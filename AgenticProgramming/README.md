# Agentic Programming

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
| [`img/`](img) | lab logos, copied from `RealityBendingLab/Lab/visuals/logo` |

The palette is taken from the lab's chromostereopsis logo — pure red against pure blue — which
shows up as the hairline above the band, the rule under each slide title, and the red/blue
fringing on the cover title.

The band carries the deck title (from the headmatter `title`), the white lab banner and the slide
number. It is hidden on the cover and the chalkboard, and on any slide with `band: false` in its
frontmatter. Dark slides use `class: rebel-dark`.

## Editing

```bash
bun install          # once
bun run dev          # live preview on http://localhost:3030
bun run build        # regenerate index.html + assets/
```

`npm` works too if you install Node; the `build` script relies on Bun's shell for `cp`/`rm`.

## Notes

- The built deck is a JS app: opening `index.html` by double-click will **not** work
  (browsers block ES modules on `file://`). Use `bun run dev`, a local server
  (`python -m http.server`), or the published GitHub Pages URL.
- `node_modules/` is git-ignored, but Dropbox will still sync it. To stop that:
  `Set-Content -Path node_modules -Stream com.dropbox.ignored -Value 1`
