
# Blog

The default [wintersmith](https://github.com/jnordberg/wintersmith) template
# HOWTO

## First time

`npm install`

[Download s3cmd](http://s3tools.org/download)

`s3cmd --configure` (nb: if you already have a ~/.s3cfg, move it out of the way)

`ln -s ~/.s3cfg ./.s3cfg_prismatik`

## Every time

Write an article in /drafts.

When you like it, move it to /contents/articles

Make it look like the other things in /contents/articles

Run `npm run preview` and see what it looks like.

Do you like it? Great! `npm run build`

`npm run push`

## That's much too hard!
I have put in place a heuristic process based on a state-of-the-art neural net! Just email your blog post to automagical_blog_generator@prismatik.com.au and it will get taken care of.

## Development

Run `gulp dev` for development.

## Production

Run `gulp prod` before production to compile assets.
