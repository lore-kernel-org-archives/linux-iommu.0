Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC0333ED
	for <iommu@lists.linux.dev>; Fri, 18 Nov 2022 13:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668778331; x=1700314331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RfcpiEbdbskkPeCw2JzA4bI6d0W2gVvyufESQpbn4Bk=;
  b=Eks+0C4l3Tftr7zMX4Qs6LklKrSseHyccM3qS1u7L92LTPBUYXVxIx/z
   WKqcWG6cdifKwLI4X9yB4362Bi2VD44HlUJUhoLQ3nocLoPZ4dH5KLZr5
   qyu2Lcmu7fqKQZ3a85YQni6hK/N0QjWF/2K3PyI8X5Qd1m0CFwrzVl4nt
   1YbPVZMCzq/VMwPxV4MRzY/Pt7u8LfUuEQfCMvihWOqEJ9NXmhxazS4Qw
   OpUJPs93/XFVlcQTrxew1stPjBIhLjWrDLOxLFgVI3qYYGyHPU7hq6D9I
   8nahnXDtxVB+WzWxQ3jvuv+lXsTvzPvkZDZp/l3SGJUWIZ0E5sdCMeCGG
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="313146034"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="313146034"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 05:32:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="642512007"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="642512007"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 18 Nov 2022 05:32:09 -0800
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
Subject: [PATCH v4 2/7] iommu/vt-d: Add device_block_translation() helper
Date: Fri, 18 Nov 2022 21:24:46 +0800
Message-Id: <20221118132451.114406-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221118132451.114406-1-baolu.lu@linux.intel.com>
References: <20221118132451.114406-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If domain attaching to device fails, the IOMMU driver should bring the
device to blocking DMA state. The upper layer is expected to recover it
by attaching a new domain. Use device_block_translation() in the error
path of dev_attach to make the behavior specific.

The difference between device_block_translation() and the previous
dmar_remove_one_dev_info() is that, in the scalable mode, it is the
RID2PASID entry instead of context entry being cleared. As a result,
enabling PCI capabilities is moved up.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 44 ++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6b8a24f68da8..6aafb86ef5c3 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -277,7 +277,7 @@ static LIST_HEAD(dmar_satc_units);
 #define for_each_rmrr_units(rmrr) \
 	list_for_each_entry(rmrr, &dmar_rmrr_units, list)
 
-static void dmar_remove_one_dev_info(struct device *dev);
+static void device_block_translation(struct device *dev);
 
 int dmar_disabled = !IS_ENABLED(CONFIG_INTEL_IOMMU_DEFAULT_ON);
 int intel_iommu_sm = IS_ENABLED(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
@@ -1400,7 +1400,7 @@ static void iommu_enable_pci_caps(struct device_domain_info *info)
 {
 	struct pci_dev *pdev;
 
-	if (!info || !dev_is_pci(info->dev))
+	if (!dev_is_pci(info->dev))
 		return;
 
 	pdev = to_pci_dev(info->dev);
@@ -2045,7 +2045,6 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	} else {
 		iommu_flush_write_buffer(iommu);
 	}
-	iommu_enable_pci_caps(info);
 
 	ret = 0;
 
@@ -2487,7 +2486,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 					dev, PASID_RID2PASID);
 		if (ret) {
 			dev_err(dev, "Setup RID2PASID failed\n");
-			dmar_remove_one_dev_info(dev);
+			device_block_translation(dev);
 			return ret;
 		}
 	}
@@ -2495,10 +2494,12 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 	ret = domain_context_mapping(domain, dev);
 	if (ret) {
 		dev_err(dev, "Domain context map failed\n");
-		dmar_remove_one_dev_info(dev);
+		device_block_translation(dev);
 		return ret;
 	}
 
+	iommu_enable_pci_caps(info);
+
 	return 0;
 }
 
@@ -4109,6 +4110,37 @@ static void dmar_remove_one_dev_info(struct device *dev)
 	info->domain = NULL;
 }
 
+/*
+ * Clear the page table pointer in context or pasid table entries so that
+ * all DMA requests without PASID from the device are blocked. If the page
+ * table has been set, clean up the data structures.
+ */
+static void device_block_translation(struct device *dev)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	unsigned long flags;
+
+	iommu_disable_dev_iotlb(info);
+	if (!dev_is_real_dma_subdevice(dev)) {
+		if (sm_supported(iommu))
+			intel_pasid_tear_down_entry(iommu, dev,
+						    PASID_RID2PASID, false);
+		else
+			domain_context_clear(info);
+	}
+
+	if (!info->domain)
+		return;
+
+	spin_lock_irqsave(&info->domain->lock, flags);
+	list_del(&info->link);
+	spin_unlock_irqrestore(&info->domain->lock, flags);
+
+	domain_detach_iommu(info->domain, iommu);
+	info->domain = NULL;
+}
+
 static int md_domain_init(struct dmar_domain *domain, int guest_width)
 {
 	int adjust_width;
@@ -4232,7 +4264,7 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 		struct device_domain_info *info = dev_iommu_priv_get(dev);
 
 		if (info->domain)
-			dmar_remove_one_dev_info(dev);
+			device_block_translation(dev);
 	}
 
 	ret = prepare_domain_attach_device(domain, dev);
-- 
2.34.1

