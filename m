Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716F4C433E1
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 10:47:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43AED20775
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 10:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yrw68s/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AED20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 10F9386A5B;
	Tue, 28 Jul 2020 10:47:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p81MoL9a7CUQ; Tue, 28 Jul 2020 10:47:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AF1A6868BD;
	Tue, 28 Jul 2020 10:47:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95553C0050;
	Tue, 28 Jul 2020 10:47:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 202BBC0050
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 10:47:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1323886AB6
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 10:47:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iKsTc6AFjnSb for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 10:47:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B900186C1A
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 10:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=0rqvrvsMt0n+zFTQU19nXsQK86pglSrGOXHi1Qp6yto=; b=Yrw68s/wiCBQaJ7/apD2sEm88h
 hBnAfdtuAfvcL+MztZQfqVA4Jx/hGq2bcrQDPNBn/WWMNcMA34ZyxyhQ/5hx6p4D7b8wV8xQb47Dg
 1lc8T2pjSAE3egPuZlUx7OMhu01EDmaZitgV8Opte0TJrmwZrD+x63Js+uId/b/pzRoez1GB0Muip
 Eb5gYO6NWH0+SUhHUE/7xCPh40uHFDDCsCKIEQQfmoxVnMq9/irmYDh8tcKNSv6G8tl9KNyL8Z1Tp
 xF4+z1BdxvvnQjoYum2zFlJjLgr+xr1CRFU6igXhrlc4j0RvQpB8R3osNETGNRay7WgCWN7YlxmcA
 /gQgS+NQ==;
Received: from [2001:4bb8:180:6102:7902:553b:654a:8555] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0N98-0004ra-0l; Tue, 28 Jul 2020 10:47:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Amit Pundir <amit.pundir@linaro.org>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 1/2] dma-pool: fix coherent pool allocations for IOMMU mappings
Date: Tue, 28 Jul 2020 12:47:41 +0200
Message-Id: <20200728104742.422960-2-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728104742.422960-1-hch@lst.de>
References: <20200728104742.422960-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
 David Rientjes <rientjes@google.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

When allocating coherent pool memory for an IOMMU mapping we don't care
about the DMA mask.  Move the guess for the initial GFP mask into the
dma_direct_alloc_pages and pass dma_coherent_ok as a function pointer
argument so that it doesn't get applied to the IOMMU case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/iommu/dma-iommu.c   |   4 +-
 include/linux/dma-direct.h  |   3 -
 include/linux/dma-mapping.h |   5 +-
 kernel/dma/direct.c         |  13 ++--
 kernel/dma/pool.c           | 114 +++++++++++++++---------------------
 5 files changed, 62 insertions(+), 77 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 4959f5df21bd07..5141d49a046baa 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1035,8 +1035,8 @@ static void *iommu_dma_alloc(struct device *dev, size_t size,
 
 	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
 	    !gfpflags_allow_blocking(gfp) && !coherent)
-		cpu_addr = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &page,
-					       gfp);
+		page = dma_alloc_from_pool(dev, PAGE_ALIGN(size), &cpu_addr,
+					       gfp, NULL);
 	else
 		cpu_addr = iommu_dma_alloc_pages(dev, size, &page, gfp, attrs);
 	if (!cpu_addr)
diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index ab2e20cba9514b..ba22952c24e244 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -67,9 +67,6 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
 }
 
 u64 dma_direct_get_required_mask(struct device *dev);
-gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
-				  u64 *phys_mask);
-bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size);
 void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index a33ed3954ed465..0dc08701d7b7ee 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -715,8 +715,9 @@ void *dma_common_pages_remap(struct page **pages, size_t size,
 			pgprot_t prot, const void *caller);
 void dma_common_free_remap(void *cpu_addr, size_t size);
 
-void *dma_alloc_from_pool(struct device *dev, size_t size,
-			  struct page **ret_page, gfp_t flags);
+struct page *dma_alloc_from_pool(struct device *dev, size_t size,
+		void **cpu_addr, gfp_t flags,
+		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t));
 bool dma_free_from_pool(struct device *dev, void *start, size_t size);
 
 int
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 67f060b86a73fa..f17aec9d01f0c0 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -45,7 +45,7 @@ u64 dma_direct_get_required_mask(struct device *dev)
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
 
-gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
+static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
 				  u64 *phys_limit)
 {
 	u64 dma_limit = min_not_zero(dma_mask, dev->bus_dma_limit);
@@ -70,7 +70,7 @@ gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
 	return 0;
 }
 
-bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
+static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
 	return phys_to_dma_direct(dev, phys) + size - 1 <=
 			min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit);
@@ -163,8 +163,13 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
 	size = PAGE_ALIGN(size);
 
 	if (dma_should_alloc_from_pool(dev, gfp, attrs)) {
-		ret = dma_alloc_from_pool(dev, size, &page, gfp);
-		if (!ret)
+		u64 phys_mask;
+
+		gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
+				&phys_mask);
+		page = dma_alloc_from_pool(dev, size, &ret, gfp,
+				dma_coherent_ok);
+		if (!page)
 			return NULL;
 		goto done;
 	}
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 6bc74a2d51273e..1ddcd48f271fff 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -196,93 +196,75 @@ static int __init dma_atomic_pool_init(void)
 }
 postcore_initcall(dma_atomic_pool_init);
 
-static inline struct gen_pool *dma_guess_pool_from_device(struct device *dev)
+static inline struct gen_pool *dma_guess_pool(struct gen_pool *prev, gfp_t gfp)
 {
-	u64 phys_mask;
-	gfp_t gfp;
-
-	gfp = dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
-					  &phys_mask);
-	if (IS_ENABLED(CONFIG_ZONE_DMA) && gfp == GFP_DMA)
+	if (prev == NULL) {
+		if (IS_ENABLED(CONFIG_ZONE_DMA32) && (gfp & GFP_DMA32))
+			return atomic_pool_dma32;
+		if (IS_ENABLED(CONFIG_ZONE_DMA) && (gfp & GFP_DMA))
+			return atomic_pool_dma;
+		return atomic_pool_kernel;
+	}
+	if (prev == atomic_pool_kernel)
+		return atomic_pool_dma32 ? atomic_pool_dma32 : atomic_pool_dma;
+	if (prev == atomic_pool_dma32)
 		return atomic_pool_dma;
-	if (IS_ENABLED(CONFIG_ZONE_DMA32) && gfp == GFP_DMA32)
-		return atomic_pool_dma32;
-	return atomic_pool_kernel;
+	return NULL;
 }
 
-static inline struct gen_pool *dma_get_safer_pool(struct gen_pool *bad_pool)
+static struct page *__dma_alloc_from_pool(struct device *dev, size_t size,
+		struct gen_pool *pool, void **cpu_addr,
+		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
 {
-	if (bad_pool == atomic_pool_kernel)
-		return atomic_pool_dma32 ? : atomic_pool_dma;
+	unsigned long addr;
+	phys_addr_t phys;
 
-	if (bad_pool == atomic_pool_dma32)
-		return atomic_pool_dma;
+	addr = gen_pool_alloc(pool, size);
+	if (!addr)
+		return NULL;
 
-	return NULL;
-}
+	phys = gen_pool_virt_to_phys(pool, addr);
+	if (!phys_addr_ok(dev, phys, size)) {
+		gen_pool_free(pool, addr, size);
+		return NULL;
+	}
 
-static inline struct gen_pool *dma_guess_pool(struct device *dev,
-					      struct gen_pool *bad_pool)
-{
-	if (bad_pool)
-		return dma_get_safer_pool(bad_pool);
+	if (gen_pool_avail(pool) < atomic_pool_size)
+		schedule_work(&atomic_pool_work);
 
-	return dma_guess_pool_from_device(dev);
+	*cpu_addr = (void *)addr;
+	memset(*cpu_addr, 0, size);
+	return pfn_to_page(__phys_to_pfn(phys));
 }
 
-void *dma_alloc_from_pool(struct device *dev, size_t size,
-			  struct page **ret_page, gfp_t flags)
+struct page *dma_alloc_from_pool(struct device *dev, size_t size,
+		void **cpu_addr, gfp_t gfp,
+		bool (*phys_addr_ok)(struct device *, phys_addr_t, size_t))
 {
 	struct gen_pool *pool = NULL;
-	unsigned long val = 0;
-	void *ptr = NULL;
-	phys_addr_t phys;
-
-	while (1) {
-		pool = dma_guess_pool(dev, pool);
-		if (!pool) {
-			WARN(1, "Failed to get suitable pool for %s\n",
-			     dev_name(dev));
-			break;
-		}
-
-		val = gen_pool_alloc(pool, size);
-		if (!val)
-			continue;
-
-		phys = gen_pool_virt_to_phys(pool, val);
-		if (dma_coherent_ok(dev, phys, size))
-			break;
-
-		gen_pool_free(pool, val, size);
-		val = 0;
-	}
-
-
-	if (val) {
-		*ret_page = pfn_to_page(__phys_to_pfn(phys));
-		ptr = (void *)val;
-		memset(ptr, 0, size);
+	struct page *page;
 
-		if (gen_pool_avail(pool) < atomic_pool_size)
-			schedule_work(&atomic_pool_work);
+	while ((pool = dma_guess_pool(pool, gfp))) {
+		page = __dma_alloc_from_pool(dev, size, pool, cpu_addr,
+					     phys_addr_ok);
+		if (page)
+			return page;
 	}
 
-	return ptr;
+	WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));
+	return NULL;
 }
 
 bool dma_free_from_pool(struct device *dev, void *start, size_t size)
 {
 	struct gen_pool *pool = NULL;
 
-	while (1) {
-		pool = dma_guess_pool(dev, pool);
-		if (!pool)
-			return false;
-
-		if (gen_pool_has_addr(pool, (unsigned long)start, size)) {
-			gen_pool_free(pool, (unsigned long)start, size);
-			return true;
-		}
+	while ((pool = dma_guess_pool(pool, 0))) {
+		if (!gen_pool_has_addr(pool, (unsigned long)start, size))
+			continue;
+		gen_pool_free(pool, (unsigned long)start, size);
+		return true;
 	}
+
+	return false;
 }
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
