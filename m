Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE61B4F0A
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 03:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750995965; cv=none; b=EC7zc/cl69jAZyjoprTtveTd1vbQkUWL3+qMarImz0XweMCH67iB79WcacDgrpWSd2LN60vYVJSHwBpV0+yQFHBkP6RongW2k059+PiQWMuiOjwDee/5c1RM6Z8s/mEYjnddI1q3RiEDoghma7U6ZopQYVrIkaSr3nsMrIWdz4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750995965; c=relaxed/simple;
	bh=l9k3mdCWT0ONzAFd2LOEwhh/YT2VGhLejL8ldrBxF3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OEhIM7U+H16/9EnTbVcEPIl1eboKaO8sXcLekRIS436LQa31qhr86+ZTL9jde23qKrLPFm8jQztOKzau5tE7H7CyGKGh0Hg6d4t7C0tyBEN5OWBL0mgYPVaowYL4Dh3+axKJS6IJ8EKdTu9tsPjk7Rkq00PgnXDXdKHT6XRPUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VXhELsjt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VXhELsjt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750995964; x=1782531964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l9k3mdCWT0ONzAFd2LOEwhh/YT2VGhLejL8ldrBxF3Q=;
  b=VXhELsjtRFG5Y/PxJCPDdjzj5lWQR2Fcp5YJynnEjbCzS7s5Kz62vor0
   BVM6tHldX3gyCSPQxqs0JcZTLzzToVioR3WSmnAGwDThBAjKGhEpAQ3yQ
   NI5A+JuxxOBG9vi6+NLD84ozn9FphRlxxtuVOwpQ28g5xnxg0ZCxxyAIx
   iXejNg7pgwPa2qs2jolDYKaAojWTYHvFsyT214yCKy4Ib1YB0en6LoI1o
   NzG8pDeNahrZVgkPOajj14WaoUa4/vOO/tKbFb9/9FiYme248D9e3zy2T
   MJH/9bjo8OShtRWeFIAc4G/Z0fMHXFx2IO5qwS3NCbYx0HsJdvrjaHCQT
   w==;
X-CSE-ConnectionGUID: T6+i8J2GRkemZAJuRRs+vw==
X-CSE-MsgGUID: /K94b0FXRqqV2Q1UAf5QhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53454217"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="53454217"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 20:46:03 -0700
X-CSE-ConnectionGUID: YKK1TYiLT2yTuFiJlLIeDw==
X-CSE-MsgGUID: EYWa3MkRQvOMZV0SkcTSUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="176374862"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jun 2025 20:46:00 -0700
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
Subject: [PATCH v3 3/5] iommufd/vdevice: Remove struct device reference from struct vdevice
Date: Fri, 27 Jun 2025 11:38:07 +0800
Message-Id: <20250627033809.1730752-4-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
References: <20250627033809.1730752-1-yilun.xu@linux.intel.com>
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

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/iommufd/driver.c          | 4 ++--
 drivers/iommu/iommufd/iommufd_private.h | 1 -
 drivers/iommu/iommufd/viommu.c          | 3 ---
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 922cd1fe7ec2..942d402bba36 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -45,7 +45,7 @@ struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
 	lockdep_assert_held(&viommu->vdevs.xa_lock);
 
 	vdev = xa_load(&viommu->vdevs, vdev_id);
-	return vdev ? vdev->dev : NULL;
+	return vdev ? vdev->idev->dev : NULL;
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_viommu_find_dev, "IOMMUFD");
 
@@ -62,7 +62,7 @@ int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
 
 	xa_lock(&viommu->vdevs);
 	xa_for_each(&viommu->vdevs, index, vdev) {
-		if (vdev->dev == dev) {
+		if (vdev->idev->dev == dev) {
 			*vdev_id = vdev->id;
 			rc = 0;
 			break;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index f58aa4439c53..3700193471db 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -628,7 +628,6 @@ struct iommufd_vdevice {
 	struct iommufd_object obj;
 	struct iommufd_ctx *ictx;
 	struct iommufd_viommu *viommu;
-	struct device *dev;
 	u64 id; /* per-vIOMMU virtual ID */
 	struct iommufd_device *idev;
 };
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 632d1d7b8fd8..452a7a24d738 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -103,7 +103,6 @@ void iommufd_vdevice_abort(struct iommufd_object *obj)
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
 	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
-	put_device(vdev->dev);
 	vdev->viommu = NULL;
 	idev->vdev = NULL;
 }
@@ -159,8 +158,6 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	}
 
 	vdev->id = virt_id;
-	vdev->dev = idev->dev;
-	get_device(idev->dev);
 	vdev->viommu = viommu;
 	refcount_inc(&viommu->obj.users);
 	/*
-- 
2.25.1

