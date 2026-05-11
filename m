Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80C24A2E00
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524880; cv=none; b=lkMxD16zs03/jjKYqIr5p5O37v6VgIN+3a5iIA8puRXvcVGP2WIGACiwzRxRa54SaFFrjhfwfZPWBeDu8aFphLMPfSRb/a3pzBnZZE8yawhGPOfIBrxaWZ72/l/59C2i5HbtTxy/PJgQUk+fqbYvkH8WyRUnZu3V0OuVc2ioTBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524880; c=relaxed/simple;
	bh=fTahA4tH62XGxZMDo/qLrD/qJ0iTEU/i2poil691+Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWvCfuaDvT9FTZ4dbV8nN28hv5i51vYtvYubv45Db9wM2H3hHSg7qm5s5Sbxw9W9qC82HO/YXxL5E/rrKdoiQsGk7UQBlFYjbnkdw0HRTbu/n47jpOYGrZMSS5nORH2iNshZStF1+7NYsiRXEl6ZIXpuph2+ysLo7mIp88eywss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IHOoCaNC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IHOoCaNC"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.147.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3EC5C20B7168;
	Mon, 11 May 2026 11:41:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3EC5C20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778524876;
	bh=xRssKIrcaPGNeeWfmpX+V9VzwqkWcV9psWjiMj7YxA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IHOoCaNC5IdtqMH3gQjCdWcF9RxZO6l4w4YqOjEHmOIJD8bHhqRFW8YECjQk1BOOv
	 gXByBi3W1w79pMW2sKKUFJ/bHVIJ982Uo3G7dhGEco9dMxWYxJCWffIL4U2Kg/1Wcx
	 jEx118qcG1bDYo7KE6gymEBVKDKzs+J4Q7uMHaJ0=
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
Subject: [PATCH v5 1/9] vfio: Rename VFIO_NOIOMMU to VFIO_GROUP_NOIOMMU
Date: Mon, 11 May 2026 11:41:06 -0700
Message-ID: <20260511184116.3687392-2-jacob.pan@linux.microsoft.com>
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

In preparation for adding cdev-based noiommu support under iommufd,
rename CONFIG_VFIO_NOIOMMU to CONFIG_VFIO_GROUP_NOIOMMU to clearly
scope it to the legacy group/container path. Also rename the helper
vfio_device_is_noiommu() to vfio_device_is_group_noiommu() to match.

Add an explicit dependency on VFIO_CONTAINER or IOMMUFD_VFIO_CONTAINER
since the group-based noiommu path is only meaningful when container
support is enabled.

This is a pure rename with no functional change, laying the groundwork
for a separate VFIO_CDEV_NOIOMMU config that enables noiommu mode
through the iommufd cdev interface.

Link: https://lore.kernel.org/linux-iommu/20260416144915.4fe38481@shazbot.org/
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/iommufd/vfio_compat.c |  4 ++--
 drivers/vfio/Kconfig                |  6 +++---
 drivers/vfio/container.c            |  6 +++---
 drivers/vfio/group.c                |  4 ++--
 drivers/vfio/iommufd.c              |  6 +++---
 drivers/vfio/vfio.h                 | 12 ++++++------
 drivers/vfio/vfio_main.c            |  4 ++--
 7 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommufd/vfio_compat.c b/drivers/iommu/iommufd/vfio_compat.c
index acb48cdd3b00..51f4870ec2b3 100644
--- a/drivers/iommu/iommufd/vfio_compat.c
+++ b/drivers/iommu/iommufd/vfio_compat.c
@@ -286,7 +286,7 @@ static int iommufd_vfio_check_extension(struct iommufd_ctx *ictx,
 		return !ictx->no_iommu_mode;
 
 	case VFIO_NOIOMMU_IOMMU:
-		return IS_ENABLED(CONFIG_VFIO_NOIOMMU);
+		return IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU);
 
 	case VFIO_DMA_CC_IOMMU:
 		return iommufd_vfio_cc_iommu(ictx);
@@ -318,7 +318,7 @@ static int iommufd_vfio_set_iommu(struct iommufd_ctx *ictx, unsigned long type)
 	 * other ioctls. We let them keep working but they mostly fail since no
 	 * IOAS should exist.
 	 */
-	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU) && type == VFIO_NOIOMMU_IOMMU &&
+	if (IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU) && type == VFIO_NOIOMMU_IOMMU &&
 	    no_iommu_mode) {
 		if (!capable(CAP_SYS_RAWIO))
 			return -EPERM;
diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index ceae52fd7586..39939be2908e 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -60,9 +60,9 @@ config VFIO_IOMMU_SPAPR_TCE
 	default VFIO
 endif
 
-config VFIO_NOIOMMU
-	bool "VFIO No-IOMMU support"
-	depends on VFIO_GROUP
+config VFIO_GROUP_NOIOMMU
+	bool "VFIO group No-IOMMU support"
+	depends on VFIO_GROUP && (VFIO_CONTAINER || IOMMUFD_VFIO_CONTAINER)
 	help
 	  VFIO is built on the ability to isolate devices using the IOMMU.
 	  Only with an IOMMU can userspace access to DMA capable devices be
diff --git a/drivers/vfio/container.c b/drivers/vfio/container.c
index 003281dbf8bc..9b8cdc5317d8 100644
--- a/drivers/vfio/container.c
+++ b/drivers/vfio/container.c
@@ -80,7 +80,7 @@ static const struct vfio_iommu_driver_ops vfio_noiommu_ops = {
 static bool vfio_iommu_driver_allowed(struct vfio_container *container,
 				      const struct vfio_iommu_driver *driver)
 {
-	if (!IS_ENABLED(CONFIG_VFIO_NOIOMMU))
+	if (!IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU))
 		return true;
 	return container->noiommu == (driver->ops == &vfio_noiommu_ops);
 }
@@ -583,7 +583,7 @@ int __init vfio_container_init(void)
 		return ret;
 	}
 
-	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU)) {
+	if (IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU)) {
 		ret = vfio_register_iommu_driver(&vfio_noiommu_ops);
 		if (ret)
 			goto err_misc;
@@ -597,7 +597,7 @@ int __init vfio_container_init(void)
 
 void vfio_container_cleanup(void)
 {
-	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU))
+	if (IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU))
 		vfio_unregister_iommu_driver(&vfio_noiommu_ops);
 	misc_deregister(&vfio_dev);
 	mutex_destroy(&vfio.iommu_drivers_lock);
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index b2299e5bc6df..5b9329df04e5 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -137,7 +137,7 @@ static int vfio_group_ioctl_set_container(struct vfio_group *group,
 
 	iommufd = iommufd_ctx_from_file(fd_file(f));
 	if (!IS_ERR(iommufd)) {
-		if (IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
+		if (IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU) &&
 		    group->type == VFIO_NO_IOMMU)
 			ret = iommufd_vfio_compat_set_no_iommu(iommufd);
 		else
@@ -190,7 +190,7 @@ static int vfio_df_group_open(struct vfio_device_file *df)
 		vfio_device_group_get_kvm_safe(device);
 
 	df->iommufd = device->group->iommufd;
-	if (df->iommufd && vfio_device_is_noiommu(device) && device->open_count == 0) {
+	if (df->iommufd && vfio_device_is_group_noiommu(device) && device->open_count == 0) {
 		/*
 		 * Require no compat ioas to be assigned to proceed.  The basic
 		 * statement is that the user cannot have done something that
diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index a38d262c6028..39079ab27f92 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -26,7 +26,7 @@ int vfio_df_iommufd_bind(struct vfio_device_file *df)
 	lockdep_assert_held(&vdev->dev_set->lock);
 
 	/* Returns 0 to permit device opening under noiommu mode */
-	if (vfio_device_is_noiommu(vdev))
+	if (vfio_device_is_group_noiommu(vdev))
 		return 0;
 
 	return vdev->ops->bind_iommufd(vdev, ictx, &df->devid);
@@ -41,7 +41,7 @@ int vfio_iommufd_compat_attach_ioas(struct vfio_device *vdev,
 	lockdep_assert_held(&vdev->dev_set->lock);
 
 	/* compat noiommu does not need to do ioas attach */
-	if (vfio_device_is_noiommu(vdev))
+	if (vfio_device_is_group_noiommu(vdev))
 		return 0;
 
 	ret = iommufd_vfio_compat_ioas_get_id(ictx, &ioas_id);
@@ -58,7 +58,7 @@ void vfio_df_iommufd_unbind(struct vfio_device_file *df)
 
 	lockdep_assert_held(&vdev->dev_set->lock);
 
-	if (vfio_device_is_noiommu(vdev))
+	if (vfio_device_is_group_noiommu(vdev))
 		return;
 
 	if (vdev->ops->unbind_iommufd)
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index e4b72e79b7e3..602623cacfc0 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -36,7 +36,7 @@ vfio_allocate_device_file(struct vfio_device *device);
 
 extern const struct file_operations vfio_device_fops;
 
-#ifdef CONFIG_VFIO_NOIOMMU
+#ifdef CONFIG_VFIO_GROUP_NOIOMMU
 extern bool vfio_noiommu __read_mostly;
 #else
 enum { vfio_noiommu = false };
@@ -112,9 +112,9 @@ bool vfio_device_has_container(struct vfio_device *device);
 int __init vfio_group_init(void);
 void vfio_group_cleanup(void);
 
-static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
+static inline bool vfio_device_is_group_noiommu(struct vfio_device *vdev)
 {
-	return IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
+	return IS_ENABLED(CONFIG_VFIO_GROUP_NOIOMMU) &&
 	       vdev->group->type == VFIO_NO_IOMMU;
 }
 #else
@@ -188,7 +188,7 @@ static inline void vfio_group_cleanup(void)
 {
 }
 
-static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
+static inline bool vfio_device_is_group_noiommu(struct vfio_device *vdev)
 {
 	return false;
 }
@@ -359,7 +359,7 @@ void vfio_init_device_cdev(struct vfio_device *device);
 static inline int vfio_device_add(struct vfio_device *device)
 {
 	/* cdev does not support noiommu device */
-	if (vfio_device_is_noiommu(device))
+	if (vfio_device_is_group_noiommu(device))
 		return device_add(&device->device);
 	vfio_init_device_cdev(device);
 	return cdev_device_add(&device->cdev, &device->device);
@@ -367,7 +367,7 @@ static inline int vfio_device_add(struct vfio_device *device)
 
 static inline void vfio_device_del(struct vfio_device *device)
 {
-	if (vfio_device_is_noiommu(device))
+	if (vfio_device_is_group_noiommu(device))
 		device_del(&device->device);
 	else
 		cdev_device_del(&device->cdev, &device->device);
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 6222376ab6ab..4d940ce6f114 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -54,7 +54,7 @@ static struct vfio {
 	int				fs_count;
 } vfio;
 
-#ifdef CONFIG_VFIO_NOIOMMU
+#ifdef CONFIG_VFIO_GROUP_NOIOMMU
 bool vfio_noiommu __read_mostly;
 module_param_named(enable_unsafe_noiommu_mode,
 		   vfio_noiommu, bool, S_IRUGO | S_IWUSR);
@@ -353,7 +353,7 @@ static int __vfio_register_dev(struct vfio_device *device,
 	 * restore cache coherency. It has to be checked here because it is only
 	 * valid for cases where we are using iommu groups.
 	 */
-	if (type == VFIO_IOMMU && !vfio_device_is_noiommu(device) &&
+	if (type == VFIO_IOMMU && !vfio_device_is_group_noiommu(device) &&
 	    !device_iommu_capable(device->dev, IOMMU_CAP_CACHE_COHERENCY)) {
 		ret = -EINVAL;
 		goto err_out;
-- 
2.43.0

