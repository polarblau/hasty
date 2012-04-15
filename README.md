**!This plugin is still in development and not ready for use just yet!**

# jquery.hasty

## Installation

Include `src/jquery.hasty.js` from this repository in the head of your
HTML.

Include a theme containing a stylesheet and possible a template file.
You can use the default theme (`/theme`) in this repository to get
started.

## Usage

Call the plugin on the comments container and supply options as needed:

```javascript
$(function(){
  $('#comments').hasty({
    // [OPTIONS]
  })
});
```
If you're using the [jekyll-hasty gem](https://github.com/polarblau/jekyll-hasty), the selector will be `#comments`.

### Options

#### commitsURL *[String]*

Github [API path to commits](http://developer.github.com/v3/repos/commits/) for repository.

Example:

```
https://api.github.com/repos/polarblau/jekyll-hasty-test-blog/commits
```

Defaults to the `data-commits-url` attribute of the selected element.

#### commitIDs *[Array]*

Array of sha commit ID hashes. Defining commits relevant for the article
at hand. Usually a list of commits changing the article.

Defaults to the `data-commit-ids` attribute of the selected element.

#### template *[String|Object]*

The template used by the *renderer* to display the comments. Supply a
custom template as string, a URL (to load the template via AJAX) or a jQuery object to read the contents of e.g.
a `script` tag.

A default template is included in the default theme which will be loaded
from

```
/hasty/themes/default/template.mustache
```

#### renderer *[Object]*

The renderer used to render the template into HTML. Every custom
renderer must implement a `render` method which accepts two arguments:

```javascript
Mustache.render(template, data)

# template:   the template as string
# data:       object holding commits and comments
```
By default [`Mustache`](https://github.com/janl/mustache.js) is used.


#### perPage *[Integer]*

Defines how many comments are shown per page.
