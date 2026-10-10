Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBC0434989;
	Sat, 10 Oct 2026 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791617169; cv=none; b=KfrrXC6psBGM3/uzVP2sDgYWXhJ21A6ejs/V4SzgilxlfA+00uy2p4t2ZQ9rxYl2Aah4go/TSWCp3MHpWW3Apb9tGVc5NMuRu7igyP2ADEeJ3d3r1PqI//FgW2YWX9OQf+HCNE+1K2akTh0HbZboQdTqpGFpmbM8mXYfxMUntFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791617169; c=relaxed/simple;
	bh=ly/GIgH8nRwLkP47R8iDbrwG9vK+nFIiG6hSiEv5698=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMFaHqEr1VVQq+2oRgTbb7DnHz0OYuKbcOjOO4wxM3xM6YuGiQ1mFYB+0TuCzRPGwEpZ1iwPMUfKM4Ub1t1XzIyLha1IqTsDvnFL2b61VRY5uUf7OjZKrbtvrl9UlffGCNz9h/7sAibfoXEuVKuBj5PxdubgcubuzbDJaypqOWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFVhMT0J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFVhMT0J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058A91F00893;
	Sat, 10 Oct 2026 07:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791617157;
	bh=MSLBgSpL8WFx3oVv0DZuEdHIFrQ0Rx31xXHUW2/juco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BFVhMT0JpSBRMmlI35eyxBKGUunlbBCcfWbHVxhwVAihKgtC1JLvdI36dnHyfD6Cn
	 KMyukunZZk5+j00EDgoTN4O9OCSw2Z41C8hr6ML4O4gfRIuXyzC21Um9jjbNK19m55
	 ouKBN2IleQTtJUMW++NPRdDuYbR7PmdNGD48qJ+n6Kgxd09JSSR8w5oU7CGqFiFPqb
	 nA5A958rzqujOH0cx4qhGEKW8fnuEvVOHfMbjKwok0VewJg61QdJl6a58CK2njNd9J
	 aSytbs+sUEcnaNK3w+d+NlCz4+y+wBm91PiIIz7zV37q159rApgcxMduY5UJhUtx+C
	 JYs+L/ScY6idQ==
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
Subject: [RFC PATCH v1 5/6] KVM/VFIO: Remove device mappings during guest_memfd teardown
Date: Sat, 10 Oct 2026 12:55:03 +0530
Message-ID: <20261010072504.536230-6-aneesh.kumar@kernel.org>
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

On final guest_memfd close, stop new provider access and callbacks
before removing private device mappings and releasing the provider. Keep
slot bindings available until the mappings have been removed.

Serialize teardown with conversion using the inode invalidate lock. VFIO
takes the vDEVICE MMIO mutex and its memory lock when disabling access
and callbacks, preventing concurrent faults or device operations from
using provider state being torn down.

Cc: Alex Williamson <alex@shazbot.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Assisted-by: Codex
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/vfio/pci/vfio_pci_gmem.c        | 27 +++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_gmem.h        |  6 ++++++
 drivers/vfio/pci/vfio_pci_gmem_access.c | 12 +++++++----
 include/linux/guest_memfd.h             |  1 +
 virt/kvm/guest_memfd.c                  | 21 +++++++++++++++++++
 5 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_gmem.c b/drivers/vfio/pci/vfio_pci_gmem.c
index d232b5c3e539..3f8630a0eeca 100644
--- a/drivers/vfio/pci/vfio_pci_gmem.c
+++ b/drivers/vfio/pci/vfio_pci_gmem.c
@@ -183,6 +183,8 @@ static int vfio_gmem_bind(void *data, u64 offset, u64 size,
 	int ret;
 
 	guard(iommufd_vdevice_mmio)(ctx->ivdev);
+	if (ctx->callbacks_detached)
+		return -ENODEV;
 	ret = vfio_gmem_resolve_bar_range(ctx, offset, size, &bar, &off, &pa);
 	if (ret)
 		return ret;
@@ -226,6 +228,8 @@ static int vfio_gmem_get_pfn(void *data, u64 offset, unsigned long *pfn)
 	int ret;
 
 	guard(rwsem_read)(&vdev->memory_lock);
+	if (ctx->callbacks_detached)
+		return -ENODEV;
 	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
 		return -EAGAIN;
 
@@ -255,6 +259,10 @@ static int vfio_gmem_prepare_conversion(struct guest_memfd_device_context *conte
 	struct vfio_pci_gmem *ctx = vfio_pci_gmem_from_context(context);
 
 	iommufd_vdevice_mmio_lock(ctx->ivdev);
+	if (req && ctx->callbacks_detached) {
+		iommufd_vdevice_mmio_unlock(ctx->ivdev);
+		return -ENODEV;
+	}
 	if (req && req->vdev_id != ctx->ivdev->virt_id) {
 		iommufd_vdevice_mmio_unlock(ctx->ivdev);
 		return -EPERM;
@@ -284,6 +292,24 @@ static void vfio_gmem_finish_conversion(struct guest_memfd_device_context *conte
 	iommufd_vdevice_mmio_unlock(ctx->ivdev);
 }
 
+/**
+ * vfio_gmem_detach() - stop invalidation callbacks before core teardown
+ * @data: attached provider context
+ *
+ * Mark the provider detached under the VFIO memory lock and revoke BAR
+ * translations.
+ */
+static void vfio_gmem_detach(void *data)
+{
+	struct vfio_pci_gmem *ctx = vfio_pci_gmem_from_context(data);
+
+	guard(iommufd_vdevice_mmio)(ctx->ivdev);
+	scoped_guard(rwsem_write, &ctx->vdev->memory_lock) {
+		ctx->callbacks_detached = true;
+	}
+	vfio_gmem_invalidate_mmio(&ctx->context);
+}
+
 /**
  * vfio_gmem_release() - release a provider after successful core cleanup
  * @data: provider context to release
@@ -315,6 +341,7 @@ const struct guest_memfd_device_operations vfio_pci_gmem_ops = {
 	.get_pfn = vfio_gmem_get_pfn,
 	.prepare_conversion = vfio_gmem_prepare_conversion,
 	.finish_conversion = vfio_gmem_finish_conversion,
+	.detach = vfio_gmem_detach,
 	.release = vfio_gmem_release,
 };
 EXPORT_SYMBOL_GPL(vfio_pci_gmem_ops);
diff --git a/drivers/vfio/pci/vfio_pci_gmem.h b/drivers/vfio/pci/vfio_pci_gmem.h
index e5ad19ba6748..a47a8d386051 100644
--- a/drivers/vfio/pci/vfio_pci_gmem.h
+++ b/drivers/vfio/pci/vfio_pci_gmem.h
@@ -17,6 +17,12 @@ struct vfio_pci_gmem {
 	unsigned long owner;
 	resource_size_t start[PCI_STD_NUM_BARS];
 	resource_size_t len[PCI_STD_NUM_BARS];
+	/*
+	 * Disables callbacks and new bind/private requests. Set once with
+	 * both the vDEVICE MMIO and VFIO memory locks held; readers hold
+	 * either lock. Shared cleanup remains allowed after detachment.
+	 */
+	bool callbacks_detached;
 };
 
 static inline struct vfio_pci_gmem *
diff --git a/drivers/vfio/pci/vfio_pci_gmem_access.c b/drivers/vfio/pci/vfio_pci_gmem_access.c
index a3975b536e22..254a311b5072 100644
--- a/drivers/vfio/pci/vfio_pci_gmem_access.c
+++ b/drivers/vfio/pci/vfio_pci_gmem_access.c
@@ -14,7 +14,7 @@
  * Called by vfio_pci_zap_bars() after it removes host BAR mappings. Notify
  * guest_memfd synchronously so KVM removes the corresponding shared guest
  * mappings. This helper does not remove host mappings or change attributes.
- * Skip notification if no provider is attached.
+ * Skip notification if no provider is attached or its callbacks are detached.
  *
  * The guest_memfd callback takes SRCU and the KVM MMU lock without taking
  * the inode invalidate lock, which may already be held during conversion.
@@ -25,7 +25,7 @@ void vfio_pci_gmem_invalidate(struct vfio_pci_core_device *vdev)
 	struct vfio_pci_gmem *ctx = vdev->gmem;
 
 	lockdep_assert_held_write(&vdev->memory_lock);
-	if (ctx)
+	if (ctx && !ctx->callbacks_detached)
 		ctx->context.device->invalidate(ctx->context.device);
 }
 
@@ -33,11 +33,12 @@ void vfio_pci_gmem_invalidate(struct vfio_pci_core_device *vdev)
  * vfio_gmem_invalidate_mmio() - revoke host and shared guest BAR translations
  * @data: attached provider context
  *
- * Initiate BAR revocation for conversion or access refresh. Call
+ * Initiate BAR revocation for conversion, access refresh or teardown. Call
  * vfio_pci_zap_and_down_write_memory_lock() to remove host BAR mappings;
  * its BAR zap path also calls vfio_pci_gmem_invalidate() to remove the
  * corresponding shared guest mappings. Release the VFIO memory lock before
- * returning.
+ * returning. Host mappings are removed even if guest_memfd callbacks are
+ * detached.
  *
  * During private conversion, the caller holds the inode invalidate lock to
  * prevent new guest_memfd faults. Host faults and I/O try that lock when
@@ -68,6 +69,7 @@ void vfio_gmem_invalidate_mmio(void *data)
  * Consult completed guest_memfd attributes for the requested interval.
  * Private mappings in another interval do not block this access. Try the
  * inode lock instead of waiting in the reverse order from conversion.
+ * Detachment excludes access during teardown.
  *
  * Return: true when the requested interval is accessible.
  */
@@ -84,6 +86,8 @@ bool vfio_pci_gmem_access_allowed(struct vfio_pci_core_device *vdev,
 	if (!ctx->ivdev)
 		return false;
 
+	if (ctx->callbacks_detached)
+		return false;
 	return ctx->context.device->host_accessible(ctx->context.device,
 						    offset, size);
 }
diff --git a/include/linux/guest_memfd.h b/include/linux/guest_memfd.h
index 24f4b3c79afa..8373ef8150c5 100644
--- a/include/linux/guest_memfd.h
+++ b/include/linux/guest_memfd.h
@@ -41,6 +41,7 @@ struct guest_memfd_device_operations {
 		const struct guest_memfd_device_request *req);
 	void (*finish_conversion)(struct guest_memfd_device_context *context,
 		const struct guest_memfd_device_request *req);
+	void (*detach)(void *data);
 	void (*release)(void *data);
 };
 
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index fc37066bfaa5..f493b452fae8 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -381,6 +381,7 @@ static void kvm_gmem_invalidate_end(struct inode *inode, pgoff_t start,
 static int kvm_gmem_device_convert(struct inode *inode, pgoff_t start,
 		pgoff_t nr_pages, const struct guest_memfd_device_request *req,
 		const struct kvm_memory_slot *slot);
+static void kvm_gmem_device_close(struct inode *inode);
 
 static long kvm_gmem_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 {
@@ -503,6 +504,9 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 
 	filemap_invalidate_lock(inode->i_mapping);
 
+	if (GMEM_I(inode)->device_ops)
+		kvm_gmem_device_close(inode);
+
 	xa_for_each(&f->bindings, index, slot) {
 		WRITE_ONCE(slot->gmem.file, NULL);
 	}
@@ -1362,6 +1366,23 @@ int kvm_gmem_device_map(struct kvm *kvm, u64 gpa, u64 size, u64 pa, u64 vdev_id)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_device_map);
 
+static void kvm_gmem_device_close(struct inode *inode)
+{
+	struct gmem_inode *gi = GMEM_I(inode);
+	int ret;
+
+	gi->device_ops->detach(gi->provider);
+	ret = gi->device_ops->prepare_conversion(gi->provider, NULL);
+	if (!ret) {
+		ret = kvm_gmem_device_make_shared(inode, 0,
+						i_size_read(inode) >> PAGE_SHIFT);
+		if (!ret)
+			WRITE_ONCE(gi->device_has_private, false);
+		gi->device_ops->finish_conversion(gi->provider, NULL);
+	}
+	WRITE_ONCE(gi->device.core, NULL);
+}
+
 static int kvm_gmem_attach_resource(struct kvm *kvm,
 		struct inode *inode, int resource_fd)
 {
-- 
2.43.0

