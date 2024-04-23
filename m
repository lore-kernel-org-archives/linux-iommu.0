Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB8213C81B
	for <iommu@lists.linux.dev>; Tue, 23 Apr 2024 13:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880761; cv=none; b=ZGQV8ovT3Mg8jIlrSGi3bKpb59Rgqj0DiqrwlUtXRZqlpRi2H+BgpaMRe49MU4XKzwDz0kPQkZEagQ5yqCubrGzMD0jXhNydbaRP87XDwsyveIS3W3U7N0Z5NG1nGE+44OQLKWqNnGxUscClS601aqK5iAuEtcrBwuBxDRhK19k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880761; c=relaxed/simple;
	bh=/kkHgP++5WmB+SKjIXakdZj5fr6XaWKzHwhooynuFYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXYPxVaSoChmS/MjNq7f69itdp526B6oeXeOT7c7ui1QDeIDvObV8WUXGCr0PFxMCtsCfYFdXNP8v2Y/YhpENmzEn7LpE5b/EcH2rX1SzAzce2vwfKLt8wLvmJAfCZocMRcxKMcH0mWry12qZK3ixYnDWDCVNPO9VyYFhnBfXDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V62kEizt; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V62kEizt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713880761; x=1745416761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/kkHgP++5WmB+SKjIXakdZj5fr6XaWKzHwhooynuFYM=;
  b=V62kEizt1uF7/M82dsRm6lzFR8DNFNAvFFVnutDvEcqRCLCJ5GCSK/nO
   Ylq5im89p/DoS7Iz1+l903BZg/jCVVMXxgxMQpyKqCMrQlASSGkgKZl8i
   jlCT8UDhtNwhKiZteO7N1fuuliOTKkR9F7/WF3hclceyaeKptRMd2Eibo
   cGscY0q6Se4vNEpTWVzl3ZhF+LW1m4w6MlOz1na61sOrvOXSMyBRcn05G
   a2DoAyP7nNhfjvedofwFk4l4+e20xogxGEZVWYXY2TB53f/3zNrCh6O/Z
   YNRYEojGy1VrB9RLlC0NPtQdfHYoAHPGckY+8lf/6BnInl/Uh2t17Axaj
   g==;
X-CSE-ConnectionGUID: 1VXi7TNvRi6yG1hg6uYuCQ==
X-CSE-MsgGUID: QRIMGcrIRyaerha8HEb3xQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="26921560"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="26921560"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:59:14 -0700
X-CSE-ConnectionGUID: lkVA5DDYRPGD/ekFDj17gw==
X-CSE-MsgGUID: BzZEYJTbQ0qBakydqpjSGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24431890"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 23 Apr 2024 06:59:10 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 6/7] page_pool: check for DMA sync shortcut earlier
Date: Tue, 23 Apr 2024 15:58:31 +0200
Message-ID: <20240423135832.2271696-7-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423135832.2271696-1-aleksander.lobakin@intel.com>
References: <20240423135832.2271696-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can save a couple more function calls in the Page Pool code if we
check for dma_need_sync() earlier, just when we test pp->p.dma_sync.
Move both these checks into an inline wrapper and call the PP wrapper
over the generic DMA sync function only when both are true.
You can't cache the result of dma_need_sync() in &page_pool, as it may
change anytime if an SWIOTLB buffer is allocated or mapped.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 net/core/page_pool.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 6cf26a68fa91..87319c6365e0 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -398,16 +398,24 @@ static struct page *__page_pool_get_cached(struct page_pool *pool)
 	return page;
 }
 
-static void page_pool_dma_sync_for_device(const struct page_pool *pool,
-					  const struct page *page,
-					  unsigned int dma_sync_size)
+static void __page_pool_dma_sync_for_device(const struct page_pool *pool,
+					    const struct page *page,
+					    u32 dma_sync_size)
 {
 	dma_addr_t dma_addr = page_pool_get_dma_addr(page);
 
 	dma_sync_size = min(dma_sync_size, pool->p.max_len);
-	dma_sync_single_range_for_device(pool->p.dev, dma_addr,
-					 pool->p.offset, dma_sync_size,
-					 pool->p.dma_dir);
+	__dma_sync_single_for_device(pool->p.dev, dma_addr + pool->p.offset,
+				     dma_sync_size, pool->p.dma_dir);
+}
+
+static __always_inline void
+page_pool_dma_sync_for_device(const struct page_pool *pool,
+			      const struct page *page,
+			      u32 dma_sync_size)
+{
+	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
+		__page_pool_dma_sync_for_device(pool, page, dma_sync_size);
 }
 
 static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
@@ -429,8 +437,7 @@ static bool page_pool_dma_map(struct page_pool *pool, struct page *page)
 	if (page_pool_set_dma_addr(page, dma))
 		goto unmap_failed;
 
-	if (pool->dma_sync)
-		page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
+	page_pool_dma_sync_for_device(pool, page, pool->p.max_len);
 
 	return true;
 
@@ -699,9 +706,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	if (likely(__page_pool_page_can_be_recycled(page))) {
 		/* Read barrier done in page_ref_count / READ_ONCE */
 
-		if (pool->dma_sync)
-			page_pool_dma_sync_for_device(pool, page,
-						      dma_sync_size);
+		page_pool_dma_sync_for_device(pool, page, dma_sync_size);
 
 		if (allow_direct && page_pool_recycle_in_cache(page, pool))
 			return NULL;
@@ -840,9 +845,7 @@ static struct page *page_pool_drain_frag(struct page_pool *pool,
 		return NULL;
 
 	if (__page_pool_page_can_be_recycled(page)) {
-		if (pool->dma_sync)
-			page_pool_dma_sync_for_device(pool, page, -1);
-
+		page_pool_dma_sync_for_device(pool, page, -1);
 		return page;
 	}
 
-- 
2.44.0

