print(wifi.sta.getip())
D5=2;
D2=10;
D3=8;
gpio.mode(D2, gpio.OUTPUT);
gpio.write(D2, gpio.HIGH);
gpio.mode(D5, gpio.INT);

function debounce (func)
    local last = 0
    local delay = 200000

    return function (...)
        local now = tmr.now()
        if now - last < delay then return end

        last = now
        return func(...)
    end
end
function turnMeOff()
    gpio.write(D2, gpio.LOW);
end
function sayHello ()
    print 'Hello'
end


function onChange ()
    if gpio.read(D5) ==gpio.HIGH then
        tmr.alarm(0, 5000, 0, turnMeOff)
    end
end


gpio.trig(D5, 'both', onChange)
