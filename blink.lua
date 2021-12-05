local duration = 10    --> 1 second
    local Diff=0;
    local Diff2=0;
    local Diff3=0;
    local Diff4=0;
    local Diff5=0;
    local Diff6=0;
function readPiezo ()
    tmr.interval(0, 10)
    knock= adc.read(0);
    if (knock > 100 ) then
        LastKnock= KnockTime;
        KnockTime=tmr.now();
        print(knock);
        print ("Knock!");
        tmr.interval(0, 50)
        Diff6=Diff5;
        Diff5=Diff4;
        Diff4=Diff3;
        Diff3=Diff2;
        Diff2=Diff;
        Diff=KnockTime-LastKnock;
        if (Diff<2000000 and Diff>5000) then
            print("Diff="..Diff);
        end
    end
    print (Diff6" "..Diff5" "..Diff4" "..Diff3" "..Diff2" "..Diff);
    
end

tmr.alarm(0, duration, 1, readPiezo)
