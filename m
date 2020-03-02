Return-Path: <SRS0=ZrTS=4T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F723C3F2D1
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 00:05:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E970246A1
	for <iommu@archiver.kernel.org>; Mon,  2 Mar 2020 00:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="j1TgDHt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E970246A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2E1B985039;
	Mon,  2 Mar 2020 00:05:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SmX-PPf2lRwQ; Mon,  2 Mar 2020 00:05:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 01B8A849E2;
	Mon,  2 Mar 2020 00:05:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD223C1D74;
	Mon,  2 Mar 2020 00:05:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9450AC013E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 00:05:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7853E2037E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 00:05:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aggM2tvLdVd7 for <iommu@lists.linux-foundation.org>;
 Mon,  2 Mar 2020 00:05:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com
 [209.85.215.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 04CF220029
 for <iommu@lists.linux-foundation.org>; Mon,  2 Mar 2020 00:05:20 +0000 (UTC)
Received: by mail-pg1-f193.google.com with SMTP id m5so663927pgg.0
 for <iommu@lists.linux-foundation.org>; Sun, 01 Mar 2020 16:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=1LQD39SjVeqtmLQiFZHIBXAjKJBE0e2cwCAeofuH3Zo=;
 b=j1TgDHt3ZsdFd2BIAni9vqIRjz05UjnfM1+l/4ZCv9UNbo38PL958p00ECLj8xUi9/
 ZxQWRufdOgyN70yt6qdwUN/abK6hwPQCd12Nlto8GN2+77MeoLpNoihEZakvdzBK6hOJ
 vc9xP7dlSu5aH4DG8FmtaWx9mLIPwe8giBbPC/KaYIs/YETi0uaklM6li42kXHV+ihbi
 yxp7y1QeUHM58xdcfs0U4DaK/FIV1PpxguIe8lry/wWHxLlRnspwD4Hm6zVP/a/7seae
 Xw9vdn/FBtnQ2wDsgsZ0DQy2DNTZpP34D+JcPYGWwS40xGtTcPdQrhwlgB1bYAHc2une
 glKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=1LQD39SjVeqtmLQiFZHIBXAjKJBE0e2cwCAeofuH3Zo=;
 b=E97BJXp4o8WsOuAJkhBooUIoKULtqZOKLzlj5cTU72chhj9a35poRbKeb9TRhv9mA7
 kYGDKsddgu8JclXUEi+rAtek9/dHh/xK0WI6K/zloHJxqwbU0ILNTt9RH9Vc0L74Ep7B
 fKCc24Eth7M2/Mkwzmu0u4Bx5kYaBXe5fzKqcmBFC6AwrYvpXzBI2HQ4WfglXgj/EgVi
 5+zPmfxCHVRj84zlhb+SLp4wZTpCM0a/i1N6lNRc1bD+S8XRb4KbUuy8dhuMIXDKEPxF
 xYedWnPOPL3DJsXEiJofTgRlw7JpTztoHbwHYIEDcBmVtJkJIXSnaMjf8GDNlj0AWp1/
 Yd4w==
X-Gm-Message-State: APjAAAUIer7N69yZzhkv2gTEKFkpTtWHE23sv5ziniCqjTHovoGwT+21
 sxHSt35E40098cTlzwUrBI1ajQ==
X-Google-Smtp-Source: APXvYqyMLcaNAChU05gqiq8Yg83xpqoR/A9irue1wQjHCzE/rxI9U8WMXJpT3gApHWFoC1rFV68VKw==
X-Received: by 2002:a62:fcd8:: with SMTP id
 e207mr14735494pfh.160.1583107519380; 
 Sun, 01 Mar 2020 16:05:19 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id 23sm18422587pfh.28.2020.03.01.16.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2020 16:05:18 -0800 (PST)
Date: Sun, 1 Mar 2020 16:05:18 -0800 (PST)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [rfc 4/6] dma-remap: dynamically expanding atomic pools
In-Reply-To: <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2003011537440.213582@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1912311738130.68206@chino.kir.corp.google.com>
 <b22416ec-cc28-3fd2-3a10-89840be173fa@amd.com>
 <alpine.DEB.2.21.2002280118461.165532@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003011535510.213582@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, "Grimm, Jon" <jon.grimm@amd.com>,
 baekhw@google.com,
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
is doubled in size.

This allows the default size to be kept quite low when one or more of the
atomic pools is not used.

Also switch over some node ids to the more appropriate NUMA_NO_NODE.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/remap.c | 79 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 21 deletions(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -10,6 +10,7 @@
 #include <linux/genalloc.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/workqueue.h>
 
 struct page **dma_common_find_pages(void *cpu_addr)
 {
@@ -104,7 +105,10 @@ static struct gen_pool *atomic_pool_dma32 __ro_after_init;
 static struct gen_pool *atomic_pool_normal __ro_after_init;
 
 #define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
-static size_t atomic_pool_size __initdata = DEFAULT_DMA_COHERENT_POOL_SIZE;
+static size_t atomic_pool_size = DEFAULT_DMA_COHERENT_POOL_SIZE;
+
+/* Dynamic background expansion when the atomic pool is near capacity */
+struct work_struct atomic_pool_work;
 
 static int __init early_coherent_pool(char *p)
 {
@@ -113,14 +117,14 @@ static int __init early_coherent_pool(char *p)
 }
 early_param("coherent_pool", early_coherent_pool);
 
-static int __init __dma_atomic_pool_init(struct gen_pool **pool,
-					 size_t pool_size, gfp_t gfp)
+static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
+			      gfp_t gfp)
 {
-	const unsigned int order = get_order(pool_size);
 	const unsigned long nr_pages = pool_size >> PAGE_SHIFT;
+	const unsigned int order = get_order(pool_size);
 	struct page *page;
 	void *addr;
-	int ret;
+	int ret = -ENOMEM;
 
 	if (dev_get_cma_area(NULL))
 		page = dma_alloc_from_contiguous(NULL, nr_pages, order, false);
@@ -131,38 +135,67 @@ static int __init __dma_atomic_pool_init(struct gen_pool **pool,
 
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
 	if (!dma_release_from_contiguous(NULL, page, nr_pages))
 		__free_pages(page, order);
 out:
-	pr_err("DMA: failed to allocate %zu KiB %pGg pool for atomic allocation\n",
-		atomic_pool_size >> 10, &gfp);
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
+		atomic_pool_resize(atomic_pool, GFP_DMA);
+	if (IS_ENABLED(CONFIG_ZONE_DMA32))
+		atomic_pool_resize(atomic_pool_dma32, GFP_DMA32);
+	atomic_pool_resize(atomic_pool_normal, GFP_KERNEL);
+}
+
+static int __init __dma_atomic_pool_init(struct gen_pool **pool,
+					 size_t pool_size, gfp_t gfp)
+{
+	int ret;
+
+	*pool = gen_pool_create(PAGE_SHIFT, NUMA_NO_NODE);
+	if (!*pool)
+		return -ENOMEM;
+
+	gen_pool_set_algo(*pool, gen_pool_first_fit_order_align, NULL);
+
+	ret = atomic_pool_expand(*pool, pool_size, gfp);
+	if (ret) {
+		gen_pool_destroy(*pool);
+		*pool = NULL;
+		pr_err("DMA: failed to allocate %zu KiB %pGg pool for atomic allocation\n",
+		       atomic_pool_size >> 10, &gfp);
+		return ret;
+	}
+
+
+	pr_info("DMA: preallocated %zu KiB %pGg pool for atomic allocations\n",
+		pool_size >> 10, &gfp);
+	return 0;
 }
 
 static int __init dma_atomic_pool_init(void)
@@ -170,6 +203,8 @@ static int __init dma_atomic_pool_init(void)
 	int ret = 0;
 	int err;
 
+	INIT_WORK(&atomic_pool_work, atomic_pool_work_fn);
+
 	ret = __dma_atomic_pool_init(&atomic_pool_normal, atomic_pool_size,
 				     GFP_KERNEL);
 	if (IS_ENABLED(CONFIG_ZONE_DMA)) {
@@ -231,6 +266,8 @@ void *dma_alloc_from_pool(struct device *dev, size_t size,
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
