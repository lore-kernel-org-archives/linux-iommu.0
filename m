Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D42C433EF
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 16:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 671AF8340C;
	Mon,  2 May 2022 16:43:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PRqmqpdQQujI; Mon,  2 May 2022 16:43:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5EA2983E39;
	Mon,  2 May 2022 16:43:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF743C002D;
	Mon,  2 May 2022 16:43:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7189CC0039
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:43:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A4C640A8D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:43:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ds2eBkZflAV for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 16:43:50 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C5F8440A79
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 16:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=F4i86N8Nb8bYFtZHyMJsf9nGP6no8/uhgRRcYTXlArQ=; b=Uwk8yq3nuhCPprtKTeExiBRxrv
 r3JOlDDh5F5KsGqszvSx6UN1xdDDCqdzny3+iV+ZZms358MH3NBbhxAvnbHdNIy7+gbC4V+/CFhuZ
 qlYabR4dRW5ZOUiN0wAHdFY/SnPeF7pB5hKC+fliY0ZwicEmfOjLb6MUEtxHCYq8wcLkZzgSuB+qS
 +x1IzJt72hc1GyRYqyprcPtPiCjhe5KuBDzN0W6nPoGSP6rbWgL/BVCzKNqeMlShQeqik+u1CNyS/
 NPXRRqpPAB+XOZiZMzdm4HhaBwZLbruHjUDVbbTWWGVv/nWDWnlgmCkYfzRYV3xvzO1/uHnWateiU
 wDFZMy+A==;
Received: from [8.34.116.185] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlZ94-001keL-J7; Mon, 02 May 2022 16:43:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 04/10] ARM/dma-mapping: remove the unused virt_to_dma helper
Date: Mon,  2 May 2022 09:43:24 -0700
Message-Id: <20220502164330.229685-5-hch@lst.de>
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

virt_to_dma was only used by the now removed dmabounce code.

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
