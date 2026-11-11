Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.245.243.92
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437016;
	b=jriCb3eLduDmqg9nme45WJxqXRbl30PLZWxTqoeVGqwikg5KqIo/NN8mm6BnGjMMRNRZ
	 uB0TIihUXxQYqtvLvFVVFkNq76wKHK9aGpCf/ZhFm8l+9w88kbmgs41fzaHb7oHJA4n7b
	 H6pg+WriEk1E5sMIKJ0Wjt1Ipzt849w5Tyo+X3DF3Br7i3P9Y+FZ3fktUTed6vQfljh2U
	 kXPrwQnx9SheRnf9ONRPtIHv13gNXWwdkbkxArsIG2jN5RW54hNnWX+wP8vE4alUe/t4Q
	 usWobg3oQopNC4pod0dufxT4ogSeZLG1HJ/kaJK03X4lzWvx/SBvvfvbVvJNAOT1O1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437016;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=I5jblTJKi+wXzEn0XfFHHKjPffBWizNSce06ASHpEv0=;
	b=21hfc50GfusjIp3qxf+ifxJR4hUoB0kkVqmQDpPo35fPas8E0nFQN97UKdnyMRb59/QW
	 ITVMfRck1+2VC6VosO1rNeY7wHQ1q+JBvF7ijjJgr/FxzpJdBB6KyyelN3rip53tDA5Mq
	 ij1CalK2u70lzEe0wUqUTFTlmV25Vo4XxlvyKlUiZ2LGS61s3cooulI3lQivNnnk0lHhi
	 +RTbb00dBM02T5e6FNIMAmr37qJIE5AocjgLkx7VVhFsocg7gKlfB5L8p7I1az19YbQRi
	 GphvnNsCJr4zT2kN1Ft3ieiGW9EZxBVQ0efuI50MWkzUOBbuqCXq/9xOLG62xWhCWbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=jM7PUoZ9;
	arc=none smtp.remote-ip=44.245.243.92
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BB6606B003
	for <iommu@lists.linux.dev>; Wed, 11 Nov 2026 22:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83BB6606B003
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=jM7PUoZ9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794437015; x=1825973015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I5jblTJKi+wXzEn0XfFHHKjPffBWizNSce06ASHpEv0=;
  b=jM7PUoZ9LDReBoflh9/T/0OOyWDNcNXOVkQVt8yg8F+HfAD7ljOg9L7c
   5eulU54Mzwyp0cgttjbtauNfPUD36nY+YnkKnSerlmmdM9PAgkTomsGng
   gX8axQhccngq7t8XrXL8F8pRQObfsYzIB9Da5vwLdP2lE+ITk6em6ae+o
   xSpG99kKnnuseKtOH/Z79FfdhBUMhQO4XANILLHqIrOqMMttXZRRgz6rg
   yHndDuRCO2CQiJkySKwuggfanMUYrBCRnOJ+hLbKNNER+wZ1Vief8ZoI1
   kfohuaCmORDKDmKoxRxGOjloFVl34gsRFEDwtJlbM5ZbHgMqUlT9RsP3H
   Q==;
X-CSE-ConnectionGUID: 10AdERIbSoqUwGgXELCDVA==
X-CSE-MsgGUID: mW09cnduT+qQHFr1LPPPTQ==
X-IronPort-AV: E=Sophos;i="6.27,208,1787011200"; 
   d="scan'208";a="33273315"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 22:43:31 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:29377]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.128:2525] with esmtp (Farcaster)
 id 465b19fa-9b9f-4e29-a180-e30b55d7fca4; Wed, 11 Nov 2026 22:43:31 +0000 (UTC)
X-Farcaster-Flow-ID: 465b19fa-9b9f-4e29-a180-e30b55d7fca4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:43:30 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Wed, 11 Nov 2026 22:43:28 +0000
From: Alexander Graf <graf@amazon.com>
To: <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
CC: The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, <linux-doc@vger.kernel.org>, <iommu@lists.linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Mike Rapoport <rppt@kernel.org>,
	<nh-open-source@amazon.com>, <linux-mm@kvack.org>, Jonathan Corbet
	<corbet@lwn.net>
Subject: [PATCH 07/40] nitro_enclaves: Add NE_MEMORY_SHARED
Date: Wed, 11 Nov 2026 22:41:52 +0000
Message-ID: <a1aa64fd1053995db2b20419ca6bee73c3a99f03.1794393490.git.graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1794300002.git.graf@amazon.com>
References: <cover.1794300002.git.graf@amazon.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

In preparation to support Nitro Sandboxes, whose parent keeps using some
of the memory it hands over, add NE_MEMORY_SHARED, a flag for
NE_ALLOC_MEMORY that makes an allocation mappable. The parent needs that
to read state the device writes for it, and for virtqueues and buffers
that both the parent and the sandbox access.

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 drivers/virt/nitro_enclaves/ne_misc_dev.c | 160 +++++++++++++++++++++-
 drivers/virt/nitro_enclaves/ne_misc_dev.h |   6 +-
 include/uapi/linux/nitro_enclaves.h       |  36 ++++-
 3 files changed, 190 insertions(+), 12 deletions(-)

diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.c b/drivers/virt/nitro_enclaves/ne_misc_dev.c
index 56ca1a9d99d41..55dbeb5b14d29 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.c
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.c
@@ -2597,17 +2597,21 @@ static long ne_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
  * serving such a request out of movable memory would take that memory from
  * the rest of the host and leave the reservation bounding nothing.
  *
- * A request larger than one contiguous run is satisfied by several runs, which
- * the driver keeps on a list of its own so that an enclave can be given every
- * one of them.
+ * A request larger than one contiguous run is satisfied by several runs, and
+ * mmap() maps them back to back into one VM_PFNMAP VMA, so user space sees a
+ * single region. The driver keeps the runs on a list of its own, so that an
+ * enclave can be given them without anyone reading them back out of the page
+ * tables.
  *
- * An allocation is never mapped, and the enclave image reaches it through
- * write().
+ * An allocation is either private or shared. A private one is never mapped, and
+ * the enclave image reaches it through write() instead. A shared one can also be
+ * mapped, at an offset and a length its own size bounds.
  *
  * The runs belong to the file the allocation is handed out on. Zeroing a fresh
  * run and a write into an allocation go through ne_walk_run(), so that neither
- * can run for as long as the allocation is large; the release path walks the
- * runs with a preemption point of its own.
+ * can run for as long as the allocation is large. A fault resolves the run its
+ * offset falls in with a binary search instead of walking, and the release path
+ * walks the runs with a preemption point of its own.
  */
 
 /**
@@ -2788,6 +2792,82 @@ static int ne_walk_allocs(struct ne_contig_mem *mem, u64 off, u64 len,
 	return 0;
 }
 
+/**
+ * ne_contig_fault_order() - Install one page table entry for a fault.
+ * @vmf:	The fault.
+ * @order:	Order of the entry to install, zero for a PTE.
+ *
+ * A mapping is populated as it is touched, so a caller that maps a whole
+ * allocation and builds an enclave image at the front of it pays page tables
+ * for the part it touched.
+ *
+ * An entry of @order needs that much of one run behind it, at a matching
+ * physical alignment. A run is a power-of-two multiple of 2 MiB aligned to at
+ * least 2 MiB, so a PMD sized entry fits inside one whenever the address it
+ * lands at is aligned too, and anything that does not fit falls back to the
+ * next order down.
+ *
+ * Return: a VM_FAULT_* value.
+ */
+static vm_fault_t ne_contig_fault_order(struct vm_fault *vmf, unsigned int order)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct ne_contig_mem *mem = vma->vm_file->private_data;
+	unsigned long len = PAGE_SIZE << order;
+	unsigned long addr = ALIGN_DOWN(vmf->address, len);
+	struct ne_contig_alloc *alloc;
+	unsigned long pfn;
+	u64 off;
+
+	if (addr < vma->vm_start || addr + len > vma->vm_end)
+		return VM_FAULT_FALLBACK;
+
+	off = ((u64)vma->vm_pgoff << PAGE_SHIFT) + (addr - vma->vm_start);
+
+	alloc = ne_find_alloc(mem, off);
+	if (!alloc)
+		return VM_FAULT_SIGBUS;
+
+	if (off + len > alloc->off + ((u64)alloc->nr_pages << PAGE_SHIFT))
+		return VM_FAULT_FALLBACK;
+
+	pfn = page_to_pfn(alloc->page) + ((off - alloc->off) >> PAGE_SHIFT);
+	if (!IS_ALIGNED(pfn, len >> PAGE_SHIFT))
+		return VM_FAULT_FALLBACK;
+
+	if (!order)
+		return vmf_insert_pfn(vma, addr, pfn);
+
+	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PMD_PFNMAP) && order == PMD_ORDER)
+		return vmf_insert_pfn_pmd(vmf, pfn,
+					  vmf->flags & FAULT_FLAG_WRITE);
+
+	if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_PUD_PFNMAP) && order == PUD_ORDER)
+		return vmf_insert_pfn_pud(vmf, pfn,
+					  vmf->flags & FAULT_FLAG_WRITE);
+
+	return VM_FAULT_FALLBACK;
+}
+
+static vm_fault_t ne_contig_vma_fault(struct vm_fault *vmf)
+{
+	return ne_contig_fault_order(vmf, 0);
+}
+
+#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
+static vm_fault_t ne_contig_huge_fault(struct vm_fault *vmf, unsigned int order)
+{
+	return ne_contig_fault_order(vmf, order);
+}
+#endif
+
+static const struct vm_operations_struct ne_contig_vm_ops = {
+	.fault		= ne_contig_vma_fault,
+#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
+	.huge_fault	= ne_contig_huge_fault,
+#endif
+};
+
 static struct cma *ne_numa_cma_area(int nid)
 {
 	struct cma *cma = dma_get_numa_cma_area(nid);
@@ -2915,6 +2995,69 @@ struct page *ne_alloc_contig(unsigned long nr_pages, int nid,
 	return page;
 }
 
+/**
+ * ne_contig_supports_mmap() - Whether an allocation may be mapped at all.
+ * @file:	The allocation's file.
+ *
+ * A private allocation is the one an enclave gets to itself, and it is never
+ * mapped. The attribute is fixed when the allocation is made and the file is
+ * not published until it is set, so this reads it without a lock.
+ *
+ * Return: true when the caller may map the allocation.
+ */
+static bool ne_contig_supports_mmap(struct file *file)
+{
+	struct ne_contig_mem *mem = file->private_data;
+
+	return mem->shared;
+}
+
+/**
+ * ne_contig_mmap_prepare() - Set a mapping of part or all of an allocation up.
+ * @desc:	The mapping to set up.
+ *
+ * The offset and the length both have to be multiples of 2 MiB, which is the
+ * unit the allocation itself is made in, and the mapping has to stay inside
+ * the allocation. A caller may map part of an allocation, and may map one
+ * allocation more than once; the runs are not mutated after the file is
+ * published and the file holds them for as long as any mapping exists.
+ *
+ * ne_contig_fault_order() populates the mapping as it is touched. The mapping
+ * asks for VM_HUGEPAGE because a fault on a VM_PFNMAP mapping without it only
+ * reaches ->huge_fault where the transparent_hugepage policy is "always".
+ *
+ * Return: 0 on success, negative return value on failure.
+ */
+static int ne_contig_mmap_prepare(struct vm_area_desc *desc)
+{
+	struct ne_contig_mem *mem = desc->file->private_data;
+	unsigned long size = vma_desc_size(desc);
+	u64 offset = (u64)desc->pgoff << PAGE_SHIFT;
+
+	if (!ne_contig_supports_mmap(desc->file))
+		return -ENODEV;
+
+	/*
+	 * MAP_PRIVATE of an allocation has no meaning: the memory exists to be
+	 * given to an enclave, and a copy that only this process can see never
+	 * reaches one.
+	 */
+	if (!vma_desc_test(desc, VMA_SHARED_BIT))
+		return -EINVAL;
+
+	if ((size | offset) & (NE_MIN_MEM_REGION_SIZE - 1))
+		return -EINVAL;
+
+	if (offset > mem->size || size > mem->size - offset)
+		return -EINVAL;
+
+	desc->vm_ops = &ne_contig_vm_ops;
+	vma_desc_set_flags(desc, VMA_IO_BIT, VMA_PFNMAP_BIT, VMA_DONTEXPAND_BIT,
+			   VMA_DONTDUMP_BIT, VMA_DONTCOPY_BIT, VMA_HUGEPAGE_BIT);
+
+	return 0;
+}
+
 /**
  * struct ne_write_ctx - Where the write walk has got to.
  * @iter:	Where the bytes come from.
@@ -3030,6 +3173,8 @@ static int ne_contig_release(struct inode *inode, struct file *file)
 static const struct file_operations ne_contig_fops = {
 	.owner			= THIS_MODULE,
 	.llseek			= generic_file_llseek,
+	.mmap_prepare		= ne_contig_mmap_prepare,
+	.get_unmapped_area	= thp_get_unmapped_area,
 	.write_iter		= ne_contig_write_iter,
 	.release		= ne_contig_release,
 };
@@ -3176,6 +3321,7 @@ static int ne_alloc_memory_ioctl(struct ne_enclave *ne_enclave,
 	mem->mm = current->mm;
 	mem->nr_pinned = nr_pages;
 	mem->size = args->size;
+	mem->shared = args->flags == NE_MEMORY_SHARED;
 	mem->enclave_id = ne_enclave->id;
 
 	/*
diff --git a/drivers/virt/nitro_enclaves/ne_misc_dev.h b/drivers/virt/nitro_enclaves/ne_misc_dev.h
index 1a76c12815298..fcdf457af5800 100644
--- a/drivers/virt/nitro_enclaves/ne_misc_dev.h
+++ b/drivers/virt/nitro_enclaves/ne_misc_dev.h
@@ -38,6 +38,7 @@ struct ne_contig_alloc {
  * @allocs:	Contiguous runs backing the allocation, ordered by offset.
  * @nr_allocs:	Number of runs in @allocs.
  * @size:	Size of the allocation in bytes, mirrored in i_size.
+ * @shared:	Whether the allocation may be mapped by the caller.
  * @enclave_id:	Id of the enclave the allocation was made for.
  * @mm:		The mm charged for the pinned pages, held via mmgrab().
  * @nr_pinned:	Pages charged to @mm->pinned_vm.
@@ -47,13 +48,14 @@ struct ne_contig_alloc {
  *
  * The array is built before the file is published and not mutated afterwards, so
  * any holder of a reference can read it without a lock of its own, which is what
- * lets a page fault resolve an offset to a run. @size is set in the same place
- * and is read the same way.
+ * lets a page fault resolve an offset to a run. @shared and @size are set in the
+ * same place and are read the same way.
  */
 struct ne_contig_mem {
 	struct ne_contig_alloc	*allocs;
 	unsigned int		nr_allocs;
 	u64			size;
+	bool			shared;
 	u64			enclave_id;
 	struct mm_struct	*mm;
 	unsigned long		nr_pinned;
diff --git a/include/uapi/linux/nitro_enclaves.h b/include/uapi/linux/nitro_enclaves.h
index a2919565bc883..f1315c9c876de 100644
--- a/include/uapi/linux/nitro_enclaves.h
+++ b/include/uapi/linux/nitro_enclaves.h
@@ -215,7 +215,7 @@ struct ne_add_any_vcpu_args {
  * @size:	Number of bytes to allocate, a multiple of 2 MiB.
  * @nid:	Host NUMA node to allocate from. One node, named; unlike
  *		%NE_ADD_ANY_VCPU it does not take %NE_NUMA_ANY.
- * @flags:	%NE_MEMORY_PRIVATE.
+ * @flags:	%NE_MEMORY_PRIVATE or %NE_MEMORY_SHARED.
  */
 struct ne_alloc_memory_args {
 	__u64	size;
@@ -237,7 +237,16 @@ struct ne_alloc_memory_args {
  *		     goes into one through write() or pwrite() and not through
  *		     a copy into a mapping, and every write is a call the
  *		     kernel handles and can act on or refuse.
- *		     The allocation lives until the descriptor is gone.
+ *		     A %NE_MEMORY_SHARED allocation can also be mapped, at
+ *		     offset 0 or at any other multiple of 2 MiB, for a multiple
+ *		     of 2 MiB, with %MAP_SHARED. A caller maps one to keep an
+ *		     address for memory it goes on using after it has handed the
+ *		     allocation over. Such a mapping is readable too, which is
+ *		     the only way to read allocated memory back. The mapping is
+ *		     not inherited across fork(); a child that needs one maps
+ *		     the descriptor itself.
+ *		     The allocation lives until the last of the descriptor and
+ *		     its mappings is gone.
  *		     The ioctl can be invoked on the enclave fd, before an
  *		     enclave is started.
  *
@@ -276,6 +285,17 @@ struct ne_alloc_memory_args {
  *				  write, so a caller that has to know how far it
  *				  got looks at the return value. A fatal signal
  *				  part way through is reported the same way.
+ *
+ * An mmap() of the descriptor sets errno to:
+ * * ENODEV			- The allocation is %NE_MEMORY_PRIVATE.
+ * * EINVAL			- The mapping is %MAP_PRIVATE, or its offset or
+ *				  length is not a multiple of 2 MiB, or it does
+ *				  not fit inside the allocation.
+ * A mapping is populated as it is touched, so the page tables for a page are
+ * allocated at first touch and not by mmap(). A touch by the process itself
+ * that fails to get them is retried until it succeeds or the process is
+ * killed. A touch the kernel makes for the process, as read() into the
+ * mapping does, reports EFAULT or a short transfer instead.
  */
 #define NE_ALLOC_MEMORY			_IOW(0xAE, 0x2E, struct ne_alloc_memory_args)
 
@@ -472,8 +492,18 @@ struct ne_user_memory_region {
  *		       way to put an enclave image in one.
  */
 #define NE_MEMORY_PRIVATE		(0x00)
+/**
+ * NE_MEMORY_SHARED - An allocation the parent may also map. A mapping is what a
+ *		      caller wants for memory it goes on reading or writing
+ *		      after it has handed the allocation over. It costs page
+ *		      tables for the part of it a caller touches, and it leaves
+ *		      the memory reachable from the parent for as long as it
+ *		      lives, so an allocation that is only being handed over
+ *		      does not ask for one.
+ */
+#define NE_MEMORY_SHARED		(0x01)
 
-#define NE_ALLOC_MEMORY_MAX_FLAG_VAL	(0x01)
+#define NE_ALLOC_MEMORY_MAX_FLAG_VAL	(0x02)
 
 /**
  * DOC: Enclave start info flags
-- 
2.47.1

