Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909862676C5
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 04:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752034275; cv=none; b=i1sTdTAHtaEC+MGG8ZUymAXIR91Pov3NOFDDQ3TkroXXiqIoQmByvL14A3mpXZiTtSso1lsuyECmpEUYz2lvIT7OuIVMA4ZnOuXmsgqPvK51tJ2dA4oQ8exVnsxvrDoxniQDuBtkcswana3+Gc7eKx9Ri+JTQTm6WbiYPsGaF84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752034275; c=relaxed/simple;
	bh=iwYw59t8kUWJiKhkGEvJV3i0KfZKDVRjBH3DUR3RKIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YhX6SrVXlv9NgTvMKljZ/AFGpr8+t8ZvRK5WamUtTWSJ0VW5Dvl7a8sRMS/H9SwNqirYgoClhCNKWA6rW+lbg6MuJ76PIjMjwpU4ucH3q8vWfo2BQWhYs/SZLQlElvALIomLG9l9QZyuBx337PQT6Hi5c+S39hlh7dVLgLH8gwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ginthz7y; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ginthz7y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752034273; x=1783570273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iwYw59t8kUWJiKhkGEvJV3i0KfZKDVRjBH3DUR3RKIw=;
  b=ginthz7yG7ymxepObgOJI9J/f+RluZLzHeyyNbNIodR42WfCko4J8Dpu
   eI6gj5kPQ0ynsJbm6pfn6Z3aroJqZY6bYhA1rS8p9rP3cC+gU1la0pdLl
   H1L0X+lhkD3Qi5WAsliNq8gBHoiwgwR6HE7ZSc5O2TDoe706Uzub5QgfC
   VCCmwLZ/ljpW07ggH7B7HCOh2YF4auKMAJJKaYUW0dA1Yr+vp9lrDoQRS
   bWCiaou3Up76OPRKxFhBII+WS8uUy4H7lHBPjmvrJ91mTraNMAQ42Gk/R
   LFQFft0XserA0kqyLY/KCufM6/52joAKwMnmWnhuELqCPoQsgdGQgnvPk
   g==;
X-CSE-ConnectionGUID: FbABRujUTUukaI0bS/s52Q==
X-CSE-MsgGUID: 9Nk1x7vERjqCqWQpj6rsfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="76831819"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="76831819"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 21:11:13 -0700
X-CSE-ConnectionGUID: +EvtZwM3QdeAOXlkYG8wTQ==
X-CSE-MsgGUID: mlYa2dRIT4O6srK6i3Q/yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="192851651"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa001.jf.intel.com with ESMTP; 08 Jul 2025 21:11:10 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: jgg@nvidia.com,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	will@kernel.org,
	aneesh.kumar@kernel.org
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	shuah@kernel.org,
	nicolinc@nvidia.com,
	aik@amd.com,
	dan.j.williams@intel.com,
	baolu.lu@linux.intel.com,
	yilun.xu@intel.com
Subject: [PATCH v4 5/7] iommufd/vdevice: Remove struct device reference from struct vdevice
Date: Wed,  9 Jul 2025 12:02:32 +0800
Message-Id: <20250709040234.1773573-6-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove struct device *dev from struct vdevice.

The dev pointer is the Plan B for vdevice to reference the physical
device. As now vdev->idev is added without refcounting concern, just
use vdev->idev->dev when needed.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/iommufd/driver.c          | 4 ++--
 drivers/iommu/iommufd/iommufd_private.h | 1 -
 drivers/iommu/iommufd/viommu.c          | 3 ---
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 2fee399a148e..d620691d00a8 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -12,7 +12,7 @@ struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 	lockdep_assert_held(&viommu->vdevs.xa_lock);
 
 	vdev = xa_load(&viommu->vdevs, vdev_id);
-	return vdev ? vdev->dev : NULL;
+	return vdev ? vdev->idev->dev : NULL;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_find_dev, "IOMMUFD");
 
@@ -29,7 +29,7 @@ int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 
 	xa_lock(&viommu->vdevs);
 	xa_for_each(&viommu->vdevs, index, vdev) {
-		if (vdev->dev == dev) {
+		if (vdev->idev->dev == dev) {
 			*vdev_id = vdev->id;
 			rc = 0;
 			break;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 62e5dae2a50d..2b9452b8550a 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -658,7 +658,6 @@ void iommufd_vdevice_abort(struct iommufd_object *obj);
 struct iommufd_vdevice {
 	struct iommufd_object obj;
 	struct iommufd_viommu *viommu;
-	struct device *dev;
 	u64 id; /* per-vIOMMU virtual ID */
 	struct iommufd_device *idev;
 };
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index e6009678c8a5..702ae248df17 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -117,7 +117,6 @@ void iommufd_vdevice_abort(struct iommufd_object *obj)
 	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
 	idev->vdev = NULL;
-	put_device(vdev->dev);
 }
 
 void iommufd_vdevice_destroy(struct iommufd_object *obj)
@@ -178,8 +177,6 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	}
 
 	vdev->id = virt_id;
-	vdev->dev = idev->dev;
-	get_device(idev->dev);
 	vdev->viommu = viommu;
 	refcount_inc(&viommu->obj.users);
 	/*
-- 
2.25.1

