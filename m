Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC32357CFB
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 22:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779401520; cv=none; b=EeIxuEERxAmY84vFH1xRKFAQAMMKrX8kR6f/FqgRAaSlaLWDkOnMJmO0Phe4tfhBl4hWQVrBKpKLyQ/AbLid0krY3aV+mi78FbKYQsD1gVy6tuhmMFiksf35s8vlJd2ggpXbZerKjn3u6wgnCnlQ/4f3dGl+m/Tg3bQQSbuT35E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779401520; c=relaxed/simple;
	bh=E7olAJ10qdpErUe8hcsSC5FtxJ201xjlB1L+h/O6J7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPr2fL25vkOcumm5AJiRqn/2GbkYNm13AYCeuQUJbBg0H86Bui3JI7Fim2SOLMIZsw8oM2JJgy1LqDi80QXocragBwPuE04cl5T7FuxbvoRDU3GlFceXd95LXuOWo/FeoBu+0svfV2ofos66gFreAnvvq6jvwgkxbfMpbns/Li8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VBdBJrOI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VBdBJrOI"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.147.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id CC3DC20B716C;
	Thu, 21 May 2026 15:11:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC3DC20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779401510;
	bh=c9ffTynzEGJ7A6ExP1VWZqw9ypGRpQMwxoh6yLQ7cI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VBdBJrOIXccSyV2m5ukOtgx02qoTBOF0l1WuDDGZL96xC3W4LpUXCSjb/QtHAZcbF
	 R+MN3+g0BTFwxZzu7r7TGP7H9VOyW4r2ZtnQN+2FFA8UP1KnZzMdxNXfN84fk3Jeu6
	 kaqv3IANsc68AQqK3bHQAWPC6IENFDPqErq80Nek=
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
Subject: [PATCH v6 3/7] iommufd: Allow binding to a noiommu device
Date: Thu, 21 May 2026 15:11:50 -0700
Message-ID: <20260521221155.1375144-4-jacob.pan@linux.microsoft.com>
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

From: Jason Gunthorpe <jgg@nvidia.com>

Allow iommufd to bind devices without an IOMMU (noiommu mode) by creating
a dummy IOMMU group for such devices and skipping hwpt operations.

This enables noiommu devices to operate through the same iommufd API as IOMMU-
capable devices.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
v6:
  - Expand iommufd_device_is_noiommu() comment to explain why dev->iommu
    is checked instead of device_iommu_mapped() (Yi & Baolu)
  - Simplify bind error handling by factoring out duplicated rc check (Yi)
v5:
   - simplify logic and rename iommufd_device_is_noiommu (Kevin, Yi)
   - use a helper iommufd_bind_noiommu instead of open coding (Kevin)
   - move IOMMU cap check under iommufd_bind_iommu() (Yi)
   - reword comments for partial init (Yi)
   - misc minor clean up
v4:
   - Update the description of the module parameter (Alex)
v3:
   - Consolidate into fewer patches

fix baolu comment

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/iommufd/device.c | 149 ++++++++++++++++++++++++---------
 1 file changed, 110 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index d03076fcf3c2..ff7f7bff5058 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -23,6 +23,19 @@ struct iommufd_attach {
 	struct xarray device_array;
 };
 
+/*
+ * Detect a noiommu device for the cdev path. We check dev->iommu rather than
+ * using device_iommu_mapped() (which checks dev->iommu_group) because when
+ * both group and cdev interfaces coexist, the group path assigns a fake
+ * noiommu iommu_group to the device. That would cause device_iommu_mapped()
+ * to return true and hide the noiommu case from the cdev path. dev->iommu is
+ * reliably NULL when no IOMMU driver is managing the device.
+ */
+static bool iommufd_device_is_noiommu(struct iommufd_device *idev)
+{
+	return IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) && !idev->dev->iommu;
+}
+
 static void iommufd_group_release(struct kref *kref)
 {
 	struct iommufd_group *igroup =
@@ -30,9 +43,11 @@ static void iommufd_group_release(struct kref *kref)
 
 	WARN_ON(!xa_empty(&igroup->pasid_attach));
 
-	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
-		   NULL, GFP_KERNEL);
-	iommu_group_put(igroup->group);
+	if (igroup->group) {
+		xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group),
+			   igroup, NULL, GFP_KERNEL);
+		iommu_group_put(igroup->group);
+	}
 	mutex_destroy(&igroup->lock);
 	kfree(igroup);
 }
@@ -204,32 +219,20 @@ void iommufd_device_destroy(struct iommufd_object *obj)
 	struct iommufd_device *idev =
 		container_of(obj, struct iommufd_device, obj);
 
-	iommu_device_release_dma_owner(idev->dev);
+	/* igroup is NULL when destroy called during bind error cleanup */
+	if (!idev->igroup)
+		return;
+	if (!iommufd_device_is_noiommu(idev))
+		iommu_device_release_dma_owner(idev->dev);
 	iommufd_put_group(idev->igroup);
 	if (!iommufd_selftest_is_mock_dev(idev->dev))
 		iommufd_ctx_put(idev->ictx);
 }
 
-/**
- * iommufd_device_bind - Bind a physical device to an iommu fd
- * @ictx: iommufd file descriptor
- * @dev: Pointer to a physical device struct
- * @id: Output ID number to return to userspace for this device
- *
- * A successful bind establishes an ownership over the device and returns
- * struct iommufd_device pointer, otherwise returns error pointer.
- *
- * A driver using this API must set driver_managed_dma and must not touch
- * the device until this routine succeeds and establishes ownership.
- *
- * Binding a PCI device places the entire RID under iommufd control.
- *
- * The caller must undo this with iommufd_device_unbind()
- */
-struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
-					   struct device *dev, u32 *id)
+static int iommufd_bind_iommu(struct iommufd_device *idev)
 {
-	struct iommufd_device *idev;
+	struct iommufd_ctx *ictx = idev->ictx;
+	struct device *dev = idev->dev;
 	struct iommufd_group *igroup;
 	int rc;
 
@@ -238,11 +241,11 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	 * to restore cache coherency.
 	 */
 	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	igroup = iommufd_get_group(ictx, dev);
 	if (IS_ERR(igroup))
-		return ERR_CAST(igroup);
+		return PTR_ERR(igroup);
 
 	/*
 	 * For historical compat with VFIO the insecure interrupt path is
@@ -268,21 +271,77 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	if (rc)
 		goto out_group_put;
 
+	/* igroup refcount moves into iommufd_device */
+	idev->igroup = igroup;
+	idev->enforce_cache_coherency =
+		device_iommu_capable(dev, IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
+	return 0;
+
+out_group_put:
+	iommufd_put_group(igroup);
+	return rc;
+}
+
+/*
+ * Noiommu devices have no real IOMMU group. Create a dummy igroup so that
+ * internal code paths that expect idev->igroup to be present still work.
+ * A NULL igroup->group distinguishes this from a real IOMMU-backed group.
+ */
+static int iommufd_bind_noiommu(struct iommufd_device *idev)
+{
+	struct iommufd_group *igroup;
+
+	igroup = iommufd_alloc_group(idev->ictx, NULL);
+	if (IS_ERR(igroup))
+		return PTR_ERR(igroup);
+	idev->igroup = igroup;
+	return 0;
+}
+
+/**
+ * iommufd_device_bind - Bind a physical device to an iommu fd
+ * @ictx: iommufd file descriptor
+ * @dev: Pointer to a physical device struct
+ * @id: Output ID number to return to userspace for this device
+ *
+ * A successful bind establishes an ownership over the device and returns
+ * struct iommufd_device pointer, otherwise returns error pointer.
+ *
+ * A driver using this API must set driver_managed_dma and must not touch
+ * the device until this routine succeeds and establishes ownership.
+ *
+ * Binding a PCI device places the entire RID under iommufd control.
+ *
+ * The caller must undo this with iommufd_device_unbind()
+ */
+struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
+					   struct device *dev, u32 *id)
+{
+	struct iommufd_device *idev;
+	int rc;
+
 	idev = iommufd_object_alloc(ictx, idev, IOMMUFD_OBJ_DEVICE);
-	if (IS_ERR(idev)) {
-		rc = PTR_ERR(idev);
-		goto out_release_owner;
-	}
+	if (IS_ERR(idev))
+		return idev;
+
 	idev->ictx = ictx;
+	idev->dev = dev;
+
+	if (!iommufd_device_is_noiommu(idev))
+		rc = iommufd_bind_iommu(idev);
+	else
+		rc = iommufd_bind_noiommu(idev);
+	if (rc)
+		goto err_out;
+
+	/*
+	 * Take a ctx reference after bind succeeds. This must happen here
+	 * so that iommufd_device_destroy() can handle partial initialization
+	 */
 	if (!iommufd_selftest_is_mock_dev(dev))
 		iommufd_ctx_get(ictx);
-	idev->dev = dev;
-	idev->enforce_cache_coherency =
-		device_iommu_capable(dev, IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
 	/* The calling driver is a user until iommufd_device_unbind() */
 	refcount_inc(&idev->obj.users);
-	/* igroup refcount moves into iommufd_device */
-	idev->igroup = igroup;
 
 	/*
 	 * If the caller fails after this success it must call
@@ -294,11 +353,14 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	*id = idev->obj.id;
 	return idev;
 
-out_release_owner:
-	iommu_device_release_dma_owner(dev);
-out_group_put:
-	iommufd_put_group(igroup);
+err_out:
+	/*
+	 * iommufd_device_destroy() handles partially initialized idev,
+	 * so iommufd_object_abort_and_destroy() is safe to call here.
+	 */
+	iommufd_object_abort_and_destroy(ictx, &idev->obj);
 	return ERR_PTR(rc);
+
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, "IOMMUFD");
 
@@ -512,6 +574,9 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 	struct iommufd_attach_handle *handle;
 	int rc;
 
+	if (iommufd_device_is_noiommu(idev))
+		return 0;
+
 	if (!iommufd_hwpt_compatible_device(hwpt, idev))
 		return -EINVAL;
 
@@ -559,6 +624,9 @@ static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
 {
 	struct iommufd_attach_handle *handle;
 
+	if (iommufd_device_is_noiommu(idev))
+		return;
+
 	handle = iommufd_device_get_attach_handle(idev, pasid);
 	if (pasid == IOMMU_NO_PASID)
 		iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
@@ -577,6 +645,9 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	struct iommufd_attach_handle *handle, *old_handle;
 	int rc;
 
+	if (iommufd_device_is_noiommu(idev))
+		return 0;
+
 	if (!iommufd_hwpt_compatible_device(hwpt, idev))
 		return -EINVAL;
 
@@ -652,7 +723,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_release_devid;
 	}
 
-	if (attach_resv) {
+	if (attach_resv && !iommufd_device_is_noiommu(idev)) {
 		rc = iommufd_device_attach_reserved_iova(idev, hwpt_paging);
 		if (rc)
 			goto err_release_devid;
-- 
2.43.0

