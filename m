Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55262221F26
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478477; cv=none; b=Mt0sAEBBiawpDP3NWfgHbvUt89nea40faJCSmxbKVwFoUrulLzRLifPBav0n9EBitXsD88ImybeXriDF5dGdg0X0Ftww63CfCk++WhkKlgTvz5pWEGFLRc73WaJTFwWrKejHybQM83viCdaKVHY4FTwA5YO72GtPHJ+6mWe8lSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478477; c=relaxed/simple;
	bh=qrY654xPOi4+3MgPrL36yjdm+0ZCDM2YiGdz09SNjZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XuBJikJ7gQZMfQ2V9QnAFxEuYdvrXCxYWdfaB+QhQihPkioKEr6OhoxcI36AN0frQ90lnhFdQy6SCyUgetRUir3ptZxc47U8lpzb1XMT2Vd2Y0hZGFHxQcDHUxb/fHUQFlhiIEkxuOSGOeNR5D5d/U714gvgZ5Tb7w/l8fOEkKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rro6WUhT; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rro6WUhT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742478476; x=1774014476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qrY654xPOi4+3MgPrL36yjdm+0ZCDM2YiGdz09SNjZE=;
  b=Rro6WUhTAyFZ2OWdagAmIkLrrUy+QIHdnx1V0jxXqvjuyA5PYr48agG+
   BIFxQ4UoBY5hRZd3kzdhsSyjJWCCZgkS1CBx3CIUfQ69veQP78cRRpMU2
   IdnueX7j4pRpjnd3x3sKtNfmdSyhYgwGTCyOqn66PkjLtNJY8FsO7Ok7I
   CfUiqPYGTxKtkZ+RN76M+L7U1lQ9SvJvZYc2KeOV+siJB/aAfXcoTrImT
   Hm3z/5nHYbgtnMy6112JegdXn1O4/EGgg4loE6T3kp4tYfauj5qDrkBez
   +tyaNReeAmdVbfF7WbIxejCuXRvHwao8RxPsV4HlYzPLvEWQGv7X+BFul
   w==;
X-CSE-ConnectionGUID: RWpn53H1Sf+Nz2OTk5uHng==
X-CSE-MsgGUID: p8aJfizfQkKUTGdzcCLFBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="69063080"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="69063080"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 06:47:48 -0700
X-CSE-ConnectionGUID: Okkidgl+SByS2Jmp3xzcXQ==
X-CSE-MsgGUID: s35Zwdm8RhyooqaP8OlQhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="160319187"
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
Subject: [PATCH v10 14/18] iommufd: Allow allocating PASID-compatible domain
Date: Thu, 20 Mar 2025 06:47:40 -0700
Message-Id: <20250320134744.5777-15-yi.l.liu@intel.com>
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

The underlying infrastructure has supported the PASID attach and related
enforcement per the requirement of the IOMMU_HWPT_ALLOC_PASID flag. This
extends iommufd to support PASID compatible domain requested by userspace.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
v9 -> v10: Dropped r-b tag as the uapi description for ALLOC_PASID is modified
---
 drivers/iommu/iommufd/device.c       | 4 +++-
 drivers/iommu/iommufd/hw_pagetable.c | 7 ++++---
 include/uapi/linux/iommufd.h         | 3 +++
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 54ffef9c17f7..f09dcddf777b 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -973,7 +973,9 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev, ioasid_t pasid,
 	}
 
 	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev, pasid,
-						0, immediate_attach, NULL);
+						pasid != IOMMU_NO_PASID ?
+						    IOMMU_HWPT_ALLOC_PASID : 0,
+						immediate_attach, NULL);
 	if (IS_ERR(hwpt_paging)) {
 		destroy_hwpt = ERR_CAST(hwpt_paging);
 		goto out_unlock;
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index b8c1e5ca7be8..3fba11754dad 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -112,7 +112,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 {
 	const u32 valid_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
 				IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
-				IOMMU_HWPT_FAULT_ID_VALID;
+				IOMMU_HWPT_FAULT_ID_VALID |
+				IOMMU_HWPT_ALLOC_PASID;
 	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
 	struct iommufd_hwpt_paging *hwpt_paging;
 	struct iommufd_hw_pagetable *hwpt;
@@ -233,7 +234,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
-	if ((flags & ~IOMMU_HWPT_FAULT_ID_VALID) ||
+	if ((flags & ~(IOMMU_HWPT_FAULT_ID_VALID | IOMMU_HWPT_ALLOC_PASID)) ||
 	    !user_data->len || !ops->domain_alloc_nested)
 		return ERR_PTR(-EOPNOTSUPP);
 	if (parent->auto_domain || !parent->nest_parent ||
@@ -290,7 +291,7 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 	struct iommufd_hw_pagetable *hwpt;
 	int rc;
 
-	if (flags & ~IOMMU_HWPT_FAULT_ID_VALID)
+	if (flags & ~(IOMMU_HWPT_FAULT_ID_VALID | IOMMU_HWPT_ALLOC_PASID))
 		return ERR_PTR(-EOPNOTSUPP);
 	if (!user_data->len)
 		return ERR_PTR(-EOPNOTSUPP);
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 5fc7e27804b7..75f3b6829624 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -393,6 +393,9 @@ struct iommu_vfio_ioas {
  *                          Any domain attached to the non-PASID part of the
  *                          device must also be flagged, otherwise attaching a
  *                          PASID will blocked.
+ *                          For the user that wants to attach PASID, ioas is
+ *                          not recommended for the non-PASID part of the
+ *                          device.
  *                          If IOMMU does not support PASID it will return
  *                          error (-EOPNOTSUPP).
  */
-- 
2.34.1

