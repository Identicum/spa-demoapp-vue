<template>
  <!-- Bar -->
  <v-app-bar color="blue-lighten-1">
    <v-app-bar-nav-icon @click="drawer = !drawer" />
    <span class="text-title-large ml-3 mr-5">Store&nbsp;<span class="font-weight-light">Online</span></span>
    <v-text-field
      v-if="smAndUp"
      v-model="search"
      variant="solo-inverted"
      density="compact"
      prepend-inner-icon="mdi-magnify"
      label="Search"
      flat
      hide-details
      clearable
      max-width="400"
    />
    <v-btn
      icon="mdi-refresh"
      title="Reload products"
      @click="loadProducts"
    />
    <v-spacer />
    <v-btn
      icon="mdi-logout"
      title="Logout"
      href="/private/logout"
    />
  </v-app-bar>

  <!-- Home menu -->
  <v-navigation-drawer
    v-model="drawer"
    color="grey-lighten-4"
  >
    <v-list density="compact">
      <v-list-item
        prepend-icon="mdi-view-dashboard"
        title="Product Catalog"
        active
      />
    </v-list>
  </v-navigation-drawer>

  <v-main class="bg-grey-lighten-4">
    <v-alert
      v-if="errorMessage"
      type="error"
    >
      API error: {{ errorMessage }}
    </v-alert>
    <v-progress-linear
      v-if="loading"
      indeterminate
    />
    <v-container fluid>
      <!-- Products page content -->
      <v-row>
        <v-col
          v-for="product in filteredProducts"
          :key="product.id"
          cols="12"
          sm="6"
          md="4"
          lg="3"
        >
          <v-card>
            <v-img
              :src="`/product-${product.id}.png`"
              gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
              height="250"
              cover
            />
            <v-card-title>{{ product.name }}</v-card-title>
            <v-card-subtitle>{{ product.description }}</v-card-subtitle>
            <v-card-text>
              <div class="d-flex align-center">
                <v-rating
                  :model-value="product.id"
                  color="amber"
                  density="compact"
                  size="small"
                  half-increments
                  readonly
                />
                <div class="text-grey ml-4">
                  {{ product.id }} (200)
                </div>
              </div>
            </v-card-text>
            <v-card-actions>
              <v-btn variant="text">
                Details
              </v-btn>
              <v-btn variant="text">
                Buy
              </v-btn>
              <v-spacer />
              <v-btn icon="mdi-share-variant" />
            </v-card-actions>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </v-main>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue'
import { useDisplay } from 'vuetify'
import axios from 'axios'

const { smAndUp } = useDisplay()
const drawer = ref(null)
const search = ref('')
const products = ref([])
const loading = ref(false)
const errorMessage = ref('')

const filteredProducts = computed(() => {
  const term = (search.value || '').trim().toLowerCase()
  if (!term) {
    return products.value
  }
  return products.value.filter(product =>
    `${product.name} ${product.description}`.toLowerCase().includes(term)
  )
})

async function loadProducts () {
  loading.value = true
  errorMessage.value = ''
  try {
    const response = await axios.get('/api/v1/products')
    products.value = response.data
  } catch (error) {
    const response = error.response
    // IPAx answers 401 on /api/ when the session expired: reload to log in again.
    // A 401 from the API itself carries WWW-Authenticate, reloading wouldn't fix it.
    if (response?.status === 401 && !response.headers['www-authenticate']) {
      window.location.reload()
      return
    }
    errorMessage.value = response ? `${response.statusText} (${response.status})` : error.message
  } finally {
    loading.value = false
  }
}

onMounted(loadProducts)
</script>
