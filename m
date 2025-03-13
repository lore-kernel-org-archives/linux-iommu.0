Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84061266F1A
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869356; cv=none; b=XBe26NA87XqKAWk8JPceBcLYVlSLyhc4QE/rskPOjP+QyW5C9n4ZGgbfS9PBYdbjKFNbsA+vH/rUKsE8UmCzm5RPHXAmeYbX7l7mVYtYf1vbILwmFAwD0o2J7Lj5xMxSQoki1aeYxERm6K4nPI7MCZu/k8FSGBwebyb09dWdQfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869356; c=relaxed/simple;
	bh=sQNr1q2oyPVB1zO3kE1kz/uH6e46vGy0D78baf0UeVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NznJiRF29WRTxWEQfsX6CK8HZZLxr9GpIqur3k9fe6ow9puRzJsEqn1j8hDdxs4ZEK7RcRK9oHP8Li6Rzgx1Rpb5zksoY/UaMjmGsNmhjOJgCE/sPT4zZfNY30W7i5U3sUH1+yp4MLNX6IACBTUOW2mvjg6g4K+Q8o2CUhYLjwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ApvYaL3j; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ApvYaL3j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869355; x=1773405355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sQNr1q2oyPVB1zO3kE1kz/uH6e46vGy0D78baf0UeVk=;
  b=ApvYaL3jHp/jFuHA4uah22mHN+M83MD6ixl1tg4PXarO0QQCRXLURK11
   +xmPyzEMcp+6c1ZTxK1zldlQ2cus3WadW1P7exAmoW9a40NBJWb2hv/jn
   PQsC+QXI86KTBoCGEBaFoOc7e4/rkAabCnsDCbVSReTGkqQYZ70dYCxYq
   hspmV2HtdJLb9vnOKZgj+bIfmQsGGKRu+gjDuFmPimAyYZcpY+K2clXx+
   WrxPx7CxBJhR6HJTc9MyLqVu4NK3sIKAhfBsmTgIlR4KkCRBXJqL/fAvi
   szxUK3ZoVVkXU0+gI17aEAGbOoab759NBzG3KgC7yYlItPk3zhR3Ly8Ag
   w==;
X-CSE-ConnectionGUID: PEGQtizaTOGsEVqQS7sZUA==
X-CSE-MsgGUID: JkjcoLZHR+iLKx0Im9b3Rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42863975"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42863975"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:39 -0700
X-CSE-ConnectionGUID: fCqK1B8+SeO1Eor5nfrNDQ==
X-CSE-MsgGUID: AT8zmSW5QcyMf28zsqdKOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126005533"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 05:35:39 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v9 13/21] iommufd: Enforce PASID-compatible domain in PASID path
Date: Thu, 13 Mar 2025 05:35:24 -0700
Message-Id: <20250313123532.103522-14-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313123532.103522-1-yi.l.liu@intel.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AMD IOMMU requires attaching PASID-compatible domains to PASID-capable
devices. This includes the domains attached to RID and PASIDs. Related
discussions in link [1] and [2]. ARM also has such a requirement, Intel
does not need it, but can live up with it. Hence, iommufd is going to
enforce this requirement as it is not harmful to vendors that do not
need it.

Mark the PASID-compatible domains and enforce it in the PASID path.

[1] https://lore.kernel.org/linux-iommu/20240709182303.GK14050@ziepe.ca/
[2] https://lore.kernel.org/linux-iommu/20240822124433.GD3468552@ziepe.ca/

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
v8 -> v9: Renamed the subject from "iommufd: Mark PASID-compatible domain"
	  to better describe what the patch has done.
	  iommufd_hwpt_pasid_compat() is added in this patch instead of
	  later patch
---
 drivers/iommu/iommufd/device.c          | 17 +++++++++++++++++
 drivers/iommu/iommufd/hw_pagetable.c    |  3 +++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 3 files changed, 21 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 63b189a5b8ac..adeeb0145184 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -499,6 +499,15 @@ static bool iommufd_device_is_attached(struct iommufd_device *idev,
 	return xa_load(&handle->device_array, idev->obj.id);
 }
 
+static int iommufd_hwpt_pasid_compat(struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_device *idev,
+				     ioasid_t pasid)
+{
+	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
+		return -EINVAL;
+	return 0;
+}
+
 static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 				      struct iommufd_device *idev,
 				      ioasid_t pasid,
@@ -508,6 +517,10 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 
 	lockdep_assert_held(&idev->igroup->lock);
 
+	rc = iommufd_hwpt_pasid_compat(hwpt, idev, pasid);
+	if (rc)
+		return rc;
+
 	if (hwpt->fault) {
 		rc = iommufd_fault_iopf_enable(idev);
 		if (rc)
@@ -552,6 +565,10 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 
 	WARN_ON(pasid != IOMMU_NO_PASID);
 
+	rc = iommufd_hwpt_pasid_compat(hwpt, idev, pasid);
+	if (rc)
+		return rc;
+
 	if (hwpt->fault && !old->fault) {
 		rc = iommufd_fault_iopf_enable(idev);
 		if (rc)
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 46babba1ceff..7a86c164f514 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -136,6 +136,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 	if (IS_ERR(hwpt_paging))
 		return ERR_CAST(hwpt_paging);
 	hwpt = &hwpt_paging->common;
+	hwpt->pasid_compat = flags & IOMMU_HWPT_ALLOC_PASID;
 
 	INIT_LIST_HEAD(&hwpt_paging->hwpt_item);
 	/* Pairs with iommufd_hw_pagetable_destroy() */
@@ -243,6 +244,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	if (IS_ERR(hwpt_nested))
 		return ERR_CAST(hwpt_nested);
 	hwpt = &hwpt_nested->common;
+	hwpt->pasid_compat = flags & IOMMU_HWPT_ALLOC_PASID;
 
 	refcount_inc(&parent->common.obj.users);
 	hwpt_nested->parent = parent;
@@ -298,6 +300,7 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 	if (IS_ERR(hwpt_nested))
 		return ERR_CAST(hwpt_nested);
 	hwpt = &hwpt_nested->common;
+	hwpt->pasid_compat = flags & IOMMU_HWPT_ALLOC_PASID;
 
 	hwpt_nested->viommu = viommu;
 	refcount_inc(&viommu->obj.users);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index f1e9b45ebd79..2d768fcfa398 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -296,6 +296,7 @@ struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
 	struct iommu_domain *domain;
 	struct iommufd_fault *fault;
+	bool pasid_compat : 1;
 };
 
 struct iommufd_hwpt_paging {
-- 
2.34.1

