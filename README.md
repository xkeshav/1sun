# Format Issue ID

Automatically formats GitHub issue titles by prepending a structured identifier like:

[PRO-260001]: Issue title

Designed for teams that want consistent, searchable, and sortable issue titles without manual effort.

---

## What this action does

When an issue is opened, edited, or labeled, this action:

- Generates a stable identifier using:
  - a configurable prefix
  - the current year (YY)
  - a zero-padded issue number
- Prepends the identifier to the issue title
- Preserves leading emojis if present
- Skips execution if the title is already formatted

---

## Example

> Before

```plaintext
🐞 Fix login redirect
```

> After

```plaintext
🐞 [PRO-260012]: Fix login redirect
```

---

## Identifier format

```text
[PREFIX-YYNNNN]
```

- `PREFIX` → configurable (e.g. PRO, BUG, APP)
- `YY` → current year (last two digits)
- `NNNN` → zero-padded issue number

---

## Inputs

| Name   | Required | Description                                         |
| ------ | -------- | --------------------------------------------------- |
| prefix | yes      | Prefix for the issue identifier (e.g. `PRO`, `BUG`) |

---

## Required permissions

This action **modifies issue titles**, so the workflow must grant:

```yaml
permissions:
  issues: write
```

---

## Usage example

```yaml
name: Auto format issue title

on:
  issues:
    types: [opened, edited, labeled]

permissions:
  issues: write

jobs:
  format_title:
    runs-on: ubuntu-latest
    steps:
      - name: Format issue title
        uses: xkeshav/1sun/format-issue-title@v1
        with:
          prefix: PRO
```

---

## Behavior notes

- If the title already contains `[PREFIX-XXXXXX]`, the action exits safely
- Leading emojis are preserved
- Spacing is normalized automatically
- Uses GitHub CLI (`gh`) via the built-in `GITHUB_TOKEN`

---

## Why a composite action?

This action is implemented as a **composite action** to keep it:

- Shell-based
- Fast to run
- Easy to audit
- Free from Node or Docker overhead

---

## License

MIT
