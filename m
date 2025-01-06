Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244E01DF739
	for <iommu@lists.linux.dev>; Mon,  6 Jan 2025 13:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736168931; cv=none; b=XmwGbUwL8WJpFayvoHJWcHxqx26+18geZOWi/+r0TMQJWw/6nohM8WQ4XPG+XxzvKSr8+8+wJ4fn6n7iZRJ0M1r6C/HrjMZ/Ut40Bg4JzpYLsyrkFAJpx6+iYf0PyzoBHXpa60OG35QWft6IMAoHNzSxsYkmQ8sOExjf5lTm3h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736168931; c=relaxed/simple;
	bh=xCTpS6ipjGJeQEohtMZNmbeIzH6qk2MfcthnLIMYa9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JS5djYS7yW4H2QasVAoc4Dv7Ripl0ooc4mGrA6DevraC+pw0hOqanBnd6aVwbV6yfGXXQFPx9MKFWqFniXcijwtLb3/46EUEhP6WSPgBdz6hjbExugiNMRJKAenJRQoAguvEWAaOKuMMO4AMy0oPsQEVGLfXIDcNPOjcLJWS5yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YRZDP19kTz1V4Nx;
	Mon,  6 Jan 2025 21:05:41 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B7FCB14037B;
	Mon,  6 Jan 2025 21:08:40 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Jan 2025 21:08:40 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <liuyonglong@huawei.com>, <fanghaiqing@huawei.com>,
	<zhangkun09@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>, Robin Murphy
	<robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, IOMMU
	<iommu@lists.linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v6 7/8] page_pool: batch refilling pages to reduce atomic operation
Date: Mon, 6 Jan 2025 21:01:15 +0800
Message-ID: <20250106130116.457938-8-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250106130116.457938-1-linyunsheng@huawei.com>
References: <20250106130116.457938-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

Add refill variable in alloc cache to keep batched refilled
pages to avoid doing the atomic operation for each page.

Testing shows there is about 10ns improvement for the
performance of 'time_bench_page_pool02_ptr_ring' test case.

CC: Robin Murphy <robin.murphy@arm.com>
CC: Alexander Duyck <alexander.duyck@gmail.com>
CC: IOMMU <iommu@lists.linux.dev>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/net/page_pool/types.h |  5 +++++
 net/core/page_pool.c          | 25 +++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 923bcb01a830..ac83abea24b0 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -51,6 +51,11 @@
 struct pp_alloc_cache {
 	u32 count;
 	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
+
+	/* Keep batched refilled pages here to avoid doing the atomic operation
+	 * for each page.
+	 */
+	struct page_pool_item *refill;
 };
 
 /**
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index b8f46c26b5ef..429d44ede074 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -677,11 +677,13 @@ static void __page_pool_return_page(struct page_pool *pool, netmem_ref netmem,
 
 static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 {
+	struct page_pool_item *refill;
 	netmem_ref netmem;
 	int pref_nid; /* preferred NUMA node */
 
 	/* Quicker fallback, avoid locks when ring is empty */
-	if (unlikely(!READ_ONCE(pool->ring.list))) {
+	refill = pool->alloc.refill;
+	if (unlikely(!refill && !READ_ONCE(pool->ring.list))) {
 		alloc_stat_inc(pool, empty);
 		return 0;
 	}
@@ -698,10 +700,14 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 
 	/* Refill alloc array, but only if NUMA match */
 	do {
-		netmem = page_pool_consume_ring(pool);
-		if (unlikely(!netmem))
-			break;
+		if (unlikely(!refill)) {
+			refill = xchg(&pool->ring.list, NULL);
+			if (!refill)
+				break;
+		}
 
+		netmem = refill->pp_netmem;
+		refill = page_pool_item_get_next(refill);
 		if (likely(netmem_is_pref_nid(netmem, pref_nid))) {
 			pool->alloc.cache[pool->alloc.count++] = netmem;
 		} else {
@@ -711,14 +717,18 @@ static noinline netmem_ref page_pool_refill_alloc_cache(struct page_pool *pool)
 			 * This limit stress on page buddy alloactor.
 			 */
 			__page_pool_return_page(pool, netmem, false);
+			atomic_dec(&pool->ring.count);
 			alloc_stat_inc(pool, waive);
 			netmem = 0;
 			break;
 		}
 	} while (pool->alloc.count < PP_ALLOC_CACHE_REFILL);
 
+	pool->alloc.refill = refill;
+
 	/* Return last page */
 	if (likely(pool->alloc.count > 0)) {
+		atomic_sub(pool->alloc.count, &pool->ring.count);
 		netmem = pool->alloc.cache[--pool->alloc.count];
 		alloc_stat_inc(pool, refill);
 	}
@@ -1406,6 +1416,7 @@ static void __page_pool_destroy(struct page_pool *pool)
 
 static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 {
+	struct page_pool_item *refill;
 	netmem_ref netmem;
 
 	if (pool->destroy_cnt)
@@ -1419,6 +1430,12 @@ static void page_pool_empty_alloc_cache_once(struct page_pool *pool)
 		netmem = pool->alloc.cache[--pool->alloc.count];
 		page_pool_return_page(pool, netmem);
 	}
+
+	while ((refill = pool->alloc.refill)) {
+		pool->alloc.refill = page_pool_item_get_next(refill);
+		page_pool_return_page(pool, refill->pp_netmem);
+		atomic_dec(&pool->ring.count);
+	}
 }
 
 static void page_pool_scrub(struct page_pool *pool)
-- 
2.33.0

