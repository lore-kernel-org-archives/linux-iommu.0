Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0642F6FD;
	Sat, 10 Oct 2026 07:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791617155; cv=none; b=fWnvM8122t4d69OCTgFi7yzlYWZBFz1obBJdqG+IF01s0OnMrUZsAYrnullgsTxo050VNXCBtyK9mBOMjX0br4AcNezMyBRJSVuoa1ohUl0X6ddfFz7Z4JDeK7V45k1kRR60xwnVe4GHsN5EJQh06geydndMol/EXTThIr/CKwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791617155; c=relaxed/simple;
	bh=euGerIxoxydZXWB5Gqloco5DwOTpdQTDl8x8D0ZUa1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InLsMF+990qKfzKZFY9GDe6qKxWrcesKFS5HxWE0dfbKbMd5PFhTU4ch5Nq4fooVCeJI0qyfil6+DlwJUZHhRSBHdgVcP7P2UexIkrnma6rB/tD/OJcQPjup/P0ZLViBCUW9mz4xZIPXvt6O8jU805Dp0u910MIKMotDs0SoASc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQE4rMKD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQE4rMKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5BB01F000FF;
	Sat, 10 Oct 2026 07:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791617150;
	bh=9b1uifwD3VyUt/lGc6qZJ8QY66DjBnLQRik94AONUao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GQE4rMKDieWjb1GlW+drRPGxuGrdFkm+8XPptc/appD8fLcB39Vq/cShsazOWkHR7
	 VtJwOIzx2sOx/zoMQ5eAZqPG3r4gN/UORGWA+bjzFvjEQ7EoskiL6Iik6TvUp9XIyy
	 09MhPW777rMN5LcEnbPVByyb9+COY9x44SZ+PLNC2kKqkZ1IfBl2U2Q7BN8vz/qBpr
	 FgjuubcVdc+zGTxnuHhBfHHlAQ60/IFFqULzxHFv2ik/FsT6Eq5blwzgnOyQdhQ6nR
	 x8VhvyG7+AgePqiZQOwLuEf8QbeclZHyEY72M3zEMBp78NYNpp+a/E53JCzhqYVwlT
	 xE9bGqT6PyxcA==
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
Subject: [RFC PATCH v1 4/6] vfio/pci: Provide guest_memfd backing for PCI BARs
Date: Sat, 10 Oct 2026 12:55:02 +0530
Message-ID: <20261010072504.536230-5-aneesh.kumar@kernel.org>
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

Allow an ordinary VFIO PCI device fd to supply BAR memory to
guest_memfd. Validate eligible BAR ranges and provide their PFNs for
shared guest mappings. Keep the VFIO file and its IOMMUFD vDEVICE alive
while the provider is attached.

Revoke host and shared guest mappings before private conversion, and
check guest_memfd attributes before allowing host BAR access. Exclude
independent dma-buf exports while attached because their mappings bypass
these access checks.

Hold the vDEVICE MMIO mutex across conversion and attribute updates.
Use the VFIO memory lock to serialize BAR access and revocation. Host
access checks try the inode invalidate lock without waiting, avoiding
deadlock with conversion, which acquires that lock first.

Cc: Alex Williamson <alex@shazbot.org>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org
Assisted-by: Codex
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 drivers/vfio/device_cdev.c              |   3 +-
 drivers/vfio/group.c                    |   4 +-
 drivers/vfio/pci/Kconfig                |  11 +
 drivers/vfio/pci/Makefile               |   2 +
 drivers/vfio/pci/vfio_pci.c             |   3 +
 drivers/vfio/pci/vfio_pci_core.c        |  13 +
 drivers/vfio/pci/vfio_pci_dmabuf.c      |  10 +
 drivers/vfio/pci/vfio_pci_gmem.c        | 322 ++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_gmem.h        |  30 +++
 drivers/vfio/pci/vfio_pci_gmem_access.c | 134 ++++++++++
 drivers/vfio/pci/vfio_pci_rdwr.c        |  13 +-
 drivers/vfio/vfio.h                     |   8 +
 drivers/vfio/vfio_main.c                |  34 ++-
 include/linux/guest_memfd.h             |   3 +
 include/linux/vfio.h                    |   3 +
 include/linux/vfio_pci_core.h           |  23 ++
 virt/kvm/guest_memfd.c                  | 105 ++++++++
 17 files changed, 702 insertions(+), 19 deletions(-)
 create mode 100644 drivers/vfio/pci/vfio_pci_gmem.c
 create mode 100644 drivers/vfio/pci/vfio_pci_gmem.h
 create mode 100644 drivers/vfio/pci/vfio_pci_gmem_access.c

diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
index 1d9515c967b0..3f251120b1cf 100644
--- a/drivers/vfio/device_cdev.c
+++ b/drivers/vfio/device_cdev.c
@@ -46,7 +46,7 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 		goto err_put_registration;
 	}
 
-	filep->private_data = df;
+	filep->private_data = &df->gmem_ops;
 
 	/*
 	 * Use the pseudo fs inode on the device to link all mmaps
@@ -54,7 +54,6 @@ int vfio_device_fops_cdev_open(struct inode *inode, struct file *filep)
 	 * associated to this device using unmap_mapping_range().
 	 */
 	filep->f_mapping = device->inode->i_mapping;
-
 	return 0;
 
 err_put_registration:
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 5bf8cbdff377..5f45d30ac62a 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -271,7 +271,8 @@ static struct file *vfio_device_open_file(struct vfio_device *device)
 		goto err_free;
 
 	filep = anon_inode_getfile_fmode("[vfio-device]", &vfio_device_fops,
-				   df, O_RDWR, FMODE_PREAD | FMODE_PWRITE);
+					 &df->gmem_ops,
+					 O_RDWR, FMODE_PREAD | FMODE_PWRITE);
 	if (IS_ERR(filep)) {
 		ret = PTR_ERR(filep);
 		goto err_close_device;
@@ -282,7 +283,6 @@ static struct file *vfio_device_open_file(struct vfio_device *device)
 	 * associated to this device using unmap_mapping_range().
 	 */
 	filep->f_mapping = device->inode->i_mapping;
-
 	if (device->group->type == VFIO_NO_IOMMU)
 		dev_warn(device->dev, "vfio-noiommu device opened by user "
 			 "(%s:%d)\n", current->comm, task_pid_nr(current));
diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 296bf01e185e..477c5afad7a2 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -55,6 +55,17 @@ config VFIO_PCI_ZDEV_KVM
 
 	  To enable s390x KVM vfio-pci extensions, say Y.
 
+config VFIO_PCI_GMEM
+	bool "VFIO PCI device guest_memfd resource provider"
+	depends on VFIO_PCI && IOMMUFD && ARM64 && KVM
+	depends on KVM_GUEST_MEMFD
+	help
+	  Allow the VFIO PCI device fd to provide BAR PFNs to guest_memfd,
+	  including confidential-device range conversion through its
+	  existing IOMMUFD vDEVICE. This requires a capable TSM backend.
+	  Shared access is revoked before confidential range mapping and is
+	  restored only after private mappings and device state permit it.
+
 config VFIO_PCI_DMABUF
 	def_bool y if VFIO_PCI_CORE && PCI_P2PDMA && DMA_SHARED_BUFFER
 
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 6138f1bf241d..1abb7448c8b1 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -3,6 +3,8 @@
 vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
 vfio-pci-core-$(CONFIG_VFIO_PCI_DMABUF) += vfio_pci_dmabuf.o
+vfio-pci-core-$(CONFIG_VFIO_PCI_GMEM) += vfio_pci_gmem_access.o
+vfio-pci-core-$(CONFIG_VFIO_PCI_GMEM) += vfio_pci_gmem.o
 obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
 
 vfio-pci-y := vfio_pci.o
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 830369ff878d..675357255a01 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -147,6 +147,9 @@ static int vfio_pci_init_dev(struct vfio_device *core_vdev)
 }
 
 static const struct vfio_device_ops vfio_pci_ops = {
+#if IS_ENABLED(CONFIG_VFIO_PCI_GMEM)
+	.gmem_ops = &vfio_pci_gmem_ops,
+#endif
 	.name		= "vfio-pci",
 	.init		= vfio_pci_init_dev,
 	.release	= vfio_pci_core_release_dev,
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 6757054e9d87..1f4bdea4546d 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1714,6 +1714,7 @@ static void vfio_pci_zap_bars(struct vfio_pci_core_device *vdev)
 	loff_t len = end - start;
 
 	unmap_mapping_range(core_vdev->inode->i_mapping, start, len, true);
+	vfio_pci_gmem_invalidate(vdev);
 }
 
 void vfio_pci_zap_and_down_write_memory_lock(struct vfio_pci_core_device *vdev)
@@ -1763,6 +1764,18 @@ vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
 	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
 		return VM_FAULT_SIGBUS;
 
+	/* Use base-page mappings so each BAR page gets its own access check. */
+	if (order && vdev->gmem)
+		return VM_FAULT_FALLBACK;
+	/*
+	 * A VFIO mmap can outlive conversion to private memory. Recheck
+	 * the guest_memfd and VM attributes for this page so a fault
+	 * cannot restore a host mapping of a private BAR range.
+	 */
+	if (!vfio_pci_gmem_access_allowed(vdev,
+				(u64)vmf->pgoff << PAGE_SHIFT, PAGE_SIZE))
+		return VM_FAULT_SIGBUS;
+
 	if (!order)
 		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
 
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index c16f460c01d6..b3ae2d97629f 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -306,6 +306,16 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	/* dma_buf_put() now frees priv */
 	INIT_LIST_HEAD(&priv->dmabufs_elm);
 	down_write(&vdev->memory_lock);
+	/*
+	 * dma-buf consumers bypass guest_memfd range access checks, and their
+	 * mappings are not revoked by conversion to private memory. Exclude
+	 * exports while attached; memory_lock serializes this with attachment.
+	 */
+	if (vdev->gmem) {
+		up_write(&vdev->memory_lock);
+		dma_buf_put(priv->dmabuf);
+		return -EBUSY;
+	}
 	dma_resv_lock(priv->dmabuf->resv, NULL);
 	priv->revoked = !__vfio_pci_memory_enabled(vdev);
 	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
diff --git a/drivers/vfio/pci/vfio_pci_gmem.c b/drivers/vfio/pci/vfio_pci_gmem.c
new file mode 100644
index 000000000000..d232b5c3e539
--- /dev/null
+++ b/drivers/vfio/pci/vfio_pci_gmem.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/guest_memfd.h>
+#include <linux/iommufd.h>
+#include <linux/overflow.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/vfio_pci_core.h>
+
+#include "../vfio.h"
+#include "vfio_pci_priv.h"
+#include "vfio_pci_gmem.h"
+
+/**
+ * vfio_gmem_resolve_bar_range() - validate and resolve a VFIO BAR interval
+ * @ctx: attached VFIO provider
+ * @offset: byte offset in the VFIO region namespace
+ * @size: interval length in bytes
+ * @bar: output BAR index
+ * @bar_offset: output byte offset within that BAR
+ * @pa: output starting physical address
+ *
+ * Check alignment, mmap eligibility, wrapper and BAR bounds, and the physical
+ * resource snapshot taken at attachment. These checks establish the provider
+ * interval; the VMM approves the protected REC physical-address claim.
+ * Output parameters are valid only on success.
+ *
+ * Return: 0 on success, -ESTALE if the BAR resource changed, or -EINVAL for
+ * an ineligible interval.
+ */
+static int vfio_gmem_resolve_bar_range(struct vfio_pci_gmem *ctx, u64 offset,
+		u64 size, u32 *bar, u64 *bar_offset, phys_addr_t *pa)
+{
+	struct pci_dev *pdev = ctx->vdev->pdev;
+	u32 index = offset >> VFIO_PCI_OFFSET_SHIFT;
+	u64 off = offset & ((1ULL << VFIO_PCI_OFFSET_SHIFT) - 1);
+
+	if (!size || !PAGE_ALIGNED(offset | size))
+		return -EINVAL;
+
+	if (offset >= ctx->context.device->size ||
+	    size > ctx->context.device->size - offset)
+		return -EINVAL;
+
+	if (index >= PCI_STD_NUM_BARS)
+		return -EINVAL;
+
+	if (!ctx->vdev->bar_mmap_supported[index] ||
+	    !(pci_resource_flags(pdev, index) & IORESOURCE_MEM) ||
+	    !PAGE_ALIGNED(ctx->start[index]))
+		return -EINVAL;
+
+	if (off >= ctx->len[index] || size > ctx->len[index] - off)
+		return -EINVAL;
+
+	/* The interval must not cross into the next VFIO region. */
+	if (size > (1ULL << VFIO_PCI_OFFSET_SHIFT) - off)
+		return -EINVAL;
+
+	/* BAR resources must still match the snapshot taken at attachment. */
+	if (ctx->start[index] != pci_resource_start(pdev, index) ||
+	    ctx->len[index] != pci_resource_len(pdev, index))
+		return -ESTALE;
+
+	if (check_add_overflow(ctx->start[index], off, pa))
+		return -EINVAL;
+
+	*bar = index;
+	*bar_offset = off;
+	return 0;
+}
+
+/**
+ * vfio_gmem_has_private_mmio() - check for private BAR ranges
+ * @data: attached VFIO provider context
+ *
+ * Return: true if the core has committed private BAR ranges.
+ */
+static bool vfio_gmem_has_private_mmio(void *data)
+{
+	struct vfio_pci_gmem *ctx = vfio_pci_gmem_from_context(data);
+
+	lockdep_assert_held(&ctx->ivdev->mmio_lock);
+	return ctx->context.device->has_private(ctx->context.device);
+}
+
+/**
+ * vfio_gmem_attach() - attach the ordinary VFIO PCI fd to guest_memfd
+ * @file: open VFIO device file supplying the BAR namespace
+ * @gdev: guest_memfd core callbacks and owning VM
+ *
+ * Require an opened IOMMUFD-backed file, exclude another provider and dma-buf
+ * exports, and snapshot the BAR resources. Pin the source file and the existing
+ * vDEVICE after its backend validates the VM. Install reverse invalidation
+ * through the IOMMUFD attachment.
+ *
+ * Return: Provider context on success, or an ERR_PTR() on failure.
+ */
+static struct guest_memfd_device_context *
+vfio_gmem_attach(struct file *file, struct guest_memfd_device *gdev)
+{
+	struct vfio_device_file *df = vfio_device_file_from_file(file);
+	struct vfio_pci_core_device *vdev =
+		container_of(df->device, struct vfio_pci_core_device, vdev);
+	struct vfio_pci_gmem *ctx;
+	struct iommufd_vdevice *ivdev;
+	int bar, ret;
+
+	ctx = kzalloc_obj(*ctx);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->vdev = vdev;
+	ctx->context.device = gdev;
+
+	mutex_lock(&vdev->vdev.dev_set->lock);
+	/* Paired with smp_store_release() after vfio_df_open(). */
+	if (!smp_load_acquire(&df->access_granted) || !df->iommufd) {
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	down_write(&vdev->memory_lock);
+	/*
+	 * Allow only one guest_memfd provider per device. Existing dma-buf
+	 * exports bypass guest_memfd access checks and cannot be revoked by
+	 * conversion to private memory. Check both under memory_lock to
+	 * serialize with provider attachment and dma-buf export.
+	 */
+	if (vdev->gmem || !list_empty(&vdev->dmabufs)) {
+		up_write(&vdev->memory_lock);
+		ret = -EBUSY;
+		goto fail;
+	}
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		ctx->start[bar] = pci_resource_start(vdev->pdev, bar);
+		ctx->len[bar] = pci_resource_len(vdev->pdev, bar);
+	}
+	vdev->gmem = ctx;
+	up_write(&vdev->memory_lock);
+	ivdev = iommufd_device_attach_mmio_provider(vdev->vdev.iommufd_device,
+						    gdev->kvm, &ctx->context,
+						    vfio_gmem_invalidate_mmio,
+						    vfio_gmem_has_private_mmio,
+						    &ctx->owner);
+	if (IS_ERR(ivdev)) {
+		ret = PTR_ERR(ivdev);
+		scoped_guard(rwsem_write, &vdev->memory_lock)
+			vdev->gmem = NULL;
+		goto fail;
+	}
+	scoped_guard(rwsem_write, &vdev->memory_lock)
+		ctx->ivdev = ivdev;
+	/* Defer VFIO last-close and IOMMUFD unbind until gmem is released. */
+	ctx->resource = get_file(file);
+	mutex_unlock(&vdev->vdev.dev_set->lock);
+	return &ctx->context;
+fail:
+	mutex_unlock(&vdev->vdev.dev_set->lock);
+	kfree(ctx);
+	return ERR_PTR(ret);
+}
+
+/**
+ * vfio_gmem_bind() - bind an eligible BAR interval to a memslot
+ * @data: provider context returned by vfio_gmem_attach()
+ * @offset: byte offset in the VFIO region namespace
+ * @size: length in bytes
+ * @binding: receives the pinned mapping owner and virtual device ID
+ *
+ * Validate the resource snapshot and reserve the BAR through the ordinary
+ * VFIO iomap machinery.
+ *
+ * Called with the inode invalidate lock held;
+ * Return: 0 on success or a negative error code.
+ */
+static int vfio_gmem_bind(void *data, u64 offset, u64 size,
+		struct guest_memfd_device_binding *binding)
+{
+	struct vfio_pci_gmem *ctx = vfio_pci_gmem_from_context(data);
+	phys_addr_t pa;
+	u64 off;
+	u32 bar;
+	int ret;
+
+	guard(iommufd_vdevice_mmio)(ctx->ivdev);
+	ret = vfio_gmem_resolve_bar_range(ctx, offset, size, &bar, &off, &pa);
+	if (ret)
+		return ret;
+
+	/* Reserve the physical resource with the ordinary VFIO BAR machinery. */
+	ret = PTR_ERR_OR_ZERO(vfio_pci_core_get_iomap(ctx->vdev, bar));
+	if (!ret) {
+		binding->owner = ctx->owner;
+		binding->vdev_id = ctx->ivdev->virt_id;
+	}
+	return ret;
+}
+
+/**
+ * vfio_gmem_get_pfn() - obtain a shared BAR PFN for a guest fault
+ * @data: attached provider context
+ * @offset: page-aligned byte offset in the VFIO region namespace
+ * @pfn: receives the bare BAR PFN
+ *
+ * Check shared-access admission, power state and PCI memory decoding under
+ * the VFIO memory lock before resolving the resource. The PFN has no RAM
+ * page reference to release. The core checks completed attributes and the
+ * fault path checks the invalidation sequence before installing a mapping.
+ *
+ * Guest_memfd calls this only for shared device ranges. Private mappings use
+ * the physical address from an approved protected device request through
+ * kvm_arch_gmem_device_map(). Installing private mappings through ordinary
+ * PFN faults would bypass that approval path.
+ *
+ * Called with the inode invalidate lock held
+ * Return: 0 on success, -EAGAIN while shared access is unavailable, -ENODEV
+ * after detachment, or a resource-validation error.
+ */
+static int vfio_gmem_get_pfn(void *data, u64 offset, unsigned long *pfn)
+{
+	struct vfio_pci_gmem *ctx = vfio_pci_gmem_from_context(data);
+	struct vfio_pci_core_device *vdev = ctx->vdev;
+	phys_addr_t pa;
+	u64 off;
+	u32 bar;
+	int ret;
+
+	guard(rwsem_read)(&vdev->memory_lock);
+	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
+		return -EAGAIN;
+
+	ret = vfio_gmem_resolve_bar_range(ctx, offset, PAGE_SIZE,
+					  &bar, &off, &pa);
+	if (!ret)
+		*pfn = PHYS_PFN(pa);
+	return ret;
+}
+
+/**
+ * vfio_gmem_prepare_conversion() - serialize device range conversion
+ * @context: attached provider context
+ * @req: protected private request, or NULL for shared cleanup
+ *
+ * Check the virtual device ID and revoke host BAR access and shared stage-2
+ * mappings before private mapping. Shared cleanup only takes the MMIO mutex.
+ * Keep that mutex held across architecture cleanup and attribute publication.
+ *
+ * Called with the inode invalidate lock held. On success,
+ * vfio_gmem_finish_conversion() must release the retained MMIO mutex.
+ * Return: 0 with the MMIO mutex held, or a negative error with it released.
+ */
+static int vfio_gmem_prepare_conversion(struct guest_memfd_device_context *context,
+		const struct guest_memfd_device_request *req)
+{
+	struct vfio_pci_gmem *ctx = vfio_pci_gmem_from_context(context);
+
+	iommufd_vdevice_mmio_lock(ctx->ivdev);
+	if (req && req->vdev_id != ctx->ivdev->virt_id) {
+		iommufd_vdevice_mmio_unlock(ctx->ivdev);
+		return -EPERM;
+	}
+	if (req)
+		vfio_gmem_invalidate_mmio(context);
+	return 0; /* Keep mmio_lock held until finish_conversion(). */
+}
+
+/**
+ * vfio_gmem_finish_conversion() - release the conversion mutex
+ * @context: attached provider context
+ * @req: protected private request, or NULL for shared cleanup
+ *
+ * Release the MMIO mutex after the core publishes completed attributes.
+ * Subsequent faults and host I/O check their own range; no device-wide private
+ * or shared admission state is published here.
+ *
+ * Called with the inode invalidate lock and the vDEVICE MMIO mutex held
+ * after successful preparation.
+ */
+static void vfio_gmem_finish_conversion(struct guest_memfd_device_context *context,
+		const struct guest_memfd_device_request *req)
+{
+	struct vfio_pci_gmem *ctx = vfio_pci_gmem_from_context(context);
+
+	iommufd_vdevice_mmio_unlock(ctx->ivdev);
+}
+
+/**
+ * vfio_gmem_release() - release a provider after successful core cleanup
+ * @data: provider context to release
+ *
+ * Detach from the pinned vDEVICE, clear the VFIO provider association and
+ * drop the source file reference before freeing the context.
+ *
+ * Takes the VFIO device-set lock and the vDEVICE MMIO and VFIO memory
+ * locks while detaching.
+ */
+static void vfio_gmem_release(void *data)
+{
+	struct vfio_pci_gmem *ctx = vfio_pci_gmem_from_context(data);
+	struct vfio_pci_core_device *vdev = ctx->vdev;
+
+	mutex_lock(&vdev->vdev.dev_set->lock);
+	iommufd_vdevice_detach_mmio_provider(ctx->ivdev);
+	down_write(&vdev->memory_lock);
+	vdev->gmem = NULL;
+	up_write(&vdev->memory_lock);
+	mutex_unlock(&vdev->vdev.dev_set->lock);
+	fput(ctx->resource);
+	kfree(ctx);
+}
+
+const struct guest_memfd_device_operations vfio_pci_gmem_ops = {
+	.attach = vfio_gmem_attach,
+	.bind = vfio_gmem_bind,
+	.get_pfn = vfio_gmem_get_pfn,
+	.prepare_conversion = vfio_gmem_prepare_conversion,
+	.finish_conversion = vfio_gmem_finish_conversion,
+	.release = vfio_gmem_release,
+};
+EXPORT_SYMBOL_GPL(vfio_pci_gmem_ops);
+
+MODULE_IMPORT_NS("IOMMUFD");
diff --git a/drivers/vfio/pci/vfio_pci_gmem.h b/drivers/vfio/pci/vfio_pci_gmem.h
new file mode 100644
index 000000000000..e5ad19ba6748
--- /dev/null
+++ b/drivers/vfio/pci/vfio_pci_gmem.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef VFIO_PCI_GMEM_H
+#define VFIO_PCI_GMEM_H
+
+#include <linux/container_of.h>
+#include <linux/guest_memfd.h>
+#include <linux/pci.h>
+
+struct iommufd_vdevice;
+struct vfio_pci_core_device;
+
+struct vfio_pci_gmem {
+	struct guest_memfd_device_context context;
+	struct vfio_pci_core_device *vdev;
+	struct iommufd_vdevice *ivdev;
+	struct file *resource;
+	unsigned long owner;
+	resource_size_t start[PCI_STD_NUM_BARS];
+	resource_size_t len[PCI_STD_NUM_BARS];
+};
+
+static inline struct vfio_pci_gmem *
+vfio_pci_gmem_from_context(struct guest_memfd_device_context *context)
+{
+	return container_of_const(context, struct vfio_pci_gmem, context);
+}
+
+void vfio_gmem_invalidate_mmio(void *data);
+
+#endif /* VFIO_PCI_GMEM_H */
diff --git a/drivers/vfio/pci/vfio_pci_gmem_access.c b/drivers/vfio/pci/vfio_pci_gmem_access.c
new file mode 100644
index 000000000000..a3975b536e22
--- /dev/null
+++ b/drivers/vfio/pci/vfio_pci_gmem_access.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Revoke translations before delegation; shared/private state is per range. */
+#include <linux/guest_memfd.h>
+#include <linux/iommufd.h>
+#include <linux/vfio_pci_core.h>
+
+#include "vfio_pci_gmem.h"
+#include "vfio_pci_priv.h"
+
+/**
+ * vfio_pci_gmem_invalidate() - notify KVM of revoked BAR mappings
+ * @vdev: VFIO PCI device whose BAR translations are being revoked
+ *
+ * Called by vfio_pci_zap_bars() after it removes host BAR mappings. Notify
+ * guest_memfd synchronously so KVM removes the corresponding shared guest
+ * mappings. This helper does not remove host mappings or change attributes.
+ * Skip notification if no provider is attached.
+ *
+ * The guest_memfd callback takes SRCU and the KVM MMU lock without taking
+ * the inode invalidate lock, which may already be held during conversion.
+ *
+ */
+void vfio_pci_gmem_invalidate(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_gmem *ctx = vdev->gmem;
+
+	lockdep_assert_held_write(&vdev->memory_lock);
+	if (ctx)
+		ctx->context.device->invalidate(ctx->context.device);
+}
+
+/**
+ * vfio_gmem_invalidate_mmio() - revoke host and shared guest BAR translations
+ * @data: attached provider context
+ *
+ * Initiate BAR revocation for conversion or access refresh. Call
+ * vfio_pci_zap_and_down_write_memory_lock() to remove host BAR mappings;
+ * its BAR zap path also calls vfio_pci_gmem_invalidate() to remove the
+ * corresponding shared guest mappings. Release the VFIO memory lock before
+ * returning.
+ *
+ * During private conversion, the caller holds the inode invalidate lock to
+ * prevent new guest_memfd faults. Host faults and I/O try that lock when
+ * checking range access, so revocation completes before delegation.
+ *
+ * Caller holds the vDEVICE MMIO mutex; takes the VFIO memory lock for
+ * write and releases it before architecture mapping.
+ */
+void vfio_gmem_invalidate_mmio(void *data)
+{
+	struct vfio_pci_gmem *ctx = vfio_pci_gmem_from_context(data);
+	struct vfio_pci_core_device *vdev = ctx->vdev;
+
+	/* IOMMUFD invokes this during attachment before ctx->ivdev is assigned. */
+	if (ctx->ivdev)
+		lockdep_assert_held(&ctx->ivdev->mmio_lock);
+
+	vfio_pci_zap_and_down_write_memory_lock(vdev);
+	up_write(&vdev->memory_lock);
+}
+
+/**
+ * vfio_pci_gmem_access_allowed() - check a host BAR access against its range
+ * @vdev: VFIO PCI device supplying the BAR
+ * @offset: byte offset in the VFIO region namespace
+ * @size: access length in bytes
+ *
+ * Consult completed guest_memfd attributes for the requested interval.
+ * Private mappings in another interval do not block this access. Try the
+ * inode lock instead of waiting in the reverse order from conversion.
+ *
+ * Return: true when the requested interval is accessible.
+ */
+bool vfio_pci_gmem_access_allowed(struct vfio_pci_core_device *vdev,
+		u64 offset, u64 size)
+{
+	struct vfio_pci_gmem *ctx = vdev->gmem;
+
+	lockdep_assert_held(&vdev->memory_lock);
+	if (!ctx)
+		return true;
+
+	/* Attachment publishes the context before resolving its vDEVICE. */
+	if (!ctx->ivdev)
+		return false;
+
+	return ctx->context.device->host_accessible(ctx->context.device,
+						    offset, size);
+}
+
+/**
+ * vfio_pci_gmem_io_access_allowed() - resolve a mapped BAR I/O pointer
+ * @vdev: VFIO PCI device supplying the iomap
+ * @io: address used by ordinary VFIO read, write or ioeventfd
+ * @size: access width in bytes
+ *
+ * Standard BAR iomaps are cached in barmap. Resolve those to file offsets
+ * before applying range admission. Generic VFIO's remaining memory I/O uses
+ * a temporary ROM iomap, which cannot be bound to a device guest_memfd.
+ * Callers supply VFIO's own validated iomap pointers.
+ *
+ * Return: true when the I/O interval is accessible.
+ */
+bool vfio_pci_gmem_io_access_allowed(struct vfio_pci_core_device *vdev,
+		void __iomem *io, size_t size)
+{
+	unsigned long addr = (unsigned long)io;
+	int bar;
+
+	lockdep_assert_held(&vdev->memory_lock);
+	if (!vdev->gmem)
+		return vfio_pci_gmem_access_allowed(vdev, 0, size);
+
+	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		unsigned long base = (unsigned long)vdev->barmap[bar];
+		u64 offset;
+
+		if (!base || addr < base)
+			continue;
+
+		offset = addr - base;
+		if (offset >= pci_resource_len(vdev->pdev, bar))
+			continue;
+
+		if (size > pci_resource_len(vdev->pdev, bar) - offset)
+			return false;
+
+		return vfio_pci_gmem_access_allowed(vdev,
+				VFIO_PCI_INDEX_TO_OFFSET(bar) + offset, size);
+	}
+	/* The ROM has no private provider mappings, but lifecycle checks apply. */
+	return vfio_pci_gmem_access_allowed(vdev,
+			VFIO_PCI_INDEX_TO_OFFSET(VFIO_PCI_ROM_REGION_INDEX), size);
+}
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 7f14dd46de17..54c1b3d2f725 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -44,7 +44,9 @@ int vfio_pci_core_iowrite##size(struct vfio_pci_core_device *vdev,	\
 {									\
 	if (test_mem) {							\
 		down_read(&vdev->memory_lock);				\
-		if (!__vfio_pci_memory_enabled(vdev)) {			\
+		if (!__vfio_pci_memory_enabled(vdev) ||			\
+		    !vfio_pci_gmem_io_access_allowed(vdev, io,		\
+						     sizeof(u##size))) {	\
 			up_read(&vdev->memory_lock);			\
 			return -EIO;					\
 		}							\
@@ -70,7 +72,9 @@ int vfio_pci_core_ioread##size(struct vfio_pci_core_device *vdev,	\
 {									\
 	if (test_mem) {							\
 		down_read(&vdev->memory_lock);				\
-		if (!__vfio_pci_memory_enabled(vdev)) {			\
+		if (!__vfio_pci_memory_enabled(vdev) ||			\
+		    !vfio_pci_gmem_io_access_allowed(vdev, io,		\
+						     sizeof(u##size))) {	\
 			up_read(&vdev->memory_lock);			\
 			return -EIO;					\
 		}							\
@@ -380,7 +384,10 @@ static int vfio_pci_ioeventfd_handler(void *opaque, void *unused)
 	if (ioeventfd->test_mem) {
 		if (!down_read_trylock(&vdev->memory_lock))
 			return 1; /* Lock contended, use thread */
-		if (!__vfio_pci_memory_enabled(vdev)) {
+		if (!__vfio_pci_memory_enabled(vdev) ||
+		    !vfio_pci_gmem_access_allowed(vdev,
+				VFIO_PCI_INDEX_TO_OFFSET(ioeventfd->bar) +
+				ioeventfd->pos, ioeventfd->count)) {
 			up_read(&vdev->memory_lock);
 			return 0;
 		}
diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
index 9b619951a5d0..af0940a063a9 100644
--- a/drivers/vfio/vfio.h
+++ b/drivers/vfio/vfio.h
@@ -7,6 +7,7 @@
 #define __VFIO_VFIO_H__
 
 #include <linux/file.h>
+#include <linux/guest_memfd.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/module.h>
@@ -17,6 +18,8 @@ struct iommu_group;
 struct vfio_container;
 
 struct vfio_device_file {
+	/* Exposed through file->private_data for VFIO device files. */
+	struct guest_memfd_device_operations gmem_ops;
 	struct vfio_device *device;
 	struct vfio_group *group;
 
@@ -27,6 +30,11 @@ struct vfio_device_file {
 	struct iommufd_ctx *iommufd; /* protected by struct vfio_device_set::lock */
 };
 
+static inline struct vfio_device_file *vfio_device_file_from_file(struct file *file)
+{
+	return container_of(file->private_data, struct vfio_device_file, gmem_ops);
+}
+
 void vfio_device_put_registration(struct vfio_device *device);
 bool vfio_device_try_get_registration(struct vfio_device *device);
 int vfio_df_open(struct vfio_device_file *df);
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index ed96acfa8635..c3df4f9b1ba4 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -509,6 +509,8 @@ vfio_allocate_device_file(struct vfio_device *device)
 	if (!df)
 		return ERR_PTR(-ENOMEM);
 
+	if (device->ops->gmem_ops)
+		df->gmem_ops = *device->ops->gmem_ops;
 	df->device = device;
 	spin_lock_init(&df->kvm_ref_lock);
 
@@ -642,7 +644,7 @@ static inline void vfio_device_pm_runtime_put(struct vfio_device *device)
  */
 static int vfio_device_fops_release(struct inode *inode, struct file *filep)
 {
-	struct vfio_device_file *df = filep->private_data;
+	struct vfio_device_file *df = vfio_device_file_from_file(filep);
 	struct vfio_device *device = df->device;
 
 	if (df->group)
@@ -1340,7 +1342,7 @@ static long vfio_get_region_info(struct vfio_device *device,
 static long vfio_device_fops_unl_ioctl(struct file *filep,
 				       unsigned int cmd, unsigned long arg)
 {
-	struct vfio_device_file *df = filep->private_data;
+	struct vfio_device_file *df = vfio_device_file_from_file(filep);
 	struct vfio_device *device = df->device;
 	void __user *uptr = (void __user *)arg;
 	int ret;
@@ -1393,7 +1395,7 @@ static long vfio_device_fops_unl_ioctl(struct file *filep,
 static ssize_t vfio_device_fops_read(struct file *filep, char __user *buf,
 				     size_t count, loff_t *ppos)
 {
-	struct vfio_device_file *df = filep->private_data;
+	struct vfio_device_file *df = vfio_device_file_from_file(filep);
 	struct vfio_device *device = df->device;
 
 	/* Paired with smp_store_release() following vfio_df_open() */
@@ -1410,7 +1412,7 @@ static ssize_t vfio_device_fops_write(struct file *filep,
 				      const char __user *buf,
 				      size_t count, loff_t *ppos)
 {
-	struct vfio_device_file *df = filep->private_data;
+	struct vfio_device_file *df = vfio_device_file_from_file(filep);
 	struct vfio_device *device = df->device;
 
 	/* Paired with smp_store_release() following vfio_df_open() */
@@ -1425,7 +1427,7 @@ static ssize_t vfio_device_fops_write(struct file *filep,
 
 static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
 {
-	struct vfio_device_file *df = filep->private_data;
+	struct vfio_device_file *df = vfio_device_file_from_file(filep);
 	struct vfio_device *device = df->device;
 
 	/* Paired with smp_store_release() following vfio_df_open() */
@@ -1442,7 +1444,7 @@ static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
 static void vfio_device_show_fdinfo(struct seq_file *m, struct file *filep)
 {
 	char *path;
-	struct vfio_device_file *df = filep->private_data;
+	struct vfio_device_file *df = vfio_device_file_from_file(filep);
 	struct vfio_device *device = df->device;
 
 	path = kobject_get_path(&device->dev->kobj, GFP_KERNEL);
@@ -1470,11 +1472,9 @@ const struct file_operations vfio_device_fops = {
 
 static struct vfio_device *vfio_device_from_file(struct file *file)
 {
-	struct vfio_device_file *df = file->private_data;
-
 	if (file->f_op != &vfio_device_fops)
 		return NULL;
-	return df->device;
+	return vfio_device_file_from_file(file)->device;
 }
 
 /**
@@ -1517,7 +1517,7 @@ EXPORT_SYMBOL_GPL(vfio_file_enforced_coherent);
 
 static void vfio_device_file_set_kvm(struct file *file, struct file *kvm)
 {
-	struct vfio_device_file *df = file->private_data;
+	struct vfio_device_file *df = vfio_device_file_from_file(file);
 	struct file *old;
 
 	if (kvm)
@@ -1814,9 +1814,15 @@ static int __init vfio_init(void)
 
 	ida_init(&vfio.device_ida);
 
+	if (IS_ENABLED(CONFIG_KVM_GUEST_MEMFD)) {
+		ret = guest_memfd_register_device_fops(&vfio_device_fops);
+		if (ret)
+			return ret;
+	}
+
 	ret = vfio_group_init();
 	if (ret)
-		return ret;
+		goto err_group;
 
 	ret = vfio_virqfd_init();
 	if (ret)
@@ -1834,13 +1840,15 @@ static int __init vfio_init(void)
 	vfio_debugfs_create_root();
 	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 	return 0;
-
 err_alloc_dev_chrdev:
 	class_unregister(&vfio_device_class);
 err_dev_class:
 	vfio_virqfd_exit();
 err_virqfd:
 	vfio_group_cleanup();
+err_group:
+	if (IS_ENABLED(CONFIG_KVM_GUEST_MEMFD))
+		guest_memfd_unregister_device_fops(&vfio_device_fops);
 	return ret;
 }
 
@@ -1853,6 +1861,8 @@ static void __exit vfio_cleanup(void)
 	vfio_virqfd_exit();
 	vfio_group_cleanup();
 	xa_destroy(&vfio_device_set_xa);
+	if (IS_ENABLED(CONFIG_KVM_GUEST_MEMFD))
+		guest_memfd_unregister_device_fops(&vfio_device_fops);
 }
 
 module_init(vfio_init);
diff --git a/include/linux/guest_memfd.h b/include/linux/guest_memfd.h
index b566c581f04d..24f4b3c79afa 100644
--- a/include/linux/guest_memfd.h
+++ b/include/linux/guest_memfd.h
@@ -52,6 +52,9 @@ struct guest_memfd_device {
 	struct kvm *kvm;
 	u64 size;
 	void *core;
+	void (*invalidate)(struct guest_memfd_device *gdev);
+	bool (*has_private)(struct guest_memfd_device *gdev);
+	bool (*host_accessible)(struct guest_memfd_device *gdev, u64 offset, u64 size);
 };
 
 /**
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 0cc91c6f96d2..8f71117a2851 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -113,7 +113,10 @@ struct vfio_device {
  *             this device is attached to.
  * @device_feature: Optional, fill in the VFIO_DEVICE_FEATURE ioctl
  */
+struct guest_memfd_device_operations;
+
 struct vfio_device_ops {
+	const struct guest_memfd_device_operations *gmem_ops;
 	char	*name;
 	int	(*init)(struct vfio_device *vdev);
 	void	(*release)(struct vfio_device *vdev);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 9a1674c152aa..73294230d54e 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -149,8 +149,31 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+	/* Attached provider; publication/removal require memory_lock for write. */
+	struct vfio_pci_gmem *gmem;
 };
 
+#if IS_ENABLED(CONFIG_VFIO_PCI_GMEM)
+extern const struct guest_memfd_device_operations vfio_pci_gmem_ops;
+void vfio_pci_gmem_invalidate(struct vfio_pci_core_device *vdev);
+bool vfio_pci_gmem_access_allowed(struct vfio_pci_core_device *vdev,
+				u64 offset, u64 size);
+bool vfio_pci_gmem_io_access_allowed(struct vfio_pci_core_device *vdev,
+				   void __iomem *io, size_t size);
+#else
+static inline void vfio_pci_gmem_invalidate(struct vfio_pci_core_device *vdev) {}
+static inline bool vfio_pci_gmem_access_allowed(struct vfio_pci_core_device *vdev,
+					     u64 offset, u64 size)
+{
+	return true;
+}
+static inline bool vfio_pci_gmem_io_access_allowed(struct vfio_pci_core_device *vdev,
+						void __iomem *io, size_t size)
+{
+	return true;
+}
+#endif
+
 enum vfio_pci_io_width {
 	VFIO_PCI_IO_WIDTH_1 = 1,
 	VFIO_PCI_IO_WIDTH_2 = 2,
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 246099caa75f..fc37066bfaa5 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1106,6 +1106,108 @@ int __weak kvm_arch_gmem_device_unmap(struct kvm *kvm, u64 gpa, u64 size)
 	return -EOPNOTSUPP;
 }
 
+static bool gmem_device_host_accessible(struct guest_memfd_device *gdev,
+					u64 offset, u64 size)
+{
+	struct file *file = READ_ONCE(gdev->core);
+	struct inode *inode;
+	pgoff_t first, last;
+	bool shared;
+
+	if (!file)
+		return false;
+	/* Unwrapped BAR offsets have no private guest_memfd mappings. */
+	if (offset >= gdev->size)
+		return true;
+	size = min(size, gdev->size - offset);
+	if (!size)
+		return false;
+	first = offset >> PAGE_SHIFT;
+	last = ((offset + size - 1) >> PAGE_SHIFT) + 1;
+	inode = file_inode(file);
+	/*
+	 * Keep guest_memfd attributes stable against conversion while checking
+	 * host access. This check only reads attributes, so a shared lock lets
+	 * other access checks run concurrently.
+	 *
+	 * VFIO callers hold memory_lock, but conversion takes the invalidate
+	 * lock exclusively before taking memory_lock to revoke BAR mappings.
+	 * Waiting here could deadlock with conversion. Try the shared lock and
+	 * deny access if it cannot be acquired.
+	 */
+	if (!filemap_invalidate_trylock_shared(inode->i_mapping))
+		return false;
+	shared = __kvm_gmem_range_has_attributes(inode, first, last - first, 0);
+	filemap_invalidate_unlock_shared(inode->i_mapping);
+	return shared;
+}
+
+/**
+ * gmem_device_invalidate() - revoke shared guest mappings of device memory
+ * @gdev: device guest_memfd whose provider is revoking access
+ *
+ * VFIO invokes this callback when zapping BAR mappings. Removing host BAR
+ * mappings alone leaves guest stage-2 mappings intact, so unmap the shared
+ * ranges in memslots backed by this guest_memfd and flush guest TLBs as needed.
+ * Advance the MMU invalidation sequence so faults that obtained a provider PFN
+ * before revocation retry instead of installing a stale mapping.
+ *
+ * SRCU protects memslot traversal, and the KVM MMU lock serializes unmapping
+ * with guest faults. Do not acquire the inode invalidate lock: conversion may
+ * already hold it, and VFIO callers hold memory_lock in the reverse order.
+ *
+ * Context: Caller holds the provider memory lock to exclude new provider PFN
+ * lookups during invalidation. Takes SRCU and the KVM MMU lock.
+ */
+static void gmem_device_invalidate(struct guest_memfd_device *gdev)
+{
+	struct file *file = gdev->core;
+	struct kvm *kvm = gdev->kvm;
+	struct kvm_memory_slot *slot;
+	struct kvm_memslots *slots;
+	int srcu_idx, bkt, as;
+	bool flush = false, found_memslot = false;
+
+	if (!file)
+		return;
+	srcu_idx = srcu_read_lock(&kvm->srcu);
+	KVM_MMU_LOCK(kvm);
+	for (as = 0; as < kvm_arch_nr_memslot_as_ids(kvm); as++) {
+		slots = __kvm_memslots(kvm, as);
+		kvm_for_each_memslot(slot, bkt, slots) {
+			struct kvm_gfn_range range = {
+				.slot = slot,
+				.start = slot->base_gfn,
+				.end = slot->base_gfn + slot->npages,
+				.attr_filter = KVM_FILTER_SHARED,
+				.may_block = false,
+			};
+
+			if (READ_ONCE(slot->gmem.file) != file)
+				continue;
+			if (!found_memslot) {
+				found_memslot = true;
+				kvm_mmu_invalidate_start(kvm);
+			}
+			flush |= kvm_mmu_unmap_gfn_range(kvm, &range);
+		}
+	}
+	if (flush)
+		kvm_flush_remote_tlbs(kvm);
+	if (found_memslot)
+		kvm_mmu_invalidate_end(kvm);
+	KVM_MMU_UNLOCK(kvm);
+	srcu_read_unlock(&kvm->srcu, srcu_idx);
+}
+
+/* The attribute tree owns mapping state; this summary is read under provider locks. */
+static bool gmem_device_has_private(struct guest_memfd_device *gdev)
+{
+	struct gmem_inode *gi = container_of(gdev, struct gmem_inode, device);
+
+	return READ_ONCE(gi->device_has_private);
+}
+
 static void kvm_gmem_device_update_private(struct gmem_inode *gi)
 {
 	MA_STATE(mas, &gi->attributes, 0, 0);
@@ -1295,6 +1397,9 @@ static int kvm_gmem_attach_resource(struct kvm *kvm,
 
 		gi->device.kvm = kvm;
 		gi->device.size = i_size_read(inode);
+		gi->device.invalidate = gmem_device_invalidate;
+		gi->device.host_accessible = gmem_device_host_accessible;
+		gi->device.has_private = gmem_device_has_private;
 		provider = dev_ops->attach(resource_file, &gi->device);
 		fput(resource_file);
 		if (IS_ERR(provider))
-- 
2.43.0

