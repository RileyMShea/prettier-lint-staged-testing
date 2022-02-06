# Prettier & Lint-staged build testing

Uses lint-staged, husky, and prettier to seemlessly format your code before it's committed.

## Notable docs

[husky](https://typicode.github.io/husky/#/)

## Important files

For everything to work across all platforms (Windows, Mac, Linux), the following files
need to be in the root of your project:

### ./.husky/common.sh

This handles a [Windows-specific bug](https://typicode.github.io/husky/#/?id=yarn-on-windows)
bug that seems to only occur when using `git-bash`,`yarn`, and `husky` together.

### ./.husky/pre-commit

Any command-line scripts you want to run and pass before code get's comitted
or npm scripts can be run. At the time of writing, this is used to run `lint-staged`
which only runs prettier on staged files.

### .gitattributes

This file is needed for Windows to make sure all platforms use the same line endings(LF).
Git always stores it's version history as LF, but to help compatibilitiy windows users who don't use git
bash(ie command prompt), it writes the actual files(not the version history) using CRLF.

see [prettier End of Line](https://prettier.io/docs/en/options.html#end-of-line) for a
detailed explanation.

### ./husky/.gitignore && ./husky/\_/.gitignore

When husky installs itself it generates a couple of git-ignores files that are local
to it's folder.

### ./prettierrc

This is one of the default file names that Prettier uses to look for a config file. At
the time of writing, this is an empty object to let Prettier know that it should use
the default config for this project and instead of using options from another config file.

### ./.prettierignore

See [Prettier - ignoring code](https://prettier.io/docs/en/ignore.html)

> It’s recommended to have a .prettierignore in your project! This way you can run
> prettier --write . to make sure that everything is formatted (without mangling files you
> don’t want, or choking on generated files). And – your editor will know which files not to
> format!

### ./package.json

devDependencies:

```json
 "devDependencies": {
    ...
    "husky": "6.0.0",
    "lint-staged": "10.5.4",
    "prettier": "2.5.1"
    ...
  },
```

- husky provides the pre-commit ability
- lint-staged provides the ability to run prettier(and/or other commands) only staged
  files, this speeds of the pre-commit time.
- prettier is the formatter that gets run to format staged files during the pre-commit
  hook.

lint-staged:

```json
  "lint-staged": {
    "*.{js,jsx,json,ts,tsx,css,md,html}": "prettier --write"
  }
```

These are the commands that will be run **ONLY** on staged files
when running `npm run lint-staged` or `yarn lint-staged`.
