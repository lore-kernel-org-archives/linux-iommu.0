Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54342222D5D
	for <iommu@lists.linux.dev>; Thu, 19 Dec 2024 13:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614873; cv=none; b=k6gD5OQCMVYg7xhBcI/sjpZhwYI4udlSUVE24cgPYME29sahaxfFvbbnb1Oz/98qzSDAjpDUv1iTGQnmD4y38wxe04OpDHjh4ok/gK5gFyGwkAPTBpgbfEFm+NjGbal10ucE7L6sUkDkwdIMDuQiFw6VTvNo+b1IvKt2Fgljm0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614873; c=relaxed/simple;
	bh=TLTgoEMjgqo3TSMAvQoEaW9XGJoN/x2Corhq9v527iU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J7z8kQOZ81Xfl4KKNQQsbHbcw40Ow0V6qnmIIt8GdSbZFItYGxb12EG7mEFaiJchg058n2XcKDQzciTzVoCY3dPglrXROFVtmEWbEaTsXRoNUO+kjvT2F4i5q8EhEuDYEnWb41OkAks42rj1EFbxR+6C3bbURo3N6akUMCxIGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PgOo5wiz; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PgOo5wiz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734614871; x=1766150871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TLTgoEMjgqo3TSMAvQoEaW9XGJoN/x2Corhq9v527iU=;
  b=PgOo5wizKha5piJaV3CGMFXBA1OZQLMz1J3krWTZOXKjGOZhepOwiw9T
   rMKIjyAMENVXX4IY9OcNJvnng3xp0ZeBrWF6siQY/FUJvDNTMJyFntrAJ
   hXSpcC2vfk/F8LFMHN+NLx2khq1GMhvh2Evs9aKi9+42XX+TaR5oI87uo
   ggnAY5I8TnQojj1jb+7QQhOS9/YM595Vzzr37tI/W2ZHekg3oU47vXe2S
   TZEyuu4ZURn5FpyMJDxxCHj5aHkbDnBn4woG38sHj2TP2B1FOLq+4+bc1
   QGKDpxCIZzFUkgpFxnH9dbieYb+CihgbGNf4ixQZ9JoYmFKZTuQTS+oPX
   g==;
X-CSE-ConnectionGUID: zdG9WK83RqiJfboCVZLKtw==
X-CSE-MsgGUID: QlGvVDDzQeWnDo2blQzwEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="46542262"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="46542262"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 05:27:50 -0800
X-CSE-ConnectionGUID: 9k9dgJz9QmadPvTJrXZYrA==
X-CSE-MsgGUID: nWRHCCQ8TPyUcnTGAku7sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="103177309"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 19 Dec 2024 05:27:49 -0800
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
Subject: [PATCH v6 03/14] iommufd: Move the iommufd_handle helpers to device.c
Date: Thu, 19 Dec 2024 05:27:35 -0800
Message-Id: <20241219132746.16193-4-yi.l.liu@intel.com>
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

The iommu_attach_handle is now only passed when attaching iopf-capable
domain, while it is not convenient for the iommu core to track the
attached domain of pasids. To address it, the iommu_attach_handle will
be passed to iommu core for non-fault-able domain as well. Hence the
iommufd_handle related helpers are no longer fault specific, it makes
more sense to move it out of fault.c.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 62 +++++++++++++++++++++++++
 drivers/iommu/iommufd/fault.c           | 56 +---------------------
 drivers/iommu/iommufd/iommufd_private.h |  8 ++++
 3 files changed, 72 insertions(+), 54 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index dfd0898fb6c1..0e1baf84e887 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -293,6 +293,68 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, "IOMMUFD");
 
+/**
+ * iommufd_device_get_attach_handle - Return the attach handle for the RID
+ *
+ * @idev: The device to get attach_handle
+ *
+ * Currently there is no locking to synchronize threads that access the
+ * returned handle with those attaching or replacing the domain which might
+ * change the handle. It's caller's duty to guarantee no use-after-free.
+ *
+ * Return valid attach_handle if there is, otherwise NULL.
+ */
+struct iommufd_attach_handle *
+iommufd_device_get_attach_handle(struct iommufd_device *idev)
+{
+	struct iommu_attach_handle *handle;
+
+	handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
+	if (IS_ERR(handle))
+		return NULL;
+
+	return to_iommufd_handle(handle);
+}
+
+int iommufd_dev_attach_handle(struct iommufd_hw_pagetable *hwpt,
+			      struct iommufd_device *idev)
+{
+	struct iommufd_attach_handle *handle;
+	int ret;
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->idev = idev;
+	ret = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
+					&handle->handle);
+	if (ret)
+		kfree(handle);
+
+	return ret;
+}
+
+int iommufd_dev_replace_handle(struct iommufd_device *idev,
+			       struct iommufd_hw_pagetable *hwpt,
+			       struct iommufd_hw_pagetable *old)
+{
+	struct iommufd_attach_handle *handle;
+	int ret;
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->idev = idev;
+	ret = iommu_replace_group_handle(idev->igroup->group,
+					 hwpt->domain, &handle->handle);
+	if (ret)
+		kfree(handle);
+
+	return ret;
+}
+
 static int iommufd_group_setup_msi(struct iommufd_group *igroup,
 				   struct iommufd_hwpt_paging *hwpt_paging)
 {
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index d09f4594c67a..d06893226070 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -60,25 +60,6 @@ static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
 	mutex_unlock(&idev->iopf_lock);
 }
 
-static int __fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
-				     struct iommufd_device *idev)
-{
-	struct iommufd_attach_handle *handle;
-	int ret;
-
-	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
-	if (!handle)
-		return -ENOMEM;
-
-	handle->idev = idev;
-	ret = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
-					&handle->handle);
-	if (ret)
-		kfree(handle);
-
-	return ret;
-}
-
 int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
 				    struct iommufd_device *idev)
 {
@@ -91,7 +72,7 @@ int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
 	if (ret)
 		return ret;
 
-	ret = __fault_domain_attach_dev(hwpt, idev);
+	ret = iommufd_dev_attach_handle(hwpt, idev);
 	if (ret)
 		iommufd_fault_iopf_disable(idev);
 
@@ -127,18 +108,6 @@ static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 	mutex_unlock(&fault->mutex);
 }
 
-static struct iommufd_attach_handle *
-iommufd_device_get_attach_handle(struct iommufd_device *idev)
-{
-	struct iommu_attach_handle *handle;
-
-	handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
-	if (IS_ERR(handle))
-		return NULL;
-
-	return to_iommufd_handle(handle);
-}
-
 void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
 				     struct iommufd_device *idev)
 {
@@ -151,27 +120,6 @@ void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
 	kfree(handle);
 }
 
-static int
-__fault_domain_replace_dev(struct iommufd_device *idev,
-			   struct iommufd_hw_pagetable *hwpt,
-			   struct iommufd_hw_pagetable *old)
-{
-	struct iommufd_attach_handle *handle;
-	int ret;
-
-	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
-	if (!handle)
-		return -ENOMEM;
-
-	handle->idev = idev;
-	ret = iommu_replace_group_handle(idev->igroup->group,
-					 hwpt->domain, &handle->handle);
-	if (ret)
-		kfree(handle);
-
-	return ret;
-}
-
 int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 				     struct iommufd_hw_pagetable *hwpt,
 				     struct iommufd_hw_pagetable *old)
@@ -190,7 +138,7 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 	curr = iommufd_device_get_attach_handle(idev);
 
 	if (hwpt->fault)
-		ret = __fault_domain_replace_dev(idev, hwpt, old);
+		ret = iommufd_dev_replace_handle(idev, hwpt, old);
 	else
 		ret = iommu_replace_group_handle(idev->igroup->group,
 						 hwpt->domain, NULL);
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index b6d706cf2c66..d5c83f10d83e 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -459,6 +459,14 @@ struct iommufd_attach_handle {
 /* Convert an iommu attach handle to iommufd handle. */
 #define to_iommufd_handle(hdl)	container_of(hdl, struct iommufd_attach_handle, handle)
 
+struct iommufd_attach_handle *
+iommufd_device_get_attach_handle(struct iommufd_device *idev);
+int iommufd_dev_attach_handle(struct iommufd_hw_pagetable *hwpt,
+			      struct iommufd_device *idev);
+int iommufd_dev_replace_handle(struct iommufd_device *idev,
+			       struct iommufd_hw_pagetable *hwpt,
+			       struct iommufd_hw_pagetable *old);
+
 static inline struct iommufd_fault *
 iommufd_get_fault(struct iommufd_ucmd *ucmd, u32 id)
 {
-- 
2.34.1

