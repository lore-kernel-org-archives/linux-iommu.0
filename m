Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AA21FBC97
	for <iommu@lists.linux.dev>; Wed, 12 Feb 2025 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340348; cv=none; b=KTCUL/FFCQiOHRIJ6bWng4mlcCPUvgaOnC9Ec2mG/h/JEjRcRCpBercb/etXv1Z3urZMxMzOqBusSq1K4oKaOgDv2NuQ/96MYB4fvxhwSI0ZGPaBgkeC+HB4D5HTcuKaN8aTyIz6dI4Khx/OGzNHBIZI/Dx0hjF3yDg3eLOXgZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340348; c=relaxed/simple;
	bh=8Y/CoGsqxjYpA23LgslA/Nil4YspdQsFWheW2IN0jDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tkUlHMUKvNlV1sjNlO4GYVdI8dCPdnbqsJBDf8SJAyUi4XM6TsrtJ/tZLrotOEra7YAAsbsla9aNC3GV9Ja/QU2/22dgN7SqO3Ok/QAA/mJkLhTxY4bI/nClEipf0dzS/PybzVWk4gTneL+XyallUD/FTeENDu4S+5feX0X4WDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z08HRWka; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z08HRWka"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739340346; x=1770876346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Y/CoGsqxjYpA23LgslA/Nil4YspdQsFWheW2IN0jDw=;
  b=Z08HRWkaN677klky1Iyxu3L8GxsWLDecE6ZJtwTNqJ6eboGYtGl03rZ4
   5TkEXzap0JtjJT3JkWaMyG/gadc0nEC2hifQiWgqcz9z5GHTRnIZ5/TTo
   8cYM9FLhdLQyqtBfZwO9Qx0dfVSyIZMScsns7YNI43KZFNLjQs/AUMYX8
   L5JGvjitHpW2V0B83ZsXhzyz3DJtrMSMFKZcwkEbA1//sB7Z4oQvTqnXi
   dfwJSE4RLOrqQGbO4eY8fDPBhHbF3fRr7jlXtCeLJAvDtL6wltlHrgwaU
   qSSRrcnBL8K82QWCX9JhRZHIkZmJCGR2i/M3M75t/EOIiqxkXr83LcSjF
   g==;
X-CSE-ConnectionGUID: 06hTF+/WSa2D9awS1yuY3Q==
X-CSE-MsgGUID: S6gi6b3zTMe0qRUUX2Byqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="57391244"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="57391244"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 22:05:45 -0800
X-CSE-ConnectionGUID: /pVbclMDTHWeP5+LaDH7jg==
X-CSE-MsgGUID: 1OWJNLHeRcCyDg62gl6arg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117900009"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa005.jf.intel.com with ESMTP; 11 Feb 2025 22:05:44 -0800
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
Subject: [PATCH 4/5] iommu: Swap the order of setting group->pasid_array and calling attach op of iommu drivers
Date: Tue, 11 Feb 2025 22:05:39 -0800
Message-Id: <20250212060540.261436-5-yi.l.liu@intel.com>
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

The current implementation stores group->pasid_array before the underlying
iommu driver has successfully set the new domain. This can lead to issues
where PRIs are received on the new domain before the attach operation is
completed. This patch swaps the order of operations to ensure that the
domain is set in the iommu driver before updating group->pasid_array.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a7ebcbaafb10..d673feab82aa 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3388,13 +3388,21 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 		}
 	}
 
-	ret = xa_insert(&group->pasid_array, pasid, pasid_entry, GFP_KERNEL);
-	if (ret)
+	if (xa_load(&group->pasid_array, pasid)) {
+		ret = -EBUSY;
 		goto out_unlock;
+	}
 
 	ret = __iommu_set_group_pasid(domain, group, pasid);
 	if (ret)
-		xa_erase(&group->pasid_array, pasid);
+		goto out_unlock;
+
+	ret = xa_insert(&group->pasid_array, pasid, pasid_entry, GFP_KERNEL);
+	if (ret) {
+		WARN_ON(ret == -EBUSY);
+		__iommu_remove_group_pasid(group, pasid, domain);
+	}
+
 out_unlock:
 	mutex_unlock(&group->mutex);
 	return ret;
@@ -3510,19 +3518,26 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
 	pasid_entry = iommu_make_pasid_entry(domain, handle);
 
 	mutex_lock(&group->mutex);
-	ret = xa_insert(&group->pasid_array,
-			IOMMU_NO_PASID, pasid_entry, GFP_KERNEL);
-	if (ret)
+	if (xa_load(&group->pasid_array, IOMMU_NO_PASID)) {
+		ret = -EBUSY;
 		goto err_unlock;
+	}
 
 	ret = __iommu_attach_group(domain, group);
 	if (ret)
-		goto err_erase;
+		goto err_unlock;
+
+	ret = xa_insert(&group->pasid_array,
+			IOMMU_NO_PASID, pasid_entry, GFP_KERNEL);
+	if (ret) {
+		WARN_ON(ret == -EBUSY);
+		goto err_remove;
+	}
 	mutex_unlock(&group->mutex);
 
 	return 0;
-err_erase:
-	xa_erase(&group->pasid_array, IOMMU_NO_PASID);
+err_remove:
+	__iommu_group_set_core_domain(group);
 err_unlock:
 	mutex_unlock(&group->mutex);
 	return ret;
-- 
2.34.1

