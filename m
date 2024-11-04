Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C563BBD8
	for <iommu@lists.linux.dev>; Mon,  4 Nov 2024 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730726719; cv=none; b=g+Q4PbuayM/4qgW0PqOjW1lCyLD2ZJCpxxm2phJoO6dg/MJKP3S5Oc+EuUFTKqgDAnTr0PiFWspIv2WaTAps7OCxOY9HBSguJx0DY1Y0zGjVRwMm/xXHYd8pjbpFM+aBpG4m0XCrAqXqR+oPVOAcBCA7M4MsAwhX7O27gfFTzJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730726719; c=relaxed/simple;
	bh=YiUvmorOdfXuEiF+eg+uAJhOPHTW5LPba3M1kUx2qT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=piqsGajA1E831P6vfc0Uvbbud0kQHkJTWFPIsuG7YeP22FrXiytTP0o8OXqkVHmuLeZcpaznlrbO3lAXWrW9qYnUeZpTUpS7YVdATo2NZYdkq/pUq/TRoeTVjxegxhfOQQwHdeevlHjxLXoRu5x/VPe23TjXsjwZ6msxAO/h21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GeoezEL5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GeoezEL5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730726718; x=1762262718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YiUvmorOdfXuEiF+eg+uAJhOPHTW5LPba3M1kUx2qT0=;
  b=GeoezEL5FrEjZsfW1mR+BMtHbt0FO1mC6L9QDR7fZ451ClDvr9ZMrYPC
   gdW8sRpF41nriOen6hlwxCpYRmzN0DRNJtrDdUI5hfIkRZuyFhmTYZSVK
   nahme7E+FDonYgnEdn/SDjWClXaQxwPB9/40J8S0nwbFQv2nEWY7S/0p/
   xd8J1USyZN5CovxQrCSqgYPDYnphzRJCdswGu/hSwkS0u9GXkBXaocQBs
   QFHkSSmggMD7F4FSi/V8WSSamHUJqY22BQuSuh+VpYYxEwchgToNnQ09F
   lSnKy9i/iGeJ55hYqxEH9e9frYosNtcuafBW33h7pUxMjs9aZ2NOaV3O2
   Q==;
X-CSE-ConnectionGUID: aWUtaBRxQDyrSyUc6KJAKw==
X-CSE-MsgGUID: ycR07eJyRGStVW9pfFFIVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="47884033"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="47884033"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 05:25:17 -0800
X-CSE-ConnectionGUID: qeeSQV/1Q5yWEBiM02zAgg==
X-CSE-MsgGUID: mQuztapWSj6yuEOzlgXNGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="84100444"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa007.jf.intel.com with ESMTP; 04 Nov 2024 05:25:17 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com
Subject: [PATCH v5 02/12] iommufd: Refactor __fault_domain_replace_dev() to be a wrapper of iommu_replace_group_handle()
Date: Mon,  4 Nov 2024 05:25:03 -0800
Message-Id: <20241104132513.15890-3-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104132513.15890-1-yi.l.liu@intel.com>
References: <20241104132513.15890-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a wrapper of iommu_attach_group_handle(), so making a wrapper for
iommu_replace_group_handle() for further code refactor. No functional change
intended.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/fault.c | 50 ++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index e590973ce5cf..230d37c17102 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -146,33 +146,23 @@ void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
 	kfree(handle);
 }
 
-static int __fault_domain_replace_dev(struct iommufd_device *idev,
-				      struct iommufd_hw_pagetable *hwpt,
-				      struct iommufd_hw_pagetable *old)
+static int
+__fault_domain_replace_dev(struct iommufd_device *idev,
+			   struct iommufd_hw_pagetable *hwpt,
+			   struct iommufd_hw_pagetable *old)
 {
-	struct iommufd_attach_handle *handle, *curr = NULL;
+	struct iommufd_attach_handle *handle;
 	int ret;
 
-	if (old->fault)
-		curr = iommufd_device_get_attach_handle(idev);
-
-	if (hwpt->fault) {
-		handle = kzalloc(sizeof(*handle), GFP_KERNEL);
-		if (!handle)
-			return -ENOMEM;
-
-		handle->idev = idev;
-		ret = iommu_replace_group_handle(idev->igroup->group,
-						 hwpt->domain, &handle->handle);
-	} else {
-		ret = iommu_replace_group_handle(idev->igroup->group,
-						 hwpt->domain, NULL);
-	}
+	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
 
-	if (!ret && curr) {
-		iommufd_auto_response_faults(old, curr);
-		kfree(curr);
-	}
+	handle->idev = idev;
+	ret = iommu_replace_group_handle(idev->igroup->group,
+					 hwpt->domain, &handle->handle);
+	if (ret)
+		kfree(handle);
 
 	return ret;
 }
@@ -183,6 +173,7 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 {
 	bool iopf_off = !hwpt->fault && old->fault;
 	bool iopf_on = hwpt->fault && !old->fault;
+	struct iommufd_attach_handle *curr;
 	int ret;
 
 	if (iopf_on) {
@@ -191,13 +182,24 @@ int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
 			return ret;
 	}
 
-	ret = __fault_domain_replace_dev(idev, hwpt, old);
+	curr = iommufd_device_get_attach_handle(idev);
+
+	if (hwpt->fault)
+		ret = __fault_domain_replace_dev(idev, hwpt, old);
+	else
+		ret = iommu_replace_group_handle(idev->igroup->group,
+						 hwpt->domain, NULL);
 	if (ret) {
 		if (iopf_on)
 			iommufd_fault_iopf_disable(idev);
 		return ret;
 	}
 
+	if (curr) {
+		iommufd_auto_response_faults(old, curr);
+		kfree(curr);
+	}
+
 	if (iopf_off)
 		iommufd_fault_iopf_disable(idev);
 
-- 
2.34.1

