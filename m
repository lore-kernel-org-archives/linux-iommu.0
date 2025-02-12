Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA42B9BC
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 06:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340345; cv=none; b=FTZ81/lLhkk1JNa5baDCOFJ6Eb4nxOQRPWxv8s5IwHfqcUww5S9RvhwQodUJACc1rSQnxPHf0kKvMIRTGmWIb6URpFqLObqR5fps3y0XUgu6BZCMhxlb2f/1UzjzS7LPGj+rBZhpXzZkAwt0JHpBnTOBMoXrIztp+EEHWOPo3Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340345; c=relaxed/simple;
	bh=yL1s4YqnHuxLOJmTpA02xK/i38exqIpukcsZlfrR8IM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZNciwtTakK15p6whCBnCvhAlIvJnwhZbu1L0S35JsSMrV0QWp8KKmWg+1jaHM7KOx+MQuesuNMWFyAAZfb8tFlR0EA9T22VIza6VT6R0Z5zJVfZooJp1jet/1WOIv8OpH0ojO6Mmn1/1S5lQnasbTlgru9ByMJ10I1r/dN56AXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHT6OjIL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHT6OjIL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739340344; x=1770876344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yL1s4YqnHuxLOJmTpA02xK/i38exqIpukcsZlfrR8IM=;
  b=JHT6OjILYvkdh6gJxC4i3nkSpOad2M45ApJ8Rq+rzmiWfJvhGv8JoK4R
   aIbYuc88krWn6Yaf4cLK37TavoGYe0lIOaFc/AxzuxtcaxafR+Z7HhZlv
   LCnjvg1/IfbuPtHAO5HUumgiKac4XFeKsevH7rgDqASvZOJqUltxXfyUJ
   qKEc3Bh6RHBapUHStamrvO8mrT+zAuvgUNgejCPj6Mg60TnW1bYa0ffX+
   9wQZPFQx2BHyGVaVlPh63AbB+6c/vcz97Vo7VKo7nTNAPt4k/jza0UyC5
   Y2q0eiJEUJbcPRB9oVpIul2CHpp6yOzy633QndSQF2+0oqdXpqN2B2mu1
   A==;
X-CSE-ConnectionGUID: YA9c4tQuRYyBWvZpF2ENKQ==
X-CSE-MsgGUID: 7FBQ9ClHSAy9ZSvvqppjXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="57391224"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="57391224"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:05:43 -0800
X-CSE-ConnectionGUID: X7EiZCviSuuVk30QhqOawQ==
X-CSE-MsgGUID: ZUnkF6+6QMe4gQlAcWnfDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117899990"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa005.jf.intel.com with ESMTP; 11 Feb 2025 22:05:43 -0800
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
Subject: [PATCH 1/5] iommu: Make @handle mandatory in iommu_{attach|replace}_group_handle()
Date: Tue, 11 Feb 2025 22:05:36 -0800
Message-Id: <20250212060540.261436-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212060540.261436-1-yi.l.liu@intel.com>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Caller of the two APIs always provide a valid handle, make @handle as
mandatory parameter.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 870c3cdbd0f6..eef7e19c547d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3511,8 +3511,10 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
 {
 	int ret;
 
-	if (handle)
-		handle->domain = domain;
+	if (!handle)
+		return -EINVAL;
+
+	handle->domain = domain;
 
 	mutex_lock(&group->mutex);
 	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
@@ -3568,16 +3570,15 @@ int iommu_replace_group_handle(struct iommu_group *group,
 	void *curr;
 	int ret;
 
-	if (!new_domain)
+	if (!new_domain || !handle)
 		return -EINVAL;
 
+	handle->domain = new_domain;
+
 	mutex_lock(&group->mutex);
-	if (handle) {
-		ret = xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);
-		if (ret)
-			goto err_unlock;
-		handle->domain = new_domain;
-	}
+	ret = xa_reserve(&group->pasid_array, IOMMU_NO_PASID, GFP_KERNEL);
+	if (ret)
+		goto err_unlock;
 
 	ret = __iommu_group_set_domain(group, new_domain);
 	if (ret)
-- 
2.34.1

