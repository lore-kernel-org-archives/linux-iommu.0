Return-Path: <SRS0=dlfR=AT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A22C433DF
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 15:39:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D966F206DF
	for <iommu@archiver.kernel.org>; Wed,  8 Jul 2020 15:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Awv94X5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D966F206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AC50487CE2;
	Wed,  8 Jul 2020 15:39:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FKIlhAP5Dsko; Wed,  8 Jul 2020 15:39:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0F72D870A1;
	Wed,  8 Jul 2020 15:39:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0171CC0893;
	Wed,  8 Jul 2020 15:39:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3604EC016F
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 15:39:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 26B7020493
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 15:39:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id djW2D1bnONQl for <iommu@lists.linux-foundation.org>;
 Wed,  8 Jul 2020 15:39:22 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id 8B3BA20439
 for <iommu@lists.linux-foundation.org>; Wed,  8 Jul 2020 15:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=YWMW3K2J8IUvzI1kP8IohAug+CmpewPJUfdbnh0Wntw=; b=Awv94X5LC0od1aO6iiqfINx41h
 2ztg70rY1xevKISNu8a6NNpryEMxwzKMDhpZNrUz6cW3Zzki2SpLb7SW1pjbnB7fN+89XrPwHbUEI
 F2+9CQ+b1aSn1ueXLovk8LBQ00lAQdvLuVZ24glSD1MkAUNFDZyBISY4AiT5gAYobVJLW/TdI0uW6
 iaxu7eGXc5ldvemq9ZchE9XZk12GnQL01sBY+XIFwIse/zuPtE/7V4gyEVVcFuFr5/Dgu9G5wgtUK
 mEiz6s6MG0By+PY7KJX8TQYrbBgHVGXeLFuBIOOP7CNoZ7B9KThLVw6WWY1sQE35duApqGEDQ7X4K
 cLAq4RrA==;
Received: from 213-225-32-40.nat.highway.a1.net ([213.225.32.40]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtCAB-0002eQ-Vl; Wed, 08 Jul 2020 15:39:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org,
	Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH 5/5] powerpc: use the generic dma_ops_bypass mode
Date: Wed,  8 Jul 2020 17:24:49 +0200
Message-Id: <20200708152449.316476-6-hch@lst.de>
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

Use the DMA API bypass mechanism for direct window mappings.  This uses
common code and speed up the direct mapping case by avoiding indirect
calls just when not using dma ops at all.  It also fixes a problem where
the sync_* methods were using the bypass check for DMA allocations, but
those are part of the streaming ops.

Note that this patch loses the DMA_ATTR_WEAK_ORDERING override, which
has never been well defined, as is only used by a few drivers, which
IIRC never showed up in the typical Cell blade setups that are affected
by the ordering workaround.

Fixes: efd176a04bef ("powerpc/pseries/dma: Allow SWIOTLB")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/Kconfig              |  1 +
 arch/powerpc/include/asm/device.h |  5 --
 arch/powerpc/kernel/dma-iommu.c   | 90 ++++---------------------------
 3 files changed, 10 insertions(+), 86 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e9b091d3587222..be868bfbe76ecf 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -152,6 +152,7 @@ config PPC
 	select CLONE_BACKWARDS
 	select DCACHE_WORD_ACCESS		if PPC64 && CPU_LITTLE_ENDIAN
 	select DMA_OPS				if PPC64
+	select DMA_OPS_BYPASS			if PPC64
 	select DYNAMIC_FTRACE			if FUNCTION_TRACER
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 266542769e4bd1..452402215e1210 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -18,11 +18,6 @@ struct iommu_table;
  * drivers/macintosh/macio_asic.c
  */
 struct dev_archdata {
-	/*
-	 * Set to %true if the dma_iommu_ops are requested to use a direct
-	 * window instead of dynamically mapping memory.
-	 */
-	bool			iommu_bypass : 1;
 	/*
 	 * These two used to be a union. However, with the hybrid ops we need
 	 * both so here we store both a DMA offset for direct mappings and
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index e486d1d78de288..569fecd7b5b234 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -14,23 +14,6 @@
  * Generic iommu implementation
  */
 
-/*
- * The coherent mask may be smaller than the real mask, check if we can
- * really use a direct window.
- */
-static inline bool dma_iommu_alloc_bypass(struct device *dev)
-{
-	return dev->archdata.iommu_bypass && !iommu_fixed_is_weak &&
-		dma_direct_supported(dev, dev->coherent_dma_mask);
-}
-
-static inline bool dma_iommu_map_bypass(struct device *dev,
-		unsigned long attrs)
-{
-	return dev->archdata.iommu_bypass &&
-		(!iommu_fixed_is_weak || (attrs & DMA_ATTR_WEAK_ORDERING));
-}
-
 /* Allocates a contiguous real buffer and creates mappings over it.
  * Returns the virtual address of the buffer and sets dma_handle
  * to the dma address (mapping) of the first page.
@@ -39,8 +22,6 @@ static void *dma_iommu_alloc_coherent(struct device *dev, size_t size,
 				      dma_addr_t *dma_handle, gfp_t flag,
 				      unsigned long attrs)
 {
-	if (dma_iommu_alloc_bypass(dev))
-		return dma_direct_alloc(dev, size, dma_handle, flag, attrs);
 	return iommu_alloc_coherent(dev, get_iommu_table_base(dev), size,
 				    dma_handle, dev->coherent_dma_mask, flag,
 				    dev_to_node(dev));
@@ -50,11 +31,7 @@ static void dma_iommu_free_coherent(struct device *dev, size_t size,
 				    void *vaddr, dma_addr_t dma_handle,
 				    unsigned long attrs)
 {
-	if (dma_iommu_alloc_bypass(dev))
-		dma_direct_free(dev, size, vaddr, dma_handle, attrs);
-	else
-		iommu_free_coherent(get_iommu_table_base(dev), size, vaddr,
-				dma_handle);
+	iommu_free_coherent(get_iommu_table_base(dev), size, vaddr, dma_handle);
 }
 
 /* Creates TCEs for a user provided buffer.  The user buffer must be
@@ -67,9 +44,6 @@ static dma_addr_t dma_iommu_map_page(struct device *dev, struct page *page,
 				     enum dma_data_direction direction,
 				     unsigned long attrs)
 {
-	if (dma_iommu_map_bypass(dev, attrs))
-		return dma_direct_map_page(dev, page, offset, size, direction,
-				attrs);
 	return iommu_map_page(dev, get_iommu_table_base(dev), page, offset,
 			      size, dma_get_mask(dev), direction, attrs);
 }
@@ -79,11 +53,8 @@ static void dma_iommu_unmap_page(struct device *dev, dma_addr_t dma_handle,
 				 size_t size, enum dma_data_direction direction,
 				 unsigned long attrs)
 {
-	if (!dma_iommu_map_bypass(dev, attrs))
-		iommu_unmap_page(get_iommu_table_base(dev), dma_handle, size,
-				direction,  attrs);
-	else
-		dma_direct_unmap_page(dev, dma_handle, size, direction, attrs);
+	iommu_unmap_page(get_iommu_table_base(dev), dma_handle, size, direction,
+			 attrs);
 }
 
 
@@ -91,8 +62,6 @@ static int dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 			    int nelems, enum dma_data_direction direction,
 			    unsigned long attrs)
 {
-	if (dma_iommu_map_bypass(dev, attrs))
-		return dma_direct_map_sg(dev, sglist, nelems, direction, attrs);
 	return ppc_iommu_map_sg(dev, get_iommu_table_base(dev), sglist, nelems,
 				dma_get_mask(dev), direction, attrs);
 }
@@ -101,11 +70,8 @@ static void dma_iommu_unmap_sg(struct device *dev, struct scatterlist *sglist,
 		int nelems, enum dma_data_direction direction,
 		unsigned long attrs)
 {
-	if (!dma_iommu_map_bypass(dev, attrs))
-		ppc_iommu_unmap_sg(get_iommu_table_base(dev), sglist, nelems,
+	ppc_iommu_unmap_sg(get_iommu_table_base(dev), sglist, nelems,
 			   direction, attrs);
-	else
-		dma_direct_unmap_sg(dev, sglist, nelems, direction, attrs);
 }
 
 static bool dma_iommu_bypass_supported(struct device *dev, u64 mask)
@@ -113,8 +79,9 @@ static bool dma_iommu_bypass_supported(struct device *dev, u64 mask)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pci_controller *phb = pci_bus_to_host(pdev->bus);
 
-	return phb->controller_ops.iommu_bypass_supported &&
-		phb->controller_ops.iommu_bypass_supported(pdev, mask);
+	if (iommu_fixed_is_weak || !phb->controller_ops.iommu_bypass_supported)
+		return false;
+	return phb->controller_ops.iommu_bypass_supported(pdev, mask);
 }
 
 /* We support DMA to/from any memory page via the iommu */
@@ -123,7 +90,7 @@ int dma_iommu_dma_supported(struct device *dev, u64 mask)
 	struct iommu_table *tbl = get_iommu_table_base(dev);
 
 	if (dev_is_pci(dev) && dma_iommu_bypass_supported(dev, mask)) {
-		dev->archdata.iommu_bypass = true;
+		dev->dma_ops_bypass = true;
 		dev_dbg(dev, "iommu: 64-bit OK, using fixed ops\n");
 		return 1;
 	}
@@ -141,7 +108,7 @@ int dma_iommu_dma_supported(struct device *dev, u64 mask)
 	}
 
 	dev_dbg(dev, "iommu: not 64-bit, using default ops\n");
-	dev->archdata.iommu_bypass = false;
+	dev->dma_ops_bypass = false;
 	return 1;
 }
 
@@ -153,47 +120,12 @@ u64 dma_iommu_get_required_mask(struct device *dev)
 	if (!tbl)
 		return 0;
 
-	if (dev_is_pci(dev)) {
-		u64 bypass_mask = dma_direct_get_required_mask(dev);
-
-		if (dma_iommu_bypass_supported(dev, bypass_mask))
-			return bypass_mask;
-	}
-
 	mask = 1ULL < (fls_long(tbl->it_offset + tbl->it_size) - 1);
 	mask += mask - 1;
 
 	return mask;
 }
 
-static void dma_iommu_sync_for_cpu(struct device *dev, dma_addr_t addr,
-		size_t size, enum dma_data_direction dir)
-{
-	if (dma_iommu_alloc_bypass(dev))
-		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
-}
-
-static void dma_iommu_sync_for_device(struct device *dev, dma_addr_t addr,
-		size_t sz, enum dma_data_direction dir)
-{
-	if (dma_iommu_alloc_bypass(dev))
-		dma_direct_sync_single_for_device(dev, addr, sz, dir);
-}
-
-extern void dma_iommu_sync_sg_for_cpu(struct device *dev,
-		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
-{
-	if (dma_iommu_alloc_bypass(dev))
-		dma_direct_sync_sg_for_cpu(dev, sgl, nents, dir);
-}
-
-extern void dma_iommu_sync_sg_for_device(struct device *dev,
-		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
-{
-	if (dma_iommu_alloc_bypass(dev))
-		dma_direct_sync_sg_for_device(dev, sgl, nents, dir);
-}
-
 const struct dma_map_ops dma_iommu_ops = {
 	.alloc			= dma_iommu_alloc_coherent,
 	.free			= dma_iommu_free_coherent,
@@ -203,10 +135,6 @@ const struct dma_map_ops dma_iommu_ops = {
 	.map_page		= dma_iommu_map_page,
 	.unmap_page		= dma_iommu_unmap_page,
 	.get_required_mask	= dma_iommu_get_required_mask,
-	.sync_single_for_cpu	= dma_iommu_sync_for_cpu,
-	.sync_single_for_device	= dma_iommu_sync_for_device,
-	.sync_sg_for_cpu	= dma_iommu_sync_sg_for_cpu,
-	.sync_sg_for_device	= dma_iommu_sync_sg_for_device,
 	.mmap			= dma_common_mmap,
 	.get_sgtable		= dma_common_get_sgtable,
 };
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
