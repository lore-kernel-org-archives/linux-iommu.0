Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2DB1A841C
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 03:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750995962; cv=none; b=ryPQecjmmgFEIxsClGff6PaFHf4dDpfIzKkAz9m5PBV4z2dK8jsygh1TlkrICLV2LsSlspl920ug2p6v3GVRlqqiE2jR3FKXLAI1juoYbPibnesp2VEow0H8bKvOEn5awV3FzntIQ20ApG+OFRajKZMPulpM9FQsQH6tikaqlZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750995962; c=relaxed/simple;
	bh=afEJLy5I97odOBS6VJbWXRxt7Bwm+rnXh/rKVVbIvZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eTodYQpjCPF8hn4XbHwvIIvVySv9MRcJ23gQS2ZhpyCBPX3FdRC9JK5QQljw0wn3m6QDN3J7BMWp/PxHuXFOR9aVgzGGkOB5q/5dWfd1hX/v/Tq8eRKqjD+gd0dUFHr55HQmLrWQqfUyLgAJPy40oiRwqLN6+vWT43LRb6SAvw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S+2yVH0T; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S+2yVH0T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750995960; x=1782531960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=afEJLy5I97odOBS6VJbWXRxt7Bwm+rnXh/rKVVbIvZI=;
  b=S+2yVH0TWF0iUGgbgUsaoOwagh7pvJRy6SUFvDfI2B840AABpIH6Kc89
   zwDKgFc9S+/0036UGPaDbprj6KeG3sY8RkmalLi1Xw2Swaw4fb4rWqlLt
   iJZ+HX/BWKU6cgfQmPfQ+33zgTd5uvMIxswExg94AuacrgMCye2QzeaaO
   SoQX75Mb6AhF7irqqECClAGUz07oDpmqlglyfDirSn8ZjLfLc6u0KMdgQ
   9VNYmim9FoJZlMtFZlE69CjmF8qmp6LsAaKfQC+OMpykrmAbAwOZvPQkr
   ZM5V+SBknlPPBIL7McJicr1FHAnsLCE0FlTu5yQCymkBMBAo6HtW4Zf0F
   Q==;
X-CSE-ConnectionGUID: Em44jacLT9C9i5s1F8bJQQ==
X-CSE-MsgGUID: qiLXTP8gSqyRj8kW3aOCRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53454205"
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="53454205"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 20:46:00 -0700
X-CSE-ConnectionGUID: mQOdIHaNQGSqSIN0g9CrBQ==
X-CSE-MsgGUID: QFR0VJbhTZqcGW6s//jgow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,269,1744095600"; 
   d="scan'208";a="176374852"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa002.fm.intel.com with ESMTP; 26 Jun 2025 20:45:57 -0700
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
Subject: [PATCH v3 2/5] iommufd: Destroy vdevice on idevice destroy
Date: Fri, 27 Jun 2025 11:38:06 +0800
Message-Id: <20250627033809.1730752-3-yilun.xu@linux.intel.com>
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

Destroy iommufd_vdevice (vdev) on iommufd_idevice (idev) destroy so
that vdev can't outlive idev.

iommufd_device (idev) represents the physical device bound to iommufd,
while the iommufd_vdevice (vdev) represents the virtual instance of the
physical device in the VM. The lifecycle of the vdev should not be
longer than idev. This doesn't cause real problem on existing use cases
cause vdev doesn't impact the physical device, only provides
virtualization information. But to extend vdev for Confidential
Computing (CC), there are needs to do secure configuration for the vdev,
e.g. TSM Bind/Unbind. These configurations should be rolled back on idev
destroy, or the external driver (VFIO) functionality may be impact.

Building the association between idev & vdev requires the two objects
pointing each other, but not referencing each other. This requires
proper locking. This is done by reviving some of Nicolin's patch [1].

There are 3 cases on idev destroy:

  1. vdev is already destroyed by userspace. No extra handling needed.
  2. vdev is still alive. Use iommufd_object_tombstone_user() to
     destroy vdev and tombstone the vdev ID.
  3. vdev is being destroyed by userspace. The vdev ID is already freed,
     but vdev destroy handler is not completed. Destroy the vdev
     immediately. To solve the racing with userspace destruction, make
     iommufd_vdevice_abort() reentrant.

[1]: https://lore.kernel.org/all/53025c827c44d68edb6469bfd940a8e8bc6147a5.1729897278.git.nicolinc@nvidia.com/

Originally-by: Nicolin Chen <nicolinc@nvidia.com>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/iommufd/device.c          | 42 +++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h | 11 +++++++
 drivers/iommu/iommufd/main.c            |  1 +
 drivers/iommu/iommufd/viommu.c          | 44 +++++++++++++++++++++++--
 4 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 86244403b532..0937d4989185 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -137,11 +137,53 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 	}
 }
 
+static void iommufd_device_remove_vdev(struct iommufd_device *idev)
+{
+	struct iommufd_vdevice *vdev;
+
+	mutex_lock(&idev->igroup->lock);
+	/* vdev has been completely destroyed by userspace */
+	if (!idev->vdev)
+		goto out_unlock;
+
+	vdev = iommufd_get_vdevice(idev->ictx, idev->vdev->obj.id);
+	if (IS_ERR(vdev)) {
+		/*
+		 * vdev is removed from xarray by userspace, but is not
+		 * destroyed/freed. Since iommufd_vdevice_abort() is reentrant,
+		 * safe to destroy vdev here.
+		 */
+		iommufd_vdevice_abort(&idev->vdev->obj);
+		goto out_unlock;
+	}
+
+	/* Should never happen */
+	if (WARN_ON(vdev != idev->vdev)) {
+		iommufd_put_object(idev->ictx, &vdev->obj);
+		goto out_unlock;
+	}
+
+	/*
+	 * vdev is still alive. Hold a users refcount to prevent racing with
+	 * userspace destruction, then use iommufd_object_tombstone_user() to
+	 * destroy it and leave a tombstone.
+	 */
+	refcount_inc(&vdev->obj.users);
+	iommufd_put_object(idev->ictx, &vdev->obj);
+	mutex_unlock(&idev->igroup->lock);
+	iommufd_object_tombstone_user(idev->ictx, &vdev->obj);
+	return;
+
+out_unlock:
+	mutex_unlock(&idev->igroup->lock);
+}
+
 void iommufd_device_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_device *idev =
 		container_of(obj, struct iommufd_device, obj);
 
+	iommufd_device_remove_vdev(idev);
 	iommu_device_release_dma_owner(idev->dev);
 	iommufd_put_group(idev->igroup);
 	if (!iommufd_selftest_is_mock_dev(idev->dev))
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index fbc9ef78d81f..f58aa4439c53 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -446,6 +446,7 @@ struct iommufd_device {
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
+	struct iommufd_vdevice *vdev;
 };
 
 static inline struct iommufd_device *
@@ -621,6 +622,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_viommu_destroy(struct iommufd_object *obj);
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd);
 void iommufd_vdevice_destroy(struct iommufd_object *obj);
+void iommufd_vdevice_abort(struct iommufd_object *obj);
 
 struct iommufd_vdevice {
 	struct iommufd_object obj;
@@ -628,8 +630,17 @@ struct iommufd_vdevice {
 	struct iommufd_viommu *viommu;
 	struct device *dev;
 	u64 id; /* per-vIOMMU virtual ID */
+	struct iommufd_device *idev;
 };
 
+static inline struct iommufd_vdevice *
+iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
+{
+	return container_of(iommufd_get_object(ictx, id,
+					       IOMMUFD_OBJ_VDEVICE),
+			    struct iommufd_vdevice, obj);
+}
+
 #ifdef CONFIG_IOMMUFD_TEST
 int iommufd_test(struct iommufd_ucmd *ucmd);
 void iommufd_selftest_destroy(struct iommufd_object *obj);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 620923669b42..64731b4fdbdf 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -529,6 +529,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	},
 	[IOMMUFD_OBJ_VDEVICE] = {
 		.destroy = iommufd_vdevice_destroy,
+		.abort = iommufd_vdevice_abort,
 	},
 	[IOMMUFD_OBJ_VEVENTQ] = {
 		.destroy = iommufd_veventq_destroy,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 01df2b985f02..632d1d7b8fd8 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -84,16 +84,38 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	return rc;
 }
 
-void iommufd_vdevice_destroy(struct iommufd_object *obj)
+void iommufd_vdevice_abort(struct iommufd_object *obj)
 {
 	struct iommufd_vdevice *vdev =
 		container_of(obj, struct iommufd_vdevice, obj);
 	struct iommufd_viommu *viommu = vdev->viommu;
+	struct iommufd_device *idev = vdev->idev;
+
+	lockdep_assert_held(&idev->igroup->lock);
+
+	/*
+	 * iommufd_vdevice_abort() could be reentrant, by
+	 * iommufd_device_unbind() or by iommufd_destroy(). Cleanup only once.
+	 */
+	if (!viommu)
+		return;
 
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
 	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
 	put_device(vdev->dev);
+	vdev->viommu = NULL;
+	idev->vdev = NULL;
+}
+
+void iommufd_vdevice_destroy(struct iommufd_object *obj)
+{
+	struct iommufd_vdevice *vdev =
+		container_of(obj, struct iommufd_vdevice, obj);
+
+	mutex_lock(&vdev->idev->igroup->lock);
+	iommufd_vdevice_abort(obj);
+	mutex_unlock(&vdev->idev->igroup->lock);
 }
 
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
@@ -124,10 +146,16 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
+	mutex_lock(&idev->igroup->lock);
+	if (idev->vdev) {
+		rc = -EEXIST;
+		goto out_unlock_igroup;
+	}
+
 	vdev = iommufd_object_alloc(ucmd->ictx, vdev, IOMMUFD_OBJ_VDEVICE);
 	if (IS_ERR(vdev)) {
 		rc = PTR_ERR(vdev);
-		goto out_put_idev;
+		goto out_unlock_igroup;
 	}
 
 	vdev->id = virt_id;
@@ -135,6 +163,14 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	get_device(idev->dev);
 	vdev->viommu = viommu;
 	refcount_inc(&viommu->obj.users);
+	/*
+	 * iommufd_device_destroy() waits until idev->vdev is NULL before
+	 * freeing the idev, which only happens once the vdev is finished
+	 * destruction. Thus we do not need refcounting on either idev->vdev or
+	 * vdev->idev.
+	 */
+	vdev->idev = idev;
+	idev->vdev = vdev;
 
 	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
 	if (curr) {
@@ -147,10 +183,12 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	if (rc)
 		goto out_abort;
 	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
-	goto out_put_idev;
+	goto out_unlock_igroup;
 
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
+out_unlock_igroup:
+	mutex_unlock(&idev->igroup->lock);
 out_put_idev:
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 out_put_viommu:
-- 
2.25.1

