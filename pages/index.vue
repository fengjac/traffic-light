<template>
  <div class="home-page">
    <q-btn class="my-card" @click="onclickVip">
      <span class="my-label">平板展示</span>
    </q-btn>
    <q-btn class="my-card" @click="onclickWorker">
      <span class="my-label">监控中心</span>
    </q-btn>
  </div>
</template>

<script setup>
const router = useRouter();

const onclickVip = () => {
  router.push({ name: "vip" });
};
const onclickWorker = () => {
  router.push({ name: "worker" });
};
</script>

<style scoped lang="scss">
.home-page {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
  height: 100%;
  column-gap: 10vw;
}

.my-card {
  width: 20vw;
  height: 20vw;
  border-radius: 10px;
  .my-label {
    font-size: 20px;
  }
}
</style>
