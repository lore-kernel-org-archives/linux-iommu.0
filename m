Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EF9211C
	for <iommu@lists.linux.dev>; Tue, 11 Apr 2023 06:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681195702; x=1712731702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zGpEfMgloBsWMUOjxE9fyxNifshGPev/lcFUTQ3YvYY=;
  b=NTw+WP8I4lwveWZKESfmnqyxBCnIXzxUik0TFgp9Da0bogRriIJYKMOp
   /nlWoLj17Q4yZzr4N5daJe35Igq3PCJNjyclfzu6iVMIvM+48qiLOzU8o
   7CVAIPNYcLAPQNIOBjYCkGcgba5N8Mjd21Cd6h11yunBqZH8apKS3/U5R
   iIQ90M1x4mp/3Uq2gqlwPM0bSao6xpYqPbltweefEQAxNrRWLdtx43+Em
   K474Cog1cEKXzqk7wrUa3Wi0wZmZLxtIioYoP9KGu0oHxiYWdjWh3J8TJ
   AecAOTZRMQPyBs7i8oO8jXAdTdKcS8CWlbmRIX0wkATkRIek0dkB9OI9a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="341028534"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341028534"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 23:48:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="1018256564"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="1018256564"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga005.fm.intel.com with ESMTP; 10 Apr 2023 23:48:20 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/17] iommu/vt-d: Move PRI handling to IOPF feature path
Date: Tue, 11 Apr 2023 14:48:03 +0800
Message-Id: <20230411064815.31456-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230411064815.31456-1-baolu.lu@linux.intel.com>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PRI is only used for IOPF. With this move, the PCI/PRI feature could be
controlled by the device driver through iommu_dev_enable/disable_feature()
interfaces.

Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20230324120234.313643-6-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c | 53 ++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6d77b4072fdd..cd3a3c4b5e64 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1415,11 +1415,6 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 	if (info->pasid_supported && !pci_enable_pasid(pdev, info->pasid_supported & ~1))
 		info->pasid_enabled = 1;
 
-	if (info->pri_supported &&
-	    (info->pasid_enabled ? pci_prg_resp_pasid_required(pdev) : 1)  &&
-	    !pci_reset_pri(pdev) && !pci_enable_pri(pdev, PRQ_DEPTH))
-		info->pri_enabled = 1;
-
 	if (info->ats_supported && pci_ats_page_aligned(pdev) &&
 	    !pci_enable_ats(pdev, VTD_PAGE_SHIFT)) {
 		info->ats_enabled = 1;
@@ -1442,11 +1437,6 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
 		domain_update_iotlb(info->domain);
 	}
 
-	if (info->pri_enabled) {
-		pci_disable_pri(pdev);
-		info->pri_enabled = 0;
-	}
-
 	if (info->pasid_enabled) {
 		pci_disable_pasid(pdev);
 		info->pasid_enabled = 0;
@@ -4667,23 +4657,48 @@ static int intel_iommu_enable_sva(struct device *dev)
 
 static int intel_iommu_enable_iopf(struct device *dev)
 {
+	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu;
 	int ret;
 
-	if (!info || !info->ats_enabled || !info->pri_enabled)
+	if (!pdev || !info || !info->ats_enabled || !info->pri_supported)
 		return -ENODEV;
+
+	if (info->pri_enabled)
+		return -EBUSY;
+
 	iommu = info->iommu;
 	if (!iommu)
 		return -EINVAL;
 
+	/* PASID is required in PRG Response Message. */
+	if (info->pasid_enabled && !pci_prg_resp_pasid_required(pdev))
+		return -EINVAL;
+
+	ret = pci_reset_pri(pdev);
+	if (ret)
+		return ret;
+
 	ret = iopf_queue_add_device(iommu->iopf_queue, dev);
 	if (ret)
 		return ret;
 
 	ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
 	if (ret)
-		iopf_queue_remove_device(iommu->iopf_queue, dev);
+		goto iopf_remove_device;
+
+	ret = pci_enable_pri(pdev, PRQ_DEPTH);
+	if (ret)
+		goto iopf_unregister_handler;
+	info->pri_enabled = 1;
+
+	return 0;
+
+iopf_unregister_handler:
+	iommu_unregister_device_fault_handler(dev);
+iopf_remove_device:
+	iopf_queue_remove_device(iommu->iopf_queue, dev);
 
 	return ret;
 }
@@ -4694,6 +4709,20 @@ static int intel_iommu_disable_iopf(struct device *dev)
 	struct intel_iommu *iommu = info->iommu;
 	int ret;
 
+	if (!info->pri_enabled)
+		return -EINVAL;
+
+	/*
+	 * PCIe spec states that by clearing PRI enable bit, the Page
+	 * Request Interface will not issue new page requests, but has
+	 * outstanding page requests that have been transmitted or are
+	 * queued for transmission. This is supposed to be called after
+	 * the device driver has stopped DMA, all PASIDs have been
+	 * unbound and the outstanding PRQs have been drained.
+	 */
+	pci_disable_pri(to_pci_dev(dev));
+	info->pri_enabled = 0;
+
 	ret = iommu_unregister_device_fault_handler(dev);
 	if (ret)
 		return ret;
-- 
2.34.1

