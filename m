Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA13270579
	for <iommu@lists.linux.dev>; Tue, 15 Jul 2025 06:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752561705; cv=none; b=hK2c3hPYq7dJHVi3hVzTXgT7HVSX4kIsAhnCy2OF70V3s4bOwA2egD8woyduh3sACeT4gLg/jxTHQlCSXWwwLDk8LeIj/VrmhxpY9DpWEOfU4LRaPjimXTGeuKzGEdmNMVIpSgecRwmBNwXfACyJDPd0xBBlgN3Rl8r2SCSpnRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752561705; c=relaxed/simple;
	bh=IuYZ7TDNy1bf7E/m7zyAAPqADAKNCwz0eV+rlgC83/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jIp9Um5K7qwwpUNoFEOEbz3MBMcH2x8TqFAViu4/4+8/N/ddhar5sBC4Lizu8t016GfNp6EsrwbM+xXDlKXhjv7+/6mLLKxT+I1q58J3XdRzqtz07D+d0B+/ae+btjtXXoG40wt+pNx1kJapIqgA1d2Z2nOuP71OtUF5OJiliAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+pETf8s; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+pETf8s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752561705; x=1784097705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IuYZ7TDNy1bf7E/m7zyAAPqADAKNCwz0eV+rlgC83/4=;
  b=W+pETf8s+pqKUVMM/BUiqBAfPUm6F3Bj/ad7izZuJsCfNqDcb0D0nKDZ
   tZqeR4Uhoz/2POjzT6hzvztG5B9g4+vO1j/fBaW0gG2xqNodgYOghhsXX
   yph8yoQC4jfcXe8dxQCtLztJww2+87OCiGP7xbDuXQSNI1oNYqY6/XowO
   /RRsBGdAotLOu+B1K9XPyajJ95ROX6SssJzRYPZAVC7wv1jnB41xIIuRN
   IF55o7LoW7U2bBLDWZxPfavckP48FBqPq4QWPPxKrRXqzQ8vXbtbfCE+7
   w+lYOvv7CnxJkq/u5NuHuyBi+Z8QTwRKEsyWKsNEIFGn20KqSBoLKMfbp
   Q==;
X-CSE-ConnectionGUID: pEFkWLgRRzmXQ71sxMy/mA==
X-CSE-MsgGUID: HLDqOyuDS3ScPbYmCChIrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="53880882"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="53880882"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2025 23:41:44 -0700
X-CSE-ConnectionGUID: Kzi/gXcYRHGPSA/4BHaWmg==
X-CSE-MsgGUID: dg9mlxoTRJm8f0phGIyoNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157649026"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa008.jf.intel.com with ESMTP; 14 Jul 2025 23:41:40 -0700
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
Subject: [PATCH v5 5/8] iommufd/vdevice: Remove struct device reference from struct vdevice
Date: Tue, 15 Jul 2025 14:32:42 +0800
Message-Id: <20250715063245.1799534-6-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
References: <20250715063245.1799534-1-yilun.xu@linux.intel.com>
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
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 +-
 drivers/iommu/iommufd/driver.c                 | 4 ++--
 drivers/iommu/iommufd/viommu.c                 | 3 ---
 include/linux/iommufd.h                        | 1 -
 4 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index eb90af5093d8..8a515987b948 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -1218,7 +1218,7 @@ static void tegra241_vintf_destroy_vsid(struct iommufd_vdevice *vdev)
 
 static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
 {
-	struct arm_smmu_master *master = dev_iommu_priv_get(vdev->dev);
+	struct arm_smmu_master *master = dev_iommu_priv_get(vdev->idev->dev);
 	struct tegra241_vintf *vintf = viommu_to_vintf(vdev->viommu);
 	struct tegra241_vintf_sid *vsid = vdev_to_vsid(vdev);
 	struct arm_smmu_stream *stream = &master->streams[0];
diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index e4eae20bcd4e..df25db6d2eaf 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -92,7 +92,7 @@ struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 	lockdep_assert_held(&viommu->vdevs.xa_lock);
 
 	vdev = xa_load(&viommu->vdevs, vdev_id);
-	return vdev ? vdev->dev : NULL;
+	return vdev ? vdev->idev->dev : NULL;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_find_dev, "IOMMUFD");
 
@@ -109,7 +109,7 @@ int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 
 	xa_lock(&viommu->vdevs);
 	xa_for_each(&viommu->vdevs, index, vdev) {
-		if (vdev->dev == dev) {
+		if (vdev->idev->dev == dev) {
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
index b88911026bc4..ecb0c8abd251 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -109,7 +109,6 @@ struct iommufd_vdevice {
 	struct iommufd_object obj;
 	struct iommufd_viommu *viommu;
 	struct iommufd_device *idev;
-	struct device *dev;
 
 	/*
 	 * Virtual device ID per vIOMMU, e.g. vSID of ARM SMMUv3, vDeviceID of
-- 
2.25.1

