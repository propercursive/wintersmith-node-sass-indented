wintersmith-node-sass-indented
==================

A [Wintersmith](https://github.com/jnordberg/wintersmith) plugin that compiles (indention-based) sass or scss to css. Based on combining approaches of the existing `wintersmith-sass` and `wintersmith-node-sass` plugins.

**Note:** Since the indention-based syntax is being phased out, this should only be used for legacy projects and it should be noted that node-sass versions may NOT be updated.

## Installing

Install globally or locally using npm

```
npm install [-g] wintersmith-node-sass-indented
```

and add `wintersmith-node-sass-indented` to your config.json

```json
{
  "plugins": [
    "wintersmith-node-sass-indented"
  ]
}
```

## Running tests

```
npm install
npm test
```

todo: write additional plugin-specific tests instead of generic Wintersmith plugin test
