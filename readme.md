
# Blog

The default [wintersmith](https://github.com/jnordberg/wintersmith) template
# HOWTO

## First time

`npm install`
[Download s3cmd](http://s3tools.org/download)
`s3cmd --configure` (nb: if you already have a ~/.s3cfg, move it out of the way)
`ln -s ~/.s3fg ./s3cfg_prismatik`

## Every time

Write an article in /drafts.

When you like it, move it to /contents/articles

Make it look like the other things in /contents/articles

Run `npm run preview` and see what it looks like.

Do you like it? Great! `npm run build`

`npm run push`
