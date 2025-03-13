Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BD9266F19
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869353; cv=none; b=AygujGSpGRwNWXnE5iMARw+TRcsWTykLWKT0swB917lpuIwEP3AchJortQd9W5xWPwneK7vuY9DsHj5FLIYC1851SUFEMsugc0oQN+fIx+5Y2lyK8VeG3q5J7TtPQjatljw/JzkRhjppCyyr2bNW1Ld0trcgkP6U3z1s/+O5WoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869353; c=relaxed/simple;
	bh=k24wSMi7obCSHSW2AEW0x/mIvLzMYE6/D9EQd1bc/bk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M+L0F06bKRNNdHWnjgffH+/oyT/FJETOPiRTRpJOZkCdjDjZrDVPjwQcacWKz7uD4s2fKXiebHqYSkXOQ0zTMPwx71PaiRHh+e8D1CLA1kc1ECpPW5fBwkSbZDJgHUo+4EUEavV4bxbpf9rq0stomdJyKkNXOlLt3HSom2usaXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UZlNNfeB; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UZlNNfeB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741869352; x=1773405352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k24wSMi7obCSHSW2AEW0x/mIvLzMYE6/D9EQd1bc/bk=;
  b=UZlNNfeBSZ8+koNn204yDrCwTl0iNzpSPyYKzeKkYZ/jSr8ukZSplEEg
   H9z39kiv57Sg0BaOqwjd3hf3fPLeUdJV+SNK7s1/bF1N4wIzJ50M3rb2l
   v3YUswdjH8MR11aHYkWEYM4oG91Qa1cfNFYC3Pxmc2bsSdGacz6+hfXYj
   RhdlTfJhMrq3VQ0GpLOLlcX1jcThx2TP5TaiE/IJswAjZWjuwNkcd9qk6
   Q0daxGtRhMJRujCklsyNN/ZNDkj+K4NbAtst3srr4tzVwOFvft8h7+IFW
   aa3Kuz6BLEdUJXaBhGjVbrb4U0rHKVmPGL+uwoxbvqL28YvjhhzbRicHv
   g==;
X-CSE-ConnectionGUID: emDR4EG9SGKoVmlUziXOtQ==
X-CSE-MsgGUID: M036K8kpQo63F86TG39aBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="42863958"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="42863958"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 05:35:38 -0700
X-CSE-ConnectionGUID: mRFEuEYGSyW5qY3Rf2FZyw==
X-CSE-MsgGUID: lIdpd+3LSK6C5yhYi24Abw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126005515"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 13 Mar 2025 05:35:38 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: joro@8bytes.org,
	baolu.lu@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com
Subject: [PATCH v9 08/21] iommufd/device: Lift iommufd_attach_handle handling to upper level helpers
Date: Thu, 13 Mar 2025 05:35:19 -0700
Message-Id: <20250313123532.103522-9-yi.l.liu@intel.com>
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

iommufd_attach_handle is allocated when attaching the first device of a
group, and destroyed when the last device is detached. The life circle is
aligned with the igroup->hwpt which is used to track attached hwpt of the
group.

This lifts the handle allocation/destroy to the upper level helpers. It
prepares for using the handle to track hwpt attachment.

No functional change is expected, except for that the replace path reuses
the old handle instead of allocating a new one. This is needed when using
handle to track attached devices of a group. Otherwise, the replace path
would need to move the tracked devices to the new handle.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 66 +++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index a63d90ab3154..e1f27da65720 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -485,24 +485,19 @@ static bool iommufd_device_is_attached(struct iommufd_device *idev)
 
 static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 				      struct iommufd_device *idev,
-				      ioasid_t pasid)
+				      ioasid_t pasid,
+				      struct iommufd_attach_handle *handle)
 {
-	struct iommufd_attach_handle *handle;
 	int rc;
 
 	lockdep_assert_held(&idev->igroup->lock);
 
-	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
-	if (!handle)
-		return -ENOMEM;
-
 	if (hwpt->fault) {
 		rc = iommufd_fault_iopf_enable(idev);
 		if (rc)
-			goto out_free_handle;
+			return rc;
 	}
 
-	handle->idev = idev;
 	WARN_ON(pasid != IOMMU_NO_PASID);
 	rc = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
 				       &handle->handle);
@@ -514,8 +509,6 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 out_disable_iopf:
 	if (hwpt->fault)
 		iommufd_fault_iopf_disable(idev);
-out_free_handle:
-	kfree(handle);
 	return rc;
 }
 
@@ -535,63 +528,50 @@ iommufd_device_get_attach_handle(struct iommufd_device *idev, ioasid_t pasid)
 
 static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
 				       struct iommufd_device *idev,
-				       ioasid_t pasid)
+				       ioasid_t pasid,
+				       struct iommufd_attach_handle *handle)
 {
-	struct iommufd_attach_handle *handle;
-
 	WARN_ON(pasid != IOMMU_NO_PASID);
 
-	handle = iommufd_device_get_attach_handle(idev, pasid);
 	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
 	if (hwpt->fault) {
 		iommufd_auto_response_faults(hwpt, handle);
 		iommufd_fault_iopf_disable(idev);
 	}
-	kfree(handle);
 }
 
 static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 				       ioasid_t pasid,
 				       struct iommufd_hw_pagetable *hwpt,
-				       struct iommufd_hw_pagetable *old)
+				       struct iommufd_hw_pagetable *old,
+				       struct iommufd_attach_handle *handle)
 {
-	struct iommufd_attach_handle *handle, *old_handle;
 	int rc;
 
 	WARN_ON(pasid != IOMMU_NO_PASID);
 
-	old_handle = iommufd_device_get_attach_handle(idev, pasid);
-
-	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
-	if (!handle)
-		return -ENOMEM;
-
 	if (hwpt->fault && !old->fault) {
 		rc = iommufd_fault_iopf_enable(idev);
 		if (rc)
-			goto out_free_handle;
+			return rc;
 	}
 
-	handle->idev = idev;
 	rc = iommu_replace_group_handle(idev->igroup->group, hwpt->domain,
 					&handle->handle);
 	if (rc)
 		goto out_disable_iopf;
 
 	if (old->fault) {
-		iommufd_auto_response_faults(hwpt, old_handle);
+		iommufd_auto_response_faults(hwpt, handle);
 		if (!hwpt->fault)
 			iommufd_fault_iopf_disable(idev);
 	}
-	kfree(old_handle);
 
 	return 0;
 
 out_disable_iopf:
 	if (hwpt->fault && !old->fault)
 		iommufd_fault_iopf_disable(idev);
-out_free_handle:
-	kfree(handle);
 	return rc;
 }
 
@@ -601,6 +581,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
 	bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID;
 	struct iommufd_group *igroup = idev->igroup;
+	struct iommufd_attach_handle *handle;
 	int rc;
 
 	mutex_lock(&igroup->lock);
@@ -610,10 +591,19 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_unlock;
 	}
 
+	if (!igroup->hwpt) {
+		handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+		if (!handle) {
+			rc = -ENOMEM;
+			goto err_unlock;
+		}
+		handle->idev = idev;
+	}
+
 	if (attach_resv) {
 		rc = iommufd_device_attach_reserved_iova(idev, hwpt_paging);
 		if (rc)
-			goto err_unlock;
+			goto err_free_handle;
 	}
 
 	/*
@@ -624,7 +614,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&igroup->device_list)) {
-		rc = iommufd_hwpt_attach_device(hwpt, idev, pasid);
+		rc = iommufd_hwpt_attach_device(hwpt, idev, pasid, handle);
 		if (rc)
 			goto err_unresv;
 		igroup->hwpt = hwpt;
@@ -636,6 +626,9 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 err_unresv:
 	if (attach_resv)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
+err_free_handle:
+	if (!igroup->hwpt)
+		kfree(handle);
 err_unlock:
 	mutex_unlock(&igroup->lock);
 	return rc;
@@ -647,12 +640,15 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
 	struct iommufd_group *igroup = idev->igroup;
 	struct iommufd_hw_pagetable *hwpt = igroup->hwpt;
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
+	struct iommufd_attach_handle *handle;
 
 	mutex_lock(&igroup->lock);
 	list_del(&idev->group_item);
 	if (list_empty(&igroup->device_list)) {
-		iommufd_hwpt_detach_device(hwpt, idev, pasid);
+		handle = iommufd_device_get_attach_handle(idev, pasid);
+		iommufd_hwpt_detach_device(hwpt, idev, pasid, handle);
 		igroup->hwpt = NULL;
+		kfree(handle);
 	}
 	if (hwpt_paging && pasid == IOMMU_NO_PASID)
 		iopt_remove_reserved_iova(&hwpt_paging->ioas->iopt, idev->dev);
@@ -725,6 +721,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 	struct iommufd_hwpt_paging *old_hwpt_paging;
 	struct iommufd_group *igroup = idev->igroup;
 	struct iommufd_hw_pagetable *old_hwpt;
+	struct iommufd_attach_handle *handle;
 	unsigned int num_devices;
 	int rc;
 
@@ -745,6 +742,9 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 		return NULL;
 	}
 
+	handle = iommufd_device_get_attach_handle(idev, pasid);
+	WARN_ON(!handle);
+
 	old_hwpt = igroup->hwpt;
 	if (attach_resv) {
 		rc = iommufd_group_do_replace_reserved_iova(igroup, hwpt_paging);
@@ -752,7 +752,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 			goto err_unlock;
 	}
 
-	rc = iommufd_hwpt_replace_device(idev, pasid, hwpt, old_hwpt);
+	rc = iommufd_hwpt_replace_device(idev, pasid, hwpt, old_hwpt, handle);
 	if (rc)
 		goto err_unresv;
 
-- 
2.34.1

