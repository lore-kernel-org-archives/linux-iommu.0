Return-Path: <SRS0=Fdbd=H7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1BFC433DB
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 07:45:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 870FF64E01
	for <iommu@archiver.kernel.org>; Mon,  1 Mar 2021 07:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870FF64E01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 586AA4F28A;
	Mon,  1 Mar 2021 07:45:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SjJOLCQFyYjO; Mon,  1 Mar 2021 07:45:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2D794F285;
	Mon,  1 Mar 2021 07:45:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E1CBC000B;
	Mon,  1 Mar 2021 07:45:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C9037C0001
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 07:45:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B7E0560675
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 07:45:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TbrdzJiz6rBI for <iommu@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 07:45:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DAFA46066B
 for <iommu@lists.linux-foundation.org>; Mon,  1 Mar 2021 07:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=dcvL651kX+/+tDC/vc46FsoJZklOjDE98QeeBFDCLlE=; b=t5bTAovDUHg7PpXkFQaiN6GS+l
 rkEIHPA6OhDt3ss3PZEGfvrl8GQrzKXAqN22LEPl3yalumIEbug2Mu3ZsVTlLRPfpqzmgn4u29+Pw
 ZhjNV/YNPlJKM7XgqRRv34XplHbctmeg7RJ3KgGkyClBZAmTvDJrEpqcPR4+m/bo3kUD/VlOKKmlT
 p4Z/hoChDLtFgMHzWcInci8zLGCyhU9l1JIlIA3uJMnES6B0KRUI7Oys99vUcnkChl95PxYeWgubf
 dJrGji3sLeseANLPZPDcjriDIvMgIvbCdlTwdK8prS9HkHh1sUXjgHiPJpP/OP24o6JodkPxa7avY
 sCMcSA5w==;
Received: from [2001:4bb8:19b:e4b7:cdf9:733f:4874:8eb4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lGdEv-00FRBY-PX; Mon, 01 Mar 2021 07:45:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 04/14] swiotlb: split swiotlb_tbl_sync_single
Date: Mon,  1 Mar 2021 08:44:26 +0100
Message-Id: <20210301074436.919889-5-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210301074436.919889-1-hch@lst.de>
References: <20210301074436.919889-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Michael Ellerman <mpe@ellerman.id.au>, iommu@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, Claire Chang <tientzu@chromium.org>,
 linuxppc-dev@lists.ozlabs.org, Dongli Zhang <dongli.zhang@oracle.com>
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

Split swiotlb_tbl_sync_single into two separate funtions for the to device
and to cpu synchronization.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c | 12 ++++++------
 drivers/xen/swiotlb-xen.c |  4 ++--
 include/linux/swiotlb.h   | 17 ++++-------------
 kernel/dma/direct.c       |  8 ++++----
 kernel/dma/direct.h       |  4 ++--
 kernel/dma/swiotlb.c      | 34 +++++++++++++++-------------------
 6 files changed, 33 insertions(+), 46 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index da2bd8f0885e6e..b57a0e3e21f6c7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -749,7 +749,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 		arch_sync_dma_for_cpu(phys, size, dir);
 
 	if (is_swiotlb_buffer(phys))
-		swiotlb_tbl_sync_single(dev, phys, size, dir, SYNC_FOR_CPU);
+		swiotlb_sync_single_for_cpu(dev, phys, size, dir);
 }
 
 static void iommu_dma_sync_single_for_device(struct device *dev,
@@ -762,7 +762,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
 	if (is_swiotlb_buffer(phys))
-		swiotlb_tbl_sync_single(dev, phys, size, dir, SYNC_FOR_DEVICE);
+		swiotlb_sync_single_for_device(dev, phys, size, dir);
 
 	if (!dev_is_dma_coherent(dev))
 		arch_sync_dma_for_device(phys, size, dir);
@@ -783,8 +783,8 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
 
 		if (is_swiotlb_buffer(sg_phys(sg)))
-			swiotlb_tbl_sync_single(dev, sg_phys(sg), sg->length,
-						dir, SYNC_FOR_CPU);
+			swiotlb_sync_single_for_cpu(dev, sg_phys(sg),
+						    sg->length, dir);
 	}
 }
 
@@ -800,8 +800,8 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 
 	for_each_sg(sgl, sg, nelems, i) {
 		if (is_swiotlb_buffer(sg_phys(sg)))
-			swiotlb_tbl_sync_single(dev, sg_phys(sg), sg->length,
-						dir, SYNC_FOR_DEVICE);
+			swiotlb_sync_single_for_device(dev, sg_phys(sg),
+						       sg->length, dir);
 
 		if (!dev_is_dma_coherent(dev))
 			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index d47f1b311caac0..4e8a4e14942afd 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -462,7 +462,7 @@ xen_swiotlb_sync_single_for_cpu(struct device *dev, dma_addr_t dma_addr,
 	}
 
 	if (is_xen_swiotlb_buffer(dev, dma_addr))
-		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
+		swiotlb_sync_single_for_cpu(dev, paddr, size, dir);
 }
 
 static void
@@ -472,7 +472,7 @@ xen_swiotlb_sync_single_for_device(struct device *dev, dma_addr_t dma_addr,
 	phys_addr_t paddr = xen_dma_to_phys(dev, dma_addr);
 
 	if (is_xen_swiotlb_buffer(dev, dma_addr))
-		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
+		swiotlb_sync_single_for_device(dev, paddr, size, dir);
 
 	if (!dev_is_dma_coherent(dev)) {
 		if (pfn_valid(PFN_DOWN(dma_to_phys(dev, dma_addr))))
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 59f421d041ed9e..0696bdc8072e97 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -42,14 +42,6 @@ extern int swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs);
 extern int swiotlb_late_init_with_default_size(size_t default_size);
 extern void __init swiotlb_update_mem_attributes(void);
 
-/*
- * Enumeration for sync targets
- */
-enum dma_sync_target {
-	SYNC_FOR_CPU = 0,
-	SYNC_FOR_DEVICE = 1,
-};
-
 phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t phys,
 		size_t mapping_size, size_t alloc_size,
 		enum dma_data_direction dir, unsigned long attrs);
@@ -60,11 +52,10 @@ extern void swiotlb_tbl_unmap_single(struct device *hwdev,
 				     enum dma_data_direction dir,
 				     unsigned long attrs);
 
-extern void swiotlb_tbl_sync_single(struct device *hwdev,
-				    phys_addr_t tlb_addr,
-				    size_t size, enum dma_data_direction dir,
-				    enum dma_sync_target target);
-
+void swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,
+		size_t size, enum dma_data_direction dir);
+void swiotlb_sync_single_for_cpu(struct device *dev, phys_addr_t tlb_addr,
+		size_t size, enum dma_data_direction dir);
 dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 002268262c9ad8..f737e334705945 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -344,8 +344,8 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
 
 		if (unlikely(is_swiotlb_buffer(paddr)))
-			swiotlb_tbl_sync_single(dev, paddr, sg->length,
-					dir, SYNC_FOR_DEVICE);
+			swiotlb_sync_single_for_device(dev, paddr, sg->length,
+						       dir);
 
 		if (!dev_is_dma_coherent(dev))
 			arch_sync_dma_for_device(paddr, sg->length,
@@ -370,8 +370,8 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 			arch_sync_dma_for_cpu(paddr, sg->length, dir);
 
 		if (unlikely(is_swiotlb_buffer(paddr)))
-			swiotlb_tbl_sync_single(dev, paddr, sg->length, dir,
-					SYNC_FOR_CPU);
+			swiotlb_sync_single_for_cpu(dev, paddr, sg->length,
+						    dir);
 
 		if (dir == DMA_FROM_DEVICE)
 			arch_dma_mark_clean(paddr, sg->length);
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index e1bf721591c0cf..50afc05b6f1dcb 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -57,7 +57,7 @@ static inline void dma_direct_sync_single_for_device(struct device *dev,
 	phys_addr_t paddr = dma_to_phys(dev, addr);
 
 	if (unlikely(is_swiotlb_buffer(paddr)))
-		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
+		swiotlb_sync_single_for_device(dev, paddr, size, dir);
 
 	if (!dev_is_dma_coherent(dev))
 		arch_sync_dma_for_device(paddr, size, dir);
@@ -74,7 +74,7 @@ static inline void dma_direct_sync_single_for_cpu(struct device *dev,
 	}
 
 	if (unlikely(is_swiotlb_buffer(paddr)))
-		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
+		swiotlb_sync_single_for_cpu(dev, paddr, size, dir);
 
 	if (dir == DMA_FROM_DEVICE)
 		arch_dma_mark_clean(paddr, size);
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index a9063092f6f566..388d9be35b5795 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -715,26 +715,22 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 }
 
-void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
-			     size_t size, enum dma_data_direction dir,
-			     enum dma_sync_target target)
+void swiotlb_sync_single_for_device(struct device *dev, phys_addr_t tlb_addr,
+		size_t size, enum dma_data_direction dir)
 {
-	switch (target) {
-	case SYNC_FOR_CPU:
-		if (likely(dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL))
-			swiotlb_bounce(hwdev, tlb_addr, size, DMA_FROM_DEVICE);
-		else
-			BUG_ON(dir != DMA_TO_DEVICE);
-		break;
-	case SYNC_FOR_DEVICE:
-		if (likely(dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
-			swiotlb_bounce(hwdev, tlb_addr, size, DMA_TO_DEVICE);
-		else
-			BUG_ON(dir != DMA_FROM_DEVICE);
-		break;
-	default:
-		BUG();
-	}
+	if (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)
+		swiotlb_bounce(dev, tlb_addr, size, DMA_TO_DEVICE);
+	else
+		BUG_ON(dir != DMA_FROM_DEVICE);
+}
+
+void swiotlb_sync_single_for_cpu(struct device *dev, phys_addr_t tlb_addr,
+		size_t size, enum dma_data_direction dir)
+{
+	if (dir == DMA_FROM_DEVICE || dir == DMA_BIDIRECTIONAL)
+		swiotlb_bounce(dev, tlb_addr, size, DMA_FROM_DEVICE);
+	else
+		BUG_ON(dir != DMA_TO_DEVICE);
 }
 
 /*
-- 
2.29.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
