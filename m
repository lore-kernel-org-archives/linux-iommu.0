Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD073AFAE0
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554543; cv=none; b=Vx60rQKDCHDZll74cdxMLeyI+Z5O+4yUVhSmsn5cli5prvHlJSGEsVS5YVUXf5oHcKdiFd7cSL7bzC1C0E4dNbY9DdiR4Bjs0J+9WbBJK3Ypd2pqjCWmqHqFCjkoCD5XUgtcPh6Ow9sfBhK25A02+btqOuoTIvI0sFYeihDhVVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554543; c=relaxed/simple;
	bh=PVTFuMn7F4PLTSzD7pwLWPN9v2JrvWM/BmAGmuEMeYY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jHGXRxQ6IGy7IhGygBaE+DbKNFBlbUI9X3De9QZQPMQw+NknIZlxQaY1X6sOvx391uNG9V7SWSAjmMc+ObyMBxR0TqfjCXYL2xiu3bMlY4BVZQPUx1YlE78SC9IODDgaJhKXWp/CxQ8T++7noFmXvXXSvWjYNuVs4jOjJkfolBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B2j0YqsB; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B2j0YqsB"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-84857446424so441663b3a.1
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 16:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554541; x=1784159341; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mg8HPDVADkikyFkQazKzK0at34W1Wn3VUkaO82xr5dA=;
        b=B2j0YqsBNQjy+K3EE4jtXIZS3s5w9eSk2eKcDurTeRL0udnENRCmF34LM50gf3MM4W
         8LlqwDLaCVD+yTpOdrE8WfM3WqyIVjcubP6LlsqPhVUwvqNj8+YxggMWZUL6Myq2Kisd
         E94HYsltbNagNhjBOWxY2hHb1NcFBlkslDoEZn2HIlbBGakPuacL4EE8J46DGw0Kgaj6
         u2tuKbZSFfOhlJrKhvuNj62PnRDONJkq3+fSXqwvomPp7n4+257goEgy5As7i8btpH91
         BTvG7wM6NLohLVAYnratk2EFfoRtFjlP87PrsvUxVxxyqHovZY5YKphIqg6kYC+gEat6
         Qb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554541; x=1784159341;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mg8HPDVADkikyFkQazKzK0at34W1Wn3VUkaO82xr5dA=;
        b=WnDLJ51nohUpzAMlMYNvwhNTYEjIGLBfNLDsjVYxqN6DtTsyptyXjDGSwHxY1Wx+vr
         8CqTEfHaFB0eqtqTyM7zMJ7UuU11P8GSzRyrpqSNyY+nGlYYKjK2hLT6+ZqRVBnmCFpz
         Ah7rJS4gd78mbCXeZfWXVf5a4GYiK7sFKMdnD77DNgg/uU/vnChfTYJ+MFC+sD0CMV2h
         vx4VpXMLfLLCs9+EglDjUp217OCvjZTG3lKHUAuMuLPz3Pximc+Ml0V25r9F3d6LWEW7
         EyKVDRo3FqjZ6OMSIlH0e7LmfSDepMFbs1R93c0dZwcRfqyO1z3L0k177dCiydImVB4s
         awaA==
X-Forwarded-Encrypted: i=1; AHgh+RppbUm4yQNyTYSRgdBVNrHF79i3dLKCht6B5qYGgEEKE7NB18zoaUPla6e7V+7barCvCRgwDA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/uepA4dJ9+FGUgfafz3GmHEdPNaybBwmFWO95tqH9mqFEJAhG
	0MTdHrJm0ByMnM2afFLi0gjPzlJRSfy/kR1mHDeYLsZWupMgNSyZN+a+s+W6QVg4Sy+SgCrpKA+
	DHGr90yrjGgyQ3g==
X-Received: from pfoc15.prod.google.com ([2002:aa7:880f:0:b0:847:ada8:bf86])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1826:b0:842:706e:ad43 with SMTP id d2e1a72fcca58-8484324665bmr4017531b3a.33.1783554541070;
 Wed, 08 Jul 2026 16:49:01 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:51 +0000
In-Reply-To: <20260708234854.4044652-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260708234854.4044652-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-8-skhawaja@google.com>
Subject: [RFC PATCH v2 07/10] dma-mapping: Add support of preserving dmam allocations
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

Device drivers use dmam_* allocation APIs for managed lifecycle of DMA
allocations. Add support of preserving managed DMA allocations so these
can be preserved and on restore these are managed again.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/dma-mapping.h | 50 ++++++++++++++++++++++
 kernel/dma/mapping.c        | 83 +++++++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 3756fc15467b..4c0c428b6b1c 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -218,6 +218,14 @@ void dma_unpreserve_allocation(struct device *dev, u64 state);
 void *dma_restore_allocation_attrs(struct device *dev, size_t size,
 				   dma_addr_t *dma_handle, gfp_t gfp,
 				   unsigned long attrs, u64 state);
+int dmam_preserve_allocation_attrs(struct device *dev, void *cpu_addr,
+				   size_t size, dma_addr_t dma_handle,
+				   unsigned long attrs, u64 *state);
+void dmam_unpreserve_allocation(struct device *dev, void *cpu_addr,
+				size_t size, dma_addr_t dma_handle, u64 state);
+void *dmam_restore_allocation_attrs(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t gfp,
+				    unsigned long attrs, u64 state);
 #endif
 #else /* CONFIG_HAS_DMA */
 static inline dma_addr_t dma_map_page_attrs(struct device *dev,
@@ -523,6 +531,25 @@ static inline void *dma_restore_allocation_attrs(struct device *dev, size_t size
 {
 	return NULL;
 }
+
+static inline int dmam_preserve_allocation_attrs(struct device *dev, void *cpu_addr,
+						 size_t size, dma_addr_t dma_handle,
+						 unsigned long attrs, u64 *state)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void dmam_unpreserve_allocation(struct device *dev, void *cpu_addr,
+					      size_t size, dma_addr_t dma_handle, u64 state)
+{
+}
+
+static inline void *dmam_restore_allocation_attrs(struct device *dev, size_t size,
+						  dma_addr_t *dma_handle, gfp_t gfp,
+						  unsigned long attrs, u64 state)
+{
+	return NULL;
+}
 #endif
 
 struct page *dma_alloc_pages(struct device *dev, size_t size,
@@ -797,6 +824,29 @@ static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
 			(gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0);
 }
 
+static inline int dmam_preserve_coherent_allocation(struct device *dev, void *cpu_addr,
+						    size_t size, dma_addr_t dma_handle, u64 *state)
+{
+	return dmam_preserve_allocation_attrs(dev, cpu_addr, size,
+					      dma_handle, 0, state);
+}
+
+static inline void dmam_unpreserve_coherent_allocation(struct device *dev, void *cpu_addr,
+						       size_t size, dma_addr_t dma_handle,
+						       u64 state)
+{
+	dmam_unpreserve_allocation(dev, cpu_addr, size, dma_handle, state);
+}
+
+static inline void *dmam_restore_coherent_allocation(struct device *dev, size_t size,
+						     dma_addr_t *dma_handle,
+						     gfp_t gfp, u64 state)
+{
+	return dmam_restore_allocation_attrs(dev, size, dma_handle, gfp,
+					     (gfp & __GFP_NOWARN) ? DMA_ATTR_NO_WARN : 0,
+					     state);
+}
+
 static inline void *dma_alloc_wc(struct device *dev, size_t size,
 				 dma_addr_t *dma_addr, gfp_t gfp)
 {
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 3b07bf30722c..aec1222ab5ae 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -37,12 +37,25 @@ struct dma_devres {
 	void		*vaddr;
 	dma_addr_t	dma_handle;
 	unsigned long	attrs;
+#ifdef CONFIG_DMA_LIVEUPDATE
+	bool is_preserved;
+#endif
 };
 
 static void dmam_release(struct device *dev, void *res)
 {
 	struct dma_devres *this = res;
 
+#ifdef CONFIG_DMA_LIVEUPDATE
+	/*
+	 * Freeing the preserved memory is dangerous as it can cause UAF in the
+	 * current or next kernel if the memory is still being used by the
+	 * device.
+	 */
+	if (WARN_ON(this->is_preserved))
+		return;
+#endif
+
 	dma_free_attrs(dev, this->size, this->vaddr, this->dma_handle,
 			this->attrs);
 }
@@ -675,6 +688,76 @@ void *dma_restore_allocation_attrs(struct device *dev, size_t size,
 	return cpu_addr;
 }
 EXPORT_SYMBOL(dma_restore_allocation_attrs);
+
+int dmam_preserve_allocation_attrs(struct device *dev, void *cpu_addr,
+				   size_t size, dma_addr_t dma_handle,
+				   unsigned long attrs, u64 *state)
+{
+	struct dma_devres match_data = { size, cpu_addr, dma_handle };
+	struct dma_devres *dr;
+	int ret;
+
+	dr = devres_find(dev, dmam_release, dmam_match, &match_data);
+	if (!dr)
+		return -EINVAL;
+
+	if (dr->is_preserved)
+		return -EINVAL;
+
+	ret = dma_preserve_allocation_attrs(dev, cpu_addr, size, dma_handle, attrs, state);
+	if (ret)
+		return ret;
+
+	dr->is_preserved = true;
+	return 0;
+}
+EXPORT_SYMBOL(dmam_preserve_allocation_attrs);
+
+void dmam_unpreserve_allocation(struct device *dev, void *cpu_addr,
+				size_t size, dma_addr_t dma_handle, u64 state)
+{
+	struct dma_devres match_data = { size, cpu_addr, dma_handle };
+	struct dma_devres *dr;
+
+	dr = devres_find(dev, dmam_release, dmam_match, &match_data);
+	if (!dr)
+		return;
+
+	if (!dr->is_preserved)
+		return;
+
+	dma_unpreserve_allocation(dev, state);
+	dr->is_preserved = false;
+}
+EXPORT_SYMBOL(dmam_unpreserve_allocation);
+
+void *dmam_restore_allocation_attrs(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t gfp,
+				    unsigned long attrs, u64 state)
+{
+	struct dma_devres *dr;
+	void *vaddr;
+
+	dr = devres_alloc(dmam_release, sizeof(*dr), gfp);
+	if (!dr)
+		return NULL;
+
+	vaddr = dma_restore_allocation_attrs(dev, size, dma_handle, gfp, attrs, state);
+	if (!vaddr) {
+		devres_free(dr);
+		return NULL;
+	}
+
+	dr->vaddr = vaddr;
+	dr->dma_handle = *dma_handle;
+	dr->size = size;
+	dr->attrs = attrs;
+
+	devres_add(dev, dr);
+
+	return vaddr;
+}
+EXPORT_SYMBOL(dmam_restore_allocation_attrs);
 #endif
 
 void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
-- 
2.55.0.795.g602f6c329a-goog

