// pages/taskList/taskList.js
Page({

  /**
   * 页面的初始数据
   */
  data: {
    taskList: []
  },

  /**
   * 申请任务
   */
  applyTask: function () {
    this.data.taskList = this.data.taskList.push([this.data.taskList.length + 1])
    this.setData({
      taskList: this.data.taskList
    })
  },

  /**
   * 删除任务
   */
  delTask: function (event) {
    this.setData({
      taskList: this.data.taskList.splice(event.target.dataset.index, 1)
    })

  },

  /**
   * 生命周期函数--监听页面加载
   */
  onLoad: function (options) {
    this.setData({
      taskList: options.data.split(',')
    })
  },

  /**
   * 生命周期函数--监听页面初次渲染完成
   */
  onReady: function () {

  },

  /**
   * 生命周期函数--监听页面显示
   */
  onShow: function () {

  },

  /**
   * 生命周期函数--监听页面隐藏
   */
  onHide: function () {

  },

  /**
   * 生命周期函数--监听页面卸载
   */
  onUnload: function () {

  },

  /**
   * 页面相关事件处理函数--监听用户下拉动作
   */
  onPullDownRefresh: function () {

  },

  /**
   * 页面上拉触底事件的处理函数
   */
  onReachBottom: function () {

  },

  /**
   * 用户点击右上角分享
   */
  onShareAppMessage: function () {

  }
})