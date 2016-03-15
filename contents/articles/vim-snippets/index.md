---
title: Snippets in Vim
author: simontaylor
date: 2016-03-15
template: article.jade
blurb: How to setup Vim to use code snippets!
---

Last week a colleague of mine who was watching me code asked me, why don't you use snippets? It was a very good question but I'd just never given much thought to the repetition involved in writing code. The more I thought about it, the more I thought how many times have I written out the same `describe` or `it` block in mocha, defined a function or typed console.log! The answer? Far far too often. Setting up snippets is well worth the effort as the time saving in the long term will be pretty huge.

So over the last couple of days I've spent some time investigating how to get snippets up and running in vim and also configuring them. Here's how to get it up and running in your vim...

### Prerequisites

* Homebrew installed (required to compile YouCompleteMe)
* A vim plugin manager, vundle, pathogen etc...
* Some cursory vim knowledge, i.e. how to make changes to your .vimrc

### Setup Snippets in Vim

Step 1 - Install the [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) plugin (YCM).
YCM is a code completion engine for vim that will provide autocomplete suggestions as you type based on the language you are coding in. Installation of the plugin itself is fairly straight forward just note you must compile the plugin based on the languages you intend to use YCM for, refer to the documentation on github.

It's not actually clear from the documentation whether YCM is a requirement to use snippets (the UltiSnips plugin). In any case, I recommend installing YCM as the autocomplete it provides is fantastic and it detects snippets you've configured to list in the autocomplete box as well.

Step 2 - Install the [UltiSnip](https://github.com/SirVer/ultisnips) vim plugin. You should now have the ability to start creating snippets. The installation guide recommends a `vim-snippets` plugin which comes with a bunch of snippets out of the box, but I would recommend not installing that as it contains snippets for a wide variety of different languages, many of which you'll probably never use.

Step 3 - Configure the shortcuts for UltiSnips. UltiSnips needs three shortcuts to function, expand snippet, jump forward, jump backward. Expand snippet converts your abbreviation into the full snippet, and jump forward and backward let you cycle through the different inputs you've configured in the snippet itself. Add the below three lines to your `.vimrc` changing the keybindings as appropriate (the below is my config). Do not bind expand to `<tab>` as this conflicts with YCM.

```
let g:UltiSnipsExpandTrigger="<c-s>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
```

Step 4 - Add some snippets!

Snippets are very easy to add, simply open a file in vim that is associated with the language you want to create snippets for, i.e. a `.js` file for javascript and type `:UltiSnipsEdit`. This will open the snippets file where you can start to add snippets.

Snippets are really easy to add! Below is an example...

```
snippet fn "function" b
function ${1:functionName}(${2:arguements}) {
	$0
}
endsnippet
```

Lets walk through the syntax.
* `snippet` - the start of your snippet
* `fn` - the trigger word for your snippet. Type `fn` in insert mode, and then press your expand shortcut to substitute it with the full snippet (`control + s` in my case).
* `"function"` - a description of the snippet, visible in YCM's menu.
* `b` - best to [read the docs](https://github.com/SirVer/ultisnips/blob/master/doc/UltiSnips.txt#L665) for this, but essentially snippet only expands if it is the first characters on a new line i.e. `fn` cannot have any preceeding text, tabs and spaces are ok though!
* `${1:functionName}` - the first piece of text in the snippet the user can customize, defaults to "functionName". After pressing your jump forward shortcut (`control + j` in my case) the first time, this is the text you will be able to edit.
* `${2:arguements}`  - the second piece of text in the snippet the user can customize, defaults to "functionName".
* `$0` - where the cursor will end up after you're done editing the snippet text (after you've pressed the jump forward shortcut three times)
* `endsnippet` - the end of your snippet text.

Note: you can also just use `$1`, `$2` etc... if you want to insert text in your snippet but don't need a placeholder.

That's pretty much it, your snippets are immediately available to use.

### What else?

As I said above, I wouldn't recommend installing the `vim-snippets` plugin, but that doesn't mean it doesn't have lots of great stuff. I'd recommend copying, pasting and then tweaking the snippets that are useful to you. Just checkout the [github repo](https://github.com/honza/vim-snippets/tree/master/UltiSnips) and copy what looks useful to you.

There's plenty more complexity here if you want to dive in. UltiSnip supports much more complex snippets, python interpolation can be used to achieve some fairly advanced snippets. I found a great snippet for requiring modules in node.js [here](https://medium.com/brigade-engineering/sharpen-your-vim-with-snippets-767b693886db#.53n8qt3p6). This gives you some idea of much more powerful snippets you can write. I found this [wiki page](http://wiki.yangleo.me/2013/10/29/write-UltiSnips-snippets.html) to be a useful resource in writing snippets that's less verbose than the UltiSnips docs.

Finally I definitely recommend backing up your snippets! Snippets live in your `~/.vim/UltiSnips` folder. I suggest replacing this path with a symlink or similar and storing your snippet files somewhere else that you regularly back up, like you're hopefully doing with your dotfiles.


### Javascript and YouCompleteMe

I had a bit of trouble getting YCM to work with javascript/node.js as a bit more configuration is required. To provide javascript autocomplete suggestions YCM uses [Tern](http://ternjs.net/) which is automatically installed via the compilation step assuming you used the javascript flag. But for tern to function it requires a configuration file.

Without this, you will get an error when opening a `.js` file in vim along the lines of...
```
RuntimeError: Warning: Unable to detect a .tern-project file in the hierarchy before /PATH-HERE and no global .tern-config file was found. This is required for accurate JavaScript completion. Please see the User Guide for details.
```

You can either do this with...

1. a `.tern-project` file in each of your project directories.
2. create a `.tern-config` file in your home directory `~/`

This file configures the tern engine so it knows what type of javascript you are coding in and therefore what autocomplete options are available, refer [tern config](https://github.com/Valloric/YouCompleteMe#javascript-semantic-completion) for what to put in the file. I just used the sample node.js config provided in the docs.
---
