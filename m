Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33351225A44
	for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 13:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614876; cv=none; b=acQk1HIcjIY2gPOtZ1iyE8jF4ReizexLIRHQorWhe5pPSP8Zs5jQ7L5vVvrjDZqh0OxIbnoZ9Y+Im7x8P065yaFghXUY00TXVruA2ilnqHK7Ok4fscuvl1mytFVzpjKOC8mWtmhscBnNbKg7DH/e4p/AAJ0iealQ03fsdrrNHjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614876; c=relaxed/simple;
	bh=qS9DZ9/MBfn5kCqhO/u5cUxk7zI8Pg8T+pkTAB2GIM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U5J6UfLAUrUKzIxNWC0OtwHYS2fhIjFzsvG28kLzH4CrqUdmXGtqJC6hLrF0EGTh0uI2Ujhh68f6Qbas+APQCapNqVtItypWMgKU6tyLT51GJN2+L4WEMz078qjtiI/HFF3WWhSpya5EKtuQraE8z1Uts0LHm6Z/7CoxOuoqZVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dvvg93X8; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dvvg93X8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734614875; x=1766150875;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qS9DZ9/MBfn5kCqhO/u5cUxk7zI8Pg8T+pkTAB2GIM4=;
  b=Dvvg93X8wSKuG2KHRF2dptDnWllMh0sIyS3lfz2f7jgnkQHrkeDVkzfY
   TUkKAGtj7YipUTj6sXK+z+LrFwTwe+0iCqD51o9fJLs6V9zXYcazIphVF
   ZZNfaAaG7ihPgqkm7qBuvW9yj1gFyxNRZgXsTcbbZJJoE1I5uTejZl37+
   1ewNwlVI4COi1u5Qda2ydyzOX+7rT5KBh+heVURWbnSyB9B2ce4OuaTsH
   zsIVu4dw3UJQqL/ydH96t8kKe10j0aP+1FGZPBhG/BamNijm7UK0kC3pc
   f+IgdsaDcRPxh8Cl5hoU/5oJltb9bO9oOxk9MM7i2I1ZPjNBm+jC8+vaI
   g==;
X-CSE-ConnectionGUID: ucg+j7DFQOKpodvpmmVqPg==
X-CSE-MsgGUID: sY6ORNwVQsWVo0H0ZmRIbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46542292"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="46542292"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 05:27:51 -0800
X-CSE-ConnectionGUID: /naXHbC2TBKZ3Sk0BKsxYg==
X-CSE-MsgGUID: ERqTdB6HQf+SBLghV6zz2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="103177326"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 19 Dec 2024 05:27:50 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: eric.auger@redhat.com,
	nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	vasant.hegde@amd.com,
	will@kernel.org
Subject: [PATCH v6 08/14] iommufd: Enforce PASID-compatible domain for RID
Date: Thu, 19 Dec 2024 05:27:40 -0800
Message-Id: <20241219132746.16193-9-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219132746.16193-1-yi.l.liu@intel.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per the definition of IOMMU_HWPT_ALLOC_PASID, iommufd needs to enforce
the RID to use PASID-compatible domain if PASID has been attached.

This enforcement requires a lock across the RID and PASID attach path,
use the idev->igroup->lock for this sync.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h | 18 ++++++++++++++++--
 drivers/iommu/iommufd/pasid.c           | 14 +++++++++++++-
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index e9d6bd8b44bc..158d8e6d5a9a 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -513,7 +513,14 @@ static inline int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 					     struct iommufd_device *idev,
 					     ioasid_t pasid)
 {
-	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
+	lockdep_assert_held(&idev->igroup->lock);
+
+	if (pasid == IOMMU_NO_PASID &&
+	    !xa_empty(&idev->pasid_hwpts) && !hwpt->pasid_compat)
+		return -EINVAL;
+
+	if (pasid != IOMMU_NO_PASID &&
+	    (!idev->igroup->hwpt->pasid_compat || !hwpt->pasid_compat))
 		return -EINVAL;
 
 	if (hwpt->fault)
@@ -549,7 +556,14 @@ static inline int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	struct iommufd_attach_handle *curr;
 	int ret;
 
-	if (pasid != IOMMU_NO_PASID && !hwpt->pasid_compat)
+	lockdep_assert_held(&idev->igroup->lock);
+
+	if (pasid == IOMMU_NO_PASID &&
+	    !xa_empty(&idev->pasid_hwpts) && !hwpt->pasid_compat)
+		return -EINVAL;
+
+	if (pasid != IOMMU_NO_PASID &&
+	    (!idev->igroup->hwpt->pasid_compat || !hwpt->pasid_compat))
 		return -EINVAL;
 
 	if (old->fault || hwpt->fault)
diff --git a/drivers/iommu/iommufd/pasid.c b/drivers/iommu/iommufd/pasid.c
index fcdfbc01dcbb..fdf97f1d71ae 100644
--- a/drivers/iommu/iommufd/pasid.c
+++ b/drivers/iommu/iommufd/pasid.c
@@ -15,6 +15,8 @@ iommufd_device_pasid_do_attach(struct iommufd_device *idev, ioasid_t pasid,
 	int rc;
 
 	refcount_inc(&hwpt->obj.users);
+
+	mutex_lock(&idev->igroup->lock);
 	curr = xa_cmpxchg(&idev->pasid_hwpts, pasid, NULL, hwpt, GFP_KERNEL);
 	if (curr) {
 		if (curr == hwpt)
@@ -30,9 +32,11 @@ iommufd_device_pasid_do_attach(struct iommufd_device *idev, ioasid_t pasid,
 		goto err_put_hwpt;
 	}
 
+	mutex_unlock(&idev->igroup->lock);
 	return NULL;
 
 err_put_hwpt:
+	mutex_unlock(&idev->igroup->lock);
 	refcount_dec(&hwpt->obj.users);
 	return rc ? ERR_PTR(rc) : NULL;
 }
@@ -45,6 +49,8 @@ iommufd_device_pasid_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	int rc;
 
 	refcount_inc(&hwpt->obj.users);
+
+	mutex_lock(&idev->igroup->lock);
 	curr = xa_store(&idev->pasid_hwpts, pasid, hwpt, GFP_KERNEL);
 	rc = xa_err(curr);
 	if (rc)
@@ -70,10 +76,12 @@ iommufd_device_pasid_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 		goto out_put_hwpt;
 	}
 
+	mutex_unlock(&idev->igroup->lock);
 	/* Caller must destroy old_hwpt */
 	return curr;
 
 out_put_hwpt:
+	mutex_unlock(&idev->igroup->lock);
 	refcount_dec(&hwpt->obj.users);
 	return rc ? ERR_PTR(rc) : NULL;
 }
@@ -152,10 +160,14 @@ void iommufd_device_pasid_detach(struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommufd_hw_pagetable *hwpt;
 
+	mutex_lock(&idev->igroup->lock);
 	hwpt = xa_erase(&idev->pasid_hwpts, pasid);
-	if (WARN_ON(!hwpt))
+	if (WARN_ON(!hwpt)) {
+		mutex_unlock(&idev->igroup->lock);
 		return;
+	}
 	iommufd_hwpt_detach_device(hwpt, idev, pasid);
+	mutex_unlock(&idev->igroup->lock);
 	iommufd_hw_pagetable_put(idev->ictx, hwpt);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_pasid_detach, "IOMMUFD");
-- 
2.34.1

