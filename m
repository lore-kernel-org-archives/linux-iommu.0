Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC691E47BB
	for <iommu@lists.linux.dev>; Fri,  8 Nov 2024 12:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067474; cv=none; b=D0wXx1qS/WfHuR77ZtInJSN+lkz4yVL6RQncxoW9BtoHYdyB2Rgfq8N6X148iUiUIMJqw+6/MoejhdVA/H0dBsvwJefnrC4owjQsgmRsfQH4cIxvEG1B0U6QanK+dB8uZR+gw7qMIeS6BrTjfecBpuHYyuH085C17nVenSp6RfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067474; c=relaxed/simple;
	bh=h/iir5bbQI/sdAE4QJiveeaniAldZP8K2NkM9vUjrYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=baVxyFLdcX0+1NvG6KBMQhmT5cIGcNO+OgLkTZ0b+ze6qjAR+d+f/DsrFpg7B72V7oWkAzNs2lozJqNR/+4OxJZGl9T1zuYHYwXXCrNnAgfU8pEbG/4Y6sX7OJ/m1qCpzgEsqB+ZWIeEzU193Clz0zgPBrFLkaxQfmz5fghXfZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZa2mdQt; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZa2mdQt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731067473; x=1762603473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h/iir5bbQI/sdAE4QJiveeaniAldZP8K2NkM9vUjrYI=;
  b=iZa2mdQtG7xZ7aaU6zUg2oZ4HNjs8yNrwscB6BHbTZfV15n4ITP7uyPX
   IRbap4bW5lky8lVg7Q3oHo9sV4E2Fa8w9POlwCYHHUyqWnSI1wseS9jo8
   nYba4oWVazsN0uy3EzVAzssxXlSEKi7wAce5KkDyOV8ZTC0nr3gXrYR3z
   yHpSzFTxOkjty0P7iLtoS9Uuu6l4L+NfM5LUBIakJAslg/vMmXcERbMZL
   ZcbKGRBVx4CDGuD1OCZMNVm1uoHQykY1/WfhUGRkJi4eolIFH8qTsFnZu
   krgzGE6EKmleF/dpiV40wO4Ecqy9h1pGBioEbq9eZObOEIsORPJDnEbBm
   w==;
X-CSE-ConnectionGUID: g/S3gNRrQAe9nOqinEhMvg==
X-CSE-MsgGUID: WuM/1NXxSPyvsLimj0T3YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31116416"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31116416"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 04:04:31 -0800
X-CSE-ConnectionGUID: OvajEX1eTXONS94RaD+Hrw==
X-CSE-MsgGUID: FVcmXU9BSm6nsdqtjefGtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85679024"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa008.fm.intel.com with ESMTP; 08 Nov 2024 04:04:30 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com,
	willy@infradead.org
Subject: [PATCH v4 2/7] iommu: Consolidate the ops->remove_dev_pasid usage into a helper
Date: Fri,  8 Nov 2024 04:04:22 -0800
Message-Id: <20241108120427.13562-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108120427.13562-1-yi.l.liu@intel.com>
References: <20241108120427.13562-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a wrapper for the ops->remove_dev_pasid, this consolidates the iommu_ops
fetching and callback invoking. It is also a preparation for starting the
transition from using remove_dev_pasid op to detach pasid to the way using
blocked_domain to detach pasid.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1c689e57928e..819c6e0188d5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3298,6 +3298,14 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
 
+static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
+				   struct iommu_domain *domain)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+	ops->remove_dev_pasid(dev, pasid, domain);
+}
+
 static int __iommu_set_group_pasid(struct iommu_domain *domain,
 				   struct iommu_group *group, ioasid_t pasid)
 {
@@ -3316,11 +3324,9 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
 err_revert:
 	last_gdev = device;
 	for_each_group_device(group, device) {
-		const struct iommu_ops *ops = dev_iommu_ops(device->dev);
-
 		if (device == last_gdev)
 			break;
-		ops->remove_dev_pasid(device->dev, pasid, domain);
+		iommu_remove_dev_pasid(device->dev, pasid, domain);
 	}
 	return ret;
 }
@@ -3330,12 +3336,9 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 				       struct iommu_domain *domain)
 {
 	struct group_device *device;
-	const struct iommu_ops *ops;
 
-	for_each_group_device(group, device) {
-		ops = dev_iommu_ops(device->dev);
-		ops->remove_dev_pasid(device->dev, pasid, domain);
-	}
+	for_each_group_device(group, device)
+		iommu_remove_dev_pasid(device->dev, pasid, domain);
 }
 
 /*
-- 
2.34.1

