Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1301EC38A2C
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 00:05:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6CD92084D
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 00:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="SSTyKD1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CD92084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A6E5B85C95;
	Wed, 15 Apr 2020 00:05:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QemI8O_M86m4; Wed, 15 Apr 2020 00:05:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B05C385C86;
	Wed, 15 Apr 2020 00:05:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F3D9C1D8D;
	Wed, 15 Apr 2020 00:05:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 724C0C0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 00:04:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5F61487E56
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 00:04:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gUdNmrpJZ+cb for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 00:04:58 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9FDEF87E54
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 00:04:58 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id a32so6003291pje.5
 for <iommu@lists.linux-foundation.org>; Tue, 14 Apr 2020 17:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=fvE20WzTia3PlpbcEfRbKcopfOLGLyEeBU9i4s4lrX4=;
 b=SSTyKD1ZOcNsQoBj+fiA3e0/x8UzcDU00xsOMVkGKWgsBra4CzHIlgIpM5Hf25JcYJ
 N/qXZzifsJVIT2txZ9eB32J1T3uYDtrmSa7fz4crymKibZkbe0E2hCMVOlwzxmPgRiUm
 LU/vvhYbR2uIblGEzuL3M44aCBywquALEEsELpTkuvTv7uZOS6UOMDJF3Fnhr5efNrlm
 RiLELA5A/NPj8qAoCj6PlduoIOOS0GVg7B7ZmDJd/pJpRt8OUidDJmSBYQufZSb+92AA
 cRPmvY2iBXxsWQhoScJYIX7VSN8VQWSxtgiZDslI/SNlCdpLKFbOqxEVLFhy3hvlZ8kN
 o0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=fvE20WzTia3PlpbcEfRbKcopfOLGLyEeBU9i4s4lrX4=;
 b=Lta2wbjv8gYt2VVt+a2TqOf9UXkTbSn3NVDu2Xi+Jekb8CGehRwy4jZNCzvxLMjYY1
 a5Q6f/7Eu60oZIA4ZJwC5Zlmn/fMVE0etcs/SL2bKHF737wydjihzlfyduY/rEzQ+0oe
 TJYDXkiJLjk2Vn4v/KW6ZRI6MivNg9a1qHhy3MSeHfhuNp42rwtxYSSqiYTckLTal4UR
 7WooY78nr3TsjpZuDEuhU8q7S3EzfAA9jNYNyyYPYDK0D7i0jaAbRpFLpvnNlC0UsH5U
 M66prC+z3ywc2GC35VnYjpb6bBSIIkkSPqgbsn1TaaZOIWq0V0YxMqEvEb2Yf4AY/L4l
 6cYQ==
X-Gm-Message-State: AGi0PuZlhNMAzBATgHumr5k80cLs3Q0DaxJdzLluJNxMsD4L+BpIAVEz
 g+X7yL1ltTl4WVg0Q/HfoFQmKQ==
X-Google-Smtp-Source: APiQypJ1PjAne6YwQhhUJSqljY5Gj4XVzm20bbfXP82ChUmZFArF2ZBb8adfZczpdeKQBgF/ZDKuvQ==
X-Received: by 2002:a17:902:a603:: with SMTP id
 u3mr2401722plq.105.1586909098036; 
 Tue, 14 Apr 2020 17:04:58 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id 11sm11848427pfz.91.2020.04.14.17.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 17:04:57 -0700 (PDT)
Date: Tue, 14 Apr 2020 17:04:56 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [patch 3/7] dma-pool: dynamically expanding atomic pools
In-Reply-To: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.22.394.2004141703350.68516@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Cc: x86@kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>
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

Allocations for lowmem should also use GFP_KERNEL for the benefits of
reclaim, so use GFP_KERNEL | GFP_DMA and GFP_KERNEL | GFP_DMA32 for
lowmem allocations.

This also allows __dma_atomic_pool_init() to return a pointer to the pool
to make initialization cleaner.

Also switch over some node ids to the more appropriate NUMA_NO_NODE.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/pool.c | 122 +++++++++++++++++++++++++++++++---------------
 1 file changed, 84 insertions(+), 38 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 5c98ab991b16..9e2da17ed17b 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -9,13 +9,17 @@
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
@@ -24,76 +28,116 @@ static int __init early_coherent_pool(char *p)
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
+		atomic_pool_resize(atomic_pool_dma,
+				   GFP_KERNEL | GFP_DMA);
+	if (IS_ENABLED(CONFIG_ZONE_DMA32))
+		atomic_pool_resize(atomic_pool_dma32,
+				   GFP_KERNEL | GFP_DMA32);
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
+						GFP_KERNEL | GFP_DMA);
+		if (!atomic_pool_dma)
+			ret = -ENOMEM;
 	}
 	if (IS_ENABLED(CONFIG_ZONE_DMA32)) {
-		err = __dma_atomic_pool_init(&atomic_pool_dma32,
-					     atomic_pool_size, GFP_DMA32);
-		if (!ret && err)
-			ret = err;
+		atomic_pool_dma32 = __dma_atomic_pool_init(atomic_pool_size,
+						GFP_KERNEL | GFP_DMA32);
+		if (!atomic_pool_dma32)
+			ret = -ENOMEM;
 	}
 	return ret;
 }
@@ -142,6 +186,8 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
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
