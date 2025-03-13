Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ED41FBCBF
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 05:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741843203; cv=none; b=Is39gzcAzSakUULBugliOz9li4SNoIUPJqTJB6YZFqkip2OwTtM+xM5r26AJ6vZmUg/WbydfZH9ZkbUES0mWa9zTYR7ZWEQGmAZOI3GwzaSArn0cG8OR+eS1+3+SYCbSsQ1QCspzvZIEOzusMyQr0NsmS7nt4AbMnWowmp8DNqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741843203; c=relaxed/simple;
	bh=QnZI5g5/imwILnMF97Mve/8kvZvqDgLUw+ieihDhkwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SY3d6CdQQqwXHsRfewIz15s+bn2G1wS9K6GOSm906MkSji7z69oyDZOn/XPtXBXdRVcXGu1e66dDWHR7SzgmhvY+qRDx4yzWfa+tsU0CCacvTKKWx6CmLpTm04n6E7rG+Xx+BqE1CIaZJ6bQKXstAST0pJ4PSmVNTtGNV/Oflac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJHhCtlu; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJHhCtlu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741843200; x=1773379200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QnZI5g5/imwILnMF97Mve/8kvZvqDgLUw+ieihDhkwQ=;
  b=HJHhCtluBmjjI9xQRq4GH70btMfLu1Uq4P7bWk6r9QpBpih9NcrYPlsj
   3o0n0mROrQouC9pMGcQigbQnygT86Qm1hQNyUczII+pfO2qhN266i1y2W
   Vgt66LdssCRUf6eKHjIObSFvNBITBX08wRMBls4MuWAyZuAaUJDTqjdzY
   NAGaYzdP1CcWqnMEDeN7l7ahIFFCFydzHZ3NH88bfbqHj2Pk7dY5rCQFb
   nWdUxKqsnyH1Yhf1DWvR5FVrEPez0AD67FWdxMcLgO1Ex1i2z2Yene59L
   eoV58v9H+rBK1q9+rwleBCL7dNJYJmAhobW9tQUjT6Pr7+Plxn7eTrTot
   Q==;
X-CSE-ConnectionGUID: q865MgODRWmvs1CIVJPDUA==
X-CSE-MsgGUID: QGcSZF8lRfevH7uusGKt5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="54323714"
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="54323714"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 22:20:00 -0700
X-CSE-ConnectionGUID: XR5O9DQ5SRSbJswEMqKKjg==
X-CSE-MsgGUID: wVWPpc6xSDqaAT93RROwdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,243,1736841600"; 
   d="scan'208";a="151807139"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2025 22:19:57 -0700
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
Subject: [PATCH v4 6/8] uacce: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Date: Thu, 13 Mar 2025 13:19:51 +0800
Message-ID: <20250313051953.4064532-7-baolu.lu@linux.intel.com>
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

None of the drivers implement anything for IOMMU_DEV_FEAT_IOPF anymore,
remove it to avoid dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/misc/uacce/uacce.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index 2a1db2abeeca..42e7d2a2a90c 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -465,31 +465,6 @@ static void uacce_release(struct device *dev)
 	kfree(uacce);
 }
 
-static unsigned int uacce_enable_sva(struct device *parent, unsigned int flags)
-{
-	int ret;
-
-	if (!(flags & UACCE_DEV_SVA))
-		return flags;
-
-	flags &= ~UACCE_DEV_SVA;
-
-	ret = iommu_dev_enable_feature(parent, IOMMU_DEV_FEAT_IOPF);
-	if (ret) {
-		dev_err(parent, "failed to enable IOPF feature! ret = %pe\n", ERR_PTR(ret));
-		return flags;
-	}
-	return flags | UACCE_DEV_SVA;
-}
-
-static void uacce_disable_sva(struct uacce_device *uacce)
-{
-	if (!(uacce->flags & UACCE_DEV_SVA))
-		return;
-
-	iommu_dev_disable_feature(uacce->parent, IOMMU_DEV_FEAT_IOPF);
-}
-
 /**
  * uacce_alloc() - alloc an accelerator
  * @parent: pointer of uacce parent device
@@ -509,8 +484,6 @@ struct uacce_device *uacce_alloc(struct device *parent,
 	if (!uacce)
 		return ERR_PTR(-ENOMEM);
 
-	flags = uacce_enable_sva(parent, flags);
-
 	uacce->parent = parent;
 	uacce->flags = flags;
 	uacce->ops = interface->ops;
@@ -533,7 +506,6 @@ struct uacce_device *uacce_alloc(struct device *parent,
 	return uacce;
 
 err_with_uacce:
-	uacce_disable_sva(uacce);
 	kfree(uacce);
 	return ERR_PTR(ret);
 }
@@ -596,9 +568,6 @@ void uacce_remove(struct uacce_device *uacce)
 		unmap_mapping_range(q->mapping, 0, 0, 1);
 	}
 
-	/* disable sva now since no opened queues */
-	uacce_disable_sva(uacce);
-
 	if (uacce->cdev)
 		cdev_device_del(uacce->cdev, &uacce->dev);
 	xa_erase(&uacce_xa, uacce->dev_id);
-- 
2.43.0

