require "test/unit"
#require 'test_helper'
APP_BASE = File.join(File.dirname(__FILE__), '..')
require File.join(File.dirname(__FILE__), '../lib/ruby_utils')


class UtilsTestCase < Test::Unit::TestCase

  APP_BASE = File.join(File.dirname(__FILE__), '..')
  APP_TEST = "#{APP_BASE}/test"
  def setup
    @content = "\211PNG\r\n\032\n\000\000\000\rIHDR\000\000\000\334\000\000\000\372\b\003\000\000\000\375q\331\230\000\000\003\000PLTEI\246\330\374\374\374\255\000\000>\233\320\331\331\331!~\271\026s\261\203\270\3309\226\314\303\334\356\305\343\363\034y\265\260\000\000S\260\3411\216\3065\222\311d\233\222E\242\326A\236\323\355\324\324\000v\266\350\363\372;\230\316i\273\346\267\326\355VWX\363\362\362\216\242]ghh\303[[\257rr\322\233\233\311ss\315\204\204\030u\262\244\326\360Q\255\337\241\321\353\261\305\310\303\304\304r\267\336\263\205\207\306gg\263\032\032\265$$q\275\346\256\316\354AAAxyz,\211\302%\202\275\222\246a\243\244\245\327\247\247\217\003\003\001f\252\345\356\365\354\354\354z\301\347\267\334\357\270\273\274p\226sk\261\332\27133\363\372\375\233\232\232g\257\331\340\340\340\364\342\342\334\354\366\255\325\353M\252\334\246\252L\275CC_\266\344\317\214\214\305\263.\330\343\351\202\203\204J\223\251\240\316\351\320\223\223Z\222\214\333\267\267\233\312\345\320\350\364\273\340\363\223\"$\370\366\366]\227\222(\205\277D\233\315\201\306\352\316\345\362j\216\260\345\274\274ow\223\222\255\270\203\216\250\032\204\301\225KX\226diJKK\246VX\211\302\343\224\314\352\324\322\322O\254\335\340\306\306U\215\210\210Se[\254\331\244JJ\340\371\371\262\320\355L\243\325*\206\3005\205\266S\244\323\216v\215344\257\023\023\245\000\000\255\260\260\215\313\354\231\321\356\257\v\v\307\2660\301\325\330\312\340\3606\223\312\277PP\000]\2453\220\307\375\371\367$\211\304J\247\332Scf\232\301\333\235\313\347n\246\315\241;;\025\201\277\310\261\261\335\357\370\324\271$\237 !'\222\317\270\260;2\217\306`\252\326\212\236Z\225\311\346X\230\305/\214\304H\211\224\211\305\347\201\276\341?\211\244\341\275\027RRS\243\313\345fv~\000n\260f\234\307q\255\323\344\351\355\356\301\f\240\b\b\223\305\351\212>G\220\304\343L\251\333nno\225\207\233]\241\315\322\352\367\360\366\372\222\224\225\232~\201\200\257\3216\201\236\270\232\234\017~\274+\217\310\037\207\303\301\367\367\314||^\247\323)\214\307\256\313\340#\215\312v  4\230\320\316\314\315\000R\236Z\257\335\305\244\2442\224\314\324\335\344\204\307\352\330\350\364J\252\3343\226\316B\222\302[\\\\P\261\342;\216\271\256\332\361\177\235k\242,/\b{\273NNOHHI\234\306\337!\202\276\360\357\357\251bc/\221\313E\246\332-\217\304\250\320\350\237\020\021W\250\327EEE\346\346\346<\236\324\214\215\2168\231\321\254\005\005G\244\327C\240\324+\210\301R\257\340#\200\273\037|\267'\204\276P\247\327??@;;;\231\310\352~\237\264O\240\320#i\254\331\234\234__`vVVbcc\253\277\330\177h|\257\000\000V\263\343\374\306\000\377\377\377\000\000\000\024q\257\314\341\2767\000\000)\274IDATx^\354\317\a\001\000\000\000\0010\375C#\207\263\006\003\213%\347\236S\245\205\234\331\237\203\022\000\000\000\004b\276\354\237X\214!\310\255\301|\211\334\0069r\227\312\376\034\333\000\f\302@\024\315,\267\207{\n\257\342y\256H\301\024\f\2229X\341\024\245A\n\270I\217\362ZK\326\375\021\207-m\024\367\307\005\027\0008\271\242c\2001\t\200Y\303\254\361e\321\220\234\364*Ug\272t+.\311\213\345G\266N\371\212\343\303]\031\3338\f\303P\364\232T\034!\235\366P\257BU\366\3200\006\f\244p\341R\023x\020\315\301\025\204\303\3018\221!y\fr9\aW\344\273\211\310O\206\317\024\340\256\024B\350Z\231\376!w\243+y\205\212\002(:\271&I\261\211\206Y&Z\345xm\272Q\376>\016\303\354\302\301\3551p\020\240[e\334\215\036\0348p \236\322\255\022\347.U\306\353B\t\234\235\002\206S\247\b\222d\300\311\230\ag5m\301\205\203\3604\\O6e\351\262W\300pjft\341\204,\0348p=\357N\a\316\331\034H\021\201\256\332\205\325\306W\244y\214\0325\242A\3024n%H\375\031\256\227\327\301\365\315g\350-\270\320\275Z8\344\202\327\300\315\002n\312C\361\346\315\244\305\205\2539\257j\023@\f\251D\352\273\356\361F\207X\022y\242\206\v\221\337\322o\341\256\034\021\234\313,\016Y.\307z=\351\231\266I\034.\304&\357\373\002\000d\332D\365l6\227\306K\206Cp\222\3500\034\234*\233C\022<\020o+=1\317\256\261\355\252\3408\334\236\200C\v\247\322\3618\034\020\321\t\271\227r]Q\374\224+\325p\v-\027\037\301\341\375\315\351\364q8\356Ux'\335\272\"\301\351k\243\340\032\337J\027\016\205\316\243\354\f\024!8\233f82J\257/\206S\275\212\251c\227\235\206\341\244\205>\362\r\215~\302\001\3039\003\253\364a8x\bg\247\361\341\350V>\206\303\373p&\375?\233{\fw\031\267\022\337\020\216>\004\351\035\341p|\t\227{p_\254\327\261\r\2030\024\004\3204\236\202Y\350]\270\372{\244\244\316\f\251\221\240\364<T\354pY\001E)rq\276\261#\"\276\257\204\363\267\237\344\002\234J\302\245'\e\263\177\235p\354\025\3352\t\227\315\272\352u\272\225\237F\357\370\305M\374\202qE\232\340\344\177\234Tq\262\303\311\021NT\245\377\334\312\2068\261\343\036\236\345\311\202\343\220\3215\300\245\003\331q\003?\277\242\263\340\"o\245\035\207>\r5\343\344\316\2567\340n#gXq!\220C\220\001\247\023'\207\323\270\300\302\210\2378\250\260\315t\000\2662\v\000\024\377s\252\e\030\217,R\261\t\324\272\254\025\200\204\203\336Q\276\225\2677\242\222s\270\271_\211\313S\351\206\003\334\334\r\260\340x\265}3\334\202\025\215p\321\v,8\246\216{q[\376\250\r\303P\034\356\021\262\347\026\322\354\335C\241\240\315:\2075{\354l\310VHG\037\247t\352\025JxG(\245\220\352\375\225\frc:\344e0H?\373{\237_\004\316rN\224\221s\316\225\223\v\327\344d\327+\331\311\251\252\234\271S\272\b\006\246\360f\222S\304@\221\327|q\027WT\253\234\255n?\271\2579\335 7\341\307\227\373\213\0340\370\350O\v\331}\334$7\207\020z\314\364-r\260\"\227\237\342\241I\316#2\f!\fg\005\2064cw\300\250\376\350\177\177\"\233W|\247p \332\206\330a\370\314\f\235\342n\274\236\034E\036\017\271\037\267I\316;\310!\tN\v6\004\214\302\240\310\222\016\330\311\361@a\246\277\001\250\3736\310M\211\372Y\223\003.\226\303\025\002_\267{l\b\200QPf\353Er\032\305\f\235\262\335T\344\360\r\275\227\260R\016\326\345\3646\243\206v\271A\312AE\316\246\352r\203\210\344\267}\212\373\312m\237\\\f\rr*\26529\216\270CN\2445\271(\212\210\264\202`\273\315\223\213e\266^4\023\215b\206N\331n\230\310\221\204\347\344\331\302\366\221\213\255r\320$\a\233\344\"~\201\305\025\271Q\024\021i\005\301v\233\345\3062[/\222\323(f\350\224\355\206\211\"\222\017\335\362\031\rl\037\271\361\337\345d\004\017\335\323x\207ro9\322\337\243\334\230\017\335la?\314\222\261m\004!\020E]\301\211V\220\233 #\276>\234S\003\322:\231\204\220\026.\241\006D\027\024aY\326\356\355|\030\214\316\233\231\037\301\237\341k\236\206\023\256vB\034\034\206\e\313\200\253P\353\235\vpC\026\336\311\256q\032\300\211 \203\177Y\205\226\201\vs\270T.\300\251\323-uQ87\203\3334\216\022\316\312 \264O\341t'\300\301a\270\261\f8\r\265\336\271\0007d\021\177\255\274\373\n~\265\247o\216\000\217t\021\344\360X\350\177\341\370/\226T\371\373\251\3357\270\240\307\357~>}/\2030\223\372\v\216^\303\321\004N]\207S\r\216\262\341f\253\223\345\271\255&\e\261\211\266\322\322\235\215\bj\227\355\372\346\350\365\346\bpM\350mrS\270\350\\{\0354\351\026\346<\373\e\355/\320\345\"\037-I8\315\251i\006G\235\000\a\2073\307\362o8\36469\352\245D\rQ\363\212\242]n\032\t8\321s\247^+\300y:\264\215\276y\372\367\321\217v\204\303P&-\003\207Y\017e/\375\355i\247G\031\372\025\215p\270\371\3056\3472\327\262\330\235y\334N\377\246b\347\207{\022prD\273\020\\0\307\032@\301x\321\364S~\346\367\300\253)\b\022\361N\f-\341~\310\237\203\e\000a\030\006\200L`y\227\016\322w\006b\004\177:\t[\364\3170\b\t\250\032\232\005P\271\247\023E1\234\314[F\303\30786\216\n8\262\255\240\253\364\000\341\2552\245D\v9\354\032T\354m\321\235\367_\t]+\367!Z\205H\212i$!\226\3034\376VNS\232\272\334\311\376\334\333\000\b\0031\030\245\245r\313<\221\330\340Z\217\303\0307AV`\225,\221\376\020?B\021EP\n(B\304\253\\\372;\343\246&}<\356\217C\223\336\213\343F\034\n\224dP\224\314\324\252\342\354\340\2211\2044\305v#n\305^\0018\223\312\342\000\237\277m\274\304\t\342h\212\254\224\025\305\341\271\225V\262\307\225\024\006\202\360\206M\264\221\221\217\300)\220\205\304\r\234Y}\r\016@JN\346\023p\005\256\342xr\362z\3322?3<\315\233\335%\240$Z\356\256\251\306\237\206\035\256\277\242ey\236\302\313\000X\024\253\027\346}\330l\226>\263\204\353\373\n\305i\333a\205\365D\270\376\2459\234\027e;\\\270\350u\270\331\000\232\241T-L\374\375\016\027\024p\031+\001\210\374/(\177\206k\240|\242a\":8\313\314\03223}\312\357\2104\221\372m\221\313o\232\300\301\235p\006Z@W\020\347\035\232op\306\260X\024\336\271\320G \265\230\027\017\343\233w8\003\327/p1!\207\0246\037\032\v\365\315\006G\323\267\210\f\345\205\230\373\031(8\270\017.\177R\322b!\034\301&\370\027\234\367\232\333\2006CL\204\214d\230\336?K\217D\203\267e\276\352\373\026\004\311!\213\035k\253\211f\310Y\343\002\337\233\230\263\034\244\253p\362\337J\360\"\036QD!R\263\333\205,W\211T\360\331HB\270\335R9\344\241\336\002\v\223\205Pu8-\252u\331\016[U\320\264\266\357\362OI)\023\275+\272\f\247\2502\234\377\001\256\256\243C-\003\324\023@i\"\20578\312T\317d\227T\035\366\215\324\031\316\341\030q\241\207\221\316\241\350\356\205\253E&\f\a\334\360\202c\211H\204[E\240\312\300\r\337\341\006\330\272\0239\222\235Ck\r8\317\355>?*\236p\233D\306\026Hw\303\r\237\340j(\315\352\230\205\301!\236\340\336 l\256\372/86\207\242A\272\r\256\264\e\334\364\031n\332\256\027\3441\256\203\277\301)\036\"-\244\214l\313\321vg8\316\245L\003\e\313\321\330\361)\345\001w\e\234LH\245\024\030\177\206+\330\217\320\315@+\022\331\360\360\031\256\223\021\020\226\242\224\204:\223\224\273[\240*\037k\336\b\241\212R\335C\352\vp\177\270\037c\023\211a \212\036l\244\002\374Q\t\256b\230De\250\r7\241\\\231+PM\216U\305;\016\263\203\223[\330=\330M\356'\003#\275\317\274\220\323\313\331\360u\260H\252HFS\004Z.\260I\v\315\n]\2316`H\205r\004\336\002\b2\223\207\203Nh\354\356\222\240\036\367\327\235b\371\344\023\311\022\273\032iu\262^\315\237\345\264\003\336\037\311\301\222VI\335\201&\315\002\324)\255N},\267-\340\231~\207\374\244\e\244K\035\312\214\242,\315\032\213\217\311i\232\351I\314\266\230\375\371\327y\325\376:\273\a\177\025u3\351\223r\272\351\275\271\305xw\363%\367/\023r?\354\322M\n\2040\f\200\321\201\356f9\220;\344\016\202\224Bg\235\215w\350\276wq\327\243~\"\272\224J\205\371A\304,\223\020\362B\334%\343\352\270\e7j\377) \364\371\234\270\004\324+\003\300\263\275v\212\340\3036\253X}\242\204\n\300\260_\340\"\252{8{\v\261e+\370d\3101\234u\036\237\377\206#\276\334\036\316\271,h\0037,\035\035\345\020n\275f\371\312[\316\244\221A\252\3440\fD\af\347eA\356\240;xc\f\311Z\e\337\301\273,|\231l\372\000s\252,\377)\3523]\"\t\351\371\374\231\201\026$\b\225,\371\271\004\207\277\3060\316\266\003c\363.a\267\321\375\320\032\0018=\324m\000W\242\266\255\037\0238\001O\373t\252\273\357PT\377\245\312U\272O\334\270h\202\307B\253\361\303\260\375\352F\265\330\020\305o\342\277\340\214$\035{!9\aK#\277\300\315$\213\236 \222\241jb;'\244\237\300\250\000\222T%]I\300e\222\264\027\270\256\223\365X\310\t\330\231\345st\307\200\205\006\177\372k\317\357\035\270pnEf\036\211],l/\316-\334\2601\353\223\272\234\t\263\234;\351#:\347\332\231\000\224R\327\211\036\344\332\360\002\227\270\350\367\200\0266\016<\270!\340tX\350\235\035\211\216\215\3579\a\204\003$P\231\3029\334\257R\vW\314\034\000\213\034D<vP\342O\270x\235\211\300C\352\246\272<@\343z\301Yo\244a\b\330\230\341aR\025\234\210\327\330Q\271`bC.x\037\356\243\262\\\267\366\e\234b\0018\037\250lG\342\264\257ps\220\320\340\2424\372e\276\335'\226S\004[$\255\034\205\211\321c\0228\025\264\366>\034`\227}\316\307\r\256\265\324C\2108\223\357\340\310\361!\022\251\327u\025783\026H\214h\030L(\351\350\346\331\335\2121s\245\377\v\35679d\214\3436\fD\321\324\354X\360\b\003\360\016\006\210A\000\361\006s\210\255x\025\225*\250\333\370,;\025\217\360\027\321\220\266\004\026\216\261H\232 S\310\337\234\347O=\353\233\201\250\036U\226\240J\210' x\"\201l\264<\302\204\021\350\211A\373fl\243\235\003dS\256Fu\250\266\024[\034i\t\005\364\244\303\203\316 Dl\330\365\325|KN~+'s\230\260\361\333B?\225\215\277u\271\375!\267\364\212\251\261\302\215\345\230\214\355\372+\236\364\216eQ,(\177C\256`QmX^\3101\233OV\205\205\234'\254\001Mu\303\246\202\242\375A \355\217qTo\345j\034|4Cu\265{\230R\034t3\272i\001n\032\300\372N\316\277\031\310\021\002\222\337\220\275'\304\023\020<\202\303\346\e\257\026\252\3660c\271\265\200\3423\310\027\004\357\023Bi\002\362\243sE\273\032G\211g$\037mY\320_ \032m\005-\360\301\360\221\234-^\315w\344v\260\200\313\v\271\bH\300~\206\031K\000\263I\024\2060\266.\301\314&\327\030\353\212<5V8+`a\273\320\a\320\220\e\005\343\253 z\002\375\261\034U\vUV\227\314\203\356'P\317\362]V\331\2570c>\272 \035Mn\225\017\v\355&.Q\374\034G4762\230\354\302qf\037\367A\217\246\321\177\247\364^\356\037\236\377T\356\027\373sP\003\000\000\203@l\376\205\"\203\3543\021\214\\\035\364r\252D.\027\271\251\364<Gn\271\037c\023\206a \212\246V\177#\b\334x\001\251Q\023\031\324{\210k=\305AV\320\002\201\eC\225W\360,\027r\b\251r\023bL\202\037\202\377\245\257\346\321%\371\225\234d\312\322\272\266\026\027\221\363\003aw\321\326cO\310\377/\267\347C9\301\303r\e\323\2318\b\236\300R\016TL\b\221Hruqw\001\247\315\313\\4\352\317j\323'\020\361G\345\312\266\362\211\004t\342\214Y\343\314\376\236\2628\026d\024\035l2\240-\216\340\353\003\330,\211\2256\025\261\205\277\245\311=\206i\343\363@fA\004\236-\273a\322\336\345\2205\364\024\216\260j\e\265\351\244\264\251\336\016\312-\3133\021\275\2315c\327\266\241 \016\267ZJ\214WA'\307\206\bJ\022k\364`C\320\322<\220'\017\2517\323\026\eW\034x\360\340\340\f\376\aJAx\b\004\234!\220\245\251\261\241\035\335\241\203&O\"[\246Lo\364\222Q\360J\177\367\364jG\205BI\003\355\247\323\335I'\203>?#/\022?\271k\275\276G\353\036\227\255\3139\363\2259E\234\016ny[\263Z\255\006+\361\vU[\251\0007\356U\005~\226\350\005\"P\030\204J)\3359\272L\024p\0040#\276\360\301\0309\327\355\273\237\242\345\322\f\316z\337\232\315\361\365\370\232\371p\3256t;\335\356M\3478ev<\323\274\315\360\206\277\226\326t\232q\363\225\343\303\306\203\200\310\205e\177-\027\251C\337\331\310q\370\a~$\200\036=\222\034\354\372\027\347;\251\035\3355+\225\223$\317$\200\253\314K)-Db1\222\213>\226\314hC~$\333\"\003M\024E*\240\2430\344\233Eo\344x@\251\025\325B.X]\021\227\315g\350\361\344X\357\375\vZ\0228\273\252T,8\375!\t\340l\220\355)e\300\323$\206\224\243bAv\316\257\241G\004\n\203I\331V\350\234\262\347\240\020yqU\371\004\314\210\274Z\225\036\212\221\333r\215\336\307\003\302\352\315!w\"\223\304\312#%HF\302\372\r\331\201\354Q\226\035<\351\355\200\035!j\253W!\344&zm\016=/\306\002\346B\225#}\202\377\n\2101#\n\274\360o\345\360Jg?\325s\337\371b9\3575\307{\373\373\b\244=\004:d\r\2325\303\241\216\224\021\357\314\260#\350\037\223\225SO\217`\227\352\235G\267\263\233B\261T*\325\353H\213Ei\201\026\215\306\324b\261\310\311\260\213\320\225\233\335/\364\177\311\001{\313,^\377\342\331\347B\001f\000V\210FJ}\215>\300\2769o\332\355\355F\2434\373\301\\\031\253 \f\003aX\273)v\224\272\247\031Dq\022qpp\366\031\322M\310\326\301M\301\301\ap\361)\212S}\001w\027w\227l\016y\203\022\250x\206\224\243\036Rp\312\227%\027B\340#\227?:\366\002\224\203\313\233WO\357*\225R\320o\216\021el\273\026\a\254 i\354\235\034\260\274\r\254]q\204@\251\305%\346\2111U|\270\210$\231\222\235\275\224\003\275d\363\221\223\353\023\374s\177\362\364M\016\271\034@n\232<vA\263\206\371!w\017\265\017\0209\233,\305p!\361\346LP\353L\254\354\234\212f)\021\210X\227\2574\"\270pE\310\031s\005\222\347D@\3006\026}\037\313\367Mro\352\314\237Er\344\f\343w\302p \272##\032\f:I(Z\251dGr \f\245T\022\0274\r=\016\004\203\341\314&\307281Z\244J\004\227-4\027\337%\216\306Y\005\346\022}\201\216\006\341\310\233LV\201\223\343\016&\261D\231{\336\376s3\333\275\335;\313\261\313\356\323\255R\325[UB\277y\252\n\336\236\0038\350\213//\256\367p\202\361P\f$l\302\212\243\205\n\250\300\025f\fu4\020 \355\370\324\2277\377\235\276\242<\305C\345\203\200\257\375}UC\373\326}lz(_C\351\354\325`\211\207\236\321\353\341\376\323\322\201\2625Dxww6\275\376\020\262\t\273\v2>\250A(\305EX\004lRMT(*\241\200-\304\326O\365\354\370\315\314\334\322\311\t\270i\255\255\203\227._\003\347\347\022\263~=\334\357\356\341\f\345-\342\226\331\255\315\335B\204\361\202);\300\307\276\343\302\271\344m\200\036\327\v\202\240\350\274L\r\004w{\004'u\003\236\346\246\266@\211f\272\"\270^\247\r\301m\257&\325\375t&\227\323\336\234J\030\222XZ\346S_&\215\254k9#\257\351\312\227\332j\320+\365*\271!8\323\314\337\016\356\353\317\257\366\247\245\241\272\270\233\307\236\273(\234bR\305\277\355\272\330\365<\0203\305\342\313K\267\210y\3478\216]t_\315\205A{\357\366\257\207pZ\227\323\322\237\345\351j\t\252FK\300\221\235R\317\b,\321)L@_3M\36545)\226\247\251\257\227\304cj\337\327T\031M]\343\336[i>\225\350\225\344\234\217\030\251\361\301\350\023v\351\347~r\006\356\317\016\016\224\235sb\356t\213\005|\273\273+\004\273\363\346\277\231\363\266\360\\\207\207Y\340\026\001\237\267\266\335z\334v]\2672\006H<\273y\r\034T\003I\257\246K]\222\a+\235\227\300\321Z\222g=^\0220\246.\321\005\270\0321i\215\245\356\2456\245\004\024\004CW\304Y\347\250J\232\277J\315\2218\352\2766G\277\351\313\251\364{Y\256\316\301u//~\331sv\3202\3362\306y+\252\214\361\214WA\234\t\036\n\306E\305\005c\254\022,\fQN\006\322\355\263\361@\200\243\e\220P\035%\340\250F\006\322m\245\255\021\301\225\324\022Cz]\"\206\212\005\350\021\024\350X\365hK\177;\234\036\003\313\3501%\200\373\221\264\314\307~\\\216\263~\224c\351\243 \235X\226\305\223\027\200\333J\t\234\205B)\254Pj\241a\330]\210#\206\204\e}'\b\"p\n\316\002\\c\316\016\341|\337\337\200\244z\206\340\322\367\e8e\351qK \321=\216@\366S]\023\021u\036\301\245\351H\222\273B\276\031.-\236\276\270\336\303\001a\237\216R\203TU`\024\333\300A\322\nUGp\3306\270\242\206\220,\324\326\004\a\212\310_\003\004\201f\\\352\365\b8\362s\003Gc\e\300--\253\326:\332\300\241\202Y\2506\321\006.Z\353\025\226\363!\334\372<\334\247\363\247\377~~&\025\207U*k+\002;f3\216\235kt\332\343ufZ6zIK\217h\227p\016D\e\020\223\256\032A\370\321o\340\"m\255-p\302\301D\247\343n\231\232\230\325H\260Z\351:\245\035)\327\210\345\311\270\214\000d\216\321\362\021p\016-\313\323l\223J\361\330\025\3061\eI\035\301\215\275\326V\262\271\245\321\030\245Z\202#\2624H\t$\327:\a\225^\345\004QS\214*:\305\224\204\3346\251\t\2319M\006>\231\210\201k\030\230\302@9&\262\307\276\\\312\3441\316]\235qn0x`\333\213\f\003\216\311\240\353c8\372\343\222\222\222\312\031\032\244u\364pH\202\350CE4\366X9\315\242\336\374\325\3214;\271\217\235\206\323\316\313\253\353\223\316\031\312s\346\205\3031\340\024\334\a\2403p\027\027\352\244s\206\321z\201]<\204\e>&\270\356\342\217\347\366\234\342L\260\352A\340\243\202\363\276\277:\261\347\006\212\356s\000*w\311\370=\240q\373\201\303\025\237\357O\313\201\000\216\3639\224th\262\320\240\220\302}\v\fMn\377\367\301\303]o\230\006\025\002\000\325m\02270;\253\210\242\315\024\230\202\300\315\250Ue\034-\303\020\n\006\032\037>\334\356\2644\252\316\363Z\002\000]5a\216\235\261\2522*\307\ryexE\021\204m\233e\001\276]\333ra\000\256z[\270\234>\357q\317\275\304\262\0346psg\321\361\226ev\326\005\312^\b\225\271\310\347\346^Wd\317\203E\234\025]\347\330\301\302\t\274\257.3\260\275\255s94\233\315P\2767\270'/w\316\211\"\316\002\307u\342\240X\264\223\340R\205\01627\317\215/\203\320\360\034\307\213m\346\005v<\347\274\360\030\301M\276y4\\>n\311\"h\203\227\277\027\270\253\027\373e\031;\317\355E\e,\262 f\006w\202\326u\355M\356m\v\303n\271\235e\242b\214q\246D\245\006\310\250\376>\336\334<\336\263(I\312u\231\000\217\370\362w\017\347<\275\272\336-K7P\002\247H\306YVM\024\313\230\bC\025\206B\204j\020\312P\310\016\f\222\232\354\263\240o\236\374\363\273(\1773\037\241E\021\310\352\237\376\361\257z\235\020\037\000\3379\\q\265\205\203\204P\203\022\023\312\347\bV\r\306^\273ln\313\204b'\203}\217\377\246\374\370m\224\2177\323\363l +\353\272\371\354\017?\374\360\227\246\256K\370\a\367\336\371\262\274\3779}\030v\327d\257\237y3\233\320\266\3150\216O\2420d\354S\021\222\241x\a\021\233\220XO\016\016\b\333\020\207\341B\003\tc%:Y\331<X\234\300\016\251n\376P\221\331\2515\246eg\e\"\037\206=\360\210\323\335\006;\fJ\343K\020a\031\363!!\020|5)lk\361p\331\363\306c\231?^MM\227\375\214A\240\323\217\377\377}\036Y\356;\223\233\377\226\374\233\242\313V\243*8\024\224\270U\375\e\206d/\000\300g\222d|\267QIE\205\225\233\257\345Q\235\362\204\362\357dg\345K\320\357\304j`\200>\212[\252\360q\017Nbj\023\000\3221;\r\260[H\205\205\233\226[\234\315L\223\353\273\342\3413\371ot\374^l\205'+Ir+\314\324\340,\255zj\000\275\037\324\030:\366\036\037`t7-\327\231H\256\357\0266;\213\231\215\202\202\303\272\371\256FI\252`H\237\002,x<k=\360\2531\325\337\003x\177;\2053\345\177M\256\3776\260s\2772JQ\034\367\323\345\306V\230L\213\303\341qC7;\206\231\235y\3244\0369\333\2667\001\340\261\201\321\375GC\345\220&\227)\243\234\203\231\263\034f\317\360\032'\216\351a\240\245J\025\223\021\204\324\201\3612\255\252(\a'\352\335\343G\222$\331\273\000\233\222\201;!\374\316\341\035\342\034[\021\250\265$r\016jtg\226\235_\034\fi%\213\234.O\030Z\245\355\355\031\353'\350\275\366\2209i\3318(\rC\302\216\236\245\361\262r\220z\227\205\340C\261\225\225p\264R\222i\323\262|t\212r\016\361\2604\265+9BBiO4T\027\271b\3617\000XX\027\375P\263Qn\306\220f$\373\347\273x\275\001\217\n\304\356Zya`\350\265\325(]\326\304\351\035\n\325\314\353\315\315}\325e\275\323\335\272(7B\213o\2174TG\273  \307O\333\353\232\307\243\306\210\237d\017\331\204\336\313\267\336v\207\004<\311\325\312E\311\322\t2B\223\233\r\324s\016\271-=\017\005\262\0249v\376\376`\034\346J\220\310q\334\353\036 J\362\0223\0304\367\366\210\246\252\3066\001jn\367\201\017\237\201HZ\202\020\2556..,Y\036z!Nr\001\247\344\330\271'\017\036\2642]\357\244\032a\351\223\3014\230\004\236A\361\257\344\212\350\000M\005\341Cw\000Y\210\307\327^\355\257>\335\363C\257\266\235\"r>\374P\030\336\022\004\254 \311\312\032\323r\226[\ft\350\311y\373G\241=\323\314\220\227\r\023ft9\002\303$\024\255(\242\234y\a^\275\340y\376\3535\370'!>\004\220W\361\230~\324h4*\325h\264\032\255\206\205!$ \362\251\340\255\322\211%[WSx\nb\221\226\334N\331\351\314\325\237\005\203\347\337\340o\204r\226\235p\353\0229g\022|2\211\231!\221c\030\345\005o\3465\216C\273\353\243\213\242\246\264\006\003\352\236\313\234:\310\345~\217\363\301\345N t\373y9;\352\206\334C9\0270?\346\317\3750\316.\317'5\334 \327\223#\215\347\222<C\034\350r\345\235\323\034\265\225\335\357\363\221\017o\305\363ASI\230\031vT\256\237\273w\333\215\333/M\230Js\025\267\a&w\035--\311'\006\004G\271\373\201L=G\333\336\365\317\315Dd\177y9\022\317\347M\263\343\365\216\004\327g\277t#\307\370\201\306\032\247\241\234\356\276\203\2706\333I\2765\314\313\215\\\247\316\262S\325\036\356<Y\017\006o\3557C\371H(\262\177~\344e\307X\372\302\205\\\036\034Xm_\036;\204\222\0221B%\255\335V\224V\353O\332\355\256\265m+\214\003\370\344\006\222\f\323\302\232\204Z\250f7\263\342\2550]h\301\242\306\263\352n\260\213\230\216\276D\020\302\bZ\232L\2245^!l\026\204\264\245\025\275\260f\\\be\020H.VB\212auJle\025Y\fu\tA7u6jC\334:\216?\300\002BP8c\217\354\254\264\221qT/y\210u\374\310\276\320/\177\353\034\341\027\213\2529\356\263D\337|\264\021\256\264\300\206\202qw\354\347a\222\363\373q25\002\336\2758;\347\034\321\f\227B-\225\335\344F\a\242\326\344\234\223\343\254\347\267\356\245\330d\324\373\024GYZh\243GK\255\341\376l\206\243\016\025w\305]\260N(\216ja\352b\2770:\017\227_\356\3562^N\221\345\324\235? \272\026p\227\233\341\374\207\212\373\306\274\266tX\202[\212\320\177/\316\203\346U\214\354\017\371EA\364@\333RrT\023[\005\035.\256\321l\t_I\211\210\251d\tp\316\204\030\024h\222&\261+\t\307\253V&\024\341-\316FJ\020hb\343\345\313\313zJ\300\320\341\342\316\2177|Yz\203\3018\333g\342b\376n2\\!\203X(f\301\301:\367n\323\245NZ\000\207\212\203\331\322\341\260\342\"(X\3039F\205\254H\223\\\371~66\331\032\016q\"e\030D\230\0268tH\325\344m\006\v\316Y]\nb\361\0218\347\234\321\017#\202\310 F\244i\032.Ql\340\354\327\341'W\360&\032\234sK\301\370bi\341\373\237\234\245\245~\322/\224\313\244\340\231\032q\354Y\306\e^\241\304O\177w\356\264\257\005\000\327V\253\020s\200\353\\\241\324\b\027\t\367-l^\032\031\367\222OCB\226\t\265q\375\236g\220\334\276\270{\037lm\301\337\314\273\343\004j\267Rm\a6[6\302U\335l\337\302\324\262H\r{h\322/\2661d\333\375\251\305\252\323\261/\356\336\026\324\366\326\326\352\030\262_\227\316}t\256\ep\257+{P/\313Q+\356\225\023>S\r/\207\250\037\357\f{\246<bV \273#bl\257\255j\305uomo\257\336\275\273\n\2335\373\270\253\360\3648\n%\201\225L\3026I\335>\270\344\034\326\367\020\340\373\313\236e\222\272\303\236'\205/\"\221`djx\300\271GW=yv/\340\302\366\352\372\352\346\334\372\372\352\312\ff\e\027X]\277{\261\206K\322\3760\f\004y \270+\205\361\267q\273\251\300U\312\002\275\274\034\036\370$\361\225\333\373\344\211\367\333\221S\226\344>\266\340^\254\257\257\364\"\356j1\2672a\377\277\177f=\267\262\206\225\223P\f\302!=\202\305\016\004\347v\277\211{#\027\24731\262\370\f\260\321h\265T\232wLV\301\263_r=\271\242\002\221M\347\212+\327\376\303\005\353\003\326$\271bq\305|Y\202*\204\020\rCe\027\207\375O\034,\005\020\024\270\366V\355\003Hg]\f7s\330w\021/\026\213|;\206^\0243\322\016~!\020\b\254=\350(N\f\301D3X\334\331\254I\306:r\201\207c\360\020\206M\a\002\367\342\322\351\023\271bF}\341+\023u\034\vC\230\003\200\277B%+b\375\364\023\251$\313\210,\233\342P\212e\305\347\204\337\016.\226\350\253\035|\243z-\256\311\354\340r\231\f\037@\350\232\242\310G\360\t)\223\031\314@\251k\275\346\300_\a[\355\336\221\243\031\251\210\373\224\214\022\230\313\217\375\252\300S\362\227\004#I\030u\234\021\306\020\026\206$M/\206\3144\241j=\207\353`\247]\254\r\334\361\302@4\352h\255\252V\334\240\252\362;\220\334\221\236\334c|ZQU\205\207\215zL2\a\245\003CC\320I\274\004\e\025\217\363\252\2643\230\036\233\226Uu%}\"\253\023u\034\030\303\b\245\210$\241\303.\235F\210I\232\r\334\b\002\307a\037Ei\266p\356\321\222}\334\276\353\\@\225$\271\037a\267\237\343\0347\241H\212rf\207\227$E\232\356\201\006\036\031\2535\031hT\334'K\252$w\365\266\253\320\346\336'M\211\211\203\201\302\220IeY\203 4\006\211\0044\251$4\006\216k\320\350\e\025;\270\321\330A\342:%IJ?\336mn(J\372K\204\037U\244\364\003\304\r\362R\376/\264\003\3736\321}E\341%\023'\311\035?t\242^YI\257\241\254F\030\2738-\214\225u\330B\243\e\256,\244h\270\374\210!\f\303\3009\027\330\222d\326\016\316\333zr\325\233\226\331\022S\340\260\323\235\365\246\003\356\366\303D\257\360\371M\f\365\362J\276\375\341-\036\366aH\345y\005\367\245\341\221\316\333\030z\f;\207PY3\f\235A\2102\214Y\026\t\232\241A:\242a\270H\256b\030\032\260\301\246\343\270\v\244m\b\263\201;\353.$ZN\356\244%9t\201\207\003\225\037\326q\274\234\277\216@\305w\315ah\206\347\363\217\236K\262\234~\212\220\302\313<\356\313\363i\2253\317Tx\342\020\n\001\316\bW >m#\204\001\316\005\311\321 %\2310\354+#\244\e\272\2113t\203A\310\016\316;>\377\0168\370\255R\263u\016\352\226\f\244_0\263\271\301\313]5\234\\\303\301\320\356\003\\\336\304\311i\023'\347;\314\231~G\226\273L\034\034\274K\003\2009\317\223\232>k\342t}6\313\204u\335\005\311i\272\256\341\370\254\256\031 \2655\241\270\355&g\376\306\377\324\3577\337X\313\e\341\3422d\323u\254\356L\233\270\000\fs\b\315\300\360\210Q\322y\023\aD\031\367u\245\273zj8xh\b\v\271t(M\3274?\304\351\177\215\333 \031J\327\3528\255\206s\331L\356x\241P\372\227\231;\bm#\273\303\000\336\t\312.\331@{\210\002;\203\306\222r\021\221\004O-v\306\003\246CPS\020\"\006\221B\207\356\241\267q1{\360a]$\031\006\266\022*,\331\262\364PH\2400\313\304f/&\254Y\342\302\224=\310\204\022\260\bD3\351\024\266\313\2300\247-\022t\e\f\v\323\364\373\277\261\262\222+\333J\330\303\376\205\347\371\351\275\200\177\371\336\214\337\310\262\247\341F\004S+\2363\315B\243\250\241\362\255Ju\241\022\236\262\375B\375|\027e\177\206\316\027\273}\216C\227\222\333\335Mn.\376\276\337O\022n\267\277+}\004\334\3578\216O,\213\275^\317\262\254\236(\226p\262\341\363g\204\353\031]\265\204\016pbO\354\371\222\333\233\031wun\034\207=\026-\274\220\223\032\205\"\336o\231\327\344|>Ss\234l\355V\272\"g\363\305\323q\321o\372(\373\355(\002\304\006n\023\315\323(z\023\315\346\342\337\373I\302A\323\227n$\373\311\037\021\356\235~\022\270\204\b\326Rb\a:o)ZB/\265\263\263\335\353y9\277$\212G8Q\002\316z>#nebYV\362\232\2435\032\305*'e\263\305Fu\301q\026\252NV\223[\262\\\241\337\372o\234\201\213~\233D\375A\210~\225L\306\270\244\375\v\340\222\034\227\214qh\244E;i\377\205\343\370\304\004T\356A$\224\254\236\233\022\272\226\330\263\\\342x9\0258\0278\253g\001g\2103\343\236\\\e\273\2404[\267\262\v\262\3548\325Z-_\315W\263ZQ\313\340\t \277\tCl\2411el\351f\246\342\020\031\004\366\315\350=\034/`Y\242\241\344\320l\252\300\331#\334G\300}1\302\275\005\234h\271\211(z\206\230zR\327E\343\241\202\341\022p\026\3410\301\222$Ot{g\341\004^\227\370-\317\313BP\265L&Ko\262\324\264B\261h6\316\231r\261P!\023p\324\314\200\273\000\234\362\246p\027GJ\016\315\b\267x~\f\267H\270\361\344,\313 \234\205\257^\312\271\242\373|\031U*\255\036\2240B8\224/\005\326\2118\341\250tAG}zi\356\301\370\262,VZ\025M\303\311f\"(\024\221L3l6\264\320\324L\023\317O\340\324\350\304\350\354\037\352\373vR\2710\216S6\325\257\2226\341\336H\332I\351\006pw\t\267\017>p\256\345z\034g\021\316\260\202\345\243[\036=\205\021\3400\301\225\2003\304\351\270\016\221$\224\357\373\252\252\036\254N~+h \236\270\213\220\032&\216\232vN\313\207Z\265U\311\267ZNF3O\275Y\375\370\343\177>\275\201\313\0372\331\365\337\261m\216\263\201\023\200\263\225\315\255\3636\307\365m\340\026\025\333\3761O\016CX\226\206\345\0061\316\020\245\234\347\006%\330x\035\272n\000\234a\031\3001\367$\034Hd\342UF\275{|\207\0226\212\rZ~a\241X)`af\344P\276\225\307I\230q\3222p\305SqIx\376\024E\367\321\366\267\366\321y\237pv\233\222C\357\366\342W8Rr0J7\024[\341\270xb\302s\215\030\347z\300\005\356\2404\002\2440\002\034&\030\2224p=k:\016\"^\tz\240r+k\223\270F>\r\001\036\364\253\251-yaA.T\322\v\216\\\251h-\\*\v\247'gC\360W!\272\217\366\305\326\343Qr6%\027\343.\306\270\027#\334{\034\227\344\270\3005\030p\313.\276z\340\f\302m\340u\225D\364\3340\030\307y\036pFp\002\016\244\211\242\227\031&q\265\252\343\310\265\005\247\225\255\245e9\355\340\272\002k\201\377\025\"\"\235\205k\343\246\340\036\b\311\255\307\212\335\006\3566\236\373\200'\327\276\255^\264\225\030\247\214\3430D8\303c\224\234a\004\3001cX\202\3240\2069?ex\003\340\002#\000nh\004\356\t\270c\325\375\307\312$\256\360\260\245eZ\325l\253X\211\277\253\205\023\2443\256\226@\265o\003\a\302\e\352]E\211q\n\341>\243\241\305+\312\030\256m\267c\034\206p\3161/ \3022\214\256\224\ex\204\3331\274z\356`\e#\a\300yA\000\234\307f\305\315\255\035K\256U4\v0\231\3467P\235Z\241\343\037\307]AX\373\235h\035\315z\347\361\021N\211q\n%w\036\235\233\321\242\202\002Ni\377\213\3430\003\311\r@@$\226\347\rE\241;\364\206\333QT\362\202\372\222^\n\202a9\022\002\2171I\252\a\314\230\025\267rl\343\214\244f,\323\221\216\343\356+\250\365u\034\366\236v\366\t'\274\304\241\271'\335\301q\377\363+/q?\031\307\005\001Km\eA\020\324\261\253\034\3020?\317\002V\357\352\313\300mw{\030\347\270\201\341\317\206\273:\a\334\353\225\231\375?\334#\302\265\371\207\240\257\267\225\2758\271\275\021N\377\274\215\246M\2071\334c<\365\276\220\030B2\0340\026\324\353t\3636`\203:}\210\221\260\304\030\eb(\030\016$\277\316\206\2360\023nun\345\311w\207\003\241\315k\257\375v'\372\032-\222\273\207\346\003\201F\366\356t\">\372\202\200\376\243\275\366\336E\302\255\323\304h\265>\254\017\2078\324\353\e\020\2530\016\251\223@\307\243\021\217\241\347\37380=\321\235\202+\037\307]]{\375\344\252\372\224\255\327\025e\257\255\254\337D\"_\307\347\334\275o\223\273\203l!Y\337\272\210\360\374GHn\235\343\370\262\\e\264\223\304\343p\225\357L\244eo0`\333e\201\244)6<,\273HUU\353\336@<\230\237\237\376}\356\330\262|\360\372\311\325\246\340\242\216\372\267\233~\207\330\213\035UE\266\227\005\337\227\204H\350H\276O\024\377\262\320\211?\377T\362U\232x\031]\0353\342\215\223\004Z\\\272\212\177\250\307\035_\025t\335W}!R1)\232\276CQ'u]\372\341\343\351\204\020\233\262\3204\247\343\276\0275\302\351\322\244\256\373\341\223\023p!?\204\005\334\303\345\345J^\016\307]\320\342\256o\241\363\375\302\t\320\035\224\307q\327\256M\3055*\305\202\246\311Z\v;\346LV\226+\034\325$\025\236\257\310\231l\265vI\230\021\240\237\371c\r\341\273\300a\351O\350\272k'\340\n\270\253s\362\330\250h\330\2474\260\223\006\252\240UZ\220\326\322\017\323\265lFn\335\232\r\247\247\006\e\324.\r\\\237\332mf\220\305\215\337d\263!Fnb\371:\0016\006\345x^\300\2739\306\226^\r\027\t\202\356\177\253[=\351E\331B^Fvf\210\254>\241\227\207Zy'[\253AUu\362\270\347\303\026&\f\3773\333\262\234g\t\216b\327\255mj\305en\350\262R\231\023\022,\227\342\212\024\333\240\346\272\227c\a\204d\t\375\325p#]\371\b\227{km:Nk6M\250xV\325t\032YqU\261\021\362\233\275f\263\371Iu6\\.\016\340\200E\327\031\365{\245U\216\366\346\251Q\33136\177HL\301*-\023`\336\330`:g\357\034\274*\216t\322\326\221\256\273\362`e\034\327\304\343\350\264\212\263\032S\231\341h\njv\034EG\2142\303'\324=d%\216\v\200CYV*eI4\301\235\347\311n\034\275U17@\304\257\212\003ot\321\244\v\312\227\315&G\221*^\200\031\247\nU\r\347\025W\025\314\227\362\221\313,\024\265V\346\335Y/\003%\027\215\316\374\222\3055@\305\3134\036d\eL\214\0236\f\236\234\e\377',\0058\274:n\354\2622\207?\316\320\f\e\005,@\231_,\322\\5\221\025\271Fi\201\337\2223\325[\277\276\364\263\316\214\264\245\303\230\221:\272@\030\350Q!\037\252\035\2463\236\330v\317g\t\264\327Y\231\225\t\307\0167^\a\207\354t\256[}8\267\366\241\234GT\351\207\361\n\224)\253\006T\307\\_\022?S\373\037;\366\217\2020\f\205\001\\\305\e\270\0254:\372gm\300I\301,\342$\035t\353X\220^\300\f.\205n\275\207'p\351-\234:\t\016\336 \253\342g\205|\243\243F\222\236\340\307\373\336K\372\fT\3257\357\267\3178;4\361p\036\236\204\260\t\304RH\327\037Y\330\252\240\377\006&N\225\312\031\304_\305Qw\335%\227\342\255\272\331\0379v\026\2125*M\230\"\202,\226\0038\034\350\246\213D\312#w\255\232\305B\004\241b\004\335\301qhfRj\316w\2500-W!\032+`\004\235\302Q\227\317\305F\326\252\303\036\252\322D\035\245\266,\226\2338\026/*\316\263\f\252\370\245\"\313i\034y\225\n\240b\006\035\306\375\343\3618\217\3638\217\3638\217{\266?\a$\000\000\000\b\303\354\037\372\b\266P\\\203%\267\352\271b\006\240\212\201\205\311\357\361\332\000\000\000\000IEND\256B`\202"
    FileUtils.mkdir_p "#{APP_TEST}/fixtures/copy"
  end

  def test_copy
    FileUtils.rm_r("#{APP_TEST}/fixtures/copy")
    Utils.copy("#{APP_TEST}/fixtures/public/test.png","#{APP_TEST}/fixtures/copy")
    assert_equal true, File.exist?("#{APP_TEST}/fixtures/copy/test.png")
    Utils.copy("#{APP_TEST}/fixtures/public/test.png","#{APP_TEST}/fixtures/copy/subfolder/sub/adf")
    assert_equal true, File.exist?("#{APP_TEST}/fixtures/copy/subfolder/sub/adf/test.png")
    Utils.copy("#{APP_TEST}/fixtures/public/test.png","#{APP_TEST}/fixtures/copy/subfolder/sffub/adf/test.png")
    assert_equal true, File.exist?("#{APP_TEST}/fixtures/copy/subfolder/sffub/adf/test.png")
  end
  def test_file_md5_file
    assert_equal('e78ce987961592e0d72ef6645ac09844', File.md5("#{APP_TEST}/fixtures/public/md5_test_file.rb"))
    assert_equal('5303d1fb25ce6fc7d64dc04b277bd7c3', File.md5("#{APP_TEST}/fixtures/public/test.png"))
  end
  def test_file_get_content
    given_content = File.get_content "#{APP_TEST}/fixtures/public/test.png"
    assert_equal(@content, given_content)
    remote_given_content = File.get_content "http://forniol.cat/manuals/test.png"
    assert_equal(@content, remote_given_content)
  end
  def test_file_put_content
    if File.exist? "/tmp/test.png"
      FileUtils.rm_f "/tmp/test.png"
    end
    File.put_content("/tmp/test.png",@content)
    assert_equal @content, File.get_content("/tmp/test.png")
    assert File.exist?( "/tmp/test.png")
  end
  def test_hash_flip!
    available_options = {'c'  => 'crop'}
    available_options.flip!
    assert_equal({'crop' => 'c'}, available_options)
  end
  def test_hash_flip
    available_options = {'c'  => 'crop'}
    assert_equal({'crop' => 'c'}, available_options.flip)
    assert_equal({'c' => 'crop'}, available_options)
  end
  def test_hash_keyfy
    available_options = {'c' => 'crop'}.keyfy!
    assert_equal({:c => 'crop'}, available_options)
    
  end
  def test_hash_unkeyfy
    available_options = {:c => 'crop'}.unkeyfy!
    assert_equal({'c' => 'crop'}, available_options)
  end
  def test_hash_unkeyfy_recursive
    available_options = {:transformacio => {:c => 'crop'}}.unkeyfy!({:recursive => true})
    assert_equal({'transformacio' => {'c' => 'crop'}}, available_options)
    available_options = {:transformacio => {:c => :crop}}.unkeyfy!({:recursive => true, :stringify_symbol => true})
    assert_equal({'transformacio' => {'c' => ':crop'}}, available_options)
  end
  def test_hash_keyfy_recursive
    available_options = {'transformacio' => {'c' => 'crop'}}.keyfy!({:recursive => true})
    assert_equal({:transformacio => {:c => 'crop'}}, available_options)
    available_options = {'transformacio' => {'c' => ':crop'}}.keyfy!({:recursive => true,:symbolize_strings => true})
    assert_equal({:transformacio => {:c => :crop}}, available_options)
  end
  def test_hash_isset?
    a = {:string_empty => '', :false => false, 
         :empty_array => [], :one_value_array => [''], 
         :true => true, :symbol => :hola, :empty_hash => {},
         :one_key_hash => {:a=>''}, :number => 12,
         :nil_value => nil}
    assert !a.isset?(:string_empty)
    assert !a.isset?(:false)
    assert !a.isset?(:empty_array)
    assert a.isset?(:one_value_array)
    assert a.isset?(:true)
    assert a.isset?(:symbol)
    assert !a.isset?(:empty_hash)
    assert a.isset?(:one_key_hash)
    assert a.isset?(:number)
  end
  def test_symbol_stringify
    assert_equal(":hola", :hola.stringify)
  end
  def test_string_digest_md5
    assert_equal('cb76c6b7972424978ce063b562475eaa', 'asjdfklasjdflkajsdflk'.md5)
  end
  def test_string_is_integer?
    assert "10".is_integer?
    assert !"10.1".is_integer?
    assert !"hola".is_numeric?
  end
  def test_string_is_numeric?
    assert "10".is_numeric?
    assert "10.1".is_numeric?
    assert !"hola".is_numeric?
  end
  def test_string_dot_less_trim
    assert_equal 'asdhfasdf', '.asdhfasdf.'.dot_less_trim
    assert_equal 'asdhfasdf', '.asdhfasdf'.dot_less_trim
    assert_equal 'asdhfasdf', 'asdhfasdf.'.dot_less_trim
    assert_equal 'asdhfasdf', 'asdhfasdf'.dot_less_trim
  end
  def test_string_simple_quotation_less_trim
    assert_equal 'asdhfasdf',  "'asdhfasdf'".simple_quotation_less_trim
    assert_equal 'asdhfasdf',  "'asdhfasdf".simple_quotation_less_trim
    assert_equal 'asdhfasdf',  "asdhfasdf'".simple_quotation_less_trim
    assert_equal 'asdhfasdf',  "asdhfasdf".simple_quotation_less_trim
  end
  def test_string_keyfy
    assert_equal ":aaaaaaa".keyfy, :aaaaaaa
    assert_equal 'aaaaa'.keyfy, 'aaaaa'
  end
  def test_string_camelize
    assert_equal("HolaComEstas", "hola_com_estas".camelize)
  end
  def test_string_underscore
    assert_equal("hola_com_estas", "HolaComEstas".underscore)
  end
  def test_string_casecompare
    assert "Hola".casecompare('hola')
    assert "Hola".casecompare('Hola')
    assert !"Hola".casecompare('adeu')
  end
  def test_dec2hex
    assert_equal("FF", '255'.dec2hex)
    assert_equal("A", '10'.dec2hex)
    assert_equal("10", '16'.dec2hex)
    assert_equal('3', '3'.dec2hex)
  end
  def test_object_class_exists?
    assert class_exists?(:string)
    assert class_exists?(:String)
    assert class_exists?('string')
    assert class_exists?('String')
    assert !class_exists?(:noneexists)
    assert !class_exists?(:NoneExists)
    assert !class_exists?('noneexists')
    assert !class_exists?('NoneExists')
  end
  def test_object_module_exists?
    assert module_exists?(:test)
    assert module_exists?(:Test)
    assert module_exists?('test')
    assert module_exists?('Test')
    assert !module_exists?(:noneexists)
    assert !module_exists?(:NoneExists)
    assert !module_exists?('noneexists')
    assert !module_exists?('NoneExists')
  end
  def test_hash_areset_function
    test = {:w => 'asdf',:h => 12}
    assert(test.areset?(:w,:h)[:result])
    assert(!test.areset?(:w,:h,:x,:y)[:result])
  end
end