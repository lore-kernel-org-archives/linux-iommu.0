Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177734EB865;
	Tue, 13 Oct 2026 11:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891859; cv=none; b=UHiPuo+6cgE9v5XpTh3CM4qf+7lJTJYdQ2peq1vSXX1TGQVzVl2feiMcGOYyV8cQt/TNwDYHSu8W/SS1KCzRfiT0zYovp6Bl15hFI/CFDSVZbzPnNMnbdUmKY9axZ1kJG8Zvc3yKhlLHGh30t5hjbG7D8JVve8u6SMP3dF1QrkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891859; c=relaxed/simple;
	bh=4OANBpHEmSdLiZGsXRmRFHuCMBaiRGj7Hu0NZgEdqHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dK02rt/VeTRxlnyud6KXZ2oGpHmHCsy4zuYhop2pn9GXkB6dOMjakBLOXmjkEXneZ4LqNjSTE2kY051rNQETMAvO1991kWS2M8GAyyPUGKJ2eF47H033zqQ6ztmAogUjqJwXD0tYF9FLCTkd3BbwHTGPl5qGO+RVvwcqKrG4VEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaAPaq2Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaAPaq2Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B221F000FF;
	Tue, 13 Oct 2026 11:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791891857;
	bh=D8wETzgZKXMrq+7nqWT6ljvjShoXyOcuU+Ww7Q6v8hk=;
	h=From:To:Cc:Subject:Date;
	b=kaAPaq2YJY7rKtY/ZiM31P7I2l+jSK9M6ALmWwjx8qDzY7fvznjp5URlFg9R//V4e
	 8mxLMTNprwBs7mxo6pZ9NLwg+v/Izdfxbqtu/Ltw3Yo4EUabN1TYdPeKXE9rb0GbNK
	 1hKZ1OD9oUPrI8w2UVzqQAIYzcdAmFGCo8nJLxad9FHF6FuVYE/xR4G+fqr43vF+Ak
	 KTqQx3UOD7tozDFpxzPdm8sMlWMi64RV12YXaSgrzUw+sK/BDdzqrQEh0l9h3HPM4U
	 noki2y+QSkfARff2W+KIDPYdQtZ6MjiwTAhbtHquqTaZqNq+fWJU7HZHWYEl5y79Th
	 1tlEjCc2bFYNg==
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	=?utf-8?q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Arnd Bergmann <arnd@arndb.de>,
	Vinod Koul <vkoul@kernel.org>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dma-debug: Skip cacheline tracking for MMIO mappings
Date: Tue, 13 Oct 2026 14:44:09 +0300
Message-ID: <20261013-dma-debug-fixes-v1-1-1ad1f471cc61@nvidia.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20261013-dma-debug-fixes-5aaf1bb17544
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Mapping one MMIO dma-buf for many RDMA importers overflows dma-debug's
cacheline overlap counter and triggers a warning. DMA_ATTR_MMIO mappings
must never be CPU-cacheable, so CPU cacheline overlap tracking does not
apply to them.

Skip MMIO entries in both cacheline insertion and removal. Keep them in
the DMA entry hash so mapping and unmapping checks still run.

The reported warning was:
 ------------[ cut here ]------------
DMA-API: exceeded 7 overlapping mappings of cacheline 0x000000e040000400
WARNING: kernel/dma/debug.c:465 at add_dma_entry+0x3b5/0x470, CPU#58: dtr/5264
Modules linked in: xt_conntrack xt_MASQUERADE ip6table_nat ip6table_filter ip6_tables iptable_nat nf_nat xt_addrtype rpcsec_gss_krb5 krb5 auth_rpcgss oid_registry overlay rpcrdma rdma_ucm ib_uverbs ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm ib_cm nvidia(O) mlx5_fwctl nvidia_drm(O) mlx5_ib ib_uverbs_support ib_core zram zsmalloc fuse mlx5_core
CPU: 58 UID: 0 PID: 5264 Comm: dtr Tainted: G           O      J 7.3.0-rc6_for_upstream_debug_2026_10_08_13_46 #1.fc40 PREEMPTLAZY
Tainted: [O]=OOT_MODULE, [J]=FWCTL
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
RIP: 0010:add_dma_entry+0x3bf/0x470
Code: ac e8 f5 89 6e 00 e9 47 fe ff ff 41 f7 c6 00 18 00 00 75 9f 83 fb 07 7e 9a 48 8d 3d eb 02 5f 04 be 07 00 00 00 48 8d 54 24 30 <67> 48 0f b9 3a eb 82 0f 0b 48 c7 c7 80 d3 2a 85 4c 89 e6 e8 a9 1f
RSP: 0018:ff110001bcb7f230 EFLAGS: 00010002
RAX: 0000000000000006 RBX: 0000000000000008 RCX: 0000000000000000
RDX: ff110001bcb7f260 RSI: 0000000000000007 RDI: ffffffff85cfd070
RBP: 000000e040000400 R08: 0000000000000000 R09: ffe21c0044b8abf5
R10: ff11000225c55faf R11: 0000000000000000 R12: 0000000000000246
R13: 1fe220003796fe48 R14: 0000000000000400 R15: 00000000ffffffff
FS:  00007fa8f91e6b80(0000) GS:ff11000eb81cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa8f5ca80f0 CR3: 0000000164871004 CR4: 0000000000373eb0
Call Trace:
 <TASK>
 ? check_sync+0x2070/0x2070
 ? find_held_lock+0x2b/0x80
 ? debug_dma_map_phys+0x588/0x840
 debug_dma_map_phys+0x267/0x840
 ? dma_debug_add_bus+0xd0/0xd0
 ? __sg_alloc_table+0x2b7/0x4d0
 dma_map_phys+0x10a/0x330
 ? sg_miter_start+0x130/0x130
 dma_buf_phys_vec_to_sgt+0x565/0xed0
 uverbs_dmabuf_map+0x158/0x340 [ib_uverbs]
 ? uverbs_dmabuf_unpin+0x10/0x10 [ib_uverbs]
 dma_buf_map_attachment+0x138/0x690
 ib_umem_dmabuf_map_pages+0x249/0xc90 [ib_core]
 pagefault_dmabuf_mr+0x172/0xf80 [mlx5_ib]
 ? do_raw_spin_unlock+0x54/0x210
 mlx5_ib_init_dmabuf_mr+0x13e/0x200 [mlx5_ib]
[... '?' frames and user-space registers omitted ...]
 reg_user_mr_dmabuf+0x3bf/0x760 [mlx5_ib]
 mlx5_ib_reg_user_mr_dmabuf+0x2dd/0x13b0 [mlx5_ib]
 ib_uverbs_handler_UVERBS_METHOD_REG_MR+0x76d/0xd90 [ib_uverbs]
 ib_uverbs_cmd_verbs+0x2337/0x31c0 [ib_uverbs]
 ib_uverbs_ioctl+0x1c7/0x350 [ib_uverbs]
 __x64_sys_ioctl+0x72c/0x11f0
 do_syscall_64+0xa1/0x4f0
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
 </TASK>
 ---[ end trace 0000000000000000 ]---

Fixes: 0e74b34dfc33 ("dma-debug: add support for resource mappings")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 kernel/dma/debug.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 026d50de340e..36c1f7cbb2ae 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -489,8 +489,10 @@ static int active_cacheline_insert(struct dma_debug_entry *entry,
 	/* If the device is not writing memory then we don't have any
 	 * concerns about the cpu consuming stale data.  This mitigates
 	 * legitimate usages of overlapping mappings.
+	 * MMIO mappings are never CPU-cacheable and do not need tracking either.
 	 */
-	if (entry->direction == DMA_TO_DEVICE)
+	if (entry->direction == DMA_TO_DEVICE ||
+	    entry->attrs & DMA_ATTR_MMIO)
 		return 0;
 
 	spin_lock_irqsave(&radix_lock, flags);
@@ -519,7 +521,8 @@ static void active_cacheline_remove(struct dma_debug_entry *entry)
 	unsigned long flags;
 
 	/* ...mirror the insert case */
-	if (entry->direction == DMA_TO_DEVICE)
+	if (entry->direction == DMA_TO_DEVICE ||
+	    entry->attrs & DMA_ATTR_MMIO)
 		return;
 
 	spin_lock_irqsave(&radix_lock, flags);

---
base-commit: 39d3758108bb0ef9da484062d65288bbe9cada0e
change-id: 20261013-dma-debug-fixes-5aaf1bb17544

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>

