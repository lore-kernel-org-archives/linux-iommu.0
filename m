Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265726;
	b=Ufqes41m9v5V27QRLEIZyJ/8QldhUGj6InuL0eOoe5BRw4Xf+uoZ00TKgHd54ax1o9Bz
	 +0PMf+HQ6s18dC/0QsGbBK6ybLiZI1A/OVXwQToJqoushTfADhSfXiMjOz6pGmM5RAU5u
	 20qa3cndybKAiSv5slc9SH74l7ghLZyCo8lePzOcbiuILReH1rOzFLmHWhYqQH1wAHuN3
	 EF+a8d1XKJd5iRZXRAf9Y2CJWNB5LdrbwmIP4qlS1VkyIC8Mg8OfROl8s1F8jfZsOJetE
	 WTsQ5GfksCNNuLEs/d4M/RP6y3kECYqInkcQ4N5tH+FdeLHk/4rf8b2W9N9bai1jOeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265726;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-CMS-MailID:X-Msg-Generator:Content-Type:
	 X-RootMTR:X-EPHeader:X-CMS-RootMailID:References;
	bh=jwUjYA3uveZxH8W6XvbyOg7KDW9X0G4RjglA1KUlko4=;
	b=vemRIw5+P5f4SK+gkAajQTqR+g3kvCvkOrR3w3zSHGAVcnibrhxe8507Rcmfhu7N80Ql
	 efUiLbSR/L06/4ZwBBL8nRdL5jceGSuxn5UF6N12rCi2/5FVwZQzK7j+9/dJkC9ltX46y
	 pw55LgxM7IDCz33gfVcs8alGfOhoyvRwTm6K+dl6UPi1EFKb8E/ESldXPLHgp1Ac9reAb
	 qQXNsIzd0yB1BF08M89XdFnBbMF+/56xL0JdjTgqz7Pehxd9OaRT2nYe9tLyjr8EoAQJo
	 /SrET0XybFKzDfoYXesz6X2oEnrCHiHC4rF05TS2XrSVsme2LUOZrPyrWnXpRzHee4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=SFQqbNv+;
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6655E606A321
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 23:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6655E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=SFQqbNv+
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261109230842euoutp01756c89f52ca6e882f7d21e84c17d8874~mgysIvosa2046320463euoutp01W
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 23:08:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261109230842euoutp01756c89f52ca6e882f7d21e84c17d8874~mgysIvosa2046320463euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1794265722;
	bh=jwUjYA3uveZxH8W6XvbyOg7KDW9X0G4RjglA1KUlko4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=SFQqbNv+Jr3i0VTAkd940jUazuLutxxI/Kj/d/yQ1nlVOJBbwqhnQ7/aUJ15m/ukc
	 JF4n+vi32bIQHGUQ79t5MN1cKmj3N8QjnUsj12/Q7SwRfN7ZyoW3cBlk5fPJHle8rE
	 behQBN6xNXA+iVuGi6AObnyYuLlF7K7/Jy0TW7qU=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261109230841eucas1p1ee97e7adcdac763c19145f604e4f11a7~mgyrqcXfC0819808198eucas1p1k;
	Mon,  9 Nov 2026 23:08:41 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261109230841eusmtip23a4ed7ae982b4c3bbb1906c5b91270e1~mgyrT2s8x0811808118eusmtip2n;
	Mon,  9 Nov 2026 23:08:41 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, David Rientjes <rientjes@google.com>, Jason
	Gunthorpe <jgg@ziepe.ca>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
Subject: [PATCH v2] dma-pool: decrypt pages before creating the shared remap
Date: Tue, 10 Nov 2026 00:08:29 +0100
Message-ID: <20261109230830.1707975-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261109230841eucas1p1ee97e7adcdac763c19145f604e4f11a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261109230841eucas1p1ee97e7adcdac763c19145f604e4f11a7
X-EPHeader: CA
X-CMS-RootMailID: 20261109230841eucas1p1ee97e7adcdac763c19145f604e4f11a7
References: <CGME20261109230841eucas1p1ee97e7adcdac763c19145f604e4f11a7@eucas1p1.samsung.com>

atomic_pool_expand() creates the pgprot_decrypted() remap of the pool
pages before calling set_memory_decrypted() on them. The error path
when gen_pool_add_virt() fails does the reverse: it re-encrypts the
pages and only then tears down the decrypted remap. In both cases there
is a window where a decrypted (shared) kernel mapping points at a page
that is still private, i.e. encrypted, to the guest.

dma_direct_alloc() gets this right: it converts the pages first, then
creates the remap, and on error removes the remap before re-encrypting.
Do the same in atomic_pool_expand(). The pages are now converted before
arch_dma_prep_coherent() and the remap, and the error path unwinds in
reverse order.

If set_memory_decrypted() fails, the encryption state of the pages is
unknown (the conversion may have partially succeeded), so they must not
be returned to the page allocator or CMA and are intentionally leaked,
as before. No remap exists at that point any more, so nothing else needs
to be undone. Add a comment explaining this.

Closes: https://sashiko.dev/#/bug/linux-9212d9b5-4a56-43e2-bc00-6e69b724078b
Fixes: 76a19940bd62 ("dma-direct: atomic allocations must come from atomic coherent pools")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
The patch was prepared with LLM assistance.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
---
Changelog:

v2:
- addressed more sashiko.dev pointed issues:
  https://sashiko.dev/#/patchset/20261109154403.384434-1-m.szyprowski%40samsung.com

v1: https://lore.kernel.org/all/20261109154403.384434-1-m.szyprowski@samsung.com/
---
 kernel/dma/pool.c | 48 +++++++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 381b3cb28368..5e8cf12e8222 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -106,6 +106,22 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 	if (!page)
 		goto out;
 
+	/*
+	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
+	 * shrink so no re-encryption occurs in dma_direct_free().
+	 */
+	if (dma_pool->cc_shared) {
+		ret = set_memory_decrypted((unsigned long)page_to_virt(page),
+					   1 << order);
+		/*
+		 * On failure the encryption state of the pages is unknown,
+		 * so they must not be returned to the page allocator or CMA.
+		 * Leak them intentionally.
+		 */
+		if (ret)
+			goto out;
+	}
+
 	arch_dma_prep_coherent(page, pool_size);
 
 #ifdef CONFIG_DMA_DIRECT_REMAP
@@ -116,42 +132,30 @@ static int atomic_pool_expand(struct dma_gen_pool *dma_pool, size_t pool_size,
 
 	addr = dma_common_contiguous_remap(page, pool_size, prot,
 			__builtin_return_address(0));
-	if (!addr)
-		goto free_page;
+	if (!addr) {
+		ret = -ENOMEM;
+		goto encrypt_pages;
+	}
 #else
 	addr = page_to_virt(page);
 #endif
-	/*
-	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
-	 * shrink so no re-encryption occurs in dma_direct_free().
-	 */
-	if (dma_pool->cc_shared) {
-		ret = set_memory_decrypted((unsigned long)page_to_virt(page),
-					   1 << order);
-		if (ret) {
-			leak_pages = true;
-			goto remove_mapping;
-		}
-	}
-
 	ret = gen_pool_add_virt(dma_pool->pool, (unsigned long)addr,
 				page_to_phys(page), pool_size, NUMA_NO_NODE);
 	if (ret)
-		goto encrypt_mapping;
+		goto remove_mapping;
 
 	dma_atomic_pool_size_add(gfp, pool_size);
 	return 0;
 
-encrypt_mapping:
-	if (dma_pool->cc_shared &&
-	    set_memory_encrypted((unsigned long)page_to_virt(page), 1 << order))
-		leak_pages = true;
-
 remove_mapping:
 #ifdef CONFIG_DMA_DIRECT_REMAP
 	dma_common_free_remap(addr, pool_size);
-free_page:
+encrypt_pages:
 #endif
+	if (dma_pool->cc_shared &&
+	    set_memory_encrypted((unsigned long)page_to_virt(page), 1 << order))
+		leak_pages = true;
+
 	if (!leak_pages &&
 	    !dma_release_from_contiguous(NULL, page, 1 << order))
 		__free_pages(page, order);
-- 
2.43.0

