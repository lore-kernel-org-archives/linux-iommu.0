Return-Path: <SRS0=n9pq=UC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911C1C282DC
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 01:23:51 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 709EA27A32
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 01:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 709EA27A32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AE28CB5F;
	Mon,  3 Jun 2019 01:23:46 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DDB5B265
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 01:23:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 2D4B083A
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 01:23:45 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	02 Jun 2019 18:23:44 -0700
X-ExtLoop1: 1
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by FMSMGA003.fm.intel.com with ESMTP; 02 Jun 2019 18:23:41 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 2/9] swiotlb: Split size parameter to map/unmap APIs
Date: Mon,  3 Jun 2019 09:16:13 +0800
Message-Id: <20190603011620.31999-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190603011620.31999-1-baolu.lu@linux.intel.com>
References: <20190603011620.31999-1-baolu.lu@linux.intel.com>
Cc: Juergen Gross <jgross@suse.com>, kevin.tian@intel.com,
	Stefano Stabellini <sstabellini@kernel.org>, ashok.raj@intel.com,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	alan.cox@intel.com, Jonathan Corbet <corbet@lwn.net>,
	Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	pengfei.xu@intel.com, Ingo Molnar <mingo@redhat.com>,
	jacob.jun.pan@intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	mika.westerberg@linux.intel.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

This splits the size parameter to swiotlb_tbl_map_single() and
swiotlb_tbl_unmap_single() into an alloc_size and a mapping_size
parameter, where the latter one is rounded up to the iommu page
size.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/xen/swiotlb-xen.c |  8 ++++----
 include/linux/swiotlb.h   |  8 ++++++--
 kernel/dma/direct.c       |  2 +-
 kernel/dma/swiotlb.c      | 24 +++++++++++++-----------
 4 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 5dcb06fe9667..bb734f851d87 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -399,8 +399,8 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	 */
 	trace_swiotlb_bounced(dev, dev_addr, size, swiotlb_force);
 
-	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys, size, dir,
-				     attrs);
+	map = swiotlb_tbl_map_single(dev, start_dma_addr, phys,
+				     size, size, dir, attrs);
 	if (map == DMA_MAPPING_ERROR)
 		return DMA_MAPPING_ERROR;
 
@@ -410,7 +410,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
 	 * Ensure that the address returned is DMA'ble
 	 */
 	if (unlikely(!dma_capable(dev, dev_addr, size))) {
-		swiotlb_tbl_unmap_single(dev, map, size, dir,
+		swiotlb_tbl_unmap_single(dev, map, size, size, dir,
 				attrs | DMA_ATTR_SKIP_CPU_SYNC);
 		return DMA_MAPPING_ERROR;
 	}
@@ -446,7 +446,7 @@ static void xen_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
 
 	/* NOTE: We use dev_addr here, not paddr! */
 	if (is_xen_swiotlb_buffer(dev_addr))
-		swiotlb_tbl_unmap_single(hwdev, paddr, size, dir, attrs);
+		swiotlb_tbl_unmap_single(hwdev, paddr, size, size, dir, attrs);
 }
 
 static void xen_swiotlb_unmap_page(struct device *hwdev, dma_addr_t dev_addr,
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 361f62bb4a8e..cde3dc18e21a 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -46,13 +46,17 @@ enum dma_sync_target {
 
 extern phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 					  dma_addr_t tbl_dma_addr,
-					  phys_addr_t phys, size_t size,
+					  phys_addr_t phys,
+					  size_t mapping_size,
+					  size_t alloc_size,
 					  enum dma_data_direction dir,
 					  unsigned long attrs);
 
 extern void swiotlb_tbl_unmap_single(struct device *hwdev,
 				     phys_addr_t tlb_addr,
-				     size_t size, enum dma_data_direction dir,
+				     size_t mapping_size,
+				     size_t alloc_size,
+				     enum dma_data_direction dir,
 				     unsigned long attrs);
 
 extern void swiotlb_tbl_sync_single(struct device *hwdev,
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 2c2772e9702a..c892394bbe51 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -290,7 +290,7 @@ void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
 		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
 
 	if (unlikely(is_swiotlb_buffer(phys)))
-		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
+		swiotlb_tbl_unmap_single(dev, phys, size, size, dir, attrs);
 }
 EXPORT_SYMBOL(dma_direct_unmap_page);
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 13f0cb080a4d..f956f785645a 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -442,7 +442,9 @@ static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
 
 phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 				   dma_addr_t tbl_dma_addr,
-				   phys_addr_t orig_addr, size_t size,
+				   phys_addr_t orig_addr,
+				   size_t mapping_size,
+				   size_t alloc_size,
 				   enum dma_data_direction dir,
 				   unsigned long attrs)
 {
@@ -479,8 +481,8 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	 * For mappings greater than or equal to a page, we limit the stride
 	 * (and hence alignment) to a page size.
 	 */
-	nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
-	if (size >= PAGE_SIZE)
+	nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	if (alloc_size >= PAGE_SIZE)
 		stride = (1 << (PAGE_SHIFT - IO_TLB_SHIFT));
 	else
 		stride = 1;
@@ -545,7 +547,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 	spin_unlock_irqrestore(&io_tlb_lock, flags);
 	if (!(attrs & DMA_ATTR_NO_WARN) && printk_ratelimit())
 		dev_warn(hwdev, "swiotlb buffer is full (sz: %zd bytes), total %lu (slots), used %lu (slots)\n",
-			 size, io_tlb_nslabs, tmp_io_tlb_used);
+			 alloc_size, io_tlb_nslabs, tmp_io_tlb_used);
 	return DMA_MAPPING_ERROR;
 found:
 	io_tlb_used += nslots;
@@ -560,7 +562,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
 		io_tlb_orig_addr[index+i] = orig_addr + (i << IO_TLB_SHIFT);
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    (dir == DMA_TO_DEVICE || dir == DMA_BIDIRECTIONAL))
-		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_TO_DEVICE);
+		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_TO_DEVICE);
 
 	return tlb_addr;
 }
@@ -569,11 +571,11 @@ phys_addr_t swiotlb_tbl_map_single(struct device *hwdev,
  * tlb_addr is the physical address of the bounce buffer to unmap.
  */
 void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
-			      size_t size, enum dma_data_direction dir,
-			      unsigned long attrs)
+			      size_t mapping_size, size_t alloc_size,
+			      enum dma_data_direction dir, unsigned long attrs)
 {
 	unsigned long flags;
-	int i, count, nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
+	int i, count, nslots = ALIGN(alloc_size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
 	int index = (tlb_addr - io_tlb_start) >> IO_TLB_SHIFT;
 	phys_addr_t orig_addr = io_tlb_orig_addr[index];
 
@@ -583,7 +585,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
 	if (orig_addr != INVALID_PHYS_ADDR &&
 	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    ((dir == DMA_FROM_DEVICE) || (dir == DMA_BIDIRECTIONAL)))
-		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_FROM_DEVICE);
+		swiotlb_bounce(orig_addr, tlb_addr, mapping_size, DMA_FROM_DEVICE);
 
 	/*
 	 * Return the buffer to the free list by setting the corresponding
@@ -663,14 +665,14 @@ bool swiotlb_map(struct device *dev, phys_addr_t *phys, dma_addr_t *dma_addr,
 
 	/* Oh well, have to allocate and map a bounce buffer. */
 	*phys = swiotlb_tbl_map_single(dev, __phys_to_dma(dev, io_tlb_start),
-			*phys, size, dir, attrs);
+			*phys, size, size, dir, attrs);
 	if (*phys == DMA_MAPPING_ERROR)
 		return false;
 
 	/* Ensure that the address returned is DMA'ble */
 	*dma_addr = __phys_to_dma(dev, *phys);
 	if (unlikely(!dma_capable(dev, *dma_addr, size))) {
-		swiotlb_tbl_unmap_single(dev, *phys, size, dir,
+		swiotlb_tbl_unmap_single(dev, *phys, size, size, dir,
 			attrs | DMA_ATTR_SKIP_CPU_SYNC);
 		return false;
 	}
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
