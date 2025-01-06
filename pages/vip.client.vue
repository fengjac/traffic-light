<template>
  <div class="vip-page">
    <div>这是个背景图</div>
    <button @click="onclick">{{ buttonLabel }}</button>
    <Connection ref="ConnectionRef" />
  </div>
</template>

<script setup>
import { socket } from "@/components/socket";
import { useTemplateRef } from "vue";

const connectionRef = useTemplateRef("ConnectionRef");

const paused = ref(true);
const isConnected = computed(() => {
  return connectionRef.value?.isConnected ?? false;
});
const buttonLabel = computed(() => (paused.value ? "开始" : "停止"));

socket.on("worker_channel", (data) => {
  if (data == "start") {
    paused.value = false;
  } else {
    paused.value = true;
  }
});

const onclick = () => {
  socket.emit("vip_channel", paused.value ? "start" : "stop");
};

onMounted(() => {
  socket.emit("vip_channel", "stop");
});
</script>

<style scoped lang="scss">
.vip-page {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100%;
  width: 100%;
}
</style>
