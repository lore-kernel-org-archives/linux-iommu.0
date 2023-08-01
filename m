Received: from mgamail.intel.com (unknown [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC32111C
	for <iommu@lists.linux.dev>; Tue,  1 Aug 2023 06:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690871620; x=1722407620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+iHkZBSN+1bzr7JDBFw7QGjlsGH/4tNigpjWZLTIazU=;
  b=bLidYF3pHk0oXyiCyGGBqg/upJ32eSfxryAS6Dw7l3GMtlkC5kW447Gf
   ZP+Hq/9gp1nX7GiWzr2YPLWxW3hTiLAKXmOAoCXxLNc0+vluBBKuxxFVo
   X/zTAFsvmmcZW1UwAZCsn/KYhnofXlAOnhYwqunBE9YOikI4fIJGT9UDT
   8zMnJ6lXQ9b+TV6+7ulS8SNqrE9beavQTq4G7QqdWw39Abed8Ukn5gcxx
   8xCvTcTAAMAle0z4vl5nIW3nVvJ0jlFiI4LKD36P9W/nqRhw7KjlrBKgV
   UM7Kn1sBL+Tb5oLBS3fuGFZINVq9zGZhDrvrcwyEeUuBeQs4PnU58ndj5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="372839973"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="372839973"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 23:33:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="798537916"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="798537916"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jul 2023 23:33:37 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/2] iommu: Consolidate pasid dma ownership check
Date: Tue,  1 Aug 2023 14:31:24 +0800
Message-Id: <20230801063125.34995-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801063125.34995-1-baolu.lu@linux.intel.com>
References: <20230801063125.34995-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When switching device DMA ownership, it is required that all the device's
pasid DMA be disabled. This is done by checking if the pasid array of the
group is empty. Consolidate all the open code into a single helper. No
intentional functionality change.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4352a149a935..1a8fb30341e6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3034,6 +3034,17 @@ static bool iommu_is_default_domain(struct iommu_group *group)
 	return false;
 }
 
+/*
+ * Assert no PASID DMA when claiming or releasing group's DMA ownership.
+ * The iommu_xxx_device_pasid() interfaces are only for device drivers
+ * that have claimed the DMA ownership. Otherwise, it's a driver bug.
+ */
+static void assert_pasid_dma_ownership(struct iommu_group *group)
+{
+	lockdep_assert_held(&group->mutex);
+	WARN_ON(!xa_empty(&group->pasid_array));
+}
+
 /**
  * iommu_device_use_default_domain() - Device driver wants to handle device
  *                                     DMA through the kernel DMA API.
@@ -3052,14 +3063,14 @@ int iommu_device_use_default_domain(struct device *dev)
 
 	mutex_lock(&group->mutex);
 	if (group->owner_cnt) {
-		if (group->owner || !iommu_is_default_domain(group) ||
-		    !xa_empty(&group->pasid_array)) {
+		if (group->owner || !iommu_is_default_domain(group)) {
 			ret = -EBUSY;
 			goto unlock_out;
 		}
 	}
 
 	group->owner_cnt++;
+	assert_pasid_dma_ownership(group);
 
 unlock_out:
 	mutex_unlock(&group->mutex);
@@ -3084,7 +3095,8 @@ void iommu_device_unuse_default_domain(struct device *dev)
 		return;
 
 	mutex_lock(&group->mutex);
-	if (!WARN_ON(!group->owner_cnt || !xa_empty(&group->pasid_array)))
+	assert_pasid_dma_ownership(group);
+	if (!WARN_ON(!group->owner_cnt))
 		group->owner_cnt--;
 
 	mutex_unlock(&group->mutex);
@@ -3118,8 +3130,7 @@ static int __iommu_take_dma_ownership(struct iommu_group *group, void *owner)
 {
 	int ret;
 
-	if ((group->domain && group->domain != group->default_domain) ||
-	    !xa_empty(&group->pasid_array))
+	if (group->domain && group->domain != group->default_domain)
 		return -EBUSY;
 
 	ret = __iommu_group_alloc_blocking_domain(group);
@@ -3129,8 +3140,10 @@ static int __iommu_take_dma_ownership(struct iommu_group *group, void *owner)
 	if (ret)
 		return ret;
 
+	assert_pasid_dma_ownership(group);
 	group->owner = owner;
 	group->owner_cnt++;
+
 	return 0;
 }
 
@@ -3206,10 +3219,10 @@ EXPORT_SYMBOL_GPL(iommu_device_claim_dma_owner);
 
 static void __iommu_release_dma_ownership(struct iommu_group *group)
 {
-	if (WARN_ON(!group->owner_cnt || !group->owner ||
-		    !xa_empty(&group->pasid_array)))
+	if (WARN_ON(!group->owner_cnt || !group->owner))
 		return;
 
+	assert_pasid_dma_ownership(group);
 	group->owner_cnt = 0;
 	group->owner = NULL;
 	__iommu_group_set_domain_nofail(group, group->default_domain);
-- 
2.34.1

