Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1672B35AC21
	for <iommu@lists.linux.dev>; Fri,  3 Apr 2026 05:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775193120; cv=none; b=TY8nq188w5WEvKre0n6XtzpmNnhkrpmMzjfqiGu6C55/Upji5apamcX3FvHFRHlJ06vI3tsCrNz5XQPa+zMmkN1cZMhN6DyE1pUR3bbnGdNfth8zmrHeCWsryJjsR6eMbes8RV7avrG/kXevqsi3oPuVe3GJlTOPQxkLW0N3FyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775193120; c=relaxed/simple;
	bh=N92SRpP+YB5otcSSkGz7rxxDOPKyMJ0M7ABS40aEhwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BHoZgGn5a9Atde42H50VxcJ0m4JTzLD+2y+nPoSnLX59HCgDG8ZX8lo0gu/eNpMYcJAYgOsqlyFE79q6CnQXTjdviAUc6f/F4dX05EltetIVWn+gXrX0932XVKP6m6BQKkbmiSNbR/lpJSYcXpB7uci2HbnaF1GYCceIMCtJKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mNRq89WI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mNRq89WI"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id B8DA520B7136;
	Thu,  2 Apr 2026 22:11:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B8DA520B7136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775193112;
	bh=GZ0UyWx9W5HBDqnNPhA1OWvphFbU0yyvmlcztWY2uGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mNRq89WIpqpeEcNXvgf0CDczsUR7+SpA9xf3KEDVDORKclOVJViLY9ANzlHMeD0Tv
	 aOU6gW8VtCOzVieosMQbQvmBWeRzTezlemEJd3FOnMp7qXMa583NB8c899W1svX+1H
	 UcPjSj7fGeNmMe0Ycl7WAiWCtCzbccUP7xtSd9xM=
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
Subject: [PATCH V3 03/10] iommufd: Allow binding to a noiommu device
Date: Thu,  2 Apr 2026 22:11:39 -0700
Message-Id: <20260403051146.10210-4-jacob.pan@linux.microsoft.com>
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

From: Jason Gunthorpe <jgg@nvidia.com>

Allow iommufd to bind devices without an IOMMU (noiommu mode) by creating
a dummy IOMMU group for such devices and skipping hwpt operations.

This enables noiommu devices to operate through the same iommufd API as IOMMU-
capable devices.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>

---
v3:
   - handle new error cases iommufd_device_bind. (Mostafa)
---
 drivers/iommu/iommufd/device.c | 126 +++++++++++++++++++++++----------
 1 file changed, 87 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 2f30ea069f66..215fd9660be3 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -23,6 +23,11 @@ struct iommufd_attach {
 	struct xarray device_array;
 };
 
+static bool is_vfio_noiommu(struct iommufd_device *idev)
+{
+	return !device_iommu_mapped(idev->dev) || !idev->dev->iommu;
+}
+
 static void iommufd_group_release(struct kref *kref)
 {
 	struct iommufd_group *igroup =
@@ -30,9 +35,11 @@ static void iommufd_group_release(struct kref *kref)
 
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
@@ -204,32 +211,17 @@ void iommufd_device_destroy(struct iommufd_object *obj)
 	struct iommufd_device *idev =
 		container_of(obj, struct iommufd_device, obj);
 
-	iommu_device_release_dma_owner(idev->dev);
+	if (!is_vfio_noiommu(idev))
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
 
@@ -238,11 +230,11 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	 * to restore cache coherency.
 	 */
 	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
-	igroup = iommufd_get_group(ictx, dev);
+	igroup = iommufd_get_group(idev->ictx, dev);
 	if (IS_ERR(igroup))
-		return ERR_CAST(igroup);
+		return PTR_ERR(igroup);
 
 	/*
 	 * For historical compat with VFIO the insecure interrupt path is
@@ -268,21 +260,69 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	if (rc)
 		goto out_group_put;
 
+	/* igroup refcount moves into iommufd_device */
+	idev->igroup = igroup;
+	return 0;
+
+out_group_put:
+	iommufd_put_group(igroup);
+	return rc;
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
-	if (!iommufd_selftest_is_mock_dev(dev))
-		iommufd_ctx_get(ictx);
 	idev->dev = dev;
 	idev->enforce_cache_coherency =
 		device_iommu_capable(dev, IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
+
+	if (!is_vfio_noiommu(idev)) {
+		rc = iommufd_bind_iommu(idev);
+		if (rc)
+			goto err_out;
+	} else {
+		struct iommufd_group *igroup;
+
+		/*
+		 * Create a dummy igroup, lots of stuff expects ths igroup to be
+		 * present, but a NULL igroup->group is OK
+		 */
+		igroup = iommufd_alloc_group(ictx, NULL);
+		if (IS_ERR(igroup)) {
+			rc = PTR_ERR(igroup);
+			goto err_out;
+		}
+		idev->igroup = igroup;
+	}
+
+	if (!iommufd_selftest_is_mock_dev(dev))
+		iommufd_ctx_get(ictx);
 	/* The calling driver is a user until iommufd_device_unbind() */
 	refcount_inc(&idev->obj.users);
-	/* igroup refcount moves into iommufd_device */
-	idev->igroup = igroup;
 
 	/*
 	 * If the caller fails after this success it must call
@@ -294,11 +334,10 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	*id = idev->obj.id;
 	return idev;
 
-out_release_owner:
-	iommu_device_release_dma_owner(dev);
-out_group_put:
-	iommufd_put_group(igroup);
+err_out:
+	iommufd_object_abort_and_destroy(ictx, &idev->obj);
 	return ERR_PTR(rc);
+
 }
 EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, "IOMMUFD");
 
@@ -512,6 +551,9 @@ static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 	struct iommufd_attach_handle *handle;
 	int rc;
 
+	if (is_vfio_noiommu(idev))
+		return 0;
+
 	if (!iommufd_hwpt_compatible_device(hwpt, idev))
 		return -EINVAL;
 
@@ -559,6 +601,9 @@ static void iommufd_hwpt_detach_device(struct iommufd_hw_pagetable *hwpt,
 {
 	struct iommufd_attach_handle *handle;
 
+	if (is_vfio_noiommu(idev))
+		return;
+
 	handle = iommufd_device_get_attach_handle(idev, pasid);
 	if (pasid == IOMMU_NO_PASID)
 		iommu_detach_group_handle(hwpt->domain, idev->igroup->group);
@@ -577,6 +622,9 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	struct iommufd_attach_handle *handle, *old_handle;
 	int rc;
 
+	if (is_vfio_noiommu(idev))
+		return 0;
+
 	if (!iommufd_hwpt_compatible_device(hwpt, idev))
 		return -EINVAL;
 
@@ -652,7 +700,7 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 		goto err_release_devid;
 	}
 
-	if (attach_resv) {
+	if (attach_resv && !is_vfio_noiommu(idev)) {
 		rc = iommufd_device_attach_reserved_iova(idev, hwpt_paging);
 		if (rc)
 			goto err_release_devid;
-- 
2.34.1

