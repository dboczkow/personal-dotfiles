#if __has_include(<dt-bindings/zmk/rgb_colors.h>)
  //
  // Color definitions with conflict guard to prevent
  // accidental redefinition of common abbreviations.
  //
  #if defined(RED) || defined(RED_RGB) || \
      defined(COR) || defined(COR_RGB) || \
      defined(ORN) || defined(ORN_RGB) || \
      defined(GDN) || defined(GDN_RGB) || \
      defined(GOL) || defined(GOL_RGB) || \
      defined(YLW) || defined(YLW_RGB) || \
      defined(CHU) || defined(CHU_RGB) || \
      defined(GRN) || defined(GRN_RGB) || \
      defined(SPG) || defined(SPG_RGB) || \
      defined(CYN) || defined(CYN_RGB) || \
      defined(AZU) || defined(AZU_RGB) || \
      defined(TEA) || defined(TEA_RGB) || \
      defined(TUR) || defined(TUR_RGB) || \
      defined(BLU) || defined(BLU_RGB) || \
      defined(PUR) || defined(PUR_RGB) || \
      defined(MAJ) || defined(MAJ_RGB) || \
      defined(PNK) || defined(PNK_RGB) || \
      defined(WHT) || defined(WHT_RGB) || \
      defined(GRY) || defined(GRY_RGB) || \
      defined(BLK) || defined(BLK_RGB) || \
      defined(C01) || defined(C01_RGB) || \
      defined(C02) || defined(C02_RGB) || \
      defined(C03) || defined(C03_RGB) || \
      defined(C04) || defined(C04_RGB) || \
      defined(C05) || defined(C05_RGB) || \
      defined(C06) || defined(C06_RGB) || \
      defined(C07) || defined(C07_RGB) || \
      defined(C08) || defined(C08_RGB) || \
      defined(C09) || defined(C09_RGB) || \
      defined(C10) || defined(C10_RGB) || \
      defined(C11) || defined(C11_RGB) || \
      defined(C12) || defined(C12_RGB) || \
      defined(C13) || defined(C13_RGB) || \
      defined(___) || \
      defined(DUG) || defined(DUG_RGB) || \
      defined(LAC) || defined(LAC_RGB) || \
      defined(BSL) || defined(BNL) || defined(BCL) || \
      defined(SSL) || defined(SNL) || defined(SCL)
  #error "Naming conflict: 3-letter color abbreviation already defined!"
  #endif

  //
  // color definitions from QMK
  // https://github.com/qmk/qmk_firmware/blob/master/quantum/color.h
  //
  #define RED_RGB 0xFF0000 // #FF0000 RED      => RED (red)
  #define COR_RGB 0xFF7C4D // #FF7C4D CORAL    => COR (coral)
  #define ORN_RGB 0xFF8000 // #FF8000 ORANGE   => ORN (ornj)
  #define GDN_RGB 0xD9A521 // #D9A521 GOLDNROD => GDN (gold'nrod)
  #define GOL_RGB 0xFFD900 // #FFD900 GOLD     => GOL (gold)
  #define YLW_RGB 0xFFFF00 // #FFFF00 YELLOW   => YLW (yellow)
  #define CHU_RGB 0x80FF00 // #80FF00 CHARTRSE => CHU (chartreuse)
  #define GRN_RGB 0x00FF00 // #00FF00 GREEN    => GRN (green)
  #define SPG_RGB 0x00FF80 // #00FF80 SPRINGRN => SPG (spring green)
  #define CYN_RGB 0x00FFFF // #00FFFF CYAN     => CYN (sigh-an)
  #define AZU_RGB 0x99F5FF // #99F5FF AZURE    => AZU (a-zur)
  #define TEA_RGB 0x008080 // #008080 TEAL     => TEA (teel)
  #define TUR_RGB 0x476E6A // #476E6A TURQUOIS => TUR (turquoise)
  #define BLU_RGB 0x0000FF // #0000FF BLUE     => BLU (bloo)
  #define PUR_RGB 0x7A00FF // #7A00FF PURPLE   => PUR (purp)
  #define MAJ_RGB 0xFF00FF // #FF00FF MAGENTA  => MAJ (mah-jenta)
  #define PNK_RGB 0xFF80BF // #FF80BF PINK     => PNK (pink)
  #define WHT_RGB 0xFFFFFF // #FFFFFF WHITE    => WHT (white)
  #define BLK_RGB 0x000000 // #000000 BLACK    => BLK (blak)
  #define GRY_RGB 0x0f0f10 // #C1C1C1 GRAY    => GRY
  #define C01_RGB 0x6100ff
  #define C02_RGB 0x7500ff
  #define C03_RGB 0x8600fe
  #define C04_RGB 0x9500fd
  #define C05_RGB 0xa400fd
  #define C06_RGB 0xb100fc
  #define C07_RGB 0xbe00fb
  #define C08_RGB 0xca00fa
  #define C09_RGB 0xd500f9
  #define C10_RGB 0xe000f8
  #define C11_RGB 0xeb00f7
  #define C12_RGB 0xf500f6
  #define C13_RGB 0xff00f5

  //
  // color definitions from MoErgo
  // https://github.com/moergo-sc/zmk/blob/aca523dfce9b6447ffd19d833b791d44f1f286de/app/src/rgb_underglow.c#L259-L265
  //
  #define DUG_RGB 0x00ff68 // #00ff68 DULL_GRN => DUG (dull green)
  #define LAC_RGB 0x6b1fce // #6b1fce LILAC    => LAC (lilac)

  //
  // underglow for the colors above
  //
  #define RED &ug RED_RGB
  #define COR &ug COR_RGB
  #define ORN &ug ORN_RGB
  #define GDN &ug GDN_RGB
  #define GOL &ug GOL_RGB
  #define YLW &ug YLW_RGB
  #define CHU &ug CHU_RGB
  #define GRN &ug GRN_RGB
  #define SPG &ug SPG_RGB
  #define CYN &ug CYN_RGB
  #define AZU &ug AZU_RGB
  #define TEA &ug TEA_RGB
  #define TUR &ug TUR_RGB
  #define BLU &ug BLU_RGB
  #define PUR &ug PUR_RGB
  #define MAJ &ug MAJ_RGB
  #define PNK &ug PNK_RGB
  #define WHT &ug WHT_RGB
  #define BLK &ug BLK_RGB
  #define GRY &ug GRY_RGB
  #define ___ &ug BLK_RGB
  #define DUG &ug DUG_RGB
  #define LAC &ug LAC_RGB
  #define C01 &ug C01_RGB
  #define C02 &ug C02_RGB
  #define C03 &ug C03_RGB
  #define C04 &ug C04_RGB
  #define C05 &ug C05_RGB
  #define C06 &ug C06_RGB
  #define C07 &ug C07_RGB
  #define C08 &ug C08_RGB
  #define C09 &ug C09_RGB
  #define C10 &ug C10_RGB
  #define C11 &ug C11_RGB
  #define C12 &ug C12_RGB
  #define C13 &ug C13_RGB

  //
  // underglow for keyboard locks on the Base layer
  //
  #define BSL &ug_sl LAC_RGB ORN_RGB // ScrollLock COLOR_OFF COLOR_ON
  #define BNL &ug_nl LAC_RGB ORN_RGB // NumLock    COLOR_OFF COLOR_ON
  #define BCL &ug_cl BLU_RGB ORN_RGB // CapsLock   COLOR_OFF COLOR_ON

  //
  // underglow for keyboard locks on the System layer
  //
  #define SSL &ug_sl BLK_RGB ORN_RGB // ScrollLock COLOR_OFF COLOR_ON
  #define SNL &ug_nl BLK_RGB ORN_RGB // NumLock    COLOR_OFF COLOR_ON
  #define SCL &ug_cl BLK_RGB ORN_RGB // CapsLock   COLOR_OFF COLOR_ON

  //
  // colors for mouse speed scaling in Mouse layers
  //
  #define FST GOL
  #define WRP CHU
  #define SLO COR

  // ==== PER-KEY-RGB <section begins> ====
  / {
    underglow-layer {
      compatible = "zmk,underglow-layer";

      #ifdef LAYER_Base
      Base {
        bindings = <
          C01 C02 C03 C04 C05                                             C05 C04 C03 C02 C01
          C02 C03 C04 C05 C06 C07                                     C07 C06 C05 C04 C03 C02
          C03 C04 C05 C06 C07 C08                                     C08 C07 C06 C05 C04 C03
          C04 C05 C06 C07 C08 C09                                     C09 C08 C07 C06 C05 C04
          C05 C06 C07 C08 C09 C10     C11 C12 C13     C13 C12 C11     C10 C09 C08 C07 C06 C05
          C06 C07 C08 C09 C10         C11 C12 C13     C13 C12 C11         C10 C09 C08 C07 C06
        >;
        layer-id = <LAYER_Base>;
      };
      #endif

      #ifdef LAYER_Lower
      Lower {
        bindings = <
          GRY WHT GOL GRN GOL                                             RED GRY WHT ___ ___
          ___ ___ ___ ___ ___ ___                                     C01 ___ WHT WHT ___ ___
          ___ ___ ___ ___ ___ ___                                     ___ ___ ___ ___ ___ ___
          ___ ___ ___ ___ ___ ___                                     WHT WHT WHT WHT ___ ___
          ___ ___ ___ ___ ___ ___     ___ ___ ___     ___ ___ WHT     ___ ___ ___ ___ ___ ___
          ___ RED ___ ___ ___         ___ ___ ___     ___ ___ ___         ___ ___ ___ ___ ___
        >;
        layer-id = <LAYER_Lower>;
      };
      #endif

      #ifdef LAYER_Gaming
      Gaming {
        bindings = <
          C01 C02 C03 C04 C05                                             ___ ___ ___ ___ ___
          C02 C03 C04 C05 C06 C07                                     ___ ___ ___ ___ ___ ___
          C03 C04 C05 WHT C07 C08                                     ___ ___ ___ ___ ___ ___
          C04 C05 WHT WHT WHT C09                                     ___ ___ ___ ___ ___ ___
          C05 C06 C07 C08 C09 C10     C11 C12 C13     GRN ___ ___     ___ ___ ___ ___ ___ ___
          C06 C07 C08 C09 C10         C11 WHT C13     ___ ___ ___         ___ ___ ___ ___ ___
        >;
        layer-id = <LAYER_Gaming>;
      };
      #endif
      
      #ifdef LAYER_Mouse
      Mouse {
        bindings = <
          ___ ___ ___ ___ ___                                             ___ ___ ___ ___ ___
          ___ ___ ___ ___ ___ ___                                     ___ ___ ___ ___ ___ ___
          ___ ___ ___ ___ ___ ___                                     ___ WHT ___ ___ WHT ___
          ___ ___ ___ WHT WHT WHT                                     WHT WHT WHT WHT ___ ___
          ___ ___ ___ ___ ___ ___     ___ WHT ___     ___ WHT ___     WHT ___ ___ ___ ___ ___
          ___ ___ ___ ___ ___         ___ ___ ___     ___ ___ ___         ___ ___ ___ ___ ___
        >;
        layer-id = <LAYER_Mouse>;
      };
      #endif
    };
  };
  // ==== PER-KEY-RGB <section ends> =====

  #undef RED
  #undef RED_RGB
  #undef COR
  #undef COR_RGB
  #undef ORN
  #undef ORN_RGB
  #undef GDN
  #undef GDN_RGB
  #undef GOL
  #undef GOL_RGB
  #undef YLW
  #undef YLW_RGB
  #undef CHU
  #undef CHU_RGB
  #undef GRN
  #undef GRN_RGB
  #undef SPG
  #undef SPG_RGB
  #undef CYN
  #undef CYN_RGB
  #undef AZU
  #undef AZU_RGB
  #undef TEA
  #undef TEA_RGB
  #undef TUR
  #undef TUR_RGB
  #undef BLU
  #undef BLU_RGB
  #undef PUR
  #undef PUR_RGB
  #undef MAJ
  #undef MAJ_RGB
  #undef PNK
  #undef PNK_RGB
  #undef WHT
  #undef WHT_RGB
  #undef BLK
  #undef BLK_RGB
  #undef GRY
  #undef GRY_RGB
  #undef ___
  #undef DUG
  #undef DUG_RGB
  #undef LAC
  #undef LAC_RGB
  #undef C01
  #undef C01_RGB
  #undef C02
  #undef C02_RGB
  #undef C03
  #undef C03_RGB
  #undef C04
  #undef C04_RGB
  #undef C05
  #undef C05_RGB
  #undef C06
  #undef C06_RGB
  #undef C07
  #undef C07_RGB
  #undef C08
  #undef C08_RGB
  #undef C09
  #undef C09_RGB
  #undef C10
  #undef C10_RGB
  #undef C11
  #undef C11_RGB
  #undef C12
  #undef C12_RGB
  #undef C13
  #undef C13_RGB

  #undef BSL
  #undef BNL
  #undef BCL
  #undef SSL
  #undef SNL
  #undef SCL

  #undef FST
  #undef WRP
  #undef SLO
#endif
