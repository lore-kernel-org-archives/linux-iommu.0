Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D45C433E2
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 07:40:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06FE021D24
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 07:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V9WRKrWM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FE021D24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 727C48545B;
	Mon, 14 Sep 2020 07:40:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OX7ke7UyWJ4a; Mon, 14 Sep 2020 07:40:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E52B4820DA;
	Mon, 14 Sep 2020 07:40:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB53FC088B;
	Mon, 14 Sep 2020 07:40:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4A7CC0859
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 07:40:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8994C20336
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 07:40:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1wbQ87S-LzNm for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 07:40:19 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by silver.osuosl.org (Postfix) with ESMTPS id 1E2E72010D
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 07:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=m2uI/54b6zhcK5JH2Qkk+DNhltSMOgJF9o6JCspd/6M=; b=V9WRKrWMbS/Pw5aOnQOrYjrdVI
 ZbvSca4rQofspafvq5fqw7JXd5Alt/v7rsNdTXCZuY41+QJPockPjspbkuctRZgBXGxqJuKWxEn4O
 Ad/mMESvpm6ndMm7D+bJOh1j44XyiCz5nFHdE4r1X2e3kPuqp3ps2fiQIx4r8dOLOgC0oBa6pcQ3D
 3smyizrG3e4oGEmRhzG1djOB0eHWYcjkINxaKZaK7CRXaPGyDu8fvsPRJYtUyo8eImRwq0uofrb0M
 A6iW3pGZDYLiNQGRBD1uMqEGXXzUZ5kR7YhMUkpxeIbCiL8LywRq72ebHPHto7OwcercW2QuyJWA4
 pK0DXiUQ==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHj60-0000Ds-AY; Mon, 14 Sep 2020 07:40:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/6] ARM/dma-mapping: remove dma_to_virt
Date: Mon, 14 Sep 2020 09:33:39 +0200
Message-Id: <20200914073343.1579578-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914073343.1579578-1-hch@lst.de>
References: <20200914073343.1579578-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Ohad Ben-Cohen <ohad@wizery.com>, devicetree@vger.kernel.org,
 Florian Fainelli <f.fainelli@gmail.com>, linux-sh@vger.kernel.org,
 Frank Rowand <frowand.list@gmail.com>, linux-usb@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
 Nathan Chancellor <natechancellor@gmail.com>,
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

dma_to_virt is entirely unused, remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/dma-mapping.h        | 18 +-----------------
 arch/arm/mach-omap1/include/mach/memory.h |  4 ----
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 70d95677656044..cf2535fb8891f5 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -24,7 +24,7 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 }
 
 /*
- * dma_to_pfn/pfn_to_dma/dma_to_virt/virt_to_dma are architecture private
+ * dma_to_pfn/pfn_to_dma/virt_to_dma are architecture private
  * functions used internally by the DMA-mapping API to provide DMA
  * addresses. They must not be used by drivers.
  */
@@ -46,17 +46,6 @@ static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
 	return pfn;
 }
 
-static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
-{
-	if (dev) {
-		unsigned long pfn = dma_to_pfn(dev, addr);
-
-		return phys_to_virt(__pfn_to_phys(pfn));
-	}
-
-	return (void *)__bus_to_virt((unsigned long)addr);
-}
-
 static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 {
 	if (dev)
@@ -76,11 +65,6 @@ static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
 	return __arch_dma_to_pfn(dev, addr);
 }
 
-static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
-{
-	return __arch_dma_to_virt(dev, addr);
-}
-
 static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 {
 	return __arch_virt_to_dma(dev, addr);
diff --git a/arch/arm/mach-omap1/include/mach/memory.h b/arch/arm/mach-omap1/include/mach/memory.h
index 1142560e0078f5..e43697c3297bf2 100644
--- a/arch/arm/mach-omap1/include/mach/memory.h
+++ b/arch/arm/mach-omap1/include/mach/memory.h
@@ -41,10 +41,6 @@
 	   __phys_to_pfn(__dma);				\
 	})
 
-#define __arch_dma_to_virt(dev, addr)	({ (void *) (is_lbus_device(dev) ? \
-						lbus_to_virt(addr) : \
-						__phys_to_virt(addr)); })
-
 #define __arch_virt_to_dma(dev, addr)	({ unsigned long __addr = (unsigned long)(addr); \
 					   (dma_addr_t) (is_lbus_device(dev) ? \
 						virt_to_lbus(__addr) : \
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
