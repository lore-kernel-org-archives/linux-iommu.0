Return-Path: <SRS0=9TsP=MM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D30C07E95
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 13:38:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D76B5611C1
	for <iommu@archiver.kernel.org>; Tue, 20 Jul 2021 13:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D76B5611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9EEF0402EA;
	Tue, 20 Jul 2021 13:38:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CuB7IuXgm9YM; Tue, 20 Jul 2021 13:38:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1FC7E403BD;
	Tue, 20 Jul 2021 13:38:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EFADBC0010;
	Tue, 20 Jul 2021 13:38:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05C3FC000E
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 13:38:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DC745400FC
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 13:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G4zXO0Wpo3GW for <iommu@lists.linux-foundation.org>;
 Tue, 20 Jul 2021 13:38:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 026F7402EA
 for <iommu@lists.linux-foundation.org>; Tue, 20 Jul 2021 13:38:38 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E09A610FB;
 Tue, 20 Jul 2021 13:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626788318;
 bh=mXTd0+iIUB+BEzQr10zc7nXeEXa1YLFhd9GXZ0dTpvg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=C2lDyYF/FLzXLIO6cARP95k+OkZM6kOvWlBT590ux2LTJoyNsw97zAZrEmUtPhiLh
 yj3LbSFIr8Kkmce0o1qxtAeyreVjT4KaptI3UZ6FSw86NvmCS4GgQkG2ZTCYnMMd7X
 cX0S7qdIIWFOew/AU61vgcuXI1XfQFNk/FPceA6FddPEVOunUJ6WpbfqyI9BaoAcUA
 bSs1K8F7AvOlEA+fLTASMxMTflziarncr2OIctYaNymlKwGZZl85YidAVMvWKe3uTH
 XjDftbwFmBDaCoB7kVXyp0qKn/wpuZaaec/0doV9FEom3Cx/ZLXWAD4Ry9qRLpZuGd
 +TjGVENu9CK1Q==
From: Will Deacon <will@kernel.org>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 2/4] swiotlb: Convert io_default_tlb_mem to static
 allocation
Date: Tue, 20 Jul 2021 14:38:24 +0100
Message-Id: <20210720133826.9075-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210720133826.9075-1-will@kernel.org>
References: <20210720133826.9075-1-will@kernel.org>
MIME-Version: 1.0
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, Claire Chang <tientzu@chromium.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
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

Since commit 69031f500865 ("swiotlb: Set dev->dma_io_tlb_mem to the
swiotlb pool used"), 'struct device' may hold a copy of the global
'io_default_tlb_mem' pointer if the device is using swiotlb for DMA. A
subsequent call to swiotlb_exit() will therefore leave dangling pointers
behind in these device structures, resulting in KASAN splats such as:

  |  BUG: KASAN: use-after-free in __iommu_dma_unmap_swiotlb+0x64/0xb0
  |  Read of size 8 at addr ffff8881d7830000 by task swapper/0/0
  |
  |  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.12.0-rc3-debug #1
  |  Hardware name: HP HP Desktop M01-F1xxx/87D6, BIOS F.12 12/17/2020
  |  Call Trace:
  |   <IRQ>
  |   dump_stack+0x9c/0xcf
  |   print_address_description.constprop.0+0x18/0x130
  |   kasan_report.cold+0x7f/0x111
  |   __iommu_dma_unmap_swiotlb+0x64/0xb0
  |   nvme_pci_complete_rq+0x73/0x130
  |   blk_complete_reqs+0x6f/0x80
  |   __do_softirq+0xfc/0x3be

Convert 'io_default_tlb_mem' to a static structure, so that the
per-device pointers remain valid after swiotlb_exit() has been invoked.
All users are updated to reference the static structure directly, using
the 'nslabs' field to determine whether swiotlb has been initialised.
The 'slots' array is still allocated dynamically and referenced via a
pointer rather than a flexible array member.

Cc: Claire Chang <tientzu@chromium.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Fixes: 69031f500865 ("swiotlb: Set dev->dma_io_tlb_mem to the swiotlb pool used")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Claire Chang <tientzu@chromium.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Will Deacon <will@kernel.org>
---
 drivers/base/core.c       |  2 +-
 drivers/xen/swiotlb-xen.c |  4 +--
 include/linux/swiotlb.h   |  4 +--
 kernel/dma/swiotlb.c      | 66 +++++++++++++++++++++------------------
 4 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index ea5b85354526..b49824001cfa 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2848,7 +2848,7 @@ void device_initialize(struct device *dev)
 	dev->dma_coherent = dma_default_coherent;
 #endif
 #ifdef CONFIG_SWIOTLB
-	dev->dma_io_tlb_mem = io_tlb_default_mem;
+	dev->dma_io_tlb_mem = &io_tlb_default_mem;
 #endif
 }
 EXPORT_SYMBOL_GPL(device_initialize);
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 785ec7e8be01..f06d9b4f1e0f 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -164,7 +164,7 @@ int __ref xen_swiotlb_init(void)
 	int rc = -ENOMEM;
 	char *start;
 
-	if (io_tlb_default_mem != NULL) {
+	if (io_tlb_default_mem.nslabs) {
 		pr_warn("swiotlb buffer already initialized\n");
 		return -EEXIST;
 	}
@@ -547,7 +547,7 @@ xen_swiotlb_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
 static int
 xen_swiotlb_dma_supported(struct device *hwdev, u64 mask)
 {
-	return xen_phys_to_dma(hwdev, io_tlb_default_mem->end - 1) <= mask;
+	return xen_phys_to_dma(hwdev, io_tlb_default_mem.end - 1) <= mask;
 }
 
 const struct dma_map_ops xen_swiotlb_dma_ops = {
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 39284ff2a6cd..b0cb2a9973f4 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -103,9 +103,9 @@ struct io_tlb_mem {
 		phys_addr_t orig_addr;
 		size_t alloc_size;
 		unsigned int list;
-	} slots[];
+	} *slots;
 };
-extern struct io_tlb_mem *io_tlb_default_mem;
+extern struct io_tlb_mem io_tlb_default_mem;
 
 static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
 {
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index f1a9ae7fad8f..7948f274f9bb 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -70,7 +70,7 @@
 
 enum swiotlb_force swiotlb_force;
 
-struct io_tlb_mem *io_tlb_default_mem;
+struct io_tlb_mem io_tlb_default_mem;
 
 /*
  * Max segment that we can provide which (if pages are contingous) will
@@ -101,7 +101,7 @@ early_param("swiotlb", setup_io_tlb_npages);
 
 unsigned int swiotlb_max_segment(void)
 {
-	return io_tlb_default_mem ? max_segment : 0;
+	return io_tlb_default_mem.nslabs ? max_segment : 0;
 }
 EXPORT_SYMBOL_GPL(swiotlb_max_segment);
 
@@ -134,9 +134,9 @@ void __init swiotlb_adjust_size(unsigned long size)
 
 void swiotlb_print_info(void)
 {
-	struct io_tlb_mem *mem = io_tlb_default_mem;
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
 
-	if (!mem) {
+	if (!mem->nslabs) {
 		pr_warn("No low mem\n");
 		return;
 	}
@@ -163,11 +163,11 @@ static inline unsigned long nr_slots(u64 val)
  */
 void __init swiotlb_update_mem_attributes(void)
 {
-	struct io_tlb_mem *mem = io_tlb_default_mem;
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	void *vaddr;
 	unsigned long bytes;
 
-	if (!mem || mem->late_alloc)
+	if (!mem->nslabs || mem->late_alloc)
 		return;
 	vaddr = phys_to_virt(mem->start);
 	bytes = PAGE_ALIGN(mem->nslabs << IO_TLB_SHIFT);
@@ -201,25 +201,24 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 
 int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
 {
-	struct io_tlb_mem *mem;
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	size_t alloc_size;
 
 	if (swiotlb_force == SWIOTLB_NO_FORCE)
 		return 0;
 
 	/* protect against double initialization */
-	if (WARN_ON_ONCE(io_tlb_default_mem))
+	if (WARN_ON_ONCE(mem->nslabs))
 		return -ENOMEM;
 
-	alloc_size = PAGE_ALIGN(struct_size(mem, slots, nslabs));
-	mem = memblock_alloc(alloc_size, PAGE_SIZE);
-	if (!mem)
+	alloc_size = PAGE_ALIGN(array_size(sizeof(*mem->slots), nslabs));
+	mem->slots = memblock_alloc(alloc_size, PAGE_SIZE);
+	if (!mem->slots)
 		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
 		      __func__, alloc_size, PAGE_SIZE);
 
 	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
 
-	io_tlb_default_mem = mem;
 	if (verbose)
 		swiotlb_print_info();
 	swiotlb_set_max_segment(mem->nslabs << IO_TLB_SHIFT);
@@ -304,26 +303,24 @@ swiotlb_late_init_with_default_size(size_t default_size)
 int
 swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 {
-	struct io_tlb_mem *mem;
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
 	unsigned long bytes = nslabs << IO_TLB_SHIFT;
 
 	if (swiotlb_force == SWIOTLB_NO_FORCE)
 		return 0;
 
 	/* protect against double initialization */
-	if (WARN_ON_ONCE(io_tlb_default_mem))
+	if (WARN_ON_ONCE(mem->nslabs))
 		return -ENOMEM;
 
-	mem = (void *)__get_free_pages(GFP_KERNEL,
-		get_order(struct_size(mem, slots, nslabs)));
-	if (!mem)
+	mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+		get_order(array_size(sizeof(*mem->slots), nslabs)));
+	if (!mem->slots)
 		return -ENOMEM;
 
-	memset(mem, 0, sizeof(*mem));
 	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
 	swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), nslabs, true);
 
-	io_tlb_default_mem = mem;
 	swiotlb_print_info();
 	swiotlb_set_max_segment(mem->nslabs << IO_TLB_SHIFT);
 	return 0;
@@ -331,18 +328,18 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 
 void __init swiotlb_exit(void)
 {
-	struct io_tlb_mem *mem = io_tlb_default_mem;
 	size_t size;
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
 
-	if (!mem)
+	if (!mem->nslabs)
 		return;
 
-	size = struct_size(mem, slots, mem->nslabs);
+	size = array_size(sizeof(*mem->slots), mem->nslabs);
 	if (mem->late_alloc)
-		free_pages((unsigned long)mem, get_order(size));
+		free_pages((unsigned long)mem->slots, get_order(size));
 	else
-		memblock_free_late(__pa(mem), PAGE_ALIGN(size));
-	io_tlb_default_mem = NULL;
+		memblock_free_late(__pa(mem->slots), PAGE_ALIGN(size));
+	memset(mem, 0, sizeof(*mem));
 }
 
 /*
@@ -696,7 +693,9 @@ size_t swiotlb_max_mapping_size(struct device *dev)
 
 bool is_swiotlb_active(struct device *dev)
 {
-	return dev->dma_io_tlb_mem != NULL;
+	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+
+	return mem && mem->nslabs;
 }
 EXPORT_SYMBOL_GPL(is_swiotlb_active);
 
@@ -711,10 +710,10 @@ static void swiotlb_create_debugfs_files(struct io_tlb_mem *mem)
 
 static int __init swiotlb_create_default_debugfs(void)
 {
-	struct io_tlb_mem *mem = io_tlb_default_mem;
+	struct io_tlb_mem *mem = &io_tlb_default_mem;
 
 	debugfs_dir = debugfs_create_dir("swiotlb", NULL);
-	if (mem) {
+	if (mem->nslabs) {
 		mem->debugfs = debugfs_dir;
 		swiotlb_create_debugfs_files(mem);
 	}
@@ -783,10 +782,17 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 	 * to it.
 	 */
 	if (!mem) {
-		mem = kzalloc(struct_size(mem, slots, nslabs), GFP_KERNEL);
+		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
 		if (!mem)
 			return -ENOMEM;
 
+		mem->slots = kzalloc(array_size(sizeof(*mem->slots), nslabs),
+				     GFP_KERNEL);
+		if (!mem->slots) {
+			kfree(mem);
+			return -ENOMEM;
+		}
+
 		set_memory_decrypted((unsigned long)phys_to_virt(rmem->base),
 				     rmem->size >> PAGE_SHIFT);
 		swiotlb_init_io_tlb_mem(mem, rmem->base, nslabs, false);
@@ -806,7 +812,7 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 static void rmem_swiotlb_device_release(struct reserved_mem *rmem,
 					struct device *dev)
 {
-	dev->dma_io_tlb_mem = io_tlb_default_mem;
+	dev->dma_io_tlb_mem = &io_tlb_default_mem;
 }
 
 static const struct reserved_mem_ops rmem_swiotlb_ops = {
-- 
2.32.0.402.g57bb445576-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
