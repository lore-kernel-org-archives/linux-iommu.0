Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125EE184C
	for <iommu@lists.linux.dev>; Tue, 20 Dec 2022 08:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VHs0G2aC0Lau8WEEFjp3imT8ZHxZW8dUlQGHCb9Fikw=; b=pZZqAkkaYtdoP9XWW7DyFAkmVH
	LgaXjFNCPGIfxxBIMTpHXVkgSUSpvONTxfsPWoj8CuCtzoabAiDZflEl8XTEZS51iPmzX4nkeZGn+
	9tmKxqwZPiNVLKwg9RqgYNJM/xpwcO1DjlBP7oc42o7XNbU8T72/k0H7IbmbUSPqiTINtIq6egJsC
	kaI6saujDqqnZ9I3zFV/mO2pgJho2A/VhIT4T0OsRxJ7eBYm+KLiV6HJ7UUnU3Gn3tcIriU2vdnYU
	wYabUhFhipbRNolwCnSLDOw9br1+8CIi76btUcgF2fMzVS0H3+Wz0XshmsjhBK15EKhmiPHfG6zY5
	H5VkHw0w==;
Received: from [2001:4bb8:199:7829:c604:55b0:ed6a:61ce] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7XrC-00BuKQ-TA; Tue, 20 Dec 2022 08:20:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [PATCH 1/2] ALSA: memalloc: don't use GFP_COMP for non-coherent dma allocations
Date: Tue, 20 Dec 2022 09:20:08 +0100
Message-Id: <20221220082009.569785-2-hch@lst.de>
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
dma allocations, but only got rejected for coherent ones.

Start fixing this by not requesting __GFP_COMP in the sound code, which
is the only place that did this.

Fixes: ffcb75458460 ("dma-mapping: reject __GFP_COMP in dma_alloc_attrs")
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Reported-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 sound/core/memalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index 3cf5a87d69eaf3..81025f50a54229 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -542,7 +542,7 @@ static void *snd_dma_noncontig_alloc(struct snd_dma_buffer *dmab, size_t size)
 	void *p;
 
 	sgt = dma_alloc_noncontiguous(dmab->dev.dev, size, dmab->dev.dir,
-				      DEFAULT_GFP | __GFP_COMP, 0);
+				      DEFAULT_GFP, 0);
 #ifdef CONFIG_SND_DMA_SGBUF
 	if (!sgt && !get_dma_ops(dmab->dev.dev)) {
 		if (dmab->dev.type == SNDRV_DMA_TYPE_DEV_WC_SG)
@@ -820,7 +820,7 @@ static void *snd_dma_noncoherent_alloc(struct snd_dma_buffer *dmab, size_t size)
 	void *p;
 
 	p = dma_alloc_noncoherent(dmab->dev.dev, size, &dmab->addr,
-				  dmab->dev.dir, DEFAULT_GFP | __GFP_COMP);
+				  dmab->dev.dir, DEFAULT_GFP);
 	if (p)
 		dmab->dev.need_sync = dma_need_sync(dmab->dev.dev, dmab->addr);
 	return p;
-- 
2.35.1

