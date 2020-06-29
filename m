Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF4FC433DF
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 13:04:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545E423D4E
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 13:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NJadWazr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545E423D4E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 443CF893A2;
	Mon, 29 Jun 2020 13:04:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UCm98eWBfvSU; Mon, 29 Jun 2020 13:04:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id BB1738883F;
	Mon, 29 Jun 2020 13:04:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6DFAC0865;
	Mon, 29 Jun 2020 13:04:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29C98C016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 13:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0E7E220472
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 13:04:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 80twZrELBRm3 for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 13:04:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id 602E12262E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 13:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=3zpdI8UmwBB+KQo6imlBDm+KZhNuWD0HZ+7/RXg0Qeo=; b=NJadWazrl8uT+evvJdr4n8PtH2
 nN4b5x1zFCfERhYewoAOFG4wWd05hgltRhZJ0RGPRTXLipdAAzLtI8PU9/BoDctoMat+0tzS0xzFQ
 TD793hEyiDS8nNPtuOmVPI07LqkXURV44OS9OVYTMC0afYGlKfdBTtgOeHix3ULRykZOMaA2KOmCH
 TBkXODizBHR/Whz0vP73PdKkyl66g0m6sjBpYr7cfhODudFhNyJpn4/dV5gAY+bX++GifzTFMWF0m
 S/U6RvBOjEB/pHXtjc5GMOf2jTKtkMhUVXhrdnnFbCdWNy27QVeyacAys15VwZtdrpUlgF4iREWq1
 Ea+R8kNw==;
Received: from [2001:4bb8:184:76e3:c71:f334:376b:cf5f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jptSB-0004Xt-ER; Mon, 29 Jun 2020 13:04:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>
Subject: [PATCH 4/4] xsk: use dma_need_sync instead of reimplenting it
Date: Mon, 29 Jun 2020 15:03:59 +0200
Message-Id: <20200629130359.2690853-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629130359.2690853-1-hch@lst.de>
References: <20200629130359.2690853-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jonathan Lemon <jonathan.lemon@gmail.com>,
 bpf@vger.kernel.org, Magnus Karlsson <magnus.karlsson@intel.com>
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

Use the dma_need_sync helper instead of (not always entirely correctly)
poking into the dma-mapping internals.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/xdp/xsk_buff_pool.c | 50 +++--------------------------------------
 1 file changed, 3 insertions(+), 47 deletions(-)

diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 6733e2c59e4835..08b80669f64955 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -2,9 +2,6 @@
 
 #include <net/xsk_buff_pool.h>
 #include <net/xdp_sock.h>
-#include <linux/dma-direct.h>
-#include <linux/dma-noncoherent.h>
-#include <linux/swiotlb.h>
 
 #include "xsk_queue.h"
 
@@ -124,48 +121,6 @@ static void xp_check_dma_contiguity(struct xsk_buff_pool *pool)
 	}
 }
 
-static bool __maybe_unused xp_check_swiotlb_dma(struct xsk_buff_pool *pool)
-{
-#if defined(CONFIG_SWIOTLB)
-	phys_addr_t paddr;
-	u32 i;
-
-	for (i = 0; i < pool->dma_pages_cnt; i++) {
-		paddr = dma_to_phys(pool->dev, pool->dma_pages[i]);
-		if (is_swiotlb_buffer(paddr))
-			return false;
-	}
-#endif
-	return true;
-}
-
-static bool xp_check_cheap_dma(struct xsk_buff_pool *pool)
-{
-#if defined(CONFIG_HAS_DMA)
-	const struct dma_map_ops *ops = get_dma_ops(pool->dev);
-
-	if (ops) {
-		return !ops->sync_single_for_cpu &&
-			!ops->sync_single_for_device;
-	}
-
-	if (!dma_is_direct(ops))
-		return false;
-
-	if (!xp_check_swiotlb_dma(pool))
-		return false;
-
-	if (!dev_is_dma_coherent(pool->dev)) {
-#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) ||		\
-	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL) ||	\
-	defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE)
-		return false;
-#endif
-	}
-#endif
-	return true;
-}
-
 int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
 	       unsigned long attrs, struct page **pages, u32 nr_pages)
 {
@@ -179,6 +134,7 @@ int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
 
 	pool->dev = dev;
 	pool->dma_pages_cnt = nr_pages;
+	pool->dma_need_sync = false;
 
 	for (i = 0; i < pool->dma_pages_cnt; i++) {
 		dma = dma_map_page_attrs(dev, pages[i], 0, PAGE_SIZE,
@@ -187,13 +143,13 @@ int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
 			xp_dma_unmap(pool, attrs);
 			return -ENOMEM;
 		}
+		if (dma_need_sync(dev, dma))
+			pool->dma_need_sync = true;
 		pool->dma_pages[i] = dma;
 	}
 
 	if (pool->unaligned)
 		xp_check_dma_contiguity(pool);
-
-	pool->dma_need_sync = !xp_check_cheap_dma(pool);
 	return 0;
 }
 EXPORT_SYMBOL(xp_dma_map);
-- 
2.26.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
