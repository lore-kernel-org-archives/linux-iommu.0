Return-Path: <SRS0=OYPK=SX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69033C282DD
	for <iommu@archiver.kernel.org>; Sun, 21 Apr 2019 01:25:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD0720651
	for <iommu@archiver.kernel.org>; Sun, 21 Apr 2019 01:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD0720651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id DB0B32CA4;
	Sun, 21 Apr 2019 01:24:44 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 379CA2BE9
	for <iommu@lists.linux-foundation.org>;
	Sun, 21 Apr 2019 01:23:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 99DE814D
	for <iommu@lists.linux-foundation.org>;
	Sun, 21 Apr 2019 01:23:58 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	20 Apr 2019 18:23:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,376,1549958400"; d="scan'208";a="136008141"
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by orsmga008.jf.intel.com with ESMTP; 20 Apr 2019 18:23:55 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 04/10] swiotlb: Extend swiotlb to support page bounce
Date: Sun, 21 Apr 2019 09:17:13 +0800
Message-Id: <20190421011719.14909-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190421011719.14909-1-baolu.lu@linux.intel.com>
References: <20190421011719.14909-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	alan.cox@intel.com, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	pengfei.xu@intel.com, jacob.jun.pan@intel.com,
	mika.westerberg@linux.intel.com, Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190421011713.68YPVT9QxVROyL73HhrLY0wsGMrSnbA_JGPxbP7Pj_g@z>

This extends below swiotlb APIs to support page bounce.

- swiotlb_tbl_map_single()
- swiotlb_tbl_unmap_single()

In page bounce manner, swiotlb allocates a whole page from the
slot pool, syncs the data, and returns the start place of the
bounced buffer in the page. The caller is responsible to sync
the data after DMA transfer with swiotlb_tbl_sync_single().

In order to distinguish page bounce from other type of bounces,
this introduces a new DMA attribution bit (DMA_ATTR_BOUNCE_PAGE)
which will be set in the @attrs passed to these APIs.

Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/dma-mapping.h |  6 +++++
 kernel/dma/swiotlb.c        | 53 ++++++++++++++++++++++++++++++++-----
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 75e60be91e5f..26e506e5b04c 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -70,6 +70,12 @@
  */
 #define DMA_ATTR_PRIVILEGED		(1UL << 9)
 
+/*
+ * DMA_ATTR_BOUNCE_PAGE: used by the IOMMU sub-system to indicate that
+ * the buffer is used as a bounce page in the DMA remapping page table.
+ */
+#define DMA_ATTR_BOUNCE_PAGE		(1UL << 10)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.
  * It can be given to a device to use as a DMA source or target.  A CPU cannot
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index dbb937ce79c8..96b87a11dee1 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -34,6 +34,7 @@
 #include <linux/scatterlist.h>
 #include <linux/mem_encrypt.h>
 #include <linux/set_memory.h>
+#include <linux/iommu.h>
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #endif
@@ -596,6 +597,14 @@ swiotlb_tbl_free_tlb(struct device *hwdev, phys_addr_t tlb_addr, size_t size)
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 }
 
+static unsigned long
+get_iommu_pgsize(struct device *dev, phys_addr_t phys, size_t size)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	return domain_minimal_pgsize(domain);
+}
+
 phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 				   dma_addr_t tbl_dma_addr,
 				   phys_addr_t orig_addr, size_t size,
@@ -603,17 +612,37 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 				   unsigned long attrs)
 {
 	phys_addr_t tlb_addr;
+	unsigned long offset = 0;
+
+	if (attrs & DMA_ATTR_BOUNCE_PAGE) {
+		unsigned long pgsize = get_iommu_pgsize(hwdev, orig_addr, size);
+
+		offset = orig_addr & (pgsize - 1);
+
+		/* Don't allow the buffer to cross page boundary. */
+		if (offset + size > pgsize)
+			return DMA_MAPPING_ERROR;
+
+		tlb_addr = swiotlb_tbl_alloc_tlb(hwdev,
+				__phys_to_dma(hwdev, io_tlb_start),
+				ALIGN_DOWN(orig_addr, pgsize), pgsize);
+	} else {
+		tlb_addr = swiotlb_tbl_alloc_tlb(hwdev,
+				tbl_dma_addr, orig_addr, size);
+	}
 
-	tlb_addr = swiotlb_tbl_alloc_tlb(hwdev, tbl_dma_addr, orig_addr, size);
 	if (tlb_addr == DMA_MAPPING_ERROR) {
 		if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 			dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes)\n",
 				 size);
-	} else if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
-		   (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL)) {
-		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_TO_DEVICE);
+		return DMA_MAPPING_ERROR;
 	}
 
+	tlb_addr += offset;
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
+		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_TO_DEVICE);
+
 	return tlb_addr;
 }
 
@@ -626,6 +655,10 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 {
 	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = io_tlb_orig_addr[index];
+	unsigned long offset = 0;
+
+	if (attrs & DMA_ATTR_BOUNCE_PAGE)
+		offset = tlb_addr & ((1 << IO_TLB_SHIFT) - 1);
 
 	/*
 	 * First, sync the memory before unmapping the entry
@@ -633,9 +666,17 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 	if (orig_addr != INVALID_PHYS_ADDR &&
 	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
-		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_FROM_DEVICE);
+		swiotlb_bounce(orig_addr + offset,
+			       tlb_addr, size, DMA_FROM_DEVICE);
+
+	if (attrs & DMA_ATTR_BOUNCE_PAGE) {
+		unsigned long pgsize = get_iommu_pgsize(hwdev, tlb_addr, size);
 
-	swiotlb_tbl_free_tlb(hwdev, tlb_addr, size);
+		swiotlb_tbl_free_tlb(hwdev,
+				     ALIGN_DOWN(tlb_addr, pgsize), pgsize);
+	} else {
+		swiotlb_tbl_free_tlb(hwdev, tlb_addr, size);
+	}
 }
 
 void swiotlb_tbl_sync_single(struct device *hwdev, phys_addr_t tlb_addr,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
