Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4B73AD507
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554541; cv=none; b=np4CCjfPO/IZNA6LZB3VCqT1oa9IgSPcVYGrUBJgptLsZKTNCWEsGshHQWMXkxYun+0/oqEGMEM92QmuLnd3evd1FdNbAsw8n1UTA5eRSMy9HC3hijv1EA77H+fF3Y6p4NR9IL52NgSN0Y3KEPYgGzYOMHjw3r1N/ch0w8R4bHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554541; c=relaxed/simple;
	bh=flV+QBf/yjrsblh7126q3g6Yp2R55A3g6V9+p+TNh5E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LnRtzErj1hYjwM58HPSzslM1rwgINoffjBA2I1HSXADX1W7cVq4DF9LDKt0EGW4s1tHeA44pE1yBwuqcS8KBaKK1mZr1PQbCSfFKbF9HI93jAQGfMOsWWiVJOlNoFsfU0cQBgtvLkWs/bj3Qz58ZuPCdfCR5pYKWcF9gkmprPvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jbLCn4Ve; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbLCn4Ve"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8484f26852dso745209b3a.1
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 16:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554539; x=1784159339; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jKjGm5vgqAcCxqxTVhSOTHzJTWIKM6FvnNwlshe3+A8=;
        b=jbLCn4VeZp8JNsq6BDNVDutqnhgduERITvvbdxd2nbR3msw45vmTf0nYphZp0wkrTS
         uuMwh7UKuVrdouSZX/Rl/tR/psQvI79dbimZpEHNglvMpSyk56xF7VqNSIAH8lg2AatR
         OP8YYLqbtihRIClp0h3B9pEykjtsn/b4pil7w+P3XImLoO90Hd73wMTXjBtSDD0fzet0
         AduZV1GQK20vAL/KFj3IBFiRTSlzbgArd90OEgrs0NpIO/y2MxwJkMUeFNpSCC6MAKyX
         CoIc7K5ADLW/lK2b3ouWcDNs+tdhPHfn89uGQrHDG17zRuPksHGbnuLNSM+Psy8EP/tL
         vJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554539; x=1784159339;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jKjGm5vgqAcCxqxTVhSOTHzJTWIKM6FvnNwlshe3+A8=;
        b=qtyOKTTW0ulU2rDQxRElMbL3obuSCWC7JWKo3KEFGhlubWYBuVO9Zn3xCAPR651gD6
         uPXYCjqW983pe7lLWuKFoiU2HPCWkkeByTn94KMng0KObO4FGwZQSMiCOkBw4yDc6MKW
         03uDZNlu88KAkRQ6ol+Ed1ekHEoq1ams8PPIG1mmzFsjUUW53fVui4lD5uWgkvm5SNxj
         qDl3ND+TiY2vsj8tk/OTpkS/Qb+bf1JlSDskywVL+1WF/CDEyKCPqJQNcJL5LkTOhm44
         plERy97JyKIx+ipkgKhs0cItE0FDgQ25x7jk/8hcpVw9K8KLFY5vok9lAaJYvQ1mBj8P
         VBbA==
X-Forwarded-Encrypted: i=1; AHgh+RqTg49MQ/ZKLK918pFmaTRtPCyC0nVDUxJ98PfdH6R35v3d19dBRqZXspcdwSv7ikiglFPXzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNJIPcVUMNIIJHV/1vrdfHMRQ0Gk+EyqvZ9oD8FgxXhW1FFjsE
	QS0NhilO0ZSHoH5GZZwwItNDW4ip8dh9k+9a+FXuTeFZg3G3gTVvgiTgEi0tXDTEbv2sX/eP/8D
	Fup8e6y2CDzipEw==
X-Received: from pfx25.prod.google.com ([2002:a05:6a00:a459:b0:847:878f:44f0])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4191:b0:845:d274:c021 with SMTP id d2e1a72fcca58-84843682779mr4464782b3a.58.1783554539065;
 Wed, 08 Jul 2026 16:48:59 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:49 +0000
In-Reply-To: <20260708234854.4044652-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260708234854.4044652-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-6-skhawaja@google.com>
Subject: [RFC PATCH v2 05/10] dma-direct: Add API to preserve/restore allocations
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
preserve/restore the DMA allocations.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/dma-direct.h |  29 ++++++
 kernel/dma/Kconfig         |   4 +
 kernel/dma/direct.c        | 189 +++++++++++++++++++++++++++++++++++++
 3 files changed, 222 insertions(+)

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
index bfef21b4a9ae..d93958931303 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -265,3 +265,7 @@ config DMA_MAP_BENCHMARK
 	  performance of dma_(un)map_page.
 
 	  See tools/testing/selftests/dma/dma_map_benchmark.c
+
+config DMA_LIVEUPDATE
+	bool "Enable preservation of DMA direct allocations"
+	depends on LIVEUPDATE
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index ec887f443741..117ebae8a81f 100644
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
@@ -307,6 +309,193 @@ void *dma_direct_alloc(struct device *dev, size_t size,
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
+	size = PAGE_ALIGN(size);
+	if (dma_is_from_cma(dma_to_phys(dev, dma_handle), size))
+		return -EOPNOTSUPP;
+
+	if (is_swiotlb_for_alloc(dev))
+		return -EOPNOTSUPP;
+
+	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
+	    !force_dma_unencrypted(dev))
+		return -EOPNOTSUPP;
+
+	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) &&
+	    !dev_is_dma_coherent(dev))
+		return -EOPNOTSUPP;
+
+	if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
+	    !dev_is_dma_coherent(dev))
+		return -EOPNOTSUPP;
+
+	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
+	    dma_is_from_pool(cpu_addr, size))
+		return -EOPNOTSUPP;
+
+	ser = kho_alloc_preserve(sizeof(*ser));
+	if (IS_ERR(ser))
+		return PTR_ERR(ser);
+
+	ser->page_phys = dma_to_phys(dev, dma_handle);
+	ser->force_decrypted = force_dma_unencrypted(dev);
+	ser->size = size;
+	ser->attrs = (attrs & ~DMA_ATTR_NO_WARN);
+
+	ret = kho_preserve_pages(phys_to_page(ser->page_phys),
+				 1 << get_order(size));
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
+			     1 << get_order(ser->size));
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
+	void *cpu_addr = NULL;
+	int i;
+
+	if (!kho_is_enabled())
+		return NULL;
+
+	ser = phys_to_virt(state);
+	page = phys_to_page(ser->page_phys);
+
+	size = PAGE_ALIGN(size);
+	if (size != ser->size)
+		return NULL;
+
+	WARN_ON_ONCE((attrs & ~DMA_ATTR_NO_WARN) != ser->attrs);
+
+	/*
+	 * Cannot free the restored pages on error here as these might be in use
+	 * by a device with direct allocation in the previous kernel.
+	 */
+	if (is_swiotlb_for_alloc(dev))
+		goto err;
+
+	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
+	    !force_dma_unencrypted(dev))
+		goto err;
+
+	if (!dev_is_dma_coherent(dev)) {
+		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC))
+			goto err;
+
+		if (IS_ENABLED(CONFIG_DMA_GLOBAL_POOL))
+			goto err;
+
+		set_uncached = IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED);
+		remap = IS_ENABLED(CONFIG_DMA_DIRECT_REMAP);
+		if (!set_uncached && !remap)
+			goto err;
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
+		goto err;
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
+	 * mapping in this kernel during init are not problematic for
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
+			goto err;
+	} else {
+		cpu_addr = page_address(page);
+		if (dma_set_decrypted(dev, cpu_addr, size)) {
+			cpu_addr = NULL;
+			goto err;
+		}
+	}
+
+	if (set_uncached) {
+		arch_dma_prep_coherent(page, size);
+		cpu_addr = arch_dma_set_uncached(cpu_addr, size);
+		if (IS_ERR(cpu_addr)) {
+			cpu_addr = NULL;
+			goto err;
+		}
+	}
+
+	*dma_handle = phys_to_dma_direct(dev, ser->page_phys);
+
+err:
+	WARN_ON(!kho_restore_pages(ser->page_phys,
+				   1 << get_order(ser->size)));
+	kho_restore_free(ser);
+
+	/*
+	 * DMA direct API expects high-order allocations, so set refcount of
+	 * tail pages to zero.
+	 */
+	for (i = (1 << get_order(size)) - 1; i > 0; --i)
+		set_page_count(page + i, 0);
+
+	return cpu_addr;
+}
+#endif
+
 void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
-- 
2.55.0.795.g602f6c329a-goog

