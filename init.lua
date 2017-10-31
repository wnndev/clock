IO_SET = 7
gpio.mode(IO_SET, gpio.INPUT,gpio.PULLUP)
print(gpio.read(IO_SET))
-------------
-- button
-------------

-------------
-- wifi
-------------
function disinit()
    wifi.setmode(wifi.STATION)
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
if(gpio.read(IO_SET)==1)then
    
    dofile('main.lua')
else
    disinit()
    print("drawing")
    disp:firstPage()
    repeat
        disp:setFont(u8g.font_6x10)
        disp:drawStr(0, 10, "-----Config Mode-----") 
        disp:drawStr(0, 20, "Wifi name: WLANConfig") 
        disp:drawStr(0, 30, "address: 192.168.4.1") 
    until disp:nextPage() == false
    dofile('config.lua')
end
