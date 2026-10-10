Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B8042BC31;
	Sat, 10 Oct 2026 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791617170; cv=none; b=tIYbV6+CD5i8YGYK3EKaQNM4/xpA8U1rb1zNpK2MlzfAOTzGuscWS09ukKupR8wIC00lMjzGDZI0pb9sT95WdaIZyPjs3zP4o2O2WaC2LmaZt/HR4Mx+DdZqh0jv0gP/xlfeLUnRq5QNbBHXkms0pZNzZtO2V5WuIWpeoJ6ANHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791617170; c=relaxed/simple;
	bh=Vbcbsr6cvfU6GoMdA6/IQjqRxgHN6aqmxXM42m0Oea4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwgwV8lUUJiCiiC2p0li+mmPvvEYkR5XBwNBuD/14xLGlN965PPMapDWAUCp6Lo6ttDE8m777x9yazL9RDTwkFO9BySOVx8prETi2G9uZCOQGyZdnvUfc4kdKoZHVv11vSyfu6i7aNOq8/CWRv1zsf3R+7bKafc1wCVUDqgvj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DopzFWC8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DopzFWC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EDEB1F000FF;
	Sat, 10 Oct 2026 07:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791617165;
	bh=SFc5keFXkg6Mpob065yWrmhH+gHGmT3Wh8EDXifbAc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DopzFWC8mcuatbjy7uO5TuGNT1kRR3mL4Jk8Szz5im+83Efac7+wTbUAETZf9a1SG
	 yPPcWYOJGDa4439dWt/BFE16F5BL0ghFu0VgC2ZNrz0O8Rgk/PtrsjWAZ9f+gboXra
	 LdjtjXV2YycGuf5XVc1ZuLt3D1J5eEy2lNkqsidtJAkiKxG7eTJUDlV1dcSCsNg2IU
	 T4ViC34FO+C5lMMNx/ZbVOQ7lspP86n5u9M5Oz7l9n/L7nu9vw2Bf3RvBYrm1zTAYa
	 C8t4GT6kgnFDn3LAXHY+d9yUSUWXY6OB7hGGGoHxR00nlIb2SzqZmXwnswAupvBbKh
	 +nS66z0+vbRiw==
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
Subject: [RFC PATCH v1 6/6] KVM: Invalidate guest_memfd mappings before removing memslot bindings
Date: Sat, 10 Oct 2026 12:55:04 +0530
Message-ID: <20261010072504.536230-7-aneesh.kumar@kernel.org>
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

Unmap guest_memfd ranges before deleting their memslot bindings. Remove
private device mappings before committing deletion, and invalidate
remaining mappings while holding the inode invalidate lock.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Assisted-by: Codex
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 virt/kvm/guest_memfd.c | 70 ++++++++++++++++++++++++++++++++++++++++--
 virt/kvm/guest_memfd.h |  6 ++++
 virt/kvm/kvm_main.c    |  4 +++
 3 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index f493b452fae8..f58270d0510d 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1330,6 +1330,58 @@ static int kvm_gmem_device_convert(struct inode *inode, pgoff_t start,
 	return ret;
 }
 
+/**
+ * kvm_gmem_prepare_memslot_delete() - remove guest_memfd mappings before deletion
+ * @kvm: VM whose memslot is being removed
+ * @slot: original guest_memfd memslot being removed
+ *
+ * The caller has replaced the active slot with an entry marked
+ * KVM_MEMSLOT_INVALID, preventing new guest faults from creating mappings.
+ * Remove private device mappings, then invalidate the remaining guest_memfd
+ * mappings, including shared mappings.
+ *
+ * Perform this cleanup while the guest_memfd binding still provides the
+ * file-offset-to-GPA translation needed to locate the guest mappings.
+ * The device provider remains attached until guest_memfd close.
+ *
+ * Caller holds slots_lock.
+ * Return: 0 on success or a negative error code.
+ */
+int kvm_gmem_prepare_memslot_delete(const struct kvm_memory_slot *slot)
+{
+	struct file *file = READ_ONCE(slot->gmem.file);
+	pgoff_t start = slot->gmem.pgoff;
+	pgoff_t end = start + slot->npages;
+	struct inode *inode;
+	int ret;
+
+	/* slots_lock keeps the bindings alive until file release can finish. */
+	file = get_file_active(&file);
+	if (!file) {
+		/* Let .release drain the bindings before deletion can discard them. */
+		if (READ_ONCE(slot->gmem.file))
+			return -EBUSY;
+		return 0;
+	}
+	inode = file_inode(file);
+	if (GMEM_I(inode)->device_ops) {
+		ret = kvm_gmem_device_convert(inode, start, slot->npages, NULL, NULL);
+		if (ret)
+			goto out;
+	}
+
+	filemap_invalidate_lock(inode->i_mapping);
+	__kvm_gmem_invalidate_start(file->private_data, start, end,
+				    kvm_gmem_get_all_gfns_filter(inode));
+	__kvm_gmem_invalidate_end(file->private_data, start, end);
+	filemap_invalidate_unlock(inode->i_mapping);
+	ret = 0;
+out:
+	fput(file);
+	return ret;
+}
+
+
 int kvm_gmem_device_map(struct kvm *kvm, u64 gpa, u64 size, u64 pa, u64 vdev_id)
 {
 	struct guest_memfd_device_request req = { gpa, pa, vdev_id };
@@ -1620,11 +1672,19 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 	return r;
 }
 
-static void __kvm_gmem_unbind(struct kvm_memory_slot *slot, struct gmem_file *f)
+static void __kvm_gmem_unbind(struct kvm_memory_slot *slot, struct file *file)
 {
+	struct gmem_file *f = file->private_data;
 	unsigned long start = slot->gmem.pgoff;
 	unsigned long end = start + slot->npages;
 
+	/*
+	 * Unmap this slot's guest mappings before removing it from f->bindings.
+	 * The invalidation helper walks f->bindings to find the slots to unmap.
+	 */
+	__kvm_gmem_invalidate_start(f, start, end,
+				    kvm_gmem_get_all_gfns_filter(file_inode(file)));
+	__kvm_gmem_invalidate_end(f, start, end);
 	xa_store_range(&f->bindings, start, end - 1, NULL, GFP_KERNEL);
 
 	/*
@@ -1656,12 +1716,16 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 	 * until the caller drops slots_lock.
 	 */
 	if (!file) {
-		__kvm_gmem_unbind(slot, slot->gmem.file->private_data);
+		struct file *closing_file = slot->gmem.file;
+
+		filemap_invalidate_lock(closing_file->f_mapping);
+		__kvm_gmem_unbind(slot, closing_file);
+		filemap_invalidate_unlock(closing_file->f_mapping);
 		return;
 	}
 
 	filemap_invalidate_lock(file->f_mapping);
-	__kvm_gmem_unbind(slot, file->private_data);
+	__kvm_gmem_unbind(slot, file);
 	filemap_invalidate_unlock(file->f_mapping);
 }
 
diff --git a/virt/kvm/guest_memfd.h b/virt/kvm/guest_memfd.h
index 0f9c6f840838..6fad6adfdadc 100644
--- a/virt/kvm/guest_memfd.h
+++ b/virt/kvm/guest_memfd.h
@@ -11,6 +11,7 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 		  unsigned int fd, uoff_t offset);
 void kvm_gmem_unbind(struct kvm_memory_slot *slot);
+int kvm_gmem_prepare_memslot_delete(const struct kvm_memory_slot *slot);
 #else
 static inline int kvm_gmem_init(struct module *module)
 {
@@ -29,6 +30,11 @@ static inline void kvm_gmem_unbind(struct kvm_memory_slot *slot)
 {
 	WARN_ON_ONCE(1);
 }
+
+static inline int kvm_gmem_prepare_memslot_delete(const struct kvm_memory_slot *slot)
+{
+	return 0;
+}
 #endif /* CONFIG_KVM_GUEST_MEMFD */
 
 #endif /* __KVM_GUEST_MEMFD_H__ */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f3f46a8563b3..58da57b8a268 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1696,6 +1696,10 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
 	}
 
 	r = kvm_arch_prepare_memory_region(kvm, old, new, change);
+	if (!r && change == KVM_MR_DELETE) {
+		if (old->flags & KVM_MEM_GUEST_MEMFD)
+			r = kvm_gmem_prepare_memslot_delete(old);
+	}
 
 	/* Free the bitmap on failure if it was allocated above. */
 	if (r && new && new->dirty_bitmap && (!old || !old->dirty_bitmap))
-- 
2.43.0

