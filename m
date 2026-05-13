Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E8F3C8C68
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778709170; cv=none; b=TsU/bi0mMQ9U+2QwHBeRqMlrAkKpHeGDNZ/bSAtZLyuaF3YdBLJFwO26gDdimLLXmQGfBIGrgL1YUf1G1lVfSuRFEuHjoTdAR4wU2yEUIT+Z346vq2QUV3u7jYsEwQTPqMXd71Uf0Zk2d1jnq5RA9dFOLoR4rnX9tFe/UOClKKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778709170; c=relaxed/simple;
	bh=mXVlQJDDIGQCBNIOAsjtzOYRiA0kS/fRbsolMHrau7I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V8uSdYJQAN+nU20DtXYuL6N90k1SYL6yU3/Q34213ZC3z2CQ53WL+/e//q8zKLkNSPA12Abn+OKRXQefVnR2cI5ad5L14h76EEk66U744/GNEf5th5d+Eqh/nJTqs2/8fnEYyfLjNTfFfPFJ+FowTu52RuONSkdLMFwayiKs9y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=akS8rWz2; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="akS8rWz2"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-67daff082b7so7276390a12.1
        for <iommu@lists.linux.dev>; Wed, 13 May 2026 14:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778709168; x=1779313968; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VmY5S5fM8AoCCFdXEvoltLd2gDk1b3FPoGY3dWz/ZhU=;
        b=akS8rWz2E8YWB1VwFcpiJjlrswMA2mP8dNI9SKSBSB2g1HDzBFgNfRfH/USbsnOXit
         XZ7DsK1OcopkuEfWJ9OTFM8viTHyc/0wSulNb2wdh/lJJj8tyWGjGYVGknW6bl2dMfc2
         VLoZPFtg/SR/XNYV7kvmqHMLSwGQEobciWlTS7JNr4hTbgZpeqDaKL1R9/dtptHWnmCD
         BIP/PeejYzHcZRZlLL1aVTH+gDmmlgl8kWg+8mlMbVo7wFBBmt7hN7lo42Ov6F2y+weD
         WzWg+3D+A/Ag6ghqdVcdc71zmpWYsjkYL8jCXRpYnctN3d6IQlLez+Gy908OmhRkXY9+
         pVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778709168; x=1779313968;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VmY5S5fM8AoCCFdXEvoltLd2gDk1b3FPoGY3dWz/ZhU=;
        b=ZrEZAmPIggOdwCKzWZkPBJ7KJk2l/yM6T6g7o+TjmlkOBj+icx5LGS2qf15FfoCjpH
         QcV/48x8Bm1HtKaJKIu7Kb0DkacSd2LDaKov1UZIgDEvQJ8Ki1GYGAsUSI4S4Tm7LNZa
         gGbwebYDPc++WzDm8gi94aniTpMKvOHeDpryYnxMBFcrmT04A7K9bB0KoEFFtWzzB49g
         Rfqj92/467BCI+F6Q0NNWJUEFG0tlUGbc++9++NTqd/pu6JKGJFPlB2xb92Q3bwDHpR2
         IjWpYyt6Xhr0ewd+w49iCrTX0aTb18WzO3sh6nDydAhGrKcAEfyGpAw3ReaNqVIOLFFc
         RRuA==
X-Gm-Message-State: AOJu0YwPdODSbwtfW69gUkUaXyS2xSfePLhByEK1l+vFK/AET3tBAu5V
	Ct7G6E46J8MEOvXfsgh1CKTPfZDQIhusuEzGpv1sn03vOz8aoqpTXMeJrQ2dn7aMJUcuo4cMLU2
	NdyqChT//5i2zL86ul7mflb6XJ+uLQTF9fbPHs3Telvub6XiOhkJWMKGctWEd7FCLjOD/5m1zbX
	FbUaoFfyHOTV1KcCkuWPUNVLhOU16JfM2wnjlPKi1ax1p8jw==
X-Received: from edbel4.prod.google.com ([2002:a05:6402:3604:b0:67c:d93d:89cd])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:8cb:b0:66d:d2f9:520c with SMTP id 4fb4d7f45d1cf-68256d5afa3mr2319843a12.19.1778709167343;
 Wed, 13 May 2026 14:52:47 -0700 (PDT)
Date: Wed, 13 May 2026 21:52:02 +0000
In-Reply-To: <20260513215203.3852661-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260513215203.3852661-1-smostafa@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260513215203.3852661-3-smostafa@google.com>
Subject: [PATCH 2/3] iommu/io-pgtable-arm: Rework to use the iommu-pages API
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, will@kernel.org, joro@8bytes.org, jgg@ziepe.ca, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Update the io-pgtable-arm allocator to use the iommu-pages API.

Replace the DMA API usage from __arm_lpae_alloc_pages() with
iommu_pages_start_incoherent() and from __arm_lpae_free_pages() with
iommu_pages_free_incoherent().

Since the iommu-pages API relies on metadata stored in the struct page
during iommu_alloc_pages_node_sz(), it cannot be used safely with memory
allocated via the custom cfg->alloc (which may not be backed by pages).
So, isolate that logic and keep it as it.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 drivers/iommu/io-pgtable-arm.c | 79 ++++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 0cbe545c491d..86b23aa04324 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -248,24 +248,15 @@ static dma_addr_t __arm_lpae_dma_addr(void *pages)
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
 	dma_addr_t dma;
 	void *pages;
 
-	/*
-	 * For very small starting-level translation tables the HW requires a
-	 * minimum alignment of at least 64 to cover all cases.
-	 */
-	size = max(size, 64);
-	if (cfg->alloc)
-		pages = cfg->alloc(cookie, size, gfp);
-	else
-		pages = iommu_alloc_pages_node_sz(dev_to_node(dev), gfp, size);
-
+	pages = cfg->alloc(cookie, size, gfp);
 	if (!pages)
 		return NULL;
 
@@ -289,14 +280,55 @@ static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
 	dma_unmap_single(dev, dma, size, DMA_TO_DEVICE);
 
 out_free:
-	if (cfg->free)
-		cfg->free(cookie, pages, size);
-	else
-		iommu_free_pages(pages);
-
+	cfg->free(cookie, pages, size);
 	return NULL;
 }
 
+static void __arm_lpae_cfg_free(void *pages, size_t size,
+				struct io_pgtable_cfg *cfg,
+				void *cookie)
+{
+	if (!cfg->coherent_walk)
+		dma_unmap_single(cfg->iommu_dev, __arm_lpae_dma_addr(pages),
+				 size, DMA_TO_DEVICE);
+
+	cfg->free(cookie, pages, size);
+}
+
+static void *__arm_lpae_alloc_pages(size_t size, gfp_t gfp,
+				    struct io_pgtable_cfg *cfg,
+				    void *cookie)
+{
+	struct device *dev = cfg->iommu_dev;
+	void *pages;
+
+	/*
+	 * For very small starting-level translation tables the HW requires a
+	 * minimum alignment of at least 64 to cover all cases.
+	 */
+	size = max(size, 64);
+
+	if (cfg->alloc)
+		return __arm_lpae_cfg_alloc(size, gfp, cfg, cookie);
+
+	pages = iommu_alloc_pages_node_sz(dev_to_node(dev), gfp, size);
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
 static void __arm_lpae_free_pages(void *pages, size_t size,
 				  struct io_pgtable_cfg *cfg,
 				  void *cookie)
@@ -304,12 +336,13 @@ static void __arm_lpae_free_pages(void *pages, size_t size,
 	/* See __arm_lpae_alloc_pages(). */
 	size = max(size, 64);
 
-	if (!cfg->coherent_walk)
-		dma_unmap_single(cfg->iommu_dev, __arm_lpae_dma_addr(pages),
-				 size, DMA_TO_DEVICE);
+	if (cfg->free) {
+		__arm_lpae_cfg_free(pages, size, cfg, cookie);
+		return;
+	}
 
-	if (cfg->free)
-		cfg->free(cookie, pages, size);
+	if (!cfg->coherent_walk)
+		iommu_pages_free_incoherent(pages, cfg->iommu_dev);
 	else
 		iommu_free_pages(pages);
 }
-- 
2.54.0.563.g4f69b47b94-goog

