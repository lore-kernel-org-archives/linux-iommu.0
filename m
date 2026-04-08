Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1854A3815F2
	for <iommu@lists.linux.dev>; Wed,  8 Apr 2026 19:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677685; cv=none; b=tt1VEGeM9bYKZzeFAv8Dozzo+XoZYJ7hlU1XOVacS6djPRyDOO2IPJ6hZIBqSMiF6/2X6B4Ax6DdwX5IGLEf4aZuTvVagLJDh0o7Jd+kyfswJrqMkAEbgGcXr9UDD7w+q6hKloAO1rjCJZkhlez37GYABFEYshF8Sizm0A286pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677685; c=relaxed/simple;
	bh=c5G7I4UDifLrETkTh7TKGEdYvvLFqIwAGOJBOKM1n6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZOizB5bl5Wy+y1p/GwohNTHZeaIxGyeF99s6ea+1msVsnVX/QlJJX+FDxahLETS5x+UwlDs/X7Ep2l6OCZKDIXV6fMAWdu61dXpmPjQuZoZ9B2MEh6MwR5+uuQQ+e5MnIb7uGln4UFL59Y3Juicx8RhcXITf8nxIu1UuYgwjMyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IwfcCXgv; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IwfcCXgv"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48887ff8b73so454475e9.2
        for <iommu@lists.linux.dev>; Wed, 08 Apr 2026 12:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775677679; x=1776282479; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I8Ii68uqF49RZqdN3es99368zeVz3d5ax63VAcg1ZH4=;
        b=IwfcCXgvQi9F3DM0HcWqMMvLO3mJdN12PDlTquco6qn8NJMhiKmr72S5MVJUUjshFE
         dpPUYTf81s6YA++d6B6sxA5iNtVmHd1vEqBOl2RPZdNdNvmQIjELjd5jFR/yxa9E12a2
         XFU2bFYdLPAhoFdbwzM/LFPUOqvAh2AJxhzKUBmDZeu87X0F7VCybMaFliIudoXsQJNh
         aqYnpvg0jDRNE2SGi9UE8ng8ZGTFz2XIbZ10qfpJ20UErbZZWYXFCunmHBD8Dv0maWii
         PD6DLMwD251PZZ9H7KRJD08TBTtK3I2RbPyeuBLMTHy4G45cmhtkvGAoAloehsaG34XH
         oX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775677679; x=1776282479;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8Ii68uqF49RZqdN3es99368zeVz3d5ax63VAcg1ZH4=;
        b=SLoRdG3Z0WkoF06SOrO4dQt+Ezq0mLaNDZ0xijIn+Q6GeC3RZBf5xfpc9Q4Q4HFpXZ
         FSdS7UTXsk7aPiVRn8aKwf5tG3abWBlWOEsGnqCxXEQtdPvXRUsmMMtFeNQ1wfOmldL2
         s6iHQb7pzXluwqJRS5uFBHrR6Vhw/L9mgkkJSPQKiYm/xbVgU3XonksKLXbubDIKp/fG
         GtJDOHLMDDZxHmFrAe7RYMyVnMUb5BjeErvJIX0tnH9SXXywY6+Jd6BZUTjN2tGvJFDU
         aYD3FCXJHIo1UI22Oo61il3+O6B3dLSxcfKS3i7Uk6KgqWk4xdPAfenuLsKGWC7hzO5A
         D5Sg==
X-Gm-Message-State: AOJu0YzkfVoLsupvC3Ms+SdzmIrbH5ESZhxNqf9Qkf2qi9yUego/DFxw
	jfAfJnB2mFUgXHqjMqCr+g/zqmb5kSj8LraRmbAnCsTqmbq6M4vr1O5TgDB2rFBe+e9SZ3WgVZ0
	tJEFSCZbVxUgpkiNcfsbU6KcLAKnuZ7xvJ1OIVYTtCdwgKQhq3JeIWHoHF4/gEsqMQoQr1hMcVm
	I5hHIiXBdCFg93Q12i2FRHx70agRaTCA5e7JAR6ykOpSb14w==
X-Received: from wmdd5.prod.google.com ([2002:a05:600c:a205:b0:488:9a47:9aa0])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3549:b0:485:41c4:e2e4 with SMTP id 5b1f17b1804b1-488997d2ccemr289069375e9.23.1775677679080;
 Wed, 08 Apr 2026 12:47:59 -0700 (PDT)
Date: Wed,  8 Apr 2026 19:47:42 +0000
In-Reply-To: <20260408194750.2280873-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260408194750.2280873-1-smostafa@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408194750.2280873-6-smostafa@google.com>
Subject: [RFC PATCH v3 5/5] dma-mapping: Fix memory decryption issues
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org, 
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com, 
	jiri@resnulli.us, jgg@ziepe.ca, aneesh.kumar@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix 2 existing issues:
1) In case a device have a restricted DMA pool, memory will be
decrypted (which is now returned in the state from swiotlb_alloc().

Later the main function  will attempt to decrypt the memory if
force_dma_unencrypted() is true.

Which results in the memory being decrypted twice.
Change that to only encrypt/decrypt memory that is not already
decrypted as indicated in the new dma_page struct.

2) Using phys_to_dma_unencrypted() is not enlighted about already
decrypted memory and will use the wrong functions for that.

Fixes: f4111e39a52a ("swiotlb: Add restricted DMA alloc/free support")
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 kernel/dma/direct.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 204bc566480c..26611d5e5757 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -43,6 +43,11 @@ static inline struct page *dma_page_to_page(struct dma_page dma_page)
 	return (struct page *)(dma_page.val & ~DMA_PAGE_DECRYPTED_FLAG);
 }
 
+static inline bool is_dma_page_decrypted(struct dma_page dma_page)
+{
+	return dma_page.val & DMA_PAGE_DECRYPTED_FLAG;
+}
+
 /*
  * Most architectures use ZONE_DMA for the first 16 Megabytes, but some use
  * it for entirely different regions. In that case the arch code needs to
@@ -51,9 +56,9 @@ static inline struct page *dma_page_to_page(struct dma_page dma_page)
 u64 zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
 
 static inline dma_addr_t phys_to_dma_direct(struct device *dev,
-		phys_addr_t phys)
+					    phys_addr_t phys, bool already_decrypted)
 {
-	if (force_dma_unencrypted(dev))
+	if (already_decrypted || force_dma_unencrypted(dev))
 		return phys_to_dma_unencrypted(dev, phys);
 	return phys_to_dma(dev, phys);
 }
@@ -67,7 +72,7 @@ static inline struct page *dma_direct_to_page(struct device *dev,
 u64 dma_direct_get_required_mask(struct device *dev)
 {
 	phys_addr_t phys = (phys_addr_t)(max_pfn - 1) << PAGE_SHIFT;
-	u64 max_dma = phys_to_dma_direct(dev, phys);
+	u64 max_dma = phys_to_dma_direct(dev, phys, false);
 
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
@@ -96,7 +101,7 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
 
 bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
-	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys);
+	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys, false);
 
 	if (dma_addr == DMA_MAPPING_ERROR)
 		return false;
@@ -122,11 +127,14 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
 static void __dma_direct_free_pages(struct device *dev, struct page *page,
 				    size_t size, bool encrypt)
 {
-	if (encrypt && dma_set_encrypted(dev, page_address(page), size))
+	bool keep_encrypted = swiotlb_is_decrypted(dev, page, size);
+
+	if (!keep_encrypted && encrypt && dma_set_encrypted(dev, page_address(page), size))
 		return;
 
 	if (swiotlb_free(dev, page, size))
 		return;
+
 	dma_free_contiguous(dev, page, size);
 }
 
@@ -205,7 +213,7 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
 	if (!page)
 		return NULL;
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page), false);
 	return ret;
 }
 
@@ -225,7 +233,8 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
 		arch_dma_prep_coherent(page, size);
 
 	/* return the page pointer as the opaque cookie */
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page),
+					 is_dma_page_decrypted(dma_page));
 	return page;
 }
 
@@ -234,6 +243,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 {
 	bool remap = false, set_uncached = false, decrypt = force_dma_unencrypted(dev);
 	struct dma_page dma_page;
+	bool already_decrypted;
 	struct page *page;
 	void *ret;
 
@@ -289,6 +299,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
+	already_decrypted = is_dma_page_decrypted(dma_page);
 	/*
 	 * dma_alloc_contiguous can return highmem pages depending on a
 	 * combination the cma= arguments and per-arch setup.  These need to be
@@ -299,12 +310,13 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		set_uncached = false;
 	}
 
-	if (decrypt && dma_set_decrypted(dev, page_address(page), size))
+	if (!already_decrypted && decrypt &&
+	    dma_set_decrypted(dev, page_address(page), size))
 		goto out_leak_pages;
 	if (remap) {
 		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
 
-		if (decrypt)
+		if (decrypt || already_decrypted)
 			prot = pgprot_decrypted(prot);
 
 		/* remove any dirty cache lines on the kernel alias */
@@ -328,11 +340,11 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 			goto out_encrypt_pages;
 	}
 
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page), already_decrypted);
 	return ret;
 
 out_encrypt_pages:
-	__dma_direct_free_pages(dev, page, size, decrypt);
+	__dma_direct_free_pages(dev, page, size, decrypt && !already_decrypted);
 	return NULL;
 out_leak_pages:
 	return NULL;
@@ -385,6 +397,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
 	struct dma_page dma_page;
+	bool already_decrypted;
 	struct page *page;
 	void *ret;
 
@@ -396,11 +409,13 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (!page)
 		return NULL;
 
+	already_decrypted = is_dma_page_decrypted(dma_page);
 	ret = page_address(page);
-	if (force_dma_unencrypted(dev) && dma_set_decrypted(dev, ret, size))
+	if (!already_decrypted && force_dma_unencrypted(dev) &&
+	    dma_set_decrypted(dev, ret, size))
 		goto out_leak_pages;
 	memset(ret, 0, size);
-	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page), already_decrypted);
 	return page;
 out_leak_pages:
 	return NULL;
-- 
2.53.0.1213.gd9a14994de-goog

