Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBA5C433F5
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 16:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 069A883E44;
	Mon,  2 May 2022 16:43:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hwq2ngkH7Hlo; Mon,  2 May 2022 16:43:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6036183E38;
	Mon,  2 May 2022 16:43:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 471E2C0039;
	Mon,  2 May 2022 16:43:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99C9FC007E
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC31483E12
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:43:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OtgthZG30G6E for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 16:43:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5BAFB8340C
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=IFhLWpCifKPfHHT7mUpFumfO9329C9KrRZyU5bRJGIw=; b=dI/lWw9Ogw24xMRTLC2/79vyOP
 j5oKZ3hARjrpU0PCXmyIGF5nnfG8eX//DVYndM+NK9zjZulapdqYDFHNatpzNV2LLwOnnqjw+MGkZ
 GOlZC2O726Lo2Tz2QXuTI9BEVb3mOigdEugwqMu4ZnBoyIad6APjRtMSw3ocqFBWf61K0ZRygP/9l
 Gsb4QAtsl3BW8nmvERZaRHN1U/Ep8eDj4tPhEFNHgMhmS9KZFhNNnkCNyI5V0Wa8LF4KsoLcUNusz
 lJ/AtEYls8NhYfuggry3xisUkvUkjjGxHtM7IJ+bVTkxKzGKn3WNlREuV9EbToNA4pA4n+zx+R0hd
 /au+qgsg==;
Received: from [8.34.116.185] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlZ98-001kgK-Pi; Mon, 02 May 2022 16:43:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 09/10] ARM/dma-mapping: consolidate IOMMU ops callbacks
Date: Mon,  2 May 2022 09:43:29 -0700
Message-Id: <20220502164330.229685-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220502164330.229685-1-hch@lst.de>
References: <20220502164330.229685-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Andrew Lunn <andrew@lunn.ch>, Andre Przywara <andre.przywara@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
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

From: Robin Murphy <robin.murphy@arm.com>

Merge the coherent and non-coherent callbacks down to a single
implementation each, relying on the generic dev->dma_coherent
flag at the points where the difference matters.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping.c | 238 +++++++++-----------------------------
 1 file changed, 55 insertions(+), 183 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 6b0095b84a581..10e5e5800d784 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1079,13 +1079,13 @@ static void __iommu_free_atomic(struct device *dev, void *cpu_addr,
 		__free_from_pool(cpu_addr, size);
 }
 
-static void *__arm_iommu_alloc_attrs(struct device *dev, size_t size,
-	    dma_addr_t *handle, gfp_t gfp, unsigned long attrs,
-	    int coherent_flag)
+static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
+	    dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
 {
 	pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
 	struct page **pages;
 	void *addr = NULL;
+	int coherent_flag = dev->dma_coherent ? COHERENT : NORMAL;
 
 	*handle = DMA_MAPPING_ERROR;
 	size = PAGE_ALIGN(size);
@@ -1128,19 +1128,7 @@ static void *__arm_iommu_alloc_attrs(struct device *dev, size_t size,
 	return NULL;
 }
 
-static void *arm_iommu_alloc_attrs(struct device *dev, size_t size,
-	    dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
-{
-	return __arm_iommu_alloc_attrs(dev, size, handle, gfp, attrs, NORMAL);
-}
-
-static void *arm_coherent_iommu_alloc_attrs(struct device *dev, size_t size,
-		    dma_addr_t *handle, gfp_t gfp, unsigned long attrs)
-{
-	return __arm_iommu_alloc_attrs(dev, size, handle, gfp, attrs, COHERENT);
-}
-
-static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
+static int arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 		    void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		    unsigned long attrs)
 {
@@ -1154,35 +1142,24 @@ static int __arm_iommu_mmap_attrs(struct device *dev, struct vm_area_struct *vma
 	if (vma->vm_pgoff >= nr_pages)
 		return -ENXIO;
 
+	if (!dev->dma_coherent)
+		vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
+
 	err = vm_map_pages(vma, pages, nr_pages);
 	if (err)
 		pr_err("Remapping memory failed: %d\n", err);
 
 	return err;
 }
-static int arm_iommu_mmap_attrs(struct device *dev,
-		struct vm_area_struct *vma, void *cpu_addr,
-		dma_addr_t dma_addr, size_t size, unsigned long attrs)
-{
-	vma->vm_page_prot = __get_dma_pgprot(attrs, vma->vm_page_prot);
-
-	return __arm_iommu_mmap_attrs(dev, vma, cpu_addr, dma_addr, size, attrs);
-}
-
-static int arm_coherent_iommu_mmap_attrs(struct device *dev,
-		struct vm_area_struct *vma, void *cpu_addr,
-		dma_addr_t dma_addr, size_t size, unsigned long attrs)
-{
-	return __arm_iommu_mmap_attrs(dev, vma, cpu_addr, dma_addr, size, attrs);
-}
 
 /*
  * free a page as defined by the above mapping.
  * Must not be called with IRQs disabled.
  */
-static void __arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
-	dma_addr_t handle, unsigned long attrs, int coherent_flag)
+static void arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_addr,
+	dma_addr_t handle, unsigned long attrs)
 {
+	int coherent_flag = dev->dma_coherent ? COHERENT : NORMAL;
 	struct page **pages;
 	size = PAGE_ALIGN(size);
 
@@ -1204,19 +1181,6 @@ static void __arm_iommu_free_attrs(struct device *dev, size_t size, void *cpu_ad
 	__iommu_free_buffer(dev, pages, size, attrs);
 }
 
-static void arm_iommu_free_attrs(struct device *dev, size_t size,
-				 void *cpu_addr, dma_addr_t handle,
-				 unsigned long attrs)
-{
-	__arm_iommu_free_attrs(dev, size, cpu_addr, handle, attrs, NORMAL);
-}
-
-static void arm_coherent_iommu_free_attrs(struct device *dev, size_t size,
-		    void *cpu_addr, dma_addr_t handle, unsigned long attrs)
-{
-	__arm_iommu_free_attrs(dev, size, cpu_addr, handle, attrs, COHERENT);
-}
-
 static int arm_iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
 				 void *cpu_addr, dma_addr_t dma_addr,
 				 size_t size, unsigned long attrs)
@@ -1236,8 +1200,7 @@ static int arm_iommu_get_sgtable(struct device *dev, struct sg_table *sgt,
  */
 static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 			  size_t size, dma_addr_t *handle,
-			  enum dma_data_direction dir, unsigned long attrs,
-			  bool is_coherent)
+			  enum dma_data_direction dir, unsigned long attrs)
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova, iova_base;
@@ -1257,7 +1220,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 		phys_addr_t phys = page_to_phys(sg_page(s));
 		unsigned int len = PAGE_ALIGN(s->offset + s->length);
 
-		if (!is_coherent && (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
+		if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 			__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
 
 		prot = __dma_info_to_prot(dir, attrs);
@@ -1277,9 +1240,20 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
 	return ret;
 }
 
-static int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
-		     enum dma_data_direction dir, unsigned long attrs,
-		     bool is_coherent)
+/**
+ * arm_iommu_map_sg - map a set of SG buffers for streaming mode DMA
+ * @dev: valid struct device pointer
+ * @sg: list of buffers
+ * @nents: number of buffers to map
+ * @dir: DMA transfer direction
+ *
+ * Map a set of buffers described by scatterlist in streaming mode for DMA.
+ * The scatter gather list elements are merged together (if possible) and
+ * tagged with the appropriate dma address and length. They are obtained via
+ * sg_dma_{address,length}.
+ */
+static int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg,
+		int nents, enum dma_data_direction dir, unsigned long attrs)
 {
 	struct scatterlist *s = sg, *dma = sg, *start = sg;
 	int i, count = 0, ret;
@@ -1294,8 +1268,7 @@ static int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 
 		if (s->offset || (size & ~PAGE_MASK) || size + s->length > max) {
 			ret = __map_sg_chunk(dev, start, size,
-					     &dma->dma_address, dir, attrs,
-					     is_coherent);
+					     &dma->dma_address, dir, attrs);
 			if (ret < 0)
 				goto bad_mapping;
 
@@ -1309,8 +1282,7 @@ static int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 		}
 		size += s->length;
 	}
-	ret = __map_sg_chunk(dev, start, size, &dma->dma_address, dir, attrs,
-			     is_coherent);
+	ret = __map_sg_chunk(dev, start, size, &dma->dma_address, dir, attrs);
 	if (ret < 0)
 		goto bad_mapping;
 
@@ -1328,44 +1300,19 @@ static int __iommu_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 }
 
 /**
- * arm_coherent_iommu_map_sg - map a set of SG buffers for streaming mode DMA
- * @dev: valid struct device pointer
- * @sg: list of buffers
- * @nents: number of buffers to map
- * @dir: DMA transfer direction
- *
- * Map a set of i/o coherent buffers described by scatterlist in streaming
- * mode for DMA. The scatter gather list elements are merged together (if
- * possible) and tagged with the appropriate dma address and length. They are
- * obtained via sg_dma_{address,length}.
- */
-static int arm_coherent_iommu_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	return __iommu_map_sg(dev, sg, nents, dir, attrs, true);
-}
-
-/**
- * arm_iommu_map_sg - map a set of SG buffers for streaming mode DMA
+ * arm_iommu_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
  * @dev: valid struct device pointer
  * @sg: list of buffers
- * @nents: number of buffers to map
- * @dir: DMA transfer direction
+ * @nents: number of buffers to unmap (same as was passed to dma_map_sg)
+ * @dir: DMA transfer direction (same as was passed to dma_map_sg)
  *
- * Map a set of buffers described by scatterlist in streaming mode for DMA.
- * The scatter gather list elements are merged together (if possible) and
- * tagged with the appropriate dma address and length. They are obtained via
- * sg_dma_{address,length}.
+ * Unmap a set of streaming mode DMA translations.  Again, CPU access
+ * rules concerning calls here are the same as for dma_unmap_single().
  */
-static int arm_iommu_map_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir, unsigned long attrs)
-{
-	return __iommu_map_sg(dev, sg, nents, dir, attrs, false);
-}
-
-static void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
-		int nents, enum dma_data_direction dir,
-		unsigned long attrs, bool is_coherent)
+static void arm_iommu_unmap_sg(struct device *dev,
+			       struct scatterlist *sg, int nents,
+			       enum dma_data_direction dir,
+			       unsigned long attrs)
 {
 	struct scatterlist *s;
 	int i;
@@ -1374,47 +1321,12 @@ static void __iommu_unmap_sg(struct device *dev, struct scatterlist *sg,
 		if (sg_dma_len(s))
 			__iommu_remove_mapping(dev, sg_dma_address(s),
 					       sg_dma_len(s));
-		if (!is_coherent && (attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
+		if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 			__dma_page_dev_to_cpu(sg_page(s), s->offset,
 					      s->length, dir);
 	}
 }
 
-/**
- * arm_coherent_iommu_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
- * @dev: valid struct device pointer
- * @sg: list of buffers
- * @nents: number of buffers to unmap (same as was passed to dma_map_sg)
- * @dir: DMA transfer direction (same as was passed to dma_map_sg)
- *
- * Unmap a set of streaming mode DMA translations.  Again, CPU access
- * rules concerning calls here are the same as for dma_unmap_single().
- */
-static void arm_coherent_iommu_unmap_sg(struct device *dev,
-		struct scatterlist *sg, int nents, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	__iommu_unmap_sg(dev, sg, nents, dir, attrs, true);
-}
-
-/**
- * arm_iommu_unmap_sg - unmap a set of SG buffers mapped by dma_map_sg
- * @dev: valid struct device pointer
- * @sg: list of buffers
- * @nents: number of buffers to unmap (same as was passed to dma_map_sg)
- * @dir: DMA transfer direction (same as was passed to dma_map_sg)
- *
- * Unmap a set of streaming mode DMA translations.  Again, CPU access
- * rules concerning calls here are the same as for dma_unmap_single().
- */
-static void arm_iommu_unmap_sg(struct device *dev,
-			       struct scatterlist *sg, int nents,
-			       enum dma_data_direction dir,
-			       unsigned long attrs)
-{
-	__iommu_unmap_sg(dev, sg, nents, dir, attrs, false);
-}
-
 /**
  * arm_iommu_sync_sg_for_cpu
  * @dev: valid struct device pointer
@@ -1452,18 +1364,17 @@ static void arm_iommu_sync_sg_for_device(struct device *dev,
 		__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
 }
 
-
 /**
- * arm_coherent_iommu_map_page
+ * arm_iommu_map_page
  * @dev: valid struct device pointer
  * @page: page that buffer resides in
  * @offset: offset into page for start of buffer
  * @size: size of buffer to map
  * @dir: DMA transfer direction
  *
- * Coherent IOMMU aware version of arm_dma_map_page()
+ * IOMMU aware version of arm_dma_map_page()
  */
-static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *page,
+static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
 	     unsigned long offset, size_t size, enum dma_data_direction dir,
 	     unsigned long attrs)
 {
@@ -1471,6 +1382,9 @@ static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *p
 	dma_addr_t dma_addr;
 	int ret, prot, len = PAGE_ALIGN(size + offset);
 
+	if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		__dma_page_cpu_to_dev(page, offset, size, dir);
+
 	dma_addr = __alloc_iova(mapping, len);
 	if (dma_addr == DMA_MAPPING_ERROR)
 		return dma_addr;
@@ -1487,50 +1401,6 @@ static dma_addr_t arm_coherent_iommu_map_page(struct device *dev, struct page *p
 	return DMA_MAPPING_ERROR;
 }
 
-/**
- * arm_iommu_map_page
- * @dev: valid struct device pointer
- * @page: page that buffer resides in
- * @offset: offset into page for start of buffer
- * @size: size of buffer to map
- * @dir: DMA transfer direction
- *
- * IOMMU aware version of arm_dma_map_page()
- */
-static dma_addr_t arm_iommu_map_page(struct device *dev, struct page *page,
-	     unsigned long offset, size_t size, enum dma_data_direction dir,
-	     unsigned long attrs)
-{
-	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
-		__dma_page_cpu_to_dev(page, offset, size, dir);
-
-	return arm_coherent_iommu_map_page(dev, page, offset, size, dir, attrs);
-}
-
-/**
- * arm_coherent_iommu_unmap_page
- * @dev: valid struct device pointer
- * @handle: DMA address of buffer
- * @size: size of buffer (same as passed to dma_map_page)
- * @dir: DMA transfer direction (same as passed to dma_map_page)
- *
- * Coherent IOMMU aware version of arm_dma_unmap_page()
- */
-static void arm_coherent_iommu_unmap_page(struct device *dev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
-	dma_addr_t iova = handle & PAGE_MASK;
-	int offset = handle & ~PAGE_MASK;
-	int len = PAGE_ALIGN(size + offset);
-
-	if (!iova)
-		return;
-
-	iommu_unmap(mapping->domain, iova, len);
-	__free_iova(mapping, iova, len);
-}
-
 /**
  * arm_iommu_unmap_page
  * @dev: valid struct device pointer
@@ -1545,15 +1415,17 @@ static void arm_iommu_unmap_page(struct device *dev, dma_addr_t handle,
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
-	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
+	struct page *page;
 	int offset = handle & ~PAGE_MASK;
 	int len = PAGE_ALIGN(size + offset);
 
 	if (!iova)
 		return;
 
-	if ((attrs & DMA_ATTR_SKIP_CPU_SYNC) == 0)
+	if (!dev->dma_coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
+		page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
 		__dma_page_dev_to_cpu(page, offset, size, dir);
+	}
 
 	iommu_unmap(mapping->domain, iova, len);
 	__free_iova(mapping, iova, len);
@@ -1665,16 +1537,16 @@ static const struct dma_map_ops iommu_ops = {
 };
 
 static const struct dma_map_ops iommu_coherent_ops = {
-	.alloc		= arm_coherent_iommu_alloc_attrs,
-	.free		= arm_coherent_iommu_free_attrs,
-	.mmap		= arm_coherent_iommu_mmap_attrs,
+	.alloc		= arm_iommu_alloc_attrs,
+	.free		= arm_iommu_free_attrs,
+	.mmap		= arm_iommu_mmap_attrs,
 	.get_sgtable	= arm_iommu_get_sgtable,
 
-	.map_page	= arm_coherent_iommu_map_page,
-	.unmap_page	= arm_coherent_iommu_unmap_page,
+	.map_page	= arm_iommu_map_page,
+	.unmap_page	= arm_iommu_unmap_page,
 
-	.map_sg		= arm_coherent_iommu_map_sg,
-	.unmap_sg	= arm_coherent_iommu_unmap_sg,
+	.map_sg		= arm_iommu_map_sg,
+	.unmap_sg	= arm_iommu_unmap_sg,
 
 	.map_resource	= arm_iommu_map_resource,
 	.unmap_resource	= arm_iommu_unmap_resource,
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
