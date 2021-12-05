local duration = 10    --> 1/100 of a second
gpio.write(2, gpio.LOW);

function readPiezo ()

    tmr.interval(0, 10)
    knock= adc.read(0);
    if (knock > 100 ) then --If the knock passes a certain threshold
        LastKnock= KnockTime; --Throw the previous value of KnockTime into LastKnock (getting a nil here the first run)
        KnockTime=tmr.now();
        print(knock);
        print ("Knock!");
        tmr.interval(0, 100) --This essentially acts as a debounce. 
        --The code below eventually gives me 5 variables with the time between knocks stored in it
        Diff5=Diff4;
        Diff4=Diff3;
        Diff3=Diff2;
        Diff2=Diff;
        if(LastKnock~=nil) then
            Diff=KnockTime-LastKnock;
            if (Diff<2000000 and Diff>5000) then --Checks to make sure it's not the first knock
                print("Diff="..Diff);
            else
                Diff5=nil; Diff4=nil; Diff3=nil; Diff2=nil; Diff=nil; --zeroes out my knocks
            end
        end
        if (Diff5~=nil) then
            print(Diff5.." "..Diff4.." "..Diff3.." "..Diff2.." "..Diff);
            if(Diff5>100000 and Diff5<250000 and Diff4>50000 and Diff4<250000 and Diff3>500000 and Diff3<2000000 and Diff2>100000 and Diff2<250000 and Diff>100000 and Diff<300000) then 
                print("Unlock Door!")
                gpio.write(2, gpio.HIGH); 
                tmr.alarm(1, 10000, 0, function() 
                    gpio.write(2, gpio.LOW); 
                end )
            end
        end
    end
    
    
end

tmr.alarm(0, duration, 1, readPiezo);
