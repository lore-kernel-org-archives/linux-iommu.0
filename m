Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B0A359A91
	for <iommu@lists.linux.dev>; Fri,  3 Apr 2026 05:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775193119; cv=none; b=F2j752ALPC+PyCMN+SQ8oOjPGWKNRtJkn1wE6a1jPPWxp2mUSIvIFgV+n75HI63TTJO7x5CvVuKmGxVYgMZtaA4RyMa4OXvYEjpy+bYKYh1UTyIt57FilF/ITC17QH16neqyVZjP2/vZ3MmL6F/FxD5lsll4welQKhMOQbAss+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775193119; c=relaxed/simple;
	bh=JkhZlvmHm9PAlbHRlrqKn4Q6uhDD2PqmEbUIHqFiBu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SMcYyrTAdp38pYMxHBb+3Msj+3QYsq5tUXVHyIqQ8w52e4Za5qqi6zNxhaIeTyj2tQgAbxYOYwm7sbWzOV1zZuqOMY88LU1MWJeuMexnkawYcDr1ONEcC565/f8BirWpe9BezeiJoVFVi0E7+VUG5ebaT3QKsRCO5v3MxXB0FCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pQI1jUsJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pQI1jUsJ"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 95E8A20B7001;
	Thu,  2 Apr 2026 22:11:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 95E8A20B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775193117;
	bh=VwHsOvGTMe2LQ3uXKZ66LHxSdQYzdzozr/qGh5zhYXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pQI1jUsJcPQFuRLMTkMbJ33l4fDQmrVCS3xISCjeDJ72axQ6nqDdDF80U+yO16r7b
	 0AtrlUQkX1n/rpuoDWkHeyor25EgvsxWTXLnD5WjcSlUNT2iBFdE5zwPYclikRHHSA
	 bDIaUpm9UQRd+B7KaMTsL0nV75jC1qrRVAOsM9uU=
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
Subject: [PATCH V3 06/10] vfio: Introduce and set noiommu flag on vfio_device
Date: Thu,  2 Apr 2026 22:11:42 -0700
Message-Id: <20260403051146.10210-7-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260403051146.10210-1-jacob.pan@linux.microsoft.com>
References: <20260403051146.10210-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a VFIO device is added to a noiommu group, set the noiommu flag on
the vfio_device structure to indicate that the device operates in
noiommu mode.

Also update function signatures to pass vfio_device instead of device,
which has the direct access to the noiommu flag.

Reviewed-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
v3:
   - Squashed with vfio noiommu logic check patch 7/11 of v2 (Mostafa)
---
 drivers/vfio/group.c | 21 +++++++++++----------
 drivers/vfio/vfio.h  |  3 +--
 include/linux/vfio.h |  1 +
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 9e88610934c8..f41cc0fa2759 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -597,7 +597,7 @@ static struct vfio_group *vfio_create_group(struct iommu_group *iommu_group,
 	return ret;
 }
 
-static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
+static struct vfio_group *vfio_noiommu_group_alloc(struct vfio_device *vdev,
 		enum vfio_group_type type)
 {
 	struct iommu_group *iommu_group;
@@ -619,7 +619,7 @@ static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
 	ret = iommu_group_set_name(iommu_group, "vfio-noiommu");
 	if (ret)
 		goto out_put_group;
-	ret = iommu_group_add_device(iommu_group, dev);
+	ret = iommu_group_add_device(iommu_group, vdev->dev);
 	if (ret)
 		goto out_put_group;
 
@@ -634,7 +634,7 @@ static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
 	return group;
 
 out_remove_device:
-	iommu_group_remove_device(dev);
+	iommu_group_remove_device(vdev->dev);
 out_put_group:
 	iommu_group_put(iommu_group);
 	return ERR_PTR(ret);
@@ -655,23 +655,24 @@ static bool vfio_group_has_device(struct vfio_group *group, struct device *dev)
 	return false;
 }
 
-static struct vfio_group *vfio_group_find_or_alloc(struct device *dev)
+static struct vfio_group *vfio_group_find_or_alloc(struct vfio_device *vdev)
 {
 	struct iommu_group *iommu_group;
 	struct vfio_group *group;
 
-	iommu_group = iommu_group_get(dev);
+	iommu_group = iommu_group_get(vdev->dev);
 	if (!iommu_group && vfio_noiommu) {
+		vdev->noiommu = 1;
 		/*
 		 * With noiommu enabled, create an IOMMU group for devices that
 		 * don't already have one, implying no IOMMU hardware/driver
 		 * exists.  Taint the kernel because we're about to give a DMA
 		 * capable device to a user without IOMMU protection.
 		 */
-		group = vfio_noiommu_group_alloc(dev, VFIO_NO_IOMMU);
+		group = vfio_noiommu_group_alloc(vdev, VFIO_NO_IOMMU);
 		if (!IS_ERR(group)) {
 			add_taint(TAINT_USER, LOCKDEP_STILL_OK);
-			dev_warn(dev, "Adding kernel taint for vfio-noiommu group on device\n");
+			dev_warn(vdev->dev, "Adding kernel taint for vfio-noiommu group on device\n");
 		}
 		return group;
 	}
@@ -682,7 +683,7 @@ static struct vfio_group *vfio_group_find_or_alloc(struct device *dev)
 	mutex_lock(&vfio.group_lock);
 	group = vfio_group_find_from_iommu(iommu_group);
 	if (group) {
-		if (WARN_ON(vfio_group_has_device(group, dev)))
+		if (WARN_ON(vfio_group_has_device(group, vdev->dev)))
 			group = ERR_PTR(-EINVAL);
 		else
 			refcount_inc(&group->drivers);
@@ -702,9 +703,9 @@ int vfio_device_set_group(struct vfio_device *device,
 	struct vfio_group *group;
 
 	if (type == VFIO_IOMMU)
-		group = vfio_group_find_or_alloc(device->dev);
+		group = vfio_group_find_or_alloc(device);
 	else
-		group = vfio_noiommu_group_alloc(device->dev, type);
+		group = vfio_noiommu_group_alloc(device, type);
 
 	if (IS_ERR(group))
 		return PTR_ERR(group);
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index db1530bb1716..9e25605da564 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -128,8 +128,7 @@ static inline bool vfio_null_group_allowed(void)
 
 static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
 {
-	return IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
-	       vdev->group->type == VFIO_NO_IOMMU;
+	return IS_ENABLED(CONFIG_VFIO_NOIOMMU) && vdev->noiommu;
 }
 #else
 struct vfio_group;
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 7384965d15d7..bb3ce7d0daf8 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -72,6 +72,7 @@ struct vfio_device {
 	u8 iommufd_attached:1;
 #endif
 	u8 cdev_opened:1;
+	u8 noiommu:1;
 #ifdef CONFIG_DEBUG_FS
 	/*
 	 * debug_root is a static property of the vfio_device
-- 
2.34.1

