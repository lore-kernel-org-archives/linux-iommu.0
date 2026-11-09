Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248755;
	b=WWTEDz7tBEVjmQ4/0E6LVW1wVUJQkWoOf3Af7qHV63xPr4nwlinB3vgxGJlJUlEG5kU1
	 1G/JGl3+2zzgE9mBDcI1Bth+RQV7CnpZzpvjyQ7egxDVsc8wurhvZyYBmbgPEVopSL3NL
	 d52wW+KTw6rwDp6ud9XmpGVGy8y20lGrWcfrcL1hUt5c0bSdNumLGLoikpJOJ3MVNONzD
	 VlrWXZ7bQurGU0iAYHAD+SSre90ol3p3j7Dg1iL6o5PVPgvrP0u4AEUCS5yTvU9SLyQJj
	 TTNK5FVxypF6zEp2DH0kZlJNhRPEzFCSKfSL/k+/hH/S4cgHUQj989nYWFM2CjoKxWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=gomwgjRp8gnNvcmuG0DoiSv5Tpyva0FtvGRYSv+rt0I=;
	b=oOWB5BI2kFSgU1EH7ZPPW7RH6xWagKseblaEWr0vWLrYK9ctFJ/77y0SU2X6qIRNFT2t
	 gHNQ3gRVvjyw9Jx6i17gzfUO00ifBkIe/Rpp52KmoirbdqCqky3KBzCZ03nGHRdTucrI0
	 TxTTR8AbCP4PpyTrvfxf+P0PptbfOuJU75rClSygMQ5dX7/mgsjo1QXHDSppF0txuoMzE
	 RUN+XTiTK2/tKBkE5e8GSajCB5226+mURL+wkpPNFn+SMkcK1ggremKbrlXjIA0U4mbXc
	 jcKww9OYh95j/ZmyZWjCZrSqCGxGvvSQc6899y7UFpewoHa41AM2oIuY1PtUAdUEImQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aEsLc1ii;
	arc=none smtp.remote-ip=209.85.218.70
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0B606CC4E
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 18:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BD0B606CC4E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lrizzo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aEsLc1ii
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c4d28d38d79so124881166b.0
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 10:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794248753; x=1794853553; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gomwgjRp8gnNvcmuG0DoiSv5Tpyva0FtvGRYSv+rt0I=;
        b=aEsLc1iiy8iYRL6mTF5bdilT/PpcFiqTU8j9i2+EgMeSRPfJulSsvKIfdWgfCeHUmW
         93SDwZt+xdmuSRT0rkpd3ALmpP0mKnKW6MKm8JRnqlJyFgiWT9Mzmoepy1hHN9WIrpEl
         yzCBMQqeA0VIJdXYUKV0bVin6lwSw+gUnNzxfbz253+szGhKmdA4uC4t9M7uIE3AGfPC
         0IiiU2HgzUqlyRZS6ubxT3zfnETnIygWwPvWcPdBMRHzH33dIZ4RqGrmDQPPjy2jJNk3
         ULy/QcvlYc+vw+xDm1ljJRO/syZLuKfQVNCwUzGxKgvAhAjel0rc6CAEEunTT2PPKGJU
         /YmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248753; x=1794853553;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gomwgjRp8gnNvcmuG0DoiSv5Tpyva0FtvGRYSv+rt0I=;
        b=zAgumpWIYkSJXeQhqkOaEfyk38D9TUAMuqCExuY8mI50YdkOVgcwQglHkZJp9LOMxe
         7r3WRCj+tvTEn6eCGaDp/Ez91w6cy+8bFAVelbujD8PnhOuQmLaQKnAPSotPRfMgdTos
         VShhPVK3ocDBs20Etb10PV4jJj45mN1i41Q6KlTnHCZ9sqVeTbNAbEbkShKg363KDyMW
         Rwden2O+zi8XBhM8CMZYOK4ReW5yT7Se9gIfx0j9n5f26rLitEbYQdPmPxIkFAqhg68U
         nr1qaUrcdsONmZpWUg3aJtd7IMtAWGDuOAHvu/GD3Sb4DsunKQMEr8hEQo3VzNkxaLsA
         fOQg==
X-Forwarded-Encrypted: i=1; AL+hErFDkWKSY6dZmYcGV26PLHhbk4nzwqE9CFCLUVOdAb0lHrxGCu7T9RHFGNoWNOufTnkWfH8fMg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+p516AppH8axPLuT4EZ2dD+hP5ohbYoTPHdv3+hQ1j7UAYElHw
	pYvBv3ElB+AqwnQcJoVjL5w0AKcMyGF+DGDz8EGAy9AHg8ENhHcXZqjz9+Q+7Y3PROtxLBvOgu6
	uHmpxGQ==
X-Received: from ejpg23.prod.google.com ([2002:a17:906:7c57:b0:c3f:d175:ee6a])
 (user=lrizzo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:3e20:b0:c41:64c1:cc2d
 with SMTP id a640c23a62f3a-c50491bd62emr17871766b.2.1794248752661; Mon, 09
 Nov 2026 10:25:52 -0800 (PST)
Date: Mon,  9 Nov 2026 18:25:24 +0000
In-Reply-To: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261003212241.3432303-1-lrizzo@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261109182533.3594984-17-lrizzo@google.com>
Subject: [RFC PATCH v2 16/25] mm/slub: Add SLAB_CACHE_PISA_RO for PISA-backed
 slab caches
From: Luigi Rizzo <lrizzo@google.com>
To: Luigi Rizzo <rizzo.unipi@gmail.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, David Hildenbrand <david@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	iommu@lists.linux.dev, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

skb heads are provided by a slab allocator that is fed by alloc_pages().

Add SLAB_CACHE_PISA_RO so that a slab cache can back its slabs with
zeroed, read-only PISA folios (__GFP_PISA_RO | __GFP_ZERO) via
pisa_alloc_folio(), clamping the slab order to
[2, PAGE_ALLOC_COSTLY_ORDER].
Slabs are still released with free_frozen_pages(), so pages from PISA
return to their allocator via __free_pages_prepare(). Caches with
SLAB_CACHE_PISA_RO skip KFENCE and are never merged.

Existing caches are unaffected.

Signed-off-by: Luigi Rizzo <lrizzo@google.com>
---
 drivers/iommu/pisa-alloc.c | 27 +++++++++++++++++++++++++++
 drivers/iommu/pisa-kunit.c | 19 +++++++++++++++++++
 include/linux/pisa.h       |  7 +++++++
 include/linux/slab.h       | 10 ++++++++++
 mm/slab.h                  |  3 ++-
 mm/slab_common.c           |  5 ++++-
 mm/slub.c                  | 14 +++++++++++++-
 7 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/pisa-alloc.c b/drivers/iommu/pisa-alloc.c
index 4b61ec84ed6d1..3b5c49d143a7e 100644
--- a/drivers/iommu/pisa-alloc.c
+++ b/drivers/iommu/pisa-alloc.c
@@ -848,6 +848,33 @@ unsigned long pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order, int preferred
 	return pisa_alloc_bulk(pa, gfp & ~__GFP_PISA_RW, nr_pages, page_array, frozen);
 }
 
+/**
+ * pisa_alloc_folio - Allocate a frozen folio for SLUB (SLAB_CACHE_PISA_RO)
+ * @gfp: GFP flags (must have __GFP_PISA_RW or __GFP_PISA_RO set)
+ * @order: Folio order
+ * @nid: Target NUMA node (or NUMA_NO_NODE)
+ *
+ * Drops __GFP_THISNODE before calling the per-node allocator and verifies
+ * node placement afterwards.
+ *
+ * Return: Frozen folio of @order, or NULL.
+ */
+struct folio *pisa_alloc_folio(gfp_t gfp, unsigned int order, int nid)
+{
+	struct page *page;
+
+	page = pisa_alloc_pages(gfp & ~__GFP_THISNODE, order, nid, NULL);
+	if (!page)
+		return NULL;
+	if (unlikely((gfp & __GFP_THISNODE) && nid != NUMA_NO_NODE &&
+		     page_to_nid(page) != nid)) {
+		page_ref_unfreeze(page, 1);
+		__free_pages(page, order);
+		return NULL;
+	}
+	return page_folio(page);
+}
+
 /**
  * pisa_has_free_blocks_rx - Check if @dev has free PISA RX blocks of @order on @nid
  * @dev: Device to check
diff --git a/drivers/iommu/pisa-kunit.c b/drivers/iommu/pisa-kunit.c
index 40bf7801183da..9cc1328893ace 100644
--- a/drivers/iommu/pisa-kunit.c
+++ b/drivers/iommu/pisa-kunit.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/shrinker.h>
 #include <linux/skbuff.h>
+#include <linux/slab.h>
 #include <net/sock.h>
 
 #include "dma-iommu.h"
@@ -621,6 +622,23 @@ static void test_reservoir_and_scrubber(struct kunit *test)
 	WRITE_ONCE(pisa_scrub_max, old_scrub);
 }
 
+static void test_slub_page_alloc(struct kunit *test)
+{
+	struct kmem_cache *s;
+	void *obj;
+
+	s = kmem_cache_create("pisa_kunit_slab", 1024, NULL,
+			      SLAB_NO_MERGE | SLAB_CACHE_PISA_RO);
+	KUNIT_ASSERT_NOT_NULL(test, s);
+
+	obj = kmem_cache_alloc(s, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, obj);
+	KUNIT_EXPECT_TRUE(test, is_pisa_page(virt_to_page(obj)));
+	kmem_cache_free(s, obj);
+
+	kmem_cache_destroy(s);
+}
+
 static struct kunit_case pisa_meta_test_cases[] = {
 	KUNIT_CASE(test_meta_init_and_roundtrip),
 	KUNIT_CASE(test_meta_invalid_phys),
@@ -635,6 +653,7 @@ static struct kunit_case pisa_meta_test_cases[] = {
 	KUNIT_CASE(test_pcp_cache),
 	KUNIT_CASE(test_gfp_pisa),
 	KUNIT_CASE(test_reservoir_and_scrubber),
+	KUNIT_CASE(test_slub_page_alloc),
 	{}
 };
 
diff --git a/include/linux/pisa.h b/include/linux/pisa.h
index 89eb0722d90bc..b9c5197f2d88d 100644
--- a/include/linux/pisa.h
+++ b/include/linux/pisa.h
@@ -110,6 +110,7 @@ unsigned long pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order,
 				    int nr_pages, struct page **page_array,
 				    bool frozen);
 
+struct folio *pisa_alloc_folio(gfp_t gfp, unsigned int order, int nid);
 bool pisa_has_free_blocks_rx(const struct device *dev, unsigned int order, int nid);
 bool pisa_page_can_recycle(const struct page *page);
 
@@ -181,6 +182,12 @@ pisa_alloc_pages_bulk(gfp_t gfp, unsigned int order, int preferred_nid,
 	return 0;
 }
 
+static inline struct folio *
+pisa_alloc_folio(gfp_t gfp, unsigned int order, int nid)
+{
+	return NULL;
+}
+
 static inline gfp_t pisa_rx_gfp(const struct device *dev)
 {
 	return 0;
diff --git a/include/linux/slab.h b/include/linux/slab.h
index cda126def67af..df19c5898e9fe 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -66,6 +66,9 @@ enum _slab_flag_bits {
 #endif
 #endif
 	_SLAB_NO_SHEAVES,
+#ifdef CONFIG_PISA
+	_SLAB_CACHE_PISA_RO,
+#endif
 	_SLAB_FLAGS_LAST_BIT
 };
 
@@ -260,6 +263,13 @@ enum _slab_flag_bits {
 #define SLAB_OBJ_EXT_IN_OBJ	__SLAB_FLAG_UNUSED
 #endif
 
+/* Back slabs with zeroed read-only PISA folios (__GFP_PISA_RO | __GFP_ZERO) */
+#ifdef CONFIG_PISA
+#define SLAB_CACHE_PISA_RO	__SLAB_FLAG_BIT(_SLAB_CACHE_PISA_RO)
+#else
+#define SLAB_CACHE_PISA_RO	__SLAB_FLAG_UNUSED
+#endif
+
 /*
  * ZERO_SIZE_PTR will be returned for zero sized kmalloc requests.
  *
diff --git a/mm/slab.h b/mm/slab.h
index e94ac63d10dc0..53620e40b216b 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -473,7 +473,8 @@ void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
 			 SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS | \
 			 SLAB_NOLEAKTRACE | SLAB_RECLAIM_ACCOUNT | \
 			 SLAB_TEMPORARY | SLAB_ACCOUNT | \
-			 SLAB_NO_USER_FLAGS | SLAB_KMALLOC | SLAB_NO_MERGE)
+			 SLAB_NO_USER_FLAGS | SLAB_KMALLOC | SLAB_NO_MERGE | \
+			 SLAB_CACHE_PISA_RO)
 
 #define SLAB_DEBUG_FLAGS (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
 			  SLAB_TRACE | SLAB_CONSISTENCY_CHECKS)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 01c64ef661e7f..d6c00047b1623 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -49,7 +49,7 @@ struct kmem_cache *kmem_cache;
  */
 #define SLAB_NEVER_MERGE (SLAB_DEBUG_FLAGS | SLAB_TYPESAFE_BY_RCU | \
 		SLAB_NOLEAKTRACE | SLAB_FAILSLAB | SLAB_NO_MERGE | \
-		SLAB_OBJ_EXT_IN_OBJ)
+		SLAB_OBJ_EXT_IN_OBJ | SLAB_CACHE_PISA_RO)
 
 #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_ACCOUNT | SLAB_MAY_ACCOUNT)
@@ -377,6 +377,9 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 	if (s)
 		goto out_unlock;
 
+	if (flags & SLAB_CACHE_PISA_RO)
+		flags |= SLAB_SKIP_KFENCE;
+
 	cache_name = kstrdup_const(name, GFP_KERNEL);
 	if (!cache_name) {
 		err = -ENOMEM;
diff --git a/mm/slub.c b/mm/slub.c
index 45e077c7526c2..63609768f4e3f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -46,6 +46,7 @@
 #include <linux/prandom.h>
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
+#include <linux/pisa.h>
 #include <linux/sort.h>
 #include <linux/irq_work.h>
 #include <linux/kprobes.h>
@@ -3378,6 +3379,8 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
 	if (unlikely(!allow_spin))
 		page = alloc_frozen_pages_nolock(0/* __GFP_COMP is implied */,
 								  node, order);
+	else if (unlikely(flags & __GFP_PISA_RO))
+		page = (struct page *)pisa_alloc_folio(flags, order, node);
 	else if (node == NUMA_NO_NODE)
 		page = alloc_frozen_pages(flags, order);
 	else
@@ -3484,7 +3487,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags,
 	gfp_t alloc_gfp;
 	void *start;
 
-	flags &= gfp_allowed_mask;
+	flags &= gfp_allowed_mask & ~__GFP_PISA_RW;
 
 	flags |= s->allocflags;
 
@@ -3495,9 +3498,13 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags,
 	alloc_gfp = (flags | __GFP_NOWARN | __GFP_NORETRY) & ~__GFP_NOFAIL;
 	if ((alloc_gfp & __GFP_DIRECT_RECLAIM) && oo_order(oo) > oo_order(s->min))
 		alloc_gfp = (alloc_gfp | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM;
+	if (unlikely(s->flags & SLAB_CACHE_PISA_RO))
+		alloc_gfp = (flags | __GFP_NOWARN) & ~__GFP_NOFAIL;
 
 	slab = alloc_slab_page(alloc_gfp, node, oo, allow_spin);
 	if (unlikely(!slab)) {
+		if (s->flags & SLAB_CACHE_PISA_RO)
+			return NULL;
 		oo = s->min;
 		alloc_gfp = flags;
 		/*
@@ -8182,6 +8189,11 @@ static int calculate_sizes(struct kmem_cache_args *args, struct kmem_cache *s)
 	if (s->flags & SLAB_RECLAIM_ACCOUNT)
 		s->allocflags |= __GFP_RECLAIMABLE;
 
+	if (s->flags & SLAB_CACHE_PISA_RO) {
+		s->allocflags |= __GFP_PISA_RO | __GFP_ZERO;
+		order = clamp_t(unsigned int, order, 2, PAGE_ALLOC_COSTLY_ORDER);
+	}
+
 	/*
 	 * For kmalloc caches we enable sheaves later by
 	 * bootstrap_kmalloc_sheaves() to avoid recursion.
-- 
2.56.0.542.g3ef89b7020-goog

