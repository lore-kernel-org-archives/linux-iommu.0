Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1406633ED
	for <iommu@lists.linux.dev>; Fri, 18 Nov 2022 13:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668778329; x=1700314329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dJwBIFugX5v1sFvIYnUIgu60nhe9NDrxApRtl04GOC0=;
  b=XgPICF3RYxWE70Do4Gk2yesPoTBO0XZ54z+ruSiJV4BNi+9YF1nL/YOZ
   nVV58ksIT/ATANUst9RpuoGzSS/PGqafkYcEY6T2LU8qMaSCiQ7wg2Pn9
   0UjGvLKQb6xUsGcAM7ezT/D3OAFKoz9J6Vu8Kz+BYLZjkoAdECe3ABRgc
   J4b4QspQYvIHR9tlAsRm96NXPY93BIYQMV/snNS/Fll000aP/36iFM+Nf
   AlJ9m30w/PT4U5J0GqHXjSnm/4qQBiyo0deC5Meq5FTkQDIHJbPuKHORt
   mYshKIY9GswqgeJ4JbIEbe8l1cPIYcdnFvSE40lt8KKxhEdmQceDCEFEs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="313146029"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="313146029"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 05:32:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="642511998"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="642511998"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 18 Nov 2022 05:32:06 -0800
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
Subject: [PATCH v4 1/7] iommu/vt-d: Allocate pasid table in device probe path
Date: Fri, 18 Nov 2022 21:24:45 +0800
Message-Id: <20221118132451.114406-2-baolu.lu@linux.intel.com>
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

Whether or not a domain is attached to the device, the pasid table should
always be valid as long as it has been probed. This moves the pasid table
allocation from the domain attaching device path to device probe path and
frees it in the device release path.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 996a8b5ee5ee..6b8a24f68da8 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2475,13 +2475,6 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 
 	/* PASID table is mandatory for a PCI device in scalable mode. */
 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
-		ret = intel_pasid_alloc_table(dev);
-		if (ret) {
-			dev_err(dev, "PASID table allocation failed\n");
-			dmar_remove_one_dev_info(dev);
-			return ret;
-		}
-
 		/* Setup the PASID entry for requests without PASID: */
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
@@ -4106,7 +4099,6 @@ static void dmar_remove_one_dev_info(struct device *dev)
 
 		iommu_disable_dev_iotlb(info);
 		domain_context_clear(info);
-		intel_pasid_free_table(info->dev);
 	}
 
 	spin_lock_irqsave(&domain->lock, flags);
@@ -4466,6 +4458,7 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	struct device_domain_info *info;
 	struct intel_iommu *iommu;
 	u8 bus, devfn;
+	int ret;
 
 	iommu = device_to_iommu(dev, &bus, &devfn);
 	if (!iommu || !iommu->iommu.ops)
@@ -4509,6 +4502,16 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 
 	dev_iommu_priv_set(dev, info);
 
+	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
+		ret = intel_pasid_alloc_table(dev);
+		if (ret) {
+			dev_err(dev, "PASID table allocation failed\n");
+			dev_iommu_priv_set(dev, NULL);
+			kfree(info);
+			return ERR_PTR(ret);
+		}
+	}
+
 	return &iommu->iommu;
 }
 
@@ -4517,6 +4520,7 @@ static void intel_iommu_release_device(struct device *dev)
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 
 	dmar_remove_one_dev_info(dev);
+	intel_pasid_free_table(dev);
 	dev_iommu_priv_set(dev, NULL);
 	kfree(info);
 	set_dma_ops(dev, NULL);
-- 
2.34.1

