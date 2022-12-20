Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1F7186B
	for <iommu@lists.linux.dev>; Tue, 20 Dec 2022 08:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cA0uvbQLIkf8Hh0wtILMN1D9yegrDmrjgvNGFHvuKz0=; b=hvoB7RCrA4P6IviJWysH9ahDds
	Lvb0cOoelZXw0CLXWCB4GmV7Hir+3IeQHy0cy8aRtaD9JyME+M8nu4ZZIJzJkkXHIxwbkLi8om2Qj
	g96u0rWaW5lz6Lrokfxyu2H3e/0GcdZ6dJKK74j0Co8wqgUphmiykGhQhGw9jVAAdJRDicqGKorKP
	RleDQOyTAoeWj4ZD9uE9DgiW9VMCf94c0O+SPmUthe0eMAIBSm8v18ThWAglClWY0ji1JW48ljBI9
	fUpAbzxG9ZSeAT0iunNd28UzBLYUbaAMudaT29y9WsF2AanC+apl7k1K0YTeew2jtXphgLNwsAThg
	WWHpbgAg==;
Received: from [2001:4bb8:199:7829:c604:55b0:ed6a:61ce] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7XrG-00BuLq-03; Tue, 20 Dec 2022 08:20:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [PATCH 2/2] dma-mapping: reject GFP_COMP for noncohernt allocaions
Date: Tue, 20 Dec 2022 09:20:09 +0100
Message-Id: <20221220082009.569785-3-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221220082009.569785-1-hch@lst.de>
References: <20221220082009.569785-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

While not quite as bogus as for the dma-coherent allocations that were
fixed earlier, GFP_COMP for these allocations has no benefits for
the dma-direct case, and can't be supported at all by dma dma-iommu
backend which splits up allocations into smaller orders.  Due to an
oversight in ffcb75458460 that flag stopped being cleared for all
dma allocations, but only got rejected for coherent ones, so fix up
these callers to not allow __GFP_COMP as well after the sound code
has been fixed to not ask for it.

Fixes: ffcb75458460 ("dma-mapping: reject __GFP_COMP in dma_alloc_attrs")
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Reported-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/mapping.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index c026a5a5e0466e..68106e3791f6c3 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -560,6 +560,8 @@ static struct page *__dma_alloc_pages(struct device *dev, size_t size,
 		return NULL;
 	if (WARN_ON_ONCE(gfp & (__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM)))
 		return NULL;
+	if (WARN_ON_ONCE(gfp & __GFP_COMP))
+		return NULL;
 
 	size = PAGE_ALIGN(size);
 	if (dma_alloc_direct(dev, ops))
@@ -645,6 +647,8 @@ struct sg_table *dma_alloc_noncontiguous(struct device *dev, size_t size,
 
 	if (WARN_ON_ONCE(attrs & ~DMA_ATTR_ALLOC_SINGLE_PAGES))
 		return NULL;
+	if (WARN_ON_ONCE(gfp & __GFP_COMP))
+		return NULL;
 
 	if (ops && ops->alloc_noncontiguous)
 		sgt = ops->alloc_noncontiguous(dev, size, dir, gfp, attrs);
-- 
2.35.1

