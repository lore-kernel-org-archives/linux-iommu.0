Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C467C4B8DE4
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778090813; cv=none; b=oaQSIFjJB5Rc9g/n/mDi4ncv7/CYt43MVbBPvlgG7Pa6/qPaygzMWna6hzDRknk+13I5XABjWLneKhxUQSSd8dfbE2rxHCLukBHcpXEa4jMZNW0+MmBPJxrKpX4EOJR5FHqd5KGIzRHxCkDFaqsV/e3oeUBrsqGktzmGjCKABHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778090813; c=relaxed/simple;
	bh=XMUkfGBqGHRl2Qmuvo2NWgJYpIC+bwtX8lQsG8v6MwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YX7OASQ18Jsodqh3H+QXd1X73+4YaH36OljLJ6K5rz02/qpBeGNuoqknihShCbYvkDeDicXgz965rYaRi+2fTfQuZrt4Q9tymZ6hrmC4mQVq0oeF6TR7XL5/7D7MoV8W8NPMnb8/n+PPe47dnVT6xr/2eAZth/DMIYGLkI7Q1Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=niogFOoG; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="niogFOoG"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso15155ad.0
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 11:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778090810; x=1778695610; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1SCkx6Yh6YZ1BPi+tG3iQfCUha6CFKOYQ/X+Py4gHbo=;
        b=niogFOoGu7/06Mfb44FLhb4KF+IPL42ZIGo+6FWvguVFcSo7j1fKcVwCy98jCR/Bll
         o1mrphXB8r2CjmGiCiB5lbBE9ujgdcZKUq4paIZSpvi6rs8nVBcgDvbGj/XVkMV443bu
         4gcnJYY2q/uTJZskCrk7iFVS6DiopxKsWflmJwzkdkpPFSQhKT34lKRFxp9UDHv5CxSx
         POysC8TOAGehHUYTh5tARn2wxjOKce5vhBOG+6dW8xvlFL0lfsxq/GtnhKSkpc4Qq3PP
         YPsaSXgpkdW0xgew3n0ne6VX6o5/XUZXV66QStyVe1k/aocU8tmV1a2KCbp+39twt2ex
         +WnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778090810; x=1778695610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SCkx6Yh6YZ1BPi+tG3iQfCUha6CFKOYQ/X+Py4gHbo=;
        b=hfHRfRBZaSS7XJww1n+YBKS2kIx4oJ3Vq1JNM3vt+K0jF+DXfNMBFYfKYdI/SNky7+
         EWxYdYF/XPEoNsqiblI/BC8236wAD7Ay+Gj0kgfAVwjDOHZnOFOaxojy9NMDL+a1HpEf
         oKR3CK4ARnoLluedqCe48GS2e03GjyhePVldjib0Lo00Q7SeqF5d5o1dUci49U86xgKg
         XDcPIZhK9P7ZrQriu9hAzcx/rmZOEgKQlRQ47CuibW+1j3qZYV9D2CfCLC5ftAOaRxgJ
         F0eW81v4Gm6fEpX3lOFevZ8g3SkDjFEfg/2DkUYjlNZTRAD0BAUiaN8W7lb01uIpxwhQ
         cyNA==
X-Forwarded-Encrypted: i=1; AFNElJ/pvsS/P67u3nVfqJ9O38JCi1+S8/13v7R3uBcvLM4gLgjvcL9wdh/Jh54RxA+pjxfSGS9/DQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZbH79+gpxWv2Ud8f8gmKYE372ogpYSmybtzimCQdvYkrgaDJ9
	w8Hg/Iy8YcCQpeN7IhQ+zjlp88Gr5Dd+fgX/mhFp3W/O3AOfT91hIPSLoMRb1UbIoxp8kDCfHmC
	4yAkcAA==
X-Gm-Gg: AeBDiet5sSTuYiHXsNaxDHm21VC9WQSrnoxL55GBh2ryeIAqDq3hdA9m+cCZbUbGOuS
	ZGPhEmhAxjKZu73bmpK+XFZeGMJHGK3R7VexCLkI8DjmR8hCtKw+oBiBjvOcpxWK94x5/IgA+gc
	hqOqb6z0EaZ+87ffjeyBmTKXSlKJdzjGJ2+k8UpjICme/YUC/ZaXQmR3sJbJxt1WIfSZtC41ZGI
	tsRcIb8YOo2oVFC7v0T9HmLKFVByJrPD2ZpVAQd0xlp4eiOeH/4JeBo+McKiE+16m677eg9HFqd
	qBvuhhZIryy0J2ay9aisp9R0hhLpT8KgtPP2rMQzRo9hm2veD52pU80+JEwEHUW2pplQh8xUNEg
	PdMqcg/E72Hq6B1zQf7/Gt0Y1tH+qRTGThAI1Sh/DUOaA/GKweeaX8x2y86NAt+t+k+pQtmNAYy
	WT6oy2xXsltqVYqGJ5kBJkdgCks2K/QqnRsWVortexnyMlNeVroArBQtLN+XXimkak0Y/osZDJ7
	Cm4vIiu
X-Received: by 2002:a17:903:124b:b0:2b9:a39a:e5db with SMTP id d9443c01a7336-2bab63fdaeemr399045ad.7.1778090809148;
        Wed, 06 May 2026 11:06:49 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7c9e1af7sm32405505ad.46.2026.05.06.11.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 11:06:48 -0700 (PDT)
Date: Wed, 6 May 2026 18:06:45 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	ntb@lists.linux.dev
Subject: Re: [PATCH v2 5/6] dma-debug: Feed DMA attribute for unmapping flows
 too
Message-ID: <afuDLtR6Q1W2_VO5@google.com>
References: <20260501-dma-attrs-debug-v2-0-8dbac75cd501@nvidia.com>
 <20260501-dma-attrs-debug-v2-5-8dbac75cd501@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260501-dma-attrs-debug-v2-5-8dbac75cd501@nvidia.com>

On Fri, May 01, 2026 at 09:35:09AM +0300, Leon Romanovsky wrote:
>From: Leon Romanovsky <leonro@nvidia.com>
>
>There are multiple unmapping flows which didn't provide DMA attributes,
>which limited DMA debug code to compare the mapping and unmapping
>attributes. Let's fix it.
>
>Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>---
> kernel/dma/debug.c   | 13 ++++++++-----
> kernel/dma/debug.h   | 19 +++++++++++--------
> kernel/dma/mapping.c |  8 ++++----
> 3 files changed, 23 insertions(+), 17 deletions(-)
>
>diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
>index f07e6a1e9fbab..3dfed51c3d9aa 100644
>--- a/kernel/dma/debug.c
>+++ b/kernel/dma/debug.c
>@@ -1307,8 +1307,8 @@ void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
> }
> EXPORT_SYMBOL(debug_dma_mapping_error);
>
>-void debug_dma_unmap_phys(struct device *dev, dma_addr_t dma_addr,
>-			  size_t size, int direction)
>+void debug_dma_unmap_phys(struct device *dev, dma_addr_t dma_addr, size_t size,
>+			  int direction, unsigned long attrs)
> {
> 	struct dma_debug_entry ref = {
> 		.type           = dma_debug_phy,
>@@ -1316,6 +1316,7 @@ void debug_dma_unmap_phys(struct device *dev, dma_addr_t dma_addr,
> 		.dev_addr       = dma_addr,
> 		.size           = size,
> 		.direction      = direction,
>+		.attrs          = attrs,
> 	};
>
> 	if (unlikely(dma_debug_disabled()))
>@@ -1381,7 +1382,7 @@ static int get_nr_mapped_entries(struct device *dev,
> }
>
> void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
>-			int nelems, int dir)
>+			int nelems, int dir, unsigned long attrs)
> {
> 	struct scatterlist *s;
> 	int mapped_ents = 0, i;
>@@ -1399,6 +1400,7 @@ void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
> 			.size           = sg_dma_len(s),
> 			.direction      = dir,
> 			.sg_call_ents   = nelems,
>+			.attrs          = attrs,
> 		};
>
> 		if (mapped_ents && i >= mapped_ents)
>@@ -1454,8 +1456,8 @@ void debug_dma_alloc_coherent(struct device *dev, size_t size,
> 	add_dma_entry(entry);
> }
>
>-void debug_dma_free_coherent(struct device *dev, size_t size,
>-			 void *virt, dma_addr_t dma_addr)
>+void debug_dma_free_coherent(struct device *dev, size_t size, void *virt,
>+			     dma_addr_t dma_addr, unsigned long attrs)
> {
> 	struct dma_debug_entry ref = {
> 		.type           = dma_debug_coherent,
>@@ -1463,6 +1465,7 @@ void debug_dma_free_coherent(struct device *dev, size_t size,
> 		.dev_addr       = dma_addr,
> 		.size           = size,
> 		.direction      = DMA_BIDIRECTIONAL,
>+		.attrs          = attrs,
> 	};
>
> 	/* handle vmalloc and linear addresses */
>diff --git a/kernel/dma/debug.h b/kernel/dma/debug.h
>index 24b8610850fbd..13e384633c32a 100644
>--- a/kernel/dma/debug.h
>+++ b/kernel/dma/debug.h
>@@ -14,21 +14,22 @@ extern void debug_dma_map_phys(struct device *dev, phys_addr_t phys,
> 			       unsigned long attrs);
>
> extern void debug_dma_unmap_phys(struct device *dev, dma_addr_t addr,
>-				 size_t size, int direction);
>+				 size_t size, int direction,
>+				 unsigned long attrs);
>
> extern void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
> 			     int nents, int mapped_ents, int direction,
> 			     unsigned long attrs);
>
> extern void debug_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
>-			       int nelems, int dir);
>+			       int nelems, int dir, unsigned long attrs);
>
> extern void debug_dma_alloc_coherent(struct device *dev, size_t size,
> 				     dma_addr_t dma_addr, void *virt,
> 				     unsigned long attrs);
>
>-extern void debug_dma_free_coherent(struct device *dev, size_t size,
>-				    void *virt, dma_addr_t addr);
>+extern void debug_dma_free_coherent(struct device *dev, size_t size, void *virt,
>+				    dma_addr_t addr, unsigned long attrs);
>
> extern void debug_dma_sync_single_for_cpu(struct device *dev,
> 					  dma_addr_t dma_handle, size_t size,
>@@ -59,7 +60,8 @@ static inline void debug_dma_map_phys(struct device *dev, phys_addr_t phys,
> }
>
> static inline void debug_dma_unmap_phys(struct device *dev, dma_addr_t addr,
>-					size_t size, int direction)
>+					size_t size, int direction,
>+					unsigned long attrs)
> {
> }
>
>@@ -70,8 +72,8 @@ static inline void debug_dma_map_sg(struct device *dev, struct scatterlist *sg,
> }
>
> static inline void debug_dma_unmap_sg(struct device *dev,
>-				      struct scatterlist *sglist,
>-				      int nelems, int dir)
>+				      struct scatterlist *sglist, int nelems,
>+				      int dir, unsigned long attrs)
> {
> }
>
>@@ -82,7 +84,8 @@ static inline void debug_dma_alloc_coherent(struct device *dev, size_t size,
> }
>
> static inline void debug_dma_free_coherent(struct device *dev, size_t size,
>-					   void *virt, dma_addr_t addr)
>+					   void *virt, dma_addr_t addr,
>+					   unsigned long attrs)
> {
> }
>
>diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>index 6cbefbd4158c8..f010b3cc0ece4 100644
>--- a/kernel/dma/mapping.c
>+++ b/kernel/dma/mapping.c
>@@ -225,7 +225,7 @@ void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
> 	else if (ops->unmap_phys)
> 		ops->unmap_phys(dev, addr, size, dir, attrs);
> 	trace_dma_unmap_phys(dev, addr, size, dir, attrs);
>-	debug_dma_unmap_phys(dev, addr, size, dir);
>+	debug_dma_unmap_phys(dev, addr, size, dir, attrs);
> }
> EXPORT_SYMBOL_GPL(dma_unmap_phys);
>
>@@ -351,7 +351,7 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>
> 	BUG_ON(!valid_dma_direction(dir));
> 	trace_dma_unmap_sg(dev, sg, nents, dir, attrs);
>-	debug_dma_unmap_sg(dev, sg, nents, dir);
>+	debug_dma_unmap_sg(dev, sg, nents, dir, attrs);
> 	if (dma_map_direct(dev, ops) ||
> 	    arch_dma_unmap_sg_direct(dev, sg, nents))
> 		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
>@@ -693,7 +693,7 @@ void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
> 	if (!cpu_addr)
> 		return;
>
>-	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle);
>+	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle, attrs);
> 	if (dma_alloc_direct(dev, ops) || arch_dma_free_direct(dev, dma_handle))
> 		dma_direct_free(dev, size, cpu_addr, dma_handle, attrs);
> 	else if (use_dma_iommu(dev))
>@@ -840,7 +840,7 @@ void dma_free_noncontiguous(struct device *dev, size_t size,
> 		struct sg_table *sgt, enum dma_data_direction dir)
> {
> 	trace_dma_free_sgt(dev, sgt, size, dir);
>-	debug_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir);
>+	debug_dma_unmap_sg(dev, sgt->sgl, sgt->orig_nents, dir, 0);
>
> 	if (use_dma_iommu(dev))
> 		iommu_dma_free_noncontiguous(dev, size, sgt, dir);
>
>-- 
>2.53.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
