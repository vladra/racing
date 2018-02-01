<template>
  <el-container>
    <el-header class="header">
      <el-menu mode="horizontal" class="nav-menu" :router="true">
        <el-menu-item index="/">Home</el-menu-item>
        <el-menu-item index="/race/1">Race</el-menu-item>
        <el-menu-item index="/about">About</el-menu-item>
      </el-menu>
    </el-header>

    <el-main>
      <router-view/>
    </el-main>
  </el-container>
</template>

<style>
.nav-menu {
  max-width: 1000px;
  margin: 0 auto;
}
</style>
