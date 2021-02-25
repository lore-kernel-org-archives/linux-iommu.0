Return-Path: <SRS0=d1gY=H3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D8AC433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 06:23:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5EF64EBD
	for <iommu@archiver.kernel.org>; Thu, 25 Feb 2021 06:23:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5EF64EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A82D24ED63;
	Thu, 25 Feb 2021 06:23:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d0QsnBCMVHBp; Thu, 25 Feb 2021 06:23:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 674B94ED60;
	Thu, 25 Feb 2021 06:23:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33468C000B;
	Thu, 25 Feb 2021 06:23:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69C8CC0001
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 06:23:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 514596F6DC
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 06:23:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7g0foYd9qmfX for <iommu@lists.linux-foundation.org>;
 Thu, 25 Feb 2021 06:23:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9441560754
 for <iommu@lists.linux-foundation.org>; Thu, 25 Feb 2021 06:23:53 +0000 (UTC)
IronPort-SDR: AQMbn5lrcxDfr2FtzWf0KAyQL6wzpt3xEw03xI8LBD8RFqXPYs95DcgN4q/ZdCGw1HEPbcFIRL
 x4WeNzC5ASRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="185537577"
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; d="scan'208";a="185537577"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2021 22:23:52 -0800
IronPort-SDR: MMjmLK3QQqS05RHZUjV4/VLMAf3Nz7v/F6myV0KgGZGsLZeK76vcucy6yWy4fe+Bknn1oNBT/V
 5KB5rdLM/QZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,205,1610438400"; d="scan'208";a="499960144"
Received: from allen-box.sh.intel.com ([10.239.159.128])
 by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2021 22:23:50 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/1] iommu: Don't use lazy flush for untrusted device
Date: Thu, 25 Feb 2021 14:14:54 +0800
Message-Id: <20210225061454.2864009-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

The lazy IOTLB flushing setup leaves a time window, in which the device
can still access some system memory, which has already been unmapped by
the device driver. It's not suitable for untrusted devices. A malicious
device might use this to attack the system by obtaining data that it
shouldn't obtain.

Fixes: c588072bba6b5 ("iommu/vt-d: Convert intel iommu driver to the iommu ops")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/dma-iommu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f659395e7959..65234e383d6b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -311,6 +311,11 @@ static void iommu_dma_flush_iotlb_all(struct iova_domain *iovad)
 	domain->ops->flush_iotlb_all(domain);
 }
 
+static bool dev_is_untrusted(struct device *dev)
+{
+	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
+}
+
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
@@ -365,8 +370,9 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 
 	init_iova_domain(iovad, 1UL << order, base_pfn);
 
-	if (!cookie->fq_domain && !iommu_domain_get_attr(domain,
-			DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE, &attr) && attr) {
+	if (!cookie->fq_domain && (!dev || !dev_is_untrusted(dev)) &&
+	    !iommu_domain_get_attr(domain, DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE, &attr) &&
+	    attr) {
 		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
 					  iommu_dma_entry_dtor))
 			pr_warn("iova flush queue initialization failed\n");
@@ -508,11 +514,6 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
 				iova_align(iovad, size), dir, attrs);
 }
 
-static bool dev_is_untrusted(struct device *dev)
-{
-	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
-}
-
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		size_t size, int prot, u64 dma_mask)
 {
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
