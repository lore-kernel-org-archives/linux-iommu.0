Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C693CC433E0
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 15:30:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E940206DF
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 15:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PBjX1RIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E940206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4E7A288BF6;
	Wed,  8 Jul 2020 15:29:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DI7QPWyqN7Be; Wed,  8 Jul 2020 15:29:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F017388BF0;
	Wed,  8 Jul 2020 15:29:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8142C0893;
	Wed,  8 Jul 2020 15:29:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35672C016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 15:29:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 23ED487CC5
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 15:29:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tzDQaydbTQJ6 for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 15:29:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id F3EF787CC4
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 15:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=oNz4U8+kA/20nWGp/WzRBBjMsQ9esVbdz0sBniPm2Zs=; b=PBjX1RILaOwe3lO17JLet4Euu1
 kPzGOdYR3X98CmkftBGD+U9K5Zxej20uFL+nlFmHJDxXkJZ2m7G6DJKK4/+PKvRZMSBwpG4/jhWx5
 6XzRFDpOwh0bMRAffHU47IbUDdmNYQon/RDszh89ZBrepL5u8jv9L/r/znCWod4Fiv3l1MM9LxEHm
 rOEkR9thlDUGFOsS6OgKRO2xlQhieeOK5DTuPQloKfd9DeGlCcZut/QvEkYdgtNAbR205+jPHsngA
 9LTjHGkXy6QNg2zoQNOskAPQKBO5ODH3Dtl3yXQIcibz+4pXQKlCTM5TuMSK0kl3x6l8aUAQzyVov
 3d0VCkpQ==;
Received: from 213-225-32-40.nat.highway.a1.net ([213.225.32.40]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtC0u-0002Cu-3L; Wed, 08 Jul 2020 15:29:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org,
	Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH 1/5] dma-mapping: move the remaining DMA API calls out of line
Date: Wed,  8 Jul 2020 17:24:45 +0200
Message-Id: <20200708152449.316476-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708152449.316476-1-hch@lst.de>
References: <20200708152449.316476-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Jesper Dangaard Brouer <brouer@redhat.com>, linuxppc-dev@lists.ozlabs.org
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

For a long time the DMA API has been implemented inline in dma-mapping.h,
but the function bodies can be quite large.  Move them all out of line.

This also removes all the dma_direct_* exports as those are just
implementation details and should never be used by drivers directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-direct.h  |  58 +++++++++
 include/linux/dma-mapping.h | 247 ++++--------------------------------
 kernel/dma/direct.c         |   9 --
 kernel/dma/mapping.c        | 164 ++++++++++++++++++++++++
 4 files changed, 244 insertions(+), 234 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 5184735a0fe8eb..78dc3524adf880 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -86,4 +86,62 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 		unsigned long attrs);
 int dma_direct_supported(struct device *dev, u64 mask);
 bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr);
+dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
+		unsigned long offset, size_t size, enum dma_data_direction dir,
+		unsigned long attrs);
+int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
+		enum dma_data_direction dir, unsigned long attrs);
+dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs);
+
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
+    defined(CONFIG_SWIOTLB)
+void dma_direct_sync_single_for_device(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir);
+void dma_direct_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
+#else
+static inline void dma_direct_sync_single_for_device(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+}
+static inline void dma_direct_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+}
+#endif
+
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL) || \
+    defined(CONFIG_SWIOTLB)
+void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs);
+void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
+		int nents, enum dma_data_direction dir, unsigned long attrs);
+void dma_direct_sync_single_for_cpu(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir);
+void dma_direct_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
+#else
+static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+}
+static inline void dma_direct_unmap_sg(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+}
+static inline void dma_direct_sync_single_for_cpu(struct device *dev,
+		dma_addr_t addr, size_t size, enum dma_data_direction dir)
+{
+}
+static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
+{
+}
+#endif
+
+size_t dma_direct_max_mapping_size(struct device *dev);
+
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index a33ed3954ed465..bd0a6f5ee44581 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -188,73 +188,6 @@ static inline int dma_mmap_from_global_coherent(struct vm_area_struct *vma,
 }
 #endif /* CONFIG_DMA_DECLARE_COHERENT */
 
-static inline bool dma_is_direct(const struct dma_map_ops *ops)
-{
-	return likely(!ops);
-}
-
-/*
- * All the dma_direct_* declarations are here just for the indirect call bypass,
- * and must not be used directly drivers!
- */
-dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs);
-int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
-		enum dma_data_direction dir, unsigned long attrs);
-dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs);
-
-#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
-    defined(CONFIG_SWIOTLB)
-void dma_direct_sync_single_for_device(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir);
-void dma_direct_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
-#else
-static inline void dma_direct_sync_single_for_device(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir)
-{
-}
-static inline void dma_direct_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
-{
-}
-#endif
-
-#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
-    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL) || \
-    defined(CONFIG_SWIOTLB)
-void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs);
-void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
-		int nents, enum dma_data_direction dir, unsigned long attrs);
-void dma_direct_sync_single_for_cpu(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir);
-void dma_direct_sync_sg_for_cpu(struct device *dev,
-		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
-#else
-static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-}
-static inline void dma_direct_unmap_sg(struct device *dev,
-		struct scatterlist *sgl, int nents, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-}
-static inline void dma_direct_sync_single_for_cpu(struct device *dev,
-		dma_addr_t addr, size_t size, enum dma_data_direction dir)
-{
-}
-static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
-		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
-{
-}
-#endif
-
-size_t dma_direct_max_mapping_size(struct device *dev);
-
 #ifdef CONFIG_HAS_DMA
 #include <asm/dma-mapping.h>
 
@@ -271,164 +204,6 @@ static inline void set_dma_ops(struct device *dev,
 	dev->dma_ops = dma_ops;
 }
 
-static inline dma_addr_t dma_map_page_attrs(struct device *dev,
-		struct page *page, size_t offset, size_t size,
-		enum dma_data_direction dir, unsigned long attrs)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-	dma_addr_t addr;
-
-	BUG_ON(!valid_dma_direction(dir));
-	if (dma_is_direct(ops))
-		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
-	else
-		addr = ops->map_page(dev, page, offset, size, dir, attrs);
-	debug_dma_map_page(dev, page, offset, size, dir, addr);
-
-	return addr;
-}
-
-static inline void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir, unsigned long attrs)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	BUG_ON(!valid_dma_direction(dir));
-	if (dma_is_direct(ops))
-		dma_direct_unmap_page(dev, addr, size, dir, attrs);
-	else if (ops->unmap_page)
-		ops->unmap_page(dev, addr, size, dir, attrs);
-	debug_dma_unmap_page(dev, addr, size, dir);
-}
-
-/*
- * dma_maps_sg_attrs returns 0 on error and > 0 on success.
- * It should never return a value < 0.
- */
-static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
-				   int nents, enum dma_data_direction dir,
-				   unsigned long attrs)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-	int ents;
-
-	BUG_ON(!valid_dma_direction(dir));
-	if (dma_is_direct(ops))
-		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
-	else
-		ents = ops->map_sg(dev, sg, nents, dir, attrs);
-	BUG_ON(ents < 0);
-	debug_dma_map_sg(dev, sg, nents, ents, dir);
-
-	return ents;
-}
-
-static inline void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
-				      int nents, enum dma_data_direction dir,
-				      unsigned long attrs)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	BUG_ON(!valid_dma_direction(dir));
-	debug_dma_unmap_sg(dev, sg, nents, dir);
-	if (dma_is_direct(ops))
-		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
-	else if (ops->unmap_sg)
-		ops->unmap_sg(dev, sg, nents, dir, attrs);
-}
-
-static inline dma_addr_t dma_map_resource(struct device *dev,
-					  phys_addr_t phys_addr,
-					  size_t size,
-					  enum dma_data_direction dir,
-					  unsigned long attrs)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-	dma_addr_t addr = DMA_MAPPING_ERROR;
-
-	BUG_ON(!valid_dma_direction(dir));
-
-	/* Don't allow RAM to be mapped */
-	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
-		return DMA_MAPPING_ERROR;
-
-	if (dma_is_direct(ops))
-		addr = dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
-	else if (ops->map_resource)
-		addr = ops->map_resource(dev, phys_addr, size, dir, attrs);
-
-	debug_dma_map_resource(dev, phys_addr, size, dir, addr);
-	return addr;
-}
-
-static inline void dma_unmap_resource(struct device *dev, dma_addr_t addr,
-				      size_t size, enum dma_data_direction dir,
-				      unsigned long attrs)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	BUG_ON(!valid_dma_direction(dir));
-	if (!dma_is_direct(ops) && ops->unmap_resource)
-		ops->unmap_resource(dev, addr, size, dir, attrs);
-	debug_dma_unmap_resource(dev, addr, size, dir);
-}
-
-static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
-					   size_t size,
-					   enum dma_data_direction dir)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	BUG_ON(!valid_dma_direction(dir));
-	if (dma_is_direct(ops))
-		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
-	else if (ops->sync_single_for_cpu)
-		ops->sync_single_for_cpu(dev, addr, size, dir);
-	debug_dma_sync_single_for_cpu(dev, addr, size, dir);
-}
-
-static inline void dma_sync_single_for_device(struct device *dev,
-					      dma_addr_t addr, size_t size,
-					      enum dma_data_direction dir)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	BUG_ON(!valid_dma_direction(dir));
-	if (dma_is_direct(ops))
-		dma_direct_sync_single_for_device(dev, addr, size, dir);
-	else if (ops->sync_single_for_device)
-		ops->sync_single_for_device(dev, addr, size, dir);
-	debug_dma_sync_single_for_device(dev, addr, size, dir);
-}
-
-static inline void
-dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
-		    int nelems, enum dma_data_direction dir)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	BUG_ON(!valid_dma_direction(dir));
-	if (dma_is_direct(ops))
-		dma_direct_sync_sg_for_cpu(dev, sg, nelems, dir);
-	else if (ops->sync_sg_for_cpu)
-		ops->sync_sg_for_cpu(dev, sg, nelems, dir);
-	debug_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
-}
-
-static inline void
-dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-		       int nelems, enum dma_data_direction dir)
-{
-	const struct dma_map_ops *ops = get_dma_ops(dev);
-
-	BUG_ON(!valid_dma_direction(dir));
-	if (dma_is_direct(ops))
-		dma_direct_sync_sg_for_device(dev, sg, nelems, dir);
-	else if (ops->sync_sg_for_device)
-		ops->sync_sg_for_device(dev, sg, nelems, dir);
-	debug_dma_sync_sg_for_device(dev, sg, nelems, dir);
-
-}
 
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
@@ -439,6 +214,28 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 	return 0;
 }
 
+dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
+		size_t offset, size_t size, enum dma_data_direction dir,
+		unsigned long attrs);
+void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
+		enum dma_data_direction dir, unsigned long attrs);
+int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
+		enum dma_data_direction dir, unsigned long attrs);
+void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
+				      int nents, enum dma_data_direction dir,
+				      unsigned long attrs);
+dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs);
+void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
+		enum dma_data_direction dir, unsigned long attrs);
+void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
+		enum dma_data_direction dir);
+void dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir);
+void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
+		    int nelems, enum dma_data_direction dir);
+void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
+		       int nelems, enum dma_data_direction dir);
 void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t flag, unsigned long attrs);
 void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 95866b64758100..6d1975c4a26873 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -315,7 +315,6 @@ void dma_direct_sync_single_for_device(struct device *dev,
 	if (!dev_is_dma_coherent(dev))
 		arch_sync_dma_for_device(paddr, size, dir);
 }
-EXPORT_SYMBOL(dma_direct_sync_single_for_device);
 
 void dma_direct_sync_sg_for_device(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
@@ -335,7 +334,6 @@ void dma_direct_sync_sg_for_device(struct device *dev,
 					dir);
 	}
 }
-EXPORT_SYMBOL(dma_direct_sync_sg_for_device);
 #endif
 
 #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
@@ -354,7 +352,6 @@ void dma_direct_sync_single_for_cpu(struct device *dev,
 	if (unlikely(is_swiotlb_buffer(paddr)))
 		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
 }
-EXPORT_SYMBOL(dma_direct_sync_single_for_cpu);
 
 void dma_direct_sync_sg_for_cpu(struct device *dev,
 		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
@@ -376,7 +373,6 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
 	if (!dev_is_dma_coherent(dev))
 		arch_sync_dma_for_cpu_all();
 }
-EXPORT_SYMBOL(dma_direct_sync_sg_for_cpu);
 
 void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
@@ -389,7 +385,6 @@ void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
 	if (unlikely(is_swiotlb_buffer(phys)))
 		swiotlb_tbl_unmap_single(dev, phys, size, size, dir, attrs);
 }
-EXPORT_SYMBOL(dma_direct_unmap_page);
 
 void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction dir, unsigned long attrs)
@@ -401,7 +396,6 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
 			     attrs);
 }
-EXPORT_SYMBOL(dma_direct_unmap_sg);
 #endif
 
 dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
@@ -428,7 +422,6 @@ dma_addr_t dma_direct_map_page(struct device *dev, struct page *page,
 		arch_sync_dma_for_device(phys, size, dir);
 	return dma_addr;
 }
-EXPORT_SYMBOL(dma_direct_map_page);
 
 int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 		enum dma_data_direction dir, unsigned long attrs)
@@ -450,7 +443,6 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
 	return 0;
 }
-EXPORT_SYMBOL(dma_direct_map_sg);
 
 dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
@@ -467,7 +459,6 @@ dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
 
 	return dma_addr;
 }
-EXPORT_SYMBOL(dma_direct_map_resource);
 
 int dma_direct_get_sgtable(struct device *dev, struct sg_table *sgt,
 		void *cpu_addr, dma_addr_t dma_addr, size_t size,
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index a8c18c9a796fdc..b53953024512fe 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -105,6 +105,170 @@ void *dmam_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 }
 EXPORT_SYMBOL(dmam_alloc_attrs);
 
+static inline bool dma_is_direct(const struct dma_map_ops *ops)
+{
+	return likely(!ops);
+}
+
+dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
+		size_t offset, size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+	dma_addr_t addr;
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (dma_is_direct(ops))
+		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
+	else
+		addr = ops->map_page(dev, page, offset, size, dir, attrs);
+	debug_dma_map_page(dev, page, offset, size, dir, addr);
+
+	return addr;
+}
+EXPORT_SYMBOL(dma_map_page_attrs);
+
+void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (dma_is_direct(ops))
+		dma_direct_unmap_page(dev, addr, size, dir, attrs);
+	else if (ops->unmap_page)
+		ops->unmap_page(dev, addr, size, dir, attrs);
+	debug_dma_unmap_page(dev, addr, size, dir);
+}
+EXPORT_SYMBOL(dma_unmap_page_attrs);
+
+/*
+ * dma_maps_sg_attrs returns 0 on error and > 0 on success.
+ * It should never return a value < 0.
+ */
+int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+	int ents;
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (dma_is_direct(ops))
+		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
+	else
+		ents = ops->map_sg(dev, sg, nents, dir, attrs);
+	BUG_ON(ents < 0);
+	debug_dma_map_sg(dev, sg, nents, ents, dir);
+
+	return ents;
+}
+EXPORT_SYMBOL(dma_map_sg_attrs);
+
+void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
+				      int nents, enum dma_data_direction dir,
+				      unsigned long attrs)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	debug_dma_unmap_sg(dev, sg, nents, dir);
+	if (dma_is_direct(ops))
+		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
+	else if (ops->unmap_sg)
+		ops->unmap_sg(dev, sg, nents, dir, attrs);
+}
+EXPORT_SYMBOL(dma_unmap_sg_attrs);
+
+dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+	dma_addr_t addr = DMA_MAPPING_ERROR;
+
+	BUG_ON(!valid_dma_direction(dir));
+
+	/* Don't allow RAM to be mapped */
+	if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
+		return DMA_MAPPING_ERROR;
+
+	if (dma_is_direct(ops))
+		addr = dma_direct_map_resource(dev, phys_addr, size, dir, attrs);
+	else if (ops->map_resource)
+		addr = ops->map_resource(dev, phys_addr, size, dir, attrs);
+
+	debug_dma_map_resource(dev, phys_addr, size, dir, addr);
+	return addr;
+}
+EXPORT_SYMBOL(dma_map_resource);
+
+void dma_unmap_resource(struct device *dev, dma_addr_t addr, size_t size,
+		enum dma_data_direction dir, unsigned long attrs)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (!dma_is_direct(ops) && ops->unmap_resource)
+		ops->unmap_resource(dev, addr, size, dir, attrs);
+	debug_dma_unmap_resource(dev, addr, size, dir);
+}
+EXPORT_SYMBOL(dma_unmap_resource);
+
+void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr, size_t size,
+		enum dma_data_direction dir)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (dma_is_direct(ops))
+		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
+	else if (ops->sync_single_for_cpu)
+		ops->sync_single_for_cpu(dev, addr, size, dir);
+	debug_dma_sync_single_for_cpu(dev, addr, size, dir);
+}
+EXPORT_SYMBOL(dma_sync_single_for_cpu);
+
+void dma_sync_single_for_device(struct device *dev, dma_addr_t addr,
+		size_t size, enum dma_data_direction dir)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (dma_is_direct(ops))
+		dma_direct_sync_single_for_device(dev, addr, size, dir);
+	else if (ops->sync_single_for_device)
+		ops->sync_single_for_device(dev, addr, size, dir);
+	debug_dma_sync_single_for_device(dev, addr, size, dir);
+}
+EXPORT_SYMBOL(dma_sync_single_for_device);
+
+void dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
+		    int nelems, enum dma_data_direction dir)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (dma_is_direct(ops))
+		dma_direct_sync_sg_for_cpu(dev, sg, nelems, dir);
+	else if (ops->sync_sg_for_cpu)
+		ops->sync_sg_for_cpu(dev, sg, nelems, dir);
+	debug_dma_sync_sg_for_cpu(dev, sg, nelems, dir);
+}
+EXPORT_SYMBOL(dma_sync_sg_for_cpu);
+
+void dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
+		       int nelems, enum dma_data_direction dir)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	BUG_ON(!valid_dma_direction(dir));
+	if (dma_is_direct(ops))
+		dma_direct_sync_sg_for_device(dev, sg, nelems, dir);
+	else if (ops->sync_sg_for_device)
+		ops->sync_sg_for_device(dev, sg, nelems, dir);
+	debug_dma_sync_sg_for_device(dev, sg, nelems, dir);
+}
+EXPORT_SYMBOL(dma_sync_sg_for_device);
+
 /*
  * Create scatter-list for the already allocated DMA buffer.
  */
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
