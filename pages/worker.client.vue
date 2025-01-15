<template>
  <div :class="['worker-page', paused ? 'stop-page' : 'start-page']">
    <div style="position: absolute; left: 20px; top: 30px;">
      <button @click="reset">重置</button>
    </div>
    <div
      class="my-light"
      :style="{ backgroundColor: paused ? 'red' : 'green' }"
    ></div>
    <div class="my-label">
      <div v-show="paused">
        <div style="color: white;">已停止</div>
        <div style="color: white;">已停止</div>
        <div style="color: white;">已停止</div>
      </div>
      <div v-show="!paused">
        <div style="color: white;">! 起机啦啦啦！</div>
        <div style="color: white;">! 起机啦啦啦！</div>
        <div style="color: white;">! 起机啦啦啦！</div>
      </div>
    </div>
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

const reset = () => {
  paused.value = true;
}
</script>

<style scoped lang="scss">
@keyframes startColors {
  0%,
  100% {
    background-color: green; /* 开始和结束时的颜色 */
  }
  50% {
    background-color: white; /* 中间过渡时的颜色 */
  }
}
@keyframes stopColors {
  0%,
  100% {
    background-color: red; /* 开始和结束时的颜色 */
  }
  50% {
    background-color: white; /* 中间过渡时的颜色 */
  }
}

.worker-page {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  column-gap: 3vh;
  height: 100%;
  width: 100%;
  animation-timing-function: linear;
  animation-iteration-count: 2;
  animation-duration: 0.1s;
}

.start-page {
  background-color: green;
  animation-name: startColors;
}
.stop-page {
  background-color: red;
  animation-name: stopColors;
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
