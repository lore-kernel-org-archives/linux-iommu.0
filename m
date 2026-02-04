Received: from mail.sig21.net (mail.sig21.net [217.197.84.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F79F42189F
	for <iommu@lists.linux.dev>; Wed,  4 Feb 2026 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.197.84.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218222; cv=none; b=bfRBI6c4zrOesmiKDsxERaneHHli9XO1SRyKqvTzFaEQfH/sbOSB4Z0qxHWgWOaXhSINF3+UiQmFpCv315mxMwdj/QbsAiwNSZ13DEBOO8VNgsOeN7jSaTd9BmMwP7ge+hfotbPGTc/QGgOA5iO3Mg3ItWqQks+jj05Ht2BWvaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218222; c=relaxed/simple;
	bh=7ZJX60M6bJBie/C2r3F4ujQ9zLB64zQivIj8S6zy6WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkInA0zd1TLQEV541C5g6Z/YSczAhosP1DFspd+aipxKoH8p5/YxY8ToV70YcCLrYHYzEMm44Myg7QafvOtTNTgZXX+Qz73GLmcJkf/xpqozjUBdAVQAJ1G5tbOIXQa8NPprvdUzwK//nvmPz701Y1E7bDU9tzHjOgnYF3AIjr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net; spf=pass smtp.mailfrom=sig21.net; arc=none smtp.client-ip=217.197.84.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sig21.net
Received: from localhorst ([127.0.0.1])
	 by mail.sig21.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	 (Exim 4.94.2)
	(envelope-from <js@sig21.net>)
	 id 1vnecd-0007Sm-PO ; Wed, 04 Feb 2026 16:16:51 +0100
Received: from js by abc.local with local (Exim 4.99.1)
	(envelope-from <js@sig21.net>)
	id 1vnecd-000000004Ny-30aT;
	Wed, 04 Feb 2026 16:16:51 +0100
Date: Wed, 4 Feb 2026 16:16:51 +0100
From: Johannes Stezenbach <js@sig21.net>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: AMD IOMMU issue with hibernate on Asrock X600
Message-ID: <aYNi4yYA2_Cu359Z@sig21.net>
References: <aXeAOtGQUdlNZF6V@sig21.net>
 <aXnXX0P-XsEFPlJd@sig21.net>
 <52148f32-2348-42d8-95e0-49b30c29da1c@amd.com>
 <aYHerYcZ-5FOguKY@sig21.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GTulLJWUtxNbtxgt"
Content-Disposition: inline
In-Reply-To: <aYHerYcZ-5FOguKY@sig21.net>


--GTulLJWUtxNbtxgt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 03, 2026 at 12:40:30PM +0100, Johannes Stezenbach wrote:
> On Tue, Feb 03, 2026 at 11:08:49AM +0530, Vasant Hegde wrote:
> > Can you try below patch?
> 
> Sadly it doesn't work, same error on hibernate.

In case it helps, I booted with amd_iommu_dump=1 and got this:

[    0.108593] [    T0] AMD-Vi: Using IVHD type 0x11
[    0.108594] [    T0] AMD-Vi: device: 0000:00:00.2 cap: 0040 flags: 30 info 0000
[    0.108596] [    T0] AMD-Vi:        mmio-addr: 00000000f7500000
[    0.108600] [    T0] AMD-Vi: PCI segment : 0x0, last bdf : 0xffff
[    0.108623] [    T0] AMD-Vi:   DEV_SELECT_RANGE_START        devid: 0000:00:00.3 flags: 0x0
[    0.108625] [    T0] AMD-Vi:   DEV_RANGE_END         devid: 0000:ff:1f.6
[    0.108706] [    T0] AMD-Vi:   DEV_ALIAS_RANGE               devid: 0000:ff:00.0 flags: 0x0 devid_to: 0000:00:14.5
[    0.108708] [    T0] AMD-Vi:   DEV_RANGE_END         devid: 0000:ff:1f.7
[    0.108710] [    T0] AMD-Vi:   DEV_SPECIAL(HPET[0])          devid: 0000:00:14.0, flags: 0x0
[    0.108712] [    T0] AMD-Vi:   DEV_SPECIAL(IOAPIC[32])               devid: 0000:00:14.0, flags: 0xd7
[    0.108715] [    T0] AMD-Vi:   DEV_SPECIAL(IOAPIC[33])               devid: 0000:00:00.1, flags: 0x0
[    0.108717] [    T0] AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, EFR2:0x0
...
[    2.617032] [    T1] AMD-Vi: Extended features (0x246577efa2254afa, 0x0): PPR NX GT [5] IA GA PC GA_vAPIC
[    2.617045] [    T1] AMD-Vi: Interrupt remapping enabled
[    2.640571] [    T1] AMD-Vi: Virtual APIC enabled

I'm also attaching the ACPI IVRS table.

Side note: I wanted to check AMD documents at https://docs.amd.com/
but the "Create Account" button doesn't work. :-(
(And why do they require an account anyway, Intel and ARM don't...)


Best Regards,
Johannes

--GTulLJWUtxNbtxgt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ivrs.dsl"

/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20251212 (64-bit version)
 * Copyright (c) 2000 - 2025 Intel Corporation
 * 
 * Disassembly of ivrs.dat
 *
 * ACPI Data Table [IVRS]
 *
 * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
 */

[000h 0000 004h]                   Signature : "IVRS"    [I/O Virtualization Reporting Structure]
[004h 0004 004h]                Table Length : 000000C8
[008h 0008 001h]                    Revision : 02
[009h 0009 001h]                    Checksum : 6D
[00Ah 0010 006h]                      Oem ID : "AMD  "
[010h 0016 008h]                Oem Table ID : "AmdTable"
[018h 0024 004h]                Oem Revision : 00000001
[01Ch 0028 004h]             Asl Compiler ID : "AMD "
[020h 0032 004h]       Asl Compiler Revision : 00000001

[024h 0036 004h]         Virtualization Info : 00203041
[028h 0040 008h]                    Reserved : 0000000000000000

[030h 0048 001h]               Subtable Type : 10 [Hardware Definition Block (IVHD)]
[031h 0049 001h]       Flags (decoded below) : B0
                                     HtTunEn : 0
                                      PassPW : 0
                                   ResPassPW : 0
                                Isoc Control : 0
                               Iotlb Support : 1
                                    Coherent : 1
                            Prefetch Support : 0
                                 PPR Support : 1
[032h 0050 002h]                      Length : 0044
[034h 0052 002h]                    DeviceId : 0002
[036h 0054 002h]           Capability Offset : 0040
[038h 0056 008h]                Base Address : 00000000F7500000
[040h 0064 002h]           PCI Segment Group : 0000
[042h 0066 002h]         Virtualization Info : 0000
[044h 0068 004h]           Feature Reporting : 80048F6E

[048h 0072 001h]               Subtable Type : 03 [Device Entry: Start of Range]
[049h 0073 002h]                   Device ID : 0003
[04Bh 0075 001h] Data Setting (decoded below) : 00
                                    INITPass : 0
                                    EIntPass : 0
                                     NMIPass : 0
                                    Reserved : 0
                                 System MGMT : 0
                                  LINT0 Pass : 0
                                  LINT1 Pass : 0

[04Ch 0076 001h]               Subtable Type : 04 [Device Entry: End of Range]
[04Dh 0077 002h]                   Device ID : FFFE
[04Fh 0079 001h] Data Setting (decoded below) : 00
                                    INITPass : 0
                                    EIntPass : 0
                                     NMIPass : 0
                                    Reserved : 0
                                 System MGMT : 0
                                  LINT0 Pass : 0
                                  LINT1 Pass : 0

[050h 0080 001h]               Subtable Type : 43 [Device Entry: Alias Start of Range]
[051h 0081 002h]                   Device ID : FF00
[053h 0083 001h] Data Setting (decoded below) : 00
                                    INITPass : 0
                                    EIntPass : 0
                                     NMIPass : 0
                                    Reserved : 0
                                 System MGMT : 0
                                  LINT0 Pass : 0
                                  LINT1 Pass : 0
[054h 0084 001h]                    Reserved : 00
[055h 0085 002h]       Source Used Device ID : 00A5
[057h 0087 001h]                    Reserved : 00

[058h 0088 001h]               Subtable Type : 04 [Device Entry: End of Range]
[059h 0089 002h]                   Device ID : FFFF
[05Bh 0091 001h] Data Setting (decoded below) : 00
                                    INITPass : 0
                                    EIntPass : 0
                                     NMIPass : 0
                                    Reserved : 0
                                 System MGMT : 0
                                  LINT0 Pass : 0
                                  LINT1 Pass : 0

[05Ch 0092 001h]               Subtable Type : 48 [Device Entry: Special Device]
[05Dh 0093 002h]                   Device ID : 0000
[05Fh 0095 001h] Data Setting (decoded below) : 00
                                    INITPass : 0
                                    EIntPass : 0
                                     NMIPass : 0
                                    Reserved : 0
                                 System MGMT : 0
                                  LINT0 Pass : 0
                                  LINT1 Pass : 0
[060h 0096 001h]                      Handle : 00
[061h 0097 002h]       Source Used Device ID : 00A0
[063h 0099 001h]                     Variety : 02

[064h 0100 001h]               Subtable Type : 48 [Device Entry: Special Device]
[065h 0101 002h]                   Device ID : 0000
[067h 0103 001h] Data Setting (decoded below) : D7
                                    INITPass : 1
                                    EIntPass : 1
                                     NMIPass : 1
                                    Reserved : 0
                                 System MGMT : 1
                                  LINT0 Pass : 1
                                  LINT1 Pass : 1
[068h 0104 001h]                      Handle : 20
[069h 0105 002h]       Source Used Device ID : 00A0
[06Bh 0107 001h]                     Variety : 01

[06Ch 0108 001h]               Subtable Type : 48 [Device Entry: Special Device]
[06Dh 0109 002h]                   Device ID : 0000
[06Fh 0111 001h] Data Setting (decoded below) : 00
                                    INITPass : 0
                                    EIntPass : 0
                                     NMIPass : 0
                                    Reserved : 0
                                 System MGMT : 0
                                  LINT0 Pass : 0
                                  LINT1 Pass : 0
[070h 0112 001h]                      Handle : 21
[071h 0113 002h]       Source Used Device ID : 0001
[073h 0115 001h]                     Variety : 01

[074h 0116 001h]               Subtable Type : 11 [Hardware Definition Block (IVHD)]
[075h 0117 001h]       Flags (decoded below) : 30
                                     HtTunEn : 0
                                      PassPW : 0
                                   ResPassPW : 0
                                Isoc Control : 0
                               Iotlb Support : 1
                                    Coherent : 1
                            Prefetch Support : 0
                                 PPR Support : 0
[076h 0118 002h]                      Length : 0054
[078h 0120 002h]                    DeviceId : 0002
[07Ah 0122 002h]           Capability Offset : 0040
[07Ch 0124 008h]                Base Address : 00000000F7500000
[084h 0132 002h]           PCI Segment Group : 0000
[086h 0134 002h]         Virtualization Info : 0000
[088h 0136 004h]                  Attributes : 00048000
[08Ch 0140 008h]                   EFR Image : 246577EFA2254AFA
[094h 0148 008h]                    Reserved : 0000000000000000

[09Ch 0156 001h]               Subtable Type : 03 [Device Entry: Start of Range]
[09Dh 0157 002h]                   Device ID : 0003
[09Fh 0159 001h] Data Setting (decoded below) : 00
                                    INITPass : 0
                                    EIntPass : 0
                                     NMIPass : 0
                                    Reserved : 0
                                 System MGMT : 0
                                  LINT0 Pass : 0
                                  LINT1 Pass : 0

[0A0h 0160 001h]               Subtable Type : 04 [Device Entry: End of Range]
[0A1h 0161 002h]                   Device ID : FFFE
[0A3h 0163 001h] Data Setting (decoded below) : 00
                                    INITPass : 0
                                    EIntPass : 0
                                     NMIPass : 0
                                    Reserved : 0
                                 System MGMT : 0
                                  LINT0 Pass : 0
                                  LINT1 Pass : 0

[0A4h 0164 001h]               Subtable Type : 43 [Device Entry: Alias Start of Range]
[0A5h 0165 002h]                   Device ID : FF00
[0A7h 0167 001h] Data Setting (decoded below) : 00
                                    INITPass : 0
                                    EIntPass : 0
                                     NMIPass : 0
                                    Reserved : 0
                                 System MGMT : 0
                                  LINT0 Pass : 0
                                  LINT1 Pass : 0
[0A8h 0168 001h]                    Reserved : 00
[0A9h 0169 002h]       Source Used Device ID : 00A5
[0ABh 0171 001h]                    Reserved : 00

[0ACh 0172 001h]               Subtable Type : 04 [Device Entry: End of Range]
[0ADh 0173 002h]                   Device ID : FFFF
[0AFh 0175 001h] Data Setting (decoded below) : 00
                                    INITPass : 0
                                    EIntPass : 0
                                     NMIPass : 0
                                    Reserved : 0
                                 System MGMT : 0
                                  LINT0 Pass : 0
                                  LINT1 Pass : 0

[0B0h 0176 001h]               Subtable Type : 48 [Device Entry: Special Device]
[0B1h 0177 002h]                   Device ID : 0000
[0B3h 0179 001h] Data Setting (decoded below) : 00
                                    INITPass : 0
                                    EIntPass : 0
                                     NMIPass : 0
                                    Reserved : 0
                                 System MGMT : 0
                                  LINT0 Pass : 0
                                  LINT1 Pass : 0
[0B4h 0180 001h]                      Handle : 00
[0B5h 0181 002h]       Source Used Device ID : 00A0
[0B7h 0183 001h]                     Variety : 02

[0B8h 0184 001h]               Subtable Type : 48 [Device Entry: Special Device]
[0B9h 0185 002h]                   Device ID : 0000
[0BBh 0187 001h] Data Setting (decoded below) : D7
                                    INITPass : 1
                                    EIntPass : 1
                                     NMIPass : 1
                                    Reserved : 0
                                 System MGMT : 1
                                  LINT0 Pass : 1
                                  LINT1 Pass : 1
[0BCh 0188 001h]                      Handle : 20
[0BDh 0189 002h]       Source Used Device ID : 00A0
[0BFh 0191 001h]                     Variety : 01

[0C0h 0192 001h]               Subtable Type : 48 [Device Entry: Special Device]
[0C1h 0193 002h]                   Device ID : 0000
[0C3h 0195 001h] Data Setting (decoded below) : 00
                                    INITPass : 0
                                    EIntPass : 0
                                     NMIPass : 0
                                    Reserved : 0
                                 System MGMT : 0
                                  LINT0 Pass : 0
                                  LINT1 Pass : 0
[0C4h 0196 001h]                      Handle : 21
[0C5h 0197 002h]       Source Used Device ID : 0001
[0C7h 0199 001h]                     Variety : 01

Raw Table Data: Length 200 (0xC8)

    0000: 49 56 52 53 C8 00 00 00 02 6D 41 4D 44 20 20 00  // IVRS.....mAMD  .
    0010: 41 6D 64 54 61 62 6C 65 01 00 00 00 41 4D 44 20  // AmdTable....AMD 
    0020: 01 00 00 00 41 30 20 00 00 00 00 00 00 00 00 00  // ....A0 .........
    0030: 10 B0 44 00 02 00 40 00 00 00 50 F7 00 00 00 00  // ..D...@...P.....
    0040: 00 00 00 00 6E 8F 04 80 03 03 00 00 04 FE FF 00  // ....n...........
    0050: 43 00 FF 00 00 A5 00 00 04 FF FF 00 48 00 00 00  // C...........H...
    0060: 00 A0 00 02 48 00 00 D7 20 A0 00 01 48 00 00 00  // ....H... ...H...
    0070: 21 01 00 01 11 30 54 00 02 00 40 00 00 00 50 F7  // !....0T...@...P.
    0080: 00 00 00 00 00 00 00 00 00 80 04 00 FA 4A 25 A2  // .............J%.
    0090: EF 77 65 24 00 00 00 00 00 00 00 00 03 03 00 00  // .we$............
    00A0: 04 FE FF 00 43 00 FF 00 00 A5 00 00 04 FF FF 00  // ....C...........
    00B0: 48 00 00 00 00 A0 00 02 48 00 00 D7 20 A0 00 01  // H.......H... ...
    00C0: 48 00 00 00 21 01 00 01                          // H...!...

--GTulLJWUtxNbtxgt--
