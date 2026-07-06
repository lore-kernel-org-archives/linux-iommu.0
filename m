Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A813AF65C
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 18:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783363734; cv=none; b=iI6WSVXEAjxNnQmB2nJCiufeh9TeqMIeDDCDpT+0//iipbls49aYwx6DhoyN6IkIzbqU/7Y1r8/lQD+JwUmcyyMtMKxXMJEzJLC5FqxKRRaCiOgOE+LtRJc1BMgEUd4+L9s1h6Q83HI98seN0Yw+P6a0SRj0Abf6XzxA5cpWqvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783363734; c=relaxed/simple;
	bh=Z6CivDxEP8xhbIeKBWL5iZ1iGoOjJpguCXFTbGOx3hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tScUsxPe8pbOL55VLfeGXjlu5AVTfLZRhZi0+w2FK1uw8wGoqcB+PlOptL8/cGonjI+qt8iJh4+BTOqtN+0hq3Sr3hVoQsIfMqOJdgJUl5LZpEjo9X4cQfgk9HA3POkfwGJyDskvXRUWGD4HUDsjRMT/rdKooJocmQkgalXrrYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YDy5E7F2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YDy5E7F2"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.1.135])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4DDFF20B7170;
	Mon,  6 Jul 2026 11:48:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4DDFF20B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783363713;
	bh=0JS0cx5a2UotNiIpW+eagSVMnbZFHJuAOBo+kwUb/sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDy5E7F2L1A8PKHpPIoLuVvqVWPvCwKsIXTEf7zCLkqmn2FX5AGPOxd+7IYmTM1yr
	 uO5WDqSlH6sh7yNaCPECQ+ocQh9aUhfzanvLXU9tVH/UJPMP10b1mgMQ/h63Bgi6J+
	 svU7XeMnEXgPwSTwpTPcT45j0QiTbcBkoun7Zx0E=
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
Subject: [PATCH v10 3/6] iommufd: Allow binding to a noiommu device
Date: Mon,  6 Jul 2026 11:48:31 -0700
Message-ID: <2c6cf6ab1564426050e637863c9b0d3b25541c63.1783360051.git.jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783360051.git.jacob.pan@linux.microsoft.com>
References: <cover.1783360051.git.jacob.pan@linux.microsoft.com>
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
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
v9:
  - Guard replace path for noiommu device (Sashiko)
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
 drivers/iommu/iommufd/device.c | 158 ++++++++++++++++++++++++---------
 1 file changed, 118 insertions(+), 40 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index b23a20c89f66..d7060b3b4676 100644
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
 
@@ -614,7 +685,8 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev, ioasid_t pasid)
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
-	bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID;
+	bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID &&
+			   !iommufd_device_is_noiommu(idev);
 	struct iommufd_group *igroup = idev->igroup;
 	struct iommufd_hw_pagetable *old_hwpt;
 	struct iommufd_attach *attach;
@@ -793,7 +865,8 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
 			  struct iommufd_hw_pagetable *hwpt)
 {
 	struct iommufd_hwpt_paging *hwpt_paging = find_hwpt_paging(hwpt);
-	bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID;
+	bool attach_resv = hwpt_paging && pasid == IOMMU_NO_PASID &&
+			   !iommufd_device_is_noiommu(idev);
 	struct iommufd_hwpt_paging *old_hwpt_paging;
 	struct iommufd_group *igroup = idev->igroup;
 	struct iommufd_hw_pagetable *old_hwpt;
@@ -1585,6 +1658,11 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
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

