# CLAUDE.md

## Where to record new guidance

Before saving anything to per-agent memory, ask "is this a rule the team should follow?" If yes, propose adding it to the project's CLAUDE.md file — it's in git, visible to everyone, and applies to every agent and contributor.

Reserve private agent memory for things that are only about how an individual works with their assistant, not shared conventions. Even then, ask if the individual rule should be stored in the CLAUDE.md in my dotfiles repo (imported from ~/.claude/CLAUDE.md, so check its location there), rather than memory. Memory is not easily visible to me, and is not stored in git.

## just commands

Commonly used commands go into `justfile`. Every project _should_ have one with common commands such as `run`, `test`, `format` and `check`. If a `just` command mentioned in this file doesn't exist: stop and notify me. Don't figure out an alternative command without approval.

If I ask for a script or command to run regularly, such as a way to create thumbnails of all photos in a particular folder, ask if it should be in the `justfile`.

## Communication style

### Be direct and honest

When writing something intended for human consumption (a comment, commit message, reply to prompt), use as few words as possible. Pick every word meticulously to reduce the volume to a strict minimum. Be down to the point. Less is more. Avoid superlatives and praise (stop telling the human they are "absolutely right"). Be direct and honest, rather than wrapping everything in layers of politeness.

Push back on requests that don't make sense. If part of a request looks wrong, unjustified, or worse than an alternative, say so and why before building it — with a concrete reason, not for the sake of it. Then do what I decide.

### Never guess or assume

**Never present a guess, assumption, or reverse-engineered explanation as established fact.** If you don't actually know something, say so plainly and label your confidence ("I don't know", "this is a guess", "I'd need to verify"). Do not take a symptom and invent a plausible-sounding mechanism to explain it, then assert it as documented behavior — that fabricated certainty causes real wasted work and destroys trust.

- **Search the web.** Search for more information instead of coming up with something yourself.
- **Get evidence before asserting.** Inspect the real environment, read the source, or test it — don't theorize.
- **When evidence isn't available yet, present an explicit hypothesis to verify, never a settled truth.**
- **After a coding task, end with one or two lines:** what you skipped or did not check, and any risk I must know.

### Code comments

Keep comments short and about the code _as it is now_. A comment must explain what the current code does or why, for someone reading it fresh.

- **If the code is obvious, don't comment it.** A comment that just restates what the code plainly says is noise. Only add one when it earns its place.
- **Plain language a junior can follow.** Describe the situation in everyday terms; avoid framework-internals jargon. Comments are read by the whole team.
- **Never narrate history.** Don't describe what the code used to do, what a previous attempt was, what changed, or why the old approach was abandoned. Git already records this. Such notes are stale the moment they're written and add noise.
- **No changelogs, dates, names, or PR/review references in code.** That context belongs in the commit message or PR description.
- **Prefer one or two plain sentences** over multi-line paragraphs. If a comment needs a paragraph to justify the code, the code usually needs rework, not the essay.
- Comment the non-obvious _why_ that the code cannot show (a workaround for a specific client bug, an ordering constraint), not the obvious _what_.

### Commit messages and PR descriptions

- **Wrap code references in backticks** — function/variable/class names, symbols, file paths, regex/string literals, and hex character codes. Plain prose stays unformatted.
- **Keep the "why" short — a few plain sentences stating what changed and why.** Don't pad it with legacy-system asides, hedging parentheticals ("the old Django table did X, now shadowed…"), or every edge case surfaced during investigation. Those conflate the change with everything adjacent to it and make it harder to review. Put mechanical/technical detail and their edge cases in the diff or its own section — not the intro.
- **No per-file "Changes" table.** Walking the reader file by file repeats what the diff already shows. Describe the change in plain English instead.

## Writing code

### Before you write

Read the task and the code it touches. List every place your change must reach: callers, tests, fixtures, config, exports. Check what your change could break for users: data it would destroy or expose, callers that stop working. That is scope. Extra features are not.

### The smallest complete change

Take the first option that fully works:

1. Does it need to exist? Skip features, options and flexibility nobody asked for, and name them in one line. A vague request ("build me X") gets the smallest version that does the core job. If you think something unasked is worth adding anyway (I might have missed or forgot something), ask for approval first.
2. Already in this codebase (a helper, component, service, pattern)? Use it the way the surrounding code does.
3. Standard library or a platform feature? Use it, unless the project has its own. A house component beats a native widget.
4. An installed dependency? Use it. Never add a dependency for a few lines.
5. Can it be one line a reader gets at a glance? One line.
6. Otherwise: the minimum code that works.

- Be lazy about the solution, never about the change itself: finish every part the task needs, including the callers, tests and fixtures your change breaks.
- No abstraction, wrapper, type conversion, option, config, boilerplate or "for later" code nobody asked for. Keep values in the form the platform already gives you. Deletion beats addition. Keep the structure the codebase already has: its layers, interfaces and conventions.
- The shortest working diff wins, once you know everything it must touch. A one-liner that needs decoding is not short.
- Bug fix: before you edit, grep every caller of the function you touch, then fix the root cause once in the shared code.
- Code you move or merge keeps its error handling and validation.
- Between options of equal size, take the one that is correct on edge cases.
- Lazy code without its check is unfinished: new non-trivial logic (a branch, a loop, a parser, money or security, or a whole new script or app) leaves one small test or an assert-based self-check. Trivial changes need none.

Never cut: validation at trust boundaries, error handling that prevents data loss, security, accessibility, anything I asked for.

### Leave the project better than it was

If you see a bug, linter error, unformatted code, or another problem, don't think "this is not my problem" or "this is in code I didn't touch". Ping me about your findings and ask what to do.

### Code style

- **Imports go at the top of the file.** Never put imports inside functions or fixtures to dodge ordering/lint warnings. The only acceptable inline import is to break a genuine circular import.
- **Never put a real email address (or other real user PII) in code, comments, or tests.** Real users' data must not leak into our code. Use the reserved example domains for placeholders — `john@example.com`, `name@example.org`.

### Lint and format before committing

Always run both `just format` and `just check` before finishing or committing. `format` only reformats; `check` is what catches lint errors like unused imports, so `format` alone is not enough.

### Self-review before committing

**Read your own diff against the rules in this file before every commit.** Not the code you remember writing — the actual `git diff --cached`. Comments in particular get written mid-fix, while the reasoning is still fresh and the old code is still in mind, and they read very differently once that context is gone. Reviewing at commit time is the only point where you see them the way the next person will.

Walk the diff and check each rule that the change touches:

- **Comments** — does each one describe the code as it is now? Delete anything that contrasts with a previous approach, restates what the code plainly says, or justifies the change rather than explaining the code.
- **Imports** at the top of the file, not inside functions.
- **No real email addresses or user PII** anywhere in code, comments, or tests.
- **Backticks** around code references in the commit message, and keep the "why" to a few plain sentences.

Fix what you find.

## Testing

- **Write the failing test first, then fix.** When fixing a bug or a performance regression, add the test against the unfixed code and watch it fail, then apply the fix and watch it pass. Don't write the test after the fix and then temporarily undo the fix to prove the test works — that is slower and risks leaving a partly-reverted file behind.
- For Django projects: **N+1 regression tests must vary the row count and assert the _total_ query count is constant — not a single-table count on one row.** A one-row test cannot detect an N+1: a per-row query is indistinguishable from a constant when there is only one row. Build the page with ≥2 rows, capture queries with `CaptureQueriesContext`, then build it again with more rows and assert the query count did not grow. Counting only one table hides per-row queries on _other_ relations. Make rows heterogeneous so optional relations are actually hit, and run the check across each filter/sort path, since each builds the queryset differently.
- Prefer to run the entire test suite using `just test` over running individual tests.
- Avoid mocking, as it's usually a sign of a bad architecture. Instead dependencies should be injected, making it possible to inject test versions when running tests. Even if mocking is the only way to go, ask for permission first.
- Avoid useless unit tests: don't test framework logic (the framework already tests that itself), avoid duplicate tests.

## Running code

### User-Agent

My email address may appear in a User-Agent header only for an approved site (list below) whose UA policy explicitly asks for an email address. Never send it to any other site. If an unapproved site's UA policy asks for an email address, ask me whether to approve the site, and hold the request until I do. If I decline or am unavailable, do not make the request.

Ad-hoc requests and requests from temporary tools use a UA prefixed with `claude-code/<ver>`, where `<ver>` is the active version for the Claude Code session.

Approved sites (by domain or name):

- Wikipedia (`wikipedia.org` and its language subdomains)

### Never touch production

**Agents do not run anything against production — not writes, not reads, not "just a quick count".** Production access belongs to a human. When production data is needed to diagnose something, write the code and hand it over for a person to run, then work from the output they paste back.

This holds no matter how safe the command looks or how urgent the bug is. Do not look for a way around it: no ssh access, no production database URL, no admin session. Reading the public site's unauthenticated pages and JSON endpoints (the same thing any visitor's browser fetches) is fine and is often enough to narrow a bug a long way before asking for a shell query.

The rule is about direct access to the project's servers, database and admin. An API I explicitly ask you to use (the project's own, or a separate service such as its analytics or DNS provider) is fine, because its access control is there to prevent that kind of damage. Use it with the credentials I point you to. Permission for one API doesn't extend to another.

When you hand over code that writes, say so explicitly, keep it in its own command, and stop there — the decision to run it is the human's, and it is not yours to assume, encourage, or treat as agreed because they ran a read-only query earlier. An API call that changes data is a write too: show me the call and wait for my OK before running it, even when I've approved reads on that API.

### Secrets

Never print or store an API key, token or password. Anything printed ends up in the conversation, which is stored on Anthropic's servers. Read the secret from where it lives (such as `.env`) into a shell variable inside the command that uses it. Don't echo it, write it to another file, put its value in the command text, or use flags that print request headers, such as `curl -v`.

### For Django projects: handing over Django shell code

**Never hand over shell code as bare Python to paste into a REPL.** The interactive shell mangles pasted indentation, so any loop or `if` breaks. Always give it as a single runnable command with the code in a quoted heredoc:

```bash
uv run ./manage.py shell <<'PY'
from books.models import Book

for b in Book.objects.filter(published=True):
    print(b.id, b.slug)
PY
```

The quoted delimiter (`<<'PY'`, not `<<PY`) stops the shell expanding `$`, and indentation survives because Django `exec`s stdin instead of running a REPL.

Keep read-only queries and anything that writes in **separate** commands, and say plainly which is which — never bury an `update()` or `save()` at the end of a block that looks like a diagnostic.
