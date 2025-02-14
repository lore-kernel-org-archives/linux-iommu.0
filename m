Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C16D1FDA7C
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 06:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739513492; cv=none; b=moYd75ZK/J7yNdzQRXp/Tt15hyu+Y6J3E6WCde7X8pxRwHoAElJZCZOpO1+ue5sN6XSrp5ZYB1MNZp2Oo8pnbTLH7qVc1iK/tMXG9LuPJbcE1dN+t5GAIFAjZGrJKEWAEsZZ3iTNfSbbXd8VKNh4J5IbaW/K/lvaWXmTrdG7neI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739513492; c=relaxed/simple;
	bh=P/XSQ+RylB0GJpNm9N0XVJmh1MmFI4aZgfpnMDOBpzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U6bsQRX2lcEkcCy4Rx0D5wWS/TNZsdKDxz2FRBaSmxQw58ryI4DRyQYQN+RcfTKV8wuqk/QqBqpN9PuImCkf+8qLkwNucp+vqxtmuhZEnqEijOf3Qg55JUCGMIMbWOCA7HLmYxmhO29UWzjkigVPxhHmRpmwR1Z7F79calb3LVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AN5sDtjL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AN5sDtjL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739513491; x=1771049491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P/XSQ+RylB0GJpNm9N0XVJmh1MmFI4aZgfpnMDOBpzE=;
  b=AN5sDtjL7NttuWHOCX68aKTzi1S+QsB67rRdPUIvTKko/JKRftOI7y2U
   /DITwL7UD04WRzSjmOxSguByKub+bnO7j0yBtdXq5EUvd20oGn+sNcg88
   tQqM0bWj12rkoFFDrzDYBrhWyCT3wXwYkvH+YQh4ND2Kynhw++dvTUn+c
   7evnGQSoc7ASPZqSWEfKZ3W+48uNCp9/60bc+mwBdKYT7nzwvx9yNs+Hm
   ksy4Y+9d5NRbKp3Jg21YbCBUEvV0iNTl4ZkkVVncwdJ/vl7bDGO8MVXrH
   TmTU5aQRo3g6P3eyE5uxUXsbZPJD2sWIXDaPPZLhJRetOnSk9kz9TxHyK
   Q==;
X-CSE-ConnectionGUID: pkWOVP66QmKTsZS9GPeBTQ==
X-CSE-MsgGUID: B7I+67nwTYWwb3+A+D9Gfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="40124578"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="40124578"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 22:11:31 -0800
X-CSE-ConnectionGUID: QYD1vStwT/y8rh9/95omaA==
X-CSE-MsgGUID: y/8M73bQRjCyFm0342wm4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114268155"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa008.jf.intel.com with ESMTP; 13 Feb 2025 22:11:28 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 09/12] dmaengine: idxd: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Date: Fri, 14 Feb 2025 14:11:01 +0800
Message-ID: <20250214061104.1959525-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
References: <20250214061104.1959525-1-baolu.lu@linux.intel.com>
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

