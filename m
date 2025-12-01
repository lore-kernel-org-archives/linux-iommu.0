Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A87338925
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610225; cv=none; b=G4bQjTBSS8sKHh+Pd6QCwD1W3rVL1/GIStiCV7EL2MFiBzYOjBrgfVez7oP4/egjL/AkYmgqEhtCfltotoBKQYyhWEXCLK7fpfmoTA5gWd7YNA+ywSADZQe5CpFJeb/lv5C+7MkZ1uBZnyQoXmLHsJPk9xCkm4YEy3WoenBawnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610225; c=relaxed/simple;
	bh=M6PxvYcbQtgTVqxhyqWxq+FI4fpOdSGHx0xHT84Gkeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IdD5ZaEWu9lWQoZVUT0aBHlztSmq3B9HFN0UmmPKiOTWHU3bXSZYltBMqfOMdabV6/xAGgKfo8r0oK8P+Ma6EfgViav6vNnoAH6odifChhE3AyW34F2eBoUymhDffkWGnWqh5fqjdnLW2Mh7JLUl4zs4pFNeQwlCwKQgTaeRbME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=q3VXhqsP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="q3VXhqsP"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 030D3206C15E;
	Mon,  1 Dec 2025 09:30:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 030D3206C15E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764610221;
	bh=E9A85AITF9dX4jFtoh0xUotyG6bSXPomrnJpYCVxT5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3VXhqsPfdF6SpPPZ3bHxy2kO5zlbOIkxmzRhJyFXMatXEbZLoy7byDGnrb/v05Vd
	 pDQYNDDNPGdTvlG5tGYiQGNMlPvsOR6E+1Rq9C3BCxZ+iYqQgypEIKWOVXtMqKsQ79
	 F2Yqzn2qplBtjpmMKCQRAw6MHL1RU2RO1vi8yFZg=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	David Matlack <dmatlack@google.com>
Subject: [RFC 7/8] iommu: Enable cdev noiommu mode under iommufd
Date: Mon,  1 Dec 2025 09:30:11 -0800
Message-Id: <20251201173012.18371-8-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With an IOAS capable dummy IOMMU driver in place for noiommu mode, devices
under noiommu mode can now bind with IOMMUFD and performe subsequent
operations such as open, attach, and IOAS map/unmap.

No IOMMU cdevs are explicitly named with noiommu prefix. e.g.

/dev/vfio/
|-- 7
|-- devices
|   `-- noiommu-vfio0
`-- vfio

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/iommufd/hw_pagetable.c |  8 ++++++
 drivers/vfio/Kconfig                 |  3 +--
 drivers/vfio/device_cdev.c           |  6 +++++
 drivers/vfio/vfio.h                  | 38 +++++++++++++++++++++++++++-
 drivers/vfio/vfio_main.c             | 16 +++++++++---
 include/linux/vfio.h                 |  2 ++
 6 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index fe789c2dc0c9..8bf76b2002b4 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -345,6 +345,14 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 	struct iommufd_device *idev;
 	int rc;
 
+	/*
+	 * For devices operating in no-IOMMU mode, permit only the automatic
+	 * domain HWPT where auto domain uses generic iommupt to provide mock
+	 * page tables.
+	 */
+	if (ucmd->ictx->no_iommu_mode)
+		return -EOPNOTSUPP;
+
 	if (cmd->__reserved)
 		return -EOPNOTSUPP;
 	if ((cmd->data_type == IOMMU_HWPT_DATA_NONE && cmd->data_len) ||
diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index ceae52fd7586..7a06a4a9dabe 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -22,8 +22,7 @@ config VFIO_DEVICE_CDEV
 	  The VFIO device cdev is another way for userspace to get device
 	  access. Userspace gets device fd by opening device cdev under
 	  /dev/vfio/devices/vfioX, and then bind the device fd with an iommufd
-	  to set up secure DMA context for device access.  This interface does
-	  not support noiommu.
+	  to set up secure DMA context for device access.
 
 	  If you don't know what to do here, say N.
 
diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 480cac3a0c27..50724e3653ef 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -132,6 +132,12 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
 		goto out_unlock;
 	}
 
+	if (device->noiommu) {
+		ret = iommufd_vfio_set_no_iommu(df->iommufd);
+		if (ret)
+			goto out_unlock;
+	}
+
 	/*
 	 * Before the device open, get the KVM pointer currently
 	 * associated with the device file (if there is) and obtain
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 50128da18bca..4c36de62a5f2 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -118,6 +118,19 @@ static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
 	return IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
 	       vdev->group->type == VFIO_NO_IOMMU;
 }
+
+static inline bool vfio_cdev_is_noiommu(struct vfio_device *vdev)
+{
+	return IS_ENABLED(CONFIG_NOIOMMU_MODE_IOMMU) && vfio_noiommu_enabled();
+}
+
+static inline int vfio_device_set_no_iommu(struct vfio_device *vdev)
+{
+	if (vfio_device_is_noiommu(vdev) || vfio_cdev_is_noiommu(vdev))
+		vdev->noiommu = true;
+
+	return 0;
+}
 #else
 struct vfio_group;
 
@@ -193,6 +206,25 @@ static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
 {
 	return false;
 }
+
+static inline int vfio_device_set_no_iommu(struct vfio_device *vdev)
+{
+	struct iommu_group *iommu_group;
+
+	/* Do not support group device noiommu mode simultaneously */
+	if (iommu_group_get(vdev->dev)) {
+		vdev->noiommu = false;
+		iommu_group_put(iommu_group);
+		return -EINVAL;
+	}
+
+	if (!IS_ENABLED(CONFIG_VFIO_NOIOMMU) || !vfio_noiommu)
+		return -EINVAL;
+
+	vdev->noiommu = true;
+
+	return 0;
+}
 #endif /* CONFIG_VFIO_GROUP */
 
 #if IS_ENABLED(CONFIG_VFIO_CONTAINER)
@@ -359,7 +391,11 @@ void vfio_init_device_cdev(struct vfio_device *device);
 
 static inline int vfio_device_add(struct vfio_device *device)
 {
-	/* cdev does not support noiommu device */
+	/*
+	 * cdev does not support noiommu device for VFIO_NOIOMMU group type.
+	 * However, under IOMMUFD with dummy iommu driver, noiommu mode is
+	 * also supported for cdev devices.
+	 */
 	if (vfio_device_is_noiommu(device))
 		return device_add(&device->device);
 	vfio_init_device_cdev(device);
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 805d30b0b82f..c8aefa13bda3 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -60,6 +60,10 @@ bool vfio_noiommu __read_mostly;
 module_param_named(enable_unsafe_noiommu_mode,
 		   vfio_noiommu, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(enable_unsafe_noiommu_mode, "Enable UNSAFE, no-IOMMU mode.  This mode provides no device isolation, no DMA translation, no host kernel protection, cannot be used for device assignment to virtual machines, requires RAWIO permissions, and will taint the kernel.  If you do not know what this is for, step away. (default: false)");
+bool vfio_noiommu_enabled(void)
+{
+	return vfio_noiommu;
+}
 #endif
 
 static DEFINE_XARRAY(vfio_device_set_xa);
@@ -327,13 +331,19 @@ static int __vfio_register_dev(struct vfio_device *device,
 	if (!device->dev_set)
 		vfio_assign_device_set(device, device);
 
-	ret = dev_set_name(&device->device, "vfio%d", device->index);
+	ret = vfio_device_set_group(device, type);
 	if (ret)
 		return ret;
 
-	ret = vfio_device_set_group(device, type);
+	ret = vfio_device_set_no_iommu(device);
 	if (ret)
-		return ret;
+		goto err_out;
+
+	/* Just to be safe, expose to user explicitly noiommu cdev node */
+	ret = dev_set_name(&device->device, "%svfio%d",
+					   device->noiommu ? "noiommu-" : "", device->index);
+	if (ret)
+		goto err_out;
 
 	/*
 	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index eb563f538dee..944e74dc3da0 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -71,6 +71,7 @@ struct vfio_device {
 	u8 iommufd_attached:1;
 #endif
 	u8 cdev_opened:1;
+	u8 noiommu:1;
 #ifdef CONFIG_DEBUG_FS
 	/*
 	 * debug_root is a static property of the vfio_device
@@ -331,6 +332,7 @@ static inline bool vfio_file_has_dev(struct file *file, struct vfio_device *devi
 	return false;
 }
 #endif
+bool vfio_noiommu_enabled(void);
 bool vfio_file_is_valid(struct file *file);
 bool vfio_file_enforced_coherent(struct file *file);
 void vfio_file_set_kvm(struct file *file, struct kvm *kvm);
-- 
2.34.1

