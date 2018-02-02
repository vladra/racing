<template>
  <el-container class="container">
    <el-header class="header">
      <el-menu mode="horizontal" class="nav-menu" :router="true">
        <el-menu-item index="/">Race results</el-menu-item>
        <el-menu-item index="/about">About</el-menu-item>
      </el-menu>
    </el-header>

    <el-main>
      <router-view/>
    </el-main>
  </el-container>
</template>

<style>
* {
  font-family: "Helvetica Neue",Helvetica,"PingFang SC","Hiragino Sans GB","Microsoft YaHei",Arial,sans-serif;
  color: #333;
}

p {
  font-size: 14px;
}

.container {
  max-width: 1200px;
  margin: 0 auto;
}

.title {
  font-family: "Helvetica Neue",Helvetica,"PingFang SC","Hiragino Sans GB","Microsoft YaHei",Arial,sans-serif;
  font-size: 20px;
  font-weight: 400;
}

.supplementary {
  font-size: 12px;
}
</style>
