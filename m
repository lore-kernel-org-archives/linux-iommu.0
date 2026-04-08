Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D7D3815E3
	for <iommu@lists.linux.dev>; Wed,  8 Apr 2026 19:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677682; cv=none; b=jE2MzctYX7fIJeZt/Z8/M2QEfv4b+RRYp0J5AcFHRHiek8J4S8qIchaEm3Gp77ksvo/a8FNrwNRVBikAkZbi3TuYvc1pRlW3JeUocyIX1emphP+GUhOrFc5b1/9im7rQVQCDkB8clC6gI/E3rJrIxC8HSzVNLZ6vaeIvNhUzsz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677682; c=relaxed/simple;
	bh=ljnywAXYuD9yVasMcE6vMsdXOxIf5S7KW0HfwwIoGA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bsozyqTfMTVjIO2p5nh2MOsmNjVP5zfpBagTeEd2HfEVcLHNWv3xivsWdequ18/0dmvIFHvIi5VC7RmAaGnMYDdF1/3t+zVFdrdeBCK76LDNoMgzOJfQ4BehaVsD1nfkW0AdHSGNmZS+i7PlS/RiIna8cAqXXsoHYVF0sLRt+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TDo92xuw; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TDo92xuw"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso343495e9.2
        for <iommu@lists.linux.dev>; Wed, 08 Apr 2026 12:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775677678; x=1776282478; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0HFQ1jpsIj20Rmmvy6mz/JJ67LDNNDb4EoQDQuxQbic=;
        b=TDo92xuwa/HT84o4i6vBDKIz1xMx4RmDCLVlrtuatBoKfuvRZjnsBgo8J6lBvxcxXU
         4y2LeHyI8xng4Mw5R0ZEJVYbrowf4asBqRTS+jX9e0FH6bxNE1Dk1mZJhAmHVCUvnksS
         bnmxzFXdgU2TZCb0SZBGiw91FS1p58JBuZfjXFQBkFAyDdzFNs2HhpXKvI05CKqGUlTZ
         ZLcHLZamS4+XTSuy9HZ2LDa7MrBxyOpYnsYttpwX5k6tKEBGdQJp4LF5+E+OoX6pg/62
         ITxtkdYX4nwgONYr0BCbMAMoR+YbzjzA5QlE+ByNXZqmIDTssrvoTrABEaqC1q7tk130
         fXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775677678; x=1776282478;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0HFQ1jpsIj20Rmmvy6mz/JJ67LDNNDb4EoQDQuxQbic=;
        b=YpbpChoLa7rNQQojUShvpRZcbOe4GGogex6w+39LlNatZNKFCq+VV0fOLIRWY8JKFv
         3GIi2cun5HOuzoNXvtj3CFIydfVLdmRZw3d2zJCFU3gXRRQBTSLlRoDPgwSErmKcWv7L
         vKACRfhb8Jbf7D6rzJnDwUei3YYvTrAFp8ST1z4lslGQSBf03yRuBnUqb2BwsDSaswkO
         BH6fZYRrb0huNbZWFUOF4Remvk0SFWApxfer5+l8EEDE+oijgOkZw4QnEJCREasYCsPC
         lRkc2wWh3XnSm4jEa7Jhr36iWfRtAUfD2TcAWIfeRHrpmF4GDEh+HlnxjiUfj55IEWh3
         tiMQ==
X-Gm-Message-State: AOJu0Yz36Ky/9wb7Mey2uazVeVC4SXbiwnqLjfYiO5HwskgFCyIwOs6w
	CV11LX/ftWGnyL3mmTRhGf0acYja23bI2GrR2SQyOTH9/ZB/8VkR/smoVGeDjoutulQ+x55ePlh
	UtWHi0Qd7nOXcxOcjytrltMzPbJJIZCJBTfwtVZqwYz+Ejbglpsr3di85b8QWLwDPvkW2LqiyLy
	fJBQJv+Y2Y6XmTyew7cfOOCJlxz9aZm3ScdwTkLTaz9bXoAw==
X-Received: from wrbgl27-n2.prod.google.com ([2002:a05:6000:299b:20b0:43c:f8a2:96a5])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8710:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-488ccf3a129mr15045395e9.1.1775677678033;
 Wed, 08 Apr 2026 12:47:58 -0700 (PDT)
Date: Wed,  8 Apr 2026 19:47:41 +0000
In-Reply-To: <20260408194750.2280873-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260408194750.2280873-1-smostafa@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408194750.2280873-5-smostafa@google.com>
Subject: [RFC PATCH v3 4/5] dma-mapping: Encapsulate memory state during allocation
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org, 
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com, 
	jiri@resnulli.us, jgg@ziepe.ca, aneesh.kumar@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a new dma-direct internal type dma_page which is
"struct page" and a bit indicate whether the memory has been decrypted
or not.
This is useful to pass such information encapsulated through
allocation functions, which is currently set from swiotlb_alloc().

No functional changes.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 kernel/dma/direct.c | 58 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index de63e0449700..204bc566480c 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -16,6 +16,33 @@
 #include <linux/pci-p2pdma.h>
 #include "direct.h"
 
+/*
+ * Represent DMA allocation and 1 bit flag for it's state
+ */
+struct dma_page {
+	unsigned long val;
+};
+
+#define DMA_PAGE_DECRYPTED_FLAG		BIT(0)
+
+#define DMA_PAGE_NULL ((struct dma_page){ .val = 0 })
+
+static inline struct dma_page page_to_dma_page(struct page *page, bool decrypted)
+{
+	struct dma_page dma_page;
+
+	dma_page.val = (unsigned long)page;
+	if (decrypted)
+		dma_page.val |= DMA_PAGE_DECRYPTED_FLAG;
+
+	return dma_page;
+}
+
+static inline struct page *dma_page_to_page(struct dma_page dma_page)
+{
+	return (struct page *)(dma_page.val & ~DMA_PAGE_DECRYPTED_FLAG);
+}
+
 /*
  * Most architectures use ZONE_DMA for the first 16 Megabytes, but some use
  * it for entirely different regions. In that case the arch code needs to
@@ -103,20 +130,21 @@ static void __dma_direct_free_pages(struct device *dev, struct page *page,
 	dma_free_contiguous(dev, page, size);
 }
 
-static struct page *dma_direct_alloc_swiotlb(struct device *dev, size_t size)
+static struct dma_page dma_direct_alloc_swiotlb(struct device *dev, size_t size)
 {
-	struct page *page = swiotlb_alloc(dev, size, NULL);
+	enum swiotlb_page_state state;
+	struct page *page = swiotlb_alloc(dev, size, &state);
 
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 		swiotlb_free(dev, page, size);
-		return NULL;
+		return DMA_PAGE_NULL;
 	}
 
-	return page;
+	return page_to_dma_page(page, state == SWIOTLB_PAGE_DECRYPTED);
 }
 
-static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
-		gfp_t gfp, bool allow_highmem)
+static struct dma_page __dma_direct_alloc_pages(struct device *dev, size_t size,
+						gfp_t gfp, bool allow_highmem)
 {
 	int node = dev_to_node(dev);
 	struct page *page;
@@ -132,7 +160,7 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (page) {
 		if (dma_coherent_ok(dev, page_to_phys(page), size) &&
 		    (allow_highmem || !PageHighMem(page)))
-			return page;
+			return page_to_dma_page(page, false);
 
 		dma_free_contiguous(dev, page, size);
 	}
@@ -148,10 +176,10 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		else if (IS_ENABLED(CONFIG_ZONE_DMA) && !(gfp & GFP_DMA))
 			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
 		else
-			return NULL;
+			return DMA_PAGE_NULL;
 	}
 
-	return page;
+	return page_to_dma_page(page, false);
 }
 
 /*
@@ -184,9 +212,11 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
+	struct dma_page dma_page;
 	struct page *page;
 
-	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
+	dma_page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
+	page = dma_page_to_page(dma_page);
 	if (!page)
 		return NULL;
 
@@ -203,6 +233,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
 	bool remap = false, set_uncached = false, decrypt = force_dma_unencrypted(dev);
+	struct dma_page dma_page;
 	struct page *page;
 	void *ret;
 
@@ -253,7 +284,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * we always manually zero the memory once we are done, and only allow
 	 * high mem if pages doesn't need decryption.
 	 */
-	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, !decrypt);
+	dma_page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, !decrypt);
+	page = dma_page_to_page(dma_page);
 	if (!page)
 		return NULL;
 
@@ -352,13 +384,15 @@ void dma_direct_free(struct device *dev, size_t size,
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
 {
+	struct dma_page dma_page;
 	struct page *page;
 	void *ret;
 
 	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
-	page = __dma_direct_alloc_pages(dev, size, gfp, false);
+	dma_page = __dma_direct_alloc_pages(dev, size, gfp, false);
+	page = dma_page_to_page(dma_page);
 	if (!page)
 		return NULL;
 
-- 
2.53.0.1213.gd9a14994de-goog

