Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875E43815EB
	for <iommu@lists.linux.dev>; Wed,  8 Apr 2026 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677682; cv=none; b=HMcLpZodYEI+j/fwz9C6ez+ZcQ7fTQ3dEOA5Uyve1iTDp0Lva1WZKcLDTEW18Y2SPCEzQsutI7XXJfbgEQMFfhaX1XQGRjkiN2TaEyERjeBBH0uqBM0KUi+gOO64glTLc3/mOngDiy5UvnZH/ypJjyiuK/oBBnJVDkpQT/xTw6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677682; c=relaxed/simple;
	bh=Wap6lbG/SCEnn+rOeCGCnUqunIqCe5Tn1Ow/jjzxAEc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sOHdo2aHwHRxwUPIMb75qmq0qGY50X+RMd3Vd7nXHN0S9Z6d/81GeVdruoB9StG8DP2bW6DGqJRNncT2cWgMRy7tMVV48DsbCG9tDWGo6+7swN059UVNK2yPX+nO4X5sTuo9+HxydtRqr4XX6WmlBIFCZeBZlqJ/VzJe3zSimVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+OSHY9a; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+OSHY9a"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-486fa07f2bbso343355e9.2
        for <iommu@lists.linux.dev>; Wed, 08 Apr 2026 12:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775677677; x=1776282477; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FmQc+pnXBAjV16L6lXzAX5g89yFxEhVx/QorzEaCsdc=;
        b=k+OSHY9axSc5uGwOwGzdFf0p6ginKwaj2yLR8z2sYUQ+6eZzyn/YZRQlyzJAq/q6Fq
         HZg9I+gcLEwJEvUnLUx4MV8mZaMytVHsGIN9/Oh/i2DlPZmqREUWeczM1uJKqq/KKsRb
         iUw3KVkUJaUcTLMIQCwuHTZgcMEgoryD7hfKf0tkaxnV/0vCKZD+IYK9bpxRhhFY3Bh+
         1N08lEfAkZi4wBymqTbqWGACHkF+PV/Q7mdPypgtBHwMSC72OtAXZyBkIyJ5KJdFeiRN
         wqbtel1sVN3VfRW59hjhEEejdg4LmlB10P48RFSI9CJiJS3MxrkT6KAKIv1hIytDUyKM
         DevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775677677; x=1776282477;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FmQc+pnXBAjV16L6lXzAX5g89yFxEhVx/QorzEaCsdc=;
        b=BVXpZLOtGv0TLIxuF3AxNH1aA5p679Mps/N3Qsv5suTxzhpxJn4KlKZT7qLLBG1sLE
         8EKXEtN0Dw7X9OYu4wV/m7wd+qOq0vPH1hv/4SI5raYlM+EjtYbY+BrF19xclWOq9jyL
         2aP+t4KgF8RGsqQT1yNmCASF8Zv9841PNIsyRQeCG0ccx1jKqXSZsc5gjDcYIYS3DIg8
         FPzFZEVHait2wKB3biWGBBa/BAeX9/mQvUuhpKbC5tTHJ42lB0QXMNww8f1BTt216W8m
         +sJ1qxcIL3u9c1ypE+sOC5pZvEV8vE3LWcJH40lQ5ta00MNH/zC5IYP83HmCz6F/7a1m
         JP1w==
X-Gm-Message-State: AOJu0YzzvLDA2v8LV+Ylj9X0mCbrOb5/glpc5P/RikyahsArMoL9hwy1
	1HmHWs4HnW4BeLkpKqZUJVU0BC/LebVU5dM81ulhuFXTrlioVnxNrs6V66+bGwPGsj+ErE3Qtai
	4DqwUA1IMZApUM8bKanJYElKVoiHvhVeoIVyqG17IkUyI7I+rBjRwjP7p8R1CabKvlea8291sHk
	Vukm9hhWG5b7uqxhr+vGZOuaWliiQkKSVC/NYZut41nDojnw==
X-Received: from wmbgx14.prod.google.com ([2002:a05:600c:858e:b0:488:a474:87b6])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8597:b0:487:575:5e1 with SMTP id 5b1f17b1804b1-488cd008ec4mr10978775e9.24.1775677676908;
 Wed, 08 Apr 2026 12:47:56 -0700 (PDT)
Date: Wed,  8 Apr 2026 19:47:40 +0000
In-Reply-To: <20260408194750.2280873-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260408194750.2280873-1-smostafa@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408194750.2280873-4-smostafa@google.com>
Subject: [RFC PATCH v3 3/5] dma-mapping: Decrypt memory on remap
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org, 
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com, 
	jiri@resnulli.us, jgg@ziepe.ca, aneesh.kumar@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

In case memory needs to be remapped on systems with
force_dma_unencrypted(), where this memory is not allocated
from a restricted-dma pool, this was currently ignored, while only
setting the decrypted pgprot in the remapped alias.

The memory still needs to be decrypted in that case.

With memory decryption, don't allow highmem allocations, but that
shouldn't be a problem on such modern systems.

Also, move force_dma_unencrypted() outside of dma_set_* to make it
clear to be able to use more generic logic to decided memory
state.

Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Fixes: f3c962226dbe ("dma-direct: clean up the remapping checks in dma_direct_alloc")
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 kernel/dma/direct.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index ce74f213ec40..de63e0449700 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -79,8 +79,6 @@ bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 
 static int dma_set_decrypted(struct device *dev, void *vaddr, size_t size)
 {
-	if (!force_dma_unencrypted(dev))
-		return 0;
 	return set_memory_decrypted((unsigned long)vaddr, PFN_UP(size));
 }
 
@@ -88,8 +86,6 @@ static int dma_set_encrypted(struct device *dev, void *vaddr, size_t size)
 {
 	int ret;
 
-	if (!force_dma_unencrypted(dev))
-		return 0;
 	ret = set_memory_encrypted((unsigned long)vaddr, PFN_UP(size));
 	if (ret)
 		pr_warn_ratelimited("leaking DMA memory that can't be re-encrypted\n");
@@ -206,7 +202,7 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
 void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
-	bool remap = false, set_uncached = false, encrypt = false;
+	bool remap = false, set_uncached = false, decrypt = force_dma_unencrypted(dev);
 	struct page *page;
 	void *ret;
 
@@ -215,7 +211,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		gfp |= __GFP_NOWARN;
 
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
-	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev))
+	    !decrypt && !is_swiotlb_for_alloc(dev))
 		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
 
 	if (!dev_is_dma_coherent(dev)) {
@@ -249,12 +245,15 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	 * Remapping or decrypting memory may block, allocate the memory from
 	 * the atomic pools instead if we aren't allowed block.
 	 */
-	if ((remap || force_dma_unencrypted(dev)) &&
+	if ((remap || decrypt) &&
 	    dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
-	/* we always manually zero the memory once we are done */
-	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
+	/*
+	 * we always manually zero the memory once we are done, and only allow
+	 * high mem if pages doesn't need decryption.
+	 */
+	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, !decrypt);
 	if (!page)
 		return NULL;
 
@@ -268,10 +267,12 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		set_uncached = false;
 	}
 
+	if (decrypt && dma_set_decrypted(dev, page_address(page), size))
+		goto out_leak_pages;
 	if (remap) {
 		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
 
-		if (force_dma_unencrypted(dev))
+		if (decrypt)
 			prot = pgprot_decrypted(prot);
 
 		/* remove any dirty cache lines on the kernel alias */
@@ -281,11 +282,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		ret = dma_common_contiguous_remap(page, size, prot,
 				__builtin_return_address(0));
 		if (!ret)
-			goto out_free_pages;
+			goto out_encrypt_pages;
 	} else {
 		ret = page_address(page);
-		if (dma_set_decrypted(dev, ret, size))
-			goto out_leak_pages;
 	}
 
 	memset(ret, 0, size);
@@ -301,9 +300,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	return ret;
 
 out_encrypt_pages:
-	encrypt = true;
-out_free_pages:
-	__dma_direct_free_pages(dev, page, size, encrypt);
+	__dma_direct_free_pages(dev, page, size, decrypt);
 	return NULL;
 out_leak_pages:
 	return NULL;
@@ -366,7 +363,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 		return NULL;
 
 	ret = page_address(page);
-	if (dma_set_decrypted(dev, ret, size))
+	if (force_dma_unencrypted(dev) && dma_set_decrypted(dev, ret, size))
 		goto out_leak_pages;
 	memset(ret, 0, size);
 	*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
-- 
2.53.0.1213.gd9a14994de-goog

