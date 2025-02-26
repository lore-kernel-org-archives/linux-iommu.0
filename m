Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B944032C8B
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 01:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532734; cv=none; b=o8VzS62W4hQNSWhLtPuGnDE8fLWfyFZa7cafW4XCkOBQerG6ZZ2RYen4IIy5YLxF0I5wJOdRU42lCQmm8/tpdbiDGeSKSzUQzjXB4bcjHiqab14W6BzZLPBX+hqC6P4KIptqfVcWoLlaQXPH4GkHzIvObO2S96LEsrDUZS9IrVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532734; c=relaxed/simple;
	bh=+LsfqUDiJzon8KRS007gdndgpyMsWqiFGKf123XdQJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hb3de75pmpLvr6Bnc2Yeq2P/HMYl5NM4JYXiYDWuBxSPWy1WLqzjYg7ydyXkQXB9GDZ2YyVE+e1jw3O1CjKDpvGjQZLBwYvfKg7WSxxoSXJ/qtOJPqZr2yR9D3MuBTfwNLcvNL34Hu6u4LVg/qj8nCOVHBgvLX5NNnmFfY6FhuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F5uHSnV5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F5uHSnV5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740532733; x=1772068733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+LsfqUDiJzon8KRS007gdndgpyMsWqiFGKf123XdQJs=;
  b=F5uHSnV5hns4i3bA/N1sTtnWuG/Z8E1pCHH601C/467Ny+yqNXZ0udYC
   rZkaAiTFa/Q1/IR00p1wPdzbPkySSLzSK6bYQtclLdzSEBIK9iya6b+J6
   vl+yzB0s+nTkLehM4/wPbtkEgg/mrOFc396M09DMOrhmjHzeB/ZNLxvX3
   7N49h67lLuXUF5Chr9tY8Twpxzc4cqevtqea6+FSE4lTO4sZwMDZaKaC9
   kALDZAUvK3amEqZitJJeQz5VtnAXR4OgWW5/Zytnh1+EwnUmmg8KOWRuw
   mnKe2/7AU6JO1/Fq/3gQjfJEyOSr2OUgUk/fhxGRzb+oFoS4WIfxHHJdS
   w==;
X-CSE-ConnectionGUID: XkRAlmFRQCmG4mZ/TrhwZQ==
X-CSE-MsgGUID: xDlv08i3T7CRfmBp/bj0WQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="45015862"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="45015862"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:18:51 -0800
X-CSE-ConnectionGUID: TqGIso0kQrqjA4GJ3XoJhg==
X-CSE-MsgGUID: guzlFdioQCyV6X5YtnDsgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="116563252"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa006.jf.intel.com with ESMTP; 25 Feb 2025 17:18:52 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com
Cc: kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	robin.murphy@arm.com,
	nicolinc@nvidia.com,
	will@kernel.org
Subject: [PATCH v3 1/4] iommu: Make @handle mandatory in iommu_{attach|replace}_group_handle()
Date: Tue, 25 Feb 2025 17:18:46 -0800
Message-Id: <20250226011849.5102-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226011849.5102-1-yi.l.liu@intel.com>
References: <20250226011849.5102-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Caller of the two APIs always provide a valid handle, make @handle as
mandatory parameter. Take this chance incoporate the handle->domain
set under the protection of group->mutex in iommu_attach_group_handle().

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 870c3cdbd0f6..715bdb8af31b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3511,10 +3511,11 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (handle)
-		handle->domain = domain;
+	if (!handle)
+		return -EINVAL;
 
 	mutex_lock(&group->mutex);
+	handle->domain = domain;
 	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
 	if (ret)
 		goto err_unlock;
@@ -3568,16 +3569,14 @@ int iommu_replace_group_handle(struct iommu_group *group,
 	void *curr;
 	int ret;
 
-	if (!new_domain)
+	if (!new_domain || !handle)
 		return -EINVAL;
 
 	mutex_lock(&group->mutex);
-	if (handle) {
-		ret = xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);
-		if (ret)
-			goto err_unlock;
-		handle->domain = new_domain;
-	}
+	handle->domain = new_domain;
+	ret = xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);
+	if (ret)
+		goto err_unlock;
 
 	ret = __iommu_group_set_domain(group, new_domain);
 	if (ret)
-- 
2.34.1

