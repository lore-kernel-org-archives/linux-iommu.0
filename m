Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C98325F7B5
	for <iommu@lists.linux.dev>; Sun,  3 Aug 2025 11:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219013; cv=none; b=QcXG+b2sA9rsL0kbXqN3qE5DS0rOCHmizRxlWX2zdmPBgxjUUs/W089ld5VrC8D/R9yehYNgj8nh+67cMZ4Pn+Z1CdxQwTyOx5lQcray1GYDaFKMzYWB0KRSNbzlFg2iq5vBawtX+6veDLuNfbMhvmyUQClVfv3FNmAauO8z4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219013; c=relaxed/simple;
	bh=RMLqCDsmbfpj0n8AV9J2G+G3vA1if/GfqRWJccxq4as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=D97EY3RKMKhugQCDEFiMi6cr7lk6DnJWeXsYOx0PTLBO/+ZyBRn1jwAwXONeSL4QeVdDaxARUd50rGY5eOi3H41TespCl/16cjOBe1PfhLjhFpJ7qL/Ok1+yDlo/Wy78/qGWiUUV/Ap6xNDIKBR0JJN/exkFFgiY60Cf5rAgE3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com; spf=pass smtp.mailfrom=infinidat.com; dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b=L8mwIqEU; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinidat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b="L8mwIqEU"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70739d1f07bso36388936d6.2
        for <iommu@lists.linux.dev>; Sun, 03 Aug 2025 04:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infinidat.com; s=google; t=1754219010; x=1754823810; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fN3UYxrSmmlQlaGuv1XtZM4/LVwFOPJtQv+F30TpBtg=;
        b=L8mwIqEUPJffAOqJhqJm42t9NbxqVn631eSxscZ43tcE9/33lAuMchAKRfaK+PylF4
         chwG8OueZYC2U2vPmhHD2t6AOhxA9eaAytuSDO8bwKGbvat/c+VKg4GcktvG0/9e+M6M
         l1EfcR4SM7VqQ54qwFQEBONXOMJFTzp4lp0s7RclzyR687h2R/T1PiAAiFiDuurWcV54
         kzFg9Ya8bmXga56ztPPDcp7uSpqkmlUAphIOZ7uBOiUFZb0RNNvw7l+gtuQQlb8/wBLm
         xVywdSy2ZFaDtAO1D7iW/zjpfCD64yChtbtYwk5i8suj8pYb82v9kzMmbmAqinAeTuAE
         nnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754219010; x=1754823810;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fN3UYxrSmmlQlaGuv1XtZM4/LVwFOPJtQv+F30TpBtg=;
        b=OTmOpwuj11ESGK0ltUfNp+uWmVSAjNNMv9LA/nfW1ZO5GS65jpjo0wERr+FrKZP9ol
         fAo2SnfdfXSK2P0XBfN5mB0TOyH4Dhfhhsj/y+rWeYDqwCdVO5LT9D4oK5LPyDK+w3hH
         wk+xc0shZhmff4tX8ELxE2LW+2FV+bRamzYtAL21DzMLe7LsFlbXBHuGutUNMMjOugZc
         r508U95PDZfZGW2JpuXmDkgRuuPFxA8ZUv5++f3Rn+Zi7ls8fnvIYHQmqKewM77uCT8d
         XMKYRgQk9hSgdYdojUjin9l4DLOLDLb42ry8MLNoXg+sLBpFQtIPC5xLT39k54Zwv6ys
         XlTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiW6gCGvrvWJDxQ0z3iRxH8DOTacL902u7IuB4IBdQpDaweNKlAOM8E0K3BhQx29q/0ereUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwS3jZAJTf4V7SK5o8ZTx/0IY/lyU+dpsk12GnmsBqkkA2jJX7A
	Ypo2UU/9Nme0csgjy5yGcbME6sWjgOJ0BC6CZg+MeTUDpowFL1mA8zSBRR7d3PAOez2Ou9G9mFk
	cv2KnMgQPjEBQJOdU/5Wv2HiBo9Ibibui4rUrR3Ixu0+W0MPkuHSzPdM=
X-Gm-Gg: ASbGncvrk+h3k1w8YFs4g+kNvYZOfGmfOmRUPmH56WJQcmuGAgeptpcU55mtzWBp5hU
	w7p5llT8oem+AsPKxx6StAGWzasyy62YMKwy0+mFT+fUg4+rGN6Yps5EaqjSsikTh3EZTJDyygi
	13mcLAO67u3Al5zz3OyoFvGYVITfxB2yTEscpYKHLXtigHUsQ1hkG+Cul96bjGVg0OYPOnVwiVJ
	aVYsgEeyQ==
X-Google-Smtp-Source: AGHT+IHKbaBoFiJcbKDxw+anBJB/nZcJWYQmS/8KYCzQ/qL9waRqnZ5fwOAPOg1abHNrz/QowM316R4hEqZhChAcC5g=
X-Received: by 2002:a05:6214:246a:b0:707:4daf:641 with SMTP id
 6a1803df08f44-7093673f190mr92236646d6.39.1754219009995; Sun, 03 Aug 2025
 04:03:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEHaoC2BWe+0Ps2oU-0xPDLFYYKG-o9+_ynFgh7u3qqyRDtrTg@mail.gmail.com>
 <CAEHaoC22NDpHUWovJChCx_XqchkEvUPYrFFe_L1PH9Mw2e386A@mail.gmail.com>
In-Reply-To: <CAEHaoC22NDpHUWovJChCx_XqchkEvUPYrFFe_L1PH9Mw2e386A@mail.gmail.com>
From: Constantine Gavrilov <cgavrilov@infinidat.com>
Date: Sun, 3 Aug 2025 14:03:19 +0300
X-Gm-Features: Ac12FXz4zwmcoFZD7aMeWXJRW8vpbph7LPHRQVVC4pqN84_Frit7RWuO1GMh8-Y
Message-ID: <CAEHaoC2bi3VUEuoWKgHbgUFfdxmACrhkjaQ9Jni-4-ByP5tYJg@mail.gmail.com>
Subject: [PATCH 1/8] Large DMA alloc/skip 32-bit alloc if size > 32-bit
To: linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This is the second patch from the set of patches that enable large IOMMU
DMA registrations. Entire work is available at the master branch of the
master branch of git@github.com:cgavrilov/linux.git repo.

Current implementation aligns DMA allocations to size, which fragments address
space in the case of large allocations. Introduce alignment parameter (size,
PMD, PUD or NONE). This change does not change the existing behavior but
facilitates the next change.

commit 3b1aa27401cb020455854ba6c5343ec618c63067
Author: Constantine Gavrilov <cgavrilov@infinidat.com>
Date:   Sun Jun 22 13:13:47 2025 +0300

    Large IOMMU registrations: extend alloc_iova() and
alloc_iova_fast() to use aligment parameter.

    This patch does not change existing behavior, it just extends the API.

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 4596073fe28f..bf525d59e82e 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1046,7 +1046,7 @@ void *tegra_drm_alloc(struct tegra_drm *tegra,
size_t size, dma_addr_t *dma)

     alloc = alloc_iova(&tegra->carveout.domain,
                size >> tegra->carveout.shift,
-               tegra->carveout.limit, true);
+               tegra->carveout.limit, ALLOC_IOVA_ALIGN_SIZE);
     if (!alloc) {
         err = -EBUSY;
         goto free_pages;
diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
index ba2e572567c0..fbd647fc031c 100644
--- a/drivers/gpu/host1x/cdma.c
+++ b/drivers/gpu/host1x/cdma.c
@@ -97,7 +97,7 @@ static int host1x_pushbuffer_init(struct push_buffer *pb)

         shift = iova_shift(&host1x->iova);
         alloc = alloc_iova(&host1x->iova, size >> shift,
-                   host1x->iova_end >> shift, true);
+                   host1x->iova_end >> shift, ALLOC_IOVA_ALIGN_SIZE);
         if (!alloc) {
             err = -ENOMEM;
             goto iommu_free_mem;
diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index 3ed49e1fd933..ff5325d21fe8 100644
--- a/drivers/gpu/host1x/job.c
+++ b/drivers/gpu/host1x/job.c
@@ -242,7 +242,7 @@ static unsigned int pin_job(struct host1x *host,
struct host1x_job *job)

             shift = iova_shift(&host->iova);
             alloc = alloc_iova(&host->iova, gather_size >> shift,
-                       host->iova_end >> shift, true);
+                       host->iova_end >> shift, ALLOC_IOVA_ALIGN_SIZE);
             if (!alloc) {
                 err = -ENOMEM;
                 goto put;
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 8280e8864ef3..ef5fa3587c3b 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -774,7 +774,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct
iommu_domain *domain,
      */
     if (dma_limit > DMA_BIT_MASK(32) && (size - 1) <=
DMA_BIT_MASK(32) && dev->iommu->pci_32bit_workaround) {
         iova = alloc_iova_fast(iovad, iova_len,
-                       DMA_BIT_MASK(32) >> shift, false);
+                       DMA_BIT_MASK(32) >> shift, false,
ALLOC_IOVA_ALIGN_SIZE);
         if (iova)
             goto done;

@@ -782,7 +782,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct
iommu_domain *domain,
         dev_notice(dev, "Using %d-bit DMA addresses\n", bits_per(dma_limit));
     }

-    iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift, true);
+    iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift, true,
ALLOC_IOVA_ALIGN_SIZE);
 done:
     return (dma_addr_t)iova << shift;
 }
@@ -1798,7 +1798,7 @@ bool dma_iova_try_alloc(struct device *dev,
struct dma_iova_state *state,

     addr = iommu_dma_alloc_iova(domain,
             iova_align(iovad, size + iova_off),
-            dma_get_mask(dev), dev);
+            dma_get_mask(dev), dev, ALLOC_IOVA_ALIGN_SIZE);
     if (!addr)
         return false;

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 18f839721813..41d5d34fcc33 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -163,17 +163,22 @@ iova_insert_rbtree(struct rb_root *root, struct
iova *iova,

 static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
         unsigned long size, unsigned long limit_pfn,
-            struct iova *new, bool size_aligned)
+            struct iova *new, iova_align_t align)
 {
     struct rb_node *curr, *prev;
     struct iova *curr_iova;
     unsigned long flags;
     unsigned long new_pfn, retry_pfn;
-    unsigned long align_mask = ~0UL;
+    unsigned long align_mask;
     unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;

-    if (size_aligned)
-        align_mask <<= fls_long(size - 1);
+    switch (align) {
+        case ALLOC_IOVA_ALIGN_NONE: align_mask = ~0UL; break;
+        case ALLOC_IOVA_ALIGN_SIZE: align_mask = (~0UL) <<
fls_long(size - 1); break;
+        case ALLOC_IOVA_ALIGN_PMD: align_mask = (~0UL) <<  (PMD_SHIFT
- iova_shift(iovad)); break;
+        case ALLOC_IOVA_ALIGN_PUD: align_mask = (~0UL) <<  (PUD_SHIFT
- iova_shift(iovad)); break;
+        default: return -EINVAL;
+    }

     /* Walk the tree backwards */
     spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
@@ -206,7 +211,7 @@ static int __alloc_and_insert_iova_range(struct
iova_domain *iovad,
         goto iova32_full;
     }

-    /* pfn_lo will point to size aligned address if size_aligned is set */
+    /* pfn_lo will point to size aligned address if align is not
ALLOC_IOVA_ALIGN_NONE */
     new->pfn_lo = new_pfn;
     new->pfn_hi = new->pfn_lo + size - 1;

@@ -242,16 +247,19 @@ static void free_iova_mem(struct iova *iova)
  * @iovad: - iova domain in question
  * @size: - size of page frames to allocate
  * @limit_pfn: - max limit address
- * @size_aligned: - set if size_aligned address range is required
+ * @align: - alignment
  * This function allocates an iova in the range iovad->start_pfn to limit_pfn,
- * searching top-down from limit_pfn to iovad->start_pfn. If the size_aligned
- * flag is set then the allocated address iova->pfn_lo will be naturally
- * aligned on roundup_power_of_two(size).
+ * searching top-down from limit_pfn to iovad->start_pfn.
+ * If align is not set to ALLOC_IOVA_ALIGN_NONE, then the allocated address
+ * iova->pfn_lo will be naturally aligned as follows:
+ *  roundup_power_of_two(size) for align == ALLOC_IOVA_ALIGN_SIZE
+ *  1UL << PMD_SHIFT for align == ALLOC_IOVA_ALIGN_PMD
+ *  1UL << PUD_SHIFT for align == ALLOC_IOVA_ALIGN_PUD
  */
 struct iova *
 alloc_iova(struct iova_domain *iovad, unsigned long size,
     unsigned long limit_pfn,
-    bool size_aligned)
+    iova_align_t align)
 {
     struct iova *new_iova;
     int ret;
@@ -261,7 +269,7 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
         return NULL;

     ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn + 1,
-            new_iova, size_aligned);
+            new_iova, align);

     if (ret) {
         free_iova_mem(new_iova);
@@ -369,13 +377,14 @@ EXPORT_SYMBOL_GPL(free_iova);
  * @size: - size of page frames to allocate
  * @limit_pfn: - max limit address
  * @flush_rcache: - set to flush rcache on regular allocation failure
+ * @align: - alignment constraint on DMA address
  * This function tries to satisfy an iova allocation from the rcache,
  * and falls back to regular allocation on failure. If regular allocation
  * fails too and the flush_rcache flag is set then the rcache will be flushed.
 */
 unsigned long
 alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
-        unsigned long limit_pfn, bool flush_rcache)
+        unsigned long limit_pfn, bool flush_rcache, iova_align_t align)
 {
     unsigned long iova_pfn;
     struct iova *new_iova;
@@ -394,7 +403,7 @@ alloc_iova_fast(struct iova_domain *iovad,
unsigned long size,
         return iova_pfn;

 retry:
-    new_iova = alloc_iova(iovad, size, limit_pfn, true);
+    new_iova = alloc_iova(iovad, size, limit_pfn, align);
     if (!new_iova) {
         unsigned int cpu;

diff --git a/drivers/media/pci/intel/ipu6/ipu6-dma.c
b/drivers/media/pci/intel/ipu6/ipu6-dma.c
index 7296373d36b0..4e2b98c4f348 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-dma.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-dma.c
@@ -172,7 +172,7 @@ void *ipu6_dma_alloc(struct ipu6_bus_device *sys,
size_t size,
     count = PHYS_PFN(size);

     iova = alloc_iova(&mmu->dmap->iovad, count,
-              PHYS_PFN(mmu->dmap->mmu_info->aperture_end), 0);
+              PHYS_PFN(mmu->dmap->mmu_info->aperture_end),
ALLOC_IOVA_ALIGN_NONE);
     if (!iova)
         goto out_kfree;

@@ -398,7 +398,7 @@ int ipu6_dma_map_sg(struct ipu6_bus_device *sys,
struct scatterlist *sglist,
         nents, npages);

     iova = alloc_iova(&mmu->dmap->iovad, npages,
-              PHYS_PFN(mmu->dmap->mmu_info->aperture_end), 0);
+              PHYS_PFN(mmu->dmap->mmu_info->aperture_end),
ALLOC_IOVA_ALIGN_NONE);
     if (!iova)
         return 0;

diff --git a/drivers/media/pci/intel/ipu6/ipu6-mmu.c
b/drivers/media/pci/intel/ipu6/ipu6-mmu.c
index 6d1c0b90169d..4d6f9b8d68bb 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-mmu.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-mmu.c
@@ -422,7 +422,7 @@ static int allocate_trash_buffer(struct ipu6_mmu *mmu)

     /* Allocate 8MB in iova range */
     iova = alloc_iova(&mmu->dmap->iovad, n_pages,
-              PHYS_PFN(mmu->dmap->mmu_info->aperture_end), 0);
+              PHYS_PFN(mmu->dmap->mmu_info->aperture_end),
ALLOC_IOVA_ALIGN_NONE);
     if (!iova) {
         dev_err(mmu->dev, "cannot allocate iova range for trash\n");
         return -ENOMEM;
diff --git a/drivers/media/platform/nvidia/tegra-vde/iommu.c
b/drivers/media/platform/nvidia/tegra-vde/iommu.c
index b1d9d841d944..ad010ad65735 100644
--- a/drivers/media/platform/nvidia/tegra-vde/iommu.c
+++ b/drivers/media/platform/nvidia/tegra-vde/iommu.c
@@ -30,7 +30,7 @@ int tegra_vde_iommu_map(struct tegra_vde *vde,
     size = iova_align(&vde->iova, size);
     shift = iova_shift(&vde->iova);

-    iova = alloc_iova(&vde->iova, size >> shift, end >> shift, true);
+    iova = alloc_iova(&vde->iova, size >> shift, end >> shift,
ALLOC_IOVA_ALIGN_SIZE);
     if (!iova)
         return -ENOMEM;

diff --git a/drivers/staging/media/ipu3/ipu3-dmamap.c
b/drivers/staging/media/ipu3/ipu3-dmamap.c
index 8a19b0024152..330314a3aa94 100644
--- a/drivers/staging/media/ipu3/ipu3-dmamap.c
+++ b/drivers/staging/media/ipu3/ipu3-dmamap.c
@@ -105,7 +105,7 @@ void *imgu_dmamap_alloc(struct imgu_device *imgu,
struct imgu_css_map *map,
     dev_dbg(dev, "%s: allocating %zu\n", __func__, size);

     iova = alloc_iova(&imgu->iova_domain, size >> shift,
-              imgu->mmu->aperture_end >> shift, 0);
+              imgu->mmu->aperture_end >> shift, ALLOC_IOVA_ALIGN_NONE);
     if (!iova)
         return NULL;

@@ -205,7 +205,7 @@ int imgu_dmamap_map_sg(struct imgu_device *imgu,
struct scatterlist *sglist,
         nents, size >> shift);

     iova = alloc_iova(&imgu->iova_domain, size >> shift,
-              imgu->mmu->aperture_end >> shift, 0);
+              imgu->mmu->aperture_end >> shift, ALLOC_IOVA_ALIGN_NONE);
     if (!iova)
         return -ENOMEM;

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c
b/drivers/vdpa/vdpa_user/iova_domain.c
index 58116f89d8da..96ce209762f9 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -362,7 +362,7 @@ vduse_domain_alloc_iova(struct iova_domain *iovad,
     unsigned long iova_len = iova_align(iovad, size) >> shift;
     unsigned long iova_pfn;

-    iova_pfn = alloc_iova_fast(iovad, iova_len, limit >> shift, true);
+    iova_pfn = alloc_iova_fast(iovad, iova_len, limit >> shift, true,
ALLOC_IOVA_ALIGN_SIZE);

     return (dma_addr_t)iova_pfn << shift;
 }
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 55c03e5fe8cb..5cb8e6e49138 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -82,6 +82,15 @@ struct dma_iova_state {
  */
 #define DMA_IOVA_USE_SWIOTLB        (1ULL << 63)

+typedef enum {
+    ALLOC_IOVA_ALIGN_NONE,
+    ALLOC_IOVA_ALIGN_SIZE,
+    ALLOC_IOVA_ALIGN_PMD,
+    ALLOC_IOVA_ALIGN_PUD,
+    ALLOC_IOVA_ALIGN_INV,
+} iova_align_t;
+
+
 static inline size_t dma_iova_size(struct dma_iova_state *state)
 {
     /* Casting is needed for 32-bits systems */
diff --git a/include/linux/iova.h b/include/linux/iova.h
index d2c4fd923efa..e35762c0acdb 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -90,11 +90,11 @@ void free_iova(struct iova_domain *iovad, unsigned
long pfn);
 void __free_iova(struct iova_domain *iovad, struct iova *iova);
 struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
     unsigned long limit_pfn,
-    bool size_aligned);
+    iova_align_t align);
 void free_iova_fast(struct iova_domain *iovad, unsigned long pfn,
             unsigned long size);
 unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
-                  unsigned long limit_pfn, bool flush_rcache);
+                  unsigned long limit_pfn, bool flush_rcache,
iova_align_t align);
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
     unsigned long pfn_hi);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
@@ -123,7 +123,7 @@ static inline void __free_iova(struct iova_domain
*iovad, struct iova *iova)
 static inline struct iova *alloc_iova(struct iova_domain *iovad,
                       unsigned long size,
                       unsigned long limit_pfn,
-                      bool size_aligned)
+                      iova_align_t align)
 {
     return NULL;
 }
@@ -137,7 +137,7 @@ static inline void free_iova_fast(struct iova_domain *iovad,
 static inline unsigned long alloc_iova_fast(struct iova_domain *iovad,
                         unsigned long size,
                         unsigned long limit_pfn,
-                        bool flush_rcache)
+                        bool flush_rcache, iova_align_t align)
 {
     return 0;
 }

-- 
----------------------------------------
Constantine Gavrilov
System Architect and Platform Engineer
Infinidat
----------------------------------------
