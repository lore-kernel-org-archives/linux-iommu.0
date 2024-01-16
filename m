Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A9A20DC3
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 01:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTWhsRyA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705367584; x=1736903584;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WfkjbHyfE98xx41wNo+YDA94wowbF1a/Cq2H7tjnKx4=;
  b=kTWhsRyAhLIcURGr4HpduB2vYJqyGlTzdEiPWFgy7yWieG9uFMG5HYmL
   1u76v0rRjx9PWgrQqA8EoIVdAWce2t79HfDijPvX+oMgkvWvA0jfyV8ot
   juawYfNEN9pLg7p7LpxpNBflEiJFaMo0hnZ4YgI49HamehPMxqfcW5L5o
   NvuGcRPoTYpzWrxcwB4TFRQfw+YUezLsdFX050c2WOfb5mcGZPZ+QB2jZ
   EpFcVUPPC5IGQuJRM9kL54mbOW326zNk0bJSPqScRQOIgtC+U/C8WLB/j
   0i5zGRh59B4wwggAjVjQxWB2Umrmnq2tjoAoktA2K5eQXYc16vhJzsFzH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="464004424"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="464004424"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 17:13:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10954"; a="733427353"
X-IronPort-AV: E=Sophos;i="6.04,197,1695711600"; 
   d="scan'208";a="733427353"
Received: from kechen-optiplex-9020.bj.intel.com ([10.238.157.62])
  by orsmga003.jf.intel.com with ESMTP; 15 Jan 2024 17:12:59 -0800
From: Tina Zhang <tina.zhang@intel.com>
To: iommu@lists.linux.dev
Cc: Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH 05/11] iommu: Add ops->domain_alloc_sva()
Date: Tue, 16 Jan 2024 09:11:40 +0800
Message-Id: <20240116011146.18645-6-tina.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240116011146.18645-1-tina.zhang@intel.com>
References: <20240116011146.18645-1-tina.zhang@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

From: Jason Gunthorpe <jgg@nvidia.com>

Make a new op that receives the device and the mm_struct that the SVA
domain should be created for. Unlike domain_alloc_paging() the dev
argument is never NULL here.

This allows drivers to fully initialize the SVA domain and allocate the
mmu_notifier during allocation. It allows the notifier lifetime to follow
the lifetime of the iommu_domain.

Since we have only one call site, upgrade the new op to return ERR_PTR
instead of NULL.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
[Updated domain owner and removed smmu3 related changes - Vasant]
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/iommu-sva.c | 16 +++++++++++-----
 include/linux/iommu.h     |  3 +++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index b51995b4fe90..c2e3a083ea43 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -99,8 +99,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 	/* Allocate a new domain and set it on device pasid. */
 	domain = iommu_sva_domain_alloc(dev, mm);
-	if (!domain) {
-		ret = -ENOMEM;
+	if (IS_ERR(domain)) {
+		ret = PTR_ERR(domain);
 		goto out_free_handle;
 	}
 
@@ -266,9 +266,15 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_domain *domain;
 
-	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
-	if (!domain)
-		return NULL;
+	if (ops->domain_alloc_sva) {
+		domain = ops->domain_alloc_sva(dev, mm);
+		if (IS_ERR(domain))
+			return domain;
+	} else {
+		domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
+		if (!domain)
+			return ERR_PTR(-ENOMEM);
+	}
 
 	domain->type = IOMMU_DOMAIN_SVA;
 	mmgrab(mm);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2f765ae06021..4cee5b22524c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -454,6 +454,7 @@ static inline int __iommu_copy_struct_from_user(
  *                     Upon failure, ERR_PTR must be returned.
  * @domain_alloc_paging: Allocate an iommu_domain that can be used for
  *                       UNMANAGED, DMA, and DMA_FQ domain types.
+ * @domain_alloc_sva: Allocate an iommu_domain for Shared Virtual Addressing.
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
@@ -494,6 +495,8 @@ struct iommu_ops {
 		struct device *dev, u32 flags, struct iommu_domain *parent,
 		const struct iommu_user_data *user_data);
 	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
+	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
+						 struct mm_struct *mm);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
-- 
2.39.3

