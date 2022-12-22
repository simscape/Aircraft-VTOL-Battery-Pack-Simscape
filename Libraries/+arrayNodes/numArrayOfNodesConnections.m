classdef numArrayOfNodesConnections < int32
    % Number of connections to an array of nodes concatenator block.

    % Copyright 2022 The MathWorks, Inc.

    enumeration
        one  (1)
        two  (2)
        three  (3)
        four  (4)
        five  (5)
        six  (6)
        seven  (7)
        eight  (8)
        nine  (9)
        ten  (10)
        eleven  (11)
        twelve  (12)
        thirteen  (13)
        fourteen  (14)
        fiveteen  (15)
        sixteen  (16)
        seventeen  (17)
        eightteen  (18)
        nineteen  (19)
        twenty  (20)
        twentyone  (21)
        twentytwo  (22)
        twentythree  (23)
        twentyfour  (24)
        twentyfive  (25)
        twentysix  (26)
        twentyseven  (27)
        twentyeight  (28)
        twentynine  (29)
        thirty  (30)
        thirtyone  (31)
        thirtytwo  (32)
        thirtythree  (33)
        thirtyfour  (34)
        thirtyfive  (35)
        thirtysix  (36)
        thirtyseven  (37)
        thirtyeight  (38)
        thirtynine  (39)
        forty  (40)
        fortyone  (41)
        fortytwo  (42)
        fortythree  (43)
        fortyfour  (44)
        fortyfive  (45)
        fortysix  (46)
        fortyseven  (47)
        fortyeight  (48)
        fortynine  (49)
        fifty  (50)
    end

    methods(Static)
        function map = displayText()
            map = containers.Map;
            map('one') = 1;
            map('two') = 2;
            map('three') = 3;
            map('four') =4;
            map('five') =5;
            map('six') =6;
            map('seven') =7;
            map('eight') =8;
            map('nine') =9;
            map('ten') =10;
            map('eleven') =11;
            map('twelve') =12;
            map('thirteen') =13;
            map('fourteen') =14;
            map('fiveteen') =15;
            map('sixteen') =16;
            map('seventeen') =17;
            map('eightteen') =18;
            map('nineteen') =19;
            map('twenty') =20;
            map('twentyone') =21;
            map('twentytwo') =22;
            map('twentythree') =23;
            map('twentyfour') =24;
            map('twentyfive') =25;
            map('twentysix') =26;
            map('twentyseven') =27;
            map('twentyeight') =28;
            map('twentynine') =29;
            map('thirty') =30;
            map('thirtyone') =31;
            map('thirtytwo') =32;
            map('thirtythree') =33;
            map('thirtyfour') =34;
            map('thirtyfive') =35;
            map('thirtysix') =36;
            map('thirtyseven') =37;
            map('thirtyeight') =38;
            map('thirtynine') =39;
            map('forty') =40;
            map('fortyone') =41;
            map('fortytwo') =42;
            map('fortythree') =43;
            map('fortyfour') =44;
            map('fortyfive') =45;
            map('fortysix') =46;
            map('fortyseven') =47;
            map('fortyeight') =48;
            map('fortynine') =49;
            map('fifty') =50;
        end
    end
end
