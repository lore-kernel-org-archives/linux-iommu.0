Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC068F58
	for <iommu@lists.linux.dev>; Sun,  3 Aug 2025 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219520; cv=none; b=Oc/ihMKiAyMl2ieWxgahdUhhasF7X6ySez14a9zYAdqjdbjB+/YSgiM1Jnkfib0LnnZwqOKK3FDQ1EaEWrHHHOvSbqllzplPYwd3s7CdPzsBvOK54MOeozD1MzZfUcmuT7YrC0jE6OLxNf1y9H1EJiwIdrhwN7+hBme20LUz5QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219520; c=relaxed/simple;
	bh=RRajYJN1LduWEl0wJ54fdb+FhlarDjwLiRjIk5l20DM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YlH+T1oUysocgsd+gQGpFCT/WBLiOlW6c4fyse6zBdX2koK9PhEtjP4g3GxbrQ93k1WrLYE43cfGkmHrBD2qTw7tN2GKUtC3zCF6GlzfPk1JTHaH2Cz7YHGXJbwuv6L2KNIixHrQ2K70DPjm8dfU76j5Yu9ZBTvC28VGa5FW2mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com; spf=pass smtp.mailfrom=infinidat.com; dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b=ViJaXMbN; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinidat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b="ViJaXMbN"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7074bad053bso38547316d6.0
        for <iommu@lists.linux.dev>; Sun, 03 Aug 2025 04:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infinidat.com; s=google; t=1754219516; x=1754824316; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+id45dnaTLNIRW3VoBV8xxh9SFZvf++TrU2afn5V0Gk=;
        b=ViJaXMbNpcSmcjNsUTcBT4iKfgoh79KMHSVjrWM/opRu1UqxRNBgZG3t/v9hqQ6Pgq
         pNCCdWo7kxEI4u3eUcpEgR9t2HsD22ciY2zz/sHjmkqZBvF2r/ft0lTqIDd+4+mmasGS
         i2326cnlxegaoxLli3e5VdL6OaZjKrM9I6Shhq7uWYtSbRrU3lgC7qeYOm1kHcDMquE6
         cDrM4XaVe1UuZDGfiAY4GV3yCwC0778iyRnbmnTiHDeTJ5YEUjnN5rsK6ntSgajD5SUB
         PSjOTlq2lukVrISpNHvQy4kkXXLPLAX23G4HEy7uWcuhHcfmzyE7UgpOhf8HJ0jjNuNb
         Ro4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754219516; x=1754824316;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+id45dnaTLNIRW3VoBV8xxh9SFZvf++TrU2afn5V0Gk=;
        b=k6OdZ4t4KKt3pg+e9xsldWf2srRWrVR7OiWGWYBy07iCFVYw+NMtlOrEtnqIbO4Nm3
         ITMkLfdBvzem5jIxmoIn4QNu8oDcR/Y8r8sUW5tiXk9LginsOpxGevjrsWlGXzSKe9rt
         s7Qw8miYZt2lHx5hRGBf0FG9DKggP+bIvIe0Yo67pYfCKqy3yyV3Z16BIs3w0x0QKEX9
         sycQNlXT93wWjY8qqgHgrfQ+qY7xmHIdN1SD1OKBmrRqr7AxpDYD4pCBfYQI3lju5Z2B
         5IruHadId0QBWqdFUZW2/a4qaxGcTU+G/KCKNSz09i7ift2TjQoKQ46aB93W89NXYDD7
         X5nw==
X-Forwarded-Encrypted: i=1; AJvYcCWn/Vwc6l6yhECqI+nnhdqlDYXoWNmy7rWyH1wg/Q1gXUokPYjqbg8ZzbQcJuNOoqA9nz1uoQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdmIqEgzG/asFtHlDqHJMqVo+brFkBtCwiMka27wm/hPm0QI7T
	tJKqvjr9/Gv1hfjwi5p/l1f4GHzNxF0eeSg/Rq34icwcPn/O18f07XxdzHtMQSLriLT/PLEE8GE
	7FXy5kxveVLODPIHbRZj2Dk9xkurgN0G+l7oxFls4Cw8pjoy4u1f1vyI=
X-Gm-Gg: ASbGncsqibY7NusunjnqmYIEIsWToQu2n2koNcb9X+asXxS4Jy41oGVOUiSI6n7dsak
	2XHK9JQKPX1yly+coHYkQrgorybnHzg7UXkJ1SGbha1Pucm+26/4viGFKny0LE2uq6Hrx7vsKkw
	sceBEUK0vcyIrOfjapBCPG2NtAPHAGt3d9NGDETJC2/nLoIm0UVHM64RqtFx0yngIwtkvVfIjY7
	pfgp3jmXw==
X-Google-Smtp-Source: AGHT+IH5DQSr8FMbfnTuka6OWMG+ejazqBN2XucJdEdtdfiy80nv0BV3+CLQH0eWTG6vKaNdqqeM+4D2I/8KkvX+vwU=
X-Received: by 2002:a0c:e34c:0:b0:709:3ab5:b935 with SMTP id
 6a1803df08f44-7093ab5bd34mr50762556d6.3.1754219516532; Sun, 03 Aug 2025
 04:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAEHaoC2BWe+0Ps2oU-0xPDLFYYKG-o9+_ynFgh7u3qqyRDtrTg@mail.gmail.com>
 <CAEHaoC22NDpHUWovJChCx_XqchkEvUPYrFFe_L1PH9Mw2e386A@mail.gmail.com>
 <CAEHaoC2bi3VUEuoWKgHbgUFfdxmACrhkjaQ9Jni-4-ByP5tYJg@mail.gmail.com>
 <CAEHaoC3ZMvHe7D-JX9bfM9hfSPs0QV-og=om5eKFFqSL=tpjcw@mail.gmail.com> <CAEHaoC0Au_0yLRKSnDg=_qjnmDMmbJ=Nff+W1feEBTib0Jb_gA@mail.gmail.com>
In-Reply-To: <CAEHaoC0Au_0yLRKSnDg=_qjnmDMmbJ=Nff+W1feEBTib0Jb_gA@mail.gmail.com>
From: Constantine Gavrilov <cgavrilov@infinidat.com>
Date: Sun, 3 Aug 2025 14:11:45 +0300
X-Gm-Features: Ac12FXxxWf_6xU9UxIxFQykDgpEUXFW9cF4UYV7q7HybOJWzp7BkzSX9SgJMMU4
Message-ID: <CAEHaoC2ZQAd+h=7mKPOuMfAMex-41soD8=kx2vR_em+i71oBRw@mail.gmail.com>
Subject: [PATCH 4/8] Large DMA alloc/add APIs to query available range
To: linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This is the fifth patch from the set of patches that enable large IOMMU
DMA registrations. Entire work is available at the master branch of the
master branch of git@github.com:cgavrilov/linux.git repo.

Some devices (like NTB or GPU) allow mapping of the system memory to PCIe bars,
allowing to implement PCIe interconnects when devices are connected to more
that one root complex. After one root complex does the mapping, an application
on another root complex can access the memory using the PCIe bar of the device.
Since a typical system memory mapping uses offset translation (between the
device bar address and the DMA address), the device driver needs to know which
contiguous DMA address range is available to satisfy the device needs before it
can set up the mapping offset. This patch provides APIs to do this.

This patch was developed before the 6.16 kernel that provides functions
dma_iova_try_alloc() and and dma_iova_link() to help with this task. With
dma_iova_try_alloc(), the device driver can reserve a DMA address range for its
future use and use dma_iova_link() later to update IOMMU translations on the
reserved range. However, we do not have APIs that would allow allocations of
smaller regions from the reserved area that would provide functionality
similar to iommu_dma_alloc_iova(). This patch allows to query the available
range, set up the offset, and use standard DMA allocation APIs, after enforcing
the DMA mask constraint on the device.

commit 31b8abf68f5114dc90c1d38bd70e505727383666
Author: Constantine Gavrilov <cgavrilov@infinidat.com>
Date:   Thu Jun 26 23:20:40 2025 +0300

    Add APIs to query available DMA address range.

    This adds two exported functions:
    * iommu_domain_get_lowest_free_address_range()
    * iovad_get_lowest_free_address_range()

    NTB drivers that implement translation by offset can query the
availalble range
    and set the first region offset to the returned value and also set
the DMA max
    address to returned value + window size. Since DMA address allocation is
    from the top addresses, this allows the applications to request a large
    IOMMU registration that matches the NTB windows size.

    The prior query to iommu_domain_get_lowest_free_address_range() makes
    sure that a required DMA range is available and not used by other devices.

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 6ba9be4fb64d..e78d7f8a2d61 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -769,6 +769,15 @@ ssize_t iommu_domain_show_busy_regions(struct
iommu_domain *domain, char *buf)
     return iovad_show_busy_regions(iovad, buf);
 }

+int iommu_domain_get_lowest_free_address_range(struct iommu_domain
*domain, struct addr_range_query *query, u64 *res)
+{
+    struct iommu_dma_cookie *cookie = domain->iova_cookie;
+    struct iova_domain *iovad = &cookie->iovad;
+
+    return iovad_get_lowest_free_address_range(iovad, query, res);
+}
+EXPORT_SYMBOL(iommu_domain_get_lowest_free_address_range);
+
 static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
         size_t size, u64 dma_limit, struct device *dev, iova_align_t align)
 {
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 96144c58b386..aba58630be12 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -311,6 +311,59 @@ ssize_t iovad_show_busy_regions(struct
iova_domain *iovad, char *buf)
 }
 EXPORT_SYMBOL_GPL(iovad_show_busy_regions);

+/*
+ * Get a hint for lowest available address range.
+*/
+int iovad_get_lowest_free_address_range(struct iova_domain *iovad,
struct addr_range_query *query, u64 *res)
+{
+    struct rb_node *curr, *prev;
+    struct iova *curr_iova, *prev_iova;
+    unsigned long flags;
+    unsigned long shift = iova_shift(iovad);
+    int ret = -ENOMEM;
+
+    if (query->align) {
+        if (!is_power_of_2(query->align))
+            return -EINVAL;
+    }
+    if (query->addr_min >= query->addr_max)
+        return -EINVAL;
+
+    spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+    curr = &iovad->anchor.node;
+    curr_iova = rb_entry(curr, struct iova, node);
+    while(curr) {
+        prev = rb_prev(curr);
+        curr = prev;
+        if (prev) {
+            u64 free_start;
+            u64 free_end;
+            u64 alloc_end;
+            prev_iova = rb_entry(prev, struct iova, node);
+            free_start = (prev_iova->pfn_hi + 1) << shift;
+            free_end = (curr_iova->pfn_lo) << shift;
+            curr_iova = prev_iova;
+            if (query->align)
+                free_start = ALIGN(free_start, query->align);
+            alloc_end = free_start + query->size;
+
+            if (free_start < query->addr_min)
+                break;
+            if (alloc_end > query->addr_max)
+                continue; //does not match address consraint
+            if (free_start > alloc_end || free_start >= free_end ||
alloc_end > free_end)
+                continue; //overflow
+
+            ret = 0;
+            *res = free_start;
+        }
+    }
+    spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
+
+    return ret;
+}
+EXPORT_SYMBOL(iovad_get_lowest_free_address_range);
+
 static struct iova *
 private_find_iova(struct iova_domain *iovad, unsigned long pfn)
 {
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5fe92c00221d..96ac4333f727 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/iova_bitmap.h>
+#include <linux/iova.h>

 #define IOMMU_READ    (1 << 0)
 #define IOMMU_WRITE    (1 << 1)
@@ -1512,6 +1513,7 @@ static inline void iommu_debugfs_setup(void) {}
 #ifdef CONFIG_IOMMU_DMA
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
 ssize_t iommu_domain_show_busy_regions(struct iommu_domain *domain, char *buf);
+int iommu_domain_get_lowest_free_address_range(struct iommu_domain
*domain, struct addr_range_query *query, u64 *res);
 #else /* CONFIG_IOMMU_DMA */
 static inline int iommu_get_msi_cookie(struct iommu_domain *domain,
dma_addr_t base)
 {
diff --git a/include/linux/iova.h b/include/linux/iova.h
index c09d224cce2b..30ce5ad499d2 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -80,6 +80,13 @@ static inline unsigned long iova_pfn(struct
iova_domain *iovad, dma_addr_t iova)
     return iova >> iova_shift(iovad);
 }

+struct addr_range_query {
+    u64 size;
+    u64 addr_min;
+    u64 addr_max;
+    u64 align;
+};
+
 #if IS_REACHABLE(CONFIG_IOMMU_IOVA)
 int iova_cache_get(void);
 void iova_cache_put(void);
@@ -97,6 +104,9 @@ void free_iova_fast(struct iova_domain *iovad,
unsigned long pfn,

 ssize_t iovad_show_busy_regions(struct iova_domain *iovad, char *buf);

+#define IOVAD_HAS_FREE_ADDR_RANGE
+int iovad_get_lowest_free_address_range(struct iova_domain *iovad,
struct addr_range_query *query, u64 *res);
+
 unsigned long alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
                   unsigned long limit_pfn, bool flush_rcache,
iova_align_t align);
 struct iova *reserve_iova(struct iova_domain *iovad, unsigned long pfn_lo,
@@ -129,6 +139,11 @@ ssize_t iovad_show_busy_regions(struct
iova_domain *iovad, char *buf)
     return -ENOTSUPP;
 }

+int iovad_get_lowest_free_address_range(struct iova_domain *iovad,
struct addr_range_query *query, u64 *res)
+{
+    return -ENOTSUPP;
+}
+
 static inline struct iova *alloc_iova(struct iova_domain *iovad,
                       unsigned long size,
                       unsigned long limit_pfn,


-- 
----------------------------------------
Constantine Gavrilov
System Architect and Platform Engineer
Infinidat
Ha-Menofim 9, Hertzelia
----------------------------------------
