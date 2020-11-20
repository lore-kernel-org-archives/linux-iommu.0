Return-Path: <SRS0=3eTK=E2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C38C5519F
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 10:24:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FE2022210
	for <iommu@archiver.kernel.org>; Fri, 20 Nov 2020 10:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE2022210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E4F9B870E1;
	Fri, 20 Nov 2020 10:24:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WKsqV8Cw1Yfg; Fri, 20 Nov 2020 10:24:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 35130870C1;
	Fri, 20 Nov 2020 10:24:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21C99C163C;
	Fri, 20 Nov 2020 10:24:52 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA600C0891
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 10:24:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 35B2F2E0D9
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 10:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KET82z26npWz for <iommu@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 10:24:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 5CC662DEC9
 for <iommu@lists.linux-foundation.org>; Fri, 20 Nov 2020 10:24:48 +0000 (UTC)
IronPort-SDR: TqlfoQyOcpKlqy4UNNXdGSRXeac6vAdJnTWf8KyiW5dqiIXYP+xkrzKKPEotDOf0Ut6f7Caq+z
 1Ie6iPlP311Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9810"; a="189551173"
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; d="scan'208";a="189551173"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2020 02:24:48 -0800
IronPort-SDR: hkFr70+3TX87oB7b/fFTDQk134RWKwQvNH919Dvq0vJGEUs94vx+GrNQyxq+xUEoKHQDhGa6FJ
 dl81uiEdhqFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,356,1599548400"; d="scan'208";a="545393674"
Received: from allen-box.sh.intel.com ([10.239.159.28])
 by orsmga005.jf.intel.com with ESMTP; 20 Nov 2020 02:24:45 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Tom Murphy <murphyt7@tcd.ie>, David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v5 3/7] iommu: Allow the dma-iommu api to use bounce buffers
Date: Fri, 20 Nov 2020 18:17:15 +0800
Message-Id: <20201120101719.3172693-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120101719.3172693-1-baolu.lu@linux.intel.com>
References: <20201120101719.3172693-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Logan Gunthorpe <logang@deltatee.com>
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

From: Tom Murphy <murphyt7@tcd.ie>

Allow the dma-iommu api to use bounce buffers for untrusted devices.
This is a copy of the intel bounce buffer code.

Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/iommu/dma-iommu.c | 163 +++++++++++++++++++++++++++++++++++---
 1 file changed, 150 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index de521e22bafb..10dafbc3d9e0 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -20,9 +20,11 @@
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/swiotlb.h>
 #include <linux/scatterlist.h>
 #include <linux/vmalloc.h>
 #include <linux/crash_dump.h>
+#include <linux/dma-direct.h>
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -499,6 +501,31 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 	iommu_dma_free_iova(cookie, dma_addr, size, iotlb_gather.freelist);
 }
 
+static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
+		size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	phys_addr_t phys;
+
+	phys = iommu_iova_to_phys(domain, dma_addr);
+	if (WARN_ON(!phys))
+		return;
+
+	__iommu_dma_unmap(dev, dma_addr, size);
+
+	if (unlikely(is_swiotlb_buffer(phys)))
+		swiotlb_tbl_unmap_single(dev, phys, size,
+				iova_align(iovad, size), dir, attrs);
+}
+
+static bool dev_is_untrusted(struct device *dev)
+{
+	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
+}
+
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		size_t size, int prot, u64 dma_mask)
 {
@@ -524,6 +551,55 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 	return iova + iova_off;
 }
 
+static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
+		size_t org_size, dma_addr_t dma_mask, bool coherent,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	int prot = dma_info_to_prot(dir, coherent, attrs);
+	struct iommu_domain *domain = iommu_get_dma_domain(dev);
+	struct iommu_dma_cookie *cookie = domain->iova_cookie;
+	struct iova_domain *iovad = &cookie->iovad;
+	size_t aligned_size = org_size;
+	void *padding_start;
+	size_t padding_size;
+	dma_addr_t iova;
+
+	/*
+	 * If both the physical buffer start address and size are
+	 * page aligned, we don't need to use a bounce page.
+	 */
+	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
+	    iova_offset(iovad, phys | org_size)) {
+		aligned_size = iova_align(iovad, org_size);
+		phys = swiotlb_tbl_map_single(dev,
+				phys_to_dma(dev, io_tlb_start),
+				phys, org_size, aligned_size, dir, attrs);
+
+		if (phys == DMA_MAPPING_ERROR)
+			return DMA_MAPPING_ERROR;
+
+		/* Cleanup the padding area. */
+		padding_start = phys_to_virt(phys);
+		padding_size = aligned_size;
+
+		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+		    (dir == DMA_TO_DEVICE ||
+		     dir == DMA_BIDIRECTIONAL)) {
+			padding_start += org_size;
+			padding_size -= org_size;
+		}
+
+		memset(padding_start, 0, padding_size);
+	}
+
+	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
+	if ((iova == DMA_MAPPING_ERROR) && is_swiotlb_buffer(phys))
+		swiotlb_tbl_unmap_single(dev, phys, org_size,
+				aligned_size, dir, attrs);
+
+	return iova;
+}
+
 static void __iommu_dma_free_pages(struct page **pages, int count)
 {
 	while (count--)
@@ -697,11 +773,15 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev))
+	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
-	arch_sync_dma_for_cpu(phys, size, dir);
+	if (!dev_is_dma_coherent(dev))
+		arch_sync_dma_for_cpu(phys, size, dir);
+
+	if (is_swiotlb_buffer(phys))
+		swiotlb_tbl_sync_single(dev, phys, size, dir, SYNC_FOR_CPU);
 }
 
 static void iommu_dma_sync_single_for_device(struct device *dev,
@@ -709,11 +789,15 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
 {
 	phys_addr_t phys;
 
-	if (dev_is_dma_coherent(dev))
+	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
 		return;
 
 	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
-	arch_sync_dma_for_device(phys, size, dir);
+	if (is_swiotlb_buffer(phys))
+		swiotlb_tbl_sync_single(dev, phys, size, dir, SYNC_FOR_DEVICE);
+
+	if (!dev_is_dma_coherent(dev))
+		arch_sync_dma_for_device(phys, size, dir);
 }
 
 static void iommu_dma_sync_sg_for_cpu(struct device *dev,
@@ -723,11 +807,17 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_dma_coherent(dev))
+	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
 		return;
 
-	for_each_sg(sgl, sg, nelems, i)
-		arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
+	for_each_sg(sgl, sg, nelems, i) {
+		if (!dev_is_dma_coherent(dev))
+			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
+
+		if (is_swiotlb_buffer(sg_phys(sg)))
+			swiotlb_tbl_sync_single(dev, sg_phys(sg), sg->length,
+						dir, SYNC_FOR_CPU);
+	}
 }
 
 static void iommu_dma_sync_sg_for_device(struct device *dev,
@@ -737,11 +827,17 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
 	struct scatterlist *sg;
 	int i;
 
-	if (dev_is_dma_coherent(dev))
+	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
 		return;
 
-	for_each_sg(sgl, sg, nelems, i)
-		arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
+	for_each_sg(sgl, sg, nelems, i) {
+		if (is_swiotlb_buffer(sg_phys(sg)))
+			swiotlb_tbl_sync_single(dev, sg_phys(sg), sg->length,
+						dir, SYNC_FOR_DEVICE);
+
+		if (!dev_is_dma_coherent(dev))
+			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
+	}
 }
 
 static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
@@ -750,10 +846,10 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 {
 	phys_addr_t phys = page_to_phys(page) + offset;
 	bool coherent = dev_is_dma_coherent(dev);
-	int prot = dma_info_to_prot(dir, coherent, attrs);
 	dma_addr_t dma_handle;
 
-	dma_handle = __iommu_dma_map(dev, phys, size, prot, dma_get_mask(dev));
+	dma_handle = __iommu_dma_map_swiotlb(dev, phys, size, dma_get_mask(dev),
+			coherent, dir, attrs);
 	if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
 	    dma_handle != DMA_MAPPING_ERROR)
 		arch_sync_dma_for_device(phys, size, dir);
@@ -765,7 +861,7 @@ static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
 {
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
-	__iommu_dma_unmap(dev, dma_handle, size);
+	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);
 }
 
 /*
@@ -843,6 +939,39 @@ static void __invalidate_sg(struct scatterlist *sg, int nents)
 	}
 }
 
+static void iommu_dma_unmap_sg_swiotlb(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	struct scatterlist *s;
+	int i;
+
+	for_each_sg(sg, s, nents, i)
+		__iommu_dma_unmap_swiotlb(dev, sg_dma_address(s),
+				sg_dma_len(s), dir, attrs);
+}
+
+static int iommu_dma_map_sg_swiotlb(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
+{
+	struct scatterlist *s;
+	int i;
+
+	for_each_sg(sg, s, nents, i) {
+		sg_dma_address(s) = __iommu_dma_map_swiotlb(dev, sg_phys(s),
+				s->length, dma_get_mask(dev),
+				dev_is_dma_coherent(dev), dir, attrs);
+		if (sg_dma_address(s) == DMA_MAPPING_ERROR)
+			goto out_unmap;
+		sg_dma_len(s) = s->length;
+	}
+
+	return nents;
+
+out_unmap:
+	iommu_dma_unmap_sg_swiotlb(dev, sg, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
+	return 0;
+}
+
 /*
  * The DMA API client is passing in a scatterlist which could describe
  * any old buffer layout, but the IOMMU API requires everything to be
@@ -869,6 +998,9 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
 
+	if (dev_is_untrusted(dev))
+		return iommu_dma_map_sg_swiotlb(dev, sg, nents, dir, attrs);
+
 	/*
 	 * Work out how much IOVA space we need, and align the segments to
 	 * IOVA granules for the IOMMU driver to handle. With some clever
@@ -938,6 +1070,11 @@ static void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		iommu_dma_sync_sg_for_cpu(dev, sg, nents, dir);
 
+	if (dev_is_untrusted(dev)) {
+		iommu_dma_unmap_sg_swiotlb(dev, sg, nents, dir, attrs);
+		return;
+	}
+
 	/*
 	 * The scatterlist segments are mapped into a single
 	 * contiguous IOVA allocation, so this is incredibly easy.
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
