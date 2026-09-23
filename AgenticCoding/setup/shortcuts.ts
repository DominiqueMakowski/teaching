import type { NavOperations, ShortcutOptions } from '@slidev/types'
import { defineShortcutsSetup } from '@slidev/types'
import { useNav } from '@slidev/client'

// Slidev has no default key for the drawing layer, and no chalkboard mode.
// We add both, using the same keys as reveal.js / Quarto:
//   b  toggle drawing (annotate the current slide)
//   c  jump to the chalkboard (the last slide) and back again
export default defineShortcutsSetup((nav: NavOperations, base: ShortcutOptions[]) => {
  const { currentSlideNo, total } = useNav()

  // Slide we were on before jumping to the chalkboard
  let returnTo: number | null = null

  function toggleChalkboard() {
    if (currentSlideNo.value === total.value) {
      // On the chalkboard: go back where we came from (no-op if we walked here)
      if (returnTo !== null) {
        nav.go(returnTo)
        returnTo = null
      }
    }
    else {
      returnTo = currentSlideNo.value
      nav.goLast()
    }
  }

  return [
    ...base,
    { name: 'toggle_drawing', key: 'b', fn: () => nav.toggleDrawing() },
    { name: 'toggle_chalkboard', key: 'c', fn: toggleChalkboard },
  ]
})
