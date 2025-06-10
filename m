Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A9E21C184;
	Tue, 10 Jun 2025 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749538415; cv=none; b=s9/eNuwiG8MNgNIE0v0nO/WdRRrWOhjvtDXdASCTHv90mvZqo2pK7j14C0v2OAYBnQgAhwxFKnR2VFl1w+zwF/9Ao+owFZTeOuYg+fVT3ishpsT4hP+f5Lk+7bzhTiWA+x5NONje8Yk/XkJOWaHDM68BwA/2k7YaPkmeCSIlxjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749538415; c=relaxed/simple;
	bh=wZqwKho69kQlxvMvKdRzNSzFkPge27kU09M5UoArVmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FuLKHs4bMokouryX6XTulRzJJijxhhhiGc5Kkeo5EnNZ2gylayXIE+tCKDYuDdAhEYaDr3tXgtJ3CBvxricuURvDWAVG8hAIiPLA719yWEU+SiaGOousG3sfidTBdBpTh2gy3sjPQN5dZmgZvkd4MtApith6xxo9I0DL4ZCgbn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InIWy4xi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InIWy4xi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BEB2C4CEEF;
	Tue, 10 Jun 2025 06:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749538414;
	bh=wZqwKho69kQlxvMvKdRzNSzFkPge27kU09M5UoArVmw=;
	h=From:To:Cc:Subject:Date:From;
	b=InIWy4xizWFPC4COOj3bDP9F8L4MBxzxjTyG4Jl0NjFzmuc9EWE6eB8/yHJPSkEOD
	 Kcg3f80TCllYPxvWcHqFjv8qjRjsqqs92h/zFQVv2LcSUYdpgjqrxtAN4F7Jy53cLd
	 FIvWoZ46G6iFRISZ1f2LbkqsgvsoWhXmsDmArXvPhPKeJ5MrzpdkhMFkyzs1J7kGF9
	 nwaxsQduYxMawJXgz5aWXbXXbbzGCKhvZ0NQr04+b4KCcJA7ajeta2A18GP7dLhaHJ
	 UgxMYFUKDr/aM36Ld6iOuC90weGyTtBG3FYTzfU3+aHtzVYU73ICIFlqQtDHapQHl2
	 7iCVE1b9K+L2g==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [RFC PATCH] iommufd: Destroy vdevice on device unbind
Date: Tue, 10 Jun 2025 12:21:46 +0530
Message-ID: <20250610065146.1321816-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The iommufd subsystem uses the VFIO character device descriptor to bind
a device file to an iommufd context via the VFIO_DEVICE_BIND_IOMMUFD
ioctl. This binding returns a bind_id, which is then used in subsequent
iommufd ioctls such as IOMMU_HWPT_ALLOC, IOMMU_VIOMMU_ALLOC, and
IOMMU_VDEVICE_ALLOC.

Among these, IOMMU_VDEVICE_ALLOC is special—the lifetime of a virtual
device (vdevice) should be tied to the bound state of its physical
device.

In the current kernel, there is no enforced dependency between
iommufd_device and iommufd_vdevice. This patch introduces such a
dependency: when the device is unbound, the associated vdevice is now
automatically destroyed.

Although there is already an implicit dependency—vdevices can only be
destroyed after the iommufd_device is unbound due to the VFIO cdev file
descriptor holding a reference to the iommu file descriptor—this patch
formalizes and extends that relationship. Now, the vdevice will be
explicitly destroyed when its corresponding device is unbound.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/device.c          |  8 ++++++++
 drivers/iommu/iommufd/iommufd_private.h |  5 +++++
 drivers/iommu/iommufd/main.c            |  6 ++++++
 drivers/iommu/iommufd/viommu.c          | 26 +++++++++++++++++++++++--
 4 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 86244403b532..a49b293bd516 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -221,6 +221,8 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	refcount_inc(&idev->obj.users);
 	/* igroup refcount moves into iommufd_device */
 	idev->igroup = igroup;
+	idev->vdev   = NULL;
+	mutex_init(&idev->lock);
 
 	/*
 	 * If the caller fails after this success it must call
@@ -282,6 +284,12 @@ EXPORT_SYMBOL_NS_GPL(iommufd_ctx_has_group, "IOMMUFD");
  */
 void iommufd_device_unbind(struct iommufd_device *idev)
 {
+	/* this will be unlocked while destroying the idev obj */
+	mutex_lock(&idev->lock);
+
+	if (idev->vdev)
+		/* extra refcount taken during vdevice alloc */
+		iommufd_object_destroy_user(idev->ictx, &idev->vdev->obj);
 	iommufd_object_destroy_user(idev->ictx, &idev->obj);
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, "IOMMUFD");
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9ccc83341f32..d85bd8b38751 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -425,6 +425,10 @@ struct iommufd_device {
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
+	/* to protect the following members*/
+	struct mutex lock;
+	/* if there is a vdevice mapping the idev */
+	struct iommufd_vdevice *vdev;
 };
 
 static inline struct iommufd_device *
@@ -606,6 +610,7 @@ struct iommufd_vdevice {
 	struct iommufd_ctx *ictx;
 	struct iommufd_viommu *viommu;
 	struct device *dev;
+	struct iommufd_device *idev;
 	u64 id; /* per-vIOMMU virtual ID */
 };
 
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 3df468f64e7d..bf653d16138e 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -172,6 +172,12 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
 		ictx->vfio_ioas = NULL;
 	xa_unlock(&ictx->objects);
 
+	if (obj->type == IOMMUFD_OBJ_DEVICE) {
+		/* idevice should be freed with lock held */
+		struct iommufd_device *idev = container_of(obj, struct iommufd_device, obj);
+
+		mutex_unlock(&idev->lock);
+	}
 	/*
 	 * Since users is zero any positive users_shortterm must be racing
 	 * iommufd_put_object(), or we have a bug.
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 01df2b985f02..17f189bc9e2c 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -84,15 +84,24 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	return rc;
 }
 
+/* This will be called from iommufd_device_unbind  */
 void iommufd_vdevice_destroy(struct iommufd_object *obj)
 {
 	struct iommufd_vdevice *vdev =
 		container_of(obj, struct iommufd_vdevice, obj);
 	struct iommufd_viommu *viommu = vdev->viommu;
+	struct iommufd_device *idev = vdev->idev;
+
+	/*
+	 * since we have an refcount on idev, it can't be freed.
+	 */
+	lockdep_assert_held(&idev->lock);
 
 	/* xa_cmpxchg is okay to fail if alloc failed xa_cmpxchg previously */
 	xa_cmpxchg(&viommu->vdevs, vdev->id, vdev, NULL, GFP_KERNEL);
 	refcount_dec(&viommu->obj.users);
+	idev->vdev = NULL;
+	refcount_dec(&idev->obj.users);
 	put_device(vdev->dev);
 }
 
@@ -124,10 +133,15 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_put_idev;
 	}
 
+	mutex_lock(&idev->lock);
+	if (idev->vdev) {
+		rc = -EINVAL;
+		goto out_put_idev_unlock;
+	}
 	vdev = iommufd_object_alloc(ucmd->ictx, vdev, IOMMUFD_OBJ_VDEVICE);
 	if (IS_ERR(vdev)) {
 		rc = PTR_ERR(vdev);
-		goto out_put_idev;
+		goto out_put_idev_unlock;
 	}
 
 	vdev->id = virt_id;
@@ -147,10 +161,18 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	if (rc)
 		goto out_abort;
 	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
-	goto out_put_idev;
+	/* don't allow idev free without vdev free */
+	refcount_inc(&idev->obj.users);
+	vdev->idev = idev;
+	/* vdev lifecycle now managed by idev */
+	idev->vdev = vdev;
+	refcount_inc(&vdev->obj.users);
+	goto out_put_idev_unlock;
 
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
+out_put_idev_unlock:
+	mutex_unlock(&idev->lock);
 out_put_idev:
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 out_put_viommu:
-- 
2.43.0

