From: Roland Dreier <roland-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Hang (due to HW?) in qi_submit_sync()
Date: Thu,  8 Jan 2015 14:36:50 -0800
Message-ID: <1420756610-20918-1-git-send-email-roland@kernel.org>
References: <1420505840-30096-1-git-send-email-roland@kernel.org>
	<1420512860.3541.77.camel@redhat.com>
	<CAG4TOxPOgTOKYZa7q9Of8XzHV_wAadtJmXFC0bmyN2Qds7T9RA@mail.gmail.com>
	<1420526901.3541.96.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1420526901.3541.96.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

So we've managed to find one magic setup and workload that reproduces
this reliably, and I've done a bit more debugging that leads me to
believe we probably need Intel's help to really get to the bottom of
this.

One question though: you mentioned that you saw this behavior until
you turned off CONFIG_NET_DMA.  What platform was that on?  We see
this on dual socket Xeon E5 v3 (Haswell EP / Grantley), and I don't
really have any other setup I can try.  Did you see this on other
platforms (Ivy Bridge / Romley maybe)?

Anyway, I added the debugging patch at the end of this mail to our
kernel to dump some status when the driver detects a hung queue.
Below we see some example output.  Things I notice:

 - IQH == IQT, in other words the QI hardware thinks it has picked up
   and validated all the descriptors submitted by software.
 - The queue has successfully processed many operations (although
   everything that we can see succeeded is type 2h, ie "IOTLB
   invalidate" as opposed to the type 4h "Interrupt Entry Cache
   invalidate" that we're stuck on.
 - There haven't been any faults and FSTS is clear.
 - The hardware hasn't executed the "Invalidation wait" descriptor.

Beyond that I'm not sure how to make much more progress without
insight into the hardware -- it looks like the driver is doing
everything right.  Anyone from Intel have any thoughts?

Here's the actual output from the kernel log:

 dmar: QI stuck waiting for index 252 / wait_index 253  IQH/T 00000fe0/00000fe0 FSTS 00000000
 dmar:   [  0] stat 0   00000000000100f2 000001500027f000
 dmar:   [  1] stat 0   0000000200000025 0000001fff412004
 dmar:   [  2] stat 0   00000000000100f2 0000015000280000
 dmar:   [  3] stat 0   0000000200000025 0000001fff41200c
 dmar:   [  4] stat 0   00000000000100f2 0000015000281000
 dmar:   [  5] stat 0   0000000200000025 0000001fff412014
 dmar:   [  6] stat 0   00000000000100f2 0000015000282000
 dmar:   [  7] stat 0   0000000200000025 0000001fff41201c
 dmar:   [  8] stat 0   00000000000100f2 0000015000283000
 dmar:   [  9] stat 0   0000000200000025 0000001fff412024
 dmar:   [ 10] stat 0   00000000000100f2 0000015000284000
 dmar:   [ 11] stat 0   0000000200000025 0000001fff41202c
 dmar:   [ 12] stat 0   00000000000100f2 0000015000285000
 dmar:   [ 13] stat 0   0000000200000025 0000001fff412034
 dmar:   [ 14] stat 0   00000000000100f2 0000015000286000
 dmar:   [ 15] stat 0   0000000200000025 0000001fff41203c
 dmar:   [ 16] stat 0   00000000000100f2 0000015000287000
 dmar:   [ 17] stat 0   0000000200000025 0000001fff412044
 dmar:   [ 18] stat 0   00000000000100f2 0000015000288000
 dmar:   [ 19] stat 0   0000000200000025 0000001fff41204c
 dmar:   [ 20] stat 0   00000000000100f2 0000015000289000
 dmar:   [ 21] stat 0   0000000200000025 0000001fff412054
 dmar:   [ 22] stat 0   00000000000100f2 000001500028a000
 dmar:   [ 23] stat 0   0000000200000025 0000001fff41205c
 dmar:   [ 24] stat 0   00000000000100f2 000001500026a000
 dmar:   [ 25] stat 0   0000000200000025 0000001fff412064
 dmar:   [ 26] stat 0   00000000000100f2 000001500026b000
 dmar:   [ 27] stat 0   0000000200000025 0000001fff41206c
 dmar:   [ 28] stat 0   00000000000100f2 000001500026c000
 dmar:   [ 29] stat 0   0000000200000025 0000001fff412074
 dmar:   [ 30] stat 0   00000000000100f2 000001500026d000
 dmar:   [ 31] stat 0   0000000200000025 0000001fff41207c
 dmar:   [ 32] stat 0   00000000000100f2 000001500026e000
 dmar:   [ 33] stat 0   0000000200000025 0000001fff412084
 dmar:   [ 34] stat 0   00000000000100f2 000001500026f000
 dmar:   [ 35] stat 0   0000000200000025 0000001fff41208c
 dmar:   [ 36] stat 0   00000000000100f2 0000015000270000
 dmar:   [ 37] stat 0   0000000200000025 0000001fff412094
 dmar:   [ 38] stat 0   00000000000100f2 0000015000271000
 dmar:   [ 39] stat 0   0000000200000025 0000001fff41209c
 dmar:   [ 40] stat 0   00000000000100f2 0000015000272000
 dmar:   [ 41] stat 0   0000000200000025 0000001fff4120a4
 dmar:   [ 42] stat 0   00000000000100f2 0000015000273000
 dmar:   [ 43] stat 0   0000000200000025 0000001fff4120ac
 dmar:   [ 44] stat 0   00000000000100f2 0000015000274000
 dmar:   [ 45] stat 0   0000000200000025 0000001fff4120b4
 dmar:   [ 46] stat 0   00000000000100f2 0000015000275000
 dmar:   [ 47] stat 0   0000000200000025 0000001fff4120bc
 dmar:   [ 48] stat 0   00000000000100f2 0000015000276000
 dmar:   [ 49] stat 0   0000000200000025 0000001fff4120c4
 dmar:   [ 50] stat 0   00000000000100f2 0000015000277000
 dmar:   [ 51] stat 0   0000000200000025 0000001fff4120cc
 dmar:   [ 52] stat 0   00000000000100f2 0000015000278000
 dmar:   [ 53] stat 0   0000000200000025 0000001fff4120d4
 dmar:   [ 54] stat 0   00000000000100f2 0000015000279000
 dmar:   [ 55] stat 0   0000000200000025 0000001fff4120dc
 dmar:   [ 56] stat 0   00000000000100f2 0000015000259000
 dmar:   [ 57] stat 0   0000000200000025 0000001fff4120e4
 dmar:   [ 58] stat 0   00000000000100f2 000001500025a000
 dmar:   [ 59] stat 0   0000000200000025 0000001fff4120ec
 dmar:   [ 60] stat 0   00000000000100f2 000001500025b000
 dmar:   [ 61] stat 0   0000000200000025 0000001fff4120f4
 dmar:   [ 62] stat 0   00000000000100f2 000001500025c000
 dmar:   [ 63] stat 0   0000000200000025 0000001fff4120fc
 dmar:   [ 64] stat 0   00000000000100f2 000001500025d000
 dmar:   [ 65] stat 0   0000000200000025 0000001fff412104
 dmar:   [ 66] stat 0   00000000000100f2 000001500025e000
 dmar:   [ 67] stat 0   0000000200000025 0000001fff41210c
 dmar:   [ 68] stat 0   00000000000100f2 000001500025f000
 dmar:   [ 69] stat 0   0000000200000025 0000001fff412114
 dmar:   [ 70] stat 0   00000000000100f2 0000015000260000
 dmar:   [ 71] stat 0   0000000200000025 0000001fff41211c
 dmar:   [ 72] stat 0   00000000000100f2 0000015000261000
 dmar:   [ 73] stat 0   0000000200000025 0000001fff412124
 dmar:   [ 74] stat 0   00000000000100f2 0000015000262000
 dmar:   [ 75] stat 0   0000000200000025 0000001fff41212c
 dmar:   [ 76] stat 0   00000000000100f2 0000015000263000
 dmar:   [ 77] stat 0   0000000200000025 0000001fff412134
 dmar:   [ 78] stat 0   00000000000100f2 0000015000264000
 dmar:   [ 79] stat 0   0000000200000025 0000001fff41213c
 dmar:   [ 80] stat 0   00000000000100f2 0000015000265000
 dmar:   [ 81] stat 0   0000000200000025 0000001fff412144
 dmar:   [ 82] stat 0   00000000000100f2 0000015000266000
 dmar:   [ 83] stat 0   0000000200000025 0000001fff41214c
 dmar:   [ 84] stat 0   00000000000100f2 0000015000267000
 dmar:   [ 85] stat 0   0000000200000025 0000001fff412154
 dmar:   [ 86] stat 0   00000000000100f2 0000015000268000
 dmar:   [ 87] stat 0   0000000200000025 0000001fff41215c
 dmar:   [ 88] stat 0   00000000000100f2 0000015000248000
 dmar:   [ 89] stat 0   0000000200000025 0000001fff412164
 dmar:   [ 90] stat 0   00000000000100f2 0000015000249000
 dmar:   [ 91] stat 0   0000000200000025 0000001fff41216c
 dmar:   [ 92] stat 0   00000000000100f2 000001500024a000
 dmar:   [ 93] stat 0   0000000200000025 0000001fff412174
 dmar:   [ 94] stat 0   00000000000100f2 000001500024b000
 dmar:   [ 95] stat 0   0000000200000025 0000001fff41217c
 dmar:   [ 96] stat 0   00000000000100f2 000001500024c000
 dmar:   [ 97] stat 0   0000000200000025 0000001fff412184
 dmar:   [ 98] stat 0   00000000000100f2 000001500024d000
 dmar:   [ 99] stat 0   0000000200000025 0000001fff41218c
 dmar:   [100] stat 0   00000000000100f2 000001500024e000
 dmar:   [101] stat 0   0000000200000025 0000001fff412194
 dmar:   [102] stat 0   00000000000100f2 000001500024f000
 dmar:   [103] stat 0   0000000200000025 0000001fff41219c
 dmar:   [104] stat 0   00000000000100f2 0000015000250000
 dmar:   [105] stat 0   0000000200000025 0000001fff4121a4
 dmar:   [106] stat 0   00000000000100f2 0000015000251000
 dmar:   [107] stat 0   0000000200000025 0000001fff4121ac
 dmar:   [108] stat 0   00000000000100f2 0000015000252000
 dmar:   [109] stat 0   0000000200000025 0000001fff4121b4
 dmar:   [110] stat 0   00000000000100f2 0000015000253000
 dmar:   [111] stat 0   0000000200000025 0000001fff4121bc
 dmar:   [112] stat 0   00000000000100f2 0000015000254000
 dmar:   [113] stat 0   0000000200000025 0000001fff4121c4
 dmar:   [114] stat 0   00000000000100f2 0000015000255000
 dmar:   [115] stat 0   0000000200000025 0000001fff4121cc
 dmar:   [116] stat 0   00000000000100f2 0000015000256000
 dmar:   [117] stat 0   0000000200000025 0000001fff4121d4
 dmar:   [118] stat 0   00000000000100f2 0000015000257000
 dmar:   [119] stat 0   0000000200000025 0000001fff4121dc
 dmar:   [120] stat 0   00000000000100f2 0000015000237000
 dmar:   [121] stat 0   0000000200000025 0000001fff4121e4
 dmar:   [122] stat 0   00000000000100f2 0000015000238000
 dmar:   [123] stat 0   0000000200000025 0000001fff4121ec
 dmar:   [124] stat 0   00000000000100f2 0000015000239000
 dmar:   [125] stat 0   0000000200000025 0000001fff4121f4
 dmar:   [126] stat 0   00000000000100f2 000001500023a000
 dmar:   [127] stat 0   0000000200000025 0000001fff4121fc
 dmar:   [128] stat 0   00000000000100f2 000001500023b000
 dmar:   [129] stat 0   0000000200000025 0000001fff412204
 dmar:   [130] stat 0   00000000000100f2 000001500023c000
 dmar:   [131] stat 0   0000000200000025 0000001fff41220c
 dmar:   [132] stat 0   00000000000100f2 000001500023d000
 dmar:   [133] stat 0   0000000200000025 0000001fff412214
 dmar:   [134] stat 0   00000000000100f2 000001500023e000
 dmar:   [135] stat 0   0000000200000025 0000001fff41221c
 dmar:   [136] stat 0   00000000000100f2 000001500023f000
 dmar:   [137] stat 0   0000000200000025 0000001fff412224
 dmar:   [138] stat 0   00000000000100f2 0000015000240000
 dmar:   [139] stat 0   0000000200000025 0000001fff41222c
 dmar:   [140] stat 0   00000000000100f2 0000015000241000
 dmar:   [141] stat 0   0000000200000025 0000001fff412234
 dmar:   [142] stat 0   00000000000100f2 0000015000242000
 dmar:   [143] stat 0   0000000200000025 0000001fff41223c
 dmar:   [144] stat 0   00000000000100f2 0000015000243000
 dmar:   [145] stat 0   0000000200000025 0000001fff412244
 dmar:   [146] stat 0   00000000000100f2 0000015000244000
 dmar:   [147] stat 0   0000000200000025 0000001fff41224c
 dmar:   [148] stat 0   00000000000100f2 0000015000245000
 dmar:   [149] stat 0   0000000200000025 0000001fff412254
 dmar:   [150] stat 0   00000000000100f2 0000015000246000
 dmar:   [151] stat 0   0000000200000025 0000001fff41225c
 dmar:   [152] stat 0   00000000000100f2 0000015000226000
 dmar:   [153] stat 0   0000000200000025 0000001fff412264
 dmar:   [154] stat 0   00000000000100f2 0000015000227000
 dmar:   [155] stat 0   0000000200000025 0000001fff41226c
 dmar:   [156] stat 0   00000000000100f2 0000015000228000
 dmar:   [157] stat 0   0000000200000025 0000001fff412274
 dmar:   [158] stat 0   00000000000100f2 0000015000229000
 dmar:   [159] stat 0   0000000200000025 0000001fff41227c
 dmar:   [160] stat 0   00000000000100f2 000001500022a000
 dmar:   [161] stat 0   0000000200000025 0000001fff412284
 dmar:   [162] stat 0   00000000000100f2 000001500022b000
 dmar:   [163] stat 0   0000000200000025 0000001fff41228c
 dmar:   [164] stat 0   00000000000100f2 000001500022c000
 dmar:   [165] stat 0   0000000200000025 0000001fff412294
 dmar:   [166] stat 0   00000000000100f2 000001500022d000
 dmar:   [167] stat 0   0000000200000025 0000001fff41229c
 dmar:   [168] stat 0   00000000000100f2 000001500022e000
 dmar:   [169] stat 0   0000000200000025 0000001fff4122a4
 dmar:   [170] stat 0   00000000000100f2 000001500022f000
 dmar:   [171] stat 0   0000000200000025 0000001fff4122ac
 dmar:   [172] stat 0   00000000000100f2 0000015000230000
 dmar:   [173] stat 0   0000000200000025 0000001fff4122b4
 dmar:   [174] stat 0   00000000000100f2 0000015000231000
 dmar:   [175] stat 0   0000000200000025 0000001fff4122bc
 dmar:   [176] stat 0   00000000000100f2 0000015000232000
 dmar:   [177] stat 0   0000000200000025 0000001fff4122c4
 dmar:   [178] stat 0   00000000000100f2 0000015000233000
 dmar:   [179] stat 0   0000000200000025 0000001fff4122cc
 dmar:   [180] stat 0   00000000000100f2 0000015000234000
 dmar:   [181] stat 0   0000000200000025 0000001fff4122d4
 dmar:   [182] stat 0   00000000000100f2 0000015000235000
 dmar:   [183] stat 0   0000000200000025 0000001fff4122dc
 dmar:   [184] stat 0   00000000000100f2 0000015000215000
 dmar:   [185] stat 0   0000000200000025 0000001fff4122e4
 dmar:   [186] stat 0   00000000000100f2 0000015000216000
 dmar:   [187] stat 0   0000000200000025 0000001fff4122ec
 dmar:   [188] stat 0   00000000000100f2 0000015000217000
 dmar:   [189] stat 0   0000000200000025 0000001fff4122f4
 dmar:   [190] stat 0   00000000000100f2 0000015000218000
 dmar:   [191] stat 0   0000000200000025 0000001fff4122fc
 dmar:   [192] stat 0   00000000000100f2 0000015000219000
 dmar:   [193] stat 0   0000000200000025 0000001fff412304
 dmar:   [194] stat 0   00000000000100f2 000001500021a000
 dmar:   [195] stat 0   0000000200000025 0000001fff41230c
 dmar:   [196] stat 0   00000000000100f2 000001500021b000
 dmar:   [197] stat 0   0000000200000025 0000001fff412314
 dmar:   [198] stat 0   00000000000100f2 000001500021c000
 dmar:   [199] stat 0   0000000200000025 0000001fff41231c
 dmar:   [200] stat 0   00000000000100f2 000001500021d000
 dmar:   [201] stat 0   0000000200000025 0000001fff412324
 dmar:   [202] stat 0   00000000000100f2 000001500021e000
 dmar:   [203] stat 0   0000000200000025 0000001fff41232c
 dmar:   [204] stat 0   00000000000100f2 000001500021f000
 dmar:   [205] stat 0   0000000200000025 0000001fff412334
 dmar:   [206] stat 0   00000000000100f2 0000015000220000
 dmar:   [207] stat 0   0000000200000025 0000001fff41233c
 dmar:   [208] stat 0   00000000000100f2 0000015000221000
 dmar:   [209] stat 0   0000000200000025 0000001fff412344
 dmar:   [210] stat 0   00000000000100f2 0000015000222000
 dmar:   [211] stat 0   0000000200000025 0000001fff41234c
 dmar:   [212] stat 0   00000000000100f2 0000015000223000
 dmar:   [213] stat 0   0000000200000025 0000001fff412354
 dmar:   [214] stat 0   00000000000100f2 0000015000224000
 dmar:   [215] stat 0   0000000200000025 0000001fff41235c
 dmar:   [216] stat 0   00000000000100f2 0000015000204000
 dmar:   [217] stat 0   0000000200000025 0000001fff412364
 dmar:   [218] stat 0   00000000000100f2 0000015000205000
 dmar:   [219] stat 0   0000000200000025 0000001fff41236c
 dmar:   [220] stat 0   00000000000100f2 0000015000206000
 dmar:   [221] stat 0   0000000200000025 0000001fff412374
 dmar:   [222] stat 0   00000000000100f2 0000015000207000
 dmar:   [223] stat 0   0000000200000025 0000001fff41237c
 dmar:   [224] stat 0   00000000000100f2 0000015000208000
 dmar:   [225] stat 0   0000000200000025 0000001fff412384
 dmar:   [226] stat 0   00000000000100f2 0000015000209000
 dmar:   [227] stat 0   0000000200000025 0000001fff41238c
 dmar:   [228] stat 0   00000000000100f2 000001500020a000
 dmar:   [229] stat 0   0000000200000025 0000001fff412394
 dmar:   [230] stat 0   00000000000100f2 000001500020b000
 dmar:   [231] stat 0   0000000200000025 0000001fff41239c
 dmar:   [232] stat 0   00000000000100f2 000001500020c000
 dmar:   [233] stat 0   0000000200000025 0000001fff4123a4
 dmar:   [234] stat 0   00000000000100f2 000001500020d000
 dmar:   [235] stat 0   0000000200000025 0000001fff4123ac
 dmar:   [236] stat 0   00000000000100f2 000001500020e000
 dmar:   [237] stat 0   0000000200000025 0000001fff4123b4
 dmar:   [238] stat 0   00000000000100f2 000001500020f000
 dmar:   [239] stat 0   0000000200000025 0000001fff4123bc
 dmar:   [240] stat 0   00000000000100f2 0000015000210000
 dmar:   [241] stat 0   0000000200000025 0000001fff4123c4
 dmar:   [242] stat 0   00000000000100f2 0000015000211000
 dmar:   [243] stat 0   0000000200000025 0000001fff4123cc
 dmar:   [244] stat 0   00000000000100f2 0000015000212000
 dmar:   [245] stat 0   0000000200000025 0000001fff4123d4
 dmar:   [246] stat 0   00000000000100f2 0000015000213000
 dmar:   [247] stat 0   0000000200000025 0000001fff4123dc
 dmar:   [248] stat 0   00000000000100f2 0000015000201000
 dmar:   [249] stat 0   0000000200000025 0000001fff4123e4
 dmar:   [250] stat 0   00000000000100f2 0000015000202000
 dmar:   [251] stat 0   0000000200000025 0000001fff4123ec
 dmar:   [252] stat 1   0000001410000014 0000000000000000
 dmar:   [253] stat 1   0000000200000025 0000001fff4123f4
 dmar:   [254] stat 0   00000000000100f2 000001500027e000
 dmar:   [255] stat 0   0000000200000025 0000001fff4123fc
 ------------[ cut here ]------------
 kernel BUG at drivers/iommu/dmar.c:901!
 invalid opcode: 0000 [#1] SMP 

 CPU: 1 PID: 5310 Comm: foed Tainted: G           O 3.10.59+ #201501080140+8825998.platinum
 task: ffff883fe5f743e0 ti: ffff883feb696000 task.ti: ffff883feb696000
 RIP: 0010:[<ffffffff81529737>]  [<ffffffff81529737>] qi_submit_sync+0x477/0x510
 RSP: 0018:ffff883feb697a10  EFLAGS: 00010046
 RAX: 0000000000000038 RBX: 0000000000000100 RCX: 00000000000000dd
 RDX: 00000000000000e2 RSI: 0000000000000046 RDI: 0000000000000046
 RBP: ffff883feb697a78 R08: ffffffffffffffff R09: 0000000000003b72
 R10: 0000000000000075 R11: 00000000000000d1 R12: ffff883ff2dda008
 R13: 0000000000000400 R14: ffff881fff40c6c0 R15: ffff883ffec019c0
 FS:  00007fb876bea700(0000) GS:ffff881fffa20000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f42963c9d50 CR3: 0000000003e0c000 CR4: 00000000001407e0
 wait_for_sess_cmds: Completed cmd ffff882706266f70 tag 0x117514 tr_state 0x91 t_state 5 flags 0x4010b tas 0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
 Stack:
  ffff883feb697a88 0000000000000fd0 0000000000000fc0 ffff883ff2dd9000
  0000000000000086 00000000000000fc 000000fc000000fd 000b415115c12cd0
  ffff883fec30c800 0000000000000000 0000000000000246 ffff883fef949858
 Call Trace:
  [<ffffffff8152f6b5>] free_irte+0xc5/0x100
  [<ffffffff81530834>] free_remapped_irq+0x44/0x60
  [<ffffffff81027b23>] destroy_irq+0x33/0xd0
  [<ffffffff81027ede>] native_teardown_msi_irq+0xe/0x10
  [<ffffffff812a6a70>] default_teardown_msi_irqs+0x60/0x80
  [<ffffffff812a64d9>] free_msi_irqs+0x99/0x150
  [<ffffffff812a749d>] pci_disable_msix+0x3d/0x60
  [<ffffffffa006b748>] vfio_msi_disable+0xc8/0xe0 [vfio_pci]
  [<ffffffffa006bf86>] vfio_pci_set_msi_trigger+0x2a6/0x2d0 [vfio_pci]
  [<ffffffffa006c41c>] vfio_pci_set_irqs_ioctl+0x8c/0xa0 [vfio_pci]
  [<ffffffffa006a3b0>] vfio_pci_release+0x70/0x150 [vfio_pci]
  [<ffffffffa0060cbc>] vfio_device_fops_release+0x1c/0x40 [vfio]
  [<ffffffff8114d7db>] __fput+0xdb/0x220
  [<ffffffff8114d92e>] ____fput+0xe/0x10
  [<ffffffff810614ac>] task_work_run+0xbc/0xe0
  [<ffffffff81043d0e>] do_exit+0x3ce/0xe50
  [<ffffffff8104557f>] do_group_exit+0x3f/0xa0
  [<ffffffff81054769>] get_signal_to_deliver+0x1a9/0x5b0
  [<ffffffff810023f8>] do_signal+0x48/0x5e0
  [<ffffffff81056778>] ? k_getrusage+0x368/0x3d0
  [<ffffffff810595f0>] ? getrusage+0x30/0x40
  [<ffffffff81009449>] ? read_tsc+0x9/0x20
  [<ffffffff810029f5>] do_notify_resume+0x65/0x80
  [<ffffffff81648ab8>] int_signal+0x12/0x17
 Code: 89 de 4d 8b 04 24 48 c7 c7 b0 12 bd 81 83 c3 01 49 83 c4 10 42 8b 


--------------------


And our debug patch (on top of 3.10.59):


diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index a7967ceb79e6..b9303fa53fbf 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -781,6 +782,8 @@ static int qi_check_fault(struct intel_iommu *iommu, int index)
 	 * No new descriptors are fetched until the ITE is cleared.
 	 */
 	if (fault & DMA_FSTS_ITE) {
+		trace_printk("DMA_FSTS_ITE set (%08x)\n", fault);
+
 		head = readl(iommu->reg + DMAR_IQH_REG);
 		head = ((head >> DMAR_IQ_SHIFT) - 1 + QI_LENGTH) % QI_LENGTH;
 		head |= 1;
@@ -799,8 +802,10 @@ static int qi_check_fault(struct intel_iommu *iommu, int index)
 			return -EAGAIN;
 	}
 
-	if (fault & DMA_FSTS_ICE)
+	if (fault & DMA_FSTS_ICE) {
+		trace_printk("DMA_FSTS_ICE set (%08x)\n", fault);
 		writel(DMA_FSTS_ICE, iommu->reg + DMAR_FSTS_REG);
+	}
 
 	return 0;
 }
@@ -816,6 +821,7 @@ int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu)
 	struct qi_desc *hw, wait_desc;
 	int wait_index, index;
 	unsigned long flags;
+	cycles_t start_time;
 
 	if (!qi)
 		return 0;
@@ -826,8 +832,16 @@ restart:
 	rc = 0;
 
 	raw_spin_lock_irqsave(&qi->q_lock, flags);
+	start_time = get_cycles();
 	while (qi->free_cnt < 3) {
 		raw_spin_unlock_irqrestore(&qi->q_lock, flags);
+
+		if (get_cycles() - start_time > DMAR_OPERATION_TIMEOUT) {
+			printk(KERN_EMERG "Only %d free entries in invalidation queue.\n",
+				qi->free_cnt);
+			BUG();
+		}
+
 		cpu_relax();
 		raw_spin_lock_irqsave(&qi->q_lock, flags);
 	}
@@ -857,6 +871,7 @@ restart:
 	 */
 	writel(qi->free_head << DMAR_IQ_SHIFT, iommu->reg + DMAR_IQT_REG);
 
+	start_time = get_cycles();
 	while (qi->desc_status[wait_index] != QI_DONE) {
 		/*
 		 * We will leave the interrupts disabled, to prevent interrupt
@@ -870,6 +885,22 @@ restart:
 			break;
 
 		raw_spin_unlock(&qi->q_lock);
+
+		if (get_cycles() - start_time > DMAR_OPERATION_TIMEOUT) {
+			int i;
+
+			pr_emerg("QI stuck waiting for index %d / wait_index %d  IQH/T %08x/%08x FSTS %08x\n",
+				 index, wait_index,
+				 readl(iommu->reg + DMAR_IQH_REG),
+				 readl(iommu->reg + DMAR_IQT_REG),
+				 readl(iommu->reg + DMAR_FSTS_REG));
+			for (i = 0; i < QI_LENGTH; ++i)
+				pr_emerg("  [%3d] stat %x   %016llx %016llx\n",
+					 i, qi->desc_status[i], hw[i].low, hw[i].high);
+
+			BUG();
+		}
+
 		cpu_relax();
 		raw_spin_lock(&qi->q_lock);
 	}
