
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity project_tb is
end project_tb;

architecture projecttb of project_tb is
constant c_CLOCK_PERIOD         : time := 15 ns;
signal   tb_done                : std_logic;
signal   mem_address            : std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst                 : std_logic := '0';
signal   tb_start               : std_logic := '0';
signal   tb_clk                 : std_logic := '0';
signal   mem_o_data,mem_i_data  : std_logic_vector (7 downto 0);
signal   enable_wire            : std_logic;
signal   mem_we                 : std_logic;

type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);

signal i: std_logic_vector(2 downto 0) := "000";


signal RAM: ram_type := (0 => std_logic_vector(to_unsigned(  0  , 8)),
			 1 => std_logic_vector(to_unsigned(  2  , 8)),
--             2 => std_logic_vector(to_unsigned(  141  , 8)),
--             3 => std_logic_vector(to_unsigned(  241  , 8)),
--             4 => std_logic_vector(to_unsigned(  56  , 8)),
--             5 => std_logic_vector(to_unsigned(  250  , 8)),
                         others => (others =>'0'));         
			 -- delta=240 shift=1    

signal RAM1: ram_type := (0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  0  , 8)),
--			 2 => std_logic_vector(to_unsigned(  227  , 8)),
--			 3 => std_logic_vector(to_unsigned(  96  , 8)),
--			 4 => std_logic_vector(to_unsigned(  80  , 8)),
--			 5 => std_logic_vector(to_unsigned(  124  , 8)),
                         others => (others =>'0'));      

signal RAM2: ram_type := (0 => std_logic_vector(to_unsigned(  0  , 8)),
			 1 => std_logic_vector(to_unsigned(  0  , 8)),
--			 2 => std_logic_vector(to_unsigned(  50  , 8)),
--			 3 => std_logic_vector(to_unsigned(  51  , 8)),
--			 4 => std_logic_vector(to_unsigned(  52  , 8)),
--			 5 => std_logic_vector(to_unsigned(  51  , 8)),
                         others => (others =>'0'));              

signal RAM3: ram_type := (0 => std_logic_vector(to_unsigned(  1  , 8)),
			 1 => std_logic_vector(to_unsigned(  1  , 8)),
			 2 => std_logic_vector(to_unsigned(  25  , 8)),
                         others => (others =>'0'));   
                         
signal RAM4: ram_type := (0 => std_logic_vector(to_unsigned(  8  , 8)),
			 1 => std_logic_vector(to_unsigned(  4  , 8)),
			 2 => std_logic_vector(to_unsigned(  128  , 8)),
			 3 => std_logic_vector(to_unsigned(  75  , 8)),
			 4 => std_logic_vector(to_unsigned(  50  , 8)),
			 5 => std_logic_vector(to_unsigned(  97  , 8)),
			 6 => std_logic_vector(to_unsigned(  49  , 8)),
			 7 => std_logic_vector(to_unsigned(  110  , 8)),
			 8 => std_logic_vector(to_unsigned(  100  , 8)),
			 9 => std_logic_vector(to_unsigned(  90  , 8)),
			 10 => std_logic_vector(to_unsigned(  170  , 8)),
			 11 => std_logic_vector(to_unsigned(  169  , 8)),
			 12 => std_logic_vector(to_unsigned(  150  , 8)),
			 13 => std_logic_vector(to_unsigned(  43  , 8)),
			 14 => std_logic_vector(to_unsigned(  224  , 8)),
			 15 => std_logic_vector(to_unsigned(  99  , 8)),
			 16 => std_logic_vector(to_unsigned(  90  , 8)),
			 17 => std_logic_vector(to_unsigned(  189  , 8)),
			 18 => std_logic_vector(to_unsigned(  178  , 8)),
			 19 => std_logic_vector(to_unsigned(  163  , 8)),
			 20 => std_logic_vector(to_unsigned(  21  , 8)),
			 21 => std_logic_vector(to_unsigned(  6  , 8)),
			 22 => std_logic_vector(to_unsigned(  240  , 8)),
			 23 => std_logic_vector(to_unsigned(  7  , 8)),
			 24 => std_logic_vector(to_unsigned(  231  , 8)),
			 25 => std_logic_vector(to_unsigned(  255  , 8)),
			 26 => std_logic_vector(to_unsigned(  6  , 8)),
			 27 => std_logic_vector(to_unsigned(  6  , 8)),
			 28 => std_logic_vector(to_unsigned(  5  , 8)),
			 29 => std_logic_vector(to_unsigned(  10  , 8)),
			 30 => std_logic_vector(to_unsigned(  0  , 8)),
			 31 => std_logic_vector(to_unsigned(  57  , 8)),
			 32 => std_logic_vector(to_unsigned(  91  , 8)),
			 33 => std_logic_vector(to_unsigned(  32  , 8)),		 			 			 
                         others => (others =>'0'));   
                                                  
signal RAM5: ram_type := (0 => std_logic_vector(to_unsigned(  9  , 8)),
			 1 => std_logic_vector(to_unsigned(  4  , 8)),
			 2 => std_logic_vector(to_unsigned(  128  , 8)),
			 3 => std_logic_vector(to_unsigned(  75  , 8)),
			 4 => std_logic_vector(to_unsigned(  50  , 8)),
			 5 => std_logic_vector(to_unsigned(  97  , 8)),
			 6 => std_logic_vector(to_unsigned(  49  , 8)),
			 7 => std_logic_vector(to_unsigned(  110  , 8)),
			 8 => std_logic_vector(to_unsigned(  100  , 8)),
			 9 => std_logic_vector(to_unsigned(  90  , 8)),
			 10 => std_logic_vector(to_unsigned(  170  , 8)),
			 11 => std_logic_vector(to_unsigned(  169  , 8)),
			 12 => std_logic_vector(to_unsigned(  150  , 8)),
			 13 => std_logic_vector(to_unsigned(  43  , 8)),
			 14 => std_logic_vector(to_unsigned(  198  , 8)),
			 15 => std_logic_vector(to_unsigned(  99  , 8)),
			 16 => std_logic_vector(to_unsigned(  90  , 8)),
			 17 => std_logic_vector(to_unsigned(  189  , 8)),
			 18 => std_logic_vector(to_unsigned(  178  , 8)),
			 19 => std_logic_vector(to_unsigned(  163  , 8)),
			 20 => std_logic_vector(to_unsigned(  50  , 8)),
			 21 => std_logic_vector(to_unsigned(  80  , 8)),
			 22 => std_logic_vector(to_unsigned(  200  , 8)),
			 23 => std_logic_vector(to_unsigned(  91  , 8)),
			 24 => std_logic_vector(to_unsigned(  201  , 8)),
			 25 => std_logic_vector(to_unsigned(  200  , 8)),
			 26 => std_logic_vector(to_unsigned(  107  , 8)),
			 27 => std_logic_vector(to_unsigned(  86  , 8)),
			 28 => std_logic_vector(to_unsigned(  49  , 8)),
			 29 => std_logic_vector(to_unsigned(  68  , 8)),
			 30 => std_logic_vector(to_unsigned(  76  , 8)),
			 31 => std_logic_vector(to_unsigned(  121  , 8)),
			 32 => std_logic_vector(to_unsigned(  114  , 8)),
			 33 => std_logic_vector(to_unsigned(  160  , 8)),
			 34 => std_logic_vector(to_unsigned(  54  , 8)),
			 35 => std_logic_vector(to_unsigned(  57  , 8)),
			 36 => std_logic_vector(to_unsigned(  73  , 8)),
			 37 => std_logic_vector(to_unsigned(  95  , 8)),			 			 			 
                         others => (others =>'0'));  

signal RAM6: ram_type := (0 => std_logic_vector(to_unsigned(  2  , 8)),
			 1 => std_logic_vector(to_unsigned(  2  , 8)),
			 2 => std_logic_vector(to_unsigned(  0  , 8)),
			 3 => std_logic_vector(to_unsigned(  0  , 8)),
			 4 => std_logic_vector(to_unsigned(  0  , 8)),
			 5 => std_logic_vector(to_unsigned(  0  , 8)),
                         others => (others =>'0'));  
                         
signal RAM7: ram_type := (
--           0 => std_logic_vector(to_unsigned(  2  , 8)),
--			 1 => std_logic_vector(to_unsigned(  2  , 8)),
--			 2 => std_logic_vector(to_unsigned(  255  , 8)),
--			 3 => std_logic_vector(to_unsigned(  255  , 8)),
--			 4 => std_logic_vector(to_unsigned(  255  , 8)),
--			 5 => std_logic_vector(to_unsigned(  254  , 8)),
             0 => std_logic_vector(to_unsigned( 16 , 8)),
            1 => std_logic_vector(to_unsigned( 16 , 8)),
            2 => std_logic_vector(to_unsigned( 190 , 8)),
            3 => std_logic_vector(to_unsigned( 189 , 8)),
            4 => std_logic_vector(to_unsigned( 200 , 8)),
            5 => std_logic_vector(to_unsigned( 234 , 8)),
            6 => std_logic_vector(to_unsigned( 154 , 8)),
            7 => std_logic_vector(to_unsigned( 58 , 8)),
            8 => std_logic_vector(to_unsigned( 153 , 8)),
            9 => std_logic_vector(to_unsigned( 152 , 8)),
            10 => std_logic_vector(to_unsigned( 169 , 8)),
            11 => std_logic_vector(to_unsigned( 191 , 8)),
            12 => std_logic_vector(to_unsigned( 254 , 8)),
            13 => std_logic_vector(to_unsigned( 74 , 8)),
            14 => std_logic_vector(to_unsigned( 19 , 8)),
            15 => std_logic_vector(to_unsigned( 21 , 8)),
            16 => std_logic_vector(to_unsigned( 26 , 8)),
            17 => std_logic_vector(to_unsigned( 108 , 8)),
            18 => std_logic_vector(to_unsigned( 170 , 8)),
            19 => std_logic_vector(to_unsigned( 56 , 8)),
            20 => std_logic_vector(to_unsigned( 70 , 8)),
            21 => std_logic_vector(to_unsigned( 198 , 8)),
            22 => std_logic_vector(to_unsigned( 95 , 8)),
            23 => std_logic_vector(to_unsigned( 140 , 8)),
            24 => std_logic_vector(to_unsigned( 36 , 8)),
            25 => std_logic_vector(to_unsigned( 30 , 8)),
            26 => std_logic_vector(to_unsigned( 148 , 8)),
            27 => std_logic_vector(to_unsigned( 86 , 8)),
            28 => std_logic_vector(to_unsigned( 26 , 8)),
            29 => std_logic_vector(to_unsigned( 135 , 8)),
            30 => std_logic_vector(to_unsigned( 56 , 8)),
            31 => std_logic_vector(to_unsigned( 34 , 8)),
            32 => std_logic_vector(to_unsigned( 220 , 8)),
            33 => std_logic_vector(to_unsigned( 36 , 8)),
            34 => std_logic_vector(to_unsigned( 140 , 8)),
            35 => std_logic_vector(to_unsigned( 82 , 8)),
            36 => std_logic_vector(to_unsigned( 145 , 8)),
            37 => std_logic_vector(to_unsigned( 208 , 8)),
            38 => std_logic_vector(to_unsigned( 169 , 8)),
            39 => std_logic_vector(to_unsigned( 78 , 8)),
            40 => std_logic_vector(to_unsigned( 11 , 8)),
            41 => std_logic_vector(to_unsigned( 231 , 8)),
            42 => std_logic_vector(to_unsigned( 205 , 8)),
            43 => std_logic_vector(to_unsigned( 208 , 8)),
            44 => std_logic_vector(to_unsigned( 226 , 8)),
            45 => std_logic_vector(to_unsigned( 186 , 8)),
            46 => std_logic_vector(to_unsigned( 66 , 8)),
            47 => std_logic_vector(to_unsigned( 183 , 8)),
            48 => std_logic_vector(to_unsigned( 229 , 8)),
            49 => std_logic_vector(to_unsigned( 24 , 8)),
            50 => std_logic_vector(to_unsigned( 90 , 8)),
            51 => std_logic_vector(to_unsigned( 137 , 8)),
            52 => std_logic_vector(to_unsigned( 82 , 8)),
            53 => std_logic_vector(to_unsigned( 52 , 8)),
            54 => std_logic_vector(to_unsigned( 92 , 8)),
            55 => std_logic_vector(to_unsigned( 164 , 8)),
            56 => std_logic_vector(to_unsigned( 50 , 8)),
            57 => std_logic_vector(to_unsigned( 94 , 8)),
            58 => std_logic_vector(to_unsigned( 193 , 8)),
            59 => std_logic_vector(to_unsigned( 206 , 8)),
            60 => std_logic_vector(to_unsigned( 59 , 8)),
            61 => std_logic_vector(to_unsigned( 217 , 8)),
            62 => std_logic_vector(to_unsigned( 26 , 8)),
            63 => std_logic_vector(to_unsigned( 191 , 8)),
            64 => std_logic_vector(to_unsigned( 68 , 8)),
            65 => std_logic_vector(to_unsigned( 170 , 8)),
            66 => std_logic_vector(to_unsigned( 172 , 8)),
            67 => std_logic_vector(to_unsigned( 49 , 8)),
            68 => std_logic_vector(to_unsigned( 163 , 8)),
            69 => std_logic_vector(to_unsigned( 169 , 8)),
            70 => std_logic_vector(to_unsigned( 66 , 8)),
            71 => std_logic_vector(to_unsigned( 116 , 8)),
            72 => std_logic_vector(to_unsigned( 87 , 8)),
            73 => std_logic_vector(to_unsigned( 93 , 8)),
            74 => std_logic_vector(to_unsigned( 74 , 8)),
            75 => std_logic_vector(to_unsigned( 84 , 8)),
            76 => std_logic_vector(to_unsigned( 0 , 8)),
            77 => std_logic_vector(to_unsigned( 130 , 8)),
            78 => std_logic_vector(to_unsigned( 194 , 8)),
            79 => std_logic_vector(to_unsigned( 132 , 8)),
            80 => std_logic_vector(to_unsigned( 201 , 8)),
            81 => std_logic_vector(to_unsigned( 196 , 8)),
            82 => std_logic_vector(to_unsigned( 226 , 8)),
            83 => std_logic_vector(to_unsigned( 143 , 8)),
            84 => std_logic_vector(to_unsigned( 106 , 8)),
            85 => std_logic_vector(to_unsigned( 252 , 8)),
            86 => std_logic_vector(to_unsigned( 69 , 8)),
            87 => std_logic_vector(to_unsigned( 138 , 8)),
            88 => std_logic_vector(to_unsigned( 159 , 8)),
            89 => std_logic_vector(to_unsigned( 237 , 8)),
            90 => std_logic_vector(to_unsigned( 14 , 8)),
            91 => std_logic_vector(to_unsigned( 41 , 8)),
            92 => std_logic_vector(to_unsigned( 122 , 8)),
            93 => std_logic_vector(to_unsigned( 104 , 8)),
            94 => std_logic_vector(to_unsigned( 17 , 8)),
            95 => std_logic_vector(to_unsigned( 101 , 8)),
            96 => std_logic_vector(to_unsigned( 95 , 8)),
            97 => std_logic_vector(to_unsigned( 51 , 8)),
            98 => std_logic_vector(to_unsigned( 207 , 8)),
            99 => std_logic_vector(to_unsigned( 173 , 8)),
            100 => std_logic_vector(to_unsigned( 66 , 8)),
            101 => std_logic_vector(to_unsigned( 223 , 8)),
            102 => std_logic_vector(to_unsigned( 183 , 8)),
            103 => std_logic_vector(to_unsigned( 181 , 8)),
            104 => std_logic_vector(to_unsigned( 226 , 8)),
            105 => std_logic_vector(to_unsigned( 125 , 8)),
            106 => std_logic_vector(to_unsigned( 226 , 8)),
            107 => std_logic_vector(to_unsigned( 96 , 8)),
            108 => std_logic_vector(to_unsigned( 3 , 8)),
            109 => std_logic_vector(to_unsigned( 120 , 8)),
            110 => std_logic_vector(to_unsigned( 78 , 8)),
            111 => std_logic_vector(to_unsigned( 115 , 8)),
            112 => std_logic_vector(to_unsigned( 96 , 8)),
            113 => std_logic_vector(to_unsigned( 148 , 8)),
            114 => std_logic_vector(to_unsigned( 208 , 8)),
            115 => std_logic_vector(to_unsigned( 72 , 8)),
            116 => std_logic_vector(to_unsigned( 114 , 8)),
            117 => std_logic_vector(to_unsigned( 1 , 8)),
            118 => std_logic_vector(to_unsigned( 147 , 8)),
            119 => std_logic_vector(to_unsigned( 246 , 8)),
            120 => std_logic_vector(to_unsigned( 194 , 8)),
            121 => std_logic_vector(to_unsigned( 55 , 8)),
            122 => std_logic_vector(to_unsigned( 46 , 8)),
            123 => std_logic_vector(to_unsigned( 244 , 8)),
            124 => std_logic_vector(to_unsigned( 13 , 8)),
            125 => std_logic_vector(to_unsigned( 81 , 8)),
            126 => std_logic_vector(to_unsigned( 128 , 8)),
            127 => std_logic_vector(to_unsigned( 247 , 8)),
            128 => std_logic_vector(to_unsigned( 136 , 8)),
            129 => std_logic_vector(to_unsigned( 13 , 8)),
            130 => std_logic_vector(to_unsigned( 89 , 8)),
            131 => std_logic_vector(to_unsigned( 189 , 8)),
            132 => std_logic_vector(to_unsigned( 182 , 8)),
            133 => std_logic_vector(to_unsigned( 226 , 8)),
            134 => std_logic_vector(to_unsigned( 204 , 8)),
            135 => std_logic_vector(to_unsigned( 29 , 8)),
            136 => std_logic_vector(to_unsigned( 104 , 8)),
            137 => std_logic_vector(to_unsigned( 87 , 8)),
            138 => std_logic_vector(to_unsigned( 179 , 8)),
            139 => std_logic_vector(to_unsigned( 69 , 8)),
            140 => std_logic_vector(to_unsigned( 83 , 8)),
            141 => std_logic_vector(to_unsigned( 18 , 8)),
            142 => std_logic_vector(to_unsigned( 220 , 8)),
            143 => std_logic_vector(to_unsigned( 176 , 8)),
            144 => std_logic_vector(to_unsigned( 45 , 8)),
            145 => std_logic_vector(to_unsigned( 101 , 8)),
            146 => std_logic_vector(to_unsigned( 164 , 8)),
            147 => std_logic_vector(to_unsigned( 34 , 8)),
            148 => std_logic_vector(to_unsigned( 214 , 8)),
            149 => std_logic_vector(to_unsigned( 182 , 8)),
            150 => std_logic_vector(to_unsigned( 238 , 8)),
            151 => std_logic_vector(to_unsigned( 169 , 8)),
            152 => std_logic_vector(to_unsigned( 94 , 8)),
            153 => std_logic_vector(to_unsigned( 122 , 8)),
            154 => std_logic_vector(to_unsigned( 232 , 8)),
            155 => std_logic_vector(to_unsigned( 223 , 8)),
            156 => std_logic_vector(to_unsigned( 171 , 8)),
            157 => std_logic_vector(to_unsigned( 253 , 8)),
            158 => std_logic_vector(to_unsigned( 115 , 8)),
            159 => std_logic_vector(to_unsigned( 251 , 8)),
            160 => std_logic_vector(to_unsigned( 219 , 8)),
            161 => std_logic_vector(to_unsigned( 190 , 8)),
            162 => std_logic_vector(to_unsigned( 65 , 8)),
            163 => std_logic_vector(to_unsigned( 20 , 8)),
            164 => std_logic_vector(to_unsigned( 192 , 8)),
            165 => std_logic_vector(to_unsigned( 248 , 8)),
            166 => std_logic_vector(to_unsigned( 204 , 8)),
            167 => std_logic_vector(to_unsigned( 32 , 8)),
            168 => std_logic_vector(to_unsigned( 201 , 8)),
            169 => std_logic_vector(to_unsigned( 119 , 8)),
            170 => std_logic_vector(to_unsigned( 252 , 8)),
            171 => std_logic_vector(to_unsigned( 97 , 8)),
            172 => std_logic_vector(to_unsigned( 235 , 8)),
            173 => std_logic_vector(to_unsigned( 38 , 8)),
            174 => std_logic_vector(to_unsigned( 189 , 8)),
            175 => std_logic_vector(to_unsigned( 43 , 8)),
            176 => std_logic_vector(to_unsigned( 192 , 8)),
            177 => std_logic_vector(to_unsigned( 4 , 8)),
            178 => std_logic_vector(to_unsigned( 155 , 8)),
            179 => std_logic_vector(to_unsigned( 221 , 8)),
            180 => std_logic_vector(to_unsigned( 56 , 8)),
            181 => std_logic_vector(to_unsigned( 56 , 8)),
            182 => std_logic_vector(to_unsigned( 172 , 8)),
            183 => std_logic_vector(to_unsigned( 31 , 8)),
            184 => std_logic_vector(to_unsigned( 207 , 8)),
            185 => std_logic_vector(to_unsigned( 139 , 8)),
            186 => std_logic_vector(to_unsigned( 200 , 8)),
            187 => std_logic_vector(to_unsigned( 63 , 8)),
            188 => std_logic_vector(to_unsigned( 141 , 8)),
            189 => std_logic_vector(to_unsigned( 80 , 8)),
            190 => std_logic_vector(to_unsigned( 60 , 8)),
            191 => std_logic_vector(to_unsigned( 163 , 8)),
            192 => std_logic_vector(to_unsigned( 201 , 8)),
            193 => std_logic_vector(to_unsigned( 34 , 8)),
            194 => std_logic_vector(to_unsigned( 136 , 8)),
            195 => std_logic_vector(to_unsigned( 128 , 8)),
            196 => std_logic_vector(to_unsigned( 55 , 8)),
            197 => std_logic_vector(to_unsigned( 125 , 8)),
            198 => std_logic_vector(to_unsigned( 70 , 8)),
            199 => std_logic_vector(to_unsigned( 12 , 8)),
            200 => std_logic_vector(to_unsigned( 209 , 8)),
            201 => std_logic_vector(to_unsigned( 151 , 8)),
            202 => std_logic_vector(to_unsigned( 254 , 8)),
            203 => std_logic_vector(to_unsigned( 113 , 8)),
            204 => std_logic_vector(to_unsigned( 135 , 8)),
            205 => std_logic_vector(to_unsigned( 214 , 8)),
            206 => std_logic_vector(to_unsigned( 56 , 8)),
            207 => std_logic_vector(to_unsigned( 43 , 8)),
            208 => std_logic_vector(to_unsigned( 56 , 8)),
            209 => std_logic_vector(to_unsigned( 150 , 8)),
            210 => std_logic_vector(to_unsigned( 17 , 8)),
            211 => std_logic_vector(to_unsigned( 186 , 8)),
            212 => std_logic_vector(to_unsigned( 16 , 8)),
            213 => std_logic_vector(to_unsigned( 202 , 8)),
            214 => std_logic_vector(to_unsigned( 227 , 8)),
            215 => std_logic_vector(to_unsigned( 12 , 8)),
            216 => std_logic_vector(to_unsigned( 88 , 8)),
            217 => std_logic_vector(to_unsigned( 125 , 8)),
            218 => std_logic_vector(to_unsigned( 1 , 8)),
            219 => std_logic_vector(to_unsigned( 198 , 8)),
            220 => std_logic_vector(to_unsigned( 119 , 8)),
            221 => std_logic_vector(to_unsigned( 222 , 8)),
            222 => std_logic_vector(to_unsigned( 56 , 8)),
            223 => std_logic_vector(to_unsigned( 179 , 8)),
            224 => std_logic_vector(to_unsigned( 167 , 8)),
            225 => std_logic_vector(to_unsigned( 189 , 8)),
            226 => std_logic_vector(to_unsigned( 142 , 8)),
            227 => std_logic_vector(to_unsigned( 60 , 8)),
            228 => std_logic_vector(to_unsigned( 188 , 8)),
            229 => std_logic_vector(to_unsigned( 218 , 8)),
            230 => std_logic_vector(to_unsigned( 34 , 8)),
            231 => std_logic_vector(to_unsigned( 138 , 8)),
            232 => std_logic_vector(to_unsigned( 254 , 8)),
            233 => std_logic_vector(to_unsigned( 12 , 8)),
            234 => std_logic_vector(to_unsigned( 201 , 8)),
            235 => std_logic_vector(to_unsigned( 200 , 8)),
            236 => std_logic_vector(to_unsigned( 196 , 8)),
            237 => std_logic_vector(to_unsigned( 153 , 8)),
            238 => std_logic_vector(to_unsigned( 39 , 8)),
            239 => std_logic_vector(to_unsigned( 66 , 8)),
            240 => std_logic_vector(to_unsigned( 63 , 8)),
            241 => std_logic_vector(to_unsigned( 134 , 8)),
            242 => std_logic_vector(to_unsigned( 243 , 8)),
            243 => std_logic_vector(to_unsigned( 246 , 8)),
            244 => std_logic_vector(to_unsigned( 187 , 8)),
            245 => std_logic_vector(to_unsigned( 3 , 8)),
            246 => std_logic_vector(to_unsigned( 118 , 8)),
            247 => std_logic_vector(to_unsigned( 224 , 8)),
            248 => std_logic_vector(to_unsigned( 110 , 8)),
            249 => std_logic_vector(to_unsigned( 8 , 8)),
            250 => std_logic_vector(to_unsigned( 109 , 8)),
            251 => std_logic_vector(to_unsigned( 43 , 8)),
            252 => std_logic_vector(to_unsigned( 107 , 8)),
            253 => std_logic_vector(to_unsigned( 248 , 8)),
            254 => std_logic_vector(to_unsigned( 107 , 8)),
            255 => std_logic_vector(to_unsigned( 244 , 8)),
            256 => std_logic_vector(to_unsigned( 141 , 8)),
            257 => std_logic_vector(to_unsigned( 212 , 8)),
                         others => (others =>'0'));                             

component project_reti_logiche is
port (
      i_clk         : in  std_logic;
      i_start       : in  std_logic;
      i_rst         : in  std_logic;
      i_data        : in  std_logic_vector(7 downto 0);
      o_address     : out std_logic_vector(15 downto 0);
      o_done        : out std_logic;
      o_en          : out std_logic;
      o_we          : out std_logic;
      o_data        : out std_logic_vector (7 downto 0)
      );
end component project_reti_logiche;


begin
UUT: project_reti_logiche
port map (
          i_clk      	=> tb_clk,
          i_start       => tb_start,
          i_rst      	=> tb_rst,
          i_data    	=> mem_o_data,
          o_address  	=> mem_address,
          o_done      	=> tb_done,
          o_en   	=> enable_wire,
          o_we 		=> mem_we,
          o_data    	=> mem_i_data
          );

p_CLK_GEN : process is
begin
    wait for c_CLOCK_PERIOD/2;
    tb_clk <= not tb_clk;
end process p_CLK_GEN;


MEM : process(tb_clk)
begin
if tb_clk'event and tb_clk = '1' then
    if enable_wire = '1' then
        if i = "000" then
            if mem_we = '1' then
                RAM(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 1 ns;
            else
                mem_o_data <= RAM(conv_integer(mem_address)) after 1 ns;
            end if;
        elsif i ="001" then
            if mem_we = '1' then
                RAM1(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 1 ns;
            else
                mem_o_data <= RAM1(conv_integer(mem_address)) after 1 ns;
            end if;
        elsif i = "010" then 
            if mem_we = '1' then
                RAM2(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 1 ns;
            else
                mem_o_data <= RAM2(conv_integer(mem_address)) after 1 ns;
            end if;
        elsif i = "011" then 
            if mem_we = '1' then
                RAM3(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 1 ns;
            else
                mem_o_data <= RAM3(conv_integer(mem_address)) after 1 ns;
            end if;
        elsif i = "100" then 
            if mem_we = '1' then
                RAM4(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 1 ns;
            else
                mem_o_data <= RAM4(conv_integer(mem_address)) after 1 ns;
            end if;
        elsif i = "101" then 
            if mem_we = '1' then
                RAM5(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 1 ns;
            else
                mem_o_data <= RAM5(conv_integer(mem_address)) after 1 ns;
            end if;
        elsif i = "110" then 
            if mem_we = '1' then
                RAM6(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 1 ns;
            else
                mem_o_data <= RAM6(conv_integer(mem_address)) after 1 ns;
            end if;
        elsif i = "111" then 
            if mem_we = '1' then
                RAM7(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 1 ns;
            else
                mem_o_data <= RAM7(conv_integer(mem_address)) after 1 ns;
            end if;    
        end if;
    end if;
end if;
end process;


test : process is
begin 
    wait for 100 ns;
    wait for c_CLOCK_PERIOD;
    tb_rst <= '1';
    wait for c_CLOCK_PERIOD;
    wait for 100 ns;
    tb_rst <= '0';
    wait for c_CLOCK_PERIOD;
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "001";

    
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "010";

    
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "011";
    
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "100";
    
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "101";
    
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "110";
    
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    i <= "111";
    
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;
    
    --RAM
	assert RAM(2) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM(2))))  severity failure; 
	assert RAM(3) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected    found " & integer'image(to_integer(unsigned(RAM(3))))  severity failure; 
	assert RAM(4) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM(4))))  severity failure; 
--	assert RAM(9) = std_logic_vector(to_unsigned( 255 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  255  found " & integer'image(to_integer(unsigned(RAM(9))))  severity failure;
    --RAM1
	assert RAM1(2) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM1(2))))  severity failure; 
	assert RAM1(3) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM1(3))))  severity failure; 
	assert RAM1(4) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM1(4))))  severity failure; 
--	assert RAM1(9) = std_logic_vector(to_unsigned( 88 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  88  found " & integer'image(to_integer(unsigned(RAM1(9))))  severity failure;
    --RAM2
	assert RAM2(2) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(2))))  severity failure; 
	assert RAM2(3) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(3))))  severity failure; 
	assert RAM2(4) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(4))))  severity failure; 
--	assert RAM2(9) = std_logic_vector(to_unsigned( 128 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM2(9))))  severity failure;
    --RAM3
    assert RAM3(3) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(3))))  severity failure;
    assert RAM3(4) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(4))))  severity failure;
    --RAM4
    assert RAM4(34)= std_logic_vector(to_unsigned( 128 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 128 found " & integer'image(to_integer(unsigned(RAM4(34))))  severity failure;
    assert RAM4(35)= std_logic_vector(to_unsigned( 75 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 75 found " & integer'image(to_integer(unsigned(RAM4(35))))  severity failure;
    assert RAM4(36)= std_logic_vector(to_unsigned( 50 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 50 found " & integer'image(to_integer(unsigned(RAM4(36))))  severity failure;
    assert RAM4(37)= std_logic_vector(to_unsigned( 97 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 97 found " & integer'image(to_integer(unsigned(RAM4(37))))  severity failure;
    assert RAM4(38)= std_logic_vector(to_unsigned( 49 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 49 found " & integer'image(to_integer(unsigned(RAM4(38))))  severity failure;
    assert RAM4(39)= std_logic_vector(to_unsigned( 110 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 110 found " & integer'image(to_integer(unsigned(RAM4(39))))  severity failure;
    assert RAM4(40)= std_logic_vector(to_unsigned( 100 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 100 found " & integer'image(to_integer(unsigned(RAM4(40))))  severity failure;
    assert RAM4(41)= std_logic_vector(to_unsigned( 90 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 90 found " & integer'image(to_integer(unsigned(RAM4(41))))  severity failure;
    assert RAM4(42)= std_logic_vector(to_unsigned( 170 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 170 found " & integer'image(to_integer(unsigned(RAM4(42))))  severity failure;
    assert RAM4(43)= std_logic_vector(to_unsigned( 169 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 169 found " & integer'image(to_integer(unsigned(RAM4(43))))  severity failure;
    assert RAM4(44)= std_logic_vector(to_unsigned( 150 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 150 found " & integer'image(to_integer(unsigned(RAM4(44))))  severity failure;
    assert RAM4(45)= std_logic_vector(to_unsigned( 43 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 43 found " & integer'image(to_integer(unsigned(RAM4(45))))  severity failure;
    assert RAM4(46)= std_logic_vector(to_unsigned( 224 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 224 found " & integer'image(to_integer(unsigned(RAM4(46))))  severity failure;
    assert RAM4(47)= std_logic_vector(to_unsigned( 99 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 99 found " & integer'image(to_integer(unsigned(RAM4(47))))  severity failure;
    assert RAM4(48)= std_logic_vector(to_unsigned( 90 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 90 found " & integer'image(to_integer(unsigned(RAM4(48))))  severity failure;
    assert RAM4(49)= std_logic_vector(to_unsigned( 189 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 189 found " & integer'image(to_integer(unsigned(RAM4(49))))  severity failure;
    assert RAM4(50)= std_logic_vector(to_unsigned( 178 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 178 found " & integer'image(to_integer(unsigned(RAM4(50))))  severity failure;
    assert RAM4(51)= std_logic_vector(to_unsigned( 163 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 163 found " & integer'image(to_integer(unsigned(RAM4(51))))  severity failure;
    assert RAM4(52)= std_logic_vector(to_unsigned( 21 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 21 found " & integer'image(to_integer(unsigned(RAM4(52))))  severity failure;
    assert RAM4(53)= std_logic_vector(to_unsigned( 6 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 6 found " & integer'image(to_integer(unsigned(RAM4(53))))  severity failure;
    assert RAM4(54)= std_logic_vector(to_unsigned( 240 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 240 found " & integer'image(to_integer(unsigned(RAM4(54))))  severity failure;
    assert RAM4(55)= std_logic_vector(to_unsigned( 7 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 7 found " & integer'image(to_integer(unsigned(RAM4(55))))  severity failure;
    assert RAM4(56)= std_logic_vector(to_unsigned( 231 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 231 found " & integer'image(to_integer(unsigned(RAM4(56))))  severity failure;
    assert RAM4(57)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM4(57))))  severity failure;
    assert RAM4(58)= std_logic_vector(to_unsigned( 6 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 6 found " & integer'image(to_integer(unsigned(RAM4(58))))  severity failure;
    assert RAM4(59)= std_logic_vector(to_unsigned( 6 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 6 found " & integer'image(to_integer(unsigned(RAM4(59))))  severity failure;
    assert RAM4(60)= std_logic_vector(to_unsigned( 5 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 5 found " & integer'image(to_integer(unsigned(RAM4(60))))  severity failure;
    assert RAM4(61)= std_logic_vector(to_unsigned( 10 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 10 found " & integer'image(to_integer(unsigned(RAM4(61))))  severity failure;
    assert RAM4(62)= std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM4(62))))  severity failure;
    assert RAM4(63)= std_logic_vector(to_unsigned( 57 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 57 found " & integer'image(to_integer(unsigned(RAM4(63))))  severity failure;
    assert RAM4(64)= std_logic_vector(to_unsigned( 91 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 91 found " & integer'image(to_integer(unsigned(RAM4(64))))  severity failure;
    assert RAM4(65)= std_logic_vector(to_unsigned( 32 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 32 found " & integer'image(to_integer(unsigned(RAM4(65))))  severity failure;
    --RAM5
    assert RAM5(38) = std_logic_vector(to_unsigned( 170 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 170 found " & integer'image(to_integer(unsigned(RAM5(38))))  severity failure;
    assert RAM5(39) = std_logic_vector(to_unsigned( 64 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 64 found " & integer'image(to_integer(unsigned(RAM5(39))))  severity failure;
    assert RAM5(40) = std_logic_vector(to_unsigned( 14 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 14 found " & integer'image(to_integer(unsigned(RAM5(40))))  severity failure;
    assert RAM5(41) = std_logic_vector(to_unsigned( 108 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 108  found " & integer'image(to_integer(unsigned(RAM5(41))))  severity failure;
    assert RAM5(42) = std_logic_vector(to_unsigned( 12 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 12  found " & integer'image(to_integer(unsigned(RAM5(42))))  severity failure;
    assert RAM5(43) = std_logic_vector(to_unsigned( 134 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 134  found " & integer'image(to_integer(unsigned(RAM5(43))))  severity failure;
    assert RAM5(44) = std_logic_vector(to_unsigned( 114 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 114  found " & integer'image(to_integer(unsigned(RAM5(44))))  severity failure;
    assert RAM5(45) = std_logic_vector(to_unsigned( 94 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 94  found " & integer'image(to_integer(unsigned(RAM5(45))))  severity failure;
    assert RAM5(46) = std_logic_vector(to_unsigned( 254 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 254  found " & integer'image(to_integer(unsigned(RAM5(46))))  severity failure;
    assert RAM5(47) = std_logic_vector(to_unsigned( 252 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 252  found " & integer'image(to_integer(unsigned(RAM5(47))))  severity failure;
    assert RAM5(48) = std_logic_vector(to_unsigned( 214 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 214  found " & integer'image(to_integer(unsigned(RAM5(48))))  severity failure;
    assert RAM5(49) = std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 0  found " & integer'image(to_integer(unsigned(RAM5(49))))  severity failure;
    assert RAM5(50) = std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255  found " & integer'image(to_integer(unsigned(RAM5(50))))  severity failure;
    assert RAM5(51) = std_logic_vector(to_unsigned( 112 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 112  found " & integer'image(to_integer(unsigned(RAM5(51))))  severity failure;
    assert RAM5(52) = std_logic_vector(to_unsigned( 94 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 94  found " & integer'image(to_integer(unsigned(RAM5(52))))  severity failure;
    assert RAM5(53) = std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255  found " & integer'image(to_integer(unsigned(RAM5(53))))  severity failure;
    assert RAM5(54) = std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255  found " & integer'image(to_integer(unsigned(RAM5(54))))  severity failure;
    assert RAM5(55) = std_logic_vector(to_unsigned( 240 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 240  found " & integer'image(to_integer(unsigned(RAM5(55))))  severity failure;
    assert RAM5(56) = std_logic_vector(to_unsigned( 14 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 14  found " & integer'image(to_integer(unsigned(RAM5(56))))  severity failure;
    assert RAM5(57) = std_logic_vector(to_unsigned( 74 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 74  found " & integer'image(to_integer(unsigned(RAM5(57))))  severity failure;
    assert RAM5(58) = std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255  found " & integer'image(to_integer(unsigned(RAM5(58))))  severity failure;
    assert RAM5(59) = std_logic_vector(to_unsigned( 96 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 96  found " & integer'image(to_integer(unsigned(RAM5(59))))  severity failure;
    assert RAM5(60) = std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255  found " & integer'image(to_integer(unsigned(RAM5(60))))  severity failure;
    assert RAM5(61) = std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255  found " & integer'image(to_integer(unsigned(RAM5(61))))  severity failure;
    assert RAM5(62) = std_logic_vector(to_unsigned( 128 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 128  found " & integer'image(to_integer(unsigned(RAM5(62))))  severity failure;
    assert RAM5(63) = std_logic_vector(to_unsigned( 86 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 86  found " & integer'image(to_integer(unsigned(RAM5(63))))  severity failure;
    assert RAM5(64) = std_logic_vector(to_unsigned( 12 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 12  found " & integer'image(to_integer(unsigned(RAM5(64))))  severity failure;
    assert RAM5(65) = std_logic_vector(to_unsigned( 50 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 50  found " & integer'image(to_integer(unsigned(RAM5(65))))  severity failure;
    assert RAM5(66) = std_logic_vector(to_unsigned( 66 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 66  found " & integer'image(to_integer(unsigned(RAM5(66))))  severity failure;
    assert RAM5(67) = std_logic_vector(to_unsigned( 156 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 156  found " & integer'image(to_integer(unsigned(RAM5(67))))  severity failure;
    assert RAM5(68) = std_logic_vector(to_unsigned( 142 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 142  found " & integer'image(to_integer(unsigned(RAM5(68))))  severity failure;
    assert RAM5(69) = std_logic_vector(to_unsigned( 234 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 234  found " & integer'image(to_integer(unsigned(RAM5(69))))  severity failure;
    assert RAM5(70) = std_logic_vector(to_unsigned( 22 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 22  found " & integer'image(to_integer(unsigned(RAM5(70))))  severity failure;
    assert RAM5(71) = std_logic_vector(to_unsigned( 28 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 28  found " & integer'image(to_integer(unsigned(RAM5(71))))  severity failure;
    assert RAM5(72) = std_logic_vector(to_unsigned( 60 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 60  found " & integer'image(to_integer(unsigned(RAM5(72))))  severity failure;
    assert RAM5(73) = std_logic_vector(to_unsigned( 104 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 104  found " & integer'image(to_integer(unsigned(RAM5(73))))  severity failure;
    --RAM6
    assert RAM6(6) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM6(6))))  severity failure; 
	assert RAM6(7) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM6(7))))  severity failure; 
	assert RAM6(8) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM6(8))))  severity failure; 
	assert RAM6(9) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM6(9))))  severity failure;
    --RAM7
--    assert RAM7(6) = std_logic_vector(to_unsigned( 128 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM2(6))))  severity failure; 
--	assert RAM7(7) = std_logic_vector(to_unsigned( 128 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM2(7))))  severity failure; 
--	assert RAM7(8) = std_logic_vector(to_unsigned( 128 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  128  found " & integer'image(to_integer(unsigned(RAM2(8))))  severity failure; 
--	assert RAM7(9) = std_logic_vector(to_unsigned( 0 , 8)) report " TEST FALLITO (WORKING ZONE). Expected  0  found " & integer'image(to_integer(unsigned(RAM2(9))))  severity failure;
	
	assert RAM7(258)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(258))))  severity failure;
    assert RAM7(259)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(259))))  severity failure;
    assert RAM7(260)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(260))))  severity failure;
    assert RAM7(261)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(261))))  severity failure;
    assert RAM7(262)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(262))))  severity failure;
    assert RAM7(263)= std_logic_vector(to_unsigned( 116 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 116 found " & integer'image(to_integer(unsigned(RAM(263))))  severity failure;
    assert RAM7(264)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(264))))  severity failure;
    assert RAM7(265)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(265))))  severity failure;
    assert RAM7(266)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(266))))  severity failure;
    assert RAM7(267)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(267))))  severity failure;
    assert RAM7(268)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(268))))  severity failure;
    assert RAM7(269)= std_logic_vector(to_unsigned( 148 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 148 found " & integer'image(to_integer(unsigned(RAM(269))))  severity failure;
    assert RAM7(270)= std_logic_vector(to_unsigned( 38 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 38 found " & integer'image(to_integer(unsigned(RAM(270))))  severity failure;
    assert RAM7(271)= std_logic_vector(to_unsigned( 42 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 42 found " & integer'image(to_integer(unsigned(RAM(271))))  severity failure;
    assert RAM7(272)= std_logic_vector(to_unsigned( 52 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 52 found " & integer'image(to_integer(unsigned(RAM(272))))  severity failure;
    assert RAM7(273)= std_logic_vector(to_unsigned( 216 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 216 found " & integer'image(to_integer(unsigned(RAM(273))))  severity failure;
    assert RAM7(274)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(274))))  severity failure;
    assert RAM7(275)= std_logic_vector(to_unsigned( 112 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 112 found " & integer'image(to_integer(unsigned(RAM(275))))  severity failure;
    assert RAM7(276)= std_logic_vector(to_unsigned( 140 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 140 found " & integer'image(to_integer(unsigned(RAM(276))))  severity failure;
    assert RAM7(277)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(277))))  severity failure;
    assert RAM7(278)= std_logic_vector(to_unsigned( 190 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 190 found " & integer'image(to_integer(unsigned(RAM(278))))  severity failure;
    assert RAM7(279)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(279))))  severity failure;
    assert RAM7(280)= std_logic_vector(to_unsigned( 72 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 72 found " & integer'image(to_integer(unsigned(RAM(280))))  severity failure;
    assert RAM7(281)= std_logic_vector(to_unsigned( 60 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 60 found " & integer'image(to_integer(unsigned(RAM(281))))  severity failure;
    assert RAM7(282)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(282))))  severity failure;
    assert RAM7(283)= std_logic_vector(to_unsigned( 172 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 172 found " & integer'image(to_integer(unsigned(RAM(283))))  severity failure;
    assert RAM7(284)= std_logic_vector(to_unsigned( 52 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 52 found " & integer'image(to_integer(unsigned(RAM(284))))  severity failure;
    assert RAM7(285)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(285))))  severity failure;
    assert RAM7(286)= std_logic_vector(to_unsigned( 112 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 112 found " & integer'image(to_integer(unsigned(RAM(286))))  severity failure;
    assert RAM7(287)= std_logic_vector(to_unsigned( 68 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 68 found " & integer'image(to_integer(unsigned(RAM(287))))  severity failure;
    assert RAM7(288)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(288))))  severity failure;
    assert RAM7(289)= std_logic_vector(to_unsigned( 72 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 72 found " & integer'image(to_integer(unsigned(RAM(289))))  severity failure;
    assert RAM7(290)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(290))))  severity failure;
    assert RAM7(291)= std_logic_vector(to_unsigned( 164 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 164 found " & integer'image(to_integer(unsigned(RAM(291))))  severity failure;
    assert RAM7(292)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(292))))  severity failure;
    assert RAM7(293)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(293))))  severity failure;
    assert RAM7(294)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(294))))  severity failure;
    assert RAM7(295)= std_logic_vector(to_unsigned( 156 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 156 found " & integer'image(to_integer(unsigned(RAM(295))))  severity failure;
    assert RAM7(296)= std_logic_vector(to_unsigned( 22 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 22 found " & integer'image(to_integer(unsigned(RAM(296))))  severity failure;
    assert RAM7(297)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(297))))  severity failure;
    assert RAM7(298)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(298))))  severity failure;
    assert RAM7(299)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(299))))  severity failure;
    assert RAM7(300)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(300))))  severity failure;
    assert RAM7(301)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(301))))  severity failure;
    assert RAM7(302)= std_logic_vector(to_unsigned( 132 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 132 found " & integer'image(to_integer(unsigned(RAM(302))))  severity failure;
    assert RAM7(303)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(303))))  severity failure;
    assert RAM7(304)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(304))))  severity failure;
    assert RAM7(305)= std_logic_vector(to_unsigned( 48 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 48 found " & integer'image(to_integer(unsigned(RAM(305))))  severity failure;
    assert RAM7(306)= std_logic_vector(to_unsigned( 180 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 180 found " & integer'image(to_integer(unsigned(RAM(306))))  severity failure;
    assert RAM7(307)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(307))))  severity failure;
    assert RAM7(308)= std_logic_vector(to_unsigned( 164 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 164 found " & integer'image(to_integer(unsigned(RAM(308))))  severity failure;
    assert RAM7(309)= std_logic_vector(to_unsigned( 104 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 104 found " & integer'image(to_integer(unsigned(RAM(309))))  severity failure;
    assert RAM7(310)= std_logic_vector(to_unsigned( 184 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 184 found " & integer'image(to_integer(unsigned(RAM(310))))  severity failure;
    assert RAM7(311)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(311))))  severity failure;
    assert RAM7(312)= std_logic_vector(to_unsigned( 100 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 100 found " & integer'image(to_integer(unsigned(RAM(312))))  severity failure;
    assert RAM7(313)= std_logic_vector(to_unsigned( 188 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 188 found " & integer'image(to_integer(unsigned(RAM(313))))  severity failure;
    assert RAM7(314)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(314))))  severity failure;
    assert RAM7(315)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(315))))  severity failure;
    assert RAM7(316)= std_logic_vector(to_unsigned( 118 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 118 found " & integer'image(to_integer(unsigned(RAM(316))))  severity failure;
    assert RAM7(317)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(317))))  severity failure;
    assert RAM7(318)= std_logic_vector(to_unsigned( 52 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 52 found " & integer'image(to_integer(unsigned(RAM(318))))  severity failure;
    assert RAM7(319)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(319))))  severity failure;
    assert RAM7(320)= std_logic_vector(to_unsigned( 136 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 136 found " & integer'image(to_integer(unsigned(RAM(320))))  severity failure;
    assert RAM7(321)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(321))))  severity failure;
    assert RAM7(322)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(322))))  severity failure;
    assert RAM7(323)= std_logic_vector(to_unsigned( 98 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 98 found " & integer'image(to_integer(unsigned(RAM(323))))  severity failure;
    assert RAM7(324)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(324))))  severity failure;
    assert RAM7(325)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(325))))  severity failure;
    assert RAM7(326)= std_logic_vector(to_unsigned( 132 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 132 found " & integer'image(to_integer(unsigned(RAM(326))))  severity failure;
    assert RAM7(327)= std_logic_vector(to_unsigned( 232 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 232 found " & integer'image(to_integer(unsigned(RAM(327))))  severity failure;
    assert RAM7(328)= std_logic_vector(to_unsigned( 174 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 174 found " & integer'image(to_integer(unsigned(RAM(328))))  severity failure;
    assert RAM7(329)= std_logic_vector(to_unsigned( 186 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 186 found " & integer'image(to_integer(unsigned(RAM(329))))  severity failure;
    assert RAM7(330)= std_logic_vector(to_unsigned( 148 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 148 found " & integer'image(to_integer(unsigned(RAM(330))))  severity failure;
    assert RAM7(331)= std_logic_vector(to_unsigned( 168 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 168 found " & integer'image(to_integer(unsigned(RAM(331))))  severity failure;
    assert RAM7(332)= std_logic_vector(to_unsigned( 0 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(332))))  severity failure;
    assert RAM7(333)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(333))))  severity failure;
    assert RAM7(334)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(334))))  severity failure;
    assert RAM7(335)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(335))))  severity failure;
    assert RAM7(336)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(336))))  severity failure;
    assert RAM7(337)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(337))))  severity failure;
    assert RAM7(338)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(338))))  severity failure;
    assert RAM7(339)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(339))))  severity failure;
    assert RAM7(340)= std_logic_vector(to_unsigned( 212 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 212 found " & integer'image(to_integer(unsigned(RAM(340))))  severity failure;
    assert RAM7(341)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(341))))  severity failure;
    assert RAM7(342)= std_logic_vector(to_unsigned( 138 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 138 found " & integer'image(to_integer(unsigned(RAM(342))))  severity failure;
    assert RAM7(343)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(343))))  severity failure;
    assert RAM7(344)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(344))))  severity failure;
    assert RAM7(345)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(345))))  severity failure;
    assert RAM7(346)= std_logic_vector(to_unsigned( 28 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 28 found " & integer'image(to_integer(unsigned(RAM(346))))  severity failure;
    assert RAM7(347)= std_logic_vector(to_unsigned( 82 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 82 found " & integer'image(to_integer(unsigned(RAM(347))))  severity failure;
    assert RAM7(348)= std_logic_vector(to_unsigned( 244 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 244 found " & integer'image(to_integer(unsigned(RAM(348))))  severity failure;
    assert RAM7(349)= std_logic_vector(to_unsigned( 208 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 208 found " & integer'image(to_integer(unsigned(RAM(349))))  severity failure;
    assert RAM7(350)= std_logic_vector(to_unsigned( 34 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 34 found " & integer'image(to_integer(unsigned(RAM(350))))  severity failure;
    assert RAM7(351)= std_logic_vector(to_unsigned( 202 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 202 found " & integer'image(to_integer(unsigned(RAM(351))))  severity failure;
    assert RAM7(352)= std_logic_vector(to_unsigned( 190 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 190 found " & integer'image(to_integer(unsigned(RAM(352))))  severity failure;
    assert RAM7(353)= std_logic_vector(to_unsigned( 102 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 102 found " & integer'image(to_integer(unsigned(RAM(353))))  severity failure;
    assert RAM7(354)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(354))))  severity failure;
    assert RAM7(355)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(355))))  severity failure;
    assert RAM7(356)= std_logic_vector(to_unsigned( 132 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 132 found " & integer'image(to_integer(unsigned(RAM(356))))  severity failure;
    assert RAM7(357)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(357))))  severity failure;
    assert RAM7(358)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(358))))  severity failure;
    assert RAM7(359)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(359))))  severity failure;
    assert RAM7(360)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(360))))  severity failure;
    assert RAM7(361)= std_logic_vector(to_unsigned( 250 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 250 found " & integer'image(to_integer(unsigned(RAM(361))))  severity failure;
    assert RAM7(362)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(362))))  severity failure;
    assert RAM7(363)= std_logic_vector(to_unsigned( 192 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 192 found " & integer'image(to_integer(unsigned(RAM(363))))  severity failure;
    assert RAM7(364)= std_logic_vector(to_unsigned( 6 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 6 found " & integer'image(to_integer(unsigned(RAM(364))))  severity failure;
    assert RAM7(365)= std_logic_vector(to_unsigned( 240 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 240 found " & integer'image(to_integer(unsigned(RAM(365))))  severity failure;
    assert RAM7(366)= std_logic_vector(to_unsigned( 156 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 156 found " & integer'image(to_integer(unsigned(RAM(366))))  severity failure;
    assert RAM7(367)= std_logic_vector(to_unsigned( 230 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 230 found " & integer'image(to_integer(unsigned(RAM(367))))  severity failure;
    assert RAM7(368)= std_logic_vector(to_unsigned( 192 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 192 found " & integer'image(to_integer(unsigned(RAM(368))))  severity failure;
    assert RAM7(369)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(369))))  severity failure;
    assert RAM7(370)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(370))))  severity failure;
    assert RAM7(371)= std_logic_vector(to_unsigned( 144 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 144 found " & integer'image(to_integer(unsigned(RAM(371))))  severity failure;
    assert RAM7(372)= std_logic_vector(to_unsigned( 228 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 228 found " & integer'image(to_integer(unsigned(RAM(372))))  severity failure;
    assert RAM7(373)= std_logic_vector(to_unsigned( 2 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 2 found " & integer'image(to_integer(unsigned(RAM(373))))  severity failure;
    assert RAM7(374)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(374))))  severity failure;
    assert RAM7(375)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(375))))  severity failure;
    assert RAM7(376)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(376))))  severity failure;
    assert RAM7(377)= std_logic_vector(to_unsigned( 110 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 110 found " & integer'image(to_integer(unsigned(RAM(377))))  severity failure;
    assert RAM7(378)= std_logic_vector(to_unsigned( 92 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 92 found " & integer'image(to_integer(unsigned(RAM(378))))  severity failure;
    assert RAM7(379)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(379))))  severity failure;
    assert RAM7(380)= std_logic_vector(to_unsigned( 26 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 26 found " & integer'image(to_integer(unsigned(RAM(380))))  severity failure;
    assert RAM7(381)= std_logic_vector(to_unsigned( 162 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 162 found " & integer'image(to_integer(unsigned(RAM(381))))  severity failure;
    assert RAM7(382)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(382))))  severity failure;
    assert RAM7(383)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(383))))  severity failure;
    assert RAM7(384)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(384))))  severity failure;
    assert RAM7(385)= std_logic_vector(to_unsigned( 26 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 26 found " & integer'image(to_integer(unsigned(RAM(385))))  severity failure;
    assert RAM7(386)= std_logic_vector(to_unsigned( 178 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 178 found " & integer'image(to_integer(unsigned(RAM(386))))  severity failure;
    assert RAM7(387)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(387))))  severity failure;
    assert RAM7(388)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(388))))  severity failure;
    assert RAM7(389)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(389))))  severity failure;
    assert RAM7(390)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(390))))  severity failure;
    assert RAM7(391)= std_logic_vector(to_unsigned( 58 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 58 found " & integer'image(to_integer(unsigned(RAM(391))))  severity failure;
    assert RAM7(392)= std_logic_vector(to_unsigned( 208 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 208 found " & integer'image(to_integer(unsigned(RAM(392))))  severity failure;
    assert RAM7(393)= std_logic_vector(to_unsigned( 174 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 174 found " & integer'image(to_integer(unsigned(RAM(393))))  severity failure;
    assert RAM7(394)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(394))))  severity failure;
    assert RAM7(395)= std_logic_vector(to_unsigned( 138 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 138 found " & integer'image(to_integer(unsigned(RAM(395))))  severity failure;
    assert RAM7(396)= std_logic_vector(to_unsigned( 166 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 166 found " & integer'image(to_integer(unsigned(RAM(396))))  severity failure;
    assert RAM7(397)= std_logic_vector(to_unsigned( 36 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 36 found " & integer'image(to_integer(unsigned(RAM(397))))  severity failure;
    assert RAM7(398)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(398))))  severity failure;
    assert RAM7(399)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(399))))  severity failure;
    assert RAM7(400)= std_logic_vector(to_unsigned( 90 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 90 found " & integer'image(to_integer(unsigned(RAM(400))))  severity failure;
    assert RAM7(401)= std_logic_vector(to_unsigned( 202 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 202 found " & integer'image(to_integer(unsigned(RAM(401))))  severity failure;
    assert RAM7(402)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(402))))  severity failure;
    assert RAM7(403)= std_logic_vector(to_unsigned( 68 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 68 found " & integer'image(to_integer(unsigned(RAM(403))))  severity failure;
    assert RAM7(404)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(404))))  severity failure;
    assert RAM7(405)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(405))))  severity failure;
    assert RAM7(406)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(406))))  severity failure;
    assert RAM7(407)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(407))))  severity failure;
    assert RAM7(408)= std_logic_vector(to_unsigned( 188 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 188 found " & integer'image(to_integer(unsigned(RAM(408))))  severity failure;
    assert RAM7(409)= std_logic_vector(to_unsigned( 244 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 244 found " & integer'image(to_integer(unsigned(RAM(409))))  severity failure;
    assert RAM7(410)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(410))))  severity failure;
    assert RAM7(411)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(411))))  severity failure;
    assert RAM7(412)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(412))))  severity failure;
    assert RAM7(413)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(413))))  severity failure;
    assert RAM7(414)= std_logic_vector(to_unsigned( 230 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 230 found " & integer'image(to_integer(unsigned(RAM(414))))  severity failure;
    assert RAM7(415)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(415))))  severity failure;
    assert RAM7(416)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(416))))  severity failure;
    assert RAM7(417)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(417))))  severity failure;
    assert RAM7(418)= std_logic_vector(to_unsigned( 130 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 130 found " & integer'image(to_integer(unsigned(RAM(418))))  severity failure;
    assert RAM7(419)= std_logic_vector(to_unsigned( 40 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 40 found " & integer'image(to_integer(unsigned(RAM(419))))  severity failure;
    assert RAM7(420)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(420))))  severity failure;
    assert RAM7(421)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(421))))  severity failure;
    assert RAM7(422)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(422))))  severity failure;
    assert RAM7(423)= std_logic_vector(to_unsigned( 64 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 64 found " & integer'image(to_integer(unsigned(RAM(423))))  severity failure;
    assert RAM7(424)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(424))))  severity failure;
    assert RAM7(425)= std_logic_vector(to_unsigned( 238 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 238 found " & integer'image(to_integer(unsigned(RAM(425))))  severity failure;
    assert RAM7(426)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(426))))  severity failure;
    assert RAM7(427)= std_logic_vector(to_unsigned( 194 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 194 found " & integer'image(to_integer(unsigned(RAM(427))))  severity failure;
    assert RAM7(428)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(428))))  severity failure;
    assert RAM7(429)= std_logic_vector(to_unsigned( 76 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 76 found " & integer'image(to_integer(unsigned(RAM(429))))  severity failure;
    assert RAM7(430)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(430))))  severity failure;
    assert RAM7(431)= std_logic_vector(to_unsigned( 86 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 86 found " & integer'image(to_integer(unsigned(RAM(431))))  severity failure;
    assert RAM7(432)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(432))))  severity failure;
    assert RAM7(433)= std_logic_vector(to_unsigned( 8 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 8 found " & integer'image(to_integer(unsigned(RAM(433))))  severity failure;
    assert RAM7(434)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(434))))  severity failure;
    assert RAM7(435)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(435))))  severity failure;
    assert RAM7(436)= std_logic_vector(to_unsigned( 112 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 112 found " & integer'image(to_integer(unsigned(RAM(436))))  severity failure;
    assert RAM7(437)= std_logic_vector(to_unsigned( 112 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 112 found " & integer'image(to_integer(unsigned(RAM(437))))  severity failure;
    assert RAM7(438)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(438))))  severity failure;
    assert RAM7(439)= std_logic_vector(to_unsigned( 62 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 62 found " & integer'image(to_integer(unsigned(RAM(439))))  severity failure;
    assert RAM7(440)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(440))))  severity failure;
    assert RAM7(441)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(441))))  severity failure;
    assert RAM7(442)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(442))))  severity failure;
    assert RAM7(443)= std_logic_vector(to_unsigned( 126 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 126 found " & integer'image(to_integer(unsigned(RAM(443))))  severity failure;
    assert RAM7(444)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(444))))  severity failure;
    assert RAM7(445)= std_logic_vector(to_unsigned( 160 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 160 found " & integer'image(to_integer(unsigned(RAM(445))))  severity failure;
    assert RAM7(446)= std_logic_vector(to_unsigned( 120 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 120 found " & integer'image(to_integer(unsigned(RAM(446))))  severity failure;
    assert RAM7(447)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(447))))  severity failure;
    assert RAM7(448)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(448))))  severity failure;
    assert RAM7(449)= std_logic_vector(to_unsigned( 68 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 68 found " & integer'image(to_integer(unsigned(RAM(449))))  severity failure;
    assert RAM7(450)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(450))))  severity failure;
    assert RAM7(451)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(451))))  severity failure;
    assert RAM7(452)= std_logic_vector(to_unsigned( 110 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 110 found " & integer'image(to_integer(unsigned(RAM(452))))  severity failure;
    assert RAM7(453)= std_logic_vector(to_unsigned( 250 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 250 found " & integer'image(to_integer(unsigned(RAM(453))))  severity failure;
    assert RAM7(454)= std_logic_vector(to_unsigned( 140 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 140 found " & integer'image(to_integer(unsigned(RAM(454))))  severity failure;
    assert RAM7(455)= std_logic_vector(to_unsigned( 24 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 24 found " & integer'image(to_integer(unsigned(RAM(455))))  severity failure;
    assert RAM7(456)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(456))))  severity failure;
    assert RAM7(457)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(457))))  severity failure;
    assert RAM7(458)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(458))))  severity failure;
    assert RAM7(459)= std_logic_vector(to_unsigned( 226 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 226 found " & integer'image(to_integer(unsigned(RAM(459))))  severity failure;
    assert RAM7(460)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(460))))  severity failure;
    assert RAM7(461)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(461))))  severity failure;
    assert RAM7(462)= std_logic_vector(to_unsigned( 112 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 112 found " & integer'image(to_integer(unsigned(RAM(462))))  severity failure;
    assert RAM7(463)= std_logic_vector(to_unsigned( 86 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 86 found " & integer'image(to_integer(unsigned(RAM(463))))  severity failure;
    assert RAM7(464)= std_logic_vector(to_unsigned( 112 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 112 found " & integer'image(to_integer(unsigned(RAM(464))))  severity failure;
    assert RAM7(465)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(465))))  severity failure;
    assert RAM7(466)= std_logic_vector(to_unsigned( 34 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 34 found " & integer'image(to_integer(unsigned(RAM(466))))  severity failure;
    assert RAM7(467)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(467))))  severity failure;
    assert RAM7(468)= std_logic_vector(to_unsigned( 32 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 32 found " & integer'image(to_integer(unsigned(RAM(468))))  severity failure;
    assert RAM7(469)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(469))))  severity failure;
    assert RAM7(470)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(470))))  severity failure;
    assert RAM7(471)= std_logic_vector(to_unsigned( 24 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 24 found " & integer'image(to_integer(unsigned(RAM(471))))  severity failure;
    assert RAM7(472)= std_logic_vector(to_unsigned( 176 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 176 found " & integer'image(to_integer(unsigned(RAM(472))))  severity failure;
    assert RAM7(473)= std_logic_vector(to_unsigned( 250 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 250 found " & integer'image(to_integer(unsigned(RAM(473))))  severity failure;
    assert RAM7(474)= std_logic_vector(to_unsigned( 2 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 2 found " & integer'image(to_integer(unsigned(RAM(474))))  severity failure;
    assert RAM7(475)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(475))))  severity failure;
    assert RAM7(476)= std_logic_vector(to_unsigned( 238 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 238 found " & integer'image(to_integer(unsigned(RAM(476))))  severity failure;
    assert RAM7(477)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(477))))  severity failure;
    assert RAM7(478)= std_logic_vector(to_unsigned( 112 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 112 found " & integer'image(to_integer(unsigned(RAM(478))))  severity failure;
    assert RAM7(479)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(479))))  severity failure;
    assert RAM7(480)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(480))))  severity failure;
    assert RAM7(481)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(481))))  severity failure;
    assert RAM7(482)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(482))))  severity failure;
    assert RAM7(483)= std_logic_vector(to_unsigned( 120 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 120 found " & integer'image(to_integer(unsigned(RAM(483))))  severity failure;
    assert RAM7(484)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(484))))  severity failure;
    assert RAM7(485)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(485))))  severity failure;
    assert RAM7(486)= std_logic_vector(to_unsigned( 68 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 68 found " & integer'image(to_integer(unsigned(RAM(486))))  severity failure;
    assert RAM7(487)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(487))))  severity failure;
    assert RAM7(488)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(488))))  severity failure;
    assert RAM7(489)= std_logic_vector(to_unsigned( 24 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 24 found " & integer'image(to_integer(unsigned(RAM(489))))  severity failure;
    assert RAM7(490)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(490))))  severity failure;
    assert RAM7(491)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(491))))  severity failure;
    assert RAM7(492)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(492))))  severity failure;
    assert RAM7(493)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(493))))  severity failure;
    assert RAM7(494)= std_logic_vector(to_unsigned( 78 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 78 found " & integer'image(to_integer(unsigned(RAM(494))))  severity failure;
    assert RAM7(495)= std_logic_vector(to_unsigned( 132 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 132 found " & integer'image(to_integer(unsigned(RAM(495))))  severity failure;
    assert RAM7(496)= std_logic_vector(to_unsigned( 126 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 126 found " & integer'image(to_integer(unsigned(RAM(496))))  severity failure;
    assert RAM7(497)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(497))))  severity failure;
    assert RAM7(498)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(498))))  severity failure;
    assert RAM7(499)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(499))))  severity failure;
    assert RAM7(500)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(500))))  severity failure;
    assert RAM7(501)= std_logic_vector(to_unsigned( 6 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 6 found " & integer'image(to_integer(unsigned(RAM(501))))  severity failure;
    assert RAM7(502)= std_logic_vector(to_unsigned( 236 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 236 found " & integer'image(to_integer(unsigned(RAM(502))))  severity failure;
    assert RAM7(503)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(503))))  severity failure;
    assert RAM7(504)= std_logic_vector(to_unsigned( 220 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 220 found " & integer'image(to_integer(unsigned(RAM(504))))  severity failure;
    assert RAM7(505)= std_logic_vector(to_unsigned( 16 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 16 found " & integer'image(to_integer(unsigned(RAM(505))))  severity failure;
    assert RAM7(506)= std_logic_vector(to_unsigned( 218 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 218 found " & integer'image(to_integer(unsigned(RAM(506))))  severity failure;
    assert RAM7(507)= std_logic_vector(to_unsigned( 86 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 86 found " & integer'image(to_integer(unsigned(RAM(507))))  severity failure;
    assert RAM7(508)= std_logic_vector(to_unsigned( 214 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 214 found " & integer'image(to_integer(unsigned(RAM(508))))  severity failure;
    assert RAM7(509)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(509))))  severity failure;
    assert RAM7(510)= std_logic_vector(to_unsigned( 214 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 214 found " & integer'image(to_integer(unsigned(RAM(510))))  severity failure;
    assert RAM7(511)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(511))))  severity failure;
    assert RAM7(512)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(512))))  severity failure;
    assert RAM7(513)= std_logic_vector(to_unsigned( 255 , 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(513))))  severity failure;

	
    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;

end projecttb; 


