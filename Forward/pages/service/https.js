var masterName = 'www.mlcbjm.com';

function req(url, data, back) {
  wx.request({
    url: 'https://' + masterName + url,
    data: data,
    method: 'POST',
    header: { 'Content-Type': 'application/json' },
    success: function (res) {
      return typeof back == "function" && back(res.data)
    },
    fail: function () {
      return typeof back == "function" && back(false)
    }
  })
}

module.exports = {
  req: req
}  
