---
title: Learning Vim in 2015
author: simontaylor
date: 2015-09-07
template: article.jade
blurb: The right and wrong way to learn vim.
---

Earlier this year I made the leap from Sublime Text to Vim and I wanted to share my thoughts for others out there who are considering taking the plunge.

### Why bother?

The biggest advantage of vim is your typing speed once you master its shortcuts. The speed advantage comes from your ability to navigate text without ever having to touch your mouse. In Atom or Sublime you are forever removing your right hand from the keyboard to hit the arrow keys or use the mouse. In vim, all navigation occurs via keystrokes and your hand never needs to leave the home row (in fact the mouse won’t work at all unless you go out of your way to enable it, which you shouldn’t...).

This is achieved by switching between vim’s different “modes”. In insert mode the user can edit text as they would in any other editor, but by pressing escape, they can switch to “normal” mode. In “normal” mode, all keys are remapped to perform different functions. “J” moves down, “K” moves up, “H” moves left, “L” moves right etc… At any time you can press the “i” key they can switch back to insert mode.

Vim also has some other amazing shortcuts that available in “normal” mode that greatly increase your editing efficiency. There are too many of these to list in few but some examples of what you can do purely with the A-Z keys in 1-2 key strokes, jump forward or backward a word at a time, jump to the start or end of the line, delete a whole word, delete an entire row, page/up down, jump to a specific line number and the list goes on… These same shortcuts exist in other editors, but because the A-Z keys are always bound to input the relevant letter, the shortcuts are far more awkward and require you to hold control / alt or command and press another key. In vim you simply change to “normal" mode and all your A-Z keys now become your shortcuts, no modifier keys required (mostly!).

Another advantage of vim occurs when you need to ssh into a remote machine. Almost every machine you access will have vim already installed. You can be right at home with the editor you're used to and edit files on the remote server with ease. This might seem like a small thing but it’s certainly not if you need to do this often. You can of course learn vim and only use it when editing files on remote servers, but it reduces the cognitive load to not have to mentally switch between different editors shortcuts. It is possible to get Atom and Sublime working on a remote server but it is not as natural as just opening a file within terminal.

As a developer you’re highly likely to be using terminal for at least part of your workflow (unless you’re using a fully featured IDE). It might be to use git, install packages, spin up a web server, run automated tests etc… Whatever the reason, it’s certainly nice to have your editor running in the same environment. You can then easily switch between any terminal operations you need and your editor. `Ctrl + Z` while in vim will hide your current vim session and throw you back into terminal to run other commands. You can then type `fg` to switch back to your open vim session. It's also easy to run a command and direct the output into vim.

Vim is highly customisable and therefore a very personal editor. You can vastly change the way vim functions by installing / configuring plugins and adding keyboard shortcuts. Atom and Sublime are also customisable but the changes from a plugin never feel as radical as with vim. Vim can be customised so heavily that your configuration becomes completely integrated into your dev workflow. Using someone else's configuration would feel completely alien and unweildy to you. Like wearing someone else's underwear. One of the best examples of this is in how you choose to use "buffers" in vim which you can [read about here](https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/).

### Any downsides to using vim?

* It will never look quite as pretty as Atom or Sublime (is this actually a downside?)
* The plugins aren't always as current as Atom or Sublime, but to date I've never been unable to find a plugin to do what I need. This will be greatly helped by [neovim](https://github.com/neovim/neovim)

### I hear learning Vim is hard, is it really?

It’s not really, but getting it configured is really hard! One thing that surprised me about learning vim was that learning vim’s shortcuts is really not that hard. It might take a couple of weeks before you feel proficient but that’s really not the hard part about learning vim.

The hardest part about learning vim is in configuring it. Out of the box vim includes very very few of the niceties you’ve come to expect from Sublime and Atom. There is no Command + P, no nice file browser, no tabs to switch between files, no across project search, no syntax highlighting, no auto closing brackets. Now that’s a lot of things it doesn’t have that you might want for free.

The good news is that there is a plugin for all of those things, the bad news is you need to find it, install it and potentially configure it yourself. At this point you might be thinking, can’t someone just configure vim for me so I don’t have to? The answer to that is yes, you can copy someone else’s .vimrc file and configure your vim in one fell swoop. But you absolutely should not do that for it is a terrible idea that leads you down the dark path of never actually learning vim!

### How should I learn vim?

First run through `vimtutor`. This is preinstalled on OSX, just open terminal, type `vimtutor` and away you go.

Next, install a package manager (I recommend [vundle](https://github.com/VundleVim/Vundle.vim)) and just start using vanilla vim. When you get stuck and don't know a particular shortcut, google it! Each time you find a missing feature that you need, find a plugin to fill that gap, install it, configure it and keep going. This starts off being really quite tedious as you are battling with learning the keyboard shortcuts while also hunting down the plugins you need. For the first two weeks expect to be really slow... For the next six weeks you'll likely still be slow as you search for all the plugins you need to configure vim to your liking and add back the functionality Sublime and Atom gave you for free. After that, things get easier!

[Editors note: I used a cheat sheet like this - http://www.viemu.com/vi-vim-cheat-sheet.gif. Also, [vim-adventures](http://vim-adventures.com/) is great]

So why put yourself through this pain when you can copy someone's config? The reason I advocate not using someone else's vim configuration (.vimrc file) is that it's really important to know how to configure vim for yourself to get the most out of it. Learning how to install and configure plugins yourself is key to setting up vim the way you want to work. Over time your vim configuration becomes a very personal setup for how you like to code and what is most efficient for you.

If you copy someone's vim config, you will get a bunch of plugins, configuration and shortcuts for free. But will you know what all their plugins do and what all their shortcuts are? If you're lucky you might know how to **use** most of their plugins/shortcuts but that is assuming they've documented it well. But even if you know the shortcuts you're unlikely to know what plugin gives you what feature unless their .vimrc is extensively well documented. This leads to the situation where you have a bunch of plugins you're potentially not even using but because you're unsure about what does what you don't know what you can / cannot remove. It's also really hard to further customise when you don't have the foundational knowledge of how your configuration is setup.

This is why I strongly recommend you learn vim the hard way and persevere through the frustration and customise vim yourself from the ground up. Read up on how other people have configured vim and what plugins they use but install each one individually and configure it the way you want to use it. This means you'll only have installed the plugins that you need and none of the plugins that you don't!

### Should I learn Vim?

That depends.

If you're new to programming don't learn vim. Learning to code is hard enough without making life difficult for yourself. Atom and Sublime have a much lower barrier to entry.

If you plan on making a career in writing words on computers, it makes sense to invest in your tools. The extra efficiency you gain will really add up over the course of 30 years.

Do you want the fastest possible text editing? and can you afford to be inefficient at coding for at least a month, more likely two? If the answer to these two questions is yes then I would suggest taking the plunge.

### Anything else?

If you're interested, [my .vimrc](https://github.com/s-taylor/dotfiles/blob/master/.vimrc) can be found on github and plenty of other good configs are just a google away. But use it wisely and don't copy and paste :)
