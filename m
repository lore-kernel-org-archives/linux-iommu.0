Return-Path: <SRS0=b5xv=ME=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EEBC07E99
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 06:22:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D5B161178
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 06:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D5B161178
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F23A56058D;
	Mon, 12 Jul 2021 06:22:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ak11HVAs-0Mt; Mon, 12 Jul 2021 06:22:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D1BAC607DB;
	Mon, 12 Jul 2021 06:22:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACC70C0010;
	Mon, 12 Jul 2021 06:22:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 082E6C000E
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:22:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD65E607DB
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:22:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id insnmP9FgAUq for <iommu@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 06:22:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2EDDF6058D
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=eVxB7IvANlcif6hq/pqZXhaiA82oKpkzsJI2QfP+SPc=; b=rZgrnlJ0qlx2ZIn795mfHCSoCB
 StQY/6FsSQNEsU/FWRg9jy5p8sMfV7aEz1F0+WPJuJ/RYdOO5VMXORF8eSj0VT1Nt3lHQ0X9jp+of
 v99xmipPH5RZXef8CyYFeoMHesYxli/R/dRrivW6qi2YeCLNO4SC18NWllwnYRQo4F5/SSSiRJF4s
 S8Fpwl4CCjGgHwV5jzPS5SXg1jjUeT3kgs+gkkXk4uHvw8TCa8WjBcq0J1/WOoz35P+3rjngtjaKD
 hs1k+odKLzmtJ8wCGWdPo4U+r5XoFair8jVchXSO6s1xfNtDaLlhcCv+Mhn7oCplvqRsqaExsWvYP
 zRGcPGDg==;
Received: from [2001:4bb8:184:8b7c:bd9:61b8:39ba:d78a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m2pJt-00GxR6-2V; Mon, 12 Jul 2021 06:22:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>,
 Brian Cain <bcain@codeaurora.org>
Subject: [PATCH 4/7] dma-mapping: simplify dma_init_coherent_memory
Date: Mon, 12 Jul 2021 08:17:01 +0200
Message-Id: <20210712061704.4162464-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210712061704.4162464-1-hch@lst.de>
References: <20210712061704.4162464-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-hexagon@vger.kernel.org, Vladimir Murzin <vladimir.murzin@arm.com>,
 Dillon Min <dillon.minfei@gmail.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

Return the allocated dma_coherent_mem structure, set the
use_dma_pfn_offset and print the failure warning inside of
dma_init_coherent_memory instead of leaving that to the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Dillon Min <dillon.minfei@gmail.com>
---
 kernel/dma/coherent.c | 78 ++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 45 deletions(-)

diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 67b126afac5a..ab397ebfd5ad 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -37,51 +37,44 @@ static inline dma_addr_t dma_get_device_base(struct device *dev,
 	return mem->device_base;
 }
 
-static int dma_init_coherent_memory(phys_addr_t phys_addr,
-		dma_addr_t device_addr, size_t size,
-		struct dma_coherent_mem **mem)
+static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
+		dma_addr_t device_addr, size_t size, bool use_dma_pfn_offset)
 {
-	struct dma_coherent_mem *dma_mem = NULL;
-	void *mem_base = NULL;
+	struct dma_coherent_mem *dma_mem;
 	int pages = size >> PAGE_SHIFT;
 	int bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
-	int ret;
+	void *mem_base;
 
-	if (!size) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!size)
+		return ERR_PTR(-EINVAL);
 
 	mem_base = memremap(phys_addr, size, MEMREMAP_WC);
-	if (!mem_base) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!mem_base)
+		return ERR_PTR(-EINVAL);
+
 	dma_mem = kzalloc(sizeof(struct dma_coherent_mem), GFP_KERNEL);
-	if (!dma_mem) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!dma_mem)
+		goto out_unmap_membase;
 	dma_mem->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
-	if (!dma_mem->bitmap) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!dma_mem->bitmap)
+		goto out_free_dma_mem;
 
 	dma_mem->virt_base = mem_base;
 	dma_mem->device_base = device_addr;
 	dma_mem->pfn_base = PFN_DOWN(phys_addr);
 	dma_mem->size = pages;
+	dma_mem->use_dev_dma_pfn_offset = use_dma_pfn_offset;
 	spin_lock_init(&dma_mem->spinlock);
 
-	*mem = dma_mem;
-	return 0;
+	return dma_mem;
 
-out:
+out_free_dma_mem:
 	kfree(dma_mem);
-	if (mem_base)
-		memunmap(mem_base);
-	return ret;
+out_unmap_membase:
+	memunmap(mem_base);
+	pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %zd MiB\n",
+		&phys_addr, size / SZ_1M);
+	return ERR_PTR(-ENOMEM);
 }
 
 static void dma_release_coherent_memory(struct dma_coherent_mem *mem)
@@ -130,9 +123,9 @@ int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 	struct dma_coherent_mem *mem;
 	int ret;
 
-	ret = dma_init_coherent_memory(phys_addr, device_addr, size, &mem);
-	if (ret)
-		return ret;
+	mem = dma_init_coherent_memory(phys_addr, device_addr, size, false);
+	if (IS_ERR(mem))
+		return PTR_ERR(mem);
 
 	ret = dma_assign_coherent_memory(dev, mem);
 	if (ret)
@@ -319,21 +312,16 @@ static struct reserved_mem *dma_reserved_default_memory __initdata;
 
 static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 {
-	struct dma_coherent_mem *mem = rmem->priv;
-	int ret;
-
-	if (!mem) {
-		ret = dma_init_coherent_memory(rmem->base, rmem->base,
-					       rmem->size, &mem);
-		if (ret) {
-			pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
-				&rmem->base, (unsigned long)rmem->size / SZ_1M);
-			return ret;
-		}
+	if (!rmem->priv) {
+		struct dma_coherent_mem *mem;
+
+		mem = dma_init_coherent_memory(rmem->base, rmem->base,
+					       rmem->size, true);
+		if (IS_ERR(mem))
+			return PTR_ERR(mem);
+		rmem->priv = mem;
 	}
-	mem->use_dev_dma_pfn_offset = true;
-	rmem->priv = mem;
-	dma_assign_coherent_memory(dev, mem);
+	dma_assign_coherent_memory(dev, rmem->priv);
 	return 0;
 }
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
