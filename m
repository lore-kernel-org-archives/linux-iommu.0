Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A31F4623;
	Wed, 25 Jun 2025 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750833638; cv=none; b=GxGE3dPqA8yE5NJ3VaNo6oVSYz4w+f9CCtjrMNrD0u5xer12ivKB0ynxJ3Ub0R8W9td44RMM/m6RE7O8l59OQuuPna7deLacvWHx7hSJ0D0oNLExrZSIYtKVmeta+EqiCEYbJ2xG2lbXshRqPz8RD//r7L4Uyh6b2hl0zEQilrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750833638; c=relaxed/simple;
	bh=TUoccqQiRZcZUPR3T9BlLZ6QpFzeXuDU5amvuXaxm6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YyIYblL2nbuxWCcpDUlqJEucNrTaHbQQ8rsKZfdX/uwM1vTOxvEo5QCSoHAiTIPAcpq2urr9OcXD/ON4wHzGddkmDa1wGXgkbrMp5ToSRKuFoKP8Y4eiUtNi8FqZwHO4To7d4VrWzRNBoE5UYagfQmRP+0QNI2LM2UVmS9uwcOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7X9oUV3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7X9oUV3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB026C4CEEA;
	Wed, 25 Jun 2025 06:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750833636;
	bh=TUoccqQiRZcZUPR3T9BlLZ6QpFzeXuDU5amvuXaxm6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=L7X9oUV337BC3BMuL7l5D0Zp27gjiCdLncUIlNQe/X9vK7sse7fd4/kjb8UXPd78s
	 6zbrIyeWKWWABN63Vq3CTsqA1yX3VJxV02EOhMlL9fjZYzUQ06bUt9qcfDAfIDmrve
	 gTv8xFy4RAYccJ1ZkXaHfCJugPitjxWicN8A6UONQ+/yzBIP0507TKQrNF8xwDUqkp
	 WplY0oX5XUx7UZK48BlV1vwC8YW/JRMmmTfmhgOyRdFdlv+IhQN3sjVLLQ51iM1c+4
	 JPKGyeC7fQdt+qipyezrEW6dze7yOAaucSy9SU786qFcLxFDgCLofMSDmgjHvgJDDO
	 m0XnRdpuNZbEw==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Xu Yilun <yilun.xu@linux.intel.com>, jgg@nvidia.com, jgg@ziepe.ca,
	kevin.tian@intel.com, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, joro@8bytes.org,
	robin.murphy@arm.com, shuah@kernel.org, nicolinc@nvidia.com,
	aik@amd.com, dan.j.williams@intel.com, baolu.lu@linux.intel.com,
	yilun.xu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
In-Reply-To: <20250623094946.1714996-4-yilun.xu@linux.intel.com>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-4-yilun.xu@linux.intel.com>
Date: Wed, 25 Jun 2025 12:10:28 +0530
Message-ID: <yq5a1pr85noj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Xu Yilun <yilun.xu@linux.intel.com> writes:

> Destroy iommufd_vdevice(vdev) on iommufd_idevice(idev) destroy so that
> vdev can't outlive idev.
>
> iommufd_device(idev) represents the physical device bound to iommufd,
> while the iommufd_vdevice(vdev) represents the virtual instance of the
> physical device in the VM. The lifecycle of the vdev should not be
> longer than idev. This doesn't cause real problem on existing use cases
> cause vdev doesn't impact the physical device, only provides
> virtualization information. But to extend vdev for Confidential
> Computing(CC), there are needs to do secure configuration for the vdev,
> e.g. TSM Bind/Unbind. These configurations should be rolled back on idev
> destroy, or the external driver(VFIO) functionality may be impact.
>
> Building the association between idev & vdev requires the two objects
> pointing each other, but not referencing each other. This requires
> proper locking. This is done by reviving some of Nicolin's patch [1].
>
> There are 3 cases on idev destroy:
>
>   1. vdev is already destroyed by userspace. No extra handling needed.
>   2. vdev is still alive. Use iommufd_object_tombstone_user() to
>      destroy vdev and tombstone the vdev ID.
>   3. vdev is being destroyed by userspace. The vdev ID is already freed,
>      but vdev destroy handler is not complete. The idev destroy handler
>      should wait for vdev destroy completion.
>
> [1]: https://lore.kernel.org/all/53025c827c44d68edb6469bfd940a8e8bc6147a5.1729897278.git.nicolinc@nvidia.com/
>
> Original-by: Nicolin Chen <nicolinc@nvidia.com>
> Original-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>

This is the latest version I have. But as Jason suggested we can
possibly switch to short term users to avoid parallel destroy returning
EBUSY. I am using a mutex lock to block parallel vdevice destroy.


diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 86244403b532..0bee1b3eadc6 100644
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
@@ -286,6 +288,23 @@ void iommufd_device_unbind(struct iommufd_device *idev)
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, "IOMMUFD");
 
+void iommufd_device_tombstone_vdevice(struct iommufd_device *idev)
+{
+	guard(mutex)(&idev->lock);
+
+	if (idev->vdev) {
+		struct iommufd_vdevice *vdev = idev->vdev;
+		/*
+		 * We want to wait for shortterm users, so we need
+		 * to pass the obj which requires an elevated refcount.
+		 */
+		refcount_inc(&vdev->obj.users);
+		iommufd_object_remove(idev->ictx, &vdev->obj, vdev->obj.id,
+				      REMOVE_OBJ_TOMBSTONE | REMOVE_WAIT_SHORTTERM);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_tombstone_vdevice, "IOMMUFD");
+
 struct iommufd_ctx *iommufd_device_to_ictx(struct iommufd_device *idev)
 {
 	return idev->ictx;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 9ccc83341f32..960f79c31145 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -187,8 +187,10 @@ void iommufd_object_finalize(struct iommufd_ctx *ictx,
 			     struct iommufd_object *obj);
 
 enum {
-	REMOVE_WAIT_SHORTTERM = 1,
+	REMOVE_WAIT_SHORTTERM = BIT(0),
+	REMOVE_OBJ_TOMBSTONE = BIT(1),
 };
+
 int iommufd_object_remove(struct iommufd_ctx *ictx,
 			  struct iommufd_object *to_destroy, u32 id,
 			  unsigned int flags);
@@ -199,7 +201,7 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
  * will be holding one.
  */
 static inline void iommufd_object_destroy_user(struct iommufd_ctx *ictx,
-					       struct iommufd_object *obj)
+						 struct iommufd_object *obj)
 {
 	int ret;
 
@@ -425,6 +427,10 @@ struct iommufd_device {
 	/* always the physical device */
 	struct device *dev;
 	bool enforce_cache_coherency;
+	/* to protect the following members*/
+	struct mutex lock;
+	/* if there is a vdevice mapping the idev */
+	struct iommufd_vdevice *vdev;
 };
 
 static inline struct iommufd_device *
@@ -606,6 +612,7 @@ struct iommufd_vdevice {
 	struct iommufd_ctx *ictx;
 	struct iommufd_viommu *viommu;
 	struct device *dev;
+	struct iommufd_device *idev;
 	u64 id; /* per-vIOMMU virtual ID */
 };
 
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 3df468f64e7d..fd82140e6320 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -81,14 +81,16 @@ void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
 struct iommufd_object *iommufd_get_object(struct iommufd_ctx *ictx, u32 id,
 					  enum iommufd_object_type type)
 {
+	XA_STATE(xas, &ictx->objects, id);
 	struct iommufd_object *obj;
 
 	if (iommufd_should_fail())
 		return ERR_PTR(-ENOENT);
 
 	xa_lock(&ictx->objects);
-	obj = xa_load(&ictx->objects, id);
-	if (!obj || (type != IOMMUFD_OBJ_ANY && obj->type != type) ||
+	obj = xas_load(&xas);
+	if (!obj || xa_is_zero(obj) ||
+	    (type != IOMMUFD_OBJ_ANY && obj->type != type) ||
 	    !iommufd_lock_obj(obj))
 		obj = ERR_PTR(-ENOENT);
 	xa_unlock(&ictx->objects);
@@ -167,7 +169,7 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
 		goto err_xa;
 	}
 
-	xas_store(&xas, NULL);
+	xas_store(&xas, (flags & REMOVE_OBJ_TOMBSTONE) ? XA_ZERO_ENTRY : NULL);
 	if (ictx->vfio_ioas == container_of(obj, struct iommufd_ioas, obj))
 		ictx->vfio_ioas = NULL;
 	xa_unlock(&ictx->objects);
@@ -199,9 +201,30 @@ int iommufd_object_remove(struct iommufd_ctx *ictx,
 
 static int iommufd_destroy(struct iommufd_ucmd *ucmd)
 {
+	int ret;
 	struct iommu_destroy *cmd = ucmd->cmd;
+	struct iommufd_object *obj;
+	struct iommufd_device *idev = NULL;
+
+	obj = iommufd_get_object(ucmd->ictx, cmd->id, IOMMUFD_OBJ_ANY);
+	/* Destroying vdevice requires an idevice lock */
+	if (!IS_ERR(obj) && obj->type == IOMMUFD_OBJ_VDEVICE) {
+		struct iommufd_vdevice *vdev =
+			container_of(obj, struct iommufd_vdevice, obj);
+		/*
+		 * since vdev have an refcount on idev, this is safe.
+		 */
+		idev = vdev->idev;
+		mutex_lock(&idev->lock);
+		/* drop the additonal reference taken above */
+		iommufd_put_object(ucmd->ictx, obj);
+	}
+
+	ret = iommufd_object_remove(ucmd->ictx, NULL, cmd->id, 0);
+	if (idev)
+		mutex_unlock(&idev->lock);
 
-	return iommufd_object_remove(ucmd->ictx, NULL, cmd->id, 0);
+	return ret;
 }
 
 static int iommufd_fops_open(struct inode *inode, struct file *filp)
@@ -233,6 +256,16 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+/*
+ * We don't need additional locks because the iommufd_fops_release() function is
+ * only triggered when the iommufd descriptor is released. At that point, no
+ * other iommufd-based ioctl operations can be running concurrently.
+ *
+ * The destruction of the vdevice via idevice unbind is also safe:
+ * iommufd_fops_release() can only be called after the idevice has been unbound.
+ * The idevice bind operation takes a reference to the iommufd descriptor,
+ * preventing early release.
+ */
 static int iommufd_fops_release(struct inode *inode, struct file *filp)
 {
 	struct iommufd_ctx *ictx = filp->private_data;
@@ -251,16 +284,22 @@ static int iommufd_fops_release(struct inode *inode, struct file *filp)
 	 */
 	while (!xa_empty(&ictx->objects)) {
 		unsigned int destroyed = 0;
-		unsigned long index;
+		XA_STATE(xas, &ictx->objects, 0);
+
+		xas_for_each(&xas, obj, ULONG_MAX) {
+
+			if (!xa_is_zero(obj)) {
+				if (!refcount_dec_if_one(&obj->users))
+					continue;
+
+				iommufd_object_ops[obj->type].destroy(obj);
+				kfree(obj);
+			}
 
-		xa_for_each(&ictx->objects, index, obj) {
-			if (!refcount_dec_if_one(&obj->users))
-				continue;
 			destroyed++;
-			xa_erase(&ictx->objects, index);
-			iommufd_object_ops[obj->type].destroy(obj);
-			kfree(obj);
+			xas_store(&xas, NULL);
 		}
+
 		/* Bug related to users refcount */
 		if (WARN_ON(!destroyed))
 			break;
diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 01df2b985f02..b3a5f505c7ed 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -89,10 +89,18 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj)
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
 
@@ -124,10 +132,15 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
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
@@ -147,10 +160,17 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	if (rc)
 		goto out_abort;
 	iommufd_object_finalize(ucmd->ictx, &vdev->obj);
-	goto out_put_idev;
+	/* don't allow idev free without vdev free */
+	refcount_inc(&idev->obj.users);
+	vdev->idev = idev;
+	/* vdev lifecycle now managed by idev */
+	idev->vdev = vdev;
+	goto out_put_idev_unlock;
 
 out_abort:
 	iommufd_object_abort_and_destroy(ucmd->ictx, &vdev->obj);
+out_put_idev_unlock:
+	mutex_unlock(&idev->lock);
 out_put_idev:
 	iommufd_put_object(ucmd->ictx, &idev->obj);
 out_put_viommu:
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 6328c3a05bcd..0bf4f8b7f8d2 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -694,6 +694,12 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 #if IS_ENABLED(CONFIG_EEH)
 	eeh_dev_release(vdev->pdev);
 #endif
+
+	/* destroy vdevice which involves tsm unbind before we disable pci disable */
+	if (core_vdev->iommufd_device)
+		iommufd_device_tombstone_vdevice(core_vdev->iommufd_device);
+
+	/* tsm unbind should happen before this */
 	vfio_pci_core_disable(vdev);
 
 	mutex_lock(&vdev->igate);
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 34b6e6ca4bfa..8de3d903bfc0 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -63,6 +63,7 @@ void iommufd_device_detach(struct iommufd_device *idev, ioasid_t pasid);
 
 struct iommufd_ctx *iommufd_device_to_ictx(struct iommufd_device *idev);
 u32 iommufd_device_to_id(struct iommufd_device *idev);
+void iommufd_device_tombstone_vdevice(struct iommufd_device *idev);
 
 struct iommufd_access_ops {
 	u8 needs_pin_pages : 1;
