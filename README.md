# opal-vienna - TodoMVC

A very simple port of [TodoMVC](http://todomvc.com) (based on backbone version).

## Opal

Opal is a ruby -> javascript transpiler

## Opal-vienna

Vienna is a simple Client side MVC framework for Opal. Vienna

- provides an observable model base class that can be stored locally or via REST.
- uses opal-jquery to create dom elements, and can also used template views

This TodoMVC also uses [https://github.com/opal/opal-haml](Haml) for the more markup intensive
footer and todo view

## Running

Get dependencies:

```
$ bundle install
```

Run the sprockets based server for auto-compiling:

```
$ bundle exec rackup
```

Open [http://localhost:9292](localhost:9292) in the browser.

## Code Overview

Opal comes with sprockets support built in, so using rack we can have an
easy to boot build system to handle all opal dependencies. If you look
in `index.html.haml`, you will see a call to `javascript_include_tag`
which acts just like the rails tag helper.

This will include our `application.rb` file, and all of its dependencies.
Each file will be included in a seperate `<script>..</script>` tag to make navigating the code in a
web browser easier.

The `app` directory holds all the code, in it
- `models` holds the single model: todo.rb . It is stored in vienna's LocalAdapter
- `templates` There are two haml templates used, one for the todo, one for the footer
- `views` There are two views, one for the whole app and one for the todo
