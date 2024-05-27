Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E742575A
	for <iommu@lists.linux.dev>; Mon, 27 May 2024 04:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716782885; cv=none; b=cQQU0sVY4e6+CC1jvB97bKkTdQdy7msdT6IqjY5KqrTIS53PBm74FWxkqI7GnZI5bJVuGRx0mVS+k7vdPErCkSrb+67dCx4mpHH8HMhu7aPacZv7GeMUsW01X3ApJyVyQuuHsVdUtruMAW2lbBn94c2uQ4jqp7C4ZEE4dy9UT6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716782885; c=relaxed/simple;
	bh=67Ni+UMZEpU4jUPoW9+IyUuAjMZCgXaGdMMlrt0ANug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=URSuh2dLcs/O2MgMegvJN59hX37o+eXFRwlD7AtW86/PPr8VshabTwmwhQYAVTGCZ3lIn8gFrB8p1okDFwRZcjgqAxb2FteA7zQBV/AnwojMrUe9lG++3tHCiOI2yo59IH5nRCmAWAagOOwBXjL5T3M1z2qJDWKux2rDNtDuhYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5BJfV8G; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n5BJfV8G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716782884; x=1748318884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=67Ni+UMZEpU4jUPoW9+IyUuAjMZCgXaGdMMlrt0ANug=;
  b=n5BJfV8GIg6ogCuhVXgcpdLs0BzQ2Wzgm5lpEOJ9tHgZnlqh6u0zjqLz
   itfV617A14kiyjVeC8bBv5R7xjG1DcDFS7oY1pNoQ6KHzBsUW/F4yFrDQ
   4lVq3pAyv7wNRHhWceJJe1DRhrbWs8ia8QHfB9sGRAXeemDQMvVvSMFuL
   tEQZABWuep/N2y9kaPHIbXSr+ffTmd+NzYFNwtVk38ZQ3aMDY51U34Avl
   40WbkLJEBJwCJsisG8v59X5LwE7IKfuB1acAi/VgxdXBBdYQq6fgmdXE9
   KghqRtBUIep7PUgeEWaZBVnBW2q+zmuHctQjvI7yPouzuTSFJLR9UiY+6
   g==;
X-CSE-ConnectionGUID: xZAhUmFRTOONbM5Eh6k3pg==
X-CSE-MsgGUID: sGW1NG9nS2yjLS/pakxbxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="13022844"
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="13022844"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 21:07:50 -0700
X-CSE-ConnectionGUID: UJXn37RjTSeCr3eD1+GwHQ==
X-CSE-MsgGUID: uyVYksVxTgi1t1p7lPqDkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,191,1712646000"; 
   d="scan'208";a="39399985"
Received: from unknown (HELO allen-box.sh.intel.com) ([10.239.159.127])
  by orviesa003.jf.intel.com with ESMTP; 26 May 2024 21:07:47 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>
Cc: iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v6 07/10] iommufd: Fault-capable hwpt attach/detach/replace
Date: Mon, 27 May 2024 12:05:14 +0800
Message-Id: <20240527040517.38561-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527040517.38561-1-baolu.lu@linux.intel.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add iopf-capable hw page table attach/detach/replace helpers. The pointer
to iommufd_device is stored in the domain attachment handle, so that it
can be echo'ed back in the iopf_group.

The iopf-capable hw page tables can only be attached to devices that
support the IOMMU_DEV_FEAT_IOPF feature. On the first attachment of an
iopf-capable hw_pagetable to the device, the IOPF feature is enabled on
the device. Similarly, after the last iopf-capable hwpt is detached from
the device, the IOPF feature is disabled on the device.

The current implementation allows a replacement between iopf-capable and
non-iopf-capable hw page tables. This matches the nested translation use
case, where a parent domain is attached by default and can then be
replaced with a nested user domain with iopf support.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommufd/iommufd_private.h |  12 ++
 drivers/iommu/iommufd/device.c          |  16 +-
 drivers/iommu/iommufd/fault.c           | 191 ++++++++++++++++++++++++
 3 files changed, 216 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index c8a4519f1405..ba89c86e1af7 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -293,6 +293,7 @@ int iommufd_check_iova_range(struct io_pagetable *iopt,
 struct iommufd_hw_pagetable {
 	struct iommufd_object obj;
 	struct iommu_domain *domain;
+	struct iommufd_fault *fault;
 };
 
 struct iommufd_hwpt_paging {
@@ -396,6 +397,9 @@ struct iommufd_device {
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
+	/* protect iopf_enabled counter */
+	struct mutex iopf_lock;
+	unsigned int iopf_enabled;
 };
 
 static inline struct iommufd_device *
@@ -456,6 +460,14 @@ struct iommufd_attach_handle {
 int iommufd_fault_alloc(struct iommufd_ucmd *ucmd);
 void iommufd_fault_destroy(struct iommufd_object *obj);
 
+int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
+				    struct iommufd_device *idev);
+void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_device *idev);
+int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
+				     struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_hw_pagetable *old);
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 873630c111c1..63681d79b72d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -215,6 +215,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	refcount_inc(&idev->obj.users);
 	/* igroup refcount moves into iommufd_device */
 	idev->igroup = igroup;
+	mutex_init(&idev->iopf_lock);
 
 	/*
 	 * If the caller fails after this success it must call
@@ -376,7 +377,10 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 	 * attachment.
 	 */
 	if (list_empty(&idev->igroup->device_list)) {
-		rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
+		if (hwpt->fault)
+			rc = iommufd_fault_domain_attach_dev(hwpt, idev);
+		else
+			rc = iommu_attach_group(hwpt->domain, idev->igroup->group);
 		if (rc)
 			goto err_unresv;
 		idev->igroup->hwpt = hwpt;
@@ -402,7 +406,10 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev)
 	mutex_lock(&idev->igroup->lock);
 	list_del(&idev->group_item);
 	if (list_empty(&idev->igroup->device_list)) {
-		iommu_detach_group(hwpt->domain, idev->igroup->group);
+		if (hwpt->fault)
+			iommufd_fault_domain_detach_dev(hwpt, idev);
+		else
+			iommu_detach_group(hwpt->domain, idev->igroup->group);
 		idev->igroup->hwpt = NULL;
 	}
 	if (hwpt_is_paging(hwpt))
@@ -497,7 +504,10 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 			goto err_unlock;
 	}
 
-	rc = iommu_group_replace_domain(igroup->group, hwpt->domain);
+	if (old_hwpt->fault || hwpt->fault)
+		rc = iommufd_fault_domain_replace_dev(idev, hwpt, old_hwpt);
+	else
+		rc = iommu_group_replace_domain(igroup->group, hwpt->domain);
 	if (rc)
 		goto err_unresv;
 
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index d0dafe761075..94dde1f57cfc 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/iommufd.h>
+#include <linux/pci.h>
 #include <linux/poll.h>
 #include <linux/anon_inodes.h>
 #include <uapi/linux/iommufd.h>
@@ -15,6 +16,196 @@
 #include "../iommu-priv.h"
 #include "iommufd_private.h"
 
+static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
+{
+	struct device *dev = idev->dev;
+	int ret;
+
+	/*
+	 * Once we turn on PCI/PRI support for VF, the response failure code
+	 * could not be forwarded to the hardware due to PRI being a shared
+	 * resource between PF and VFs. There is no coordination for this
+	 * shared capability. This waits for a vPRI reset to recover.
+	 */
+	if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
+		return -EINVAL;
+
+	mutex_lock(&idev->iopf_lock);
+	/* Device iopf has already been on. */
+	if (++idev->iopf_enabled > 1) {
+		mutex_unlock(&idev->iopf_lock);
+		return 0;
+	}
+
+	ret = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_IOPF);
+	if (ret)
+		--idev->iopf_enabled;
+	mutex_unlock(&idev->iopf_lock);
+
+	return ret;
+}
+
+static void iommufd_fault_iopf_disable(struct iommufd_device *idev)
+{
+	mutex_lock(&idev->iopf_lock);
+	if (!WARN_ON(idev->iopf_enabled == 0)) {
+		if (--idev->iopf_enabled == 0)
+			iommu_dev_disable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
+	}
+	mutex_unlock(&idev->iopf_lock);
+}
+
+static int __fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_device *idev)
+{
+	struct iommufd_attach_handle *handle;
+	int ret;
+
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->handle.domain = hwpt->domain;
+	handle->idev = idev;
+	ret = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
+					&handle->handle);
+	if (ret)
+		kfree(handle);
+
+	return ret;
+}
+
+int iommufd_fault_domain_attach_dev(struct iommufd_hw_pagetable *hwpt,
+				    struct iommufd_device *idev)
+{
+	int ret;
+
+	if (!hwpt->fault)
+		return -EINVAL;
+
+	ret = iommufd_fault_iopf_enable(idev);
+	if (ret)
+		return ret;
+
+	ret = __fault_domain_attach_dev(hwpt, idev);
+	if (ret)
+		iommufd_fault_iopf_disable(idev);
+
+	return ret;
+}
+
+static void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
+					 struct iommufd_attach_handle *handle)
+{
+	struct iommufd_fault *fault = hwpt->fault;
+	struct iopf_group *group, *next;
+	unsigned long index;
+
+	if (!fault)
+		return;
+
+	mutex_lock(&fault->mutex);
+	list_for_each_entry_safe(group, next, &fault->deliver, node) {
+		if (group->attach_handle != &handle->handle)
+			continue;
+		list_del(&group->node);
+		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
+		iopf_free_group(group);
+	}
+
+	xa_for_each(&fault->response, index, group) {
+		if (group->attach_handle != &handle->handle)
+			continue;
+		xa_erase(&fault->response, index);
+		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
+		iopf_free_group(group);
+	}
+	mutex_unlock(&fault->mutex);
+}
+
+static struct iommufd_attach_handle *
+iommufd_device_get_attach_handle(struct iommufd_device *idev)
+{
+	struct iommu_attach_handle *handle;
+
+	handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
+	if (!handle)
+		return NULL;
+
+	return to_iommufd_handle(handle);
+}
+
+void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_device *idev)
+{
+	struct iommufd_attach_handle *handle;
+
+	handle = iommufd_device_get_attach_handle(idev);
+	iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
+	iommufd_auto_response_faults(hwpt, handle);
+	iommufd_fault_iopf_disable(idev);
+	kfree(handle);
+}
+
+static int __fault_domain_replace_dev(struct iommufd_device *idev,
+				      struct iommufd_hw_pagetable *hwpt,
+				      struct iommufd_hw_pagetable *old)
+{
+	struct iommufd_attach_handle *handle, *curr = NULL;
+	int ret;
+
+	if (old->fault)
+		curr = iommufd_device_get_attach_handle(idev);
+
+	if (hwpt->fault) {
+		handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+		if (!handle)
+			return -ENOMEM;
+
+		handle->handle.domain = hwpt->domain;
+		handle->idev = idev;
+		ret = iommu_replace_group_handle(idev->igroup->group,
+						 hwpt->domain, &handle->handle);
+	} else {
+		ret = iommu_replace_group_handle(idev->igroup->group,
+						 hwpt->domain, NULL);
+	}
+
+	if (!ret && curr) {
+		iommufd_auto_response_faults(old, curr);
+		kfree(curr);
+	}
+
+	return ret;
+}
+
+int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
+				     struct iommufd_hw_pagetable *hwpt,
+				     struct iommufd_hw_pagetable *old)
+{
+	bool iopf_off = !hwpt->fault && old->fault;
+	bool iopf_on = hwpt->fault && !old->fault;
+	int ret;
+
+	if (iopf_on) {
+		ret = iommufd_fault_iopf_enable(idev);
+		if (ret)
+			return ret;
+	}
+
+	ret = __fault_domain_replace_dev(idev, hwpt, old);
+	if (ret) {
+		if (iopf_on)
+			iommufd_fault_iopf_disable(idev);
+		return ret;
+	}
+
+	if (iopf_off)
+		iommufd_fault_iopf_disable(idev);
+
+	return 0;
+}
+
 void iommufd_fault_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_fault *fault = container_of(obj, struct iommufd_fault, obj);
-- 
2.34.1

