Received: from exactco.de (exactco.de [176.9.10.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71C2F3C0A
	for <iommu@lists.linux.dev>; Wed,  3 Dec 2025 11:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.10.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764760907; cv=none; b=KRbpAAbRj3eBja+j3C5qA8xCkRejLdSy3W8X/qbZPLu/FWnhYPwZb4qNcpv+EaMDBn6d0JBPCOQ+UOqCLBBWMKEaMDQwksD8pOCPql1VWLexlD1rVyr0jwz3JdeERI3m6W1BWb6MZ4rCldTr+n3SPg0l21+1RIOwpylw0bZPGb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764760907; c=relaxed/simple;
	bh=iZqnU3WseH4Z4TcClRhCb4JWpw/grTH9Kw5mvFrrLCc=;
	h=Date:Message-Id:Cc:To:Subject:From:Mime-Version:Content-Type; b=kaaxHYMkl61pTKMx7zi1gXmP3pJcB/sA7qQ0MCZGb+NwXDuUAREpPXYWGbZWrHts99X04sJ12xhI3U4upi2exPsKo7YqlqzmDav4jWG8As2HxCiTc0pV/qm9V6Q10Vb1+zqnBsG0+Akdh0M8TrAZ9rnbewJHaDZ4G4yzRqvjamM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de; spf=pass smtp.mailfrom=exactco.de; dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b=HOdvCGYI; arc=none smtp.client-ip=176.9.10.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exactco.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exactco.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=exactco.de header.i=@exactco.de header.b="HOdvCGYI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=exactco.de;
	s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version:From:Subject:To:Cc
	:Message-Id:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
	List-Owner:List-Archive; bh=qOoZW5buOxeIwWfYI63xT2dOu2nvI+ucK76qAlbSBbU=; b=H
	OdvCGYI/6YxJc5IxmkMiO7Smiy3KRNAeiLOjqlqFLeLLWgA6p9zlEqMEFyJtC6zJXNpvx3/laBwfn
	lYJnCHSC3wPzQgozm3RJVsGDzlFbv+FPthYoM5xp3Dcx9k0IG/0ZvJsyvT6X7nRnzvhslT1q/6OKP
	YKgwrPde32iXt+mj+R4j6LlT0uRtwRKFdUOK/Y2YZLs1WAo4HXWs0RjE3qD9WxvzYHo+O1Uo5lxEM
	asusFDAKi15L3KuPc0DoC07MySWosMCPZr6zm5OP5gSiZNGjE/EmpMWeqWdH+TejVk71Bb5UPLkPq
	s7/Nxx4cXco0DhtiHstnK0+Oe3CmiV6PQ==;
Date: Wed, 03 Dec 2025 12:21:39 +0100 (CET)
Message-Id: <20251203.122139.262836288998583119.rene@exactco.de>
Cc: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>, Borislav Petkov <bp@alien8.de>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
To: x86@kernel.org, iommu@lists.linux.dev
Subject: amd_iommu x2apic irq_remap broken on consumer AM5 X670/X870?
From: =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
X-Mailer: Mew version 6.10 on Emacs 30.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi,

since I got my Gigabyte Technology Co., Ltd. X670E AORUS MASTER/X670E
AORUS MASTER on AM5 launch day with an 7950x the amd_iommu w/ x2apic
irq_remap never has worked for me. Namely many devices not getting
interrupts, no matter what strict, passthrough mode I specify. The
only way to have all pci devices working with without irq_remap or
iommu disabled. Sometimes, however, I would like to pass some to a
Qemu VM though:

nvme nvme0: I/O tag 768 (8300) QID 21 timeout, completion polled
nvme nvme1: I/O tag 384 (8180) QID 7 timeout, completion polled
nvme nvme0: I/O tag 832 (f340) QID 22 timeout, completion polled
nvme nvme1: I/O tag 704 (c2c0) QID 21 timeout, completion polled
nvme nvme1: I/O tag 0 (4000) QID 5 timeout, completion polled
nvme nvme1: I/O tag 832 (d340) QID 22 timeout, completion polled
nvme nvme0: I/O tag 769 (9301) QID 21 timeout, completion polled
amdgpu 0000:13:00.0: [drm] REG_WAIT timeout 1us * 100000 tries - optc31_disable_crtc line:147
nvme nvme0: I/O tag 64 (f040) QID 24 timeout, completion polled

Mostly my two nvme drives, but amdgpu also appears to be a bit
glitchy. A friend recently reported smillar issues on an brand new
Asus X870 board w/ 9950x where even more does not work for them
(OCR'ed from screenshot):

hub 10-0:1.0: config failed, hub doesn't have any ports! (err -19)
sd 6:0:0:0: [sda] Asking for cache data failed
/dev/nvme0n1p2: clean, 997496/124696678 files, 2340087590/499823872 blocks
snd_hda_intel 0000:01:00.1: azx_get_response timeout, switching to polling mode: last cmd=0x000f0002
snd_hda_intel 0000:73:00.6: azx_get_response timeout, switching to polling mode: last cmd=0x004f0009
Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
xhci_hcd 0000:73:00.3: xHCI host not responding to stop endpoint command
xhci_hcd 0000:73:00.3: xHCI host controller not responding, assume dead
xhci_hcd 0000:73:00.3: HC died; cleaning up
usb 5-2.3: Failed to query (GET_INFO) UVC control on unit 2: -108 (exp. 1)
usb 5-2.3: Failed to query (GET_INFO) UVC control on unit 2: -19 (exp. 1)
usb 5-2.3: Failed to query (GET_INFO) UVC control on unit 2: -19 (exp. 1)
usb 5-2.3: Failed to query (GET_INFO) UVC control on unit 2: -19 (exp. 1)
usb 5-2.3: Failed to query (GET_INFO) UVC control on unit 2: -19 (exp. 1)
usb 5-2.3: Failed to query (GET_INFO) UVC control on unit 2: -19 (exp. 1)
usb 5-2.3: Failed to query (GET_INFO) UVC control on unit 2: -19 (exp. 1)
usb 5-2.3: Failed to query (GET_INFO) UVC control on unit 2: -19 (exp. 1)
uvcvideo 5-2.3:1.1: Failed to query (GET_CUR) UVC probe control : -19 (exp. 26).
usb 5-2.3:1.1: cannot set freq 16000 to ep 0x86
Buffer I/O error on dev sda, sector 64 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
Buffer I/O error on dev sda, sector 64 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 2
usb 5-2.3:1.2: failed to get current value for 0x80700 (id 5)
Buffer I/O error on dev sda, logical block 8 read
Buffer I/O error on dev sda, logical block 8 read
Buffer I/O error on dev sda, logical block 8 read
Buffer I/O error on dev sda, logical block 8 read
nvme nvme0: I/O tag 37 (8214) QID 13 timeout, completion polled
nvme nvme0: I/O tag 512 (e200) QID 25 timeout, completion polled
nvme nvme0: I/O tag 704 (22c0) QID 31 timeout, completion polled

For years I hoped an BIOS updates or kernel changes would eventually
fix this, but two years later nothing did improve.

I started to debug this last weekend, with various iommu_dump, debugfs
and printk but did not yet found any real clue why this does not
work. The same kernel build works on my am4/5950x w/ iommu and x2apic
just fine. My friend is on some official Ubuntu release.

Are there known consumer silicon limitations? Any help what is needed
to narrow this down and finally fix would be highly appreciated. See
below some initial iommu_dump and lspci details. One major difference
I noticed between my working x570 and not working x670 is the former
iommu not having an irq itself?

Thank you so much,
      René

00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Starship/Matisse IOMMU
        Subsystem: ASUSTeK Computer Inc. Device 8808
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr+ Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Capabilities: [40] Secure device <?>
        Capabilities: [64] MSI: Enable- Count=1/4 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [74] HyperTransport: MSI Mapping Enable+ Fixed+
        Capabilities: [c8] Vendor Specific Information: Len=18 <?>

00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge IOMMU
        Subsystem: Gigabyte Technology Co., Ltd Device d000
        Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 255
        Capabilities: [40] Secure device <?>
        Capabilities: [64] MSI: Enable- Count=1/4 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [74] HyperTransport: MSI Mapping Enable+ Fixed+

amd_iommu_dump=1

APIC: Switch to symmetric I/O mode setup
AMD-Vi: Using IVHD type 0x40
AMD-Vi: device: 0000:00:00.2 cap: 0040 flags: 30 info 0000
AMD-Vi:        mmio-addr: 00000000f7700000
AMD-Vi: PCI segment : 0x0, last bdf : 0xffff
AMD-Vi:   DEV_SELECT_RANGE_START\x09devid: 0000:00:00.3 flags: 0x0
AMD-Vi:   DEV_RANGE_END\x09\x09devid: 0000:ff:1f.6
AMD-Vi:   DEV_ALIAS_RANGE\x09\x09devid: 0000:ff:00.0 flags: 0x0 devid_to: 0000:00:14.5
AMD-Vi:   DEV_RANGE_END\x09\x09devid: 0000:ff:1f.7
AMD-Vi:   DEV_SPECIAL(HPET[0])\x09\x09devid: 0000:00:14.0, flags: 0x0
AMD-Vi:   DEV_SPECIAL(IOAPIC[32])\x09\x09devid: 0000:00:14.0, flags: 0xd7
AMD-Vi:   DEV_SPECIAL(IOAPIC[33])\x09\x09devid: 0000:00:00.1, flags: 0x0
AMD-Vi:   DEV_ACPI_HID(AMDI0020[ID00])\x09\x09devid: 0000:00:14.5, flags: 0x40
AMD-Vi: ivrs, add hid:AMDI0020, uid:ID00, rdevid:0xa0
AMD-Vi:   DEV_ACPI_HID(AMDI0020[ID01])\x09\x09devid: 0000:00:14.5, flags: 0x40
AMD-Vi: ivrs, add hid:AMDI0020, uid:ID01, rdevid:0xa0
AMD-Vi:   DEV_ACPI_HID(AMDI0020[ID02])\x09\x09devid: 0000:00:14.5, flags: 0x40
AMD-Vi: ivrs, add hid:AMDI0020, uid:ID02, rdevid:0xa0
AMD-Vi:   DEV_ACPI_HID(AMDI0020[ID03])\x09\x09devid: 0000:00:14.5, flags: 0x40
AMD-Vi: ivrs, add hid:AMDI0020, uid:ID03, rdevid:0xa0
AMD-Vi: Using global IVHD EFR:0x246577efa2254afe, EFR2:0x0

lspci -vvv | grep '^[^[:space:]]\|Interr'
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Root Complex
00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge IOMMU
	Interrupt: pin A routed to IRQ 255
00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge
00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge GPP Bridge (prog-if 00 [Normal decode])
	Interrupt: pin ? routed to IRQ 30
00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge
00:02.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge GPP Bridge (prog-if 00 [Normal decode])
	Interrupt: pin ? routed to IRQ 31
00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge GPP Bridge (prog-if 00 [Normal decode])
	Interrupt: pin ? routed to IRQ 32
00:03.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge
00:04.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge
00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Dummy Host Bridge
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Internal GPP Bridge to Bus [C:A] (prog-if 00 [Normal decode])
	Interrupt: pin A routed to IRQ 33
00:08.3 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Internal GPP Bridge to Bus [C:A] (prog-if 00 [Normal decode])
	Interrupt: pin A routed to IRQ 34
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 71)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 51)
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 5
00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 6
00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge Data Fabric; Function 7
01:00.0 Non-Volatile memory controller: Sandisk Corp WD Black SN850X NVMe SSD (rev 01) (prog-if 02 [NVM Express])
	Interrupt: pin A routed to IRQ 46
02:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Upstream Port (rev 01) (prog-if 00 [Normal decode])
	Interrupt: pin A routed to IRQ 24
03:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port (rev 01) (prog-if 00 [Normal decode])
	Interrupt: pin A routed to IRQ 35
03:04.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port (rev 01) (prog-if 00 [Normal decode])
	Interrupt: pin A routed to IRQ 36
03:05.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port (rev 01) (prog-if 00 [Normal decode])
	Interrupt: pin A routed to IRQ 38
03:06.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port (rev 01) (prog-if 00 [Normal decode])
	Interrupt: pin A routed to IRQ 40
03:08.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port (rev 01) (prog-if 00 [Normal decode])
	Interrupt: pin A routed to IRQ 41
03:0c.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port (rev 01) (prog-if 00 [Normal decode])
	Interrupt: pin A routed to IRQ 24
03:0d.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port (rev 01) (prog-if 00 [Normal decode])
	Interrupt: pin A routed to IRQ 37
08:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Upstream Port (rev 01) (prog-if 00 [Normal decode])
	Interrupt: pin A routed to IRQ 24
09:00.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port (rev 01) (prog-if 00 [Normal decode])
	Interrupt: pin A routed to IRQ 42
09:04.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port (rev 01) (prog-if 00 [Normal decode])
	Interrupt: pin A routed to IRQ 43
09:06.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port (rev 01) (prog-if 00 [Normal decode])
	Interrupt: pin A routed to IRQ 44
09:08.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port (rev 01) (prog-if 00 [Normal decode])
	Interrupt: pin A routed to IRQ 45
09:0c.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port (rev 01) (prog-if 00 [Normal decode])
	Interrupt: pin A routed to IRQ 24
09:0d.0 PCI bridge: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset PCIe Switch Downstream Port (rev 01) (prog-if 00 [Normal decode])
	Interrupt: pin A routed to IRQ 37
0c:00.0 Ethernet controller: Intel Corporation Ethernet Controller I225-V (rev 03)
	Interrupt: pin A routed to IRQ 39
0e:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset USB 3.2 Controller (rev 01) (prog-if 30 [XHCI])
	Interrupt: pin A routed to IRQ 24
0f:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset SATA Controller (rev 01) (prog-if 01 [AHCI 1.0])
	Interrupt: pin A routed to IRQ 160
10:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset USB 3.2 Controller (rev 01) (prog-if 30 [XHCI])
	Interrupt: pin A routed to IRQ 24
11:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] 600 Series Chipset SATA Controller (rev 01) (prog-if 01 [AHCI 1.0])
	Interrupt: pin A routed to IRQ 161
12:00.0 Non-Volatile memory controller: Sandisk Corp WD Black SN850X NVMe SSD (rev 01) (prog-if 02 [NVM Express])
	Interrupt: pin A routed to IRQ 24
13:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Raphael (rev c1) (prog-if 00 [VGA controller])
	Interrupt: pin A routed to IRQ 79
13:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Radeon High Definition Audio Controller [Rembrandt/Strix]
	Interrupt: pin B routed to IRQ 164
13:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 19h PSP/CCP
	Interrupt: pin C routed to IRQ 255
13:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge USB 3.1 xHCI (prog-if 30 [XHCI])
	Interrupt: pin D routed to IRQ 70
13:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge USB 3.1 xHCI (prog-if 30 [XHCI])
	Interrupt: pin A routed to IRQ 79
13:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h/19h/1ah HD Audio Controller
	Interrupt: pin C routed to IRQ 165
14:00.0 USB controller: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridge USB 2.0 xHCI (prog-if 30 [XHCI])
	Interrupt: pin A routed to IRQ 24

-- 
René Rebe, ExactCODE GmbH, Berlin, Germany
https://exactco.de • https://t2linux.com • https://patreon.com/renerebe
