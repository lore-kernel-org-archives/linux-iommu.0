Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1BBC43334
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 02:56:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B541F60BAA;
	Tue, 14 Jun 2022 02:56:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8gFo29vcN71h; Tue, 14 Jun 2022 02:56:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9675A60B00;
	Tue, 14 Jun 2022 02:56:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B3C8C0032;
	Tue, 14 Jun 2022 02:56:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5092AC002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 02:56:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E260417B3
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 02:56:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o-UKs7q9wVYp for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 02:56:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7E1C341608
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 02:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655175365; x=1686711365;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2OradfonvTzvQIlP/JG0I5HnkCgZvFw+PYBG+YT/4/4=;
 b=InqV3qALTLiefJqSDOcQI49QTVu7jGgbCBbmqFEmNUuFULdFNEC39YDc
 /PhkLIpCjWyg6Y7++KxPuVuuWGrJ5ewtgQzER7KkNTTZhuERC3VUo2CvN
 SBNs66+P8WaYHbE3LXHB2dreKxnhRvTDsac9Rp/mAlKc1MOlxdrNPmyIh
 a3D2L7N3dTREQ0LJEb+mgLoiPHtmTqJww2kn7wbVjQFiomECkVjK5A1Yi
 ONr2Hv6aIYYJhWIS9b9aJHYsCDaVsX93QVGcSPygaFgJ5Ic9uJqgGyAz7
 JgvZ6yUtEmnAeSThUCnG42x90KS8keCc2OdOw+J7aQFJDgxdE+WmhGIAP Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="303887145"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; d="scan'208";a="303887145"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 19:56:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; d="scan'208";a="588166694"
Received: from allen-box.sh.intel.com ([10.239.159.48])
 by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2022 19:56:02 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 10/12] iommu/vt-d: Fold __dmar_remove_one_dev_info() into
 its caller
Date: Tue, 14 Jun 2022 10:51:35 +0800
Message-Id: <20220614025137.1632762-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
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

Fold __dmar_remove_one_dev_info() into dmar_remove_one_dev_info() which
is its only caller. Make the spin lock critical range only cover the
device list change code and remove some unnecessary checks.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index af22690f44c8..8345e0c0824c 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -295,7 +295,6 @@ static LIST_HEAD(dmar_satc_units);
 static int g_num_of_iommus;
 
 static void dmar_remove_one_dev_info(struct device *dev);
-static void __dmar_remove_one_dev_info(struct device_domain_info *info);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
 int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
@@ -4141,20 +4140,14 @@ static void domain_context_clear(struct device_domain_info *info)
 			       &domain_context_clear_one_cb, info);
 }
 
-static void __dmar_remove_one_dev_info(struct device_domain_info *info)
+static void dmar_remove_one_dev_info(struct device *dev)
 {
-	struct dmar_domain *domain;
-	struct intel_iommu *iommu;
-
-	assert_spin_locked(&device_domain_lock);
-
-	if (WARN_ON(!info))
-		return;
-
-	iommu = info->iommu;
-	domain = info->domain;
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct dmar_domain *domain = info->domain;
+	struct intel_iommu *iommu = info->iommu;
+	unsigned long flags;
 
-	if (info->dev && !dev_is_real_dma_subdevice(info->dev)) {
+	if (!dev_is_real_dma_subdevice(info->dev)) {
 		if (dev_is_pci(info->dev) && sm_supported(iommu))
 			intel_pasid_tear_down_entry(iommu, info->dev,
 					PASID_RID2PASID, false);
@@ -4164,20 +4157,11 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 		intel_pasid_free_table(info->dev);
 	}
 
-	list_del(&info->link);
-	domain_detach_iommu(domain, iommu);
-}
-
-static void dmar_remove_one_dev_info(struct device *dev)
-{
-	struct device_domain_info *info;
-	unsigned long flags;
-
 	spin_lock_irqsave(&device_domain_lock, flags);
-	info = dev_iommu_priv_get(dev);
-	if (info)
-		__dmar_remove_one_dev_info(info);
+	list_del(&info->link);
 	spin_unlock_irqrestore(&device_domain_lock, flags);
+
+	domain_detach_iommu(domain, iommu);
 }
 
 static int md_domain_init(struct dmar_domain *domain, int guest_width)
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
