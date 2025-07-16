Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495F928B3E2
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 07:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649972; cv=none; b=g8exiICQ8jZT8F/eI24K/opaI5p/9T0I8gy+9JXxX7CNLzj/IQqjz51c/Gu3yAuXc7ASNoHkQB7SwyzjYZX+Jf1zVDfRxAT7diHyO8OJavvhjCfB1BgyKWiHl4PE7HCySBhHtHBmfc2vrt/WL3ra1pwTVFd8mLIy+y/6qQ635+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649972; c=relaxed/simple;
	bh=nJV35tCeC3FV4M9MblNrza0Hf2M8xmHmaqVlITtrpxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XVlIoc6blHLOxP7SPspoTMbrJtQDboEpcr3CCVZ34dhGSDWC2hdxawd6PhZ4SOUKiuxWPvzb9Nyi/RP8oCWFVOieq9G2IKMV44g+ok9yasDYY9zoGXGBccaitURDT2A2rKQngwag9zlLKLUD1JhmRsGV0XZ+eEMc2ONsDxS04No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVKKdpb5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVKKdpb5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752649970; x=1784185970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nJV35tCeC3FV4M9MblNrza0Hf2M8xmHmaqVlITtrpxY=;
  b=MVKKdpb5ZIoNtQZ8KShAdKqITJSIZ7V4rLy9/kFBgUTbrJcOPiR5qmeW
   Fw39beAXoGFZsYoGJWVLxg+By4g+9OrT1sT6AkM73zKTms8tZmpQuCUjl
   eXcBC5ZNIM8R7ga8SOwNb70Dzxq6a8UeRJHAC+15jMIEld3/EebvykaLe
   oL6g/jIJUHfNjV2AaNmWd7UFq7W80LnqxGGo19O12ezx2kN2kCX4UwY6T
   lTaRX++IDsd+ycirAV7tfvRyV2rcCiPOhuATntwAabbkomsGu//D4Siy0
   omDoA9JaQznUFOH0hnU4/DMboOtAqh2SjLur2HZBviafU+bVy37GhmdY7
   Q==;
X-CSE-ConnectionGUID: hzI3SDnPSWereD0YjjZYLw==
X-CSE-MsgGUID: d9f+kQo/TVGWg/gMUyupXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="58540847"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="58540847"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 00:12:47 -0700
X-CSE-ConnectionGUID: leKmR03/R0OGVM/cL5VZew==
X-CSE-MsgGUID: WXL3r+GJT1K7Yv+lB5dVSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="161453654"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa003.fm.intel.com with ESMTP; 16 Jul 2025 00:12:43 -0700
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
Subject: [PATCH v6 5/8] iommufd/vdevice: Remove struct device reference from struct vdevice
Date: Wed, 16 Jul 2025 15:03:46 +0800
Message-Id: <20250716070349.1807226-6-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250716070349.1807226-1-yilun.xu@linux.intel.com>
References: <20250716070349.1807226-1-yilun.xu@linux.intel.com>
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
use vdev->idev->dev when needed. To avoid exposing
struct iommufd_device in the public header, export a
iommufd_vdevice_to_device() helper.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c |  3 ++-
 drivers/iommu/iommufd/driver.c                 | 10 ++++++++--
 drivers/iommu/iommufd/viommu.c                 |  3 ---
 include/linux/iommufd.h                        |  8 +++++++-
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index eb90af5093d8..4c86eacd36b1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -1218,7 +1218,8 @@ static void tegra241_vintf_destroy_vsid(struct iommufd_vdevice *vdev)
 
 static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
 {
-	struct arm_smmu_master *master = dev_iommu_priv_get(vdev->dev);
+	struct device *dev = iommufd_vdevice_to_device(vdev);
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct tegra241_vintf *vintf = viommu_to_vintf(vdev->viommu);
 	struct tegra241_vintf_sid *vsid = vdev_to_vsid(vdev);
 	struct arm_smmu_stream *stream = &master->streams[0];
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index e4eae20bcd4e..6f1010da221c 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -83,6 +83,12 @@ void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
 }
 EXPORT_SYMBOL_NS_GPL(_iommufd_destroy_mmap, "IOMMUFD");
 
+struct device *iommufd_vdevice_to_device(struct iommufd_vdevice *vdev)
+{
+	return vdev->idev->dev;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_vdevice_to_device, "IOMMUFD");
+
 /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id)
@@ -92,7 +98,7 @@ struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 	lockdep_assert_held(&viommu->vdevs.xa_lock);
 
 	vdev = xa_load(&viommu->vdevs, vdev_id);
-	return vdev ? vdev->dev : NULL;
+	return vdev ? iommufd_vdevice_to_device(vdev) : NULL;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_find_dev, "IOMMUFD");
 
@@ -109,7 +115,7 @@ int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 
 	xa_lock(&viommu->vdevs);
 	xa_for_each(&viommu->vdevs, index, vdev) {
-		if (vdev->dev == dev) {
+		if (iommufd_vdevice_to_device(vdev) == dev) {
 			*vdev_id = vdev->virt_id;
 			rc = 0;
 			break;
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index ecbae5091ffe..6cf0bd5d8f08 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -125,7 +125,6 @@ void iommufd_vdevice_abort(struct iommufd_object *obj)
 	xa_cmpxchg(&viommu->vdevs, vdev->virt_id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
 	idev->vdev = NULL;
-	put_device(vdev->dev);
 }
 
 void iommufd_vdevice_destroy(struct iommufd_object *obj)
@@ -203,8 +202,6 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	}
 
 	vdev->virt_id = virt_id;
-	vdev->dev = idev->dev;
-	get_device(idev->dev);
 	vdev->viommu = viommu;
 	refcount_inc(&viommu->obj.users);
 	/*
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index b88911026bc4..810e4d8ac912 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -109,7 +109,6 @@ struct iommufd_vdevice {
 	struct iommufd_object obj;
 	struct iommufd_viommu *viommu;
 	struct iommufd_device *idev;
-	struct device *dev;
 
 	/*
 	 * Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID of
@@ -261,6 +260,7 @@ int _iommufd_alloc_mmap(struct iommufd_ctx *ictx, struct iommufd_object *owner,
 			unsigned long *offset);
 void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
 			   struct iommufd_object *owner, unsigned long offset);
+struct device *iommufd_vdevice_to_device(struct iommufd_vdevice *vdev);
 struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 				       unsigned long vdev_id);
 int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
@@ -295,6 +295,12 @@ static inline void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
 {
 }
 
+static inline struct device *
+iommufd_vdevice_to_device(struct iommufd_vdevice *vdev)
+{
+	return NULL;
+}
+
 static inline struct device *
 iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
 {
-- 
2.25.1

