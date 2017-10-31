status = nil


tmr.alarm(0, 1000, 1, function()
s=wifi.sta.status();
if(s==1)then
status = 'STA_CONNECTING'
elseif(s==2)then
status = 'STA_WRONGPWD'
elseif(s==3)then
status = 'STA_APNOTFOUND'
elseif(s==5)then
status = 'STA_GOTIP'
end
end)
-------------
-- http
-------------
dofile('httpServer.lua')
wifi.ap.config({ssid='WLANConfig'})
wifi.setmode(wifi.STATIONAP)
httpServer:listen(80)
httpServer:use('/config', function(req, res)
    if req.query.ssid ~= nil and req.query.pwd ~= nil then
        wifi.sta.config({ssid=req.query.ssid, pwd=req.query.pwd,save=true,auto=true})
       wifi.sta.autoconnect(1)
        print(req.query.ssid..req.query.pwd)
        status = 'STA_CONNECTING'
        tmr.alarm(1, 1000, 1, function()
            print(status)
            if status ~= 'STA_CONNECTING' then
                res:type('application/json')
                res:send('{"status":"' .. status .. '"}')
                if(status=='STA_GOTIP')then
                    tmr.alarm(3, 2000, 0, function()
                        print("sta mode")
                        wifi.setmode(wifi.STATION)
                        httpServer:close()
                        --dofile('main.lua')
                        end)
                end
                tmr.stop(1)
                
            end
        end)
    end
end)

httpServer:use('/scanap', function(req, res)
print("scan")
    wifi.sta.getap(function(table)
        local aptable = {}
        for ssid,v in pairs(table) do
            local authmode, rssi, bssid, channel = string.match(v, "([^,]+),([^,]+),([^,]+),([^,]+)")
            aptable[ssid] = {
                authmode = authmode,
                rssi = rssi,
                bssid = bssid,
                channel = channel
            }
        end
        res:type('application/json')
        res:send(sjson.encode(aptable))
    end)
end)
