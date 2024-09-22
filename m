Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46F029A2
	for <iommu@lists.linux.dev>; Sun, 22 Sep 2024 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727015165; cv=none; b=AzTdW/2cpohmZMQVjmPx6H+L4Ck96zBKDawO3sl8gsEQok9/AYkyfBSt3V5LSZqCAb7SNEzipYs22cj219MCVozERDER6w0avjhXHM9xSxSEHSx8oE2NZ1dgFRGEUgPec4KOulo2i/S+JNFlG0dQvHgBtQ33/JG+z+zqwIzsb1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727015165; c=relaxed/simple;
	bh=7Ue3DkntWvSkDpEWqjkvuCyuLxb/OVayJxC3fvDJVnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ntvAV97tIU+uDa6CsnUaC8KNbfDICdYL6V2yb//swvtOg86ju548aiA+dmzVHu6lR412Yi8L17TvfrH/LlV/y6HHL/1vYp21MrNGzj6unRojwF62VIBp/zwJiTGenXhM4QwLngZvW1cXaHcV7E4jqCbF6ozAG/n/qkDmKNtUyNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWBmR6G3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWBmR6G3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D890C4CEC3;
	Sun, 22 Sep 2024 14:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727015165;
	bh=7Ue3DkntWvSkDpEWqjkvuCyuLxb/OVayJxC3fvDJVnI=;
	h=From:To:Cc:Subject:Date:From;
	b=sWBmR6G3rtqeVVJrl5noM/BA7wcSpyuCKASMckykNh7kVgXWJEXH6fFuSojytddtz
	 4j2mJWhswfmtw7ITtoOe52ntX6VcoOf4cWjmhcU/SH0dZ4e5DLgJTXKMfIh+LDMOBp
	 O6BJUCyH5AP4cxquHNuAuTUwIXbeeL/JGf9FZOYC+evv84Y7bgceKREc/HGqnsRLHI
	 hIxoDeGgA8CSfbjskGby9d7FqQhR/FhUJpZqq3RspeKGXUtFu0Qe6AvlRwcfFOhawl
	 zwS9GeiG5qXWXipe13OMCDb1Ipcy3neqVO7NIm/ljuvgsxYSEh4jUFZR46fEGteMXT
	 BwuS+oycpja0g==
From: Leon Romanovsky <leon@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH] dma-mapping: report unlimited DMA addressing in IOMMU DMA path
Date: Sun, 22 Sep 2024 17:25:46 +0300
Message-ID: <92f61e9627003eeeee1bc5fc8b32e59d7c932a33.1727015030.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While using the IOMMU DMA path, the dma_addressing_limited() function
checks ops struct which doesn't exist in the IOMMU case. This causes
to the kernel panic while loading ADMGPU driver.

BUG: kernel NULL pointer dereference, address: 00000000000000a0
PGD 0 P4D 0
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 10 UID: 0 PID: 611 Comm: (udev-worker) Tainted: G                T  6.11.0-clang-07154-g726e2d0cf2bb #257
Tainted: [T]=RANDSTRUCT
Hardware name: ASUS System Product Name/ROG STRIX Z690-G GAMING WIFI, BIOS 3701 07/03/2024
RIP: 0010:dma_addressing_limited+0x53/0xa0
Code: 8b 93 48 02 00 00 48 39 d1 49 89 d6 4c 0f 42 f1 48 85 d2 4c 0f 44 f1 f6 83 fc 02 00 00 40 75 0a 48 89 df e8 1f 09 00 00 eb 24 <4c> 8b 1c 25 a0 00 00 00 4d 85 db 74 17 48 89 df 41 ba 8b 84 2d 55
RSP: 0018:ffffa8d2c12cf740 EFLAGS: 00010202
RAX: 00000000ffffffff RBX: ffff8948820220c8 RCX: 000000ffffffffff
RDX: 0000000000000000 RSI: ffffffffc124dc6d RDI: ffff8948820220c8
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff894883c3f040
R13: ffff89488dac8828 R14: 000000ffffffffff R15: ffff8948820220c8
FS:  00007fe6ba881900(0000) GS:ffff894fdf700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000a0 CR3: 0000000111984000 CR4: 0000000000f50ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __die_body+0x65/0xc0
 ? page_fault_oops+0x3b9/0x450
 ? _prb_read_valid+0x212/0x390
 ? do_user_addr_fault+0x608/0x680
 ? exc_page_fault+0x4e/0xa0
 ? asm_exc_page_fault+0x26/0x30
 ? dma_addressing_limited+0x53/0xa0
 amdgpu_ttm_init+0x56/0x4b0 [amdgpu]
 gmc_v8_0_sw_init+0x561/0x670 [amdgpu]
 amdgpu_device_ip_init+0xf5/0x570 [amdgpu]
 amdgpu_device_init+0x1a57/0x1ea0 [amdgpu]
 ? _raw_spin_unlock_irqrestore+0x1a/0x40
 ? pci_conf1_read+0xc0/0xe0
 ? pci_bus_read_config_word+0x52/0xa0
 amdgpu_driver_load_kms+0x15/0xa0 [amdgpu]
 amdgpu_pci_probe+0x1b7/0x4c0 [amdgpu]
 pci_device_probe+0x1c5/0x260
 really_probe+0x130/0x470
 __driver_probe_device+0x77/0x150
 driver_probe_device+0x19/0x120
 __driver_attach+0xb1/0x1e0
 ? __cfi___driver_attach+0x10/0x10
 bus_for_each_dev+0x115/0x170
 bus_add_driver+0x192/0x2d0
 driver_register+0x5c/0xf0
 ? __cfi_init_module+0x10/0x10 [amdgpu]
 do_one_initcall+0x128/0x380
 ? idr_alloc_cyclic+0x139/0x1d0
 ? security_kernfs_init_security+0x42/0x140
 ? __kernfs_new_node+0x1be/0x250
 ? sysvec_apic_timer_interrupt+0xb6/0xc0
 ? asm_sysvec_apic_timer_interrupt+0x1a/0x20
 ? _raw_spin_unlock+0x11/0x30
 ? free_unref_page+0x283/0x650
 ? kfree+0x274/0x3a0
 ? kfree+0x274/0x3a0
 ? kfree+0x274/0x3a0
 ? load_module+0xf2e/0x1130
 ? __kmalloc_cache_noprof+0x12a/0x2e0
 do_init_module+0x7d/0x240
 __se_sys_init_module+0x19e/0x220
 do_syscall_64+0x8a/0x150
 ? __irq_exit_rcu+0x5e/0x100
 entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7fe6bb5980ee
Code: 48 8b 0d 3d ed 12 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0a ed 12 00 f7 d8 64 89 01 48
RSP: 002b:00007ffd462219d8 EFLAGS: 00000206 ORIG_RAX: 00000000000000af
RAX: ffffffffffffffda RBX: 0000556caf0d0670 RCX: 00007fe6bb5980ee
RDX: 0000556caf0d3080 RSI: 0000000002893458 RDI: 00007fe6b3400010
RBP: 0000000000020000 R08: 0000000000020010 R09: 0000000000000080
R10: c26073c166186e00 R11: 0000000000000206 R12: 0000556caf0d3430
R13: 0000556caf0d0670 R14: 0000556caf0d3080 R15: 0000556caf0ce700
 </TASK>
Modules linked in: amdgpu(+) i915(+) drm_suballoc_helper intel_gtt drm_exec drm_buddy iTCO_wdt i2c_algo_bit intel_pmc_bxt drm_display_helper iTCO_vendor_support gpu_sched drm_ttm_helper cec ttm amdxcp video backlight pinctrl_alderlake nct6775 hwmon_vid nct6775_core coretemp
CR2: 00000000000000a0
---[ end trace 0000000000000000 ]---
RIP: 0010:dma_addressing_limited+0x53/0xa0
Code: 8b 93 48 02 00 00 48 39 d1 49 89 d6 4c 0f 42 f1 48 85 d2 4c 0f 44 f1 f6 83 fc 02 00 00 40 75 0a 48 89 df e8 1f 09 00 00 eb 24 <4c> 8b 1c 25 a0 00 00 00 4d 85 db 74 17 48 89 df 41 ba 8b 84 2d 55
RSP: 0018:ffffa8d2c12cf740 EFLAGS: 00010202
RAX: 00000000ffffffff RBX: ffff8948820220c8 RCX: 000000ffffffffff
RDX: 0000000000000000 RSI: ffffffffc124dc6d RDI: ffff8948820220c8
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff894883c3f040
R13: ffff89488dac8828 R14: 000000ffffffffff R15: ffff8948820220c8
FS:  00007fe6ba881900(0000) GS:ffff894fdf700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000000a0 CR3: 0000000111984000 CR4: 0000000000f50ef0
PKRU: 55555554

Fixes: b5c58b2fdc42 ("dma-mapping: direct calls for dma-iommu")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219292
Signed-off-by: Leon Romanovsky <leon@kernel.org>
---
 kernel/dma/mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b839683da0ba..cf3b89e681a3 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -926,7 +926,7 @@ bool dma_addressing_limited(struct device *dev)
 			 dma_get_required_mask(dev))
 		return true;
 
-	if (unlikely(ops))
+	if (unlikely(ops) || use_dma_iommu(dev)
 		return false;
 	return !dma_direct_all_ram_mapped(dev);
 }
-- 
2.46.1

