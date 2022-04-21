Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF05C4167B
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 07:42:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF03A41B84;
	Thu, 21 Apr 2022 07:42:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BGexl82AmICD; Thu, 21 Apr 2022 07:42:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6CC3341B76;
	Thu, 21 Apr 2022 07:42:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 407F0C0033;
	Thu, 21 Apr 2022 07:42:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA740C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 07:42:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8E854400E5
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 07:42:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 04PsGnVMFP2e for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 07:42:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A1211405C2
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 07:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=B6bUxdK604oMD6IGwRtm3YqcJPw1O1IDlWY25cO5q1Q=; b=J5mWjZNeN3gDIhoMu7QxrZ4R0Y
 UdP+c+b5ibwoOLeK2pKeV+tvv3PWiP5g1GeTv4uP9IN1L2NnTQQpLUZvcagx4gb05i4GB6Ceu/BUq
 zTaaCf9SrNLtADst331hjGNi9saB/qWNKlNcb9GLXcAZpbg6b+iuEKg5MDCL+tbHsGERa6TlkIxy0
 5G+6ig4GvkUJwqKq6qT2Bzh7biQuVzPKZZ8W1wZ7inGxqgtbGXoZWWFUooKvSU+UZbIUt5705ri3T
 t8TctdwahEKw6soNlpESQG3f86LSnfATUf+DOlcJrb46CXT7q7QNNqaeV67fTQRnPhIgJPGL+QJIH
 B7C6safw==;
Received: from [2001:4bb8:191:364b:7b50:153f:5622:82f7] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhRSE-00C7Wr-CV; Thu, 21 Apr 2022 07:42:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 4/7] ARM: remove the unused virt_to_dma helper
Date: Thu, 21 Apr 2022 09:42:01 +0200
Message-Id: <20220421074204.1284072-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220421074204.1284072-1-hch@lst.de>
References: <20220421074204.1284072-1-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/dma-direct.h | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/dma-direct.h b/arch/arm/include/asm/dma-direct.h
index 77fcb7ee5ec90..6fd52713b5d12 100644
--- a/arch/arm/include/asm/dma-direct.h
+++ b/arch/arm/include/asm/dma-direct.h
@@ -5,7 +5,7 @@
 #include <asm/memory.h>
 
 /*
- * dma_to_pfn/pfn_to_dma/virt_to_dma are architecture private
+ * dma_to_pfn/pfn_to_dma are architecture private
  * functions used internally by the DMA-mapping API to provide DMA
  * addresses. They must not be used by drivers.
  */
@@ -25,14 +25,6 @@ static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
 	return pfn;
 }
 
-static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
-{
-	if (dev)
-		return pfn_to_dma(dev, virt_to_pfn(addr));
-
-	return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
-}
-
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	unsigned int offset = paddr & ~PAGE_MASK;
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
