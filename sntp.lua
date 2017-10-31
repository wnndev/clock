print(wifi.sta.status())
sntp.sync({"0.nodemcu.pool.ntp.org","1.nodemcu.pool.ntp.org","2.nodemcu.pool.ntp.org","3.nodemcu.pool.ntp.org"},
  function(sec, usec, server, info)
    print('sync', sec, usec, server)
    
    rtctime.set(sec, usec/1000)
  end,
  function()
   print('failed!')
  end,
  function()
    print('sync')
  end
)
tm = rtctime.epoch2cal(rtctime.get())
print(string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"]))
