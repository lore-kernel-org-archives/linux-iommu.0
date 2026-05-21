Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7284D36EAAB
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 22:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779401523; cv=none; b=Jf/t9BqrMBcB+/fQmBiixde+AwJZavblobAd2r+5OOyJYR5/nirOeLjeJYeymxDa53SQfnxn/X1JTvqURhFH0wpzgqvv9FK1LjKrdc9Kst2DgumnZwEaP4j0fbK4jLCpPwvlLAOdJrumQwRW7FSt8Dgx6gMhNAAc+phtSFjTFWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779401523; c=relaxed/simple;
	bh=A9ah0RgMfOidz5z7nkdG4Mwg2UwD6V86iSpbtMSeD1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJg4nSNZHIVBcl1930e1eT6PQYSeyIu+irUYORmljFSd94G6l+BXYNXR9DRH/yOF9bSr85CD3m9z6l/qUfZoWWPH25YlSI/NE5lY5wkVDknOFtksJa+DknZKuEMjDDByY9nLt9tdOgziaKUAstw76SKUoQbtBkMfbfeM7RADs4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Qukz5zyU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Qukz5zyU"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.147.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 376F120B7167;
	Thu, 21 May 2026 15:11:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 376F120B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779401512;
	bh=5edBK/N/MRvo0l8pw3uQHEpk9bR+/l7DSu1rr7MICeM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qukz5zyUi7gKJR0TmZCrR9aevV0UmLnBqvbbIIymzzda0yVRSqoC8fx3IhKMkWQ0K
	 jfjRtgEDDtYLYi5ZxY3i8Nhaeo6qoLmguLeyYFnS++3AdOgnJ12MwZyL3okmZumu46
	 wgA95fJDaXl1xVOqiDxeuSxN8MK+ohEJk/SI+gTY=
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
Subject: [PATCH v6 5/7] vfio: Enable cdev noiommu mode under iommufd
Date: Thu, 21 May 2026 15:11:52 -0700
Message-ID: <20260521221155.1375144-6-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
References: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
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

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
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
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/vfio/Kconfig       |  8 +++++---
 drivers/vfio/device_cdev.c |  3 +++
 drivers/vfio/iommufd.c     |  6 +++---
 drivers/vfio/vfio.h        | 20 +++++++++++++-------
 drivers/vfio/vfio_main.c   | 23 +++++++++++++++++++----
 include/linux/vfio.h       |  1 +
 6 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index ceae52fd7586..d3d8fef2855c 100644
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
 
@@ -62,7 +61,10 @@ endif
 
 config VFIO_NOIOMMU
 	bool "VFIO No-IOMMU support"
-	depends on VFIO_GROUP
+	depends on VFIO_GROUP || VFIO_DEVICE_CDEV
+	depends on !VFIO_GROUP || VFIO_CONTAINER || IOMMUFD_VFIO_CONTAINER
+	depends on !VFIO_DEVICE_CDEV || !GENERIC_ATOMIC64
+	select IOMMUFD_NOIOMMU if VFIO_DEVICE_CDEV
 	help
 	  VFIO is built on the ability to isolate devices using the IOMMU.
 	  Only with an IOMMU can userspace access to DMA capable devices be
diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 54abf312cf04..4e2c1e4fc1f8 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -27,6 +27,9 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 	struct vfio_device_file *df;
 	int ret;
 
+	if (device->noiommu && !capable(CAP_SYS_RAWIO))
+		return -EPERM;
+
 	/* Paired with the put in vfio_device_fops_release() */
 	if (!vfio_device_try_get_registration(device))
 		return -ENODEV;
diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index a38d262c6028..d4f2e2a0f2f3 100644
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
@@ -58,7 +58,7 @@ void vfio_df_iommufd_unbind(struct vfio_device_file *df)
 
 	lockdep_assert_held(&vdev->dev_set->lock);
 
-	if (vfio_device_is_noiommu(vdev))
+	if (df->group && vfio_device_is_noiommu(vdev))
 		return;
 
 	if (vdev->ops->unbind_iommufd)
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index e4b72e79b7e3..6f0a2dfc8a00 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -358,19 +358,13 @@ void vfio_init_device_cdev(struct vfio_device *device);
 
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
@@ -420,6 +414,18 @@ static inline void vfio_cdev_cleanup(void)
 }
 #endif /* CONFIG_VFIO_DEVICE_CDEV */
 
+#if IS_ENABLED(CONFIG_VFIO_NOIOMMU)
+static inline bool vfio_device_is_cdev_noiommu(struct vfio_device *vdev)
+{
+	return vdev->noiommu;
+}
+#else
+static inline bool vfio_device_is_cdev_noiommu(struct vfio_device *vdev)
+{
+	return false;
+}
+#endif
+
 #if IS_ENABLED(CONFIG_VFIO_VIRQFD)
 int __init vfio_virqfd_init(void);
 void vfio_virqfd_exit(void);
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 6222376ab6ab..84381c500623 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -321,6 +321,20 @@ static int vfio_init_device(struct vfio_device *device, struct device *dev,
 	return ret;
 }
 
+static int vfio_device_set_noiommu_and_name(struct vfio_device *device)
+{
+	if (IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV) && vfio_noiommu && !device->dev->iommu) {
+		device->noiommu = true;
+		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+		dev_warn(device->dev,
+			 "Adding kernel taint for vfio-noiommu cdev on device\n");
+	}
+
+	/* Just to be safe, expose to user explicitly noiommu cdev node */
+	return dev_set_name(&device->device, "%svfio%d",
+		     device->noiommu ? "noiommu-" : "", device->index);
+}
+
 static int __vfio_register_dev(struct vfio_device *device,
 			       enum vfio_group_type type)
 {
@@ -340,20 +354,21 @@ static int __vfio_register_dev(struct vfio_device *device,
 	if (!device->dev_set)
 		vfio_assign_device_set(device, device);
 
-	ret = dev_set_name(&device->device, "vfio%d", device->index);
+	ret = vfio_device_set_group(device, type);
 	if (ret)
 		return ret;
 
-	ret = vfio_device_set_group(device, type);
+	ret = vfio_device_set_noiommu_and_name(device);
 	if (ret)
-		return ret;
+		goto err_out;
 
 	/*
 	 * VFIO always sets IOMMU_CACHE because we offer no way for userspace to
 	 * restore cache coherency. It has to be checked here because it is only
 	 * valid for cases where we are using iommu groups.
 	 */
-	if (type == VFIO_IOMMU && !vfio_device_is_noiommu(device) &&
+	if (type == VFIO_IOMMU && !(vfio_device_is_noiommu(device) ||
+				    vfio_device_is_cdev_noiommu(device)) &&
 	    !device_iommu_capable(device->dev, IOMMU_CAP_CACHE_COHERENCY)) {
 		ret = -EINVAL;
 		goto err_out;
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

