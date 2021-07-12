Return-Path: <SRS0=b5xv=ME=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB4BC07E99
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 06:25:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E87B061181
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 06:25:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E87B061181
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B8A6683560;
	Mon, 12 Jul 2021 06:25:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n6Tnzui2PAKa; Mon, 12 Jul 2021 06:25:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 87D4982881;
	Mon, 12 Jul 2021 06:25:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E3EFC0010;
	Mon, 12 Jul 2021 06:25:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30C99C000E
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:25:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 113EA40469
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:25:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ONFgJAHWyGgA for <iommu@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 06:25:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 090AE40464
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=6X06lcCwC1Y3gdU9i+2NMCcmA+3YPz9rMuvZMRFQNn0=; b=fXkX/fu6fAVwscLofg3PDLnrE2
 z0I85vN1ay5aPmwOi3PUiLXpxBiRXz3Rh/ofR4wYXZPqoQp2Y+1DOjMn2uhKtnFp0XbqmMHZNodsZ
 P6baR0Eoj+960/wi3oopb8YthQ66IWGb/YAP15ditUDRzsHyYH27R0+pKNFzvJpgKVcCxg0GhFiXi
 OQJKDN15n8YdJlr/oULGtrsOdQKgTKNKyFhk8ixjTflAykSUhEVj+0DguqBv1Wv5OYmpLaRjEqcsz
 /CJ4LA9F26liGUfWvghKbtSFSZy7VNbVKu4SlOCR/tw8m3UXjxQtZDMreD/cWshSxNiqhU6Cjr8S1
 fMcJYH0Q==;
Received: from [2001:4bb8:184:8b7c:bd9:61b8:39ba:d78a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m2pMO-00Gxgl-CG; Mon, 12 Jul 2021 06:24:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>,
 Brian Cain <bcain@codeaurora.org>
Subject: [PATCH 6/7] dma-mapping: make the global coherent pool conditional
Date: Mon, 12 Jul 2021 08:17:03 +0200
Message-Id: <20210712061704.4162464-7-hch@lst.de>
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

Only build the code to support the global coherent pool if support for
it is enabled.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Dillon Min <dillon.minfei@gmail.com>
---
 include/linux/dma-map-ops.h | 18 +++++++-------
 kernel/dma/coherent.c       | 47 ++++++++++++++++++++-----------------
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
index 7e49bb86a0c0..9b79aa4dd300 100644
--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -170,13 +170,6 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr);
 int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, size_t size, int *ret);
-
-void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
-		dma_addr_t *dma_handle);
-int dma_release_from_global_coherent(int order, void *vaddr);
-int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
-		size_t size, int *ret);
-int dma_init_global_coherent(phys_addr_t phys_addr, size_t size);
 #else
 static inline int dma_declare_coherent_memory(struct device *dev,
 		phys_addr_t phys_addr, dma_addr_t device_addr, size_t size)
@@ -186,7 +179,16 @@ static inline int dma_declare_coherent_memory(struct device *dev,
 #define dma_alloc_from_dev_coherent(dev, size, handle, ret) (0)
 #define dma_release_from_dev_coherent(dev, order, vaddr) (0)
 #define dma_mmap_from_dev_coherent(dev, vma, vaddr, order, ret) (0)
+#endif /* CONFIG_DMA_DECLARE_COHERENT */
 
+#ifdef CONFIG_DMA_GLOBAL_POOL
+void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
+		dma_addr_t *dma_handle);
+int dma_release_from_global_coherent(int order, void *vaddr);
+int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *cpu_addr,
+		size_t size, int *ret);
+int dma_init_global_coherent(phys_addr_t phys_addr, size_t size);
+#else
 static inline void *dma_alloc_from_global_coherent(struct device *dev,
 		ssize_t size, dma_addr_t *dma_handle)
 {
@@ -201,7 +203,7 @@ static inline int dma_mmap_from_global_coherent(struct vm_area_struct *vma,
 {
 	return 0;
 }
-#endif /* CONFIG_DMA_DECLARE_COHERENT */
+#endif /* CONFIG_DMA_GLOBAL_POOL */
 
 /*
  * This is the actual return value from the ->alloc_noncontiguous method.
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 160d4e246ecb..c05408902a68 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -20,8 +20,6 @@ struct dma_coherent_mem {
 	bool		use_dev_dma_pfn_offset;
 };
 
-static struct dma_coherent_mem *dma_coherent_default_memory __ro_after_init;
-
 static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *dev)
 {
 	if (dev && dev->dma_mem)
@@ -191,16 +189,6 @@ int dma_alloc_from_dev_coherent(struct device *dev, ssize_t size,
 	return 1;
 }
 
-void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
-				     dma_addr_t *dma_handle)
-{
-	if (!dma_coherent_default_memory)
-		return NULL;
-
-	return __dma_alloc_from_coherent(dev, dma_coherent_default_memory, size,
-					 dma_handle);
-}
-
 static int __dma_release_from_coherent(struct dma_coherent_mem *mem,
 				       int order, void *vaddr)
 {
@@ -236,15 +224,6 @@ int dma_release_from_dev_coherent(struct device *dev, int order, void *vaddr)
 	return __dma_release_from_coherent(mem, order, vaddr);
 }
 
-int dma_release_from_global_coherent(int order, void *vaddr)
-{
-	if (!dma_coherent_default_memory)
-		return 0;
-
-	return __dma_release_from_coherent(dma_coherent_default_memory, order,
-			vaddr);
-}
-
 static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
 		struct vm_area_struct *vma, void *vaddr, size_t size, int *ret)
 {
@@ -290,6 +269,28 @@ int dma_mmap_from_dev_coherent(struct device *dev, struct vm_area_struct *vma,
 	return __dma_mmap_from_coherent(mem, vma, vaddr, size, ret);
 }
 
+#ifdef CONFIG_DMA_GLOBAL_POOL
+static struct dma_coherent_mem *dma_coherent_default_memory __ro_after_init;
+
+void *dma_alloc_from_global_coherent(struct device *dev, ssize_t size,
+				     dma_addr_t *dma_handle)
+{
+	if (!dma_coherent_default_memory)
+		return NULL;
+
+	return __dma_alloc_from_coherent(dev, dma_coherent_default_memory, size,
+					 dma_handle);
+}
+
+int dma_release_from_global_coherent(int order, void *vaddr)
+{
+	if (!dma_coherent_default_memory)
+		return 0;
+
+	return __dma_release_from_coherent(dma_coherent_default_memory, order,
+			vaddr);
+}
+
 int dma_mmap_from_global_coherent(struct vm_area_struct *vma, void *vaddr,
 				   size_t size, int *ret)
 {
@@ -311,6 +312,7 @@ int dma_init_global_coherent(phys_addr_t phys_addr, size_t size)
 	pr_info("DMA: default coherent area is set\n");
 	return 0;
 }
+#endif /* CONFIG_DMA_GLOBAL_POOL */
 
 /*
  * Support for reserved memory regions defined in device tree
@@ -377,6 +379,7 @@ static int __init rmem_dma_setup(struct reserved_mem *rmem)
 	return 0;
 }
 
+#ifdef CONFIG_DMA_GLOBAL_POOL
 static int __init dma_init_reserved_memory(void)
 {
 	if (!dma_reserved_default_memory)
@@ -384,8 +387,8 @@ static int __init dma_init_reserved_memory(void)
 	return dma_init_global_coherent(dma_reserved_default_memory->base,
 					dma_reserved_default_memory->size);
 }
-
 core_initcall(dma_init_reserved_memory);
+#endif /* CONFIG_DMA_GLOBAL_POOL */
 
 RESERVEDMEM_OF_DECLARE(dma, "shared-dma-pool", rmem_dma_setup);
 #endif
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
