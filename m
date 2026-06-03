Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF528402428
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 22:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780524136; cv=none; b=YJUsCLTEonWFchHBHDNOPIv4xgsGtpCMc6jMXgEglHBia0+Ingbe3J5UgOVeTbHG2zRo4JrvGJd30d4Jod/f5uRZ/9bOJzswPXhSNtN6JFVZV5WjlRlsuwAadBzMcgQHslYVnDSQCjS3CrOOffDBhPDyRgUAB2XeTh6ojt0ZWxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780524136; c=relaxed/simple;
	bh=wN+Dk6nkTd3eJ9PzQVaMOZ50whiDgF42HEfh6ntxKv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGvS4Kzk50wigSK06Bsky2eEfVjQSQeZ2RMrtUrrc14paNYemfVmCDWTCJAw5fbAWeBYlFPuIfd71X20ag61IkDcpZUmkgK1L8EruO/3Nu12+eWrpwmR4P/K9boTNd8Lqr88ugfwmjgP3qReCS4CN/l0QSn0CwwaZA1UHfn8mfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XmOJX+tw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XmOJX+tw"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.147.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id CD82120B716D;
	Wed,  3 Jun 2026 15:01:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD82120B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780524119;
	bh=fqUCwKNZ0+olZO+PI992CgoyO/0IJLDo52hjiF59KoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XmOJX+twtF6a1PDSIcFr0f9jRncu1cOsQLzNuZd5xotrtIo1SgC8otJ0ipNeR94Mz
	 Iyjx6kNkoKEA0OtnYc/13MG/4mMHJKbj3Ntskkz5DNM7uUiaDYh7qdjRIf03ZU6fjd
	 6caj7nswGXW6OBSxEGo7JgVkXbdH+qx84pKgUwj8=
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
Subject: [PATCH v8 3/6] iommufd: Allow binding to a noiommu device
Date: Wed,  3 Jun 2026 15:02:08 -0700
Message-ID: <20260603220211.2584590-4-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603220211.2584590-1-jacob.pan@linux.microsoft.com>
References: <20260603220211.2584590-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

Allow iommufd to bind devices without an IOMMU (noiommu mode) by creating
a dummy igroup for such devices and skipping hwpt operations.

This enables noiommu devices to operate through the same iommufd API as IOMMU-
capable devices.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
v7:
  - Block get hw info for noiommu
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
---
 drivers/iommu/iommufd/device.c | 154 ++++++++++++++++++++++++---------
 1 file changed, 115 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index d03076fcf3c2..670349ff65ea 100644
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
@@ -1585,6 +1656,11 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
 
+	if (iommufd_device_is_noiommu(idev)) {
+		rc = -EOPNOTSUPP;
+		goto out_put;
+	}
+
 	ops = dev_iommu_ops(idev->dev);
 	if (ops->hw_info) {
 		data = ops->hw_info(idev->dev, &data_len, &cmd->out_data_type);
-- 
2.43.0

