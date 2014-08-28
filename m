From: Linda Knippers <linda.knippers-VXdhtT5mjnY@public.gmane.org>
Subject: Re: [PATCH v2] iommu/vt-d: Fix broken device issue when using iommu=pt
Date: Thu, 28 Aug 2014 12:42:49 -0400
Message-ID: <53FF5C09.2070309@hp.com>
References: <1408949099-18677-1-git-send-email-wangyijing@huawei.com>	
	<20140825091531.GG16329@8bytes.org>	
	<8dada92a-19af-4b77-b917-f2d97291abbe@CMEXHTCAS2.ad.emulex.com>	
	<53FB1B09.5070209@huawei.com>	
	<8b3c2f14-d454-45f5-87ab-69e1b87f27c9@CMEXHTCAS1.ad.emulex.com>
	<1408979059.29915.0.camel@i7.infradead.org>
	<53FBE82B.2080105@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <53FBE82B.2080105-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Sathya Perla <Sathya.Perla-iH1Dq9VlAzfQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Subramanian Seetharaman <subbu.seetharaman-laKkSmNT4hbQT0dZR+AlfA@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 8/25/2014 9:51 PM, Yijing Wang wrote:
> On 2014/8/25 23:04, David Woodhouse wrote:
>> On Mon, 2014-08-25 at 12:11 +0000, Sathya Perla wrote:
>>>
>>> Hi Wang, from the kernel log I can see that the faulting address
>>> 0xbdf70000 falls in the
>>> RMRR range the BIOS requested:
>>> [    0.111343] DMAR: RMRR base: 0x000000bdf6f000 end: 0x000000bdf7efff
>>
>> We can't see which *devices* that RMRR was for.
>>
>> If we're asked for an RMRR mapping on a "non-existing" device, we should
>> probably make sure we set that up. It's insane, but then most RMRR use
>> is insane so what's new.

Hi Wang,

I'm still puzzled by the DMA requests and am discussing this with
some other developers.  We may have some more questions about your
specific hardware/firmware configuration.

-- ljk

>>
>> Please could I see a copy of the DMAR table?
> 
> Hi David, DMAR table is following, my another question is whether the dmar fault source device id 04:00.4
> 04:00.5 04:00.6 04:00.7 are the wrong request id of physical device 04:00.0 04:00.1 04:00.2 04:00.3.
> 
> It seems not, I configured the eth4(04:00.1), and the network is good while lots dmar fault message in dmesg
> including(04:00.4/5/6/7). So I think eth4 used the correct dmar request id, if this is the case, where the invisible
> request id 04:00.4/5/6/7 from.
> 
> #ifconfig
> eth4      Link encap:Ethernet  HWaddr F0:92:1C:16:8D:4C
>           inet addr:156.4.110.210  Bcast:156.4.110.255  Mask:255.255.255.0
>           inet6 addr: fe80::f292:1cff:fe16:8d4c/64 Scope:Link
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:2922928 errors:0 dropped:13101 overruns:0 frame:0
>           TX packets:141409 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:187229544 (178.5 Mb)  TX bytes:48629667 (46.3 Mb)
> 
> lo        Link encap:Local Loopback
>           inet addr:127.0.0.1  Mask:255.0.0.0
>           inet6 addr: ::1/128 Scope:Host
>           UP LOOPBACK RUNNING  MTU:16436  Metric:1
>           RX packets:98 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:98 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
>           RX bytes:7300 (7.1 Kb)  TX bytes:7300 (7.1 Kb)
> 
> #ethtool -i eth4
> driver: be2net
> version: 4.4.161.0s
> firmware-version: 4.6.247.5
> bus-info: 0000:04:00.1
> supports-statistics: yes
> supports-test: yes
> supports-eeprom-access: yes
> supports-register-dump: yes
> 
> 
> /*
>  * Intel ACPI Component Architecture
>  * AML Disassembler version 20121220-64
>  * Copyright (c) 2000 - 2012 Intel Corporation
>  *
>  * Disassembly of dmar.dat, Tue Aug 26 03:05:06 2014
>  *
>  * ACPI Data Table [DMAR]
>  *
>  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
>  */
> 
> [000h 0000   4]                    Signature : "DMAR"    [DMA Remapping table]
> [004h 0004   4]                 Table Length : 0000060C
> [008h 0008   1]                     Revision : 01
> [009h 0009   1]                     Checksum : 0D
> [00Ah 0010   6]                       Oem ID : "HP    "
> [010h 0016   8]                 Oem Table ID : "ProLiant"
> [018h 0024   4]                 Oem Revision : 00000001
> [01Ch 0028   4]              Asl Compiler ID : "  "
> [020h 0032   4]        Asl Compiler Revision : 0000162E
> 
> [024h 0036   1]           Host Address Width : 2D
> [025h 0037   1]                        Flags : 03
> 
> [030h 0048   2]                Subtable Type : 0000 [Hardware Unit Definition]
> [032h 0050   2]                       Length : 00B0
> [034h 0052   1]                        Flags : 00
> [035h 0053   1]                     Reserved : 00
> [036h 0054   2]           PCI Segment Number : 0000
> [038h 0056   8]        Register Base Address : 00000000EFEFE000
> 
> [040h 0064   1]      Device Scope Entry Type : 02
> [041h 0065   1]                 Entry Length : 08
> [042h 0066   2]                     Reserved : 0000
> [044h 0068   1]               Enumeration ID : 00
> [045h 0069   1]               PCI Bus Number : 20
> [046h 0070   2]                     PCI Path : 00,00
> 
> [048h 0072   1]      Device Scope Entry Type : 02
> [049h 0073   1]                 Entry Length : 08
> [04Ah 0074   2]                     Reserved : 0000
> [04Ch 0076   1]               Enumeration ID : 00
> [04Dh 0077   1]               PCI Bus Number : 20
> [04Eh 0078   2]                     PCI Path : 01,00
> 
> [050h 0080   1]      Device Scope Entry Type : 02
> [051h 0081   1]                 Entry Length : 08
> [052h 0082   2]                     Reserved : 0000
> [054h 0084   1]               Enumeration ID : 00
> [055h 0085   1]               PCI Bus Number : 20
> [056h 0086   2]                     PCI Path : 01,01
> 
> [058h 0088   1]      Device Scope Entry Type : 02
> [059h 0089   1]                 Entry Length : 08
> [05Ah 0090   2]                     Reserved : 0000
> [05Ch 0092   1]               Enumeration ID : 00
> [05Dh 0093   1]               PCI Bus Number : 20
> [05Eh 0094   2]                     PCI Path : 02,00
> 
> [060h 0096   1]      Device Scope Entry Type : 02
> [061h 0097   1]                 Entry Length : 08
> [062h 0098   2]                     Reserved : 0000
> [064h 0100   1]               Enumeration ID : 00
> [065h 0101   1]               PCI Bus Number : 20
> [066h 0102   2]                     PCI Path : 02,01
> 
> [068h 0104   1]      Device Scope Entry Type : 02
> [069h 0105   1]                 Entry Length : 08
> [06Ah 0106   2]                     Reserved : 0000
> [06Ch 0108   1]               Enumeration ID : 00
> [06Dh 0109   1]               PCI Bus Number : 20
> [06Eh 0110   2]                     PCI Path : 02,02
> 
> [070h 0112   1]      Device Scope Entry Type : 02
> [071h 0113   1]                 Entry Length : 08
> [072h 0114   2]                     Reserved : 0000
> [074h 0116   1]               Enumeration ID : 00
> [075h 0117   1]               PCI Bus Number : 20
> [076h 0118   2]                     PCI Path : 02,03
> 
> [078h 0120   1]      Device Scope Entry Type : 02
> [079h 0121   1]                 Entry Length : 08
> [07Ah 0122   2]                     Reserved : 0000
> [07Ch 0124   1]               Enumeration ID : 00
> [07Dh 0125   1]               PCI Bus Number : 20
> [07Eh 0126   2]                     PCI Path : 03,00
> 
> [080h 0128   1]      Device Scope Entry Type : 02
> [081h 0129   1]                 Entry Length : 08
> [082h 0130   2]                     Reserved : 0000
> [084h 0132   1]               Enumeration ID : 00
> [085h 0133   1]               PCI Bus Number : 20
> [086h 0134   2]                     PCI Path : 03,01
> 
> [088h 0136   1]      Device Scope Entry Type : 02
> [089h 0137   1]                 Entry Length : 08
> [08Ah 0138   2]                     Reserved : 0000
> [08Ch 0140   1]               Enumeration ID : 00
> [08Dh 0141   1]               PCI Bus Number : 20
> [08Eh 0142   2]                     PCI Path : 03,02
> 
> [090h 0144   1]      Device Scope Entry Type : 02
> [091h 0145   1]                 Entry Length : 08
> [092h 0146   2]                     Reserved : 0000
> [094h 0148   1]               Enumeration ID : 00
> [095h 0149   1]               PCI Bus Number : 20
> [096h 0150   2]                     PCI Path : 03,03
> 
> [098h 0152   1]      Device Scope Entry Type : 03
> [099h 0153   1]                 Entry Length : 08
> [09Ah 0154   2]                     Reserved : 0000
> [09Ch 0156   1]               Enumeration ID : 0A
> [09Dh 0157   1]               PCI Bus Number : 20
> [09Eh 0158   2]                     PCI Path : 05,04
> 
> [0A0h 0160   1]      Device Scope Entry Type : 01
> [0A1h 0161   1]                 Entry Length : 08
> [0A2h 0162   2]                     Reserved : 0000
> [0A4h 0164   1]               Enumeration ID : 00
> [0A5h 0165   1]               PCI Bus Number : 20
> [0A6h 0166   2]                     PCI Path : 04,00
> 
> [0A8h 0168   1]      Device Scope Entry Type : 01
> [0A9h 0169   1]                 Entry Length : 08
> [0AAh 0170   2]                     Reserved : 0000
> [0ACh 0172   1]               Enumeration ID : 00
> [0ADh 0173   1]               PCI Bus Number : 20
> [0AEh 0174   2]                     PCI Path : 04,01
> 
> [0B0h 0176   1]      Device Scope Entry Type : 01
> [0B1h 0177   1]                 Entry Length : 08
> [0B2h 0178   2]                     Reserved : 0000
> [0B4h 0180   1]               Enumeration ID : 00
> [0B5h 0181   1]               PCI Bus Number : 20
> [0B6h 0182   2]                     PCI Path : 04,02
> 
> [0B8h 0184   1]      Device Scope Entry Type : 01
> [0B9h 0185   1]                 Entry Length : 08
> [0BAh 0186   2]                     Reserved : 0000
> [0BCh 0188   1]               Enumeration ID : 00
> [0BDh 0189   1]               PCI Bus Number : 20
> [0BEh 0190   2]                     PCI Path : 04,03
> 
> [0C0h 0192   1]      Device Scope Entry Type : 01
> [0C1h 0193   1]                 Entry Length : 08
> [0C2h 0194   2]                     Reserved : 0000
> [0C4h 0196   1]               Enumeration ID : 00
> [0C5h 0197   1]               PCI Bus Number : 20
> [0C6h 0198   2]                     PCI Path : 04,04
> 
> [0C8h 0200   1]      Device Scope Entry Type : 01
> [0C9h 0201   1]                 Entry Length : 08
> [0CAh 0202   2]                     Reserved : 0000
> [0CCh 0204   1]               Enumeration ID : 00
> [0CDh 0205   1]               PCI Bus Number : 20
> [0CEh 0206   2]                     PCI Path : 04,05
> 
> [0D0h 0208   1]      Device Scope Entry Type : 01
> [0D1h 0209   1]                 Entry Length : 08
> [0D2h 0210   2]                     Reserved : 0000
> [0D4h 0212   1]               Enumeration ID : 00
> [0D5h 0213   1]               PCI Bus Number : 20
> [0D6h 0214   2]                     PCI Path : 04,06
> 
> [0D8h 0216   1]      Device Scope Entry Type : 01
> [0D9h 0217   1]                 Entry Length : 08
> [0DAh 0218   2]                     Reserved : 0000
> [0DCh 0220   1]               Enumeration ID : 00
> [0DDh 0221   1]               PCI Bus Number : 20
> [0DEh 0222   2]                     PCI Path : 04,07
> 
> [0E0h 0224   2]                Subtable Type : 0000 [Hardware Unit Definition]
> [0E2h 0226   2]                       Length : 0028
> [0E4h 0228   1]                        Flags : 01
> [0E5h 0229   1]                     Reserved : 00
> [0E6h 0230   2]           PCI Segment Number : 0000
> [0E8h 0232   8]        Register Base Address : 00000000DCFFE000
> 
> [0F0h 0240   1]      Device Scope Entry Type : 03
> [0F1h 0241   1]                 Entry Length : 08
> [0F2h 0242   2]                     Reserved : 0000
> [0F4h 0244   1]               Enumeration ID : 08
> [0F5h 0245   1]               PCI Bus Number : 00
> [0F6h 0246   2]                     PCI Path : 1E,01
> 
> [0F8h 0248   1]      Device Scope Entry Type : 03
> [0F9h 0249   1]                 Entry Length : 08
> [0FAh 0250   2]                     Reserved : 0000
> [0FCh 0252   1]               Enumeration ID : 00
> [0FDh 0253   1]               PCI Bus Number : 00
> [0FEh 0254   2]                     PCI Path : 05,04
> 
> [100h 0256   1]      Device Scope Entry Type : 04
> [101h 0257   1]                 Entry Length : 08
> [102h 0258   2]                     Reserved : 0000
> [104h 0260   1]               Enumeration ID : 00
> [105h 0261   1]               PCI Bus Number : 00
> [106h 0262   2]                     PCI Path : 1F,00
> 
> [108h 0264   2]                Subtable Type : 0001 [Reserved Memory Region]
> [10Ah 0266   2]                       Length : 0028
> [10Ch 0268   2]                     Reserved : 0000
> [10Eh 0270   2]           PCI Segment Number : 0000
> [110h 0272   8]                 Base Address : 00000000BDFFD000
> [118h 0280   8]          End Address (limit) : 00000000BDFFFFFF
> 
> [120h 0288   1]      Device Scope Entry Type : 01
> [121h 0289   1]                 Entry Length : 08
> [122h 0290   2]                     Reserved : 0000
> [124h 0292   1]               Enumeration ID : 00
> [125h 0293   1]               PCI Bus Number : 00
> [126h 0294   2]                     PCI Path : 1D,00
> 
> [128h 0296   1]      Device Scope Entry Type : 01
> [129h 0297   1]                 Entry Length : 08
> [12Ah 0298   2]                     Reserved : 0000
> [12Ch 0300   1]               Enumeration ID : 00
> [12Dh 0301   1]               PCI Bus Number : 00
> [12Eh 0302   2]                     PCI Path : 1A,00
> 
> [130h 0304   2]                Subtable Type : 0001 [Reserved Memory Region]
> [132h 0306   2]                       Length : 0036
> [134h 0308   2]                     Reserved : 0000
> [136h 0310   2]           PCI Segment Number : 0000
> [138h 0312   8]                 Base Address : 00000000BDFF6000
> [140h 0320   8]          End Address (limit) : 00000000BDFFCFFF
> 
> [148h 0328   1]      Device Scope Entry Type : 01
> [149h 0329   1]                 Entry Length : 0A
> [14Ah 0330   2]                     Reserved : 0000
> [14Ch 0332   1]               Enumeration ID : 00
> [14Dh 0333   1]               PCI Bus Number : 00
> [14Eh 0334   2]                     PCI Path : 1C,07
> [150h 0336   2]                     PCI Path : 00,00
> 
> [152h 0338   1]      Device Scope Entry Type : 01
> [153h 0339   1]                 Entry Length : 0A
> [154h 0340   2]                     Reserved : 0000
> [156h 0342   1]               Enumeration ID : 00
> [157h 0343   1]               PCI Bus Number : 00
> [158h 0344   2]                     PCI Path : 1C,07
> [15Ah 0346   2]                     PCI Path : 00,02
> 
> [15Ch 0348   1]      Device Scope Entry Type : 01
> [15Dh 0349   1]                 Entry Length : 0A
> [15Eh 0350   2]                     Reserved : 0000
> [160h 0352   1]               Enumeration ID : 00
> [161h 0353   1]               PCI Bus Number : 00
> [162h 0354   2]                     PCI Path : 1C,07
> [164h 0356   2]                     PCI Path : 00,04
> 
> [166h 0358   2]                Subtable Type : 0001 [Reserved Memory Region]
> [168h 0360   2]                       Length : 00A0
> [16Ah 0362   2]                     Reserved : 0000
> [16Ch 0364   2]           PCI Segment Number : 0000
> [16Eh 0366   8]                 Base Address : 00000000BDF83000
> [176h 0374   8]          End Address (limit) : 00000000BDF84FFF
> 
> [17Eh 0382   1]      Device Scope Entry Type : 01
> [17Fh 0383   1]                 Entry Length : 0A
> [180h 0384   2]                     Reserved : 0000
> [182h 0386   1]               Enumeration ID : 00
> [183h 0387   1]               PCI Bus Number : 00
> [184h 0388   2]                     PCI Path : 02,02
> [186h 0390   2]                     PCI Path : 00,00
> 
> [188h 0392   1]      Device Scope Entry Type : 01
> [189h 0393   1]                 Entry Length : 0A
> [18Ah 0394   2]                     Reserved : 0000
> [18Ch 0396   1]               Enumeration ID : 00
> [18Dh 0397   1]               PCI Bus Number : 00
> [18Eh 0398   2]                     PCI Path : 1C,07
> [190h 0400   2]                     PCI Path : 00,00
> 
> [192h 0402   1]      Device Scope Entry Type : 01
> [193h 0403   1]                 Entry Length : 0A
> [194h 0404   2]                     Reserved : 0000
> [196h 0406   1]               Enumeration ID : 00
> [197h 0407   1]               PCI Bus Number : 00
> [198h 0408   2]                     PCI Path : 1C,07
> [19Ah 0410   2]                     PCI Path : 00,02
> 
> [19Ch 0412   1]      Device Scope Entry Type : 01
> [19Dh 0413   1]                 Entry Length : 0A
> [19Eh 0414   2]                     Reserved : 0000
> [1A0h 0416   1]               Enumeration ID : 00
> [1A1h 0417   1]               PCI Bus Number : 00
> [1A2h 0418   2]                     PCI Path : 01,01
> [1A4h 0420   2]                     PCI Path : 00,00
> 
> [1A6h 0422   1]      Device Scope Entry Type : 01
> [1A7h 0423   1]                 Entry Length : 08
> [1A8h 0424   2]                     Reserved : 0000
> [1AAh 0426   1]               Enumeration ID : 00
> [1ABh 0427   1]               PCI Bus Number : 00
> [1ACh 0428   2]                     PCI Path : 1F,02
> 
> [1AEh 0430   1]      Device Scope Entry Type : 01
> [1AFh 0431   1]                 Entry Length : 08
> [1B0h 0432   2]                     Reserved : 0000
> [1B2h 0434   1]               Enumeration ID : 00
> [1B3h 0435   1]               PCI Bus Number : 00
> [1B4h 0436   2]                     PCI Path : 1F,05
> 
> [1B6h 0438   1]      Device Scope Entry Type : 01
> [1B7h 0439   1]                 Entry Length : 0A
> [1B8h 0440   2]                     Reserved : 0000
> [1BAh 0442   1]               Enumeration ID : 00
> [1BBh 0443   1]               PCI Bus Number : 00
> [1BCh 0444   2]                     PCI Path : 02,00
> [1BEh 0446   2]                     PCI Path : 00,00
> 
> [1C0h 0448   1]      Device Scope Entry Type : 01
> [1C1h 0449   1]                 Entry Length : 0A
> [1C2h 0450   2]                     Reserved : 0000
> [1C4h 0452   1]               Enumeration ID : 00
> [1C5h 0453   1]               PCI Bus Number : 00
> [1C6h 0454   2]                     PCI Path : 02,00
> [1C8h 0456   2]                     PCI Path : 00,01
> 
> [1CAh 0458   1]      Device Scope Entry Type : 01
> [1CBh 0459   1]                 Entry Length : 0A
> [1CCh 0460   2]                     Reserved : 0000
> [1CEh 0462   1]               Enumeration ID : 00
> [1CFh 0463   1]               PCI Bus Number : 00
> [1D0h 0464   2]                     PCI Path : 02,00
> [1D2h 0466   2]                     PCI Path : 00,02
> 
> [1D4h 0468   1]      Device Scope Entry Type : 01
> [1D5h 0469   1]                 Entry Length : 0A
> [1D6h 0470   2]                     Reserved : 0000
> [1D8h 0472   1]               Enumeration ID : 00
> [1D9h 0473   1]               PCI Bus Number : 00
> [1DAh 0474   2]                     PCI Path : 02,00
> [1DCh 0476   2]                     PCI Path : 00,03
> 
> [1DEh 0478   1]      Device Scope Entry Type : 01
> [1DFh 0479   1]                 Entry Length : 0A
> [1E0h 0480   2]                     Reserved : 0000
> [1E2h 0482   1]               Enumeration ID : 00
> [1E3h 0483   1]               PCI Bus Number : 00
> [1E4h 0484   2]                     PCI Path : 03,00
> [1E6h 0486   2]                     PCI Path : 00,00
> 
> [1E8h 0488   1]      Device Scope Entry Type : 01
> [1E9h 0489   1]                 Entry Length : 0A
> [1EAh 0490   2]                     Reserved : 0000
> [1ECh 0492   1]               Enumeration ID : 00
> [1EDh 0493   1]               PCI Bus Number : 00
> [1EEh 0494   2]                     PCI Path : 03,00
> [1F0h 0496   2]                     PCI Path : 00,01
> 
> [1F2h 0498   1]      Device Scope Entry Type : 01
> [1F3h 0499   1]                 Entry Length : 0A
> [1F4h 0500   2]                     Reserved : 0000
> [1F6h 0502   1]               Enumeration ID : 00
> [1F7h 0503   1]               PCI Bus Number : 20
> [1F8h 0504   2]                     PCI Path : 03,00
> [1FAh 0506   2]                     PCI Path : 00,00
> 
> [1FCh 0508   1]      Device Scope Entry Type : 01
> [1FDh 0509   1]                 Entry Length : 0A
> [1FEh 0510   2]                     Reserved : 0000
> [200h 0512   1]               Enumeration ID : 00
> [201h 0513   1]               PCI Bus Number : 20
> [202h 0514   2]                     PCI Path : 03,00
> [204h 0516   2]                     PCI Path : 00,01
> 
> [206h 0518   2]                Subtable Type : 0001 [Reserved Memory Region]
> [208h 0520   2]                       Length : 00A0
> [20Ah 0522   2]                     Reserved : 0000
> [20Ch 0524   2]           PCI Segment Number : 0000
> [20Eh 0526   8]                 Base Address : 00000000BDF7F000
> [216h 0534   8]          End Address (limit) : 00000000BDF82FFF
> 
> [21Eh 0542   1]      Device Scope Entry Type : 01
> [21Fh 0543   1]                 Entry Length : 0A
> [220h 0544   2]                     Reserved : 0000
> [222h 0546   1]               Enumeration ID : 00
> [223h 0547   1]               PCI Bus Number : 00
> [224h 0548   2]                     PCI Path : 02,02
> [226h 0550   2]                     PCI Path : 00,00
> 
> [228h 0552   1]      Device Scope Entry Type : 01
> [229h 0553   1]                 Entry Length : 0A
> [22Ah 0554   2]                     Reserved : 0000
> [22Ch 0556   1]               Enumeration ID : 00
> [22Dh 0557   1]               PCI Bus Number : 00
> [22Eh 0558   2]                     PCI Path : 1C,07
> [230h 0560   2]                     PCI Path : 00,00
> 
> [232h 0562   1]      Device Scope Entry Type : 01
> [233h 0563   1]                 Entry Length : 0A
> [234h 0564   2]                     Reserved : 0000
> [236h 0566   1]               Enumeration ID : 00
> [237h 0567   1]               PCI Bus Number : 00
> [238h 0568   2]                     PCI Path : 1C,07
> [23Ah 0570   2]                     PCI Path : 00,02
> 
> [23Ch 0572   1]      Device Scope Entry Type : 01
> [23Dh 0573   1]                 Entry Length : 0A
> [23Eh 0574   2]                     Reserved : 0000
> [240h 0576   1]               Enumeration ID : 00
> [241h 0577   1]               PCI Bus Number : 00
> [242h 0578   2]                     PCI Path : 01,01
> [244h 0580   2]                     PCI Path : 00,00
> 
> [246h 0582   1]      Device Scope Entry Type : 01
> [247h 0583   1]                 Entry Length : 08
> [248h 0584   2]                     Reserved : 0000
> [24Ah 0586   1]               Enumeration ID : 00
> [24Bh 0587   1]               PCI Bus Number : 00
> [24Ch 0588   2]                     PCI Path : 1F,02
> 
> [24Eh 0590   1]      Device Scope Entry Type : 01
> [24Fh 0591   1]                 Entry Length : 08
> [250h 0592   2]                     Reserved : 0000
> [252h 0594   1]               Enumeration ID : 00
> [253h 0595   1]               PCI Bus Number : 00
> [254h 0596   2]                     PCI Path : 1F,05
> 
> [256h 0598   1]      Device Scope Entry Type : 01
> [257h 0599   1]                 Entry Length : 0A
> [258h 0600   2]                     Reserved : 0000
> [25Ah 0602   1]               Enumeration ID : 00
> [25Bh 0603   1]               PCI Bus Number : 00
> [25Ch 0604   2]                     PCI Path : 02,00
> [25Eh 0606   2]                     PCI Path : 00,00
> 
> [260h 0608   1]      Device Scope Entry Type : 01
> [261h 0609   1]                 Entry Length : 0A
> [262h 0610   2]                     Reserved : 0000
> [264h 0612   1]               Enumeration ID : 00
> [265h 0613   1]               PCI Bus Number : 00
> [266h 0614   2]                     PCI Path : 02,00
> [268h 0616   2]                     PCI Path : 00,01
> 
> [26Ah 0618   1]      Device Scope Entry Type : 01
> [26Bh 0619   1]                 Entry Length : 0A
> [26Ch 0620   2]                     Reserved : 0000
> [26Eh 0622   1]               Enumeration ID : 00
> [26Fh 0623   1]               PCI Bus Number : 00
> [270h 0624   2]                     PCI Path : 02,00
> [272h 0626   2]                     PCI Path : 00,02
> 
> [274h 0628   1]      Device Scope Entry Type : 01
> [275h 0629   1]                 Entry Length : 0A
> [276h 0630   2]                     Reserved : 0000
> [278h 0632   1]               Enumeration ID : 00
> [279h 0633   1]               PCI Bus Number : 00
> [27Ah 0634   2]                     PCI Path : 02,00
> [27Ch 0636   2]                     PCI Path : 00,03
> 
> [27Eh 0638   1]      Device Scope Entry Type : 01
> [27Fh 0639   1]                 Entry Length : 0A
> [280h 0640   2]                     Reserved : 0000
> [282h 0642   1]               Enumeration ID : 00
> [283h 0643   1]               PCI Bus Number : 00
> [284h 0644   2]                     PCI Path : 03,00
> [286h 0646   2]                     PCI Path : 00,00
> 
> [288h 0648   1]      Device Scope Entry Type : 01
> [289h 0649   1]                 Entry Length : 0A
> [28Ah 0650   2]                     Reserved : 0000
> [28Ch 0652   1]               Enumeration ID : 00
> [28Dh 0653   1]               PCI Bus Number : 00
> [28Eh 0654   2]                     PCI Path : 03,00
> [290h 0656   2]                     PCI Path : 00,01
> 
> [292h 0658   1]      Device Scope Entry Type : 01
> [293h 0659   1]                 Entry Length : 0A
> [294h 0660   2]                     Reserved : 0000
> [296h 0662   1]               Enumeration ID : 00
> [297h 0663   1]               PCI Bus Number : 20
> [298h 0664   2]                     PCI Path : 03,00
> [29Ah 0666   2]                     PCI Path : 00,00
> 
> [29Ch 0668   1]      Device Scope Entry Type : 01
> [29Dh 0669   1]                 Entry Length : 0A
> [29Eh 0670   2]                     Reserved : 0000
> [2A0h 0672   1]               Enumeration ID : 00
> [2A1h 0673   1]               PCI Bus Number : 20
> [2A2h 0674   2]                     PCI Path : 03,00
> [2A4h 0676   2]                     PCI Path : 00,01
> 
> [2A6h 0678   2]                Subtable Type : 0001 [Reserved Memory Region]
> [2A8h 0680   2]                       Length : 00A0
> [2AAh 0682   2]                     Reserved : 0000
> [2ACh 0684   2]           PCI Segment Number : 0000
> [2AEh 0686   8]                 Base Address : 00000000BDF6F000
> [2B6h 0694   8]          End Address (limit) : 00000000BDF7EFFF
> 
> [2BEh 0702   1]      Device Scope Entry Type : 01
> [2BFh 0703   1]                 Entry Length : 0A
> [2C0h 0704   2]                     Reserved : 0000
> [2C2h 0706   1]               Enumeration ID : 00
> [2C3h 0707   1]               PCI Bus Number : 00
> [2C4h 0708   2]                     PCI Path : 02,02
> [2C6h 0710   2]                     PCI Path : 00,00
> 
> [2C8h 0712   1]      Device Scope Entry Type : 01
> [2C9h 0713   1]                 Entry Length : 0A
> [2CAh 0714   2]                     Reserved : 0000
> [2CCh 0716   1]               Enumeration ID : 00
> [2CDh 0717   1]               PCI Bus Number : 00
> [2CEh 0718   2]                     PCI Path : 1C,07
> [2D0h 0720   2]                     PCI Path : 00,00
> 
> [2D2h 0722   1]      Device Scope Entry Type : 01
> [2D3h 0723   1]                 Entry Length : 0A
> [2D4h 0724   2]                     Reserved : 0000
> [2D6h 0726   1]               Enumeration ID : 00
> [2D7h 0727   1]               PCI Bus Number : 00
> [2D8h 0728   2]                     PCI Path : 1C,07
> [2DAh 0730   2]                     PCI Path : 00,02
> 
> [2DCh 0732   1]      Device Scope Entry Type : 01
> [2DDh 0733   1]                 Entry Length : 0A
> [2DEh 0734   2]                     Reserved : 0000
> [2E0h 0736   1]               Enumeration ID : 00
> [2E1h 0737   1]               PCI Bus Number : 00
> [2E2h 0738   2]                     PCI Path : 01,01
> [2E4h 0740   2]                     PCI Path : 00,00
> 
> [2E6h 0742   1]      Device Scope Entry Type : 01
> [2E7h 0743   1]                 Entry Length : 08
> [2E8h 0744   2]                     Reserved : 0000
> [2EAh 0746   1]               Enumeration ID : 00
> [2EBh 0747   1]               PCI Bus Number : 00
> [2ECh 0748   2]                     PCI Path : 1F,02
> 
> [2EEh 0750   1]      Device Scope Entry Type : 01
> [2EFh 0751   1]                 Entry Length : 08
> [2F0h 0752   2]                     Reserved : 0000
> [2F2h 0754   1]               Enumeration ID : 00
> [2F3h 0755   1]               PCI Bus Number : 00
> [2F4h 0756   2]                     PCI Path : 1F,05
> 
> [2F6h 0758   1]      Device Scope Entry Type : 01
> [2F7h 0759   1]                 Entry Length : 0A
> [2F8h 0760   2]                     Reserved : 0000
> [2FAh 0762   1]               Enumeration ID : 00
> [2FBh 0763   1]               PCI Bus Number : 00
> [2FCh 0764   2]                     PCI Path : 02,00
> [2FEh 0766   2]                     PCI Path : 00,00
> 
> [300h 0768   1]      Device Scope Entry Type : 01
> [301h 0769   1]                 Entry Length : 0A
> [302h 0770   2]                     Reserved : 0000
> [304h 0772   1]               Enumeration ID : 00
> [305h 0773   1]               PCI Bus Number : 00
> [306h 0774   2]                     PCI Path : 02,00
> [308h 0776   2]                     PCI Path : 00,01
> 
> [30Ah 0778   1]      Device Scope Entry Type : 01
> [30Bh 0779   1]                 Entry Length : 0A
> [30Ch 0780   2]                     Reserved : 0000
> [30Eh 0782   1]               Enumeration ID : 00
> [30Fh 0783   1]               PCI Bus Number : 00
> [310h 0784   2]                     PCI Path : 02,00
> [312h 0786   2]                     PCI Path : 00,02
> 
> [314h 0788   1]      Device Scope Entry Type : 01
> [315h 0789   1]                 Entry Length : 0A
> [316h 0790   2]                     Reserved : 0000
> [318h 0792   1]               Enumeration ID : 00
> [319h 0793   1]               PCI Bus Number : 00
> [31Ah 0794   2]                     PCI Path : 02,00
> [31Ch 0796   2]                     PCI Path : 00,03
> 
> [31Eh 0798   1]      Device Scope Entry Type : 01
> [31Fh 0799   1]                 Entry Length : 0A
> [320h 0800   2]                     Reserved : 0000
> [322h 0802   1]               Enumeration ID : 00
> [323h 0803   1]               PCI Bus Number : 00
> [324h 0804   2]                     PCI Path : 03,00
> [326h 0806   2]                     PCI Path : 00,00
> 
> [328h 0808   1]      Device Scope Entry Type : 01
> [329h 0809   1]                 Entry Length : 0A
> [32Ah 0810   2]                     Reserved : 0000
> [32Ch 0812   1]               Enumeration ID : 00
> [32Dh 0813   1]               PCI Bus Number : 00
> [32Eh 0814   2]                     PCI Path : 03,00
> [330h 0816   2]                     PCI Path : 00,01
> 
> [332h 0818   1]      Device Scope Entry Type : 01
> [333h 0819   1]                 Entry Length : 0A
> [334h 0820   2]                     Reserved : 0000
> [336h 0822   1]               Enumeration ID : 00
> [337h 0823   1]               PCI Bus Number : 20
> [338h 0824   2]                     PCI Path : 03,00
> [33Ah 0826   2]                     PCI Path : 00,00
> 
> [33Ch 0828   1]      Device Scope Entry Type : 01
> [33Dh 0829   1]                 Entry Length : 0A
> [33Eh 0830   2]                     Reserved : 0000
> [340h 0832   1]               Enumeration ID : 00
> [341h 0833   1]               PCI Bus Number : 20
> [342h 0834   2]                     PCI Path : 03,00
> [344h 0836   2]                     PCI Path : 00,01
> 
> [346h 0838   2]                Subtable Type : 0001 [Reserved Memory Region]
> [348h 0840   2]                       Length : 00A0
> [34Ah 0842   2]                     Reserved : 0000
> [34Ch 0844   2]           PCI Segment Number : 0000
> [34Eh 0846   8]                 Base Address : 00000000BDF6E000
> [356h 0854   8]          End Address (limit) : 00000000BDF6EFFF
> 
> [35Eh 0862   1]      Device Scope Entry Type : 01
> [35Fh 0863   1]                 Entry Length : 0A
> [360h 0864   2]                     Reserved : 0000
> [362h 0866   1]               Enumeration ID : 00
> [363h 0867   1]               PCI Bus Number : 00
> [364h 0868   2]                     PCI Path : 02,02
> [366h 0870   2]                     PCI Path : 00,00
> 
> [368h 0872   1]      Device Scope Entry Type : 01
> [369h 0873   1]                 Entry Length : 0A
> [36Ah 0874   2]                     Reserved : 0000
> [36Ch 0876   1]               Enumeration ID : 00
> [36Dh 0877   1]               PCI Bus Number : 00
> [36Eh 0878   2]                     PCI Path : 1C,07
> [370h 0880   2]                     PCI Path : 00,00
> 
> [372h 0882   1]      Device Scope Entry Type : 01
> [373h 0883   1]                 Entry Length : 0A
> [374h 0884   2]                     Reserved : 0000
> [376h 0886   1]               Enumeration ID : 00
> [377h 0887   1]               PCI Bus Number : 00
> [378h 0888   2]                     PCI Path : 1C,07
> [37Ah 0890   2]                     PCI Path : 00,02
> 
> [37Ch 0892   1]      Device Scope Entry Type : 01
> [37Dh 0893   1]                 Entry Length : 0A
> [37Eh 0894   2]                     Reserved : 0000
> [380h 0896   1]               Enumeration ID : 00
> [381h 0897   1]               PCI Bus Number : 00
> [382h 0898   2]                     PCI Path : 01,01
> [384h 0900   2]                     PCI Path : 00,00
> 
> [386h 0902   1]      Device Scope Entry Type : 01
> [387h 0903   1]                 Entry Length : 08
> [388h 0904   2]                     Reserved : 0000
> [38Ah 0906   1]               Enumeration ID : 00
> [38Bh 0907   1]               PCI Bus Number : 00
> [38Ch 0908   2]                     PCI Path : 1F,02
> 
> [38Eh 0910   1]      Device Scope Entry Type : 01
> [38Fh 0911   1]                 Entry Length : 08
> [390h 0912   2]                     Reserved : 0000
> [392h 0914   1]               Enumeration ID : 00
> [393h 0915   1]               PCI Bus Number : 00
> [394h 0916   2]                     PCI Path : 1F,05
> 
> [396h 0918   1]      Device Scope Entry Type : 01
> [397h 0919   1]                 Entry Length : 0A
> [398h 0920   2]                     Reserved : 0000
> [39Ah 0922   1]               Enumeration ID : 00
> [39Bh 0923   1]               PCI Bus Number : 00
> [39Ch 0924   2]                     PCI Path : 02,00
> [39Eh 0926   2]                     PCI Path : 00,00
> 
> [3A0h 0928   1]      Device Scope Entry Type : 01
> [3A1h 0929   1]                 Entry Length : 0A
> [3A2h 0930   2]                     Reserved : 0000
> [3A4h 0932   1]               Enumeration ID : 00
> [3A5h 0933   1]               PCI Bus Number : 00
> [3A6h 0934   2]                     PCI Path : 02,00
> [3A8h 0936   2]                     PCI Path : 00,01
> 
> [3AAh 0938   1]      Device Scope Entry Type : 01
> [3ABh 0939   1]                 Entry Length : 0A
> [3ACh 0940   2]                     Reserved : 0000
> [3AEh 0942   1]               Enumeration ID : 00
> [3AFh 0943   1]               PCI Bus Number : 00
> [3B0h 0944   2]                     PCI Path : 02,00
> [3B2h 0946   2]                     PCI Path : 00,02
> 
> [3B4h 0948   1]      Device Scope Entry Type : 01
> [3B5h 0949   1]                 Entry Length : 0A
> [3B6h 0950   2]                     Reserved : 0000
> [3B8h 0952   1]               Enumeration ID : 00
> [3B9h 0953   1]               PCI Bus Number : 00
> [3BAh 0954   2]                     PCI Path : 02,00
> [3BCh 0956   2]                     PCI Path : 00,03
> 
> [3BEh 0958   1]      Device Scope Entry Type : 01
> [3BFh 0959   1]                 Entry Length : 0A
> [3C0h 0960   2]                     Reserved : 0000
> [3C2h 0962   1]               Enumeration ID : 00
> [3C3h 0963   1]               PCI Bus Number : 00
> [3C4h 0964   2]                     PCI Path : 03,00
> [3C6h 0966   2]                     PCI Path : 00,00
> 
> [3C8h 0968   1]      Device Scope Entry Type : 01
> [3C9h 0969   1]                 Entry Length : 0A
> [3CAh 0970   2]                     Reserved : 0000
> [3CCh 0972   1]               Enumeration ID : 00
> [3CDh 0973   1]               PCI Bus Number : 00
> [3CEh 0974   2]                     PCI Path : 03,00
> [3D0h 0976   2]                     PCI Path : 00,01
> 
> [3D2h 0978   1]      Device Scope Entry Type : 01
> [3D3h 0979   1]                 Entry Length : 0A
> [3D4h 0980   2]                     Reserved : 0000
> [3D6h 0982   1]               Enumeration ID : 00
> [3D7h 0983   1]               PCI Bus Number : 20
> [3D8h 0984   2]                     PCI Path : 03,00
> [3DAh 0986   2]                     PCI Path : 00,00
> 
> [3DCh 0988   1]      Device Scope Entry Type : 01
> [3DDh 0989   1]                 Entry Length : 0A
> [3DEh 0990   2]                     Reserved : 0000
> [3E0h 0992   1]               Enumeration ID : 00
> [3E1h 0993   1]               PCI Bus Number : 20
> [3E2h 0994   2]                     PCI Path : 03,00
> [3E4h 0996   2]                     PCI Path : 00,01
> 
> [3E6h 0998   2]                Subtable Type : 0001 [Reserved Memory Region]
> [3E8h 1000   2]                       Length : 00A0
> [3EAh 1002   2]                     Reserved : 0000
> [3ECh 1004   2]           PCI Segment Number : 0000
> [3EEh 1006   8]                 Base Address : 00000000000F4000
> [3F6h 1014   8]          End Address (limit) : 00000000000F4FFF
> 
> [3FEh 1022   1]      Device Scope Entry Type : 01
> [3FFh 1023   1]                 Entry Length : 0A
> [400h 1024   2]                     Reserved : 0000
> [402h 1026   1]               Enumeration ID : 00
> [403h 1027   1]               PCI Bus Number : 00
> [404h 1028   2]                     PCI Path : 02,02
> [406h 1030   2]                     PCI Path : 00,00
> 
> [408h 1032   1]      Device Scope Entry Type : 01
> [409h 1033   1]                 Entry Length : 0A
> [40Ah 1034   2]                     Reserved : 0000
> [40Ch 1036   1]               Enumeration ID : 00
> [40Dh 1037   1]               PCI Bus Number : 00
> [40Eh 1038   2]                     PCI Path : 1C,07
> [410h 1040   2]                     PCI Path : 00,00
> 
> [412h 1042   1]      Device Scope Entry Type : 01
> [413h 1043   1]                 Entry Length : 0A
> [414h 1044   2]                     Reserved : 0000
> [416h 1046   1]               Enumeration ID : 00
> [417h 1047   1]               PCI Bus Number : 00
> [418h 1048   2]                     PCI Path : 1C,07
> [41Ah 1050   2]                     PCI Path : 00,02
> 
> [41Ch 1052   1]      Device Scope Entry Type : 01
> [41Dh 1053   1]                 Entry Length : 0A
> [41Eh 1054   2]                     Reserved : 0000
> [420h 1056   1]               Enumeration ID : 00
> [421h 1057   1]               PCI Bus Number : 00
> [422h 1058   2]                     PCI Path : 01,01
> [424h 1060   2]                     PCI Path : 00,00
> 
> [426h 1062   1]      Device Scope Entry Type : 01
> [427h 1063   1]                 Entry Length : 08
> [428h 1064   2]                     Reserved : 0000
> [42Ah 1066   1]               Enumeration ID : 00
> [42Bh 1067   1]               PCI Bus Number : 00
> [42Ch 1068   2]                     PCI Path : 1F,02
> 
> [42Eh 1070   1]      Device Scope Entry Type : 01
> [42Fh 1071   1]                 Entry Length : 08
> [430h 1072   2]                     Reserved : 0000
> [432h 1074   1]               Enumeration ID : 00
> [433h 1075   1]               PCI Bus Number : 00
> [434h 1076   2]                     PCI Path : 1F,05
> 
> [436h 1078   1]      Device Scope Entry Type : 01
> [437h 1079   1]                 Entry Length : 0A
> [438h 1080   2]                     Reserved : 0000
> [43Ah 1082   1]               Enumeration ID : 00
> [43Bh 1083   1]               PCI Bus Number : 00
> [43Ch 1084   2]                     PCI Path : 02,00
> [43Eh 1086   2]                     PCI Path : 00,00
> 
> [440h 1088   1]      Device Scope Entry Type : 01
> [441h 1089   1]                 Entry Length : 0A
> [442h 1090   2]                     Reserved : 0000
> [444h 1092   1]               Enumeration ID : 00
> [445h 1093   1]               PCI Bus Number : 00
> [446h 1094   2]                     PCI Path : 02,00
> [448h 1096   2]                     PCI Path : 00,01
> 
> [44Ah 1098   1]      Device Scope Entry Type : 01
> [44Bh 1099   1]                 Entry Length : 0A
> [44Ch 1100   2]                     Reserved : 0000
> [44Eh 1102   1]               Enumeration ID : 00
> [44Fh 1103   1]               PCI Bus Number : 00
> [450h 1104   2]                     PCI Path : 02,00
> [452h 1106   2]                     PCI Path : 00,02
> 
> [454h 1108   1]      Device Scope Entry Type : 01
> [455h 1109   1]                 Entry Length : 0A
> [456h 1110   2]                     Reserved : 0000
> [458h 1112   1]               Enumeration ID : 00
> [459h 1113   1]               PCI Bus Number : 00
> [45Ah 1114   2]                     PCI Path : 02,00
> [45Ch 1116   2]                     PCI Path : 00,03
> 
> [45Eh 1118   1]      Device Scope Entry Type : 01
> [45Fh 1119   1]                 Entry Length : 0A
> [460h 1120   2]                     Reserved : 0000
> [462h 1122   1]               Enumeration ID : 00
> [463h 1123   1]               PCI Bus Number : 00
> [464h 1124   2]                     PCI Path : 03,00
> [466h 1126   2]                     PCI Path : 00,00
> 
> [468h 1128   1]      Device Scope Entry Type : 01
> [469h 1129   1]                 Entry Length : 0A
> [46Ah 1130   2]                     Reserved : 0000
> [46Ch 1132   1]               Enumeration ID : 00
> [46Dh 1133   1]               PCI Bus Number : 00
> [46Eh 1134   2]                     PCI Path : 03,00
> [470h 1136   2]                     PCI Path : 00,01
> 
> [472h 1138   1]      Device Scope Entry Type : 01
> [473h 1139   1]                 Entry Length : 0A
> [474h 1140   2]                     Reserved : 0000
> [476h 1142   1]               Enumeration ID : 00
> [477h 1143   1]               PCI Bus Number : 20
> [478h 1144   2]                     PCI Path : 03,00
> [47Ah 1146   2]                     PCI Path : 00,00
> 
> [47Ch 1148   1]      Device Scope Entry Type : 01
> [47Dh 1149   1]                 Entry Length : 0A
> [47Eh 1150   2]                     Reserved : 0000
> [480h 1152   1]               Enumeration ID : 00
> [481h 1153   1]               PCI Bus Number : 20
> [482h 1154   2]                     PCI Path : 03,00
> [484h 1156   2]                     PCI Path : 00,01
> 
> [486h 1158   2]                Subtable Type : 0001 [Reserved Memory Region]
> [488h 1160   2]                       Length : 00A0
> [48Ah 1162   2]                     Reserved : 0000
> [48Ch 1164   2]           PCI Segment Number : 0000
> [48Eh 1166   8]                 Base Address : 00000000000E8000
> [496h 1174   8]          End Address (limit) : 00000000000E8FFF
> 
> [49Eh 1182   1]      Device Scope Entry Type : 01
> [49Fh 1183   1]                 Entry Length : 0A
> [4A0h 1184   2]                     Reserved : 0000
> [4A2h 1186   1]               Enumeration ID : 00
> [4A3h 1187   1]               PCI Bus Number : 00
> [4A4h 1188   2]                     PCI Path : 02,02
> [4A6h 1190   2]                     PCI Path : 00,00
> 
> [4A8h 1192   1]      Device Scope Entry Type : 01
> [4A9h 1193   1]                 Entry Length : 0A
> [4AAh 1194   2]                     Reserved : 0000
> [4ACh 1196   1]               Enumeration ID : 00
> [4ADh 1197   1]               PCI Bus Number : 00
> [4AEh 1198   2]                     PCI Path : 1C,07
> [4B0h 1200   2]                     PCI Path : 00,00
> 
> [4B2h 1202   1]      Device Scope Entry Type : 01
> [4B3h 1203   1]                 Entry Length : 0A
> [4B4h 1204   2]                     Reserved : 0000
> [4B6h 1206   1]               Enumeration ID : 00
> [4B7h 1207   1]               PCI Bus Number : 00
> [4B8h 1208   2]                     PCI Path : 1C,07
> [4BAh 1210   2]                     PCI Path : 00,02
> 
> [4BCh 1212   1]      Device Scope Entry Type : 01
> [4BDh 1213   1]                 Entry Length : 0A
> [4BEh 1214   2]                     Reserved : 0000
> [4C0h 1216   1]               Enumeration ID : 00
> [4C1h 1217   1]               PCI Bus Number : 00
> [4C2h 1218   2]                     PCI Path : 01,01
> [4C4h 1220   2]                     PCI Path : 00,00
> 
> [4C6h 1222   1]      Device Scope Entry Type : 01
> [4C7h 1223   1]                 Entry Length : 08
> [4C8h 1224   2]                     Reserved : 0000
> [4CAh 1226   1]               Enumeration ID : 00
> [4CBh 1227   1]               PCI Bus Number : 00
> [4CCh 1228   2]                     PCI Path : 1F,02
> 
> [4CEh 1230   1]      Device Scope Entry Type : 01
> [4CFh 1231   1]                 Entry Length : 08
> [4D0h 1232   2]                     Reserved : 0000
> [4D2h 1234   1]               Enumeration ID : 00
> [4D3h 1235   1]               PCI Bus Number : 00
> [4D4h 1236   2]                     PCI Path : 1F,05
> 
> [4D6h 1238   1]      Device Scope Entry Type : 01
> [4D7h 1239   1]                 Entry Length : 0A
> [4D8h 1240   2]                     Reserved : 0000
> [4DAh 1242   1]               Enumeration ID : 00
> [4DBh 1243   1]               PCI Bus Number : 00
> [4DCh 1244   2]                     PCI Path : 02,00
> [4DEh 1246   2]                     PCI Path : 00,00
> 
> [4E0h 1248   1]      Device Scope Entry Type : 01
> [4E1h 1249   1]                 Entry Length : 0A
> [4E2h 1250   2]                     Reserved : 0000
> [4E4h 1252   1]               Enumeration ID : 00
> [4E5h 1253   1]               PCI Bus Number : 00
> [4E6h 1254   2]                     PCI Path : 02,00
> [4E8h 1256   2]                     PCI Path : 00,01
> 
> [4EAh 1258   1]      Device Scope Entry Type : 01
> [4EBh 1259   1]                 Entry Length : 0A
> [4ECh 1260   2]                     Reserved : 0000
> [4EEh 1262   1]               Enumeration ID : 00
> [4EFh 1263   1]               PCI Bus Number : 00
> [4F0h 1264   2]                     PCI Path : 02,00
> [4F2h 1266   2]                     PCI Path : 00,02
> 
> [4F4h 1268   1]      Device Scope Entry Type : 01
> [4F5h 1269   1]                 Entry Length : 0A
> [4F6h 1270   2]                     Reserved : 0000
> [4F8h 1272   1]               Enumeration ID : 00
> [4F9h 1273   1]               PCI Bus Number : 00
> [4FAh 1274   2]                     PCI Path : 02,00
> [4FCh 1276   2]                     PCI Path : 00,03
> 
> [4FEh 1278   1]      Device Scope Entry Type : 01
> [4FFh 1279   1]                 Entry Length : 0A
> [500h 1280   2]                     Reserved : 0000
> [502h 1282   1]               Enumeration ID : 00
> [503h 1283   1]               PCI Bus Number : 00
> [504h 1284   2]                     PCI Path : 03,00
> [506h 1286   2]                     PCI Path : 00,00
> 
> [508h 1288   1]      Device Scope Entry Type : 01
> [509h 1289   1]                 Entry Length : 0A
> [50Ah 1290   2]                     Reserved : 0000
> [50Ch 1292   1]               Enumeration ID : 00
> [50Dh 1293   1]               PCI Bus Number : 00
> [50Eh 1294   2]                     PCI Path : 03,00
> [510h 1296   2]                     PCI Path : 00,01
> 
> [512h 1298   1]      Device Scope Entry Type : 01
> [513h 1299   1]                 Entry Length : 0A
> [514h 1300   2]                     Reserved : 0000
> [516h 1302   1]               Enumeration ID : 00
> [517h 1303   1]               PCI Bus Number : 20
> [518h 1304   2]                     PCI Path : 03,00
> [51Ah 1306   2]                     PCI Path : 00,00
> 
> [51Ch 1308   1]      Device Scope Entry Type : 01
> [51Dh 1309   1]                 Entry Length : 0A
> [51Eh 1310   2]                     Reserved : 0000
> [520h 1312   1]               Enumeration ID : 00
> [521h 1313   1]               PCI Bus Number : 20
> [522h 1314   2]                     PCI Path : 03,00
> [524h 1316   2]                     PCI Path : 00,01
> 
> [526h 1318   2]                Subtable Type : 0001 [Reserved Memory Region]
> [528h 1320   2]                       Length : 0036
> [52Ah 1322   2]                     Reserved : 0000
> [52Ch 1324   2]           PCI Segment Number : 0000
> [52Eh 1326   8]                 Base Address : 00000000BDDDE000
> [536h 1334   8]          End Address (limit) : 00000000BDDDEFFF
> 
> [53Eh 1342   1]      Device Scope Entry Type : 01
> [53Fh 1343   1]                 Entry Length : 0A
> [540h 1344   2]                     Reserved : 0000
> [542h 1346   1]               Enumeration ID : 00
> [543h 1347   1]               PCI Bus Number : 00
> [544h 1348   2]                     PCI Path : 1C,07
> [546h 1350   2]                     PCI Path : 00,00
> 
> [548h 1352   1]      Device Scope Entry Type : 01
> [549h 1353   1]                 Entry Length : 0A
> [54Ah 1354   2]                     Reserved : 0000
> [54Ch 1356   1]               Enumeration ID : 00
> [54Dh 1357   1]               PCI Bus Number : 00
> [54Eh 1358   2]                     PCI Path : 1C,07
> [550h 1360   2]                     PCI Path : 00,02
> 
> [552h 1362   1]      Device Scope Entry Type : 01
> [553h 1363   1]                 Entry Length : 0A
> [554h 1364   2]                     Reserved : 0000
> [556h 1366   1]               Enumeration ID : 00
> [557h 1367   1]               PCI Bus Number : 00
> [558h 1368   2]                     PCI Path : 1C,07
> [55Ah 1370   2]                     PCI Path : 00,04
> 
> [55Ch 1372   2]                Subtable Type : 0002 [Root Port ATS Capability]
> [55Eh 1374   2]                       Length : 00B0
> [560h 1376   1]                        Flags : 00
> [561h 1377   1]                     Reserved : 00
> [562h 1378   2]           PCI Segment Number : 0000
> 
> [564h 1380   1]      Device Scope Entry Type : 02
> [565h 1381   1]                 Entry Length : 08
> [566h 1382   2]                     Reserved : 0000
> [568h 1384   1]               Enumeration ID : 00
> [569h 1385   1]               PCI Bus Number : 00
> [56Ah 1386   2]                     PCI Path : 01,00
> 
> [56Ch 1388   1]      Device Scope Entry Type : 02
> [56Dh 1389   1]                 Entry Length : 08
> [56Eh 1390   2]                     Reserved : 0000
> [570h 1392   1]               Enumeration ID : 00
> [571h 1393   1]               PCI Bus Number : 00
> [572h 1394   2]                     PCI Path : 01,01
> 
> [574h 1396   1]      Device Scope Entry Type : 02
> [575h 1397   1]                 Entry Length : 08
> [576h 1398   2]                     Reserved : 0000
> [578h 1400   1]               Enumeration ID : 00
> [579h 1401   1]               PCI Bus Number : 00
> [57Ah 1402   2]                     PCI Path : 02,00
> 
> [57Ch 1404   1]      Device Scope Entry Type : 02
> [57Dh 1405   1]                 Entry Length : 08
> [57Eh 1406   2]                     Reserved : 0000
> [580h 1408   1]               Enumeration ID : 00
> [581h 1409   1]               PCI Bus Number : 00
> [582h 1410   2]                     PCI Path : 02,01
> 
> [584h 1412   1]      Device Scope Entry Type : 02
> [585h 1413   1]                 Entry Length : 08
> [586h 1414   2]                     Reserved : 0000
> [588h 1416   1]               Enumeration ID : 00
> [589h 1417   1]               PCI Bus Number : 00
> [58Ah 1418   2]                     PCI Path : 02,02
> 
> [58Ch 1420   1]      Device Scope Entry Type : 02
> [58Dh 1421   1]                 Entry Length : 08
> [58Eh 1422   2]                     Reserved : 0000
> [590h 1424   1]               Enumeration ID : 00
> [591h 1425   1]               PCI Bus Number : 00
> [592h 1426   2]                     PCI Path : 02,03
> 
> [594h 1428   1]      Device Scope Entry Type : 02
> [595h 1429   1]                 Entry Length : 08
> [596h 1430   2]                     Reserved : 0000
> [598h 1432   1]               Enumeration ID : 00
> [599h 1433   1]               PCI Bus Number : 00
> [59Ah 1434   2]                     PCI Path : 03,00
> 
> [59Ch 1436   1]      Device Scope Entry Type : 02
> [59Dh 1437   1]                 Entry Length : 08
> [59Eh 1438   2]                     Reserved : 0000
> [5A0h 1440   1]               Enumeration ID : 00
> [5A1h 1441   1]               PCI Bus Number : 00
> [5A2h 1442   2]                     PCI Path : 03,01
> 
> [5A4h 1444   1]      Device Scope Entry Type : 02
> [5A5h 1445   1]                 Entry Length : 08
> [5A6h 1446   2]                     Reserved : 0000
> [5A8h 1448   1]               Enumeration ID : 00
> [5A9h 1449   1]               PCI Bus Number : 00
> [5AAh 1450   2]                     PCI Path : 03,02
> 
> [5ACh 1452   1]      Device Scope Entry Type : 02
> [5ADh 1453   1]                 Entry Length : 08
> [5AEh 1454   2]                     Reserved : 0000
> [5B0h 1456   1]               Enumeration ID : 00
> [5B1h 1457   1]               PCI Bus Number : 00
> [5B2h 1458   2]                     PCI Path : 03,03
> 
> [5B4h 1460   1]      Device Scope Entry Type : 02
> [5B5h 1461   1]                 Entry Length : 08
> [5B6h 1462   2]                     Reserved : 0000
> [5B8h 1464   1]               Enumeration ID : 00
> [5B9h 1465   1]               PCI Bus Number : 20
> [5BAh 1466   2]                     PCI Path : 00,00
> 
> [5BCh 1468   1]      Device Scope Entry Type : 02
> [5BDh 1469   1]                 Entry Length : 08
> [5BEh 1470   2]                     Reserved : 0000
> [5C0h 1472   1]               Enumeration ID : 00
> [5C1h 1473   1]               PCI Bus Number : 20
> [5C2h 1474   2]                     PCI Path : 01,00
> 
> [5C4h 1476   1]      Device Scope Entry Type : 02
> [5C5h 1477   1]                 Entry Length : 08
> [5C6h 1478   2]                     Reserved : 0000
> [5C8h 1480   1]               Enumeration ID : 00
> [5C9h 1481   1]               PCI Bus Number : 20
> [5CAh 1482   2]                     PCI Path : 01,01
> 
> [5CCh 1484   1]      Device Scope Entry Type : 02
> [5CDh 1485   1]                 Entry Length : 08
> [5CEh 1486   2]                     Reserved : 0000
> [5D0h 1488   1]               Enumeration ID : 00
> [5D1h 1489   1]               PCI Bus Number : 20
> [5D2h 1490   2]                     PCI Path : 02,00
> 
> [5D4h 1492   1]      Device Scope Entry Type : 02
> [5D5h 1493   1]                 Entry Length : 08
> [5D6h 1494   2]                     Reserved : 0000
> [5D8h 1496   1]               Enumeration ID : 00
> [5D9h 1497   1]               PCI Bus Number : 20
> [5DAh 1498   2]                     PCI Path : 02,01
> 
> [5DCh 1500   1]      Device Scope Entry Type : 02
> [5DDh 1501   1]                 Entry Length : 08
> [5DEh 1502   2]                     Reserved : 0000
> [5E0h 1504   1]               Enumeration ID : 00
> [5E1h 1505   1]               PCI Bus Number : 20
> [5E2h 1506   2]                     PCI Path : 02,02
> 
> [5E4h 1508   1]      Device Scope Entry Type : 02
> [5E5h 1509   1]                 Entry Length : 08
> [5E6h 1510   2]                     Reserved : 0000
> [5E8h 1512   1]               Enumeration ID : 00
> [5E9h 1513   1]               PCI Bus Number : 20
> [5EAh 1514   2]                     PCI Path : 02,03
> 
> [5ECh 1516   1]      Device Scope Entry Type : 02
> [5EDh 1517   1]                 Entry Length : 08
> [5EEh 1518   2]                     Reserved : 0000
> [5F0h 1520   1]               Enumeration ID : 00
> [5F1h 1521   1]               PCI Bus Number : 20
> [5F2h 1522   2]                     PCI Path : 03,00
> 
> [5F4h 1524   1]      Device Scope Entry Type : 02
> [5F5h 1525   1]                 Entry Length : 08
> [5F6h 1526   2]                     Reserved : 0000
> [5F8h 1528   1]               Enumeration ID : 00
> [5F9h 1529   1]               PCI Bus Number : 20
> [5FAh 1530   2]                     PCI Path : 03,01
> 
> [5FCh 1532   1]      Device Scope Entry Type : 02
> [5FDh 1533   1]                 Entry Length : 08
> [5FEh 1534   2]                     Reserved : 0000
> [600h 1536   1]               Enumeration ID : 00
> [601h 1537   1]               PCI Bus Number : 20
> [602h 1538   2]                     PCI Path : 03,02
> 
> [604h 1540   1]      Device Scope Entry Type : 02
> [605h 1541   1]                 Entry Length : 08
> [606h 1542   2]                     Reserved : 0000
> [608h 1544   1]               Enumeration ID : 00
> [609h 1545   1]               PCI Bus Number : 20
> [60Ah 1546   2]                     PCI Path : 03,03
> 
> Raw Table Data: Length 1548 (0x60C)
> 
>   0000: 44 4D 41 52 0C 06 00 00 01 0D 48 50 20 20 20 20  DMAR......HP
>   0010: 50 72 6F 4C 69 61 6E 74 01 00 00 00 D2 04 00 00  ProLiant........
>   0020: 2E 16 00 00 2D 03 00 00 00 00 00 00 00 00 00 00  ....-...........
>   0030: 00 00 B0 00 00 00 00 00 00 E0 EF EF 00 00 00 00  ................
>   0040: 02 08 00 00 00 20 00 00 02 08 00 00 00 20 01 00  ..... ....... ..
>   0050: 02 08 00 00 00 20 01 01 02 08 00 00 00 20 02 00  ..... ....... ..
>   0060: 02 08 00 00 00 20 02 01 02 08 00 00 00 20 02 02  ..... ....... ..
>   0070: 02 08 00 00 00 20 02 03 02 08 00 00 00 20 03 00  ..... ....... ..
>   0080: 02 08 00 00 00 20 03 01 02 08 00 00 00 20 03 02  ..... ....... ..
>   0090: 02 08 00 00 00 20 03 03 03 08 00 00 0A 20 05 04  ..... ....... ..
>   00A0: 01 08 00 00 00 20 04 00 01 08 00 00 00 20 04 01  ..... ....... ..
>   00B0: 01 08 00 00 00 20 04 02 01 08 00 00 00 20 04 03  ..... ....... ..
>   00C0: 01 08 00 00 00 20 04 04 01 08 00 00 00 20 04 05  ..... ....... ..
>   00D0: 01 08 00 00 00 20 04 06 01 08 00 00 00 20 04 07  ..... ....... ..
>   00E0: 00 00 28 00 01 00 00 00 00 E0 FF DC 00 00 00 00  ..(.............
>   00F0: 03 08 00 00 08 00 1E 01 03 08 00 00 00 00 05 04  ................
>   0100: 04 08 00 00 00 00 1F 00 01 00 28 00 00 00 00 00  ..........(.....
>   0110: 00 D0 FF BD 00 00 00 00 FF FF FF BD 00 00 00 00  ................
>   0120: 01 08 00 00 00 00 1D 00 01 08 00 00 00 00 1A 00  ................
>   0130: 01 00 36 00 00 00 00 00 00 60 FF BD 00 00 00 00  ..6......`......
>   0140: FF CF FF BD 00 00 00 00 01 0A 00 00 00 00 1C 07  ................
>   0150: 00 00 01 0A 00 00 00 00 1C 07 00 02 01 0A 00 00  ................
>   0160: 00 00 1C 07 00 04 01 00 A0 00 00 00 00 00 00 30  ...............0
>   0170: F8 BD 00 00 00 00 FF 4F F8 BD 00 00 00 00 01 0A  .......O........
>   0180: 00 00 00 00 02 02 00 00 01 0A 00 00 00 00 1C 07  ................
>   0190: 00 00 01 0A 00 00 00 00 1C 07 00 02 01 0A 00 00  ................
>   01A0: 00 00 01 01 00 00 01 08 00 00 00 00 1F 02 01 08  ................
>   01B0: 00 00 00 00 1F 05 01 0A 00 00 00 00 02 00 00 00  ................
>   01C0: 01 0A 00 00 00 00 02 00 00 01 01 0A 00 00 00 00  ................
>   01D0: 02 00 00 02 01 0A 00 00 00 00 02 00 00 03 01 0A  ................
>   01E0: 00 00 00 00 03 00 00 00 01 0A 00 00 00 00 03 00  ................
>   01F0: 00 01 01 0A 00 00 00 20 03 00 00 00 01 0A 00 00  ....... ........
>   0200: 00 20 03 00 00 01 01 00 A0 00 00 00 00 00 00 F0  . ..............
>   0210: F7 BD 00 00 00 00 FF 2F F8 BD 00 00 00 00 01 0A  ......./........
>   0220: 00 00 00 00 02 02 00 00 01 0A 00 00 00 00 1C 07  ................
>   0230: 00 00 01 0A 00 00 00 00 1C 07 00 02 01 0A 00 00  ................
>   0240: 00 00 01 01 00 00 01 08 00 00 00 00 1F 02 01 08  ................
>   0250: 00 00 00 00 1F 05 01 0A 00 00 00 00 02 00 00 00  ................
>   0260: 01 0A 00 00 00 00 02 00 00 01 01 0A 00 00 00 00  ................
>   0270: 02 00 00 02 01 0A 00 00 00 00 02 00 00 03 01 0A  ................
>   0280: 00 00 00 00 03 00 00 00 01 0A 00 00 00 00 03 00  ................
>   0290: 00 01 01 0A 00 00 00 20 03 00 00 00 01 0A 00 00  ....... ........
>   02A0: 00 20 03 00 00 01 01 00 A0 00 00 00 00 00 00 F0  . ..............
>   02B0: F6 BD 00 00 00 00 FF EF F7 BD 00 00 00 00 01 0A  ................
>   02C0: 00 00 00 00 02 02 00 00 01 0A 00 00 00 00 1C 07  ................
>   02D0: 00 00 01 0A 00 00 00 00 1C 07 00 02 01 0A 00 00  ................
>   02E0: 00 00 01 01 00 00 01 08 00 00 00 00 1F 02 01 08  ................
>   02F0: 00 00 00 00 1F 05 01 0A 00 00 00 00 02 00 00 00  ................
>   0300: 01 0A 00 00 00 00 02 00 00 01 01 0A 00 00 00 00  ................
>   0310: 02 00 00 02 01 0A 00 00 00 00 02 00 00 03 01 0A  ................
>   0320: 00 00 00 00 03 00 00 00 01 0A 00 00 00 00 03 00  ................
>   0330: 00 01 01 0A 00 00 00 20 03 00 00 00 01 0A 00 00  ....... ........
>   0340: 00 20 03 00 00 01 01 00 A0 00 00 00 00 00 00 E0  . ..............
>   0350: F6 BD 00 00 00 00 FF EF F6 BD 00 00 00 00 01 0A  ................
>   0360: 00 00 00 00 02 02 00 00 01 0A 00 00 00 00 1C 07  ................
>   0370: 00 00 01 0A 00 00 00 00 1C 07 00 02 01 0A 00 00  ................
>   0380: 00 00 01 01 00 00 01 08 00 00 00 00 1F 02 01 08  ................
>   0390: 00 00 00 00 1F 05 01 0A 00 00 00 00 02 00 00 00  ................
>   03A0: 01 0A 00 00 00 00 02 00 00 01 01 0A 00 00 00 00  ................
>   03B0: 02 00 00 02 01 0A 00 00 00 00 02 00 00 03 01 0A  ................
>   03C0: 00 00 00 00 03 00 00 00 01 0A 00 00 00 00 03 00  ................
>   03D0: 00 01 01 0A 00 00 00 20 03 00 00 00 01 0A 00 00  ....... ........
>   03E0: 00 20 03 00 00 01 01 00 A0 00 00 00 00 00 00 40  . .............@
>   03F0: 0F 00 00 00 00 00 FF 4F 0F 00 00 00 00 00 01 0A  .......O........
>   0400: 00 00 00 00 02 02 00 00 01 0A 00 00 00 00 1C 07  ................
>   0410: 00 00 01 0A 00 00 00 00 1C 07 00 02 01 0A 00 00  ................
>   0420: 00 00 01 01 00 00 01 08 00 00 00 00 1F 02 01 08  ................
>   0430: 00 00 00 00 1F 05 01 0A 00 00 00 00 02 00 00 00  ................
>   0440: 01 0A 00 00 00 00 02 00 00 01 01 0A 00 00 00 00  ................
>   0450: 02 00 00 02 01 0A 00 00 00 00 02 00 00 03 01 0A  ................
>   0460: 00 00 00 00 03 00 00 00 01 0A 00 00 00 00 03 00  ................
>   0470: 00 01 01 0A 00 00 00 20 03 00 00 00 01 0A 00 00  ....... ........
>   0480: 00 20 03 00 00 01 01 00 A0 00 00 00 00 00 00 80  . ..............
>   0490: 0E 00 00 00 00 00 FF 8F 0E 00 00 00 00 00 01 0A  ................
>   04A0: 00 00 00 00 02 02 00 00 01 0A 00 00 00 00 1C 07  ................
>   04B0: 00 00 01 0A 00 00 00 00 1C 07 00 02 01 0A 00 00  ................
>   04C0: 00 00 01 01 00 00 01 08 00 00 00 00 1F 02 01 08  ................
>   04D0: 00 00 00 00 1F 05 01 0A 00 00 00 00 02 00 00 00  ................
>   04E0: 01 0A 00 00 00 00 02 00 00 01 01 0A 00 00 00 00  ................
>   04F0: 02 00 00 02 01 0A 00 00 00 00 02 00 00 03 01 0A  ................
>   0500: 00 00 00 00 03 00 00 00 01 0A 00 00 00 00 03 00  ................
>   0510: 00 01 01 0A 00 00 00 20 03 00 00 00 01 0A 00 00  ....... ........
>   0520: 00 20 03 00 00 01 01 00 36 00 00 00 00 00 00 E0  . ......6.......
>   0530: DD BD 00 00 00 00 FF EF DD BD 00 00 00 00 01 0A  ................
>   0540: 00 00 00 00 1C 07 00 00 01 0A 00 00 00 00 1C 07  ................
>   0550: 00 02 01 0A 00 00 00 00 1C 07 00 04 02 00 B0 00  ................
>   0560: 00 00 00 00 02 08 00 00 00 00 01 00 02 08 00 00  ................
>   0570: 00 00 01 01 02 08 00 00 00 00 02 00 02 08 00 00  ................
>   0580: 00 00 02 01 02 08 00 00 00 00 02 02 02 08 00 00  ................
>   0590: 00 00 02 03 02 08 00 00 00 00 03 00 02 08 00 00  ................
>   05A0: 00 00 03 01 02 08 00 00 00 00 03 02 02 08 00 00  ................
>   05B0: 00 00 03 03 02 08 00 00 00 20 00 00 02 08 00 00  ......... ......
>   05C0: 00 20 01 00 02 08 00 00 00 20 01 01 02 08 00 00  . ....... ......
>   05D0: 00 20 02 00 02 08 00 00 00 20 02 01 02 08 00 00  . ....... ......
>   05E0: 00 20 02 02 02 08 00 00 00 20 02 03 02 08 00 00  . ....... ......
>   05F0: 00 20 03 00 02 08 00 00 00 20 03 01 02 08 00 00  . ....... ......
>   0600: 00 20 03 02 02 08 00 00 00 20 03 03              . ....... ..
> 
> 
>>
> 
> 
