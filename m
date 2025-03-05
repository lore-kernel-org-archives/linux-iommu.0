Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232ED2475F2
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179847; cv=none; b=adhjbnqiuWqt7hdCxVtcKGp5/QWI/hUB83Mv7PdNiy7NUDCVedag4k/CFYDgiwB045zp6RtZn5gyeJwlbGx6EW5DQwge6wQTAD8Fqj5hKgHZ4s1uJelbRI1H+6lxfIsfI5FRGcBtK+o2JDFTGmto4qncHzCmIVBy/MdAh1qhHDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179847; c=relaxed/simple;
	bh=Oys6ui/2ehjiPYtdZB78KvK8zQxSP1E/BexVYXKJIcM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FA9n2V10TMlNG5LCORxrkW8ng/Dpo/jbAIanwZ4BaNY9LdMzePf1yxNtMihJOj5maoocOHfPIHcW6ld3huh5fXy4OkrbdSrpGGfMjYhWiJilYrzOHN93dM9tYIiGExHzD9EcWSVXDQ3i5twvELF54w8QFEvmhGGNOSul1GJBTDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYX4RT6V; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYX4RT6V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741179847; x=1772715847;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oys6ui/2ehjiPYtdZB78KvK8zQxSP1E/BexVYXKJIcM=;
  b=nYX4RT6VJvkFyxdXQKvwBv5GV3P5IsEJkyEfdu+WPmi8IzdRNEEBkS9S
   iVhIxih9tj8Vmq7H707WFfjOYJ9nqiJWfM3EMcWQOFm4hcPs6wsul0ELn
   LgWiPjaFLVjkOQRFJS43xtMqUtxGNSFwLTBQIS87R/fYMvDZ9F1MPF5gB
   YOPrb+uyg7uFSvY43SGhFkhY7rA+Lf2MdTw/yckifw6BXGWwo+gzBF6rp
   bL1xn0QpkVbRVgdCA2bIg3GbyoSkq5WVG5ltHwV7Coc9FiTY0+FGHzyWf
   Z6iMooxrV4oblK4POmxhpv8gJRB92DjpVTD9QqbGntfSqROjV6aA0Aw3U
   g==;
X-CSE-ConnectionGUID: IxhpDvn8Q+yllGwZdKhEmQ==
X-CSE-MsgGUID: I6z9A4fGR4m/FT+OPvotKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="64582866"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="64582866"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 05:03:59 -0800
X-CSE-ConnectionGUID: LzTqUjaSRsi4m8/70owBnQ==
X-CSE-MsgGUID: psJyTMnVTeGngV2NHgrWCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123725967"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa004.jf.intel.com with ESMTP; 05 Mar 2025 05:03:59 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	jgg@nvidia.com
Cc: yi.l.liu@intel.com,
	iommu@lists.linux.dev
Subject: [RFC] iommufd: Use accurate dev_id in the PRI forwarding path
Date: Wed,  5 Mar 2025 05:03:56 -0800
Message-Id: <20250305130356.126424-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jason, Kevin, Baolu,

This is more a query, the patch here does not really work as there
is locking issue. So I'd like to hear from you if any good idea.

Detail as below:

Existing code has a problem when the PRI happens on a device that has
alias. The PRI reporting path uses the idev stored in the handle. While
this idev is the first idev that attachs to the domain.  If the PRI
happens on devices other than the first attached device, then the idev
stored in handle does not match.

To solve it, the PRI reporting path needs to loop the attached devices
to get the correct idev and its dev_id. The trouble is that the device_list
is protected by igroup->lock. While the PRI path hold the fault->mutex
lock. This fault->mutex lock might be used in the attach path or the
replace path. Both path would hold igroup->lock first, and then the
fault->mutex if auto_response needed. This will have A-B-B-A locking
issue.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c          | 31 +++++++++++++++++++------
 drivers/iommu/iommufd/fault.c           |  4 +++-
 drivers/iommu/iommufd/iommufd_private.h |  5 +++-
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index bd50146e2ad0..586d008d6bac 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -390,26 +390,26 @@ int iommufd_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 
 	handle = to_iommufd_handle(raw_handle);
 	/* No IOMMU_RESV_SW_MSI means no change to the msi_msg */
-	if (handle->idev->igroup->sw_msi_start == PHYS_ADDR_MAX)
+	if (handle->igroup->sw_msi_start == PHYS_ADDR_MAX)
 		return 0;
 
-	ictx = handle->idev->ictx;
+	ictx = handle->igroup->ictx;
 	guard(mutex)(&ictx->sw_msi_lock);
 	/*
 	 * The input msi_addr is the exact byte offset of the MSI doorbell, we
 	 * assume the caller has checked that it is contained with a MMIO region
 	 * that is secure to map at PAGE_SIZE.
 	 */
-	msi_map = iommufd_sw_msi_get_map(handle->idev->ictx,
+	msi_map = iommufd_sw_msi_get_map(ictx,
 					 msi_addr & PAGE_MASK,
-					 handle->idev->igroup->sw_msi_start);
+					 handle->igroup->sw_msi_start);
 	if (IS_ERR(msi_map))
 		return PTR_ERR(msi_map);
 
 	rc = iommufd_sw_msi_install(ictx, hwpt_paging, msi_map);
 	if (rc)
 		return rc;
-	__set_bit(msi_map->id, handle->idev->igroup->required_sw_msi.bitmap);
+	__set_bit(msi_map->id, handle->igroup->required_sw_msi.bitmap);
 
 	iova = msi_map->sw_msi_start + msi_map->pgoff * PAGE_SIZE;
 	msi_desc_set_iommu_msi_iova(desc, iova, PAGE_SHIFT);
@@ -482,6 +482,26 @@ static bool iommufd_device_is_attached(struct iommufd_device *idev)
 	return false;
 }
 
+struct iommufd_device *
+iommufd_group_find_device(struct iommufd_group *igroup, struct device *dev)
+{
+	struct iommufd_device *cur, *idev = NULL;
+
+	/* !!! Headsup !!!
+	 * taking igroup->lock has dead lock with fault->mutex
+	 */
+	mutex_lock(&igroup->lock);
+	list_for_each_entry(cur, &igroup->device_list, group_item) {
+		if (cur->dev == dev) {
+			idev = cur;
+			break;
+		}
+	}
+	mutex_unlock(&igroup->lock);
+
+	return idev;
+}
+
 static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 				      struct iommufd_device *idev)
 {
@@ -500,7 +517,7 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 			goto out_free_handle;
 	}
 
-	handle->idev = idev;
+	handle->igroup = idev->igroup;
 	rc = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
 				       &handle->handle);
 	if (rc)
@@ -562,7 +579,7 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 			goto out_free_handle;
 	}
 
-	handle->idev = idev;
+	handle->igroup = idev->igroup;
 	rc = iommu_replace_group_handle(idev->igroup->group, hwpt->domain,
 					&handle->handle);
 	if (rc)
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index c48d72c9668c..b7e0283d024a 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -168,7 +168,11 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 			break;
 		}
-		idev = to_iommufd_handle(group->attach_handle)->idev;
+		/* Or just add a WARN_ON if the idev->dev does not match
+		   group->fault_param->dev ?*/
+		idev = iommufd_group_find_device(
+				to_iommufd_handle(group->attach_handle)->igroup,
+				group->fault_param->dev);
 		list_for_each_entry(iopf, &group->faults, list) {
 			iommufd_compose_fault_message(&iopf->fault,
 						      &data, idev,
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 246297452a44..df0db45deac0 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -433,6 +433,9 @@ iommufd_get_device(struct iommufd_ucmd *ucmd, u32 id)
 			    struct iommufd_device, obj);
 }
 
+struct iommufd_device *
+iommufd_group_find_device(struct iommufd_group *igroup, struct device *dev);
+
 void iommufd_device_destroy(struct iommufd_object *obj);
 int iommufd_get_hw_info(struct iommufd_ucmd *ucmd);
 
@@ -499,7 +502,7 @@ static inline void iommufd_fault_deliver_restore(struct iommufd_fault *fault,
 
 struct iommufd_attach_handle {
 	struct iommu_attach_handle handle;
-	struct iommufd_device *idev;
+	struct iommufd_group *igroup;
 };
 
 /* Convert an iommu attach handle to iommufd handle. */
-- 
2.34.1

