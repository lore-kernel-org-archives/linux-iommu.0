Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56CD36B055;
	Mon, 27 Apr 2026 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777270229; cv=none; b=MiDpYqFHvIhU3tnMhwKNYsEMA4a28j9uMNs8bqbqxzb6vySq0VyZAKWQU6zv7wKcEVmGzd+uq8lYzYMFVppSKzjvu5NmjuxXksJhTJJC1XycU8hrmjNF216mlrv/PDS7NFSYlTYpJ0faRmnCs+nBbJDKdv2n33HmQ7VtsCHwMp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777270229; c=relaxed/simple;
	bh=GsMrvT95jqJoIf80EiOGB0kNyW9tUTunjzDRSq0VmnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpGjC22kRUr8Ton3Es808mjEIlbcvoNPew3vHwQlwgGAMGorFxNRy9FKt8Ec6u2AKA5j5/9QRK2UfjmenJx7WStpvfQ2Pdk2cyvEEMtT6F39XH5nOEvxxXhZJn/vwz4rWKkuRJh/ZMs0B3M2TatkRegiQUmq5Z7A/6Hyi+lxJlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4AsL3KQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4AsL3KQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A10C19425;
	Mon, 27 Apr 2026 06:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777270229;
	bh=GsMrvT95jqJoIf80EiOGB0kNyW9tUTunjzDRSq0VmnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V4AsL3KQjIIL0ZcbgO+6JHT/kIO/SzhWYeXIgqhVnwmt1BtjDD6vzmgIMYptXg3hg
	 S/0gVOsOihZV8hw4JFYCr6qEYhesUyiLBCofJcP3QBZRAYyHoe1xJ+KU1y3ZmgsZUh
	 ha052FTqdtNgjrSTNsbJGzaOi9bGEbCAtfb8tDiKZOahgweRteN4G1gNfDxt47yXYw
	 SVde2t775SlHYkcZfnkYADOETwJTJoG3xNiXTs75XN6yP8yKcfrjglruZ2Xcue/eCX
	 +SlM3wLnTlsPAMVcrjo0O5tTpcAV21hJetgSutMNHtc1HqL7uSIMc3JHoOzvHjpE4O
	 0u5foroeQyxdw==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 1/4] iommufd/device: Associate a kvm pointer to iommufd_device
Date: Mon, 27 Apr 2026 11:40:02 +0530
Message-ID: <20260427061005.901854-2-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427061005.901854-1-aneesh.kumar@kernel.org>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>

Add a struct kvm * to iommufd_device_bind() fn and associate it
with idev if bind is successful.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
[nicolinc: fix build error in iommufd_test_mock_domain()]
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/device.c          | 5 ++++-
 drivers/iommu/iommufd/iommufd_private.h | 2 ++
 drivers/iommu/iommufd/selftest.c        | 2 +-
 drivers/vfio/iommufd.c                  | 2 +-
 include/linux/iommufd.h                 | 4 +++-
 5 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 344d620cdecc..453fbceb9219 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -203,6 +203,7 @@ void iommufd_device_destroy(struct iommufd_object *obj)
  * iommufd_device_bind - Bind a physical device to an iommu fd
  * @ictx: iommufd file descriptor
  * @dev: Pointer to a physical device struct
+ * @kvm: Pointer to struct kvm if device belongs to a KVM VM
  * @id: Output ID number to return to userspace for this device
  *
  * A successful bind establishes an ownership over the device and returns
@@ -216,7 +217,8 @@ void iommufd_device_destroy(struct iommufd_object *obj)
  * The caller must undo this with iommufd_device_unbind()
  */
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
-					   struct device *dev, u32 *id)
+					   struct device *dev, struct kvm *kvm,
+					   u32 *id)
 {
 	struct iommufd_device *idev;
 	struct iommufd_group *igroup;
@@ -266,6 +268,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 	if (!iommufd_selftest_is_mock_dev(dev))
 		iommufd_ctx_get(ictx);
 	idev->dev = dev;
+	idev->kvm = kvm;
 	idev->enforce_cache_coherency =
 		device_iommu_capable(dev, IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
 	/* The calling driver is a user until iommufd_device_unbind() */
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 6ac1965199e9..c48a568c6cbb 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -488,6 +488,8 @@ struct iommufd_device {
 	struct list_head group_item;
 	/* always the physical device */
 	struct device *dev;
+	/* ..and kvm if available */
+	struct kvm *kvm;
 	bool enforce_cache_coherency;
 	struct iommufd_vdevice *vdev;
 	bool destroying;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 7823142097d4..76a2f83f430c 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -1100,7 +1100,7 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 		goto out_sobj;
 	}
 
-	idev = iommufd_device_bind(ucmd->ictx, &sobj->idev.mock_dev->dev,
+	idev = iommufd_device_bind(ucmd->ictx, &sobj->idev.mock_dev->dev, NULL,
 				   &idev_id);
 	if (IS_ERR(idev)) {
 		rc = PTR_ERR(idev);
diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
index a38d262c6028..c1c58194fd3a 100644
--- a/drivers/vfio/iommufd.c
+++ b/drivers/vfio/iommufd.c
@@ -119,7 +119,7 @@ int vfio_iommufd_physical_bind(struct vfio_device *vdev,
 {
 	struct iommufd_device *idev;
 
-	idev = iommufd_device_bind(ictx, vdev->dev, out_device_id);
+	idev = iommufd_device_bind(ictx, vdev->dev, vdev->kvm, out_device_id);
 	if (IS_ERR(idev))
 		return PTR_ERR(idev);
 	vdev->iommufd_device = idev;
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 6e7efe83bc5d..5cdcb8d2f305 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -24,6 +24,7 @@ struct iommufd_ctx;
 struct iommufd_device;
 struct iommufd_viommu_ops;
 struct page;
+struct kvm;
 
 enum iommufd_object_type {
 	IOMMUFD_OBJ_NONE,
@@ -59,7 +60,8 @@ struct iommufd_object {
 };
 
 struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
-					   struct device *dev, u32 *id);
+					   struct device *dev, struct kvm *kvm,
+					   u32 *id);
 void iommufd_device_unbind(struct iommufd_device *idev);
 
 int iommufd_device_attach(struct iommufd_device *idev, ioasid_t pasid,
-- 
2.43.0

