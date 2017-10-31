istimesync=false
isconnected=false
iswifi=false
httpidle=true
weathertype=0
temp=" "
bitmap_toMydear="F0000FE00000001FE0FFF87FF03FFFFFFFFE3FF000003F1FF3FFF8FFF1FFFE3FFFFEFFFBFFF7FF7FFFF07DFCFFFF00FF7FFFFEFFFFFFFFFCFFE03FF07FF800FFFF0FF87FFFFFFFFC7F803FE07FC000FDFF0FE03F807F07F03E001FC000000003F7000000000003E00000000000000003E000000000000000000000000000007FF000000000000000000000000000007FF000000000000000000000000000007FF0108108068007C2100400200000007FF0FEC1081C91F8041002001003C7803FF010A2140488908F9E7FF3FF87EFC007E0FC84A204804908A24012008FFFE007E0ADE7413FF9FFC8C20000000FFFE007E094813E04811048923FE1FF0FFFE007E0BC82000490FF8F8A0200100FFFE007E09487BE06A020088A02001007FFC00FE0FD40220C403F08823FE1FF03FF800FC09541A234C851088202801401FF000FC095463E05288E0F8202401200FE000FC08E20220C1971C88C7FF3FF807C00078000000000000000000000000038001F8000000000000000000000000000003F0000000000000000000000000000007F8000000000000000000000000000007CF80000007C0000000000000000000078F8FE0000FE0000000000000000000078F9FF1F00FF00000000007E0000000FFC3DFFBF03FF003F8000F8FF8000781FF83FEFFF87EF01FFF000F9FFC000FE3FF83FC7FFCFE787FFFC01F9FFF001FFFFF0"
bitmap_timesync="0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000084FE00001000800000000000000001E082023FF0900080000000000000000120800220109F008000000000000000012FC5FA2FD0900FF8000000000000000120850A20109008880000000000000001E0850A2FD3FF88881800C006000000012485FA2850000888240120090000000122850A2850510FF8240120090000000122850A2FD09208881800C00600000001E085FA20111C008000000000000000012084022010300080000000000000000003840E2071C0008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
bitmap_sun="00000000000000000000000000000000000000000800000000000808000000020018000000020000000000010FE000000000383000000000C008000000008F880000000088C8C0000000884C0000000C86440000003880C400000000808400000000C184000000007E0C0000000000190000000011F1800000000F0080000000000000000001C0000000000300800000000000800000000000800000000000000000000000000000"
bitmap_bigrain="0000000000000000000000000000000000000000000000000000007F00000001FCC1800000030780800000060000800000040000800000040000F000007C0000180000400000080000400000080000400000080000600000380000380000E000000FFFFF80000000000000000000000100000018421108000030462108000020C422080000408C620800004088440000000000000000000000000000000000000000000000000000"
bitmap_midrain="0000000000000000000000000000000000000000000000000000007F00000001FCC1800000030780800000060000800000040000800000040000F000007C0000180000400000080000400000080000400000080000600000380000380000E000000FFFFF8000000000000000000000000000000604040000000C0C0C0000001818180000001030100000000000000000000000000000000000000000000000000000000000000000"
bitmap_smallrain="0000000000000000000000000000000000000000000000000000007F00000001FCC1800000030780800000060000800000040000800000040000F000007C0000180000400000080000400000080000400000080000600000380000380000E000000FFFFF80000000000000000000000000000000000000000000200C0000000060080000000040180000000000000000000000000000000000000000000000000000000000000000"
bitmap_cloudy="0000000000000000000000000000000000000000400000000000010000000060020000000020000000000003C0000000000FF0000000041FF8000000061FF8000000003FFC7F0000003FFCC18000003F7F808000013F08008000031C00008000001C0000F00000780000180000400000080000400000080000400000080000600000380000380000E000000FFFFF8000000000000000000000000000000000000000000000000000"
bitmap_overcast="00000000000000000000000000007F0000000001C080000000030040000000020047F0000002007C1800000200000800000E0000080000180000080000100000180000100000070000700000018001C0000000800100000000400100000000400100000000400100000000C0010000000380008000001E0000FFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
function timesync()
    sntp.sync({"0.nodemcu.pool.ntp.org","1.nodemcu.pool.ntp.org","2.nodemcu.pool.ntp.org","3.nodemcu.pool.ntp.org"},
      function(sec, usec, server, info)
        print('sync', sec, usec, server)
        rtctime.set(sec+28800, usec/1000)
        istimesync=true
      end,
      function()
       print('failed!')
       tmr.alarm(0,1000,0,timesync)
      end
    )
end
function drawstring(x,y,str)
    print("drawing")
    disp:firstPage()
    repeat
        disp:setFont(u8g.font_6x10)
        --disp:drawStr( 0,32, "Hello World!")
        ls = disp:getFontLineSpacing()
        disp:drawStr(x, y, str) 
    until disp:nextPage() == false 
end
function drawstring2line(str1,str2)
    print("drawing")
    disp:firstPage()
    repeat
        disp:setFont(u8g.font_6x10)
        --disp:drawStr( 0,32, "Hello World!")
        ls = disp:getFontLineSpacing()
        disp:drawStr(0, 16, str1) 
        disp:drawStr(0, 32, str2) 
    until disp:nextPage() == false 
end
function init_i2c_display()
    local sda = 2
    local scl = 1
    local sla = 0x3c
    local rst = 5
    gpio.mode(rst, gpio.OUTPUT,gpio.PULLUP)
    gpio.write(rst, gpio.LOW)
    tmr.delay(10000)
    gpio.write(rst, gpio.HIGH)
    tmr.delay(10000)
    i2c.setup(0, sda, scl, i2c.SLOW)
    disp = u8g.ssd1306_128x32_i2c(sla)
end
function dispbitmap(x,y,cnt,h,bitmapStr)
    hex=encoder.fromHex(bitmapStr)
    disp:firstPage()
    repeat
        disp:drawBitmap ( x , y , cnt , h ,hex)
    until disp:nextPage() == false 
end
function dispweather()
    if(weathertype=="1")then
        disp:drawBitmap(75,0,6,28,encoder.fromHex(bitmap_sun))
    elseif(weathertype=="2")then
        disp:drawBitmap(75,0,6,28,encoder.fromHex(bitmap_smallrain))
    elseif(weathertype=="3")then
        disp:drawBitmap(75,0,6,28,encoder.fromHex(bitmap_midrain))
    elseif(weathertype=="4")then
        disp:drawBitmap(75,0,6,28,encoder.fromHex(bitmap_bigrain))    
    elseif(weathertype=="5")then
        disp:drawBitmap(75,0,6,28,encoder.fromHex(bitmap_cloudy))  
    elseif(weathertype=="6")then
        disp:drawBitmap(75,0,6,28,encoder.fromHex(bitmap_overcast))  
    end 
    disp:setFont(u8g.font_6x10)
    if(temp~=nil)then
        disp:drawStr(85,32,""..temp) 
    end
end
function datahandler(data)
    local mode
    data=string.gsub(data,"0x","")
    data=string.gsub(data,",","")
    data=string.gsub(data,"\n","")
    data=string.gsub(data,"\r","")
    mode=string.match(data,"Mode=(%d)")
    --print(mode)
    if(mode=="1")then
        print("ImageMode")
        httpidle=false
        http.get("http://device.wnndev.com/imagedata",nil, function(code, imagedata)
            httpidle=true
            if (code < 0) then
                print("HTTP request failed")
                --drawstring(0,16,"Server request failed")
                isconnected=false
                --drawstring(0,16,"Server request...")
                sysmode=3
            else
            print("Image Server connected")
            isconnected=true
            if(pcall(dispbitmap,0,0,16,32,imagedata))then
                    --print("right hex string:"..data)
                else  
                    drawstring2line("Server OK","But data broken")
                    drawstring(0,16,"Server request...")
                    sysmode=3
                    --print("wrong hex string:"..data)
                end
            end
        end)
    elseif(mode=="2")then
        print("TestMode")
        data="test"
        
    else
        --print("wcmode")
        
        weathertype=string.match(data,"WeatherType([%w,]+)EndWeatherType")
        temp=string.match(data,"Temp([%--%w+/]+)EndTemp")
        data="wc"
    end
    --print(data)
    return data
end
function weatherclock()
    --if(istimesync)then
        local tm = rtctime.epoch2cal(rtctime.get())
        --time=string.format("%04d/%02d/%02d %02d:%02d:%02d", tm["year"], tm["mon"], tm["day"], tm["hour"], tm["min"], tm["sec"])
        
        disp:firstPage()
        repeat
            disp:setFont(u8g.font_fur20)
            --disp:drawStr( 0,32, "Hello World!")
            local ls = disp:getFontLineSpacing()
            disp:drawStr(1, ls-3, string.format("%02d",tm["hour"])) 
            if(dot)then
                disp:drawStr(32, ls-3-3, ":")
            end
            disp:drawStr(40, ls-3, string.format("%02d",tm["min"]))
            --disp:drawLine(0,23,71,23)
            disp:drawLine(72,0,72,127)
            --disp:drawLine(0,0,127,0)
            --disp:drawLine(127,0,127,31)
            --disp:drawLine(127,31,0,31)
            --disp:drawLine(0,31,0,0)
            disp:setFont(u8g.font_6x10)
            disp:drawStr(0,32, string.format(" %04d-%02d-%02d", tm["year"], tm["mon"], tm["day"]))
            if(iswifi)then
            if(not istimesync)then
                --disp:setFont(u8g.font_6x10)
                disp:drawTriangle(116,5, 122,5, 119,0)         
            end
            if(not isconnected)then
                    --disp:setFont(u8g.font_6x10)
                disp:drawCircle(125, 2, 2)
            end
            else
                    --disp:setFont(u8g.font_6x10)
                disp:drawLine(122,5,127,0)
                disp:drawLine(122,0,127,5)
            end
            --weather
            
            dispweather()
        until disp:nextPage() == false 
        dot=not dot
    --else
        
     --   dispbitmap(0,0,16,32,bitmap_timesync)
     --   tmr.delay(3000000)
    --end
end
function getdata()
    httpidle=false
    http.get("http://device.wnndev.com",nil, function(code, data)
    httpidle=true
        if (code < 0) then
            print("HTTP request failed")
            --drawstring(0,16,"Server request failed")
            isconnected=false
            --drawstring(0,16,"Server request...")
            sysmode=3
        else
            print("Server connected")
            --drawstring(0,16,data)
            --if(#data%2==0 and )then
            --print(data)
            
            --print(data)
            isconnected=true
            sysmode=1
            data=datahandler(data)
            if(data==nil) then
                print("nildata")
                return
            
            elseif(data=="wc")then
                sysmode=3
            elseif(data=="test")then
                sysmode=2
                drawstring2line("Server OK","Test OK")
            else
                sysmode=1
                
            end
        end
        data=nil
      end)
      
end

sysmode=3
--tmr.delay(1000000)
init_i2c_display()
pcall(dispbitmap,0,0,16,32,bitmap_toMydear)
--drawstring(0,16,"Wifi connecting...")
--while(wifi.sta.status()~=5)do
--end
--print("connected")
print(wifi.sta.getip()) 
--drawstring(0,16,"Server request...")
timesync()
pcall(getdata)
tmr.alarm(3,11231,1,function() 
print("Remain Ram Size:"..node.heap())
print(httpidle)
    if(httpidle)then
        getdata()
    else
        print("http busy")
        end
end)
tmr.alarm(1,500,1,
function()
    if(sysmode==3)then
        weatherclock()
    end
end)
tmr.alarm(2,1111,1,
function()
        iswifi=(wifi.sta.status()==5)    
end)
tmr.alarm(4,6870943,1,
function()
        timesync()
end)

