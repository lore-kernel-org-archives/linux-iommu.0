Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62729C4332F
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 16:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 194AF60F5E;
	Mon,  2 May 2022 16:43:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qmBIdoMtcoat; Mon,  2 May 2022 16:43:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E427560F47;
	Mon,  2 May 2022 16:43:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72E22C007F;
	Mon,  2 May 2022 16:43:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFE5FC0084
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5F94740A90
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:43:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Urx8uasMzHnd for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 16:43:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5ADEB40133
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=cZaNmyA5wUJ1C28stjNbm+l6w8z51K+/m7PND4lK+88=; b=nwYcpRVoU+eYIdeAaVQw3FQw3Z
 ji1Zd+u30eNLLR2pXWT726Ec9iPdOYY+OOAM+AmJ4md2ka60o8HvD6xIyxqvbIcoFcpMcohULqEbJ
 nv2MOjb0Lo7Cpj0ciZFCqFPbl2d2AjCk1+smg94HyXDqhICEiV4Y0kdY9DOE565RpPaBGPVJLDUTw
 2frLTJBf9t/QKKopXGznCkChsydW2y+kFwkdc7M149xr0oiUh7oQZvdXFhGj3VVsjb6IstHaeiFiv
 ai56Odxu9pkI+21qleyBiKEvHnqFDxMlpIDHG+DidUFnR90av7+kzjFy7e1Wqdnxhxs/7xU6f9uXk
 AJft8n/w==;
Received: from [8.34.116.185] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlZ99-001kgW-FN; Mon, 02 May 2022 16:43:39 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 10/10] ARM/dma-mapping: merge IOMMU ops
Date: Mon,  2 May 2022 09:43:30 -0700
Message-Id: <20220502164330.229685-11-hch@lst.de>
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

The dma_sync_* operations are now the only difference between the
coherent and non-coherent IOMMU ops. Some minor tweaks to make those
safe for coherent devices with minimal overhead, and we can condense
down to a single set of DMA ops.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mm/dma-mapping.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 10e5e5800d784..dd46cce61579a 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1341,6 +1341,9 @@ static void arm_iommu_sync_sg_for_cpu(struct device *dev,
 	struct scatterlist *s;
 	int i;
 
+	if (dev->dma_coherent)
+		return;
+
 	for_each_sg(sg, s, nents, i)
 		__dma_page_dev_to_cpu(sg_page(s), s->offset, s->length, dir);
 
@@ -1360,6 +1363,9 @@ static void arm_iommu_sync_sg_for_device(struct device *dev,
 	struct scatterlist *s;
 	int i;
 
+	if (dev->dma_coherent)
+		return;
+
 	for_each_sg(sg, s, nents, i)
 		__dma_page_cpu_to_dev(sg_page(s), s->offset, s->length, dir);
 }
@@ -1493,12 +1499,13 @@ static void arm_iommu_sync_single_for_cpu(struct device *dev,
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
-	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
+	struct page *page;
 	unsigned int offset = handle & ~PAGE_MASK;
 
-	if (!iova)
+	if (dev->dma_coherent || !iova)
 		return;
 
+	page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
 	__dma_page_dev_to_cpu(page, offset, size, dir);
 }
 
@@ -1507,12 +1514,13 @@ static void arm_iommu_sync_single_for_device(struct device *dev,
 {
 	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
 	dma_addr_t iova = handle & PAGE_MASK;
-	struct page *page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
+	struct page *page;
 	unsigned int offset = handle & ~PAGE_MASK;
 
-	if (!iova)
+	if (dev->dma_coherent || !iova)
 		return;
 
+	page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
 	__dma_page_cpu_to_dev(page, offset, size, dir);
 }
 
@@ -1536,22 +1544,6 @@ static const struct dma_map_ops iommu_ops = {
 	.unmap_resource		= arm_iommu_unmap_resource,
 };
 
-static const struct dma_map_ops iommu_coherent_ops = {
-	.alloc		= arm_iommu_alloc_attrs,
-	.free		= arm_iommu_free_attrs,
-	.mmap		= arm_iommu_mmap_attrs,
-	.get_sgtable	= arm_iommu_get_sgtable,
-
-	.map_page	= arm_iommu_map_page,
-	.unmap_page	= arm_iommu_unmap_page,
-
-	.map_sg		= arm_iommu_map_sg,
-	.unmap_sg	= arm_iommu_unmap_sg,
-
-	.map_resource	= arm_iommu_map_resource,
-	.unmap_resource	= arm_iommu_unmap_resource,
-};
-
 /**
  * arm_iommu_create_mapping
  * @bus: pointer to the bus holding the client device (for IOMMU calls)
@@ -1750,10 +1742,7 @@ static void arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		return;
 	}
 
-	if (coherent)
-		set_dma_ops(dev, &iommu_coherent_ops);
-	else
-		set_dma_ops(dev, &iommu_ops);
+	set_dma_ops(dev, &iommu_ops);
 }
 
 static void arm_teardown_iommu_dma_ops(struct device *dev)
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
