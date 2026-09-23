# Agentic Coding

Slidev deck. Source: [`slides.md`](slides.md). Built output: `index.html` + `assets/` (committed, served by GitHub Pages).

## Presenting

| Key | Action |
| --- | --- |
| `b` | toggle the drawing layer (annotate the current slide) |
| `c` | jump to the chalkboard (last slide) and back again |
| `d` | dark mode |
| `o` | slide overview |
| `g` | go to slide |
| `f` | fullscreen |

`b` and `c` are custom, defined in [`setup/shortcuts.ts`](setup/shortcuts.ts); the rest are Slidev defaults.
The cover slide shows this list in its bottom-right corner, slowly fading in and out, as a reminder
when you start presenting (static for anyone with reduced-motion turned on).
The drawing toolbar (pen, line, arrow, shapes, eraser, colours, undo, clear, pin-to-all-slides) is also
reachable by hovering the bottom-left of the slide and clicking the pen icon. On a tablet, a stylus draws
directly without toggling drawing mode on.

Drawings live for the session only. To keep them, set `drawings: { persist: true }` in the headmatter —
they are then saved as SVG under `.slidev/drawings` and baked into the build and the PDF export.

## Lab theme

| File | Role |
| --- | --- |
| [`style.css`](style.css) | palette and all theme rules (auto-loaded by Slidev) |
| [`slide-top.vue`](slide-top.vue) | the black band drawn on top of every content slide |
| [`img/`](img) | lab logos (from `RealityBendingLab/Lab/visuals/logo`) and the Sussex mark |

The palette is taken from the lab's chromostereopsis logo — pure red against pure blue — which
shows up as the hairline above the band, the rule under each slide title, and the red/blue
fringing on the cover title.

The band carries the deck title (from the headmatter `title`), the white lab banner and the slide
number. It is hidden on the cover and the chalkboard, and on any slide with `band: false` in its
frontmatter. Dark slides use `class: rebel-dark`.

## Editing

`index.html` is a **built** file. Editing `slides.md` changes nothing on the page until you rebuild:

```bash
bash build.sh
```

That installs dependencies on first run, rebuilds `index.html` + `assets/`, and cleans up after
itself. `bun run build` does exactly the same thing if you prefer. Then **hard-refresh the browser**
(<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>R</kbd>) — it caches the old build otherwise.

While actually writing the deck, skip the rebuild loop entirely:

```bash
bun run dev
```

It serves the deck at <http://localhost:3030> and reloads on every save. Run `bash build.sh` once at
the end, before committing.

## Notes

- The built deck is a JS app: opening `index.html` by double-click will **not** work
  (browsers block ES modules on `file://`). Use `bun run dev`, a local server
  (`python -m http.server`), or the published GitHub Pages URL.
- `node_modules/` (~400 MB) is git-ignored, and `build.sh` marks it as Dropbox-ignored on first
  install so it is not synced. To redo that by hand:
  `Set-Content -Path node_modules -Stream com.dropbox.ignored -Value 1`
