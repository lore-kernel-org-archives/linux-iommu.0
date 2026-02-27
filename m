Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F98F36402F
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 17:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772214777; cv=none; b=kMFeKORA6gDJNpy3oV4cSr+7fTaNYa1VedDBbWlV+pz7KKLvC0/N5pruyJBo5pJRNkip7s+tj7lZgHIOzNdzlGZeO2AQ8rEQh2RU28l+ba7qhUukSgo0zocmXpTbx3wTNkanBL3JMriOpy05/64Cjm4CREK05avNhfV2Q1q7oUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772214777; c=relaxed/simple;
	bh=vIsw4yuGQk7MJfcxOGm893uXXqE/sHLD0s/h51EyV40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KpPR52FK7hdli2p1J6EWruVOAmKsTw6jqxj5kPaGi9EfLKB+Ikok6CFhRqP8G7kdOry2l9h0fj2cZ9Bt+PcglIh6YoxQ9IJEAnob5I65CfleYm7iym2qy2CzH8QitTgx/6uicFJb3+iU2C3EnYTrGaZBhi0bE+H0dnCk3X5sZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kAzG/3ti; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kAzG/3ti"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 20E9420B6F04;
	Fri, 27 Feb 2026 09:52:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 20E9420B6F04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772214774;
	bh=W96SnSZLqhLnwJNZa3jg8QlmCEk8GqczL6oQb+wbHn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kAzG/3tiWFatrITES0s8oFu1G3B2tQoDTgML+EVOt6BzTMJ4QFSWOdhudKYocBzZT
	 EmBSuGwAu+XbPhuPXz4cpMqFw2YCYM+b9QKUQvlT+mlUI+n/yZBYpAnTf8XYK6+/v5
	 570x/3ARs7/GebzhHoJ3TJf7ljcWKfuzEw2AIuO4=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 06/11] vfio: Introduce and set noiommu flag on vfio_device
Date: Fri, 27 Feb 2026 09:52:42 -0800
Message-Id: <20260227175247.26103-7-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227175247.26103-1-jacob.pan@linux.microsoft.com>
References: <20260227175247.26103-1-jacob.pan@linux.microsoft.com>
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

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/vfio/group.c | 21 +++++++++++----------
 include/linux/vfio.h |  1 +
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 98f2a4f2ebff..6f98c57de9e0 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -588,7 +588,7 @@ static struct vfio_group *vfio_create_group(struct iommu_group *iommu_group,
 	return ret;
 }
 
-static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
+static struct vfio_group *vfio_noiommu_group_alloc(struct vfio_device *vdev,
 		enum vfio_group_type type)
 {
 	struct iommu_group *iommu_group;
@@ -610,7 +610,7 @@ static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
 	ret = iommu_group_set_name(iommu_group, "vfio-noiommu");
 	if (ret)
 		goto out_put_group;
-	ret = iommu_group_add_device(iommu_group, dev);
+	ret = iommu_group_add_device(iommu_group, vdev->dev);
 	if (ret)
 		goto out_put_group;
 
@@ -625,7 +625,7 @@ static struct vfio_group *vfio_noiommu_group_alloc(struct device *dev,
 	return group;
 
 out_remove_device:
-	iommu_group_remove_device(dev);
+	iommu_group_remove_device(vdev->dev);
 out_put_group:
 	iommu_group_put(iommu_group);
 	return ERR_PTR(ret);
@@ -646,23 +646,24 @@ static bool vfio_group_has_device(struct vfio_group *group, struct device *dev)
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
@@ -673,7 +674,7 @@ static struct vfio_group *vfio_group_find_or_alloc(struct device *dev)
 	mutex_lock(&vfio.group_lock);
 	group = vfio_group_find_from_iommu(iommu_group);
 	if (group) {
-		if (WARN_ON(vfio_group_has_device(group, dev)))
+		if (WARN_ON(vfio_group_has_device(group, vdev->dev)))
 			group = ERR_PTR(-EINVAL);
 		else
 			refcount_inc(&group->drivers);
@@ -693,9 +694,9 @@ int vfio_device_set_group(struct vfio_device *device,
 	struct vfio_group *group;
 
 	if (type == VFIO_IOMMU)
-		group = vfio_group_find_or_alloc(device->dev);
+		group = vfio_group_find_or_alloc(device);
 	else
-		group = vfio_noiommu_group_alloc(device->dev, type);
+		group = vfio_noiommu_group_alloc(device, type);
 
 	if (IS_ERR(group))
 		return PTR_ERR(group);
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index e90859956514..844d14839f96 100644
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

