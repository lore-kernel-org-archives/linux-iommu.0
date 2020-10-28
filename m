Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F75C55178
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 07:00:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D2A9239D2
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 07:00:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D2A9239D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B2B648743A;
	Wed, 28 Oct 2020 07:00:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NK7blNl1sxAf; Wed, 28 Oct 2020 07:00:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 275FE87403;
	Wed, 28 Oct 2020 07:00:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20576C088B;
	Wed, 28 Oct 2020 07:00:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 95AC6C0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 07:00:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 906168741C
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 07:00:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ttFrcMbHOLWO for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 07:00:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ozlabs.ru (ozlabs.ru [107.174.27.60])
 by hemlock.osuosl.org (Postfix) with ESMTP id 40840871DB
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 07:00:38 +0000 (UTC)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 463BCAE80275;
 Wed, 28 Oct 2020 02:59:54 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v3 1/2] dma: Allow mixing bypass and mapped DMA
 operation
Date: Wed, 28 Oct 2020 18:00:29 +1100
Message-Id: <20201028070030.60643-2-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028070030.60643-1-aik@ozlabs.ru>
References: <20201028070030.60643-1-aik@ozlabs.ru>
Cc: Michael Ellerman <mpe@ellerman.id.au>, iommu@lists.linux-foundation.org,
 Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

At the moment we allow bypassing DMA ops only when we can do this for
the entire RAM. However there are configs with mixed type memory
where we could still allow bypassing IOMMU in most cases;
POWERPC with persistent memory is one example.

This adds an arch hook to determine where bypass can still work and
we invoke direct DMA API. The following patch checks the bus limit
on POWERPC to allow or disallow direct mapping.

This adds a CONFIG_ARCH_HAS_DMA_SET_MASK config option to make arch_xxxx
hooks no-op by default.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 kernel/dma/mapping.c | 24 ++++++++++++++++++++----
 kernel/dma/Kconfig   |  4 ++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 51bb8fa8eb89..a0bc9eb876ed 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -137,6 +137,18 @@ static inline bool dma_map_direct(struct device *dev,
 	return dma_go_direct(dev, *dev->dma_mask, ops);
 }
 
+#ifdef CONFIG_ARCH_HAS_DMA_MAP_DIRECT
+bool arch_dma_map_page_direct(struct device *dev, phys_addr_t addr);
+bool arch_dma_unmap_page_direct(struct device *dev, dma_addr_t dma_handle);
+bool arch_dma_map_sg_direct(struct device *dev, struct scatterlist *sg, int nents);
+bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg, int nents);
+#else
+#define arch_dma_map_page_direct(d, a) (0)
+#define arch_dma_unmap_page_direct(d, a) (0)
+#define arch_dma_map_sg_direct(d, s, n) (0)
+#define arch_dma_unmap_sg_direct(d, s, n) (0)
+#endif
+
 dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		size_t offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
@@ -149,7 +161,8 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 	if (WARN_ON_ONCE(!dev->dma_mask))
 		return DMA_MAPPING_ERROR;
 
-	if (dma_map_direct(dev, ops))
+	if (dma_map_direct(dev, ops) ||
+	    arch_dma_map_page_direct(dev, page_to_phys(page) + offset + size))
 		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
 	else
 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
@@ -165,7 +178,8 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 	const struct dma_map_ops *ops = get_dma_ops(dev);
 
 	BUG_ON(!valid_dma_direction(dir));
-	if (dma_map_direct(dev, ops))
+	if (dma_map_direct(dev, ops) ||
+	    arch_dma_unmap_page_direct(dev, addr + size))
 		dma_direct_unmap_page(dev, addr, size, dir, attrs);
 	else if (ops->unmap_page)
 		ops->unmap_page(dev, addr, size, dir, attrs);
@@ -188,7 +202,8 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
 	if (WARN_ON_ONCE(!dev->dma_mask))
 		return 0;
 
-	if (dma_map_direct(dev, ops))
+	if (dma_map_direct(dev, ops) ||
+	    arch_dma_map_sg_direct(dev, sg, nents))
 		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
 	else
 		ents = ops->map_sg(dev, sg, nents, dir, attrs);
@@ -207,7 +222,8 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 
 	BUG_ON(!valid_dma_direction(dir));
 	debug_dma_unmap_sg(dev, sg, nents, dir);
-	if (dma_map_direct(dev, ops))
+	if (dma_map_direct(dev, ops) ||
+	    arch_dma_unmap_sg_direct(dev, sg, nents))
 		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
 	else if (ops->unmap_sg)
 		ops->unmap_sg(dev, sg, nents, dir, attrs);
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index c99de4a21458..43d106598e82 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -20,6 +20,10 @@ config DMA_OPS
 config DMA_OPS_BYPASS
 	bool
 
+# Lets platform IOMMU driver choose between bypass and IOMMU
+config ARCH_HAS_DMA_MAP_DIRECT
+	bool
+
 config NEED_SG_DMA_LENGTH
 	bool
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
