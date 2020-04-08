Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DB9C2BA2B
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EBFA20771
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="A2jYLkpG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBFA20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 79FC8880C2;
	Wed,  8 Apr 2020 21:21:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GB58CYrcQyM5; Wed,  8 Apr 2020 21:21:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4D0AB87F40;
	Wed,  8 Apr 2020 21:21:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34981C1AE8;
	Wed,  8 Apr 2020 21:21:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56504C1AE8
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 21:21:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 4AFD9880C2
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 21:21:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K50Oaw2wI39V for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 21:21:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com
 [209.85.216.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CBDA487F0A
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 21:21:08 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id t40so360628pjb.3
 for <iommu@lists.linux-foundation.org>; Wed, 08 Apr 2020 14:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=XrwqZbZ6JyVYdyuo7IDIjfmWjlFwWYqBg8MJXvuP7Jc=;
 b=A2jYLkpGa0TCVu3kNy7L56iAgQwz3sQ513YQzo//e/Wc3fAPFs6p7v+WNGTHIO3KeU
 BeluFw3ZxMv09dOUmZf7M7NBt6RjPcjCW02G3bQ/bxNGs+fhqdNmNWa9H/0AAgRfCWPi
 PADq4pdWtj8LIkrAmyp+PXKyyLrBC+NR7bSfsVUploFgg07Mtttnv1b591p7vqTUakpp
 AQhZdZJ64dKSx0hvbr3C1VPDQeF8DdzjllK6umv12yPbTurhEo3xLdVTmVYhlQucCPCt
 IfSSBRrhsaic5yUufnGm5LnQLzntolBb1LU9wxzWfYVDpaVZ7chXGrXrhFCsNYDMFXlk
 mVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=XrwqZbZ6JyVYdyuo7IDIjfmWjlFwWYqBg8MJXvuP7Jc=;
 b=QtyhDPPhxg/V7fJz3cgmZLO5PIxarMgxwzpPFr2XO3v6e/207RgtS0s1p7vuf9vjCI
 iHpEhi0zl+7BMlR8fIcB2fGUMVGVflN8XEm9rYgxiglojSqa2CE8HaQxrYjoqPPW0GDf
 i1RurrKkBCLnV/V7As51bFAdBLpYmGA4cOGNa73RsbMkO/peqTLePtCAiylnSU4BsE5P
 efWXBvbKgVL/rpI93Vyc4OM8ROsmR/BmmSGgA5mZTY/a77Xle5M0RBun7mEG/s3nk5ko
 W+vePpOgQ4266Lrl4dqpaP9DCLXPsi7nvWWSQEy/0M3FaQMVcIdYatBvf9RbW7wJMOKD
 /J5w==
X-Gm-Message-State: AGi0PuZO8OIs1X7QCOOQHX3p+3cvNrpVVqrL3h7BUHT6/HVOsRJk4Phi
 m2fsBQxGVL9L4agpwMByuZGULA==
X-Google-Smtp-Source: APiQypJbHyPTVqa91PsxIG/fkhTk5MssOnwIaFUlxeUKZl5SkSrG8Vblfvw7O0m0Pc1Ho/EM1StflQ==
X-Received: by 2002:a17:90a:3328:: with SMTP id
 m37mr7669217pjb.158.1586380868065; 
 Wed, 08 Apr 2020 14:21:08 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id a185sm17750579pfa.27.2020.04.08.14.21.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2020 14:21:07 -0700 (PDT)
Date: Wed, 8 Apr 2020 14:21:06 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [rfc v2 3/6] dma-pool: dynamically expanding atomic pools
In-Reply-To: <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2004081419510.19661@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
 <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com>
 <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: "Grimm, Jon" <jon.grimm@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

When an atomic pool becomes fully depleted because it is now relied upon
for all non-blocking allocations through the DMA API, allow background
expansion of each pool by a kworker.

When an atomic pool has less than the default size of memory left, kick
off a kworker to dynamically expand the pool in the background.  The pool
is doubled in size, up to MAX_ORDER-1.  If memory cannot be allocated at
the requested order, smaller allocation(s) are attempted.

This allows the default size to be kept quite low when one or more of the
atomic pools is not used.

This also allows __dma_atomic_pool_init to return a pointer to the pool
to make initialization cleaner.

Also switch over some node ids to the more appropriate NUMA_NO_NODE.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/pool.c | 120 +++++++++++++++++++++++++++++++---------------
 1 file changed, 82 insertions(+), 38 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 9b806f5eded8..e14c5a2da734 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -11,13 +11,17 @@
 #include <linux/genalloc.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/workqueue.h>
 
 static struct gen_pool *atomic_pool_dma __ro_after_init;
 static struct gen_pool *atomic_pool_dma32 __ro_after_init;
 static struct gen_pool *atomic_pool_kernel __ro_after_init;
 
 #define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
-static size_t atomic_pool_size __initdata = DEFAULT_DMA_COHERENT_POOL_SIZE;
+static size_t atomic_pool_size = DEFAULT_DMA_COHERENT_POOL_SIZE;
+
+/* Dynamic background expansion when the atomic pool is near capacity */
+static struct work_struct atomic_pool_work;
 
 static int __init early_coherent_pool(char *p)
 {
@@ -26,76 +30,114 @@ static int __init early_coherent_pool(char *p)
 }
 early_param("coherent_pool", early_coherent_pool);
 
-static int __init __dma_atomic_pool_init(struct gen_pool **pool,
-					 size_t pool_size, gfp_t gfp)
+static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
+			      gfp_t gfp)
 {
-	const unsigned int order = get_order(pool_size);
-	const unsigned long nr_pages = pool_size >> PAGE_SHIFT;
+	unsigned int order;
 	struct page *page;
 	void *addr;
-	int ret;
+	int ret = -ENOMEM;
+
+	/* Cannot allocate larger than MAX_ORDER-1 */
+	order = min(get_order(pool_size), MAX_ORDER-1);
+
+	do {
+		pool_size = 1 << (PAGE_SHIFT + order);
 
-	if (dev_get_cma_area(NULL))
-		page = dma_alloc_from_contiguous(NULL, nr_pages, order, false);
-	else
-		page = alloc_pages(gfp, order);
+		if (dev_get_cma_area(NULL))
+			page = dma_alloc_from_contiguous(NULL, 1 << order,
+							 order, false);
+		else
+			page = alloc_pages(gfp, order);
+	} while (!page && order-- > 0);
 	if (!page)
 		goto out;
 
 	arch_dma_prep_coherent(page, pool_size);
 
-	*pool = gen_pool_create(PAGE_SHIFT, -1);
-	if (!*pool)
-		goto free_page;
-
 	addr = dma_common_contiguous_remap(page, pool_size,
 					   pgprot_dmacoherent(PAGE_KERNEL),
 					   __builtin_return_address(0));
 	if (!addr)
-		goto destroy_genpool;
+		goto free_page;
 
-	ret = gen_pool_add_virt(*pool, (unsigned long)addr, page_to_phys(page),
-				pool_size, -1);
+	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
+				pool_size, NUMA_NO_NODE);
 	if (ret)
 		goto remove_mapping;
-	gen_pool_set_algo(*pool, gen_pool_first_fit_order_align, NULL);
 
-	pr_info("DMA: preallocated %zu KiB %pGg pool for atomic allocations\n",
-		pool_size >> 10, &gfp);
 	return 0;
 
 remove_mapping:
 	dma_common_free_remap(addr, pool_size);
-destroy_genpool:
-	gen_pool_destroy(*pool);
-	*pool = NULL;
 free_page:
-	if (!dma_release_from_contiguous(NULL, page, nr_pages))
+	if (!dma_release_from_contiguous(NULL, page, 1 << order))
 		__free_pages(page, order);
 out:
-	pr_err("DMA: failed to allocate %zu KiB %pGg pool for atomic allocation\n",
-	       pool_size >> 10, &gfp);
-	return -ENOMEM;
+	return ret;
+}
+
+static void atomic_pool_resize(struct gen_pool *pool, gfp_t gfp)
+{
+	if (pool && gen_pool_avail(pool) < atomic_pool_size)
+		atomic_pool_expand(pool, gen_pool_size(pool), gfp);
+}
+
+static void atomic_pool_work_fn(struct work_struct *work)
+{
+	if (IS_ENABLED(CONFIG_ZONE_DMA))
+		atomic_pool_resize(atomic_pool_dma, GFP_DMA);
+	if (IS_ENABLED(CONFIG_ZONE_DMA32))
+		atomic_pool_resize(atomic_pool_dma32, GFP_DMA32);
+	atomic_pool_resize(atomic_pool_kernel, GFP_KERNEL);
+}
+
+static __init struct gen_pool *__dma_atomic_pool_init(size_t pool_size,
+						      gfp_t gfp)
+{
+	struct gen_pool *pool;
+	int ret;
+
+	pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
+	if (!pool)
+		return NULL;
+
+	gen_pool_set_algo(pool, gen_pool_first_fit_order_align, NULL);
+
+	ret = atomic_pool_expand(pool, pool_size, gfp);
+	if (ret) {
+		gen_pool_destroy(pool);
+		pr_err("DMA: failed to allocate %zu KiB %pGg pool for atomic allocation\n",
+		       pool_size >> 10, &gfp);
+		return NULL;
+	}
+
+	pr_info("DMA: preallocated %zu KiB %pGg pool for atomic allocations\n",
+		gen_pool_size(pool) >> 10, &gfp);
+	return pool;
 }
 
 static int __init dma_atomic_pool_init(void)
 {
 	int ret = 0;
-	int err;
 
-	ret = __dma_atomic_pool_init(&atomic_pool_kernel, atomic_pool_size,
-				     GFP_KERNEL);
+	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
+
+	atomic_pool_kernel = __dma_atomic_pool_init(atomic_pool_size,
+						    GFP_KERNEL);
+	if (!atomic_pool_kernel)
+		ret = -ENOMEM;
 	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
-		err = __dma_atomic_pool_init(&atomic_pool_dma,
-					     atomic_pool_size, GFP_DMA);
-		if (!ret && err)
-			ret = err;
+		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
+							 GFP_DMA);
+		if (!atomic_pool_dma)
+			ret = -ENOMEM;
 	}
 	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
-		err = __dma_atomic_pool_init(&atomic_pool_dma32,
-					     atomic_pool_size, GFP_DMA32);
-		if (!ret && err)
-			ret = err;
+		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
+							   GFP_DMA32);
+		if (!atomic_pool_dma32)
+			ret = -ENOMEM;
 	}
 	return ret;
 }
@@ -144,6 +186,8 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
 		ptr = (void *)val;
 		memset(ptr, 0, size);
 	}
+	if (gen_pool_avail(pool) < atomic_pool_size)
+		schedule_work(&atomic_pool_work);
 
 	return ptr;
 }
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
