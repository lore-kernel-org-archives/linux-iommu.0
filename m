Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6DBC2D0F4
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B00920771
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 21:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jCD1KXRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B00920771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6F5A1856BF;
	Wed,  8 Apr 2020 21:21:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NRam_ZQGOBk8; Wed,  8 Apr 2020 21:21:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A2A03853D9;
	Wed,  8 Apr 2020 21:21:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91036C1AE8;
	Wed,  8 Apr 2020 21:21:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D8634C0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 21:21:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B8C4F221C6
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 21:21:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pmfimJKEoq6O for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 21:21:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by silver.osuosl.org (Postfix) with ESMTPS id 7E96F2039A
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 21:21:05 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id k191so3894355pgc.13
 for <iommu@lists.linux-foundation.org>; Wed, 08 Apr 2020 14:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :user-agent:mime-version;
 bh=34Kn/eu0N7rYRcQksHLSyYAck8Jvs1iQ8jdTQOhf4Ck=;
 b=jCD1KXRGvc81zHGNV/YZL1/fM8jq8zVdMP7whm5j15FWS1pYB8zRmLnmnFArQ3DsQE
 Iu+5rSzL1Y586/poD0+AjOFifPtJAMhCHUMC+ai5SLQDEmhKAoUbBVrYwoEcBLNgFMtr
 o0+KpP8pJ8G4KPrGqeTwIcPnk9Wkbweecz948ztQU5lKSO1d3n0zufuXFlzdMAElQgkl
 BywzgakieQjRsJf7G0nnCx6Kb5an76l/ttNbOC+ERZlU7puJBzxyBAoTPSTzT/gNEu8W
 R2jyPA8LJ/zszRi2zDnxfD8jw43BpsSgZmt6mpQPyu34ze+ctwFmQAehvtvsrqNJlB3p
 Sosg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:user-agent:mime-version;
 bh=34Kn/eu0N7rYRcQksHLSyYAck8Jvs1iQ8jdTQOhf4Ck=;
 b=U0XDPZLU+Ip3EMt6HDtETyeoGxbeWZGfao60r8pvhrxlUO190y4deViI2NEk9J6UtS
 /sXnqH5b2m6Gt79p1qLFHarmedmH4vuiGfuWDTVaCAVLVsjffdndxD5Tp6xj2j/Y1Kp5
 X6bLCOW85nuLenmkGbQ/9YphGMeyydIkC1BsI5dDLxhPCwWiMlt02WH0WPtuGg7a7Ai3
 gEIUB1BgnqOvGgAKg1f3yhcyRvixEHJfOwoae39MWvsW6BQTs7SztphnZ8XtLZq7A8hV
 S1DkMSba41RU4PMbUM5HOPqyPAb0W/KsgyxlAfhegs94/lCva4gTu/VbqMBxr7HJFNgC
 iURg==
X-Gm-Message-State: AGi0PuYUNtvgKzM4Cg4z+v8/OPdPdd9sK2zrYvhz3PvbLMzsHuj+Pch3
 8u67kv35XSPBHtaWiZrcdyAruA==
X-Google-Smtp-Source: APiQypKtS/LFVS198NdDuc3ZtVm87KjhUpjqfAcswscSsZzCMTJ3ghCkfuC8xCZ71NfUFWli5mGQYw==
X-Received: by 2002:aa7:9f49:: with SMTP id h9mr9824804pfr.217.1586380864725; 
 Wed, 08 Apr 2020 14:21:04 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598]
 ([2620:15c:17:3:3a5:23a7:5e32:4598])
 by smtp.gmail.com with ESMTPSA id q6sm405407pja.34.2020.04.08.14.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2020 14:21:04 -0700 (PDT)
Date: Wed, 8 Apr 2020 14:21:03 -0700 (PDT)
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Christoph Hellwig <hch@lst.de>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [rfc v2 1/6] dma-remap: separate DMA atomic pools from direct remap
 code
In-Reply-To: <alpine.DEB.2.21.2004081418490.19661@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.21.2004081419190.19661@chino.kir.corp.google.com>
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

DMA atomic pools will be needed beyond only CONFIG_DMA_DIRECT_REMAP so
separate them out into their own file.

This also adds a new Kconfig option that can be subsequently used for
options, such as CONFIG_AMD_MEM_ENCRYPT, that will utilize the coherent
pools but do not have a dependency on direct remapping.

For this patch alone, there is no functional change introduced.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 kernel/dma/Kconfig  |   6 ++-
 kernel/dma/Makefile |   1 +
 kernel/dma/pool.c   | 125 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/dma/remap.c  | 114 ----------------------------------------
 4 files changed, 131 insertions(+), 115 deletions(-)
 create mode 100644 kernel/dma/pool.c

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 4c103a24e380..d006668c0027 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -79,10 +79,14 @@ config DMA_REMAP
 	select DMA_NONCOHERENT_MMAP
 	bool
 
-config DMA_DIRECT_REMAP
+config DMA_COHERENT_POOL
 	bool
 	select DMA_REMAP
 
+config DMA_DIRECT_REMAP
+	bool
+	select DMA_COHERENT_POOL
+
 config DMA_CMA
 	bool "DMA Contiguous Memory Allocator"
 	depends on HAVE_DMA_CONTIGUOUS && CMA
diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
index d237cf3dc181..370f63344e9c 100644
--- a/kernel/dma/Makefile
+++ b/kernel/dma/Makefile
@@ -6,4 +6,5 @@ obj-$(CONFIG_DMA_DECLARE_COHERENT)	+= coherent.o
 obj-$(CONFIG_DMA_VIRT_OPS)		+= virt.o
 obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
 obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
+obj-$(CONFIG_DMA_COHERENT_POOL)		+= pool.o
 obj-$(CONFIG_DMA_REMAP)			+= remap.o
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
new file mode 100644
index 000000000000..64cbe5852cf6
--- /dev/null
+++ b/kernel/dma/pool.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ * Copyright (c) 2014 The Linux Foundation
+ * Copyright (C) 2020 Google LLC
+ */
+#include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
+#include <linux/dma-contiguous.h>
+#include <linux/init.h>
+#include <linux/genalloc.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+static struct gen_pool *atomic_pool __ro_after_init;
+
+#define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
+static size_t atomic_pool_size __initdata = DEFAULT_DMA_COHERENT_POOL_SIZE;
+
+static int __init early_coherent_pool(char *p)
+{
+	atomic_pool_size = memparse(p, &p);
+	return 0;
+}
+early_param("coherent_pool", early_coherent_pool);
+
+static gfp_t dma_atomic_pool_gfp(void)
+{
+	if (IS_ENABLED(CONFIG_ZONE_DMA))
+		return GFP_DMA;
+	if (IS_ENABLED(CONFIG_ZONE_DMA32))
+		return GFP_DMA32;
+	return GFP_KERNEL;
+}
+
+static int __init dma_atomic_pool_init(void)
+{
+	unsigned int pool_size_order = get_order(atomic_pool_size);
+	unsigned long nr_pages = atomic_pool_size >> PAGE_SHIFT;
+	struct page *page;
+	void *addr;
+	int ret;
+
+	if (dev_get_cma_area(NULL))
+		page = dma_alloc_from_contiguous(NULL, nr_pages,
+						 pool_size_order, false);
+	else
+		page = alloc_pages(dma_atomic_pool_gfp(), pool_size_order);
+	if (!page)
+		goto out;
+
+	arch_dma_prep_coherent(page, atomic_pool_size);
+
+	atomic_pool = gen_pool_create(PAGE_SHIFT, -1);
+	if (!atomic_pool)
+		goto free_page;
+
+	addr = dma_common_contiguous_remap(page, atomic_pool_size,
+					   pgprot_dmacoherent(PAGE_KERNEL),
+					   __builtin_return_address(0));
+	if (!addr)
+		goto destroy_genpool;
+
+	ret = gen_pool_add_virt(atomic_pool, (unsigned long)addr,
+				page_to_phys(page), atomic_pool_size, -1);
+	if (ret)
+		goto remove_mapping;
+	gen_pool_set_algo(atomic_pool, gen_pool_first_fit_order_align, NULL);
+
+	pr_info("DMA: preallocated %zu KiB pool for atomic allocations\n",
+		atomic_pool_size / 1024);
+	return 0;
+
+remove_mapping:
+	dma_common_free_remap(addr, atomic_pool_size);
+destroy_genpool:
+	gen_pool_destroy(atomic_pool);
+	atomic_pool = NULL;
+free_page:
+	if (!dma_release_from_contiguous(NULL, page, nr_pages))
+		__free_pages(page, pool_size_order);
+out:
+	pr_err("DMA: failed to allocate %zu KiB pool for atomic coherent allocation\n",
+		atomic_pool_size / 1024);
+	return -ENOMEM;
+}
+postcore_initcall(dma_atomic_pool_init);
+
+bool dma_in_atomic_pool(void *start, size_t size)
+{
+	if (unlikely(!atomic_pool))
+		return false;
+
+	return gen_pool_has_addr(atomic_pool, (unsigned long)start, size);
+}
+
+void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags)
+{
+	unsigned long val;
+	void *ptr = NULL;
+
+	if (!atomic_pool) {
+		WARN(1, "coherent pool not initialised!\n");
+		return NULL;
+	}
+
+	val = gen_pool_alloc(atomic_pool, size);
+	if (val) {
+		phys_addr_t phys = gen_pool_virt_to_phys(atomic_pool, val);
+
+		*ret_page = pfn_to_page(__phys_to_pfn(phys));
+		ptr = (void *)val;
+		memset(ptr, 0, size);
+	}
+
+	return ptr;
+}
+
+bool dma_free_from_pool(void *start, size_t size)
+{
+	if (!dma_in_atomic_pool(start, size))
+		return false;
+	gen_pool_free(atomic_pool, (unsigned long)start, size);
+	return true;
+}
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index d14cbc83986a..081486007342 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -97,117 +97,3 @@ void dma_common_free_remap(void *cpu_addr, size_t size)
 	unmap_kernel_range((unsigned long)cpu_addr, PAGE_ALIGN(size));
 	vunmap(cpu_addr);
 }
-
-#ifdef CONFIG_DMA_DIRECT_REMAP
-static struct gen_pool *atomic_pool __ro_after_init;
-
-#define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
-static size_t atomic_pool_size __initdata = DEFAULT_DMA_COHERENT_POOL_SIZE;
-
-static int __init early_coherent_pool(char *p)
-{
-	atomic_pool_size = memparse(p, &p);
-	return 0;
-}
-early_param("coherent_pool", early_coherent_pool);
-
-static gfp_t dma_atomic_pool_gfp(void)
-{
-	if (IS_ENABLED(CONFIG_ZONE_DMA))
-		return GFP_DMA;
-	if (IS_ENABLED(CONFIG_ZONE_DMA32))
-		return GFP_DMA32;
-	return GFP_KERNEL;
-}
-
-static int __init dma_atomic_pool_init(void)
-{
-	unsigned int pool_size_order = get_order(atomic_pool_size);
-	unsigned long nr_pages = atomic_pool_size >> PAGE_SHIFT;
-	struct page *page;
-	void *addr;
-	int ret;
-
-	if (dev_get_cma_area(NULL))
-		page = dma_alloc_from_contiguous(NULL, nr_pages,
-						 pool_size_order, false);
-	else
-		page = alloc_pages(dma_atomic_pool_gfp(), pool_size_order);
-	if (!page)
-		goto out;
-
-	arch_dma_prep_coherent(page, atomic_pool_size);
-
-	atomic_pool = gen_pool_create(PAGE_SHIFT, -1);
-	if (!atomic_pool)
-		goto free_page;
-
-	addr = dma_common_contiguous_remap(page, atomic_pool_size,
-					   pgprot_dmacoherent(PAGE_KERNEL),
-					   __builtin_return_address(0));
-	if (!addr)
-		goto destroy_genpool;
-
-	ret = gen_pool_add_virt(atomic_pool, (unsigned long)addr,
-				page_to_phys(page), atomic_pool_size, -1);
-	if (ret)
-		goto remove_mapping;
-	gen_pool_set_algo(atomic_pool, gen_pool_first_fit_order_align, NULL);
-
-	pr_info("DMA: preallocated %zu KiB pool for atomic allocations\n",
-		atomic_pool_size / 1024);
-	return 0;
-
-remove_mapping:
-	dma_common_free_remap(addr, atomic_pool_size);
-destroy_genpool:
-	gen_pool_destroy(atomic_pool);
-	atomic_pool = NULL;
-free_page:
-	if (!dma_release_from_contiguous(NULL, page, nr_pages))
-		__free_pages(page, pool_size_order);
-out:
-	pr_err("DMA: failed to allocate %zu KiB pool for atomic coherent allocation\n",
-		atomic_pool_size / 1024);
-	return -ENOMEM;
-}
-postcore_initcall(dma_atomic_pool_init);
-
-bool dma_in_atomic_pool(void *start, size_t size)
-{
-	if (unlikely(!atomic_pool))
-		return false;
-
-	return gen_pool_has_addr(atomic_pool, (unsigned long)start, size);
-}
-
-void *dma_alloc_from_pool(size_t size, struct page **ret_page, gfp_t flags)
-{
-	unsigned long val;
-	void *ptr = NULL;
-
-	if (!atomic_pool) {
-		WARN(1, "coherent pool not initialised!\n");
-		return NULL;
-	}
-
-	val = gen_pool_alloc(atomic_pool, size);
-	if (val) {
-		phys_addr_t phys = gen_pool_virt_to_phys(atomic_pool, val);
-
-		*ret_page = pfn_to_page(__phys_to_pfn(phys));
-		ptr = (void *)val;
-		memset(ptr, 0, size);
-	}
-
-	return ptr;
-}
-
-bool dma_free_from_pool(void *start, size_t size)
-{
-	if (!dma_in_atomic_pool(start, size))
-		return false;
-	gen_pool_free(atomic_pool, (unsigned long)start, size);
-	return true;
-}
-#endif /* CONFIG_DMA_DIRECT_REMAP */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
