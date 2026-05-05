Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6B8282F1A
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 00:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940868; cv=none; b=PgEoJ7QVfiGJv8TrAnOjWsKdBZAz5trlYCk2qiW5jNT5pDNvobfyodXYaCFBrEVc8GbN+opmBw2ER+7Ok4llru4C5+3v85JEvbO8buquVe9oPaWGFnrl8KSyMosIJJfpVuBnxx06lbMebFAc0FQGGTZ2ZXg1KUAP+PNydBwzeVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940868; c=relaxed/simple;
	bh=aM+uxzi74ErOIQV1wNCkBoE1fYEbHevhpMfCkOITqpY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q3ozprZMYOKQqcJgm0Sf6prUtKtDw4qH9rS+bdsd6rRr40x0kpt87Ksb+xCr985V2IV9QvhNyYKaseSmPIE3w6F/J7d3OQ8m6oFTpnB3aTfiRJWYYHoMRX6AzW3po36cBBL5epYd+yYH885fgYbSLJPBPcjs9vWk1JlU+2ohjRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jGEMruDj; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jGEMruDj"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c802545ae0eso800331a12.2
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 17:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777940864; x=1778545664; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M2hjkJ1In2ag1iLE+KuZ3epwvTGInKsCURDrkdhtZDM=;
        b=jGEMruDjHhIsRZ8+z9doPyiwhd0h62ewiz2LJ/3JRdvWXPTLih1Z/8vKqAw4geQL2D
         SZkOjUdGSzozCZiOw2JJ/HoEJjJ1uB0L23CFWRIoNTYjw4KEZizY8YTat+vuOMclWKi8
         FXrgkIbe92yeUaEwSyJD2cd58NqPRq3wmy+16qK7BOzaqmKzPry5DB1bInJDSgE23cmP
         qka5SOgCRw6IbWXnOYjFQPPamGfbzKqDZ6wgm7EFLz3vHY8fBII+aagtalvrR3vOiy7K
         vJb+zM9HqJgwrGwsX6VVGWYy5YQQnPThmRzZuCILwIV3w9sStDCZmavJ9i0Zy+Ym9h0C
         ACFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940864; x=1778545664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2hjkJ1In2ag1iLE+KuZ3epwvTGInKsCURDrkdhtZDM=;
        b=dz+dgZrwl9lStmISmxQfESqlVf1oXp+Elmr0cf8+U+VlIJJRDQIcJ7Gq/xURNqe7l3
         TGaCJWlHVe09nFbytLWhSQRr19gNakBqilKimqyrNvPd7t0rxZPyV1Z8SaEy93hlCbZf
         6JO/fLvGln7VKfPv5H1LK8EaCKgMZGS+lXIJQvQZOOp5EDf+ZsQTusTiv+F4R9JkIkFk
         mYos2ujrv/0huXI62h4bQLX+m4JQQRPxni1TBmki2TFgxhiXyA0PH1ySpO0UUp5QeO5h
         gGCtHldoWYD8xA4sBGIsrcvnU5yKyRtLBbk2QNNyPTh5qxf1QPZgLxRFdrf1pz6DOo/4
         rdxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tjF03O3uZlvjD6TetaYgUAWfLWCbc2BNn/j1m6JJeyDglydBdheZn955QKVyM8+5B2Faumw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyB0AbfBmgIy9rDc3pY0toyEjm4JmzYCMn4vygPTdMDOrRM9oyO
	pcT5XQU+JRWmr0vh/EcJYAfFXuuVnGuiTJfU8UcvfxjboieVJvM3z7Vn7Dz+r4tzYlZuO6wI/6X
	5dPRxZzYzy2qlFw==
X-Received: from pfde22.prod.google.com ([2002:aa7:8c56:0:b0:82f:4abd:a354])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4fcd:b0:838:af72:fb35 with SMTP id d2e1a72fcca58-83921ef6ff6mr943516b3a.10.1777940863669;
 Mon, 04 May 2026 17:27:43 -0700 (PDT)
Date: Tue,  5 May 2026 00:27:36 +0000
In-Reply-To: <20260505002737.2213734-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260505002737.2213734-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505002737.2213734-4-skhawaja@google.com>
Subject: [RFC PATCH 3/4] dma-direct: Add API to preserve/restore allocations
From: Samiullah Khawaja <skhawaja@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"

Add an API to preserve/restore the DMA direct allocation for liveupdate.
The underlying memory is preserved/restored using KHO. During restore
the memory is setup based on the device configuration, gfp flags and
allocation attributes. Once restored, the driver can use the usual
dma_free* API to deallocate the restored DMA allocation.

This API will be used to add support in dma_alloc* APIs to
preseve/restore the DMA allocations.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/dma-direct.h |  29 +++++++
 kernel/dma/Kconfig         |   3 +
 kernel/dma/direct.c        | 163 +++++++++++++++++++++++++++++++++++++
 3 files changed, 195 insertions(+)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index c249912456f9..0efe2bc1a815 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -141,6 +141,35 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
 u64 dma_direct_get_required_mask(struct device *dev);
 void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
+
+#ifdef CONFIG_DMA_LIVEUPDATE
+int dma_direct_preserve_allocation(struct device *dev, void *cpu_addr,
+				   size_t size, dma_addr_t dma_handle,
+				   unsigned long attrs, u64 *state);
+void dma_direct_unpreserve_allocation(struct device *dev, u64 state);
+void *dma_direct_restore_allocation(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t gfp,
+				    unsigned long attrs, u64 state);
+#else
+static inline int dma_direct_preserve_allocation(struct device *dev, void *cpu_addr,
+						 size_t size, dma_addr_t dma_handle,
+						 unsigned long attrs, u64 *state)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void dma_direct_unpreserve_allocation(struct device *dev, u64 state)
+{
+}
+
+static inline void *dma_direct_restore_allocation(struct device *dev, size_t size,
+						  dma_addr_t *dma_handle, gfp_t gfp,
+						  unsigned long attrs, u64 state)
+{
+	return NULL;
+}
+#endif
+
 void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
 		dma_addr_t dma_addr, unsigned long attrs);
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index bfef21b4a9ae..d92852942c6c 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -265,3 +265,6 @@ config DMA_MAP_BENCHMARK
 	  performance of dma_(un)map_page.
 
 	  See tools/testing/selftests/dma/dma_map_benchmark.c
+
+config DMA_LIVEUPDATE
+	bool "Enable preservation of DMA direct allocations"
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index ec887f443741..c2b98f91900a 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -6,6 +6,8 @@
  */
 #include <linux/memblock.h> /* for max_pfn */
 #include <linux/export.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/dma_alloc.h>
 #include <linux/mm.h>
 #include <linux/dma-map-ops.h>
 #include <linux/scatterlist.h>
@@ -307,6 +309,167 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	return NULL;
 }
 
+#ifdef CONFIG_DMA_LIVEUPDATE
+int dma_direct_preserve_allocation(struct device *dev, void *cpu_addr,
+				   size_t size, dma_addr_t dma_handle,
+				   unsigned long attrs, u64 *state)
+{
+	struct dma_alloc_ser *ser;
+	int ret;
+
+	if (!kho_is_enabled())
+		return -EOPNOTSUPP;
+
+	if (IS_ENABLED(CONFIG_DMA_CMA))
+		return -EOPNOTSUPP;
+
+	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
+	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
+		return -EOPNOTSUPP;
+
+	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) &&
+	    !dev_is_dma_coherent(dev) &&
+	    !is_swiotlb_for_alloc(dev))
+		return -EOPNOTSUPP;
+
+	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
+	    !dev_is_dma_coherent(dev))
+		return -EOPNOTSUPP;
+
+	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
+	    dma_is_from_pool(dev, cpu_addr, PAGE_ALIGN(size)))
+		return -EOPNOTSUPP;
+
+	ser = kho_alloc_preserve(sizeof(*ser));
+	if (IS_ERR(ser))
+		return PTR_ERR(ser);
+
+	ser->page_phys = dma_to_phys(dev, dma_handle);
+	ser->force_decrypted = force_dma_unencrypted(dev);
+	ser->size = size;
+
+	ret = kho_preserve_pages(phys_to_page(ser->page_phys),
+				 size >> PAGE_SHIFT);
+	if (ret) {
+		kho_unpreserve_free(ser);
+		return ret;
+	}
+
+	*state = virt_to_phys(ser);
+	return 0;
+}
+
+void dma_direct_unpreserve_allocation(struct device *dev, u64 state)
+{
+	struct dma_alloc_ser *ser;
+
+	if (!kho_is_enabled())
+		return;
+
+	ser = phys_to_virt(state);
+	kho_unpreserve_pages(phys_to_page(ser->page_phys),
+			     ser->size >> PAGE_SHIFT);
+	kho_unpreserve_free(ser);
+}
+
+void *dma_direct_restore_allocation(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t gfp,
+				    unsigned long attrs, u64 state)
+{
+	bool remap = false, set_uncached = false;
+	struct dma_alloc_ser *ser = NULL;
+	struct page *page;
+	void *cpu_addr;
+
+	if (!kho_is_enabled())
+		return NULL;
+
+	ser = phys_to_virt(state);
+	page = phys_to_page(ser->page_phys);
+
+	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
+	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
+		return NULL;
+
+	if (!dev_is_dma_coherent(dev)) {
+		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) &&
+		    !is_swiotlb_for_alloc(dev))
+			return NULL;
+
+		if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL))
+			return NULL;
+
+		set_uncached = IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED);
+		remap = IS_ENABLED(CONFIG_DMA_DIRECT_REMAP);
+		if (!set_uncached && !remap)
+			return NULL;
+	}
+
+	if (PageHighMem(page)) {
+		remap = true;
+		set_uncached = false;
+	}
+
+	/*
+	 * Remapping will be blocking so return error. The preserved memory
+	 * might be already decrypted in the previous kernel, but the decryption
+	 * call is not guaranteed to be non-blocking so return error always if
+	 * decryption is required.
+	 */
+	if ((remap || force_dma_unencrypted(dev)) &&
+	    dma_direct_use_pool(dev, gfp))
+		return NULL;
+
+	/*
+	 * Encryption scheme changed between two kernels and this might cause
+	 * issues if device/driver is not handling it properly.
+	 */
+	WARN_ON_ONCE(ser->force_decrypted != force_dma_unencrypted(dev));
+
+	/*
+	 * arch_dma_prep_coherent() should make sure that any cache lines from
+	 * the previous kernel, if the device was coherent previously or cached
+	 * mapping in this kernel during init are not problamatic for
+	 * non-coherent allocations.
+	 */
+	if (remap) {
+		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
+
+		if (force_dma_unencrypted(dev))
+			prot = pgprot_decrypted(prot);
+
+		arch_dma_prep_coherent(page, size);
+
+		cpu_addr = dma_common_contiguous_remap(page, size, prot,
+						       __builtin_return_address(0));
+		if (!cpu_addr)
+			return NULL;
+	} else {
+		cpu_addr = page_address(page);
+		if (dma_set_decrypted(dev, cpu_addr, size))
+			return NULL;
+	}
+
+	if (set_uncached) {
+		arch_dma_prep_coherent(page, size);
+		cpu_addr = arch_dma_set_uncached(cpu_addr, size);
+		if (IS_ERR(cpu_addr))
+			return NULL;
+	}
+
+	*dma_handle = phys_to_dma_direct(dev, ser->page_phys);
+
+	/*
+	 * Cannot free the restored pages on error here as these might be in use
+	 * by a device with direct allocation in the previous kernel.
+	 */
+	WARN_ON(!kho_restore_pages(ser->page_phys,
+				   ser->size >> PAGE_SHIFT));
+	kho_restore_free(ser);
+	return cpu_addr;
+}
+#endif
+
 void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
-- 
2.54.0.545.g6539524ca2-goog

