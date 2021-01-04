Return-Path: <SRS0=ghm9=GH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248D4C433DB
	for <iommu@archiver.kernel.org>; Mon,  4 Jan 2021 23:24:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD0E20789
	for <iommu@archiver.kernel.org>; Mon,  4 Jan 2021 23:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD0E20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0CD7486DB0;
	Mon,  4 Jan 2021 23:24:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FEdc7ANp92Mq; Mon,  4 Jan 2021 23:24:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C51F684371;
	Mon,  4 Jan 2021 23:24:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6161C088B;
	Mon,  4 Jan 2021 23:24:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF415C013A
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jan 2021 23:24:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C679F848A9
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jan 2021 23:24:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y97ZuXxbjwpQ for <iommu@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 23:24:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BC93585AE9
 for <iommu@lists.linux-foundation.org>; Mon,  4 Jan 2021 23:24:00 +0000 (UTC)
Received: from zn.tnic (p200300ec2f086c00329c23fffea6a903.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f08:6c00:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 603711EC04BF;
 Tue,  5 Jan 2021 00:23:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1609802636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=awv9l/SdcR6rvzuFwZGQBCvqI4bOZoLi18GlQBYNZEw=;
 b=nId8X0rknWtfLrIHUxYek5cgfSF711MXzH4vaeqWo3tPZ6MtsMHpcGjMfTQ98lirc5Fc3g
 YsHBbWJf7SAUVbC9dD62fYizrdqTdWo8xJGvpQPJl0VeFUVC0iKQJ2nSzFS/586CQ8Tr7G
 MRQNkcTTKeW4ds+Qr4aqxLX1v+TT2us=
Date: Tue, 5 Jan 2021 00:23:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: iommu@lists.linux-foundation.org, David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: Interrupts enabled after amd_iommu_resume+0x0/0x40
Message-ID: <20210104232353.GJ32151@zn.tnic>
References: <20210104132250.GE32151@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210104132250.GE32151@zn.tnic>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Jan 04, 2021 at 02:22:50PM +0100, Borislav Petkov wrote:
> Hi folks,
> 
> syscore_resume() doesn't like when the AMD iommu driver enables
> interrupts in its ->resume hook when I resume the box from suspend to
> RAM.
> 
> All kinds of warnings get triggered too:
> 
> [   17.386830] WARNING: CPU: 0 PID: 2 at kernel/time/timekeeping.c:824 ktime_get+0x8d/0xa0
> [   17.386830] WARNING: CPU: 0 PID: 2 at kernel/time/timekeeping.c:867 ktime_get_with_offset+0xda/0xf0
> [   17.386830] WARNING: CPU: 0 PID: 2 at kernel/time/timekeeping.c:824 ktime_get+0x8d/0xa0
> [   17.386830] WARNING: CPU: 0 PID: 2 at kernel/time/timekeeping.c:867 ktime_get_with_offset+0xda/0xf0
> [   17.386830] WARNING: CPU: 0 PID: 1576 at drivers/base/syscore.c:103 syscore_resume+0x12d/0x160
> 
> but when I comment out the
> 
> 	amd_iommu_enable_interrupts()
> 
> call in the resume hook, all is fine and quiet and box resumes.
> 
> I'll try to bisect later to try to pinpoint it better because I don't
> see what recent change would've caused this. But someone might have a
> better idea so CC the usual suspects.

Ok, bisected to:

# first bad commit: [d1adcfbb520c43c10fc22fcdccdd4204e014fb53] iommu/amd: Fix IOMMU interrupt generation in X2APIC mode

That patch reverts cleanly ontop of -rc2 and with it reverted, the
machine resumes fine.

Below is the full dmesg of the failing case:

[    0.000000] Linux version 5.11.0-rc2+ (root@vh) (gcc (Debian 10.2.0-16) 10.2.0, GNU ld (GNU Binutils for Debian) 2.35.1) #20 SMP PREEMPT Mon Jan 4 23:44:59 CET 2021
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.11.0-rc2+ root=UUID=b8777929-d36d-43a9-a767-7ac37891ece0 ro debug ignore_loglevel log_buf_len=16M no_console_suspend net.ifnames=0 systemd.log_target=null resume=/dev/nvme0n1p3
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009bfffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009c00000-0x0000000009d00fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000009d01000-0x0000000009efffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f0ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000009f10000-0x00000000bd9ddfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bd9de000-0x00000000bdbddfff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000bdbde000-0x00000000ca37dfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ca37e000-0x00000000cc37dfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000cc37e000-0x00000000cc3fdfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000cc3fe000-0x00000000cdffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ce000000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fde00000-0x00000000fdefffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000040f33ffff] usable
[    0.000000] BIOS-e820: [mem 0x000000040f340000-0x000000042fffffff] reserved
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.70 by Lenovo
[    0.000000] efi: ACPI=0xcc3fd000 ACPI 2.0=0xcc3fd014 TPMFinalLog=0xcc22d000 SMBIOS=0xbf71e000 SMBIOS 3.0=0xbf711000 MEMATTR=0xba547018 
[    0.000000] SMBIOS 3.2.0 present.
[    0.000000] DMI: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W(1.27 ) 10/20/2020
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 1696.901 MHz processor
[    0.000008] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000010] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000015] last_pfn = 0x40f340 max_arch_pfn = 0x400000000
[    0.000019] MTRR default type: uncachable
[    0.000020] MTRR fixed ranges enabled:
[    0.000021]   00000-9FFFF write-back
[    0.000022]   A0000-BFFFF uncachable
[    0.000023]   C0000-FFFFF write-protect
[    0.000024] MTRR variable ranges enabled:
[    0.000025]   0 base 000000000000 mask FFFF80000000 write-back
[    0.000027]   1 base 000080000000 mask FFFFC0000000 write-back
[    0.000028]   2 base 0000C0000000 mask FFFFF0000000 write-back
[    0.000029]   3 base 0000FF000000 mask FFFFFF000000 write-protect
[    0.000030]   4 disabled
[    0.000031]   5 disabled
[    0.000032]   6 disabled
[    0.000032]   7 disabled
[    0.000033] TOM2: 0000000430000000 aka 17152M
[    0.000194] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000534] last_pfn = 0xce000 max_arch_pfn = 0x400000000
[    0.003662] Using GB pages for direct mapping
[    0.018779] printk: log_buf_len: 16777216 bytes
[    0.018782] printk: early log buf free: 127432(97%)
[    0.018784] Secure boot could not be determined
[    0.018784] RAMDISK: [mem 0x37141000-0x37897fff]
[    0.018795] ACPI: Early table checksum verification disabled
[    0.018799] ACPI: RSDP 0x00000000CC3FD014 000024 (v02 LENOVO)
[    0.018802] ACPI: XSDT 0x00000000CC3FB188 0000FC (v01 LENOVO TP-R1B   00001270 PTEC 00000002)
[    0.018807] ACPI: FACP 0x00000000BE499000 000114 (v06 LENOVO TP-R1B   00001270 PTEC 00000002)
[    0.018811] ACPI: DSDT 0x00000000BE485000 00E856 (v01 LENOVO TP-R1B   00001270 INTL 20180313)
[    0.018814] ACPI: FACS 0x00000000CC218000 000040
[    0.018816] ACPI: SSDT 0x00000000BF751000 0000A2 (v01 LENOVO PID0Ssdt 00000001 INTL 20180313)
[    0.018818] ACPI: SSDT 0x00000000BF750000 000CCC (v01 LENOVO UsbCTabl 00000001 INTL 20180313)
[    0.018820] ACPI: SSDT 0x00000000BF743000 007216 (v02 LENOVO TP-R1B   00000002 MSFT 04000000)
[    0.018822] ACPI: IVRS 0x00000000BF742000 0001A4 (v02 LENOVO TP-R1B   00001270 PTEC 00000002)
[    0.018824] ACPI: SSDT 0x00000000BF704000 000266 (v01 LENOVO STD3     00000001 INTL 20180313)
[    0.018827] ACPI: SSDT 0x00000000BF6F0000 000632 (v02 LENOVO Tpm2Tabl 00001000 INTL 20180313)
[    0.018829] ACPI: TPM2 0x00000000BF6EF000 000034 (v03 LENOVO TP-R1B   00001270 PTEC 00000002)
[    0.018831] ACPI: SSDT 0x00000000BF6EE000 000924 (v01 LENOVO WmiTable 00000001 INTL 20180313)
[    0.018833] ACPI: POAT 0x00000000BF6B5000 000055 (v03 LENOVO TP-R1B   00001270 PTEC 00000002)
[    0.018835] ACPI: BATB 0x00000000BF6A0000 00004A (v02 LENOVO TP-R1B   00001270 PTEC 00000002)
[    0.018837] ACPI: HPET 0x00000000BE498000 000038 (v01 LENOVO TP-R1B   00001270 PTEC 00000002)
[    0.018840] ACPI: APIC 0x00000000BE497000 000138 (v02 LENOVO TP-R1B   00001270 PTEC 00000002)
[    0.018842] ACPI: MCFG 0x00000000BE496000 00003C (v01 LENOVO TP-R1B   00001270 PTEC 00000002)
[    0.018844] ACPI: SBST 0x00000000BE495000 000030 (v01 LENOVO TP-R1B   00001270 PTEC 00000002)
[    0.018846] ACPI: WSMT 0x00000000BE494000 000028 (v01 LENOVO TP-R1B   00001270 PTEC 00000002)
[    0.018848] ACPI: VFCT 0x00000000BE477000 00D484 (v01 LENOVO TP-R1B   00001270 PTEC 00000002)
[    0.018850] ACPI: SSDT 0x00000000BE473000 0039F4 (v01 LENOVO TP-R1B   00000001 AMD  00000001)
[    0.018852] ACPI: CRAT 0x00000000BE472000 000F00 (v01 LENOVO TP-R1B   00001270 PTEC 00000002)
[    0.018854] ACPI: CDIT 0x00000000BE471000 000029 (v01 LENOVO TP-R1B   00001270 PTEC 00000002)
[    0.018857] ACPI: FPDT 0x00000000BF6C7000 000034 (v01 LENOVO TP-R1B   00001270 PTEC 00000002)
[    0.018859] ACPI: SSDT 0x00000000BE46F000 0013CF (v01 LENOVO TP-R1B   00000001 INTL 20180313)
[    0.018861] ACPI: SSDT 0x00000000BE46D000 001576 (v01 LENOVO TP-R1B   00000001 INTL 20180313)
[    0.018863] ACPI: SSDT 0x00000000BE469000 00353C (v01 LENOVO TP-R1B   00000001 INTL 20180313)
[    0.018865] ACPI: UEFI 0x00000000CC217000 00013E (v01 LENOVO TP-R1B   00001270 PTEC 00000002)
[    0.018867] ACPI: SSDT 0x00000000BF74F000 000090 (v01 LENOVO TP-R1B   00000001 INTL 20180313)
[    0.018869] ACPI: SSDT 0x00000000BF74E000 0009AD (v01 LENOVO TP-R1B   00000001 INTL 20180313)
[    0.018875] ACPI: Local APIC address 0xfee00000
[    0.018920] No NUMA configuration found
[    0.018921] Faking a node at [mem 0x0000000000000000-0x000000040f33ffff]
[    0.018925] NODE_DATA(0) allocated [mem 0x40f33e000-0x40f33ffff]
[    0.018947] Zone ranges:
[    0.018948]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.018949]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.018950]   Normal   [mem 0x0000000100000000-0x000000040f33ffff]
[    0.018952] Movable zone start for each node
[    0.018952] Early memory node ranges
[    0.018953]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.018954]   node   0: [mem 0x0000000000100000-0x0000000009bfffff]
[    0.018955]   node   0: [mem 0x0000000009d01000-0x0000000009efffff]
[    0.018956]   node   0: [mem 0x0000000009f10000-0x00000000bd9ddfff]
[    0.018957]   node   0: [mem 0x00000000cc3fe000-0x00000000cdffffff]
[    0.018958]   node   0: [mem 0x0000000100000000-0x000000040f33ffff]
[    0.019278] Zeroed struct page in unavailable ranges: 38995 pages
[    0.019279] Initmem setup node 0 [mem 0x0000000000001000-0x000000040f33ffff]
[    0.019281] On node 0 totalpages: 3991469
[    0.019282]   DMA zone: 64 pages used for memmap
[    0.019283]   DMA zone: 23 pages reserved
[    0.019284]   DMA zone: 3998 pages, LIFO batch:0
[    0.019316]   DMA32 zone: 12180 pages used for memmap
[    0.019317]   DMA32 zone: 779471 pages, LIFO batch:63
[    0.025069]   Normal zone: 50125 pages used for memmap
[    0.025075]   Normal zone: 3208000 pages, LIFO batch:63
[    0.026055] ACPI: PM-Timer IO Port: 0x408
[    0.026057] ACPI: Local APIC address 0xfee00000
[    0.026063] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.026064] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.026065] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.026066] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.026066] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.026067] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.026068] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.026069] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.026069] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.026070] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.026071] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.026072] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.026072] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.026073] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.026074] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.026075] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.026088] IOAPIC[0]: apic_id 32, version 33, address 0xfec00000, GSI 0-23
[    0.026093] IOAPIC[1]: apic_id 33, version 33, address 0xfec01000, GSI 24-55
[    0.026094] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.026096] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.026098] ACPI: IRQ0 used by override.
[    0.026099] ACPI: IRQ9 used by override.
[    0.026100] Using ACPI (MADT) for SMP configuration information
[    0.026101] ACPI: HPET id: 0x43538210 base: 0xfed00000
[    0.026105] smpboot: Allowing 16 CPUs, 0 hotplug CPUs
[    0.026122] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.026124] PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.026125] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.026126] PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.026127] PM: hibernation: Registered nosave memory: [mem 0x09c00000-0x09d00fff]
[    0.026128] PM: hibernation: Registered nosave memory: [mem 0x09f00000-0x09f0ffff]
[    0.026130] PM: hibernation: Registered nosave memory: [mem 0xbd9de000-0xbdbddfff]
[    0.026131] PM: hibernation: Registered nosave memory: [mem 0xbdbde000-0xca37dfff]
[    0.026131] PM: hibernation: Registered nosave memory: [mem 0xca37e000-0xcc37dfff]
[    0.026132] PM: hibernation: Registered nosave memory: [mem 0xcc37e000-0xcc3fdfff]
[    0.026134] PM: hibernation: Registered nosave memory: [mem 0xce000000-0xcfffffff]
[    0.026134] PM: hibernation: Registered nosave memory: [mem 0xd0000000-0xf7ffffff]
[    0.026135] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
[    0.026136] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0xfddfffff]
[    0.026136] PM: hibernation: Registered nosave memory: [mem 0xfde00000-0xfdefffff]
[    0.026137] PM: hibernation: Registered nosave memory: [mem 0xfdf00000-0xfed7ffff]
[    0.026138] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfed80fff]
[    0.026138] PM: hibernation: Registered nosave memory: [mem 0xfed81000-0xffffffff]
[    0.026140] [mem 0xd0000000-0xf7ffffff] available for PCI devices
[    0.026142] Booting paravirtualized kernel on bare hardware
[    0.026145] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.028932] setup_percpu: NR_CPUS:16 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.029532] percpu: Embedded 53 pages/cpu s180224 r8192 d28672 u262144
[    0.029539] pcpu-alloc: s180224 r8192 d28672 u262144 alloc=1*2097152
[    0.029541] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
[    0.029564] Built 1 zonelists, mobility grouping on.  Total pages: 3929077
[    0.029565] Policy zone: Normal
[    0.029567] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.11.0-rc2+ root=UUID=b8777929-d36d-43a9-a767-7ac37891ece0 ro debug ignore_loglevel log_buf_len=16M no_console_suspend net.ifnames=0 systemd.log_target=null resume=/dev/nvme0n1p3
[    0.031459] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    0.032383] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.032426] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.049191] Memory: 3113028K/15965876K available (12297K kernel code, 1784K rwdata, 4176K rodata, 1420K init, 4104K bss, 505756K reserved, 0K cma-reserved)
[    0.049199] random: get_random_u64 called from __kmem_cache_create+0x1e/0x6d0 with crng_init=0
[    0.049306] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.049316] ftrace: allocating 34911 entries in 137 pages
[    0.057908] ftrace: allocated 137 pages with 3 groups
[    0.058013] rcu: Preemptible hierarchical RCU implementation.
[    0.058014] 	Trampoline variant of Tasks RCU enabled.
[    0.058015] 	Rude variant of Tasks RCU enabled.
[    0.058015] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.060436] NR_IRQS: 4352, nr_irqs: 1096, preallocated irqs: 16
[    0.060777] random: crng done (trusting CPU's manufacturer)
[    0.060798] Console: colour dummy device 80x25
[    0.060994] printk: console [tty0] enabled
[    0.061010] ACPI: Core revision 20201113
[    0.061183] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
[    0.061203] APIC: Switch to symmetric I/O mode setup
[    0.061846] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR0, rdevid:160
[    0.061848] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR1, rdevid:160
[    0.061850] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR2, rdevid:160
[    0.061851] AMD-Vi: ivrs, add hid:AMDI0020, uid:\_SB.FUR3, rdevid:160
[    0.159307] Switched APIC routing to physical flat.
[    0.160038] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.177203] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1875b7b5daa, max_idle_ns: 440795214762 ns
[    0.177213] Calibrating delay loop (skipped), value calculated using timer frequency.. 3393.80 BogoMIPS (lpj=6787604)
[    0.177216] pid_max: default: 32768 minimum: 301
[    0.178648] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.178698] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.178907] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.178965] LVT offset 1 assigned for vector 0xf9
[    0.179074] LVT offset 2 assigned for vector 0xf4
[    0.179099] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    0.179101] Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
[    0.179106] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.179110] Spectre V2 : Mitigation: Full AMD retpoline
[    0.179111] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.179113] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.179115] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.179118] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
[    0.179120] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
[    0.179306] Freeing SMP alternatives memory: 28K
[    0.288170] smpboot: CPU0: AMD Ryzen 7 PRO 4750U with Radeon Graphics (family: 0x17, model: 0x60, stepping: 0x1)
[    0.288307] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
[    0.288315] ... version:                0
[    0.288316] ... bit width:              48
[    0.288317] ... generic registers:      6
[    0.288319] ... value mask:             0000ffffffffffff
[    0.288320] ... max period:             00007fffffffffff
[    0.288321] ... fixed-purpose events:   0
[    0.288323] ... event mask:             000000000000003f
[    0.288386] rcu: Hierarchical SRCU implementation.
[    0.288647] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.288788] smp: Bringing up secondary CPUs ...
[    0.288872] x86: Booting SMP configuration:
[    0.288874] .... node  #0, CPUs:        #1
[    0.289208] TSC synchronization [CPU#0 -> CPU#1]:
[    0.289208] Measured 401296509 cycles TSC warp between CPUs, turning off TSC clock.
[    0.289208] tsc: Marking TSC unstable due to check_tsc_sync_source failed
[    0.289208]   #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
[    0.293506] smp: Brought up 1 node, 16 CPUs
[    0.293506] smpboot: Max logical packages: 1
[    0.293506] smpboot: Total of 16 processors activated (54300.83 BogoMIPS)
[    0.309271] node 0 deferred pages initialised in 16ms
[    0.309555] devtmpfs: initialized
[    0.309555] PM: Registering ACPI NVS region [mem 0x09f00000-0x09f0ffff] (65536 bytes)
[    0.309555] PM: Registering ACPI NVS region [mem 0xca37e000-0xcc37dfff] (33554432 bytes)
[    0.309555] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.309555] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    0.309555] pinctrl core: initialized pinctrl subsystem
[    0.309555] NET: Registered protocol family 16
[    0.309662] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
[    0.309884] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.310105] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.310195] thermal_sys: Registered thermal governor 'fair_share'
[    0.310196] thermal_sys: Registered thermal governor 'bang_bang'
[    0.310198] thermal_sys: Registered thermal governor 'step_wise'
[    0.310200] thermal_sys: Registered thermal governor 'user_space'
[    0.310218] cpuidle: using governor ladder
[    0.310223] cpuidle: using governor menu
[    0.310252] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.310252] ACPI: bus type PCI registered
[    0.310252] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.310252] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.310252] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
[    0.310252] PCI: Using configuration type 1 for base access
[    0.313447] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.313447] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.513925] ACPI: Added _OSI(Module Device)
[    0.513925] ACPI: Added _OSI(Processor Device)
[    0.513925] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.513925] ACPI: Added _OSI(Processor Aggregator Device)
[    0.513925] ACPI: Added _OSI(Linux-Dell-Video)
[    0.513925] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.513925] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.523348] ACPI: 13 ACPI AML tables successfully acquired and loaded
[    0.524300] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.535283] ACPI: EC: EC started
[    0.535286] ACPI: EC: interrupt blocked
[    0.535430] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.535433] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC used to handle transactions
[    0.535435] ACPI: Interpreter enabled
[    0.535448] ACPI: (supports S0 S3 S4 S5)
[    0.535450] ACPI: Using IOAPIC for interrupt routing
[    0.535528] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.535691] ACPI: Enabled 3 GPEs in block 00 to 1F
[    0.536373] ACPI: Power Resource [P0U1] (on)
[    0.536388] ACPI: Power Resource [P3U1] (on)
[    0.536581] ACPI: Power Resource [WRST] (on)
[    0.536658] ACPI: Power Resource [P0NV] (on)
[    0.537138] ACPI: Power Resource [P0S0] (on)
[    0.537152] ACPI: Power Resource [P3S0] (on)
[    0.537196] ACPI: Power Resource [P0S1] (on)
[    0.537212] ACPI: Power Resource [P3S1] (on)
[    0.539114] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.539121] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.539194] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug LTR]
[    0.539261] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    0.539263] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    0.539271] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
[    0.539377] PCI host bridge to bus 0000:00
[    0.539379] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.539382] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c1fff window]
[    0.539384] pci_bus 0000:00: root bus resource [mem 0x000c2000-0x000c3fff window]
[    0.539386] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c5fff window]
[    0.539389] pci_bus 0000:00: root bus resource [mem 0x000c6000-0x000c7fff window]
[    0.539391] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000c9fff window]
[    0.539393] pci_bus 0000:00: root bus resource [mem 0x000ca000-0x000cbfff window]
[    0.539395] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cdfff window]
[    0.539397] pci_bus 0000:00: root bus resource [mem 0x000ce000-0x000cffff window]
[    0.539399] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d1fff window]
[    0.539401] pci_bus 0000:00: root bus resource [mem 0x000d2000-0x000d3fff window]
[    0.539403] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d5fff window]
[    0.539405] pci_bus 0000:00: root bus resource [mem 0x000d6000-0x000d7fff window]
[    0.539407] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000d9fff window]
[    0.539409] pci_bus 0000:00: root bus resource [mem 0x000da000-0x000dbfff window]
[    0.539411] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000ddfff window]
[    0.539413] pci_bus 0000:00: root bus resource [mem 0x000de000-0x000dffff window]
[    0.539415] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e1fff window]
[    0.539417] pci_bus 0000:00: root bus resource [mem 0x000e2000-0x000e3fff window]
[    0.539419] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e5fff window]
[    0.539421] pci_bus 0000:00: root bus resource [mem 0x000e6000-0x000e7fff window]
[    0.539423] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000e9fff window]
[    0.539425] pci_bus 0000:00: root bus resource [mem 0x000ea000-0x000ebfff window]
[    0.539427] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000edfff window]
[    0.539429] pci_bus 0000:00: root bus resource [mem 0x000ee000-0x000effff window]
[    0.539431] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xf7ffffff window]
[    0.539434] pci_bus 0000:00: root bus resource [mem 0xfc000000-0xfdffffff window]
[    0.539436] pci_bus 0000:00: root bus resource [mem 0x430000000-0xffffffffff window]
[    0.539438] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.539440] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.539442] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.539452] pci 0000:00:00.0: [1022:1630] type 00 class 0x060000
[    0.539520] pci 0000:00:00.2: [1022:1631] type 00 class 0x080600
[    0.539586] pci 0000:00:01.0: [1022:1632] type 00 class 0x060000
[    0.539640] pci 0000:00:02.0: [1022:1632] type 00 class 0x060000
[    0.539689] pci 0000:00:02.1: [1022:1634] type 01 class 0x060400
[    0.539748] pci 0000:00:02.1: PME# supported from D0 D3hot D3cold
[    0.539819] pci 0000:00:02.2: [1022:1634] type 01 class 0x060400
[    0.539876] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    0.539950] pci 0000:00:02.3: [1022:1634] type 01 class 0x060400
[    0.540015] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
[    0.540075] pci 0000:00:02.4: [1022:1634] type 01 class 0x060400
[    0.540131] pci 0000:00:02.4: PME# supported from D0 D3hot D3cold
[    0.540207] pci 0000:00:02.6: [1022:1634] type 01 class 0x060400
[    0.540263] pci 0000:00:02.6: PME# supported from D0 D3hot D3cold
[    0.540337] pci 0000:00:08.0: [1022:1632] type 00 class 0x060000
[    0.540386] pci 0000:00:08.1: [1022:1635] type 01 class 0x060400
[    0.540407] pci 0000:00:08.1: enabling Extended Tags
[    0.540437] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
[    0.540520] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
[    0.540606] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
[    0.540718] pci 0000:00:18.0: [1022:1448] type 00 class 0x060000
[    0.540746] pci 0000:00:18.1: [1022:1449] type 00 class 0x060000
[    0.540774] pci 0000:00:18.2: [1022:144a] type 00 class 0x060000
[    0.540801] pci 0000:00:18.3: [1022:144b] type 00 class 0x060000
[    0.540832] pci 0000:00:18.4: [1022:144c] type 00 class 0x060000
[    0.540860] pci 0000:00:18.5: [1022:144d] type 00 class 0x060000
[    0.540890] pci 0000:00:18.6: [1022:144e] type 00 class 0x060000
[    0.540917] pci 0000:00:18.7: [1022:144f] type 00 class 0x060000
[    0.541226] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802
[    0.541243] pci 0000:01:00.0: reg 0x10: [mem 0xfd800000-0xfd803fff 64bit]
[    0.541431] pci 0000:00:02.1: PCI bridge to [bus 01]
[    0.541435] pci 0000:00:02.1:   bridge window [mem 0xfd800000-0xfd8fffff]
[    0.541486] pci 0000:02:00.0: [10ec:8168] type 00 class 0x020000
[    0.541503] pci 0000:02:00.0: reg 0x10: [io  0x3400-0x34ff]
[    0.541525] pci 0000:02:00.0: reg 0x18: [mem 0xfd714000-0xfd714fff 64bit]
[    0.541540] pci 0000:02:00.0: reg 0x20: [mem 0xfd700000-0xfd703fff 64bit]
[    0.541633] pci 0000:02:00.0: supports D1 D2
[    0.541634] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.541746] pci 0000:02:00.1: [10ec:816a] type 00 class 0x070002
[    0.541761] pci 0000:02:00.1: reg 0x10: [io  0x3200-0x32ff]
[    0.541779] pci 0000:02:00.1: reg 0x18: [mem 0xfd715000-0xfd715fff 64bit]
[    0.541791] pci 0000:02:00.1: reg 0x20: [mem 0xfd704000-0xfd707fff 64bit]
[    0.541875] pci 0000:02:00.1: supports D1 D2
[    0.541877] pci 0000:02:00.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.541964] pci 0000:02:00.2: [10ec:816b] type 00 class 0x070002
[    0.541979] pci 0000:02:00.2: reg 0x10: [io  0x3100-0x31ff]
[    0.541996] pci 0000:02:00.2: reg 0x18: [mem 0xfd716000-0xfd716fff 64bit]
[    0.542008] pci 0000:02:00.2: reg 0x20: [mem 0xfd708000-0xfd70bfff 64bit]
[    0.542091] pci 0000:02:00.2: supports D1 D2
[    0.542092] pci 0000:02:00.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.542179] pci 0000:02:00.3: [10ec:816c] type 00 class 0x0c0701
[    0.542194] pci 0000:02:00.3: reg 0x10: [io  0x3000-0x30ff]
[    0.542211] pci 0000:02:00.3: reg 0x18: [mem 0xfd717000-0xfd717fff 64bit]
[    0.542223] pci 0000:02:00.3: reg 0x20: [mem 0xfd70c000-0xfd70ffff 64bit]
[    0.542306] pci 0000:02:00.3: supports D1 D2
[    0.542307] pci 0000:02:00.3: PME# supported from D0 D1 D2 D3hot D3cold
[    0.542393] pci 0000:02:00.4: [10ec:816d] type 00 class 0x0c0320
[    0.542410] pci 0000:02:00.4: reg 0x10: [mem 0xfd718000-0xfd718fff]
[    0.542432] pci 0000:02:00.4: reg 0x18: [mem 0xfd710000-0xfd713fff 64bit]
[    0.542534] pci 0000:02:00.4: supports D1 D2
[    0.542535] pci 0000:02:00.4: PME# supported from D0 D1 D2 D3hot D3cold
[    0.542664] pci 0000:00:02.2: PCI bridge to [bus 02]
[    0.542667] pci 0000:00:02.2:   bridge window [io  0x3000-0x3fff]
[    0.542670] pci 0000:00:02.2:   bridge window [mem 0xfd700000-0xfd7fffff]
[    0.543028] pci 0000:03:00.0: [8086:2723] type 00 class 0x028000
[    0.543081] pci 0000:03:00.0: reg 0x10: [mem 0xfd600000-0xfd603fff 64bit]
[    0.543253] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    0.543669] pci 0000:00:02.3: PCI bridge to [bus 03]
[    0.543673] pci 0000:00:02.3:   bridge window [mem 0xfd600000-0xfd6fffff]
[    0.543721] pci 0000:04:00.0: [10ec:522a] type 00 class 0xff0000
[    0.543736] pci 0000:04:00.0: reg 0x10: [mem 0xfd500000-0xfd500fff]
[    0.543841] pci 0000:04:00.0: supports D1 D2
[    0.543843] pci 0000:04:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.543949] pci 0000:00:02.4: PCI bridge to [bus 04]
[    0.543953] pci 0000:00:02.4:   bridge window [mem 0xfd500000-0xfd5fffff]
[    0.543999] pci 0000:05:00.0: [10ec:8168] type 00 class 0x020000
[    0.544016] pci 0000:05:00.0: reg 0x10: [io  0x2000-0x20ff]
[    0.544037] pci 0000:05:00.0: reg 0x18: [mem 0xfd404000-0xfd404fff 64bit]
[    0.544052] pci 0000:05:00.0: reg 0x20: [mem 0xfd400000-0xfd403fff 64bit]
[    0.544140] pci 0000:05:00.0: supports D1 D2
[    0.544142] pci 0000:05:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.544255] pci 0000:00:02.6: PCI bridge to [bus 05]
[    0.544259] pci 0000:00:02.6:   bridge window [io  0x2000-0x2fff]
[    0.544261] pci 0000:00:02.6:   bridge window [mem 0xfd400000-0xfd4fffff]
[    0.544313] pci 0000:06:00.0: [1002:1636] type 00 class 0x030000
[    0.544324] pci 0000:06:00.0: reg 0x10: [mem 0x460000000-0x46fffffff 64bit pref]
[    0.544332] pci 0000:06:00.0: reg 0x18: [mem 0x470000000-0x4701fffff 64bit pref]
[    0.544338] pci 0000:06:00.0: reg 0x20: [io  0x1000-0x10ff]
[    0.544345] pci 0000:06:00.0: reg 0x24: [mem 0xfd300000-0xfd37ffff]
[    0.544354] pci 0000:06:00.0: enabling Extended Tags
[    0.544364] pci 0000:06:00.0: BAR 0: assigned to efifb
[    0.544403] pci 0000:06:00.0: PME# supported from D1 D2 D3hot D3cold
[    0.544471] pci 0000:06:00.1: [1002:1637] type 00 class 0x040300
[    0.544479] pci 0000:06:00.1: reg 0x10: [mem 0xfd3c8000-0xfd3cbfff]
[    0.544499] pci 0000:06:00.1: enabling Extended Tags
[    0.544526] pci 0000:06:00.1: PME# supported from D1 D2 D3hot D3cold
[    0.544568] pci 0000:06:00.2: [1022:15df] type 00 class 0x108000
[    0.544580] pci 0000:06:00.2: reg 0x18: [mem 0xfd200000-0xfd2fffff]
[    0.544590] pci 0000:06:00.2: reg 0x24: [mem 0xfd3cc000-0xfd3cdfff]
[    0.544597] pci 0000:06:00.2: enabling Extended Tags
[    0.544668] pci 0000:06:00.3: [1022:1639] type 00 class 0x0c0330
[    0.544679] pci 0000:06:00.3: reg 0x10: [mem 0xfd000000-0xfd0fffff 64bit]
[    0.544702] pci 0000:06:00.3: enabling Extended Tags
[    0.544731] pci 0000:06:00.3: PME# supported from D0 D3hot D3cold
[    0.544776] pci 0000:06:00.4: [1022:1639] type 00 class 0x0c0330
[    0.544786] pci 0000:06:00.4: reg 0x10: [mem 0xfd100000-0xfd1fffff 64bit]
[    0.544809] pci 0000:06:00.4: enabling Extended Tags
[    0.544838] pci 0000:06:00.4: PME# supported from D0 D3hot D3cold
[    0.544883] pci 0000:06:00.5: [1022:15e2] type 00 class 0x048000
[    0.544891] pci 0000:06:00.5: reg 0x10: [mem 0xfd380000-0xfd3bffff]
[    0.544911] pci 0000:06:00.5: enabling Extended Tags
[    0.544937] pci 0000:06:00.5: PME# supported from D0 D3hot D3cold
[    0.544980] pci 0000:06:00.6: [1022:15e3] type 00 class 0x040300
[    0.544987] pci 0000:06:00.6: reg 0x10: [mem 0xfd3c0000-0xfd3c7fff]
[    0.545008] pci 0000:06:00.6: enabling Extended Tags
[    0.545034] pci 0000:06:00.6: PME# supported from D0 D3hot D3cold
[    0.545089] pci 0000:00:08.1: PCI bridge to [bus 06]
[    0.545092] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    0.545095] pci 0000:00:08.1:   bridge window [mem 0xfd000000-0xfd3fffff]
[    0.545098] pci 0000:00:08.1:   bridge window [mem 0x460000000-0x4701fffff 64bit pref]
[    0.545236] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 11 12 14 15) *0
[    0.545278] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 11 12 14 15) *0
[    0.545307] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 10 11 12 14 15) *0
[    0.545346] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 12 14 15) *0
[    0.545382] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15) *0
[    0.545409] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15) *0
[    0.545435] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 11 12 14 15) *0
[    0.545462] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 7 10 11 12 14 15) *0
[    0.545947] ACPI: EC: interrupt unblocked
[    0.545949] ACPI: EC: event unblocked
[    0.545959] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.545961] ACPI: EC: GPE=0x3
[    0.545962] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC initialization complete
[    0.545964] ACPI: \_SB_.PCI0.LPC0.EC0_: EC: Used to handle transactions and events
[    0.546009] iommu: Default domain type: Translated 
[    0.546017] pci 0000:06:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    0.546017] pci 0000:06:00.0: vgaarb: bridge control possible
[    0.546017] pci 0000:06:00.0: vgaarb: setting as boot device
[    0.546017] vgaarb: loaded
[    0.546017] SCSI subsystem initialized
[    0.546017] libata version 3.00 loaded.
[    0.546017] ACPI: bus type USB registered
[    0.546017] usbcore: registered new interface driver usbfs
[    0.546017] usbcore: registered new interface driver hub
[    0.546017] usbcore: registered new device driver usb
[    0.546017] Registered efivars operations
[    0.546017] PCI: Using ACPI for IRQ routing
[    0.547298] PCI: pci_cache_line_size set to 64 bytes
[    0.549223] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
[    0.549226] e820: reserve RAM buffer [mem 0x09c00000-0x0bffffff]
[    0.549228] e820: reserve RAM buffer [mem 0x09f00000-0x0bffffff]
[    0.549229] e820: reserve RAM buffer [mem 0xbd9de000-0xbfffffff]
[    0.549231] e820: reserve RAM buffer [mem 0xce000000-0xcfffffff]
[    0.549232] e820: reserve RAM buffer [mem 0x40f340000-0x40fffffff]
[    0.549267] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.549270] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.551660] clocksource: Switched to clocksource hpet
[    0.554000] pnp: PnP ACPI init
[    0.554158] system 00:00: [io  0x0f50-0x0f51] has been reserved
[    0.554162] system 00:00: [mem 0xfec00000-0xfec01fff] could not be reserved
[    0.554165] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.554167] system 00:00: [mem 0xf8000000-0xfbffffff] has been reserved
[    0.554173] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.554304] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.554335] system 00:02: [io  0x04d0-0x04d1] has been reserved
[    0.554337] system 00:02: [io  0x0530-0x0537] has been reserved
[    0.554339] system 00:02: [io  0x0400-0x0427] has been reserved
[    0.554340] system 00:02: [io  0x0430] has been reserved
[    0.554342] system 00:02: [io  0x0440-0x0447] has been reserved
[    0.554344] system 00:02: [io  0x0b00-0x0b1f] has been reserved
[    0.554346] system 00:02: [io  0x0b20-0x0b3f] has been reserved
[    0.554347] system 00:02: [io  0x0c00-0x0c01] has been reserved
[    0.554349] system 00:02: [io  0x0c14] has been reserved
[    0.554352] system 00:02: [io  0x0c50-0x0c52] has been reserved
[    0.554353] system 00:02: [io  0x0cd0-0x0cd1] has been reserved
[    0.554355] system 00:02: [io  0x0cd2-0x0cd3] has been reserved
[    0.554357] system 00:02: [io  0x0cd4-0x0cd5] has been reserved
[    0.554359] system 00:02: [io  0x0cd6-0x0cd7] has been reserved
[    0.554361] system 00:02: [io  0x0cd8-0x0cdf] has been reserved
[    0.554362] system 00:02: [io  0x0cf9] could not be reserved
[    0.554364] system 00:02: [io  0x8100-0x81ff window] has been reserved
[    0.554366] system 00:02: [io  0x8200-0x82ff window] has been reserved
[    0.554369] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.554409] system 00:03: [mem 0x000e0000-0x000fffff] could not be reserved
[    0.554411] system 00:03: [mem 0xff000000-0xffffffff] has been reserved
[    0.554413] system 00:03: [mem 0xfec10000-0xfec1001f] has been reserved
[    0.554415] system 00:03: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.554417] system 00:03: [mem 0xfed61000-0xfed613ff] has been reserved
[    0.554419] system 00:03: [mem 0xfed80000-0xfed80fff] has been reserved
[    0.554422] system 00:03: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.554434] pnp 00:04: Plug and Play ACPI device, IDs LEN0071 PNP0303 (active)
[    0.554445] pnp 00:05: Plug and Play ACPI device, IDs LEN2064 PNP0f13 (active)
[    0.554564] pnp: PnP ACPI: found 6 devices
[    0.562937] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.562999] NET: Registered protocol family 2
[    0.563225] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
[    0.563412] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.563852] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
[    0.564000] TCP: Hash tables configured (established 131072 bind 65536)
[    0.564094] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.564183] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    0.564293] NET: Registered protocol family 1
[    0.564325] pci 0000:00:02.3: bridge window [io  0x1000-0x0fff] to [bus 03] add_size 1000
[    0.564336] pci 0000:00:02.3: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 03] add_size 200000 add_align 100000
[    0.564376] pci 0000:00:02.3: BAR 15: assigned [mem 0x430000000-0x4301fffff 64bit pref]
[    0.564391] pci 0000:00:02.3: BAR 13: assigned [io  0x4000-0x4fff]
[    0.564399] pci 0000:00:02.1: PCI bridge to [bus 01]
[    0.564418] pci 0000:00:02.1:   bridge window [mem 0xfd800000-0xfd8fffff]
[    0.564429] pci 0000:00:02.2: PCI bridge to [bus 02]
[    0.564435] pci 0000:00:02.2:   bridge window [io  0x3000-0x3fff]
[    0.564443] pci 0000:00:02.2:   bridge window [mem 0xfd700000-0xfd7fffff]
[    0.564452] pci 0000:00:02.3: PCI bridge to [bus 03]
[    0.564458] pci 0000:00:02.3:   bridge window [io  0x4000-0x4fff]
[    0.564465] pci 0000:00:02.3:   bridge window [mem 0xfd600000-0xfd6fffff]
[    0.564471] pci 0000:00:02.3:   bridge window [mem 0x430000000-0x4301fffff 64bit pref]
[    0.564481] pci 0000:00:02.4: PCI bridge to [bus 04]
[    0.564487] pci 0000:00:02.4:   bridge window [mem 0xfd500000-0xfd5fffff]
[    0.564497] pci 0000:00:02.6: PCI bridge to [bus 05]
[    0.564502] pci 0000:00:02.6:   bridge window [io  0x2000-0x2fff]
[    0.564509] pci 0000:00:02.6:   bridge window [mem 0xfd400000-0xfd4fffff]
[    0.564521] pci 0000:00:08.1: PCI bridge to [bus 06]
[    0.564526] pci 0000:00:08.1:   bridge window [io  0x1000-0x1fff]
[    0.564533] pci 0000:00:08.1:   bridge window [mem 0xfd000000-0xfd3fffff]
[    0.564539] pci 0000:00:08.1:   bridge window [mem 0x460000000-0x4701fffff 64bit pref]
[    0.564550] pci_bus 0000:00: resource 4 [mem 0x000a0000-0x000bffff window]
[    0.564556] pci_bus 0000:00: resource 5 [mem 0x000c0000-0x000c1fff window]
[    0.564562] pci_bus 0000:00: resource 6 [mem 0x000c2000-0x000c3fff window]
[    0.564567] pci_bus 0000:00: resource 7 [mem 0x000c4000-0x000c5fff window]
[    0.564573] pci_bus 0000:00: resource 8 [mem 0x000c6000-0x000c7fff window]
[    0.564578] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000c9fff window]
[    0.564583] pci_bus 0000:00: resource 10 [mem 0x000ca000-0x000cbfff window]
[    0.564589] pci_bus 0000:00: resource 11 [mem 0x000cc000-0x000cdfff window]
[    0.564594] pci_bus 0000:00: resource 12 [mem 0x000ce000-0x000cffff window]
[    0.564600] pci_bus 0000:00: resource 13 [mem 0x000d0000-0x000d1fff window]
[    0.564605] pci_bus 0000:00: resource 14 [mem 0x000d2000-0x000d3fff window]
[    0.564611] pci_bus 0000:00: resource 15 [mem 0x000d4000-0x000d5fff window]
[    0.564616] pci_bus 0000:00: resource 16 [mem 0x000d6000-0x000d7fff window]
[    0.564621] pci_bus 0000:00: resource 17 [mem 0x000d8000-0x000d9fff window]
[    0.564627] pci_bus 0000:00: resource 18 [mem 0x000da000-0x000dbfff window]
[    0.564632] pci_bus 0000:00: resource 19 [mem 0x000dc000-0x000ddfff window]
[    0.564638] pci_bus 0000:00: resource 20 [mem 0x000de000-0x000dffff window]
[    0.564643] pci_bus 0000:00: resource 21 [mem 0x000e0000-0x000e1fff window]
[    0.564648] pci_bus 0000:00: resource 22 [mem 0x000e2000-0x000e3fff window]
[    0.564654] pci_bus 0000:00: resource 23 [mem 0x000e4000-0x000e5fff window]
[    0.564659] pci_bus 0000:00: resource 24 [mem 0x000e6000-0x000e7fff window]
[    0.564664] pci_bus 0000:00: resource 25 [mem 0x000e8000-0x000e9fff window]
[    0.564670] pci_bus 0000:00: resource 26 [mem 0x000ea000-0x000ebfff window]
[    0.564675] pci_bus 0000:00: resource 27 [mem 0x000ec000-0x000edfff window]
[    0.564681] pci_bus 0000:00: resource 28 [mem 0x000ee000-0x000effff window]
[    0.564686] pci_bus 0000:00: resource 29 [mem 0xd0000000-0xf7ffffff window]
[    0.564692] pci_bus 0000:00: resource 30 [mem 0xfc000000-0xfdffffff window]
[    0.564697] pci_bus 0000:00: resource 31 [mem 0x430000000-0xffffffffff window]
[    0.564704] pci_bus 0000:00: resource 32 [io  0x0000-0x0cf7 window]
[    0.564709] pci_bus 0000:00: resource 33 [io  0x0d00-0xffff window]
[    0.564715] pci_bus 0000:01: resource 1 [mem 0xfd800000-0xfd8fffff]
[    0.564720] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
[    0.564725] pci_bus 0000:02: resource 1 [mem 0xfd700000-0xfd7fffff]
[    0.564731] pci_bus 0000:03: resource 0 [io  0x4000-0x4fff]
[    0.564736] pci_bus 0000:03: resource 1 [mem 0xfd600000-0xfd6fffff]
[    0.564741] pci_bus 0000:03: resource 2 [mem 0x430000000-0x4301fffff 64bit pref]
[    0.564748] pci_bus 0000:04: resource 1 [mem 0xfd500000-0xfd5fffff]
[    0.564753] pci_bus 0000:05: resource 0 [io  0x2000-0x2fff]
[    0.564758] pci_bus 0000:05: resource 1 [mem 0xfd400000-0xfd4fffff]
[    0.564763] pci_bus 0000:06: resource 0 [io  0x1000-0x1fff]
[    0.564768] pci_bus 0000:06: resource 1 [mem 0xfd000000-0xfd3fffff]
[    0.564773] pci_bus 0000:06: resource 2 [mem 0x460000000-0x4701fffff 64bit pref]
[    0.565774] pci 0000:06:00.1: D0 power state depends on 0000:06:00.0
[    0.565963] PCI: CLS 32 bytes, default 64
[    0.565999] Unpacking initramfs...
[    0.636174] Freeing initrd memory: 7516K
[    0.636256] pci 0000:00:00.2: AMD-Vi: Unable to read/write to IOMMU perf counter.
[    0.636363] pci 0000:00:00.2: can't derive routing for PCI INT A
[    0.636365] pci 0000:00:00.2: PCI INT A: not connected
[    0.636396] pci 0000:00:01.0: Adding to iommu group 0
[    0.636412] pci 0000:00:02.0: Adding to iommu group 1
[    0.636419] pci 0000:00:02.1: Adding to iommu group 2
[    0.636428] pci 0000:00:02.2: Adding to iommu group 3
[    0.636439] pci 0000:00:02.3: Adding to iommu group 4
[    0.636446] pci 0000:00:02.4: Adding to iommu group 5
[    0.636454] pci 0000:00:02.6: Adding to iommu group 6
[    0.636467] pci 0000:00:08.0: Adding to iommu group 7
[    0.636474] pci 0000:00:08.1: Adding to iommu group 7
[    0.636485] pci 0000:00:14.0: Adding to iommu group 8
[    0.636492] pci 0000:00:14.3: Adding to iommu group 8
[    0.636516] pci 0000:00:18.0: Adding to iommu group 9
[    0.636523] pci 0000:00:18.1: Adding to iommu group 9
[    0.636530] pci 0000:00:18.2: Adding to iommu group 9
[    0.636537] pci 0000:00:18.3: Adding to iommu group 9
[    0.636544] pci 0000:00:18.4: Adding to iommu group 9
[    0.636551] pci 0000:00:18.5: Adding to iommu group 9
[    0.636558] pci 0000:00:18.6: Adding to iommu group 9
[    0.636564] pci 0000:00:18.7: Adding to iommu group 9
[    0.636573] pci 0000:01:00.0: Adding to iommu group 10
[    0.636592] pci 0000:02:00.0: Adding to iommu group 11
[    0.636600] pci 0000:02:00.1: Adding to iommu group 11
[    0.636610] pci 0000:02:00.2: Adding to iommu group 11
[    0.636618] pci 0000:02:00.3: Adding to iommu group 11
[    0.636626] pci 0000:02:00.4: Adding to iommu group 11
[    0.636634] pci 0000:03:00.0: Adding to iommu group 12
[    0.636642] pci 0000:04:00.0: Adding to iommu group 13
[    0.636650] pci 0000:05:00.0: Adding to iommu group 14
[    0.636663] pci 0000:06:00.0: Adding to iommu group 7
[    0.636667] pci 0000:06:00.1: Adding to iommu group 7
[    0.636671] pci 0000:06:00.2: Adding to iommu group 7
[    0.636675] pci 0000:06:00.3: Adding to iommu group 7
[    0.636679] pci 0000:06:00.4: Adding to iommu group 7
[    0.636685] pci 0000:06:00.5: Adding to iommu group 7
[    0.636689] pci 0000:06:00.6: Adding to iommu group 7
[    0.638397] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
[    0.638406] pci 0000:00:00.2: AMD-Vi: Extended features (0x206d73ef22254ade):
[    0.638408]  PPR X2APIC NX GT IA GA PC GA_vAPIC
[    0.638413] AMD-Vi: Interrupt remapping enabled
[    0.638414] AMD-Vi: Virtual APIC enabled
[    0.638415] AMD-Vi: X2APIC enabled
[    0.638585] AMD-Vi: Lazy IO/TLB flushing enabled
[    0.639644] amd_uncore: 4  amd_df counters detected
[    0.639649] amd_uncore: 6  amd_l3 counters detected
[    0.640638] LVT offset 0 assigned for vector 0x400
[    0.641083] perf: AMD IBS detected (0x000003ff)
[    0.641321] Initialise system trusted keyrings
[    0.641338] Key type blacklist registered
[    0.641420] workingset: timestamp_bits=61 max_order=22 bucket_order=0
[    0.641904] fuse: init (API version 7.33)
[    0.641978] 9p: Installing v9fs 9p2000 file system support
[    0.642018] Key type asymmetric registered
[    0.642020] Asymmetric key parser 'x509' registered
[    0.642025] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    0.642028] io scheduler mq-deadline registered
[    0.643119] pcieport 0000:00:02.1: PME: Signaling with IRQ 26
[    0.643224] pcieport 0000:00:02.2: PME: Signaling with IRQ 27
[    0.643319] pcieport 0000:00:02.3: PME: Signaling with IRQ 28
[    0.643332] pcieport 0000:00:02.3: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.643545] pcieport 0000:00:02.4: PME: Signaling with IRQ 29
[    0.643640] pcieport 0000:00:02.6: PME: Signaling with IRQ 30
[    0.643733] pcieport 0000:00:08.1: PME: Signaling with IRQ 31
[    0.643805] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    0.643826] efifb: probing for efifb
[    0.643887] efifb: framebuffer at 0x460000000, using 8128k, total 8128k
[    0.643890] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    0.643891] efifb: scrolling: redraw
[    0.643893] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    0.646673] Console: switching to colour frame buffer device 240x67
[    0.649357] fb0: EFI VGA frame buffer device
[    0.649396] Monitor-Mwait will be used to enter C-1 state
[    0.649411] ACPI: \_SB_.PLTF.C000: Found 3 idle states
[    0.649600] ACPI: \_SB_.PLTF.C001: Found 3 idle states
[    0.649865] ACPI: \_SB_.PLTF.C002: Found 3 idle states
[    0.650057] ACPI: \_SB_.PLTF.C003: Found 3 idle states
[    0.650305] ACPI: \_SB_.PLTF.C004: Found 3 idle states
[    0.650599] ACPI: \_SB_.PLTF.C005: Found 3 idle states
[    0.650785] ACPI: \_SB_.PLTF.C006: Found 3 idle states
[    0.651108] ACPI: \_SB_.PLTF.C007: Found 3 idle states
[    0.651297] ACPI: \_SB_.PLTF.C008: Found 3 idle states
[    0.651475] ACPI: \_SB_.PLTF.C009: Found 3 idle states
[    0.651578] ACPI: \_SB_.PLTF.C00A: Found 3 idle states
[    0.651720] ACPI: \_SB_.PLTF.C00B: Found 3 idle states
[    0.651939] ACPI: \_SB_.PLTF.C00C: Found 3 idle states
[    0.652166] ACPI: \_SB_.PLTF.C00D: Found 3 idle states
[    0.652417] ACPI: \_SB_.PLTF.C00E: Found 3 idle states
[    0.652682] ACPI: \_SB_.PLTF.C00F: Found 3 idle states
[    0.660644] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.660876] serial 0000:02:00.1: enabling device (0000 -> 0003)
[    0.681361] 0000:02:00.1: ttyS0 at I/O 0x3200 (irq = 32, base_baud = 115200) is a 16550A
[    0.681502] serial 0000:02:00.2: enabling device (0000 -> 0003)
[    0.702102] 0000:02:00.2: ttyS1 at I/O 0x3100 (irq = 33, base_baud = 115200) is a 16550A
[    0.702399] Linux agpgart interface v0.103
[    0.703103] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    0.703661] [drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
[    0.703904] [drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
[    0.704682] checking generic (460000000 7f0000) vs hw (0 0)
[    0.704730] platform vkms: [drm] fb1: vkmsdrmfb frame buffer device
[    0.706276] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[    0.706335] SCSI Media Changer driver v0.25 
[    0.706457] tun: Universal TUN/TAP device driver, 1.6
[    0.706566] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.706591] ehci-pci: EHCI PCI platform driver
[    0.706805] ehci-pci 0000:02:00.4: EHCI Host Controller
[    0.706821] ehci-pci 0000:02:00.4: new USB bus registered, assigned bus number 1
[    0.706891] ehci-pci 0000:02:00.4: irq 35, io mem 0xfd718000
[    0.721478] ehci-pci 0000:02:00.4: USB 0.0 started, EHCI 1.00
[    0.721630] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.11
[    0.721687] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.721735] usb usb1: Product: EHCI Host Controller
[    0.721768] usb usb1: Manufacturer: Linux 5.11.0-rc2+ ehci_hcd
[    0.723310] usb usb1: SerialNumber: 0000:02:00.4
[    0.724299] hub 1-0:1.0: USB hub found
[    0.724830] hub 1-0:1.0: 1 port detected
[    0.725433] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.725951] ohci-pci: OHCI PCI platform driver
[    0.726572] xhci_hcd 0000:06:00.3: xHCI Host Controller
[    0.727090] xhci_hcd 0000:06:00.3: new USB bus registered, assigned bus number 2
[    0.727681] xhci_hcd 0000:06:00.3: hcc params 0x0268ffe5 hci version 0x110 quirks 0x0000000000000410
[    0.728443] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.11
[    0.728967] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.729492] usb usb2: Product: xHCI Host Controller
[    0.730017] usb usb2: Manufacturer: Linux 5.11.0-rc2+ xhci-hcd
[    0.730548] usb usb2: SerialNumber: 0000:06:00.3
[    0.731275] hub 2-0:1.0: USB hub found
[    0.731813] hub 2-0:1.0: 4 ports detected
[    0.732481] xhci_hcd 0000:06:00.3: xHCI Host Controller
[    0.733005] xhci_hcd 0000:06:00.3: new USB bus registered, assigned bus number 3
[    0.733545] xhci_hcd 0000:06:00.3: Host supports USB 3.1 Enhanced SuperSpeed
[    0.734084] usb usb3: We don't know the algorithms for LPM for this host, disabling LPM.
[    0.734630] usb usb3: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.11
[    0.735165] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.735701] usb usb3: Product: xHCI Host Controller
[    0.736232] usb usb3: Manufacturer: Linux 5.11.0-rc2+ xhci-hcd
[    0.736771] usb usb3: SerialNumber: 0000:06:00.3
[    0.737499] hub 3-0:1.0: USB hub found
[    0.738042] hub 3-0:1.0: 2 ports detected
[    0.738759] xhci_hcd 0000:06:00.4: xHCI Host Controller
[    0.739285] xhci_hcd 0000:06:00.4: new USB bus registered, assigned bus number 4
[    0.739904] xhci_hcd 0000:06:00.4: hcc params 0x0268ffe5 hci version 0x110 quirks 0x0000000000000410
[    0.740703] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.11
[    0.741273] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.741842] usb usb4: Product: xHCI Host Controller
[    0.742412] usb usb4: Manufacturer: Linux 5.11.0-rc2+ xhci-hcd
[    0.742994] usb usb4: SerialNumber: 0000:06:00.4
[    0.743773] hub 4-0:1.0: USB hub found
[    0.744378] hub 4-0:1.0: 4 ports detected
[    0.745135] xhci_hcd 0000:06:00.4: xHCI Host Controller
[    0.745750] xhci_hcd 0000:06:00.4: new USB bus registered, assigned bus number 5
[    0.746361] xhci_hcd 0000:06:00.4: Host supports USB 3.1 Enhanced SuperSpeed
[    0.746991] usb usb5: We don't know the algorithms for LPM for this host, disabling LPM.
[    0.747640] usb usb5: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.11
[    0.748283] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.748939] usb usb5: Product: xHCI Host Controller
[    0.749595] usb usb5: Manufacturer: Linux 5.11.0-rc2+ xhci-hcd
[    0.750241] usb usb5: SerialNumber: 0000:06:00.4
[    0.751083] hub 5-0:1.0: USB hub found
[    0.751729] hub 5-0:1.0: 2 ports detected
[    0.752490] usbcore: registered new interface driver usb-storage
[    0.753123] usbcore: registered new interface driver usbserial_generic
[    0.753755] usbserial: USB Serial support registered for generic
[    0.754388] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.759117] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.760173] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.760971] mousedev: PS/2 mouse device common for all mice
[    0.761667] rtc_cmos 00:01: RTC can wake from S4
[    0.762609] rtc_cmos 00:01: registered as rtc0
[    0.764037] rtc_cmos 00:01: setting system clock to 2021-01-04T22:47:08 UTC (1609800428)
[    0.765018] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    0.765853] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    0.766341] ledtrig-cpu: registered to indicate activity on CPUs
[    0.767262] hid: raw HID events driver (C) Jiri Kosina
[    0.767973] gre: GRE over IPv4 demultiplexor driver
[    0.768601] ip_gre: GRE over IPv4 tunneling driver
[    0.769428] NET: Registered protocol family 10
[    0.776871] Segment Routing with IPv6
[    0.777528] mip6: Mobile IPv6
[    0.778143] NET: Registered protocol family 17
[    0.778785] 9pnet: Installing 9P2000 support
[    0.781387] microcode: CPU0: patch_level=0x08600106
[    0.782204] microcode: CPU1: patch_level=0x08600106
[    0.783020] microcode: CPU2: patch_level=0x08600106
[    0.783639] microcode: CPU3: patch_level=0x08600106
[    0.784293] microcode: CPU4: patch_level=0x08600106
[    0.785631] microcode: CPU5: patch_level=0x08600106
[    0.786397] microcode: CPU6: patch_level=0x08600106
[    0.787678] microcode: CPU7: patch_level=0x08600106
[    0.788282] microcode: CPU8: patch_level=0x08600106
[    0.789113] microcode: CPU9: patch_level=0x08600106
[    0.790282] microcode: CPU10: patch_level=0x08600106
[    0.791501] microcode: CPU11: patch_level=0x08600106
[    0.792196] microcode: CPU12: patch_level=0x08600106
[    0.793008] microcode: CPU13: patch_level=0x08600106
[    0.793575] microcode: CPU14: patch_level=0x08600106
[    0.794730] microcode: CPU15: patch_level=0x08600106
[    0.795249] microcode: Microcode Update Driver: v2.2.
[    0.795942] resctrl: L3 allocation detected
[    0.796952] resctrl: L3DATA allocation detected
[    0.797461] resctrl: L3CODE allocation detected
[    0.797945] resctrl: MB allocation detected
[    0.798426] resctrl: L3 monitoring detected
[    0.798909] IPI shorthand broadcast: enabled
[    0.799500] registered taskstats version 1
[    0.799983] Loading compiled-in X.509 certificates
[    0.800732] printk: console [netcon0] enabled
[    0.801225] netconsole: network logging started
[    0.801853] Unstable clock detected, switching default tracing clock to "global"
               If you want to keep using the local clock, then add:
                 "trace_clock=local"
               on the kernel command line
[    0.805030] Freeing unused decrypted memory: 2036K
[    0.805724] Freeing unused kernel image (initmem) memory: 1420K
[    0.845489] Write protecting the kernel read-only data: 20480k
[    0.847969] Freeing unused kernel image (text/rodata gap) memory: 2036K
[    0.849128] Freeing unused kernel image (rodata/data gap) memory: 1968K
[    0.850601] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    0.851095] Run /init as init process
[    0.851565]   with arguments:
[    0.852028]     /init
[    0.852481]   with environment:
[    0.852928]     HOME=/
[    0.853374]     TERM=linux
[    0.853814]     BOOT_IMAGE=/boot/vmlinuz-5.11.0-rc2+
[    0.922417] nvme nvme0: pci function 0000:01:00.0
[    0.933861] nvme nvme0: missing or invalid SUBNQN field.
[    0.934329] nvme nvme0: Shutdown timeout set to 8 seconds
[    0.951690] nvme nvme0: 16/0/0 default/read/poll queues
[    0.955654]  nvme0n1: p1 p2 p3
[    0.989752] PM: Image not found (code -22)
[    1.028181] EXT4-fs (nvme0n1p2): mounted filesystem with ordered data mode. Opts: (null). Quota mode: disabled.
[    1.069345] usb 2-3: new full-speed USB device number 2 using xhci_hcd
[    1.085302] usb 4-3: new full-speed USB device number 2 using xhci_hcd
[    1.198099] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input3
[    1.198900] ACPI: Power Button [PWRB]
[    1.199522] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input4
[    1.200528] acpi_cpufreq: overriding BIOS provided _PSD data
[    1.207630] ACPI: Video Device [VGA] (multi-head: yes  rom: no  post: no)
[    1.210361] acpi device:1a: registered as cooling_device16
[    1.212682] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:19/LNXVIDEO:00/input/input5
[    1.216562] ACPI: AC Adapter [AC] (on-line)
[    1.216767] battery: ACPI: Battery Slot [BAT0] (battery present)
[    1.217315] ACPI: Lid Switch [LID]
[    1.217408] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input6
[    1.218871] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    1.229882] r8169 0000:02:00.0: can't disable ASPM; OS doesn't have ASPM control
[    1.229955] ccp 0000:06:00.2: enabling device (0000 -> 0002)
[    1.235968] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
[    1.236934] ACPI: Sleep Button [SLPB]
[    1.238383] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
[    1.240600] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input7
[    1.242688] acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    1.243089] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
[    1.247135] ccp 0000:06:00.2: tee enabled
[    1.247544] rtsx_pci 0000:04:00.0: enabling device (0000 -> 0002)
[    1.250906] libphy: r8169: probed
[    1.251950] ccp 0000:06:00.2: psp enabled
[    1.254378] r8169 0000:02:00.0 eth0: RTL8168ep/8111ep, 00:2b:67:21:2e:1b, XID 502, IRQ 76
[    1.257486] ACPI: Power Button [PWRF]
[    1.259165] r8169 0000:02:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
[    1.264141] usb 2-3: New USB device found, idVendor=058f, idProduct=9540, bcdDevice= 1.20
[    1.266327] r8169 0000:05:00.0: can't disable ASPM; OS doesn't have ASPM control
[    1.268735] usb 2-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    1.273482] usb 2-3: Product: EMV Smartcard Reader
[    1.275806] usb 2-3: Manufacturer: Generic
[    1.278130] usb 4-3: New USB device found, idVendor=06cb, idProduct=00bd, bcdDevice= 0.00
[    1.280509] usb 4-3: New USB device strings: Mfr=0, Product=0, SerialNumber=1
[    1.282914] usb 4-3: SerialNumber: 6e11c6fafca5
[    1.285837] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    1.286041] input: PC Speaker as /devices/platform/pcspkr/input/input8
[    1.288321] libphy: r8169: probed
[    1.295227] acpi PNP0C14:04: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    1.297365] r8169 0000:05:00.0 eth1: RTL8168h/8111h, 00:2b:67:21:2e:1a, XID 541, IRQ 80
[    1.312666] acpi PNP0C14:05: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[    1.316597] pstore: Using crash dump compression: deflate
[    1.316615] pstore: Registered efi as persistent store backend
[    1.318538] r8169 0000:05:00.0 eth1: jumbo features [frames: 9194 bytes, tx checksumming: ko]
[    1.330780] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840 ms ovfl timer
[    1.334040] RAPL PMU: hw unit of domain package 2^-16 Joules
[    1.337719] Non-volatile memory driver v1.3
[    1.342234] cryptd: max_cpu_qlen set to 1000
[    1.365064] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[    1.365379] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[    1.366706] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    1.368810] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO address
[    1.371768] thinkpad_acpi: http://ibm-acpi.sf.net/
[    1.375142] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
[    1.377943] thinkpad_acpi: ThinkPad BIOS R1BET58W(1.27 ), EC R1BHT58W
[    1.387836] thinkpad_acpi: Lenovo ThinkPad, model 20Y2MMMMCC
[    1.392631] thinkpad_acpi: radio switch found; radios are enabled
[    1.395704] thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
[    1.398600] thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
[    1.409386] AVX2 version of gcm_enc/dec engaged.
[    1.409395] AES CTR mode by8 optimization enabled
[    1.415437] thinkpad_acpi: Standard ACPI backlight interface available, not loading native one
[    1.435158] snd_hda_intel 0000:06:00.1: enabling device (0000 -> 0002)
[    1.435399] snd_hda_intel 0000:06:00.1: Handle vga_switcheroo audio client
[    1.435633] snd_hda_intel 0000:06:00.6: enabling device (0000 -> 0002)
[    1.449949] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:06:00.1/sound/card0/input10
[    1.452737] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    1.452931] input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:06:00.1/sound/card0/input11
[    1.456166] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    1.458823] input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:08.1/0000:06:00.1/sound/card0/input12
[    1.461519] cfg80211: failed to load regulatory.db
[    1.471162] thinkpad_acpi: battery 1 registered (start 95, stop 100)
[    1.471177] battery: new extension: ThinkPad Battery Extension
[    1.471554] battery: extension unregistered: ThinkPad Battery Extension
[    1.491520] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC257: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
[    1.491530] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    1.491533] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
[    1.491537] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[    1.491538] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[    1.510517] Intel(R) Wireless WiFi driver for Linux
[    1.510858] iwlwifi 0000:03:00.0: enabling device (0000 -> 0002)
[    1.517305] ACPI Error: No handler for Region [ECSI] (000000004f5e137c) [EmbeddedControl] (20201113/evregion-128)
[    1.517318] ACPI Error: Region EmbeddedControl (ID=3) has no handler (20201113/exfldio-261)
[    1.517326] ACPI Error: Aborting method \_SB.UBTC.ECRD due to previous error (AE_NOT_EXIST) (20201113/psparse-529)
[    1.517340] ACPI Error: Aborting method \_SB.UBTC._DSM due to previous error (AE_NOT_EXIST) (20201113/psparse-529)
[    1.517359] ACPI: \_SB_.UBTC: failed to evaluate _DSM (0x6)
[    1.517367] ucsi_acpi USBC000:00: ucsi_acpi_dsm: failed to evaluate _DSM 2
[    1.519199] iwlwifi 0000:03:00.0: Direct firmware load for iwlwifi-cc-a0-59.ucode failed with error -2
[    1.519217] iwlwifi 0000:03:00.0: Direct firmware load for iwlwifi-cc-a0-58.ucode failed with error -2
[    1.519232] iwlwifi 0000:03:00.0: Direct firmware load for iwlwifi-cc-a0-57.ucode failed with error -2
[    1.519244] iwlwifi 0000:03:00.0: Direct firmware load for iwlwifi-cc-a0-56.ucode failed with error -2
[    1.520529] iwlwifi 0000:03:00.0: api flags index 2 larger than supported by driver
[    1.546865] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:08.1/0000:06:00.6/sound/card1/input13
[    1.548760] iwlwifi 0000:03:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.3.35.22
[    1.551445] input: HD-Audio Generic Headphone as /devices/pci0000:00/0000:00:08.1/0000:06:00.6/sound/card1/input14
[    1.554199] iwlwifi 0000:03:00.0: Found debug destination: EXTERNAL_DRAM
[    1.564779] iwlwifi 0000:03:00.0: Found debug configuration: 0
[    1.565413] iwlwifi 0000:03:00.0: loaded firmware version 55.d9698065.0 cc-a0-55.ucode op_mode iwlmvm
[    1.607653] [drm] amdgpu kernel modesetting enabled.
[    1.611353] Virtual CRAT table created for CPU
[    1.614502] amdgpu: Topology: Add CPU node
[    1.617348] checking generic (460000000 7f0000) vs hw (460000000 10000000)
[    1.620359] fb0: switching to amdgpudrmfb from EFI VGA
[    1.627593] Console: switching to colour dummy device 80x25
[    1.627703] amdgpu 0000:06:00.0: vgaarb: deactivate vga console
[    1.627834] amdgpu 0000:06:00.0: enabling device (0006 -> 0007)
[    1.627988] [drm] initializing kernel modesetting (RENOIR 0x1002:0x1636 0x17AA:0x5099 0xD1).
[    1.628001] amdgpu 0000:06:00.0: amdgpu: Trusted Memory Zone (TMZ) feature disabled as experimental (default)
[    1.646465] thinkpad_acpi: ThinkPad ACPI Extras v0.26
[    1.646486] thinkpad_acpi: http://ibm-acpi.sf.net/
[    1.646490] thinkpad_acpi: ThinkPad BIOS R1BET58W(1.27 ), EC R1BHT58W
[    1.646495] thinkpad_acpi: Lenovo ThinkPad, model 20Y2MMMMCC
[    1.647513] thinkpad_acpi: radio switch found; radios are enabled
[    1.647543] thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
[    1.647550] thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
[    1.654879] [drm] register mmio base: 0xFD300000
[    1.654894] [drm] register mmio size: 524288
[    1.654902] [drm] PCIE atomic ops is not supported
[    1.657135] [drm] add ip block number 0 <soc15_common>
[    1.657141] [drm] add ip block number 1 <gmc_v9_0>
[    1.657145] [drm] add ip block number 2 <vega10_ih>
[    1.657150] [drm] add ip block number 3 <psp>
[    1.657154] [drm] add ip block number 4 <smu>
[    1.657158] [drm] add ip block number 5 <gfx_v9_0>
[    1.657163] [drm] add ip block number 6 <sdma_v4_0>
[    1.657167] [drm] add ip block number 7 <dm>
[    1.657171] [drm] add ip block number 8 <vcn_v2_0>
[    1.657175] [drm] add ip block number 9 <jpeg_v2_0>
[    1.657209] amdgpu 0000:06:00.0: amdgpu: Fetched VBIOS from VFCT
[    1.657522] amdgpu: ATOM BIOS: 113-RENOIR-026
[    1.659723] [drm] VCN decode is enabled in VM mode
[    1.659737] [drm] VCN encode is enabled in VM mode
[    1.659742] [drm] JPEG decode is enabled in VM mode
[    1.659798] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[    1.659813] amdgpu 0000:06:00.0: amdgpu: VRAM: 512M 0x000000F400000000 - 0x000000F41FFFFFFF (512M used)
[    1.659825] amdgpu 0000:06:00.0: amdgpu: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
[    1.659833] amdgpu 0000:06:00.0: amdgpu: AGP: 267419648M 0x000000F800000000 - 0x0000FFFFFFFFFFFF
[    1.659846] [drm] Detected VRAM RAM=512M, BAR=512M
[    1.659851] [drm] RAM width 128bits DDR4
[    1.660079] [TTM] Zone  kernel: Available graphics memory: 7794408 KiB
[    1.660090] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[    1.660190] [drm] amdgpu: 512M of VRAM memory ready
[    1.660197] [drm] amdgpu: 3072M of GTT memory ready.
[    1.660204] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    1.660342] [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
[    1.661109] amdgpu 0000:06:00.0: Direct firmware load for amdgpu/renoir_ta.bin failed with error -2
[    1.661121] amdgpu 0000:06:00.0: amdgpu: psp v12.0: Failed to load firmware "amdgpu/renoir_ta.bin"
[    1.668199] [drm] Loading DMUB firmware via PSP: version=0x00000000
[    1.668837] [drm] Found VCN firmware Version ENC: 1.7 DEC: 4 VEP: 0 Revision: 17
[    1.668855] [drm] PSP loading VCN firmware
[    1.715597] kvm: Nested Virtualization enabled
[    1.715633] SVM: kvm: Nested Paging enabled
[    1.715638] SVM: Virtual VMLOAD VMSAVE supported
[    1.715641] SVM: Virtual GIF supported
[    1.725066] EDAC MC: Ver: 3.0.0
[    1.725965] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    1.729003] MCE: In-kernel MCE decoding enabled.
[    1.733041] thinkpad_acpi: Standard ACPI backlight interface available, not loading native one
[    1.736247] EDAC amd64: F17h_M60h detected (node 0).
[    1.736282] EDAC DEBUG: reserve_mc_sibling_devs: F0: 0000:00:18.0
[    1.736288] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    1.736293] EDAC DEBUG: reserve_mc_sibling_devs: F6: 0000:00:18.6
[    1.736297] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    1.736303] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000430000000
[    1.736325] EDAC DEBUG: read_umc_base_mask:   DCSB0[0]=0x00000001 reg: 0x50000
[    1.736334] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[0]=0x00000000 reg: 0x50010
[    1.736342] EDAC DEBUG: read_umc_base_mask:   DCSB0[1]=0x00000000 reg: 0x50004
[    1.736349] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[1]=0x00000000 reg: 0x50014
[    1.736356] EDAC DEBUG: read_umc_base_mask:   DCSB0[2]=0x00000000 reg: 0x50008
[    1.736364] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[2]=0x00000000 reg: 0x50018
[    1.736371] EDAC DEBUG: read_umc_base_mask:   DCSB0[3]=0x00000000 reg: 0x5000c
[    1.736378] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[3]=0x00000000 reg: 0x5001c
[    1.736385] EDAC DEBUG: read_umc_base_mask:   DCSM0[0]=0x01fffffe reg: 0x50020
[    1.736393] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[0]=0x00000000 reg: 0x50028
[    1.736400] EDAC DEBUG: read_umc_base_mask:   DCSM0[1]=0x00000000 reg: 0x50024
[    1.736407] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[1]=0x00000000 reg: 0x5002c
[    1.736414] EDAC DEBUG: read_umc_base_mask:   DCSB1[0]=0x00000001 reg: 0x150000
[    1.736421] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[0]=0x00000000 reg: 0x150010
[    1.736429] EDAC DEBUG: read_umc_base_mask:   DCSB1[1]=0x00000000 reg: 0x150004
[    1.736436] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[1]=0x00000000 reg: 0x150014
[    1.736443] EDAC DEBUG: read_umc_base_mask:   DCSB1[2]=0x00000000 reg: 0x150008
[    1.736450] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[2]=0x00000000 reg: 0x150018
[    1.736457] EDAC DEBUG: read_umc_base_mask:   DCSB1[3]=0x00000000 reg: 0x15000c
[    1.736464] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[3]=0x00000000 reg: 0x15001c
[    1.736472] EDAC DEBUG: read_umc_base_mask:   DCSM1[0]=0x01fffffe reg: 0x150020
[    1.736479] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[0]=0x00000000 reg: 0x150028
[    1.736486] EDAC DEBUG: read_umc_base_mask:   DCSM1[1]=0x00000000 reg: 0x150024
[    1.736493] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[1]=0x00000000 reg: 0x15002c
[    1.736499] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR4
[    1.736504] EDAC amd64: Node 0: DRAM ECC disabled.
[    1.743629] iwlwifi 0000:03:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz, REV=0x340
[    1.770443] thinkpad_acpi: battery 1 registered (start 95, stop 100)
[    1.770467] battery: new extension: ThinkPad Battery Extension
[    1.770864] battery: extension unregistered: ThinkPad Battery Extension
[    1.798860] EDAC amd64: F17h_M60h detected (node 0).
[    1.798886] EDAC DEBUG: reserve_mc_sibling_devs: F0: 0000:00:18.0
[    1.798892] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    1.798897] EDAC DEBUG: reserve_mc_sibling_devs: F6: 0000:00:18.6
[    1.798901] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    1.798907] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000430000000
[    1.798928] EDAC DEBUG: read_umc_base_mask:   DCSB0[0]=0x00000001 reg: 0x50000
[    1.798937] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[0]=0x00000000 reg: 0x50010
[    1.798945] EDAC DEBUG: read_umc_base_mask:   DCSB0[1]=0x00000000 reg: 0x50004
[    1.798952] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[1]=0x00000000 reg: 0x50014
[    1.798959] EDAC DEBUG: read_umc_base_mask:   DCSB0[2]=0x00000000 reg: 0x50008
[    1.798966] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[2]=0x00000000 reg: 0x50018
[    1.798973] EDAC DEBUG: read_umc_base_mask:   DCSB0[3]=0x00000000 reg: 0x5000c
[    1.798980] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[3]=0x00000000 reg: 0x5001c
[    1.798987] EDAC DEBUG: read_umc_base_mask:   DCSM0[0]=0x01fffffe reg: 0x50020
[    1.798995] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[0]=0x00000000 reg: 0x50028
[    1.799002] EDAC DEBUG: read_umc_base_mask:   DCSM0[1]=0x00000000 reg: 0x50024
[    1.799009] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[1]=0x00000000 reg: 0x5002c
[    1.799016] EDAC DEBUG: read_umc_base_mask:   DCSB1[0]=0x00000001 reg: 0x150000
[    1.799023] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[0]=0x00000000 reg: 0x150010
[    1.799030] EDAC DEBUG: read_umc_base_mask:   DCSB1[1]=0x00000000 reg: 0x150004
[    1.799037] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[1]=0x00000000 reg: 0x150014
[    1.799044] EDAC DEBUG: read_umc_base_mask:   DCSB1[2]=0x00000000 reg: 0x150008
[    1.799051] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[2]=0x00000000 reg: 0x150018
[    1.799058] EDAC DEBUG: read_umc_base_mask:   DCSB1[3]=0x00000000 reg: 0x15000c
[    1.799065] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[3]=0x00000000 reg: 0x15001c
[    1.799072] EDAC DEBUG: read_umc_base_mask:   DCSM1[0]=0x01fffffe reg: 0x150020
[    1.799080] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[0]=0x00000000 reg: 0x150028
[    1.799087] EDAC DEBUG: read_umc_base_mask:   DCSM1[1]=0x00000000 reg: 0x150024
[    1.799094] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[1]=0x00000000 reg: 0x15002c
[    1.799100] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR4
[    1.799104] EDAC amd64: Node 0: DRAM ECC disabled.
[    1.810695] psmouse serio1: synaptics: queried max coordinates: x [..5678], y [..4694]
[    1.848789] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1162..]
[    1.848813] psmouse serio1: synaptics: The touchpad can support a better bus than the too old PS/2 protocol. Make sure MOUSE_PS2_SYNAPTICS_SMBUS and RMI4_SMB are enabled to get a better touchpad experience.
[    1.906650] EDAC amd64: F17h_M60h detected (node 0).
[    1.906678] EDAC DEBUG: reserve_mc_sibling_devs: F0: 0000:00:18.0
[    1.906684] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    1.906688] EDAC DEBUG: reserve_mc_sibling_devs: F6: 0000:00:18.6
[    1.906693] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    1.906699] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000430000000
[    1.906720] EDAC DEBUG: read_umc_base_mask:   DCSB0[0]=0x00000001 reg: 0x50000
[    1.906729] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[0]=0x00000000 reg: 0x50010
[    1.906737] EDAC DEBUG: read_umc_base_mask:   DCSB0[1]=0x00000000 reg: 0x50004
[    1.906744] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[1]=0x00000000 reg: 0x50014
[    1.906751] EDAC DEBUG: read_umc_base_mask:   DCSB0[2]=0x00000000 reg: 0x50008
[    1.906758] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[2]=0x00000000 reg: 0x50018
[    1.906765] EDAC DEBUG: read_umc_base_mask:   DCSB0[3]=0x00000000 reg: 0x5000c
[    1.906772] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[3]=0x00000000 reg: 0x5001c
[    1.906780] EDAC DEBUG: read_umc_base_mask:   DCSM0[0]=0x01fffffe reg: 0x50020
[    1.906787] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[0]=0x00000000 reg: 0x50028
[    1.906794] EDAC DEBUG: read_umc_base_mask:   DCSM0[1]=0x00000000 reg: 0x50024
[    1.906801] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[1]=0x00000000 reg: 0x5002c
[    1.906808] EDAC DEBUG: read_umc_base_mask:   DCSB1[0]=0x00000001 reg: 0x150000
[    1.906816] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[0]=0x00000000 reg: 0x150010
[    1.906823] EDAC DEBUG: read_umc_base_mask:   DCSB1[1]=0x00000000 reg: 0x150004
[    1.906830] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[1]=0x00000000 reg: 0x150014
[    1.906837] EDAC DEBUG: read_umc_base_mask:   DCSB1[2]=0x00000000 reg: 0x150008
[    1.906844] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[2]=0x00000000 reg: 0x150018
[    1.906851] EDAC DEBUG: read_umc_base_mask:   DCSB1[3]=0x00000000 reg: 0x15000c
[    1.906858] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[3]=0x00000000 reg: 0x15001c
[    1.906865] EDAC DEBUG: read_umc_base_mask:   DCSM1[0]=0x01fffffe reg: 0x150020
[    1.906872] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[0]=0x00000000 reg: 0x150028
[    1.906879] EDAC DEBUG: read_umc_base_mask:   DCSM1[1]=0x00000000 reg: 0x150024
[    1.906886] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[1]=0x00000000 reg: 0x15002c
[    1.906893] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR4
[    1.906897] EDAC amd64: Node 0: DRAM ECC disabled.
[    1.937543] psmouse serio1: synaptics: Touchpad model: 1, fw: 10.32, id: 0x1e2a1, caps: 0xf014a3/0x940300/0x12e800/0x500000, board id: 3471, fw id: 2909640
[    1.937622] psmouse serio1: synaptics: serio: Synaptics pass-through port at isa0060/serio1/input0
[    1.966791] EDAC amd64: F17h_M60h detected (node 0).
[    1.966817] EDAC DEBUG: reserve_mc_sibling_devs: F0: 0000:00:18.0
[    1.966823] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    1.966828] EDAC DEBUG: reserve_mc_sibling_devs: F6: 0000:00:18.6
[    1.966832] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    1.966838] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000430000000
[    1.966859] EDAC DEBUG: read_umc_base_mask:   DCSB0[0]=0x00000001 reg: 0x50000
[    1.966868] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[0]=0x00000000 reg: 0x50010
[    1.966876] EDAC DEBUG: read_umc_base_mask:   DCSB0[1]=0x00000000 reg: 0x50004
[    1.966883] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[1]=0x00000000 reg: 0x50014
[    1.966890] EDAC DEBUG: read_umc_base_mask:   DCSB0[2]=0x00000000 reg: 0x50008
[    1.966897] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[2]=0x00000000 reg: 0x50018
[    1.966904] EDAC DEBUG: read_umc_base_mask:   DCSB0[3]=0x00000000 reg: 0x5000c
[    1.966911] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[3]=0x00000000 reg: 0x5001c
[    1.966918] EDAC DEBUG: read_umc_base_mask:   DCSM0[0]=0x01fffffe reg: 0x50020
[    1.966926] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[0]=0x00000000 reg: 0x50028
[    1.966933] EDAC DEBUG: read_umc_base_mask:   DCSM0[1]=0x00000000 reg: 0x50024
[    1.966940] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[1]=0x00000000 reg: 0x5002c
[    1.966947] EDAC DEBUG: read_umc_base_mask:   DCSB1[0]=0x00000001 reg: 0x150000
[    1.966954] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[0]=0x00000000 reg: 0x150010
[    1.966961] EDAC DEBUG: read_umc_base_mask:   DCSB1[1]=0x00000000 reg: 0x150004
[    1.966968] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[1]=0x00000000 reg: 0x150014
[    1.966975] EDAC DEBUG: read_umc_base_mask:   DCSB1[2]=0x00000000 reg: 0x150008
[    1.966982] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[2]=0x00000000 reg: 0x150018
[    1.966989] EDAC DEBUG: read_umc_base_mask:   DCSB1[3]=0x00000000 reg: 0x15000c
[    1.966996] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[3]=0x00000000 reg: 0x15001c
[    1.967003] EDAC DEBUG: read_umc_base_mask:   DCSM1[0]=0x01fffffe reg: 0x150020
[    1.967010] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[0]=0x00000000 reg: 0x150028
[    1.967017] EDAC DEBUG: read_umc_base_mask:   DCSM1[1]=0x00000000 reg: 0x150024
[    1.967024] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[1]=0x00000000 reg: 0x15002c
[    1.967030] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR4
[    1.967035] EDAC amd64: Node 0: DRAM ECC disabled.
[    1.969531] iwlwifi 0000:03:00.0: base HW address: 08:d2:3e:5f:21:2a
[    1.984185] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio1/input/input2
[    1.984316] thermal thermal_zone0: failed to read out thermal zone (-61)
[    2.022772] EDAC amd64: F17h_M60h detected (node 0).
[    2.022798] EDAC DEBUG: reserve_mc_sibling_devs: F0: 0000:00:18.0
[    2.022804] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    2.022809] EDAC DEBUG: reserve_mc_sibling_devs: F6: 0000:00:18.6
[    2.022813] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    2.022819] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000430000000
[    2.022841] EDAC DEBUG: read_umc_base_mask:   DCSB0[0]=0x00000001 reg: 0x50000
[    2.022850] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[0]=0x00000000 reg: 0x50010
[    2.022857] EDAC DEBUG: read_umc_base_mask:   DCSB0[1]=0x00000000 reg: 0x50004
[    2.022864] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[1]=0x00000000 reg: 0x50014
[    2.022871] EDAC DEBUG: read_umc_base_mask:   DCSB0[2]=0x00000000 reg: 0x50008
[    2.022878] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[2]=0x00000000 reg: 0x50018
[    2.022885] EDAC DEBUG: read_umc_base_mask:   DCSB0[3]=0x00000000 reg: 0x5000c
[    2.022892] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[3]=0x00000000 reg: 0x5001c
[    2.022900] EDAC DEBUG: read_umc_base_mask:   DCSM0[0]=0x01fffffe reg: 0x50020
[    2.022907] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[0]=0x00000000 reg: 0x50028
[    2.022914] EDAC DEBUG: read_umc_base_mask:   DCSM0[1]=0x00000000 reg: 0x50024
[    2.022921] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[1]=0x00000000 reg: 0x5002c
[    2.022928] EDAC DEBUG: read_umc_base_mask:   DCSB1[0]=0x00000001 reg: 0x150000
[    2.022935] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[0]=0x00000000 reg: 0x150010
[    2.022943] EDAC DEBUG: read_umc_base_mask:   DCSB1[1]=0x00000000 reg: 0x150004
[    2.022950] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[1]=0x00000000 reg: 0x150014
[    2.022957] EDAC DEBUG: read_umc_base_mask:   DCSB1[2]=0x00000000 reg: 0x150008
[    2.022964] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[2]=0x00000000 reg: 0x150018
[    2.022971] EDAC DEBUG: read_umc_base_mask:   DCSB1[3]=0x00000000 reg: 0x15000c
[    2.022978] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[3]=0x00000000 reg: 0x15001c
[    2.022985] EDAC DEBUG: read_umc_base_mask:   DCSM1[0]=0x01fffffe reg: 0x150020
[    2.022992] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[0]=0x00000000 reg: 0x150028
[    2.022999] EDAC DEBUG: read_umc_base_mask:   DCSM1[1]=0x00000000 reg: 0x150024
[    2.023007] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[1]=0x00000000 reg: 0x15002c
[    2.023013] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR4
[    2.023018] EDAC amd64: Node 0: DRAM ECC disabled.
[    2.089729] EDAC amd64: F17h_M60h detected (node 0).
[    2.089758] EDAC DEBUG: reserve_mc_sibling_devs: F0: 0000:00:18.0
[    2.089764] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    2.089769] EDAC DEBUG: reserve_mc_sibling_devs: F6: 0000:00:18.6
[    2.089773] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    2.089779] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000430000000
[    2.089801] EDAC DEBUG: read_umc_base_mask:   DCSB0[0]=0x00000001 reg: 0x50000
[    2.089810] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[0]=0x00000000 reg: 0x50010
[    2.089818] EDAC DEBUG: read_umc_base_mask:   DCSB0[1]=0x00000000 reg: 0x50004
[    2.089825] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[1]=0x00000000 reg: 0x50014
[    2.089832] EDAC DEBUG: read_umc_base_mask:   DCSB0[2]=0x00000000 reg: 0x50008
[    2.089839] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[2]=0x00000000 reg: 0x50018
[    2.089846] EDAC DEBUG: read_umc_base_mask:   DCSB0[3]=0x00000000 reg: 0x5000c
[    2.089853] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[3]=0x00000000 reg: 0x5001c
[    2.089860] EDAC DEBUG: read_umc_base_mask:   DCSM0[0]=0x01fffffe reg: 0x50020
[    2.089868] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[0]=0x00000000 reg: 0x50028
[    2.089875] EDAC DEBUG: read_umc_base_mask:   DCSM0[1]=0x00000000 reg: 0x50024
[    2.089882] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[1]=0x00000000 reg: 0x5002c
[    2.089889] EDAC DEBUG: read_umc_base_mask:   DCSB1[0]=0x00000001 reg: 0x150000
[    2.089897] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[0]=0x00000000 reg: 0x150010
[    2.089904] EDAC DEBUG: read_umc_base_mask:   DCSB1[1]=0x00000000 reg: 0x150004
[    2.089911] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[1]=0x00000000 reg: 0x150014
[    2.089918] EDAC DEBUG: read_umc_base_mask:   DCSB1[2]=0x00000000 reg: 0x150008
[    2.089925] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[2]=0x00000000 reg: 0x150018
[    2.089933] EDAC DEBUG: read_umc_base_mask:   DCSB1[3]=0x00000000 reg: 0x15000c
[    2.089939] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[3]=0x00000000 reg: 0x15001c
[    2.089947] EDAC DEBUG: read_umc_base_mask:   DCSM1[0]=0x01fffffe reg: 0x150020
[    2.089954] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[0]=0x00000000 reg: 0x150028
[    2.089961] EDAC DEBUG: read_umc_base_mask:   DCSM1[1]=0x00000000 reg: 0x150024
[    2.089968] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[1]=0x00000000 reg: 0x15002c
[    2.089974] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR4
[    2.089979] EDAC amd64: Node 0: DRAM ECC disabled.
[    2.150524] EDAC amd64: F17h_M60h detected (node 0).
[    2.150552] EDAC DEBUG: reserve_mc_sibling_devs: F0: 0000:00:18.0
[    2.150558] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    2.150563] EDAC DEBUG: reserve_mc_sibling_devs: F6: 0000:00:18.6
[    2.150567] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    2.150573] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000430000000
[    2.150595] EDAC DEBUG: read_umc_base_mask:   DCSB0[0]=0x00000001 reg: 0x50000
[    2.150604] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[0]=0x00000000 reg: 0x50010
[    2.150611] EDAC DEBUG: read_umc_base_mask:   DCSB0[1]=0x00000000 reg: 0x50004
[    2.150618] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[1]=0x00000000 reg: 0x50014
[    2.150626] EDAC DEBUG: read_umc_base_mask:   DCSB0[2]=0x00000000 reg: 0x50008
[    2.150633] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[2]=0x00000000 reg: 0x50018
[    2.150640] EDAC DEBUG: read_umc_base_mask:   DCSB0[3]=0x00000000 reg: 0x5000c
[    2.150647] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[3]=0x00000000 reg: 0x5001c
[    2.150654] EDAC DEBUG: read_umc_base_mask:   DCSM0[0]=0x01fffffe reg: 0x50020
[    2.150662] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[0]=0x00000000 reg: 0x50028
[    2.150669] EDAC DEBUG: read_umc_base_mask:   DCSM0[1]=0x00000000 reg: 0x50024
[    2.150676] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[1]=0x00000000 reg: 0x5002c
[    2.150683] EDAC DEBUG: read_umc_base_mask:   DCSB1[0]=0x00000001 reg: 0x150000
[    2.150690] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[0]=0x00000000 reg: 0x150010
[    2.150697] EDAC DEBUG: read_umc_base_mask:   DCSB1[1]=0x00000000 reg: 0x150004
[    2.150704] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[1]=0x00000000 reg: 0x150014
[    2.150712] EDAC DEBUG: read_umc_base_mask:   DCSB1[2]=0x00000000 reg: 0x150008
[    2.150719] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[2]=0x00000000 reg: 0x150018
[    2.150726] EDAC DEBUG: read_umc_base_mask:   DCSB1[3]=0x00000000 reg: 0x15000c
[    2.150733] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[3]=0x00000000 reg: 0x15001c
[    2.150740] EDAC DEBUG: read_umc_base_mask:   DCSM1[0]=0x01fffffe reg: 0x150020
[    2.150747] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[0]=0x00000000 reg: 0x150028
[    2.150754] EDAC DEBUG: read_umc_base_mask:   DCSM1[1]=0x00000000 reg: 0x150024
[    2.150761] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[1]=0x00000000 reg: 0x15002c
[    2.150767] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR4
[    2.150772] EDAC amd64: Node 0: DRAM ECC disabled.
[    2.242950] EDAC amd64: F17h_M60h detected (node 0).
[    2.242977] EDAC DEBUG: reserve_mc_sibling_devs: F0: 0000:00:18.0
[    2.242983] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    2.242988] EDAC DEBUG: reserve_mc_sibling_devs: F6: 0000:00:18.6
[    2.242992] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    2.242998] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000430000000
[    2.243020] EDAC DEBUG: read_umc_base_mask:   DCSB0[0]=0x00000001 reg: 0x50000
[    2.243029] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[0]=0x00000000 reg: 0x50010
[    2.243036] EDAC DEBUG: read_umc_base_mask:   DCSB0[1]=0x00000000 reg: 0x50004
[    2.243043] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[1]=0x00000000 reg: 0x50014
[    2.243051] EDAC DEBUG: read_umc_base_mask:   DCSB0[2]=0x00000000 reg: 0x50008
[    2.243058] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[2]=0x00000000 reg: 0x50018
[    2.243065] EDAC DEBUG: read_umc_base_mask:   DCSB0[3]=0x00000000 reg: 0x5000c
[    2.243072] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[3]=0x00000000 reg: 0x5001c
[    2.243079] EDAC DEBUG: read_umc_base_mask:   DCSM0[0]=0x01fffffe reg: 0x50020
[    2.243087] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[0]=0x00000000 reg: 0x50028
[    2.243094] EDAC DEBUG: read_umc_base_mask:   DCSM0[1]=0x00000000 reg: 0x50024
[    2.243101] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[1]=0x00000000 reg: 0x5002c
[    2.243108] EDAC DEBUG: read_umc_base_mask:   DCSB1[0]=0x00000001 reg: 0x150000
[    2.243115] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[0]=0x00000000 reg: 0x150010
[    2.243123] EDAC DEBUG: read_umc_base_mask:   DCSB1[1]=0x00000000 reg: 0x150004
[    2.243130] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[1]=0x00000000 reg: 0x150014
[    2.243137] EDAC DEBUG: read_umc_base_mask:   DCSB1[2]=0x00000000 reg: 0x150008
[    2.243144] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[2]=0x00000000 reg: 0x150018
[    2.243151] EDAC DEBUG: read_umc_base_mask:   DCSB1[3]=0x00000000 reg: 0x15000c
[    2.243158] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[3]=0x00000000 reg: 0x15001c
[    2.243165] EDAC DEBUG: read_umc_base_mask:   DCSM1[0]=0x01fffffe reg: 0x150020
[    2.243172] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[0]=0x00000000 reg: 0x150028
[    2.243180] EDAC DEBUG: read_umc_base_mask:   DCSM1[1]=0x00000000 reg: 0x150024
[    2.243187] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[1]=0x00000000 reg: 0x15002c
[    2.243193] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR4
[    2.243197] EDAC amd64: Node 0: DRAM ECC disabled.
[    2.310602] EDAC amd64: F17h_M60h detected (node 0).
[    2.310628] EDAC DEBUG: reserve_mc_sibling_devs: F0: 0000:00:18.0
[    2.310634] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    2.310638] EDAC DEBUG: reserve_mc_sibling_devs: F6: 0000:00:18.6
[    2.310643] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    2.310649] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000430000000
[    2.310670] EDAC DEBUG: read_umc_base_mask:   DCSB0[0]=0x00000001 reg: 0x50000
[    2.310679] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[0]=0x00000000 reg: 0x50010
[    2.310687] EDAC DEBUG: read_umc_base_mask:   DCSB0[1]=0x00000000 reg: 0x50004
[    2.310694] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[1]=0x00000000 reg: 0x50014
[    2.310701] EDAC DEBUG: read_umc_base_mask:   DCSB0[2]=0x00000000 reg: 0x50008
[    2.310708] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[2]=0x00000000 reg: 0x50018
[    2.310715] EDAC DEBUG: read_umc_base_mask:   DCSB0[3]=0x00000000 reg: 0x5000c
[    2.310722] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[3]=0x00000000 reg: 0x5001c
[    2.310729] EDAC DEBUG: read_umc_base_mask:   DCSM0[0]=0x01fffffe reg: 0x50020
[    2.310737] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[0]=0x00000000 reg: 0x50028
[    2.310744] EDAC DEBUG: read_umc_base_mask:   DCSM0[1]=0x00000000 reg: 0x50024
[    2.310751] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[1]=0x00000000 reg: 0x5002c
[    2.310758] EDAC DEBUG: read_umc_base_mask:   DCSB1[0]=0x00000001 reg: 0x150000
[    2.310765] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[0]=0x00000000 reg: 0x150010
[    2.310772] EDAC DEBUG: read_umc_base_mask:   DCSB1[1]=0x00000000 reg: 0x150004
[    2.310779] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[1]=0x00000000 reg: 0x150014
[    2.310786] EDAC DEBUG: read_umc_base_mask:   DCSB1[2]=0x00000000 reg: 0x150008
[    2.310793] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[2]=0x00000000 reg: 0x150018
[    2.310800] EDAC DEBUG: read_umc_base_mask:   DCSB1[3]=0x00000000 reg: 0x15000c
[    2.310807] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[3]=0x00000000 reg: 0x15001c
[    2.310814] EDAC DEBUG: read_umc_base_mask:   DCSM1[0]=0x01fffffe reg: 0x150020
[    2.310821] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[0]=0x00000000 reg: 0x150028
[    2.310828] EDAC DEBUG: read_umc_base_mask:   DCSM1[1]=0x00000000 reg: 0x150024
[    2.310835] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[1]=0x00000000 reg: 0x15002c
[    2.310841] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR4
[    2.310846] EDAC amd64: Node 0: DRAM ECC disabled.
[    2.350628] EDAC amd64: F17h_M60h detected (node 0).
[    2.350654] EDAC DEBUG: reserve_mc_sibling_devs: F0: 0000:00:18.0
[    2.350660] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    2.350665] EDAC DEBUG: reserve_mc_sibling_devs: F6: 0000:00:18.6
[    2.350669] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    2.350675] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000430000000
[    2.350696] EDAC DEBUG: read_umc_base_mask:   DCSB0[0]=0x00000001 reg: 0x50000
[    2.350705] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[0]=0x00000000 reg: 0x50010
[    2.350713] EDAC DEBUG: read_umc_base_mask:   DCSB0[1]=0x00000000 reg: 0x50004
[    2.350720] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[1]=0x00000000 reg: 0x50014
[    2.350727] EDAC DEBUG: read_umc_base_mask:   DCSB0[2]=0x00000000 reg: 0x50008
[    2.350734] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[2]=0x00000000 reg: 0x50018
[    2.350741] EDAC DEBUG: read_umc_base_mask:   DCSB0[3]=0x00000000 reg: 0x5000c
[    2.350748] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[3]=0x00000000 reg: 0x5001c
[    2.350755] EDAC DEBUG: read_umc_base_mask:   DCSM0[0]=0x01fffffe reg: 0x50020
[    2.350763] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[0]=0x00000000 reg: 0x50028
[    2.350770] EDAC DEBUG: read_umc_base_mask:   DCSM0[1]=0x00000000 reg: 0x50024
[    2.350777] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[1]=0x00000000 reg: 0x5002c
[    2.350784] EDAC DEBUG: read_umc_base_mask:   DCSB1[0]=0x00000001 reg: 0x150000
[    2.350791] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[0]=0x00000000 reg: 0x150010
[    2.350799] EDAC DEBUG: read_umc_base_mask:   DCSB1[1]=0x00000000 reg: 0x150004
[    2.350806] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[1]=0x00000000 reg: 0x150014
[    2.350813] EDAC DEBUG: read_umc_base_mask:   DCSB1[2]=0x00000000 reg: 0x150008
[    2.350820] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[2]=0x00000000 reg: 0x150018
[    2.350827] EDAC DEBUG: read_umc_base_mask:   DCSB1[3]=0x00000000 reg: 0x15000c
[    2.350834] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[3]=0x00000000 reg: 0x15001c
[    2.350841] EDAC DEBUG: read_umc_base_mask:   DCSM1[0]=0x01fffffe reg: 0x150020
[    2.350848] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[0]=0x00000000 reg: 0x150028
[    2.350855] EDAC DEBUG: read_umc_base_mask:   DCSM1[1]=0x00000000 reg: 0x150024
[    2.350862] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[1]=0x00000000 reg: 0x15002c
[    2.350868] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR4
[    2.350873] EDAC amd64: Node 0: DRAM ECC disabled.
[    2.390507] EDAC amd64: F17h_M60h detected (node 0).
[    2.390534] EDAC DEBUG: reserve_mc_sibling_devs: F0: 0000:00:18.0
[    2.390539] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    2.390544] EDAC DEBUG: reserve_mc_sibling_devs: F6: 0000:00:18.6
[    2.390549] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    2.390554] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000430000000
[    2.390576] EDAC DEBUG: read_umc_base_mask:   DCSB0[0]=0x00000001 reg: 0x50000
[    2.390585] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[0]=0x00000000 reg: 0x50010
[    2.390592] EDAC DEBUG: read_umc_base_mask:   DCSB0[1]=0x00000000 reg: 0x50004
[    2.390600] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[1]=0x00000000 reg: 0x50014
[    2.390607] EDAC DEBUG: read_umc_base_mask:   DCSB0[2]=0x00000000 reg: 0x50008
[    2.390614] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[2]=0x00000000 reg: 0x50018
[    2.390621] EDAC DEBUG: read_umc_base_mask:   DCSB0[3]=0x00000000 reg: 0x5000c
[    2.390628] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[3]=0x00000000 reg: 0x5001c
[    2.390635] EDAC DEBUG: read_umc_base_mask:   DCSM0[0]=0x01fffffe reg: 0x50020
[    2.390643] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[0]=0x00000000 reg: 0x50028
[    2.390650] EDAC DEBUG: read_umc_base_mask:   DCSM0[1]=0x00000000 reg: 0x50024
[    2.390657] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[1]=0x00000000 reg: 0x5002c
[    2.390664] EDAC DEBUG: read_umc_base_mask:   DCSB1[0]=0x00000001 reg: 0x150000
[    2.390671] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[0]=0x00000000 reg: 0x150010
[    2.390678] EDAC DEBUG: read_umc_base_mask:   DCSB1[1]=0x00000000 reg: 0x150004
[    2.390685] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[1]=0x00000000 reg: 0x150014
[    2.390692] EDAC DEBUG: read_umc_base_mask:   DCSB1[2]=0x00000000 reg: 0x150008
[    2.390699] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[2]=0x00000000 reg: 0x150018
[    2.390706] EDAC DEBUG: read_umc_base_mask:   DCSB1[3]=0x00000000 reg: 0x15000c
[    2.390713] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[3]=0x00000000 reg: 0x15001c
[    2.390721] EDAC DEBUG: read_umc_base_mask:   DCSM1[0]=0x01fffffe reg: 0x150020
[    2.390728] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[0]=0x00000000 reg: 0x150028
[    2.390735] EDAC DEBUG: read_umc_base_mask:   DCSM1[1]=0x00000000 reg: 0x150024
[    2.390742] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[1]=0x00000000 reg: 0x15002c
[    2.390748] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR4
[    2.390753] EDAC amd64: Node 0: DRAM ECC disabled.
[    2.430549] EDAC amd64: F17h_M60h detected (node 0).
[    2.430575] EDAC DEBUG: reserve_mc_sibling_devs: F0: 0000:00:18.0
[    2.430581] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    2.430586] EDAC DEBUG: reserve_mc_sibling_devs: F6: 0000:00:18.6
[    2.430590] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    2.430596] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000430000000
[    2.430617] EDAC DEBUG: read_umc_base_mask:   DCSB0[0]=0x00000001 reg: 0x50000
[    2.430626] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[0]=0x00000000 reg: 0x50010
[    2.430633] EDAC DEBUG: read_umc_base_mask:   DCSB0[1]=0x00000000 reg: 0x50004
[    2.430641] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[1]=0x00000000 reg: 0x50014
[    2.430648] EDAC DEBUG: read_umc_base_mask:   DCSB0[2]=0x00000000 reg: 0x50008
[    2.430655] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[2]=0x00000000 reg: 0x50018
[    2.430662] EDAC DEBUG: read_umc_base_mask:   DCSB0[3]=0x00000000 reg: 0x5000c
[    2.430669] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[3]=0x00000000 reg: 0x5001c
[    2.430676] EDAC DEBUG: read_umc_base_mask:   DCSM0[0]=0x01fffffe reg: 0x50020
[    2.430683] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[0]=0x00000000 reg: 0x50028
[    2.430690] EDAC DEBUG: read_umc_base_mask:   DCSM0[1]=0x00000000 reg: 0x50024
[    2.430697] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[1]=0x00000000 reg: 0x5002c
[    2.430704] EDAC DEBUG: read_umc_base_mask:   DCSB1[0]=0x00000001 reg: 0x150000
[    2.430712] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[0]=0x00000000 reg: 0x150010
[    2.430719] EDAC DEBUG: read_umc_base_mask:   DCSB1[1]=0x00000000 reg: 0x150004
[    2.430726] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[1]=0x00000000 reg: 0x150014
[    2.430733] EDAC DEBUG: read_umc_base_mask:   DCSB1[2]=0x00000000 reg: 0x150008
[    2.430740] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[2]=0x00000000 reg: 0x150018
[    2.430747] EDAC DEBUG: read_umc_base_mask:   DCSB1[3]=0x00000000 reg: 0x15000c
[    2.430754] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[3]=0x00000000 reg: 0x15001c
[    2.430761] EDAC DEBUG: read_umc_base_mask:   DCSM1[0]=0x01fffffe reg: 0x150020
[    2.430768] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[0]=0x00000000 reg: 0x150028
[    2.430775] EDAC DEBUG: read_umc_base_mask:   DCSM1[1]=0x00000000 reg: 0x150024
[    2.430782] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[1]=0x00000000 reg: 0x15002c
[    2.430788] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR4
[    2.430793] EDAC amd64: Node 0: DRAM ECC disabled.
[    2.470467] EDAC amd64: F17h_M60h detected (node 0).
[    2.470494] EDAC DEBUG: reserve_mc_sibling_devs: F0: 0000:00:18.0
[    2.470499] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    2.470504] EDAC DEBUG: reserve_mc_sibling_devs: F6: 0000:00:18.6
[    2.470509] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    2.470515] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000430000000
[    2.470536] EDAC DEBUG: read_umc_base_mask:   DCSB0[0]=0x00000001 reg: 0x50000
[    2.470545] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[0]=0x00000000 reg: 0x50010
[    2.470552] EDAC DEBUG: read_umc_base_mask:   DCSB0[1]=0x00000000 reg: 0x50004
[    2.470560] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[1]=0x00000000 reg: 0x50014
[    2.470567] EDAC DEBUG: read_umc_base_mask:   DCSB0[2]=0x00000000 reg: 0x50008
[    2.470574] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[2]=0x00000000 reg: 0x50018
[    2.470581] EDAC DEBUG: read_umc_base_mask:   DCSB0[3]=0x00000000 reg: 0x5000c
[    2.470588] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[3]=0x00000000 reg: 0x5001c
[    2.470595] EDAC DEBUG: read_umc_base_mask:   DCSM0[0]=0x01fffffe reg: 0x50020
[    2.470605] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[0]=0x00000000 reg: 0x50028
[    2.470612] EDAC DEBUG: read_umc_base_mask:   DCSM0[1]=0x00000000 reg: 0x50024
[    2.470619] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[1]=0x00000000 reg: 0x5002c
[    2.470626] EDAC DEBUG: read_umc_base_mask:   DCSB1[0]=0x00000001 reg: 0x150000
[    2.470633] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[0]=0x00000000 reg: 0x150010
[    2.470641] EDAC DEBUG: read_umc_base_mask:   DCSB1[1]=0x00000000 reg: 0x150004
[    2.470648] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[1]=0x00000000 reg: 0x150014
[    2.470655] EDAC DEBUG: read_umc_base_mask:   DCSB1[2]=0x00000000 reg: 0x150008
[    2.470662] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[2]=0x00000000 reg: 0x150018
[    2.470669] EDAC DEBUG: read_umc_base_mask:   DCSB1[3]=0x00000000 reg: 0x15000c
[    2.470676] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[3]=0x00000000 reg: 0x15001c
[    2.470683] EDAC DEBUG: read_umc_base_mask:   DCSM1[0]=0x01fffffe reg: 0x150020
[    2.470690] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[0]=0x00000000 reg: 0x150028
[    2.470697] EDAC DEBUG: read_umc_base_mask:   DCSM1[1]=0x00000000 reg: 0x150024
[    2.470704] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[1]=0x00000000 reg: 0x15002c
[    2.470710] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR4
[    2.470715] EDAC amd64: Node 0: DRAM ECC disabled.
[    2.494568] [drm] reserve 0x400000 from 0xf41f800000 for PSP TMR
[    2.502511] EDAC amd64: F17h_M60h detected (node 0).
[    2.502537] EDAC DEBUG: reserve_mc_sibling_devs: F0: 0000:00:18.0
[    2.502543] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    2.502547] EDAC DEBUG: reserve_mc_sibling_devs: F6: 0000:00:18.6
[    2.502552] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    2.502558] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000430000000
[    2.502581] EDAC DEBUG: read_umc_base_mask:   DCSB0[0]=0x00000001 reg: 0x50000
[    2.502590] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[0]=0x00000000 reg: 0x50010
[    2.502598] EDAC DEBUG: read_umc_base_mask:   DCSB0[1]=0x00000000 reg: 0x50004
[    2.502605] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[1]=0x00000000 reg: 0x50014
[    2.502612] EDAC DEBUG: read_umc_base_mask:   DCSB0[2]=0x00000000 reg: 0x50008
[    2.502619] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[2]=0x00000000 reg: 0x50018
[    2.502627] EDAC DEBUG: read_umc_base_mask:   DCSB0[3]=0x00000000 reg: 0x5000c
[    2.502634] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[3]=0x00000000 reg: 0x5001c
[    2.502641] EDAC DEBUG: read_umc_base_mask:   DCSM0[0]=0x01fffffe reg: 0x50020
[    2.502649] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[0]=0x00000000 reg: 0x50028
[    2.502656] EDAC DEBUG: read_umc_base_mask:   DCSM0[1]=0x00000000 reg: 0x50024
[    2.502663] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[1]=0x00000000 reg: 0x5002c
[    2.502670] EDAC DEBUG: read_umc_base_mask:   DCSB1[0]=0x00000001 reg: 0x150000
[    2.502678] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[0]=0x00000000 reg: 0x150010
[    2.502685] EDAC DEBUG: read_umc_base_mask:   DCSB1[1]=0x00000000 reg: 0x150004
[    2.502692] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[1]=0x00000000 reg: 0x150014
[    2.502700] EDAC DEBUG: read_umc_base_mask:   DCSB1[2]=0x00000000 reg: 0x150008
[    2.502707] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[2]=0x00000000 reg: 0x150018
[    2.502714] EDAC DEBUG: read_umc_base_mask:   DCSB1[3]=0x00000000 reg: 0x15000c
[    2.502721] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[3]=0x00000000 reg: 0x15001c
[    2.502728] EDAC DEBUG: read_umc_base_mask:   DCSM1[0]=0x01fffffe reg: 0x150020
[    2.502736] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[0]=0x00000000 reg: 0x150028
[    2.502743] EDAC DEBUG: read_umc_base_mask:   DCSM1[1]=0x00000000 reg: 0x150024
[    2.502750] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[1]=0x00000000 reg: 0x15002c
[    2.502756] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR4
[    2.502761] EDAC amd64: Node 0: DRAM ECC disabled.
[    2.510160] psmouse serio2: trackpoint: Elan TrackPoint firmware: 0x11, buttons: 3/3
[    2.538488] EDAC amd64: F17h_M60h detected (node 0).
[    2.538516] EDAC DEBUG: reserve_mc_sibling_devs: F0: 0000:00:18.0
[    2.538522] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    2.538526] EDAC DEBUG: reserve_mc_sibling_devs: F6: 0000:00:18.6
[    2.538530] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    2.538536] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000430000000
[    2.538558] EDAC DEBUG: read_umc_base_mask:   DCSB0[0]=0x00000001 reg: 0x50000
[    2.538567] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[0]=0x00000000 reg: 0x50010
[    2.538575] EDAC DEBUG: read_umc_base_mask:   DCSB0[1]=0x00000000 reg: 0x50004
[    2.538582] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[1]=0x00000000 reg: 0x50014
[    2.538589] EDAC DEBUG: read_umc_base_mask:   DCSB0[2]=0x00000000 reg: 0x50008
[    2.538596] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[2]=0x00000000 reg: 0x50018
[    2.538603] EDAC DEBUG: read_umc_base_mask:   DCSB0[3]=0x00000000 reg: 0x5000c
[    2.538610] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[3]=0x00000000 reg: 0x5001c
[    2.538617] EDAC DEBUG: read_umc_base_mask:   DCSM0[0]=0x01fffffe reg: 0x50020
[    2.538625] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[0]=0x00000000 reg: 0x50028
[    2.538632] EDAC DEBUG: read_umc_base_mask:   DCSM0[1]=0x00000000 reg: 0x50024
[    2.538639] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[1]=0x00000000 reg: 0x5002c
[    2.538646] EDAC DEBUG: read_umc_base_mask:   DCSB1[0]=0x00000001 reg: 0x150000
[    2.538653] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[0]=0x00000000 reg: 0x150010
[    2.538660] EDAC DEBUG: read_umc_base_mask:   DCSB1[1]=0x00000000 reg: 0x150004
[    2.538667] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[1]=0x00000000 reg: 0x150014
[    2.538674] EDAC DEBUG: read_umc_base_mask:   DCSB1[2]=0x00000000 reg: 0x150008
[    2.538681] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[2]=0x00000000 reg: 0x150018
[    2.538688] EDAC DEBUG: read_umc_base_mask:   DCSB1[3]=0x00000000 reg: 0x15000c
[    2.538695] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[3]=0x00000000 reg: 0x15001c
[    2.538702] EDAC DEBUG: read_umc_base_mask:   DCSM1[0]=0x01fffffe reg: 0x150020
[    2.538709] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[0]=0x00000000 reg: 0x150028
[    2.538716] EDAC DEBUG: read_umc_base_mask:   DCSM1[1]=0x00000000 reg: 0x150024
[    2.538723] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[1]=0x00000000 reg: 0x15002c
[    2.538729] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR4
[    2.538734] EDAC amd64: Node 0: DRAM ECC disabled.
[    2.582673] EDAC amd64: F17h_M60h detected (node 0).
[    2.582699] EDAC DEBUG: reserve_mc_sibling_devs: F0: 0000:00:18.0
[    2.582705] EDAC DEBUG: reserve_mc_sibling_devs: F3: 0000:00:18.3
[    2.582709] EDAC DEBUG: reserve_mc_sibling_devs: F6: 0000:00:18.6
[    2.582714] EDAC DEBUG: read_mc_regs:   TOP_MEM:  0x00000000d0000000
[    2.582719] EDAC DEBUG: read_mc_regs:   TOP_MEM2: 0x0000000430000000
[    2.582741] EDAC DEBUG: read_umc_base_mask:   DCSB0[0]=0x00000001 reg: 0x50000
[    2.582750] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[0]=0x00000000 reg: 0x50010
[    2.582758] EDAC DEBUG: read_umc_base_mask:   DCSB0[1]=0x00000000 reg: 0x50004
[    2.582765] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[1]=0x00000000 reg: 0x50014
[    2.582772] EDAC DEBUG: read_umc_base_mask:   DCSB0[2]=0x00000000 reg: 0x50008
[    2.582779] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[2]=0x00000000 reg: 0x50018
[    2.582786] EDAC DEBUG: read_umc_base_mask:   DCSB0[3]=0x00000000 reg: 0x5000c
[    2.582793] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC0[3]=0x00000000 reg: 0x5001c
[    2.582800] EDAC DEBUG: read_umc_base_mask:   DCSM0[0]=0x01fffffe reg: 0x50020
[    2.582808] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[0]=0x00000000 reg: 0x50028
[    2.582815] EDAC DEBUG: read_umc_base_mask:   DCSM0[1]=0x00000000 reg: 0x50024
[    2.582822] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC0[1]=0x00000000 reg: 0x5002c
[    2.582829] EDAC DEBUG: read_umc_base_mask:   DCSB1[0]=0x00000001 reg: 0x150000
[    2.582836] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[0]=0x00000000 reg: 0x150010
[    2.582843] EDAC DEBUG: read_umc_base_mask:   DCSB1[1]=0x00000000 reg: 0x150004
[    2.582850] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[1]=0x00000000 reg: 0x150014
[    2.582858] EDAC DEBUG: read_umc_base_mask:   DCSB1[2]=0x00000000 reg: 0x150008
[    2.582865] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[2]=0x00000000 reg: 0x150018
[    2.582872] EDAC DEBUG: read_umc_base_mask:   DCSB1[3]=0x00000000 reg: 0x15000c
[    2.582879] EDAC DEBUG: read_umc_base_mask:     DCSB_SEC1[3]=0x00000000 reg: 0x15001c
[    2.582886] EDAC DEBUG: read_umc_base_mask:   DCSM1[0]=0x01fffffe reg: 0x150020
[    2.582893] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[0]=0x00000000 reg: 0x150028
[    2.582900] EDAC DEBUG: read_umc_base_mask:   DCSM1[1]=0x00000000 reg: 0x150024
[    2.582907] EDAC DEBUG: read_umc_base_mask:     DCSM_SEC1[1]=0x00000000 reg: 0x15002c
[    2.582913] EDAC DEBUG: read_mc_regs:   DIMM type: Unbuffered-DDR4
[    2.582918] EDAC amd64: Node 0: DRAM ECC disabled.
[    2.657306] ucsi_acpi: probe of USBC000:00 failed with error -5
[    2.689816] amdgpu 0000:06:00.0: amdgpu: SMU is initialized successfully!
[    2.691199] [drm] kiq ring mec 2 pipe 1 q 0
[    2.691927] [drm] Display Core initialized with v3.2.116!
[    2.704703] [drm] DMUB hardware initialized: version=0x01000000
[    2.729329] snd_hda_intel 0000:06:00.1: bound 0000:06:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
[    2.750836] input: TPPS/2 Elan TrackPoint as /devices/platform/i8042/serio1/serio2/input/input16
[    2.831140] [drm] VCN decode and encode initialized successfully(under DPG Mode).
[    2.831189] [drm] JPEG decode initialized successfully.
[    2.833335] kfd kfd: Allocated 3969056 bytes on gart
[    2.833610] Virtual CRAT table created for GPU
[    2.833858] amdgpu: Topology: Add dGPU node [0x1636:0x1002]
[    2.833867] kfd kfd: added device 1002:1636
[    2.833874] amdgpu 0000:06:00.0: amdgpu: SE 1, SH per SE 2, CU per SH 18, active_cu_number 27
[    2.834941] [drm] fb mappable at 0x410CE0000
[    2.834956] [drm] vram apper at 0x410000000
[    2.834961] [drm] size 8294400
[    2.834964] [drm] fb depth is 24
[    2.834968] [drm]    pitch is 7680
[    2.835183] fbcon: amdgpudrmfb (fb0) is primary device
[    2.879976] Console: switching to colour frame buffer device 240x67
[    2.903266] amdgpu 0000:06:00.0: [drm] fb0: amdgpudrmfb frame buffer device
[    2.903434] amdgpu 0000:06:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
[    2.903486] amdgpu 0000:06:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[    2.903539] amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[    2.903592] amdgpu 0000:06:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
[    2.903644] amdgpu 0000:06:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
[    2.903696] amdgpu 0000:06:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
[    2.903748] amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
[    2.903801] amdgpu 0000:06:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
[    2.903853] amdgpu 0000:06:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
[    2.903907] amdgpu 0000:06:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
[    2.903960] amdgpu 0000:06:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
[    2.904010] amdgpu 0000:06:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
[    2.904061] amdgpu 0000:06:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
[    2.904112] amdgpu 0000:06:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
[    2.904163] amdgpu 0000:06:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
[    2.926702] [drm] Initialized amdgpu 3.40.0 20150101 for 0000:06:00.0 on minor 2
[    3.153480] Adding 999420k swap on /dev/nvme0n1p3.  Priority:-2 extents:1 across:999420k SS
[    3.169265] EXT4-fs (nvme0n1p2): re-mounted. Opts: errors=remount-ro. Quota mode: disabled.
[    3.621518] Generic FE-GE Realtek PHY r8169-500:00: attached PHY driver (mii_bus:phy_addr=r8169-500:00, irq=IGNORE)
[    3.789739] r8169 0000:05:00.0 eth1: Link is Down
[    3.861945] amdgpu 0000:06:00.0: amdgpu: Unsupported power profile mode 0 on RENOIR
[    5.366849] r8169 0000:05:00.0 eth1: Link is Up - 100Mbps/Full - flow control rx/tx
[    5.366941] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
[   54.152939] hib.sh (1624): drop_caches: 3
[   54.155804] PM: suspend entry (deep)
[   54.161485] Filesystems sync: 0.003 seconds
[   54.188314] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   54.189413] OOM killer disabled.
[   54.189441] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   54.333445] [drm] free PSP TMR buffer
[   54.415204] r8169 0000:05:00.0 eth1: Link is Down
[   54.581064] ACPI: EC: interrupt blocked
[   54.637463] ACPI: Preparing to enter system sleep state S3
[   54.640891] ACPI: EC: event blocked
[   54.640896] ACPI: EC: EC stopped
[   54.640900] PM: Saving platform NVS memory
[   54.641500] Disabling non-boot CPUs ...
[   54.642717] IRQ 87: no longer affine to CPU1
[   54.643888] smpboot: CPU 1 is now offline
[   54.644986] IRQ 88: no longer affine to CPU2
[   54.646055] smpboot: CPU 2 is now offline
[   54.647207] IRQ 89: no longer affine to CPU3
[   54.648252] smpboot: CPU 3 is now offline
[   54.649331] IRQ 90: no longer affine to CPU4
[   54.650377] smpboot: CPU 4 is now offline
[   54.651412] IRQ 91: no longer affine to CPU5
[   54.652454] smpboot: CPU 5 is now offline
[   54.653373] IRQ 92: no longer affine to CPU6
[   54.654404] smpboot: CPU 6 is now offline
[   54.655336] IRQ 93: no longer affine to CPU7
[   54.656365] smpboot: CPU 7 is now offline
[   54.657369] IRQ 94: no longer affine to CPU8
[   54.658402] smpboot: CPU 8 is now offline
[   54.659352] IRQ 95: no longer affine to CPU9
[   54.660395] smpboot: CPU 9 is now offline
[   54.661380] IRQ 96: no longer affine to CPU10
[   54.662414] smpboot: CPU 10 is now offline
[   54.664422] smpboot: CPU 11 is now offline
[   54.666433] smpboot: CPU 12 is now offline
[   54.668365] smpboot: CPU 13 is now offline
[   54.670385] smpboot: CPU 14 is now offline
[   54.672291] smpboot: CPU 15 is now offline
[   54.672327] ACPI: Low-level resume complete
[   54.672327] ACPI: EC: EC started
[   54.672327] PM: Restoring platform NVS memory
[   54.672327] ------------[ cut here ]------------
[   54.672327] WARNING: CPU: 0 PID: 2 at kernel/time/timekeeping.c:824 ktime_get+0x8d/0xa0
[   54.672327] Modules linked in: nls_ascii nls_cp437 vfat fat joydev iwlmvm edac_mce_amd edac_core kvm_amd mac80211 kvm libarc4 irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel iwlwifi snd_hda_codec_realtek ghash_clmulni_intel amdgpu snd_hda_codec_generic snd_hda_codec_hdmi rtsx_pci_sdmmc snd_hda_intel snd_intel_dspcfg mmc_core snd_hda_codec aesni_intel wmi_bmof glue_helper snd_hwdep libaes crypto_simd snd_hda_core sp5100_tco cryptd snd_pcm nvram rapl pcspkr efi_pstore watchdog ledtrig_audio cfg80211 ucsi_acpi snd_timer i2c_piix4 k10temp rtsx_pci gpu_sched ccp r8169 typec_ucsi mfd_core snd typec wmi soundcore battery ac video i2c_scmi i2c_multi_instantiate acpi_cpufreq button psmouse serio_raw nvme nvme_core
[   54.672327] CPU: 0 PID: 2 Comm: kthreadd Not tainted 5.11.0-rc2+ #20
[   54.672327] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W(1.27 ) 10/20/2020
[   54.672327] RIP: 0010:ktime_get+0x8d/0xa0
[   54.672327] Code: 0d 7c 9b 93 01 48 0f 45 d5 8b 35 4e 9b 93 01 41 39 f4 75 9e 48 0f af c2 48 01 f8 48 d3 e8 48 01 d8 5b 5d 41 5c c3 f3 90 eb 88 <0f> 0b eb 82 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44
[   54.672327] RSP: 0018:ffffc90000107d78 EFLAGS: 00010202
[   54.672327] RAX: 0000000000000001 RBX: 00000000ffffffff RCX: 0000000000000000
[   54.672327] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffc90000107d58
[   54.672327] RBP: ffffc90000107e38 R08: 0000000000000001 R09: 0000000000000000
[   54.672327] R10: ffff8881050ab4b0 R11: ffffc90000107d10 R12: 0000000000800700
[   54.672327] R13: ffff888101fe0900 R14: ffffc90000107eb0 R15: ffff888110018000
[   54.672327] FS:  0000000000000000(0000) GS:ffff8883fae00000(0000) knlGS:0000000000000000
[   54.672327] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.672327] CR2: 00007f902c0de730 CR3: 0000000102a4e000 CR4: 0000000000350ef0
[   54.672327] Call Trace:
[   54.672327]  copy_process+0xfab/0x1a30
[   54.672327]  ? kernel_clone+0xaf/0x420
[   54.672327]  kernel_clone+0xaf/0x420
[   54.672327]  ? _raw_spin_unlock_irq+0x13/0x30
[   54.672327]  ? finish_task_switch.isra.0+0xb7/0x2a0
[   54.672327]  kernel_thread+0x55/0x80
[   54.672327]  ? __kthread_bind_mask+0x90/0x90
[   54.672327]  kthreadd+0xf8/0x150
[   54.672327]  ? kthread_create_on_cpu+0x90/0x90
[   54.672327]  ret_from_fork+0x22/0x30
[   54.672327] ---[ end trace 5ad731f459b5e3b6 ]---
[   54.672327] ------------[ cut here ]------------
[   54.672327] WARNING: CPU: 0 PID: 2 at kernel/time/timekeeping.c:867 ktime_get_with_offset+0xda/0xf0
[   54.672327] Modules linked in: nls_ascii nls_cp437 vfat fat joydev iwlmvm edac_mce_amd edac_core kvm_amd mac80211 kvm libarc4 irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel iwlwifi snd_hda_codec_realtek ghash_clmulni_intel amdgpu snd_hda_codec_generic snd_hda_codec_hdmi rtsx_pci_sdmmc snd_hda_intel snd_intel_dspcfg mmc_core snd_hda_codec aesni_intel wmi_bmof glue_helper snd_hwdep libaes crypto_simd snd_hda_core sp5100_tco cryptd snd_pcm nvram rapl pcspkr efi_pstore watchdog ledtrig_audio cfg80211 ucsi_acpi snd_timer i2c_piix4 k10temp rtsx_pci gpu_sched ccp r8169 typec_ucsi mfd_core snd typec wmi soundcore battery ac video i2c_scmi i2c_multi_instantiate acpi_cpufreq button psmouse serio_raw nvme nvme_core
[   54.672327] CPU: 0 PID: 2 Comm: kthreadd Tainted: G        W         5.11.0-rc2+ #20
[   54.672327] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W(1.27 ) 10/20/2020
[   54.672327] RIP: 0010:ktime_get_with_offset+0xda/0xf0
[   54.672327] Code: 24 10 48 8b 6c 24 08 4c 8b 6c 24 18 4c 8b 74 24 20 48 01 f8 48 d3 e8 48 01 d8 48 8b 1c 24 48 83 c4 28 c3 f3 90 e9 62 ff ff ff <0f> 0b e9 58 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
[   54.672327] RSP: 0018:ffffc90000107d68 EFLAGS: 00010202
[   54.672327] RAX: 0000000000000001 RBX: 00000000ffffffff RCX: 0000000000000019
[   54.672327] RDX: 0000000000000000 RSI: 0000000000001c6e RDI: 0000000000000001
[   54.672327] RBP: ffffc90000107e38 R08: 0000000000000001 R09: 0000000000000000
[   54.672327] R10: ffff8881050ab4b0 R11: ffffc90000107d10 R12: 0000000000800700
[   54.672327] R13: ffffffff82a3e8a0 R14: ffffc90000107eb0 R15: ffff888110018000
[   54.672327] FS:  0000000000000000(0000) GS:ffff8883fae00000(0000) knlGS:0000000000000000
[   54.672327] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.672327] CR2: 00007f902c0de730 CR3: 0000000102a4e000 CR4: 0000000000350ef0
[   54.672327] Call Trace:
[   54.672327]  copy_process+0xfbc/0x1a30
[   54.672327]  ? kernel_clone+0xaf/0x420
[   54.672327]  kernel_clone+0xaf/0x420
[   54.672327]  ? _raw_spin_unlock_irq+0x13/0x30
[   54.672327]  ? finish_task_switch.isra.0+0xb7/0x2a0
[   54.672327]  kernel_thread+0x55/0x80
[   54.672327]  ? __kthread_bind_mask+0x90/0x90
[   54.672327]  kthreadd+0xf8/0x150
[   54.672327]  ? kthread_create_on_cpu+0x90/0x90
[   54.672327]  ret_from_fork+0x22/0x30
[   54.672327] ---[ end trace 5ad731f459b5e3b7 ]---
[   54.672327] ------------[ cut here ]------------
[   54.672327] WARNING: CPU: 0 PID: 2 at kernel/time/timekeeping.c:824 ktime_get+0x8d/0xa0
[   54.672327] Modules linked in: nls_ascii nls_cp437 vfat fat joydev iwlmvm edac_mce_amd edac_core kvm_amd mac80211 kvm libarc4 irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel iwlwifi snd_hda_codec_realtek ghash_clmulni_intel amdgpu snd_hda_codec_generic snd_hda_codec_hdmi rtsx_pci_sdmmc snd_hda_intel snd_intel_dspcfg mmc_core snd_hda_codec aesni_intel wmi_bmof glue_helper snd_hwdep libaes crypto_simd snd_hda_core sp5100_tco cryptd snd_pcm nvram rapl pcspkr efi_pstore watchdog ledtrig_audio cfg80211 ucsi_acpi snd_timer i2c_piix4 k10temp rtsx_pci gpu_sched ccp r8169 typec_ucsi mfd_core snd typec wmi soundcore battery ac video i2c_scmi i2c_multi_instantiate acpi_cpufreq button psmouse serio_raw nvme nvme_core
[   54.672327] CPU: 0 PID: 2 Comm: kthreadd Tainted: G        W         5.11.0-rc2+ #20
[   54.672327] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W(1.27 ) 10/20/2020
[   54.672327] RIP: 0010:ktime_get+0x8d/0xa0
[   54.672327] Code: 0d 7c 9b 93 01 48 0f 45 d5 8b 35 4e 9b 93 01 41 39 f4 75 9e 48 0f af c2 48 01 f8 48 d3 e8 48 01 d8 5b 5d 41 5c c3 f3 90 eb 88 <0f> 0b eb 82 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 0f 1f 44
[   54.672327] RSP: 0018:ffffc90000107d78 EFLAGS: 00010202
[   54.672327] RAX: 0000000000000001 RBX: 00000000ffffffff RCX: 0000000000000000
[   54.672327] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffc90000107d58
[   54.672327] RBP: ffffc90000107e38 R08: 0000000000000001 R09: 0000000000000000
[   54.672327] R10: ffff8881050ab4b0 R11: ffffc90000107d10 R12: 0000000000800700
[   54.672327] R13: ffff888101fe0a80 R14: ffffc90000107eb0 R15: ffff88811001eac0
[   54.672327] FS:  0000000000000000(0000) GS:ffff8883fae00000(0000) knlGS:0000000000000000
[   54.672327] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.672327] CR2: 00007f902c0de730 CR3: 0000000102a4e000 CR4: 0000000000350ef0
[   54.672327] Call Trace:
[   54.672327]  copy_process+0xfab/0x1a30
[   54.672327]  ? kernel_clone+0xaf/0x420
[   54.672327]  kernel_clone+0xaf/0x420
[   54.672327]  ? _raw_spin_unlock_irq+0x13/0x30
[   54.672327]  ? finish_task_switch.isra.0+0xb7/0x2a0
[   54.672327]  kernel_thread+0x55/0x80
[   54.672327]  ? __kthread_bind_mask+0x90/0x90
[   54.672327]  kthreadd+0xf8/0x150
[   54.672327]  ? kthread_create_on_cpu+0x90/0x90
[   54.672327]  ret_from_fork+0x22/0x30
[   54.672327] ---[ end trace 5ad731f459b5e3b8 ]---
[   54.672327] ------------[ cut here ]------------
[   54.672327] WARNING: CPU: 0 PID: 2 at kernel/time/timekeeping.c:867 ktime_get_with_offset+0xda/0xf0
[   54.672327] Modules linked in: nls_ascii nls_cp437 vfat fat joydev iwlmvm edac_mce_amd edac_core kvm_amd mac80211 kvm libarc4 irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel iwlwifi snd_hda_codec_realtek ghash_clmulni_intel amdgpu snd_hda_codec_generic snd_hda_codec_hdmi rtsx_pci_sdmmc snd_hda_intel snd_intel_dspcfg mmc_core snd_hda_codec aesni_intel wmi_bmof glue_helper snd_hwdep libaes crypto_simd snd_hda_core sp5100_tco cryptd snd_pcm nvram rapl pcspkr efi_pstore watchdog ledtrig_audio cfg80211 ucsi_acpi snd_timer i2c_piix4 k10temp rtsx_pci gpu_sched ccp r8169 typec_ucsi mfd_core snd typec wmi soundcore battery ac video i2c_scmi i2c_multi_instantiate acpi_cpufreq button psmouse serio_raw nvme nvme_core
[   54.672327] CPU: 0 PID: 2 Comm: kthreadd Tainted: G        W         5.11.0-rc2+ #20
[   54.672327] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W(1.27 ) 10/20/2020
[   54.672327] RIP: 0010:ktime_get_with_offset+0xda/0xf0
[   54.672327] Code: 24 10 48 8b 6c 24 08 4c 8b 6c 24 18 4c 8b 74 24 20 48 01 f8 48 d3 e8 48 01 d8 48 8b 1c 24 48 83 c4 28 c3 f3 90 e9 62 ff ff ff <0f> 0b e9 58 ff ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
[   54.672327] RSP: 0018:ffffc90000107d68 EFLAGS: 00010202
[   54.672327] RAX: 0000000000000001 RBX: 00000000ffffffff RCX: 0000000000000019
[   54.672327] RDX: 0000000000000000 RSI: 0000000000001c6e RDI: 0000000000000001
[   54.672327] RBP: ffffc90000107e38 R08: 0000000000000001 R09: 0000000000000000
[   54.672327] R10: ffff8881050ab4b0 R11: ffffc90000107d10 R12: 0000000000800700
[   54.672327] R13: ffffffff82a3e8a0 R14: ffffc90000107eb0 R15: ffff88811001eac0
[   54.672327] FS:  0000000000000000(0000) GS:ffff8883fae00000(0000) knlGS:0000000000000000
[   54.672327] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.672327] CR2: 00007f902c0de730 CR3: 0000000102a4e000 CR4: 0000000000350ef0
[   54.672327] Call Trace:
[   54.672327]  copy_process+0xfbc/0x1a30
[   54.672327]  ? kernel_clone+0xaf/0x420
[   54.672327]  kernel_clone+0xaf/0x420
[   54.672327]  ? _raw_spin_unlock_irq+0x13/0x30
[   54.672327]  ? finish_task_switch.isra.0+0xb7/0x2a0
[   54.672327]  kernel_thread+0x55/0x80
[   54.672327]  ? __kthread_bind_mask+0x90/0x90
[   54.672327]  kthreadd+0xf8/0x150
[   54.672327]  ? kthread_create_on_cpu+0x90/0x90
[   54.672327]  ret_from_fork+0x22/0x30
[   54.672327] ---[ end trace 5ad731f459b5e3b9 ]---
[   54.672327] ------------[ cut here ]------------
[   54.672327] Interrupts enabled after amd_iommu_resume+0x0/0x40
[   54.672327] WARNING: CPU: 0 PID: 1624 at drivers/base/syscore.c:103 syscore_resume+0x12d/0x160
[   54.672327] Modules linked in: nls_ascii nls_cp437 vfat fat joydev iwlmvm edac_mce_amd edac_core kvm_amd mac80211 kvm libarc4 irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel iwlwifi snd_hda_codec_realtek ghash_clmulni_intel amdgpu snd_hda_codec_generic snd_hda_codec_hdmi rtsx_pci_sdmmc snd_hda_intel snd_intel_dspcfg mmc_core snd_hda_codec aesni_intel wmi_bmof glue_helper snd_hwdep libaes crypto_simd snd_hda_core sp5100_tco cryptd snd_pcm nvram rapl pcspkr efi_pstore watchdog ledtrig_audio cfg80211 ucsi_acpi snd_timer i2c_piix4 k10temp rtsx_pci gpu_sched ccp r8169 typec_ucsi mfd_core snd typec wmi soundcore battery ac video i2c_scmi i2c_multi_instantiate acpi_cpufreq button psmouse serio_raw nvme nvme_core
[   54.672327] CPU: 0 PID: 1624 Comm: hib.sh Tainted: G        W         5.11.0-rc2+ #20
[   54.672327] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W(1.27 ) 10/20/2020
[   54.672327] RIP: 0010:syscore_resume+0x12d/0x160
[   54.672327] Code: ff ff ff 80 3d f7 73 fb 00 00 0f 1f 00 0f 85 3b ff ff ff 48 8b 73 18 48 c7 c7 05 4f 15 82 c6 05 dc 73 fb 00 01 e8 41 2c 2e 00 <0f> 0b e9 1d ff ff ff 80 3d ca 73 fb 00 00 0f 85 d5 fe ff ff 48 c7
[   54.672327] RSP: 0018:ffffc9000184fdd0 EFLAGS: 00010286
[   54.672327] RAX: 0000000000000000 RBX: ffffffff82539960 RCX: 0000000000000000
[   54.672327] RDX: 0000000000000001 RSI: 00000000fff7ffff RDI: 00000000ffffffff
[   54.672327] RBP: 0000000000000003 R08: 0000000000000000 R09: ffffc9000184fc08
[   54.672327] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
[   54.672327] R13: 0000000000000000 R14: ffffc9000184fde8 R15: 0000000000000000
[   54.672327] FS:  00007f902bf1c740(0000) GS:ffff8883fae00000(0000) knlGS:0000000000000000
[   54.672327] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   54.672327] CR2: 00007f902c0de730 CR3: 0000000102a4e000 CR4: 0000000000350ef0
[   54.672327] Call Trace:
[   54.672327]  suspend_devices_and_enter+0x6d4/0x810
[   54.672327]  pm_suspend.cold+0x322/0x37b
[   54.672327]  state_store+0x8b/0x100
[   54.672327]  kernfs_fop_write+0xe5/0x1d0
[   54.672327]  vfs_write+0xf0/0x2c0
[   54.672327]  ksys_write+0x70/0x100
[   54.672327]  ? fpregs_assert_state_consistent+0x1e/0x50
[   54.672327]  do_syscall_64+0x33/0x80
[   54.672327]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   54.672327] RIP: 0033:0x7f902c00ded3
[   54.672327] Code: 8b 15 c1 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
[   54.672327] RSP: 002b:00007ffd25245fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   54.672327] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f902c00ded3
[   54.672327] RDX: 0000000000000004 RSI: 000055e9a5f80a40 RDI: 0000000000000001
[   54.672327] RBP: 000055e9a5f80a40 R08: 000000000000000a R09: 0000000000000003
[   54.672327] R10: 000055e9a5f967f0 R11: 0000000000000246 R12: 0000000000000004
[   54.672327] R13: 00007f902c0de6a0 R14: 0000000000000004 R15: 00007f902c0de8a0
[   54.672327] ---[ end trace 5ad731f459b5e3ba ]---
[   54.672327] LVT offset 0 assigned for vector 0x400
[   54.672327] BUG: using smp_processor_id() in preemptible [00000000] code: hib.sh/1624
[   54.672327] caller is tick_resume_local+0x1e/0x80
[   54.672327] CPU: 0 PID: 1624 Comm: hib.sh Tainted: G        W         5.11.0-rc2+ #20
[   54.672327] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W(1.27 ) 10/20/2020
[   54.672327] Call Trace:
[   54.672327]  dump_stack+0x57/0x6a
[   54.672327]  check_preemption_disabled+0xdd/0xe0
[   54.672327]  tick_resume_local+0x1e/0x80
[   54.672327]  timekeeping_resume+0x111/0x160
[   54.672327]  syscore_resume+0x46/0x160
[   54.672327]  suspend_devices_and_enter+0x6d4/0x810
[   54.672327]  pm_suspend.cold+0x322/0x37b
[   54.672327]  state_store+0x8b/0x100
[   54.672327]  kernfs_fop_write+0xe5/0x1d0
[   54.672327]  vfs_write+0xf0/0x2c0
[   54.672327]  ksys_write+0x70/0x100
[   54.672327]  ? fpregs_assert_state_consistent+0x1e/0x50
[   54.672327]  do_syscall_64+0x33/0x80
[   54.672327]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   54.672327] RIP: 0033:0x7f902c00ded3
[   54.672327] Code: 8b 15 c1 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
[   54.672327] RSP: 002b:00007ffd25245fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   54.672327] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f902c00ded3
[   54.672327] RDX: 0000000000000004 RSI: 000055e9a5f80a40 RDI: 0000000000000001
[   54.672327] RBP: 000055e9a5f80a40 R08: 000000000000000a R09: 0000000000000003
[   54.672327] R10: 000055e9a5f967f0 R11: 0000000000000246 R12: 0000000000000004
[   54.672327] R13: 00007f902c0de6a0 R14: 0000000000000004 R15: 00007f902c0de8a0
[   54.672327] BUG: using __this_cpu_read() in preemptible [00000000] code: hib.sh/1624
[   54.672327] caller is tick_resume_oneshot+0x12/0x40
[   54.672327] CPU: 0 PID: 1624 Comm: hib.sh Tainted: G        W         5.11.0-rc2+ #20
[   54.672327] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W(1.27 ) 10/20/2020
[   54.672327] Call Trace:
[   54.672327]  dump_stack+0x57/0x6a
[   54.672327]  check_preemption_disabled+0xdd/0xe0
[   54.672327]  tick_resume_oneshot+0x12/0x40
[   54.672327]  timekeeping_resume+0x111/0x160
[   54.672327]  syscore_resume+0x46/0x160
[   54.672327]  suspend_devices_and_enter+0x6d4/0x810
[   54.672327]  pm_suspend.cold+0x322/0x37b
[   54.672327]  state_store+0x8b/0x100
[   54.672327]  kernfs_fop_write+0xe5/0x1d0
[   54.672327]  vfs_write+0xf0/0x2c0
[   54.672327]  ksys_write+0x70/0x100
[   54.672327]  ? fpregs_assert_state_consistent+0x1e/0x50
[   54.672327]  do_syscall_64+0x33/0x80
[   54.672327]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   54.672327] RIP: 0033:0x7f902c00ded3
[   54.672327] Code: 8b 15 c1 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
[   54.672327] RSP: 002b:00007ffd25245fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   54.672327] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f902c00ded3
[   54.672327] RDX: 0000000000000004 RSI: 000055e9a5f80a40 RDI: 0000000000000001
[   54.672327] RBP: 000055e9a5f80a40 R08: 000000000000000a R09: 0000000000000003
[   54.672327] R10: 000055e9a5f967f0 R11: 0000000000000246 R12: 0000000000000004
[   54.672327] R13: 00007f902c0de6a0 R14: 0000000000000004 R15: 00007f902c0de8a0
[   54.672327] BUG: using smp_processor_id() in preemptible [00000000] code: hib.sh/1624
[   54.672327] caller is retrigger_next_event+0x12/0x90
[   54.672327] CPU: 0 PID: 1624 Comm: hib.sh Tainted: G        W         5.11.0-rc2+ #20
[   54.672327] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W(1.27 ) 10/20/2020
[   54.672327] Call Trace:
[   54.672327]  dump_stack+0x57/0x6a
[   54.672327]  check_preemption_disabled+0xdd/0xe0
[   54.672327]  retrigger_next_event+0x12/0x90
[   54.672327]  hrtimers_resume+0xc/0x30
[   54.672327]  timekeeping_resume+0x116/0x160
[   54.672327]  syscore_resume+0x46/0x160
[   54.672327]  suspend_devices_and_enter+0x6d4/0x810
[   54.672327]  pm_suspend.cold+0x322/0x37b
[   54.672327]  state_store+0x8b/0x100
[   54.672327]  kernfs_fop_write+0xe5/0x1d0
[   54.672327]  vfs_write+0xf0/0x2c0
[   54.672327]  ksys_write+0x70/0x100
[   54.672327]  ? fpregs_assert_state_consistent+0x1e/0x50
[   54.672327]  do_syscall_64+0x33/0x80
[   54.672327]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   54.672327] RIP: 0033:0x7f902c00ded3
[   54.672327] Code: 8b 15 c1 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
[   54.672327] RSP: 002b:00007ffd25245fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   54.672327] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f902c00ded3
[   54.672327] RDX: 0000000000000004 RSI: 000055e9a5f80a40 RDI: 0000000000000001
[   54.672327] RBP: 000055e9a5f80a40 R08: 000000000000000a R09: 0000000000000003
[   54.672327] R10: 000055e9a5f967f0 R11: 0000000000000246 R12: 0000000000000004
[   54.672327] R13: 00007f902c0de6a0 R14: 0000000000000004 R15: 00007f902c0de8a0
[   54.672327] BUG: using smp_processor_id() in preemptible [00000000] code: hib.sh/1624
[   54.672327] caller is ledtrig_cpu+0x2a/0x100
[   54.672327] CPU: 0 PID: 1624 Comm: hib.sh Tainted: G        W         5.11.0-rc2+ #20
[   54.672327] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W(1.27 ) 10/20/2020
[   54.672327] Call Trace:
[   54.672327]  dump_stack+0x57/0x6a
[   54.672327]  check_preemption_disabled+0xdd/0xe0
[   54.672327]  ledtrig_cpu+0x2a/0x100
[   54.672327]  syscore_resume+0x46/0x160
[   54.672327]  suspend_devices_and_enter+0x6d4/0x810
[   54.672327]  pm_suspend.cold+0x322/0x37b
[   54.672327]  state_store+0x8b/0x100
[   54.672327]  kernfs_fop_write+0xe5/0x1d0
[   54.672327]  vfs_write+0xf0/0x2c0
[   54.672327]  ksys_write+0x70/0x100
[   54.672327]  ? fpregs_assert_state_consistent+0x1e/0x50
[   54.672327]  do_syscall_64+0x33/0x80
[   54.672327]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   54.672327] RIP: 0033:0x7f902c00ded3
[   54.672327] Code: 8b 15 c1 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
[   54.672327] RSP: 002b:00007ffd25245fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   54.672327] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f902c00ded3
[   54.672327] RDX: 0000000000000004 RSI: 000055e9a5f80a40 RDI: 0000000000000001
[   54.672327] RBP: 000055e9a5f80a40 R08: 000000000000000a R09: 0000000000000003
[   54.672327] R10: 000055e9a5f967f0 R11: 0000000000000246 R12: 0000000000000004
[   54.672327] R13: 00007f902c0de6a0 R14: 0000000000000004 R15: 00007f902c0de8a0
[   54.672327] BUG: using smp_processor_id() in preemptible [00000000] code: hib.sh/1624
[   54.672327] caller is machine_check_poll+0x3b/0x230
[   54.672327] CPU: 0 PID: 1624 Comm: hib.sh Tainted: G        W         5.11.0-rc2+ #20
[   54.672327] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W(1.27 ) 10/20/2020
[   54.672327] Call Trace:
[   54.672327]  dump_stack+0x57/0x6a
[   54.672327]  check_preemption_disabled+0xdd/0xe0
[   54.672327]  machine_check_poll+0x3b/0x230
[   54.672327]  ? preempt_count_add+0x68/0xa0
[   54.672327]  __mcheck_cpu_init_generic+0x3d/0xd0
[   54.672327]  mce_syscore_resume+0xa/0x30
[   54.672327]  syscore_resume+0x46/0x160
[   54.672327]  suspend_devices_and_enter+0x6d4/0x810
[   54.672327]  pm_suspend.cold+0x322/0x37b
[   54.672327]  state_store+0x8b/0x100
[   54.672327]  kernfs_fop_write+0xe5/0x1d0
[   54.672327]  vfs_write+0xf0/0x2c0
[   54.672327]  ksys_write+0x70/0x100
[   54.672327]  ? fpregs_assert_state_consistent+0x1e/0x50
[   54.672327]  do_syscall_64+0x33/0x80
[   54.672327]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   54.672327] RIP: 0033:0x7f902c00ded3
[   54.672327] Code: 8b 15 c1 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
[   54.672327] RSP: 002b:00007ffd25245fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   54.672327] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f902c00ded3
[   54.672327] RDX: 0000000000000004 RSI: 000055e9a5f80a40 RDI: 0000000000000001
[   54.672327] RBP: 000055e9a5f80a40 R08: 000000000000000a R09: 0000000000000003
[   54.672327] R10: 000055e9a5f967f0 R11: 0000000000000246 R12: 0000000000000004
[   54.672327] R13: 00007f902c0de6a0 R14: 0000000000000004 R15: 00007f902c0de8a0
[   54.672327] BUG: using smp_processor_id() in preemptible [00000000] code: hib.sh/1624
[   54.672327] caller is mce_setup+0x32/0x100
[   54.672327] CPU: 0 PID: 1624 Comm: hib.sh Tainted: G        W         5.11.0-rc2+ #20
[   54.672327] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W(1.27 ) 10/20/2020
[   54.672327] Call Trace:
[   54.672327]  dump_stack+0x57/0x6a
[   54.672327]  check_preemption_disabled+0xdd/0xe0
[   54.672327]  mce_setup+0x32/0x100
[   54.672327]  machine_check_poll+0x56/0x230
[   54.672327]  __mcheck_cpu_init_generic+0x3d/0xd0
[   54.672327]  mce_syscore_resume+0xa/0x30
[   54.672327]  syscore_resume+0x46/0x160
[   54.672327]  suspend_devices_and_enter+0x6d4/0x810
[   54.672327]  pm_suspend.cold+0x322/0x37b
[   54.672327]  state_store+0x8b/0x100
[   54.672327]  kernfs_fop_write+0xe5/0x1d0
[   54.672327]  vfs_write+0xf0/0x2c0
[   54.672327]  ksys_write+0x70/0x100
[   54.672327]  ? fpregs_assert_state_consistent+0x1e/0x50
[   54.672327]  do_syscall_64+0x33/0x80
[   54.672327]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   54.672327] RIP: 0033:0x7f902c00ded3
[   54.672327] Code: 8b 15 c1 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
[   54.672327] RSP: 002b:00007ffd25245fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   54.672327] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f902c00ded3
[   54.672327] RDX: 0000000000000004 RSI: 000055e9a5f80a40 RDI: 0000000000000001
[   54.672327] RBP: 000055e9a5f80a40 R08: 000000000000000a R09: 0000000000000003
[   54.672327] R10: 000055e9a5f967f0 R11: 0000000000000246 R12: 0000000000000004
[   54.672327] R13: 00007f902c0de6a0 R14: 0000000000000004 R15: 00007f902c0de8a0
[   54.672327] BUG: using __this_cpu_read() in preemptible [00000000] code: hib.sh/1624
[   54.672327] caller is mce_rdmsrl+0x1c/0x80
[   54.672327] CPU: 0 PID: 1624 Comm: hib.sh Tainted: G        W         5.11.0-rc2+ #20
[   54.672327] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W(1.27 ) 10/20/2020
[   54.672327] Call Trace:
[   54.672327]  dump_stack+0x57/0x6a
[   54.672327]  check_preemption_disabled+0xdd/0xe0
[   54.672327]  mce_rdmsrl+0x1c/0x80
[   54.672327]  machine_check_poll+0x60/0x230
[   54.672327]  __mcheck_cpu_init_generic+0x3d/0xd0
[   54.672327]  mce_syscore_resume+0xa/0x30
[   54.672327]  syscore_resume+0x46/0x160
[   54.672327]  suspend_devices_and_enter+0x6d4/0x810
[   54.672327]  pm_suspend.cold+0x322/0x37b
[   54.672327]  state_store+0x8b/0x100
[   54.672327]  kernfs_fop_write+0xe5/0x1d0
[   54.672327]  vfs_write+0xf0/0x2c0
[   54.672327]  ksys_write+0x70/0x100
[   54.672327]  ? fpregs_assert_state_consistent+0x1e/0x50
[   54.672327]  do_syscall_64+0x33/0x80
[   54.672327]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   54.672327] RIP: 0033:0x7f902c00ded3
[   54.672327] Code: 8b 15 c1 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
[   54.672327] RSP: 002b:00007ffd25245fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   54.672327] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f902c00ded3
[   54.672327] RDX: 0000000000000004 RSI: 000055e9a5f80a40 RDI: 0000000000000001
[   54.672327] RBP: 000055e9a5f80a40 R08: 000000000000000a R09: 0000000000000003
[   54.672327] R10: 000055e9a5f967f0 R11: 0000000000000246 R12: 0000000000000004
[   54.672327] R13: 00007f902c0de6a0 R14: 0000000000000004 R15: 00007f902c0de8a0
[   54.672327] BUG: using __this_cpu_read() in preemptible [00000000] code: hib.sh/1624
[   54.672327] caller is mce_rdmsrl+0x1c/0x80
[   54.672327] CPU: 0 PID: 1624 Comm: hib.sh Tainted: G        W         5.11.0-rc2+ #20
[   54.672327] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W(1.27 ) 10/20/2020
[   54.672327] Call Trace:
[   54.672327]  dump_stack+0x57/0x6a
[   54.672327]  check_preemption_disabled+0xdd/0xe0
[   54.672327]  mce_rdmsrl+0x1c/0x80
[   54.672327]  machine_check_poll+0xe9/0x230
[   54.672327]  __mcheck_cpu_init_generic+0x3d/0xd0
[   54.672327]  mce_syscore_resume+0xa/0x30
[   54.672327]  syscore_resume+0x46/0x160
[   54.672327]  suspend_devices_and_enter+0x6d4/0x810
[   54.672327]  pm_suspend.cold+0x322/0x37b
[   54.672327]  state_store+0x8b/0x100
[   54.672327]  kernfs_fop_write+0xe5/0x1d0
[   54.672327]  vfs_write+0xf0/0x2c0
[   54.672327]  ksys_write+0x70/0x100
[   54.672327]  ? fpregs_assert_state_consistent+0x1e/0x50
[   54.672327]  do_syscall_64+0x33/0x80
[   54.672327]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   54.672327] RIP: 0033:0x7f902c00ded3
[   54.672327] Code: 8b 15 c1 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
[   54.672327] RSP: 002b:00007ffd25245fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   54.672327] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f902c00ded3
[   54.672327] RDX: 0000000000000004 RSI: 000055e9a5f80a40 RDI: 0000000000000001
[   54.672327] RBP: 000055e9a5f80a40 R08: 000000000000000a R09: 0000000000000003
[   54.672327] R10: 000055e9a5f967f0 R11: 0000000000000246 R12: 0000000000000004
[   54.672327] R13: 00007f902c0de6a0 R14: 0000000000000004 R15: 00007f902c0de8a0
[   54.672327] BUG: using __this_cpu_read() in preemptible [00000000] code: hib.sh/1624
[   54.672327] caller is mce_rdmsrl+0x1c/0x80
[   54.672327] CPU: 0 PID: 1624 Comm: hib.sh Tainted: G        W         5.11.0-rc2+ #20
[   54.672327] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W(1.27 ) 10/20/2020
[   54.672327] Call Trace:
[   54.672327]  dump_stack+0x57/0x6a
[   54.672327]  check_preemption_disabled+0xdd/0xe0
[   54.672327]  mce_rdmsrl+0x1c/0x80
[   54.672327]  machine_check_poll+0xe9/0x230
[   54.672327]  __mcheck_cpu_init_generic+0x3d/0xd0
[   54.672327]  mce_syscore_resume+0xa/0x30
[   54.672327]  syscore_resume+0x46/0x160
[   54.672327]  suspend_devices_and_enter+0x6d4/0x810
[   54.672327]  pm_suspend.cold+0x322/0x37b
[   54.672327]  state_store+0x8b/0x100
[   54.672327]  kernfs_fop_write+0xe5/0x1d0
[   54.672327]  vfs_write+0xf0/0x2c0
[   54.672327]  ksys_write+0x70/0x100
[   54.672327]  ? fpregs_assert_state_consistent+0x1e/0x50
[   54.672327]  do_syscall_64+0x33/0x80
[   54.672327]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   54.672327] RIP: 0033:0x7f902c00ded3
[   54.672327] Code: 8b 15 c1 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
[   54.672327] RSP: 002b:00007ffd25245fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   54.672327] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f902c00ded3
[   54.672327] RDX: 0000000000000004 RSI: 000055e9a5f80a40 RDI: 0000000000000001
[   54.672327] RBP: 000055e9a5f80a40 R08: 000000000000000a R09: 0000000000000003
[   54.672327] R10: 000055e9a5f967f0 R11: 0000000000000246 R12: 0000000000000004
[   54.672327] R13: 00007f902c0de6a0 R14: 0000000000000004 R15: 00007f902c0de8a0
[   54.672327] BUG: using __this_cpu_read() in preemptible [00000000] code: hib.sh/1624
[   54.672327] caller is mce_rdmsrl+0x1c/0x80
[   54.672327] CPU: 0 PID: 1624 Comm: hib.sh Tainted: G        W         5.11.0-rc2+ #20
[   54.672327] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC, BIOS R1BET58W(1.27 ) 10/20/2020
[   54.672327] Call Trace:
[   54.672327]  dump_stack+0x57/0x6a
[   54.672327]  check_preemption_disabled+0xdd/0xe0
[   54.672327]  mce_rdmsrl+0x1c/0x80
[   54.672327]  machine_check_poll+0xe9/0x230
[   54.672327]  __mcheck_cpu_init_generic+0x3d/0xd0
[   54.672327]  mce_syscore_resume+0xa/0x30
[   54.672327]  syscore_resume+0x46/0x160
[   54.672327]  suspend_devices_and_enter+0x6d4/0x810
[   54.672327]  pm_suspend.cold+0x322/0x37b
[   54.672327]  state_store+0x8b/0x100
[   54.672327]  kernfs_fop_write+0xe5/0x1d0
[   54.672327]  vfs_write+0xf0/0x2c0
[   54.672327]  ksys_write+0x70/0x100
[   54.672327]  ? fpregs_assert_state_consistent+0x1e/0x50
[   54.672327]  do_syscall_64+0x33/0x80
[   54.672327]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   54.672327] RIP: 0033:0x7f902c00ded3
[   54.672327] Code: 8b 15 c1 ef 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
[   54.672327] RSP: 002b:00007ffd25245fa8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   54.672327] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f902c00ded3
[   54.672327] RDX: 0000000000000004 RSI: 000055e9a5f80a40 RDI: 0000000000000001
[   54.672327] RBP: 000055e9a5f80a40 R08: 000000000000000a R09: 0000000000000003
[   54.672327] R10: 000055e9a5f967f0 R11: 0000000000000246 R12: 0000000000000004
[   54.672327] R13: 00007f902c0de6a0 R14: 0000000000000004 R15: 00007f902c0de8a0
[   54.673300] Enabling non-boot CPUs ...
[   54.673315] x86: Booting SMP configuration:
[   54.673316] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   54.643745] microcode: CPU1: patch_level=0x08600106
[   54.673677] ACPI: \_SB_.PLTF.C001: Found 3 idle states
[   54.673939] CPU1 is up
[   54.673966] smpboot: Booting Node 0 Processor 2 APIC 0x2
[   54.673599] microcode: CPU2: patch_level=0x08600106
[   54.674326] ACPI: \_SB_.PLTF.C002: Found 3 idle states
[   54.674565] CPU2 is up
[   54.674578] smpboot: Booting Node 0 Processor 3 APIC 0x3
[   54.674197] microcode: CPU3: patch_level=0x08600106
[   54.674946] ACPI: \_SB_.PLTF.C003: Found 3 idle states
[   54.675181] CPU3 is up
[   54.675195] smpboot: Booting Node 0 Processor 4 APIC 0x4
[   54.674822] microcode: CPU4: patch_level=0x08600106
[   54.675829] ACPI: \_SB_.PLTF.C004: Found 3 idle states
[   54.676084] CPU4 is up
[   54.676097] smpboot: Booting Node 0 Processor 5 APIC 0x5
[   54.675698] microcode: CPU5: patch_level=0x08600106
[   54.676457] ACPI: \_SB_.PLTF.C005: Found 3 idle states
[   54.676699] CPU5 is up
[   54.676713] smpboot: Booting Node 0 Processor 6 APIC 0x6
[   54.676328] microcode: CPU6: patch_level=0x08600106
[   54.677073] ACPI: \_SB_.PLTF.C006: Found 3 idle states
[   54.677367] CPU6 is up
[   54.677392] smpboot: Booting Node 0 Processor 7 APIC 0x7
[   54.676950] microcode: CPU7: patch_level=0x08600106
[   54.677755] ACPI: \_SB_.PLTF.C007: Found 3 idle states
[   54.677929] CPU7 is up
[   54.677948] smpboot: Booting Node 0 Processor 8 APIC 0x8
[   54.677634] microcode: CPU8: patch_level=0x08600106
[   54.678265] ACPI: \_SB_.PLTF.C008: Found 3 idle states
[   54.678461] CPU8 is up
[   54.678477] smpboot: Booting Node 0 Processor 9 APIC 0x9
[   54.678167] microcode: CPU9: patch_level=0x08600106
[   54.678880] ACPI: \_SB_.PLTF.C009: Found 3 idle states
[   54.679319] CPU9 is up
[   54.679336] smpboot: Booting Node 0 Processor 10 APIC 0xa
[   54.678701] microcode: CPU10: patch_level=0x08600106
[   54.679870] ACPI: \_SB_.PLTF.C00A: Found 3 idle states
[   54.680220] CPU10 is up
[   54.680235] smpboot: Booting Node 0 Processor 11 APIC 0xb
[   54.679806] microcode: CPU11: patch_level=0x08600106
[   54.680694] ACPI: \_SB_.PLTF.C00B: Found 3 idle states
[   54.681062] CPU11 is up
[   54.681077] smpboot: Booting Node 0 Processor 12 APIC 0xc
[   54.680546] microcode: CPU12: patch_level=0x08600106
[   54.681537] ACPI: \_SB_.PLTF.C00C: Found 3 idle states
[   54.681808] CPU12 is up
[   54.681825] smpboot: Booting Node 0 Processor 13 APIC 0xd
[   54.681386] microcode: CPU13: patch_level=0x08600106
[   54.682157] ACPI: \_SB_.PLTF.C00D: Found 3 idle states
[   54.682390] CPU13 is up
[   54.682401] smpboot: Booting Node 0 Processor 14 APIC 0xe
[   54.682050] microcode: CPU14: patch_level=0x08600106
[   54.682855] ACPI: \_SB_.PLTF.C00E: Found 3 idle states
[   54.683273] CPU14 is up
[   54.683282] smpboot: Booting Node 0 Processor 15 APIC 0xf
[   54.682713] microcode: CPU15: patch_level=0x08600106
[   54.683743] ACPI: \_SB_.PLTF.C00F: Found 3 idle states
[   54.684047] CPU15 is up
[   54.684952] ACPI: Waking up from system sleep state S3
[   55.244544] ACPI: EC: interrupt unblocked
[   55.302755] ACPI: EC: event unblocked
[   55.303068] pci 0000:00:00.2: can't derive routing for PCI INT A
[   55.303087] pci 0000:00:00.2: PCI INT A: no GSI
[   55.303153] usb usb1: root hub lost power or was reset
[   55.304815] [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
[   55.304926] [drm] PSP is resuming...
[   55.313715] nvme nvme0: Shutdown timeout set to 8 seconds
[   55.324821] [drm] reserve 0x400000 from 0xf41f800000 for PSP TMR
[   55.331406] nvme nvme0: 16/0/0 default/read/poll queues
[   55.501530] r8169 0000:05:00.0 eth1: Link is Down
[   55.561597] amdgpu 0000:06:00.0: amdgpu: SMU is resuming...
[   55.561666] amdgpu 0000:06:00.0: amdgpu: dpm has been disabled
[   55.562852] amdgpu 0000:06:00.0: amdgpu: SMU is resumed successfully!
[   55.564213] [drm] kiq ring mec 2 pipe 1 q 0
[   55.577453] [drm] DMUB hardware initialized: version=0x01000000
[   55.831146] [drm] VCN decode and encode initialized successfully(under DPG Mode).
[   55.831449] [drm] JPEG decode initialized successfully.
[   55.831713] amdgpu 0000:06:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
[   55.831717] amdgpu 0000:06:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
[   55.831719] amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
[   55.831721] amdgpu 0000:06:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
[   55.831723] amdgpu 0000:06:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
[   55.831725] amdgpu 0000:06:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
[   55.831727] amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
[   55.831729] amdgpu 0000:06:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
[   55.831731] amdgpu 0000:06:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
[   55.831733] amdgpu 0000:06:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
[   55.831736] amdgpu 0000:06:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
[   55.831738] amdgpu 0000:06:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
[   55.831739] amdgpu 0000:06:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
[   55.831741] amdgpu 0000:06:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
[   55.831743] amdgpu 0000:06:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
[   56.361789] psmouse serio1: synaptics: queried max coordinates: x [..5678], y [..4694]
[   56.404165] psmouse serio1: synaptics: queried min coordinates: x [1266..], y [1162..]
[   56.544123] acpi LNXPOWER:07: Turning OFF
[   56.546346] acpi LNXPOWER:05: Turning OFF
[   56.548656] acpi LNXPOWER:02: Turning OFF
[   56.550774] acpi LNXPOWER:01: Turning OFF
[   56.552942] OOM killer enabled.
[   56.554055] pci_bus 0000:01: Allocating resources
[   56.555046] Restarting tasks ... 
[   56.557607] pcieport 0000:00:02.1: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
[   56.557628] done.
[   56.560110] pcieport 0000:00:02.1: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
[   56.562377] thermal thermal_zone0: failed to read out thermal zone (-61)
[   56.564473] pci_bus 0000:02: Allocating resources
[   56.564496] pcieport 0000:00:02.2: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
[   56.573630] pci_bus 0000:03: Allocating resources
[   56.574092] pci_bus 0000:04: Allocating resources
[   56.574098] pcieport 0000:00:02.4: bridge window [io  0x1000-0x0fff] to [bus 04] add_size 1000
[   56.574103] pcieport 0000:00:02.4: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 04] add_size 200000 add_align 100000
[   56.574112] pci_bus 0000:05: Allocating resources
[   56.574117] pcieport 0000:00:02.6: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 05] add_size 200000 add_align 100000
[   56.588379] pcieport 0000:00:02.1: BAR 15: assigned [mem 0x430200000-0x4303fffff 64bit pref]
[   56.588400] pcieport 0000:00:02.2: BAR 15: assigned [mem 0x430400000-0x4305fffff 64bit pref]
[   56.588416] pcieport 0000:00:02.4: BAR 15: assigned [mem 0x430600000-0x4307fffff 64bit pref]
[   56.588433] pcieport 0000:00:02.6: BAR 15: assigned [mem 0x430800000-0x4309fffff 64bit pref]
[   56.588443] pcieport 0000:00:02.1: BAR 13: assigned [io  0x5000-0x5fff]
[   56.588448] pcieport 0000:00:02.4: BAR 13: assigned [io  0x6000-0x6fff]
[   56.588717] pci_bus 0000:06: Allocating resources
[   56.622533] PM: suspend exit
[   57.144160] r8169 0000:05:00.0 eth1: Link is Up - 100Mbps/Full - flow control rx/tx


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
