Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D2A221F16
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478476; cv=none; b=b7l4exDazP9MabL33+jxgTteDsyYHTs8BdgGdopnk/26KgXxEZXDWkZbXSM9lxleRaHah9SC813lsNdpkMdoLqTmrswQc9y1cT6+TqLIblfWlYNNzHrLACo/q6KR9wDn30AuCPzWY3mLTGDTLCXT9iGKUQs+wgtxz/xsLn0oIZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478476; c=relaxed/simple;
	bh=8rc9Q2wEMDfMoMID/+QQHHWVsLCcMyS/j+Qjfwj7dLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i3k+yQArZtCmszx2r+m+jb0+/gU/33BFRJ3wvcmEA4oIsRxqFe5sYsUGhSZmQgS2B9asvy6Bm1tL7+BJqSfkUHyI9d5NYsvDoxERBHcSIUD9ZgcR9JUt/uusdu9EuXrjI3Z19aC9H7v5V4edPHNIvUbb3iNPwwdM71wAIqsiYLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djOnZy7S; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djOnZy7S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742478475; x=1774014475;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8rc9Q2wEMDfMoMID/+QQHHWVsLCcMyS/j+Qjfwj7dLk=;
  b=djOnZy7SYNRFcCItyDuRkwil+/djVrPKsLPGx3K34csBdSKcuJZiz7UY
   Y/IDR9Rz2N+vQXUKuUmhR3QjbkElqcBlpcZYvMFSNte0otIXvoqFCEJLW
   d/25GE4ilqfYNTLyQXG2I3GENjPcLpXAtojmh4MKrLXv7qV1tNxRKim/s
   du/0MRhKQK6kzUy/tRR40L4NvXw95q1z8gm/gWyvKQ0d8bAQfMQvoIFVt
   OfYJUo45G6tsMv35l/PbzTrMjNAQmxkCPJMYFb3+GCNAE/1/WFmNLxZki
   7D2W6BgylWr2lspeuzwmImhXWnD5Y2CRGOFmRPs43t0lIaxbaPj0ivFSe
   Q==;
X-CSE-ConnectionGUID: nwqm8fO4RRu9jSWQf5FzIg==
X-CSE-MsgGUID: n2tLI7V0QtOr9+Qti60bZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="69063072"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="69063072"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:47:48 -0700
X-CSE-ConnectionGUID: aPHRctRcT7ybWrQQ/vnnRg==
X-CSE-MsgGUID: kWdeDhDUSpOmSgpy0GWqcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="160319180"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa001.jf.intel.com with ESMTP; 20 Mar 2025 06:47:48 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v10 12/18] iommufd: Enforce PASID-compatible domain for RID
Date: Thu, 20 Mar 2025 06:47:38 -0700
Message-Id: <20250320134744.5777-13-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320134744.5777-1-yi.l.liu@intel.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
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

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
v9 -> v10: split the hwpt->pasid_compat check to a separate if in the
           else statement.
---
 drivers/iommu/iommufd/device.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 17c424d9a355..54ffef9c17f7 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -514,8 +514,28 @@ static int iommufd_hwpt_pasid_compat(struct iommufd_hw_pagetable *hwpt,
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
 
@@ -526,8 +546,6 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 	struct iommufd_attach_handle *handle;
 	int rc;
 
-	lockdep_assert_held(&idev->igroup->lock);
-
 	rc = iommufd_hwpt_pasid_compat(hwpt, idev, pasid);
 	if (rc)
 		return rc;
-- 
2.34.1

