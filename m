Return-Path: <SRS0=vdHR=V5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB6BC433FF
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 06:21:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F6B620644
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 06:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6B620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CFD1DEE4;
	Thu,  1 Aug 2019 06:21:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1A4968953
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 06:02:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A4CB3821
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 06:02:58 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	31 Jul 2019 23:02:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,333,1559545200"; d="scan'208";a="184119261"
Received: from allen-box.sh.intel.com ([10.239.159.136])
	by orsmga002.jf.intel.com with ESMTP; 31 Jul 2019 23:02:56 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 2/3] iommu/vt-d: Apply per-device dma_ops
Date: Thu,  1 Aug 2019 14:01:55 +0800
Message-Id: <20190801060156.8564-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801060156.8564-1-baolu.lu@linux.intel.com>
References: <20190801060156.8564-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

Current Intel IOMMU driver sets the system level dma_ops. This
implementation has at least the following drawbacks: 1) each
dma API will go through the IOMMU driver even the devices are
using identity mapped domains; 2) if user requests to use an
identity mapped domain (a.k.a. bypass iommu translation), the
driver might fall back to dma domain blindly if the device is
not able to address all system memory.

This sets per-device dma_ops if a device is using a dma domain.
Otherwise, use the default system level dma_ops for direct dma.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 48 ++++++++-----------------------------
 1 file changed, 10 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d2ac89a2026e..609b539b93f6 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3431,43 +3431,10 @@ static struct dmar_domain *get_private_domain_for_dev(struct device *dev)
 /* Check if the dev needs to go through non-identity map and unmap process.*/
 static bool iommu_need_mapping(struct device *dev)
 {
-	int ret;
-
 	if (iommu_dummy(dev))
 		return false;
 
-	ret = identity_mapping(dev);
-	if (ret) {
-		u64 dma_mask = *dev->dma_mask;
-
-		if (dev->coherent_dma_mask && dev->coherent_dma_mask < dma_mask)
-			dma_mask = dev->coherent_dma_mask;
-
-		if (dma_mask >= dma_get_required_mask(dev))
-			return false;
-
-		/*
-		 * 32 bit DMA is removed from si_domain and fall back to
-		 * non-identity mapping.
-		 */
-		dmar_remove_one_dev_info(dev);
-		ret = iommu_request_dma_domain_for_dev(dev);
-		if (ret) {
-			struct iommu_domain *domain;
-			struct dmar_domain *dmar_domain;
-
-			domain = iommu_get_domain_for_dev(dev);
-			if (domain) {
-				dmar_domain = to_dmar_domain(domain);
-				dmar_domain->flags |= DOMAIN_FLAG_LOSE_CHILDREN;
-			}
-			get_private_domain_for_dev(dev);
-		}
-
-		dev_info(dev, "32bit DMA uses non-identity mapping\n");
-	}
-
-	return true;
+	return !identity_mapping(dev);
 }
 
 static dma_addr_t __intel_map_single(struct device *dev, phys_addr_t paddr,
@@ -4895,8 +4862,6 @@ int __init intel_iommu_init(void)
 	}
 	up_write(&dmar_global_lock);
 
-	dma_ops = &intel_dma_ops;
-
 	init_iommu_pm_ops();
 
 	for_each_active_iommu(iommu, drhd) {
@@ -5487,8 +5452,13 @@ static int intel_iommu_add_device(struct device *dev)
 		}
 	}
 
-	if (device_needs_bounce(dev))
-		set_dma_ops(dev, &bounce_dma_ops);
+	dmar_domain = find_domain(dev);
+	if (dmar_domain && !domain_type_is_si(dmar_domain)) {
+		if (device_needs_bounce(dev))
+			set_dma_ops(dev, &bounce_dma_ops);
+		else
+			set_dma_ops(dev, &intel_dma_ops);
+	}
 
 	return 0;
 }
@@ -5507,6 +5477,8 @@ static void intel_iommu_remove_device(struct device *dev)
 	iommu_group_remove_device(dev);
 
 	iommu_device_unlink(&iommu->iommu, dev);
+
+	set_dma_ops(dev, NULL);
 }
 
 static void intel_iommu_get_resv_regions(struct device *device,
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
