Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427F22DF8B
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577593; cv=none; b=DWmSQOo4F7/D1Qoab+0sVwtfhWyZEjQbdw3gRgP3kMkx+Gj72jrzPybIMkIYQahOkqKSidquMyYsGsFBHrG2CRKiv12YI0bpgSmH3xmKbXeyd3zLd53DZ9VdegIu/9AniAwey7eSJvKKKo5kvoB63wDZM28+Uo5F3XqgwXN0IYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577593; c=relaxed/simple;
	bh=N5kueN7+u0rT/A9Zf58+wV7S0Wt2kvtoYeCJEdRlOuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pqjLw7tG5brZ1PDn0VMwHQ5E/lf6M38/2fg3WLG2y6NJ/4jEK3jALDHN1F9edyAJacVcrdyB9j1ig7yXz5Wn7CoH5tNPCcE5tvqOHRFiHjJcisk9Lda1Gg4/Fl3tNFPE8XRMZHG095GMthehlWN38VGXyGwSiiXUsl/0MMUg9RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XCFAVPM4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XCFAVPM4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742577592; x=1774113592;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N5kueN7+u0rT/A9Zf58+wV7S0Wt2kvtoYeCJEdRlOuc=;
  b=XCFAVPM4wj082aHNumAkZRh6JmPzTKeEZ14iGfV1156zPeOYSldtuBPh
   Ad74tW1RFkDrCaOxGyuEBszBCjeWYfIbgHGyDDCmIG7t8rIXtElZ8wh6m
   fAC9UvdeZ0nKslQg2zzwZPtCRRk9ZSqAseI67tU96ON/JDy/kvREFqy4s
   7SmMFUqhbQTbf3AX/w5qr+3yX0Nga0NcJtgWvEViq2lLkHV4mBvKlb2Sh
   8StrnxF3ePlsrGon9RCLfLGk25Phrs4popl4MpJh9Wolm27qfc7C1Ky6F
   MujaZo8QpQ6gk5ZluYh4EQuJyJ4hpIg/afiRXCh098ll8bPREuPz0Pr7u
   w==;
X-CSE-ConnectionGUID: /O0EGCpbRJq3YsAfzlJJqw==
X-CSE-MsgGUID: QQ8HDGDVQ/OtKnsd0N5ejw==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43976827"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43976827"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:19:47 -0700
X-CSE-ConnectionGUID: W253yVE9SsahBmVSox+HqA==
X-CSE-MsgGUID: sqWwsUPqSmOm00gkK9YaEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123914506"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa010.fm.intel.com with ESMTP; 21 Mar 2025 10:19:46 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v11 12/18] iommufd: Enforce PASID-compatible domain for RID
Date: Fri, 21 Mar 2025 10:19:34 -0700
Message-Id: <20250321171940.7213-13-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321171940.7213-1-yi.l.liu@intel.com>
References: <20250321171940.7213-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per the definition of IOMMU_HWPT_ALLOC_PASID, iommufd needs to enforce
the RID to use PASID-compatible domain if PASID has been attached, and
vice versa. The PASID path has already enforced it. This adds the
enforcement in the RID path.

This enforcement requires a lock across the RID and PASID attach path,
the idev->igroup->lock is used as both the RID and the PASID path holds
it.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 4cc6de03f76e..1605f6c0e1ee 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -399,8 +399,28 @@ static int iommufd_hwpt_pasid_compat(struct iommufd_hw_pagetable *hwpt,
 				     struct iommufd_device *idev,
 				     ioasid_t pasid)
 {
-	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
-		return -EINVAL;
+	struct iommufd_group *igroup = idev->igroup;
+
+	lockdep_assert_held(&igroup->lock);
+
+	if (pasid == IOMMU_NO_PASID) {
+		unsigned long start = IOMMU_NO_PASID;
+
+		if (!hwpt->pasid_compat &&
+		    xa_find_after(&igroup->pasid_attach,
+				  &start, UINT_MAX, XA_PRESENT))
+			return -EINVAL;
+	} else {
+		struct iommufd_attach *attach;
+
+		if (!hwpt->pasid_compat)
+			return -EINVAL;
+
+		attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
+		if (attach && attach->hwpt && !attach->hwpt->pasid_compat)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -411,8 +431,6 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 	struct iommufd_attach_handle *handle;
 	int rc;
 
-	lockdep_assert_held(&idev->igroup->lock);
-
 	rc = iommufd_hwpt_pasid_compat(hwpt, idev, pasid);
 	if (rc)
 		return rc;
-- 
2.34.1

