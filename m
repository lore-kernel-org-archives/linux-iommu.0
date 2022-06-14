Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C2FCCA47C
	for <iommu@archiver.kernel.org>; Tue, 14 Jun 2022 09:21:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AEA5D40A01;
	Tue, 14 Jun 2022 09:21:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aYpzcwSdkK54; Tue, 14 Jun 2022 09:21:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 91B9E401A2;
	Tue, 14 Jun 2022 09:21:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E204C0032;
	Tue, 14 Jun 2022 09:21:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 99534C002D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 09:21:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7594F82C5E
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 09:21:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FgG4dOUURr2o for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jun 2022 09:21:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE82D82BF4
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jun 2022 09:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=xvhbBJhULwcSTCX2LQgOhY6hVQNYWx3xEqylfnNwsR8=; b=A7OlzOM9cbfkwjlmAAPe5Aa2M3
 oNQkIgk4pOc5VgoKvygadWlqgPPInU/T72IlnBjQ0YONSvVAlfXSbJk9Vk9PNwUisydNy7h2UwCcF
 nSIDEH8u+cPqEyjGijnfvrIoYeiOKc5syKzsF1lszUpDmdX3xw7GI8INLYpPpzncFuM2r4UtrIvO4
 76wCJKBFBWngPd303NHpYkUiOCttYpJdtc6rLV7h7rjHG1QbdSbNlokXb4hOhvN7LyppY4F3pykn+
 /+AQUFOSelHz/moEqeeN1P07KbymCDq9JvV5GOLbt0dOvf5zdFw6PFqiAZoMeArpXRy9UylYPkoJs
 HcM9GN/A==;
Received: from [2001:4bb8:180:36f6:1fed:6d48:cf16:d13c] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1o12jZ-008fR7-SO; Tue, 14 Jun 2022 09:21:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 08/10] ARM/dma-mapping: drop .dma_supported for IOMMU ops
Date: Tue, 14 Jun 2022 11:20:45 +0200
Message-Id: <20220614092047.572235-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220614092047.572235-1-hch@lst.de>
References: <20220614092047.572235-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Andrew Lunn <andrew@lunn.ch>, Marc Zyngier <maz@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>,
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

When an IOMMU is present, we trust that it should be capable
of remapping any physical memory, and since the device masks
represent the input (virtual) addresses to the IOMMU it makes
no sense to validate them against physical PFNs anyway.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm/mm/dma-mapping.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ceb56928d01ec..4055f2dc2859e 100644
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
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
