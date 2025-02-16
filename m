Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3757C1304BA
	for <iommu@lists.linux.dev>; Sun, 16 Feb 2025 03:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739677957; cv=none; b=Zt202F8JRRocPbtvaXa1N3+BOEr5DAcfp6D/FzRS17KhD1d/arm7rPK7+WpZuGswz4Ncwt7DoaAVHrD0KK0om3oYZnWeIIgpDU4tNA1Dms/LR2MlzH2FMnKPksxQVO4Zx56bG+32Y9UXNULc/0Wuo4Npoa6DcwaAtnh6mOlkzDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739677957; c=relaxed/simple;
	bh=/bJfwctC8lUUgU0M/8hG62WnG5qAAa9a66BW8jU4qWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oi+Y4OSuyGY5DFPzTVoUV3oinxGHNNxeJ6BTXStZe/nSNNuItU2cZpGKGcgQXbIlbAjZe1YRzcRWS+3edaKlBWQA7Ts23MsfwmgJ9d6n0vB8TT03cB0/saXPMsl4Cf1uu7PCTJ0HxECELAKc0NqYWnd2cXkav4d4gPTUzKFneyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VppLqozo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VppLqozo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739677956; x=1771213956;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/bJfwctC8lUUgU0M/8hG62WnG5qAAa9a66BW8jU4qWU=;
  b=VppLqozoItVihKl1OvNiHfn+hahwPVAGtvnnelBGHsDdNcYrDjUlIPqo
   AdjUJnXNpfk34LSAgDmNv4GZH8c8Iu8om7ZW70ufzsVtI3EXPDY0hoBAb
   WXJxPVDFcHhvE4zwW9zwRqvQdBmGSenrBf+gPWMBGmbhiAMyIH5A9WmtW
   sKITn/Zom3PakskiGsBn3B3NKbpDqYks5eYbtc4m6H8WtiZrjrMuV6Jfc
   7MrfHMDWb1NQgH1ZvPBtMx7SArqMCboxDHdzCUYmfQSMB8S5urw81goF3
   V5LLCJeHwl4S+8DE+W9YbKPjXHspAfhwWeXeWFK4aAvO38UKedwsUhFaR
   A==;
X-CSE-ConnectionGUID: kXreKR7FS+ev2b7zGYBe+Q==
X-CSE-MsgGUID: A6uZftFDSYmqwMTHc3Ez6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="57919333"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="57919333"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 19:52:34 -0800
X-CSE-ConnectionGUID: StvaeB7vRTCPpLHsgtgCPA==
X-CSE-MsgGUID: HgYu4qmnTLaR8fdgXM12aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="113544737"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa009.jf.intel.com with ESMTP; 15 Feb 2025 19:52:35 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	jgg@nvidia.com
Cc: yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	robin.murphy@arm.com,
	nicolinc@nvidia.com,
	will@kernel.org,
	vasant.hegde@amd.com
Subject: [PATCH v7 07/13] iommufd: Enforce PASID-compatible domain for RID
Date: Sat, 15 Feb 2025 19:52:22 -0800
Message-Id: <20250216035228.23831-8-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216035228.23831-1-yi.l.liu@intel.com>
References: <20250216035228.23831-1-yi.l.liu@intel.com>
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
 drivers/iommu/iommufd/device.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 30dd2f79491a..e0f097b04467 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -357,6 +357,22 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 
 /* The device attach/detach/replace helpers for attach_handle */
 
+static int iommufd_hwpt_pasid_compat(struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_device *idev,
+				     ioasid_t pasid)
+{
+	lockdep_assert_held(&idev->igroup->lock);
+
+	if (pasid == IOMMU_NO_PASID &&
+	    !xa_empty(&idev->pasid_hwpts) && !hwpt->pasid_compat)
+		return -EINVAL;
+
+	if (pasid != IOMMU_NO_PASID &&
+	    (!idev->igroup->hwpt->pasid_compat || !hwpt->pasid_compat))
+		return -EINVAL;
+	return 0;
+}
+
 int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 			       struct iommufd_device *idev,
 			       ioasid_t pasid)
@@ -364,10 +380,9 @@ int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 	struct iommufd_attach_handle *handle;
 	int rc;
 
-	lockdep_assert_held(&idev->igroup->lock);
-
-	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
-		return -EINVAL;
+	rc = iommufd_hwpt_pasid_compat(hwpt, idev, pasid);
+	if (rc)
+		return rc;
 
 	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
 	if (!handle)
@@ -441,8 +456,9 @@ int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	struct iommufd_attach_handle *handle, *old_handle;
 	int rc;
 
-	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
-		return -EINVAL;
+	rc = iommufd_hwpt_pasid_compat(hwpt, idev, pasid);
+	if (rc)
+		return rc;
 
 	old_handle = iommufd_device_get_attach_handle(idev, pasid);
 
-- 
2.34.1

