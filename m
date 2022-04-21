Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA04C433F5
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 11:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 580A961186;
	Thu, 21 Apr 2022 11:37:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7tHmuttg1MTo; Thu, 21 Apr 2022 11:37:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2A5866117E;
	Thu, 21 Apr 2022 11:37:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BE8CC0033;
	Thu, 21 Apr 2022 11:37:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0BDB8C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E63DC41B3C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:37:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jxL7dySHZPrX for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 11:37:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id E1BBB41A68
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 11:37:05 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2221B1480;
 Thu, 21 Apr 2022 04:37:05 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 229503F5A1;
 Thu, 21 Apr 2022 04:37:04 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: hch@lst.de,
	linux@armlinux.org.uk
Subject: [PATCH 1/3] ARM/dma-mapping: Drop .dma_supported for IOMMU ops
Date: Thu, 21 Apr 2022 12:36:57 +0100
Message-Id: <708280c132ffc837674d84bb6c165badbbc97d4e.1650539846.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.35.3.dirty
In-Reply-To: <cover.1650539846.git.robin.murphy@arm.com>
References: <cover.1650539846.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: arnd@kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

When an IOMMU is present, we trust that it should be capable
of remapping any physical memory, and since the device masks
represent the input (virtual) addresses to the IOMMU it makes
no sense to validate them against physical PFNs anyway.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm/mm/dma-mapping.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 0f76222cbcbb..6b0095b84a58 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -104,25 +104,6 @@ static struct arm_dma_buffer *arm_dma_buffer_find(void *virt)
  *
  */
 
-#ifdef CONFIG_ARM_DMA_USE_IOMMU
-/*
- * Return whether the given device DMA address mask can be supported
- * properly.  For example, if your device can only drive the low 24-bits
- * during bus mastering, then you would pass 0x00ffffff as the mask
- * to this function.
- */
-static int arm_dma_supported(struct device *dev, u64 mask)
-{
-	unsigned long max_dma_pfn = min(max_pfn - 1, arm_dma_pfn_limit);
-
-	/*
-	 * Translate the device's DMA mask to a PFN limit.  This
-	 * PFN number includes the page which we can DMA to.
-	 */
-	return PHYS_PFN(dma_to_phys(dev, mask)) >= max_dma_pfn;
-}
-#endif
-
 static void __dma_clear_buffer(struct page *page, size_t size, int coherent_flag)
 {
 	/*
@@ -1681,8 +1662,6 @@ static const struct dma_map_ops iommu_ops = {
 
 	.map_resource		= arm_iommu_map_resource,
 	.unmap_resource		= arm_iommu_unmap_resource,
-
-	.dma_supported		= arm_dma_supported,
 };
 
 static const struct dma_map_ops iommu_coherent_ops = {
@@ -1699,8 +1678,6 @@ static const struct dma_map_ops iommu_coherent_ops = {
 
 	.map_resource	= arm_iommu_map_resource,
 	.unmap_resource	= arm_iommu_unmap_resource,
-
-	.dma_supported		= arm_dma_supported,
 };
 
 /**
-- 
2.35.3.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
