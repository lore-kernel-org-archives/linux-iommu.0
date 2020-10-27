Return-Path: <SRS0=PKzM=EC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40241C55179
	for <iommu@archiver.kernel.org>; Tue, 27 Oct 2020 10:26:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF78A22283
	for <iommu@archiver.kernel.org>; Tue, 27 Oct 2020 10:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF78A22283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4F34A87258;
	Tue, 27 Oct 2020 10:26:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kX2YSXG0JUx7; Tue, 27 Oct 2020 10:26:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 678CE87253;
	Tue, 27 Oct 2020 10:26:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 504A5C088B;
	Tue, 27 Oct 2020 10:26:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B858C0051
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 10:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6F14286693
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 10:25:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DLH-SduLVbiG for <iommu@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 10:25:58 +0000 (UTC)
X-Greylist: delayed 00:07:05 by SQLgrey-1.7.6
Received: from ozlabs.ru (ozlabs.ru [107.174.27.60])
 by whitealder.osuosl.org (Postfix) with ESMTP id ECF2985DA0
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 10:25:57 +0000 (UTC)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id A3EA6AE80277;
 Tue, 27 Oct 2020 06:18:10 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v2 1/2] dma: Allow mixing bypass and normal IOMMU
 operation
Date: Tue, 27 Oct 2020 21:18:40 +1100
Message-Id: <20201027101841.96056-2-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027101841.96056-1-aik@ozlabs.ru>
References: <20201027101841.96056-1-aik@ozlabs.ru>
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

This adds another check for the bus limit to determine where bypass
can still work and we invoke direct DMA API; when DMA handle is outside
that limit, we fall back to DMA ops.

This adds a CONFIG_DMA_OPS_BYPASS_BUS_LIMIT config option which is off
by default and will be enable for PPC_PSERIES in the following patch.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 kernel/dma/mapping.c | 61 ++++++++++++++++++++++++++++++++++++++++++--
 kernel/dma/Kconfig   |  4 +++
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 51bb8fa8eb89..0f4f998e6c72 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -137,6 +137,18 @@ static inline bool dma_map_direct(struct device *dev,
 	return dma_go_direct(dev, *dev->dma_mask, ops);
 }
 
+#ifdef CONFIG_DMA_OPS_BYPASS_BUS_LIMIT
+static inline bool can_map_direct(struct device *dev, phys_addr_t addr)
+{
+	return dev->bus_dma_limit >= phys_to_dma(dev, addr);
+}
+
+static inline bool dma_handle_direct(struct device *dev, dma_addr_t dma_handle)
+{
+	return dma_handle >= dev->archdata.dma_offset;
+}
+#endif
+
 dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 		size_t offset, size_t size, enum dma_data_direction dir,
 		unsigned long attrs)
@@ -151,6 +163,11 @@ dma_addr_t dma_map_page_attrs(struct device *dev, struct page *page,
 
 	if (dma_map_direct(dev, ops))
 		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
+#ifdef CONFIG_DMA_OPS_BYPASS_BUS_LIMIT
+	else if (dev->bus_dma_limit &&
+		 can_map_direct(dev, (phys_addr_t) page_to_phys(page) + offset + size))
+		addr = dma_direct_map_page(dev, page, offset, size, dir, attrs);
+#endif
 	else
 		addr = ops->map_page(dev, page, offset, size, dir, attrs);
 	debug_dma_map_page(dev, page, offset, size, dir, addr);
@@ -167,6 +184,10 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
 	BUG_ON(!valid_dma_direction(dir));
 	if (dma_map_direct(dev, ops))
 		dma_direct_unmap_page(dev, addr, size, dir, attrs);
+#ifdef CONFIG_DMA_OPS_BYPASS_BUS_LIMIT
+	else if (dev->bus_dma_limit && dma_handle_direct(dev, addr + size))
+		dma_direct_unmap_page(dev, addr, size, dir, attrs);
+#endif
 	else if (ops->unmap_page)
 		ops->unmap_page(dev, addr, size, dir, attrs);
 	debug_dma_unmap_page(dev, addr, size, dir);
@@ -190,6 +211,23 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
 
 	if (dma_map_direct(dev, ops))
 		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
+#ifdef CONFIG_DMA_OPS_BYPASS_BUS_LIMIT
+	else if (dev->bus_dma_limit) {
+		struct scatterlist *s;
+		bool direct = true;
+		int i;
+
+		for_each_sg(sg, s, nents, i) {
+			direct = can_map_direct(dev, sg_phys(s) + s->offset + s->length);
+			if (!direct)
+				break;
+		}
+		if (direct)
+			ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
+		else
+			ents = ops->map_sg(dev, sg, nents, dir, attrs);
+	}
+#endif
 	else
 		ents = ops->map_sg(dev, sg, nents, dir, attrs);
 	BUG_ON(ents < 0);
@@ -207,9 +245,28 @@ void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
 
 	BUG_ON(!valid_dma_direction(dir));
 	debug_dma_unmap_sg(dev, sg, nents, dir);
-	if (dma_map_direct(dev, ops))
+	if (dma_map_direct(dev, ops)) {
 		dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
-	else if (ops->unmap_sg)
+		return;
+	}
+#ifdef CONFIG_DMA_OPS_BYPASS_BUS_LIMIT
+	if (dev->bus_dma_limit) {
+		struct scatterlist *s;
+		bool direct = true;
+		int i;
+
+		for_each_sg(sg, s, nents, i) {
+			direct = dma_handle_direct(dev, s->dma_address + s->length);
+			if (!direct)
+				break;
+		}
+		if (direct) {
+			dma_direct_unmap_sg(dev, sg, nents, dir, attrs);
+			return;
+		}
+	}
+#endif
+	if (ops->unmap_sg)
 		ops->unmap_sg(dev, sg, nents, dir, attrs);
 }
 EXPORT_SYMBOL(dma_unmap_sg_attrs);
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index c99de4a21458..02fa174fbdec 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -20,6 +20,10 @@ config DMA_OPS
 config DMA_OPS_BYPASS
 	bool
 
+# IOMMU driver limited by a DMA window size may switch between bypass and window
+config DMA_OPS_BYPASS_BUS_LIMIT
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
