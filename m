Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E459C2BA2B
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 06:27:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B34B2078A
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 06:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B34B2078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 33EB08598B;
	Thu, 16 Apr 2020 06:27:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p65VAqDHcwVr; Thu, 16 Apr 2020 06:27:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5C2E685960;
	Thu, 16 Apr 2020 06:27:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49D9DC1AE8;
	Thu, 16 Apr 2020 06:27:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CC6CC0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 06:27:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 39E9621543
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 06:27:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qKcAInR8d9Wh for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 06:27:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id 071B821563
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 06:27:15 +0000 (UTC)
IronPort-SDR: UQvR0H14DulJ1qe3WLot1N8XmmXEVZ35X6WNjS/9f9DoZI9W/chr1Yp/brEDGCNptwJF8w2u8I
 xl0w1c7OaW7Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 23:27:15 -0700
IronPort-SDR: Nfwh5Z+btCAjT8POt3Hkqkuk7HkG8iRCyKfoQcPWnjFj85sJp86zrj0CE+VRJ3VYbqZ5g8WeTz
 3rf6zXM7zaAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; d="scan'208";a="277881105"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 15 Apr 2020 23:27:12 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v3 3/3] iommu/vt-d: Apply per-device dma_ops
Date: Thu, 16 Apr 2020 14:23:54 +0800
Message-Id: <20200416062354.10307-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416062354.10307-1-baolu.lu@linux.intel.com>
References: <20200416062354.10307-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 Daniel Drake <drake@endlessm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Derrick Jonathan <jonathan.derrick@intel.com>
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

Current Intel IOMMU driver sets the system level dma_ops. This
causes each dma API to go through the IOMMU driver even the
devices are using identity mapped domains. This sets per-device
dma_ops only if a device is using a DMA domain. Otherwise, use
the default system level dma_ops for direct dma.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 82 ++++++++++++-------------------------
 1 file changed, 26 insertions(+), 56 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index f556fd89c7d2..ac6f94573d1f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -2720,17 +2720,6 @@ static int __init si_domain_init(int hw)
 	return 0;
 }
 
-static int identity_mapping(struct device *dev)
-{
-	struct device_domain_info *info;
-
-	info = dev->archdata.iommu;
-	if (info)
-		return (info->domain == si_domain);
-
-	return 0;
-}
-
 static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 {
 	struct dmar_domain *ndomain;
@@ -3315,18 +3304,6 @@ static unsigned long intel_alloc_iova(struct device *dev,
 	return iova_pfn;
 }
 
-/* Check if the dev needs to go through non-identity map and unmap process.*/
-static bool iommu_need_mapping(struct device *dev)
-{
-	if (iommu_dummy(dev))
-		return false;
-
-	if (unlikely(attach_deferred(dev)))
-		do_deferred_attach(dev);
-
-	return !identity_mapping(dev);
-}
-
 static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 				     size_t size, int dir, u64 dma_mask)
 {
@@ -3340,6 +3317,9 @@ static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
 
 	BUG_ON(dir == DMA_NONE);
 
+	if (unlikely(attach_deferred(dev)))
+		do_deferred_attach(dev);
+
 	domain = find_domain(dev);
 	if (!domain)
 		return DMA_MAPPING_ERROR;
@@ -3391,20 +3371,15 @@ static dma_addr_t intel_map_page(struct device *dev, struct page *page,
 				 enum dma_data_direction dir,
 				 unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
-		return __intel_map_single(dev, page_to_phys(page) + offset,
-				size, dir, *dev->dma_mask);
-	return dma_direct_map_page(dev, page, offset, size, dir, attrs);
+	return __intel_map_single(dev, page_to_phys(page) + offset,
+				  size, dir, *dev->dma_mask);
 }
 
 static dma_addr_t intel_map_resource(struct device *dev, phys_addr_t phys_addr,
 				     size_t size, enum dma_data_direction dir,
 				     unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
-		return __intel_map_single(dev, phys_addr, size, dir,
-				*dev->dma_mask);
-	return dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
+	return __intel_map_single(dev, phys_addr, size, dir, *dev->dma_mask);
 }
 
 static void intel_unmap(struct device *dev, dma_addr_t dev_addr, size_t size)
@@ -3455,17 +3430,13 @@ static void intel_unmap_page(struct device *dev, dma_addr_t dev_addr,
 			     size_t size, enum dma_data_direction dir,
 			     unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
-		intel_unmap(dev, dev_addr, size);
-	else
-		dma_direct_unmap_page(dev, dev_addr, size, dir, attrs);
+	intel_unmap(dev, dev_addr, size);
 }
 
 static void intel_unmap_resource(struct device *dev, dma_addr_t dev_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	if (iommu_need_mapping(dev))
-		intel_unmap(dev, dev_addr, size);
+	intel_unmap(dev, dev_addr, size);
 }
 
 static void *intel_alloc_coherent(struct device *dev, size_t size,
@@ -3475,8 +3446,8 @@ static void *intel_alloc_coherent(struct device *dev, size_t size,
 	struct page *page = NULL;
 	int order;
 
-	if (!iommu_need_mapping(dev))
-		return dma_direct_alloc(dev, size, dma_handle, flags, attrs);
+	if (unlikely(attach_deferred(dev)))
+		do_deferred_attach(dev);
 
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
@@ -3511,9 +3482,6 @@ static void intel_free_coherent(struct device *dev, size_t size, void *vaddr,
 	int order;
 	struct page *page = virt_to_page(vaddr);
 
-	if (!iommu_need_mapping(dev))
-		return dma_direct_free(dev, size, vaddr, dma_handle, attrs);
-
 	size = PAGE_ALIGN(size);
 	order = get_order(size);
 
@@ -3531,9 +3499,6 @@ static void intel_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	struct scatterlist *sg;
 	int i;
 
-	if (!iommu_need_mapping(dev))
-		return dma_direct_unmap_sg(dev, sglist, nelems, dir, attrs);
-
 	for_each_sg(sglist, sg, nelems, i) {
 		nrpages += aligned_nrpages(sg_dma_address(sg), sg_dma_len(sg));
 	}
@@ -3557,8 +3522,9 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 	struct intel_iommu *iommu;
 
 	BUG_ON(dir == DMA_NONE);
-	if (!iommu_need_mapping(dev))
-		return dma_direct_map_sg(dev, sglist, nelems, dir, attrs);
+
+	if (unlikely(attach_deferred(dev)))
+		do_deferred_attach(dev);
 
 	domain = find_domain(dev);
 	if (!domain)
@@ -3605,8 +3571,6 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
 
 static u64 intel_get_required_mask(struct device *dev)
 {
-	if (!iommu_need_mapping(dev))
-		return dma_direct_get_required_mask(dev);
 	return DMA_BIT_MASK(32);
 }
 
@@ -4888,8 +4852,6 @@ int __init intel_iommu_init(void)
 	}
 	up_write(&dmar_global_lock);
 
-	dma_ops = &intel_dma_ops;
-
 	init_iommu_pm_ops();
 
 	down_read(&dmar_global_lock);
@@ -5479,11 +5441,6 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	if (translation_pre_enabled(iommu))
 		dev->archdata.iommu = DEFER_DEVICE_DOMAIN_INFO;
 
-	if (device_needs_bounce(dev)) {
-		dev_info(dev, "Use Intel IOMMU bounce page dma_ops\n");
-		set_dma_ops(dev, &bounce_dma_ops);
-	}
-
 	return &iommu->iommu;
 }
 
@@ -5498,7 +5455,19 @@ static void intel_iommu_release_device(struct device *dev)
 
 	dmar_remove_one_dev_info(dev);
 
+	set_dma_ops(dev, NULL);
+}
+
+static void intel_iommu_probe_finalize(struct device *dev)
+{
+	struct iommu_domain *domain;
+
+	domain = iommu_get_domain_for_dev(dev);
 	if (device_needs_bounce(dev))
+		set_dma_ops(dev, &bounce_dma_ops);
+	else if (domain && domain->type == IOMMU_DOMAIN_DMA)
+		set_dma_ops(dev, &intel_dma_ops);
+	else
 		set_dma_ops(dev, NULL);
 }
 
@@ -5830,6 +5799,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.unmap			= intel_iommu_unmap,
 	.iova_to_phys		= intel_iommu_iova_to_phys,
 	.probe_device		= intel_iommu_probe_device,
+	.probe_finalize		= intel_iommu_probe_finalize,
 	.release_device		= intel_iommu_release_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
