Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A3922D7B2
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577591; cv=none; b=bwD7RqSDT+igmkiBp2YF3H3j7gkWXssZ30fslMxg3fqZuc0L9qsH3GOkF9xHXo6cZSx8URO834CXeNrnIgxO9wN92O1AtwpN3ERxS++EW6690q5fTAFjuNs4jP65cLsch4RH3GYT9dXA2q6LU3gbybOcDZt6eSOgKRO8BcCoxwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577591; c=relaxed/simple;
	bh=htV8H2j7oeufjLwhs/me1KjrxsPw6KV+MJHQlJh0kzA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=in4Y5yg3YrYKsIKJPI4jzh6FYf1e0Cfjzo7rQteRPHKyxL9KUUnq0lQb1E91XmZXCrAL8vXFPvXySJ1M5/O5c2mvh17TE3fvOZdTVMUwGjZXJyLvefTIGNbqzyeb55oKaPcKMjgR0w2iXpyt4hDtjbsaXiPUc+HTsoEtD6Sq1J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UrOYf8FZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UrOYf8FZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742577590; x=1774113590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=htV8H2j7oeufjLwhs/me1KjrxsPw6KV+MJHQlJh0kzA=;
  b=UrOYf8FZxRumWE00IpBRhPL//xoSS9Ni/bW8yHAn93IuELV6JgHt8JyR
   cp068yyYwvsSkiSvkALLmKi08JwNXwoWbPd78fRgzqUMLK6W4Ft717OO+
   YIlS+K9gHkVnYkiBrqd4jmXkQHIpN3xkfrJgOFep2ZC8x1ccPYJ2ERnZQ
   9W9Z5d1Bt2hoTRRp9Dszp74L6zIVAgYqxU7sRbDQWMXiKKCBieUMbwkwI
   +ykDNyjIx6tSqnU4ViZT2hWrmcDZdiArL4u5TuOPtE49WO7wCxIFHavum
   69G9dI14Atf2JveCYndNJEG12LkM/efZOudA40Rjn9If0e3F8N9GDSyun
   w==;
X-CSE-ConnectionGUID: scTalK7OSp2u71BvXkN2OQ==
X-CSE-MsgGUID: 01THHSDZTuSqpZABO+bJUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11380"; a="43976815"
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="43976815"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2025 10:19:46 -0700
X-CSE-ConnectionGUID: zhjqpGsEQWWEZpbNSNeP1w==
X-CSE-MsgGUID: qUMbwpesQhSF0XRPJJk16g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,265,1736841600"; 
   d="scan'208";a="123914493"
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
Subject: [PATCH v11 09/18] iommufd/device: Add pasid_attach array to track per-PASID attach
Date: Fri, 21 Mar 2025 10:19:31 -0700
Message-Id: <20250321171940.7213-10-yi.l.liu@intel.com>
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

PASIDs of PASID-capable device can be attached to hwpt separately, hence
a pasid array to track per-PASID attachment is necessary. The index
IOMMU_NO_PASID is used by the RID path. Hence drop the igroup->attach.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
v10 -> v11: Use xa_load() in iommufd_device_do_replace()
---
 drivers/iommu/iommufd/device.c          | 59 +++++++++++++++++--------
 drivers/iommu/iommufd/iommufd_private.h |  2 +-
 2 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 760917f5d764..175f3d39baaa 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -27,7 +27,7 @@ static void iommufd_group_release(struct kref *kref)
 	struct iommufd_group *igroup =
 		container_of(kref, struct iommufd_group, ref);
 
-	WARN_ON(igroup->attach);
+	WARN_ON(!xa_empty(&igroup->pasid_attach));
 
 	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
 		   NULL, GFP_KERNEL);
@@ -94,6 +94,7 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 
 	kref_init(&new_igroup->ref);
 	mutex_init(&new_igroup->lock);
+	xa_init(&new_igroup->pasid_attach);
 	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
 	/* group reference moves into new_igroup */
 	new_igroup->group = group;
@@ -297,16 +298,19 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, "IOMMUFD");
 
-static unsigned int iommufd_group_device_num(struct iommufd_group *igroup)
+static unsigned int iommufd_group_device_num(struct iommufd_group *igroup,
+					     ioasid_t pasid)
 {
+	struct iommufd_attach *attach;
 	struct iommufd_device *idev;
 	unsigned int count = 0;
 	unsigned long index;
 
 	lockdep_assert_held(&igroup->lock);
 
-	if (igroup->attach)
-		xa_for_each(&igroup->attach->device_array, index, idev)
+	attach = xa_load(&igroup->pasid_attach, pasid);
+	if (attach)
+		xa_for_each(&attach->device_array, index, idev)
 			count++;
 	return count;
 }
@@ -351,7 +355,7 @@ static bool
 iommufd_group_first_attach(struct iommufd_group *igroup, ioasid_t pasid)
 {
 	lockdep_assert_held(&igroup->lock);
-	return !igroup->attach;
+	return !xa_load(&igroup->pasid_attach, pasid);
 }
 
 static int
@@ -382,10 +386,13 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 
 /* The device attach/detach/replace helpers for attach_handle */
 
-/* Check if idev is attached to igroup->hwpt */
-static bool iommufd_device_is_attached(struct iommufd_device *idev)
+static bool iommufd_device_is_attached(struct iommufd_device *idev,
+				       ioasid_t pasid)
 {
-	return xa_load(&idev->igroup->attach->device_array, idev->obj.id);
+	struct iommufd_attach *attach;
+
+	attach = xa_load(&idev->igroup->pasid_attach, pasid);
+	return xa_load(&attach->device_array, idev->obj.id);
 }
 
 static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
@@ -512,12 +519,18 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 
 	mutex_lock(&igroup->lock);
 
-	attach = igroup->attach;
+	attach = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
+			    XA_ZERO_ENTRY, GFP_KERNEL);
+	if (xa_is_err(attach)) {
+		rc = xa_err(attach);
+		goto err_unlock;
+	}
+
 	if (!attach) {
 		attach = kzalloc(sizeof(*attach), GFP_KERNEL);
 		if (!attach) {
 			rc = -ENOMEM;
-			goto err_unlock;
+			goto err_release_pasid;
 		}
 		xa_init(&attach->device_array);
 	}
@@ -554,7 +567,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		if (rc)
 			goto err_unresv;
 		attach->hwpt = hwpt;
-		igroup->attach = attach;
+		WARN_ON(xa_is_err(xa_store(&igroup->pasid_attach, pasid, attach,
+					   GFP_KERNEL)));
 	}
 	refcount_inc(&hwpt->obj.users);
 	WARN_ON(xa_is_err(xa_store(&attach->device_array, idev->obj.id,
@@ -569,6 +583,9 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 err_free_attach:
 	if (iommufd_group_first_attach(igroup, pasid))
 		kfree(attach);
+err_release_pasid:
+	if (iommufd_group_first_attach(igroup, pasid))
+		xa_release(&igroup->pasid_attach, pasid);
 err_unlock:
 	mutex_unlock(&igroup->lock);
 	return rc;
@@ -583,14 +600,14 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 	struct iommufd_attach *attach;
 
 	mutex_lock(&igroup->lock);
-	attach = igroup->attach;
+	attach = xa_load(&igroup->pasid_attach, pasid);
 	hwpt = attach->hwpt;
 	hwpt_paging = find_hwpt_paging(hwpt);
 
 	xa_erase(&attach->device_array, idev->obj.id);
 	if (xa_empty(&attach->device_array)) {
 		iommufd_hwpt_detach_device(hwpt, idev, pasid);
-		igroup->attach = NULL;
+		xa_erase(&igroup->pasid_attach, pasid);
 		kfree(attach);
 	}
 	if (hwpt_paging && pasid == IOMMU_NO_PASID)
@@ -617,12 +634,14 @@ static void
 iommufd_group_remove_reserved_iova(struct iommufd_group *igroup,
 				   struct iommufd_hwpt_paging *hwpt_paging)
 {
+	struct iommufd_attach *attach;
 	struct iommufd_device *cur;
 	unsigned long index;
 
 	lockdep_assert_held(&igroup->lock);
 
-	xa_for_each(&igroup->attach->device_array, index, cur)
+	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
+	xa_for_each(&attach->device_array, index, cur)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, cur->dev);
 }
 
@@ -631,15 +650,17 @@ iommufd_group_do_replace_reserved_iova(struct iommufd_group *igroup,
 				       struct iommufd_hwpt_paging *hwpt_paging)
 {
 	struct iommufd_hwpt_paging *old_hwpt_paging;
+	struct iommufd_attach *attach;
 	struct iommufd_device *cur;
 	unsigned long index;
 	int rc;
 
 	lockdep_assert_held(&igroup->lock);
 
-	old_hwpt_paging = find_hwpt_paging(igroup->attach->hwpt);
+	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
+	old_hwpt_paging = find_hwpt_paging(attach->hwpt);
 	if (!old_hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas) {
-		xa_for_each(&igroup->attach->device_array, index, cur) {
+		xa_for_each(&attach->device_array, index, cur) {
 			rc = iopt_table_enforce_dev_resv_regions(
 				&hwpt_paging->ioas->iopt, cur->dev, NULL);
 			if (rc)
@@ -672,7 +693,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 
 	mutex_lock(&igroup->lock);
 
-	attach = igroup->attach;
+	attach = xa_load(&igroup->pasid_attach, pasid);
 	if (!attach) {
 		rc = -EINVAL;
 		goto err_unlock;
@@ -682,7 +703,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 
 	WARN_ON(!old_hwpt || xa_empty(&attach->device_array));
 
-	if (!iommufd_device_is_attached(idev)) {
+	if (!iommufd_device_is_attached(idev, pasid)) {
 		rc = -EINVAL;
 		goto err_unlock;
 	}
@@ -709,7 +730,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 
 	attach->hwpt = hwpt;
 
-	num_devices = iommufd_group_device_num(igroup);
+	num_devices = iommufd_group_device_num(igroup, pasid);
 	/*
 	 * Move the refcounts held by the device_array to the new hwpt. Retain a
 	 * refcount for this thread as the caller will free it.
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 5b4d8962166b..85467f53bdb2 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -406,7 +406,7 @@ struct iommufd_group {
 	struct mutex lock;
 	struct iommufd_ctx *ictx;
 	struct iommu_group *group;
-	struct iommufd_attach *attach;
+	struct xarray pasid_attach;
 	struct iommufd_sw_msi_maps required_sw_msi;
 	phys_addr_t sw_msi_start;
 };
-- 
2.34.1

