Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7DBC433FE
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 02:37:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7112740224;
	Tue, 10 May 2022 02:37:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CM4oVH2-7rqm; Tue, 10 May 2022 02:37:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0F0D440221;
	Tue, 10 May 2022 02:37:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD721C0039;
	Tue, 10 May 2022 02:37:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72C63C002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:37:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 54595812E6
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:37:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NcfhMrAVsJRp for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 02:37:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66CE8812B2
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 02:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652150237; x=1683686237;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G8SAVnkB9Oc0egJ76tNEE5lHsWIKg6jQfTV+dY72GGI=;
 b=ZsrfweGqqCZBF4pvRfUMKkiMLZSjN9Lo33UJBQkcK0vVdREx9kz65BGu
 79hZKKZRRY5LR8fEzI79aroygS/r8m6q9mDHAd0kx3a8PPvuwoy9HECcU
 co4U3JXFerENJw4AyDFaQzwlx4Kfaom7B04RVgf7MgKK/a3pGHvOfaJGi
 kEQ4Z/P4SqW3PODVvcS9O7nbZPTVDDd2Yxj8T9rfeiJZA5/lDEekpicIg
 FFt7hceW9XlOosdUIK8w+y9e7IiUCwBEg5zyjvjHrfVTeLUoyCK9VyiWu
 sjUP57glDNOtIzzDA5mwsH4fFK0czZlSFBUV7fTl/EHEbkXiiR5LRTtE9 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="266825969"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="266825969"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 19:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; d="scan'208";a="519523443"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by orsmga003.jf.intel.com with ESMTP; 09 May 2022 19:37:14 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 3/8] iommu/vt-d: Fold dmar_insert_one_dev_info() into its
 caller
Date: Tue, 10 May 2022 10:34:02 +0800
Message-Id: <20220510023407.2759143-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510023407.2759143-1-baolu.lu@linux.intel.com>
References: <20220510023407.2759143-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@lst.de>
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

Fold dmar_insert_one_dev_info() into domain_add_dev_info() which is its
only caller.

No intentional functional impact.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20220416120423.879552-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 110 +++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 59 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a5ca2b536ea8..cf43e8f9091b 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2473,64 +2473,6 @@ static bool dev_is_real_dma_subdevice(struct device *dev)
 	       pci_real_dma_dev(to_pci_dev(dev)) != to_pci_dev(dev);
 }
 
-static int dmar_insert_one_dev_info(struct intel_iommu *iommu, int bus,
-				    int devfn, struct device *dev,
-				    struct dmar_domain *domain)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&device_domain_lock, flags);
-	info->domain = domain;
-	spin_lock(&iommu->lock);
-	ret = domain_attach_iommu(domain, iommu);
-	spin_unlock(&iommu->lock);
-	if (ret) {
-		spin_unlock_irqrestore(&device_domain_lock, flags);
-		return ret;
-	}
-	list_add(&info->link, &domain->devices);
-	spin_unlock_irqrestore(&device_domain_lock, flags);
-
-	/* PASID table is mandatory for a PCI device in scalable mode. */
-	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
-		ret = intel_pasid_alloc_table(dev);
-		if (ret) {
-			dev_err(dev, "PASID table allocation failed\n");
-			dmar_remove_one_dev_info(dev);
-			return ret;
-		}
-
-		/* Setup the PASID entry for requests without PASID: */
-		spin_lock_irqsave(&iommu->lock, flags);
-		if (hw_pass_through && domain_type_is_si(domain))
-			ret = intel_pasid_setup_pass_through(iommu, domain,
-					dev, PASID_RID2PASID);
-		else if (domain_use_first_level(domain))
-			ret = domain_setup_first_level(iommu, domain, dev,
-					PASID_RID2PASID);
-		else
-			ret = intel_pasid_setup_second_level(iommu, domain,
-					dev, PASID_RID2PASID);
-		spin_unlock_irqrestore(&iommu->lock, flags);
-		if (ret) {
-			dev_err(dev, "Setup RID2PASID failed\n");
-			dmar_remove_one_dev_info(dev);
-			return ret;
-		}
-	}
-
-	ret = domain_context_mapping(domain, dev);
-	if (ret) {
-		dev_err(dev, "Domain context map failed\n");
-		dmar_remove_one_dev_info(dev);
-		return ret;
-	}
-
-	return 0;
-}
-
 static int iommu_domain_identity_map(struct dmar_domain *domain,
 				     unsigned long first_vpfn,
 				     unsigned long last_vpfn)
@@ -2606,14 +2548,64 @@ static int __init si_domain_init(int hw)
 
 static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 {
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
+	unsigned long flags;
 	u8 bus, devfn;
+	int ret;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu)
 		return -ENODEV;
 
-	return dmar_insert_one_dev_info(iommu, bus, devfn, dev, domain);
+	spin_lock_irqsave(&device_domain_lock, flags);
+	info->domain = domain;
+	spin_lock(&iommu->lock);
+	ret = domain_attach_iommu(domain, iommu);
+	spin_unlock(&iommu->lock);
+	if (ret) {
+		spin_unlock_irqrestore(&device_domain_lock, flags);
+		return ret;
+	}
+	list_add(&info->link, &domain->devices);
+	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	/* PASID table is mandatory for a PCI device in scalable mode. */
+	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
+		ret = intel_pasid_alloc_table(dev);
+		if (ret) {
+			dev_err(dev, "PASID table allocation failed\n");
+			dmar_remove_one_dev_info(dev);
+			return ret;
+		}
+
+		/* Setup the PASID entry for requests without PASID: */
+		spin_lock_irqsave(&iommu->lock, flags);
+		if (hw_pass_through && domain_type_is_si(domain))
+			ret = intel_pasid_setup_pass_through(iommu, domain,
+					dev, PASID_RID2PASID);
+		else if (domain_use_first_level(domain))
+			ret = domain_setup_first_level(iommu, domain, dev,
+					PASID_RID2PASID);
+		else
+			ret = intel_pasid_setup_second_level(iommu, domain,
+					dev, PASID_RID2PASID);
+		spin_unlock_irqrestore(&iommu->lock, flags);
+		if (ret) {
+			dev_err(dev, "Setup RID2PASID failed\n");
+			dmar_remove_one_dev_info(dev);
+			return ret;
+		}
+	}
+
+	ret = domain_context_mapping(domain, dev);
+	if (ret) {
+		dev_err(dev, "Domain context map failed\n");
+		dmar_remove_one_dev_info(dev);
+		return ret;
+	}
+
+	return 0;
 }
 
 static bool device_has_rmrr(struct device *dev)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
