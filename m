Return-Path: <SRS0=/T8B=3Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840FDC3524A
	for <iommu@archiver.kernel.org>; Tue,  4 Feb 2020 06:32:15 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588AD2086A
	for <iommu@archiver.kernel.org>; Tue,  4 Feb 2020 06:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iSB/Ye9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588AD2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 21CB784DD1;
	Tue,  4 Feb 2020 06:32:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sRNIvta3BusX; Tue,  4 Feb 2020 06:32:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6C39784AE1;
	Tue,  4 Feb 2020 06:32:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B8CFC1D81;
	Tue,  4 Feb 2020 06:32:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F8A1C0174
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 06:32:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 03D7384FA7
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 06:32:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3d1K63tRY-er for <iommu@lists.linux-foundation.org>;
 Tue,  4 Feb 2020 06:32:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C5B9984F6A
 for <iommu@lists.linux-foundation.org>; Tue,  4 Feb 2020 06:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=WO3aGKMLhSItShYL4YFiEW+0t5h86tQid5XsHlIa/Cc=; b=iSB/Ye9/TN9eBJjI4/cvDApqma
 e93TPwqXMZ6Di8xq5xYXFzvZ/4H52Es/a304TgkAftw+/HaNNRZlU/zIcSoJ+KqjNMlLZCaBw1y/P
 gMroaLAiadxzism6jaNK8gDvqRMqj3BiZ5DL3dBiyvZ4XHcoPlvpudqP0yXAsmE2a8L9RVR+Pqsim
 kfCnSjMoOGybbRYQwUi5ITIajc6w3/7HlORX2/gwEjNPl8xvy6ZQrGMpm7Ma9+VMKoGSrY4BZHrXx
 I+WvhYyE3Nh7Ui7wsJNUmK0hCc1J1g98LU9nYmcy9Gl83ot1I20jZcUPoCgsb1u0p6y+4ASydN8Vq
 OvNkF5lg==;
Received: from [2001:4bb8:184:589f:5d35:7054:f1cc:c43d] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iyrkn-00088V-TS; Tue, 04 Feb 2020 06:32:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 1/2] dma-direct: improve swiotlb error reporting
Date: Tue,  4 Feb 2020 07:32:04 +0100
Message-Id: <20200204063205.652456-2-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204063205.652456-1-hch@lst.de>
References: <20200204063205.652456-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org
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

Untangle the way how dma_direct_map_page calls into swiotlb to be able
to properly report errors where the swiotlb DMA address overflows the
mask separately from overflows in the !swiotlb case.  This means that
siotlb_map now has to do a little more work that duplicates
dma_direct_map_page, but doing so greatly simplifies the calling
convention.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swiotlb.h | 11 +++--------
 kernel/dma/direct.c     | 16 +++++++--------
 kernel/dma/swiotlb.c    | 43 +++++++++++++++++++++++------------------
 3 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index cde3dc18e21a..046bb94bd4d6 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -64,6 +64,9 @@ extern void swiotlb_tbl_sync_single(struct device *hwdev,
 				    size_t size, enum dma_data_direction dir,
 				    enum dma_sync_target target);
 
+dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
+		size_t size, enum dma_data_direction dir, unsigned long attrs);
+
 #ifdef CONFIG_SWIOTLB
 extern enum swiotlb_force swiotlb_force;
 extern phys_addr_t io_tlb_start, io_tlb_end;
@@ -73,8 +76,6 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 	return paddr >= io_tlb_start && paddr < io_tlb_end;
 }
 
-bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs);
 void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 size_t swiotlb_max_mapping_size(struct device *dev);
@@ -85,12 +86,6 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
 {
 	return false;
 }
-static inline bool swiotlb_map(struct device *dev, phys_addr_t *phys,
-		dma_addr_t *dma_addr, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	return false;
-}
 static inline void swiotlb_exit(void)
 {
 }
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 6af7ae83c4ad..82ad50aaf42c 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -357,13 +357,6 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 EXPORT_SYMBOL(dma_direct_unmap_sg);
 #endif
 
-static inline bool dma_direct_possible(struct device *dev, dma_addr_t dma_addr,
-		size_t size)
-{
-	return swiotlb_force != SWIOTLB_FORCE &&
-		dma_capable(dev, dma_addr, size, true);
-}
-
 dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
@@ -371,8 +364,13 @@ dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 	phys_addr_t phys = page_to_phys(page) + offset;
 	dma_addr_t dma_addr = phys_to_dma(dev, phys);
 
-	if (unlikely(!dma_direct_possible(dev, dma_addr, size)) &&
-	    !swiotlb_map(dev, &phys, &dma_addr, size, dir, attrs)) {
+	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
+		return swiotlb_map(dev, phys, size, dir, attrs);
+
+	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
+		if (swiotlb_force != SWIOTLB_NO_FORCE)
+			return swiotlb_map(dev, phys, size, dir, attrs);
+
 		report_addr(dev, dma_addr, size);
 		return DMA_MAPPING_ERROR;
 	}
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 9280d6f8271e..589bb9a40f21 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -22,6 +22,7 @@
 
 #include <linux/cache.h>
 #include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/mm.h>
 #include <linux/export.h>
 #include <linux/spinlock.h>
@@ -656,35 +657,39 @@ void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
 }
 
 /*
- * Create a swiotlb mapping for the buffer at @phys, and in case of DMAing
+ * Create a swiotlb mapping for the buffer at @paddr, and in case of DMAing
  * to the device copy the data into it as well.
  */
-bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
+dma_addr_t swiotlb_map(struct device *dev, phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir, unsigned long attrs)
 {
-	trace_swiotlb_bounced(dev, *dma_addr, size, swiotlb_force);
+	phys_addr_t swiotlb_addr;
+	dma_addr_t dma_addr;
 
-	if (unlikely(swiotlb_force == SWIOTLB_NO_FORCE)) {
-		dev_warn_ratelimited(dev,
-			"Cannot do DMA to address %pa\n", phys);
-		return false;
-	}
+	trace_swiotlb_bounced(dev, phys_to_dma(dev, paddr), size,
+			      swiotlb_force);
 
-	/* Oh well, have to allocate and map a bounce buffer. */
-	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
-			*phys, size, size, dir, attrs);
-	if (*phys == (phys_addr_t)DMA_MAPPING_ERROR)
-		return false;
+	swiotlb_addr = swiotlb_tbl_map_single(dev,
+			__phys_to_dma(dev, io_tlb_start),
+			paddr, size, size, dir, attrs);
+	if (swiotlb_addr == (phys_addr_t)DMA_MAPPING_ERROR)
+		return DMA_MAPPING_ERROR;
 
 	/* Ensure that the address returned is DMA'ble */
-	*dma_addr = __phys_to_dma(dev, *phys);
-	if (unlikely(!dma_capable(dev, *dma_addr, size, true))) {
-		swiotlb_tbl_unmap_single(dev, *phys, size, size, dir,
+	dma_addr = __phys_to_dma(dev, swiotlb_addr);
+	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
+		swiotlb_tbl_unmap_single(dev, swiotlb_addr, size, size, dir,
 			attrs | DMA_ATTR_SKIP_CPU_SYNC);
-		return false;
+		dev_err_once(dev,
+			"swiotlb addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
+			&dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
+		WARN_ON_ONCE(1);
+		return DMA_MAPPING_ERROR;
 	}
 
-	return true;
+	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		arch_sync_dma_for_device(swiotlb_addr, size, dir);
+	return dma_addr;
 }
 
 size_t swiotlb_max_mapping_size(struct device *dev)
-- 
2.24.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
