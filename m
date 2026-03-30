Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBE63264CD
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 14:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774882302; cv=none; b=IWu7PyxAJraiXf9F3lfPBSs4j7Oz/FU5pc1krAXiQMIorDbuXbWZPzzbJ3EJiefmyj3JpJn2LuRbFOb1kk7mdTBVcXK/eDW69v2N9x265L3/pEVZXqSGltGtaICBy5gmRRdNi3zskMMTec4+uumky1HYvnkQAd8lzVtnO3phBng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774882302; c=relaxed/simple;
	bh=blqPOdpFL9rgBFWqDEnMj0GQkW/94UGmtk6kjXsP/Ro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cG1XbyTit+CcNVa+NGqk3+t2BCzhh6j1+wUxoKgbcmng/RVtD37RNtsPIy8oYOGgc4Z74/Rgnh1I4fCwZiffK1xEXy8Rf/H+MHJAOORmFvN0gq4XCCiOT29hGavTvvZNYq3a4L6pdX7RnHGdkPsqS/nSZvVW8//gILWCgQQx6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HmIHnX9l; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HmIHnX9l"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-66bb46fd086so1124200a12.3
        for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774882299; x=1775487099; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=72NJpUNwgOjfnU3080YLnTh3b+2pO2EMQ9vDQPCjWLY=;
        b=HmIHnX9lhIhdT/5vGRFguwSwDEKAHeGjvnrMMLkqEMIVCeGJQC/vN3i79RnpourRq0
         djd6OPeML74+COEja+T2558ZqCySs0a2RZfxuYEaAWgRqHkFNzbk0uS6uFlHl3ilpGLw
         647kZLTPsdTXsdntJYkHLBiK7O03ByrTw9sFIrPMslvO/BkAHH0pJBPKcGa2AkfbMQ/b
         BY8t31z0jbaRwTGtiG8WLDo9pKUet+7pXPvschrcVVFxJsBEVcSpvIqZiA/UoB4y4wtg
         A3B8x47gq7+yAimbRwftrqlIZYjyyPA5gJT2pO3COiX0KuYap5IHaomzJYgBqIDIdD+c
         PVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774882299; x=1775487099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=72NJpUNwgOjfnU3080YLnTh3b+2pO2EMQ9vDQPCjWLY=;
        b=pxrYwtWAWeS56MCYFfxqV56O+54/GkdcverfGI5L5YYYvU9gEZFyFVBG30a5JAfwjf
         qo/HKxxFj8p59CfTi/15TRtMRzrt6Rh9+bmg71iYbUgXcWyJwH+v/sBhof3G02+Jgt1L
         p0ILdvqbpV9I++yFsk5szZHWfbiQ8Khj96oT+alDHNYZ2R4O3COi7fDV3Sk3X/J4AhbF
         vGN631b8qSK5gyY965+TANidvu4B1n7tHby4zktOn/NAZSd3vvZ4W2+gUy/PVlAzUL0K
         dOC4X94uoVnaPTpW60/iNsJcyrrr91/PPDvEi78S+gwVJ29Z9KKPKOlxLUNSkbH+Bg3t
         SuXQ==
X-Gm-Message-State: AOJu0Yz3uWSR37PsvcVwrqSVHJe8JRo7AUebKaqoBGJco6ALrazgy37v
	QLXtXdKbGLlWcuA4RimErA+rv8LmnXRzDKB/ScPm8HFSns2z4KmVigySa/6eXz91iH1u80m9K9E
	1KWOauZsHlrQqz0I0Az+3obgX0h3YtRnTCWZePcptYsSAlxSrZA0TaDXP2kIP4t6k17nrFInp33
	sSLisVB4RLwE9Y6l7VpmsMNEOfEl/op1oHupyMWz7CY7yGBw==
X-Received: from edcz13.prod.google.com ([2002:a05:6402:35cd:b0:66b:eb4d:db46])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:510d:b0:66c:7ab:1445 with SMTP id 4fb4d7f45d1cf-66c07ab16a4mr1183900a12.7.1774882298813;
 Mon, 30 Mar 2026 07:51:38 -0700 (PDT)
Date: Mon, 30 Mar 2026 14:50:41 +0000
In-Reply-To: <20260330145043.1586623-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260330145043.1586623-1-smostafa@google.com>
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Message-ID: <20260330145043.1586623-4-smostafa@google.com>
Subject: [RFC PATCH v2 3/5] dma-mapping: Decrypt memory on remap
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

Reported-by: Catalin Marinas <catalin.marinas@arm.com>
Fixes: f3c962226dbe ("dma-direct: clean up the remapping checks in dma_direct_alloc")
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 kernel/dma/direct.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 1a402bb956d9..a4260689bcc8 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -203,6 +203,7 @@ static void *dma_direct_alloc_no_mapping(struct device *dev, size_t size,
 void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
+	bool allow_highmem = !force_dma_unencrypted(dev);
 	bool remap = false, set_uncached = false;
 	struct page *page;
 	void *ret;
@@ -251,7 +252,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	/* we always manually zero the memory once we are done */
-	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, true);
+	page = __dma_direct_alloc_pages(dev, size, gfp & ~__GFP_ZERO, allow_highmem);
 	if (!page)
 		return NULL;
 
@@ -265,6 +266,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		set_uncached = false;
 	}
 
+	if (dma_set_decrypted(dev, page_address(page), size))
+		goto out_leak_pages;
+
 	if (remap) {
 		pgprot_t prot = dma_pgprot(dev, PAGE_KERNEL, attrs);
 
@@ -278,11 +282,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
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
@@ -300,7 +302,6 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 out_encrypt_pages:
 	if (dma_set_encrypted(dev, page_address(page), size))
 		return NULL;
-out_free_pages:
 	__dma_direct_free_pages(dev, page, size);
 	return NULL;
 out_leak_pages:
@@ -339,7 +340,12 @@ void dma_direct_free(struct device *dev, size_t size,
 		return;
 
 	if (is_vmalloc_addr(cpu_addr)) {
+		void *vaddr = page_address(dma_direct_to_page(dev, dma_addr));
+
 		vunmap(cpu_addr);
+
+		if (dma_set_encrypted(dev, vaddr, size))
+			return;
 	} else {
 		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_CLEAR_UNCACHED))
 			arch_dma_clear_uncached(cpu_addr, size);
-- 
2.53.0.1185.g05d4b7b318-goog

