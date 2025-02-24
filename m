Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B2F1EDA13
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 05:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740374211; cv=none; b=R2sXNXwJT9E/ee1uYP8FSntWwja+Ilv2X1MYUdrYK+M8Re3yWqHJWVl9/di9e+vrrkTkVVodVbAHlXMAQ6z9W2f84l5OuQ7iyI1TBP04Xbx7slktcwvTBh5ELK8pQIQzTWtLnCJ6iRG6Rv60vVc73wkJ9mLltGkLFc1wUVwAt6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740374211; c=relaxed/simple;
	bh=ZvCAkeVNiqSTrTmWFcyHvoeplhrkh5mOUa8taQ8Oz9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3UOLXJuVkPmYq41THfTq9NaafU12Ym85Ny2cQqDTulte+1/EESJq9ohGjfRs/2jjq1B4LElQf3D7Bb+oL1arIibYaYjIqMZdfqypJxvzNwRVRHzkVn9NtQWs4yAqZbnz9dsodrPay2aSVMDff/Gca4CjOI2r/ArFE0ShZcckXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROX//Dsu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROX//Dsu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740374210; x=1771910210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZvCAkeVNiqSTrTmWFcyHvoeplhrkh5mOUa8taQ8Oz9k=;
  b=ROX//DsuKc/fx6UVK0HlBmdXedgFSMqAcfhMRD6GGUwR0qVVPIONXaV3
   /YMVFEh6slSOGY7Jt5q99JsrWRiEs/vVb8JJ27leyr4sSU4BlimBN6Vwf
   Y+YvVLZUB2mPXl3MYCYA00j4eB4H8bs4hXZg8B3pb2G4n5fzzeUBpe2bU
   u3F74HNqwep1wheyKRhBmHMnn507Xj0yS4Rk/cplvtJo+ujzt+EcjCzs2
   qcQbSemoyddI0BOh3LqIy/D0R4iOjlss2Gd0RYXkTdC5ZtGVfoPbWJPIq
   V2NeiHhAJhVfhYiaElsvewBK2qixDDAJcQdFPEfIoWL46evtDXMrpTgRA
   A==;
X-CSE-ConnectionGUID: jgVRSBliSc67GYUvwYzE8w==
X-CSE-MsgGUID: 6QtvAImgQIOlJB1QlVuH7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="45024272"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="45024272"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2025 21:16:49 -0800
X-CSE-ConnectionGUID: zFldEcreRDSkger/M04TGg==
X-CSE-MsgGUID: G0sjBRmYRPysiA5sB0Y4Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="116143417"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa008.fm.intel.com with ESMTP; 23 Feb 2025 21:16:46 -0800
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
Subject: [PATCH v2 09/12] dmaengine: idxd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Date: Mon, 24 Feb 2025 13:16:23 +0800
Message-ID: <20250224051627.2956304-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
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

