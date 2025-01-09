Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECE42F2D;
	Thu,  9 Jan 2025 08:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412750; cv=none; b=DE1cqCQjKnBatquJQ2Bq8FhgHkODU80gIntCPhRZk5twXKTiP8/iEmSR/iBlxrpZJDOi5XjzrBePjp9sOtoxw/OkZ+0tWFMZz0TTLbLvDYVPxmshfiqOUAJiMzrgNKu5cQ1ZVlZyMknNyq/mYoCd3PitnAgHlIyeKo+Vd7fhfmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412750; c=relaxed/simple;
	bh=ble1xGj60v4Mm0xF0dvHJcDp2NkWzwBoNY3PMnYu6a8=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=CZf5BQkRxBHz2PM6IXpVA3pL1RfxSoxBStsA2gVOeTgG2CIw69KdooXPE4gg7BBB+49KV4ztit2rc5C2RzfGbGbrU1osvsbQOg2gq93NmW37+TtIfTmbu0vE59Ferg92NPCc4gvrpOIo6eRY8TBycdqGQxltfvN+ZaDhVNHaNAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=WeS5ZLus; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="WeS5ZLus"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Content-Type:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=D/yG2xxpT+xoDyD7C1WES96vvGDZf6VfFmqOx4SGcfY=; t=1736412748; x=1736844748; 
	b=WeS5ZLus3xIuTOrT827Q2whlX082AOvjKnQCMz3JSW3sS4rgDxG3E+2qOvobOM/EM0uOmHkl9f8
	6LO72oQGMfZ472BspXC1dpWLRwUOBRjFDzSFXDMTcOz4VrUFsRL36J/uH27WqluRgg+1rZuUibsTz
	7O/b4wZGsw3efuHz7EEpUWaQKVOo5/6cWk+49mOOgx62FbPvYTEAOaKe0dB0PzmlF1caFWRKMKi5C
	WjK2x1FL4jyDa+HcAnKJkG9nEPLln20TTir4A5NLjS3W79mPh4dNQSzaW//pcKLAsZWMhm/bw4ilM
	jv35njIYFZDM6g51S8p/FHJqEgQH3Qb5iXZQ==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1tVoH8-00AK1y-2R;
	Thu, 09 Jan 2025 09:52:22 +0100
Content-Type: multipart/mixed; boundary="------------yG0qJU9teIDhGcLuyuwkHaCp"
Message-ID: <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info>
Date: Thu, 9 Jan 2025 09:52:22 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Regression] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Adrian Huang <ahuang12@lenovo.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>, linux-kernel@simg.de, bgravato@gmail.com
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20250109082849.GC20724@lst.de>
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1736412748;09771240;
X-HE-SMSGID: 1tVoH8-00AK1y-2R

This is a multi-part message in MIME format.
--------------yG0qJU9teIDhGcLuyuwkHaCp
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[CCing the people from
https://bugzilla.kernel.org/show_bug.cgi?id=219609, as they permitted that.

Stefan, Bruno, reminder: some developers might not follow the ticket or
unwilling to go to a web-based bug tracker; so any answers to questions
that are raised here via email might not be seen if you only provide
them in the bug tracker; yes, that sucks, but that's how it is for now;
hopefully things on that front will improve soon.]

On 09.01.25 09:28, Christoph Hellwig wrote:
> On Wed, Jan 08, 2025 at 08:07:28AM -0700, Keith Busch wrote:
>> It should always be okay to do smaller transfers as long as everything
>> stays aligned the logical block size. I'm guessing the dma opt change
>> has exposed some other flaw in the nvme controller. For example, two
>> consecutive smaller writes are hitting some controller side caching bug
>> that a single larger trasnfer would have handled correctly. The host
>> could have sent such a sequence even without the patch reverted, but
>> happens to not be doing that in this particular test.
> 
> Yes.  This somehow reminds of the bug with an Intel SSD that got
> really upset with quickly following writes to different LBAs inside the
> same indirection unit.  But as the new smaller size is nicely aligned
> that seems unlikely.  Maybe the higher number of commands simply overloads
> the buggy firmware?

Thx for the assessment. FWIW, I bought such a machine myself recently
and it's still in a state where I could abandon the install. I haven't
checked yet if mine is affected, too.

> Of course the real question is why we're even seeing the limitation.
> The value suggests it's the swiotlb one.  Does the system use AMD SEV
> (memory encryption)?

In case it is helpful to anyone: there are some logs buried deep in
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1076372 I'm attaching
one of the kernel logs I found there (there were multiple ones; hope I
picked a appropriate one) for easier access.

Ciao, Thorsten
--------------yG0qJU9teIDhGcLuyuwkHaCp
Content-Type: application/x-troff-man; name="kern.log-6.11.5"
Content-Disposition: attachment; filename="kern.log-6.11.5"
Content-Transfer-Encoding: 7bit

2024-11-25T17:49:56.681779+01:00 ws7 kernel: [    0.000000] Linux version 6.11.5 (stefan@ws7) (gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #2 SMP PREEMPT_DYNAMIC Mon Nov 25 17:11:04 CET 2024
2024-11-25T17:49:56.681850+01:00 ws7 kernel: [    0.000000] Command line: initrd=\6.11.5\initrd root=/dev/disk/by-id/nvme-Lexar_SSD_NM790_4TB_NHG456R005482P2202_1-part2 ro usbcore.autosuspend=-1 video=HDMI-A-1:1600x1200D
2024-11-25T17:49:56.681851+01:00 ws7 kernel: [    0.000000] BIOS-provided physical RAM map:
2024-11-25T17:49:56.681852+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
2024-11-25T17:49:56.681852+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
2024-11-25T17:49:56.681852+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009afefff] usable
2024-11-25T17:49:56.681853+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x0000000009aff000-0x0000000009ffffff] reserved
2024-11-25T17:49:56.681855+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x000000000a000000-0x000000000a1fffff] usable
2024-11-25T17:49:56.681856+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x000000000a200000-0x000000000a20bfff] ACPI NVS
2024-11-25T17:49:56.681856+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x000000000a20c000-0x000000008567efff] usable
2024-11-25T17:49:56.681856+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x000000008567f000-0x000000008b67efff] reserved
2024-11-25T17:49:56.681856+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x000000008b67f000-0x000000008d67efff] ACPI data
2024-11-25T17:49:56.681857+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x000000008d67f000-0x000000008f67efff] ACPI NVS
2024-11-25T17:49:56.681859+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x000000008f67f000-0x00000000977fefff] reserved
2024-11-25T17:49:56.681859+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x00000000977ff000-0x0000000099ff9fff] usable
2024-11-25T17:49:56.681859+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x0000000099ffa000-0x0000000099ffcfff] reserved
2024-11-25T17:49:56.681860+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x0000000099ffd000-0x0000000099ffffff] usable
2024-11-25T17:49:56.681860+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x000000009a000000-0x000000009bffffff] reserved
2024-11-25T17:49:56.681866+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x000000009d790000-0x000000009d7effff] reserved
2024-11-25T17:49:56.681868+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x000000009d7f5000-0x000000009fffffff] reserved
2024-11-25T17:49:56.681869+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
2024-11-25T17:49:56.681869+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x00000000f7000000-0x00000000ffffffff] reserved
2024-11-25T17:49:56.681869+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000017de2fffff] usable
2024-11-25T17:49:56.681869+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x00000017df340000-0x00000018801fffff] reserved
2024-11-25T17:49:56.681869+01:00 ws7 kernel: [    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000ffffffffff] reserved
2024-11-25T17:49:56.681870+01:00 ws7 kernel: [    0.000000] NX (Execute Disable) protection: active
2024-11-25T17:49:56.681872+01:00 ws7 kernel: [    0.000000] APIC: Static calls initialized
2024-11-25T17:49:56.681872+01:00 ws7 kernel: [    0.000000] e820: update [mem 0x7e09c018-0x7e0a0257] usable ==> usable
2024-11-25T17:49:56.681873+01:00 ws7 kernel: [    0.000000] extended physical RAM map:
2024-11-25T17:49:56.681873+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] usable
2024-11-25T17:49:56.681873+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
2024-11-25T17:49:56.681873+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000009afefff] usable
2024-11-25T17:49:56.681876+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x0000000009aff000-0x0000000009ffffff] reserved
2024-11-25T17:49:56.681876+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x000000000a000000-0x000000000a1fffff] usable
2024-11-25T17:49:56.681876+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x000000000a200000-0x000000000a20bfff] ACPI NVS
2024-11-25T17:49:56.681877+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x000000000a20c000-0x000000007e09c017] usable
2024-11-25T17:49:56.681877+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x000000007e09c018-0x000000007e0a0257] usable
2024-11-25T17:49:56.681877+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x000000007e0a0258-0x000000008567efff] usable
2024-11-25T17:49:56.681877+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x000000008567f000-0x000000008b67efff] reserved
2024-11-25T17:49:56.681879+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x000000008b67f000-0x000000008d67efff] ACPI data
2024-11-25T17:49:56.681880+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x000000008d67f000-0x000000008f67efff] ACPI NVS
2024-11-25T17:49:56.681880+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x000000008f67f000-0x00000000977fefff] reserved
2024-11-25T17:49:56.681880+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x00000000977ff000-0x0000000099ff9fff] usable
2024-11-25T17:49:56.681881+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x0000000099ffa000-0x0000000099ffcfff] reserved
2024-11-25T17:49:56.681881+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x0000000099ffd000-0x0000000099ffffff] usable
2024-11-25T17:49:56.681883+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x000000009a000000-0x000000009bffffff] reserved
2024-11-25T17:49:56.681884+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x000000009d790000-0x000000009d7effff] reserved
2024-11-25T17:49:56.681884+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x000000009d7f5000-0x000000009fffffff] reserved
2024-11-25T17:49:56.681884+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x00000000e0000000-0x00000000efffffff] reserved
2024-11-25T17:49:56.681884+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x00000000f7000000-0x00000000ffffffff] reserved
2024-11-25T17:49:56.681885+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x0000000100000000-0x00000017de2fffff] usable
2024-11-25T17:49:56.681887+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x00000017df340000-0x00000018801fffff] reserved
2024-11-25T17:49:56.681887+01:00 ws7 kernel: [    0.000000] reserve setup_data: [mem 0x000000fd00000000-0x000000ffffffffff] reserved
2024-11-25T17:49:56.681887+01:00 ws7 kernel: [    0.000000] efi: EFI v2.9 by American Megatrends
2024-11-25T17:49:56.681888+01:00 ws7 kernel: [    0.000000] efi: ACPI=0x8f666000 ACPI 2.0=0x8f666014 TPMFinalLog=0x8f633000 SMBIOS=0x974d8000 SMBIOS 3.0=0x974d7000 MEMATTR=0x7fe40698 ESRT=0x7fe8be18 INITRD=0x7e0a2f18 RNG=0x8cdaa018 TPMEventLog=0x8cda9018 
2024-11-25T17:49:56.681888+01:00 ws7 kernel: [    0.000000] random: crng init done
2024-11-25T17:49:56.681888+01:00 ws7 kernel: [    0.000000] efi: Remove mem50: MMIO range=[0xe0000000-0xefffffff] (256MB) from e820 map
2024-11-25T17:49:56.681890+01:00 ws7 kernel: [    0.000000] e820: remove [mem 0xe0000000-0xefffffff] reserved
2024-11-25T17:49:56.681891+01:00 ws7 kernel: [    0.000000] efi: Remove mem51: MMIO range=[0xf7000000-0xfedfffff] (126MB) from e820 map
2024-11-25T17:49:56.681891+01:00 ws7 kernel: [    0.000000] e820: remove [mem 0xf7000000-0xfedfffff] reserved
2024-11-25T17:49:56.681891+01:00 ws7 kernel: [    0.000000] efi: Not removing mem52: MMIO range=[0xfee00000-0xfee00fff] (4KB) from e820 map
2024-11-25T17:49:56.681891+01:00 ws7 kernel: [    0.000000] efi: Remove mem53: MMIO range=[0xfee01000-0xffffffff] (17MB) from e820 map
2024-11-25T17:49:56.681892+01:00 ws7 kernel: [    0.000000] e820: remove [mem 0xfee01000-0xffffffff] reserved
2024-11-25T17:49:56.681892+01:00 ws7 kernel: [    0.000000] efi: Remove mem55: MMIO range=[0x1860000000-0x18801fffff] (514MB) from e820 map
2024-11-25T17:49:56.681894+01:00 ws7 kernel: [    0.000000] e820: remove [mem 0x1860000000-0x18801fffff] reserved
2024-11-25T17:49:56.681894+01:00 ws7 kernel: [    0.000000] SMBIOS 3.4.0 present.
2024-11-25T17:49:56.681894+01:00 ws7 kernel: [    0.000000] DMI: ASRock X600M-STX/X600M-STX, BIOS 4.03 07/11/2024
2024-11-25T17:49:56.681895+01:00 ws7 kernel: [    0.000000] DMI: Memory slots populated: 2/2
2024-11-25T17:49:56.681895+01:00 ws7 kernel: [    0.000000] tsc: Fast TSC calibration using PIT
2024-11-25T17:49:56.681895+01:00 ws7 kernel: [    0.000000] tsc: Detected 4199.969 MHz processor
2024-11-25T17:49:56.681897+01:00 ws7 kernel: [    0.000067] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
2024-11-25T17:49:56.681897+01:00 ws7 kernel: [    0.000069] e820: remove [mem 0x000a0000-0x000fffff] usable
2024-11-25T17:49:56.681898+01:00 ws7 kernel: [    0.000073] last_pfn = 0x17de300 max_arch_pfn = 0x400000000
2024-11-25T17:49:56.681898+01:00 ws7 kernel: [    0.000076] MTRR map: 6 entries (3 fixed + 3 variable; max 20), built from 9 variable MTRRs
2024-11-25T17:49:56.681898+01:00 ws7 kernel: [    0.000077] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
2024-11-25T17:49:56.681898+01:00 ws7 kernel: [    0.000247] last_pfn = 0x9a000 max_arch_pfn = 0x400000000
2024-11-25T17:49:56.681899+01:00 ws7 kernel: [    0.002542] esrt: Reserving ESRT space from 0x000000007fe8be18 to 0x000000007fe8be50.
2024-11-25T17:49:56.681901+01:00 ws7 kernel: [    0.002546] e820: update [mem 0x7fe8b000-0x7fe8bfff] usable ==> reserved
2024-11-25T17:49:56.681901+01:00 ws7 kernel: [    0.002555] Using GB pages for direct mapping
2024-11-25T17:49:56.681901+01:00 ws7 kernel: [    0.003052] Secure boot disabled
2024-11-25T17:49:56.681901+01:00 ws7 kernel: [    0.003053] RAMDISK: [mem 0x79cea000-0x7cdacfff]
2024-11-25T17:49:56.681902+01:00 ws7 kernel: [    0.003057] ACPI: Early table checksum verification disabled
2024-11-25T17:49:56.681902+01:00 ws7 kernel: [    0.003059] ACPI: RSDP 0x000000008F666014 000024 (v02 ALASKA)
2024-11-25T17:49:56.681904+01:00 ws7 kernel: [    0.003062] ACPI: XSDT 0x000000008F665728 0000D4 (v01 ALASKA A M I    00000001 AMI  01000013)
2024-11-25T17:49:56.681904+01:00 ws7 kernel: [    0.003065] ACPI: FACP 0x000000008D674000 000114 (v06 ALASKA A M I    00000001 AMI  00010013)
2024-11-25T17:49:56.681905+01:00 ws7 kernel: [    0.003068] ACPI: DSDT 0x000000008D5EF000 07B9FF (v02 ALASKA A M I    00000001 INTL 20220331)
2024-11-25T17:49:56.681905+01:00 ws7 kernel: [    0.003069] ACPI: FACS 0x000000008F663000 000040
2024-11-25T17:49:56.681905+01:00 ws7 kernel: [    0.003070] ACPI: SSDT 0x000000008D676000 00837C (v02 AMD    Splinter 00000002 MSFT 04000000)
2024-11-25T17:49:56.681905+01:00 ws7 kernel: [    0.003071] ACPI: SSDT 0x000000008D675000 000221 (v02 ALASKA CPUSSDT  00000001 AMI  00000001)
2024-11-25T17:49:56.681907+01:00 ws7 kernel: [    0.003072] ACPI: FIDT 0x000000008D66E000 00009C (v01 ALASKA A M I    00000001 AMI  00010013)
2024-11-25T17:49:56.681908+01:00 ws7 kernel: [    0.003074] ACPI: MCFG 0x000000008D66D000 00003C (v01 ALASKA A M I    00000001 MSFT 00010013)
2024-11-25T17:49:56.681908+01:00 ws7 kernel: [    0.003075] ACPI: HPET 0x000000008D66C000 000038 (v01 ALASKA A M I    00000001 AMI  00000005)
2024-11-25T17:49:56.681908+01:00 ws7 kernel: [    0.003076] ACPI: FPDT 0x000000008D66B000 000044 (v01 ALASKA A M I    01072009 AMI  01000013)
2024-11-25T17:49:56.681908+01:00 ws7 kernel: [    0.003077] ACPI: VFCT 0x000000008D66F000 004284 (v01 ALASKA A M I    00000001 AMD  33504F47)
2024-11-25T17:49:56.681909+01:00 ws7 kernel: [    0.003078] ACPI: TPM2 0x000000008D5EE000 00004C (v04 ALASKA A M I    00000001 AMI  00000000)
2024-11-25T17:49:56.681909+01:00 ws7 kernel: [    0.003079] ACPI: SSDT 0x000000008D5E8000 00547E (v02 AMD    AMD CPU  00000001 AMD  00000001)
2024-11-25T17:49:56.681992+01:00 ws7 kernel: [    0.003080] ACPI: WPBT 0x000000008CDC4000 000036 (v01 ALASKA A M I    00000001 MSFT 00010013)
2024-11-25T17:49:56.681992+01:00 ws7 kernel: [    0.003081] ACPI: SSDT 0x000000008CDC3000 000CDE (v02 AMD    OEMACP   00000001 INTL 20220331)
2024-11-25T17:49:56.681993+01:00 ws7 kernel: [    0.003082] ACPI: SSDT 0x000000008CDC2000 0006D4 (v02 AMD    CPMWLRC  00000001 INTL 20220331)
2024-11-25T17:49:56.681993+01:00 ws7 kernel: [    0.003083] ACPI: SSDT 0x000000008CDC0000 00169E (v02 AMD    CPMDFIG2 00000001 INTL 20220331)
2024-11-25T17:49:56.681993+01:00 ws7 kernel: [    0.003085] ACPI: SSDT 0x000000008CDBD000 002AA6 (v02 AMD    CDFAAIG2 00000001 INTL 20220331)
2024-11-25T17:49:56.681993+01:00 ws7 kernel: [    0.003086] ACPI: SSDT 0x000000008CDB3000 009A6C (v02 AMD    CPMCMN   00000001 INTL 20220331)
2024-11-25T17:49:56.681995+01:00 ws7 kernel: [    0.003087] ACPI: SSDT 0x000000008CDB0000 002345 (v02 AMD    AOD      00000001 INTL 20220331)
2024-11-25T17:49:56.681996+01:00 ws7 kernel: [    0.003088] ACPI: WSMT 0x000000008CDAF000 000028 (v01 ALASKA A M I    00000001 AMI  00010013)
2024-11-25T17:49:56.681996+01:00 ws7 kernel: [    0.003089] ACPI: APIC 0x000000008CDAE000 00015E (v06 ALASKA A M I    00000001 AMI  00010013)
2024-11-25T17:49:56.681996+01:00 ws7 kernel: [    0.003090] ACPI: IVRS 0x000000008CDAD000 0000C8 (v02 AMD    AmdTable 00000001 AMD  00000001)
2024-11-25T17:49:56.681996+01:00 ws7 kernel: [    0.003091] ACPI: SSDT 0x000000008CDAC000 000500 (v02 AMD    MEMTOOL0 00000002 INTL 20220331)
2024-11-25T17:49:56.681997+01:00 ws7 kernel: [    0.003092] ACPI: SSDT 0x000000008CDAB000 00047C (v02 AMD    AMDWOV   00000001 INTL 20220331)
2024-11-25T17:49:56.681997+01:00 ws7 kernel: [    0.003093] ACPI: Reserving FACP table memory at [mem 0x8d674000-0x8d674113]
2024-11-25T17:49:56.681999+01:00 ws7 kernel: [    0.003094] ACPI: Reserving DSDT table memory at [mem 0x8d5ef000-0x8d66a9fe]
2024-11-25T17:49:56.681999+01:00 ws7 kernel: [    0.003094] ACPI: Reserving FACS table memory at [mem 0x8f663000-0x8f66303f]
2024-11-25T17:49:56.682000+01:00 ws7 kernel: [    0.003095] ACPI: Reserving SSDT table memory at [mem 0x8d676000-0x8d67e37b]
2024-11-25T17:49:56.682000+01:00 ws7 kernel: [    0.003095] ACPI: Reserving SSDT table memory at [mem 0x8d675000-0x8d675220]
2024-11-25T17:49:56.682000+01:00 ws7 kernel: [    0.003095] ACPI: Reserving FIDT table memory at [mem 0x8d66e000-0x8d66e09b]
2024-11-25T17:49:56.682000+01:00 ws7 kernel: [    0.003096] ACPI: Reserving MCFG table memory at [mem 0x8d66d000-0x8d66d03b]
2024-11-25T17:49:56.682002+01:00 ws7 kernel: [    0.003096] ACPI: Reserving HPET table memory at [mem 0x8d66c000-0x8d66c037]
2024-11-25T17:49:56.682003+01:00 ws7 kernel: [    0.003096] ACPI: Reserving FPDT table memory at [mem 0x8d66b000-0x8d66b043]
2024-11-25T17:49:56.682003+01:00 ws7 kernel: [    0.003096] ACPI: Reserving VFCT table memory at [mem 0x8d66f000-0x8d673283]
2024-11-25T17:49:56.682003+01:00 ws7 kernel: [    0.003097] ACPI: Reserving TPM2 table memory at [mem 0x8d5ee000-0x8d5ee04b]
2024-11-25T17:49:56.682003+01:00 ws7 kernel: [    0.003097] ACPI: Reserving SSDT table memory at [mem 0x8d5e8000-0x8d5ed47d]
2024-11-25T17:49:56.682004+01:00 ws7 kernel: [    0.003097] ACPI: Reserving WPBT table memory at [mem 0x8cdc4000-0x8cdc4035]
2024-11-25T17:49:56.682006+01:00 ws7 kernel: [    0.003098] ACPI: Reserving SSDT table memory at [mem 0x8cdc3000-0x8cdc3cdd]
2024-11-25T17:49:56.682006+01:00 ws7 kernel: [    0.003098] ACPI: Reserving SSDT table memory at [mem 0x8cdc2000-0x8cdc26d3]
2024-11-25T17:49:56.682006+01:00 ws7 kernel: [    0.003098] ACPI: Reserving SSDT table memory at [mem 0x8cdc0000-0x8cdc169d]
2024-11-25T17:49:56.682006+01:00 ws7 kernel: [    0.003099] ACPI: Reserving SSDT table memory at [mem 0x8cdbd000-0x8cdbfaa5]
2024-11-25T17:49:56.682007+01:00 ws7 kernel: [    0.003099] ACPI: Reserving SSDT table memory at [mem 0x8cdb3000-0x8cdbca6b]
2024-11-25T17:49:56.682007+01:00 ws7 kernel: [    0.003099] ACPI: Reserving SSDT table memory at [mem 0x8cdb0000-0x8cdb2344]
2024-11-25T17:49:56.682007+01:00 ws7 kernel: [    0.003099] ACPI: Reserving WSMT table memory at [mem 0x8cdaf000-0x8cdaf027]
2024-11-25T17:49:56.682009+01:00 ws7 kernel: [    0.003100] ACPI: Reserving APIC table memory at [mem 0x8cdae000-0x8cdae15d]
2024-11-25T17:49:56.682010+01:00 ws7 kernel: [    0.003100] ACPI: Reserving IVRS table memory at [mem 0x8cdad000-0x8cdad0c7]
2024-11-25T17:49:56.682010+01:00 ws7 kernel: [    0.003100] ACPI: Reserving SSDT table memory at [mem 0x8cdac000-0x8cdac4ff]
2024-11-25T17:49:56.682010+01:00 ws7 kernel: [    0.003101] ACPI: Reserving SSDT table memory at [mem 0x8cdab000-0x8cdab47b]
2024-11-25T17:49:56.682010+01:00 ws7 kernel: [    0.003156] No NUMA configuration found
2024-11-25T17:49:56.682011+01:00 ws7 kernel: [    0.003157] Faking a node at [mem 0x0000000000000000-0x00000017de2fffff]
2024-11-25T17:49:56.682013+01:00 ws7 kernel: [    0.003160] NODE_DATA(0) allocated [mem 0x17de2d5000-0x17de2fffff]
2024-11-25T17:49:56.682013+01:00 ws7 kernel: [    0.003293] Zone ranges:
2024-11-25T17:49:56.682014+01:00 ws7 kernel: [    0.003294]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
2024-11-25T17:49:56.682014+01:00 ws7 kernel: [    0.003295]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
2024-11-25T17:49:56.682014+01:00 ws7 kernel: [    0.003295]   Normal   [mem 0x0000000100000000-0x00000017de2fffff]
2024-11-25T17:49:56.682014+01:00 ws7 kernel: [    0.003296]   Device   empty
2024-11-25T17:49:56.682015+01:00 ws7 kernel: [    0.003296] Movable zone start for each node
2024-11-25T17:49:56.682017+01:00 ws7 kernel: [    0.003297] Early memory node ranges
2024-11-25T17:49:56.682017+01:00 ws7 kernel: [    0.003297]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
2024-11-25T17:49:56.682017+01:00 ws7 kernel: [    0.003298]   node   0: [mem 0x0000000000100000-0x0000000009afefff]
2024-11-25T17:49:56.682018+01:00 ws7 kernel: [    0.003299]   node   0: [mem 0x000000000a000000-0x000000000a1fffff]
2024-11-25T17:49:56.682018+01:00 ws7 kernel: [    0.003299]   node   0: [mem 0x000000000a20c000-0x000000008567efff]
2024-11-25T17:49:56.682018+01:00 ws7 kernel: [    0.003300]   node   0: [mem 0x00000000977ff000-0x0000000099ff9fff]
2024-11-25T17:49:56.682020+01:00 ws7 kernel: [    0.003300]   node   0: [mem 0x0000000099ffd000-0x0000000099ffffff]
2024-11-25T17:49:56.682021+01:00 ws7 kernel: [    0.003300]   node   0: [mem 0x0000000100000000-0x00000017de2fffff]
2024-11-25T17:49:56.682021+01:00 ws7 kernel: [    0.003303] Initmem setup node 0 [mem 0x0000000000001000-0x00000017de2fffff]
2024-11-25T17:49:56.682021+01:00 ws7 kernel: [    0.003307] On node 0, zone DMA: 1 pages in unavailable ranges
2024-11-25T17:49:56.682021+01:00 ws7 kernel: [    0.003315] On node 0, zone DMA: 96 pages in unavailable ranges
2024-11-25T17:49:56.682022+01:00 ws7 kernel: [    0.003380] On node 0, zone DMA32: 1281 pages in unavailable ranges
2024-11-25T17:49:56.682024+01:00 ws7 kernel: [    0.004425] On node 0, zone DMA32: 12 pages in unavailable ranges
2024-11-25T17:49:56.682024+01:00 ws7 kernel: [    0.004594] On node 0, zone DMA32: 41344 pages in unavailable ranges
2024-11-25T17:49:56.682025+01:00 ws7 kernel: [    0.004595] On node 0, zone DMA32: 3 pages in unavailable ranges
2024-11-25T17:49:56.682025+01:00 ws7 kernel: [    0.004768] On node 0, zone Normal: 24576 pages in unavailable ranges
2024-11-25T17:49:56.682025+01:00 ws7 kernel: [    0.004794] On node 0, zone Normal: 7424 pages in unavailable ranges
2024-11-25T17:49:56.682025+01:00 ws7 kernel: [    0.004989] ACPI: PM-Timer IO Port: 0x808
2024-11-25T17:49:56.682026+01:00 ws7 kernel: [    0.004994] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
2024-11-25T17:49:56.682032+01:00 ws7 kernel: [    0.005007] IOAPIC[0]: apic_id 32, version 33, address 0xfec00000, GSI 0-23
2024-11-25T17:49:56.682032+01:00 ws7 kernel: [    0.005011] IOAPIC[1]: apic_id 33, version 33, address 0xfec01000, GSI 24-55
2024-11-25T17:49:56.682032+01:00 ws7 kernel: [    0.005012] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
2024-11-25T17:49:56.682033+01:00 ws7 kernel: [    0.005013] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
2024-11-25T17:49:56.682033+01:00 ws7 kernel: [    0.005015] ACPI: Using ACPI (MADT) for SMP configuration information
2024-11-25T17:49:56.682033+01:00 ws7 kernel: [    0.005015] ACPI: HPET id: 0x10228201 base: 0xfed00000
2024-11-25T17:49:56.682035+01:00 ws7 kernel: [    0.005019] CPU topo: Max. logical packages:   1
2024-11-25T17:49:56.682036+01:00 ws7 kernel: [    0.005019] CPU topo: Max. logical dies:       1
2024-11-25T17:49:56.682036+01:00 ws7 kernel: [    0.005020] CPU topo: Max. dies per package:   1
2024-11-25T17:49:56.682036+01:00 ws7 kernel: [    0.005021] CPU topo: Max. threads per core:   2
2024-11-25T17:49:56.682036+01:00 ws7 kernel: [    0.005022] CPU topo: Num. cores per package:     8
2024-11-25T17:49:56.682037+01:00 ws7 kernel: [    0.005022] CPU topo: Num. threads per package:  16
2024-11-25T17:49:56.682037+01:00 ws7 kernel: [    0.005023] CPU topo: Allowing 16 present CPUs plus 0 hotplug CPUs
2024-11-25T17:49:56.682039+01:00 ws7 kernel: [    0.005032] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
2024-11-25T17:49:56.682039+01:00 ws7 kernel: [    0.005033] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
2024-11-25T17:49:56.682040+01:00 ws7 kernel: [    0.005034] PM: hibernation: Registered nosave memory: [mem 0x09aff000-0x09ffffff]
2024-11-25T17:49:56.682040+01:00 ws7 kernel: [    0.005034] PM: hibernation: Registered nosave memory: [mem 0x0a200000-0x0a20bfff]
2024-11-25T17:49:56.682040+01:00 ws7 kernel: [    0.005035] PM: hibernation: Registered nosave memory: [mem 0x7e09c000-0x7e09cfff]
2024-11-25T17:49:56.682040+01:00 ws7 kernel: [    0.005036] PM: hibernation: Registered nosave memory: [mem 0x7e0a0000-0x7e0a0fff]
2024-11-25T17:49:56.682042+01:00 ws7 kernel: [    0.005036] PM: hibernation: Registered nosave memory: [mem 0x7fe8b000-0x7fe8bfff]
2024-11-25T17:49:56.682043+01:00 ws7 kernel: [    0.005037] PM: hibernation: Registered nosave memory: [mem 0x8567f000-0x8b67efff]
2024-11-25T17:49:56.682043+01:00 ws7 kernel: [    0.005037] PM: hibernation: Registered nosave memory: [mem 0x8b67f000-0x8d67efff]
2024-11-25T17:49:56.682043+01:00 ws7 kernel: [    0.005037] PM: hibernation: Registered nosave memory: [mem 0x8d67f000-0x8f67efff]
2024-11-25T17:49:56.682043+01:00 ws7 kernel: [    0.005038] PM: hibernation: Registered nosave memory: [mem 0x8f67f000-0x977fefff]
2024-11-25T17:49:56.682044+01:00 ws7 kernel: [    0.005038] PM: hibernation: Registered nosave memory: [mem 0x99ffa000-0x99ffcfff]
2024-11-25T17:49:56.682046+01:00 ws7 kernel: [    0.005039] PM: hibernation: Registered nosave memory: [mem 0x9a000000-0x9bffffff]
2024-11-25T17:49:56.682046+01:00 ws7 kernel: [    0.005039] PM: hibernation: Registered nosave memory: [mem 0x9c000000-0x9d78ffff]
2024-11-25T17:49:56.682046+01:00 ws7 kernel: [    0.005039] PM: hibernation: Registered nosave memory: [mem 0x9d790000-0x9d7effff]
2024-11-25T17:49:56.682046+01:00 ws7 kernel: [    0.005040] PM: hibernation: Registered nosave memory: [mem 0x9d7f0000-0x9d7f4fff]
2024-11-25T17:49:56.682047+01:00 ws7 kernel: [    0.005040] PM: hibernation: Registered nosave memory: [mem 0x9d7f5000-0x9fffffff]
2024-11-25T17:49:56.682047+01:00 ws7 kernel: [    0.005040] PM: hibernation: Registered nosave memory: [mem 0xa0000000-0xfedfffff]
2024-11-25T17:49:56.682047+01:00 ws7 kernel: [    0.005041] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
2024-11-25T17:49:56.682049+01:00 ws7 kernel: [    0.005041] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xffffffff]
2024-11-25T17:49:56.682050+01:00 ws7 kernel: [    0.005042] [mem 0xa0000000-0xfedfffff] available for PCI devices
2024-11-25T17:49:56.682050+01:00 ws7 kernel: [    0.005043] Booting paravirtualized kernel on bare hardware
2024-11-25T17:49:56.682050+01:00 ws7 kernel: [    0.005044] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
2024-11-25T17:49:56.682050+01:00 ws7 kernel: [    0.007484] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
2024-11-25T17:49:56.682143+01:00 ws7 kernel: [    0.007849] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u524288
2024-11-25T17:49:56.682146+01:00 ws7 kernel: [    0.007852] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=1*2097152
2024-11-25T17:49:56.682147+01:00 ws7 kernel: [    0.007853] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
2024-11-25T17:49:56.682147+01:00 ws7 kernel: [    0.007855] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
2024-11-25T17:49:56.682147+01:00 ws7 kernel: [    0.007865] Kernel command line: initrd=\6.11.5\initrd root=/dev/disk/by-id/nvme-Lexar_SSD_NM790_4TB_NHG456R005482P2202_1-part2 ro usbcore.autosuspend=-1 video=HDMI-A-1:1600x1200D
2024-11-25T17:49:56.682148+01:00 ws7 kernel: [    0.010103] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes, linear)
2024-11-25T17:49:56.682148+01:00 ws7 kernel: [    0.011159] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
2024-11-25T17:49:56.682159+01:00 ws7 kernel: [    0.011217] Fallback order for Node 0: 0 
2024-11-25T17:49:56.682159+01:00 ws7 kernel: [    0.011221] Built 1 zonelists, mobility grouping on.  Total pages: 24534031
2024-11-25T17:49:56.682160+01:00 ws7 kernel: [    0.011222] Policy zone: Normal
2024-11-25T17:49:56.682160+01:00 ws7 kernel: [    0.011228] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
2024-11-25T17:49:56.682160+01:00 ws7 kernel: [    0.011271] software IO TLB: area num 16.
2024-11-25T17:49:56.682161+01:00 ws7 kernel: [    0.021495] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
2024-11-25T17:49:56.682166+01:00 ws7 kernel: [    0.021524] ftrace: allocating 45171 entries in 177 pages
2024-11-25T17:49:56.682167+01:00 ws7 kernel: [    0.027170] ftrace: allocated 177 pages with 4 groups
2024-11-25T17:49:56.682167+01:00 ws7 kernel: [    0.027591] Dynamic Preempt: voluntary
2024-11-25T17:49:56.682167+01:00 ws7 kernel: [    0.027638] rcu: Preemptible hierarchical RCU implementation.
2024-11-25T17:49:56.682168+01:00 ws7 kernel: [    0.027638] rcu: 	RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=16.
2024-11-25T17:49:56.682168+01:00 ws7 kernel: [    0.027639] 	Trampoline variant of Tasks RCU enabled.
2024-11-25T17:49:56.682168+01:00 ws7 kernel: [    0.027639] 	Rude variant of Tasks RCU enabled.
2024-11-25T17:49:56.682183+01:00 ws7 kernel: [    0.027640] 	Tracing variant of Tasks RCU enabled.
2024-11-25T17:49:56.682186+01:00 ws7 kernel: [    0.027640] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
2024-11-25T17:49:56.682186+01:00 ws7 kernel: [    0.027641] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
2024-11-25T17:49:56.682187+01:00 ws7 kernel: [    0.027648] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
2024-11-25T17:49:56.682187+01:00 ws7 kernel: [    0.027650] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
2024-11-25T17:49:56.682187+01:00 ws7 kernel: [    0.027652] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=16.
2024-11-25T17:49:56.682194+01:00 ws7 kernel: [    0.028854] NR_IRQS: 524544, nr_irqs: 1096, preallocated irqs: 16
2024-11-25T17:49:56.682194+01:00 ws7 kernel: [    0.029055] rcu: srcu_init: Setting srcu_struct sizes based on contention.
2024-11-25T17:49:56.682194+01:00 ws7 kernel: [    0.029183] Console: colour dummy device 80x25
2024-11-25T17:49:56.682195+01:00 ws7 kernel: [    0.029184] printk: legacy console [tty0] enabled
2024-11-25T17:49:56.682195+01:00 ws7 kernel: [    0.029349] ACPI: Core revision 20240322
2024-11-25T17:49:56.682195+01:00 ws7 kernel: [    0.029542] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
2024-11-25T17:49:56.682200+01:00 ws7 kernel: [    0.029561] APIC: Switch to symmetric I/O mode setup
2024-11-25T17:49:56.682200+01:00 ws7 kernel: [    0.030008] AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, EFR2:0x0
2024-11-25T17:49:56.682200+01:00 ws7 kernel: [    0.031365] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
2024-11-25T17:49:56.682201+01:00 ws7 kernel: [    0.049569] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x3c8a43cbe1d, max_idle_ns: 440795324995 ns
2024-11-25T17:49:56.682201+01:00 ws7 kernel: [    0.049573] Calibrating delay loop (skipped), value calculated using timer frequency.. 8399.93 BogoMIPS (lpj=16799876)
2024-11-25T17:49:56.682201+01:00 ws7 kernel: [    0.049589] x86/cpu: User Mode Instruction Prevention (UMIP) activated
2024-11-25T17:49:56.682205+01:00 ws7 kernel: [    0.049758] LVT offset 1 assigned for vector 0xf9
2024-11-25T17:49:56.682206+01:00 ws7 kernel: [    0.049917] LVT offset 2 assigned for vector 0xf4
2024-11-25T17:49:56.682206+01:00 ws7 kernel: [    0.049955] Last level iTLB entries: 4KB 512, 2MB 512, 4MB 256
2024-11-25T17:49:56.682206+01:00 ws7 kernel: [    0.049956] Last level dTLB entries: 4KB 3072, 2MB 3072, 4MB 1536, 1GB 0
2024-11-25T17:49:56.682207+01:00 ws7 kernel: [    0.049959] process: using mwait in idle threads
2024-11-25T17:49:56.682207+01:00 ws7 kernel: [    0.049961] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
2024-11-25T17:49:56.682211+01:00 ws7 kernel: [    0.049964] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
2024-11-25T17:49:56.682211+01:00 ws7 kernel: [    0.049965] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
2024-11-25T17:49:56.682212+01:00 ws7 kernel: [    0.049967] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
2024-11-25T17:49:56.682212+01:00 ws7 kernel: [    0.049968] Spectre V2 : User space: Mitigation: STIBP always-on protection
2024-11-25T17:49:56.682212+01:00 ws7 kernel: [    0.049970] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
2024-11-25T17:49:56.682212+01:00 ws7 kernel: [    0.049972] Speculative Return Stack Overflow: Mitigation: Safe RET
2024-11-25T17:49:56.682213+01:00 ws7 kernel: [    0.049978] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
2024-11-25T17:49:56.682217+01:00 ws7 kernel: [    0.049979] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
2024-11-25T17:49:56.682217+01:00 ws7 kernel: [    0.049980] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
2024-11-25T17:49:56.682217+01:00 ws7 kernel: [    0.049981] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
2024-11-25T17:49:56.682218+01:00 ws7 kernel: [    0.049982] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
2024-11-25T17:49:56.682218+01:00 ws7 kernel: [    0.049983] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
2024-11-25T17:49:56.682218+01:00 ws7 kernel: [    0.049984] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
2024-11-25T17:49:56.682222+01:00 ws7 kernel: [    0.049986] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
2024-11-25T17:49:56.682223+01:00 ws7 kernel: [    0.049987] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
2024-11-25T17:49:56.682223+01:00 ws7 kernel: [    0.049989] x86/fpu: xstate_offset[5]:  832, xstate_sizes[5]:   64
2024-11-25T17:49:56.682223+01:00 ws7 kernel: [    0.049990] x86/fpu: xstate_offset[6]:  896, xstate_sizes[6]:  512
2024-11-25T17:49:56.682223+01:00 ws7 kernel: [    0.049991] x86/fpu: xstate_offset[7]: 1408, xstate_sizes[7]: 1024
2024-11-25T17:49:56.682224+01:00 ws7 kernel: [    0.049992] x86/fpu: xstate_offset[9]: 2432, xstate_sizes[9]:    8
2024-11-25T17:49:56.682224+01:00 ws7 kernel: [    0.049993] x86/fpu: xstate_offset[11]: 2440, xstate_sizes[11]:   16
2024-11-25T17:49:56.682228+01:00 ws7 kernel: [    0.049994] x86/fpu: Enabled xstate features 0xae7, context size is 2456 bytes, using 'compacted' format.
2024-11-25T17:49:56.682228+01:00 ws7 kernel: [    0.067791] Freeing SMP alternatives memory: 40K
2024-11-25T17:49:56.682229+01:00 ws7 kernel: [    0.067794] pid_max: default: 32768 minimum: 301
2024-11-25T17:49:56.682229+01:00 ws7 kernel: [    0.071285] LSM: initializing lsm=lockdown,capability,landlock,yama,apparmor,tomoyo,bpf,ima,evm
2024-11-25T17:49:56.682229+01:00 ws7 kernel: [    0.071299] landlock: Up and running.
2024-11-25T17:49:56.682230+01:00 ws7 kernel: [    0.071301] Yama: becoming mindful.
2024-11-25T17:49:56.682234+01:00 ws7 kernel: [    0.071316] AppArmor: AppArmor initialized
2024-11-25T17:49:56.682234+01:00 ws7 kernel: [    0.071319] TOMOYO Linux initialized
2024-11-25T17:49:56.682234+01:00 ws7 kernel: [    0.071323] LSM support for eBPF active
2024-11-25T17:49:56.682235+01:00 ws7 kernel: [    0.071381] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
2024-11-25T17:49:56.682235+01:00 ws7 kernel: [    0.071417] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
2024-11-25T17:49:56.682235+01:00 ws7 kernel: [    0.179770] smpboot: CPU0: AMD Ryzen 7 8700G w/ Radeon 780M Graphics (family: 0x19, model: 0x75, stepping: 0x2)
2024-11-25T17:49:56.682239+01:00 ws7 kernel: [    0.179931] Performance Events: Fam17h+ 16-deep LBR, core perfctr, AMD PMU driver.
2024-11-25T17:49:56.682240+01:00 ws7 kernel: [    0.179958] ... version:                2
2024-11-25T17:49:56.682240+01:00 ws7 kernel: [    0.179961] ... bit width:              48
2024-11-25T17:49:56.682240+01:00 ws7 kernel: [    0.179963] ... generic registers:      6
2024-11-25T17:49:56.682240+01:00 ws7 kernel: [    0.179965] ... value mask:             0000ffffffffffff
2024-11-25T17:49:56.682241+01:00 ws7 kernel: [    0.179967] ... max period:             00007fffffffffff
2024-11-25T17:49:56.682244+01:00 ws7 kernel: [    0.179969] ... fixed-purpose events:   0
2024-11-25T17:49:56.682245+01:00 ws7 kernel: [    0.179971] ... event mask:             000000000000003f
2024-11-25T17:49:56.682245+01:00 ws7 kernel: [    0.180045] signal: max sigframe size: 3376
2024-11-25T17:49:56.682245+01:00 ws7 kernel: [    0.180067] rcu: Hierarchical SRCU implementation.
2024-11-25T17:49:56.682246+01:00 ws7 kernel: [    0.180069] rcu: 	Max phase no-delay instances is 1000.
2024-11-25T17:49:56.682246+01:00 ws7 kernel: [    0.180107] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
2024-11-25T17:49:56.682246+01:00 ws7 kernel: [    0.181571] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
2024-11-25T17:49:56.682250+01:00 ws7 kernel: [    0.181571] smp: Bringing up secondary CPUs ...
2024-11-25T17:49:56.682251+01:00 ws7 kernel: [    0.181571] smpboot: x86: Booting SMP configuration:
2024-11-25T17:49:56.682251+01:00 ws7 kernel: [    0.181571] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
2024-11-25T17:49:56.682251+01:00 ws7 kernel: [    0.197652] Spectre V2 : Update user space SMT mitigation: STIBP always-on
2024-11-25T17:49:56.682251+01:00 ws7 kernel: [    0.211572] smp: Brought up 1 node, 16 CPUs
2024-11-25T17:49:56.682252+01:00 ws7 kernel: [    0.211572] smpboot: Total of 16 processors activated (134399.00 BogoMIPS)
2024-11-25T17:49:56.682256+01:00 ws7 kernel: [    0.266196] node 0 deferred pages initialised in 52ms
2024-11-25T17:49:56.682256+01:00 ws7 kernel: [    0.266809] Memory: 96315148K/98136124K available (16384K kernel code, 2431K rwdata, 11140K rodata, 4136K init, 5240K bss, 1802984K reserved, 0K cma-reserved)
2024-11-25T17:49:56.682257+01:00 ws7 kernel: [    0.266811] devtmpfs: initialized
2024-11-25T17:49:56.682257+01:00 ws7 kernel: [    0.266811] x86/mm: Memory block size: 2048MB
2024-11-25T17:49:56.682257+01:00 ws7 kernel: [    0.269594] ACPI: PM: Registering ACPI NVS region [mem 0x0a200000-0x0a20bfff] (49152 bytes)
2024-11-25T17:49:56.682257+01:00 ws7 kernel: [    0.269599] ACPI: PM: Registering ACPI NVS region [mem 0x8d67f000-0x8f67efff] (33554432 bytes)
2024-11-25T17:49:56.682261+01:00 ws7 kernel: [    0.269932] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
2024-11-25T17:49:56.682262+01:00 ws7 kernel: [    0.269946] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
2024-11-25T17:49:56.682262+01:00 ws7 kernel: [    0.270003] pinctrl core: initialized pinctrl subsystem
2024-11-25T17:49:56.682262+01:00 ws7 kernel: [    0.270368] NET: Registered PF_NETLINK/PF_ROUTE protocol family
2024-11-25T17:49:56.682263+01:00 ws7 kernel: [    0.270596] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
2024-11-25T17:49:56.682352+01:00 ws7 kernel: [    0.270740] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
2024-11-25T17:49:56.682356+01:00 ws7 kernel: [    0.270887] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
2024-11-25T17:49:56.682357+01:00 ws7 kernel: [    0.270896] audit: initializing netlink subsys (disabled)
2024-11-25T17:49:56.682357+01:00 ws7 kernel: [    0.270903] audit: type=2000 audit(1732553391.240:1): state=initialized audit_enabled=0 res=1
2024-11-25T17:49:56.682357+01:00 ws7 kernel: [    0.270903] thermal_sys: Registered thermal governor 'fair_share'
2024-11-25T17:49:56.682357+01:00 ws7 kernel: [    0.270903] thermal_sys: Registered thermal governor 'bang_bang'
2024-11-25T17:49:56.682358+01:00 ws7 kernel: [    0.270903] thermal_sys: Registered thermal governor 'step_wise'
2024-11-25T17:49:56.682358+01:00 ws7 kernel: [    0.270903] thermal_sys: Registered thermal governor 'user_space'
2024-11-25T17:49:56.682362+01:00 ws7 kernel: [    0.270903] thermal_sys: Registered thermal governor 'power_allocator'
2024-11-25T17:49:56.682362+01:00 ws7 kernel: [    0.270903] cpuidle: using governor ladder
2024-11-25T17:49:56.682363+01:00 ws7 kernel: [    0.270903] cpuidle: using governor menu
2024-11-25T17:49:56.682363+01:00 ws7 kernel: [    0.270903] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
2024-11-25T17:49:56.682363+01:00 ws7 kernel: [    0.270903] PCI: ECAM [mem 0xe0000000-0xefffffff] (base 0xe0000000) for domain 0000 [bus 00-ff]
2024-11-25T17:49:56.682363+01:00 ws7 kernel: [    0.270903] PCI: Using configuration type 1 for base access
2024-11-25T17:49:56.682367+01:00 ws7 kernel: [    0.270903] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
2024-11-25T17:49:56.682368+01:00 ws7 kernel: [    0.270903] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
2024-11-25T17:49:56.682368+01:00 ws7 kernel: [    0.270903] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
2024-11-25T17:49:56.682368+01:00 ws7 kernel: [    0.270903] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
2024-11-25T17:49:56.682369+01:00 ws7 kernel: [    0.270903] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
2024-11-25T17:49:56.682369+01:00 ws7 kernel: [    0.270903] ACPI: Added _OSI(Module Device)
2024-11-25T17:49:56.682369+01:00 ws7 kernel: [    0.270903] ACPI: Added _OSI(Processor Device)
2024-11-25T17:49:56.682373+01:00 ws7 kernel: [    0.270903] ACPI: Added _OSI(3.0 _SCP Extensions)
2024-11-25T17:49:56.682373+01:00 ws7 kernel: [    0.270903] ACPI: Added _OSI(Processor Aggregator Device)
2024-11-25T17:49:56.682374+01:00 ws7 kernel: [    0.281364] ACPI: 12 ACPI AML tables successfully acquired and loaded
2024-11-25T17:49:56.682374+01:00 ws7 kernel: [    0.286188] ACPI: Interpreter enabled
2024-11-25T17:49:56.682374+01:00 ws7 kernel: [    0.286201] ACPI: PM: (supports S0 S3 S4 S5)
2024-11-25T17:49:56.682374+01:00 ws7 kernel: [    0.286203] ACPI: Using IOAPIC for interrupt routing
2024-11-25T17:49:56.682378+01:00 ws7 kernel: [    0.286625] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
2024-11-25T17:49:56.682379+01:00 ws7 kernel: [    0.286629] PCI: Ignoring E820 reservations for host bridge windows
2024-11-25T17:49:56.682379+01:00 ws7 kernel: [    0.286881] ACPI: Enabled 8 GPEs in block 00 to 1F
2024-11-25T17:49:56.682379+01:00 ws7 kernel: [    0.288367] ACPI: \_SB_.PCI0.GP11.PWRS: New power resource
2024-11-25T17:49:56.682380+01:00 ws7 kernel: [    0.289985] ACPI: \_SB_.PCI0.GP11.SWUS.PWRS: New power resource
2024-11-25T17:49:56.682380+01:00 ws7 kernel: [    0.290412] ACPI: \_SB_.PCI0.GP12.PWRS: New power resource
2024-11-25T17:49:56.682388+01:00 ws7 kernel: [    0.290828] ACPI: \_SB_.PCI0.GP12.SWUS.PWRS: New power resource
2024-11-25T17:49:56.682388+01:00 ws7 kernel: [    0.291603] ACPI: \_SB_.PCI0.GP17.XHC0.P0U0: New power resource
2024-11-25T17:49:56.682388+01:00 ws7 kernel: [    0.293775] ACPI: \_SB_.PCI0.GP17.XHC1.P0U1: New power resource
2024-11-25T17:49:56.682389+01:00 ws7 kernel: [    0.295791] ACPI: \_SB_.PCI0.GP19.XHC3.PWRS: New power resource
2024-11-25T17:49:56.682389+01:00 ws7 kernel: [    0.296551] ACPI: \_SB_.PCI0.GP19.XHC4.PWRS: New power resource
2024-11-25T17:49:56.682389+01:00 ws7 kernel: [    0.297307] ACPI: \_SB_.PCI0.GP19.NHI0.PWRS: New power resource
2024-11-25T17:49:56.682389+01:00 ws7 kernel: [    0.297734] ACPI: \_SB_.PCI0.GP19.NHI1.PWRS: New power resource
2024-11-25T17:49:56.682393+01:00 ws7 kernel: [    0.298024] ACPI: \_SB_.PCI0.GPP1.P0NV: New power resource
2024-11-25T17:49:56.682394+01:00 ws7 kernel: [    0.298564] ACPI: \_SB_.PCI0.GPP5.PWRS: New power resource
2024-11-25T17:49:56.682394+01:00 ws7 kernel: [    0.298680] ACPI: \_SB_.PCI0.GPP6.PWR1: New power resource
2024-11-25T17:49:56.682394+01:00 ws7 kernel: [    0.302210] ACPI: \_SB_.PRWL: New power resource
2024-11-25T17:49:56.682394+01:00 ws7 kernel: [    0.302232] ACPI: \_SB_.PRWB: New power resource
2024-11-25T17:49:56.682395+01:00 ws7 kernel: [    0.302669] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
2024-11-25T17:49:56.682399+01:00 ws7 kernel: [    0.302675] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
2024-11-25T17:49:56.682399+01:00 ws7 kernel: [    0.302771] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME AER PCIeCapability LTR]
2024-11-25T17:49:56.682399+01:00 ws7 kernel: [    0.303101] PCI host bridge to bus 0000:00
2024-11-25T17:49:56.682400+01:00 ws7 kernel: [    0.303105] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
2024-11-25T17:49:56.682400+01:00 ws7 kernel: [    0.303108] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
2024-11-25T17:49:56.682400+01:00 ws7 kernel: [    0.303111] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
2024-11-25T17:49:56.682404+01:00 ws7 kernel: [    0.303114] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
2024-11-25T17:49:56.682405+01:00 ws7 kernel: [    0.303117] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
2024-11-25T17:49:56.682405+01:00 ws7 kernel: [    0.303120] pci_bus 0000:00: root bus resource [mem 0xa0000000-0xf6ffffff window]
2024-11-25T17:49:56.682405+01:00 ws7 kernel: [    0.303123] pci_bus 0000:00: root bus resource [mem 0x1860000000-0xfcffffffff window]
2024-11-25T17:49:56.682405+01:00 ws7 kernel: [    0.303127] pci_bus 0000:00: root bus resource [bus 00-ff]
2024-11-25T17:49:56.682406+01:00 ws7 kernel: [    0.303140] pci 0000:00:00.0: [1022:14e8] type 00 class 0x060000 conventional PCI endpoint
2024-11-25T17:49:56.682410+01:00 ws7 kernel: [    0.303230] pci 0000:00:00.2: [1022:14e9] type 00 class 0x080600 conventional PCI endpoint
2024-11-25T17:49:56.682410+01:00 ws7 kernel: [    0.303316] pci 0000:00:01.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
2024-11-25T17:49:56.682410+01:00 ws7 kernel: [    0.303390] pci 0000:00:01.2: [1022:14ee] type 01 class 0x060400 PCIe Root Port
2024-11-25T17:49:56.682410+01:00 ws7 kernel: [    0.303409] pci 0000:00:01.2: PCI bridge to [bus 01]
2024-11-25T17:49:56.682411+01:00 ws7 kernel: [    0.303415] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
2024-11-25T17:49:56.682411+01:00 ws7 kernel: [    0.303419] pci 0000:00:01.2:   bridge window [mem 0xf6f00000-0xf6ffffff]
2024-11-25T17:49:56.682411+01:00 ws7 kernel: [    0.303434] pci 0000:00:01.2: enabling Extended Tags
2024-11-25T17:49:56.682415+01:00 ws7 kernel: [    0.303506] pci 0000:00:01.2: PME# supported from D0 D3hot D3cold
2024-11-25T17:49:56.682416+01:00 ws7 kernel: [    0.303650] pci 0000:00:01.3: [1022:14ed] type 01 class 0x060400 PCIe Root Port
2024-11-25T17:49:56.682416+01:00 ws7 kernel: [    0.303783] pci 0000:00:01.3: PCI bridge to [bus 02]
2024-11-25T17:49:56.682416+01:00 ws7 kernel: [    0.303792] pci 0000:00:01.3:   bridge window [mem 0xf6e00000-0xf6efffff]
2024-11-25T17:49:56.682417+01:00 ws7 kernel: [    0.303827] pci 0000:00:01.3: enabling Extended Tags
2024-11-25T17:49:56.682417+01:00 ws7 kernel: [    0.303931] pci 0000:00:01.3: PME# supported from D0 D3hot D3cold
2024-11-25T17:49:56.682421+01:00 ws7 kernel: [    0.304136] pci 0000:00:02.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
2024-11-25T17:49:56.682421+01:00 ws7 kernel: [    0.304211] pci 0000:00:02.3: [1022:14ee] type 01 class 0x060400 PCIe Root Port
2024-11-25T17:49:56.682422+01:00 ws7 kernel: [    0.304230] pci 0000:00:02.3: PCI bridge to [bus 03]
2024-11-25T17:49:56.682422+01:00 ws7 kernel: [    0.304236] pci 0000:00:02.3:   bridge window [io  0xe000-0xefff]
2024-11-25T17:49:56.682422+01:00 ws7 kernel: [    0.304239] pci 0000:00:02.3:   bridge window [mem 0xf6d00000-0xf6dfffff]
2024-11-25T17:49:56.682422+01:00 ws7 kernel: [    0.304254] pci 0000:00:02.3: enabling Extended Tags
2024-11-25T17:49:56.682423+01:00 ws7 kernel: [    0.304323] pci 0000:00:02.3: PME# supported from D0 D3hot D3cold
2024-11-25T17:49:56.682427+01:00 ws7 kernel: [    0.304462] pci 0000:00:03.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
2024-11-25T17:49:56.682427+01:00 ws7 kernel: [    0.304537] pci 0000:00:04.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
2024-11-25T17:49:56.682427+01:00 ws7 kernel: [    0.304616] pci 0000:00:08.0: [1022:14ea] type 00 class 0x060000 conventional PCI endpoint
2024-11-25T17:49:56.682427+01:00 ws7 kernel: [    0.304682] pci 0000:00:08.1: [1022:14eb] type 01 class 0x060400 PCIe Root Port
2024-11-25T17:49:56.682428+01:00 ws7 kernel: [    0.304699] pci 0000:00:08.1: PCI bridge to [bus 04]
2024-11-25T17:49:56.682428+01:00 ws7 kernel: [    0.304704] pci 0000:00:08.1:   bridge window [io  0xd000-0xdfff]
2024-11-25T17:49:56.682432+01:00 ws7 kernel: [    0.304707] pci 0000:00:08.1:   bridge window [mem 0xf6600000-0xf6bfffff]
2024-11-25T17:49:56.682432+01:00 ws7 kernel: [    0.304715] pci 0000:00:08.1:   bridge window [mem 0xfce0000000-0xfcefffffff 64bit pref]
2024-11-25T17:49:56.682432+01:00 ws7 kernel: [    0.304723] pci 0000:00:08.1: enabling Extended Tags
2024-11-25T17:49:56.682433+01:00 ws7 kernel: [    0.304760] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
2024-11-25T17:49:56.682433+01:00 ws7 kernel: [    0.304872] pci 0000:00:08.2: [1022:14eb] type 01 class 0x060400 PCIe Root Port
2024-11-25T17:49:56.682433+01:00 ws7 kernel: [    0.304921] pci 0000:00:08.2: PCI bridge to [bus 05]
2024-11-25T17:49:56.682437+01:00 ws7 kernel: [    0.304927] pci 0000:00:08.2:   bridge window [mem 0xf6c00000-0xf6cfffff]
2024-11-25T17:49:56.682438+01:00 ws7 kernel: [    0.304934] pci 0000:00:08.2:   bridge window [mem 0xfcf0000000-0xfcf00fffff 64bit pref]
2024-11-25T17:49:56.682438+01:00 ws7 kernel: [    0.304942] pci 0000:00:08.2: enabling Extended Tags
2024-11-25T17:49:56.682438+01:00 ws7 kernel: [    0.304979] pci 0000:00:08.2: PME# supported from D0 D3hot D3cold
2024-11-25T17:49:56.682438+01:00 ws7 kernel: [    0.305066] pci 0000:00:08.3: [1022:14eb] type 01 class 0x060400 PCIe Root Port
2024-11-25T17:49:56.682439+01:00 ws7 kernel: [    0.305082] pci 0000:00:08.3: PCI bridge to [bus 06]
2024-11-25T17:49:56.682439+01:00 ws7 kernel: [    0.305097] pci 0000:00:08.3: enabling Extended Tags
2024-11-25T17:49:56.682443+01:00 ws7 kernel: [    0.305134] pci 0000:00:08.3: PME# supported from D0 D3hot D3cold
2024-11-25T17:49:56.682443+01:00 ws7 kernel: [    0.305247] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500 conventional PCI endpoint
2024-11-25T17:49:56.682444+01:00 ws7 kernel: [    0.305362] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100 conventional PCI endpoint
2024-11-25T17:49:56.682444+01:00 ws7 kernel: [    0.305492] pci 0000:00:18.0: [1022:14f0] type 00 class 0x060000 conventional PCI endpoint
2024-11-25T17:49:56.682444+01:00 ws7 kernel: [    0.305523] pci 0000:00:18.1: [1022:14f1] type 00 class 0x060000 conventional PCI endpoint
2024-11-25T17:49:56.682444+01:00 ws7 kernel: [    0.305554] pci 0000:00:18.2: [1022:14f2] type 00 class 0x060000 conventional PCI endpoint
2024-11-25T17:49:56.682448+01:00 ws7 kernel: [    0.305587] pci 0000:00:18.3: [1022:14f3] type 00 class 0x060000 conventional PCI endpoint
2024-11-25T17:49:56.682449+01:00 ws7 kernel: [    0.305617] pci 0000:00:18.4: [1022:14f4] type 00 class 0x060000 conventional PCI endpoint
2024-11-25T17:49:56.682449+01:00 ws7 kernel: [    0.305647] pci 0000:00:18.5: [1022:14f5] type 00 class 0x060000 conventional PCI endpoint
2024-11-25T17:49:56.682543+01:00 ws7 kernel: [    0.305677] pci 0000:00:18.6: [1022:14f6] type 00 class 0x060000 conventional PCI endpoint
2024-11-25T17:49:56.682543+01:00 ws7 kernel: [    0.305707] pci 0000:00:18.7: [1022:14f7] type 00 class 0x060000 conventional PCI endpoint
2024-11-25T17:49:56.682544+01:00 ws7 kernel: [    0.305825] pci 0000:01:00.0: [1b21:0612] type 00 class 0x010601 PCIe Legacy Endpoint
2024-11-25T17:49:56.682544+01:00 ws7 kernel: [    0.305841] pci 0000:01:00.0: BAR 0 [io  0xf050-0xf057]
2024-11-25T17:49:56.682548+01:00 ws7 kernel: [    0.305849] pci 0000:01:00.0: BAR 1 [io  0xf040-0xf043]
2024-11-25T17:49:56.682549+01:00 ws7 kernel: [    0.305858] pci 0000:01:00.0: BAR 2 [io  0xf030-0xf037]
2024-11-25T17:49:56.682549+01:00 ws7 kernel: [    0.305865] pci 0000:01:00.0: BAR 3 [io  0xf020-0xf023]
2024-11-25T17:49:56.682549+01:00 ws7 kernel: [    0.305873] pci 0000:01:00.0: BAR 4 [io  0xf000-0xf01f]
2024-11-25T17:49:56.682549+01:00 ws7 kernel: [    0.305882] pci 0000:01:00.0: BAR 5 [mem 0xf6f00000-0xf6f001ff]
2024-11-25T17:49:56.682550+01:00 ws7 kernel: [    0.306030] pci 0000:00:01.2: PCI bridge to [bus 01]
2024-11-25T17:49:56.682554+01:00 ws7 kernel: [    0.306194] pci 0000:02:00.0: [1d97:1602] type 00 class 0x010802 PCIe Endpoint
2024-11-25T17:49:56.682554+01:00 ws7 kernel: [    0.306209] pci 0000:02:00.0: BAR 0 [mem 0xf6e00000-0xf6e03fff 64bit]
2024-11-25T17:49:56.682554+01:00 ws7 kernel: [    0.306458] pci 0000:00:01.3: PCI bridge to [bus 02]
2024-11-25T17:49:56.682555+01:00 ws7 kernel: [    0.306548] pci 0000:03:00.0: [10ec:8125] type 00 class 0x020000 PCIe Endpoint
2024-11-25T17:49:56.682555+01:00 ws7 kernel: [    0.306567] pci 0000:03:00.0: BAR 0 [io  0xe000-0xe0ff]
2024-11-25T17:49:56.682555+01:00 ws7 kernel: [    0.306591] pci 0000:03:00.0: BAR 2 [mem 0xf6d00000-0xf6d0ffff 64bit]
2024-11-25T17:49:56.682559+01:00 ws7 kernel: [    0.306606] pci 0000:03:00.0: BAR 4 [mem 0xf6d10000-0xf6d13fff 64bit]
2024-11-25T17:49:56.682559+01:00 ws7 kernel: [    0.306712] pci 0000:03:00.0: supports D1 D2
2024-11-25T17:49:56.682560+01:00 ws7 kernel: [    0.306715] pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
2024-11-25T17:49:56.682560+01:00 ws7 kernel: [    0.306924] pci 0000:00:02.3: PCI bridge to [bus 03]
2024-11-25T17:49:56.682560+01:00 ws7 kernel: [    0.307010] pci 0000:04:00.0: [1002:15bf] type 00 class 0x030000 PCIe Legacy Endpoint
2024-11-25T17:49:56.682560+01:00 ws7 kernel: [    0.307025] pci 0000:04:00.0: BAR 0 [mem 0xfce0000000-0xfcefffffff 64bit pref]
2024-11-25T17:49:56.682561+01:00 ws7 kernel: [    0.307035] pci 0000:04:00.0: BAR 2 [mem 0xf6600000-0xf67fffff 64bit pref]
2024-11-25T17:49:56.682565+01:00 ws7 kernel: [    0.307043] pci 0000:04:00.0: BAR 4 [io  0xd000-0xd0ff]
2024-11-25T17:49:56.682565+01:00 ws7 kernel: [    0.307050] pci 0000:04:00.0: BAR 5 [mem 0xf6b00000-0xf6b7ffff]
2024-11-25T17:49:56.682565+01:00 ws7 kernel: [    0.307061] pci 0000:04:00.0: enabling Extended Tags
2024-11-25T17:49:56.682566+01:00 ws7 kernel: [    0.307120] pci 0000:04:00.0: PME# supported from D1 D2 D3hot D3cold
2024-11-25T17:49:56.682566+01:00 ws7 kernel: [    0.307249] pci 0000:04:00.1: [1002:1640] type 00 class 0x040300 PCIe Legacy Endpoint
2024-11-25T17:49:56.682566+01:00 ws7 kernel: [    0.307260] pci 0000:04:00.1: BAR 0 [mem 0xf6b88000-0xf6b8bfff]
2024-11-25T17:49:56.682570+01:00 ws7 kernel: [    0.307285] pci 0000:04:00.1: enabling Extended Tags
2024-11-25T17:49:56.682570+01:00 ws7 kernel: [    0.307321] pci 0000:04:00.1: PME# supported from D1 D2 D3hot D3cold
2024-11-25T17:49:56.682571+01:00 ws7 kernel: [    0.307405] pci 0000:04:00.2: [1022:15c7] type 00 class 0x108000 PCIe Endpoint
2024-11-25T17:49:56.682571+01:00 ws7 kernel: [    0.307421] pci 0000:04:00.2: BAR 2 [mem 0xf6a00000-0xf6afffff]
2024-11-25T17:49:56.682571+01:00 ws7 kernel: [    0.307434] pci 0000:04:00.2: BAR 5 [mem 0xf6b8c000-0xf6b8dfff]
2024-11-25T17:49:56.682571+01:00 ws7 kernel: [    0.307443] pci 0000:04:00.2: enabling Extended Tags
2024-11-25T17:49:56.682572+01:00 ws7 kernel: [    0.307540] pci 0000:04:00.3: [1022:15b9] type 00 class 0x0c0330 PCIe Endpoint
2024-11-25T17:49:56.682575+01:00 ws7 kernel: [    0.307554] pci 0000:04:00.3: BAR 0 [mem 0xf6900000-0xf69fffff 64bit]
2024-11-25T17:49:56.682576+01:00 ws7 kernel: [    0.307582] pci 0000:04:00.3: enabling Extended Tags
2024-11-25T17:49:56.682576+01:00 ws7 kernel: [    0.307621] pci 0000:04:00.3: PME# supported from D0 D3hot D3cold
2024-11-25T17:49:56.682576+01:00 ws7 kernel: [    0.307713] pci 0000:04:00.4: [1022:15ba] type 00 class 0x0c0330 PCIe Endpoint
2024-11-25T17:49:56.682577+01:00 ws7 kernel: [    0.307727] pci 0000:04:00.4: BAR 0 [mem 0xf6800000-0xf68fffff 64bit]
2024-11-25T17:49:56.682577+01:00 ws7 kernel: [    0.307755] pci 0000:04:00.4: enabling Extended Tags
2024-11-25T17:49:56.682581+01:00 ws7 kernel: [    0.307793] pci 0000:04:00.4: PME# supported from D0 D3hot D3cold
2024-11-25T17:49:56.682581+01:00 ws7 kernel: [    0.307882] pci 0000:04:00.6: [1022:15e3] type 00 class 0x040300 PCIe Endpoint
2024-11-25T17:49:56.682582+01:00 ws7 kernel: [    0.307892] pci 0000:04:00.6: BAR 0 [mem 0xf6b80000-0xf6b87fff]
2024-11-25T17:49:56.682582+01:00 ws7 kernel: [    0.307917] pci 0000:04:00.6: enabling Extended Tags
2024-11-25T17:49:56.682582+01:00 ws7 kernel: [    0.307953] pci 0000:04:00.6: PME# supported from D0 D3hot D3cold
2024-11-25T17:49:56.682582+01:00 ws7 kernel: [    0.308054] pci 0000:00:08.1: PCI bridge to [bus 04]
2024-11-25T17:49:56.682586+01:00 ws7 kernel: [    0.308102] pci 0000:05:00.0: [1022:14ec] type 00 class 0x130000 PCIe Endpoint
2024-11-25T17:49:56.682587+01:00 ws7 kernel: [    0.308135] pci 0000:05:00.0: enabling Extended Tags
2024-11-25T17:49:56.682587+01:00 ws7 kernel: [    0.308182] pci 0000:05:00.0: PME# supported from D3hot D3cold
2024-11-25T17:49:56.682587+01:00 ws7 kernel: [    0.308273] pci 0000:05:00.1: [1022:1502] type 00 class 0x118000 PCIe Endpoint
2024-11-25T17:49:56.682587+01:00 ws7 kernel: [    0.308292] pci 0000:05:00.1: BAR 0 [mem 0xf6c00000-0xf6c7ffff]
2024-11-25T17:49:56.682588+01:00 ws7 kernel: [    0.308298] pci 0000:05:00.1: BAR 1 [mem 0xf6cc0000-0xf6cc1fff]
2024-11-25T17:49:56.682588+01:00 ws7 kernel: [    0.308306] pci 0000:05:00.1: BAR 2 [mem 0xfcf0000000-0xfcf003ffff 64bit pref]
2024-11-25T17:49:56.682592+01:00 ws7 kernel: [    0.308312] pci 0000:05:00.1: BAR 4 [mem 0xf6c80000-0xf6cbffff]
2024-11-25T17:49:56.682592+01:00 ws7 kernel: [    0.308325] pci 0000:05:00.1: enabling Extended Tags
2024-11-25T17:49:56.682593+01:00 ws7 kernel: [    0.308456] pci 0000:00:08.2: PCI bridge to [bus 05]
2024-11-25T17:49:56.682593+01:00 ws7 kernel: [    0.308517] pci 0000:06:00.0: [1022:14ec] type 00 class 0x130000 PCIe Endpoint
2024-11-25T17:49:56.682593+01:00 ws7 kernel: [    0.308549] pci 0000:06:00.0: enabling Extended Tags
2024-11-25T17:49:56.682593+01:00 ws7 kernel: [    0.308673] pci 0000:00:08.3: PCI bridge to [bus 06]
2024-11-25T17:49:56.682597+01:00 ws7 kernel: [    0.311072] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
2024-11-25T17:49:56.682598+01:00 ws7 kernel: [    0.311109] ACPI: PCI: Interrupt link LNKB configured for IRQ 0
2024-11-25T17:49:56.682598+01:00 ws7 kernel: [    0.311140] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
2024-11-25T17:49:56.682598+01:00 ws7 kernel: [    0.311178] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
2024-11-25T17:49:56.682599+01:00 ws7 kernel: [    0.311213] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
2024-11-25T17:49:56.682599+01:00 ws7 kernel: [    0.311242] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
2024-11-25T17:49:56.682599+01:00 ws7 kernel: [    0.311271] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
2024-11-25T17:49:56.682603+01:00 ws7 kernel: [    0.311300] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
2024-11-25T17:49:56.682603+01:00 ws7 kernel: [    0.312003] iommu: Default domain type: Translated
2024-11-25T17:49:56.682604+01:00 ws7 kernel: [    0.312003] iommu: DMA domain TLB invalidation policy: lazy mode
2024-11-25T17:49:56.682604+01:00 ws7 kernel: [    0.312003] pps_core: LinuxPPS API ver. 1 registered
2024-11-25T17:49:56.682604+01:00 ws7 kernel: [    0.312003] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
2024-11-25T17:49:56.682604+01:00 ws7 kernel: [    0.312003] PTP clock support registered
2024-11-25T17:49:56.682608+01:00 ws7 kernel: [    0.312003] EDAC MC: Ver: 3.0.0
2024-11-25T17:49:56.682609+01:00 ws7 kernel: [    0.312003] efivars: Registered efivars operations
2024-11-25T17:49:56.682609+01:00 ws7 kernel: [    0.312003] NetLabel: Initializing
2024-11-25T17:49:56.682609+01:00 ws7 kernel: [    0.312003] NetLabel:  domain hash size = 128
2024-11-25T17:49:56.682609+01:00 ws7 kernel: [    0.312003] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
2024-11-25T17:49:56.682610+01:00 ws7 kernel: [    0.312003] NetLabel:  unlabeled traffic allowed by default
2024-11-25T17:49:56.682614+01:00 ws7 kernel: [    0.312003] PCI: Using ACPI for IRQ routing
2024-11-25T17:49:56.682614+01:00 ws7 kernel: [    0.321279] PCI: pci_cache_line_size set to 64 bytes
2024-11-25T17:49:56.682614+01:00 ws7 kernel: [    0.321395] e820: reserve RAM buffer [mem 0x09aff000-0x0bffffff]
2024-11-25T17:49:56.682615+01:00 ws7 kernel: [    0.321396] e820: reserve RAM buffer [mem 0x0a200000-0x0bffffff]
2024-11-25T17:49:56.682615+01:00 ws7 kernel: [    0.321397] e820: reserve RAM buffer [mem 0x7e09c018-0x7fffffff]
2024-11-25T17:49:56.682615+01:00 ws7 kernel: [    0.321398] e820: reserve RAM buffer [mem 0x7fe8b000-0x7fffffff]
2024-11-25T17:49:56.682615+01:00 ws7 kernel: [    0.321399] e820: reserve RAM buffer [mem 0x8567f000-0x87ffffff]
2024-11-25T17:49:56.682619+01:00 ws7 kernel: [    0.321400] e820: reserve RAM buffer [mem 0x99ffa000-0x9bffffff]
2024-11-25T17:49:56.682620+01:00 ws7 kernel: [    0.321400] e820: reserve RAM buffer [mem 0x9a000000-0x9bffffff]
2024-11-25T17:49:56.682620+01:00 ws7 kernel: [    0.321401] e820: reserve RAM buffer [mem 0x17de300000-0x17dfffffff]
2024-11-25T17:49:56.682620+01:00 ws7 kernel: [    0.321431] pci 0000:04:00.0: vgaarb: setting as boot VGA device
2024-11-25T17:49:56.682621+01:00 ws7 kernel: [    0.321431] pci 0000:04:00.0: vgaarb: bridge control possible
2024-11-25T17:49:56.682621+01:00 ws7 kernel: [    0.321431] pci 0000:04:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
2024-11-25T17:49:56.682625+01:00 ws7 kernel: [    0.321431] vgaarb: loaded
2024-11-25T17:49:56.682625+01:00 ws7 kernel: [    0.321431] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
2024-11-25T17:49:56.682625+01:00 ws7 kernel: [    0.321431] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
2024-11-25T17:49:56.682626+01:00 ws7 kernel: [    0.322616] clocksource: Switched to clocksource tsc-early
2024-11-25T17:49:56.682626+01:00 ws7 kernel: [    0.322716] VFS: Disk quotas dquot_6.6.0
2024-11-25T17:49:56.682626+01:00 ws7 kernel: [    0.322724] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
2024-11-25T17:49:56.682628+01:00 ws7 kernel: [    0.322831] AppArmor: AppArmor Filesystem Enabled
2024-11-25T17:49:56.682631+01:00 ws7 kernel: [    0.322841] pnp: PnP ACPI init
2024-11-25T17:49:56.682631+01:00 ws7 kernel: [    0.322899] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
2024-11-25T17:49:56.682633+01:00 ws7 kernel: [    0.322944] system 00:01: [mem 0x17e0000000-0x185fffffff window] has been reserved
2024-11-25T17:49:56.682634+01:00 ws7 kernel: [    0.323491] system 00:03: [io  0x0a00-0x0a0f] has been reserved
2024-11-25T17:49:56.682634+01:00 ws7 kernel: [    0.323495] system 00:03: [io  0x0a10-0x0a1f] has been reserved
2024-11-25T17:49:56.682634+01:00 ws7 kernel: [    0.323497] system 00:03: [io  0x0a20-0x0a2f] has been reserved
2024-11-25T17:49:56.682638+01:00 ws7 kernel: [    0.323617] system 00:04: [io  0x04d0-0x04d1] has been reserved
2024-11-25T17:49:56.682638+01:00 ws7 kernel: [    0.323620] system 00:04: [io  0x040b] has been reserved
2024-11-25T17:49:56.682639+01:00 ws7 kernel: [    0.323623] system 00:04: [io  0x04d6] has been reserved
2024-11-25T17:49:56.682639+01:00 ws7 kernel: [    0.323625] system 00:04: [io  0x0c00-0x0c01] has been reserved
2024-11-25T17:49:56.682639+01:00 ws7 kernel: [    0.323628] system 00:04: [io  0x0c14] has been reserved
2024-11-25T17:49:56.682639+01:00 ws7 kernel: [    0.323630] system 00:04: [io  0x0c50-0x0c51] has been reserved
2024-11-25T17:49:56.682643+01:00 ws7 kernel: [    0.323633] system 00:04: [io  0x0c52] has been reserved
2024-11-25T17:49:56.682643+01:00 ws7 kernel: [    0.323636] system 00:04: [io  0x0c6c] has been reserved
2024-11-25T17:49:56.682644+01:00 ws7 kernel: [    0.323638] system 00:04: [io  0x0c6f] has been reserved
2024-11-25T17:49:56.682644+01:00 ws7 kernel: [    0.323641] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
2024-11-25T17:49:56.682644+01:00 ws7 kernel: [    0.323643] system 00:04: [io  0x0800-0x089f] has been reserved
2024-11-25T17:49:56.682713+01:00 ws7 kernel: [    0.323646] system 00:04: [io  0x0b00-0x0b0f] has been reserved
2024-11-25T17:49:56.682714+01:00 ws7 kernel: [    0.323649] system 00:04: [io  0x0b20-0x0b3f] has been reserved
2024-11-25T17:49:56.682729+01:00 ws7 kernel: [    0.323651] system 00:04: [io  0x0900-0x090f] has been reserved
2024-11-25T17:49:56.682729+01:00 ws7 kernel: [    0.323654] system 00:04: [io  0x0910-0x091f] has been reserved
2024-11-25T17:49:56.682730+01:00 ws7 kernel: [    0.323657] system 00:04: [mem 0xfedc0000-0xfedc0fff] has been reserved
2024-11-25T17:49:56.682730+01:00 ws7 kernel: [    0.323660] system 00:04: [mem 0xfee00000-0xfee00fff] has been reserved
2024-11-25T17:49:56.682730+01:00 ws7 kernel: [    0.323663] system 00:04: [mem 0xfec10000-0xfec10fff] has been reserved
2024-11-25T17:49:56.682730+01:00 ws7 kernel: [    0.323666] system 00:04: [mem 0xff000000-0xffffffff] has been reserved
2024-11-25T17:49:56.682731+01:00 ws7 kernel: [    0.323668] pnp: PnP ACPI: found 5 devices
2024-11-25T17:49:56.682731+01:00 ws7 kernel: [    0.329397] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
2024-11-25T17:49:56.682731+01:00 ws7 kernel: [    0.329469] NET: Registered PF_INET protocol family
2024-11-25T17:49:56.682732+01:00 ws7 kernel: [    0.329563] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
2024-11-25T17:49:56.682740+01:00 ws7 kernel: [    0.337839] tcp_listen_portaddr_hash hash table entries: 65536 (order: 8, 1048576 bytes, linear)
2024-11-25T17:49:56.682740+01:00 ws7 kernel: [    0.337889] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
2024-11-25T17:49:56.682740+01:00 ws7 kernel: [    0.338011] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, linear)
2024-11-25T17:49:56.682741+01:00 ws7 kernel: [    0.338240] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
2024-11-25T17:49:56.682741+01:00 ws7 kernel: [    0.338300] TCP: Hash tables configured (established 524288 bind 65536)
2024-11-25T17:49:56.682741+01:00 ws7 kernel: [    0.338408] MPTCP token hash table entries: 65536 (order: 8, 1572864 bytes, linear)
2024-11-25T17:49:56.682745+01:00 ws7 kernel: [    0.338507] UDP hash table entries: 65536 (order: 9, 2097152 bytes, linear)
2024-11-25T17:49:56.682745+01:00 ws7 kernel: [    0.338642] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes, linear)
2024-11-25T17:49:56.682745+01:00 ws7 kernel: [    0.338756] NET: Registered PF_UNIX/PF_LOCAL protocol family
2024-11-25T17:49:56.682745+01:00 ws7 kernel: [    0.338764] NET: Registered PF_XDP protocol family
2024-11-25T17:49:56.682746+01:00 ws7 kernel: [    0.338779] pci 0000:00:01.2: PCI bridge to [bus 01]
2024-11-25T17:49:56.682746+01:00 ws7 kernel: [    0.338788] pci 0000:00:01.2:   bridge window [io  0xf000-0xffff]
2024-11-25T17:49:56.682747+01:00 ws7 kernel: [    0.338793] pci 0000:00:01.2:   bridge window [mem 0xf6f00000-0xf6ffffff]
2024-11-25T17:49:56.682748+01:00 ws7 kernel: [    0.338815] pci 0000:00:01.3: PCI bridge to [bus 02]
2024-11-25T17:49:56.682748+01:00 ws7 kernel: [    0.338825] pci 0000:00:01.3:   bridge window [mem 0xf6e00000-0xf6efffff]
2024-11-25T17:49:56.682749+01:00 ws7 kernel: [    0.338862] pci 0000:00:02.3: PCI bridge to [bus 03]
2024-11-25T17:49:56.682749+01:00 ws7 kernel: [    0.338865] pci 0000:00:02.3:   bridge window [io  0xe000-0xefff]
2024-11-25T17:49:56.682749+01:00 ws7 kernel: [    0.338869] pci 0000:00:02.3:   bridge window [mem 0xf6d00000-0xf6dfffff]
2024-11-25T17:49:56.682749+01:00 ws7 kernel: [    0.338891] pci 0000:00:08.1: PCI bridge to [bus 04]
2024-11-25T17:49:56.682751+01:00 ws7 kernel: [    0.338893] pci 0000:00:08.1:   bridge window [io  0xd000-0xdfff]
2024-11-25T17:49:56.682751+01:00 ws7 kernel: [    0.338899] pci 0000:00:08.1:   bridge window [mem 0xf6600000-0xf6bfffff]
2024-11-25T17:49:56.682752+01:00 ws7 kernel: [    0.338903] pci 0000:00:08.1:   bridge window [mem 0xfce0000000-0xfcefffffff 64bit pref]
2024-11-25T17:49:56.682752+01:00 ws7 kernel: [    0.338908] pci 0000:00:08.2: PCI bridge to [bus 05]
2024-11-25T17:49:56.682752+01:00 ws7 kernel: [    0.338912] pci 0000:00:08.2:   bridge window [mem 0xf6c00000-0xf6cfffff]
2024-11-25T17:49:56.682752+01:00 ws7 kernel: [    0.338916] pci 0000:00:08.2:   bridge window [mem 0xfcf0000000-0xfcf00fffff 64bit pref]
2024-11-25T17:49:56.682755+01:00 ws7 kernel: [    0.338922] pci 0000:00:08.3: PCI bridge to [bus 06]
2024-11-25T17:49:56.682755+01:00 ws7 kernel: [    0.338929] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
2024-11-25T17:49:56.682755+01:00 ws7 kernel: [    0.338932] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
2024-11-25T17:49:56.682755+01:00 ws7 kernel: [    0.338935] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
2024-11-25T17:49:56.682755+01:00 ws7 kernel: [    0.338938] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
2024-11-25T17:49:56.682755+01:00 ws7 kernel: [    0.338940] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
2024-11-25T17:49:56.682756+01:00 ws7 kernel: [    0.338943] pci_bus 0000:00: resource 9 [mem 0xa0000000-0xf6ffffff window]
2024-11-25T17:49:56.682758+01:00 ws7 kernel: [    0.338946] pci_bus 0000:00: resource 10 [mem 0x1860000000-0xfcffffffff window]
2024-11-25T17:49:56.682758+01:00 ws7 kernel: [    0.338949] pci_bus 0000:01: resource 0 [io  0xf000-0xffff]
2024-11-25T17:49:56.682758+01:00 ws7 kernel: [    0.338952] pci_bus 0000:01: resource 1 [mem 0xf6f00000-0xf6ffffff]
2024-11-25T17:49:56.682758+01:00 ws7 kernel: [    0.338955] pci_bus 0000:02: resource 1 [mem 0xf6e00000-0xf6efffff]
2024-11-25T17:49:56.682758+01:00 ws7 kernel: [    0.338957] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
2024-11-25T17:49:56.682759+01:00 ws7 kernel: [    0.338960] pci_bus 0000:03: resource 1 [mem 0xf6d00000-0xf6dfffff]
2024-11-25T17:49:56.682761+01:00 ws7 kernel: [    0.338963] pci_bus 0000:04: resource 0 [io  0xd000-0xdfff]
2024-11-25T17:49:56.682761+01:00 ws7 kernel: [    0.338965] pci_bus 0000:04: resource 1 [mem 0xf6600000-0xf6bfffff]
2024-11-25T17:49:56.682762+01:00 ws7 kernel: [    0.338968] pci_bus 0000:04: resource 2 [mem 0xfce0000000-0xfcefffffff 64bit pref]
2024-11-25T17:49:56.682762+01:00 ws7 kernel: [    0.338971] pci_bus 0000:05: resource 1 [mem 0xf6c00000-0xf6cfffff]
2024-11-25T17:49:56.682762+01:00 ws7 kernel: [    0.338974] pci_bus 0000:05: resource 2 [mem 0xfcf0000000-0xfcf00fffff 64bit pref]
2024-11-25T17:49:56.682762+01:00 ws7 kernel: [    0.339167] pci 0000:04:00.1: D0 power state depends on 0000:04:00.0
2024-11-25T17:49:56.682763+01:00 ws7 kernel: [    0.339454] PCI: CLS 64 bytes, default 64
2024-11-25T17:49:56.682765+01:00 ws7 kernel: [    0.339484] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
2024-11-25T17:49:56.682765+01:00 ws7 kernel: [    0.339512] Trying to unpack rootfs image as initramfs...
2024-11-25T17:49:56.682765+01:00 ws7 kernel: [    0.339529] pci 0000:00:01.0: Adding to iommu group 0
2024-11-25T17:49:56.682765+01:00 ws7 kernel: [    0.339543] pci 0000:00:01.2: Adding to iommu group 1
2024-11-25T17:49:56.682766+01:00 ws7 kernel: [    0.339557] pci 0000:00:01.3: Adding to iommu group 2
2024-11-25T17:49:56.682766+01:00 ws7 kernel: [    0.339592] pci 0000:00:02.0: Adding to iommu group 3
2024-11-25T17:49:56.682768+01:00 ws7 kernel: [    0.339613] pci 0000:00:02.3: Adding to iommu group 4
2024-11-25T17:49:56.682769+01:00 ws7 kernel: [    0.339629] pci 0000:00:03.0: Adding to iommu group 5
2024-11-25T17:49:56.682769+01:00 ws7 kernel: [    0.339645] pci 0000:00:04.0: Adding to iommu group 6
2024-11-25T17:49:56.682769+01:00 ws7 kernel: [    0.339668] pci 0000:00:08.0: Adding to iommu group 7
2024-11-25T17:49:56.682769+01:00 ws7 kernel: [    0.339680] pci 0000:00:08.1: Adding to iommu group 8
2024-11-25T17:49:56.682769+01:00 ws7 kernel: [    0.339693] pci 0000:00:08.2: Adding to iommu group 9
2024-11-25T17:49:56.682772+01:00 ws7 kernel: [    0.339705] pci 0000:00:08.3: Adding to iommu group 10
2024-11-25T17:49:56.682772+01:00 ws7 kernel: [    0.339725] pci 0000:00:14.0: Adding to iommu group 11
2024-11-25T17:49:56.682772+01:00 ws7 kernel: [    0.339737] pci 0000:00:14.3: Adding to iommu group 11
2024-11-25T17:49:56.682772+01:00 ws7 kernel: [    0.339782] pci 0000:00:18.0: Adding to iommu group 12
2024-11-25T17:49:56.682772+01:00 ws7 kernel: [    0.339794] pci 0000:00:18.1: Adding to iommu group 12
2024-11-25T17:49:56.682772+01:00 ws7 kernel: [    0.339805] pci 0000:00:18.2: Adding to iommu group 12
2024-11-25T17:49:56.682773+01:00 ws7 kernel: [    0.339816] pci 0000:00:18.3: Adding to iommu group 12
2024-11-25T17:49:56.682775+01:00 ws7 kernel: [    0.339828] pci 0000:00:18.4: Adding to iommu group 12
2024-11-25T17:49:56.682775+01:00 ws7 kernel: [    0.339839] pci 0000:00:18.5: Adding to iommu group 12
2024-11-25T17:49:56.682775+01:00 ws7 kernel: [    0.339851] pci 0000:00:18.6: Adding to iommu group 12
2024-11-25T17:49:56.682775+01:00 ws7 kernel: [    0.339862] pci 0000:00:18.7: Adding to iommu group 12
2024-11-25T17:49:56.682775+01:00 ws7 kernel: [    0.339880] pci 0000:01:00.0: Adding to iommu group 13
2024-11-25T17:49:56.682776+01:00 ws7 kernel: [    0.339892] pci 0000:02:00.0: Adding to iommu group 14
2024-11-25T17:49:56.682778+01:00 ws7 kernel: [    0.339905] pci 0000:03:00.0: Adding to iommu group 15
2024-11-25T17:49:56.682778+01:00 ws7 kernel: [    0.339929] pci 0000:04:00.0: Adding to iommu group 16
2024-11-25T17:49:56.682778+01:00 ws7 kernel: [    0.339941] pci 0000:04:00.1: Adding to iommu group 17
2024-11-25T17:49:56.682778+01:00 ws7 kernel: [    0.339954] pci 0000:04:00.2: Adding to iommu group 18
2024-11-25T17:49:56.682779+01:00 ws7 kernel: [    0.339968] pci 0000:04:00.3: Adding to iommu group 19
2024-11-25T17:49:56.682779+01:00 ws7 kernel: [    0.339981] pci 0000:04:00.4: Adding to iommu group 20
2024-11-25T17:49:56.682780+01:00 ws7 kernel: [    0.339994] pci 0000:04:00.6: Adding to iommu group 21
2024-11-25T17:49:56.682781+01:00 ws7 kernel: [    0.340007] pci 0000:05:00.0: Adding to iommu group 22
2024-11-25T17:49:56.682781+01:00 ws7 kernel: [    0.340022] pci 0000:05:00.1: Adding to iommu group 23
2024-11-25T17:49:56.682782+01:00 ws7 kernel: [    0.340033] pci 0000:06:00.0: Adding to iommu group 24
2024-11-25T17:49:56.682782+01:00 ws7 kernel: [    0.342120] AMD-Vi: Extended features (0x246577efa2254afa, 0x0): PPR NX GT [5] IA GA PC GA_vAPIC
2024-11-25T17:49:56.682782+01:00 ws7 kernel: [    0.342129] AMD-Vi: Interrupt remapping enabled
2024-11-25T17:49:56.682782+01:00 ws7 kernel: [    0.488825] Freeing initrd memory: 49932K
2024-11-25T17:49:56.682785+01:00 ws7 kernel: [    0.571587] AMD-Vi: Virtual APIC enabled
2024-11-25T17:49:56.682785+01:00 ws7 kernel: [    0.571627] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
2024-11-25T17:49:56.682785+01:00 ws7 kernel: [    0.571641] software IO TLB: mapped [mem 0x0000000075cea000-0x0000000079cea000] (64MB)
2024-11-25T17:49:56.682785+01:00 ws7 kernel: [    0.571692] LVT offset 0 assigned for vector 0x400
2024-11-25T17:49:56.682785+01:00 ws7 kernel: [    0.571789] perf: AMD IBS detected (0x00000bff)
2024-11-25T17:49:56.682785+01:00 ws7 kernel: [    0.571873] amd_uncore: 4 amd_df counters detected
2024-11-25T17:49:56.682788+01:00 ws7 kernel: [    0.571883] amd_uncore: 6 amd_l3 counters detected
2024-11-25T17:49:56.682788+01:00 ws7 kernel: [    0.571892] amd_uncore: 4 amd_umc_0 counters detected
2024-11-25T17:49:56.682789+01:00 ws7 kernel: [    0.571902] amd_uncore: 4 amd_umc_1 counters detected
2024-11-25T17:49:56.682789+01:00 ws7 kernel: [    0.571999] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).
2024-11-25T17:49:56.682789+01:00 ws7 kernel: [    0.572663] Initialise system trusted keyrings
2024-11-25T17:49:56.682789+01:00 ws7 kernel: [    0.572674] Key type blacklist registered
2024-11-25T17:49:56.682789+01:00 ws7 kernel: [    0.572702] workingset: timestamp_bits=36 max_order=25 bucket_order=0
2024-11-25T17:49:56.682792+01:00 ws7 kernel: [    0.572712] zbud: loaded
2024-11-25T17:49:56.682792+01:00 ws7 kernel: [    0.572800] fuse: init (API version 7.40)
2024-11-25T17:49:56.682792+01:00 ws7 kernel: [    0.572937] integrity: Platform Keyring initialized
2024-11-25T17:49:56.682793+01:00 ws7 kernel: [    0.572940] integrity: Machine keyring initialized
2024-11-25T17:49:56.682793+01:00 ws7 kernel: [    0.579608] Key type asymmetric registered
2024-11-25T17:49:56.682793+01:00 ws7 kernel: [    0.579610] Asymmetric key parser 'x509' registered
2024-11-25T17:49:56.682795+01:00 ws7 kernel: [    0.583185] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
2024-11-25T17:49:56.682796+01:00 ws7 kernel: [    0.583220] io scheduler mq-deadline registered
2024-11-25T17:49:56.682796+01:00 ws7 kernel: [    0.585601] pcieport 0000:00:01.2: PME: Signaling with IRQ 28
2024-11-25T17:49:56.682796+01:00 ws7 kernel: [    0.585647] pcieport 0000:00:01.2: AER: enabled with IRQ 28
2024-11-25T17:49:56.682840+01:00 ws7 kernel: [    0.585902] pcieport 0000:00:01.3: PME: Signaling with IRQ 29
2024-11-25T17:49:56.682841+01:00 ws7 kernel: [    0.585976] pcieport 0000:00:01.3: AER: enabled with IRQ 29
2024-11-25T17:49:56.682842+01:00 ws7 kernel: [    0.586184] pcieport 0000:00:02.3: PME: Signaling with IRQ 30
2024-11-25T17:49:56.682844+01:00 ws7 kernel: [    0.586225] pcieport 0000:00:02.3: AER: enabled with IRQ 30
2024-11-25T17:49:56.682844+01:00 ws7 kernel: [    0.586419] pcieport 0000:00:08.1: PME: Signaling with IRQ 31
2024-11-25T17:49:56.682844+01:00 ws7 kernel: [    0.586631] pcieport 0000:00:08.2: PME: Signaling with IRQ 32
2024-11-25T17:49:56.682844+01:00 ws7 kernel: [    0.586827] pcieport 0000:00:08.3: PME: Signaling with IRQ 33
2024-11-25T17:49:56.682844+01:00 ws7 kernel: [    0.586907] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
2024-11-25T17:49:56.682844+01:00 ws7 kernel: [    0.587244] Estimated ratio of average max frequency by base frequency (times 1024): 1333
2024-11-25T17:49:56.682847+01:00 ws7 kernel: [    0.587254] Monitor-Mwait will be used to enter C-1 state
2024-11-25T17:49:56.682847+01:00 ws7 kernel: [    0.587256] ACPI: \_SB_.PLTF.C000: Found 3 idle states
2024-11-25T17:49:56.682847+01:00 ws7 kernel: [    0.587362] ACPI: \_SB_.PLTF.C002: Found 3 idle states
2024-11-25T17:49:56.682847+01:00 ws7 kernel: [    0.587498] ACPI: \_SB_.PLTF.C004: Found 3 idle states
2024-11-25T17:49:56.682847+01:00 ws7 kernel: [    0.587630] ACPI: \_SB_.PLTF.C006: Found 3 idle states
2024-11-25T17:49:56.682848+01:00 ws7 kernel: [    0.587758] ACPI: \_SB_.PLTF.C008: Found 3 idle states
2024-11-25T17:49:56.682850+01:00 ws7 kernel: [    0.587897] ACPI: \_SB_.PLTF.C00A: Found 3 idle states
2024-11-25T17:49:56.682850+01:00 ws7 kernel: [    0.588037] ACPI: \_SB_.PLTF.C00C: Found 3 idle states
2024-11-25T17:49:56.682850+01:00 ws7 kernel: [    0.588175] ACPI: \_SB_.PLTF.C00E: Found 3 idle states
2024-11-25T17:49:56.682850+01:00 ws7 kernel: [    0.588287] ACPI: \_SB_.PLTF.C001: Found 3 idle states
2024-11-25T17:49:56.682850+01:00 ws7 kernel: [    0.588365] ACPI: \_SB_.PLTF.C003: Found 3 idle states
2024-11-25T17:49:56.682850+01:00 ws7 kernel: [    0.588465] ACPI: \_SB_.PLTF.C005: Found 3 idle states
2024-11-25T17:49:56.682851+01:00 ws7 kernel: [    0.588570] ACPI: \_SB_.PLTF.C007: Found 3 idle states
2024-11-25T17:49:56.682853+01:00 ws7 kernel: [    0.588675] ACPI: \_SB_.PLTF.C009: Found 3 idle states
2024-11-25T17:49:56.682853+01:00 ws7 kernel: [    0.588792] ACPI: \_SB_.PLTF.C00B: Found 3 idle states
2024-11-25T17:49:56.682853+01:00 ws7 kernel: [    0.588904] ACPI: \_SB_.PLTF.C00D: Found 3 idle states
2024-11-25T17:49:56.682853+01:00 ws7 kernel: [    0.589013] ACPI: \_SB_.PLTF.C00F: Found 3 idle states
2024-11-25T17:49:56.682853+01:00 ws7 kernel: [    0.589221] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
2024-11-25T17:49:56.682854+01:00 ws7 kernel: [    0.589636] Linux agpgart interface v0.103
2024-11-25T17:49:56.682856+01:00 ws7 kernel: [    0.755615] tpm_crb MSFT0101:00: Disabling hwrng
2024-11-25T17:49:56.682856+01:00 ws7 kernel: [    0.756864] i8042: PNP: No PS/2 controller found.
2024-11-25T17:49:56.682856+01:00 ws7 kernel: [    0.756906] mousedev: PS/2 mouse device common for all mice
2024-11-25T17:49:56.682856+01:00 ws7 kernel: [    0.756922] rtc_cmos 00:02: RTC can wake from S4
2024-11-25T17:49:56.682856+01:00 ws7 kernel: [    0.757201] rtc_cmos 00:02: registered as rtc0
2024-11-25T17:49:56.682857+01:00 ws7 kernel: [    0.757236] rtc_cmos 00:02: setting system clock to 2024-11-25T16:49:52 UTC (1732553392)
2024-11-25T17:49:56.682858+01:00 ws7 kernel: [    0.757264] rtc_cmos 00:02: alarms up to one month, y3k, 114 bytes nvram
2024-11-25T17:49:56.682859+01:00 ws7 kernel: [    0.758078] ledtrig-cpu: registered to indicate activity on CPUs
2024-11-25T17:49:56.682859+01:00 ws7 kernel: [    0.758367] NET: Registered PF_INET6 protocol family
2024-11-25T17:49:56.682859+01:00 ws7 kernel: [    0.761603] Segment Routing with IPv6
2024-11-25T17:49:56.682859+01:00 ws7 kernel: [    0.761616] In-situ OAM (IOAM) with IPv6
2024-11-25T17:49:56.682860+01:00 ws7 kernel: [    0.761640] mip6: Mobile IPv6
2024-11-25T17:49:56.682860+01:00 ws7 kernel: [    0.761646] NET: Registered PF_PACKET protocol family
2024-11-25T17:49:56.682862+01:00 ws7 kernel: [    0.761672] mpls_gso: MPLS GSO support
2024-11-25T17:49:56.682862+01:00 ws7 kernel: [    0.762722] microcode: Current revision: 0x0a705205
2024-11-25T17:49:56.682862+01:00 ws7 kernel: [    0.762924] resctrl: L3 allocation detected
2024-11-25T17:49:56.682862+01:00 ws7 kernel: [    0.762926] resctrl: MB allocation detected
2024-11-25T17:49:56.682863+01:00 ws7 kernel: [    0.762928] resctrl: SMBA allocation detected
2024-11-25T17:49:56.682863+01:00 ws7 kernel: [    0.762930] resctrl: L3 monitoring detected
2024-11-25T17:49:56.682871+01:00 ws7 kernel: [    0.762947] IPI shorthand broadcast: enabled
2024-11-25T17:49:56.682873+01:00 ws7 kernel: [    0.764273] sched_clock: Marking stable (762433052, 488261)->(767115782, -4194469)
2024-11-25T17:49:56.682873+01:00 ws7 kernel: [    0.764376] registered taskstats version 1
2024-11-25T17:49:56.682873+01:00 ws7 kernel: [    0.764469] Loading compiled-in X.509 certificates
2024-11-25T17:49:56.682874+01:00 ws7 kernel: [    0.774160] Loaded X.509 cert 'Build time autogenerated kernel key: b97a9cdb53c489384dfd3b51b14fb4971baa68d3'
2024-11-25T17:49:56.682874+01:00 ws7 kernel: [    0.775828] Demotion targets for Node 0: null
2024-11-25T17:49:56.682876+01:00 ws7 kernel: [    0.775868] Key type .fscrypt registered
2024-11-25T17:49:56.682877+01:00 ws7 kernel: [    0.775870] Key type fscrypt-provisioning registered
2024-11-25T17:49:56.682878+01:00 ws7 kernel: [    0.779894] cryptd: max_cpu_qlen set to 1000
2024-11-25T17:49:56.682878+01:00 ws7 kernel: [    0.781894] AES CTR mode by8 optimization enabled
2024-11-25T17:49:56.682878+01:00 ws7 kernel: [    0.795966] Key type encrypted registered
2024-11-25T17:49:56.682878+01:00 ws7 kernel: [    0.795971] AppArmor: AppArmor sha256 policy hashing enabled
2024-11-25T17:49:56.682878+01:00 ws7 kernel: [    0.796057] ima: Allocated hash algorithm: sha256
2024-11-25T17:49:56.682880+01:00 ws7 kernel: [    1.024975] ima: No architecture policies found
2024-11-25T17:49:56.682880+01:00 ws7 kernel: [    1.024999] evm: Initialising EVM extended attributes:
2024-11-25T17:49:56.682881+01:00 ws7 kernel: [    1.025003] evm: security.selinux
2024-11-25T17:49:56.682881+01:00 ws7 kernel: [    1.025006] evm: security.SMACK64 (disabled)
2024-11-25T17:49:56.682881+01:00 ws7 kernel: [    1.025010] evm: security.SMACK64EXEC (disabled)
2024-11-25T17:49:56.682881+01:00 ws7 kernel: [    1.025013] evm: security.SMACK64TRANSMUTE (disabled)
2024-11-25T17:49:56.682883+01:00 ws7 kernel: [    1.025017] evm: security.SMACK64MMAP (disabled)
2024-11-25T17:49:56.682883+01:00 ws7 kernel: [    1.025020] evm: security.apparmor
2024-11-25T17:49:56.682883+01:00 ws7 kernel: [    1.025023] evm: security.ima
2024-11-25T17:49:56.682883+01:00 ws7 kernel: [    1.025025] evm: security.capability
2024-11-25T17:49:56.682884+01:00 ws7 kernel: [    1.025028] evm: HMAC attrs: 0x1
2024-11-25T17:49:56.682884+01:00 ws7 kernel: [    1.122601] RAS: Correctable Errors collector initialized.
2024-11-25T17:49:56.682884+01:00 ws7 kernel: [    1.130670] clk: Disabling unused clocks
2024-11-25T17:49:56.682886+01:00 ws7 kernel: [    1.130674] PM: genpd: Disabling unused power domains
2024-11-25T17:49:56.682886+01:00 ws7 kernel: [    1.131450] Freeing unused decrypted memory: 2028K
2024-11-25T17:49:56.682886+01:00 ws7 kernel: [    1.131733] Freeing unused kernel image (initmem) memory: 4136K
2024-11-25T17:49:56.682886+01:00 ws7 kernel: [    1.131741] Write protecting the kernel read-only data: 28672k
2024-11-25T17:49:56.682886+01:00 ws7 kernel: [    1.132011] Freeing unused kernel image (rodata/data gap) memory: 1148K
2024-11-25T17:49:56.682887+01:00 ws7 kernel: [    1.160555] x86/mm: Checked W+X mappings: passed, no W+X pages found.
2024-11-25T17:49:56.682888+01:00 ws7 kernel: [    1.160562] Run /init as init process
2024-11-25T17:49:56.682889+01:00 ws7 kernel: [    1.160564]   with arguments:
2024-11-25T17:49:56.682889+01:00 ws7 kernel: [    1.160565]     /init
2024-11-25T17:49:56.682889+01:00 ws7 kernel: [    1.160566]   with environment:
2024-11-25T17:49:56.682889+01:00 ws7 kernel: [    1.160567]     HOME=/
2024-11-25T17:49:56.682889+01:00 ws7 kernel: [    1.160568]     TERM=linux
2024-11-25T17:49:56.682890+01:00 ws7 kernel: [    1.240574] ACPI: video: Video Device [VGA] (multi-head: yes  rom: no  post: no)
2024-11-25T17:49:56.682891+01:00 ws7 kernel: [    1.240795] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:1a/LNXVIDEO:00/input/input0
2024-11-25T17:49:56.682892+01:00 ws7 kernel: [    1.241590] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
2024-11-25T17:49:56.682892+01:00 ws7 kernel: [    1.241595] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus port selection
2024-11-25T17:49:56.682892+01:00 ws7 kernel: [    1.242235] i2c i2c-0: Successfully instantiated SPD at 0x50
2024-11-25T17:49:56.682892+01:00 ws7 kernel: [    1.242852] piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
2024-11-25T17:49:56.682892+01:00 ws7 kernel: [    1.243444] i2c i2c-2: Successfully instantiated SPD at 0x50
2024-11-25T17:49:56.682894+01:00 ws7 kernel: [    1.244020] i2c i2c-2: Successfully instantiated SPD at 0x51
2024-11-25T17:49:56.682895+01:00 ws7 kernel: [    1.246750] SCSI subsystem initialized
2024-11-25T17:49:56.682895+01:00 ws7 kernel: [    1.246756] nvme nvme0: pci function 0000:02:00.0
2024-11-25T17:49:56.682895+01:00 ws7 kernel: [    1.248587] nvme nvme0: bad crto:0 cap:8202020ff0103ff
2024-11-25T17:49:56.682895+01:00 ws7 kernel: [    1.248760] ACPI: bus type USB registered
2024-11-25T17:49:56.682895+01:00 ws7 kernel: [    1.248780] usbcore: registered new interface driver usbfs
2024-11-25T17:49:56.682897+01:00 ws7 kernel: [    1.248788] usbcore: registered new interface driver hub
2024-11-25T17:49:56.682897+01:00 ws7 kernel: [    1.248799] usbcore: registered new device driver usb
2024-11-25T17:49:56.682897+01:00 ws7 kernel: [    1.261083] nvme nvme0: allocated 40 MiB host memory buffer.
2024-11-25T17:49:56.682897+01:00 ws7 kernel: [    1.305476] nvme nvme0: 16/0/0 default/read/poll queues
2024-11-25T17:49:56.682898+01:00 ws7 kernel: [    1.347697]  nvme0n1: p1 p2 p3
2024-11-25T17:49:56.682898+01:00 ws7 kernel: [    1.360191] libata version 3.00 loaded.
2024-11-25T17:49:56.682899+01:00 ws7 kernel: [    1.360223] xhci_hcd 0000:04:00.3: xHCI Host Controller
2024-11-25T17:49:56.682900+01:00 ws7 kernel: [    1.360231] xhci_hcd 0000:04:00.3: new USB bus registered, assigned bus number 1
2024-11-25T17:49:56.682900+01:00 ws7 kernel: [    1.360602] xhci_hcd 0000:04:00.3: hcc params 0x0128ffc5 hci version 0x120 quirks 0x0000000200000010
2024-11-25T17:49:56.682900+01:00 ws7 kernel: [    1.360990] xhci_hcd 0000:04:00.3: xHCI Host Controller
2024-11-25T17:49:56.682900+01:00 ws7 kernel: [    1.360995] xhci_hcd 0000:04:00.3: new USB bus registered, assigned bus number 2
2024-11-25T17:49:56.682901+01:00 ws7 kernel: [    1.360999] xhci_hcd 0000:04:00.3: Host supports USB 3.1 Enhanced SuperSpeed
2024-11-25T17:49:56.682901+01:00 ws7 kernel: [    1.361032] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.11
2024-11-25T17:49:56.682903+01:00 ws7 kernel: [    1.361036] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
2024-11-25T17:49:56.682903+01:00 ws7 kernel: [    1.361039] usb usb1: Product: xHCI Host Controller
2024-11-25T17:49:56.682903+01:00 ws7 kernel: [    1.361042] usb usb1: Manufacturer: Linux 6.11.5 xhci-hcd
2024-11-25T17:49:56.682903+01:00 ws7 kernel: [    1.361044] usb usb1: SerialNumber: 0000:04:00.3
2024-11-25T17:49:56.682903+01:00 ws7 kernel: [    1.361141] hub 1-0:1.0: USB hub found
2024-11-25T17:49:56.682903+01:00 ws7 kernel: [    1.361157] hub 1-0:1.0: 2 ports detected
2024-11-25T17:49:56.682905+01:00 ws7 kernel: [    1.361688] ahci 0000:01:00.0: version 3.0
2024-11-25T17:49:56.682905+01:00 ws7 kernel: [    1.361693] ahci 0000:01:00.0: enabling device (0000 -> 0003)
2024-11-25T17:49:56.682906+01:00 ws7 kernel: [    1.361708] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
2024-11-25T17:49:56.682906+01:00 ws7 kernel: [    1.361733] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.11
2024-11-25T17:49:56.682906+01:00 ws7 kernel: [    1.361738] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
2024-11-25T17:49:56.682906+01:00 ws7 kernel: [    1.361742] usb usb2: Product: xHCI Host Controller
2024-11-25T17:49:56.682906+01:00 ws7 kernel: [    1.361745] usb usb2: Manufacturer: Linux 6.11.5 xhci-hcd
2024-11-25T17:49:56.682908+01:00 ws7 kernel: [    1.361748] usb usb2: SerialNumber: 0000:04:00.3
2024-11-25T17:49:56.682908+01:00 ws7 kernel: [    1.361829] hub 2-0:1.0: USB hub found
2024-11-25T17:49:56.682909+01:00 ws7 kernel: [    1.361846] hub 2-0:1.0: 2 ports detected
2024-11-25T17:49:56.682909+01:00 ws7 kernel: [    1.361853] ahci 0000:01:00.0: SSS flag set, parallel bus scan disabled
2024-11-25T17:49:56.682909+01:00 ws7 kernel: [    1.361886] ahci 0000:01:00.0: AHCI vers 0001.0200, 32 command slots, 6 Gbps, SATA mode
2024-11-25T17:49:56.682909+01:00 ws7 kernel: [    1.361890] ahci 0000:01:00.0: 2/2 ports implemented (port mask 0x3)
2024-11-25T17:49:56.682969+01:00 ws7 kernel: [    1.361893] ahci 0000:01:00.0: flags: 64bit ncq sntf stag led clo pmp pio slum part ccc 
2024-11-25T17:49:56.682969+01:00 ws7 kernel: [    1.362099] scsi host0: ahci
2024-11-25T17:49:56.682969+01:00 ws7 kernel: [    1.362189] scsi host1: ahci
2024-11-25T17:49:56.682970+01:00 ws7 kernel: [    1.362234] ata1: SATA max UDMA/133 abar m512@0xf6f00000 port 0xf6f00100 irq 55 lpm-pol 3
2024-11-25T17:49:56.682970+01:00 ws7 kernel: [    1.362238] ata2: SATA max UDMA/133 abar m512@0xf6f00000 port 0xf6f00180 irq 55 lpm-pol 3
2024-11-25T17:49:56.682970+01:00 ws7 kernel: [    1.362736] xhci_hcd 0000:04:00.4: xHCI Host Controller
2024-11-25T17:49:56.682972+01:00 ws7 kernel: [    1.362747] xhci_hcd 0000:04:00.4: new USB bus registered, assigned bus number 3
2024-11-25T17:49:56.682972+01:00 ws7 kernel: [    1.363113] xhci_hcd 0000:04:00.4: USB3 root hub has no ports
2024-11-25T17:49:56.682972+01:00 ws7 kernel: [    1.363119] xhci_hcd 0000:04:00.4: hcc params 0x0110ffc5 hci version 0x120 quirks 0x0000000200000010
2024-11-25T17:49:56.682972+01:00 ws7 kernel: [    1.363540] xhci_hcd 0000:04:00.4: xHCI Host Controller
2024-11-25T17:49:56.682972+01:00 ws7 kernel: [    1.363547] xhci_hcd 0000:04:00.4: new USB bus registered, assigned bus number 4
2024-11-25T17:49:56.682973+01:00 ws7 kernel: [    1.363553] xhci_hcd 0000:04:00.4: Host supports USB 3.0 SuperSpeed
2024-11-25T17:49:56.682973+01:00 ws7 kernel: [    1.363598] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.11
2024-11-25T17:49:56.682975+01:00 ws7 kernel: [    1.363605] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
2024-11-25T17:49:56.682975+01:00 ws7 kernel: [    1.363611] usb usb3: Product: xHCI Host Controller
2024-11-25T17:49:56.682975+01:00 ws7 kernel: [    1.363615] usb usb3: Manufacturer: Linux 6.11.5 xhci-hcd
2024-11-25T17:49:56.682975+01:00 ws7 kernel: [    1.363619] usb usb3: SerialNumber: 0000:04:00.4
2024-11-25T17:49:56.682975+01:00 ws7 kernel: [    1.363699] hub 3-0:1.0: USB hub found
2024-11-25T17:49:56.682975+01:00 ws7 kernel: [    1.363719] hub 3-0:1.0: 1 port detected
2024-11-25T17:49:56.682977+01:00 ws7 kernel: [    1.363867] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
2024-11-25T17:49:56.682977+01:00 ws7 kernel: [    1.363884] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.11
2024-11-25T17:49:56.682978+01:00 ws7 kernel: [    1.363888] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
2024-11-25T17:49:56.682978+01:00 ws7 kernel: [    1.363891] usb usb4: Product: xHCI Host Controller
2024-11-25T17:49:56.682978+01:00 ws7 kernel: [    1.363893] usb usb4: Manufacturer: Linux 6.11.5 xhci-hcd
2024-11-25T17:49:56.682978+01:00 ws7 kernel: [    1.363896] usb usb4: SerialNumber: 0000:04:00.4
2024-11-25T17:49:56.682980+01:00 ws7 kernel: [    1.363961] hub 4-0:1.0: USB hub found
2024-11-25T17:49:56.682980+01:00 ws7 kernel: [    1.363966] hub 4-0:1.0: config failed, hub doesn't have any ports! (err -19)
2024-11-25T17:49:56.682980+01:00 ws7 kernel: [    1.374977] r8169 0000:03:00.0 eth0: RTL8125B, 9c:6b:00:62:0b:21, XID 641, IRQ 58
2024-11-25T17:49:56.682980+01:00 ws7 kernel: [    1.374983] r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
2024-11-25T17:49:56.682981+01:00 ws7 kernel: [    1.596505] tsc: Refined TSC clocksource calibration: 4199.957 MHz
2024-11-25T17:49:56.682981+01:00 ws7 kernel: [    1.596517] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x3c8a390f0fe, max_idle_ns: 440795371908 ns
2024-11-25T17:49:56.682981+01:00 ws7 kernel: [    1.596546] clocksource: Switched to clocksource tsc
2024-11-25T17:49:56.682983+01:00 ws7 kernel: [    1.620496] usb 3-1: new high-speed USB device number 2 using xhci_hcd
2024-11-25T17:49:56.682983+01:00 ws7 kernel: [    1.620496] usb 1-2: new high-speed USB device number 2 using xhci_hcd
2024-11-25T17:49:56.682983+01:00 ws7 kernel: [    1.674855] ata1: SATA link down (SStatus 0 SControl 300)
2024-11-25T17:49:56.682983+01:00 ws7 kernel: [    1.771719] usb 3-1: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice=60.60
2024-11-25T17:49:56.682984+01:00 ws7 kernel: [    1.771726] usb 3-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
2024-11-25T17:49:56.682984+01:00 ws7 kernel: [    1.771732] usb 3-1: Product: USB2.0 Hub
2024-11-25T17:49:56.682986+01:00 ws7 kernel: [    1.778568] usb 1-2: New USB device found, idVendor=0bda, idProduct=5411, bcdDevice= 1.01
2024-11-25T17:49:56.682986+01:00 ws7 kernel: [    1.778576] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-11-25T17:49:56.682986+01:00 ws7 kernel: [    1.778581] usb 1-2: Product: USB2.1 Hub
2024-11-25T17:49:56.682986+01:00 ws7 kernel: [    1.778585] usb 1-2: Manufacturer: Generic
2024-11-25T17:49:56.682986+01:00 ws7 kernel: [    1.812045] hub 3-1:1.0: USB hub found
2024-11-25T17:49:56.682986+01:00 ws7 kernel: [    1.812593] hub 3-1:1.0: 4 ports detected
2024-11-25T17:49:56.682988+01:00 ws7 kernel: [    1.841243] hub 1-2:1.0: USB hub found
2024-11-25T17:49:56.682989+01:00 ws7 kernel: [    1.842072] hub 1-2:1.0: 5 ports detected
2024-11-25T17:49:56.682989+01:00 ws7 kernel: [    1.905091] usb 2-2: new SuperSpeed USB device number 2 using xhci_hcd
2024-11-25T17:49:56.682989+01:00 ws7 kernel: [    1.906572] usb: port power management may be unreliable
2024-11-25T17:49:56.682989+01:00 ws7 kernel: [    1.932350] usb 2-2: New USB device found, idVendor=0bda, idProduct=0411, bcdDevice= 1.01
2024-11-25T17:49:56.682989+01:00 ws7 kernel: [    1.932358] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
2024-11-25T17:49:56.682989+01:00 ws7 kernel: [    1.932363] usb 2-2: Product: USB3.2 Hub
2024-11-25T17:49:56.682991+01:00 ws7 kernel: [    1.932367] usb 2-2: Manufacturer: Generic
2024-11-25T17:49:56.682991+01:00 ws7 kernel: [    1.953232] hub 2-2:1.0: USB hub found
2024-11-25T17:49:56.682992+01:00 ws7 kernel: [    1.953964] hub 2-2:1.0: 4 ports detected
2024-11-25T17:49:56.682992+01:00 ws7 kernel: [    1.986843] ata2: SATA link down (SStatus 0 SControl 300)
2024-11-25T17:49:56.682992+01:00 ws7 kernel: [    2.056712] EXT4-fs (nvme0n1p2): mounted filesystem 3e0acb9b-9fda-4557-a33a-2c28f4cc3cf6 ro with ordered data mode. Quota mode: none.
2024-11-25T17:49:56.682992+01:00 ws7 kernel: [    2.089670] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
2024-11-25T17:49:56.682994+01:00 ws7 kernel: [    2.267457] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
2024-11-25T17:49:56.682994+01:00 ws7 kernel: [    2.267495] ACPI: button: Power Button [PWRB]
2024-11-25T17:49:56.682994+01:00 ws7 kernel: [    2.267544] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
2024-11-25T17:49:56.682995+01:00 ws7 kernel: [    2.267616] ACPI: button: Power Button [PWRF]
2024-11-25T17:49:56.682995+01:00 ws7 kernel: [    2.276162] pstore: Using crash dump compression: deflate
2024-11-25T17:49:56.682995+01:00 ws7 kernel: [    2.278181] pstore: Registered efi_pstore as persistent store backend
2024-11-25T17:49:56.682997+01:00 ws7 kernel: [    2.278505] input: PC Speaker as /devices/platform/pcspkr/input/input3
2024-11-25T17:49:56.682997+01:00 ws7 kernel: [    2.284957] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
2024-11-25T17:49:56.682997+01:00 ws7 kernel: [    2.285033] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840 ms ovfl timer
2024-11-25T17:49:56.682997+01:00 ws7 kernel: [    2.285040] RAPL PMU: hw unit of domain package 2^-16 Joules
2024-11-25T17:49:56.682997+01:00 ws7 kernel: [    2.285336] ccp 0000:04:00.2: enabling device (0000 -> 0002)
2024-11-25T17:49:56.682998+01:00 ws7 kernel: [    2.285951] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO address
2024-11-25T17:49:56.682998+01:00 ws7 kernel: [    2.287894] ccp 0000:04:00.2: tee enabled
2024-11-25T17:49:56.683000+01:00 ws7 kernel: [    2.302394] ccp 0000:04:00.2: psp enabled
2024-11-25T17:49:56.683000+01:00 ws7 kernel: [    2.318661] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
2024-11-25T17:49:56.683000+01:00 ws7 kernel: [    2.328452] ACPI: bus type drm_connector registered
2024-11-25T17:49:56.683000+01:00 ws7 kernel: [    2.349832] Error: Driver 'pcspkr' is already registered, aborting...
2024-11-25T17:49:56.683000+01:00 ws7 kernel: [    2.358242] kvm_amd: TSC scaling supported
2024-11-25T17:49:56.683000+01:00 ws7 kernel: [    2.358249] kvm_amd: Nested Virtualization enabled
2024-11-25T17:49:56.683002+01:00 ws7 kernel: [    2.358252] kvm_amd: Nested Paging enabled
2024-11-25T17:49:56.683003+01:00 ws7 kernel: [    2.358254] kvm_amd: LBR virtualization supported
2024-11-25T17:49:56.683003+01:00 ws7 kernel: [    2.358259] kvm_amd: Virtual VMLOAD VMSAVE supported
2024-11-25T17:49:56.683003+01:00 ws7 kernel: [    2.358261] kvm_amd: Virtual GIF supported
2024-11-25T17:49:56.683003+01:00 ws7 kernel: [    2.358263] kvm_amd: Virtual NMI enabled
2024-11-25T17:49:56.683003+01:00 ws7 kernel: [    2.364311] MCE: In-kernel MCE decoding enabled.
2024-11-25T17:49:56.683004+01:00 ws7 kernel: [    2.370471] amd_atl: AMD Address Translation Library initialized
2024-11-25T17:49:56.683005+01:00 ws7 kernel: [    2.370562] snd_hda_intel 0000:04:00.1: enabling device (0000 -> 0002)
2024-11-25T17:49:56.683006+01:00 ws7 kernel: [    2.370659] snd_hda_intel 0000:04:00.1: Handle vga_switcheroo audio client
2024-11-25T17:49:56.683006+01:00 ws7 kernel: [    2.370710] snd_hda_intel 0000:04:00.6: enabling device (0000 -> 0002)
2024-11-25T17:49:56.683006+01:00 ws7 kernel: [    2.371987] intel_rapl_common: Found RAPL domain package
2024-11-25T17:49:56.683006+01:00 ws7 kernel: [    2.371991] intel_rapl_common: Found RAPL domain core
2024-11-25T17:49:56.683006+01:00 ws7 kernel: [    2.576575] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input4
2024-11-25T17:49:56.683008+01:00 ws7 kernel: [    2.576622] input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input5
2024-11-25T17:49:56.683008+01:00 ws7 kernel: [    2.576656] input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input6
2024-11-25T17:49:56.683008+01:00 ws7 kernel: [    2.576692] input: HD-Audio Generic HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input7
2024-11-25T17:49:56.683009+01:00 ws7 kernel: [    2.580341] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC269VC: line_outs=1 (0x1b/0x0/0x0/0x0/0x0) type:line
2024-11-25T17:49:56.683009+01:00 ws7 kernel: [    2.580348] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
2024-11-25T17:49:56.683011+01:00 ws7 kernel: [    2.580352] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
2024-11-25T17:49:56.683011+01:00 ws7 kernel: [    2.580356] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
2024-11-25T17:49:56.683011+01:00 ws7 kernel: [    2.580359] snd_hda_codec_realtek hdaudioC1D0:    inputs:
2024-11-25T17:49:56.683011+01:00 ws7 kernel: [    2.580361] snd_hda_codec_realtek hdaudioC1D0:      Mic=0x19
2024-11-25T17:49:56.683011+01:00 ws7 kernel: [    2.580364] snd_hda_codec_realtek hdaudioC1D0:      Mic=0x18
2024-11-25T17:49:56.683011+01:00 ws7 kernel: [    2.592172] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:08.1/0000:04:00.6/sound/card1/input8
2024-11-25T17:49:56.683013+01:00 ws7 kernel: [    2.592215] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:08.1/0000:04:00.6/sound/card1/input9
2024-11-25T17:49:56.683014+01:00 ws7 kernel: [    2.592256] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:08.1/0000:04:00.6/sound/card1/input10
2024-11-25T17:49:56.683014+01:00 ws7 kernel: [    2.592286] input: HD-Audio Generic Line Out as /devices/pci0000:00/0000:00:08.1/0000:04:00.6/sound/card1/input11
2024-11-25T17:49:56.683014+01:00 ws7 kernel: [    2.592322] input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:08.1/0000:04:00.6/sound/card1/input12
2024-11-25T17:49:56.683014+01:00 ws7 kernel: [    3.673382] [drm] amdgpu kernel modesetting enabled.
2024-11-25T17:49:56.683014+01:00 ws7 kernel: [    3.678773] amdgpu: Virtual CRAT table created for CPU
2024-11-25T17:49:56.683018+01:00 ws7 kernel: [    3.678785] amdgpu: Topology: Add CPU node
2024-11-25T17:49:56.683019+01:00 ws7 kernel: [    3.678892] amdgpu 0000:04:00.0: enabling device (0006 -> 0007)
2024-11-25T17:49:56.683071+01:00 ws7 kernel: [    3.678942] [drm] initializing kernel modesetting (IP DISCOVERY 0x1002:0x15BF 0x1002:0x15BF 0x06).
2024-11-25T17:49:56.683071+01:00 ws7 kernel: [    3.678952] [drm] register mmio base: 0xF6B00000
2024-11-25T17:49:56.683071+01:00 ws7 kernel: [    3.678954] [drm] register mmio size: 524288
2024-11-25T17:49:56.683071+01:00 ws7 kernel: [    3.682130] [drm] add ip block number 0 <soc21_common>
2024-11-25T17:49:56.683074+01:00 ws7 kernel: [    3.682133] [drm] add ip block number 1 <gmc_v11_0>
2024-11-25T17:49:56.683074+01:00 ws7 kernel: [    3.682135] [drm] add ip block number 2 <ih_v6_0>
2024-11-25T17:49:56.683074+01:00 ws7 kernel: [    3.682137] [drm] add ip block number 3 <psp>
2024-11-25T17:49:56.683074+01:00 ws7 kernel: [    3.682140] [drm] add ip block number 4 <smu>
2024-11-25T17:49:56.683074+01:00 ws7 kernel: [    3.682142] [drm] add ip block number 5 <dm>
2024-11-25T17:49:56.683075+01:00 ws7 kernel: [    3.682144] [drm] add ip block number 6 <gfx_v11_0>
2024-11-25T17:49:56.683075+01:00 ws7 kernel: [    3.682146] [drm] add ip block number 7 <sdma_v6_0>
2024-11-25T17:49:56.683077+01:00 ws7 kernel: [    3.682149] [drm] add ip block number 8 <vcn_v4_0>
2024-11-25T17:49:56.683077+01:00 ws7 kernel: [    3.682151] [drm] add ip block number 9 <jpeg_v4_0>
2024-11-25T17:49:56.683077+01:00 ws7 kernel: [    3.682153] [drm] add ip block number 10 <mes_v11_0>
2024-11-25T17:49:56.683077+01:00 ws7 kernel: [    3.682174] amdgpu 0000:04:00.0: amdgpu: Fetched VBIOS from VFCT
2024-11-25T17:49:56.683078+01:00 ws7 kernel: [    3.682177] amdgpu: ATOM BIOS: 113-PHXGENERIC-001
2024-11-25T17:49:56.683078+01:00 ws7 kernel: [    3.690780] amdgpu 0000:04:00.0: vgaarb: deactivate vga console
2024-11-25T17:49:56.683080+01:00 ws7 kernel: [    3.690785] amdgpu 0000:04:00.0: amdgpu: Trusted Memory Zone (TMZ) feature enabled
2024-11-25T17:49:56.683080+01:00 ws7 kernel: [    3.690828] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
2024-11-25T17:49:56.683080+01:00 ws7 kernel: [    3.690852] amdgpu 0000:04:00.0: amdgpu: VRAM: 2048M 0x0000008000000000 - 0x000000807FFFFFFF (2048M used)
2024-11-25T17:49:56.683081+01:00 ws7 kernel: [    3.690856] amdgpu 0000:04:00.0: amdgpu: GART: 512M 0x00007FFF00000000 - 0x00007FFF1FFFFFFF
2024-11-25T17:49:56.683081+01:00 ws7 kernel: [    3.690872] [drm] Detected VRAM RAM=2048M, BAR=2048M
2024-11-25T17:49:56.683081+01:00 ws7 kernel: [    3.690874] [drm] RAM width 128bits DDR5
2024-11-25T17:49:56.683083+01:00 ws7 kernel: [    3.690959] [drm] amdgpu: 2048M of VRAM memory ready
2024-11-25T17:49:56.683083+01:00 ws7 kernel: [    3.690962] [drm] amdgpu: 47065M of GTT memory ready.
2024-11-25T17:49:56.683083+01:00 ws7 kernel: [    3.690979] [drm] GART: num cpu pages 131072, num gpu pages 131072
2024-11-25T17:49:56.683083+01:00 ws7 kernel: [    3.691428] [drm] PCIE GART of 512M enabled (table at 0x000000807FD00000).
2024-11-25T17:49:56.683084+01:00 ws7 kernel: [    3.692103] [drm] Loading DMUB firmware via PSP: version=0x08003D00
2024-11-25T17:49:56.683084+01:00 ws7 kernel: [    3.692440] [drm] Found VCN firmware Version ENC: 1.21 DEC: 8 VEP: 0 Revision: 2
2024-11-25T17:49:56.683084+01:00 ws7 kernel: [    3.717460] amdgpu 0000:04:00.0: amdgpu: reserve 0x4a00000 from 0x8070000000 for PSP TMR
2024-11-25T17:49:56.683086+01:00 ws7 kernel: [    4.391482] amdgpu 0000:04:00.0: amdgpu: RAS: optional ras ta ucode is not available
2024-11-25T17:49:56.683086+01:00 ws7 kernel: [    4.399896] amdgpu 0000:04:00.0: amdgpu: RAP: optional rap ta ucode is not available
2024-11-25T17:49:56.683087+01:00 ws7 kernel: [    4.399903] amdgpu 0000:04:00.0: amdgpu: SECUREDISPLAY: securedisplay ta ucode is not available
2024-11-25T17:49:56.683087+01:00 ws7 kernel: [    4.427867] amdgpu 0000:04:00.0: amdgpu: SMU is initialized successfully!
2024-11-25T17:49:56.683087+01:00 ws7 kernel: [    4.427872] [drm] Seamless boot condition check passed
2024-11-25T17:49:56.683087+01:00 ws7 kernel: [    4.428967] [drm] Display Core v3.2.291 initialized on DCN 3.1.4
2024-11-25T17:49:56.683089+01:00 ws7 kernel: [    4.428971] [drm] DP-HDMI FRL PCON supported
2024-11-25T17:49:56.683089+01:00 ws7 kernel: [    4.431048] [drm] DMUB hardware initialized: version=0x08003D00
2024-11-25T17:49:56.683090+01:00 ws7 kernel: [    4.432069] snd_hda_intel 0000:04:00.1: bound 0000:04:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
2024-11-25T17:49:56.683090+01:00 ws7 kernel: [    4.432845] [drm] forcing HDMI-A-1 connector on
2024-11-25T17:49:56.683090+01:00 ws7 kernel: [    4.433800] amdgpu 0000:04:00.0: amdgpu: [drm] *ERROR* Failed to read EDID
2024-11-25T17:49:56.683090+01:00 ws7 kernel: [    4.441185] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
2024-11-25T17:49:56.683092+01:00 ws7 kernel: [    4.441199] kfd kfd: amdgpu: Total number of KFD nodes to be created: 1
2024-11-25T17:49:56.683092+01:00 ws7 kernel: [    4.441320] amdgpu: Virtual CRAT table created for GPU
2024-11-25T17:49:56.683093+01:00 ws7 kernel: [    4.441953] amdgpu: Topology: Add dGPU node [0x15bf:0x1002]
2024-11-25T17:49:56.683093+01:00 ws7 kernel: [    4.441956] kfd kfd: amdgpu: added device 1002:15bf
2024-11-25T17:49:56.683093+01:00 ws7 kernel: [    4.441969] amdgpu 0000:04:00.0: amdgpu: SE 1, SH per SE 2, CU per SH 6, active_cu_number 12
2024-11-25T17:49:56.683093+01:00 ws7 kernel: [    4.441976] amdgpu 0000:04:00.0: amdgpu: ring gfx_0.0.0 uses VM inv eng 0 on hub 0
2024-11-25T17:49:56.683093+01:00 ws7 kernel: [    4.441979] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
2024-11-25T17:49:56.683095+01:00 ws7 kernel: [    4.441983] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
2024-11-25T17:49:56.683096+01:00 ws7 kernel: [    4.441986] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 6 on hub 0
2024-11-25T17:49:56.683096+01:00 ws7 kernel: [    4.441989] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 7 on hub 0
2024-11-25T17:49:56.683096+01:00 ws7 kernel: [    4.441992] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 8 on hub 0
2024-11-25T17:49:56.683096+01:00 ws7 kernel: [    4.441995] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 9 on hub 0
2024-11-25T17:49:56.683096+01:00 ws7 kernel: [    4.441998] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 10 on hub 0
2024-11-25T17:49:56.683099+01:00 ws7 kernel: [    4.442001] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 11 on hub 0
2024-11-25T17:49:56.683099+01:00 ws7 kernel: [    4.442004] amdgpu 0000:04:00.0: amdgpu: ring sdma0 uses VM inv eng 12 on hub 0
2024-11-25T17:49:56.683099+01:00 ws7 kernel: [    4.442007] amdgpu 0000:04:00.0: amdgpu: ring vcn_unified_0 uses VM inv eng 0 on hub 8
2024-11-25T17:49:56.683099+01:00 ws7 kernel: [    4.442010] amdgpu 0000:04:00.0: amdgpu: ring jpeg_dec uses VM inv eng 1 on hub 8
2024-11-25T17:49:56.683099+01:00 ws7 kernel: [    4.442013] amdgpu 0000:04:00.0: amdgpu: ring mes_kiq_3.1.0 uses VM inv eng 13 on hub 0
2024-11-25T17:49:56.683099+01:00 ws7 kernel: [    4.443499] [drm] ring gfx_32768.1.1 was added
2024-11-25T17:49:56.683101+01:00 ws7 kernel: [    4.444233] [drm] ring compute_32768.2.2 was added
2024-11-25T17:49:56.683102+01:00 ws7 kernel: [    4.444964] [drm] ring sdma_32768.3.3 was added
2024-11-25T17:49:56.683102+01:00 ws7 kernel: [    4.445026] [drm] ring gfx_32768.1.1 ib test pass
2024-11-25T17:49:56.683102+01:00 ws7 kernel: [    4.445080] [drm] ring compute_32768.2.2 ib test pass
2024-11-25T17:49:56.683102+01:00 ws7 kernel: [    4.445142] [drm] ring sdma_32768.3.3 ib test pass
2024-11-25T17:49:56.683102+01:00 ws7 kernel: [    4.448085] amdgpu 0000:04:00.0: amdgpu: Runtime PM not available
2024-11-25T17:49:56.683102+01:00 ws7 kernel: [    4.448618] [drm] Initialized amdgpu 3.59.0 for 0000:04:00.0 on minor 0
2024-11-25T17:49:56.683104+01:00 ws7 kernel: [    4.450783] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] *ERROR* No EDID found on connector: HDMI-A-1.
2024-11-25T17:49:56.683105+01:00 ws7 kernel: [    4.451619] [drm:amdgpu_dm_connector_mode_valid [amdgpu]] *ERROR* No EDID found on connector: HDMI-A-1.
2024-11-25T17:49:56.683105+01:00 ws7 kernel: [    4.452688] [drm:amdgpu_dm_connector_mode_valid [amdgpu]] *ERROR* No EDID found on connector: HDMI-A-1.
2024-11-25T17:49:56.683105+01:00 ws7 kernel: [    4.453459] fbcon: amdgpudrmfb (fb0) is primary device
2024-11-25T17:49:56.683105+01:00 ws7 kernel: [    4.453638] [drm] pre_validate_dsc:1578 MST_DSC dsc precompute is not needed
2024-11-25T17:49:56.683105+01:00 ws7 kernel: [    4.636161] Console: switching to colour frame buffer device 200x75
2024-11-25T17:49:56.683107+01:00 ws7 kernel: [    4.653972] amdgpu 0000:04:00.0: [drm] fb0: amdgpudrmfb frame buffer device
2024-11-25T17:49:56.683108+01:00 ws7 kernel: [    4.824937] EXT4-fs (nvme0n1p2): re-mounted 3e0acb9b-9fda-4557-a33a-2c28f4cc3cf6 r/w. Quota mode: none.
2024-11-25T17:49:56.683108+01:00 ws7 kernel: [    4.920743] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA measurements will not be recorded in the IMA log.
2024-11-25T17:49:56.683108+01:00 ws7 kernel: [    4.921084] device-mapper: uevent: version 1.0.3
2024-11-25T17:49:56.683108+01:00 ws7 kernel: [    4.921172] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
2024-11-25T17:49:56.683108+01:00 ws7 kernel: [    4.967643] lp: driver loaded but no devices found
2024-11-25T17:49:56.683110+01:00 ws7 kernel: [    4.971393] ppdev: user-space parallel port driver
2024-11-25T17:49:56.683111+01:00 ws7 kernel: [    4.980664] FAT-fs (nvme0n1p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
2024-11-25T17:49:56.683111+01:00 ws7 kernel: [    5.001624] EXT4-fs (nvme0n1p3): mounted filesystem 8281a32d-511b-4e20-90f2-c5c2cfb669db r/w with ordered data mode. Quota mode: none.
2024-11-25T17:49:56.683111+01:00 ws7 kernel: [    5.050820] audit: type=1400 audit(1732553396.318:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="firejail-default" pid=1586 comm="apparmor_parser"
2024-11-25T17:49:56.683111+01:00 ws7 kernel: [    5.051472] audit: type=1400 audit(1732553396.318:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="lsb_release" pid=1588 comm="apparmor_parser"
2024-11-25T17:49:56.683113+01:00 ws7 kernel: [    5.051498] audit: type=1400 audit(1732553396.318:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe" pid=1589 comm="apparmor_parser"
2024-11-25T17:49:56.683113+01:00 ws7 kernel: [    5.051519] audit: type=1400 audit(1732553396.318:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="nvidia_modprobe//kmod" pid=1589 comm="apparmor_parser"
2024-11-25T17:49:56.683114+01:00 ws7 kernel: [    5.051718] audit: type=1400 audit(1732553396.318:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/bin/man" pid=1593 comm="apparmor_parser"
2024-11-25T17:49:56.683114+01:00 ws7 kernel: [    5.051738] audit: type=1400 audit(1732553396.318:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_filter" pid=1593 comm="apparmor_parser"
2024-11-25T17:49:56.683114+01:00 ws7 kernel: [    5.051757] audit: type=1400 audit(1732553396.318:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="man_groff" pid=1593 comm="apparmor_parser"
2024-11-25T17:49:56.683116+01:00 ws7 kernel: [    5.052143] audit: type=1400 audit(1732553396.318:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/cups-browsed" pid=1594 comm="apparmor_parser"
2024-11-25T17:49:56.683116+01:00 ws7 kernel: [    5.052505] audit: type=1400 audit(1732553396.322:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="/usr/sbin/ntpd" pid=1596 comm="apparmor_parser"
2024-11-25T17:49:56.683120+01:00 ws7 kernel: [    5.162862] RPC: Registered named UNIX socket transport module.
2024-11-25T17:49:56.683120+01:00 ws7 kernel: [    5.162876] RPC: Registered udp transport module.
2024-11-25T17:49:56.683120+01:00 ws7 kernel: [    5.162883] RPC: Registered tcp transport module.
2024-11-25T17:49:56.683120+01:00 ws7 kernel: [    5.162889] RPC: Registered tcp-with-tls transport module.
2024-11-25T17:49:56.683122+01:00 ws7 kernel: [    5.162896] RPC: Registered tcp NFSv4.1 backchannel transport module.
2024-11-25T17:49:56.683122+01:00 ws7 kernel: [    5.178186] netfs: FS-Cache loaded
2024-11-25T17:49:56.766115+01:00 ws7 kernel: [    5.488507] RTL8226B_RTL8221B 2.5Gbps PHY r8169-0-300:00: attached PHY driver (mii_bus:phy_addr=r8169-0-300:00, irq=MAC)
2024-11-25T17:49:56.966099+01:00 ws7 kernel: [    5.688607] r8169 0000:03:00.0 eth0: Link is Down
2024-11-25T17:49:56.990097+01:00 ws7 kernel: [    5.714508] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
2024-11-25T17:49:57.026153+01:00 ws7 kernel: [    5.750840] NET: Registered PF_QIPCRTR protocol family
2024-11-25T17:49:57.030094+01:00 ws7 kernel: [    5.756466] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] *ERROR* No EDID found on connector: HDMI-A-1.
2024-11-25T17:49:57.034097+01:00 ws7 kernel: [    5.757400] [drm:amdgpu_dm_connector_mode_valid [amdgpu]] *ERROR* No EDID found on connector: HDMI-A-1.
2024-11-25T17:49:57.034101+01:00 ws7 kernel: [    5.758588] [drm:amdgpu_dm_connector_mode_valid [amdgpu]] *ERROR* No EDID found on connector: HDMI-A-1.
2024-11-25T17:49:57.046107+01:00 ws7 kernel: [    5.770863] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] *ERROR* No EDID found on connector: HDMI-A-1.
2024-11-25T17:49:57.046120+01:00 ws7 kernel: [    5.771785] [drm:amdgpu_dm_connector_mode_valid [amdgpu]] *ERROR* No EDID found on connector: HDMI-A-1.
2024-11-25T17:49:57.050103+01:00 ws7 kernel: [    5.772905] [drm:amdgpu_dm_connector_mode_valid [amdgpu]] *ERROR* No EDID found on connector: HDMI-A-1.
2024-11-25T17:49:57.794160+01:00 ws7 kernel: [    6.518008] NFSD: Using UMH upcall client tracking operations.
2024-11-25T17:49:57.794193+01:00 ws7 kernel: [    6.519552] NFSD: Using UMH upcall client tracking operations.
2024-11-25T17:49:57.794193+01:00 ws7 kernel: [    6.519559] NFSD: starting 90-second grace period (net f0000000)
2024-11-25T17:49:59.046113+01:00 ws7 kernel: [    7.772150] Key type dns_resolver registered
2024-11-25T17:49:59.158103+01:00 ws7 kernel: [    7.880640] NFS: Registering the id_resolver key type
2024-11-25T17:49:59.158109+01:00 ws7 kernel: [    7.880648] Key type id_resolver registered
2024-11-25T17:49:59.158110+01:00 ws7 kernel: [    7.880649] Key type id_legacy registered
2024-11-25T17:49:59.942104+01:00 ws7 kernel: [    8.667090] r8169 0000:03:00.0 eth0: Link is Up - 1Gbps/Full - flow control rx/tx
2024-11-25T17:49:59.946097+01:00 ws7 kernel: [    8.668788] br0: port 1(eth0) entered blocking state
2024-11-25T17:49:59.946101+01:00 ws7 kernel: [    8.668793] br0: port 1(eth0) entered disabled state
2024-11-25T17:49:59.946101+01:00 ws7 kernel: [    8.668801] r8169 0000:03:00.0 eth0: entered allmulticast mode
2024-11-25T17:49:59.946102+01:00 ws7 kernel: [    8.668915] r8169 0000:03:00.0 eth0: entered promiscuous mode
2024-11-25T17:49:59.946102+01:00 ws7 kernel: [    8.669017] br0: port 1(eth0) entered blocking state
2024-11-25T17:49:59.946103+01:00 ws7 kernel: [    8.669019] br0: port 1(eth0) entered listening state
2024-11-25T17:50:02.698185+01:00 ws7 kernel: [   11.423453] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] *ERROR* No EDID found on connector: HDMI-A-1.
2024-11-25T17:50:02.698194+01:00 ws7 kernel: [   11.424371] [drm:amdgpu_dm_connector_mode_valid [amdgpu]] *ERROR* No EDID found on connector: HDMI-A-1.
2024-11-25T17:50:02.702096+01:00 ws7 kernel: [   11.425557] [drm:amdgpu_dm_connector_mode_valid [amdgpu]] *ERROR* No EDID found on connector: HDMI-A-1.
2024-11-25T17:50:03.050107+01:00 ws7 kernel: [   11.774328] [drm:drm_helper_probe_single_connector_modes [drm_kms_helper]] *ERROR* No EDID found on connector: HDMI-A-1.
2024-11-25T17:50:03.050118+01:00 ws7 kernel: [   11.775298] [drm:amdgpu_dm_connector_mode_valid [amdgpu]] *ERROR* No EDID found on connector: HDMI-A-1.
2024-11-25T17:50:03.054105+01:00 ws7 kernel: [   11.777128] [drm:amdgpu_dm_connector_mode_valid [amdgpu]] *ERROR* No EDID found on connector: HDMI-A-1.
2024-11-25T17:50:15.082120+01:00 ws7 kernel: [   23.804437] br0: port 1(eth0) entered learning state
2024-11-25T17:50:30.182149+01:00 ws7 kernel: [   38.908381] br0: port 1(eth0) entered forwarding state

--------------yG0qJU9teIDhGcLuyuwkHaCp--
