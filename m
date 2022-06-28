Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75BEC433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Jun 2022 07:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2181E830E6;
	Tue, 28 Jun 2022 07:01:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2181E830E6
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XEm+erW0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o25yhkP1ikUO; Tue, 28 Jun 2022 07:01:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9C43482FF9;
	Tue, 28 Jun 2022 07:01:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C43482FF9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8209AC0032;
	Tue, 28 Jun 2022 07:01:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A78FC002D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4620410C2
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:01:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E4620410C2
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=XEm+erW0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D86eonBBKBQK for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 07:01:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A235E40A05
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A235E40A05
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jun 2022 07:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656399710; x=1687935710;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mPDwd3BkU3o6OuGz9qQJs1CO8hLpWEnsDMkD88RV/8k=;
 b=XEm+erW0wyHg+TM5k1JHp4tO+CAY8jx0qbo/YNiXn4+sCwnB+OnR7ocY
 unYD0aX4H4I+XlpRYlj2UV4d4ywP7fHbK01JD8TNW17s1xmO//Sc5k3Ht
 JLELfc7z7RaQI3iZa1qdQ8+LCwuAgoFXiwvqGMVlqXEsUC342TlyI0X4y
 S4sFu19h9PhsodY7B1oO7Ee3Pfsas9iJn5IXJewXy0liLE8aV0HC3k3OY
 1H100ctW8Amf4d7o3fuAC8W3DZHMoMFBmb3PH7Qc58Fa9WCgZ6OQn221N
 eruC/LyKQlfE4zxcAgisEbj2tVZmHS7ho3UHxCTnU2Z8da6YBR+urKppX g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="345652857"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="345652857"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 00:01:50 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; d="scan'208";a="646782839"
Received: from spr.sh.intel.com ([10.239.53.120])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2022 00:01:47 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] swiotlb: Use bitmap to track free slots
Date: Tue, 28 Jun 2022 15:01:32 +0800
Message-Id: <20220628070136.419163-2-chao.gao@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628070136.419163-1-chao.gao@intel.com>
References: <20220628070136.419163-1-chao.gao@intel.com>
MIME-Version: 1.0
Cc: len.brown@intel.com, tony.luck@intel.com, rafael.j.wysocki@intel.com,
 dave.hansen@intel.com, iommu@lists.linux-foundation.org,
 ilpo.jarvinen@linux.intel.com, dan.j.williams@intel.com,
 reinette.chatre@intel.com, kirill.shutemov@linux.intel.com
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

Currently, each slot tracks the number of contiguous free slots starting
from itself. It helps to quickly check if there are enough contiguous
entries when dealing with an allocation request. But maintaining this
information can leads to some overhead. Specifically, if a slot is
allocated/freed, preceding slots may need to be updated as the number
of contiguous free slots can change. This process may access memory
scattering over multiple cachelines.

To reduce the overhead of maintaining the number of contiguous free
entries, use a global bitmap to track free slots; each bit represents
if a slot is available. The number of contiguous free slots can be
calculated by counting the number of consecutive 1s in the bitmap.

Tests show that the average cost of freeing slots drops by 120 cycles
while the average cost of allocation increases by 20 cycles. Overall,
100 cycles are saved from a pair of allocation and freeing.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 include/linux/swiotlb.h |  6 ++--
 kernel/dma/swiotlb.c    | 64 ++++++++++++++++++++---------------------
 2 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 7ed35dd3de6e..c3eab237991a 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -78,8 +78,6 @@ extern enum swiotlb_force swiotlb_force;
  *		@end. For default swiotlb, this is command line adjustable via
  *		setup_io_tlb_npages.
  * @used:	The number of used IO TLB block.
- * @list:	The free list describing the number of free entries available
- *		from each index.
  * @index:	The index to start searching in the next round.
  * @orig_addr:	The original address corresponding to a mapped entry.
  * @alloc_size:	Size of the allocated buffer.
@@ -89,6 +87,8 @@ extern enum swiotlb_force swiotlb_force;
  * @late_alloc:	%true if allocated using the page allocator
  * @force_bounce: %true if swiotlb bouncing is forced
  * @for_alloc:  %true if the pool is used for memory allocation
+ * @bitmap:	The bitmap used to track free entries. 1 in bit X means the slot
+ *		indexed by X is free.
  */
 struct io_tlb_mem {
 	phys_addr_t start;
@@ -105,8 +105,8 @@ struct io_tlb_mem {
 	struct io_tlb_slot {
 		phys_addr_t orig_addr;
 		size_t alloc_size;
-		unsigned int list;
 	} *slots;
+	unsigned long *bitmap;
 };
 extern struct io_tlb_mem io_tlb_default_mem;
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index cb50f8d38360..d7f68c0af7f5 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -207,7 +207,7 @@ static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
 
 	spin_lock_init(&mem->lock);
 	for (i = 0; i < mem->nslabs; i++) {
-		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
+		__set_bit(i, mem->bitmap);
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
 	}
@@ -274,6 +274,11 @@ void __init swiotlb_init_remap(bool addressing_limit, unsigned int flags,
 		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
 		      __func__, alloc_size, PAGE_SIZE);
 
+	mem->bitmap = memblock_alloc(BITS_TO_BYTES(nslabs), SMP_CACHE_BYTES);
+	if (!mem->bitmap)
+		panic("%s: Failed to allocate %lu bytes align=0x%x\n",
+		      __func__, DIV_ROUND_UP(nslabs, BITS_PER_BYTE), SMP_CACHE_BYTES);
+
 	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, flags, false);
 
 	if (flags & SWIOTLB_VERBOSE)
@@ -337,10 +342,13 @@ int swiotlb_init_late(size_t size, gfp_t gfp_mask,
 			(PAGE_SIZE << order) >> 20);
 	}
 
+	mem->bitmap = bitmap_zalloc(nslabs, GFP_KERNEL);
 	mem->slots = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
 		get_order(array_size(sizeof(*mem->slots), nslabs)));
-	if (!mem->slots) {
+	if (!mem->slots || !mem->bitmap) {
 		free_pages((unsigned long)vstart, order);
+		bitmap_free(mem->bitmap);
+		kfree(mem->slots);
 		return -ENOMEM;
 	}
 
@@ -498,7 +506,7 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 	unsigned int iotlb_align_mask =
 		dma_get_min_align_mask(dev) & ~(IO_TLB_SIZE - 1);
 	unsigned int nslots = nr_slots(alloc_size), stride;
-	unsigned int index, wrap, count = 0, i;
+	unsigned int index, wrap, i;
 	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
 	unsigned long flags;
 
@@ -514,6 +522,9 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 		stride = max(stride, stride << (PAGE_SHIFT - IO_TLB_SHIFT));
 	stride = max(stride, (alloc_align_mask >> IO_TLB_SHIFT) + 1);
 
+	/* slots shouldn't cross one segment */
+	max_slots = min_t(unsigned long, max_slots, IO_TLB_SEGSIZE);
+
 	spin_lock_irqsave(&mem->lock, flags);
 	if (unlikely(nslots > mem->nslabs - mem->used))
 		goto not_found;
@@ -535,8 +546,15 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 		if (!iommu_is_span_boundary(index, nslots,
 					    nr_slots(tbl_dma_addr),
 					    max_slots)) {
-			if (mem->slots[index].list >= nslots)
+			if (find_next_zero_bit(mem->bitmap, index + nslots, index) ==
+					index + nslots)
 				goto found;
+		} else {
+			/*
+			 * Remaining slots between current one and the next
+			 * bounary cannot meet our requirement.
+			 */
+			index = wrap_index(mem, round_up(index, max_slots));
 		}
 		index = wrap_index(mem, index + stride);
 	} while (index != wrap);
@@ -547,14 +565,10 @@ static int swiotlb_find_slots(struct device *dev, phys_addr_t orig_addr,
 
 found:
 	for (i = index; i < index + nslots; i++) {
-		mem->slots[i].list = 0;
+		__clear_bit(i, mem->bitmap);
 		mem->slots[i].alloc_size =
 			alloc_size - (offset + ((i - index) << IO_TLB_SHIFT));
 	}
-	for (i = index - 1;
-	     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 &&
-	     mem->slots[i].list; i--)
-		mem->slots[i].list = ++count;
 
 	/*
 	 * Update the indices to avoid searching in the next round.
@@ -628,38 +642,19 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 	unsigned int offset = swiotlb_align_offset(dev, tlb_addr);
 	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
 	int nslots = nr_slots(mem->slots[index].alloc_size + offset);
-	int count, i;
+	int i;
 
-	/*
-	 * Return the buffer to the free list by setting the corresponding
-	 * entries to indicate the number of contiguous entries available.
-	 * While returning the entries to the free list, we merge the entries
-	 * with slots below and above the pool being returned.
-	 */
 	spin_lock_irqsave(&mem->lock, flags);
-	if (index + nslots < ALIGN(index + 1, IO_TLB_SEGSIZE))
-		count = mem->slots[index + nslots].list;
-	else
-		count = 0;
-
 	/*
-	 * Step 1: return the slots to the free list, merging the slots with
-	 * superceeding slots
+	 * Return the slots to swiotlb, updating bitmap to indicate
+	 * corresponding entries are free.
 	 */
 	for (i = index + nslots - 1; i >= index; i--) {
-		mem->slots[i].list = ++count;
+		__set_bit(i, mem->bitmap);
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
 	}
 
-	/*
-	 * Step 2: merge the returned slots with the preceding slots, if
-	 * available (non zero)
-	 */
-	for (i = index - 1;
-	     io_tlb_offset(i) != IO_TLB_SEGSIZE - 1 && mem->slots[i].list;
-	     i--)
-		mem->slots[i].list = ++count;
 	mem->used -= nslots;
 	spin_unlock_irqrestore(&mem->lock, flags);
 }
@@ -826,7 +821,10 @@ static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
 			return -ENOMEM;
 
 		mem->slots = kcalloc(nslabs, sizeof(*mem->slots), GFP_KERNEL);
-		if (!mem->slots) {
+		mem->bitmap = bitmap_zalloc(nslabs, GFP_KERNEL);
+		if (!mem->slots || !mem->bitmap) {
+			kfree(mem->slots);
+			bitmap_free(mem->bitmap);
 			kfree(mem);
 			return -ENOMEM;
 		}
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
