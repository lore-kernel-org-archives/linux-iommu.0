Return-Path: <SRS0=Lu7X=XA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF43C3A5AB
	for <iommu@archiver.kernel.org>; Thu,  5 Sep 2019 11:38:39 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD0B21848
	for <iommu@archiver.kernel.org>; Thu,  5 Sep 2019 11:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gG/jB0yB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD0B21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6E2771645;
	Thu,  5 Sep 2019 11:38:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7F200FEA
	for <iommu@lists.linux-foundation.org>;
	Thu,  5 Sep 2019 11:38:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D13D1A9
	for <iommu@lists.linux-foundation.org>;
	Thu,  5 Sep 2019 11:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lvjuAVmXWnqIo3K+E9tXy5TID8WvXJDeSutxv9/oHdw=;
	b=gG/jB0yBlGSl35MsUrkeDPerAo
	cE/FDIbYcjuiubqlkgQWE4CHjude/TTSjjU2UcQPV6O8KtLjcmzxULuUqStE3F+yZ8qdjlKcrKG7B
	Lv6GlmMzXARAejrzHHYCWFXzV9YWn7t8I3BXGHBXzN3x1vg2q+MX7u5hlJyrWkH3p6K0B92r3ntU7
	NTKbssKPuMahrzrDN4eSo5094KtagVRc8zSedcWQzPL+FxuY8rMBusWnjPp8rIfnHqD//0T90s3Y4
	rypryPkG2ONX/Gtg+CYjBcUVczWsN3lYYyGDYu7AA8Glx4rInW4Rk4v13yEihbf/G9iEDrb18iBov
	2KejsX1Q==;
Received: from 213-225-38-191.nat.highway.a1.net ([213.225.38.191]
	helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1i5q5x-0002ZN-Ow; Thu, 05 Sep 2019 11:38:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Stefano Stabellini <sstabellini@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, gross@suse.com,
	boris.ostrovsky@oracle.com
Subject: [PATCH 01/11] xen/arm: use dma-noncoherent.h calls for xen-swiotlb
	cache maintainance
Date: Thu,  5 Sep 2019 13:33:58 +0200
Message-Id: <20190905113408.3104-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190905113408.3104-1-hch@lst.de>
References: <20190905113408.3104-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
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

Copy the arm64 code that uses the dma-direct/swiotlb helpers for DMA
on-coherent devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/device.h            |  3 -
 arch/arm/include/asm/xen/page-coherent.h | 72 +++++++++---------------
 arch/arm/mm/dma-mapping.c                |  8 +--
 drivers/xen/swiotlb-xen.c                | 20 -------
 4 files changed, 28 insertions(+), 75 deletions(-)

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index f6955b55c544..c675bc0d5aa8 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -14,9 +14,6 @@ struct dev_archdata {
 #endif
 #ifdef CONFIG_ARM_DMA_USE_IOMMU
 	struct dma_iommu_mapping	*mapping;
-#endif
-#ifdef CONFIG_XEN
-	const struct dma_map_ops *dev_dma_ops;
 #endif
 	unsigned int dma_coherent:1;
 	unsigned int dma_ops_setup:1;
diff --git a/arch/arm/include/asm/xen/page-coherent.h b/arch/arm/include/asm/xen/page-coherent.h
index 2c403e7c782d..602ac02f154c 100644
--- a/arch/arm/include/asm/xen/page-coherent.h
+++ b/arch/arm/include/asm/xen/page-coherent.h
@@ -6,23 +6,37 @@
 #include <asm/page.h>
 #include <xen/arm/page-coherent.h>
 
-static inline const struct dma_map_ops *xen_get_dma_ops(struct device *dev)
-{
-	if (dev && dev->archdata.dev_dma_ops)
-		return dev->archdata.dev_dma_ops;
-	return get_arch_dma_ops(NULL);
-}
-
 static inline void *xen_alloc_coherent_pages(struct device *hwdev, size_t size,
 		dma_addr_t *dma_handle, gfp_t flags, unsigned long attrs)
 {
-	return xen_get_dma_ops(hwdev)->alloc(hwdev, size, dma_handle, flags, attrs);
+	return dma_direct_alloc(hwdev, size, dma_handle, flags, attrs);
 }
 
 static inline void xen_free_coherent_pages(struct device *hwdev, size_t size,
 		void *cpu_addr, dma_addr_t dma_handle, unsigned long attrs)
 {
-	xen_get_dma_ops(hwdev)->free(hwdev, size, cpu_addr, dma_handle, attrs);
+	dma_direct_free(hwdev, size, cpu_addr, dma_handle, attrs);
+}
+
+static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir)
+{
+	unsigned long pfn = PFN_DOWN(handle);
+
+	if (pfn_valid(pfn))
+		dma_direct_sync_single_for_cpu(hwdev, handle, size, dir);
+	else
+		__xen_dma_sync_single_for_cpu(hwdev, handle, size, dir);
+}
+
+static inline void xen_dma_sync_single_for_device(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir)
+{
+	unsigned long pfn = PFN_DOWN(handle);
+	if (pfn_valid(pfn))
+		dma_direct_sync_single_for_device(hwdev, handle, size, dir);
+	else
+		__xen_dma_sync_single_for_device(hwdev, handle, size, dir);
 }
 
 static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
@@ -36,17 +50,8 @@ static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
 	bool local = (page_pfn <= dev_pfn) &&
 		(dev_pfn - page_pfn < compound_pages);
 
-	/*
-	 * Dom0 is mapped 1:1, while the Linux page can span across
-	 * multiple Xen pages, it's not possible for it to contain a
-	 * mix of local and foreign Xen pages. So if the first xen_pfn
-	 * == mfn the page is local otherwise it's a foreign page
-	 * grant-mapped in dom0. If the page is local we can safely
-	 * call the native dma_ops function, otherwise we call the xen
-	 * specific function.
-	 */
 	if (local)
-		xen_get_dma_ops(hwdev)->map_page(hwdev, page, offset, size, dir, attrs);
+		dma_direct_map_page(hwdev, page, offset, size, dir, attrs);
 	else
 		__xen_dma_map_page(hwdev, page, dev_addr, offset, size, dir, attrs);
 }
@@ -63,33 +68,10 @@ static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 	 * safely call the native dma_ops function, otherwise we call the xen
 	 * specific function.
 	 */
-	if (pfn_valid(pfn)) {
-		if (xen_get_dma_ops(hwdev)->unmap_page)
-			xen_get_dma_ops(hwdev)->unmap_page(hwdev, handle, size, dir, attrs);
-	} else
+	if (pfn_valid(pfn))
+		dma_direct_unmap_page(hwdev, handle, size, dir, attrs);
+	else
 		__xen_dma_unmap_page(hwdev, handle, size, dir, attrs);
 }
 
-static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
-{
-	unsigned long pfn = PFN_DOWN(handle);
-	if (pfn_valid(pfn)) {
-		if (xen_get_dma_ops(hwdev)->sync_single_for_cpu)
-			xen_get_dma_ops(hwdev)->sync_single_for_cpu(hwdev, handle, size, dir);
-	} else
-		__xen_dma_sync_single_for_cpu(hwdev, handle, size, dir);
-}
-
-static inline void xen_dma_sync_single_for_device(struct device *hwdev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
-{
-	unsigned long pfn = PFN_DOWN(handle);
-	if (pfn_valid(pfn)) {
-		if (xen_get_dma_ops(hwdev)->sync_single_for_device)
-			xen_get_dma_ops(hwdev)->sync_single_for_device(hwdev, handle, size, dir);
-	} else
-		__xen_dma_sync_single_for_device(hwdev, handle, size, dir);
-}
-
 #endif /* _ASM_ARM_XEN_PAGE_COHERENT_H */
diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index d42557ee69c2..738097396445 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1132,10 +1132,6 @@ static const struct dma_map_ops *arm_get_dma_map_ops(bool coherent)
 	 * 32-bit DMA.
 	 * Use the generic dma-direct / swiotlb ops code in that case, as that
 	 * handles bounce buffering for us.
-	 *
-	 * Note: this checks CONFIG_ARM_LPAE instead of CONFIG_SWIOTLB as the
-	 * latter is also selected by the Xen code, but that code for now relies
-	 * on non-NULL dev_dma_ops.  To be cleaned up later.
 	 */
 	if (IS_ENABLED(CONFIG_ARM_LPAE))
 		return NULL;
@@ -2363,10 +2359,8 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 	set_dma_ops(dev, dma_ops);
 
 #ifdef CONFIG_XEN
-	if (xen_initial_domain()) {
-		dev->archdata.dev_dma_ops = dev->dma_ops;
+	if (xen_initial_domain())
 		dev->dma_ops = xen_dma_ops;
-	}
 #endif
 	dev->archdata.dma_ops_setup = true;
 }
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index ae1df496bf38..eee86cc7046b 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -557,11 +557,6 @@ xen_swiotlb_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 		     void *cpu_addr, dma_addr_t dma_addr, size_t size,
 		     unsigned long attrs)
 {
-#ifdef CONFIG_ARM
-	if (xen_get_dma_ops(dev)->mmap)
-		return xen_get_dma_ops(dev)->mmap(dev, vma, cpu_addr,
-						    dma_addr, size, attrs);
-#endif
 	return dma_common_mmap(dev, vma, cpu_addr, dma_addr, size, attrs);
 }
 
@@ -574,21 +569,6 @@ xen_swiotlb_get_sgtable(struct device *dev, struct sg_table *sgt,
 			void *cpu_addr, dma_addr_t handle, size_t size,
 			unsigned long attrs)
 {
-#ifdef CONFIG_ARM
-	if (xen_get_dma_ops(dev)->get_sgtable) {
-#if 0
-	/*
-	 * This check verifies that the page belongs to the current domain and
-	 * is not one mapped from another domain.
-	 * This check is for debug only, and should not go to production build
-	 */
-		unsigned long bfn = PHYS_PFN(dma_to_phys(dev, handle));
-		BUG_ON (!page_is_ram(bfn));
-#endif
-		return xen_get_dma_ops(dev)->get_sgtable(dev, sgt, cpu_addr,
-							   handle, size, attrs);
-	}
-#endif
 	return dma_common_get_sgtable(dev, sgt, cpu_addr, handle, size, attrs);
 }
 
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
