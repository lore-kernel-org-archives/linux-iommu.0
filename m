Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02A7C4332F
	for <iommu@archiver.kernel.org>; Sat,  9 Apr 2022 13:32:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 339B441DF5;
	Sat,  9 Apr 2022 13:32:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eZiXBrIQk5AF; Sat,  9 Apr 2022 13:32:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9F66141BA4;
	Sat,  9 Apr 2022 13:32:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B90AC0084;
	Sat,  9 Apr 2022 13:32:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7F8FC002C
 for <iommu@lists.linux-foundation.org>; Sat,  9 Apr 2022 13:32:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB52B843AC
 for <iommu@lists.linux-foundation.org>; Sat,  9 Apr 2022 13:32:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uWZbMB2Y75TX for <iommu@lists.linux-foundation.org>;
 Sat,  9 Apr 2022 13:32:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 178828439A
 for <iommu@lists.linux-foundation.org>; Sat,  9 Apr 2022 13:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649511156; x=1681047156;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=60z86IsfKNedOIQbPNYiwb7F+FTL02AF8htmqN73hc0=;
 b=F/EYJMdzkr0XThr3GETuOn6auFi2PBIEqm6NRgZ2A/3STiz+Ia/AxWYD
 wJmRhN6CHGzsA+KFRkKNx8eaZk68OzBNMK2hU7SD4d92M+kqt1juEtuW3
 PLv3UKUDuxFbiMeGFERY2cvLKddbJ7RhknuRL2GQV/20BwCucgmGKuRxX
 SQ7XqwefI8qJtjNy0Hx84+ekxf31QiRakl+suKNjMP6NWNyefWLjvttsF
 aHPFumxk4yLb1e+Fk/7sO3Z1pI9q5laRflPEkGaDZrT+9ajPekYS7yZlo
 jN5Mst0cMsm7Bv9ggiryU29Hdadkpf8TGlT4r9yZ46laq+Ln3z6Mhygtl g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="261982412"
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; d="scan'208";a="261982412"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2022 06:32:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; d="scan'208";a="610239138"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga008.fm.intel.com with ESMTP; 09 Apr 2022 06:32:32 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 1/1] iommu/vt-d: Change return type of
 dmar_insert_one_dev_info()
Date: Sat,  9 Apr 2022 21:30:06 +0800
Message-Id: <20220409133006.3953129-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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
 drivers/iommu/intel/iommu.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index d24e6da33a60..5682f3de205d 100644
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
+		return -ENODEV;
 	}
 	list_add(&info->link, &domain->devices);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
@@ -2501,7 +2500,7 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		if (ret) {
 			dev_err(dev, "PASID table allocation failed\n");
 			dmar_remove_one_dev_info(dev);
-			return NULL;
+			return -ENOMEM;
 		}
 
 		/* Setup the PASID entry for requests without PASID: */
@@ -2519,17 +2518,17 @@ static struct dmar_domain *dmar_insert_one_dev_info(struct intel_iommu *iommu,
 		if (ret) {
 			dev_err(dev, "Setup RID2PASID failed\n");
 			dmar_remove_one_dev_info(dev);
-			return NULL;
+			return -ENODEV;
 		}
 	}
 
 	if (domain_context_mapping(domain, dev)) {
 		dev_err(dev, "Domain context map failed\n");
 		dmar_remove_one_dev_info(dev);
-		return NULL;
+		return -ENODEV;
 	}
 
-	return domain;
+	return 0;
 }
 
 static int iommu_domain_identity_map(struct dmar_domain *domain,
@@ -2607,7 +2606,6 @@ static int __init si_domain_init(int hw)
 
 static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 {
-	struct dmar_domain *ndomain;
 	struct intel_iommu *iommu;
 	u8 bus, devfn;
 
@@ -2615,11 +2613,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
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
