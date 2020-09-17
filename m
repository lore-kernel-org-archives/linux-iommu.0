Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF1AC43461
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 17:41:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866FC2137B
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 17:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W52KmyKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866FC2137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1ADB28755A;
	Thu, 17 Sep 2020 17:41:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1dkOyxA-V4fS; Thu, 17 Sep 2020 17:41:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 91D8F87546;
	Thu, 17 Sep 2020 17:41:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FC06C0888;
	Thu, 17 Sep 2020 17:41:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70BA0C0859
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 17:41:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 525682E10C
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 17:41:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5RszmZ9WH3zK for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 17:41:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id F2BE920404
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 17:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=KzFlskTtmrM7XbM2RHeFq/XrvDOcZp5iQ+zvN+xoZ6s=; b=W52KmyKfz6Yg3D0Gg5sOUVRhY6
 9YO2fXcc15UC2+ZB2tB1a0OE4cfo9DsFWP7/dS743uyXakYRhS1KIY3opHGbxQt+iLIdF6wvt2WtP
 LLz0yp5vyGE6FTYHWtp4ORfhbFh7EO7JQPux3AS+/zCdT0F8/GUZmhaNyWdj4k6BRIwfnFewGpgKs
 nMrx6f3O+9pRsKF9wBuEEgVYdWEmAhrDe76OJoWf3L6mY3oyBVMyPt+zNlZaxqln9B5i+OgP3qbYF
 ZkRP5uQO5bM2XVOxbcPsz4RCDpxE0XOPeTJZPAYeOBc+Oder4glvi+mKRSlECAkvSONOV8ILHN1Xk
 TAnZT62Q==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIxuD-0003Ny-D8; Thu, 17 Sep 2020 17:41:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>
Subject: [PATCH 3/4] ARM/dma-mapping: don't handle NULL devices in dma-direct.h
Date: Thu, 17 Sep 2020 19:32:28 +0200
Message-Id: <20200917173229.3311382-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917173229.3311382-1-hch@lst.de>
References: <20200917173229.3311382-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

The DMA API removed support for not passing in a device a long time
ago, so remove the NULL checks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/dma-direct.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/dma-direct.h b/arch/arm/include/asm/dma-direct.h
index 1f04a5e1c615de..84cb4e30658891 100644
--- a/arch/arm/include/asm/dma-direct.h
+++ b/arch/arm/include/asm/dma-direct.h
@@ -11,7 +11,7 @@
  */
 static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
 {
-	if (dev && dev->dma_range_map)
+	if (dev->dma_range_map)
 		pfn = PFN_DOWN(translate_phys_to_dma(dev, PFN_PHYS(pfn)));
 	return (dma_addr_t)__pfn_to_phys(pfn);
 }
@@ -20,16 +20,13 @@ static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
 {
 	unsigned long pfn = __phys_to_pfn(addr);
 
-	if (dev && dev->dma_range_map)
+	if (dev->dma_range_map)
 		pfn = PFN_DOWN(translate_dma_to_phys(dev, PFN_PHYS(pfn)));
 	return pfn;
 }
 
 static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 {
-	if (dev)
-		return pfn_to_dma(dev, virt_to_pfn(addr));
-
 	return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
 }
 
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
