Return-Path: <SRS0=MUIX=UD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F44C28CC3
	for <iommu@archiver.kernel.org>; Tue,  4 Jun 2019 06:55:25 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C68224DB7
	for <iommu@archiver.kernel.org>; Tue,  4 Jun 2019 06:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tFue28d/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C68224DB7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id BEF00E19;
	Tue,  4 Jun 2019 06:55:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1E865E1D
	for <iommu@lists.linux-foundation.org>;
	Tue,  4 Jun 2019 06:55:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id AC0C06D6
	for <iommu@lists.linux-foundation.org>;
	Tue,  4 Jun 2019 06:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=97BhO94V8jLdTUMw7JoDn6KQHii2re3fulwUdwFjYBI=;
	b=tFue28d/NACZJWIBnHUgst3mcC
	kSW3mXpirIcDda6kq0ORR53gZV/3aWOou7YOP7/jjVUsx9Nq13hyKqovanMtUDh+9cn+kOOfmdZ3h
	WuSN3frnRaStXDjmp8W4abdA4+x4/t6n7m3jG4/uq4kmsZCuhHmmXlB2E4Puc4LNWeUGLMuatoaxz
	zB8Wu3eSa8uwVv8yJg64x21cXloaW9LfIeeyqjQUfUuWp4EjVxWT+8wF++127uFmcK+VAEIYu4M80
	/qSyg0M7Un4DX1zlJikp5XiCM3ltmJeLSKjwcDfqc9yc30nFQLNNmq2JD/E+tAdSp53e+f8lgLCLs
	AuHQbzBw==;
Received: from 089144193064.atnat0002.highway.a1.net ([89.144.193.64]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
	id 1hY3Lo-0003ZV-DH; Tue, 04 Jun 2019 06:55:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 3/3] dma-mapping: introduce a dma_common_find_pages helper
Date: Tue,  4 Jun 2019 08:55:04 +0200
Message-Id: <20190604065504.25662-4-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604065504.25662-1-hch@lst.de>
References: <20190604065504.25662-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, linux-mm@kvack.org,
	Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

A helper to find the backing page array based on a virtual address.
This also ensures we do the same vm_flags check everywhere instead
of slightly different or missing ones in a few places.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping.c   |  7 +------
 drivers/iommu/dma-iommu.c   | 15 +++------------
 include/linux/dma-mapping.h |  1 +
 kernel/dma/remap.c          | 13 +++++++++++--
 4 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 647fd25d2aba..7620d4f55e92 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1434,18 +1434,13 @@ static struct page **__atomic_get_pages(void *addr)
 
 static struct page **__iommu_get_pages(void *cpu_addr, unsigned long attrs)
 {
-	struct vm_struct *area;
-
 	if (__in_atomic_pool(cpu_addr, PAGE_SIZE))
 		return __atomic_get_pages(cpu_addr);
 
 	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
 		return cpu_addr;
 
-	area = find_vm_area(cpu_addr);
-	if (area && (area->flags & VM_DMA_COHERENT))
-		return area->pages;
-	return NULL;
+	return dma_common_find_pages(cpu_addr);
 }
 
 static void *__iommu_alloc_simple(struct device *dev, size_t size, gfp_t gfp,
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index cea561897086..002d3bb6254a 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -543,15 +543,6 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 	return pages;
 }
 
-static struct page **__iommu_dma_get_pages(void *cpu_addr)
-{
-	struct vm_struct *area = find_vm_area(cpu_addr);
-
-	if (!area || !area->pages)
-		return NULL;
-	return area->pages;
-}
-
 /**
  * iommu_dma_alloc_remap - Allocate and map a buffer contiguous in IOVA space
  * @dev: Device to allocate memory for. Must be a real device
@@ -940,7 +931,7 @@ static void __iommu_dma_free(struct device *dev, size_t size, void *cpu_addr)
 		 * If it the address is remapped, then it's either non-coherent
 		 * or highmem CMA, or an iommu_dma_alloc_remap() construction.
 		 */
-		pages = __iommu_dma_get_pages(cpu_addr);
+		pages = dma_common_find_pages(cpu_addr);
 		if (!pages)
 			page = vmalloc_to_page(cpu_addr);
 		dma_common_free_remap(cpu_addr, alloc_size);
@@ -1050,7 +1041,7 @@ static int iommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		return -ENXIO;
 
 	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
-		struct page **pages = __iommu_dma_get_pages(cpu_addr);
+		struct page **pages = dma_common_find_pages(cpu_addr);
 
 		if (pages)
 			return __iommu_dma_mmap(pages, size, vma);
@@ -1072,7 +1063,7 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
 	int ret;
 
 	if (IS_ENABLED(CONFIG_DMA_REMAP) && is_vmalloc_addr(cpu_addr)) {
-		struct page **pages = __iommu_dma_get_pages(cpu_addr);
+		struct page **pages = dma_common_find_pages(cpu_addr);
 
 		if (pages) {
 			return sg_alloc_table_from_pages(sgt, pages,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ac320b7cacfd..cb07d1388d66 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -615,6 +615,7 @@ extern int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		unsigned long attrs);
 
+struct page **dma_common_find_pages(void *cpu_addr);
 void *dma_common_contiguous_remap(struct page *page, size_t size,
 			pgprot_t prot, const void *caller);
 
diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 51958d21c810..52cdca386de0 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -11,6 +11,15 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
+struct page **dma_common_find_pages(void *cpu_addr)
+{
+	struct vm_struct *area = find_vm_area(cpu_addr);
+
+	if (!area || area->flags != VM_DMA_COHERENT)
+		return NULL;
+	return area->pages;
+}
+
 static struct vm_struct *__dma_common_pages_remap(struct page **pages,
 			size_t size, pgprot_t prot, const void *caller)
 {
@@ -78,9 +87,9 @@ void *dma_common_contiguous_remap(struct page *page, size_t size,
  */
 void dma_common_free_remap(void *cpu_addr, size_t size)
 {
-	struct vm_struct *area = find_vm_area(cpu_addr);
+	struct page **pages = dma_common_find_pages(cpu_addr);
 
-	if (!area || area->flags != VM_DMA_COHERENT) {
+	if (!pages) {
 		WARN(1, "trying to free invalid coherent area: %p\n", cpu_addr);
 		return;
 	}
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
