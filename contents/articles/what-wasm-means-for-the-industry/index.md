---
title: What wasm means for the industry
author: davidbanham
date: 2015-06-18
template: article.jade
blurb: Discussing the practical implications of wasm for workaday software developers.
---

It's a red letter day for the web! Brendan Eich has [announced](https://brendaneich.com/2015/06/from-asm-js-to-webassembly/) that the major browser developers are working towards a standard called [WebAssembly](https://github.com/WebAssembly/design/blob/master/HighLevelGoals.md).

### The web is already _amazing_.
We can deploy a single codebase to every [major](https://wiki.apache.org/cordova/PlatformSupport) [platform](https://github.com/nwjs/nw.js/wiki/How-to-package-and-distribute-your-apps#windows). We can deliver [offline](http://diveintohtml5.info/offline.html) experiences that incorporate seamless [syncing](http://pouchdb.com/) and updating. We can create [distributed peer-to-peer topologies](https://github.com/rtc-io/rtc-mesh). We can do [audio and video chat](https://talky.io/). We can do rich [3D graphics](https://www.youtube.com/watch?v=XsyogXtyU9o).

[Prismatik](http://prismatik.com.au/) is a polyglot consultancy. People bring us problems, we often solve those problems with computers. When we do, we pick The Right Tool for the job. The vast majority of the time, that ends up involving the web. The web has become such an incredible application platform in recent years that it's impossible to ignore it. 

Until now, building for the web has meant building in Javascript. We love JS. It's a much more impressive language than many people give it credit for. [NodeJS](https://nodejs.org/) allows us to write the same language on both ends of the wire, unlocking great stuff like [isomorphic frameworks](http://isomorphic.net/libraries) and portability of library code.

What if it wasn't just JS, though? Wouldn't it be great to write whatever language you like and deploy to the web? Maybe this particular product makes more sense in Go. Maybe Lua, Elixir, Rust, Ruby, OCaml... pick your poison. WebAssembly (wasm) lays the foundation for making that a reality.

### But can't you already do that?

Well, _kinda_. You could already use [emscripten](http://kripken.github.io/emscripten-site/) to compile [LLVM](http://llvm.org/) code into [asm.js](http://asmjs.org/). Some browsers had specific optimisation for asm.js code, making it [pretty dang snappy](http://kripken.github.io/misc-js-benchmarks/banana/benchmark.html)! While it worked, it was still a hack at heart. Asm.js and the emscripten pipeline was a fantastic proof of concept. It made us realise that this kind of thing was not only desirable, but feasible.

The path laid out is that asm.js will effectively be paralleled and then superseded by wasm. The fact that it will no longer be based on Javascript means that we can evolve the capabilities of wasm without being bound by backwards compatibility with JS. That is _exciting_.

There's still work to do. Language X will still need to support wasm as a compilation target (although if it's already got a path to llvm, most of the work might already be done). To make it useful, there will need to be a way to call and manipulate the DOM. A reliable, planned standard will greatly encourage that work to occur.

tl:dr, maybe we'll see an isomorphic web framework in every major language. That would be _incredible_.

Always bet on the web.
