Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29B6151991
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 01:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532739; cv=none; b=pr+Clj8SSVQB/HiC/8HegaRR/Aq1O6GxWZWBfCnVTBxX/LZ4P3xogBNW1WSFePRhIYyCzFi/nTHRxmb76nsfTyemdcZlVY4FJLRHYZZbjP0j9/3glNJCjVd5f1vAc0uAtSx/sauCuUL+CyXt5Z72WRNwhp4n8XtlSogL4o6SlTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532739; c=relaxed/simple;
	bh=s9cdmMq+v/9ceqPgy0BYcIxnrpYWevj5iU2RLqlaAh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=irXF1DPOA8vZT5Ezoa7qiS01ixpZKSNEMTELh7FN3R78xNnuGCaI2PJ6Teo4OHHHmahVwOvAG8t/AA7I7i9e9QZfRXHExRytOOk6T3gG+mzAPL/sQek4lbp0ubkDPrM0VQXE+PbHMwugVwZr3IZWlfayhJ85ASBs86kIZjL5L8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdYFxqvW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdYFxqvW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740532735; x=1772068735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s9cdmMq+v/9ceqPgy0BYcIxnrpYWevj5iU2RLqlaAh8=;
  b=fdYFxqvWc9PxAghU/YWzmULmu0NqNUchFX+zcklNMLOXUTg+XTt6G+4F
   BtvYXXXgyHTNRS1jdfThaoZ+WsFgvWqxgaY8buAzoBeabuPoQO/f9/0PU
   GI6Snas2j4FwXXJjkb6FyDCOjw+WFWds/MK31/02tpeDDY/j3AWJddbA3
   4YN/77TqhdqSQVnFw9O4ctxkPJelI6c6JLdFUNmeVjQfx6xiuJBAHo2Gh
   WuyJJ0e57+rmhK7L96DIQry5F1Q580zI+Llga85u9OE09OIP9Gb74wsPy
   rWXSYJLB7cBDOcwjfjhx04tn0UdbmVQv6es1EvDep8t7kmjziDJuSqcaq
   g==;
X-CSE-ConnectionGUID: UXPpZJrDT4Sn8rYZ/YvnVg==
X-CSE-MsgGUID: Oczp83npTVaFhyJ9KQrbnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="45015879"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="45015879"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:18:52 -0800
X-CSE-ConnectionGUID: M2vWzqfYS1u9fhKxV1/syQ==
X-CSE-MsgGUID: KWYm9xKFS0egYkKzFd8VjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="116563262"
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
Subject: [PATCH v3 4/4] iommu: Swap the order of setting group->pasid_array and calling attach op of iommu drivers
Date: Tue, 25 Feb 2025 17:18:49 -0800
Message-Id: <20250226011849.5102-5-yi.l.liu@intel.com>
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

The current implementation stores entry to the group->pasid_array before
the underlying iommu driver has successfully set the new domain. This can
lead to issues where PRIs are received on the new domain before the attach
operation is completed.

This patch swaps the order of operations to ensure that the domain is set
in the underlying iommu driver before updating the group->pasid_array.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 48 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index f9884a5cdeca..73a3b20b2ef9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3388,13 +3388,29 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 
 	entry = iommu_make_pasid_array_entry(domain, handle);
 
-	ret = xa_insert(&group->pasid_array, pasid, entry, GFP_KERNEL);
+	/*
+	 * Entry present is a failure case. Use xa_insert() instead of
+	 * xa_reserve().
+	 */
+	ret = xa_insert(&group->pasid_array, pasid, XA_ZERO_ENTRY, GFP_KERNEL);
 	if (ret)
 		goto out_unlock;
 
 	ret = __iommu_set_group_pasid(domain, group, pasid);
-	if (ret)
-		xa_erase(&group->pasid_array, pasid);
+	if (ret) {
+		xa_release(&group->pasid_array, pasid);
+		goto out_unlock;
+	}
+
+	/*
+	 * The xa_insert() above reserved the memory, and the group->mutex is
+	 * held, this cannot fail. The new domain cannot be visible until the
+	 * operation succeeds as we cannot tolerate PRIs becoming concurrently
+	 * queued and then failing attach.
+	 */
+	WARN_ON(xa_is_err(xa_store(&group->pasid_array,
+				   pasid, entry, GFP_KERNEL)));
+
 out_unlock:
 	mutex_unlock(&group->mutex);
 	return ret;
@@ -3509,19 +3525,27 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
 
 	mutex_lock(&group->mutex);
 	entry = iommu_make_pasid_array_entry(domain, handle);
-	ret = xa_insert(&group->pasid_array, IOMMU_NO_PASID, entry, GFP_KERNEL);
+	ret = xa_insert(&group->pasid_array,
+			IOMMU_NO_PASID, XA_ZERO_ENTRY, GFP_KERNEL);
 	if (ret)
-		goto err_unlock;
+		goto out_unlock;
 
 	ret = __iommu_attach_group(domain, group);
-	if (ret)
-		goto err_erase;
-	mutex_unlock(&group->mutex);
+	if (ret) {
+		xa_release(&group->pasid_array, IOMMU_NO_PASID);
+		goto out_unlock;
+	}
 
-	return 0;
-err_erase:
-	xa_erase(&group->pasid_array, IOMMU_NO_PASID);
-err_unlock:
+	/*
+	 * The xa_insert() above reserved the memory, and the group->mutex is
+	 * held, this cannot fail. The new domain cannot be visible until the
+	 * operation succeeds as we cannot tolerate PRIs becoming concurrently
+	 * queued and then failing attach.
+	 */
+	WARN_ON(xa_is_err(xa_store(&group->pasid_array,
+				   IOMMU_NO_PASID, entry, GFP_KERNEL)));
+
+out_unlock:
 	mutex_unlock(&group->mutex);
 	return ret;
 }
-- 
2.34.1

