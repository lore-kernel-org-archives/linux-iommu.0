Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249ACC3A59C
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 13:00:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3F12173E
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 13:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fg1Fi2Xx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3F12173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ADEABEDC;
	Fri, 16 Aug 2019 13:00:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D54ABEB9
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 13:00:27 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 69F2887B
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 13:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+H6Vmvi99DXRckdm80fPfqbJQOOfhCyq72jLJc4AZJs=;
	b=fg1Fi2Xxi6o0tEMPl8vOVUio7o
	t8lYiDFMlKhmBktIj6FaJAjvhTvtxU7q3jkmxqQRhTI/HdTspzpS78lfidjtnfpYO24VaQe9Wz1KK
	tCtfViJsn+lWKv75nqnTVb3cbpPCE4Cfh71jlcNjduABet+BWRUUmdI383RyKapDenQSr5RNN/aS4
	x2YDR657QQrxVOkPb60idV50MA0FGiJDwMbglLvDEbEr5jfdBGe7b3yN3pp/BXmBwXZplm7ALRG8z
	lLOTjA4thw1W37tmnIl/nEBN5R98A765JswKgY2/g+EwMMvWleD8XPyDL+HrhCaQmh3cCi23INZI9
	P8K8AfcA==;
Received: from [91.112.187.46] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1hybqB-0006Lo-8l; Fri, 16 Aug 2019 13:00:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Stefano Stabellini <sstabellini@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 02/11] xen/arm: use dev_is_dma_coherent
Date: Fri, 16 Aug 2019 15:00:04 +0200
Message-Id: <20190816130013.31154-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816130013.31154-1-hch@lst.de>
References: <20190816130013.31154-1-hch@lst.de>
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

Use the dma-noncoherent dev_is_dma_coherent helper instead of the home
grown variant.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/dma-mapping.h   |  6 ------
 arch/arm/xen/mm.c                    | 12 ++++++------
 arch/arm64/include/asm/dma-mapping.h |  9 ---------
 3 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index dba9355e2484..bdd80ddbca34 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -91,12 +91,6 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 }
 #endif
 
-/* do not use this function in a driver */
-static inline bool is_device_dma_coherent(struct device *dev)
-{
-	return dev->archdata.dma_coherent;
-}
-
 /**
  * arm_dma_alloc - allocate consistent memory for DMA
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index d33b77e9add3..90574d89d0d4 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/cpu.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
 #include <linux/export.h>
@@ -99,7 +99,7 @@ void __xen_dma_map_page(struct device *hwdev, struct page *page,
 	     dma_addr_t dev_addr, unsigned long offset, size_t size,
 	     enum dma_data_direction dir, unsigned long attrs)
 {
-	if (is_device_dma_coherent(hwdev))
+	if (dev_is_dma_coherent(hwdev))
 		return;
 	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
 		return;
@@ -112,7 +112,7 @@ void __xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 		unsigned long attrs)
 
 {
-	if (is_device_dma_coherent(hwdev))
+	if (dev_is_dma_coherent(hwdev))
 		return;
 	if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
 		return;
@@ -123,7 +123,7 @@ void __xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 void __xen_dma_sync_single_for_cpu(struct device *hwdev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
-	if (is_device_dma_coherent(hwdev))
+	if (dev_is_dma_coherent(hwdev))
 		return;
 	__xen_dma_page_dev_to_cpu(hwdev, handle, size, dir);
 }
@@ -131,7 +131,7 @@ void __xen_dma_sync_single_for_cpu(struct device *hwdev,
 void __xen_dma_sync_single_for_device(struct device *hwdev,
 		dma_addr_t handle, size_t size, enum dma_data_direction dir)
 {
-	if (is_device_dma_coherent(hwdev))
+	if (dev_is_dma_coherent(hwdev))
 		return;
 	__xen_dma_page_cpu_to_dev(hwdev, handle, size, dir);
 }
@@ -159,7 +159,7 @@ bool xen_arch_need_swiotlb(struct device *dev,
 	 * memory and we are not able to flush the cache.
 	 */
 	return (!hypercall_cflush && (xen_pfn != bfn) &&
-		!is_device_dma_coherent(dev));
+		!dev_is_dma_coherent(dev));
 }
 
 int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
diff --git a/arch/arm64/include/asm/dma-mapping.h b/arch/arm64/include/asm/dma-mapping.h
index bdcb0922a40c..67243255a858 100644
--- a/arch/arm64/include/asm/dma-mapping.h
+++ b/arch/arm64/include/asm/dma-mapping.h
@@ -18,14 +18,5 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return NULL;
 }
 
-/*
- * Do not use this function in a driver, it is only provided for
- * arch/arm/mm/xen.c, which is used by arm64 as well.
- */
-static inline bool is_device_dma_coherent(struct device *dev)
-{
-	return dev->dma_coherent;
-}
-
 #endif	/* __KERNEL__ */
 #endif	/* __ASM_DMA_MAPPING_H */
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
