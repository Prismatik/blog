---
title: Recreating Redux — Behind the magic curtain
author: nickmatenaar
date: 2016-04-12
template: article.jade
blurb: Implementing a simplified version of the core of redux, with the intention of developing a deeper understanding of the underlying concepts behind the library.
---

Released mid 2015, [Redux](https://github.com/reactjs/redux/) has quickly become one of the most popular libraries to manage state in a React application. Libraries such as [React-Redux](https://github.com/reactjs/react-redux), [React-Router-Redux](https://github.com/reactjs/react-router-redux) and middleware such as [redux-thunk](https://github.com/gaearon/redux-thunk) make it easy to quickly create single page applications with react and redux, though can crowd and overwhelm someone just beginning to explore these ideas.

Throughout this article we’ll be taking a step back, to implement a simplified version of the core of redux, with the intention of developing a deeper understanding of the underlying concepts behind the library.

## The Core

The idea behind Redux is quite simple:

* All the state of your application lives in a single **store**.

* To change the state of your application, you must **dispatch** an **action**.

* Actions transform the state through the use of a **reducer**.

* When an action is dispatched, the store lets **subscribers** know the state has changed.

I’ll be implementing these using ES2015, transpiling with [Babel](https://babeljs.io/) and testing with [Mocha](https://mochajs.org/) and [Chai](http://chaijs.com/). All code below is [available on Github.](https://github.com/Nicktho/recreating-redux)

### All the state of your application lives in a single **store**.

Redux exports the function *createStore*, which, as the name implies, creates and returns our store, the center of a redux application.

We’ll start here.

```
export function createStore(reducer, initialState) {
  let currentState = initialState;

  return {}
}
```

*createStore* takes two arguments, *reducer* and *initialState. *Let’s store the initialState as our current state for now.

We’ll need a way to access our state, the store supplies us with a *getState* method to do just that. This is also a good opportunity for us to write our first test.

```
describe('createStore', () => {
  describe('#getState', () => {
    it('should return the current state', () => {
      const state = { notes: [ 'hello world', 'hello' ] };

      const store = createStore(x => x, state);

      expect(store.getState()).to.equal(state);
    });
  });
});
```

Our state tree in this and future tests will resemble a simple note taking application. Our *reducer* here returns any argument passed into it, as we won’t be focusing on that just yet.

Let’s implement our method.

```
export function createStore(reducer, initialState) {
  let currentState = initialState;

  function getState() {
    return currentState;
  }
  
  return { getState };
});
```

Great, now we can access our store’s state, but to change it we’ll need to dispatch an action.

### To change the state of your application, you must **dispatch** an **action, **which transforms the state through the use of a **reducer**.

Let’s start out with another test

```
describe('#dispatch', () => {
  const reducer = (state = [ 'hello world' ], action) => {
    switch(action.type) {
      case 'ADD_NOTE':
        return [ ...state, action.payload ];
      default:
        return state;
    }
  };

  const addNote = payload => ({ type: 'ADD_NOTE', payload });

  it('should update the state with the result of the reducer', () => {
    const store = createStore(reducer);

    store.dispatch(addNote('hello'));

    expect(store.getState()).to.deep.equal([ 'hello world', 'hello' ]);
  });
});
```

First we’re creating our notes reducer and an action creator, *addNote*, if you would like to learn more about reducers and action creators, the [Redux Documentation](http://redux.js.org/docs/basics/Reducers.html) is an excellent resource*.*

In our test, we’ll create our store, dispatch our action with a new payload and check to see if the store was successfully updated.

Let’s implement it!

```
export function createStore(reducer, initialState) {
  let currentState = initialState;

  function getState() {
    return currentState;
  }

  function dispatch(action) {
    currentState = reducer(currentState, action);
  }
  
  dispatch({ type: 'INIT' });

  return { getState, dispatch };
}
```

Notice we’re instantly dispatching an *INIT *action. This will flow throw all our reducers and return the default state, setting up our store.

Great, almost there, the last step is to notify the store’s subscribers that a change has been made.

### When an action is dispatched, the store lets **subscribers** know the state has changed.

We’ll need a way to subscribe to our store, let's write a test.

```
describe('#subscribe', () => {
  it('should add the passed function to the listeners', () => {
    const store = createStore(x => x, {});

    let called = false;

    store.subscribe(() => called = true);
    store.dispatch({ type: '' });

    expect(called).to.be.true;
  });
});
```

Since our listeners will be private, we’ll need update our dispatch method to notify listeners to pass this test.

We’ll go ahead and implement *subscribe*, which will add the passed function to an array of listeners, also, we’ll update our dispatch to let our listeners know something has changed.

```
export function createStore(reducer, initialState) {
  let listeners = [];
  let currentState = initialState;

  function getState() {
    return currentState;
  }

  function subscribe(listener) {
    listeners.push(listener);
  }

  function dispatch(action) {
    currentState = reducer(currentState, action);

    listeners.forEach(listener => listener());
  }

  dispatch({ type: 'INIT' });

  return { getState, subscribe, dispatch };
}
```

Believe it or not, we’ve just implemented a simplified version of Redux!

Let’s look at one more function the redux package gives us, *combineReducers.*

## combineReducers, the helper.

*combineReducers *is, in my opinion, the most beneficial helper method supplied by the Redux package. Essentially, it allows you to split up your reducer in to multiple reducers for each part of your state tree. Before continuing, I recommend reading through the [official documentation for reducers](http://redux.js.org/docs/basics/Reducers.html) if you have not done so already.

As usual, we’ll start with a test.

```
describe('combineReducers', () => {
  it('should combine multiple reducers to a single reducer', () => {
    const notes = (state = [ 'hello world' ], action) => {
      switch(action.type) {
        case 'ADD_NOTE':
          return [ ...state, action.payload ];
        default:
          return state;
      }
    };

    const numbers = (state = [ 1 ], action) => {
      switch(action.type) {
        case 'ADD_NUMBER':
          return [ ...state, action.payload ];
        default:
          return state;
      }
    };

    const reducer = combineReducers({ notes, numbers });

    const state = reducer({}, { type: 'ADD_NUMBER', payload: 2 });

    expect(state).to.deep.equal({
      notes: [ 'hello world' ],
      numbers: [ 1, 2 ]
    });
  });
});
```

As shown in the official documentation, *combineReducers* takes an object with its keys as parts in the state tree and it’s values their reducers. It then returns a single reducer, ready to pass into *createStore. *We’ll test this functionality by combining two reducers and passing through one action to see if the state updates correctly.

Let’s take a look at an implementation of this function.

<script src=https://gist.github.com/Nicktho/fb3a77ff84838f0d7827d381daba3c8c#file-recreating-redux-1-js></script>

What we’ve created here is essentially a higher-order reducer. We’ll return a new reducer, that when called, loops through all passed in reducers and calls them with the current state and action. These results are bundled in an object with each key, the key of the reducer in the initially passed in object, aka, our state tree!

## Wrapping up

I find learning through recreation produces a far deeper understanding for myself and I hope it did for you too. Behind the now countless libraries and middlewares built on top of it, Redux is quite a simple library, but a powerful idea and architecture.

[The source for the complete project is available on GitHub.](https://github.com/Nicktho/recreating-redux)