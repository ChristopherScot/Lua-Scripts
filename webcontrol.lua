gpio.write(2, gpio.HIGH);
wifi.sta.config("SparkLan","psychoduber22")
wifi.sta.setip({ip="192.168.1.111",netmask="255.255.255.0",gateway="192.168.1.1"})
print(wifi.sta.getip())

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(conn,payload)
    --print(payload)
        if string.find(payload,"Door=Unlock") ~= nil then
            print("This is working")
            gpio.write(2, gpio.HIGH);
            tmr.alarm(1, 10000, 0, function() 
                    gpio.write(2, gpio.LOW); 
            end )
        end
        conn:close();
        collectgarbage();
    end)
end)

