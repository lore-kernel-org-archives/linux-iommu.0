Return-Path: <SRS0=KP5g=OF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DB6C433F5
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 14:39:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C13C061209
	for <iommu@archiver.kernel.org>; Wed, 15 Sep 2021 14:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C13C061209
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 92F2080CC9;
	Wed, 15 Sep 2021 14:39:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JpOZOgmqGKYO; Wed, 15 Sep 2021 14:39:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2977380C9D;
	Wed, 15 Sep 2021 14:39:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05AA9C0011;
	Wed, 15 Sep 2021 14:39:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A4F3C000D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 14:39:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 39242404CD
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 14:39:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nHr1OE9xM_sX for <iommu@lists.linux-foundation.org>;
 Wed, 15 Sep 2021 14:39:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 91D98404C8
 for <iommu@lists.linux-foundation.org>; Wed, 15 Sep 2021 14:39:14 +0000 (UTC)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5D12461E64760;
 Wed, 15 Sep 2021 16:39:11 +0200 (CEST)
Subject: Re: AMD-Vi: [Firmware Warn]: EFR mismatch. Use IVHD EFR
 (0xf77ef22294ada : 0x400f77ef22294ada).
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
References: <16533743-de8d-6355-211d-1b4f8949fcfb@molgen.mpg.de>
 <2f5b07e4-5492-330b-b057-55230639cd5e@molgen.mpg.de>
 <YUCRC0CI7rWXt4VA@8bytes.org>
 <38c22e95-aa19-4166-be8a-28749bfacd3e@molgen.mpg.de>
 <3c61d4d9-f6e0-d847-3b60-bde8b3733f09@molgen.mpg.de>
Message-ID: <e148d54d-6b5a-365d-bc90-b1bd4b0e694d@molgen.mpg.de>
Date: Wed, 15 Sep 2021 16:39:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <3c61d4d9-f6e0-d847-3b60-bde8b3733f09@molgen.mpg.de>
Content-Type: multipart/mixed; boundary="------------DED23756AFA40979751A9EC6"
Content-Language: en-US
Cc: David Coe <david.coe@live.co.uk>, Robert Richter <rrichter@amd.com>,
 Alexander Monakov <amonakov@ispras.ru>, iommu@lists.linux-foundation.org,
 Mario Limonciello <mario.limonciello@amd.com>, Dell.Client.Kernel@dell.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This is a multi-part message in MIME format.
--------------DED23756AFA40979751A9EC6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


Am 15.09.21 um 00:17 schrieb Paul Menzel:
> [Use Mario’s current address]
> 
> Am 15.09.21 um 00:15 schrieb Paul Menzel:
>> [Cc: +Mario from AMD]

>> Am 14.09.21 um 14:09 schrieb Jörg Rödel:
>>> On Tue, Sep 14, 2021 at 11:10:57AM +0200, Paul Menzel wrote:
>>>> Linux 5.15-rc1 still warns about that (also with latest system firmware
>>>> 1.1.50).
>>>
>>> The reason is most likely that the latest firmware still reports a
>>> different EFR feature set in the IVRS table than the IOMMU reports in
>>> its EFR MMIO register.
>>
>> What do you mean exactly? Only 0x400 is prepended. The rest of the 
>> string is identical. What feature set would the 0x400 in the beginning 
>> be?

ACPICA 20200326 is able to deassemble IVRS subtable type 0x11. The 
incorrect(?) value can be seen there.

     $ sudo iasl -d -p IVRS.dsl /sys/firmware/acpi/tables/IVRS
     […]
     $ grep EFR IVRS.dsl
     [090h 0144   8]                    EFR Image : 400F77EF22294ADA

>> Anyway, it’d be great if AMD and Dell could take a look.
Dell client kernel team, please confirm, that you received the report.


Kind regards,

Paul


[1]: https://acpica.org/node/178

--------------DED23756AFA40979751A9EC6
Content-Type: text/x-dsl; charset=UTF-8;
 name="IVRS.dsl"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="IVRS.dsl"

/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembly of IVRS, Wed Sep 15 11:48:42 2021
 *
 * ACPI Data Table [IVRS]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
 */

[000h 0000   4]                    Signature : "IVRS"    [I/O Virtualization Reporting Structure]
[004h 0004   4]                 Table Length : 000000D0
[008h 0008   1]                     Revision : 02
[009h 0009   1]                     Checksum : EE
[00Ah 0010   6]                       Oem ID : "AMD"
[010h 0016   8]                 Oem Table ID : "MYRTLE"
[018h 0024   4]                 Oem Revision : 00000001
[01Ch 0028   4]              Asl Compiler ID : "ACPI"
[020h 0032   4]        Asl Compiler Revision : 00040000

[024h 0036   4]          Virtualization Info : 00203041
[028h 0040   8]                     Reserved : 0000000000000000

[030h 0048   1]                Subtable Type : 10 [Hardware Definition Block]
[031h 0049   1]                        Flags : B0
[032h 0050   2]                       Length : 0048
[034h 0052   2]                     DeviceId : 0002

[036h 0054   2]            Capability Offset : 0040
[038h 0056   8]                 Base Address : 00000000FC000000
[040h 0064   2]            PCI Segment Group : 0000
[042h 0066   2]          Virtualization Info : 0000
[044h 0068   4]            Feature Reporting : 80048F6E

[048h 0072   1]                   Entry Type : 03
[049h 0073   2]                    Device ID : 0008
[04Bh 0075   1]                 Data Setting : 00

[04Ch 0076   1]                   Entry Type : 04
[04Dh 0077   2]                    Device ID : FFFE
[04Fh 0079   1]                 Data Setting : 00

[050h 0080   1]                   Entry Type : 43
[051h 0081   2]                    Device ID : FF00
[053h 0083   1]                 Data Setting : 00
[054h 0084   1]                     Reserved : 00
[055h 0085   2]        Source Used Device ID : 00A4
[057h 0087   1]                     Reserved : 00

[058h 0088   1]                   Entry Type : 04
[059h 0089   2]                    Device ID : FFFF
[05Bh 0091   1]                 Data Setting : 00

[05Ch 0092   1]                   Entry Type : 00
[05Dh 0093   2]                    Device ID : 0000
[05Fh 0095   1]                 Data Setting : 00

[060h 0096   1]                   Entry Type : 48
[061h 0097   2]                    Device ID : 0000
[063h 0099   1]                 Data Setting : 00
[064h 0100   1]                       Handle : 00
[065h 0101   2]        Source Used Device ID : 00A0
[067h 0103   1]                      Variety : 02

[068h 0104   1]                   Entry Type : 48
[069h 0105   2]                    Device ID : 0000
[06Bh 0107   1]                 Data Setting : D7
[06Ch 0108   1]                       Handle : 20
[06Dh 0109   2]        Source Used Device ID : 00A0
[06Fh 0111   1]                      Variety : 01

[070h 0112   1]                   Entry Type : 48
[071h 0113   2]                    Device ID : 0000
[073h 0115   1]                 Data Setting : 00
[074h 0116   1]                       Handle : 21
[075h 0117   2]        Source Used Device ID : 0001
[077h 0119   1]                      Variety : 01

[078h 0120   1]                Subtable Type : 11 [Hardware Definition Block]
[079h 0121   1]                        Flags : B0
[07Ah 0122   2]                       Length : 0058
[07Ch 0124   2]                     DeviceId : 0002

[07Eh 0126   2]            Capability Offset : 0040
[080h 0128   8]                 Base Address : 00000000FC000000
[088h 0136   2]            PCI Segment Group : 0000
[08Ah 0138   2]          Virtualization Info : 0000
[08Ch 0140   4]                   Attributes : 00040200
[090h 0144   8]                    EFR Image : 400F77EF22294ADA
[098h 0152   8]                     Reserved : 0000000000000000

[0A0h 0160   1]                   Entry Type : 03
[0A1h 0161   2]                    Device ID : 0008
[0A3h 0163   1]                 Data Setting : 00

[0A4h 0164   1]                   Entry Type : 04
[0A5h 0165   2]                    Device ID : FFFE
[0A7h 0167   1]                 Data Setting : 00

[0A8h 0168   1]                   Entry Type : 43
[0A9h 0169   2]                    Device ID : FF00
[0ABh 0171   1]                 Data Setting : 00
[0ACh 0172   1]                     Reserved : 00
[0ADh 0173   2]        Source Used Device ID : 00A4
[0AFh 0175   1]                     Reserved : 00

[0B0h 0176   1]                   Entry Type : 04
[0B1h 0177   2]                    Device ID : FFFF
[0B3h 0179   1]                 Data Setting : 00

[0B4h 0180   1]                   Entry Type : 00
[0B5h 0181   2]                    Device ID : 0000
[0B7h 0183   1]                 Data Setting : 00

[0B8h 0184   1]                   Entry Type : 48
[0B9h 0185   2]                    Device ID : 0000
[0BBh 0187   1]                 Data Setting : 00
[0BCh 0188   1]                       Handle : 00
[0BDh 0189   2]        Source Used Device ID : 00A0
[0BFh 0191   1]                      Variety : 02

[0C0h 0192   1]                   Entry Type : 48
[0C1h 0193   2]                    Device ID : 0000
[0C3h 0195   1]                 Data Setting : D7
[0C4h 0196   1]                       Handle : 20
[0C5h 0197   2]        Source Used Device ID : 00A0
[0C7h 0199   1]                      Variety : 01

[0C8h 0200   1]                   Entry Type : 48
[0C9h 0201   2]                    Device ID : 0000
[0CBh 0203   1]                 Data Setting : 00
[0CCh 0204   1]                       Handle : 21
[0CDh 0205   2]        Source Used Device ID : 0001
[0CFh 0207   1]                      Variety : 01

Raw Table Data: Length 208 (0xD0)

    0000: 49 56 52 53 D0 00 00 00 02 EE 41 4D 44 00 00 00  // IVRS......AMD...
    0010: 4D 59 52 54 4C 45 00 00 01 00 00 00 41 43 50 49  // MYRTLE......ACPI
    0020: 00 00 04 00 41 30 20 00 00 00 00 00 00 00 00 00  // ....A0 .........
    0030: 10 B0 48 00 02 00 40 00 00 00 00 FC 00 00 00 00  // ..H...@.........
    0040: 00 00 00 00 6E 8F 04 80 03 08 00 00 04 FE FF 00  // ....n...........
    0050: 43 00 FF 00 00 A4 00 00 04 FF FF 00 00 00 00 00  // C...............
    0060: 48 00 00 00 00 A0 00 02 48 00 00 D7 20 A0 00 01  // H.......H... ...
    0070: 48 00 00 00 21 01 00 01 11 B0 58 00 02 00 40 00  // H...!.....X...@.
    0080: 00 00 00 FC 00 00 00 00 00 00 00 00 00 02 04 00  // ................
    0090: DA 4A 29 22 EF 77 0F 40 00 00 00 00 00 00 00 00  // .J)".w.@........
    00A0: 03 08 00 00 04 FE FF 00 43 00 FF 00 00 A4 00 00  // ........C.......
    00B0: 04 FF FF 00 00 00 00 00 48 00 00 00 00 A0 00 02  // ........H.......
    00C0: 48 00 00 D7 20 A0 00 01 48 00 00 00 21 01 00 01  // H... ...H...!...

--------------DED23756AFA40979751A9EC6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--------------DED23756AFA40979751A9EC6--
