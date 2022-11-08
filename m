Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FD8612F
	for <iommu@lists.linux.dev>; Tue,  8 Nov 2022 07:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667893299; x=1699429299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zTZb7UZzftplWCVlQbHsdD95SGetcv/Zvq7nWlgOBsA=;
  b=k6spqoQCuOsoQJPP9pit5LVvh/2X5H5L1gh2JhBN159l0R4dsvdl7PZv
   1xEHWPOUfWE8bt0TQfRriV+Lvlc4lLuhNp+LM7usMLmzM1eKTKaLf8abX
   4yT41KjWOeGzvyEa5c0l7h3Af/TdgOob2ziTKwSXYPOoeWCJ+//EzSH+z
   6R8Am0/vaRm0gDVS9yzFHRjvnmdaQrtdV1UNTLJ0mtl2e9tKZzfPDKO4N
   TdIbbjBODIslhqTfQQf32QAamhsQdneUL+hoOB+G8uIHOp4j+4orkFDzy
   kMJeGVd/fwbagCuF2PdtMG9+zR23QdtrSh8KWzCTk/Ig66AW+J5F1JHN0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="290350150"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="290350150"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 23:41:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="699821940"
X-IronPort-AV: E=Sophos;i="5.96,147,1665471600"; 
   d="scan'208";a="699821940"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 07 Nov 2022 23:41:10 -0800
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
Subject: [PATCH v2 5/8] iommu/vt-d: Fold dmar_remove_one_dev_info() into its caller
Date: Tue,  8 Nov 2022 15:34:05 +0800
Message-Id: <20221108073408.1005721-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221108073408.1005721-1-baolu.lu@linux.intel.com>
References: <20221108073408.1005721-1-baolu.lu@linux.intel.com>
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
index 5d5d08192c2c..8bbe516f7d21 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1479,7 +1479,7 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 	}
 }
 
-static void iommu_disable_dev_iotlb(struct device_domain_info *info)
+static void iommu_disable_pci_caps(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
@@ -4124,30 +4124,6 @@ static void domain_context_clear(struct device_domain_info *info)
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
 /*
  * Clear the page table pointer in context or pasid table entries so that
  * all DMA requests without PASID from the device are blocked. If the page
@@ -4596,7 +4572,10 @@ static void intel_iommu_release_device(struct device *dev)
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

