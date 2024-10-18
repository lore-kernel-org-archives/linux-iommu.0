Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F89185B5F
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 05:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729231109; cv=none; b=AwmzrhIeRcNJ93Lk0VMWINlWnkrpE86jN3v0Y0qUXol1FnO58Mjbtf86SgFtMrJ3MSMq+xQip9rLu0Rd5eo98vI5A3uY8VeBGiSNhptpUL9SyB8pi29EJqJGTecPnoRF8ptacVqLpSPJx5fDGlFcsIbOLVMVIT2qiBrUohhAckQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729231109; c=relaxed/simple;
	bh=hQh/alPdWirG+fauDX2BRT65avMKmeffGeTFMuJoT9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cgnHmucBtmZnIfij19uFBLgV2prFGo1IAW1ghccYaiiLi0RA2tVKCiePj0CpKS5gRGFX0/taJ1roxF6fDN6jgIUFI0eVfpzjC9/SNDPC+GZcJAkT8RrLDVxFeQknzdegNdBxwIhmj6S3roM8dp3mMb4e10REP6NBRJg6rSDeGbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3ArTb/v; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3ArTb/v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729231108; x=1760767108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hQh/alPdWirG+fauDX2BRT65avMKmeffGeTFMuJoT9M=;
  b=F3ArTb/v4qLqJ7YNGjPQ8NlFJx5wCVZ4GDZFwvazAclMU83hzSX6DGAh
   SdkjidkYTm2xCKE8wJcw9UqL3cB8EBKjDEyt2N/0BcwHcOwmYbPNMhELR
   MKg9AcB+MqU55vs4qyUv69mM6Qy3OjsXu/uk6tV71x/KobT52rnERRTDv
   9tXlvq/l/5OpBVlnNnc6MHMMo9ynrY3SEQcHPm6YOGaOzyaPXH+ZsIPRp
   MpvLNbeICEorOmUUQS/p3fySvHx0NZV7R+GhMDYul82Jz72KcekPi0o3p
   sZP6oBe8OaMU0QCM+4/XR8t8osHG2Ywqch7Qnf3RrQcpnHO5nLTbCgglL
   g==;
X-CSE-ConnectionGUID: C2YMvazZQRut930wBZ4Qjw==
X-CSE-MsgGUID: Qeze3kxPSUGTYyK8rvBVMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="39879123"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="39879123"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 22:58:26 -0700
X-CSE-ConnectionGUID: FWHub406T+S05+lIMpI0dg==
X-CSE-MsgGUID: 6LKb6JYQQ6OA4tC/G/bvuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="78675724"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa009.jf.intel.com with ESMTP; 17 Oct 2024 22:58:26 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	will@kernel.org
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com
Subject: [PATCH v2 1/3] iommu: Add a wrapper for remove_dev_pasid
Date: Thu, 17 Oct 2024 22:58:22 -0700
Message-Id: <20241018055824.24880-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241018055824.24880-1-yi.l.liu@intel.com>
References: <20241018055824.24880-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommu drivers are on the way to drop the remove_dev_pasid op by
extending the blocked_domain to support PASID. However, this cannot be
done in one shot. So far, the Intel iommu and the ARM SMMUv3 driver have
supported it, while the AMD iommu driver has not yet. During this
transition, the IOMMU core needs to support both ways to destroy the
attachment of device/PASID and domain.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f3f81c04b8fb..9266e4ebebc2 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3324,6 +3324,28 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
 
+/*
+ * This is gated by AMD's blocked domain pasid support, it should be
+ * dropped once AMD iommu driver is ready.
+ */
+static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
+				   struct iommu_domain *domain)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_domain *blocked_domain = ops->blocked_domain;
+	int ret = 1;
+
+	if (blocked_domain->ops->set_dev_pasid) {
+		ret = blocked_domain->ops->set_dev_pasid(blocked_domain,
+							 dev, pasid, domain);
+	} else if (ops->remove_dev_pasid) {
+		ops->remove_dev_pasid(dev, pasid, domain);
+		ret = 0;
+	}
+
+	WARN_ON(ret);
+}
+
 static int __iommu_set_group_pasid(struct iommu_domain *domain,
 				   struct iommu_group *group, ioasid_t pasid)
 {
@@ -3342,11 +3364,9 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
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
@@ -3356,11 +3376,9 @@ static void __iommu_remove_group_pasid(struct iommu_group *group,
 				       struct iommu_domain *domain)
 {
 	struct group_device *device;
-	const struct iommu_ops *ops;
 
 	for_each_group_device(group, device) {
-		ops = dev_iommu_ops(device->dev);
-		ops->remove_dev_pasid(device->dev, pasid, domain);
+		iommu_remove_dev_pasid(device->dev, pasid, domain);
 	}
 }
 
-- 
2.34.1

