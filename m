Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF54CC433F5
	for <iommu@archiver.kernel.org>; Sat, 16 Apr 2022 12:07:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5B10241A1B;
	Sat, 16 Apr 2022 12:07:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GeqGnkiih_nH; Sat, 16 Apr 2022 12:07:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0660D41864;
	Sat, 16 Apr 2022 12:07:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD807C0033;
	Sat, 16 Apr 2022 12:07:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 952CDC002C
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 12:07:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 810E340002
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 12:06:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OifPXr31e0Cn for <iommu@lists.linux-foundation.org>;
 Sat, 16 Apr 2022 12:06:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD8D6409A5
 for <iommu@lists.linux-foundation.org>; Sat, 16 Apr 2022 12:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650110818; x=1681646818;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zZEekOCvmqUuQ4X15MOWFS0pi7DbdrUqVzVf5lho4Kk=;
 b=GHyhn4AA+U9ZaZTf55XTivNMB8I/3I0ClZAtKKeFn1PthW5ToXsKDtxv
 NHZO6gI6xBNHA3yKguJHEXt4l5L7bxCrMetOkxSY14p9o9M4aaa42ywvs
 9g9Hj1LA5+8o9Db+dt1iwv6hEMXHNFGU9yPXKHdB82dOFWd9w0sblplQ5
 KKnAHppCk2sBAtfecVsdYxyCr+GAJpDX6Y3uUylv8L2+Dhr8ekhClHio6
 8CGm0+i1v+Ef8jJ9/kI7lBsZi7LxQlYG/DR67JxYsqUIw0xCsn6ClzTqD
 TTTwCvJ8FMtpCSbOZwK0i8mWZblmW0fXCP+vXf85CTRABuX10IVBLGniA w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="243219642"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; d="scan'208";a="243219642"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2022 05:06:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; d="scan'208";a="701329057"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2022 05:06:57 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH v2 1/2] iommu/vt-d: Change return type of
 dmar_insert_one_dev_info()
Date: Sat, 16 Apr 2022 20:04:22 +0800
Message-Id: <20220416120423.879552-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220416120423.879552-1-baolu.lu@linux.intel.com>
References: <20220416120423.879552-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
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

The dmar_insert_one_dev_info() returns the pass-in domain on success and
NULL on failure. This doesn't make much sense. Change it to an integer.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d24e6da33a60..ae0301e3ce53 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2474,10 +2474,9 @@ static bool dev_is_real_dma_subdevice(struct device *dev)
 	       pci_real_dma_dev(to_pci_dev(dev)) != to_pci_dev(dev);
 }
 
-static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
-						    int bus, int devfn,
-						    struct device *dev,
-						    struct dmar_domain *domain)
+static int dmar_insert_one_dev_info(struct intel_iommu *iommu, int bus,
+				    int devfn, struct device *dev,
+				    struct dmar_domain *domain)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	unsigned long flags;
@@ -2490,7 +2489,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 	spin_unlock(&iommu->lock);
 	if (ret) {
 		spin_unlock_irqrestore(&device_domain_lock, flags);
-		return NULL;
+		return ret;
 	}
 	list_add(&info->link, &domain->devices);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
@@ -2501,7 +2500,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		if (ret) {
 			dev_err(dev, "PASID table allocation failed\n");
 			dmar_remove_one_dev_info(dev);
-			return NULL;
+			return ret;
 		}
 
 		/* Setup the PASID entry for requests without PASID: */
@@ -2519,17 +2518,18 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		if (ret) {
 			dev_err(dev, "Setup RID2PASID failed\n");
 			dmar_remove_one_dev_info(dev);
-			return NULL;
+			return ret;
 		}
 	}
 
-	if (domain_context_mapping(domain, dev)) {
+	ret = domain_context_mapping(domain, dev);
+	if (ret) {
 		dev_err(dev, "Domain context map failed\n");
 		dmar_remove_one_dev_info(dev);
-		return NULL;
+		return ret;
 	}
 
-	return domain;
+	return 0;
 }
 
 static int iommu_domain_identity_map(struct dmar_domain *domain,
@@ -2607,7 +2607,6 @@ static int __init si_domain_init(int hw)
 
 static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 {
-	struct dmar_domain *ndomain;
 	struct intel_iommu *iommu;
 	u8 bus, devfn;
 
@@ -2615,11 +2614,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 	if (!iommu)
 		return -ENODEV;
 
-	ndomain = dmar_insert_one_dev_info(iommu, bus, devfn, dev, domain);
-	if (ndomain != domain)
-		return -EBUSY;
-
-	return 0;
+	return dmar_insert_one_dev_info(iommu, bus, devfn, dev, domain);
 }
 
 static bool device_has_rmrr(struct device *dev)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
