LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

USE work.param_pkg.all;

ENTITY mbe_mul IS
    PORT(
        A : IN UNSIGNED(32-1 DOWNTO 0);
        B : IN UNSIGNED(32-1 DOWNTO 0);
        P : OUT UNSIGNED(2*32-1 DOWNTO 0)
        );
END ENTITY;

ARCHITECTURE structure OF mbe_mul IS

    COMPONENT half_adder
        PORT(
            A     : IN STD_LOGIC;
            B     : IN STD_LOGIC;
            SUM   : OUT STD_LOGIC;
            C_OUT : OUT STD_LOGIC
            );				
    END COMPONENT;
    
    COMPONENT full_adder
        PORT(
            A     : IN STD_LOGIC;
            B     : IN STD_LOGIC;
            C_IN  : IN STD_LOGIC;
            SUM   : OUT STD_LOGIC;
            C_OUT : OUT STD_LOGIC
            );				
    END COMPONENT;
    
    COMPONENT parprod_gen
        PORT(
            A  : IN UNSIGNED(32-1 DOWNTO 0);
            B  : IN UNSIGNED(32-1 DOWNTO 0);
            PP : OUT PARTIAL_PRODUCTS
            );
    END COMPONENT;
    
    SIGNAL FA_out, FA_carry : STD_LOGIC_VECTOR(541 DOWNTO 0);
    SIGNAL HA_out, HA_carry : STD_LOGIC_VECTOR(45 DOWNTO 0);
    
    SIGNAL parprod : PARTIAL_PRODUCTS;
    
    BEGIN
    
        parprod_gen : parprod_gen
            PORT MAP(
                A  => A,
                B  => B,
                PP => parprod);

        FA_0 : full_adder
            PORT MAP(
                A     => parprod(1)(26),
                B     => parprod(2)(24),
                C_IN  => parprod(3)(22),
                SUM   => FA_out(0),
                C_OUT => FA_carry(0));

        FA_1 : full_adder
            PORT MAP(
                A     => parprod(0)(27),
                B     => parprod(1)(27),
                C_IN  => parprod(2)(25),
                SUM   => FA_out(1),
                C_OUT => FA_carry(1));

        FA_2 : full_adder
            PORT MAP(
                A     => parprod(0)(28),
                B     => parprod(1)(28),
                C_IN  => parprod(2)(26),
                SUM   => FA_out(2),
                C_OUT => FA_carry(2));

        FA_3 : full_adder
            PORT MAP(
                A     => parprod(3)(24),
                B     => parprod(4)(22),
                C_IN  => parprod(5)(20),
                SUM   => FA_out(3),
                C_OUT => FA_carry(3));

        FA_4 : full_adder
            PORT MAP(
                A     => HA_carry(4),
                B     => parprod(0)(29),
                C_IN  => parprod(1)(29),
                SUM   => FA_out(4),
                C_OUT => FA_carry(4));

        FA_5 : full_adder
            PORT MAP(
                A     => parprod(2)(27),
                B     => parprod(3)(25),
                C_IN  => parprod(4)(23),
                SUM   => FA_out(5),
                C_OUT => FA_carry(5));

        FA_6 : full_adder
            PORT MAP(
                A     => HA_carry(5),
                B     => parprod(0)(30),
                C_IN  => parprod(1)(30),
                SUM   => FA_out(6),
                C_OUT => FA_carry(6));

        FA_7 : full_adder
            PORT MAP(
                A     => parprod(2)(28),
                B     => parprod(3)(26),
                C_IN  => parprod(4)(24),
                SUM   => FA_out(7),
                C_OUT => FA_carry(7));

        FA_8 : full_adder
            PORT MAP(
                A     => parprod(5)(22),
                B     => parprod(6)(20),
                C_IN  => parprod(7)(18),
                SUM   => FA_out(8),
                C_OUT => FA_carry(8));

        FA_9 : full_adder
            PORT MAP(
                A     => FA_carry(6),
                B     => HA_carry(6),
                C_IN  => parprod(0)(31),
                SUM   => FA_out(9),
                C_OUT => FA_carry(9));

        FA_10 : full_adder
            PORT MAP(
                A     => parprod(1)(31),
                B     => parprod(2)(29),
                C_IN  => parprod(3)(27),
                SUM   => FA_out(10),
                C_OUT => FA_carry(10));

        FA_11 : full_adder
            PORT MAP(
                A     => parprod(4)(25),
                B     => parprod(5)(23),
                C_IN  => parprod(6)(21),
                SUM   => FA_out(11),
                C_OUT => FA_carry(11));

        FA_12 : full_adder
            PORT MAP(
                A     => FA_carry(11),
                B     => FA_carry(10),
                C_IN  => FA_carry(9),
                SUM   => FA_out(12),
                C_OUT => FA_carry(12));

        FA_13 : full_adder
            PORT MAP(
                A     => HA_carry(7),
                B     => parprod(0)(32),
                C_IN  => parprod(1)(32),
                SUM   => FA_out(13),
                C_OUT => FA_carry(13));

        FA_14 : full_adder
            PORT MAP(
                A     => parprod(2)(30),
                B     => parprod(3)(28),
                C_IN  => parprod(4)(26),
                SUM   => FA_out(14),
                C_OUT => FA_carry(14));

        FA_15 : full_adder
            PORT MAP(
                A     => parprod(5)(24),
                B     => parprod(6)(22),
                C_IN  => parprod(7)(20),
                SUM   => FA_out(15),
                C_OUT => FA_carry(15));

        FA_16 : full_adder
            PORT MAP(
                A     => FA_carry(15),
                B     => FA_carry(14),
                C_IN  => FA_carry(13),
                SUM   => FA_out(16),
                C_OUT => FA_carry(16));

        FA_17 : full_adder
            PORT MAP(
                A     => FA_carry(12),
                B     => parprod(0)(33),
                C_IN  => parprod(1)(33),
                SUM   => FA_out(17),
                C_OUT => FA_carry(17));

        FA_18 : full_adder
            PORT MAP(
                A     => parprod(2)(31),
                B     => parprod(3)(29),
                C_IN  => parprod(4)(27),
                SUM   => FA_out(18),
                C_OUT => FA_carry(18));

        FA_19 : full_adder
            PORT MAP(
                A     => parprod(5)(25),
                B     => parprod(6)(23),
                C_IN  => parprod(7)(21),
                SUM   => FA_out(19),
                C_OUT => FA_carry(19));

        FA_20 : full_adder
            PORT MAP(
                A     => FA_carry(19),
                B     => FA_carry(18),
                C_IN  => FA_carry(17),
                SUM   => FA_out(20),
                C_OUT => FA_carry(20));

        FA_21 : full_adder
            PORT MAP(
                A     => FA_carry(16),
                B     => parprod(0)(34),
                C_IN  => parprod(1)(34),
                SUM   => FA_out(21),
                C_OUT => FA_carry(21));

        FA_22 : full_adder
            PORT MAP(
                A     => parprod(2)(32),
                B     => parprod(3)(30),
                C_IN  => parprod(4)(28),
                SUM   => FA_out(22),
                C_OUT => FA_carry(22));

        FA_23 : full_adder
            PORT MAP(
                A     => parprod(5)(26),
                B     => parprod(6)(24),
                C_IN  => parprod(7)(22),
                SUM   => FA_out(23),
                C_OUT => FA_carry(23));

        FA_24 : full_adder
            PORT MAP(
                A     => FA_carry(23),
                B     => FA_carry(22),
                C_IN  => FA_carry(21),
                SUM   => FA_out(24),
                C_OUT => FA_carry(24));

        FA_25 : full_adder
            PORT MAP(
                A     => FA_carry(20),
                B     => parprod(0)(35),
                C_IN  => parprod(1)(35),
                SUM   => FA_out(25),
                C_OUT => FA_carry(25));

        FA_26 : full_adder
            PORT MAP(
                A     => parprod(2)(33),
                B     => parprod(3)(31),
                C_IN  => parprod(4)(29),
                SUM   => FA_out(26),
                C_OUT => FA_carry(26));

        FA_27 : full_adder
            PORT MAP(
                A     => parprod(5)(27),
                B     => parprod(6)(25),
                C_IN  => parprod(7)(23),
                SUM   => FA_out(27),
                C_OUT => FA_carry(27));

        FA_28 : full_adder
            PORT MAP(
                A     => FA_carry(25),
                B     => FA_carry(24),
                C_IN  => parprod(1)(36),
                SUM   => FA_out(28),
                C_OUT => FA_carry(28));

        FA_29 : full_adder
            PORT MAP(
                A     => parprod(2)(34),
                B     => parprod(3)(32),
                C_IN  => parprod(4)(30),
                SUM   => FA_out(29),
                C_OUT => FA_carry(29));

        FA_30 : full_adder
            PORT MAP(
                A     => parprod(5)(28),
                B     => parprod(6)(26),
                C_IN  => parprod(7)(24),
                SUM   => FA_out(30),
                C_OUT => FA_carry(30));

        FA_31 : full_adder
            PORT MAP(
                A     => FA_carry(30),
                B     => FA_carry(29),
                C_IN  => FA_carry(28),
                SUM   => FA_out(31),
                C_OUT => FA_carry(31));

        FA_32 : full_adder
            PORT MAP(
                A     => HA_carry(8),
                B     => parprod(2)(35),
                C_IN  => parprod(3)(33),
                SUM   => FA_out(32),
                C_OUT => FA_carry(32));

        FA_33 : full_adder
            PORT MAP(
                A     => parprod(4)(31),
                B     => parprod(5)(29),
                C_IN  => parprod(6)(27),
                SUM   => FA_out(33),
                C_OUT => FA_carry(33));

        FA_34 : full_adder
            PORT MAP(
                A     => FA_carry(31),
                B     => parprod(2)(36),
                C_IN  => parprod(3)(34),
                SUM   => FA_out(34),
                C_OUT => FA_carry(34));

        FA_35 : full_adder
            PORT MAP(
                A     => parprod(4)(32),
                B     => parprod(5)(30),
                C_IN  => parprod(6)(28),
                SUM   => FA_out(35),
                C_OUT => FA_carry(35));

        FA_36 : full_adder
            PORT MAP(
                A     => FA_carry(35),
                B     => FA_carry(34),
                C_IN  => HA_carry(9),
                SUM   => FA_out(36),
                C_OUT => FA_carry(36));

        FA_37 : full_adder
            PORT MAP(
                A     => parprod(3)(35),
                B     => parprod(4)(33),
                C_IN  => parprod(5)(31),
                SUM   => FA_out(37),
                C_OUT => FA_carry(37));

        FA_38 : full_adder
            PORT MAP(
                A     => parprod(3)(36),
                B     => parprod(4)(34),
                C_IN  => parprod(5)(32),
                SUM   => FA_out(38),
                C_OUT => FA_carry(38));

        FA_39 : full_adder
            PORT MAP(
                A     => FA_carry(38),
                B     => HA_carry(10),
                C_IN  => parprod(4)(35),
                SUM   => FA_out(39),
                C_OUT => FA_carry(39));

        FA_40 : full_adder
            PORT MAP(
                A     => parprod(1)(18),
                B     => parprod(2)(16),
                C_IN  => parprod(3)(14),
                SUM   => FA_out(40),
                C_OUT => FA_carry(40));

        FA_41 : full_adder
            PORT MAP(
                A     => parprod(0)(19),
                B     => parprod(1)(19),
                C_IN  => parprod(2)(17),
                SUM   => FA_out(41),
                C_OUT => FA_carry(41));

        FA_42 : full_adder
            PORT MAP(
                A     => parprod(0)(20),
                B     => parprod(1)(20),
                C_IN  => parprod(2)(18),
                SUM   => FA_out(42),
                C_OUT => FA_carry(42));

        FA_43 : full_adder
            PORT MAP(
                A     => parprod(3)(16),
                B     => parprod(4)(14),
                C_IN  => parprod(5)(12),
                SUM   => FA_out(43),
                C_OUT => FA_carry(43));

        FA_44 : full_adder
            PORT MAP(
                A     => HA_carry(16),
                B     => parprod(0)(21),
                C_IN  => parprod(1)(21),
                SUM   => FA_out(44),
                C_OUT => FA_carry(44));

        FA_45 : full_adder
            PORT MAP(
                A     => parprod(2)(19),
                B     => parprod(3)(17),
                C_IN  => parprod(4)(15),
                SUM   => FA_out(45),
                C_OUT => FA_carry(45));

        FA_46 : full_adder
            PORT MAP(
                A     => HA_carry(17),
                B     => parprod(0)(22),
                C_IN  => parprod(1)(22),
                SUM   => FA_out(46),
                C_OUT => FA_carry(46));

        FA_47 : full_adder
            PORT MAP(
                A     => parprod(2)(20),
                B     => parprod(3)(18),
                C_IN  => parprod(4)(16),
                SUM   => FA_out(47),
                C_OUT => FA_carry(47));

        FA_48 : full_adder
            PORT MAP(
                A     => parprod(5)(14),
                B     => parprod(6)(12),
                C_IN  => parprod(7)(10),
                SUM   => FA_out(48),
                C_OUT => FA_carry(48));

        FA_49 : full_adder
            PORT MAP(
                A     => FA_carry(46),
                B     => HA_carry(18),
                C_IN  => parprod(0)(23),
                SUM   => FA_out(49),
                C_OUT => FA_carry(49));

        FA_50 : full_adder
            PORT MAP(
                A     => parprod(1)(23),
                B     => parprod(2)(21),
                C_IN  => parprod(3)(19),
                SUM   => FA_out(50),
                C_OUT => FA_carry(50));

        FA_51 : full_adder
            PORT MAP(
                A     => parprod(4)(17),
                B     => parprod(5)(15),
                C_IN  => parprod(6)(13),
                SUM   => FA_out(51),
                C_OUT => FA_carry(51));

        FA_52 : full_adder
            PORT MAP(
                A     => FA_carry(51),
                B     => FA_carry(50),
                C_IN  => FA_carry(49),
                SUM   => FA_out(52),
                C_OUT => FA_carry(52));

        FA_53 : full_adder
            PORT MAP(
                A     => HA_carry(19),
                B     => HA_out(0),
                C_IN  => parprod(2)(22),
                SUM   => FA_out(53),
                C_OUT => FA_carry(53));

        FA_54 : full_adder
            PORT MAP(
                A     => parprod(3)(20),
                B     => parprod(4)(18),
                C_IN  => parprod(5)(16),
                SUM   => FA_out(54),
                C_OUT => FA_carry(54));

        FA_55 : full_adder
            PORT MAP(
                A     => parprod(6)(14),
                B     => parprod(7)(12),
                C_IN  => parprod(8)(10),
                SUM   => FA_out(55),
                C_OUT => FA_carry(55));

        FA_56 : full_adder
            PORT MAP(
                A     => FA_carry(55),
                B     => FA_carry(54),
                C_IN  => FA_carry(53),
                SUM   => FA_out(56),
                C_OUT => FA_carry(56));

        FA_57 : full_adder
            PORT MAP(
                A     => FA_carry(52),
                B     => HA_out(1),
                C_IN  => parprod(1)(25),
                SUM   => FA_out(57),
                C_OUT => FA_carry(57));

        FA_58 : full_adder
            PORT MAP(
                A     => parprod(2)(23),
                B     => parprod(3)(21),
                C_IN  => parprod(4)(19),
                SUM   => FA_out(58),
                C_OUT => FA_carry(58));

        FA_59 : full_adder
            PORT MAP(
                A     => parprod(5)(17),
                B     => parprod(6)(15),
                C_IN  => parprod(7)(13),
                SUM   => FA_out(59),
                C_OUT => FA_carry(59));

        FA_60 : full_adder
            PORT MAP(
                A     => FA_carry(59),
                B     => FA_carry(58),
                C_IN  => FA_carry(57),
                SUM   => FA_out(60),
                C_OUT => FA_carry(60));

        FA_61 : full_adder
            PORT MAP(
                A     => FA_carry(56),
                B     => FA_out(0),
                C_IN  => HA_out(2),
                SUM   => FA_out(61),
                C_OUT => FA_carry(61));

        FA_62 : full_adder
            PORT MAP(
                A     => parprod(4)(20),
                B     => parprod(5)(18),
                C_IN  => parprod(6)(16),
                SUM   => FA_out(62),
                C_OUT => FA_carry(62));

        FA_63 : full_adder
            PORT MAP(
                A     => parprod(7)(14),
                B     => parprod(8)(12),
                C_IN  => parprod(9)(10),
                SUM   => FA_out(63),
                C_OUT => FA_carry(63));

        FA_64 : full_adder
            PORT MAP(
                A     => FA_carry(63),
                B     => FA_carry(62),
                C_IN  => FA_carry(61),
                SUM   => FA_out(64),
                C_OUT => FA_carry(64));

        FA_65 : full_adder
            PORT MAP(
                A     => FA_carry(60),
                B     => FA_out(1),
                C_IN  => HA_out(3),
                SUM   => FA_out(65),
                C_OUT => FA_carry(65));

        FA_66 : full_adder
            PORT MAP(
                A     => parprod(3)(23),
                B     => parprod(4)(21),
                C_IN  => parprod(5)(19),
                SUM   => FA_out(66),
                C_OUT => FA_carry(66));

        FA_67 : full_adder
            PORT MAP(
                A     => parprod(6)(17),
                B     => parprod(7)(15),
                C_IN  => parprod(8)(13),
                SUM   => FA_out(67),
                C_OUT => FA_carry(67));

        FA_68 : full_adder
            PORT MAP(
                A     => FA_carry(67),
                B     => FA_carry(66),
                C_IN  => FA_carry(65),
                SUM   => FA_out(68),
                C_OUT => FA_carry(68));

        FA_69 : full_adder
            PORT MAP(
                A     => FA_carry(64),
                B     => FA_out(3),
                C_IN  => FA_out(2),
                SUM   => FA_out(69),
                C_OUT => FA_carry(69));

        FA_70 : full_adder
            PORT MAP(
                A     => HA_out(4),
                B     => parprod(6)(18),
                C_IN  => parprod(7)(16),
                SUM   => FA_out(70),
                C_OUT => FA_carry(70));

        FA_71 : full_adder
            PORT MAP(
                A     => parprod(8)(14),
                B     => parprod(9)(12),
                C_IN  => parprod(10)(10),
                SUM   => FA_out(71),
                C_OUT => FA_carry(71));

        FA_72 : full_adder
            PORT MAP(
                A     => FA_carry(71),
                B     => FA_carry(70),
                C_IN  => FA_carry(69),
                SUM   => FA_out(72),
                C_OUT => FA_carry(72));

        FA_73 : full_adder
            PORT MAP(
                A     => FA_carry(68),
                B     => FA_out(5),
                C_IN  => FA_out(4),
                SUM   => FA_out(73),
                C_OUT => FA_carry(73));

        FA_74 : full_adder
            PORT MAP(
                A     => HA_out(5),
                B     => parprod(5)(21),
                C_IN  => parprod(6)(19),
                SUM   => FA_out(74),
                C_OUT => FA_carry(74));

        FA_75 : full_adder
            PORT MAP(
                A     => parprod(7)(17),
                B     => parprod(8)(15),
                C_IN  => parprod(9)(13),
                SUM   => FA_out(75),
                C_OUT => FA_carry(75));

        FA_76 : full_adder
            PORT MAP(
                A     => FA_carry(75),
                B     => FA_carry(74),
                C_IN  => FA_carry(73),
                SUM   => FA_out(76),
                C_OUT => FA_carry(76));

        FA_77 : full_adder
            PORT MAP(
                A     => FA_carry(72),
                B     => FA_out(8),
                C_IN  => FA_out(7),
                SUM   => FA_out(77),
                C_OUT => FA_carry(77));

        FA_78 : full_adder
            PORT MAP(
                A     => FA_out(6),
                B     => HA_out(6),
                C_IN  => parprod(8)(16),
                SUM   => FA_out(78),
                C_OUT => FA_carry(78));

        FA_79 : full_adder
            PORT MAP(
                A     => parprod(9)(14),
                B     => parprod(10)(12),
                C_IN  => parprod(11)(10),
                SUM   => FA_out(79),
                C_OUT => FA_carry(79));

        FA_80 : full_adder
            PORT MAP(
                A     => FA_carry(79),
                B     => FA_carry(78),
                C_IN  => FA_carry(77),
                SUM   => FA_out(80),
                C_OUT => FA_carry(80));

        FA_81 : full_adder
            PORT MAP(
                A     => FA_carry(76),
                B     => FA_out(11),
                C_IN  => FA_out(10),
                SUM   => FA_out(81),
                C_OUT => FA_carry(81));

        FA_82 : full_adder
            PORT MAP(
                A     => FA_out(9),
                B     => HA_out(7),
                C_IN  => parprod(7)(19),
                SUM   => FA_out(82),
                C_OUT => FA_carry(82));

        FA_83 : full_adder
            PORT MAP(
                A     => parprod(8)(17),
                B     => parprod(9)(15),
                C_IN  => parprod(10)(13),
                SUM   => FA_out(83),
                C_OUT => FA_carry(83));

        FA_84 : full_adder
            PORT MAP(
                A     => FA_carry(83),
                B     => FA_carry(82),
                C_IN  => FA_carry(81),
                SUM   => FA_out(84),
                C_OUT => FA_carry(84));

        FA_85 : full_adder
            PORT MAP(
                A     => FA_carry(80),
                B     => FA_out(15),
                C_IN  => FA_out(14),
                SUM   => FA_out(85),
                C_OUT => FA_carry(85));

        FA_86 : full_adder
            PORT MAP(
                A     => FA_out(13),
                B     => FA_out(12),
                C_IN  => parprod(8)(18),
                SUM   => FA_out(86),
                C_OUT => FA_carry(86));

        FA_87 : full_adder
            PORT MAP(
                A     => parprod(9)(16),
                B     => parprod(10)(14),
                C_IN  => parprod(11)(12),
                SUM   => FA_out(87),
                C_OUT => FA_carry(87));

        FA_88 : full_adder
            PORT MAP(
                A     => FA_carry(87),
                B     => FA_carry(86),
                C_IN  => FA_carry(85),
                SUM   => FA_out(88),
                C_OUT => FA_carry(88));

        FA_89 : full_adder
            PORT MAP(
                A     => FA_carry(84),
                B     => FA_out(19),
                C_IN  => FA_out(18),
                SUM   => FA_out(89),
                C_OUT => FA_carry(89));

        FA_90 : full_adder
            PORT MAP(
                A     => FA_out(17),
                B     => FA_out(16),
                C_IN  => parprod(8)(19),
                SUM   => FA_out(90),
                C_OUT => FA_carry(90));

        FA_91 : full_adder
            PORT MAP(
                A     => parprod(9)(17),
                B     => parprod(10)(15),
                C_IN  => parprod(11)(13),
                SUM   => FA_out(91),
                C_OUT => FA_carry(91));

        FA_92 : full_adder
            PORT MAP(
                A     => FA_carry(91),
                B     => FA_carry(90),
                C_IN  => FA_carry(89),
                SUM   => FA_out(92),
                C_OUT => FA_carry(92));

        FA_93 : full_adder
            PORT MAP(
                A     => FA_carry(88),
                B     => FA_out(23),
                C_IN  => FA_out(22),
                SUM   => FA_out(93),
                C_OUT => FA_carry(93));

        FA_94 : full_adder
            PORT MAP(
                A     => FA_out(21),
                B     => FA_out(20),
                C_IN  => parprod(8)(20),
                SUM   => FA_out(94),
                C_OUT => FA_carry(94));

        FA_95 : full_adder
            PORT MAP(
                A     => parprod(9)(18),
                B     => parprod(10)(16),
                C_IN  => parprod(11)(14),
                SUM   => FA_out(95),
                C_OUT => FA_carry(95));

        FA_96 : full_adder
            PORT MAP(
                A     => FA_carry(95),
                B     => FA_carry(94),
                C_IN  => FA_carry(93),
                SUM   => FA_out(96),
                C_OUT => FA_carry(96));

        FA_97 : full_adder
            PORT MAP(
                A     => FA_carry(92),
                B     => FA_out(27),
                C_IN  => FA_out(26),
                SUM   => FA_out(97),
                C_OUT => FA_carry(97));

        FA_98 : full_adder
            PORT MAP(
                A     => FA_out(25),
                B     => FA_out(24),
                C_IN  => parprod(8)(21),
                SUM   => FA_out(98),
                C_OUT => FA_carry(98));

        FA_99 : full_adder
            PORT MAP(
                A     => parprod(9)(19),
                B     => parprod(10)(17),
                C_IN  => parprod(11)(15),
                SUM   => FA_out(99),
                C_OUT => FA_carry(99));

        FA_100 : full_adder
            PORT MAP(
                A     => FA_carry(99),
                B     => FA_carry(98),
                C_IN  => FA_carry(97),
                SUM   => FA_out(100),
                C_OUT => FA_carry(100));

        FA_101 : full_adder
            PORT MAP(
                A     => FA_carry(96),
                B     => FA_out(30),
                C_IN  => FA_out(29),
                SUM   => FA_out(101),
                C_OUT => FA_carry(101));

        FA_102 : full_adder
            PORT MAP(
                A     => FA_out(28),
                B     => HA_out(8),
                C_IN  => parprod(8)(22),
                SUM   => FA_out(102),
                C_OUT => FA_carry(102));

        FA_103 : full_adder
            PORT MAP(
                A     => parprod(9)(20),
                B     => parprod(10)(18),
                C_IN  => parprod(11)(16),
                SUM   => FA_out(103),
                C_OUT => FA_carry(103));

        FA_104 : full_adder
            PORT MAP(
                A     => FA_carry(103),
                B     => FA_carry(102),
                C_IN  => FA_carry(101),
                SUM   => FA_out(104),
                C_OUT => FA_carry(104));

        FA_105 : full_adder
            PORT MAP(
                A     => FA_carry(100),
                B     => FA_out(33),
                C_IN  => FA_out(32),
                SUM   => FA_out(105),
                C_OUT => FA_carry(105));

        FA_106 : full_adder
            PORT MAP(
                A     => FA_out(31),
                B     => parprod(7)(25),
                C_IN  => parprod(8)(23),
                SUM   => FA_out(106),
                C_OUT => FA_carry(106));

        FA_107 : full_adder
            PORT MAP(
                A     => parprod(9)(21),
                B     => parprod(10)(19),
                C_IN  => parprod(11)(17),
                SUM   => FA_out(107),
                C_OUT => FA_carry(107));

        FA_108 : full_adder
            PORT MAP(
                A     => FA_carry(107),
                B     => FA_carry(106),
                C_IN  => FA_carry(105),
                SUM   => FA_out(108),
                C_OUT => FA_carry(108));

        FA_109 : full_adder
            PORT MAP(
                A     => FA_carry(104),
                B     => FA_out(35),
                C_IN  => FA_out(34),
                SUM   => FA_out(109),
                C_OUT => FA_carry(109));

        FA_110 : full_adder
            PORT MAP(
                A     => HA_out(9),
                B     => parprod(7)(26),
                C_IN  => parprod(8)(24),
                SUM   => FA_out(110),
                C_OUT => FA_carry(110));

        FA_111 : full_adder
            PORT MAP(
                A     => parprod(9)(22),
                B     => parprod(10)(20),
                C_IN  => parprod(11)(18),
                SUM   => FA_out(111),
                C_OUT => FA_carry(111));

        FA_112 : full_adder
            PORT MAP(
                A     => FA_carry(111),
                B     => FA_carry(110),
                C_IN  => FA_carry(109),
                SUM   => FA_out(112),
                C_OUT => FA_carry(112));

        FA_113 : full_adder
            PORT MAP(
                A     => FA_carry(108),
                B     => FA_out(37),
                C_IN  => FA_out(36),
                SUM   => FA_out(113),
                C_OUT => FA_carry(113));

        FA_114 : full_adder
            PORT MAP(
                A     => parprod(6)(29),
                B     => parprod(7)(27),
                C_IN  => parprod(8)(25),
                SUM   => FA_out(114),
                C_OUT => FA_carry(114));

        FA_115 : full_adder
            PORT MAP(
                A     => parprod(9)(23),
                B     => parprod(10)(21),
                C_IN  => parprod(11)(19),
                SUM   => FA_out(115),
                C_OUT => FA_carry(115));

        FA_116 : full_adder
            PORT MAP(
                A     => FA_carry(115),
                B     => FA_carry(114),
                C_IN  => FA_carry(113),
                SUM   => FA_out(116),
                C_OUT => FA_carry(116));

        FA_117 : full_adder
            PORT MAP(
                A     => FA_carry(112),
                B     => FA_out(38),
                C_IN  => HA_out(10),
                SUM   => FA_out(117),
                C_OUT => FA_carry(117));

        FA_118 : full_adder
            PORT MAP(
                A     => parprod(6)(30),
                B     => parprod(7)(28),
                C_IN  => parprod(8)(26),
                SUM   => FA_out(118),
                C_OUT => FA_carry(118));

        FA_119 : full_adder
            PORT MAP(
                A     => parprod(9)(24),
                B     => parprod(10)(22),
                C_IN  => parprod(11)(20),
                SUM   => FA_out(119),
                C_OUT => FA_carry(119));

        FA_120 : full_adder
            PORT MAP(
                A     => FA_carry(119),
                B     => FA_carry(118),
                C_IN  => FA_carry(117),
                SUM   => FA_out(120),
                C_OUT => FA_carry(120));

        FA_121 : full_adder
            PORT MAP(
                A     => FA_carry(116),
                B     => FA_out(39),
                C_IN  => parprod(5)(33),
                SUM   => FA_out(121),
                C_OUT => FA_carry(121));

        FA_122 : full_adder
            PORT MAP(
                A     => parprod(6)(31),
                B     => parprod(7)(29),
                C_IN  => parprod(8)(27),
                SUM   => FA_out(122),
                C_OUT => FA_carry(122));

        FA_123 : full_adder
            PORT MAP(
                A     => parprod(9)(25),
                B     => parprod(10)(23),
                C_IN  => parprod(11)(21),
                SUM   => FA_out(123),
                C_OUT => FA_carry(123));

        FA_124 : full_adder
            PORT MAP(
                A     => FA_carry(123),
                B     => FA_carry(122),
                C_IN  => FA_carry(121),
                SUM   => FA_out(124),
                C_OUT => FA_carry(124));

        FA_125 : full_adder
            PORT MAP(
                A     => FA_carry(120),
                B     => HA_out(11),
                C_IN  => parprod(5)(34),
                SUM   => FA_out(125),
                C_OUT => FA_carry(125));

        FA_126 : full_adder
            PORT MAP(
                A     => parprod(6)(32),
                B     => parprod(7)(30),
                C_IN  => parprod(8)(28),
                SUM   => FA_out(126),
                C_OUT => FA_carry(126));

        FA_127 : full_adder
            PORT MAP(
                A     => parprod(9)(26),
                B     => parprod(10)(24),
                C_IN  => parprod(11)(22),
                SUM   => FA_out(127),
                C_OUT => FA_carry(127));

        FA_128 : full_adder
            PORT MAP(
                A     => FA_carry(127),
                B     => FA_carry(126),
                C_IN  => FA_carry(125),
                SUM   => FA_out(128),
                C_OUT => FA_carry(128));

        FA_129 : full_adder
            PORT MAP(
                A     => FA_carry(124),
                B     => HA_carry(11),
                C_IN  => parprod(5)(35),
                SUM   => FA_out(129),
                C_OUT => FA_carry(129));

        FA_130 : full_adder
            PORT MAP(
                A     => parprod(6)(33),
                B     => parprod(7)(31),
                C_IN  => parprod(8)(29),
                SUM   => FA_out(130),
                C_OUT => FA_carry(130));

        FA_131 : full_adder
            PORT MAP(
                A     => parprod(9)(27),
                B     => parprod(10)(25),
                C_IN  => parprod(11)(23),
                SUM   => FA_out(131),
                C_OUT => FA_carry(131));

        FA_132 : full_adder
            PORT MAP(
                A     => FA_carry(129),
                B     => FA_carry(128),
                C_IN  => parprod(5)(36),
                SUM   => FA_out(132),
                C_OUT => FA_carry(132));

        FA_133 : full_adder
            PORT MAP(
                A     => parprod(6)(34),
                B     => parprod(7)(32),
                C_IN  => parprod(8)(30),
                SUM   => FA_out(133),
                C_OUT => FA_carry(133));

        FA_134 : full_adder
            PORT MAP(
                A     => parprod(9)(28),
                B     => parprod(10)(26),
                C_IN  => parprod(11)(24),
                SUM   => FA_out(134),
                C_OUT => FA_carry(134));

        FA_135 : full_adder
            PORT MAP(
                A     => FA_carry(134),
                B     => FA_carry(133),
                C_IN  => FA_carry(132),
                SUM   => FA_out(135),
                C_OUT => FA_carry(135));

        FA_136 : full_adder
            PORT MAP(
                A     => HA_carry(20),
                B     => parprod(6)(35),
                C_IN  => parprod(7)(33),
                SUM   => FA_out(136),
                C_OUT => FA_carry(136));

        FA_137 : full_adder
            PORT MAP(
                A     => parprod(8)(31),
                B     => parprod(9)(29),
                C_IN  => parprod(10)(27),
                SUM   => FA_out(137),
                C_OUT => FA_carry(137));

        FA_138 : full_adder
            PORT MAP(
                A     => FA_carry(135),
                B     => parprod(6)(36),
                C_IN  => parprod(7)(34),
                SUM   => FA_out(138),
                C_OUT => FA_carry(138));

        FA_139 : full_adder
            PORT MAP(
                A     => parprod(8)(32),
                B     => parprod(9)(30),
                C_IN  => parprod(10)(28),
                SUM   => FA_out(139),
                C_OUT => FA_carry(139));

        FA_140 : full_adder
            PORT MAP(
                A     => FA_carry(139),
                B     => FA_carry(138),
                C_IN  => HA_carry(21),
                SUM   => FA_out(140),
                C_OUT => FA_carry(140));

        FA_141 : full_adder
            PORT MAP(
                A     => parprod(7)(35),
                B     => parprod(8)(33),
                C_IN  => parprod(9)(31),
                SUM   => FA_out(141),
                C_OUT => FA_carry(141));

        FA_142 : full_adder
            PORT MAP(
                A     => parprod(7)(36),
                B     => parprod(8)(34),
                C_IN  => parprod(9)(32),
                SUM   => FA_out(142),
                C_OUT => FA_carry(142));

        FA_143 : full_adder
            PORT MAP(
                A     => FA_carry(142),
                B     => HA_carry(22),
                C_IN  => parprod(8)(35),
                SUM   => FA_out(143),
                C_OUT => FA_carry(143));

        FA_144 : full_adder
            PORT MAP(
                A     => parprod(1)(12),
                B     => parprod(2)(10),
                C_IN  => parprod(3)(8),
                SUM   => FA_out(144),
                C_OUT => FA_carry(144));

        FA_145 : full_adder
            PORT MAP(
                A     => parprod(0)(13),
                B     => parprod(1)(13),
                C_IN  => parprod(2)(11),
                SUM   => FA_out(145),
                C_OUT => FA_carry(145));

        FA_146 : full_adder
            PORT MAP(
                A     => parprod(0)(14),
                B     => parprod(1)(14),
                C_IN  => parprod(2)(12),
                SUM   => FA_out(146),
                C_OUT => FA_carry(146));

        FA_147 : full_adder
            PORT MAP(
                A     => parprod(3)(10),
                B     => parprod(4)(8),
                C_IN  => parprod(5)(6),
                SUM   => FA_out(147),
                C_OUT => FA_carry(147));

        FA_148 : full_adder
            PORT MAP(
                A     => HA_carry(28),
                B     => parprod(0)(15),
                C_IN  => parprod(1)(15),
                SUM   => FA_out(148),
                C_OUT => FA_carry(148));

        FA_149 : full_adder
            PORT MAP(
                A     => parprod(2)(13),
                B     => parprod(3)(11),
                C_IN  => parprod(4)(9),
                SUM   => FA_out(149),
                C_OUT => FA_carry(149));

        FA_150 : full_adder
            PORT MAP(
                A     => FA_carry(149),
                B     => FA_carry(148),
                C_IN  => HA_carry(29),
                SUM   => FA_out(150),
                C_OUT => FA_carry(150));

        FA_151 : full_adder
            PORT MAP(
                A     => HA_out(12),
                B     => parprod(2)(14),
                C_IN  => parprod(3)(12),
                SUM   => FA_out(151),
                C_OUT => FA_carry(151));

        FA_152 : full_adder
            PORT MAP(
                A     => parprod(4)(10),
                B     => parprod(5)(8),
                C_IN  => parprod(6)(6),
                SUM   => FA_out(152),
                C_OUT => FA_carry(152));

        FA_153 : full_adder
            PORT MAP(
                A     => FA_carry(152),
                B     => FA_carry(151),
                C_IN  => FA_carry(150),
                SUM   => FA_out(153),
                C_OUT => FA_carry(153));

        FA_154 : full_adder
            PORT MAP(
                A     => HA_out(13),
                B     => parprod(1)(17),
                C_IN  => parprod(2)(15),
                SUM   => FA_out(154),
                C_OUT => FA_carry(154));

        FA_155 : full_adder
            PORT MAP(
                A     => parprod(3)(13),
                B     => parprod(4)(11),
                C_IN  => parprod(5)(9),
                SUM   => FA_out(155),
                C_OUT => FA_carry(155));

        FA_156 : full_adder
            PORT MAP(
                A     => FA_carry(155),
                B     => FA_carry(154),
                C_IN  => FA_carry(153),
                SUM   => FA_out(156),
                C_OUT => FA_carry(156));

        FA_157 : full_adder
            PORT MAP(
                A     => FA_out(40),
                B     => HA_out(14),
                C_IN  => parprod(4)(12),
                SUM   => FA_out(157),
                C_OUT => FA_carry(157));

        FA_158 : full_adder
            PORT MAP(
                A     => parprod(5)(10),
                B     => parprod(6)(8),
                C_IN  => parprod(7)(6),
                SUM   => FA_out(158),
                C_OUT => FA_carry(158));

        FA_159 : full_adder
            PORT MAP(
                A     => FA_carry(158),
                B     => FA_carry(157),
                C_IN  => FA_carry(156),
                SUM   => FA_out(159),
                C_OUT => FA_carry(159));

        FA_160 : full_adder
            PORT MAP(
                A     => FA_out(41),
                B     => HA_out(15),
                C_IN  => parprod(3)(15),
                SUM   => FA_out(160),
                C_OUT => FA_carry(160));

        FA_161 : full_adder
            PORT MAP(
                A     => parprod(4)(13),
                B     => parprod(5)(11),
                C_IN  => parprod(6)(9),
                SUM   => FA_out(161),
                C_OUT => FA_carry(161));

        FA_162 : full_adder
            PORT MAP(
                A     => FA_carry(161),
                B     => FA_carry(160),
                C_IN  => FA_carry(159),
                SUM   => FA_out(162),
                C_OUT => FA_carry(162));

        FA_163 : full_adder
            PORT MAP(
                A     => FA_out(43),
                B     => FA_out(42),
                C_IN  => HA_out(16),
                SUM   => FA_out(163),
                C_OUT => FA_carry(163));

        FA_164 : full_adder
            PORT MAP(
                A     => parprod(6)(10),
                B     => parprod(7)(8),
                C_IN  => parprod(8)(6),
                SUM   => FA_out(164),
                C_OUT => FA_carry(164));

        FA_165 : full_adder
            PORT MAP(
                A     => FA_carry(164),
                B     => FA_carry(163),
                C_IN  => FA_carry(162),
                SUM   => FA_out(165),
                C_OUT => FA_carry(165));

        FA_166 : full_adder
            PORT MAP(
                A     => FA_out(45),
                B     => FA_out(44),
                C_IN  => HA_out(17),
                SUM   => FA_out(166),
                C_OUT => FA_carry(166));

        FA_167 : full_adder
            PORT MAP(
                A     => parprod(5)(13),
                B     => parprod(6)(11),
                C_IN  => parprod(7)(9),
                SUM   => FA_out(167),
                C_OUT => FA_carry(167));

        FA_168 : full_adder
            PORT MAP(
                A     => FA_carry(167),
                B     => FA_carry(166),
                C_IN  => FA_carry(165),
                SUM   => FA_out(168),
                C_OUT => FA_carry(168));

        FA_169 : full_adder
            PORT MAP(
                A     => FA_out(48),
                B     => FA_out(47),
                C_IN  => FA_out(46),
                SUM   => FA_out(169),
                C_OUT => FA_carry(169));

        FA_170 : full_adder
            PORT MAP(
                A     => HA_out(18),
                B     => parprod(8)(8),
                C_IN  => parprod(9)(6),
                SUM   => FA_out(170),
                C_OUT => FA_carry(170));

        FA_171 : full_adder
            PORT MAP(
                A     => FA_carry(170),
                B     => FA_carry(169),
                C_IN  => FA_carry(168),
                SUM   => FA_out(171),
                C_OUT => FA_carry(171));

        FA_172 : full_adder
            PORT MAP(
                A     => FA_out(51),
                B     => FA_out(50),
                C_IN  => FA_out(49),
                SUM   => FA_out(172),
                C_OUT => FA_carry(172));

        FA_173 : full_adder
            PORT MAP(
                A     => HA_out(19),
                B     => parprod(7)(11),
                C_IN  => parprod(8)(9),
                SUM   => FA_out(173),
                C_OUT => FA_carry(173));

        FA_174 : full_adder
            PORT MAP(
                A     => FA_carry(173),
                B     => FA_carry(172),
                C_IN  => FA_carry(171),
                SUM   => FA_out(174),
                C_OUT => FA_carry(174));

        FA_175 : full_adder
            PORT MAP(
                A     => FA_out(55),
                B     => FA_out(54),
                C_IN  => FA_out(53),
                SUM   => FA_out(175),
                C_OUT => FA_carry(175));

        FA_176 : full_adder
            PORT MAP(
                A     => FA_out(52),
                B     => parprod(9)(8),
                C_IN  => parprod(10)(6),
                SUM   => FA_out(176),
                C_OUT => FA_carry(176));

        FA_177 : full_adder
            PORT MAP(
                A     => FA_carry(176),
                B     => FA_carry(175),
                C_IN  => FA_carry(174),
                SUM   => FA_out(177),
                C_OUT => FA_carry(177));

        FA_178 : full_adder
            PORT MAP(
                A     => FA_out(59),
                B     => FA_out(58),
                C_IN  => FA_out(57),
                SUM   => FA_out(178),
                C_OUT => FA_carry(178));

        FA_179 : full_adder
            PORT MAP(
                A     => FA_out(56),
                B     => parprod(8)(11),
                C_IN  => parprod(9)(9),
                SUM   => FA_out(179),
                C_OUT => FA_carry(179));

        FA_180 : full_adder
            PORT MAP(
                A     => FA_carry(179),
                B     => FA_carry(178),
                C_IN  => FA_carry(177),
                SUM   => FA_out(180),
                C_OUT => FA_carry(180));

        FA_181 : full_adder
            PORT MAP(
                A     => FA_out(63),
                B     => FA_out(62),
                C_IN  => FA_out(61),
                SUM   => FA_out(181),
                C_OUT => FA_carry(181));

        FA_182 : full_adder
            PORT MAP(
                A     => FA_out(60),
                B     => parprod(10)(8),
                C_IN  => parprod(11)(6),
                SUM   => FA_out(182),
                C_OUT => FA_carry(182));

        FA_183 : full_adder
            PORT MAP(
                A     => FA_carry(182),
                B     => FA_carry(181),
                C_IN  => FA_carry(180),
                SUM   => FA_out(183),
                C_OUT => FA_carry(183));

        FA_184 : full_adder
            PORT MAP(
                A     => FA_out(67),
                B     => FA_out(66),
                C_IN  => FA_out(65),
                SUM   => FA_out(184),
                C_OUT => FA_carry(184));

        FA_185 : full_adder
            PORT MAP(
                A     => FA_out(64),
                B     => parprod(9)(11),
                C_IN  => parprod(10)(9),
                SUM   => FA_out(185),
                C_OUT => FA_carry(185));

        FA_186 : full_adder
            PORT MAP(
                A     => FA_carry(185),
                B     => FA_carry(184),
                C_IN  => FA_carry(183),
                SUM   => FA_out(186),
                C_OUT => FA_carry(186));

        FA_187 : full_adder
            PORT MAP(
                A     => FA_out(71),
                B     => FA_out(70),
                C_IN  => FA_out(69),
                SUM   => FA_out(187),
                C_OUT => FA_carry(187));

        FA_188 : full_adder
            PORT MAP(
                A     => FA_out(68),
                B     => parprod(11)(8),
                C_IN  => parprod(12)(6),
                SUM   => FA_out(188),
                C_OUT => FA_carry(188));

        FA_189 : full_adder
            PORT MAP(
                A     => FA_carry(188),
                B     => FA_carry(187),
                C_IN  => FA_carry(186),
                SUM   => FA_out(189),
                C_OUT => FA_carry(189));

        FA_190 : full_adder
            PORT MAP(
                A     => FA_out(75),
                B     => FA_out(74),
                C_IN  => FA_out(73),
                SUM   => FA_out(190),
                C_OUT => FA_carry(190));

        FA_191 : full_adder
            PORT MAP(
                A     => FA_out(72),
                B     => parprod(10)(11),
                C_IN  => parprod(11)(9),
                SUM   => FA_out(191),
                C_OUT => FA_carry(191));

        FA_192 : full_adder
            PORT MAP(
                A     => FA_carry(191),
                B     => FA_carry(190),
                C_IN  => FA_carry(189),
                SUM   => FA_out(192),
                C_OUT => FA_carry(192));

        FA_193 : full_adder
            PORT MAP(
                A     => FA_out(79),
                B     => FA_out(78),
                C_IN  => FA_out(77),
                SUM   => FA_out(193),
                C_OUT => FA_carry(193));

        FA_194 : full_adder
            PORT MAP(
                A     => FA_out(76),
                B     => parprod(12)(8),
                C_IN  => parprod(13)(6),
                SUM   => FA_out(194),
                C_OUT => FA_carry(194));

        FA_195 : full_adder
            PORT MAP(
                A     => FA_carry(194),
                B     => FA_carry(193),
                C_IN  => FA_carry(192),
                SUM   => FA_out(195),
                C_OUT => FA_carry(195));

        FA_196 : full_adder
            PORT MAP(
                A     => FA_out(83),
                B     => FA_out(82),
                C_IN  => FA_out(81),
                SUM   => FA_out(196),
                C_OUT => FA_carry(196));

        FA_197 : full_adder
            PORT MAP(
                A     => FA_out(80),
                B     => parprod(11)(11),
                C_IN  => parprod(12)(9),
                SUM   => FA_out(197),
                C_OUT => FA_carry(197));

        FA_198 : full_adder
            PORT MAP(
                A     => FA_carry(197),
                B     => FA_carry(196),
                C_IN  => FA_carry(195),
                SUM   => FA_out(198),
                C_OUT => FA_carry(198));

        FA_199 : full_adder
            PORT MAP(
                A     => FA_out(87),
                B     => FA_out(86),
                C_IN  => FA_out(85),
                SUM   => FA_out(199),
                C_OUT => FA_carry(199));

        FA_200 : full_adder
            PORT MAP(
                A     => FA_out(84),
                B     => parprod(12)(10),
                C_IN  => parprod(13)(8),
                SUM   => FA_out(200),
                C_OUT => FA_carry(200));

        FA_201 : full_adder
            PORT MAP(
                A     => FA_carry(200),
                B     => FA_carry(199),
                C_IN  => FA_carry(198),
                SUM   => FA_out(201),
                C_OUT => FA_carry(201));

        FA_202 : full_adder
            PORT MAP(
                A     => FA_out(91),
                B     => FA_out(90),
                C_IN  => FA_out(89),
                SUM   => FA_out(202),
                C_OUT => FA_carry(202));

        FA_203 : full_adder
            PORT MAP(
                A     => FA_out(88),
                B     => parprod(12)(11),
                C_IN  => parprod(13)(9),
                SUM   => FA_out(203),
                C_OUT => FA_carry(203));

        FA_204 : full_adder
            PORT MAP(
                A     => FA_carry(203),
                B     => FA_carry(202),
                C_IN  => FA_carry(201),
                SUM   => FA_out(204),
                C_OUT => FA_carry(204));

        FA_205 : full_adder
            PORT MAP(
                A     => FA_out(95),
                B     => FA_out(94),
                C_IN  => FA_out(93),
                SUM   => FA_out(205),
                C_OUT => FA_carry(205));

        FA_206 : full_adder
            PORT MAP(
                A     => FA_out(92),
                B     => parprod(12)(12),
                C_IN  => parprod(13)(10),
                SUM   => FA_out(206),
                C_OUT => FA_carry(206));

        FA_207 : full_adder
            PORT MAP(
                A     => FA_carry(206),
                B     => FA_carry(205),
                C_IN  => FA_carry(204),
                SUM   => FA_out(207),
                C_OUT => FA_carry(207));

        FA_208 : full_adder
            PORT MAP(
                A     => FA_out(99),
                B     => FA_out(98),
                C_IN  => FA_out(97),
                SUM   => FA_out(208),
                C_OUT => FA_carry(208));

        FA_209 : full_adder
            PORT MAP(
                A     => FA_out(96),
                B     => parprod(12)(13),
                C_IN  => parprod(13)(11),
                SUM   => FA_out(209),
                C_OUT => FA_carry(209));

        FA_210 : full_adder
            PORT MAP(
                A     => FA_carry(209),
                B     => FA_carry(208),
                C_IN  => FA_carry(207),
                SUM   => FA_out(210),
                C_OUT => FA_carry(210));

        FA_211 : full_adder
            PORT MAP(
                A     => FA_out(103),
                B     => FA_out(102),
                C_IN  => FA_out(101),
                SUM   => FA_out(211),
                C_OUT => FA_carry(211));

        FA_212 : full_adder
            PORT MAP(
                A     => FA_out(100),
                B     => parprod(12)(14),
                C_IN  => parprod(13)(12),
                SUM   => FA_out(212),
                C_OUT => FA_carry(212));

        FA_213 : full_adder
            PORT MAP(
                A     => FA_carry(212),
                B     => FA_carry(211),
                C_IN  => FA_carry(210),
                SUM   => FA_out(213),
                C_OUT => FA_carry(213));

        FA_214 : full_adder
            PORT MAP(
                A     => FA_out(107),
                B     => FA_out(106),
                C_IN  => FA_out(105),
                SUM   => FA_out(214),
                C_OUT => FA_carry(214));

        FA_215 : full_adder
            PORT MAP(
                A     => FA_out(104),
                B     => parprod(12)(15),
                C_IN  => parprod(13)(13),
                SUM   => FA_out(215),
                C_OUT => FA_carry(215));

        FA_216 : full_adder
            PORT MAP(
                A     => FA_carry(215),
                B     => FA_carry(214),
                C_IN  => FA_carry(213),
                SUM   => FA_out(216),
                C_OUT => FA_carry(216));

        FA_217 : full_adder
            PORT MAP(
                A     => FA_out(111),
                B     => FA_out(110),
                C_IN  => FA_out(109),
                SUM   => FA_out(217),
                C_OUT => FA_carry(217));

        FA_218 : full_adder
            PORT MAP(
                A     => FA_out(108),
                B     => parprod(12)(16),
                C_IN  => parprod(13)(14),
                SUM   => FA_out(218),
                C_OUT => FA_carry(218));

        FA_219 : full_adder
            PORT MAP(
                A     => FA_carry(218),
                B     => FA_carry(217),
                C_IN  => FA_carry(216),
                SUM   => FA_out(219),
                C_OUT => FA_carry(219));

        FA_220 : full_adder
            PORT MAP(
                A     => FA_out(115),
                B     => FA_out(114),
                C_IN  => FA_out(113),
                SUM   => FA_out(220),
                C_OUT => FA_carry(220));

        FA_221 : full_adder
            PORT MAP(
                A     => FA_out(112),
                B     => parprod(12)(17),
                C_IN  => parprod(13)(15),
                SUM   => FA_out(221),
                C_OUT => FA_carry(221));

        FA_222 : full_adder
            PORT MAP(
                A     => FA_carry(221),
                B     => FA_carry(220),
                C_IN  => FA_carry(219),
                SUM   => FA_out(222),
                C_OUT => FA_carry(222));

        FA_223 : full_adder
            PORT MAP(
                A     => FA_out(119),
                B     => FA_out(118),
                C_IN  => FA_out(117),
                SUM   => FA_out(223),
                C_OUT => FA_carry(223));

        FA_224 : full_adder
            PORT MAP(
                A     => FA_out(116),
                B     => parprod(12)(18),
                C_IN  => parprod(13)(16),
                SUM   => FA_out(224),
                C_OUT => FA_carry(224));

        FA_225 : full_adder
            PORT MAP(
                A     => FA_carry(224),
                B     => FA_carry(223),
                C_IN  => FA_carry(222),
                SUM   => FA_out(225),
                C_OUT => FA_carry(225));

        FA_226 : full_adder
            PORT MAP(
                A     => FA_out(123),
                B     => FA_out(122),
                C_IN  => FA_out(121),
                SUM   => FA_out(226),
                C_OUT => FA_carry(226));

        FA_227 : full_adder
            PORT MAP(
                A     => FA_out(120),
                B     => parprod(12)(19),
                C_IN  => parprod(13)(17),
                SUM   => FA_out(227),
                C_OUT => FA_carry(227));

        FA_228 : full_adder
            PORT MAP(
                A     => FA_carry(227),
                B     => FA_carry(226),
                C_IN  => FA_carry(225),
                SUM   => FA_out(228),
                C_OUT => FA_carry(228));

        FA_229 : full_adder
            PORT MAP(
                A     => FA_out(127),
                B     => FA_out(126),
                C_IN  => FA_out(125),
                SUM   => FA_out(229),
                C_OUT => FA_carry(229));

        FA_230 : full_adder
            PORT MAP(
                A     => FA_out(124),
                B     => parprod(12)(20),
                C_IN  => parprod(13)(18),
                SUM   => FA_out(230),
                C_OUT => FA_carry(230));

        FA_231 : full_adder
            PORT MAP(
                A     => FA_carry(230),
                B     => FA_carry(229),
                C_IN  => FA_carry(228),
                SUM   => FA_out(231),
                C_OUT => FA_carry(231));

        FA_232 : full_adder
            PORT MAP(
                A     => FA_out(131),
                B     => FA_out(130),
                C_IN  => FA_out(129),
                SUM   => FA_out(232),
                C_OUT => FA_carry(232));

        FA_233 : full_adder
            PORT MAP(
                A     => FA_out(128),
                B     => parprod(12)(21),
                C_IN  => parprod(13)(19),
                SUM   => FA_out(233),
                C_OUT => FA_carry(233));

        FA_234 : full_adder
            PORT MAP(
                A     => FA_carry(233),
                B     => FA_carry(232),
                C_IN  => FA_carry(231),
                SUM   => FA_out(234),
                C_OUT => FA_carry(234));

        FA_235 : full_adder
            PORT MAP(
                A     => FA_out(134),
                B     => FA_out(133),
                C_IN  => FA_out(132),
                SUM   => FA_out(235),
                C_OUT => FA_carry(235));

        FA_236 : full_adder
            PORT MAP(
                A     => HA_out(20),
                B     => parprod(12)(22),
                C_IN  => parprod(13)(20),
                SUM   => FA_out(236),
                C_OUT => FA_carry(236));

        FA_237 : full_adder
            PORT MAP(
                A     => FA_carry(236),
                B     => FA_carry(235),
                C_IN  => FA_carry(234),
                SUM   => FA_out(237),
                C_OUT => FA_carry(237));

        FA_238 : full_adder
            PORT MAP(
                A     => FA_out(137),
                B     => FA_out(136),
                C_IN  => FA_out(135),
                SUM   => FA_out(238),
                C_OUT => FA_carry(238));

        FA_239 : full_adder
            PORT MAP(
                A     => parprod(11)(25),
                B     => parprod(12)(23),
                C_IN  => parprod(13)(21),
                SUM   => FA_out(239),
                C_OUT => FA_carry(239));

        FA_240 : full_adder
            PORT MAP(
                A     => FA_carry(239),
                B     => FA_carry(238),
                C_IN  => FA_carry(237),
                SUM   => FA_out(240),
                C_OUT => FA_carry(240));

        FA_241 : full_adder
            PORT MAP(
                A     => FA_out(139),
                B     => FA_out(138),
                C_IN  => HA_out(21),
                SUM   => FA_out(241),
                C_OUT => FA_carry(241));

        FA_242 : full_adder
            PORT MAP(
                A     => parprod(11)(26),
                B     => parprod(12)(24),
                C_IN  => parprod(13)(22),
                SUM   => FA_out(242),
                C_OUT => FA_carry(242));

        FA_243 : full_adder
            PORT MAP(
                A     => FA_carry(242),
                B     => FA_carry(241),
                C_IN  => FA_carry(240),
                SUM   => FA_out(243),
                C_OUT => FA_carry(243));

        FA_244 : full_adder
            PORT MAP(
                A     => FA_out(141),
                B     => FA_out(140),
                C_IN  => parprod(10)(29),
                SUM   => FA_out(244),
                C_OUT => FA_carry(244));

        FA_245 : full_adder
            PORT MAP(
                A     => parprod(11)(27),
                B     => parprod(12)(25),
                C_IN  => parprod(13)(23),
                SUM   => FA_out(245),
                C_OUT => FA_carry(245));

        FA_246 : full_adder
            PORT MAP(
                A     => FA_carry(245),
                B     => FA_carry(244),
                C_IN  => FA_carry(243),
                SUM   => FA_out(246),
                C_OUT => FA_carry(246));

        FA_247 : full_adder
            PORT MAP(
                A     => FA_out(142),
                B     => HA_out(22),
                C_IN  => parprod(10)(30),
                SUM   => FA_out(247),
                C_OUT => FA_carry(247));

        FA_248 : full_adder
            PORT MAP(
                A     => parprod(11)(28),
                B     => parprod(12)(26),
                C_IN  => parprod(13)(24),
                SUM   => FA_out(248),
                C_OUT => FA_carry(248));

        FA_249 : full_adder
            PORT MAP(
                A     => FA_carry(248),
                B     => FA_carry(247),
                C_IN  => FA_carry(246),
                SUM   => FA_out(249),
                C_OUT => FA_carry(249));

        FA_250 : full_adder
            PORT MAP(
                A     => FA_out(143),
                B     => parprod(9)(33),
                C_IN  => parprod(10)(31),
                SUM   => FA_out(250),
                C_OUT => FA_carry(250));

        FA_251 : full_adder
            PORT MAP(
                A     => parprod(11)(29),
                B     => parprod(12)(27),
                C_IN  => parprod(13)(25),
                SUM   => FA_out(251),
                C_OUT => FA_carry(251));

        FA_252 : full_adder
            PORT MAP(
                A     => FA_carry(251),
                B     => FA_carry(250),
                C_IN  => FA_carry(249),
                SUM   => FA_out(252),
                C_OUT => FA_carry(252));

        FA_253 : full_adder
            PORT MAP(
                A     => HA_out(23),
                B     => parprod(9)(34),
                C_IN  => parprod(10)(32),
                SUM   => FA_out(253),
                C_OUT => FA_carry(253));

        FA_254 : full_adder
            PORT MAP(
                A     => parprod(11)(30),
                B     => parprod(12)(28),
                C_IN  => parprod(13)(26),
                SUM   => FA_out(254),
                C_OUT => FA_carry(254));

        FA_255 : full_adder
            PORT MAP(
                A     => FA_carry(254),
                B     => FA_carry(253),
                C_IN  => FA_carry(252),
                SUM   => FA_out(255),
                C_OUT => FA_carry(255));

        FA_256 : full_adder
            PORT MAP(
                A     => HA_carry(23),
                B     => parprod(9)(35),
                C_IN  => parprod(10)(33),
                SUM   => FA_out(256),
                C_OUT => FA_carry(256));

        FA_257 : full_adder
            PORT MAP(
                A     => parprod(11)(31),
                B     => parprod(12)(29),
                C_IN  => parprod(13)(27),
                SUM   => FA_out(257),
                C_OUT => FA_carry(257));

        FA_258 : full_adder
            PORT MAP(
                A     => FA_carry(255),
                B     => parprod(9)(36),
                C_IN  => parprod(10)(34),
                SUM   => FA_out(258),
                C_OUT => FA_carry(258));

        FA_259 : full_adder
            PORT MAP(
                A     => parprod(11)(32),
                B     => parprod(12)(30),
                C_IN  => parprod(13)(28),
                SUM   => FA_out(259),
                C_OUT => FA_carry(259));

        FA_260 : full_adder
            PORT MAP(
                A     => FA_carry(259),
                B     => FA_carry(258),
                C_IN  => HA_carry(30),
                SUM   => FA_out(260),
                C_OUT => FA_carry(260));

        FA_261 : full_adder
            PORT MAP(
                A     => parprod(10)(35),
                B     => parprod(11)(33),
                C_IN  => parprod(12)(31),
                SUM   => FA_out(261),
                C_OUT => FA_carry(261));

        FA_262 : full_adder
            PORT MAP(
                A     => parprod(10)(36),
                B     => parprod(11)(34),
                C_IN  => parprod(12)(32),
                SUM   => FA_out(262),
                C_OUT => FA_carry(262));

        FA_263 : full_adder
            PORT MAP(
                A     => FA_carry(262),
                B     => HA_carry(31),
                C_IN  => parprod(11)(35),
                SUM   => FA_out(263),
                C_OUT => FA_carry(263));

        FA_264 : full_adder
            PORT MAP(
                A     => parprod(1)(8),
                B     => parprod(2)(6),
                C_IN  => parprod(3)(4),
                SUM   => FA_out(264),
                C_OUT => FA_carry(264));

        FA_265 : full_adder
            PORT MAP(
                A     => parprod(0)(9),
                B     => parprod(1)(9),
                C_IN  => parprod(2)(7),
                SUM   => FA_out(265),
                C_OUT => FA_carry(265));

        FA_266 : full_adder
            PORT MAP(
                A     => FA_carry(265),
                B     => HA_carry(36),
                C_IN  => HA_out(24),
                SUM   => FA_out(266),
                C_OUT => FA_carry(266));

        FA_267 : full_adder
            PORT MAP(
                A     => parprod(2)(8),
                B     => parprod(3)(6),
                C_IN  => parprod(4)(4),
                SUM   => FA_out(267),
                C_OUT => FA_carry(267));

        FA_268 : full_adder
            PORT MAP(
                A     => FA_carry(267),
                B     => FA_carry(266),
                C_IN  => HA_out(25),
                SUM   => FA_out(268),
                C_OUT => FA_carry(268));

        FA_269 : full_adder
            PORT MAP(
                A     => parprod(1)(11),
                B     => parprod(2)(9),
                C_IN  => parprod(3)(7),
                SUM   => FA_out(269),
                C_OUT => FA_carry(269));

        FA_270 : full_adder
            PORT MAP(
                A     => FA_carry(269),
                B     => FA_carry(268),
                C_IN  => FA_out(144),
                SUM   => FA_out(270),
                C_OUT => FA_carry(270));

        FA_271 : full_adder
            PORT MAP(
                A     => HA_out(26),
                B     => parprod(4)(6),
                C_IN  => parprod(5)(4),
                SUM   => FA_out(271),
                C_OUT => FA_carry(271));

        FA_272 : full_adder
            PORT MAP(
                A     => FA_carry(271),
                B     => FA_carry(270),
                C_IN  => FA_out(145),
                SUM   => FA_out(272),
                C_OUT => FA_carry(272));

        FA_273 : full_adder
            PORT MAP(
                A     => HA_out(27),
                B     => parprod(3)(9),
                C_IN  => parprod(4)(7),
                SUM   => FA_out(273),
                C_OUT => FA_carry(273));

        FA_274 : full_adder
            PORT MAP(
                A     => FA_carry(273),
                B     => FA_carry(272),
                C_IN  => FA_out(147),
                SUM   => FA_out(274),
                C_OUT => FA_carry(274));

        FA_275 : full_adder
            PORT MAP(
                A     => FA_out(146),
                B     => HA_out(28),
                C_IN  => parprod(6)(4),
                SUM   => FA_out(275),
                C_OUT => FA_carry(275));

        FA_276 : full_adder
            PORT MAP(
                A     => FA_carry(275),
                B     => FA_carry(274),
                C_IN  => FA_out(149),
                SUM   => FA_out(276),
                C_OUT => FA_carry(276));

        FA_277 : full_adder
            PORT MAP(
                A     => FA_out(148),
                B     => HA_out(29),
                C_IN  => parprod(5)(7),
                SUM   => FA_out(277),
                C_OUT => FA_carry(277));

        FA_278 : full_adder
            PORT MAP(
                A     => FA_carry(277),
                B     => FA_carry(276),
                C_IN  => FA_out(152),
                SUM   => FA_out(278),
                C_OUT => FA_carry(278));

        FA_279 : full_adder
            PORT MAP(
                A     => FA_out(151),
                B     => FA_out(150),
                C_IN  => parprod(7)(4),
                SUM   => FA_out(279),
                C_OUT => FA_carry(279));

        FA_280 : full_adder
            PORT MAP(
                A     => FA_carry(279),
                B     => FA_carry(278),
                C_IN  => FA_out(155),
                SUM   => FA_out(280),
                C_OUT => FA_carry(280));

        FA_281 : full_adder
            PORT MAP(
                A     => FA_out(154),
                B     => FA_out(153),
                C_IN  => parprod(6)(7),
                SUM   => FA_out(281),
                C_OUT => FA_carry(281));

        FA_282 : full_adder
            PORT MAP(
                A     => FA_carry(281),
                B     => FA_carry(280),
                C_IN  => FA_out(158),
                SUM   => FA_out(282),
                C_OUT => FA_carry(282));

        FA_283 : full_adder
            PORT MAP(
                A     => FA_out(157),
                B     => FA_out(156),
                C_IN  => parprod(8)(4),
                SUM   => FA_out(283),
                C_OUT => FA_carry(283));

        FA_284 : full_adder
            PORT MAP(
                A     => FA_carry(283),
                B     => FA_carry(282),
                C_IN  => FA_out(161),
                SUM   => FA_out(284),
                C_OUT => FA_carry(284));

        FA_285 : full_adder
            PORT MAP(
                A     => FA_out(160),
                B     => FA_out(159),
                C_IN  => parprod(7)(7),
                SUM   => FA_out(285),
                C_OUT => FA_carry(285));

        FA_286 : full_adder
            PORT MAP(
                A     => FA_carry(285),
                B     => FA_carry(284),
                C_IN  => FA_out(164),
                SUM   => FA_out(286),
                C_OUT => FA_carry(286));

        FA_287 : full_adder
            PORT MAP(
                A     => FA_out(163),
                B     => FA_out(162),
                C_IN  => parprod(9)(4),
                SUM   => FA_out(287),
                C_OUT => FA_carry(287));

        FA_288 : full_adder
            PORT MAP(
                A     => FA_carry(287),
                B     => FA_carry(286),
                C_IN  => FA_out(167),
                SUM   => FA_out(288),
                C_OUT => FA_carry(288));

        FA_289 : full_adder
            PORT MAP(
                A     => FA_out(166),
                B     => FA_out(165),
                C_IN  => parprod(8)(7),
                SUM   => FA_out(289),
                C_OUT => FA_carry(289));

        FA_290 : full_adder
            PORT MAP(
                A     => FA_carry(289),
                B     => FA_carry(288),
                C_IN  => FA_out(170),
                SUM   => FA_out(290),
                C_OUT => FA_carry(290));

        FA_291 : full_adder
            PORT MAP(
                A     => FA_out(169),
                B     => FA_out(168),
                C_IN  => parprod(10)(4),
                SUM   => FA_out(291),
                C_OUT => FA_carry(291));

        FA_292 : full_adder
            PORT MAP(
                A     => FA_carry(291),
                B     => FA_carry(290),
                C_IN  => FA_out(173),
                SUM   => FA_out(292),
                C_OUT => FA_carry(292));

        FA_293 : full_adder
            PORT MAP(
                A     => FA_out(172),
                B     => FA_out(171),
                C_IN  => parprod(9)(7),
                SUM   => FA_out(293),
                C_OUT => FA_carry(293));

        FA_294 : full_adder
            PORT MAP(
                A     => FA_carry(293),
                B     => FA_carry(292),
                C_IN  => FA_out(176),
                SUM   => FA_out(294),
                C_OUT => FA_carry(294));

        FA_295 : full_adder
            PORT MAP(
                A     => FA_out(175),
                B     => FA_out(174),
                C_IN  => parprod(11)(4),
                SUM   => FA_out(295),
                C_OUT => FA_carry(295));

        FA_296 : full_adder
            PORT MAP(
                A     => FA_carry(295),
                B     => FA_carry(294),
                C_IN  => FA_out(179),
                SUM   => FA_out(296),
                C_OUT => FA_carry(296));

        FA_297 : full_adder
            PORT MAP(
                A     => FA_out(178),
                B     => FA_out(177),
                C_IN  => parprod(10)(7),
                SUM   => FA_out(297),
                C_OUT => FA_carry(297));

        FA_298 : full_adder
            PORT MAP(
                A     => FA_carry(297),
                B     => FA_carry(296),
                C_IN  => FA_out(182),
                SUM   => FA_out(298),
                C_OUT => FA_carry(298));

        FA_299 : full_adder
            PORT MAP(
                A     => FA_out(181),
                B     => FA_out(180),
                C_IN  => parprod(12)(4),
                SUM   => FA_out(299),
                C_OUT => FA_carry(299));

        FA_300 : full_adder
            PORT MAP(
                A     => FA_carry(299),
                B     => FA_carry(298),
                C_IN  => FA_out(185),
                SUM   => FA_out(300),
                C_OUT => FA_carry(300));

        FA_301 : full_adder
            PORT MAP(
                A     => FA_out(184),
                B     => FA_out(183),
                C_IN  => parprod(11)(7),
                SUM   => FA_out(301),
                C_OUT => FA_carry(301));

        FA_302 : full_adder
            PORT MAP(
                A     => FA_carry(301),
                B     => FA_carry(300),
                C_IN  => FA_out(188),
                SUM   => FA_out(302),
                C_OUT => FA_carry(302));

        FA_303 : full_adder
            PORT MAP(
                A     => FA_out(187),
                B     => FA_out(186),
                C_IN  => parprod(13)(4),
                SUM   => FA_out(303),
                C_OUT => FA_carry(303));

        FA_304 : full_adder
            PORT MAP(
                A     => FA_carry(303),
                B     => FA_carry(302),
                C_IN  => FA_out(191),
                SUM   => FA_out(304),
                C_OUT => FA_carry(304));

        FA_305 : full_adder
            PORT MAP(
                A     => FA_out(190),
                B     => FA_out(189),
                C_IN  => parprod(12)(7),
                SUM   => FA_out(305),
                C_OUT => FA_carry(305));

        FA_306 : full_adder
            PORT MAP(
                A     => FA_carry(305),
                B     => FA_carry(304),
                C_IN  => FA_out(194),
                SUM   => FA_out(306),
                C_OUT => FA_carry(306));

        FA_307 : full_adder
            PORT MAP(
                A     => FA_out(193),
                B     => FA_out(192),
                C_IN  => parprod(14)(4),
                SUM   => FA_out(307),
                C_OUT => FA_carry(307));

        FA_308 : full_adder
            PORT MAP(
                A     => FA_carry(307),
                B     => FA_carry(306),
                C_IN  => FA_out(197),
                SUM   => FA_out(308),
                C_OUT => FA_carry(308));

        FA_309 : full_adder
            PORT MAP(
                A     => FA_out(196),
                B     => FA_out(195),
                C_IN  => parprod(13)(7),
                SUM   => FA_out(309),
                C_OUT => FA_carry(309));

        FA_310 : full_adder
            PORT MAP(
                A     => FA_carry(309),
                B     => FA_carry(308),
                C_IN  => FA_out(200),
                SUM   => FA_out(310),
                C_OUT => FA_carry(310));

        FA_311 : full_adder
            PORT MAP(
                A     => FA_out(199),
                B     => FA_out(198),
                C_IN  => parprod(14)(6),
                SUM   => FA_out(311),
                C_OUT => FA_carry(311));

        FA_312 : full_adder
            PORT MAP(
                A     => FA_carry(311),
                B     => FA_carry(310),
                C_IN  => FA_out(203),
                SUM   => FA_out(312),
                C_OUT => FA_carry(312));

        FA_313 : full_adder
            PORT MAP(
                A     => FA_out(202),
                B     => FA_out(201),
                C_IN  => parprod(14)(7),
                SUM   => FA_out(313),
                C_OUT => FA_carry(313));

        FA_314 : full_adder
            PORT MAP(
                A     => FA_carry(313),
                B     => FA_carry(312),
                C_IN  => FA_out(206),
                SUM   => FA_out(314),
                C_OUT => FA_carry(314));

        FA_315 : full_adder
            PORT MAP(
                A     => FA_out(205),
                B     => FA_out(204),
                C_IN  => parprod(14)(8),
                SUM   => FA_out(315),
                C_OUT => FA_carry(315));

        FA_316 : full_adder
            PORT MAP(
                A     => FA_carry(315),
                B     => FA_carry(314),
                C_IN  => FA_out(209),
                SUM   => FA_out(316),
                C_OUT => FA_carry(316));

        FA_317 : full_adder
            PORT MAP(
                A     => FA_out(208),
                B     => FA_out(207),
                C_IN  => parprod(14)(9),
                SUM   => FA_out(317),
                C_OUT => FA_carry(317));

        FA_318 : full_adder
            PORT MAP(
                A     => FA_carry(317),
                B     => FA_carry(316),
                C_IN  => FA_out(212),
                SUM   => FA_out(318),
                C_OUT => FA_carry(318));

        FA_319 : full_adder
            PORT MAP(
                A     => FA_out(211),
                B     => FA_out(210),
                C_IN  => parprod(14)(10),
                SUM   => FA_out(319),
                C_OUT => FA_carry(319));

        FA_320 : full_adder
            PORT MAP(
                A     => FA_carry(319),
                B     => FA_carry(318),
                C_IN  => FA_out(215),
                SUM   => FA_out(320),
                C_OUT => FA_carry(320));

        FA_321 : full_adder
            PORT MAP(
                A     => FA_out(214),
                B     => FA_out(213),
                C_IN  => parprod(14)(11),
                SUM   => FA_out(321),
                C_OUT => FA_carry(321));

        FA_322 : full_adder
            PORT MAP(
                A     => FA_carry(321),
                B     => FA_carry(320),
                C_IN  => FA_out(218),
                SUM   => FA_out(322),
                C_OUT => FA_carry(322));

        FA_323 : full_adder
            PORT MAP(
                A     => FA_out(217),
                B     => FA_out(216),
                C_IN  => parprod(14)(12),
                SUM   => FA_out(323),
                C_OUT => FA_carry(323));

        FA_324 : full_adder
            PORT MAP(
                A     => FA_carry(323),
                B     => FA_carry(322),
                C_IN  => FA_out(221),
                SUM   => FA_out(324),
                C_OUT => FA_carry(324));

        FA_325 : full_adder
            PORT MAP(
                A     => FA_out(220),
                B     => FA_out(219),
                C_IN  => parprod(14)(13),
                SUM   => FA_out(325),
                C_OUT => FA_carry(325));

        FA_326 : full_adder
            PORT MAP(
                A     => FA_carry(325),
                B     => FA_carry(324),
                C_IN  => FA_out(224),
                SUM   => FA_out(326),
                C_OUT => FA_carry(326));

        FA_327 : full_adder
            PORT MAP(
                A     => FA_out(223),
                B     => FA_out(222),
                C_IN  => parprod(14)(14),
                SUM   => FA_out(327),
                C_OUT => FA_carry(327));

        FA_328 : full_adder
            PORT MAP(
                A     => FA_carry(327),
                B     => FA_carry(326),
                C_IN  => FA_out(227),
                SUM   => FA_out(328),
                C_OUT => FA_carry(328));

        FA_329 : full_adder
            PORT MAP(
                A     => FA_out(226),
                B     => FA_out(225),
                C_IN  => parprod(14)(15),
                SUM   => FA_out(329),
                C_OUT => FA_carry(329));

        FA_330 : full_adder
            PORT MAP(
                A     => FA_carry(329),
                B     => FA_carry(328),
                C_IN  => FA_out(230),
                SUM   => FA_out(330),
                C_OUT => FA_carry(330));

        FA_331 : full_adder
            PORT MAP(
                A     => FA_out(229),
                B     => FA_out(228),
                C_IN  => parprod(14)(16),
                SUM   => FA_out(331),
                C_OUT => FA_carry(331));

        FA_332 : full_adder
            PORT MAP(
                A     => FA_carry(331),
                B     => FA_carry(330),
                C_IN  => FA_out(233),
                SUM   => FA_out(332),
                C_OUT => FA_carry(332));

        FA_333 : full_adder
            PORT MAP(
                A     => FA_out(232),
                B     => FA_out(231),
                C_IN  => parprod(14)(17),
                SUM   => FA_out(333),
                C_OUT => FA_carry(333));

        FA_334 : full_adder
            PORT MAP(
                A     => FA_carry(333),
                B     => FA_carry(332),
                C_IN  => FA_out(236),
                SUM   => FA_out(334),
                C_OUT => FA_carry(334));

        FA_335 : full_adder
            PORT MAP(
                A     => FA_out(235),
                B     => FA_out(234),
                C_IN  => parprod(14)(18),
                SUM   => FA_out(335),
                C_OUT => FA_carry(335));

        FA_336 : full_adder
            PORT MAP(
                A     => FA_carry(335),
                B     => FA_carry(334),
                C_IN  => FA_out(239),
                SUM   => FA_out(336),
                C_OUT => FA_carry(336));

        FA_337 : full_adder
            PORT MAP(
                A     => FA_out(238),
                B     => FA_out(237),
                C_IN  => parprod(14)(19),
                SUM   => FA_out(337),
                C_OUT => FA_carry(337));

        FA_338 : full_adder
            PORT MAP(
                A     => FA_carry(337),
                B     => FA_carry(336),
                C_IN  => FA_out(242),
                SUM   => FA_out(338),
                C_OUT => FA_carry(338));

        FA_339 : full_adder
            PORT MAP(
                A     => FA_out(241),
                B     => FA_out(240),
                C_IN  => parprod(14)(20),
                SUM   => FA_out(339),
                C_OUT => FA_carry(339));

        FA_340 : full_adder
            PORT MAP(
                A     => FA_carry(339),
                B     => FA_carry(338),
                C_IN  => FA_out(245),
                SUM   => FA_out(340),
                C_OUT => FA_carry(340));

        FA_341 : full_adder
            PORT MAP(
                A     => FA_out(244),
                B     => FA_out(243),
                C_IN  => parprod(14)(21),
                SUM   => FA_out(341),
                C_OUT => FA_carry(341));

        FA_342 : full_adder
            PORT MAP(
                A     => FA_carry(341),
                B     => FA_carry(340),
                C_IN  => FA_out(248),
                SUM   => FA_out(342),
                C_OUT => FA_carry(342));

        FA_343 : full_adder
            PORT MAP(
                A     => FA_out(247),
                B     => FA_out(246),
                C_IN  => parprod(14)(22),
                SUM   => FA_out(343),
                C_OUT => FA_carry(343));

        FA_344 : full_adder
            PORT MAP(
                A     => FA_carry(343),
                B     => FA_carry(342),
                C_IN  => FA_out(251),
                SUM   => FA_out(344),
                C_OUT => FA_carry(344));

        FA_345 : full_adder
            PORT MAP(
                A     => FA_out(250),
                B     => FA_out(249),
                C_IN  => parprod(14)(23),
                SUM   => FA_out(345),
                C_OUT => FA_carry(345));

        FA_346 : full_adder
            PORT MAP(
                A     => FA_carry(345),
                B     => FA_carry(344),
                C_IN  => FA_out(254),
                SUM   => FA_out(346),
                C_OUT => FA_carry(346));

        FA_347 : full_adder
            PORT MAP(
                A     => FA_out(253),
                B     => FA_out(252),
                C_IN  => parprod(14)(24),
                SUM   => FA_out(347),
                C_OUT => FA_carry(347));

        FA_348 : full_adder
            PORT MAP(
                A     => FA_carry(347),
                B     => FA_carry(346),
                C_IN  => FA_out(257),
                SUM   => FA_out(348),
                C_OUT => FA_carry(348));

        FA_349 : full_adder
            PORT MAP(
                A     => FA_out(256),
                B     => FA_out(255),
                C_IN  => parprod(14)(25),
                SUM   => FA_out(349),
                C_OUT => FA_carry(349));

        FA_350 : full_adder
            PORT MAP(
                A     => FA_carry(349),
                B     => FA_carry(348),
                C_IN  => FA_out(259),
                SUM   => FA_out(350),
                C_OUT => FA_carry(350));

        FA_351 : full_adder
            PORT MAP(
                A     => FA_out(258),
                B     => HA_out(30),
                C_IN  => parprod(14)(26),
                SUM   => FA_out(351),
                C_OUT => FA_carry(351));

        FA_352 : full_adder
            PORT MAP(
                A     => FA_carry(351),
                B     => FA_carry(350),
                C_IN  => FA_out(261),
                SUM   => FA_out(352),
                C_OUT => FA_carry(352));

        FA_353 : full_adder
            PORT MAP(
                A     => FA_out(260),
                B     => parprod(13)(29),
                C_IN  => parprod(14)(27),
                SUM   => FA_out(353),
                C_OUT => FA_carry(353));

        FA_354 : full_adder
            PORT MAP(
                A     => FA_carry(353),
                B     => FA_carry(352),
                C_IN  => FA_out(262),
                SUM   => FA_out(354),
                C_OUT => FA_carry(354));

        FA_355 : full_adder
            PORT MAP(
                A     => HA_out(31),
                B     => parprod(13)(30),
                C_IN  => parprod(14)(28),
                SUM   => FA_out(355),
                C_OUT => FA_carry(355));

        FA_356 : full_adder
            PORT MAP(
                A     => FA_carry(355),
                B     => FA_carry(354),
                C_IN  => FA_out(263),
                SUM   => FA_out(356),
                C_OUT => FA_carry(356));

        FA_357 : full_adder
            PORT MAP(
                A     => parprod(12)(33),
                B     => parprod(13)(31),
                C_IN  => parprod(14)(29),
                SUM   => FA_out(357),
                C_OUT => FA_carry(357));

        FA_358 : full_adder
            PORT MAP(
                A     => FA_carry(357),
                B     => FA_carry(356),
                C_IN  => HA_out(32),
                SUM   => FA_out(358),
                C_OUT => FA_carry(358));

        FA_359 : full_adder
            PORT MAP(
                A     => parprod(12)(34),
                B     => parprod(13)(32),
                C_IN  => parprod(14)(30),
                SUM   => FA_out(359),
                C_OUT => FA_carry(359));

        FA_360 : full_adder
            PORT MAP(
                A     => FA_carry(359),
                B     => FA_carry(358),
                C_IN  => HA_carry(32),
                SUM   => FA_out(360),
                C_OUT => FA_carry(360));

        FA_361 : full_adder
            PORT MAP(
                A     => parprod(12)(35),
                B     => parprod(13)(33),
                C_IN  => parprod(14)(31),
                SUM   => FA_out(361),
                C_OUT => FA_carry(361));

        FA_362 : full_adder
            PORT MAP(
                A     => parprod(12)(36),
                B     => parprod(13)(34),
                C_IN  => parprod(14)(32),
                SUM   => FA_out(362),
                C_OUT => FA_carry(362));

        FA_363 : full_adder
            PORT MAP(
                A     => FA_carry(362),
                B     => HA_carry(37),
                C_IN  => parprod(13)(35),
                SUM   => FA_out(363),
                C_OUT => FA_carry(363));

        FA_364 : full_adder
            PORT MAP(
                A     => HA_carry(40),
                B     => HA_out(33),
                C_IN  => parprod(2)(4),
                SUM   => FA_out(364),
                C_OUT => FA_carry(364));

        FA_365 : full_adder
            PORT MAP(
                A     => FA_carry(364),
                B     => HA_out(34),
                C_IN  => parprod(1)(7),
                SUM   => FA_out(365),
                C_OUT => FA_carry(365));

        FA_366 : full_adder
            PORT MAP(
                A     => FA_carry(365),
                B     => FA_out(264),
                C_IN  => HA_out(35),
                SUM   => FA_out(366),
                C_OUT => FA_carry(366));

        FA_367 : full_adder
            PORT MAP(
                A     => FA_carry(366),
                B     => FA_out(265),
                C_IN  => HA_out(36),
                SUM   => FA_out(367),
                C_OUT => FA_carry(367));

        FA_368 : full_adder
            PORT MAP(
                A     => FA_carry(367),
                B     => FA_out(267),
                C_IN  => FA_out(266),
                SUM   => FA_out(368),
                C_OUT => FA_carry(368));

        FA_369 : full_adder
            PORT MAP(
                A     => FA_carry(368),
                B     => FA_out(269),
                C_IN  => FA_out(268),
                SUM   => FA_out(369),
                C_OUT => FA_carry(369));

        FA_370 : full_adder
            PORT MAP(
                A     => FA_carry(369),
                B     => FA_out(271),
                C_IN  => FA_out(270),
                SUM   => FA_out(370),
                C_OUT => FA_carry(370));

        FA_371 : full_adder
            PORT MAP(
                A     => FA_carry(370),
                B     => FA_out(273),
                C_IN  => FA_out(272),
                SUM   => FA_out(371),
                C_OUT => FA_carry(371));

        FA_372 : full_adder
            PORT MAP(
                A     => FA_carry(371),
                B     => FA_out(275),
                C_IN  => FA_out(274),
                SUM   => FA_out(372),
                C_OUT => FA_carry(372));

        FA_373 : full_adder
            PORT MAP(
                A     => FA_carry(372),
                B     => FA_out(277),
                C_IN  => FA_out(276),
                SUM   => FA_out(373),
                C_OUT => FA_carry(373));

        FA_374 : full_adder
            PORT MAP(
                A     => FA_carry(373),
                B     => FA_out(279),
                C_IN  => FA_out(278),
                SUM   => FA_out(374),
                C_OUT => FA_carry(374));

        FA_375 : full_adder
            PORT MAP(
                A     => FA_carry(374),
                B     => FA_out(281),
                C_IN  => FA_out(280),
                SUM   => FA_out(375),
                C_OUT => FA_carry(375));

        FA_376 : full_adder
            PORT MAP(
                A     => FA_carry(375),
                B     => FA_out(283),
                C_IN  => FA_out(282),
                SUM   => FA_out(376),
                C_OUT => FA_carry(376));

        FA_377 : full_adder
            PORT MAP(
                A     => FA_carry(376),
                B     => FA_out(285),
                C_IN  => FA_out(284),
                SUM   => FA_out(377),
                C_OUT => FA_carry(377));

        FA_378 : full_adder
            PORT MAP(
                A     => FA_carry(377),
                B     => FA_out(287),
                C_IN  => FA_out(286),
                SUM   => FA_out(378),
                C_OUT => FA_carry(378));

        FA_379 : full_adder
            PORT MAP(
                A     => FA_carry(378),
                B     => FA_out(289),
                C_IN  => FA_out(288),
                SUM   => FA_out(379),
                C_OUT => FA_carry(379));

        FA_380 : full_adder
            PORT MAP(
                A     => FA_carry(379),
                B     => FA_out(291),
                C_IN  => FA_out(290),
                SUM   => FA_out(380),
                C_OUT => FA_carry(380));

        FA_381 : full_adder
            PORT MAP(
                A     => FA_carry(380),
                B     => FA_out(293),
                C_IN  => FA_out(292),
                SUM   => FA_out(381),
                C_OUT => FA_carry(381));

        FA_382 : full_adder
            PORT MAP(
                A     => FA_carry(381),
                B     => FA_out(295),
                C_IN  => FA_out(294),
                SUM   => FA_out(382),
                C_OUT => FA_carry(382));

        FA_383 : full_adder
            PORT MAP(
                A     => FA_carry(382),
                B     => FA_out(297),
                C_IN  => FA_out(296),
                SUM   => FA_out(383),
                C_OUT => FA_carry(383));

        FA_384 : full_adder
            PORT MAP(
                A     => FA_carry(383),
                B     => FA_out(299),
                C_IN  => FA_out(298),
                SUM   => FA_out(384),
                C_OUT => FA_carry(384));

        FA_385 : full_adder
            PORT MAP(
                A     => FA_carry(384),
                B     => FA_out(301),
                C_IN  => FA_out(300),
                SUM   => FA_out(385),
                C_OUT => FA_carry(385));

        FA_386 : full_adder
            PORT MAP(
                A     => FA_carry(385),
                B     => FA_out(303),
                C_IN  => FA_out(302),
                SUM   => FA_out(386),
                C_OUT => FA_carry(386));

        FA_387 : full_adder
            PORT MAP(
                A     => FA_carry(386),
                B     => FA_out(305),
                C_IN  => FA_out(304),
                SUM   => FA_out(387),
                C_OUT => FA_carry(387));

        FA_388 : full_adder
            PORT MAP(
                A     => FA_carry(387),
                B     => FA_out(307),
                C_IN  => FA_out(306),
                SUM   => FA_out(388),
                C_OUT => FA_carry(388));

        FA_389 : full_adder
            PORT MAP(
                A     => FA_carry(388),
                B     => FA_out(309),
                C_IN  => FA_out(308),
                SUM   => FA_out(389),
                C_OUT => FA_carry(389));

        FA_390 : full_adder
            PORT MAP(
                A     => FA_carry(389),
                B     => FA_out(311),
                C_IN  => FA_out(310),
                SUM   => FA_out(390),
                C_OUT => FA_carry(390));

        FA_391 : full_adder
            PORT MAP(
                A     => FA_carry(390),
                B     => FA_out(313),
                C_IN  => FA_out(312),
                SUM   => FA_out(391),
                C_OUT => FA_carry(391));

        FA_392 : full_adder
            PORT MAP(
                A     => FA_carry(391),
                B     => FA_out(315),
                C_IN  => FA_out(314),
                SUM   => FA_out(392),
                C_OUT => FA_carry(392));

        FA_393 : full_adder
            PORT MAP(
                A     => FA_carry(392),
                B     => FA_out(317),
                C_IN  => FA_out(316),
                SUM   => FA_out(393),
                C_OUT => FA_carry(393));

        FA_394 : full_adder
            PORT MAP(
                A     => FA_carry(393),
                B     => FA_out(319),
                C_IN  => FA_out(318),
                SUM   => FA_out(394),
                C_OUT => FA_carry(394));

        FA_395 : full_adder
            PORT MAP(
                A     => FA_carry(394),
                B     => FA_out(321),
                C_IN  => FA_out(320),
                SUM   => FA_out(395),
                C_OUT => FA_carry(395));

        FA_396 : full_adder
            PORT MAP(
                A     => FA_carry(395),
                B     => FA_out(323),
                C_IN  => FA_out(322),
                SUM   => FA_out(396),
                C_OUT => FA_carry(396));

        FA_397 : full_adder
            PORT MAP(
                A     => FA_carry(396),
                B     => FA_out(325),
                C_IN  => FA_out(324),
                SUM   => FA_out(397),
                C_OUT => FA_carry(397));

        FA_398 : full_adder
            PORT MAP(
                A     => FA_carry(397),
                B     => FA_out(327),
                C_IN  => FA_out(326),
                SUM   => FA_out(398),
                C_OUT => FA_carry(398));

        FA_399 : full_adder
            PORT MAP(
                A     => FA_carry(398),
                B     => FA_out(329),
                C_IN  => FA_out(328),
                SUM   => FA_out(399),
                C_OUT => FA_carry(399));

        FA_400 : full_adder
            PORT MAP(
                A     => FA_carry(399),
                B     => FA_out(331),
                C_IN  => FA_out(330),
                SUM   => FA_out(400),
                C_OUT => FA_carry(400));

        FA_401 : full_adder
            PORT MAP(
                A     => FA_carry(400),
                B     => FA_out(333),
                C_IN  => FA_out(332),
                SUM   => FA_out(401),
                C_OUT => FA_carry(401));

        FA_402 : full_adder
            PORT MAP(
                A     => FA_carry(401),
                B     => FA_out(335),
                C_IN  => FA_out(334),
                SUM   => FA_out(402),
                C_OUT => FA_carry(402));

        FA_403 : full_adder
            PORT MAP(
                A     => FA_carry(402),
                B     => FA_out(337),
                C_IN  => FA_out(336),
                SUM   => FA_out(403),
                C_OUT => FA_carry(403));

        FA_404 : full_adder
            PORT MAP(
                A     => FA_carry(403),
                B     => FA_out(339),
                C_IN  => FA_out(338),
                SUM   => FA_out(404),
                C_OUT => FA_carry(404));

        FA_405 : full_adder
            PORT MAP(
                A     => FA_carry(404),
                B     => FA_out(341),
                C_IN  => FA_out(340),
                SUM   => FA_out(405),
                C_OUT => FA_carry(405));

        FA_406 : full_adder
            PORT MAP(
                A     => FA_carry(405),
                B     => FA_out(343),
                C_IN  => FA_out(342),
                SUM   => FA_out(406),
                C_OUT => FA_carry(406));

        FA_407 : full_adder
            PORT MAP(
                A     => FA_carry(406),
                B     => FA_out(345),
                C_IN  => FA_out(344),
                SUM   => FA_out(407),
                C_OUT => FA_carry(407));

        FA_408 : full_adder
            PORT MAP(
                A     => FA_carry(407),
                B     => FA_out(347),
                C_IN  => FA_out(346),
                SUM   => FA_out(408),
                C_OUT => FA_carry(408));

        FA_409 : full_adder
            PORT MAP(
                A     => FA_carry(408),
                B     => FA_out(349),
                C_IN  => FA_out(348),
                SUM   => FA_out(409),
                C_OUT => FA_carry(409));

        FA_410 : full_adder
            PORT MAP(
                A     => FA_carry(409),
                B     => FA_out(351),
                C_IN  => FA_out(350),
                SUM   => FA_out(410),
                C_OUT => FA_carry(410));

        FA_411 : full_adder
            PORT MAP(
                A     => FA_carry(410),
                B     => FA_out(353),
                C_IN  => FA_out(352),
                SUM   => FA_out(411),
                C_OUT => FA_carry(411));

        FA_412 : full_adder
            PORT MAP(
                A     => FA_carry(411),
                B     => FA_out(355),
                C_IN  => FA_out(354),
                SUM   => FA_out(412),
                C_OUT => FA_carry(412));

        FA_413 : full_adder
            PORT MAP(
                A     => FA_carry(412),
                B     => FA_out(357),
                C_IN  => FA_out(356),
                SUM   => FA_out(413),
                C_OUT => FA_carry(413));

        FA_414 : full_adder
            PORT MAP(
                A     => FA_carry(413),
                B     => FA_out(359),
                C_IN  => FA_out(358),
                SUM   => FA_out(414),
                C_OUT => FA_carry(414));

        FA_415 : full_adder
            PORT MAP(
                A     => FA_carry(414),
                B     => FA_out(361),
                C_IN  => FA_out(360),
                SUM   => FA_out(415),
                C_OUT => FA_carry(415));

        FA_416 : full_adder
            PORT MAP(
                A     => FA_carry(415),
                B     => FA_out(362),
                C_IN  => HA_out(37),
                SUM   => FA_out(416),
                C_OUT => FA_carry(416));

        FA_417 : full_adder
            PORT MAP(
                A     => FA_carry(416),
                B     => FA_out(363),
                C_IN  => parprod(14)(33),
                SUM   => FA_out(417),
                C_OUT => FA_carry(417));

        FA_418 : full_adder
            PORT MAP(
                A     => FA_carry(417),
                B     => HA_out(38),
                C_IN  => parprod(14)(34),
                SUM   => FA_out(418),
                C_OUT => FA_carry(418));

        FA_419 : full_adder
            PORT MAP(
                A     => FA_carry(418),
                B     => HA_carry(38),
                C_IN  => parprod(14)(35),
                SUM   => FA_out(419),
                C_OUT => FA_carry(419));

        FA_420 : full_adder
            PORT MAP(
                A     => HA_carry(43),
                B     => HA_out(39),
                C_IN  => parprod(2)(2),
                SUM   => FA_out(420),
                C_OUT => FA_carry(420));

        FA_421 : full_adder
            PORT MAP(
                A     => FA_carry(420),
                B     => HA_out(40),
                C_IN  => parprod(1)(5),
                SUM   => FA_out(421),
                C_OUT => FA_carry(421));

        FA_422 : full_adder
            PORT MAP(
                A     => FA_carry(421),
                B     => FA_out(364),
                C_IN  => parprod(3)(2),
                SUM   => FA_out(422),
                C_OUT => FA_carry(422));

        FA_423 : full_adder
            PORT MAP(
                A     => FA_carry(422),
                B     => FA_out(365),
                C_IN  => parprod(2)(5),
                SUM   => FA_out(423),
                C_OUT => FA_carry(423));

        FA_424 : full_adder
            PORT MAP(
                A     => FA_carry(423),
                B     => FA_out(366),
                C_IN  => parprod(4)(2),
                SUM   => FA_out(424),
                C_OUT => FA_carry(424));

        FA_425 : full_adder
            PORT MAP(
                A     => FA_carry(424),
                B     => FA_out(367),
                C_IN  => parprod(3)(5),
                SUM   => FA_out(425),
                C_OUT => FA_carry(425));

        FA_426 : full_adder
            PORT MAP(
                A     => FA_carry(425),
                B     => FA_out(368),
                C_IN  => parprod(5)(2),
                SUM   => FA_out(426),
                C_OUT => FA_carry(426));

        FA_427 : full_adder
            PORT MAP(
                A     => FA_carry(426),
                B     => FA_out(369),
                C_IN  => parprod(4)(5),
                SUM   => FA_out(427),
                C_OUT => FA_carry(427));

        FA_428 : full_adder
            PORT MAP(
                A     => FA_carry(427),
                B     => FA_out(370),
                C_IN  => parprod(6)(2),
                SUM   => FA_out(428),
                C_OUT => FA_carry(428));

        FA_429 : full_adder
            PORT MAP(
                A     => FA_carry(428),
                B     => FA_out(371),
                C_IN  => parprod(5)(5),
                SUM   => FA_out(429),
                C_OUT => FA_carry(429));

        FA_430 : full_adder
            PORT MAP(
                A     => FA_carry(429),
                B     => FA_out(372),
                C_IN  => parprod(7)(2),
                SUM   => FA_out(430),
                C_OUT => FA_carry(430));

        FA_431 : full_adder
            PORT MAP(
                A     => FA_carry(430),
                B     => FA_out(373),
                C_IN  => parprod(6)(5),
                SUM   => FA_out(431),
                C_OUT => FA_carry(431));

        FA_432 : full_adder
            PORT MAP(
                A     => FA_carry(431),
                B     => FA_out(374),
                C_IN  => parprod(8)(2),
                SUM   => FA_out(432),
                C_OUT => FA_carry(432));

        FA_433 : full_adder
            PORT MAP(
                A     => FA_carry(432),
                B     => FA_out(375),
                C_IN  => parprod(7)(5),
                SUM   => FA_out(433),
                C_OUT => FA_carry(433));

        FA_434 : full_adder
            PORT MAP(
                A     => FA_carry(433),
                B     => FA_out(376),
                C_IN  => parprod(9)(2),
                SUM   => FA_out(434),
                C_OUT => FA_carry(434));

        FA_435 : full_adder
            PORT MAP(
                A     => FA_carry(434),
                B     => FA_out(377),
                C_IN  => parprod(8)(5),
                SUM   => FA_out(435),
                C_OUT => FA_carry(435));

        FA_436 : full_adder
            PORT MAP(
                A     => FA_carry(435),
                B     => FA_out(378),
                C_IN  => parprod(10)(2),
                SUM   => FA_out(436),
                C_OUT => FA_carry(436));

        FA_437 : full_adder
            PORT MAP(
                A     => FA_carry(436),
                B     => FA_out(379),
                C_IN  => parprod(9)(5),
                SUM   => FA_out(437),
                C_OUT => FA_carry(437));

        FA_438 : full_adder
            PORT MAP(
                A     => FA_carry(437),
                B     => FA_out(380),
                C_IN  => parprod(11)(2),
                SUM   => FA_out(438),
                C_OUT => FA_carry(438));

        FA_439 : full_adder
            PORT MAP(
                A     => FA_carry(438),
                B     => FA_out(381),
                C_IN  => parprod(10)(5),
                SUM   => FA_out(439),
                C_OUT => FA_carry(439));

        FA_440 : full_adder
            PORT MAP(
                A     => FA_carry(439),
                B     => FA_out(382),
                C_IN  => parprod(12)(2),
                SUM   => FA_out(440),
                C_OUT => FA_carry(440));

        FA_441 : full_adder
            PORT MAP(
                A     => FA_carry(440),
                B     => FA_out(383),
                C_IN  => parprod(11)(5),
                SUM   => FA_out(441),
                C_OUT => FA_carry(441));

        FA_442 : full_adder
            PORT MAP(
                A     => FA_carry(441),
                B     => FA_out(384),
                C_IN  => parprod(13)(2),
                SUM   => FA_out(442),
                C_OUT => FA_carry(442));

        FA_443 : full_adder
            PORT MAP(
                A     => FA_carry(442),
                B     => FA_out(385),
                C_IN  => parprod(12)(5),
                SUM   => FA_out(443),
                C_OUT => FA_carry(443));

        FA_444 : full_adder
            PORT MAP(
                A     => FA_carry(443),
                B     => FA_out(386),
                C_IN  => parprod(14)(2),
                SUM   => FA_out(444),
                C_OUT => FA_carry(444));

        FA_445 : full_adder
            PORT MAP(
                A     => FA_carry(444),
                B     => FA_out(387),
                C_IN  => parprod(13)(5),
                SUM   => FA_out(445),
                C_OUT => FA_carry(445));

        FA_446 : full_adder
            PORT MAP(
                A     => FA_carry(445),
                B     => FA_out(388),
                C_IN  => parprod(15)(2),
                SUM   => FA_out(446),
                C_OUT => FA_carry(446));

        FA_447 : full_adder
            PORT MAP(
                A     => FA_carry(446),
                B     => FA_out(389),
                C_IN  => parprod(14)(5),
                SUM   => FA_out(447),
                C_OUT => FA_carry(447));

        FA_448 : full_adder
            PORT MAP(
                A     => FA_carry(447),
                B     => FA_out(390),
                C_IN  => parprod(15)(4),
                SUM   => FA_out(448),
                C_OUT => FA_carry(448));

        FA_449 : full_adder
            PORT MAP(
                A     => FA_carry(448),
                B     => FA_out(391),
                C_IN  => parprod(15)(5),
                SUM   => FA_out(449),
                C_OUT => FA_carry(449));

        FA_450 : full_adder
            PORT MAP(
                A     => FA_carry(449),
                B     => FA_out(392),
                C_IN  => parprod(15)(6),
                SUM   => FA_out(450),
                C_OUT => FA_carry(450));

        FA_451 : full_adder
            PORT MAP(
                A     => FA_carry(450),
                B     => FA_out(393),
                C_IN  => parprod(15)(7),
                SUM   => FA_out(451),
                C_OUT => FA_carry(451));

        FA_452 : full_adder
            PORT MAP(
                A     => FA_carry(451),
                B     => FA_out(394),
                C_IN  => parprod(15)(8),
                SUM   => FA_out(452),
                C_OUT => FA_carry(452));

        FA_453 : full_adder
            PORT MAP(
                A     => FA_carry(452),
                B     => FA_out(395),
                C_IN  => parprod(15)(9),
                SUM   => FA_out(453),
                C_OUT => FA_carry(453));

        FA_454 : full_adder
            PORT MAP(
                A     => FA_carry(453),
                B     => FA_out(396),
                C_IN  => parprod(15)(10),
                SUM   => FA_out(454),
                C_OUT => FA_carry(454));

        FA_455 : full_adder
            PORT MAP(
                A     => FA_carry(454),
                B     => FA_out(397),
                C_IN  => parprod(15)(11),
                SUM   => FA_out(455),
                C_OUT => FA_carry(455));

        FA_456 : full_adder
            PORT MAP(
                A     => FA_carry(455),
                B     => FA_out(398),
                C_IN  => parprod(15)(12),
                SUM   => FA_out(456),
                C_OUT => FA_carry(456));

        FA_457 : full_adder
            PORT MAP(
                A     => FA_carry(456),
                B     => FA_out(399),
                C_IN  => parprod(15)(13),
                SUM   => FA_out(457),
                C_OUT => FA_carry(457));

        FA_458 : full_adder
            PORT MAP(
                A     => FA_carry(457),
                B     => FA_out(400),
                C_IN  => parprod(15)(14),
                SUM   => FA_out(458),
                C_OUT => FA_carry(458));

        FA_459 : full_adder
            PORT MAP(
                A     => FA_carry(458),
                B     => FA_out(401),
                C_IN  => parprod(15)(15),
                SUM   => FA_out(459),
                C_OUT => FA_carry(459));

        FA_460 : full_adder
            PORT MAP(
                A     => FA_carry(459),
                B     => FA_out(402),
                C_IN  => parprod(15)(16),
                SUM   => FA_out(460),
                C_OUT => FA_carry(460));

        FA_461 : full_adder
            PORT MAP(
                A     => FA_carry(460),
                B     => FA_out(403),
                C_IN  => parprod(15)(17),
                SUM   => FA_out(461),
                C_OUT => FA_carry(461));

        FA_462 : full_adder
            PORT MAP(
                A     => FA_carry(461),
                B     => FA_out(404),
                C_IN  => parprod(15)(18),
                SUM   => FA_out(462),
                C_OUT => FA_carry(462));

        FA_463 : full_adder
            PORT MAP(
                A     => FA_carry(462),
                B     => FA_out(405),
                C_IN  => parprod(15)(19),
                SUM   => FA_out(463),
                C_OUT => FA_carry(463));

        FA_464 : full_adder
            PORT MAP(
                A     => FA_carry(463),
                B     => FA_out(406),
                C_IN  => parprod(15)(20),
                SUM   => FA_out(464),
                C_OUT => FA_carry(464));

        FA_465 : full_adder
            PORT MAP(
                A     => FA_carry(464),
                B     => FA_out(407),
                C_IN  => parprod(15)(21),
                SUM   => FA_out(465),
                C_OUT => FA_carry(465));

        FA_466 : full_adder
            PORT MAP(
                A     => FA_carry(465),
                B     => FA_out(408),
                C_IN  => parprod(15)(22),
                SUM   => FA_out(466),
                C_OUT => FA_carry(466));

        FA_467 : full_adder
            PORT MAP(
                A     => FA_carry(466),
                B     => FA_out(409),
                C_IN  => parprod(15)(23),
                SUM   => FA_out(467),
                C_OUT => FA_carry(467));

        FA_468 : full_adder
            PORT MAP(
                A     => FA_carry(467),
                B     => FA_out(410),
                C_IN  => parprod(15)(24),
                SUM   => FA_out(468),
                C_OUT => FA_carry(468));

        FA_469 : full_adder
            PORT MAP(
                A     => FA_carry(468),
                B     => FA_out(411),
                C_IN  => parprod(15)(25),
                SUM   => FA_out(469),
                C_OUT => FA_carry(469));

        FA_470 : full_adder
            PORT MAP(
                A     => FA_carry(469),
                B     => FA_out(412),
                C_IN  => parprod(15)(26),
                SUM   => FA_out(470),
                C_OUT => FA_carry(470));

        FA_471 : full_adder
            PORT MAP(
                A     => FA_carry(470),
                B     => FA_out(413),
                C_IN  => parprod(15)(27),
                SUM   => FA_out(471),
                C_OUT => FA_carry(471));

        FA_472 : full_adder
            PORT MAP(
                A     => FA_carry(471),
                B     => FA_out(414),
                C_IN  => parprod(15)(28),
                SUM   => FA_out(472),
                C_OUT => FA_carry(472));

        FA_473 : full_adder
            PORT MAP(
                A     => FA_carry(472),
                B     => FA_out(415),
                C_IN  => parprod(15)(29),
                SUM   => FA_out(473),
                C_OUT => FA_carry(473));

        FA_474 : full_adder
            PORT MAP(
                A     => FA_carry(473),
                B     => FA_out(416),
                C_IN  => parprod(15)(30),
                SUM   => FA_out(474),
                C_OUT => FA_carry(474));

        FA_475 : full_adder
            PORT MAP(
                A     => FA_carry(474),
                B     => FA_out(417),
                C_IN  => parprod(15)(31),
                SUM   => FA_out(475),
                C_OUT => FA_carry(475));

        FA_476 : full_adder
            PORT MAP(
                A     => FA_carry(475),
                B     => FA_out(418),
                C_IN  => parprod(15)(32),
                SUM   => FA_out(476),
                C_OUT => FA_carry(476));

        FA_477 : full_adder
            PORT MAP(
                A     => FA_carry(476),
                B     => FA_out(419),
                C_IN  => parprod(15)(33),
                SUM   => FA_out(477),
                C_OUT => FA_carry(477));

        FA_478 : full_adder
            PORT MAP(
                A     => FA_carry(477),
                B     => HA_out(41),
                C_IN  => parprod(15)(34),
                SUM   => FA_out(478),
                C_OUT => FA_carry(478));

        FA_479 : full_adder
            PORT MAP(
                A     => FA_carry(478),
                B     => HA_carry(41),
                C_IN  => parprod(15)(35),
                SUM   => FA_out(479),
                C_OUT => FA_carry(479));

        FA_480 : full_adder
            PORT MAP(
                A     => HA_carry(45),
                B     => HA_out(42),
                C_IN  => parprod(2)(0),
                SUM   => FA_out(480),
                C_OUT => FA_carry(480));

        FA_481 : full_adder
            PORT MAP(
                A     => FA_carry(480),
                B     => HA_out(43),
                C_IN  => parprod(1)(3),
                SUM   => FA_out(481),
                C_OUT => FA_carry(481));

        FA_482 : full_adder
            PORT MAP(
                A     => FA_carry(481),
                B     => FA_out(420),
                C_IN  => parprod(3)(0),
                SUM   => FA_out(482),
                C_OUT => FA_carry(482));

        FA_483 : full_adder
            PORT MAP(
                A     => FA_carry(482),
                B     => FA_out(421),
                C_IN  => parprod(2)(3),
                SUM   => FA_out(483),
                C_OUT => FA_carry(483));

        FA_484 : full_adder
            PORT MAP(
                A     => FA_carry(483),
                B     => FA_out(422),
                C_IN  => parprod(4)(0),
                SUM   => FA_out(484),
                C_OUT => FA_carry(484));

        FA_485 : full_adder
            PORT MAP(
                A     => FA_carry(484),
                B     => FA_out(423),
                C_IN  => parprod(3)(3),
                SUM   => FA_out(485),
                C_OUT => FA_carry(485));

        FA_486 : full_adder
            PORT MAP(
                A     => FA_carry(485),
                B     => FA_out(424),
                C_IN  => parprod(5)(0),
                SUM   => FA_out(486),
                C_OUT => FA_carry(486));

        FA_487 : full_adder
            PORT MAP(
                A     => FA_carry(486),
                B     => FA_out(425),
                C_IN  => parprod(4)(3),
                SUM   => FA_out(487),
                C_OUT => FA_carry(487));

        FA_488 : full_adder
            PORT MAP(
                A     => FA_carry(487),
                B     => FA_out(426),
                C_IN  => parprod(6)(0),
                SUM   => FA_out(488),
                C_OUT => FA_carry(488));

        FA_489 : full_adder
            PORT MAP(
                A     => FA_carry(488),
                B     => FA_out(427),
                C_IN  => parprod(5)(3),
                SUM   => FA_out(489),
                C_OUT => FA_carry(489));

        FA_490 : full_adder
            PORT MAP(
                A     => FA_carry(489),
                B     => FA_out(428),
                C_IN  => parprod(7)(0),
                SUM   => FA_out(490),
                C_OUT => FA_carry(490));

        FA_491 : full_adder
            PORT MAP(
                A     => FA_carry(490),
                B     => FA_out(429),
                C_IN  => parprod(6)(3),
                SUM   => FA_out(491),
                C_OUT => FA_carry(491));

        FA_492 : full_adder
            PORT MAP(
                A     => FA_carry(491),
                B     => FA_out(430),
                C_IN  => parprod(8)(0),
                SUM   => FA_out(492),
                C_OUT => FA_carry(492));

        FA_493 : full_adder
            PORT MAP(
                A     => FA_carry(492),
                B     => FA_out(431),
                C_IN  => parprod(7)(3),
                SUM   => FA_out(493),
                C_OUT => FA_carry(493));

        FA_494 : full_adder
            PORT MAP(
                A     => FA_carry(493),
                B     => FA_out(432),
                C_IN  => parprod(9)(0),
                SUM   => FA_out(494),
                C_OUT => FA_carry(494));

        FA_495 : full_adder
            PORT MAP(
                A     => FA_carry(494),
                B     => FA_out(433),
                C_IN  => parprod(8)(3),
                SUM   => FA_out(495),
                C_OUT => FA_carry(495));

        FA_496 : full_adder
            PORT MAP(
                A     => FA_carry(495),
                B     => FA_out(434),
                C_IN  => parprod(10)(0),
                SUM   => FA_out(496),
                C_OUT => FA_carry(496));

        FA_497 : full_adder
            PORT MAP(
                A     => FA_carry(496),
                B     => FA_out(435),
                C_IN  => parprod(9)(3),
                SUM   => FA_out(497),
                C_OUT => FA_carry(497));

        FA_498 : full_adder
            PORT MAP(
                A     => FA_carry(497),
                B     => FA_out(436),
                C_IN  => parprod(11)(0),
                SUM   => FA_out(498),
                C_OUT => FA_carry(498));

        FA_499 : full_adder
            PORT MAP(
                A     => FA_carry(498),
                B     => FA_out(437),
                C_IN  => parprod(10)(3),
                SUM   => FA_out(499),
                C_OUT => FA_carry(499));

        FA_500 : full_adder
            PORT MAP(
                A     => FA_carry(499),
                B     => FA_out(438),
                C_IN  => parprod(12)(0),
                SUM   => FA_out(500),
                C_OUT => FA_carry(500));

        FA_501 : full_adder
            PORT MAP(
                A     => FA_carry(500),
                B     => FA_out(439),
                C_IN  => parprod(11)(3),
                SUM   => FA_out(501),
                C_OUT => FA_carry(501));

        FA_502 : full_adder
            PORT MAP(
                A     => FA_carry(501),
                B     => FA_out(440),
                C_IN  => parprod(13)(0),
                SUM   => FA_out(502),
                C_OUT => FA_carry(502));

        FA_503 : full_adder
            PORT MAP(
                A     => FA_carry(502),
                B     => FA_out(441),
                C_IN  => parprod(12)(3),
                SUM   => FA_out(503),
                C_OUT => FA_carry(503));

        FA_504 : full_adder
            PORT MAP(
                A     => FA_carry(503),
                B     => FA_out(442),
                C_IN  => parprod(14)(0),
                SUM   => FA_out(504),
                C_OUT => FA_carry(504));

        FA_505 : full_adder
            PORT MAP(
                A     => FA_carry(504),
                B     => FA_out(443),
                C_IN  => parprod(13)(3),
                SUM   => FA_out(505),
                C_OUT => FA_carry(505));

        FA_506 : full_adder
            PORT MAP(
                A     => FA_carry(505),
                B     => FA_out(444),
                C_IN  => parprod(15)(0),
                SUM   => FA_out(506),
                C_OUT => FA_carry(506));

        FA_507 : full_adder
            PORT MAP(
                A     => FA_carry(506),
                B     => FA_out(445),
                C_IN  => parprod(14)(3),
                SUM   => FA_out(507),
                C_OUT => FA_carry(507));

        FA_508 : full_adder
            PORT MAP(
                A     => FA_carry(507),
                B     => FA_out(446),
                C_IN  => parprod(16)(0),
                SUM   => FA_out(508),
                C_OUT => FA_carry(508));

        FA_509 : full_adder
            PORT MAP(
                A     => FA_carry(508),
                B     => FA_out(447),
                C_IN  => parprod(15)(3),
                SUM   => FA_out(509),
                C_OUT => FA_carry(509));

        FA_510 : full_adder
            PORT MAP(
                A     => FA_carry(509),
                B     => FA_out(448),
                C_IN  => parprod(16)(2),
                SUM   => FA_out(510),
                C_OUT => FA_carry(510));

        FA_511 : full_adder
            PORT MAP(
                A     => FA_carry(510),
                B     => FA_out(449),
                C_IN  => parprod(16)(3),
                SUM   => FA_out(511),
                C_OUT => FA_carry(511));

        FA_512 : full_adder
            PORT MAP(
                A     => FA_carry(511),
                B     => FA_out(450),
                C_IN  => parprod(16)(4),
                SUM   => FA_out(512),
                C_OUT => FA_carry(512));

        FA_513 : full_adder
            PORT MAP(
                A     => FA_carry(512),
                B     => FA_out(451),
                C_IN  => parprod(16)(5),
                SUM   => FA_out(513),
                C_OUT => FA_carry(513));

        FA_514 : full_adder
            PORT MAP(
                A     => FA_carry(513),
                B     => FA_out(452),
                C_IN  => parprod(16)(6),
                SUM   => FA_out(514),
                C_OUT => FA_carry(514));

        FA_515 : full_adder
            PORT MAP(
                A     => FA_carry(514),
                B     => FA_out(453),
                C_IN  => parprod(16)(7),
                SUM   => FA_out(515),
                C_OUT => FA_carry(515));

        FA_516 : full_adder
            PORT MAP(
                A     => FA_carry(515),
                B     => FA_out(454),
                C_IN  => parprod(16)(8),
                SUM   => FA_out(516),
                C_OUT => FA_carry(516));

        FA_517 : full_adder
            PORT MAP(
                A     => FA_carry(516),
                B     => FA_out(455),
                C_IN  => parprod(16)(9),
                SUM   => FA_out(517),
                C_OUT => FA_carry(517));

        FA_518 : full_adder
            PORT MAP(
                A     => FA_carry(517),
                B     => FA_out(456),
                C_IN  => parprod(16)(10),
                SUM   => FA_out(518),
                C_OUT => FA_carry(518));

        FA_519 : full_adder
            PORT MAP(
                A     => FA_carry(518),
                B     => FA_out(457),
                C_IN  => parprod(16)(11),
                SUM   => FA_out(519),
                C_OUT => FA_carry(519));

        FA_520 : full_adder
            PORT MAP(
                A     => FA_carry(519),
                B     => FA_out(458),
                C_IN  => parprod(16)(12),
                SUM   => FA_out(520),
                C_OUT => FA_carry(520));

        FA_521 : full_adder
            PORT MAP(
                A     => FA_carry(520),
                B     => FA_out(459),
                C_IN  => parprod(16)(13),
                SUM   => FA_out(521),
                C_OUT => FA_carry(521));

        FA_522 : full_adder
            PORT MAP(
                A     => FA_carry(521),
                B     => FA_out(460),
                C_IN  => parprod(16)(14),
                SUM   => FA_out(522),
                C_OUT => FA_carry(522));

        FA_523 : full_adder
            PORT MAP(
                A     => FA_carry(522),
                B     => FA_out(461),
                C_IN  => parprod(16)(15),
                SUM   => FA_out(523),
                C_OUT => FA_carry(523));

        FA_524 : full_adder
            PORT MAP(
                A     => FA_carry(523),
                B     => FA_out(462),
                C_IN  => parprod(16)(16),
                SUM   => FA_out(524),
                C_OUT => FA_carry(524));

        FA_525 : full_adder
            PORT MAP(
                A     => FA_carry(524),
                B     => FA_out(463),
                C_IN  => parprod(16)(17),
                SUM   => FA_out(525),
                C_OUT => FA_carry(525));

        FA_526 : full_adder
            PORT MAP(
                A     => FA_carry(525),
                B     => FA_out(464),
                C_IN  => parprod(16)(18),
                SUM   => FA_out(526),
                C_OUT => FA_carry(526));

        FA_527 : full_adder
            PORT MAP(
                A     => FA_carry(526),
                B     => FA_out(465),
                C_IN  => parprod(16)(19),
                SUM   => FA_out(527),
                C_OUT => FA_carry(527));

        FA_528 : full_adder
            PORT MAP(
                A     => FA_carry(527),
                B     => FA_out(466),
                C_IN  => parprod(16)(20),
                SUM   => FA_out(528),
                C_OUT => FA_carry(528));

        FA_529 : full_adder
            PORT MAP(
                A     => FA_carry(528),
                B     => FA_out(467),
                C_IN  => parprod(16)(21),
                SUM   => FA_out(529),
                C_OUT => FA_carry(529));

        FA_530 : full_adder
            PORT MAP(
                A     => FA_carry(529),
                B     => FA_out(468),
                C_IN  => parprod(16)(22),
                SUM   => FA_out(530),
                C_OUT => FA_carry(530));

        FA_531 : full_adder
            PORT MAP(
                A     => FA_carry(530),
                B     => FA_out(469),
                C_IN  => parprod(16)(23),
                SUM   => FA_out(531),
                C_OUT => FA_carry(531));

        FA_532 : full_adder
            PORT MAP(
                A     => FA_carry(531),
                B     => FA_out(470),
                C_IN  => parprod(16)(24),
                SUM   => FA_out(532),
                C_OUT => FA_carry(532));

        FA_533 : full_adder
            PORT MAP(
                A     => FA_carry(532),
                B     => FA_out(471),
                C_IN  => parprod(16)(25),
                SUM   => FA_out(533),
                C_OUT => FA_carry(533));

        FA_534 : full_adder
            PORT MAP(
                A     => FA_carry(533),
                B     => FA_out(472),
                C_IN  => parprod(16)(26),
                SUM   => FA_out(534),
                C_OUT => FA_carry(534));

        FA_535 : full_adder
            PORT MAP(
                A     => FA_carry(534),
                B     => FA_out(473),
                C_IN  => parprod(16)(27),
                SUM   => FA_out(535),
                C_OUT => FA_carry(535));

        FA_536 : full_adder
            PORT MAP(
                A     => FA_carry(535),
                B     => FA_out(474),
                C_IN  => parprod(16)(28),
                SUM   => FA_out(536),
                C_OUT => FA_carry(536));

        FA_537 : full_adder
            PORT MAP(
                A     => FA_carry(536),
                B     => FA_out(475),
                C_IN  => parprod(16)(29),
                SUM   => FA_out(537),
                C_OUT => FA_carry(537));

        FA_538 : full_adder
            PORT MAP(
                A     => FA_carry(537),
                B     => FA_out(476),
                C_IN  => parprod(16)(30),
                SUM   => FA_out(538),
                C_OUT => FA_carry(538));

        FA_539 : full_adder
            PORT MAP(
                A     => FA_carry(538),
                B     => FA_out(477),
                C_IN  => parprod(16)(31),
                SUM   => FA_out(539),
                C_OUT => FA_carry(539));

        FA_540 : full_adder
            PORT MAP(
                A     => FA_carry(539),
                B     => FA_out(478),
                C_IN  => parprod(16)(32),
                SUM   => FA_out(540),
                C_OUT => FA_carry(540));

        FA_541 : full_adder
            PORT MAP(
                A     => FA_carry(540),
                B     => FA_out(479),
                C_IN  => parprod(16)(33),
                SUM   => FA_out(541),
                C_OUT => FA_carry(541));

        HA_0 : half_adder
            PORT MAP(
                A     => parprod(0)(24),
                B     => parprod(1)(24),
                SUM   => HA_out(0),
                C_OUT => HA_carry(0));

        HA_1 : half_adder
            PORT MAP(
                A     => HA_carry(0),
                B     => parprod(0)(25),
                SUM   => HA_out(1),
                C_OUT => HA_carry(1));

        HA_2 : half_adder
            PORT MAP(
                A     => HA_carry(1),
                B     => parprod(0)(26),
                SUM   => HA_out(2),
                C_OUT => HA_carry(2));

        HA_3 : half_adder
            PORT MAP(
                A     => FA_carry(0),
                B     => HA_carry(2),
                SUM   => HA_out(3),
                C_OUT => HA_carry(3));

        HA_4 : half_adder
            PORT MAP(
                A     => FA_carry(1),
                B     => HA_carry(3),
                SUM   => HA_out(4),
                C_OUT => HA_carry(4));

        HA_5 : half_adder
            PORT MAP(
                A     => FA_carry(3),
                B     => FA_carry(2),
                SUM   => HA_out(5),
                C_OUT => HA_carry(5));

        HA_6 : half_adder
            PORT MAP(
                A     => FA_carry(5),
                B     => FA_carry(4),
                SUM   => HA_out(6),
                C_OUT => HA_carry(6));

        HA_7 : half_adder
            PORT MAP(
                A     => FA_carry(8),
                B     => FA_carry(7),
                SUM   => HA_out(7),
                C_OUT => HA_carry(7));

        HA_8 : half_adder
            PORT MAP(
                A     => FA_carry(27),
                B     => FA_carry(26),
                SUM   => HA_out(8),
                C_OUT => HA_carry(8));

        HA_9 : half_adder
            PORT MAP(
                A     => FA_carry(33),
                B     => FA_carry(32),
                SUM   => HA_out(9),
                C_OUT => HA_carry(9));

        HA_10 : half_adder
            PORT MAP(
                A     => FA_carry(37),
                B     => FA_carry(36),
                SUM   => HA_out(10),
                C_OUT => HA_carry(10));

        HA_11 : half_adder
            PORT MAP(
                A     => FA_carry(39),
                B     => parprod(4)(36),
                SUM   => HA_out(11),
                C_OUT => HA_carry(11));

        HA_12 : half_adder
            PORT MAP(
                A     => parprod(0)(16),
                B     => parprod(1)(16),
                SUM   => HA_out(12),
                C_OUT => HA_carry(12));

        HA_13 : half_adder
            PORT MAP(
                A     => HA_carry(12),
                B     => parprod(0)(17),
                SUM   => HA_out(13),
                C_OUT => HA_carry(13));

        HA_14 : half_adder
            PORT MAP(
                A     => HA_carry(13),
                B     => parprod(0)(18),
                SUM   => HA_out(14),
                C_OUT => HA_carry(14));

        HA_15 : half_adder
            PORT MAP(
                A     => FA_carry(40),
                B     => HA_carry(14),
                SUM   => HA_out(15),
                C_OUT => HA_carry(15));

        HA_16 : half_adder
            PORT MAP(
                A     => FA_carry(41),
                B     => HA_carry(15),
                SUM   => HA_out(16),
                C_OUT => HA_carry(16));

        HA_17 : half_adder
            PORT MAP(
                A     => FA_carry(43),
                B     => FA_carry(42),
                SUM   => HA_out(17),
                C_OUT => HA_carry(17));

        HA_18 : half_adder
            PORT MAP(
                A     => FA_carry(45),
                B     => FA_carry(44),
                SUM   => HA_out(18),
                C_OUT => HA_carry(18));

        HA_19 : half_adder
            PORT MAP(
                A     => FA_carry(48),
                B     => FA_carry(47),
                SUM   => HA_out(19),
                C_OUT => HA_carry(19));

        HA_20 : half_adder
            PORT MAP(
                A     => FA_carry(131),
                B     => FA_carry(130),
                SUM   => HA_out(20),
                C_OUT => HA_carry(20));

        HA_21 : half_adder
            PORT MAP(
                A     => FA_carry(137),
                B     => FA_carry(136),
                SUM   => HA_out(21),
                C_OUT => HA_carry(21));

        HA_22 : half_adder
            PORT MAP(
                A     => FA_carry(141),
                B     => FA_carry(140),
                SUM   => HA_out(22),
                C_OUT => HA_carry(22));

        HA_23 : half_adder
            PORT MAP(
                A     => FA_carry(143),
                B     => parprod(8)(36),
                SUM   => HA_out(23),
                C_OUT => HA_carry(23));

        HA_24 : half_adder
            PORT MAP(
                A     => parprod(0)(10),
                B     => parprod(1)(10),
                SUM   => HA_out(24),
                C_OUT => HA_carry(24));

        HA_25 : half_adder
            PORT MAP(
                A     => HA_carry(24),
                B     => parprod(0)(11),
                SUM   => HA_out(25),
                C_OUT => HA_carry(25));

        HA_26 : half_adder
            PORT MAP(
                A     => HA_carry(25),
                B     => parprod(0)(12),
                SUM   => HA_out(26),
                C_OUT => HA_carry(26));

        HA_27 : half_adder
            PORT MAP(
                A     => FA_carry(144),
                B     => HA_carry(26),
                SUM   => HA_out(27),
                C_OUT => HA_carry(27));

        HA_28 : half_adder
            PORT MAP(
                A     => FA_carry(145),
                B     => HA_carry(27),
                SUM   => HA_out(28),
                C_OUT => HA_carry(28));

        HA_29 : half_adder
            PORT MAP(
                A     => FA_carry(147),
                B     => FA_carry(146),
                SUM   => HA_out(29),
                C_OUT => HA_carry(29));

        HA_30 : half_adder
            PORT MAP(
                A     => FA_carry(257),
                B     => FA_carry(256),
                SUM   => HA_out(30),
                C_OUT => HA_carry(30));

        HA_31 : half_adder
            PORT MAP(
                A     => FA_carry(261),
                B     => FA_carry(260),
                SUM   => HA_out(31),
                C_OUT => HA_carry(31));

        HA_32 : half_adder
            PORT MAP(
                A     => FA_carry(263),
                B     => parprod(11)(36),
                SUM   => HA_out(32),
                C_OUT => HA_carry(32));

        HA_33 : half_adder
            PORT MAP(
                A     => parprod(0)(6),
                B     => parprod(1)(6),
                SUM   => HA_out(33),
                C_OUT => HA_carry(33));

        HA_34 : half_adder
            PORT MAP(
                A     => HA_carry(33),
                B     => parprod(0)(7),
                SUM   => HA_out(34),
                C_OUT => HA_carry(34));

        HA_35 : half_adder
            PORT MAP(
                A     => HA_carry(34),
                B     => parprod(0)(8),
                SUM   => HA_out(35),
                C_OUT => HA_carry(35));

        HA_36 : half_adder
            PORT MAP(
                A     => FA_carry(264),
                B     => HA_carry(35),
                SUM   => HA_out(36),
                C_OUT => HA_carry(36));

        HA_37 : half_adder
            PORT MAP(
                A     => FA_carry(361),
                B     => FA_carry(360),
                SUM   => HA_out(37),
                C_OUT => HA_carry(37));

        HA_38 : half_adder
            PORT MAP(
                A     => FA_carry(363),
                B     => parprod(13)(36),
                SUM   => HA_out(38),
                C_OUT => HA_carry(38));

        HA_39 : half_adder
            PORT MAP(
                A     => parprod(0)(4),
                B     => parprod(1)(4),
                SUM   => HA_out(39),
                C_OUT => HA_carry(39));

        HA_40 : half_adder
            PORT MAP(
                A     => HA_carry(39),
                B     => parprod(0)(5),
                SUM   => HA_out(40),
                C_OUT => HA_carry(40));

        HA_41 : half_adder
            PORT MAP(
                A     => FA_carry(419),
                B     => parprod(14)(36),
                SUM   => HA_out(41),
                C_OUT => HA_carry(41));

        HA_42 : half_adder
            PORT MAP(
                A     => parprod(0)(2),
                B     => parprod(1)(2),
                SUM   => HA_out(42),
                C_OUT => HA_carry(42));

        HA_43 : half_adder
            PORT MAP(
                A     => HA_carry(42),
                B     => parprod(0)(3),
                SUM   => HA_out(43),
                C_OUT => HA_carry(43));

        HA_44 : half_adder
            PORT MAP(
                A     => parprod(0)(0),
                B     => parprod(1)(0),
                SUM   => HA_out(44),
                C_OUT => HA_carry(44));

        HA_45 : half_adder
            PORT MAP(
                A     => HA_carry(44),
                B     => parprod(0)(1),
                SUM   => HA_out(45),
                C_OUT => HA_carry(45));

        P(63 DOWNTO 2) <= UNSIGNED(FA_out(541 DOWNTO 480));
        P(1 DOWNTO 0) <= UNSIGNED(HA_out(45 DOWNTO 44));
END ARCHITECTURE;

