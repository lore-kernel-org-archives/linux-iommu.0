Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6037F8D9
	for <iommu@lists.linux.dev>; Wed,  8 Apr 2026 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677679; cv=none; b=g3pMQs6O5sAdC2ssF0Burp1xfsVaiX4KaevC7ZvxD0qXXMc7Ia1XT7ttiauRG7hdW8nsbQd23GVHM0fj4K9tGbjvHv5rMOKWbGJK5fzYqruPjwtSbnY43TMhB35PM/5D/ZEqydrl5WNmop/cK6tXwq1sfHZLhz/9FKCHqUubZ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677679; c=relaxed/simple;
	bh=MTYNkJlUHc2hk2wVY4COdGRvfk5v8kr43GQAGEytGr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D4qiYMlSK31UL7KTGA1yDQylab645xSCyDM1xDVGfXINZnkpkOcbqEUs7TEsEnq+bbNY9knuz19Xl9XGrWQAEnYZzKc+2ebfCfMOICVVSQCqcYg+WyDJ3faegQvAMCoeHuv/4OQl5CVwbIroxsoTiLW5UWmEa20YBoTx6JWozwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r0VpHxmw; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r0VpHxmw"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-488b966e9dbso677045e9.3
        for <iommu@lists.linux.dev>; Wed, 08 Apr 2026 12:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775677676; x=1776282476; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R9wr9J2jjZi9zDgPEShl28f6yfD5q9/Iu+uj378SHds=;
        b=r0VpHxmwztf7JhWptsBPDLrXaYjgrF3pZL50oRCGgmHK9Axx8/kTFBhdTKXFPTP7M8
         foyjOL6DzKRnoJjF7I+QbWQKxSuRieFW2fVLZ2WrfcFAEz/Bf2vyVjuuqKwyB3ND1JtZ
         yAcH9MNlQK5rJqc/FEFQjDP1CQOQ7K9lzHdqFgMP1Gs1Etn9IBV+Kmmf7H6g1qb5GN/o
         UlRThJu+mIrMQ762n/S+tuZXZEFnTddyUGI+nlehOcmqaOKvgPBhxufnrm2D2tl8Wce0
         x7D6R4tJrHXbNJ48m6rOMYUq2E8YSDwJVO0KcGVp8bLE29NhU/vvt7HLS44vs9T76IyM
         QIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775677676; x=1776282476;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R9wr9J2jjZi9zDgPEShl28f6yfD5q9/Iu+uj378SHds=;
        b=XYScjvxktSLMNP1cm7YzVtM/W9eymDaCFZLTc6FQTOeWhMtUfw2QN+RXubJ3q/Pr/U
         XnC+VmACRPe+DruIErEqIglgDpUWRDMv+REst/nQ3Cz6fCsC3KLUJs3IvS7+Z5mBtBqv
         BUNGpa1efuSnTp37+LxuG9a9+Oq3Ye+RKwGlBt7sHhvY5OxMCQTJDkdISv6baVnlj4hC
         Jf4qVDml9v8FGW3fbOsocsQi5Mvo/XodTESgyM8+Y8DgkSiDEsi9mHEmyKnXuH2gtXjm
         DzrMFk+ksjml+Tmcn/I5Zgq2860bwchNo2a10Z/JimSbfYZIvQ0jELBnnL3TdJy5C1eG
         XJBA==
X-Gm-Message-State: AOJu0Yyl6haWXD8ajF++Zo/4e5BXtNScAdIX+ch6krgFIPWBcKeE6JdL
	t4HDnvLSVWSkdLD6dCV9IFIepdvwNY04w/VWPJdh6qN/xiHdci9cZY4k+1JnhJMw9Rk2bxjZ1aD
	eJf+Hz11lP3KMbwePrHWCNd2ydKJwmiYOOwE1iu+OSVVqo6ltIhMWeMAURIvggworTFehmjgfdP
	OoJhU7m9buK72jKFDN92lQ4iEHXKkuhSpWijA3Q+eC4FIALQ==
X-Received: from wmcn9.prod.google.com ([2002:a05:600c:c0c9:b0:485:3ee6:2d4])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b75:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-488997bcd86mr326807635e9.21.1775677675905;
 Wed, 08 Apr 2026 12:47:55 -0700 (PDT)
Date: Wed,  8 Apr 2026 19:47:39 +0000
In-Reply-To: <20260408194750.2280873-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260408194750.2280873-1-smostafa@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408194750.2280873-3-smostafa@google.com>
Subject: [RFC PATCH v3 2/5] dma-mapping: Move encryption in __dma_direct_free_pages()
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org, 
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com, 
	jiri@resnulli.us, jgg@ziepe.ca, aneesh.kumar@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

In the next patches, we will need to avoid encrypting memory allocated
from SWIOTLB, so instead of calling dma_set_encrypted() before
__dma_direct_free_pages(), call it inside, conditional on the memory
state passed to the function.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 kernel/dma/direct.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 6efb5973fbd3..ce74f213ec40 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -97,8 +97,11 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
 }
 
 static void __dma_direct_free_pages(struct device *dev, struct page *page,
-				    size_t size)
+				    size_t size, bool encrypt)
 {
+	if (encrypt && dma_set_encrypted(dev, page_address(page), size))
+		return;
+
 	if (swiotlb_free(dev, page, size))
 		return;
 	dma_free_contiguous(dev, page, size);
@@ -203,7 +206,7 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
 void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
-	bool remap = false, set_uncached = false;
+	bool remap = false, set_uncached = false, encrypt = false;
 	struct page *page;
 	void *ret;
 
@@ -298,10 +301,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	return ret;
 
 out_encrypt_pages:
-	if (dma_set_encrypted(dev, page_address(page), size))
-		return NULL;
+	encrypt = true;
 out_free_pages:
-	__dma_direct_free_pages(dev, page, size);
+	__dma_direct_free_pages(dev, page, size, encrypt);
 	return NULL;
 out_leak_pages:
 	return NULL;
@@ -311,6 +313,7 @@ void dma_direct_free(struct device *dev, size_t size,
 		void *cpu_addr, dma_addr_t dma_addr, unsigned long attrs)
 {
 	unsigned int page_order = get_order(size);
+	bool encrypt = false;
 
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
 	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
@@ -343,11 +346,10 @@ void dma_direct_free(struct device *dev, size_t size,
 	} else {
 		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
 			arch_dma_clear_uncached(cpu_addr, size);
-		if (dma_set_encrypted(dev, cpu_addr, size))
-			return;
+		encrypt = true;
 	}
 
-	__dma_direct_free_pages(dev, dma_direct_to_page(dev, dma_addr), size);
+	__dma_direct_free_pages(dev, dma_direct_to_page(dev, dma_addr), size, encrypt);
 }
 
 struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
@@ -384,9 +386,7 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 	    dma_free_from_pool(dev, vaddr, size))
 		return;
 
-	if (dma_set_encrypted(dev, vaddr, size))
-		return;
-	__dma_direct_free_pages(dev, page, size);
+	__dma_direct_free_pages(dev, page, size, true);
 }
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
-- 
2.53.0.1213.gd9a14994de-goog

