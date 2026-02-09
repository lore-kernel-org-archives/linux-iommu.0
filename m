Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388DF3803D7
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770651498; cv=none; b=IoVqfoK7uTTimU4f9X67/UPRzx6brEMKdPV1q1o+DhiPb8wk8ZPPJ8/ngBUNCCjXPDRvHxHstxbhux2EBZhq09Ea1bvMlLj7U4hrJg7kmn9vqjQxpxhxzhJMYe7Xxih7kQAxxVgVkfw8CdNEDdFQnpybg/R0KL3SgK36V5hYmNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770651498; c=relaxed/simple;
	bh=iGVSUlByZ9R+Hf3KbnSMbzHFW1HHMLu5Fivqmkrt5c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffB7f0gdS2u1B0lHP9E2skQ0t0aFa2jlFlQG/3c0XShZ1DM/DYeACJqnRUmTM0BSQpdN7TsdbYpBpT0SHi8hNw3JpGZ/9/JOfyF0tAQra2StynrM6PUcyWMm4p6LpJY8N02WMlxtnplN83kfAoA0zFBdFo45aEluM+f4Q1vJFb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=nx5yOjR5; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nx5yOjR5"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4362507f0bcso2763067f8f.0
        for <iommu@lists.linux.dev>; Mon, 09 Feb 2026 07:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770651496; x=1771256296; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ee6Qt6P3kb+iUDKJmukIBp9eLArciL7f3fEMhhpVWQ=;
        b=nx5yOjR58AQ/x+v2LBEgqvkgO3xHOryDsr4S3nQKb4UmiDqs9BZmpuAKxY8Rrkauwf
         ZrZaJMTipNvUuM/U3+Oebd3/DWIrTPAxUAJ+RiGhCrY6O6Rvnxvzlk68UwCcgXwBXO1N
         eLSoGllYuQfRx+lkqVRo73CXcNhMF65dLKpDXkkIGQ6RiEHB+yD1zs+vrXQsiNDiUQAi
         q/7a2FLEPjF/D/rcDzrgIplmCY6n7UaSQfC/tpGPIrH740PACR9BFtCu5zPUJ292M5Gx
         pcKbMsRKc/gw4yN9VFs0sW0AHn0sZIVJPgxUvsHpnBPmVHsfyYauN8nYTHEBhSdG3ivU
         zLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770651496; x=1771256296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ee6Qt6P3kb+iUDKJmukIBp9eLArciL7f3fEMhhpVWQ=;
        b=hxJK359b6M3eajyF+BTyW8Wus/B9RR7ige6Ty35NcbdLq58Gv+n+KrXlrNkkJR30Qa
         KujxOs6d1r01HOFNqOKT1j5gleQX15fEVhRAryWdqCy+UO+HMavJaPHpKjEaRkEvDbAE
         AdEx82Llv0wqX+n8J8wtKmDfxXXLbLjVwg62LxQBmwf6162RIr5iSuqmFkQHpR7eVRWu
         uhZ03+hmp/WkRPKqxz7HZe6bexTOD88KpdsfHjQLFWNTs+eHkZOSArg2SqxiHRc20Lfa
         D5T6hxHkqj5dQSW3pF+bdZ8B0ZNkK7q1KTwuS6uymyK9unW8770RAdM75Sh4VWaixfNR
         T00w==
X-Forwarded-Encrypted: i=1; AJvYcCUbhCRZ9KTC7ol5sGi1WyU2zFuVaWLpqRnE/9sBBXf4LoALw+pBF+jQYJ2R/f40Ywp8b40zgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKjtyelEGgdQxaKl0sRdP0LoV0HNAKaLQiQgBPCSoeIbDQPOJk
	NgH5gsXeNXS7HD5OtuQPAyQduYMEtxMOmQ5U9uXhQuQaAD6jMfVYj8QOmIMy7OI/tAA=
X-Gm-Gg: AZuq6aK/vWya1gUpLH8K6W108uwwbvWHYPDLZA0eVKJuidreelojDmtiL4FvX4B+nq7
	/e8TzBhgWf/EJ+yu8wrHo+78vJ5daspj2vRqPcCsPu8yPj6I5OWuyoACP0DcHSsKktnSz1NJ+FY
	wSJPi+yt9T96rL02UOjxwGm36LlmIblxxj/figYBYkdwTYkBWSDeqlgi/GHkCMyOVxfpUzjsNU+
	fvbvAEFKLvk9RRecMa3WH97f5arIelRoxCJOVn393FAuuCfgq3asnuM4jotO0O1nlXZlzqSZSS9
	r7fNf8GS3la4ZTEQ7vyfPICuxXfFcQfQym0VvlDBpHNmBzEvSgyWPe5b6m/jhi8eUoXszlXua9S
	6N45Fj9SvmzoUB8nqjQ+OZkzU2CCs2mu8PJvmulv6vDskXrDEuKv2PlLxiAMpS/mmaDk4fVcIgv
	key2xp71CwJyVc
X-Received: by 2002:a05:6000:2c09:b0:436:42fb:153c with SMTP id ffacd0b85a97d-43642fb1705mr11442711f8f.30.1770651496419;
        Mon, 09 Feb 2026 07:38:16 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362972fa4csm26172323f8f.26.2026.02.09.07.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 07:38:15 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	iommu@lists.linux.dev,
	linux-media@vger.kernel.org
Cc: sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com,
	Brian.Starkey@arm.com,
	jstultz@google.com,
	tjmercier@google.com,
	christian.koenig@amd.com,
	m.szyprowski@samsung.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	sean.anderson@linux.dev,
	ptesarik@suse.com,
	catalin.marinas@arm.com,
	aneesh.kumar@kernel.org,
	suzuki.poulose@arm.com,
	steven.price@arm.com,
	thomas.lendacky@amd.com,
	john.allen@amd.com,
	ashish.kalra@amd.com,
	suravee.suthikulpanit@amd.com,
	linux-coco@lists.linux.dev
Subject: [PATCH 5/5] dma-buf: heaps: system: add an option to allocate explicitly decrypted memory
Date: Mon,  9 Feb 2026 16:38:09 +0100
Message-ID: <20260209153809.250835-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260209153809.250835-1-jiri@resnulli.us>
References: <20260209153809.250835-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Add a new DMA_HEAP_FLAG_DECRYPTED heap flag to allow userspace to
allocate decrypted (shared) memory from the dma-buf system heap for
confidential computing (CoCo) VMs.

On CoCo VMs, guest memory is encrypted by default. The hardware uses an
encryption bit in page table entries (C-bit on AMD SEV, "shared" bit on
Intel TDX) to control whether a given memory access is encrypted or
decrypted. The kernel's direct map is set up with encryption enabled,
so pages returned by alloc_pages() are encrypted in the direct map
by default. To make this memory usable for devices that do not support
DMA to encrypted memory (no TDISP support), it has to be explicitly
decrypted. A couple of things are needed to properly handle
decrypted memory for the dma-buf use case:

- set_memory_decrypted() on the direct map after allocation:
  Besides clearing the encryption bit in the direct map PTEs, this
  also notifies the hypervisor about the page state change. On free,
  the inverse set_memory_encrypted() must be called before returning
  pages to the allocator. If re-encryption fails, pages
  are intentionally leaked to prevent decrypted memory from being
  reused as private.

- pgprot_decrypted() for userspace and kernel virtual mappings:
  Any new mapping of the decrypted pages, be it to userspace via
  mmap or to kernel vmalloc space via vmap, creates PTEs independent
  of the direct map. These must also have the encryption bit cleared,
  otherwise accesses through them would see encrypted (garbage) data.

- DMA_ATTR_CC_DECRYPTED for DMA mapping:
  Since the pages are already decrypted, the DMA API needs to be
  informed via DMA_ATTR_CC_DECRYPTED so it can map them correctly
  as unencrypted for device access.

On non-CoCo VMs the flag is rejected with -EOPNOTSUPP to prevent
misuse by userspace that does not understand the security implications
of explicitly decrypted memory.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/dma-buf/heaps/system_heap.c | 87 +++++++++++++++++++++++++++--
 include/linux/dma-heap.h            |  1 +
 include/uapi/linux/dma-heap.h       | 12 +++-
 3 files changed, 94 insertions(+), 6 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 124dca56e4d8..0f80ecb660ec 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -10,6 +10,7 @@
  *	Andrew F. Davis <afd@ti.com>
  */
 
+#include <linux/cc_platform.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-heap.h>
@@ -17,7 +18,9 @@
 #include <linux/highmem.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/pgtable.h>
 #include <linux/scatterlist.h>
+#include <linux/set_memory.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
@@ -29,6 +32,7 @@ struct system_heap_buffer {
 	struct sg_table sg_table;
 	int vmap_cnt;
 	void *vaddr;
+	bool decrypted;
 };
 
 struct dma_heap_attachment {
@@ -36,6 +40,7 @@ struct dma_heap_attachment {
 	struct sg_table table;
 	struct list_head list;
 	bool mapped;
+	bool decrypted;
 };
 
 #define LOW_ORDER_GFP (GFP_HIGHUSER | __GFP_ZERO)
@@ -52,6 +57,34 @@ static gfp_t order_flags[] = {HIGH_ORDER_GFP, HIGH_ORDER_GFP, LOW_ORDER_GFP};
 static const unsigned int orders[] = {8, 4, 0};
 #define NUM_ORDERS ARRAY_SIZE(orders)
 
+static int system_heap_set_page_decrypted(struct page *page)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+	unsigned int nr_pages = 1 << compound_order(page);
+	int ret;
+
+	ret = set_memory_decrypted(addr, nr_pages);
+	if (ret)
+		pr_warn_ratelimited("dma-buf system heap: failed to decrypt page at %p\n",
+				    page_address(page));
+
+	return ret;
+}
+
+static int system_heap_set_page_encrypted(struct page *page)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+	unsigned int nr_pages = 1 << compound_order(page);
+	int ret;
+
+	ret = set_memory_encrypted(addr, nr_pages);
+	if (ret)
+		pr_warn_ratelimited("dma-buf system heap: failed to re-encrypt page at %p, leaking memory\n",
+				    page_address(page));
+
+	return ret;
+}
+
 static int dup_sg_table(struct sg_table *from, struct sg_table *to)
 {
 	struct scatterlist *sg, *new_sg;
@@ -90,6 +123,7 @@ static int system_heap_attach(struct dma_buf *dmabuf,
 	a->dev = attachment->dev;
 	INIT_LIST_HEAD(&a->list);
 	a->mapped = false;
+	a->decrypted = buffer->decrypted;
 
 	attachment->priv = a;
 
@@ -119,9 +153,11 @@ static struct sg_table *system_heap_map_dma_buf(struct dma_buf_attachment *attac
 {
 	struct dma_heap_attachment *a = attachment->priv;
 	struct sg_table *table = &a->table;
+	unsigned long attrs;
 	int ret;
 
-	ret = dma_map_sgtable(attachment->dev, table, direction, 0);
+	attrs = a->decrypted ? DMA_ATTR_CC_DECRYPTED : 0;
+	ret = dma_map_sgtable(attachment->dev, table, direction, attrs);
 	if (ret)
 		return ERR_PTR(ret);
 
@@ -188,8 +224,13 @@ static int system_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
 	unsigned long addr = vma->vm_start;
 	unsigned long pgoff = vma->vm_pgoff;
 	struct scatterlist *sg;
+	pgprot_t prot;
 	int i, ret;
 
+	prot = vma->vm_page_prot;
+	if (buffer->decrypted)
+		prot = pgprot_decrypted(prot);
+
 	for_each_sgtable_sg(table, sg, i) {
 		unsigned long n = sg->length >> PAGE_SHIFT;
 
@@ -206,8 +247,7 @@ static int system_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
 		if (addr + size > vma->vm_end)
 			size = vma->vm_end - addr;
 
-		ret = remap_pfn_range(vma, addr, page_to_pfn(page),
-				size, vma->vm_page_prot);
+		ret = remap_pfn_range(vma, addr, page_to_pfn(page), size, prot);
 		if (ret)
 			return ret;
 
@@ -225,6 +265,7 @@ static void *system_heap_do_vmap(struct system_heap_buffer *buffer)
 	struct page **pages = vmalloc(sizeof(struct page *) * npages);
 	struct page **tmp = pages;
 	struct sg_page_iter piter;
+	pgprot_t prot;
 	void *vaddr;
 
 	if (!pages)
@@ -235,7 +276,10 @@ static void *system_heap_do_vmap(struct system_heap_buffer *buffer)
 		*tmp++ = sg_page_iter_page(&piter);
 	}
 
-	vaddr = vmap(pages, npages, VM_MAP, PAGE_KERNEL);
+	prot = PAGE_KERNEL;
+	if (buffer->decrypted)
+		prot = pgprot_decrypted(prot);
+	vaddr = vmap(pages, npages, VM_MAP, prot);
 	vfree(pages);
 
 	if (!vaddr)
@@ -296,6 +340,14 @@ static void system_heap_dma_buf_release(struct dma_buf *dmabuf)
 	for_each_sgtable_sg(table, sg, i) {
 		struct page *page = sg_page(sg);
 
+		/*
+		 * Intentionally leak pages that cannot be re-encrypted
+		 * to prevent decrypted memory from being reused.
+		 */
+		if (buffer->decrypted &&
+		    system_heap_set_page_encrypted(page))
+			continue;
+
 		__free_pages(page, compound_order(page));
 	}
 	sg_free_table(table);
@@ -344,6 +396,7 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
 	unsigned long size_remaining = len;
 	unsigned int max_order = orders[0];
+	bool decrypted = heap_flags & DMA_HEAP_FLAG_DECRYPTED;
 	struct dma_buf *dmabuf;
 	struct sg_table *table;
 	struct scatterlist *sg;
@@ -351,6 +404,15 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 	struct page *page, *tmp_page;
 	int i, ret = -ENOMEM;
 
+	if (decrypted) {
+		if (!cc_platform_has(CC_ATTR_MEM_ENCRYPT))
+			return ERR_PTR(-EOPNOTSUPP);
+#ifdef CONFIG_HIGHMEM
+		/* Sanity check, should not happen. */
+		return ERR_PTR(-EINVAL);
+#endif
+	}
+
 	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
 	if (!buffer)
 		return ERR_PTR(-ENOMEM);
@@ -359,6 +421,7 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 	mutex_init(&buffer->lock);
 	buffer->heap = heap;
 	buffer->len = len;
+	buffer->decrypted = decrypted;
 
 	INIT_LIST_HEAD(&pages);
 	i = 0;
@@ -393,6 +456,14 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 		list_del(&page->lru);
 	}
 
+	if (decrypted) {
+		for_each_sgtable_sg(table, sg, i) {
+			ret = system_heap_set_page_decrypted(sg_page(sg));
+			if (ret)
+				goto free_pages;
+		}
+	}
+
 	/* create the dmabuf */
 	exp_info.exp_name = dma_heap_get_name(heap);
 	exp_info.ops = &system_heap_buf_ops;
@@ -410,6 +481,13 @@ static struct dma_buf *system_heap_allocate(struct dma_heap *heap,
 	for_each_sgtable_sg(table, sg, i) {
 		struct page *p = sg_page(sg);
 
+		/*
+		 * Intentionally leak pages that cannot be re-encrypted
+		 * to prevent decrypted memory from being reused.
+		 */
+		if (buffer->decrypted &&
+		    system_heap_set_page_encrypted(p))
+			continue;
 		__free_pages(p, compound_order(p));
 	}
 	sg_free_table(table);
@@ -430,6 +508,7 @@ static int __init system_heap_create(void)
 	struct dma_heap_export_info exp_info = {
 		.name = "system",
 		.ops = &system_heap_ops,
+		.valid_heap_flags = DMA_HEAP_FLAG_DECRYPTED,
 	};
 	struct dma_heap *sys_heap;
 
diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
index 7cfb531a9281..295a7eaa19ca 100644
--- a/include/linux/dma-heap.h
+++ b/include/linux/dma-heap.h
@@ -10,6 +10,7 @@
 #define _DMA_HEAPS_H
 
 #include <linux/types.h>
+#include <uapi/linux/dma-heap.h>
 
 struct dma_heap;
 
diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-heap.h
index a4cf716a49fa..6552c88e52f6 100644
--- a/include/uapi/linux/dma-heap.h
+++ b/include/uapi/linux/dma-heap.h
@@ -18,8 +18,16 @@
 /* Valid FD_FLAGS are O_CLOEXEC, O_RDONLY, O_WRONLY, O_RDWR */
 #define DMA_HEAP_VALID_FD_FLAGS (O_CLOEXEC | O_ACCMODE)
 
-/* Currently no heap flags */
-#define DMA_HEAP_VALID_HEAP_FLAGS (0ULL)
+/**
+ * DMA_HEAP_FLAG_DECRYPTED - Allocate decrypted (shared) memory
+ *
+ * For confidential computing guests (AMD SEV, Intel TDX), this flag
+ * requests that the allocated memory be marked as decrypted (shared
+ * with the host).
+ */
+#define DMA_HEAP_FLAG_DECRYPTED		(1ULL << 0)
+
+#define DMA_HEAP_VALID_HEAP_FLAGS (DMA_HEAP_FLAG_DECRYPTED)
 
 /**
  * struct dma_heap_allocation_data - metadata passed from userspace for
-- 
2.51.1

