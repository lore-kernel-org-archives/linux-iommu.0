Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40FEA29
	for <iommu@lists.linux.dev>; Thu,  3 Nov 2022 06:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667455224; x=1698991224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NwQMgsKcZs/tlpXVoJMXkMuWIzP3I35y6H0OEip798w=;
  b=Xe+ueeXRq21zZlv4ZozY9OEFOFDXq3eFIAibwEfCOu9wuuRQ/h7hFN6U
   304THjpXcJX2fcMW0l8OxyahuBZp0341jYV2q9PVsUQmjmA+OuFl01lvA
   BaKI1IqjuWovwmySAOIDn48UtzihdI9fTic6kLu29dpNUHx0reYkA08To
   jcqBpPdg0yo4H56XEjesiYta5ANQAxHb1ir1czF933gkO+6YSh09wa6SL
   E6C2ROiR3gAIwO93djvHxn/YBOPZdIOaYQAOozpab5vuJFh88EKoPnEJ/
   FogCg0tfPpJeKOz0kCGNNBmI2CmeUt6/LBCDeV1WNIFXRjl6Z9PJXqeDz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="311322510"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="311322510"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 23:00:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="723819311"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="723819311"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Nov 2022 23:00:22 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: iommu@lists.linux.dev
Cc: Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Liu Yi L <yi.l.liu@intel.com>,
	Jacob jun Pan <jacob.jun.pan@intel.com>,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 4/7] iommu/vt-d: Fold dmar_remove_one_dev_info() into its caller
Date: Thu,  3 Nov 2022 13:53:26 +0800
Message-Id: <20221103055329.633052-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221103055329.633052-1-baolu.lu@linux.intel.com>
References: <20221103055329.633052-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fold dmar_remove_one_dev_info() into intel_iommu_release_device() which
is its only caller. Replace most of the code with
device_block_translation() to make the code neat and tidy.

Rename iommu_disable_dev_iotlb() to iommu_disable_pci_caps() to pair with
iommu_enable_pci_caps().

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b956c411f2bb..393e07ac4c21 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1443,7 +1443,7 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 	}
 }
 
-static void iommu_disable_dev_iotlb(struct device_domain_info *info)
+static void iommu_disable_pci_caps(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
@@ -4088,30 +4088,6 @@ static void domain_context_clear(struct device_domain_info *info)
 			       &domain_context_clear_one_cb, info);
 }
 
-static void dmar_remove_one_dev_info(struct device *dev)
-{
-	struct device_domain_info *info = dev_iommu_priv_get(dev);
-	struct dmar_domain *domain = info->domain;
-	struct intel_iommu *iommu = info->iommu;
-	unsigned long flags;
-
-	if (!dev_is_real_dma_subdevice(info->dev)) {
-		if (dev_is_pci(info->dev) && sm_supported(iommu))
-			intel_pasid_tear_down_entry(iommu, info->dev,
-					PASID_RID2PASID, false);
-
-		iommu_disable_dev_iotlb(info);
-		domain_context_clear(info);
-	}
-
-	spin_lock_irqsave(&domain->lock, flags);
-	list_del(&info->link);
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	domain_detach_iommu(domain, iommu);
-	info->domain = NULL;
-}
-
 static int md_domain_init(struct dmar_domain *domain, int guest_width)
 {
 	int adjust_width;
@@ -4564,7 +4540,10 @@ static void intel_iommu_release_device(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
-	dmar_remove_one_dev_info(dev);
+	iommu_disable_pci_caps(info);
+	domain_context_clear(info);
+	device_block_translation(dev);
+
 	intel_pasid_free_table(dev);
 	dev_iommu_priv_set(dev, NULL);
 	kfree(info);
-- 
2.34.1

