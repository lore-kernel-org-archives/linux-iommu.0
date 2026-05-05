Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC682773D3
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 00:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777940867; cv=none; b=QXTJVrxKKBSo79ro7cBFW4+UlcXHsB4SZS0MFF+s2uUu4Nnl2EKJXQLPC0MueGrGHyb9jkZRAOLU/a5vGqvMXvXUJEjBelwV46h9JPCGXM/gnKwngEPkgijFnHQv8ppY8RwCRSr+vrf80CbwT7ihfMcglmCK34jpJ/em+whOOW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777940867; c=relaxed/simple;
	bh=HageMQ77INdDXdvwF/mB+wcQSqkX+jiMsu2ThXNuUzs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NeuxJenC7jq6giyNAgT6TfOElI3/6KonxurPjYX/VIkswevHBNWsqCx+vlgIUyfninro53gd9Cx63QVYmiOGCyE6HGG4Ku3xHOWSWh7t6gz9PCWJOK3cRFlzdcPzeaVqWFuDX+94o+X2iBNziUww2rETTfMSZN1P3Edhdxs5hFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mWpXtkTq; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mWpXtkTq"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f6b984b3aso2344165b3a.3
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 17:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777940866; x=1778545666; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zufAZqrs7wE5NdNZHdqCW4lBwECX6d0FSow8KZpRsP8=;
        b=mWpXtkTqEPhpKLCX5HemLFPCMOr5bVyzVh4b4tSyCmyaqwg03qqTWTBtOfURmbbueC
         JIc0Vh56U9yQmjxwfxwAmie/F4AfHz5mEyarazWJNGNA5XcKgY5tiFalpwgtXPOigxVU
         S/Sg/Ipix7uzVsPBe9htK4BugYpFFLExKZIqRJkTFBb0mKgMpPo8s79qYgGRabm03K+h
         9BchUyBHqyV3VhdIrRibowxhkDtCvHJ6WRQSZnRL0qjUvKZOXB9veZ3Yw/S88gCbz/ZJ
         YIYi/yDpvvdQ7ev1USip5lDjtGMdv0lM5q/auyef4xGpl9OEPn+vGWAUICurlOD78IU7
         sCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777940866; x=1778545666;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zufAZqrs7wE5NdNZHdqCW4lBwECX6d0FSow8KZpRsP8=;
        b=sonzNLr+AHTj+FhQi20d5bAE74sTc2b56ewyOUUGk8JrW+GtL94HXr1o0OAPsQOerC
         IS+kPklk5y3ond+zfcwchBEOxWcdrzvJz8p3AM+Gt4S8Xqc/b2tdlLQ/TwpaR0XZQCOh
         FCQnRSjEej4Q+ej4v5z3J8+9lY47tC50HGw5g/Wf+obu8ib/P2ii53u47VxdDhEhJmZO
         8m8+pwsAMVGfMir7Lf+WZ98VhPvFggxtRag3zPuI1W/W5UmD+buZsbrvJLjxYrEQNjab
         MCEA2L2OJ+8bAGp1ZCf5eAx+AqXdelSLtEW3/THpwchlaZn5V1OOxTK6RohgH4lHLLam
         qovg==
X-Forwarded-Encrypted: i=1; AFNElJ/xWCnewSgtj3T7g9rxLcPdM0f4203vFhQ87AKaVrekGuu7kwsA11PiVf48k5r+o8I4lnBFrA==@lists.linux.dev
X-Gm-Message-State: AOJu0YybU3jm6MRoWdFR0lmH3x9QKf0I6F0PGzgArLiJJm5azTn5RuWo
	hzeICNXlGusiqSgHVRMGFuBp5puz4QcKO8FyVxlOynL2Om6jjwrTK+jFKYE5wrOSCAn7x+tfHFC
	3PVVvPP//5lo1Iw==
X-Received: from pfbmb14.prod.google.com ([2002:a05:6a00:760e:b0:838:5125:b5e4])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3003:b0:835:42cf:1f7a with SMTP id d2e1a72fcca58-83921ef6cf1mr905533b3a.6.1777940865363;
 Mon, 04 May 2026 17:27:45 -0700 (PDT)
Date: Tue,  5 May 2026 00:27:37 +0000
In-Reply-To: <20260505002737.2213734-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260505002737.2213734-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260505002737.2213734-5-skhawaja@google.com>
Subject: [RFC PATCH 4/4] dma-mapping: Add API to preserve/restore DMA allocation
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

Add new DMA APIs that allow preserving/restoring DMA allocations across
live update.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/dma-mapping.h | 50 +++++++++++++++++++++++++++++++++++
 kernel/dma/mapping.c        | 52 +++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index db8ab24a54f4..3756fc15467b 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -210,6 +210,15 @@ void *dma_vmap_noncontiguous(struct device *dev, size_t size,
 void dma_vunmap_noncontiguous(struct device *dev, void *vaddr);
 int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
 		size_t size, struct sg_table *sgt);
+#ifdef CONFIG_DMA_LIVEUPDATE
+int dma_preserve_allocation_attrs(struct device *dev, void *cpu_addr,
+				  size_t size, dma_addr_t dma_handle,
+				  unsigned long attrs, u64 *state);
+void dma_unpreserve_allocation(struct device *dev, u64 state);
+void *dma_restore_allocation_attrs(struct device *dev, size_t size,
+				   dma_addr_t *dma_handle, gfp_t gfp,
+				   unsigned long attrs, u64 state);
+#endif
 #else /* CONFIG_HAS_DMA */
 static inline dma_addr_t dma_map_page_attrs(struct device *dev,
 		struct page *page, size_t offset, size_t size,
@@ -496,6 +505,26 @@ static inline bool dma_need_unmap(struct device *dev)
 }
 #endif /* !CONFIG_HAS_DMA || !CONFIG_DMA_NEED_SYNC */
 
+#if !defined(CONFIG_DMA_LIVEUPDATE) || !defined(CONFIG_HAS_DMA)
+static inline int dma_preserve_allocation_attrs(struct device *dev, void *cpu_addr,
+						size_t size, dma_addr_t dma_handle,
+						unsigned long attrs, u64 *state)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void dma_unpreserve_allocation(struct device *dev, u64 state)
+{
+}
+
+static inline void *dma_restore_allocation_attrs(struct device *dev, size_t size,
+						 dma_addr_t *dma_handle, gfp_t gfp,
+						 unsigned long attrs, u64 state)
+{
+	return NULL;
+}
+#endif
+
 struct page *dma_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
 void dma_free_pages(struct device *dev, size_t size, struct page *page,
@@ -618,6 +647,27 @@ static inline void *dma_alloc_coherent(struct device *dev, size_t size,
 			(gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0);
 }
 
+static inline int dma_preserve_coherent_allocation(struct device *dev, void *cpu_addr,
+						   size_t size, dma_addr_t dma_handle, u64 *state)
+{
+	return dma_preserve_allocation_attrs(dev, cpu_addr, size,
+					     dma_handle, 0, state);
+}
+
+static inline void dma_unpreserve_coherent_allocation(struct device *dev, u64 state)
+{
+	dma_unpreserve_allocation(dev, state);
+}
+
+static inline void *dma_restore_coherent_allocation(struct device *dev, size_t size,
+						    dma_addr_t *dma_handle,
+						    gfp_t gfp, u64 state)
+{
+	return dma_restore_allocation_attrs(dev, size, dma_handle, gfp,
+					    (gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0,
+					    state);
+}
+
 static inline void dma_free_coherent(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_handle)
 {
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 23ed8eb9233e..c315b74a0884 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -12,6 +12,8 @@
 #include <linux/gfp.h>
 #include <linux/iommu-dma.h>
 #include <linux/kmsan.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/dma_alloc.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
@@ -628,6 +630,56 @@ u64 dma_get_required_mask(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(dma_get_required_mask);
 
+#ifdef CONFIG_DMA_LIVEUPDATE
+int dma_preserve_allocation_attrs(struct device *dev, void *cpu_addr,
+				  size_t size, dma_addr_t dma_handle,
+				  unsigned long attrs, u64 *state)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+#ifdef CONFIG_DMA_DECLARE_COHERENT
+	return -EOPNOTSUPP;
+#endif
+
+	if (dma_alloc_direct(dev, ops))
+		return dma_direct_preserve_allocation(dev, cpu_addr, size,
+						      dma_handle, attrs,
+						      state);
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(dma_preserve_allocation_attrs);
+
+void dma_unpreserve_allocation(struct device *dev, u64 state)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (dma_alloc_direct(dev, ops))
+		dma_direct_unpreserve_allocation(dev, state);
+}
+EXPORT_SYMBOL(dma_unpreserve_allocation);
+
+void *dma_restore_allocation_attrs(struct device *dev, size_t size,
+				   dma_addr_t *dma_handle, gfp_t gfp,
+				   unsigned long attrs, u64 state)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	WARN_ON_ONCE(!dev->coherent_dma_mask);
+
+#ifdef CONFIG_DMA_DECLARE_COHERENT
+	return NULL;
+#endif
+
+	if (dma_alloc_direct(dev, ops))
+		return dma_direct_restore_allocation(dev, size, dma_handle,
+						     gfp, attrs, state);
+
+	return NULL;
+}
+EXPORT_SYMBOL(dma_restore_allocation_attrs);
+#endif
+
 void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t flag, unsigned long attrs)
 {
-- 
2.54.0.545.g6539524ca2-goog

