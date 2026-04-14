Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244A33803F9
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 21:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776201262; cv=none; b=M9+d1HatQK3UxtY6u4ursGH1J3lDYBDZFAmt5Uqgfh9mWMlXYlbesQ00Cx+zu5QFqdjnT7Yw0wc5PaIIaYGgv/6O3zOvhnpWHxDJ5uSEjw6lXMjgezmKJqq5zq8KHASaORTbpMD/f0zVBrb6EeT40C8wExrfg/HE5yh3mJFkwcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776201262; c=relaxed/simple;
	bh=EphhcaxyLDa/srh7+qco6UOAcGo9WUAhUYaGgE0Il44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W+BVxcchCmBPqfYn8YVGpktIY7ElnWE99oPfNdM8YBOM2rswVDHxVP4fQCgAimlQz0ZDf4+FMiyM2JAmknH6Cr7fRWZurRHquFe0kD/S0lvQ7aAJXaId8OOjJ81togiKwtiEnPW+0upyT6OcVTwtCcrrj1yvOHWHX0kgzV53kAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SeISo8EA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SeISo8EA"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8EC4320B6F0C;
	Tue, 14 Apr 2026 14:14:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8EC4320B6F0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776201259;
	bh=Lnu30SbS/Ukekt8h2B59910/avV7ytB1fZw6oe0YW1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SeISo8EAJMWroAt4wBK3GUhKtTCGZNmP6RKfg06+D4Mlftgwl350rvRmPnHJ/Wrj1
	 fnMMp+QPbcdsEEDIrR3FX+uBGFkQlxlkIrYBs1LE2Q6Ue6BLtr7gH7XDRdRsGBrgEG
	 YbBFgL01zt52HTGaQEByLpvKuCnEfCue1XxG4q50=
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
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: [PATCH V4 07/10] vfio: Enable cdev noiommu mode under iommufd
Date: Tue, 14 Apr 2026 14:14:09 -0700
Message-Id: <20260414211412.2729-8-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
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
v4:
   - Move vfio_device_has_group() related out to 5/10
   - Keep wait loop in vfio_unregister_group_dev (Jason)
v3:
   - Add explict dependency on !GENERIC_ATOMIC64
v2:
   - Fix build dependency on IOMMU_SUPPORT
---
 drivers/vfio/Kconfig     |  8 ++++++--
 drivers/vfio/iommufd.c   |  7 -------
 drivers/vfio/vfio.h      |  8 +-------
 drivers/vfio/vfio_main.c | 20 ++++++--------------
 4 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index ceae52fd7586..c013255bf7f1 100644
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
 
@@ -63,6 +62,11 @@ endif
 config VFIO_NOIOMMU
 	bool "VFIO No-IOMMU support"
 	depends on VFIO_GROUP
+	depends on !GENERIC_ATOMIC64 # IOMMU_PT_AMDV1 requires cmpxchg64
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
index 9e25605da564..ad9e09f6d095 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -376,19 +376,13 @@ void vfio_init_device_cdev(struct vfio_device *device);
 
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
index 5d7c2d014689..3ae3d34c21cc 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -332,13 +332,15 @@ static int __vfio_register_dev(struct vfio_device *device,
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
@@ -359,7 +361,7 @@ static int __vfio_register_dev(struct vfio_device *device,
 	refcount_set(&device->refcount, 1);
 
 	/* noiommu device w/o container may have NULL group */
-	if (!vfio_device_has_group(device))
+	if (vfio_device_is_noiommu(device) && !vfio_device_has_group(device))
 		return 0;
 
 	vfio_device_group_register(device);
@@ -396,16 +398,6 @@ void vfio_unregister_group_dev(struct vfio_device *device)
 	bool interrupted = false;
 	long rc;
 
-	/*
-	 * For noiommu devices without a container, thus no dummy group,
-	 * simply delete and unregister to balance refcount.
-	 */
-	if (!vfio_device_has_group(device)) {
-		vfio_device_del(device);
-		vfio_device_put_registration(device);
-		return;
-	}
-
 	/*
 	 * Prevent new device opened by userspace via the
 	 * VFIO_GROUP_GET_DEVICE_FD in the group path.
-- 
2.34.1

