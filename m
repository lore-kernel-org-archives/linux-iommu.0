Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1EA20FAA1
	for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148420; cv=none; b=kD19PnbFvmI89tCqtRDr4VQfxXdkdLCxlpGel5W9EC7uySaEReQ4eB44vGRQdTroXKUcsoOwdn5aDaoRPRRoNq6WhIr6+0f2bfw7egvjD/OZuHhJvBgJRQP5yK2jU+2euIS1BxFFe/KBzg+sx5RVlwkkyNPSXchFe+cGBIkQlpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148420; c=relaxed/simple;
	bh=OMpZHtkWSQ7nIo9B3V50+88BLqJEk3PwwOhMC9Fyi/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kqYZlZ2B0ULPNrSFYMc2P5OHEeOAkyvRggTY8KCd74OCb6fosOWFdfKp9+43BbT9J4wJdZtG7UVNM0/DPs45Ojb7GWXNjuTg+duDNDQ4oeI2sC0ofatWHwf/wswKhKfi4sUhuhm8NDC3C0QuSosXk2wZOzMgvLPQALrbDzeEdhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYggRcnT; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYggRcnT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740148418; x=1771684418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OMpZHtkWSQ7nIo9B3V50+88BLqJEk3PwwOhMC9Fyi/4=;
  b=IYggRcnTXX1weD61hlP3kaeDrp9a7e53OK26FTSGd3+v3SFBS7t16tQw
   urZlPEKdsq9iRCHBQUZB1eKoU89YDJmrgchRltvEKzh4fulobRMbnFL9L
   gIjBBYg61IMMwCaqFrzAywReo1OLUOwfFMRl41kUw4/KbxQ5MmjxUW2le
   66EBSHtu0PwCohbcHVl5H41MLSKbcIcuS8LXSMI2sClmBDkEACINYDUJY
   5yvqO8ZKCm6OQD52RvFPeUvMxaI7VL7WKgwythDxR6/23DNXwLjdihHjp
   YzSmcVdAvtqvN+jag/ZifF6SIizQvhlIYUZpgNF4ms8eZIba+uOrNMDdO
   A==;
X-CSE-ConnectionGUID: TvpcSK+ERN+q8g+mU7pDdg==
X-CSE-MsgGUID: oywKu+TcRReP9X0xJOqaKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="63441042"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="63441042"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 06:33:37 -0800
X-CSE-ConnectionGUID: K29KnPC/R3i9CdgAvGdv3A==
X-CSE-MsgGUID: LNCB7bdBSE6Z7sFAQxr3pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115887156"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 21 Feb 2025 06:33:38 -0800
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
Subject: [PATCH v2 1/4] iommu: Make @handle mandatory in iommu_{attach|replace}_group_handle()
Date: Fri, 21 Feb 2025 06:33:32 -0800
Message-Id: <20250221143335.49874-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221143335.49874-1-yi.l.liu@intel.com>
References: <20250221143335.49874-1-yi.l.liu@intel.com>
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

