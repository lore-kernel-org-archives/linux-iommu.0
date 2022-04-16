Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E07C433EF
	for <iommu@archiver.kernel.org>; Sat, 16 Apr 2022 12:07:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C64E960EB4;
	Sat, 16 Apr 2022 12:07:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qFaoAgV-a2bF; Sat, 16 Apr 2022 12:07:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8F3A460B6F;
	Sat, 16 Apr 2022 12:07:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15321C0086;
	Sat, 16 Apr 2022 12:07:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47000C002C
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 12:07:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2F9B340002
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 12:07:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OYsJJ11eFfm6 for <iommu@lists.linux-foundation.org>;
 Sat, 16 Apr 2022 12:07:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 84F2F409A5
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 12:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650110820; x=1681646820;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3EjpBpYj2BKhSoii581vA75Vap4xNT9OdKwXnWr/2vk=;
 b=Cx4Gg/XT91Gh0d544d4kQ/9R5K8WLlcnMr2ppUZVMe5B4jQZ9cjqeLOG
 9z5FSo3rPMXMQ0eIMVEiA+NRcJj1tf6peE3gDTDJTu6rquuuF8rUR5/vP
 vUi/OmQ4WeSLi7/lSSupVQL6nIDjD0gDmHQt/QhDyTlvWZncOiKhezbd9
 iZy06wK/wP6uZVfcrEZ9jGD6dv0YW3JUR6SN5z7j2VWwY8ZggbE/I5aoZ
 u5iZsIfgIIsw2DE7Z63NC4XITbJywMG7CMO8ohT/y0d1W8IJSSKa1WJad
 ne/gQ8rEuLBWZqVZ1FTDRSPTLVhl0VVeCH4GjoJwGUXouW8tYiUywI/gd Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="243219645"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; d="scan'208";a="243219645"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2022 05:07:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; d="scan'208";a="701329084"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2022 05:06:58 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 2/2] iommu/vt-d: Fold dmar_insert_one_dev_info() into its
 caller
Date: Sat, 16 Apr 2022 20:04:23 +0800
Message-Id: <20220416120423.879552-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416120423.879552-1-baolu.lu@linux.intel.com>
References: <20220416120423.879552-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
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
---
 drivers/iommu/intel/iommu.c | 110 +++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 59 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ae0301e3ce53..954c891ec01e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2474,64 +2474,6 @@ static bool dev_is_real_dma_subdevice(struct device *dev)
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
@@ -2607,14 +2549,64 @@ static int __init si_domain_init(int hw)
 
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
