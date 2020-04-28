Return-Path: <SRS0=7g3a=6M=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7C2C83004
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 12:05:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E9F6206D7
	for <iommu@archiver.kernel.org>; Tue, 28 Apr 2020 12:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="GSSfGXuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E9F6206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D3C5B86F87;
	Tue, 28 Apr 2020 12:05:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qUOHsJe4BR2j; Tue, 28 Apr 2020 12:05:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8A9B68706B;
	Tue, 28 Apr 2020 12:05:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D1F9C0172;
	Tue, 28 Apr 2020 12:05:46 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81859C0863
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 11:40:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7E4C888047
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 11:40:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ETQpSeNLXsPv for <iommu@lists.linux-foundation.org>;
 Tue, 28 Apr 2020 11:40:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail27.static.mailgun.info (mail27.static.mailgun.info
 [104.130.122.27])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 18FAD88058
 for <iommu@lists.linux-foundation.org>; Tue, 28 Apr 2020 11:40:07 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1588074011; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Ic5PAM9vc1XfgijUSdoG2PECaN335jbhSTijBUOxs58=;
 b=GSSfGXuCPFIX5Qo/e7x/Z6IIeTi9daS/jRoZQ78DJ8R/slLqd4njIyc3dEKj/Bm6do2YmFBl
 okak8ZHEpy4aw3obYC2m49V3Duj/1QppIPtqgkAeyB3e/vKKUFdveRrjXmKVQw845zV6Px06
 vVNnF3JdGUQPLAd0zI30ukWtf4Q=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea81604.7f2981041570-smtp-out-n04;
 Tue, 28 Apr 2020 11:39:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id AEE2EC43637; Tue, 28 Apr 2020 11:39:47 +0000 (UTC)
Received: from blr-ubuntu-31.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: svaddagi)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id A9AA4C433D2;
 Tue, 28 Apr 2020 11:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9AA4C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=vatsa@codeaurora.org
From: Srivatsa Vaddagiri <vatsa@codeaurora.org>
To: konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com,
 jan.kiszka@siemens.com, will@kernel.org, stefano.stabellini@xilinx.com
Subject: [PATCH 3/5] swiotlb: Add alloc and free APIs
Date: Tue, 28 Apr 2020 17:09:16 +0530
Message-Id: <1588073958-1793-4-git-send-email-vatsa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
References: <1588073958-1793-1-git-send-email-vatsa@codeaurora.org>
X-Mailman-Approved-At: Tue, 28 Apr 2020 12:05:44 +0000
Cc: tsoni@codeaurora.org, virtio-dev@lists.oasis-open.org,
 alex.bennee@linaro.org, vatsa@codeaurora.org, christoffer.dall@arm.com,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 pratikp@codeaurora.org, linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Move the memory allocation and free portion of swiotlb driver
into independent routines. They will be useful for drivers that
need swiotlb driver to just allocate/free memory chunks and not
additionally bounce memory.

Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>
---
 include/linux/swiotlb.h |  17 ++++++
 kernel/dma/swiotlb.c    | 151 ++++++++++++++++++++++++++++--------------------
 2 files changed, 106 insertions(+), 62 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index c634b4d..957697e 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -186,6 +186,10 @@ void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
 bool is_swiotlb_active(void);
+extern phys_addr_t swiotlb_alloc(struct swiotlb_pool *pool, size_t alloc_size,
+		unsigned long tbl_dma_addr, unsigned long mask);
+extern void swiotlb_free(struct swiotlb_pool *pool,
+			phys_addr_t tlb_addr, size_t alloc_size);
 #else
 #define swiotlb_force SWIOTLB_NO_FORCE
 
@@ -219,6 +223,19 @@ static inline bool is_swiotlb_active(void)
 {
 	return false;
 }
+
+static inline phys_addr_t swiotlb_alloc(struct swiotlb_pool *pool,
+		size_t alloc_size, unsigned long tbl_dma_addr,
+		unsigned long mask)
+{
+	return DMA_MAPPING_ERROR;
+}
+
+static inline void swiotlb_free(struct swiotlb_pool *pool,
+			phys_addr_t tlb_addr, size_t alloc_size)
+{
+}
+
 #endif /* CONFIG_SWIOTLB */
 
 extern void swiotlb_print_info(void);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 8cf0b57..7411ce5 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -444,37 +444,14 @@ static inline void *tlb_vaddr(struct swiotlb_pool *pool, phys_addr_t tlb_addr)
 	return pool->io_tlb_vstart + (tlb_addr - pool->io_tlb_start);
 }
 
-phys_addr_t _swiotlb_tbl_map_single(struct swiotlb_pool *pool,
-				   struct device *hwdev,
-				   dma_addr_t tbl_dma_addr,
-				   phys_addr_t orig_addr,
-				   size_t mapping_size,
-				   size_t alloc_size,
-				   enum dma_data_direction dir,
-				   unsigned long attrs)
+phys_addr_t swiotlb_alloc(struct swiotlb_pool *pool, size_t alloc_size,
+		unsigned long tbl_dma_addr, unsigned long mask)
 {
 	unsigned long flags;
 	phys_addr_t tlb_addr;
-	unsigned int nslots, stride, index, wrap;
-	int i;
-	unsigned long mask;
+	unsigned int i, nslots, stride, index, wrap;
 	unsigned long offset_slots;
 	unsigned long max_slots;
-	unsigned long tmp_io_tlb_used;
-
-	if (pool->no_iotlb_memory)
-		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
-
-	if (mem_encrypt_active())
-		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
-
-	if (mapping_size > alloc_size) {
-		dev_warn_once(hwdev, "Invalid sizes (mapping: %zd bytes, alloc: %zd bytes)",
-			      mapping_size, alloc_size);
-		return (phys_addr_t)DMA_MAPPING_ERROR;
-	}
-
-	mask = dma_get_seg_boundary(hwdev);
 
 	tbl_dma_addr &= mask;
 
@@ -555,54 +532,23 @@ phys_addr_t _swiotlb_tbl_map_single(struct swiotlb_pool *pool,
 	} while (index != wrap);
 
 not_found:
-	tmp_io_tlb_used = pool->io_tlb_used;
-
 	spin_unlock_irqrestore(&pool->io_tlb_lock, flags);
-	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
-		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
-			 alloc_size, pool->io_tlb_nslabs, tmp_io_tlb_used);
 	return (phys_addr_t)DMA_MAPPING_ERROR;
+
 found:
 	pool->io_tlb_used += nslots;
 	spin_unlock_irqrestore(&pool->io_tlb_lock, flags);
 
-	/*
-	 * Save away the mapping from the original address to the DMA address.
-	 * This is needed when we sync the memory.  Then we sync the buffer if
-	 * needed.
-	 */
-	for (i = 0; i < nslots; i++)
-		pool->io_tlb_orig_addr[index+i] = orig_addr +
-						(i << IO_TLB_SHIFT);
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
-		swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
-					mapping_size, DMA_TO_DEVICE);
-
 	return tlb_addr;
 }
 
-/*
- * tlb_addr is the physical address of the bounce buffer to unmap.
- */
-void _swiotlb_tbl_unmap_single(struct swiotlb_pool *pool,
-			struct device *hwdev, phys_addr_t tlb_addr,
-			size_t mapping_size, size_t alloc_size,
-			enum dma_data_direction dir, unsigned long attrs)
+void swiotlb_free(struct swiotlb_pool *pool,
+			phys_addr_t tlb_addr, size_t alloc_size)
 {
 	unsigned long flags;
-	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	int i, count;
+	int nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
 	int index = (tlb_addr - pool->io_tlb_start) >> IO_TLB_SHIFT;
-	phys_addr_t orig_addr = pool->io_tlb_orig_addr[index];
-
-	/*
-	 * First, sync the memory before unmapping the entry
-	 */
-	if (orig_addr != INVALID_PHYS_ADDR &&
-	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
-		swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
-						mapping_size, DMA_FROM_DEVICE);
 
 	/*
 	 * Return the buffer to the free list by setting the corresponding
@@ -636,6 +582,87 @@ void _swiotlb_tbl_unmap_single(struct swiotlb_pool *pool,
 	spin_unlock_irqrestore(&pool->io_tlb_lock, flags);
 }
 
+phys_addr_t _swiotlb_tbl_map_single(struct swiotlb_pool *pool,
+				   struct device *hwdev,
+				   dma_addr_t tbl_dma_addr,
+				   phys_addr_t orig_addr,
+				   size_t mapping_size,
+				   size_t alloc_size,
+				   enum dma_data_direction dir,
+				   unsigned long attrs)
+{
+	phys_addr_t tlb_addr;
+	unsigned int nslots, index;
+	int i;
+	unsigned long mask;
+
+	if (pool->no_iotlb_memory)
+		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
+
+	if (mem_encrypt_active())
+		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
+
+	if (mapping_size > alloc_size) {
+		dev_warn_once(hwdev, "Invalid sizes (mapping: %zd bytes, alloc: %zd bytes)",
+			      mapping_size, alloc_size);
+		return (phys_addr_t)DMA_MAPPING_ERROR;
+	}
+
+	mask = dma_get_seg_boundary(hwdev);
+
+	tlb_addr = swiotlb_alloc(pool, alloc_size, tbl_dma_addr, mask);
+
+	if (tlb_addr == DMA_MAPPING_ERROR) {
+		if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
+			dev_warn(hwdev, "swiotlb buffer is full (sz: %zd "
+				"bytes), total %lu (slots), used %lu (slots)\n",
+				alloc_size, pool->io_tlb_nslabs,
+				pool->io_tlb_used);
+		return (phys_addr_t)DMA_MAPPING_ERROR;
+	}
+
+	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	index = (tlb_addr - pool->io_tlb_start) >> IO_TLB_SHIFT;
+
+	/*
+	 * Save away the mapping from the original address to the DMA address.
+	 * This is needed when we sync the memory.  Then we sync the buffer if
+	 * needed.
+	 */
+	for (i = 0; i < nslots; i++)
+		pool->io_tlb_orig_addr[index+i] = orig_addr +
+						(i << IO_TLB_SHIFT);
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
+		swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
+					mapping_size, DMA_TO_DEVICE);
+
+	return tlb_addr;
+}
+
+/*
+ * tlb_addr is the physical address of the bounce buffer to unmap.
+ */
+void _swiotlb_tbl_unmap_single(struct swiotlb_pool *pool,
+			struct device *hwdev, phys_addr_t tlb_addr,
+			size_t mapping_size, size_t alloc_size,
+			enum dma_data_direction dir, unsigned long attrs)
+{
+	int index = (tlb_addr - pool->io_tlb_start) >> IO_TLB_SHIFT;
+	phys_addr_t orig_addr = pool->io_tlb_orig_addr[index];
+
+	/*
+	 * First, sync the memory before unmapping the entry
+	 */
+	if (orig_addr != INVALID_PHYS_ADDR &&
+	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
+		swiotlb_bounce(orig_addr, tlb_vaddr(pool, tlb_addr),
+						mapping_size, DMA_FROM_DEVICE);
+
+	swiotlb_free(pool, tlb_addr, alloc_size);
+}
+
 void _swiotlb_tbl_sync_single(struct swiotlb_pool *pool,
 			struct device *hwdev, phys_addr_t tlb_addr,
 			size_t size, enum dma_data_direction dir,
-- 
2.7.4

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
