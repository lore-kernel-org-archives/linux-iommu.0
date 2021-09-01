Return-Path: <SRS0=1qmC=NX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF2FC432BE
	for <iommu@archiver.kernel.org>; Wed,  1 Sep 2021 04:21:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5084161058
	for <iommu@archiver.kernel.org>; Wed,  1 Sep 2021 04:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5084161058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 123A3403FB;
	Wed,  1 Sep 2021 04:21:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gtNWXUkwNg1I; Wed,  1 Sep 2021 04:21:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B505C403D7;
	Wed,  1 Sep 2021 04:21:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DC0DC0010;
	Wed,  1 Sep 2021 04:21:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 318A7C000E
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 04:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F3306403EB
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 04:21:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VarbJcGcD9Po for <iommu@lists.linux-foundation.org>;
 Wed,  1 Sep 2021 04:21:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 775D4403D7
 for <iommu@lists.linux-foundation.org>; Wed,  1 Sep 2021 04:21:47 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="218629111"
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; d="scan'208";a="218629111"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2021 21:21:45 -0700
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; d="scan'208";a="466682263"
Received: from spr.sh.intel.com ([10.239.53.16])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2021 21:21:43 -0700
From: Chao Gao <chao.gao@intel.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] swiotlb: allocate memory in a cache-friendly way
Date: Wed,  1 Sep 2021 12:21:35 +0800
Message-Id: <20210901042135.103981-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: Andi Kleen <ak@linux.intel.com>
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

Currently, swiotlb uses a global index to indicate the starting point
of next search. The index increases from 0 to the number of slots - 1
and then wraps around. It is straightforward but not cache-friendly
because the "oldest" slot in swiotlb tends to be used first.

Freed slots are probably accessed right before being freed, especially
in VM's case (device backends access them in DMA_TO_DEVICE mode; guest
accesses them in other DMA modes). Thus those just freed slots may
reside in cache. Then reusing those just freed slots can reduce cache
misses.

To that end, maintain a free list for free slots and insert freed slots
from the head and searching for free slots always starts from the head.

With this optimization, network throughput of sending data from host to
guest, measured by iperf3, increases by 7%.

A bad side effect of this patch is we cannot use a large stride to skip
unaligned slots when there is an alignment requirement. Currently, a
large stride is used when a) device has an alignment requirement, stride
is calculated according to the requirement; b) the requested size is
larger than PAGE_SIZE. For x86 with 4KB page size, stride is set to 2.

For case a), few devices have an alignment requirement; the impact is
limited. For case b) this patch probably leads to one (or more if page size
is larger than 4K) additional lookup; but as the "io_tlb_slot" struct of
free slots are also accessed when freeing slots, they probably resides in
CPU cache as well and then the overhead is almost negligible.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 include/linux/swiotlb.h | 15 ++++++++------
 kernel/dma/swiotlb.c    | 43 +++++++++++------------------------------
 2 files changed, 20 insertions(+), 38 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index b0cb2a9973f4..8cafafd218af 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -63,6 +63,13 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
 #ifdef CONFIG_SWIOTLB
 extern enum swiotlb_force swiotlb_force;
 
+struct io_tlb_slot {
+	phys_addr_t orig_addr;
+	size_t alloc_size;
+	unsigned int list;
+	struct list_head node;
+};
+
 /**
  * struct io_tlb_mem - IO TLB Memory Pool Descriptor
  *
@@ -93,17 +100,13 @@ struct io_tlb_mem {
 	phys_addr_t end;
 	unsigned long nslabs;
 	unsigned long used;
-	unsigned int index;
+	struct list_head free_slots;
 	spinlock_t lock;
 	struct dentry *debugfs;
 	bool late_alloc;
 	bool force_bounce;
 	bool for_alloc;
-	struct io_tlb_slot {
-		phys_addr_t orig_addr;
-		size_t alloc_size;
-		unsigned int list;
-	} *slots;
+	struct io_tlb_slot *slots;
 };
 extern struct io_tlb_mem io_tlb_default_mem;
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 87c40517e822..12b5b8471e54 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -184,7 +184,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 	mem->nslabs = nslabs;
 	mem->start = start;
 	mem->end = mem->start + bytes;
-	mem->index = 0;
+	INIT_LIST_HEAD(&mem->free_slots);
 	mem->late_alloc = late_alloc;
 
 	if (swiotlb_force == SWIOTLB_FORCE)
@@ -195,6 +195,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
+		list_add_tail(&mem->slots[i].node, &mem->free_slots);
 	}
 	memset(vaddr, 0, bytes);
 }
@@ -447,13 +448,6 @@ static inline unsigned long get_max_slots(unsigned long boundary_mask)
 	return nr_slots(boundary_mask + 1);
 }
 
-static unsigned int wrap_index(struct io_tlb_mem *mem, unsigned int index)
-{
-	if (index >= mem->nslabs)
-		return 0;
-	return index;
-}
-
 /*
  * Find a suitable number of IO TLB entries size that will fit this request and
  * allocate a buffer from that IO TLB pool.
@@ -462,38 +456,29 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 			      size_t alloc_size)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_slot *slot, *tmp;
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
 	dma_addr_t tbl_dma_addr =
 		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
 	unsigned long max_slots = get_max_slots(boundary_mask);
 	unsigned int iotlb_align_mask =
 		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
-	unsigned int nslots = nr_slots(alloc_size), stride;
-	unsigned int index, wrap, count = 0, i;
+	unsigned int nslots = nr_slots(alloc_size);
+	unsigned int index, count = 0, i;
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
 	unsigned long flags;
 
 	BUG_ON(!nslots);
 
-	/*
-	 * For mappings with an alignment requirement don't bother looping to
-	 * unaligned slots once we found an aligned one.  For allocations of
-	 * PAGE_SIZE or larger only look for page aligned allocations.
-	 */
-	stride = (iotlb_align_mask >> IO_TLB_SHIFT) + 1;
-	if (alloc_size >= PAGE_SIZE)
-		stride = max(stride, stride << (PAGE_SHIFT - IO_TLB_SHIFT));
-
 	spin_lock_irqsave(&mem->lock, flags);
 	if (unlikely(nslots > mem->nslabs - mem->used))
 		goto not_found;
 
-	index = wrap = wrap_index(mem, ALIGN(mem->index, stride));
-	do {
+	list_for_each_entry_safe(slot, tmp, &mem->free_slots, node) {
+		index = slot - mem->slots;
 		if (orig_addr &&
 		    (slot_addr(tbl_dma_addr, index) & iotlb_align_mask) !=
 			    (orig_addr & iotlb_align_mask)) {
-			index = wrap_index(mem, index + 1);
 			continue;
 		}
 
@@ -505,11 +490,10 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 		if (!iommu_is_span_boundary(index, nslots,
 					    nr_slots(tbl_dma_addr),
 					    max_slots)) {
-			if (mem->slots[index].list >= nslots)
+			if (slot->list >= nslots)
 				goto found;
 		}
-		index = wrap_index(mem, index + stride);
-	} while (index != wrap);
+	}
 
 not_found:
 	spin_unlock_irqrestore(&mem->lock, flags);
@@ -520,19 +504,13 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 		mem->slots[i].list = 0;
 		mem->slots[i].alloc_size =
 			alloc_size - (offset + ((i - index) << IO_TLB_SHIFT));
+		list_del(&mem->slots[i].node);
 	}
 	for (i = index - 1;
 	     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
 	     mem->slots[i].list; i--)
 		mem->slots[i].list = ++count;
 
-	/*
-	 * Update the indices to avoid searching in the next round.
-	 */
-	if (index + nslots < mem->nslabs)
-		mem->index = index + nslots;
-	else
-		mem->index = 0;
 	mem->used += nslots;
 
 	spin_unlock_irqrestore(&mem->lock, flags);
@@ -613,6 +591,7 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 		mem->slots[i].list = ++count;
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
+		list_add(&mem->slots[i].node, &mem->free_slots);
 	}
 
 	/*
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
