Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124C12F851;
	Sat, 10 Oct 2026 07:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791617130; cv=none; b=touZVJkHNYjv6PorwueIvMSF6R6ISJTXQqNo52ik+ilAD9WA/NyvPlG7q6cfG91JN9khNNyySDJOVr6d65Qbm22acMXJLM7omfoZchrl+xIKRUgHole/m1Y7BSqvtcoDUQsNCvmreIuT3efwA3OVGdzlfBoaxPjo2qGbPMhnkOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791617130; c=relaxed/simple;
	bh=m9Ca1aLM0eb7pWYfGXouQIe+XOemoY7WRpTYAeF8JaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYjMRfPLGeLNrDVdieZanCDmMD1+8Ipy+8+JNMXSdA72oWPpbu8Oq1BvJS0RxEHDvqaBnSpzPyRSA0UdySbS0RbAxmWJqjs+o5+yclN9TkpkLUnvyYo35KQFBXCZzgh3rtl3xSkj9eeAzYUwLwFQmoB5LaXfoZ8yg2Y3Tlkwb5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eu0dvj24; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eu0dvj24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB9F1F00893;
	Sat, 10 Oct 2026 07:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791617128;
	bh=r+HauRrCKggUEivQqOt7R8dMo+z8Py60eTSvNxkx3gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Eu0dvj24Mi1UpqyagVU5GBWXIA/kfeeB5bkEJat1OviCkllROhfuoPdloUwg/Wsmh
	 pdjPrHDekbfLZ+kJR2zl7cti0tdKFtUR77jJHiQMrciw4PbgUshaN9RoGJ8m3CEKqK
	 0RlvLFVjMZgx1TM0dY04nnFC1d8a/y+Nc+CD2sY+aL2mvkeo1/e2Iosg8IE76btPJK
	 nGecfxIX2Dp1qR7DVr9sViMorzoBvIZ4rtvE8Hl81CqLvMaBzbLxz1UtHMIH5jPmoK
	 wHT4nL4R4Ac9CWNO5Ean/QymXkaDbozc2Amolb/wpUnOWgY79UASIgn/fikl0HEKdD
	 MA24ShzSgh7Rw==
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
Subject: [RFC PATCH v1 1/6] KVM: guest_memfd: attach and bind device resources
Date: Sat, 10 Oct 2026 12:54:59 +0530
Message-ID: <20261010072504.536230-2-aneesh.kumar@kernel.org>
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

Introduce the device resource flag and registration of a provider file
operations identity. KVM checks file->f_op before interpreting
private_data as guest_memfd_device_operations.

Add attach() to establish the provider, bind() to associate eligible
file offsets with memslots, get_pfn() for shared device PFNs, release()
for the provider lifetime.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Assisted-by: Codex
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 Documentation/virt/kvm/api.rst |   4 +
 include/linux/guest_memfd.h    |  34 +++++++
 include/linux/kvm_host.h       |   9 +-
 include/uapi/linux/kvm.h       |   1 +
 virt/kvm/guest_memfd.c         | 167 ++++++++++++++++++++++++++++++---
 5 files changed, 202 insertions(+), 13 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 5ece28765d2c..a4abee9f1ce1 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6527,6 +6527,10 @@ specified via KVM_CREATE_GUEST_MEMFD.  Currently defined flags:
                                 must be a supported resource (e.g. tmpfs mount
                                 root directory). Currently, tmpfs resource pools
                                 require noswap and huge=never mount options.
+  GUEST_MEMFD_FLAG_DEVICE       Use a device resource file as resource_fd. Requires
+                                GUEST_MEMFD_FLAG_USE_RESOURCE and
+                                GUEST_MEMFD_FLAG_INIT_SHARED; mmap is disallowed.
+                                The fd must expose guest_memfd device operations.
   ============================= ================================================
 
 When the KVM MMU performs a PFN lookup to service a guest fault, the fault will
diff --git a/include/linux/guest_memfd.h b/include/linux/guest_memfd.h
index 60eb4f008c24..4f232612a525 100644
--- a/include/linux/guest_memfd.h
+++ b/include/linux/guest_memfd.h
@@ -5,8 +5,42 @@
 #include <linux/types.h>
 
 struct file;
+struct file_operations;
 struct folio;
 struct mempolicy;
+struct kvm;
+struct guest_memfd_device;
+
+/* Binding data stays valid only while the device guest_memfd is active. */
+struct guest_memfd_device_binding {
+	/* Architecture-specific mapping owner, e.g. an RMM vDEVICE handle. */
+	unsigned long owner;
+	u64 vdev_id;
+};
+
+/* Embedded by a device provider and returned from attach(). */
+struct guest_memfd_device_context {
+	struct guest_memfd_device *device;
+};
+
+struct guest_memfd_device_operations {
+	struct guest_memfd_device_context *(*attach)(struct file *resource,
+		struct guest_memfd_device *gdev);
+	int (*bind)(void *data, u64 offset, u64 size,
+		struct guest_memfd_device_binding *binding);
+	int (*get_pfn)(void *data, u64 offset, unsigned long *pfn);
+	void (*release)(void *data);
+};
+
+/* A registered file type stores device operations in file->private_data. */
+int guest_memfd_register_device_fops(const struct file_operations *fops);
+void guest_memfd_unregister_device_fops(const struct file_operations *fops);
+
+struct guest_memfd_device {
+	struct kvm *kvm;
+	u64 size;
+	void *core;
+};
 
 /**
  * struct guest_memfd_provider_operations - Operations for external memory providers
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 1dda54e8dee8..f1675a3e00b6 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -56,6 +56,7 @@
  */
 #define KVM_MEMSLOT_INVALID			(1UL << 16)
 #define KVM_MEMSLOT_GMEM_ONLY			(1UL << 17)
+#define KVM_MEMSLOT_GMEM_DEVICE			(1UL << 18)
 
 /*
  * Bit 63 of the memslot generation number is an "update in-progress flag",
@@ -2605,16 +2606,22 @@ static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
 #endif /* kvm_arch_has_private_mem */
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
+struct guest_memfd_device_binding;
+
 bool kvm_gmem_is_private_gfn(struct kvm *kvm, gfn_t gfn);
 bool kvm_gmem_range_has_attributes(struct kvm_memory_slot *slot, gfn_t start,
 				   gfn_t end, u64 attributes);
+bool kvm_arch_gmem_device_supported(struct kvm *kvm);
+void kvm_arch_gmem_device_bind(struct kvm_memory_slot *slot,
+		const struct guest_memfd_device_binding *binding);
 int kvm_gmem_set_attributes(struct kvm_memory_slot *slot, gfn_t start,
 			    gfn_t end, u64 attributes);
 bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm);
 
 static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
 {
-	u64 flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_USE_RESOURCE;
+	u64 flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_USE_RESOURCE |
+		    GUEST_MEMFD_FLAG_DEVICE;
 
 	if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))
 		flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 9408ddde164a..b0d853f88ca8 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1681,6 +1681,7 @@ struct kvm_memory_attributes2 {
 #define GUEST_MEMFD_FLAG_MMAP		(1ULL << 0)
 #define GUEST_MEMFD_FLAG_INIT_SHARED	(1ULL << 1)
 #define GUEST_MEMFD_FLAG_USE_RESOURCE	(1ULL << 2)
+#define GUEST_MEMFD_FLAG_DEVICE		(1ULL << 3)
 
 struct kvm_create_guest_memfd {
 	__u64 size;
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index a65a1eda8b90..c1fd232a83dd 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -2,11 +2,13 @@
 #include <linux/anon_inodes.h>
 #include <linux/backing-dev.h>
 #include <linux/falloc.h>
+#include <linux/export.h>
 #include <linux/fs.h>
 #include <linux/guest_memfd.h>
 #include <linux/kvm_host.h>
 #include <linux/maple_tree.h>
 #include <linux/mempolicy.h>
+#include <linux/mutex.h>
 #include <linux/pseudo_fs.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
@@ -16,6 +18,46 @@
 
 static struct vfsmount *kvm_gmem_mnt;
 
+static const struct file_operations *kvm_gmem_device_fops;
+static DEFINE_MUTEX(kvm_gmem_device_fops_lock);
+
+int guest_memfd_register_device_fops(const struct file_operations *fops)
+{
+	int ret = 0;
+
+	mutex_lock(&kvm_gmem_device_fops_lock);
+	if (kvm_gmem_device_fops)
+		ret = -EBUSY;
+	else
+		kvm_gmem_device_fops = fops;
+	mutex_unlock(&kvm_gmem_device_fops_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(guest_memfd_register_device_fops);
+
+void guest_memfd_unregister_device_fops(const struct file_operations *fops)
+{
+	mutex_lock(&kvm_gmem_device_fops_lock);
+	if (kvm_gmem_device_fops == fops)
+		kvm_gmem_device_fops = NULL;
+	mutex_unlock(&kvm_gmem_device_fops_lock);
+}
+EXPORT_SYMBOL_GPL(guest_memfd_unregister_device_fops);
+
+static const struct guest_memfd_device_operations *
+kvm_gmem_device_ops(struct file *file)
+{
+	const struct guest_memfd_device_operations *ops = NULL;
+
+	mutex_lock(&kvm_gmem_device_fops_lock);
+	/* The caller's file reference keeps private_data alive. */
+	if (file->f_op == kvm_gmem_device_fops)
+		ops = file->private_data;
+	mutex_unlock(&kvm_gmem_device_fops_lock);
+	return ops;
+}
+
 /*
  * A guest_memfd instance can be associated multiple VMs, each with its own
  * "view" of the underlying physical memory.
@@ -38,6 +80,8 @@ struct gmem_inode {
 	struct inode vfs_inode;
 	struct list_head gmem_file_list;
 
+	struct guest_memfd_device device;
+	const struct guest_memfd_device_operations *device_ops;
 	void *provider;
 	const struct guest_memfd_provider_operations *provider_ops;
 
@@ -75,6 +119,10 @@ static inline void gmem_provider_invalidate_folio(struct gmem_inode *gi,
 
 static inline void gmem_provider_release(struct gmem_inode *gi)
 {
+	if (gi->device_ops) {
+		gi->device_ops->release(gi->provider);
+		kvm_put_kvm(gi->device.kvm);
+	}
 	if (gi->provider_ops && gi->provider_ops->release)
 		gi->provider_ops->release(gi->provider);
 }
@@ -189,6 +237,9 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 	struct mempolicy *policy;
 	struct folio *folio;
 
+	if (gi->device_ops)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	/*
 	 * Fast-path: See if folio is already present in mapping to avoid
 	 * policy_lookup.
@@ -237,6 +288,8 @@ static struct folio *kvm_gmem_get_folio(struct inode *inode, pgoff_t index)
 
 static enum kvm_gfn_range_filter kvm_gmem_get_all_gfns_filter(struct inode *inode)
 {
+	if (GMEM_I(inode)->device_ops)
+		return KVM_FILTER_SHARED;
 	if (gmem_in_place_conversion)
 		return KVM_FILTER_SHARED | KVM_FILTER_PRIVATE;
 
@@ -393,6 +446,9 @@ static long kvm_gmem_fallocate(struct file *file, int mode, loff_t offset,
 {
 	int ret;
 
+	if (GMEM_I(file_inode(file))->device_ops)
+		return -EOPNOTSUPP;
+
 	if (!(mode & FALLOC_FL_KEEP_SIZE))
 		return -EOPNOTSUPP;
 
@@ -436,8 +492,9 @@ static int kvm_gmem_release(struct inode *inode, struct file *file)
 
 	filemap_invalidate_lock(inode->i_mapping);
 
-	xa_for_each(&f->bindings, index, slot)
+	xa_for_each(&f->bindings, index, slot) {
 		WRITE_ONCE(slot->gmem.file, NULL);
+	}
 
 	/*
 	 * All in-flight operations are gone and new bindings can be created.
@@ -477,6 +534,8 @@ DEFINE_CLASS(gmem_get_file, struct file *, if (_T) fput(_T),
 
 static bool kvm_gmem_supports_mmap(struct inode *inode)
 {
+	if (GMEM_I(inode)->device_ops)
+		return false;
 	return GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_MMAP;
 }
 
@@ -733,6 +792,9 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
 	struct ma_state mas;
 	int r = 0;
 
+	if (gi->device_ops)
+		return -EOPNOTSUPP;
+
 	mt = &gi->attributes;
 
 	filemap_invalidate_lock(mapping);
@@ -1007,7 +1069,18 @@ static int kvm_gmem_init_inode(struct inode *inode, loff_t size, u64 flags)
 	return r;
 }
 
-static int kvm_gmem_attach_resource(struct inode *inode, int resource_fd)
+bool __weak kvm_arch_gmem_device_supported(struct kvm *kvm)
+{
+	return false;
+}
+
+void __weak kvm_arch_gmem_device_bind(struct kvm_memory_slot *slot,
+		const struct guest_memfd_device_binding *binding)
+{
+}
+
+static int kvm_gmem_attach_resource(struct kvm *kvm,
+		struct inode *inode, int resource_fd)
 {
 	struct file *resource_file;
 	struct inode *res_inode;
@@ -1018,6 +1091,39 @@ static int kvm_gmem_attach_resource(struct inode *inode, int resource_fd)
 	if (!resource_file)
 		return -EBADF;
 
+	if (GMEM_I(inode)->flags & GUEST_MEMFD_FLAG_DEVICE) {
+		struct gmem_inode *gi = GMEM_I(inode);
+		const struct guest_memfd_device_operations *dev_ops;
+
+		dev_ops = kvm_gmem_device_ops(resource_file);
+		if (!dev_ops || !dev_ops->attach) {
+			fput(resource_file);
+			return -EOPNOTSUPP;
+		}
+
+		if (!kvm_arch_gmem_device_supported(kvm)) {
+			fput(resource_file);
+			return -EOPNOTSUPP;
+		}
+
+		if (!(gi->flags & GUEST_MEMFD_FLAG_INIT_SHARED) ||
+		    (gi->flags & GUEST_MEMFD_FLAG_MMAP)) {
+			fput(resource_file);
+			return -EOPNOTSUPP;
+		}
+
+		gi->device.kvm = kvm;
+		gi->device.size = i_size_read(inode);
+		provider = dev_ops->attach(resource_file, &gi->device);
+		fput(resource_file);
+		if (IS_ERR(provider))
+			return PTR_ERR(provider);
+		kvm_get_kvm(kvm);
+		gi->provider = provider;
+		gi->device_ops = dev_ops;
+		return 0;
+	}
+
 	res_inode = file_inode(resource_file);
 	ops = res_inode->i_sb->s_op->gmem_provider_ops;
 
@@ -1072,7 +1178,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags, int resour
 		goto err_inode;
 
 	if (flags & GUEST_MEMFD_FLAG_USE_RESOURCE) {
-		err = kvm_gmem_attach_resource(inode, resource_fd);
+		err = kvm_gmem_attach_resource(kvm, inode, resource_fd);
 		if (err)
 			goto err_inode;
 	}
@@ -1091,6 +1197,7 @@ static int __kvm_gmem_create(struct kvm *kvm, loff_t size, u64 flags, int resour
 	xa_init(&f->bindings);
 	list_add(&f->entry, &GMEM_I(inode)->gmem_file_list);
 
+	WRITE_ONCE(GMEM_I(inode)->device.core, file);
 	fd_install(fd, file);
 	return fd;
 
@@ -1118,6 +1225,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 
 	if (!(flags & GUEST_MEMFD_FLAG_USE_RESOURCE) && args->resource_fd)
 		return -EINVAL;
+	if ((flags & GUEST_MEMFD_FLAG_DEVICE) &&
+	    !(flags & GUEST_MEMFD_FLAG_USE_RESOURCE))
+		return -EINVAL;
 
 	return __kvm_gmem_create(kvm, size, flags, args->resource_fd);
 }
@@ -1125,6 +1235,7 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 		  unsigned int fd, uoff_t offset)
 {
+	struct guest_memfd_device_binding binding = {};
 	uoff_t size = slot->npages << PAGE_SHIFT;
 	unsigned long start, end;
 	struct gmem_file *f;
@@ -1140,16 +1251,16 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 		return -EBADF;
 
 	if (file->f_op != &kvm_gmem_fops)
-		goto err;
+		goto out_put;
 
 	f = file->private_data;
 	if (f->kvm != kvm)
-		goto err;
+		goto out_put;
 
 	inode = file_inode(file);
 
 	if (!PAGE_ALIGNED(offset) || offset + size > i_size_read(inode))
-		goto err;
+		goto out_put;
 
 	filemap_invalidate_lock(inode->i_mapping);
 
@@ -1159,9 +1270,23 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (!xa_empty(&f->bindings) &&
 	    xa_find(&f->bindings, &start, end - 1, XA_PRESENT)) {
 		r = -EEXIST;
-		filemap_invalidate_unlock(inode->i_mapping);
-		goto err;
+		goto out_unlock;
+	}
+
+	if (GMEM_I(inode)->device_ops) {
+		if (slot->flags & (KVM_MEM_LOG_DIRTY_PAGES | KVM_MEM_READONLY)) {
+			r = -EINVAL;
+			goto out_unlock;
+		}
+		r = GMEM_I(inode)->device_ops->bind(GMEM_I(inode)->provider, offset,
+						   size, &binding);
+		if (r)
+			goto out_unlock;
+		slot->flags |= KVM_MEMSLOT_GMEM_ONLY | KVM_MEMSLOT_GMEM_DEVICE;
 	}
+	r = xa_err(xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL));
+	if (r)
+		goto out_unlock;
 
 	/*
 	 * memslots of flag KVM_MEM_GUEST_MEMFD are immutable to change, so
@@ -1170,19 +1295,20 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	 */
 	WRITE_ONCE(slot->gmem.file, file);
 	slot->gmem.pgoff = start;
+	if (slot->flags & KVM_MEMSLOT_GMEM_DEVICE)
+		kvm_arch_gmem_device_bind(slot, &binding);
 	if (gmem_in_place_conversion || kvm_gmem_supports_mmap(inode))
 		slot->flags |= KVM_MEMSLOT_GMEM_ONLY;
 
-	xa_store_range(&f->bindings, start, end - 1, slot, GFP_KERNEL);
+	r = 0;
+out_unlock:
 	filemap_invalidate_unlock(inode->i_mapping);
-
+out_put:
 	/*
 	 * Drop the reference to the file, even on success.  The file pins KVM,
 	 * not the other way 'round.  Active bindings are invalidated if the
 	 * file is closed before memslots are destroyed.
 	 */
-	r = 0;
-err:
 	fput(file);
 	return r;
 }
@@ -1289,6 +1415,21 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 
 	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
 
+	if (GMEM_I(file_inode(file))->device_ops) {
+		struct gmem_inode *gi = GMEM_I(file_inode(file));
+		unsigned long device_pfn;
+
+		*max_order = 0;
+		if (kvm_gmem_is_private_mem(file_inode(file), index))
+			r = -EAGAIN;
+		else
+			r = gi->device_ops->get_pfn(gi->provider,
+						(u64)index << PAGE_SHIFT, &device_pfn);
+		if (!r)
+			*pfn = device_pfn;
+		goto out;
+	}
+
 	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, max_order);
 	if (IS_ERR(folio)) {
 		r = PTR_ERR(folio);
@@ -1443,6 +1584,8 @@ static struct inode *kvm_gmem_alloc_inode(struct super_block *sb)
 	gi->flags = 0;
 	gi->provider = NULL;
 	gi->provider_ops = NULL;
+	gi->device_ops = NULL;
+	memset(&gi->device, 0, sizeof(gi->device));
 	INIT_LIST_HEAD(&gi->gmem_file_list);
 	return &gi->vfs_inode;
 }
-- 
2.43.0

