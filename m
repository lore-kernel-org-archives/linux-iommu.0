Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA50E241679
	for <iommu@lists.linux.dev>; Mon, 23 Jun 2025 09:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672652; cv=none; b=LukeJiiaaD/DQEazyo3ssf27/ToOXqhlmv3BOprbgJzjb53E05DkMmrnOSA14U4JRkz3MydwsjrhbV72yZwQ0aL2a68IUZ0IOwzQuamOcvrk88x6PHPssL0rsCkuA8ERV6njJnNPtS5SpxUWF7UFl/qQGG+fWvqBYHQ16bhQi44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672652; c=relaxed/simple;
	bh=eG1eg5apZTSueD/Cu1CtjPn9WRibNu7IhiHyzCb/Dgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FP4qpy2ulKXtvcePc7Qf7T0ihCH0clZbSvqA8VFtFGC6enlYJjfHG7BlXUffc5TPex6vGyGsvW/EvTL/0qpvk7vmOZ2NsFwv1QzRqFCnLRZCDT+5b9vARG3w74MF5J/7dGZ7arEvKJ/1Lf0v5JHtNPVWxx3oMWZVdYjuGVVmGPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lv6I4wVW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lv6I4wVW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750672651; x=1782208651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eG1eg5apZTSueD/Cu1CtjPn9WRibNu7IhiHyzCb/Dgg=;
  b=lv6I4wVWkpwINbjawrh4jsuYcE0clt9HOKRRAw6uYxs0pGRm6oBJpKeT
   3undZCVoe0lakUCLLLJi5R2c4AO52zBhjbFZFZmKZbcrSFiw/VwcA1Z6b
   lXhNSofBvB68pIM+OyOQh9ndbvUlZ0ra2QgK+op+MpsO5x4bg0u8d5gUi
   2CBzwgA5IPNVVdQg8ehss++DjNBFR01IKLdNWY5cyuMDVX4sz6kDTFNzi
   weH1N565/OMO6L/c7VBoJBXIX48CV3E3czzo1fY6Sh4JwRYV1eKbB3ZXA
   ykzskqn1u/BLlRlh0FooqVJeeYW4nXP6BpRqXaFh5k1WFveT+UKiHhhDV
   g==;
X-CSE-ConnectionGUID: uodXdsLBQc6TTB3ccKT1Sg==
X-CSE-MsgGUID: 9aTzIvJyQZ2cjQ4IpbcwFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="78285839"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="78285839"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 02:57:30 -0700
X-CSE-ConnectionGUID: 5yqTpPfdSxSyH0O7PGnmaw==
X-CSE-MsgGUID: 3a5agaUaSj+qgsFXUznEzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="155859363"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by fmviesa005.fm.intel.com with ESMTP; 23 Jun 2025 02:57:27 -0700
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
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com
Subject: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
Date: Mon, 23 Jun 2025 17:49:45 +0800
Message-Id: <20250623094946.1714996-4-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Destroy iommufd_vdevice(vdev) on iommufd_idevice(idev) destroy so that
vdev can't outlive idev.

iommufd_device(idev) represents the physical device bound to iommufd,
while the iommufd_vdevice(vdev) represents the virtual instance of the
physical device in the VM. The lifecycle of the vdev should not be
longer than idev. This doesn't cause real problem on existing use cases
cause vdev doesn't impact the physical device, only provides
virtualization information. But to extend vdev for Confidential
Computing(CC), there are needs to do secure configuration for the vdev,
e.g. TSM Bind/Unbind. These configurations should be rolled back on idev
destroy, or the external driver(VFIO) functionality may be impact.

Building the association between idev & vdev requires the two objects
pointing each other, but not referencing each other. This requires
proper locking. This is done by reviving some of Nicolin's patch [1].

There are 3 cases on idev destroy:

  1. vdev is already destroyed by userspace. No extra handling needed.
  2. vdev is still alive. Use iommufd_object_tombstone_user() to
     destroy vdev and tombstone the vdev ID.
  3. vdev is being destroyed by userspace. The vdev ID is already freed,
     but vdev destroy handler is not complete. The idev destroy handler
     should wait for vdev destroy completion.

[1]: https://lore.kernel.org/all/53025c827c44d68edb6469bfd940a8e8bc6147a5.1729897278.git.nicolinc@nvidia.com/

Original-by: Nicolin Chen <nicolinc@nvidia.com>
Original-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 drivers/iommu/iommufd/device.c          | 43 +++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h | 11 +++++++
 drivers/iommu/iommufd/main.c            |  1 +
 drivers/iommu/iommufd/viommu.c          | 33 +++++++++++++++++--
 4 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 86244403b532..908a94a27bab 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -137,11 +137,54 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 	}
 }
 
+static void iommufd_device_remove_vdev(struct iommufd_device *idev)
+{
+	bool vdev_removing = false;
+
+	mutex_lock(&idev->igroup->lock);
+	if (idev->vdev) {
+		struct iommufd_vdevice *vdev;
+
+		vdev = iommufd_get_vdevice(idev->ictx, idev->vdev->obj.id);
+		if (IS_ERR(vdev)) {
+			/* vdev is removed from xarray, but is not destroyed/freed */
+			vdev_removing = true;
+			goto unlock;
+		}
+
+		/* Should never happen */
+		if (WARN_ON(vdev != idev->vdev)) {
+			idev->vdev = NULL;
+			iommufd_put_object(idev->ictx, &vdev->obj);
+			goto unlock;
+		}
+
+		/*
+		 * vdev cannot be destroyed after refcount_inc, safe to release
+		 * idev->igroup->lock and use idev->vdev afterward.
+		 */
+		refcount_inc(&idev->vdev->obj.users);
+		iommufd_put_object(idev->ictx, &idev->vdev->obj);
+	}
+unlock:
+	mutex_unlock(&idev->igroup->lock);
+
+	if (vdev_removing) {
+		if (!wait_event_timeout(idev->ictx->destroy_wait,
+					!idev->vdev,
+					msecs_to_jiffies(60000)))
+			pr_crit("Time out waiting for iommufd vdevice removed\n");
+	} else if (idev->vdev) {
+		iommufd_object_tombstone_user(idev->ictx, &idev->vdev->obj);
+	}
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
index 5fd75aba068b..3f955a123095 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -531,6 +531,7 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
 	},
 	[IOMMUFD_OBJ_VDEVICE] = {
 		.destroy = iommufd_vdevice_destroy,
+		.abort = iommufd_vdevice_abort,
 	},
 	[IOMMUFD_OBJ_VEVENTQ] = {
 		.destroy = iommufd_veventq_destroy,
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 4577b88c8560..9b062e651ea5 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -84,16 +84,31 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
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
 
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
 	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
 	put_device(vdev->dev);
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
+	wake_up_interruptible_all(&vdev->ictx->destroy_wait);
 }
 
 int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
@@ -124,18 +139,28 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
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
 
+	/* vdev can't outlive idev, vdev->idev is always valid, need no refcnt */
+	vdev->idev = idev;
 	vdev->ictx = ucmd->ictx;
 	vdev->id = virt_id;
 	vdev->dev = idev->dev;
 	get_device(idev->dev);
 	vdev->viommu = viommu;
 	refcount_inc(&viommu->obj.users);
+	/* idev->vdev is protected by idev->igroup->lock, need no refcnt */
+	idev->vdev = vdev;
 
 	curr = xa_cmpxchg(&viommu->vdevs, virt_id, NULL, vdev, GFP_KERNEL);
 	if (curr) {
@@ -148,10 +173,12 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
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

