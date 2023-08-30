Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FE01C03
	for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 09:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=DcmeLDzz9KZVlL4wnP4yA+AoGk0RUXEO/hVtZsOAMnE=; b=Lri93OD1kRmRMjC5TAfFqrIYxW
	5Qg4UkkMEldr6WEw6PWIsW933m2EekES0WObHxDXJBQzrzMQwXb8w27B/J2oBBR7LYdnzQo1hMUQF
	wi2ItXbStuUF3qTgH1YkV3c5mGuCTYyFSFpFOPyFxxP6rIaE7joLB4JmbF7UsgbwRziJA20Kf7Lbb
	79KXJHDdaQ1U7zpVau/6X85sKNiBvQbAbry88qR/cIHBBM5mlIQ/wQI9gbbrch8bz4kHvbxsEjbGw
	vWo3/OEg+h4K3X31sgi67q7t9vxtl5vnRQ/eqZ64VHL1mBpT7D3n4zyYsANr7xtDajdyWaZ16Cn3P
	UTvRje4w==;
Received: from 213-147-167-102.nat.highway.webapn.at ([213.147.167.102] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qbHUk-00D9P8-1n;
	Wed, 30 Aug 2023 09:28:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: m.szyprowski@samsung.com,
	robin.murphy@arm.com
Cc: hchunhui@mail.ustc.edu.cn,
	iommu@lists.linux.dev
Subject: [PATCH] dma-pool: remove a __maybe_unused label in atomic_pool_expand
Date: Wed, 30 Aug 2023 11:28:04 +0200
Message-Id: <20230830092804.148776-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Move the #endif a line so that free_page label is only seen by the
compile pass when actually used.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 1acec2e228273f..b481c48a31a630 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -135,9 +135,9 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 remove_mapping:
 #ifdef CONFIG_DMA_DIRECT_REMAP
 	dma_common_free_remap(addr, pool_size);
-#endif
-free_page: __maybe_unused
+free_page:
 	__free_pages(page, order);
+#endif
 out:
 	return ret;
 }
-- 
2.39.2

