# Prettier & Lint-staged build testing

[![code style: prettier](https://img.shields.io/badge/code_style-prettier-ff69b4.svg?style=flat-square)](https://github.com/prettier/prettier)

![git hooks lifecycle image](https://blog.gitguardian.com/content/images/2020/04/hook-graphic-4.png)
This repo showcases usage of npm cli tools: lint-staged, husky, and prettier;
enabling automatic formatting/linting/testing when used in git life-cycle hooks such as
`pre-commit`.

Additionally, other git lifecycle hooks are used to run `npm test` and `eslint` during the `pre-push` git life-cycle hook.

## Setup

1. Clone this repo to your local machine
2. Run `npm install`. The postinstall phase will add the git hooks to your local machine.
3. Try adding a small, poorly-formated function to a file in the `/src` directory. IE
   ```js
   function add(a, b) {
     return a + b;
   }
   ```
4. Stage the file and commit the change.
5. See if the lint-staged and prettier hooks are working. If you commit the command line,
   you should see output like:

```shell

```

Just run `npm install` and the all the hooks will be setup for your. The npm
lifecycle script `postinstall` should do everything else for you.

Now go ahead make a commit and you should see the code formatted.

## Escape hatch

If theres a problem and you need to run a git command like `commit` or `push` without
having the git hooks execute they can be bypassed by adding the `--no-verify` flag to
your git command.

```shell
git commit -m "small change" --no-verify
git push --no-verify
```

If using git with the GUI in vscode you also do this by enabling the
"git.allowNoVerify" setting.

```json
{
  ...
  "git.allowNoVerifyCommit":true
}
```

## Removing git hooks

`npm run husky:uninstall` to remove husky git-hook setup

## External docs

- [husky](https://typicode.github.io/husky/#/)
- [prettier](https://prettier.io/docs/en/index.html)
- [lint-staged](https://github.com/okonet/lint-staged#readme)

## Important files

For everything to work across all platforms (Windows, Mac, Linux), the following files
need to be in the root of your project:

### ./.husky/common.sh

This handles a [Windows-specific bug](https://typicode.github.io/husky/#/?id=yarn-on-windows)
bug that seems to only occur when using `git-bash`,`yarn`, and `husky` together.

### ./.husky/pre-commit

Any command-line scripts you want to run and pass before code get's committed
or npm scripts can be run. At the time of writing, this is used to run `lint-staged`
which only runs prettier on staged files.

### .gitattributes

This file is needed for Windows to make sure all platforms use the same line endings(LF).
Git always stores it's version history as LF, but to help compatibility windows users who don't use git
bash(ie command prompt), it writes the actual files(not the version history) using CRLF.

See [prettier End of Line](https://prettier.io/docs/en/options.html#end-of-line) for a
detailed explanation.

### ./husky/.gitignore && ./husky/\_/.gitignore

When husky installs itself, it generates a couple of git-ignores files that are local
to it's own `./.husky/` folder. You shouldn't need to touch or modify these files.

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
...
 "devDependencies": {
    ...
    "husky": "6.0.0",
    "lint-staged": "10.5.4",
    "prettier": "2.5.1"
  },
...
```

- `husky` provides the git hooks capabilities to run pre-commit, pre-push, and other
  git lifecycle hooks.
- `lint-staged` provides the ability to run prettier(and/or other commands) only staged
  files, this speeds of the pre-commit time.
- `prettier` is the code formatter that gets run to format staged files during the pre-commit hook.

lint-staged:

```json
  "lint-staged": {
    "*.{js,jsx,json,ts,tsx,css,md,html}": "prettier --write",
    "*.{foo,bar}": "foo bar"
  }
```

These are the commands that will be run **ONLY** on staged files
when running `npm run lint-staged` or `yarn lint-staged`. Again, the reason to only
run on staged files is to make the hooks run fast, since otherwise it would run across
all files, even unchanged files.
