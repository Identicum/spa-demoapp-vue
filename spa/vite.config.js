import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vuetify from 'vite-plugin-vuetify'

export default defineConfig({
  plugins: [
    vue(),
    // Tree-shake Vuetify: only the components used in templates are bundled
    vuetify({ autoImport: true })
  ]
})
