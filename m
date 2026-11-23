Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460295;
	b=jFHXAqpXUXQoGG3f82MBTNB5ntv1WzVAu5qiGLQKjCFEpmsIsvm5Dww4t/LZ7kItR5yX
	 gRoaLseo1UvhbC/miTMV2pKj+TDEtnUaeLvWaSu8T4eTfYbpR8Yb5eMWsC8vouCyQrudM
	 bBgAx3LBP9QPRlpAMQp3fBcFDDVKasiuyHbSZTaWgx7GczrgfA7siDCRp7QC1vyUNz7Zg
	 tXRMmG7H84aE+AWQvXsqMblFvXT7942/iRkVAswDLlUE3SEerW0B3qeOiKdyYuXRop1sg
	 kMWDBfSIkXUJ2nCKsUp/3dw6W70XkXhxQnuPQlM3DsV82WuaO//tj43K4otwMNlSYng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460295;
	h=DMARC-Filter:DKIM-Signature:X-Pm-Submission-Id:From:To:Cc:Subject:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 Message-Id:Date;
	bh=S9ZWPaLRJ22bKz+JdqFAnfkIboPEjlm3ulrVKhl0UhA=;
	b=N2y+oVsmGyTHs5vhzaxh5V3IdaIL9pPofKgSAf7GzsJZY1WmRAhq4l10mcWpyqxY2RMB
	 izmD7qgXgirQXbI/sWSxNMZ/f7ZamV05w7VJwJ1PjIhAQbl0XH6P+AkQoO1LM2jh0YPib
	 T+tqe84Qp4reAC4SQcGDKqRnqRz/42S1UOb46ywviMSP5KMQq9IWhlLVyP+dS1BV73knO
	 pGvPJG20+rXNOegDhb3vgICALsEImSqhBIlxW4n6n4NRi3StArItkYrLPoiQa0zoyj5iw
	 ER/YGrdqfRpt5Viz5hrcXPq256Z8BIJZoUhiyuQ6U815Yj9pWzDCnGo0+FOHFSfGmyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aigeus.net;
	spf=pass smtp.mailfrom=aigeus.net;
	dkim=pass header.d=aigeus.net header.i=@aigeus.net header.a=rsa-sha256 header.s=protonmail header.b=hCmgxJ63;
	arc=none smtp.remote-ip=109.224.244.108
Received: from mail-244108.protonmail.ch (mail-244108.protonmail.ch [109.224.244.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A6C606A31A
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 18:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07A6C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aigeus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aigeus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aigeus.net header.i=@aigeus.net header.a=rsa-sha256 header.s=protonmail header.b=hCmgxJ63
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aigeus.net;
	s=protonmail; t=1795460291; x=1795719491;
	bh=S9ZWPaLRJ22bKz+JdqFAnfkIboPEjlm3ulrVKhl0UhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Message-Id:Date:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=hCmgxJ63rPY9nIrwFOjOBV7otGbOuurlbKnpnB5yCym3zH4arj7AaV8dKqzkrJ2Ww
	 YJXEaKuv7JPewlJNmTqnevBT698x66wn4nQQLaegkLhPmHSOjtLEmD2N2aflPdtJ+a
	 0JiY70KYoLTzBGhEAbQ6OiCtw3WVzr0ywsMU2jkKi9BY9nheFWa1+5ruYXf5P1R+k1
	 ElHGDIq1OeXW+wucTijoTdu1GyVdULrLwzvJiEpdGtY28JYmBGs9QZyZ1vKKcgW/pJ
	 YmUM7Rg+el2zTOIlBNwbRD1GJr4j+PrVNXAWIVsHEfRmTnkxXz5jcwmA/GeXvqOTML
	 HJ446HhQILBBQ==
X-Pm-Submission-Id: 4jYFZS1pGVz2ScQ9
From: Aigeus <info@aigeus.net>
To: iommu@lists.linux.dev, regressions@lists.linux.dev
Cc: baolu.lu@linux.intel.com
Subject: Re: [REGRESSION] GPU passes into VM improperly after c376a3456d8b or a98db518dde2
In-Reply-To: <HYhMd0Klo0XE_yiVY7XmsgyKKFDwKHfKRy22KrycLcYd0V_ykA4xdbBMJXkA07YX3os6qK-NhMIVi6ITo-CkNIIF0e-GcI0UwwZmdDhAJ0I=@protonmail.com>
References: <HYhMd0Klo0XE_yiVY7XmsgyKKFDwKHfKRy22KrycLcYd0V_ykA4xdbBMJXkA07YX3os6qK-NhMIVi6ITo-CkNIIF0e-GcI0UwwZmdDhAJ0I=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-Id: <4jYFZS1pGVz2ScQ9@mailsubfra1001.protonmail.ch>
Date: Mon, 23 Nov 2026 18:58:08 +0000 (UTC)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list

Hello,

I hit fault reason 0x0c on a Haswell platform with a symptom that does not
involve VFIO at all, and I would like to check whether it belongs to this
thread.

On my machine an in-kernel amdgpu attach fails at boot: the GPU issues DMA
reads that the remapping hardware rejects, and the PSP then fails to load the
SMU microcode, so the GPU never initialises. No VM, no vfio-pci, no userspace
involvement - the driver is bound to the card as usual.

Hardware
  Gigabyte H97-HD3, BIOS F9c (03/03/2016), Intel Core i7-4790K (Haswell; the
  ACPI DMAR table's OEM ID string reads "BDW", which I assume is just a board
  firmware string).
  AMD Radeon RX 5500 XT (Navi 14, 1002:7340, 8 GB) at 0000:03:00.0
  ACPI DMAR: Host address width 39, two DRHDs:
    dmar0 @fed90000 flags 0x0   ver 1:0 cap c0000020660462 ecap f0101a
    dmar1 @fed91000 flags 0x1   ver 1:0 cap d2008c20660462 ecap f010da
          (IOAPIC 8 and HPET 0 are under dmar1)
  No ATSR, no SATC, queued invalidation in use.

Software - same machine, same BIOS, same firmware package, same command line
  works : Debian 13, 6.12.118-1      (linux-image-6.12.118+deb13-amd64)
  broken: Debian 13, 7.3.4-1~bpo13+1 (linux-image-7.3.4+deb13-amd64)
  Both boot with "root=UUID=... ro quiet splash" and no IOMMU option.

Config delta (verbatim diff of the two /boot/config-* files, IOMMU symbols):
  5d4
  < CONFIG_IOMMU_IO_PGTABLE=y
  19a19,23
  > CONFIG_IOMMU_PT=y
  > CONFIG_IOMMU_PT_AMDV1=y
  > CONFIG_IOMMU_PT_VTDSS=y
  > # CONFIG_IOMMU_PT_RISCV64 is not set
  > CONFIG_IOMMU_PT_X86_64=y
  So 7.3.4 is the first kernel I have that is built with the generic page-table
  code.

Observed sequence on 7.3.4 (kern.log, one boot):
  DMAR: DRHD: handling fault status reg 3
  DMAR: [DMA Read NO_PASID] Request device [0000:03:00.0] fault addr 0xff368000
        [fault reason 0x0c] non-zero reserved fields in PTE
  (three times, then) DMAR: DRHD: handling fault status reg 2
  amdgpu 0000:03:00.0: failed to load ucode SMC(0x34)
  amdgpu 0000:03:00.0: psp gfx command LOAD_IP_FW(0x6) failed and response status is (0x0)
  amdgpu 0000:03:00.0: PSP load smu failed!
  [drm:psp_v11_0_ring_destroy [amdgpu]] *ERROR* Fail to stop psp ring
  amdgpu 0000:03:00.0: PSP firmware loading failed
  amdgpu 0000:03:00.0: hw_init of IP block <psp> failed -22
  amdgpu 0000:03:00.0: Fatal error during GPU init

  I cannot prove from the log alone that fault addr 0xff368000 is the SMU ucode
  buffer. What I can say is that the only DMA faults in the log are reads by
  0000:03:00.0, they occur in the same instant as the SMC load attempt, and the
  SMC load is what fails. If it helps I can confirm the faulting address with
  amdgpu dynamic debug once the card is back in the machine.

Counts
  /var/log/kern.log   (7.3.4 boots, 2026-11-23 19:43-20:42): 36 fault lines
  /var/log/kern.log.1 (6.12 boots)                         :  0
  On 6.12.118 the same card initialises fully on the same BIOS:
    amdgpu 0000:03:00.0: amdgpu: VRAM: 8176M ...
    amdgpu 0000:03:00.0: amdgpu: SMU is initialized successfully!
    [drm] Initialized amdgpu 3.61.0 for 0000:03:00.0 on minor 1

What I have ruled out
  - Firmware: navi14_smc.bin and the rest of the navi14 blobs are present in
    /lib/firmware/amdgpu (firmware-amd-graphics 20260916-1~bpo13+1), and
    lsinitramfs shows them in the initrd of both kernels.
  - Hardware: the card initialises completely on 6.12.118 with the same BIOS.
  - The BIOS-reserved-region variant of bugzilla #221545, which this thread
    quotes as "the BIOS DMAR tables contain reserved PTE fields, this generates
    continuous DMAR faults (fault reason 0x0c) on device 00:1b.0". On my box the
    BIOS is untouched and 6.12.118 produces zero faults with the same ACPI
    tables, while 7.3.4 produces 36. What changed is the code producing the
    page tables, not the firmware.

Workaround
  intel_iommu=off. Verified after reboot: /proc/cmdline shows the option, dmesg
  shows "DMAR: IOMMU disabled", and the fault count is 0. That boot was done
  with the discrete card already out of the machine, so it proves the faults
  stop, not that amdgpu initialises again; I will retest with the card
  reinstalled. iommu.passthrough=1 not tested yet.

Questions
  1. Is the plain amdgpu/PSP case the same root cause as the VFIO case here,
     i.e. page-table entries built by the new common code carrying bits this
     VT-d implementation requires to be zero? I cannot tell from the log which
     stage and scope apply to a plain DMA-API domain on this box.
  2. Is there a bisection or a debug build you would like me to run? I can
     rebuild the Debian 7.3.4 tree with a patch and retest within a day.
     CONFIG_IOMMU_DEBUGFS is not set in the Debian kernel, so I could not
     produce the page-table dump that was useful in this thread; I can build a
     debug kernel that does.

The card is currently out of the machine (it is the box's only discrete GPU and
it is running off the iGPU), so a retest with it reinstalled needs a few hours'
notice. Happy to test patches.

-- 
Aigeus
GitHub: EgolOS <79418083+EgolOS@users.noreply.github.com>
