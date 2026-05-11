Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC4B4BCABB
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524885; cv=none; b=NudZL8XeOOFiTcX9WACF+F7dIKh2SWbEU7V2FaXPbNJoS9cslV+MOdeEW0TrdCKb81as0q3MUwxnBmI5HKfDElbiT7hufYWcN1ph8vmNgJU0iD5U3TPZq3YiJzjyaPaR5mRL52uGjdEoHLTDsyC3EGNr9R+OSCfuG+0LQAJzVn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524885; c=relaxed/simple;
	bh=pGKSHzjBjry0ncUxTRtbbPnjc+fwKLyZhbIVYzJgVoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRRrl0VwLFJhQ64WzN4HY/KVGi27ekpiDQqpe2QDAC4CSpKBaJu+ARdQvlLOZ6u76eLVycieTh97/Nn6sj8mjE7yYd9ayzRs+pEZr+Pc8EIe/iSEURhXckyJcmGxmp49Z7hwW71VAI2JnByyfQTGK28WrwmfjwhJVswhsVX9QrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OXhXbbaW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OXhXbbaW"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.147.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id D00C920B716E;
	Mon, 11 May 2026 11:41:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D00C920B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778524880;
	bh=A8hla75Jg/26Fd28mQp+uOQndUsTAifFfjWEmyAYl8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OXhXbbaWnGQADkQJ1DsIkvpW4qShPrKhsG7gbMUZ/Z87BuehOaGDkKwSYj/+665ub
	 70BxcQqwu6mSrKA3V/HDbM8udWN/cBCyDnrpmEhuKq7C+xvwR4oVM0NkAttAdhIkLr
	 vSkcLUHGBb1WT5U4RMASwjGb1EceEEQ0BWgbSbsg=
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
	Yi Liu <yi.l.liu@intel.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 7/9] vfio: Enable cdev noiommu mode under iommufd
Date: Mon, 11 May 2026 11:41:12 -0700
Message-ID: <20260511184116.3687392-8-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that devices under noiommu mode can bind with IOMMUFD and perform
IOAS operations, lift restrictions on cdev from VFIO side.

Remove the vfio_device_is_group_noiommu() early returns in
vfio_df_iommufd_bind() and vfio_df_iommufd_unbind() so that both
group and cdev noiommu devices go through the standard iommufd bind
path. This is safe because iommufd_device_bind() now handles noiommu
devices via its own iommufd_device_is_noiommu() check.

Add CAP_SYS_RAWIO checks for cdev open and bind under noiommu to
maintain security parity with the group noiommu path.

No IOMMU cdevs are explicitly named with noiommu prefix. e.g.

    /dev/vfio/
    |-- devices
    |   `-- noiommu-vfio0
    `-- vfio

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
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
 drivers/vfio/Kconfig       |  3 +--
 drivers/vfio/device_cdev.c | 10 ++++++++++
 drivers/vfio/iommufd.c     |  7 -------
 drivers/vfio/vfio.h        | 22 ++++++++++++++--------
 drivers/vfio/vfio_main.c   | 25 ++++++++++++++++++++-----
 include/linux/vfio.h       |  1 +
 6 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index b1b1633412a9..b1a260b6054c 100644
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
index 54abf312cf04..46a808244398 100644
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
@@ -110,6 +113,13 @@ long vfio_df_ioctl_bind_iommufd(struct vfio_device_file *df,
 	if (df->group)
 		return -EINVAL;
 
+	/*
+	 * CAP_SYS_RAWIO is already checked at cdev open, recheck here
+	 * in case the fd was passed to a less privileged process.
+	 */
+	if (device->noiommu && !capable(CAP_SYS_RAWIO))
+		return -EPERM;
+
 	ret = vfio_device_block_group(device);
 	if (ret)
 		return ret;
diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index 39079ab27f92..bc80056c74d3 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -25,10 +25,6 @@ int vfio_df_iommufd_bind(struct vfio_device_file *df)
 
 	lockdep_assert_held(&vdev->dev_set->lock);
 
-	/* Returns 0 to permit device opening under noiommu mode */
-	if (vfio_device_is_group_noiommu(vdev))
-		return 0;
-
 	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
 }
 
@@ -58,9 +54,6 @@ void vfio_df_iommufd_unbind(struct vfio_device_file *df)
 
 	lockdep_assert_held(&vdev->dev_set->lock);
 
-	if (vfio_device_is_group_noiommu(vdev))
-		return;
-
 	if (vdev->ops->unbind_iommufd)
 		vdev->ops->unbind_iommufd(vdev);
 }
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 602623cacfc0..ac79b1a2fce9 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -36,7 +36,7 @@ vfio_allocate_device_file(struct vfio_device *device);
 
 extern const struct file_operations vfio_device_fops;
 
-#ifdef CONFIG_VFIO_GROUP_NOIOMMU
+#if IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU) || IS_ENABLED(CONFIG_VFIO_CDEV_NOIOMMU)
 extern bool vfio_noiommu __read_mostly;
 #else
 enum { vfio_noiommu = false };
@@ -358,19 +358,13 @@ void vfio_init_device_cdev(struct vfio_device *device);
 
 static inline int vfio_device_add(struct vfio_device *device)
 {
-	/* cdev does not support noiommu device */
-	if (vfio_device_is_group_noiommu(device))
-		return device_add(&device->device);
 	vfio_init_device_cdev(device);
 	return cdev_device_add(&device->cdev, &device->device);
 }
 
 static inline void vfio_device_del(struct vfio_device *device)
 {
-	if (vfio_device_is_group_noiommu(device))
-		device_del(&device->device);
-	else
-		cdev_device_del(&device->cdev, &device->device);
+	cdev_device_del(&device->cdev, &device->device);
 }
 
 int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep);
@@ -420,6 +414,18 @@ static inline void vfio_cdev_cleanup(void)
 }
 #endif /* CONFIG_VFIO_DEVICE_CDEV */
 
+#if IS_ENABLED(CONFIG_VFIO_CDEV_NOIOMMU)
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
index 4d940ce6f114..1ba0f282d746 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -54,7 +54,7 @@ static struct vfio {
 	int				fs_count;
 } vfio;
 
-#ifdef CONFIG_VFIO_GROUP_NOIOMMU
+#if IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU) || IS_ENABLED(CONFIG_VFIO_CDEV_NOIOMMU)
 bool vfio_noiommu __read_mostly;
 module_param_named(enable_unsafe_noiommu_mode,
 		   vfio_noiommu, bool, S_IRUGO | S_IWUSR);
@@ -321,6 +321,20 @@ static int vfio_init_device(struct vfio_device *device, struct device *dev,
 	return ret;
 }
 
+static int vfio_device_set_noiommu_and_name(struct vfio_device *device)
+{
+	if (IS_ENABLED(CONFIG_VFIO_CDEV_NOIOMMU) && vfio_noiommu && !device->dev->iommu) {
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
-	if (type == VFIO_IOMMU && !vfio_device_is_group_noiommu(device) &&
+	if (type == VFIO_IOMMU && !(vfio_device_is_group_noiommu(device) ||
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

