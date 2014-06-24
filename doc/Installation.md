# Installing Pi Fight

The Pi Fight back end is written in Elixir using the Phoenix web framework.
The front end is a combination of HTML, Sass, and Javascript.

To run Pi Fight you must [install Elixir](http://elixir-lang.org/getting_started/1.html).  To modify the web interface you
will also need [Sass](http://sass-lang.com/install).

## The first time you run

You'll need to fetch some libraries.

    mix deps.get

## Launching the server

    mix phoenix.start

The arena page will be available at http://localhost:4000/static/index.html

## Running the tests

    mix test

## Compiling your Sass changes

    sass --watch  sass:priv/static/css
