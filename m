Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAD821422B
	for <iommu@lists.linux.dev>; Sun,  3 Aug 2025 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219859; cv=none; b=k8v7cTY5KGE+F6oNZq89Uw1Hw7Qs0PHWf5Lha+4PZ4Nan15zmJbhMesFo2B6rIGuE/gCpM67Oe+726NwOfPi3ju0ZPNdCj8qNPyGNlUXXqW022hxhWiFTF/VHKsZ90qh6wLrWr4v594sC/98MMoqloYvcIvrmHLWTFF2Oxl9ULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219859; c=relaxed/simple;
	bh=d0R8EDhjUqnNngbOxjeKQcqua7pRcAMMnsTDsA+Ro8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Vr/z1jB6oOhfUeli53TNghvx7fsNCg3kQkUFEtzt2KYhM/935ICglGhjfiKJjN2+3c0GV9olwbDxPkw+MO/12VWLs1ICb3yHP7nn1TPxQvB/O2msQYyy5+FOmG7/ecfoCUkHWWTu7NPBBYd8Sdwq/qqm03zH1TTWOKJX/xrQwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com; spf=pass smtp.mailfrom=infinidat.com; dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b=Vub5HW6E; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinidat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b="Vub5HW6E"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-7076b55460eso31171836d6.0
        for <iommu@lists.linux.dev>; Sun, 03 Aug 2025 04:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infinidat.com; s=google; t=1754219856; x=1754824656; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EJCABHFDmK9VaB5CwomNDJ9KGxLMOeQ+qHkRsJyn2yE=;
        b=Vub5HW6EXswOWOvrhLNfMkNw28l94pPU6brWKJ7IRJ3lpb4HQSekQNwuZJn1W+1prg
         t31/fpdE7v8CbIenkklKYsWQITjqXoKkblnfBP/uSlac/iohoev+12M+xJ6CvafjLnSu
         nsXaPU1SmME0QcACjZoZSC8TIRY8MW3lHSnI32yXEc13rjJfWap0oX73lB95wXfBSL6B
         5+WuZij13opz2gr773IcKMkS5Xb9AmfoBXdZ+sRkJA4orwPDtMg+BWBsmV9Ze+1Tkg2m
         0Gu5AP7m3WjI6FRgyd1cvM8oN8iDKByKgCMfyiFTdEuCxXFaVWtRIBVR9Am5IBLTjVHX
         cXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754219856; x=1754824656;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EJCABHFDmK9VaB5CwomNDJ9KGxLMOeQ+qHkRsJyn2yE=;
        b=r2AQFvZInPZnL/RYSnpQ+Tvfg8+B+zxvrvDS5qw6WVCmNmEk7K51nw3ffKdeRzwr40
         SHt+vapnKYb0FGO09vltIGf/9RJNIZT3Dz7G2oXiDroCZTBb6jTEJx36DEsQAcRwDjlu
         qqO8BkzbsLi5QRF2q3C7FtSz3LtPm5Ypd43pNWKOnx3nyn8MU6b/rGkU//gcAeO+/mOf
         bC2pc8jd7R3IRfIvZfhp9MmHdV9ax9xjnsrej8MIc7LEZsuTjDVcZ+2x4GcIxvras89S
         1wOTuQtWaEtXRVOUd41O+C6ZY6vEMXm9kFs+p/FJdEko5Ziuc/ARScZhXQ6HNU8ujBNV
         8qVA==
X-Forwarded-Encrypted: i=1; AJvYcCVoG64/apC4ZHs4CKsV4qRNpJ7/pgboHj0hEtwU34Xpxd2VCWKvmQ1NgEz595z/UEOMf9bz6g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzg/Z5pRI9cG/PHo80R445wD9TEEQABdLAg6fCpRvPyNjsEwSVg
	ec0pdrmMZVEe33Bat6B4bnhJt5paznD0ztgHKJiBWk4L4QDA8Oq2jnNW1Kfz+/POV6JqO9sqH3J
	L0ajnvnhpXi9DY0YsdtHq9AtaUuOWtL9qtRLt59bjJQ==
X-Gm-Gg: ASbGncv+OFDGe0hZsV42tpYDyJCdFPjS+zllue63Wq0p46Z86As/ZvUTOucnK235nDh
	TgmB6TlPo4hbwQFxgGBe7e0PIJtwMMqXLCfMrJ6Nd/n8DwGn0D/uoq4s44MtFwlIUTeL3cBlCLG
	VeBTX08c0LO6VbEuFFgjX9bY1MvvFazbp4Hn4ADTqHKkzsK2vt7unKFM0Cs9NnCsQLJyBnFlLAh
	CcsDl9yDA==
X-Google-Smtp-Source: AGHT+IG14mFtyyy1YEATAQBgRu9BAPlOY7kV424JnOCcvL/poj5BPzG8AZQjttjIbOI22NVwqHm44HP6a7TVHzWt7oY=
X-Received: by 2002:a05:6214:2626:b0:707:4b37:f6c5 with SMTP id
 6a1803df08f44-709362fdd09mr83856226d6.35.1754219856065; Sun, 03 Aug 2025
 04:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEHaoC2BWe+0Ps2oU-0xPDLFYYKG-o9+_ynFgh7u3qqyRDtrTg@mail.gmail.com>
 <CAEHaoC22NDpHUWovJChCx_XqchkEvUPYrFFe_L1PH9Mw2e386A@mail.gmail.com>
 <CAEHaoC2bi3VUEuoWKgHbgUFfdxmACrhkjaQ9Jni-4-ByP5tYJg@mail.gmail.com>
 <CAEHaoC3ZMvHe7D-JX9bfM9hfSPs0QV-og=om5eKFFqSL=tpjcw@mail.gmail.com>
 <CAEHaoC0Au_0yLRKSnDg=_qjnmDMmbJ=Nff+W1feEBTib0Jb_gA@mail.gmail.com>
 <CAEHaoC2ZQAd+h=7mKPOuMfAMex-41soD8=kx2vR_em+i71oBRw@mail.gmail.com>
 <CAEHaoC3t8nFhR4MAYV1AaR5mjN4ndkkWrKUyBY_smbtpDykAEA@mail.gmail.com> <CAEHaoC1mHQp62GMBofGJwKBkjgf8rQr_tUxwESKa7Ehd6_3nWA@mail.gmail.com>
In-Reply-To: <CAEHaoC1mHQp62GMBofGJwKBkjgf8rQr_tUxwESKa7Ehd6_3nWA@mail.gmail.com>
From: Constantine Gavrilov <cgavrilov@infinidat.com>
Date: Sun, 3 Aug 2025 14:17:24 +0300
X-Gm-Features: Ac12FXyCe3Y0d1KY-hXOj8mMqH58OmiavVXy1bcYlNMPqSDWBNX521gS0SiBLvA
Message-ID: <CAEHaoC2JjQ0k4B3T1eK=4OhwTE_JxwgZ5A=nBjheR5Ehspwj7Q@mail.gmail.com>
Subject: [PATCH 7/8] Large DMA alloc/low address limit in alloc funcs
To: linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This is the eighth patch from the set of patches that enable large IOMMU
DMA registrations. Entire work is available at the master branch of the
master branch of git@github.com:cgavrilov/linux.git repo.

Some devices (like NTB or GPU) allow mapping of the system memory to PCIe bars,
allowing to implement PCIe interconnects when devices are connected to more
than one root complex. After one root complex does the mapping, an application
on another root complex can access the memory using the PCIe bar of the device.
Since a typical system memory mapping uses offset translation (between the
device bar address and the DMA address), the device driver needs to know which
contiguous DMA address range is available to satisfy the device needs before it
can set up the mapping offset. After querying the available range, the device
driver can set up the mapping translation and use the top and low DMA address
constraints to ensure that future DMA allocation APIs will allocate DMA
addresses within the selected range.

This patch was developed before the 6.16 kernel that provides functions
dma_iova_try_alloc() and and dma_iova_link() to help with this task. With
dma_iova_try_alloc(), the device driver can reserve a DMA address range for its
future use and use dma_iova_link() later to update IOMMU translations on the
reserved range. However, we do not have APIs that would allow allocations of
smaller regions from the reserve red area that would provide functionality
similar to iommu_dma_alloc_iova(). This patch allows to query the available
range, set up the offset, and use standard DMA allocation APIs, after enforcing
the DMA mask constraints on the device.

This patch does not change the existing behavior but extends some DMA address
allocation APIs to use the low and top address constraints.

commit 00de9ac3bdb6747fbe6b21de78ad11a32c67a71f
Author: Constantine Gavrilov <cgavrilov@infinidat.com>
Date:   Tue Jul 1 14:12:27 2025 +0300

    Support low address limit in functions that allocate DMA address.

    Devices that map memory windows to PCI bars (for example NTB devices)
    may need this change. This is because such devices may use very large
    memory windows (terabytes in size), and they cannot simply cap the top
    DMA address to the size of the window, since the range [0-window size]
    may not be available. Such devices can find an available DMA region, set
    up the memory window, and request DMA address allocations in the found
    range.

    This is a preparation step, there is no change of behavior in this
    change.

    The following public APIs add low_limit_pfn parameter:
    * alloc_iova() - passes parameter
    * alloc_iova_fast() - passes parameter

    The following static functions that are called during DMA address
    allocation add low_limit_pfn parameter:

    * iova_rcache_get() - passes parameter
    * __alloc_and_insert_iova_range() - uses parameter
    * iova_magazine_pop() - uses parameter
    * __iova_rcache_get() - uses parameter
    * iova_rcache_get() - passes parameter

diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index bf525d59e82e..f8b7eadeee05 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1046,7 +1046,7 @@ void *tegra_drm_alloc(struct tegra_drm *tegra,
size_t size, dma_addr_t *dma)

     alloc = alloc_iova(&tegra->carveout.domain,
                size >> tegra->carveout.shift,
-               tegra->carveout.limit, ALLOC_IOVA_ALIGN_SIZE);
+               0, tegra->carveout.limit, ALLOC_IOVA_ALIGN_SIZE);
     if (!alloc) {
         err = -EBUSY;
         goto free_pages;
diff --git a/drivers/gpu/host1x/cdma.c b/drivers/gpu/host1x/cdma.c
index fbd647fc031c..d49b238b1708 100644
--- a/drivers/gpu/host1x/cdma.c
+++ b/drivers/gpu/host1x/cdma.c
@@ -97,7 +97,7 @@ static int host1x_pushbuffer_init(struct push_buffer *pb)

         shift = iova_shift(&host1x->iova);
         alloc = alloc_iova(&host1x->iova, size >> shift,
-                   host1x->iova_end >> shift, ALLOC_IOVA_ALIGN_SIZE);
+                   0, host1x->iova_end >> shift, ALLOC_IOVA_ALIGN_SIZE);
         if (!alloc) {
             err = -ENOMEM;
             goto iommu_free_mem;
diff --git a/drivers/gpu/host1x/job.c b/drivers/gpu/host1x/job.c
index ff5325d21fe8..715585b6ec67 100644
--- a/drivers/gpu/host1x/job.c
+++ b/drivers/gpu/host1x/job.c
@@ -242,7 +242,7 @@ static unsigned int pin_job(struct host1x *host,
struct host1x_job *job)

             shift = iova_shift(&host->iova);
             alloc = alloc_iova(&host->iova, gather_size >> shift,
-                       host->iova_end >> shift, ALLOC_IOVA_ALIGN_SIZE);
+                       0, host->iova_end >> shift, ALLOC_IOVA_ALIGN_SIZE);
             if (!alloc) {
                 err = -ENOMEM;
                 goto put;
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index e78d7f8a2d61..414d31347fc2 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -810,7 +810,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct
iommu_domain *domain,
      * expected address bits are wired up between the device and the IOMMU.
      */
     if (dma_limit > DMA_BIT_MASK(32) && (size - 1) <=
DMA_BIT_MASK(32) && dev->iommu->pci_32bit_workaround) {
-        iova = alloc_iova_fast(iovad, iova_len,
+        iova = alloc_iova_fast(iovad, iova_len, 0,
                        DMA_BIT_MASK(32) >> shift, false, align);
         if (iova)
             goto done;
@@ -819,7 +819,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct
iommu_domain *domain,
         dev_notice(dev, "Using %d-bit DMA addresses\n", bits_per(dma_limit));
     }

-    iova = alloc_iova_fast(iovad, iova_len, dma_limit >> shift, true, align);
+    iova = alloc_iova_fast(iovad, iova_len, 0, dma_limit >> shift,
true, align);
 done:
     return (dma_addr_t)iova << shift;
 }
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 09356d6065ef..e599cfc66bff 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -24,6 +24,7 @@ static bool iova_rcache_insert(struct iova_domain *iovad,
                    unsigned long size);
 static unsigned long iova_rcache_get(struct iova_domain *iovad,
                      unsigned long size,
+                     unsigned long low_limit_pfn,
                      unsigned long limit_pfn);
 static void free_iova_rcaches(struct iova_domain *iovad);
 static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
@@ -205,16 +206,18 @@ iova_insert_rbtree(struct rb_root *root, struct
iova *iova,
 }

 static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
-        unsigned long size, unsigned long limit_pfn,
-            struct iova *new, iova_align_t align)
+        unsigned long size, unsigned low_limit_pfn, unsigned long limit_pfn,
+        struct iova *new, iova_align_t align)
 {
     struct rb_node *curr, *prev, *start_search;
     struct iova *curr_iova, *start_iova;
     unsigned long flags;
     unsigned long new_pfn, retry_pfn;
     unsigned long align_mask;
-    unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;
+    unsigned long high_pfn = limit_pfn;
+    bool retried = false;

+    low_limit_pfn = max(low_limit_pfn, iovad->start_pfn);
     switch (align) {
         case ALLOC_IOVA_ALIGN_NONE: align_mask = ~0UL; break;
         case ALLOC_IOVA_ALIGN_SIZE: align_mask = (~0UL) <<
fls_long(size - 1); break;
@@ -237,14 +240,15 @@ static int __alloc_and_insert_iova_range(struct
iova_domain *iovad,
         prev = curr;
         curr = rb_prev(curr);
         curr_iova = to_iova(curr);
-    } while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);
+    } while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_limit_pfn);

-    if (high_pfn < size || new_pfn < low_pfn) {
-        if (start_search != &iovad->anchor.node && low_pfn ==
iovad->start_pfn && retry_pfn < limit_pfn) {
+    if (high_pfn < size || new_pfn < low_limit_pfn) {
+        if (start_search != &iovad->anchor.node && !retried &&
retry_pfn < limit_pfn) {
             high_pfn = limit_pfn;
-            low_pfn = retry_pfn + 1;
+            low_limit_pfn = retry_pfn + 1;
             curr = start_search = iova_find_limit(iovad, limit_pfn);
             curr_iova = start_iova = to_iova(curr);
+            retried = true;
             goto retry;
         }
         goto iova32_full;
@@ -297,6 +301,7 @@ static void free_iova_mem(struct iova *iova)
  */
 struct iova *
 alloc_iova(struct iova_domain *iovad, unsigned long size,
+    unsigned long low_limit_pfn,
     unsigned long limit_pfn,
     iova_align_t align)
 {
@@ -307,7 +312,7 @@ alloc_iova(struct iova_domain *iovad, unsigned long size,
     if (!new_iova)
         return NULL;

-    ret = __alloc_and_insert_iova_range(iovad, size, limit_pfn + 1,
+    ret = __alloc_and_insert_iova_range(iovad, size, low_limit_pfn,
limit_pfn + 1,
             new_iova, align);

     if (ret) {
@@ -507,7 +512,8 @@ EXPORT_SYMBOL_GPL(free_iova);
 */
 unsigned long
 alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
-        unsigned long limit_pfn, bool flush_rcache, iova_align_t align)
+        unsigned long low_limit_pfn, unsigned long limit_pfn,
+        bool flush_rcache, iova_align_t align)
 {
     unsigned long iova_pfn;
     struct iova *new_iova;
@@ -521,12 +527,12 @@ alloc_iova_fast(struct iova_domain *iovad,
unsigned long size,
     if (size < (1 << (IOVA_RANGE_CACHE_MAX_SIZE - 1)))
         size = roundup_pow_of_two(size);

-    iova_pfn = iova_rcache_get(iovad, size, limit_pfn + 1);
+    iova_pfn = iova_rcache_get(iovad, size, low_limit_pfn, limit_pfn + 1);
     if (iova_pfn)
         return iova_pfn;

 retry:
-    new_iova = alloc_iova(iovad, size, limit_pfn, align);
+    new_iova = alloc_iova(iovad, size, low_limit_pfn, limit_pfn, align);
     if (!new_iova) {
         unsigned int cpu;

@@ -780,13 +786,14 @@ static bool iova_magazine_empty(struct iova_magazine *mag)
 }

 static unsigned long iova_magazine_pop(struct iova_magazine *mag,
+                       unsigned long low_limit_pfn,
                        unsigned long limit_pfn)
 {
     int i;
     unsigned long pfn;

     /* Only fall back to the rbtree if we have no suitable pfns at all */
-    for (i = mag->size - 1; mag->pfns[i] > limit_pfn; i--)
+    for (i = mag->size - 1; (mag->pfns[i] > limit_pfn) ||
(mag->pfns[i] < low_limit_pfn); i--)
         if (i == 0)
             return 0;

@@ -953,6 +960,7 @@ static bool iova_rcache_insert(struct iova_domain
*iovad, unsigned long pfn,
  * it from the 'rcache'.
  */
 static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
+                       unsigned long low_limit_pfn,
                        unsigned long limit_pfn)
 {
     struct iova_cpu_rcache *cpu_rcache;
@@ -979,7 +987,7 @@ static unsigned long __iova_rcache_get(struct
iova_rcache *rcache,
     }

     if (has_pfn)
-        iova_pfn = iova_magazine_pop(cpu_rcache->loaded, limit_pfn);
+        iova_pfn = iova_magazine_pop(cpu_rcache->loaded,
low_limit_pfn, limit_pfn);

     spin_unlock_irqrestore(&cpu_rcache->lock, flags);

@@ -993,6 +1001,7 @@ static unsigned long __iova_rcache_get(struct
iova_rcache *rcache,
  */
 static unsigned long iova_rcache_get(struct iova_domain *iovad,
                      unsigned long size,
+                     unsigned long low_limit_pfn,
                      unsigned long limit_pfn)
 {
     unsigned int log_size = order_base_2(size);
@@ -1000,7 +1009,7 @@ static unsigned long iova_rcache_get(struct
iova_domain *iovad,
     if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
         return 0;

-    return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
+    return __iova_rcache_get(&iovad->rcaches[log_size],
low_limit_pfn, limit_pfn - size);
 }

 /*
diff --git a/drivers/media/pci/intel/ipu6/ipu6-dma.c
b/drivers/media/pci/intel/ipu6/ipu6-dma.c
index 4e2b98c4f348..24b677f73992 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-dma.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-dma.c
@@ -172,7 +172,7 @@ void *ipu6_dma_alloc(struct ipu6_bus_device *sys,
size_t size,
     count = PHYS_PFN(size);

     iova = alloc_iova(&mmu->dmap->iovad, count,
-              PHYS_PFN(mmu->dmap->mmu_info->aperture_end),
ALLOC_IOVA_ALIGN_NONE);
+              0, PHYS_PFN(mmu->dmap->mmu_info->aperture_end),
ALLOC_IOVA_ALIGN_NONE);
     if (!iova)
         goto out_kfree;

@@ -398,7 +398,7 @@ int ipu6_dma_map_sg(struct ipu6_bus_device *sys,
struct scatterlist *sglist,
         nents, npages);

     iova = alloc_iova(&mmu->dmap->iovad, npages,
-              PHYS_PFN(mmu->dmap->mmu_info->aperture_end),
ALLOC_IOVA_ALIGN_NONE);
+              0, PHYS_PFN(mmu->dmap->mmu_info->aperture_end),
ALLOC_IOVA_ALIGN_NONE);
     if (!iova)
         return 0;

diff --git a/drivers/media/pci/intel/ipu6/ipu6-mmu.c
b/drivers/media/pci/intel/ipu6/ipu6-mmu.c
index 4d6f9b8d68bb..013d33a0f5dc 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-mmu.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-mmu.c
@@ -422,7 +422,7 @@ static int allocate_trash_buffer(struct ipu6_mmu *mmu)

     /* Allocate 8MB in iova range */
     iova = alloc_iova(&mmu->dmap->iovad, n_pages,
-              PHYS_PFN(mmu->dmap->mmu_info->aperture_end),
ALLOC_IOVA_ALIGN_NONE);
+              0, PHYS_PFN(mmu->dmap->mmu_info->aperture_end),
ALLOC_IOVA_ALIGN_NONE);
     if (!iova) {
         dev_err(mmu->dev, "cannot allocate iova range for trash\n");
         return -ENOMEM;
diff --git a/drivers/media/platform/nvidia/tegra-vde/iommu.c
b/drivers/media/platform/nvidia/tegra-vde/iommu.c
index ad010ad65735..ec687165e150 100644
--- a/drivers/media/platform/nvidia/tegra-vde/iommu.c
+++ b/drivers/media/platform/nvidia/tegra-vde/iommu.c
@@ -30,7 +30,7 @@ int tegra_vde_iommu_map(struct tegra_vde *vde,
     size = iova_align(&vde->iova, size);
     shift = iova_shift(&vde->iova);

-    iova = alloc_iova(&vde->iova, size >> shift, end >> shift,
ALLOC_IOVA_ALIGN_SIZE);
+    iova = alloc_iova(&vde->iova, size >> shift, 0, end >> shift,
ALLOC_IOVA_ALIGN_SIZE);
     if (!iova)
         return -ENOMEM;

diff --git a/drivers/staging/media/ipu3/ipu3-dmamap.c
b/drivers/staging/media/ipu3/ipu3-dmamap.c
index 330314a3aa94..fb42a6740f0e 100644
--- a/drivers/staging/media/ipu3/ipu3-dmamap.c
+++ b/drivers/staging/media/ipu3/ipu3-dmamap.c
@@ -105,7 +105,7 @@ void *imgu_dmamap_alloc(struct imgu_device *imgu,
struct imgu_css_map *map,
     dev_dbg(dev, "%s: allocating %zu\n", __func__, size);

     iova = alloc_iova(&imgu->iova_domain, size >> shift,
-              imgu->mmu->aperture_end >> shift, ALLOC_IOVA_ALIGN_NONE);
+              0, imgu->mmu->aperture_end >> shift, ALLOC_IOVA_ALIGN_NONE);
     if (!iova)
         return NULL;

@@ -205,7 +205,7 @@ int imgu_dmamap_map_sg(struct imgu_device *imgu,
struct scatterlist *sglist,
         nents, size >> shift);

     iova = alloc_iova(&imgu->iova_domain, size >> shift,
-              imgu->mmu->aperture_end >> shift, ALLOC_IOVA_ALIGN_NONE);
+              0, imgu->mmu->aperture_end >> shift, ALLOC_IOVA_ALIGN_NONE);
     if (!iova)
         return -ENOMEM;

diff --git a/drivers/vdpa/vdpa_user/iova_domain.c
b/drivers/vdpa/vdpa_user/iova_domain.c
index 96ce209762f9..feb130648888 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.c
+++ b/drivers/vdpa/vdpa_user/iova_domain.c
@@ -362,7 +362,7 @@ vduse_domain_alloc_iova(struct iova_domain *iovad,
     unsigned long iova_len = iova_align(iovad, size) >> shift;
     unsigned long iova_pfn;

-    iova_pfn = alloc_iova_fast(iovad, iova_len, limit >> shift, true,
ALLOC_IOVA_ALIGN_SIZE);
+    iova_pfn = alloc_iova_fast(iovad, iova_len, 0, limit >> shift,
true, ALLOC_IOVA_ALIGN_SIZE);

     return (dma_addr_t)iova_pfn << shift;
 }
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 0780a64e1149..d17b4901effc 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -97,8 +97,7 @@ unsigned long iova_rcache_range(void);
 void free_iova(struct iova_domain *iovad, unsigned long pfn);
 void __free_iova(struct iova_domain *iovad, struct iova *iova);
 struct iova *alloc_iova(struct iova_domain *iovad, unsigned long size,
-    unsigned long limit_pfn,
-    iova_align_t align);
+    unsigned long low_limit_pfn, unsigned long limit_pfn, iova_align_t align);

 void free_iova_fast(struct iova_domain *iovad, unsigned long pfn,
             unsigned long size);
@@ -109,7 +108,8 @@ ssize_t iovad_show_busy_regions(struct iova_domain
*iovad, char *buf);
 int iovad_get_lowest_free_address_range(struct iova_domain *iovad,
struct addr_range_query *query, u64 *res);

 unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
-                  unsigned long limit_pfn, bool flush_rcache,
iova_align_t align);
+                unsigned long low_limit_pfn, unsigned long limit_pfn,
+                bool flush_rcache, iova_align_t align);
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
     unsigned long pfn_hi);
 void init_iova_domain(struct iova_domain *iovad, unsigned long granule,
@@ -147,6 +147,7 @@ int iovad_get_lowest_free_address_range(struct
iova_domain *iovad, struct addr_r

 static inline struct iova *alloc_iova(struct iova_domain *iovad,
                       unsigned long size,
+                      unsigned long low_limit_pfn,
                       unsigned long limit_pfn,
                       iova_align_t align)
 {
@@ -161,6 +162,7 @@ static inline void free_iova_fast(struct iova_domain *iovad,

 static inline unsigned long alloc_iova_fast(struct iova_domain *iovad,
                         unsigned long size,
+                        unsigned long low_limit_pfn,
                         unsigned long limit_pfn,
                         bool flush_rcache, iova_align_t align)
 {


-- 
----------------------------------------
Constantine Gavrilov
System Architect and Platform Engineer
Infinidat
----------------------------------------
