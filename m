Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE75A3B531B
	for <iommu@lists.linux.dev>; Tue, 14 Apr 2026 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157401; cv=none; b=tBwP2aax/pheSTxuXgvL9Cs29b9WDCX4ouzyY3aDfH36XDbCXtWSVfr1WNwlC2I/sbYfXz0gKVoDI+Ob+4SGgjhSSyjvEgZHxP9Mv0CSQq7R7v9S9ejbo2UaqhsRVdJRtZX2FSVY9KiszW91vcyrTyhkO5DjOxcP8ksXmAJAuCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157401; c=relaxed/simple;
	bh=wN4DKWlxmROB6FN+Uz8xwErxwfZjlVcfAFMxhH8KZjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nzUAS+r6sUgQCyjAoB5uSuBu4F8jQGx3B5qknmJTCXxCU9U0aA742J5BMcERbmbNh59vL6/vT8ZPE9YOdoG44qyACEX9j/2zcBgZtU5V/CcJUxA7OKKorbBJ5sBTAnlTvKp1WHkcuK92yxVmMzdCRECh7wGm9NMB//1QJncvqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=eGR+MRxE; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="eGR+MRxE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776157392; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IFzB3mo90OwMkDYnSXs3XtgMaNpNtEUFZm5l6DP+N4c=;
	b=eGR+MRxE84VZX9LHY9WvN/THH2+xzZEM1eQQJnywAp4c6/9wOqY3zVTQe0MuQOu5KhiNOcUOrpoVnI9XxfwCljg9q3SempwFbI0NmAZ8PH3UvozAlKBDmc/JdUqeTkq/YluxHwhzIRqscpibDQxcPc5Bk44Z7jrbLJgYJjIiFKU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=feng.tang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X10x0BJ_1776157390;
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0X10x0BJ_1776157390 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Apr 2026 17:03:11 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH v1] dma-contiguous: try local node first for dma_alloc_contiguous()
Date: Tue, 14 Apr 2026 17:03:10 +0800
Message-Id: <20260414090310.92055-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a bug report on a multi-numa-nodes ARM server that when
IOMMU is disabled, the dma_alloc_coherent() function always returns
memory from node 0 even for devices attaching to other nodes, while
they can get local dma memory when IOMMU is on with the same API.

The reason is, when IOMMU is disabled, the dma_alloc_coherent() will
go the direct way and call dma_alloc_contiguous(). The system doesn't
have any explicit cma setting (like per-numa cma), and only has a
default 64MB cma reserved area (on node 0), where kernel will try
first to allocate memory from.

Make the dma allocation more locality friendly by trying first the
numa aware allocation alloc_pages_node() before falling back to the
reserved cma area.

One more thought is to check the node of the reserved cma area and
only call alloc_pages_nodes() when it isn't the same node that the
device attaches to.

Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
 kernel/dma/contiguous.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index c56004d314dc..0180f40f094e 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -371,8 +371,9 @@ static struct page *cma_alloc_aligned(struct cma *cma, size_t size, gfp_t gfp)
  */
 struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 {
-#ifdef CONFIG_DMA_NUMA_CMA
+#ifdef CONFIG_NUMA
 	int nid = dev_to_node(dev);
+	struct page *page;
 #endif
 
 	/* CMA can be used only in the context which permits sleeping */
@@ -386,7 +387,6 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 #ifdef CONFIG_DMA_NUMA_CMA
 	if (nid != NUMA_NO_NODE && !(gfp & (GFP_DMA | GFP_DMA32))) {
 		struct cma *cma = dma_contiguous_pernuma_area[nid];
-		struct page *page;
 
 		if (cma) {
 			page = cma_alloc_aligned(cma, size, gfp);
@@ -402,6 +402,14 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
 		}
 	}
 #endif
+
+#ifdef CONFIG_NUMA
+	/* Try first to allocate memory on the same node as the device */
+	page = alloc_pages_node(nid, gfp, get_order(size));
+	if (page)
+		return page;
+#endif
+
 	if (!dma_contiguous_default_area)
 		return NULL;
 
-- 
2.39.5 (Apple Git-154)

