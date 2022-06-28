Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFCECCA479
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 07:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C67BC4152B;
	Tue, 28 Jun 2022 07:01:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C67BC4152B
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CYYgIGLa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lrmaYuSmC1NI; Tue, 28 Jun 2022 07:01:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EAEB7410AA;
	Tue, 28 Jun 2022 07:01:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAEB7410AA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C00CCC0032;
	Tue, 28 Jun 2022 07:01:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D3ECC002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E352410A5
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:01:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E352410A5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B_Ybkb8NTuiQ for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 07:01:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE8BD40A05
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE8BD40A05
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656399713; x=1687935713;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JhxXs2GNe3FvZ8K4QS8CdHUgLDYKpHaDOujt94hpGh0=;
 b=CYYgIGLayIRjqwkWDGPn8gHVcBjHkwngPY5NF6BomVqpLCZ9E+G2tC+B
 2+NiodEBJdBCQrnANIMGOJAl545AlCudbPDP7rIDf50XlEXdyxHKaA+tE
 QthxFfHeKLBbVPhwwDCop3pjASkIGgnNwLxwDopNUuEWFTLLOv/Ao8QT1
 Th5XmwEAq3uPXdSIUZv3VjXC1Y1BHY0AXFlabp2hhCdQMCnN2aRWNO5cF
 SUd1ItvpiivSG0bMCtP++Wi0nxNQImGew2Ag8zrzdAWeCZiUpHLlJl3gE
 BkfvLNWogRzdNC3Xk39JGF+C9/cJJG3FfJrVIqxb115W2BrvLzE/9k52h g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="345652869"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="345652869"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 00:01:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="646782864"
Received: from spr.sh.intel.com ([10.239.53.120])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 00:01:50 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] swiotlb: Allocate memory in a cache-friendly way
Date: Tue, 28 Jun 2022 15:01:33 +0800
Message-Id: <20220628070136.419163-3-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628070136.419163-1-chao.gao@intel.com>
References: <20220628070136.419163-1-chao.gao@intel.com>
MIME-Version: 1.0
Cc: len.brown@intel.com, tony.luck@intel.com, rafael.j.wysocki@intel.com,
 dave.hansen@intel.com, iommu@lists.linux-foundation.org,
 Andi Kleen <ak@linux.intel.com>, ilpo.jarvinen@linux.intel.com,
 dan.j.williams@intel.com, reinette.chatre@intel.com,
 kirill.shutemov@linux.intel.com
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
 include/linux/swiotlb.h | 13 +++++----
 kernel/dma/swiotlb.c    | 63 ++++++++++++++++-------------------------
 2 files changed, 32 insertions(+), 44 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index c3eab237991a..012a6fde873b 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -62,6 +62,12 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
 #ifdef CONFIG_SWIOTLB
 extern enum swiotlb_force swiotlb_force;
 
+struct io_tlb_slot {
+	phys_addr_t orig_addr;
+	size_t alloc_size;
+	struct list_head node;
+};
+
 /**
  * struct io_tlb_mem - IO TLB Memory Pool Descriptor
  *
@@ -96,16 +102,13 @@ struct io_tlb_mem {
 	void *vaddr;
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
-	} *slots;
+	struct io_tlb_slot *slots;
 	unsigned long *bitmap;
 };
 extern struct io_tlb_mem io_tlb_default_mem;
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index d7f68c0af7f5..2283f3a36f0d 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -200,7 +200,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 	mem->nslabs = nslabs;
 	mem->start = start;
 	mem->end = mem->start + bytes;
-	mem->index = 0;
+	INIT_LIST_HEAD(&mem->free_slots);
 	mem->late_alloc = late_alloc;
 
 	mem->force_bounce = swiotlb_force_bounce || (flags & SWIOTLB_FORCE);
@@ -210,6 +210,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 		__set_bit(i, mem->bitmap);
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
+		list_add_tail(&mem->slots[i].node, &mem->free_slots);
 	}
 
 	/*
@@ -484,13 +485,6 @@ static inline unsigned long get_max_slots(unsigned long boundary_mask)
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
@@ -499,29 +493,21 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 			      size_t alloc_size, unsigned int alloc_align_mask)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
+	struct io_tlb_slot *slot, *tmp;
 	unsigned long boundary_mask = dma_get_seg_boundary(dev);
 	dma_addr_t tbl_dma_addr =
 		phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
+	dma_addr_t slot_dma_addr;
 	unsigned long max_slots = get_max_slots(boundary_mask);
 	unsigned int iotlb_align_mask =
 		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
-	unsigned int nslots = nr_slots(alloc_size), stride;
-	unsigned int index, wrap, i;
+	unsigned int nslots = nr_slots(alloc_size);
+	unsigned int index, i;
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
-	stride = max(stride, (alloc_align_mask >> IO_TLB_SHIFT) + 1);
-
 	/* slots shouldn't cross one segment */
 	max_slots = min_t(unsigned long, max_slots, IO_TLB_SEGSIZE);
 
@@ -529,15 +515,26 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	if (unlikely(nslots > mem->nslabs - mem->used))
 		goto not_found;
 
-	index = wrap = wrap_index(mem, ALIGN(mem->index, stride));
-	do {
+	list_for_each_entry_safe(slot, tmp, &mem->free_slots, node) {
+		index = slot - mem->slots;
+		slot_dma_addr = slot_addr(tbl_dma_addr, index);
 		if (orig_addr &&
-		    (slot_addr(tbl_dma_addr, index) & iotlb_align_mask) !=
+		    (slot_dma_addr & iotlb_align_mask) !=
 			    (orig_addr & iotlb_align_mask)) {
-			index = wrap_index(mem, index + 1);
 			continue;
 		}
 
+		/* Ensure requested alignment is met */
+		if (alloc_align_mask && (slot_dma_addr & (alloc_align_mask - 1)))
+			continue;
+
+		/*
+		 * If requested size is larger than a page, ensure allocated
+		 * memory to be page aligned.
+		 */
+		if (alloc_size >= PAGE_SIZE && (slot_dma_addr & ~PAGE_MASK))
+			continue;
+
 		/*
 		 * If we find a slot that indicates we have 'nslots' number of
 		 * contiguous buffers, we allocate the buffers from that slot
@@ -549,15 +546,8 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 			if (find_next_zero_bit(mem->bitmap, index + nslots, index) ==
 					index + nslots)
 				goto found;
-		} else {
-			/*
-			 * Remaining slots between current one and the next
-			 * bounary cannot meet our requirement.
-			 */
-			index = wrap_index(mem, round_up(index, max_slots));
 		}
-		index = wrap_index(mem, index + stride);
-	} while (index != wrap);
+	}
 
 not_found:
 	spin_unlock_irqrestore(&mem->lock, flags);
@@ -568,15 +558,9 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 		__clear_bit(i, mem->bitmap);
 		mem->slots[i].alloc_size =
 			alloc_size - (offset + ((i - index) << IO_TLB_SHIFT));
+		list_del(&mem->slots[i].node);
 	}
 
-	/*
-	 * Update the indices to avoid searching in the next round.
-	 */
-	if (index + nslots < mem->nslabs)
-		mem->index = index + nslots;
-	else
-		mem->index = 0;
 	mem->used += nslots;
 
 	spin_unlock_irqrestore(&mem->lock, flags);
@@ -653,6 +637,7 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 		__set_bit(i, mem->bitmap);
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
+		list_add(&mem->slots[i].node, &mem->free_slots);
 	}
 
 	mem->used -= nslots;
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
