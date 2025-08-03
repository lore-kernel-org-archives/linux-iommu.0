Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCE91E8836
	for <iommu@lists.linux.dev>; Sun,  3 Aug 2025 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219100; cv=none; b=pCiF6fcCvx8EsOCYBPn32KGZ68kWNdZORDSrc2ZPoTSlGxCybUaHVGmdQjpiacTuM+vWB3rrlnPLvth5/k022GVqpsGMei0rEWPSYBvbimkiTHOpMaihg6n1sTSeDjwkDzk+NmLJh0NJ9WpFDbWFU16cvcVxjfYalDf4DFidaag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219100; c=relaxed/simple;
	bh=kVdY1HKYYm+Dn46+YDQ18n9jnei0ksAtkvUxLy+oVAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hfcZeX3S4OI7i0X62tXrBGppiccRjFfOKbCzDMhwyVb4sCtqkMVK4P1j8lK4NFPBa4dr9L+5dznoJcrVp8wDcLw6fE+kQdome1Vgl93ewDQlQE2TgTRI2wPKzkGciIg35qRWKzfxpJ+OVzQQg9/H4ZkzWW0CuGcno0qL/HtYsn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com; spf=pass smtp.mailfrom=infinidat.com; dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b=kw0imKcQ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinidat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b="kw0imKcQ"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e7f940a386so13862385a.3
        for <iommu@lists.linux.dev>; Sun, 03 Aug 2025 04:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infinidat.com; s=google; t=1754219097; x=1754823897; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wkZHsOWyNosdIh15VRAdfFxTcRUEv7g04p4+IwGuig8=;
        b=kw0imKcQFNd3rveIPP3IIkJ8Y1xIhb4LAVGf5oWGh5j/OGhEh6+K71xz9g/PdtotB/
         whvtjUYfL0zX/3cYXMW2jid9XYjqE9Jjpmkx4n/tD2g6eDAXGLYCa5xgYBlSqzRXX6i0
         TzgpQLAG9zw8bcTL13p1Onygj7d6O19K+heOsXxpPay5LMqPq1l91jmk/iIqsJ9IDJnP
         Dz9BQKZIzjaPRmG6DSBdTYDd2vnXt2fYCkAq/NMzh2ERprsB2V5xm7X+ff6dygp9mT4I
         BM4lw5iMvCczD8Uw/szrawcfK0JPeRNb4NH8khGKCRfz25AcEUWYBevt5kLZgmSOMhR/
         65lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754219097; x=1754823897;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkZHsOWyNosdIh15VRAdfFxTcRUEv7g04p4+IwGuig8=;
        b=AIeFH/E96RucDcYwi1ODr1KQSf8v9GybRRnzgKVzuJCdyw0lnODHRiPE9oWDEKR3Jw
         uuzCiq1rn97+senqHd1mxdJy29e/XyNM6Tzj3ZQLeg0EKJbBhS8LleD21RrxcO71QFpA
         AVpoW8sXoevKiVpCq5JGG2u94g3C2yDQNl5zkdFfj1EzedaZYERz24AA0fQrNbizdnoN
         Kfwk+Ed1FQ1h7GDIqD7/Bm/+uqk+ZvsO7B8GRGoVMcblBHRP11BFdrEAu/M4R9zGaEST
         o9CCaxKI6N7+YWBW+9D1L87bVkmi2OMFvzPEam6Is96J9d891Wgwv00fKV0Ve0jWVSum
         ddQg==
X-Forwarded-Encrypted: i=1; AJvYcCXHUvhXouiXOMO4cuqTNvAqEWrzNPfF9IRdXSK/DLYf6rS0tOqGJPnN5q4kLubQUUhBy7We9A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx04uidYyU0JOMsZtQYWoO7UDH4iRrWTFlA6ECWuaGTLt/L9Fo/
	NzUHm5QqOJcfw9oGgSLH79YD3+R7VMm0lF1iXpuGIoTJnlmPyozZ41OhPvN4G1j9XEnGtH+SJ4f
	7B1i/8B8kiOmMM96LMue73H+1ebA2m3uY8KcwopiNVw==
X-Gm-Gg: ASbGncu8+64JrPnRLSVdG3lshnf4VqgW8pHJ8YFq6N8q3C7tGbzW/N5fAvitDitzJvA
	gtarLatW7PRqww++MgrEnmxXkyweZhtRYGDXRKZtI4uHVKa0yDwvzv9t8Bulj20dIT6lCbyE3PY
	cx/8ixpIHNoSNwvXedrl4ImLfYsesiIwNT3ptMXZ+3094E8J5KpJMfygrYtGCF4cFP6bavFuQIZ
	lmKT1f6jw==
X-Google-Smtp-Source: AGHT+IGjiDOAPsLb0UBCHkOalulOvH+ec71dmZiA61PQJVDyhiE3uWNYltZ4U4Ma5ViOBFssHpA9u1T4Xlpdfl8SzQY=
X-Received: by 2002:ad4:5ccd:0:b0:706:ff7e:5a36 with SMTP id
 6a1803df08f44-70935f67977mr77604926d6.14.1754219096900; Sun, 03 Aug 2025
 04:04:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEHaoC2BWe+0Ps2oU-0xPDLFYYKG-o9+_ynFgh7u3qqyRDtrTg@mail.gmail.com>
 <CAEHaoC22NDpHUWovJChCx_XqchkEvUPYrFFe_L1PH9Mw2e386A@mail.gmail.com> <CAEHaoC2bi3VUEuoWKgHbgUFfdxmACrhkjaQ9Jni-4-ByP5tYJg@mail.gmail.com>
In-Reply-To: <CAEHaoC2bi3VUEuoWKgHbgUFfdxmACrhkjaQ9Jni-4-ByP5tYJg@mail.gmail.com>
From: Constantine Gavrilov <cgavrilov@infinidat.com>
Date: Sun, 3 Aug 2025 14:04:45 +0300
X-Gm-Features: Ac12FXyO7mIBzrbpfpa81FGEqFE3f0DrGGMIZXBdcJcsKeXgrWEqNJCdywa-NOo
Message-ID: <CAEHaoC3ZMvHe7D-JX9bfM9hfSPs0QV-og=om5eKFFqSL=tpjcw@mail.gmail.com>
Subject: Re: [PATCH 2/8] Large DMA alloc/skip 32-bit alloc if size > 32-bit
To: linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This is the third patch from the set of patches that enable large IOMMU
DMA registrations. Entire work is available at the master branch of the
master branch of git@github.com:cgavrilov/linux.git repo.

Current implementation aligns DMA allocations to size, which fragments address
space in the case of large allocations. Extend the use of previously added
alignment parameter to additional kernel functions. Do not request specific
alignment in some functions that allocate large DMA areas.


commit 8a758550f6b39392a9cad627f323f8649621e6e2
Author: Constantine Gavrilov <cgavrilov@infinidat.com>
Date:   Sun Jun 22 15:44:52 2025 +0300

    Large IOMMU registrations: do not align IOMMU allocations to map
size by default.

    Implemented as follows:
    * extend iommu_dma_alloc_iova() function to use alignment parameter
    * extend __iommu_dma_map() function to use alignment parameter
    * extend dma_iova_try_alloc() function to use alignment parameter
    * add DMA_ATTR_IOVA_ALIGN_{PMD, PUD, SIZE} DMA mapping attributes

    The followings static functions will not request DMA address alignment,
    unless one of the  DMA_ATTR_IOVA_ALIGN_{PMD, PUD, SIZE} DMA mapping
    attributes is used. The previous behavior was to request mapping size
    alignment:
    * __iommu_dma_alloc_noncontiguous()
    * iommu_dma_alloc_remap()
    * __dma_map_sg_attrs() - calls iommu_dma_map_sg() that changes behavior

    The following kernel functions will not request DMA address alignment
    when calling  dma_iova_try_alloc() function:
    * register_dma_pages() from mlx5 VFIO driver
    * hmm_dma_map_alloc()
    * blk_rq_dma_map_iter_start()

    The following public APIs will not request DMA address alignment, unless
    one of the  DMA_ATTR_IOVA_ALIGN_{PMD, PUD, SIZE} DMA mapping flags is
    used. The previous behavior was to request mapping size
    alignment:
    * iommu_dma_map_page() - calls __iommu_dma_map()
    * iommu_dma_map_resource() - calls __iommu_dma_map()
    * iommu_dma_alloc() - calls __iommu_dma_map()
    * iommu_dma_alloc_noncontiguous() - calls iommu_dma_alloc_remap() or
      __iommu_dma_alloc_noncontiguous()
    * iommu_dma_map_sg() - calls iommu_dma_alloc_iova()
    * iommu_dma_map_sg() - software IOTLB case - calls
iommu_dma_map_sg_swiotlb()
      that calls iommu_dma_map_page()
    * dma_map_sg_attrs() - calls __dma_map_sg_attrs()
    * dma_map_sgtable() - calls __dma_map_sg_attrs()
    * dma_map_page_attrs() - calls iommu_dma_map_page()
    * dma_common_alloc_pages() - calls iommu_dma_map_page()
    * dma_map_resource() - calls iommu_dma_map_resource()
    * dma_alloc_attrs() - calls iommu_dma_alloc()
    * dma_alloc_noncontiguous() - calls iommu_dma_alloc_noncontiguous()

diff --git a/Documentation/core-api/dma-api.rst
b/Documentation/core-api/dma-api.rst
index 2ad08517e626..b9d3f290b6fe 100644
--- a/Documentation/core-api/dma-api.rst
+++ b/Documentation/core-api/dma-api.rst
@@ -541,7 +541,7 @@ matter.  All the considerations from the previous
section apply here as well.
 ::

     bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
-        phys_addr_t phys, size_t size);
+        phys_addr_t phys, size_t size, iova_align_t align);

 Is used to try to allocate IOVA space for mapping operation.  If it returns
 false this API can't be used for the given device and the normal streaming
diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index ad283017caef..a9ef7fab2790 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -184,7 +184,7 @@ bool blk_rq_dma_map_iter_start(struct request
*req, struct device *dma_dev,
     }

     if (blk_can_dma_map_iova(req, dma_dev) &&
-        dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len))
+        dma_iova_try_alloc(dma_dev, state, vec.paddr, total_len,
ALLOC_IOVA_ALIGN_NONE))
         return blk_rq_dma_map_iova(req, dma_dev, state, iter, &vec);
     return blk_dma_map_direct(req, dma_dev, iter, &vec);
 }
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ef5fa3587c3b..0b7537e9812f 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -741,8 +741,28 @@ static int dma_info_to_prot(enum
dma_data_direction dir, bool coherent,
     }
 }

+static iova_align_t dma_info_to_alignment(unsigned long attrs)
+{
+    iova_align_t align = ALLOC_IOVA_ALIGN_NONE;
+
+    if (attrs & DMA_ATTR_IOVA_ALIGN_PMD) {
+        if (attrs & (DMA_ATTR_IOVA_ALIGN_PUD | DMA_ATTR_IOVA_ALIGN_SIZE))
+            return ALLOC_IOVA_ALIGN_INV;
+        return ALLOC_IOVA_ALIGN_PMD;
+    } else if (attrs & DMA_ATTR_IOVA_ALIGN_PUD) {
+        if (attrs & (DMA_ATTR_IOVA_ALIGN_PMD | DMA_ATTR_IOVA_ALIGN_SIZE))
+            return ALLOC_IOVA_ALIGN_INV;
+        return ALLOC_IOVA_ALIGN_PUD;
+    } else if (attrs & DMA_ATTR_IOVA_ALIGN_SIZE) {
+        if (attrs & (DMA_ATTR_IOVA_ALIGN_PMD | DMA_ATTR_IOVA_ALIGN_PUD))
+            return ALLOC_IOVA_ALIGN_INV;
+        return ALLOC_IOVA_ALIGN_SIZE;
+    }
+    return align;
+}
+
 static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
-        size_t size, u64 dma_limit, struct device *dev)
+        size_t size, u64 dma_limit, struct device *dev, iova_align_t align)
 {
     struct iommu_dma_cookie *cookie = domain->iova_cookie;
     struct iova_domain *iovad = &cookie->iovad;
@@ -774,7 +794,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct
iommu_domain *domain,
      */
     if (dma_limit > DMA_BIT_MASK(32) && (size - 1) <=
DMA_BIT_MASK(32) && dev->iommu->pci_32bit_workaround) {
         iova = alloc_iova_fast(iovad, iova_len,
-                       DMA_BIT_MASK(32) >> shift, false,
ALLOC_IOVA_ALIGN_SIZE);
+                       DMA_BIT_MASK(32) >> shift, false, align);
         if (iova)
             goto done;

@@ -782,7 +802,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct
iommu_domain *domain,
         dev_notice(dev, "Using %d-bit DMA addresses\n", bits_per(dma_limit));
     }

-    iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift, true,
ALLOC_IOVA_ALIGN_SIZE);
+    iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift, true, align);
 done:
     return (dma_addr_t)iova << shift;
 }
@@ -828,7 +848,7 @@ static void __iommu_dma_unmap(struct device *dev,
dma_addr_t dma_addr,
 }

 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
-        size_t size, int prot, u64 dma_mask)
+        size_t size, int prot, u64 dma_mask, iova_align_t align)
 {
     struct iommu_domain *domain = iommu_get_dma_domain(dev);
     struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -847,7 +867,7 @@ static dma_addr_t __iommu_dma_map(struct device
*dev, phys_addr_t phys,

     size = iova_align(iovad, size + iova_off);

-    iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev);
+    iova = iommu_dma_alloc_iova(domain, size, dma_mask, dev, align);
     if (!iova)
         return DMA_MAPPING_ERROR;

@@ -933,6 +953,12 @@ static struct page
**__iommu_dma_alloc_noncontiguous(struct device *dev,
     struct page **pages;
     dma_addr_t iova;
     ssize_t ret;
+    iova_align_t align = dma_info_to_alignment(attrs);
+
+    if (align == ALLOC_IOVA_ALIGN_INV) {
+        dev_warn_once(dev, "%s: invalid alignment requested\n", __func__);
+        return NULL;
+    }

     if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
         iommu_deferred_attach(dev, domain))
@@ -955,7 +981,7 @@ static struct page
**__iommu_dma_alloc_noncontiguous(struct device *dev,
         return NULL;

     size = iova_align(iovad, size);
-    iova = iommu_dma_alloc_iova(domain, size, dev->coherent_dma_mask, dev);
+    iova = iommu_dma_alloc_iova(domain, size, dev->coherent_dma_mask,
dev, align);
     if (!iova)
         goto out_free_pages;

@@ -1201,7 +1227,12 @@ dma_addr_t iommu_dma_map_page(struct device
*dev, struct page *page,
     struct iommu_dma_cookie *cookie = domain->iova_cookie;
     struct iova_domain *iovad = &cookie->iovad;
     dma_addr_t iova, dma_mask = dma_get_mask(dev);
+    iova_align_t align = dma_info_to_alignment(attrs);

+    if (align == ALLOC_IOVA_ALIGN_INV) {
+        dev_warn_once(dev, "%s: invalid alignment requested\n", __func__);
+        return DMA_MAPPING_ERROR;
+    }
     /*
      * If both the physical buffer start address and size are page aligned,
      * we don't need to use a bounce page.
@@ -1216,7 +1247,7 @@ dma_addr_t iommu_dma_map_page(struct device
*dev, struct page *page,
     if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
         arch_sync_dma_for_device(phys, size, dir);

-    iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
+    iova = __iommu_dma_map(dev, phys, size, prot, dma_mask, align);
     if (iova == DMA_MAPPING_ERROR)
         swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
     return iova;
@@ -1389,6 +1420,12 @@ int iommu_dma_map_sg(struct device *dev, struct
scatterlist *sg, int nents,
     unsigned long mask = dma_get_seg_boundary(dev);
     ssize_t ret;
     int i;
+    iova_align_t align = dma_info_to_alignment(attrs);
+
+    if (align == ALLOC_IOVA_ALIGN_INV) {
+        dev_warn_once(dev, "%s: invalid alignment requested\n", __func__);
+        return -EINVAL;
+    }

     if (static_branch_unlikely(&iommu_deferred_attach_enabled)) {
         ret = iommu_deferred_attach(dev, domain);
@@ -1470,7 +1507,7 @@ int iommu_dma_map_sg(struct device *dev, struct
scatterlist *sg, int nents,
     if (!iova_len)
         return __finalise_sg(dev, sg, nents, 0);

-    iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev), dev);
+    iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev),
dev, align);
     if (!iova) {
         ret = -ENOMEM;
         goto out_restore_sg;
@@ -1549,9 +1586,15 @@ void iommu_dma_unmap_sg(struct device *dev,
struct scatterlist *sg, int nents,
 dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
         size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
+    iova_align_t align = dma_info_to_alignment(attrs);
+
+    if (align == ALLOC_IOVA_ALIGN_INV) {
+        dev_warn_once(dev, "%s: invalid alignment requested\n", __func__);
+        return DMA_MAPPING_ERROR;
+    }
     return __iommu_dma_map(dev, phys, size,
             dma_info_to_prot(dir, false, attrs) | IOMMU_MMIO,
-            dma_get_mask(dev));
+            dma_get_mask(dev), align);
 }

 void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
@@ -1642,6 +1685,12 @@ void *iommu_dma_alloc(struct device *dev,
size_t size, dma_addr_t *handle,
     int ioprot = dma_info_to_prot(DMA_BIDIRECTIONAL, coherent, attrs);
     struct page *page = NULL;
     void *cpu_addr;
+    iova_align_t align = dma_info_to_alignment(attrs);
+
+    if (align == ALLOC_IOVA_ALIGN_INV) {
+        dev_warn_once(dev, "%s: invalid alignment requested\n", __func__);
+        return NULL;
+    }

     gfp |= __GFP_ZERO;

@@ -1660,7 +1709,7 @@ void *iommu_dma_alloc(struct device *dev, size_t
size, dma_addr_t *handle,
         return NULL;

     *handle = __iommu_dma_map(dev, page_to_phys(page), size, ioprot,
-            dev->coherent_dma_mask);
+            dev->coherent_dma_mask, align);
     if (*handle == DMA_MAPPING_ERROR) {
         __iommu_dma_free(dev, size, cpu_addr);
         return NULL;
@@ -1753,6 +1802,7 @@ size_t iommu_dma_max_mapping_size(struct device *dev)
  * @state: IOVA state
  * @phys: physical address
  * @size: IOVA size
+ * @align: DMA address alignment
  *
  * Check if @dev supports the IOVA-based DMA API, and if yes allocate
IOVA space
  * for the given base address and size.
@@ -1764,7 +1814,7 @@ size_t iommu_dma_max_mapping_size(struct device *dev)
  * allocated, or %false if the regular DMA API should be used.
  */
 bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
-        phys_addr_t phys, size_t size)
+        phys_addr_t phys, size_t size, iova_align_t align)
 {
     struct iommu_dma_cookie *cookie;
     struct iommu_domain *domain;
@@ -1798,7 +1848,7 @@ bool dma_iova_try_alloc(struct device *dev,
struct dma_iova_state *state,

     addr = iommu_dma_alloc_iova(domain,
             iova_align(iovad, size + iova_off),
-            dma_get_mask(dev), dev, ALLOC_IOVA_ALIGN_SIZE);
+            dma_get_mask(dev), dev, align);
     if (!addr)
         return false;

@@ -2161,7 +2211,7 @@ static struct iommu_dma_msi_page
*iommu_dma_get_msi_page(struct device *dev,
     if (!msi_page)
         return NULL;

-    iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev);
+    iova = iommu_dma_alloc_iova(domain, size, dma_get_mask(dev), dev,
ALLOC_IOVA_ALIGN_NONE);
     if (!iova)
         goto out_free_page;

diff --git a/drivers/vfio/pci/mlx5/cmd.c b/drivers/vfio/pci/mlx5/cmd.c
index 5b919a0b2524..36d21eec9959 100644
--- a/drivers/vfio/pci/mlx5/cmd.c
+++ b/drivers/vfio/pci/mlx5/cmd.c
@@ -387,7 +387,7 @@ static int register_dma_pages(struct mlx5_core_dev
*mdev, u32 npages,

     mtt = (__be64 *)MLX5_ADDR_OF(create_mkey_in, mkey_in, klm_pas_mtt);

-    if (dma_iova_try_alloc(mdev->device, state, 0, npages * PAGE_SIZE)) {
+    if (dma_iova_try_alloc(mdev->device, state, 0, npages *
PAGE_SIZE, ALLOC_IOVA_ALIGN_NONE)) {
         addr = state->addr;
         for (i = 0; i < npages; i++) {
             err = dma_iova_link(mdev->device, state,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 5cb8e6e49138..7eef81301755 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -58,6 +58,16 @@
  */
 #define DMA_ATTR_PRIVILEGED        (1UL << 9)

+/*
+ * Alignment flags when using IOMMU. In the case of direct mapping, DMA address
+ * will typically have the same alignment as the virtual address. So, alignment
+ * expectation works in general case if the virtual address is aligned to the
+ * requested alignment.
+ */
+#define DMA_ATTR_IOVA_ALIGN_PMD (1UL << 10)
+#define DMA_ATTR_IOVA_ALIGN_PUD (1UL << 11)
+#define DMA_ATTR_IOVA_ALIGN_SIZE (1UL << 12)
+
 /*
  * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
  * be given to a device to use as a DMA source or target.  It is specific to a
@@ -316,7 +326,7 @@ static inline bool dma_use_iova(struct
dma_iova_state *state)
 }

 bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
-        phys_addr_t phys, size_t size);
+        phys_addr_t phys, size_t size, iova_align_t align);
 void dma_iova_free(struct device *dev, struct dma_iova_state *state);
 void dma_iova_destroy(struct device *dev, struct dma_iova_state *state,
         size_t mapped_len, enum dma_data_direction dir,
@@ -335,7 +345,7 @@ static inline bool dma_use_iova(struct
dma_iova_state *state)
     return false;
 }
 static inline bool dma_iova_try_alloc(struct device *dev,
-        struct dma_iova_state *state, phys_addr_t phys, size_t size)
+        struct dma_iova_state *state, phys_addr_t phys, size_t size,
iova_align_t align)
 {
     return false;
 }
diff --git a/mm/hmm.c b/mm/hmm.c
index feac86196a65..47a415cfc60c 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -660,7 +660,7 @@ int hmm_dma_map_alloc(struct device *dev, struct
hmm_dma_map *map,
         return -ENOMEM;

     use_iova = dma_iova_try_alloc(dev, &map->state, 0,
-            nr_entries * PAGE_SIZE);
+            nr_entries * PAGE_SIZE, ALLOC_IOVA_ALIGN_NONE);
     if (!use_iova && dma_need_unmap(dev)) {
         map->dma_list = kvcalloc(nr_entries, sizeof(*map->dma_list),
                      GFP_KERNEL | __GFP_NOWARN);


-- 
----------------------------------------
Constantine Gavrilov
System Architect and Platform Engineer
Infinidat
----------------------------------------
