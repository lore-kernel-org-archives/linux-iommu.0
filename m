Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA8841F5CC;
	Sat, 10 Oct 2026 07:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791617145; cv=none; b=CHc61ytkUSu7MtsyUUqXsMPwBOTacqTNNFzHXKE5lhl58KkAT8E5EDRIlQivw3pQ7ntkUi8iLGeOkfgnGPG2tQrgNcyY0pryx/LkGMojbC1JLMpHvKGvf0v+8kbasV4mLJjJTvejDNiamUcfi9Ul7G0GiI273pp16EQZdXFTqY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791617145; c=relaxed/simple;
	bh=VsbBN+Gd9crWzbtmDpOiUzbhpJ2HeVHD0GBSu765JAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fplJ+VaRMPHq2q3nXD73hsk/565iUfQzuQI/5bnjEINelrktCD5gyCEgbnnZvCchvG5MYSIlhyqC1mlOJweKIbQOmnvDZR2C5nD3Bmd0q2q2w2Um3FpEbkLlEPBXaWnyTr0Eyipa815OEIJWrg+jjZL4+HBOnBMTFjzm4jpwrn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKID7QUw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKID7QUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730F41F00898;
	Sat, 10 Oct 2026 07:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791617143;
	bh=30aq9tkiRs8WXbQvzT7r2ZLPlmnUXZ3Mb3eddKOUaaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NKID7QUw3ci/1/RxlD7rfVmdSrtZ2/Zd+cFkF34F3aBR5OSiIzgmhoVVTDjO+6TlT
	 yA1rj2Tb9yLhKP03T/xnhCt7fgphDahRbCuG3vQPOaSoZ+BFVp3YaLLAqcA8FQLmtA
	 GN40klzob4yKoZK/HrupRKVY62C5h1Sjcta/h2osWxuurb9r3JAN7gU0p5Jujl7GAa
	 HnCJ0FSKTHcs/69RL+uSQWibqi27ZDad4HXzABYFLrLIIvGjQTqd5wPifJEz1k5FTL
	 FXCUN0hiNoGLWVRfnKYlKbfPiJW2V6vyxQApSlvepExaaiX0O+kRDRXnPqs3dJ0NnH
	 /zKdfkFVEVf8Q==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Alex Williamson <alex@shazbot.org>,
	David Woodhouse <dwmw2@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Christopherson <seanjc@google.com>,
	Will Deacon <will@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Fred Griffoul <griffoul@gmail.com>,
	iommu@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [RFC PATCH v1 3/6] iommufd: Support MMIO provider attachment to vDEVICEs
Date: Sat, 10 Oct 2026 12:55:01 +0530
Message-ID: <20261010072504.536230-4-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010072504.536230-1-aneesh.kumar@kernel.org>
References: <20261010072504.536230-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow a device MMIO provider to attach to the existing vDEVICE after the
backend validates its association with the VM. Keep the vDEVICE and
IOMMUFD context alive until the provider detaches.

Add a per-vDEVICE MMIO mutex to serialize provider attachment and
detachment, and allow providers and backends to use the same lock for
memory conversion and device state changes. Provide callbacks to
invalidate MMIO mappings and query whether private ranges remain.

Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kevin Tian <kevin.tian@intel.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Assisted-by: Codex
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/iommu/iommufd/viommu.c | 90 ++++++++++++++++++++++++++++++++++
 include/linux/iommufd.h        | 33 +++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
index 9155d0dcb4b4..24a817fb2ae8 100644
--- a/drivers/iommu/iommufd/viommu.c
+++ b/drivers/iommu/iommufd/viommu.c
@@ -250,6 +250,7 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
 		goto out_unlock_igroup;
 	}
 
+	mutex_init(&vdev->mmio_lock);
 	vdev->virt_id = virt_id;
 	vdev->viommu = viommu;
 	refcount_inc(&viommu->obj.users);
@@ -487,3 +488,92 @@ int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	iommufd_put_object(ucmd->ictx, &viommu->obj);
 	return rc;
 }
+
+struct iommufd_vdevice *
+iommufd_device_attach_mmio_provider(struct iommufd_device *idev,
+		struct kvm *kvm, void *data,
+		void (*invalidate_mmio)(void *),
+		bool (*has_private_mmio)(void *),
+		unsigned long *owner)
+{
+	struct iommufd_vdevice *vdev;
+	int ret;
+
+	if (!idev)
+		return ERR_PTR(-ENODEV);
+
+	guard(mutex)(&idev->igroup->lock);
+	if (idev->destroying)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	vdev = idev->vdev;
+	if (!vdev)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	if (!vdev->viommu->ops ||
+	    !vdev->viommu->ops->vdevice_get_mmio_owner)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	guard(mutex)(&vdev->mmio_lock);
+	if (vdev->mmio_provider_data)
+		return ERR_PTR(-EBUSY);
+
+	ret = vdev->viommu->ops->vdevice_get_mmio_owner(vdev, kvm, owner);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/* IOMMU_DESTROY must wait for the attached gmem provider to detach. */
+	ret = iommufd_try_inc_users(idev->ictx, &vdev->obj);
+	if (ret)
+		return ERR_PTR(ret);
+
+	iommufd_ctx_get(idev->ictx);
+	vdev->mmio_provider_data = data;
+	vdev->invalidate_mmio = invalidate_mmio;
+	vdev->has_private_mmio = has_private_mmio;
+	invalidate_mmio(data);
+	return vdev;
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_device_attach_mmio_provider, "IOMMUFD");
+
+void iommufd_vdevice_detach_mmio_provider(struct iommufd_vdevice *vdev)
+{
+	struct iommufd_ctx *ictx = vdev->viommu->ictx;
+
+	scoped_guard(mutex, &vdev->mmio_lock) {
+		WARN_ON(iommufd_vdevice_has_private_mmio(vdev));
+		vdev->mmio_provider_data = NULL;
+		vdev->invalidate_mmio = NULL;
+		vdev->has_private_mmio = NULL;
+	}
+	refcount_dec(&vdev->obj.users);
+	iommufd_ctx_put(ictx);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_vdevice_detach_mmio_provider, "IOMMUFD");
+
+void iommufd_vdevice_mmio_lock(struct iommufd_vdevice *vdev)
+{
+	mutex_lock(&vdev->mmio_lock);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_vdevice_mmio_lock, "IOMMUFD");
+
+void iommufd_vdevice_mmio_unlock(struct iommufd_vdevice *vdev)
+{
+	mutex_unlock(&vdev->mmio_lock);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_vdevice_mmio_unlock, "IOMMUFD");
+
+/**
+ * iommufd_vdevice_has_private_mmio() - check for private MMIO ranges
+ * @vdev: vDEVICE whose private MMIO state is being checked
+ *
+ * Return: true if the attached provider has committed private ranges.
+ */
+bool iommufd_vdevice_has_private_mmio(struct iommufd_vdevice *vdev)
+{
+	lockdep_assert_held(&vdev->mmio_lock);
+	if (!vdev->has_private_mmio)
+		return false;
+	return vdev->has_private_mmio(vdev->mmio_provider_data);
+}
+EXPORT_SYMBOL_NS_GPL(iommufd_vdevice_has_private_mmio, "IOMMUFD");
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 2e67846d6f35..3f3b9d1dd22a 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -7,10 +7,12 @@
 #define __LINUX_IOMMUFD_H
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/iommu.h>
 #include <linux/refcount.h>
+#include <linux/mutex.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
 #include <uapi/linux/iommufd.h>
@@ -26,6 +28,7 @@ struct iommufd_device;
 struct iommufd_viommu_ops;
 struct tsm_dev;
 struct page;
+struct kvm;
 struct tsm_guest_req_info;
 
 enum iommufd_object_type {
@@ -73,6 +76,20 @@ int iommufd_device_replace(struct iommufd_device *idev, ioasid_t pasid,
 			   u32 *pt_id);
 void iommufd_device_detach(struct iommufd_device *idev, ioasid_t pasid);
 
+/* The returned opaque vDEVICE pins its IOMMUFD context and physical owner. */
+struct iommufd_vdevice *
+iommufd_device_attach_mmio_provider(struct iommufd_device *idev,
+		struct kvm *kvm, void *data,
+		void (*invalidate_mmio)(void *),
+		bool (*has_private_mmio)(void *),
+		unsigned long *owner);
+void iommufd_vdevice_detach_mmio_provider(struct iommufd_vdevice *vdev);
+void iommufd_vdevice_mmio_lock(struct iommufd_vdevice *vdev);
+void iommufd_vdevice_mmio_unlock(struct iommufd_vdevice *vdev);
+DEFINE_GUARD(iommufd_vdevice_mmio, struct iommufd_vdevice *,
+	     iommufd_vdevice_mmio_lock(_T), iommufd_vdevice_mmio_unlock(_T))
+bool iommufd_vdevice_has_private_mmio(struct iommufd_vdevice *vdev);
+
 struct iommufd_ctx *iommufd_device_to_ictx(struct iommufd_device *idev);
 u32 iommufd_device_to_id(struct iommufd_device *idev);
 
@@ -130,6 +147,18 @@ struct iommufd_vdevice {
 	 */
 	u64 virt_id;
 
+	/* Serializes provider attachment and conversion. */
+	struct mutex mmio_lock;
+	/* Attached provider and callbacks, protected by mmio_lock until detach. */
+	void *mmio_provider_data;
+	/*
+	 * Revoke VFIO userspace BAR mappings and shared guest stage-2 mappings
+	 * before delegation. Private guest mappings remain intact; guest_memfd
+	 * removes them through its architecture unmap operation.
+	 */
+	void (*invalidate_mmio)(void *data);
+	bool (*has_private_mmio)(void *data);
+
 	/* Guest TSM requests accepted by this vdevice; set by vdevice_init(). */
 	u64 tsm_req_op_mask;
 	u32 tsm_tvm_arch;
@@ -187,6 +216,7 @@ struct iommufd_hw_queue {
  *                include/uapi/linux/iommufd.h)
  *                If driver has a deinit function to revert what vdevice_init op
  *                does, it should set it to the @vdev->destroy function pointer
+ * @vdevice_get_mmio_owner: Validate the VM and return its MMIO owner.
  * @vdevice_tsm_req: Forward a guest TSM request to a driver-owned vDEVICE
  * @get_hw_queue_size: Get the size of a driver-defined HW queue structure for a
  *                     given @viommu corresponding to @queue_type. Driver should
@@ -218,6 +248,9 @@ struct iommufd_viommu_ops {
 		const struct iommu_user_data *user_data);
 	int (*cache_invalidate)(struct iommufd_viommu *viommu,
 				struct iommu_user_data_array *array);
+	/* Owner lookup runs with vdevice->mmio_lock held. */
+	int (*vdevice_get_mmio_owner)(struct iommufd_vdevice *vdev,
+		struct kvm *kvm, unsigned long *owner);
 	const size_t vdevice_size;
 	int (*vdevice_init)(struct iommufd_vdevice *vdev);
 	ssize_t (*vdevice_tsm_req)(struct iommufd_vdevice *vdev,
-- 
2.43.0

