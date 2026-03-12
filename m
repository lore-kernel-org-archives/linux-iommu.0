Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27143F23CB
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331015; cv=none; b=jaAUFt1EatqMFG1m22gITeoQWT10Mf7VNOJ+Yg+4DP1QEBw1g0atnOKOW1KwxCCmFKjSvqhWrRG/VX8dy8/eR3zPIT4ErbK4LUxGkAd36AoXnv30UnzGgcLp9c+nfeOHpik4dxJ1usSjyuf8CKrG+wRoydDQPFv3GFm1p/gp5oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331015; c=relaxed/simple;
	bh=SavvkJ5bNxk/P/8LG/BekWiO2WEHd51gjqTsZXLBRVs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tr2XDEAOL3YrR53Ts/oi1LdksLkH7EvUM83Gq4Gu6caZylFDeDwfP2wl9h9ZYS+kTqfvYcIedwxL6WXQgllHBIJC57g0kDlxilgvT8n21I7+3SuYZsFeVbo+aLpekBX9w/t9rQ3eM8AxrCFVVyCV3+jmi4RpKskW2dGtUxIxooE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TRfeDbgK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TRfeDbgK"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 290FA20B6F12;
	Thu, 12 Mar 2026 08:56:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 290FA20B6F12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773331012;
	bh=7RSfYj9T7LuqQNLKAWtutzfQn7FQ0Vdz0zSCUEceyQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TRfeDbgKNp4zMigFE+lILXtzKiSIQoDF3YZnAjGLEBbKsXoX4Zt7XZuBDLBBZtdmj
	 v3wr5cacPfRD5uHF5Lc7fRHWzzcY04qmT/ZHvQlvCsMYxfMzHfB01KwZbDly0cgz9K
	 IQ7+MLd7yrFj06hcCrtI6MKrYFSkj8zKn10sK1u0=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: [PATCH V2 08/11] vfio: Enable cdev noiommu mode under iommufd
Date: Thu, 12 Mar 2026 08:56:34 -0700
Message-Id: <20260312155637.376854-9-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that devices under noiommu mode can bind with IOMMUFD and perform
IOAS operations, lift restrictions on cdev from VFIO side.

No IOMMU cdevs are explicitly named with noiommu prefix. e.g.

    /dev/vfio/
    |-- 7
    |-- devices
    |   `-- noiommu-vfio0
    `-- vfio

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>

---
v2:
   - Fix build dependency on IOMMU_SUPPORT

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/vfio/Kconfig     |  7 +++++--
 drivers/vfio/iommufd.c   |  7 -------
 drivers/vfio/vfio.h      |  8 +-------
 drivers/vfio/vfio_main.c | 22 +++++++++++++++++++---
 include/linux/vfio.h     |  9 +++++++++
 5 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index ceae52fd7586..78feca3d0c8b 100644
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
 
@@ -63,6 +62,10 @@ endif
 config VFIO_NOIOMMU
 	bool "VFIO No-IOMMU support"
 	depends on VFIO_GROUP
+	select GENERIC_PT
+	select IOMMU_PT
+	select IOMMU_PT_AMDV1
+	depends on IOMMU_SUPPORT
 	help
 	  VFIO is built on the ability to isolate devices using the IOMMU.
 	  Only with an IOMMU can userspace access to DMA capable devices be
diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index a38d262c6028..26c9c3068c77 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -25,10 +25,6 @@ int vfio_df_iommufd_bind(struct vfio_device_file *df)
 
 	lockdep_assert_held(&vdev->dev_set->lock);
 
-	/* Returns 0 to permit device opening under noiommu mode */
-	if (vfio_device_is_noiommu(vdev))
-		return 0;
-
 	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
 }
 
@@ -58,9 +54,6 @@ void vfio_df_iommufd_unbind(struct vfio_device_file *df)
 
 	lockdep_assert_held(&vdev->dev_set->lock);
 
-	if (vfio_device_is_noiommu(vdev))
-		return;
-
 	if (vdev->ops->unbind_iommufd)
 		vdev->ops->unbind_iommufd(vdev);
 }
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index c5541967ef9b..f6262f2cc7a6 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -381,19 +381,13 @@ void vfio_init_device_cdev(struct vfio_device *device);
 
 static inline int vfio_device_add(struct vfio_device *device)
 {
-	/* cdev does not support noiommu device */
-	if (vfio_device_is_noiommu(device))
-		return device_add(&device->device);
 	vfio_init_device_cdev(device);
 	return cdev_device_add(&device->cdev, &device->device);
 }
 
 static inline void vfio_device_del(struct vfio_device *device)
 {
-	if (vfio_device_is_noiommu(device))
-		device_del(&device->device);
-	else
-		cdev_device_del(&device->cdev, &device->device);
+	cdev_device_del(&device->cdev, &device->device);
 }
 
 int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep);
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 742477546b15..099d9b1ade4c 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -331,13 +331,15 @@ static int __vfio_register_dev(struct vfio_device *device,
 	if (!device->dev_set)
 		vfio_assign_device_set(device, device);
 
-	ret = dev_set_name(&device->device, "vfio%d", device->index);
+	ret = vfio_device_set_group(device, type);
 	if (ret)
 		return ret;
 
-	ret = vfio_device_set_group(device, type);
+	/* Just to be safe, expose to user explicitly noiommu cdev node */
+	ret = dev_set_name(&device->device, "%svfio%d",
+					   device->noiommu ? "noiommu-" : "", device->index);
 	if (ret)
-		return ret;
+		goto err_out;
 
 	/*
 	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
@@ -357,6 +359,10 @@ static int __vfio_register_dev(struct vfio_device *device,
 	/* Refcounting can't start until the driver calls register */
 	refcount_set(&device->refcount, 1);
 
+	/* noiommu device w/o container may have NULL group */
+	if (vfio_device_is_noiommu(device) && !vfio_device_has_group(device))
+		return 0;
+
 	vfio_device_group_register(device);
 	vfio_device_debugfs_init(device);
 
@@ -391,6 +397,16 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 	bool interrupted = false;
 	long rc;
 
+	/*
+	 * For noiommu devices without a container, thus no dummy group,
+	 * simply delete and unregister to balance refcount.
+	 */
+	if (device->noiommu && !vfio_device_has_group(device)) {
+		vfio_device_del(device);
+		vfio_device_put_registration(device);
+		return;
+	}
+
 	/*
 	 * Prevent new device opened by userspace via the
 	 * VFIO_GROUP_GET_DEVICE_FD in the group path.
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 844d14839f96..775bd4f6bae9 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -327,6 +327,10 @@ struct iommu_group *vfio_file_iommu_group(struct file *file);
 #if IS_ENABLED(CONFIG_VFIO_GROUP)
 bool vfio_file_is_group(struct file *file);
 bool vfio_file_has_dev(struct file *file, struct vfio_device *device);
+static inline bool vfio_device_has_group(struct vfio_device *device)
+{
+	return device->group;
+}
 #else
 static inline bool vfio_file_is_group(struct file *file)
 {
@@ -337,6 +341,11 @@ static inline bool vfio_file_has_dev(struct file *file, struct vfio_device *devi
 {
 	return false;
 }
+
+static inline bool vfio_device_has_group(struct vfio_device *device)
+{
+	return false;
+}
 #endif
 bool vfio_file_is_valid(struct file *file);
 bool vfio_file_enforced_coherent(struct file *file);
-- 
2.34.1

