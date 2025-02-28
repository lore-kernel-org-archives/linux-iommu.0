Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A32566E3
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734815; cv=none; b=gfxRgeYz0yRU1aFthBWmD2r9t8HzqqSI4DDNy3ge29Ah7b2K1Zkjn53pZZLyZdCSY0+Aj81YRRdsJPKyOVaIeKg+MomipkxfvGFscfv/7zR9gueBhPtCtJ9vqrlGXA2lR8whFARGcP89p/9tpw5JIIv8iyGak7tv7u0EkPmX01k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734815; c=relaxed/simple;
	bh=QnZI5g5/imwILnMF97Mve/8kvZvqDgLUw+ieihDhkwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XV5+D1UwTzo8ywxgDZcyheAZm11xr4XC+QH3aylZxQ+TBNZSEQf6UOCx4jFoPQmlFuIamrahkoLnney6tAONZVTekb4ksUl6mVhBwZwTLulRKjL8mPfTg84Btbh84KWbgjWulhqdpNyZdvO9BeJ519FkqVAc86fbXmWmK0s8w0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AANHIxtM; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AANHIxtM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740734814; x=1772270814;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QnZI5g5/imwILnMF97Mve/8kvZvqDgLUw+ieihDhkwQ=;
  b=AANHIxtMn8uP3SUoQGifFx37QIOxT7MU14NJn9Ds8FYtYqNu4dUZpgnU
   d6+7Nus0lPJky+RN1m3i4LB/60Ra5AYi305+ObigYKOJ5/A9qVg3iIfR9
   bxRFqtNHUUU9JMHgO/g1ewHd9B79zSearvT6pOIpIYKxOUZhukNIya0bJ
   fA9PrWeCjCRtspG86PgK/69sYiEutiSosKQJGN3Cb1FsXxBqqFwUJ16vE
   ktReVAM19MlsJxtwqVPz38t/pqHIn77BHedeAEQBZAaFadnBrKff+KA2r
   HareSrshT/gXAbd4NlJVVWVY6SJBIOZpbaUc0TlJ0ZzpXG+cVwxlA10t5
   Q==;
X-CSE-ConnectionGUID: WTE6tNTTSSu+OAUCwV2W1g==
X-CSE-MsgGUID: rRjhvWaFRi+lboJqa9l3jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45438397"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="45438397"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 01:26:54 -0800
X-CSE-ConnectionGUID: +vEQEtgpTK2JWl8HZZ4sJQ==
X-CSE-MsgGUID: jULxgnTmRWG/La7dvgcNsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148213061"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa001.fm.intel.com with ESMTP; 28 Feb 2025 01:26:51 -0800
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
Subject: [PATCH v3 10/12] uacce: Remove unnecessary IOMMU_DEV_FEAT_IOPF
Date: Fri, 28 Feb 2025 17:26:29 +0800
Message-ID: <20250228092631.3425464-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228092631.3425464-1-baolu.lu@linux.intel.com>
References: <20250228092631.3425464-1-baolu.lu@linux.intel.com>
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

