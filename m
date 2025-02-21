Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5637720FAB7
	for <iommu@lists.linux.dev>; Fri, 21 Feb 2025 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740148421; cv=none; b=OSKr52FRU+4eJTZ88E5WccwTgCKKNknHL0Xj83NagnJMO30/KImELekcdtdlwYcvkq6HIPkhlWnesFOWgIvulzQ5sHX1wOwx1uOtUJZBw0LaZw8nW6PmgHpSHP/lIPuZFLOg6J2hPAeEeagFX5WNzOcNwEzVa4CWNEW+5U7lsBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740148421; c=relaxed/simple;
	bh=5EWjKuLjEvFlW7+441/ckbjb6bPpeNlh1wzVujDdJWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a4PPr1ji54ccL9DScgKunaEbc6/oUn0VHPx4L6MP/uDO5y5avMkGZp6LtpBykbB062+5LfQBmZ40ag8I2OUqjTzhfUaJG7+O2CMFFQWmr0Mm/hbtzKIr/FAyzSTkxf6asPSIrSrbzaqxpac06gLd5dgyoGE16DjtxT/1NV0k0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8gOKwlt; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8gOKwlt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740148420; x=1771684420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5EWjKuLjEvFlW7+441/ckbjb6bPpeNlh1wzVujDdJWA=;
  b=X8gOKwltFTLr4YagTNywSBoMTHphOyTsggOlX2VnXGXH2wr4rOC4VHwM
   KdTorG/neOmogUpW6T4+s6a3tiXQkq9PyVSajbPgjbMSuaUpepF79LRKU
   KJyTcg4BMB/65FeFs+E5+2+Dz8brnoX56CZHLI3NbxwQ5ptktogXBIEmp
   rLt0YpUiBjLTxDA4hyerkSE95EM72Mqjed6mSDGfkaDSq48X3CU1aYdH1
   z4bflxvsmUK6qUOU6ZpdDEbZqYBGnypzrlfglVdrZCWEK6UYsj/lyBB0m
   g6t5RTc4EBrIA0/AJm5jZFopLR2Sc269kvpe68WDNEMptfBGBTuhfrFcK
   A==;
X-CSE-ConnectionGUID: sdmAYDUYSJeQIb3I6llSbw==
X-CSE-MsgGUID: jUIxZi6ES7appjgZEHsRSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11352"; a="63441061"
X-IronPort-AV: E=Sophos;i="6.13,305,1732608000"; 
   d="scan'208";a="63441061"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 06:33:39 -0800
X-CSE-ConnectionGUID: 7uh63yWTSCOTWmT7Y3agfA==
X-CSE-MsgGUID: HVqm1erVRsmwis2IhzgZDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115887177"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 21 Feb 2025 06:33:40 -0800
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
Subject: [PATCH v2 4/4] iommu: Swap the order of setting group->pasid_array and calling attach op of iommu drivers
Date: Fri, 21 Feb 2025 06:33:35 -0800
Message-Id: <20250221143335.49874-5-yi.l.liu@intel.com>
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

The current implementation stores entry to the group->pasid_array before
the underlying iommu driver has successfully set the new domain. This can
lead to issues where PRIs are received on the new domain before the attach
operation is completed.

This patch swaps the order of operations to ensure that the domain is set
in the underlying iommu driver before updating the group->pasid_array.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 44 +++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index eff5f678883b..73555e1cf016 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3388,13 +3388,25 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 
 	entry = iommu_make_pasid_array_entry(domain, handle);
 
-	ret = xa_insert(&group->pasid_array, pasid, entry, GFP_KERNEL);
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
@@ -3509,19 +3521,27 @@ int iommu_attach_group_handle(struct iommu_domain *domain,
 
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

