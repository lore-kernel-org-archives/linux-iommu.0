Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BA343E4BC
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 22:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780524139; cv=none; b=ce5bKd+y/bOsT8eIYmJv7pGDKVrghWcuJ1JrNTq5zEfATEToEx2mk5jRSo8uPnG4OUkp+2MXoAtcQZq85+GTPWMLOU+uqEdUPpZN6esrA3vRhccK3i30CTe9lJgIKfEGs92pfLCEgNY1ByWNmsjq6OBmCb4qN1ev6iFx3GXdQjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780524139; c=relaxed/simple;
	bh=0oOUZab0C42KyQHK91KKID/5miNZ34CSruVKduqCvgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eTNpHGNFOf0f4g2zF71jqvcV0r8iRFyXdR+hA0ML8S65Es6ykINEfyaOccxlAidnK5XqSykKauZfIykXSQ28QfcCp81EyXXRU/3bBBBPkTSMGGYjslMieEJDI38vzs8I+u2UdGq/H3mnPnKaIqyWZppilH8qRD879WGLRuEzVJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jW8glq0/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jW8glq0/"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.147.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id A69C520B716A;
	Wed,  3 Jun 2026 15:02:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A69C520B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780524121;
	bh=iFAffnFqEz+0dzezYRbJ6LRxkIFZYw2wBqckTlJVIYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jW8glq0/vFnsVFePjKWiFPy5RIGZt8ZupFedqKx36z5nO+KSymuMmpsQE7cgLdfdL
	 r6+N/znZSmD54fu+zOWGw0W1D/cH4Cmje8oJ6zifAeqN1pUSDgTYumIqTuQhF3OI4B
	 BZ83rzpPDVMBgpGoVYlyWyIDKv6QJMWLeladFI34=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>
Subject: [PATCH v8 5/6] vfio: Enable cdev noiommu mode under iommufd
Date: Wed,  3 Jun 2026 15:02:10 -0700
Message-ID: <20260603220211.2584590-6-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603220211.2584590-1-jacob.pan@linux.microsoft.com>
References: <20260603220211.2584590-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that devices under noiommu mode can bind with IOMMUFD and perform
IOAS operations, lift restrictions on cdev from VFIO side.
Use cases are documented in Documentation/driver-api/vfio.rst

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
v8:
  - Fix warning message (Kevin)
v7:
  - Avoid treating emulated device as noiommu device (Sashiko)
  - Keep platforms w/ GENERIC_ATOMIC64 to use VFIO group noiommu as
    before (Sashiko)
  - Restore order of group & cdev init for noiommu (Yi)
  - Consolidate noiommu helper for cdev & group (Yi)
v6:
  - Revert back to unified VFIO_NOIOMMU Kconfig for both cdev and group.
    Use Kconfig dependency to restrict usages and avoid null group
    checks. (Alex & Yi)
  - Add CAP_SYS_RAWIO checks for cdev open to maintain security parity
    with the group noiommu path. (Alex)
v5:
   - Add Kconfig VFIO_CDEV_NOIOMMU to select IOMMUFD_NOIOMMU
     and its dependencies
   - Add comment to explain vfio_noiommu conditional definition (Alex)
   - Removed early return for group noiommu in bind/unbind
   - Use consistent wording referring to VFIO noiommu mode (Kevin)
   - Update unsafe_noiommu Kconfig help text (Kevin)
   - Change dev_warn to dev_info for noiommu enabling msg (Kevin)
v4:
   - Remove early return in iommufd_bind for noiommu (Alex)
v3:
   - Consolidate into fewer patches
v2:
   - removed unnecessary device->noiommu set in
     iommufd_vfio_compat_ioas_get_id()

---
 drivers/vfio/Kconfig       |  7 ++++---
 drivers/vfio/device_cdev.c |  3 +++
 drivers/vfio/iommufd.c     | 12 ++++++++----
 drivers/vfio/vfio.h        | 23 +++++++++--------------
 drivers/vfio/vfio_main.c   | 26 +++++++++++++++++++++++++-
 include/linux/vfio.h       |  1 +
 6 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index ceae52fd7586..b9d6e1c22aed 100644
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
 
@@ -62,7 +61,9 @@ endif
 
 config VFIO_NOIOMMU
 	bool "VFIO No-IOMMU support"
-	depends on VFIO_GROUP
+	depends on VFIO_GROUP || (VFIO_DEVICE_CDEV && !GENERIC_ATOMIC64)
+	depends on !VFIO_GROUP || VFIO_CONTAINER || IOMMUFD_VFIO_CONTAINER
+	select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV && !GENERIC_ATOMIC64
 	help
 	  VFIO is built on the ability to isolate devices using the IOMMU.
 	  Only with an IOMMU can userspace access to DMA capable devices be
diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 54abf312cf04..5ca14979b56e 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -27,6 +27,9 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 	struct vfio_device_file *df;
 	int ret;
 
+	if (vfio_device_is_noiommu(device) && !capable(CAP_SYS_RAWIO))
+		return -EPERM;
+
 	/* Paired with the put in vfio_device_fops_release() */
 	if (!vfio_device_try_get_registration(device))
 		return -ENODEV;
diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index a38d262c6028..e9893d34d07b 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -25,8 +25,8 @@ int vfio_df_iommufd_bind(struct vfio_device_file *df)
 
 	lockdep_assert_held(&vdev->dev_set->lock);
 
-	/* Returns 0 to permit device opening under noiommu mode */
-	if (vfio_device_is_noiommu(vdev))
+	/* Group noiommu via iommufd compat needs no device binding */
+	if (df->group && vfio_device_is_noiommu(vdev))
 		return 0;
 
 	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
@@ -40,7 +40,11 @@ int vfio_iommufd_compat_attach_ioas(struct vfio_device *vdev,
 
 	lockdep_assert_held(&vdev->dev_set->lock);
 
-	/* compat noiommu does not need to do ioas attach */
+	/*
+	 * Compat noiommu does not need to do ioas attach. This helper is
+	 * only called from the legacy group/iommufd compat path, so no
+	 * explicit df->group check is needed.
+	 */
 	if (vfio_device_is_noiommu(vdev))
 		return 0;
 
@@ -58,7 +62,7 @@ void vfio_df_iommufd_unbind(struct vfio_device_file *df)
 
 	lockdep_assert_held(&vdev->dev_set->lock);
 
-	if (vfio_device_is_noiommu(vdev))
+	if (df->group && vfio_device_is_noiommu(vdev))
 		return;
 
 	if (vdev->ops->unbind_iommufd)
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index e4b72e79b7e3..7728bc99b63d 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -112,11 +112,6 @@ bool vfio_device_has_container(struct vfio_device *device);
 int __init vfio_group_init(void);
 void vfio_group_cleanup(void);
 
-static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
-{
-	return IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
-	       vdev->group->type == VFIO_NO_IOMMU;
-}
 #else
 struct vfio_group;
 
@@ -188,11 +183,17 @@ static inline void vfio_group_cleanup(void)
 {
 }
 
+#endif /* CONFIG_VFIO_GROUP */
+
 static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
 {
-	return false;
+#if IS_ENABLED(CONFIG_VFIO_GROUP)
+	if (vdev->group && vdev->group->type == VFIO_NO_IOMMU)
+		return true;
+#endif
+
+	return IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && vdev->noiommu;
 }
-#endif /* CONFIG_VFIO_GROUP */
 
 #if IS_ENABLED(CONFIG_VFIO_CONTAINER)
 /**
@@ -358,19 +359,13 @@ void vfio_init_device_cdev(struct vfio_device *device);
 
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
index 6222376ab6ab..fc8a50941aac 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -321,6 +321,24 @@ static int vfio_init_device(struct vfio_device *device, struct device *dev,
 	return ret;
 }
 
+static int vfio_device_set_noiommu_and_name(struct vfio_device *device, enum vfio_group_type type)
+{
+	if (IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && vfio_noiommu &&
+	    !device->dev->iommu && type == VFIO_IOMMU)
+		device->noiommu = true;
+
+	/*
+	 * device->noiommu records no-IOMMU support for the standalone cdev
+	 * interface. VFIO_NOIOMMU enables both group and cdev no-IOMMU; when
+	 * cdev no-IOMMU is available, device->noiommu is set before
+	 * vfio_device_set_group(), so the cdev is named noiommu-vfio%d up
+	 * front. There cannot be a combination of a plain vfio%d cdev name and
+	 * a no-IOMMU group because VFIO_NOIOMMU selects IOMMUFD_NOIOMMU.
+	 */
+	return dev_set_name(&device->device, "%svfio%d",
+		     device->noiommu ? "noiommu-" : "", device->index);
+}
+
 static int __vfio_register_dev(struct vfio_device *device,
 			       enum vfio_group_type type)
 {
@@ -340,7 +358,7 @@ static int __vfio_register_dev(struct vfio_device *device,
 	if (!device->dev_set)
 		vfio_assign_device_set(device, device);
 
-	ret = dev_set_name(&device->device, "vfio%d", device->index);
+	ret = vfio_device_set_noiommu_and_name(device, type);
 	if (ret)
 		return ret;
 
@@ -348,6 +366,12 @@ static int __vfio_register_dev(struct vfio_device *device,
 	if (ret)
 		return ret;
 
+	if (vfio_device_is_noiommu(device) && IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU)) {
+		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+		dev_warn(device->dev,
+			 "Adding kernel taint for vfio-noiommu cdev\n");
+	}
+
 	/*
 	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
 	 * restore cache coherency. It has to be checked here because it is only
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 31b826efba00..45f08986359e 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -74,6 +74,7 @@ struct vfio_device {
 	u8 iommufd_attached:1;
 #endif
 	u8 cdev_opened:1;
+	u8 noiommu:1;
 	/*
 	 * debug_root is a static property of the vfio_device
 	 * which must be set prior to registering the vfio_device.
-- 
2.43.0

