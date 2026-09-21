<script setup lang="ts">
import { computed } from 'vue'
import { configs, useNav, useSlideContext } from '@slidev/client'

// Reality Bending Lab band, drawn on top of every content slide.
// Skipped on the cover, on the chalkboard (last slide), and on any
// slide with `band: false` in its frontmatter.
const { $page, $frontmatter } = useSlideContext()
const { total } = useNav()

const show = computed(() =>
  $page.value > 1 && $page.value < total.value && $frontmatter.band !== false,
)
</script>

<template>
  <footer v-if="show" class="rebel-band">
    <span class="rebel-band-deck">{{ configs.title }}</span>
    <span class="rebel-band-lab">
      <img src="./img/banner_white.png" alt="Reality Bending Lab">
      <span class="rebel-band-no">{{ $page }}</span>
    </span>
  </footer>
</template>
