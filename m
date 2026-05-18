Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55799351C22;
	Mon, 18 May 2026 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127598; cv=none; b=TcEUzvv4N7JbS534L4Ai9D+ahqS/ubTg1HC/9t4HogEp1vStOKY7uz2X0NxSoT9MDspZ8MMuNQ/nRISwD5pj9kuwD2jQyiJB0cDkEYFSbTZMd+4rUS0XLLmKjclG5xDxOA1wIlvO7ebaKY9+/ff4+JMcohS6bQ8r0OXAJ+6KEDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127598; c=relaxed/simple;
	bh=fKoNlYFQ9i+xwRphioK+E097l6m7eBvvV96x1XXJGRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9G7FMoGOVlU37mFmCA0AuTdU3m87tRKB6Td0J6bYqNMHMyt8+ZXtogqCnJik3BL6yoQUdsuN5crqqV0SS2F+NzGULMufKTCMzdf0CJlo4Ax0VAS7QSvHlyE4KHpK9G+HYz1BOeo9DbPPIJF68yhhNZZbNPJqWc/8QLtQ3slJyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=htIWBgJa; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="htIWBgJa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GWvEh8/+ioAp2vdjyqkYVgoQtAgnd/toD6zHWkmNYaY=; b=htIWBgJaE9rCE+UKOQq0+OUPuu
	NKD0GMDTiaBvVoegu03A5jAYjZdFVZfPASgG0h3X8dWYjISSocl52QZHyu+/fL/ZjCz/NF6KUfBII
	U/oaMcdqRjjn+GN36opBC/WMSHBNhqDKg3nhuoFs1cOiwhtMMOqBT2PpYyLshwr8Lcuza7Ctn9tQ8
	O3pR/yZmOCPT3QoSMGZ1euZNkSFl983I22Jo9XTDkWWati+0MHhxlOR2qZiL4e5uCiR1CXZAq+G2g
	7FTW9aZdKsynCqR0pmSNaazxf27+bATuVPn2WDoUx+EM4M54Mc2hY2JxGD29z35AJQJg1lwO65n8S
	tsxsvTxA==;
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wP2Lb-0000000006g-3XVp;
	Mon, 18 May 2026 14:05:47 -0400
From: Rik van Riel <riel@surriel.com>
To: linux-kernel@vger.kernel.org
Cc: robin.murphy@arm.com,
	joro@8bytes.org,
	will@kernel.org,
	iommu@lists.linux.dev,
	jgg@ziepe.ca,
	kyle@mcmartin.ca,
	kernel-team@meta.com,
	Rik van Riel <riel@meta.com>,
	Claude Opus <claude-opus-4-6@anthropic.com>,
	Rik van Riel <riel@surriel.com>
Subject: [PATCH 2/4] iova: drop dead cached_node / cached32_node infrastructure
Date: Mon, 18 May 2026 14:05:05 -0400
Message-ID: <20260518180545.2286608-3-riel@surriel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260518180545.2286608-1-riel@surriel.com>
References: <20260518180545.2286608-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rik van Riel <riel@meta.com>

After the augmented-rbtree port, cached_node and cached32_node are still
maintained on every insert and delete but are never consulted on the
allocation path. Drop the fields and their helpers.

The one piece of useful work in __cached_rbnode_delete_update() was
resetting iovad->max32_alloc_size when an iova in the 32-bit range was
freed (so the next 32-bit alloc can retry). That logic is preserved by
moving it inline into remove_iova().

No external consumers reference the cached_node fields.

Assisted-by: Claude Opus <claude-opus-4-6@anthropic.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 drivers/iommu/iova.c | 35 +++--------------------------------
 include/linux/iova.h |  2 --
 2 files changed, 3 insertions(+), 34 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 5c813dd42c04..4848a7c202be 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -57,8 +57,6 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 
 	spin_lock_init(&iovad->iova_rbtree_lock);
 	iovad->rbroot = RB_ROOT;
-	iovad->cached_node = &iovad->anchor.node;
-	iovad->cached32_node = &iovad->anchor.node;
 	iovad->granule = granule;
 	iovad->start_pfn = start_pfn;
 	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
@@ -71,34 +69,6 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
 
-static void
-__cached_rbnode_insert_update(struct iova_domain *iovad, struct iova *new)
-{
-	if (new->pfn_hi < iovad->dma_32bit_pfn)
-		iovad->cached32_node = &new->node;
-	else
-		iovad->cached_node = &new->node;
-}
-
-static void
-__cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
-{
-	struct iova *cached_iova;
-
-	cached_iova = to_iova(iovad->cached32_node);
-	if (free == cached_iova ||
-	    (free->pfn_hi < iovad->dma_32bit_pfn &&
-	     free->pfn_lo >= cached_iova->pfn_lo))
-		iovad->cached32_node = rb_next(&free->node);
-
-	if (free->pfn_lo < iovad->dma_32bit_pfn)
-		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
-
-	cached_iova = to_iova(iovad->cached_node);
-	if (free->pfn_lo >= cached_iova->pfn_lo)
-		iovad->cached_node = rb_next(&free->node);
-}
-
 /* Insert the iova into domain rbtree by holding writer lock */
 static void
 iova_insert_rbtree(struct rb_root *root, struct iova *iova,
@@ -240,7 +210,6 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	new->pfn_hi = new_pfn + size - 1;
 
 	iova_insert_rbtree(&iovad->rbroot, new, gap_node);
-	__cached_rbnode_insert_update(iovad, new);
 
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 	return 0;
@@ -327,7 +296,9 @@ static void remove_iova(struct iova_domain *iovad, struct iova *iova)
 	struct iova *next_iova = NULL;
 
 	assert_spin_locked(&iovad->iova_rbtree_lock);
-	__cached_rbnode_delete_update(iovad, iova);
+
+	if (iova->pfn_lo < iovad->dma_32bit_pfn)
+		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
 
 	next_node = rb_next(&iova->node);
 	if (next_node) {
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 52635a72c5c5..3c4cc81e5182 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -30,8 +30,6 @@ struct iova_rcache;
 struct iova_domain {
 	spinlock_t	iova_rbtree_lock; /* Lock to protect update of rbtree */
 	struct rb_root	rbroot;		/* iova domain rbtree root */
-	struct rb_node	*cached_node;	/* Save last alloced node */
-	struct rb_node	*cached32_node; /* Save last 32-bit alloced node */
 	unsigned long	granule;	/* pfn granularity for this domain */
 	unsigned long	start_pfn;	/* Lower limit for this domain */
 	unsigned long	dma_32bit_pfn;
-- 
2.52.0

