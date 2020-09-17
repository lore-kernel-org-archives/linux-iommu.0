Return-Path: <SRS0=xf59=C2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEB4C433E2
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 17:37:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6133220872
	for <iommu@archiver.kernel.org>; Thu, 17 Sep 2020 17:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jJ5sl2B4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6133220872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D456887851;
	Thu, 17 Sep 2020 17:37:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rw2-1C-GYaJT; Thu, 17 Sep 2020 17:36:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BE0618796F;
	Thu, 17 Sep 2020 17:36:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E69FC0888;
	Thu, 17 Sep 2020 17:36:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5DA2DC0859
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 17:36:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4F08F876B8
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 17:36:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ui9wVoWfjyUe for <iommu@lists.linux-foundation.org>;
 Thu, 17 Sep 2020 17:36:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 03EE787427
 for <iommu@lists.linux-foundation.org>; Thu, 17 Sep 2020 17:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=xTwmx2yvm3/8GxzEt2o6zYRVX1Gm2w1vvRxX22ySD8g=; b=jJ5sl2B4Y1iarDEtcZbARx6pnL
 KxXxurqGhLYZZJTIFUdPMLuCDsrfm+Q4e7XlIzImdAnJAgezEgIV+yTFZsY6GkgIbNzilu4ZdOL7n
 JT5lGpnhobxg63vdqU5BzaDFXlauSKLqGp9GKWGSaNRVHyPX9c1+67YALrTXFi5tDdYj5A0z1PMKc
 9ygpWvgwX/KXvwbDnWHR0ACkDxoslXUU0rMYozQGWld6y05aNEQUiy8OoMuNscWgca1OwlSGzxmzh
 BVVeyu+B9xdXlMVhyltVEoYr+R65+Gz+9TDPnCvmR8lmA0IvXQNhrHpIUAeMp8tGZROnOc8USFYNg
 4CjaQz/A==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIxpz-00034I-9S; Thu, 17 Sep 2020 17:36:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>
Subject: [PATCH 1/4] ARM/omap1: switch to use dma_direct_set_offset for lbus
 DMA offsets
Date: Thu, 17 Sep 2020 19:32:26 +0200
Message-Id: <20200917173229.3311382-2-hch@lst.de>
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

Switch the omap1510 platform ohci device to use dma_direct_set_offset
to set the DMA offset instead of using direct hooks into the DMA
mapping code and remove the now unused hooks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/dma-direct.h         | 18 -------------
 arch/arm/mach-omap1/include/mach/memory.h | 31 -----------------------
 arch/arm/mach-omap1/usb.c                 | 22 ++++++++++++++++
 3 files changed, 22 insertions(+), 49 deletions(-)

diff --git a/arch/arm/include/asm/dma-direct.h b/arch/arm/include/asm/dma-direct.h
index 436544aeb83405..77fcb7ee5ec907 100644
--- a/arch/arm/include/asm/dma-direct.h
+++ b/arch/arm/include/asm/dma-direct.h
@@ -9,7 +9,6 @@
  * functions used internally by the DMA-mapping API to provide DMA
  * addresses. They must not be used by drivers.
  */
-#ifndef __arch_pfn_to_dma
 static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
 {
 	if (dev && dev->dma_range_map)
@@ -34,23 +33,6 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 	return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
 }
 
-#else
-static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	return __arch_pfn_to_dma(dev, pfn);
-}
-
-static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
-{
-	return __arch_dma_to_pfn(dev, addr);
-}
-
-static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
-{
-	return __arch_virt_to_dma(dev, addr);
-}
-#endif
-
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	unsigned int offset = paddr & ~PAGE_MASK;
diff --git a/arch/arm/mach-omap1/include/mach/memory.h b/arch/arm/mach-omap1/include/mach/memory.h
index 1142560e0078f5..36bc0000cb6ab8 100644
--- a/arch/arm/mach-omap1/include/mach/memory.h
+++ b/arch/arm/mach-omap1/include/mach/memory.h
@@ -14,42 +14,11 @@
  * OMAP-1510 bus address is translated into a Local Bus address if the
  * OMAP bus type is lbus. We do the address translation based on the
  * device overriding the defaults used in the dma-mapping API.
- * Note that the is_lbus_device() test is not very efficient on 1510
- * because of the strncmp().
  */
-#if defined(CONFIG_ARCH_OMAP15XX) && !defined(__ASSEMBLER__)
 
 /*
  * OMAP-1510 Local Bus address offset
  */
 #define OMAP1510_LB_OFFSET	UL(0x30000000)
 
-#define virt_to_lbus(x)		((x) - PAGE_OFFSET + OMAP1510_LB_OFFSET)
-#define lbus_to_virt(x)		((x) - OMAP1510_LB_OFFSET + PAGE_OFFSET)
-#define is_lbus_device(dev)	(cpu_is_omap15xx() && dev && (strncmp(dev_name(dev), "ohci", 4) == 0))
-
-#define __arch_pfn_to_dma(dev, pfn)	\
-	({ dma_addr_t __dma = __pfn_to_phys(pfn); \
-	   if (is_lbus_device(dev)) \
-		__dma = __dma - PHYS_OFFSET + OMAP1510_LB_OFFSET; \
-	   __dma; })
-
-#define __arch_dma_to_pfn(dev, addr)	\
-	({ dma_addr_t __dma = addr;				\
-	   if (is_lbus_device(dev))				\
-		__dma += PHYS_OFFSET - OMAP1510_LB_OFFSET;	\
-	   __phys_to_pfn(__dma);				\
-	})
-
-#define __arch_dma_to_virt(dev, addr)	({ (void *) (is_lbus_device(dev) ? \
-						lbus_to_virt(addr) : \
-						__phys_to_virt(addr)); })
-
-#define __arch_virt_to_dma(dev, addr)	({ unsigned long __addr = (unsigned long)(addr); \
-					   (dma_addr_t) (is_lbus_device(dev) ? \
-						virt_to_lbus(__addr) : \
-						__virt_to_phys(__addr)); })
-
-#endif	/* CONFIG_ARCH_OMAP15XX */
-
 #endif
diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
index d8e9bbda8f7bdd..ba8566204ea9f4 100644
--- a/arch/arm/mach-omap1/usb.c
+++ b/arch/arm/mach-omap1/usb.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
 #include <linux/io.h>
 
 #include <asm/irq.h>
@@ -542,6 +543,25 @@ static u32 __init omap1_usb2_init(unsigned nwires, unsigned alt_pingroup)
 /* ULPD_APLL_CTRL */
 #define APLL_NDPLL_SWITCH	(1 << 0)
 
+static int omap_1510_usb_ohci_notifier(struct notifier_block *nb,
+		unsigned long event, void *data)
+{
+	struct device *dev = data;
+
+	if (event != BUS_NOTIFY_ADD_DEVICE)
+		return NOTIFY_DONE;
+
+	if (strncmp(dev_name(dev), "ohci", 4) == 0 &&
+	    dma_direct_set_offset(dev, PHYS_OFFSET, OMAP1510_LB_OFFSET,
+			(u64)-1))
+		WARN_ONCE(1, "failed to set DMA offset\n");
+	return NOTIFY_OK;
+}
+
+static struct notifier_block omap_1510_usb_ohci_nb = {
+	.notifier_call		= omap_1510_usb_ohci_notifier,
+};
+
 static void __init omap_1510_usb_init(struct omap_usb_config *config)
 {
 	unsigned int val;
@@ -600,6 +620,8 @@ static void __init omap_1510_usb_init(struct omap_usb_config *config)
 	if (config->register_host) {
 		int status;
 
+		bus_register_notifier(&platform_bus_type,
+				      &omap_1510_usb_ohci_nb);
 		ohci_device.dev.platform_data = config;
 		status = platform_device_register(&ohci_device);
 		if (status)
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
