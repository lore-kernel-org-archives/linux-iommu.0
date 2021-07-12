Return-Path: <SRS0=b5xv=ME=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1B5C07E99
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 06:20:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8539061107
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 06:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8539061107
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4931B4012C;
	Mon, 12 Jul 2021 06:20:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ij2LLdLfDHkP; Mon, 12 Jul 2021 06:20:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DF182400CB;
	Mon, 12 Jul 2021 06:20:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B61A4C0010;
	Mon, 12 Jul 2021 06:20:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77C8BC000E
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:20:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 653DF606BA
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:20:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jp9SE3t9U9w6 for <iommu@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 06:19:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D7026058D
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 06:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=UhkCU2sEw53RmWN21Z8+k4mhj1p/WEbokRIpJqAAyt8=; b=NOEQDVGSkWa7JbJUMAr+wu4/4n
 e3jaU2L/1xwFoQ7qooaCwO771e6hqu51gNr3cwwK8NtR7YcIHN0Da5YaArCnU12VHE6QTLdKnE9gm
 gP/6gEWJhDMIaLErEuVp3taOA+rjgxl6m/5v5IampmluoqCvhyQZUVjBJLjDKVzJkeBc2txJMSjfN
 1Z1VWWpVCswe816CwyvmmoQHQbyZIYzPWMZq1hcHlur1kQUjEpFVZ5hwXYi3PdXjzR4rvawCpmJ6+
 9dIioC+R/EW0ETB/kvSKwbtw5upr+1ITF/3B1c60YGMsLwFhk2OuFt1AW0vT+6y24zjB0QxPbhWH5
 kxvIUvBQ==;
Received: from [2001:4bb8:184:8b7c:bd9:61b8:39ba:d78a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m2pHU-00Gx9t-Nu; Mon, 12 Jul 2021 06:19:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>,
 Brian Cain <bcain@codeaurora.org>
Subject: [PATCH 2/7] ARM/nommu: use the generic dma-direct code for
 non-coherent devices
Date: Mon, 12 Jul 2021 08:16:59 +0200
Message-Id: <20210712061704.4162464-3-hch@lst.de>
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

Select the right options to just use the generic dma-direct code
instead of reimplementing it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Dillon Min <dillon.minfei@gmail.com>
---
 arch/arm/Kconfig                |   5 +-
 arch/arm/mm/dma-mapping-nommu.c | 173 ++------------------------------
 2 files changed, 9 insertions(+), 169 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3ea1c417339f..fcb192bfd35a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -18,8 +18,8 @@ config ARM
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 	select ARCH_HAS_STRICT_MODULE_RWX if MMU
-	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if SWIOTLB
-	select ARCH_HAS_SYNC_DMA_FOR_CPU if SWIOTLB
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if SWIOTLB || !MMU
+	select ARCH_HAS_SYNC_DMA_FOR_CPU if SWIOTLB || !MMU
 	select ARCH_HAS_TEARDOWN_DMA_OPS if MMU
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAVE_CUSTOM_GPIO_H
@@ -44,6 +44,7 @@ config ARM
 	select CPU_PM if SUSPEND || CPU_IDLE
 	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select DMA_DECLARE_COHERENT
+	select DMA_GLOBAL_POOL if !MMU
 	select DMA_OPS
 	select DMA_REMAP if MMU
 	select EDAC_SUPPORT
diff --git a/arch/arm/mm/dma-mapping-nommu.c b/arch/arm/mm/dma-mapping-nommu.c
index 6bfd2b884505..cfd9c933d2f0 100644
--- a/arch/arm/mm/dma-mapping-nommu.c
+++ b/arch/arm/mm/dma-mapping-nommu.c
@@ -5,12 +5,7 @@
  *  Copyright (C) 2000-2004 Russell King
  */
 
-#include <linux/export.h>
-#include <linux/mm.h>
-#include <linux/dma-direct.h>
 #include <linux/dma-map-ops.h>
-#include <linux/scatterlist.h>
-
 #include <asm/cachetype.h>
 #include <asm/cacheflush.h>
 #include <asm/outercache.h>
@@ -18,65 +13,8 @@
 
 #include "dma.h"
 
-/*
- *  The generic direct mapping code is used if
- *   - MMU/MPU is off
- *   - cpu is v7m w/o cache support
- *   - device is coherent
- *  otherwise arm_nommu_dma_ops is used.
- *
- *  arm_nommu_dma_ops rely on consistent DMA memory (please, refer to
- *  [1] on how to declare such memory).
- *
- *  [1] Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
- */
-
-static void *arm_nommu_dma_alloc(struct device *dev, size_t size,
-				 dma_addr_t *dma_handle, gfp_t gfp,
-				 unsigned long attrs)
-
-{
-	void *ret = dma_alloc_from_global_coherent(dev, size, dma_handle);
-
-	/*
-	 * dma_alloc_from_global_coherent() may fail because:
-	 *
-	 * - no consistent DMA region has been defined, so we can't
-	 *   continue.
-	 * - there is no space left in consistent DMA region, so we
-	 *   only can fallback to generic allocator if we are
-	 *   advertised that consistency is not required.
-	 */
-
-	WARN_ON_ONCE(ret == NULL);
-	return ret;
-}
-
-static void arm_nommu_dma_free(struct device *dev, size_t size,
-			       void *cpu_addr, dma_addr_t dma_addr,
-			       unsigned long attrs)
-{
-	int ret = dma_release_from_global_coherent(get_order(size), cpu_addr);
-
-	WARN_ON_ONCE(ret == 0);
-}
-
-static int arm_nommu_dma_mmap(struct device *dev, struct vm_area_struct *vma,
-			      void *cpu_addr, dma_addr_t dma_addr, size_t size,
-			      unsigned long attrs)
-{
-	int ret;
-
-	if (dma_mmap_from_global_coherent(vma, cpu_addr, size, &ret))
-		return ret;
-	if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
-		return ret;
-	return -ENXIO;
-}
-
-
-static void __dma_page_cpu_to_dev(phys_addr_t paddr, size_t size,
-				  enum dma_data_direction dir)
+void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	dmac_map_area(__va(paddr), size, dir);
 
@@ -86,8 +24,8 @@ static void __dma_page_cpu_to_dev(phys_addr_t paddr, size_t size,
 		outer_clean_range(paddr, paddr + size);
 }
 
-static void __dma_page_dev_to_cpu(phys_addr_t paddr, size_t size,
-				  enum dma_data_direction dir)
+void arch_sync_dma_for_cpu(phys_addr_t paddr, size_t size,
+		enum dma_data_direction dir)
 {
 	if (dir != DMA_TO_DEVICE) {
 		outer_inv_range(paddr, paddr + size);
@@ -95,102 +33,6 @@ static void __dma_page_dev_to_cpu(phys_addr_t paddr, size_t size,
 	}
 }
 
-static dma_addr_t arm_nommu_dma_map_page(struct device *dev, struct page *page,
-					 unsigned long offset, size_t size,
-					 enum dma_data_direction dir,
-					 unsigned long attrs)
-{
-	dma_addr_t handle = page_to_phys(page) + offset;
-
-	__dma_page_cpu_to_dev(handle, size, dir);
-
-	return handle;
-}
-
-static void arm_nommu_dma_unmap_page(struct device *dev, dma_addr_t handle,
-				     size_t size, enum dma_data_direction dir,
-				     unsigned long attrs)
-{
-	__dma_page_dev_to_cpu(handle, size, dir);
-}
-
-
-static int arm_nommu_dma_map_sg(struct device *dev, struct scatterlist *sgl,
-				int nents, enum dma_data_direction dir,
-				unsigned long attrs)
-{
-	int i;
-	struct scatterlist *sg;
-
-	for_each_sg(sgl, sg, nents, i) {
-		sg_dma_address(sg) = sg_phys(sg);
-		sg_dma_len(sg) = sg->length;
-		__dma_page_cpu_to_dev(sg_dma_address(sg), sg_dma_len(sg), dir);
-	}
-
-	return nents;
-}
-
-static void arm_nommu_dma_unmap_sg(struct device *dev, struct scatterlist *sgl,
-				   int nents, enum dma_data_direction dir,
-				   unsigned long attrs)
-{
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sgl, sg, nents, i)
-		__dma_page_dev_to_cpu(sg_dma_address(sg), sg_dma_len(sg), dir);
-}
-
-static void arm_nommu_dma_sync_single_for_device(struct device *dev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
-{
-	__dma_page_cpu_to_dev(handle, size, dir);
-}
-
-static void arm_nommu_dma_sync_single_for_cpu(struct device *dev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir)
-{
-	__dma_page_cpu_to_dev(handle, size, dir);
-}
-
-static void arm_nommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
-					     int nents, enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sgl, sg, nents, i)
-		__dma_page_cpu_to_dev(sg_dma_address(sg), sg_dma_len(sg), dir);
-}
-
-static void arm_nommu_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sgl,
-					  int nents, enum dma_data_direction dir)
-{
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sgl, sg, nents, i)
-		__dma_page_dev_to_cpu(sg_dma_address(sg), sg_dma_len(sg), dir);
-}
-
-const struct dma_map_ops arm_nommu_dma_ops = {
-	.alloc			= arm_nommu_dma_alloc,
-	.free			= arm_nommu_dma_free,
-	.alloc_pages		= dma_direct_alloc_pages,
-	.free_pages		= dma_direct_free_pages,
-	.mmap			= arm_nommu_dma_mmap,
-	.map_page		= arm_nommu_dma_map_page,
-	.unmap_page		= arm_nommu_dma_unmap_page,
-	.map_sg			= arm_nommu_dma_map_sg,
-	.unmap_sg		= arm_nommu_dma_unmap_sg,
-	.sync_single_for_device	= arm_nommu_dma_sync_single_for_device,
-	.sync_single_for_cpu	= arm_nommu_dma_sync_single_for_cpu,
-	.sync_sg_for_device	= arm_nommu_dma_sync_sg_for_device,
-	.sync_sg_for_cpu	= arm_nommu_dma_sync_sg_for_cpu,
-};
-EXPORT_SYMBOL(arm_nommu_dma_ops);
-
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 			const struct iommu_ops *iommu, bool coherent)
 {
@@ -201,14 +43,11 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		 * enough to check if MPU is in use or not since in absense of
 		 * MPU system memory map is used.
 		 */
-		dev->archdata.dma_coherent = (cacheid) ? coherent : true;
+		dev->dma_coherent = cacheid ? coherent : true;
 	} else {
 		/*
 		 * Assume coherent DMA in case MMU/MPU has not been set up.
 		 */
-		dev->archdata.dma_coherent = (get_cr() & CR_M) ? coherent : true;
+		dev->dma_coherent = (get_cr() & CR_M) ? coherent : true;
 	}
-
-	if (!dev->archdata.dma_coherent)
-		set_dma_ops(dev, &arm_nommu_dma_ops);
 }
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
