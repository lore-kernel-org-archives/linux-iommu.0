Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B841FBC9E
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 05:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741843198; cv=none; b=IRBdFhZAyQ3iJH0G3DSu0PmUY0JebT187CuhDWWqhcvKLNGch7q4DN22SJHvE2vaMc1CZRmNqb0N7ZZ9MX3vQxzveAu4ivEo1WWL6DhQivMJVvBWxsSL8ISHzyg3eu9hccVr+bYybCUwhl6HnnMqmiozMP7JxTV6b62O4lbFmDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741843198; c=relaxed/simple;
	bh=LalUdJVj91uyCo7aoTOFqO1HMi4LdrZjiQ2EMwM8TAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=heruI0dFK+7rRaUhpYDgpcM34uiqB28g9OZjE/DJ7wBrCbrYOtGrMSwinQipvePD532wYqj4VuEsSRNUiHkuth3Oo9YDCt97b6UmCjjOI3KAEJbPUe8SPqNK+HdMV8SN2gYWMDcKE9fSIadHrg3L1iTOb4q+EiymrZ4lv1u30q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrxXgBQY; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrxXgBQY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741843197; x=1773379197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LalUdJVj91uyCo7aoTOFqO1HMi4LdrZjiQ2EMwM8TAI=;
  b=WrxXgBQYuL04iOw0JGd2NuDEq4pQtytHajSUnJFbqnUs+CUcoz/mLVub
   /9SCOg9lv1L6xY46YLysNgaJn1rvKLzakUayQRJ0MURal+lBtHrq2ELIF
   Ek4YrSNe4babMOu69ETQZsn1FvEtzir2LKXv8y95U6ugbrOa5fo5NQ2wG
   JaIlOIGJnVEwRTGmSVfSMEbYXNANe+gz7eaePwphu4cCpK6PcRhG6l9sl
   tuBJBLx4+MplFWvjegfLk3Dy9M1WpwG3+KcuOKGTndz1+laxLoagUJQiA
   1UVuyRESRiurORnfMYNXc39NXAa0VOO4mV1WLA02uTrjdRkwvsgXiQ4ei
   Q==;
X-CSE-ConnectionGUID: 8Qmi07dURBqhshVn74/3OA==
X-CSE-MsgGUID: +AeWZVi9TtSs6bf5juZxaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="54323702"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="54323702"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 22:19:57 -0700
X-CSE-ConnectionGUID: N88eXz2nQIGhPJGedYUqvA==
X-CSE-MsgGUID: BFCPHzDPTFGKnG4kOxHY6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="151807128"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2025 22:19:54 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 5/8] dmaengine: idxd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Date: Thu, 13 Mar 2025 13:19:50 +0800
Message-ID: <20250313051953.4064532-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IOMMU_DEV_FEAT_IOPF implementation in the iommu driver is just a no-op.
It will also be removed from the iommu driver in the subsequent patch.
Remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/dma/idxd/init.c | 37 ++++++-------------------------------
 1 file changed, 6 insertions(+), 31 deletions(-)

diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index 1e5038cca22c..d44944195807 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -626,21 +626,6 @@ static void idxd_disable_system_pasid(struct idxd_device *idxd)
 	idxd->pasid = IOMMU_PASID_INVALID;
 }
 
-static int idxd_enable_sva(struct pci_dev *pdev)
-{
-	int ret;
-
-	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
-	if (ret)
-		return ret;
-	return 0;
-}
-
-static void idxd_disable_sva(struct pci_dev *pdev)
-{
-	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
-}
-
 static int idxd_probe(struct idxd_device *idxd)
 {
 	struct pci_dev *pdev = idxd->pdev;
@@ -655,17 +640,13 @@ static int idxd_probe(struct idxd_device *idxd)
 	dev_dbg(dev, "IDXD reset complete\n");
 
 	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
-		if (idxd_enable_sva(pdev)) {
-			dev_warn(dev, "Unable to turn on user SVA feature.\n");
-		} else {
-			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
+		set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
 
-			rc = idxd_enable_system_pasid(idxd);
-			if (rc)
-				dev_warn(dev, "No in-kernel DMA with PASID. %d\n", rc);
-			else
-				set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
-		}
+		rc = idxd_enable_system_pasid(idxd);
+		if (rc)
+			dev_warn(dev, "No in-kernel DMA with PASID. %d\n", rc);
+		else
+			set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
 	} else if (!sva) {
 		dev_warn(dev, "User forced SVA off via module param.\n");
 	}
@@ -703,8 +684,6 @@ static int idxd_probe(struct idxd_device *idxd)
  err:
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
-	if (device_user_pasid_enabled(idxd))
-		idxd_disable_sva(pdev);
 	return rc;
 }
 
@@ -715,8 +694,6 @@ static void idxd_cleanup(struct idxd_device *idxd)
 	idxd_cleanup_internals(idxd);
 	if (device_pasid_enabled(idxd))
 		idxd_disable_system_pasid(idxd);
-	if (device_user_pasid_enabled(idxd))
-		idxd_disable_sva(idxd->pdev);
 }
 
 /*
@@ -1248,8 +1225,6 @@ static void idxd_remove(struct pci_dev *pdev)
 	free_irq(irq_entry->vector, irq_entry);
 	pci_free_irq_vectors(pdev);
 	pci_iounmap(pdev, idxd->reg_base);
-	if (device_user_pasid_enabled(idxd))
-		idxd_disable_sva(pdev);
 	pci_disable_device(pdev);
 	destroy_workqueue(idxd->wq);
 	perfmon_pmu_remove(idxd);
-- 
2.43.0

