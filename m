Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7307C1DFFD
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777897186; cv=none; b=mJ8LWcAZnoTZFf9ChWzECAYQraJe9JUxmW2/qLQDM6QeS06C/lhsO0/vFuEk46JKLyHziO1uugCWwqRQq3cICCWuWo6OFa9Eu5oSiaS/jmWv3G36xBQUq+UCuhQY/YKJsKwgPSAzQVtJ6XeKyakKCJcGcGMne0VskXJqFXh7hjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777897186; c=relaxed/simple;
	bh=9ePXNcpJXNpBucWE7Um02jeLVCQaYHO77fP8l6NTbXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPqPM58elojIFCetCgpIfas2YLl0yr0tWlUWYqUAYacasN18+AxbDRtvMqeoAR1Cuthr763AKVfQQ3JD1s7KrpiA3o/iSSoqurdgxLaR3e5J5dUyfA+370HIW1Gxc4u8K3kegvw2gjNgglSeJIgeUebtE0X8yCtFmfLhW1VvSM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U94ZfjFB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U94ZfjFB"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891ad5c074so202855e9.0
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 05:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777897183; x=1778501983; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PZFwKQCzFDeKBEEx0s8dTkXKr01dndAPiIRslPFEQHw=;
        b=U94ZfjFBnY7AO3uOUXtDwORfczZ0YWYIl+hDFef1JvXoztd8eJYoeFNOYi/X4fC6fO
         hIG9vkMSIfLnxEB8Yzrt1/nA7zig9RGEwTuWiLwIR+3q4LhyM8oX3SunVL5eVnaOqUQW
         BzuFYbgtXlJHrKjwvB2JDEBmlbmWa5cN2U54k/MjyyXWv9s8HQOvotX7PmeIdF/2fwZg
         EqJ8Zg6VDVyO8qaXkdBniiCBcpVSOzjtx+MZb65w9cSNpQLP649raKW+YWQwaaHXmULS
         Eeap3+JWL16OKdziceZmA75SVLtDVD8ItQSeeAwxyJCR22AtIOyKBcm2U/gU9FCyWlbd
         ly+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777897183; x=1778501983;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZFwKQCzFDeKBEEx0s8dTkXKr01dndAPiIRslPFEQHw=;
        b=JD0Zqa+8HXptZixkxGcv7zk9fQ2ctFZ0N7WZn9htpNU58RUqW7MyVe+oZXMEXnQpTt
         h4N5X5WcKFzd+AFRFd32tVkPViN6GoaaMQfIUkfQk815WwEvm8LOsi7odQykXwdfoQ67
         KbihznGK0yNdwu5RiWK4WMA1Mv5KqN8UhY2+6zvckUtFmFhicXci2PxgiOmHTBiS+UXs
         NZ/vf0Ujfid4VClwqVh+X5PFq1taDx18ohvPpW8E1hGWixsyv9tLLRgEStgMg6ZDd5/7
         mWQm3XgqN73pEkJjfON/5iZLpkrXRRpStmCzyQF7WMmh+4jCyTJat9ncITrTd52j+qZb
         5Jow==
X-Forwarded-Encrypted: i=1; AFNElJ/WyjYyirLwELWb13fro/ItM4e9oqkswePXDB+4MPNoUobjiBNj96rSxBD9tWTdIDT1GeIx3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNbTMQsAbfaa5Y6FKfYQbPNulOmyX4Qe9xeBWG+4Kfq/VBPhTb
	RzUdzRNB2CuE2CIWXf9uZG6PnKnHzxrODGDP5t3sXg0NCdH6FCGk14Q3A9/l+Vc1Dw==
X-Gm-Gg: AeBDiev8luyGGxr6P9zzTEFD7JyhWepKXKOAU2WPQOZ9JXQv0q8AehF9nsMld4dZ9zM
	LSQZ7eZ5tbxcD8IuEYfTqAnzgiCqIh7NWb3m0mOMCp984C2c0FhVDsQD14Qg9TYU4mfT8tdR6yu
	PAQG6KXR+ofLWllwfKKwA/gIsxzU1KnBeeDL6mu1/moh8LGZFMWVH/KQb+/1VtNWTeoWK0kKjbm
	/MoDsZjJWRqL3msk02KCI5gF70dn4jJRvsz9Gvcu0nGRj30p7UbpzKKArtpTS8n1KLEICAiU9PL
	qdrNRR9O/RMutRBOhBWKCSFp5C+c7DJ9Hvg0h2ZrslsscUaF/t7dBRZnXAy7VqqKFlUFB3tGWum
	9m47aO7YsEwxgyDwt07ZjfZFdU8n7vOx1AVELA9k6quxXreKjkguktr34Pc+R0y3O2T9rwuwDd9
	1Y50COrm5KJ2VffXAKgZV+BsJSQ1TaykJSSxt6THiiVE4AZwB2Pf7WaigYQq77/BftanVZpnq03
	okHqw==
X-Received: by 2002:a05:600c:6089:b0:488:960f:60b8 with SMTP id 5b1f17b1804b1-48a9852d054mr1083545e9.6.1777897182533;
        Mon, 04 May 2026 05:19:42 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fea7de6sm78783785e9.12.2026.05.04.05.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:19:41 -0700 (PDT)
Date: Mon, 4 May 2026 12:19:37 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 06/25] iommu/io-pgtable-arm: Rework to use the
 iommu-pages API
Message-ID: <afiO2WL4ILGfmUui@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-7-smostafa@google.com>
 <20260501122424.GA6912@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260501122424.GA6912@ziepe.ca>

On Fri, May 01, 2026 at 09:24:24AM -0300, Jason Gunthorpe wrote:
> On Fri, May 01, 2026 at 11:19:08AM +0000, Mostafa Saleh wrote:
> > To prepare for supporting io-pgtable-arm in the pKVM hypervisor,
> > we need to abstract away standard kernel allocations, frees, virt/phys
> > conversions, and DMA API mapping.
> > 
> > This patch introduces a set of generic wrappers in iommu-pages.h:
> > - iommu_alloc_data
> > - iommu_free_data
> > - iommu_virt_to_phys
> > - iommu_phys_to_virt
> > - iommu_pages_dma_map
> > - iommu_pages_dma_mapping_error
> > - iommu_pages_dma_unmap
> 
> Wah? This has nothing to do with iommu pages? This just leaking
> everything iommu pages abstracted out :(
> 
> When I said to use iommu-pages, I meant to use the existing API, not a
> completely different one.
> 
> From an iommu-pages perspective the issue is this code open codes
> dma_map_single()/etc instead of using the API surface
> iommu_pages_start_incoherent()
> 
> This is annoying to fix beacuse the external allocator messes it up,
> but I think with some #ifdef you can probably fix it up.
> 
> So.. I suggest you update it to use the iommu_pages API, #ifdef out
> the allocator so the pkvm pkvm doesn't need to deal with it. Then
> compile a special iommu-pages for the pkvm side presenting the same
> API.

I see, we still need to leave the DMA-API calls for the custom config,
as I am not sure if it can use pages not backed by the vmemmap, I
pushed that into a separate function so it’s easily compiled out.

Without this patch, now it looks like:

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 0208e5897c29..1583b9916b09 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -248,26 +248,15 @@ static dma_addr_t __arm_lpae_dma_addr(void *pages)
 	return (dma_addr_t)virt_to_phys(pages);
 }

-static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
-				    struct io_pgtable_cfg *cfg,
-				    void *cookie)
+static void *__arm_lpae_cfg_alloc(size_t size, gfp_t gfp,
+				  struct io_pgtable_cfg *cfg,
+				  void *cookie)
 {
 	struct device *dev = cfg->iommu_dev;
-	size_t alloc_size;
 	dma_addr_t dma;
 	void *pages;

-	/*
-	 * For very small starting-level translation tables the HW requires a
-	 * minimum alignment of at least 64 to cover all cases.
-	 */
-	alloc_size = max(size, 64);
-	if (cfg->alloc)
-		pages = cfg->alloc(cookie, alloc_size, gfp);
-	else
-		pages = iommu_alloc_pages_node_sz(dev_to_node(dev), gfp,
-						  alloc_size);
-
+	pages = cfg->alloc(cookie, size, gfp);
 	if (!pages)
 		return NULL;

@@ -289,26 +278,67 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 out_unmap:
 	dev_err(dev, "Cannot accommodate DMA translation for IOMMU page tables\n");
 	dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
-
 out_free:
-	if (cfg->free)
-		cfg->free(cookie, pages, size);
-	else
-		iommu_free_pages(pages);
-
+	cfg->free(cookie, pages, size);
 	return NULL;
 }

-static void __arm_lpae_free_pages(void *pages, size_t size,
-				  struct io_pgtable_cfg *cfg,
-				  void *cookie)
+static void __arm_lpae_cfg_free(void *pages, size_t size,
+				struct io_pgtable_cfg *cfg,
+				void *cookie)
 {
 	if (!cfg->coherent_walk)
 		dma_unmap_single(cfg->iommu_dev, __arm_lpae_dma_addr(pages),
 				 size, DMA_TO_DEVICE);

-	if (cfg->free)
-		cfg->free(cookie, pages, size);
+	cfg->free(cookie, pages, size);
+}
+
+static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
+				    struct io_pgtable_cfg *cfg,
+				    void *cookie)
+{
+	struct device *dev = cfg->iommu_dev;
+	size_t alloc_size;
+	void *pages;
+
+	/*
+	 * For very small starting-level translation tables the HW requires a
+	 * minimum alignment of at least 64 to cover all cases.
+	 */
+	alloc_size = max(size, 64);
+	if (cfg->alloc)
+		return __arm_lpae_cfg_alloc(alloc_size, gfp, cfg, cookie);
+
+	pages = iommu_alloc_pages_node_sz(dev_to_node(dev), gfp, alloc_size);
+	if (!pages)
+		return NULL;
+
+	if (!cfg->coherent_walk) {
+		int ret = iommu_pages_start_incoherent(pages, dev);
+
+		if (ret) {
+			if (ret == -EOPNOTSUPP)
+				dev_err(dev, "Cannot accommodate DMA translation for IOMMU page tables\n");
+			iommu_free_pages(pages);
+			return NULL;
+		}
+	}
+
+	return pages;
+}
+
+static void __arm_lpae_free_pages(void *pages, size_t size,
+				  struct io_pgtable_cfg *cfg,
+				  void *cookie)
+{
+	if (cfg->free) {
+		__arm_lpae_cfg_free(pages, size, cfg, cookie);
+		return;
+	}
+
+	if (!cfg->coherent_walk)
+		iommu_pages_free_incoherent(pages, cfg->iommu_dev);
 	else
 		iommu_free_pages(pages);
 }


Thanks,
Mostafa

> 
> You should have a pkvm shim header that provides
> kmalloc/kfree/virt_to_phys in the normal way and just #include that in
> io-pgtable when doing a pkvm build instead of hacking up all the code.

Ok, I can do that in another change, but I believe it's better to
change the usage in this file to arm_lpae_*(virt_to_phys...) so it's
clear which parts are intended for that.

Thanks,
Mostafa

> 
> Jason
