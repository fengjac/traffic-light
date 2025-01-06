<template>
  <div class="worker-page">
    <div
      class="my-light"
      :style="{ backgroundColor: paused ? 'red' : 'green' }"
    ></div>
    <div class="my-label">{{ label }}</div>
    <Connection />
  </div>
</template>

<script setup>
import { socket } from "@/components/socket";

const paused = ref(true);
const label = computed(() => (paused.value ? "已停止" : "！起机！"));

socket.on("worker_channel", (data) => {
  if (data == "start") {
    paused.value = false;
  } else {
    paused.value = true;
  }
});
</script>

<style scoped lang="scss">
.worker-page {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  column-gap: 3vh;
  height: 100%;
  width: 100%;
}

.my-light {
  width: 15rem;
  height: 15rem;
  border-radius: 15rem;
}

.my-label {
  font-size: 5rem;
}
</style>
