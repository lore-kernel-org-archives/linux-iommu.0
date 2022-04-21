Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A527C433EF
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 07:42:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1BAC41BB8;
	Thu, 21 Apr 2022 07:42:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z4mXAje-A3PG; Thu, 21 Apr 2022 07:42:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5B3A341B77;
	Thu, 21 Apr 2022 07:42:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34592C0033;
	Thu, 21 Apr 2022 07:42:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE355C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 07:42:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A7D8B408A6
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 07:42:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C5-oYygMYtRH for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 07:42:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C323540913
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 07:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=dOLgH0j7aIAvSNqqrH+sQ+MxAuxdQq5ytthuFPHbJcQ=; b=Adact85ROgkBf/Q5tCsPUYKTh3
 xfaI04wFywH6p9OXEUwdOCLZ8UL8MOprtdIE9cU6c05ysoqZeDSIkuJ9VqC82/hWgceTXfwT/ittq
 NQhMvZLjp3/eFv7jWqOuby3IxiJndidbGn3k9nxtieDOROIzgZyYINu61u+jtFEB4ALfRShrp6brA
 efh/gGFLrSo1BwDIaklTww1PqoZrvLMUcjnLvph8hJMP330ZO5NZIoQlqkJIMbJrk0FprxUt7IJXs
 NS/f3x7evl6H3PreKNxvQtkNUBbGxnAm13dKTo19/yBxbKed3hbQ5gcK9uw+CCtt/yV2ikRm5J0ME
 ix1rzBWA==;
Received: from [2001:4bb8:191:364b:7b50:153f:5622:82f7] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nhRSK-00C7a2-6c; Thu, 21 Apr 2022 07:42:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH 6/7] ARM: use the common dma_to_phys/phys_to_dma
 implementation where possible
Date: Thu, 21 Apr 2022 09:42:03 +0200
Message-Id: <20220421074204.1284072-7-hch@lst.de>
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

Only the footbridge platforms provide their own DMA address translation
helpers, so switch to the generic version for all other platforms, and
consolidate the footbridge implementation to remove two levels of
indirection.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/Kconfig                              |  1 -
 arch/arm/include/asm/dma-direct.h             | 41 +------------------
 arch/arm/include/asm/memory.h                 |  2 -
 arch/arm/mach-footbridge/Kconfig              |  1 +
 arch/arm/mach-footbridge/common.c             | 19 +++++----
 .../mach-footbridge/include/mach/dma-direct.h |  8 ++++
 .../arm/mach-footbridge/include/mach/memory.h |  4 --
 7 files changed, 21 insertions(+), 55 deletions(-)
 create mode 100644 arch/arm/mach-footbridge/include/mach/dma-direct.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2e8091e2d8a86..ac2e3e4957d66 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -15,7 +15,6 @@ config ARM
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
-	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
diff --git a/arch/arm/include/asm/dma-direct.h b/arch/arm/include/asm/dma-direct.h
index 6fd52713b5d12..4f7bcde03abb5 100644
--- a/arch/arm/include/asm/dma-direct.h
+++ b/arch/arm/include/asm/dma-direct.h
@@ -1,40 +1 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef ASM_ARM_DMA_DIRECT_H
-#define ASM_ARM_DMA_DIRECT_H 1
-
-#include <asm/memory.h>
-
-/*
- * dma_to_pfn/pfn_to_dma are architecture private
- * functions used internally by the DMA-mapping API to provide DMA
- * addresses. They must not be used by drivers.
- */
-static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	if (dev && dev->dma_range_map)
-		pfn = PFN_DOWN(translate_phys_to_dma(dev, PFN_PHYS(pfn)));
-	return (dma_addr_t)__pfn_to_bus(pfn);
-}
-
-static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
-{
-	unsigned long pfn = __bus_to_pfn(addr);
-
-	if (dev && dev->dma_range_map)
-		pfn = PFN_DOWN(translate_dma_to_phys(dev, PFN_PHYS(pfn)));
-	return pfn;
-}
-
-static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
-{
-	unsigned int offset = paddr & ~PAGE_MASK;
-	return pfn_to_dma(dev, __phys_to_pfn(paddr)) + offset;
-}
-
-static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
-{
-	unsigned int offset = dev_addr & ~PAGE_MASK;
-	return __pfn_to_phys(dma_to_pfn(dev, dev_addr)) + offset;
-}
-
-#endif /* ASM_ARM_DMA_DIRECT_H */
+#include <mach/dma-direct.h>
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index f673e13e0f942..a55a9038abc89 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -378,8 +378,6 @@ static inline unsigned long __virt_to_idmap(unsigned long x)
 #ifndef __virt_to_bus
 #define __virt_to_bus	__virt_to_phys
 #define __bus_to_virt	__phys_to_virt
-#define __pfn_to_bus(x)	__pfn_to_phys(x)
-#define __bus_to_pfn(x)	__phys_to_pfn(x)
 #endif
 
 /*
diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index 728aff93fba9d..b5bbdcf2e4896 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -60,6 +60,7 @@ endmenu
 
 # Footbridge support
 config FOOTBRIDGE
+	select ARCH_HAS_PHYS_TO_DMA
 	bool
 
 # Footbridge in host mode
diff --git a/arch/arm/mach-footbridge/common.c b/arch/arm/mach-footbridge/common.c
index 322495df271d5..5020eb96b025d 100644
--- a/arch/arm/mach-footbridge/common.c
+++ b/arch/arm/mach-footbridge/common.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/spinlock.h>
+#include <linux/dma-direct.h>
 #include <video/vga.h>
 
 #include <asm/page.h>
@@ -335,17 +336,19 @@ unsigned long __bus_to_virt(unsigned long res)
 	return res;
 }
 EXPORT_SYMBOL(__bus_to_virt);
-
-unsigned long __pfn_to_bus(unsigned long pfn)
+#else
+static inline unsigned long fb_bus_sdram_offset(void)
 {
-	return __pfn_to_phys(pfn) + (fb_bus_sdram_offset() - PHYS_OFFSET);
+	return BUS_OFFSET;
 }
-EXPORT_SYMBOL(__pfn_to_bus);
+#endif /* CONFIG_FOOTBRIDGE_ADDIN */
 
-unsigned long __bus_to_pfn(unsigned long bus)
+dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	return __phys_to_pfn(bus - (fb_bus_sdram_offset() - PHYS_OFFSET));
+	return paddr + (fb_bus_sdram_offset() - PHYS_OFFSET);
 }
-EXPORT_SYMBOL(__bus_to_pfn);
 
-#endif
+phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr)
+{
+	return dev_addr - (fb_bus_sdram_offset() - PHYS_OFFSET);
+}
diff --git a/arch/arm/mach-footbridge/include/mach/dma-direct.h b/arch/arm/mach-footbridge/include/mach/dma-direct.h
new file mode 100644
index 0000000000000..01f9e8367c009
--- /dev/null
+++ b/arch/arm/mach-footbridge/include/mach/dma-direct.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef MACH_FOOTBRIDGE_DMA_DIRECT_H
+#define MACH_FOOTBRIDGE_DMA_DIRECT_H 1
+
+dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
+phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dev_addr);
+
+#endif /* MACH_FOOTBRIDGE_DMA_DIRECT_H */
diff --git a/arch/arm/mach-footbridge/include/mach/memory.h b/arch/arm/mach-footbridge/include/mach/memory.h
index 46fd4a8872b9a..3a5d2638c18f8 100644
--- a/arch/arm/mach-footbridge/include/mach/memory.h
+++ b/arch/arm/mach-footbridge/include/mach/memory.h
@@ -26,8 +26,6 @@
 #ifndef __ASSEMBLY__
 extern unsigned long __virt_to_bus(unsigned long);
 extern unsigned long __bus_to_virt(unsigned long);
-extern unsigned long __pfn_to_bus(unsigned long);
-extern unsigned long __bus_to_pfn(unsigned long);
 #endif
 #define __virt_to_bus	__virt_to_bus
 #define __bus_to_virt	__bus_to_virt
@@ -42,8 +40,6 @@ extern unsigned long __bus_to_pfn(unsigned long);
 #define BUS_OFFSET		0xe0000000
 #define __virt_to_bus(x)	((x) + (BUS_OFFSET - PAGE_OFFSET))
 #define __bus_to_virt(x)	((x) - (BUS_OFFSET - PAGE_OFFSET))
-#define __pfn_to_bus(x)		(__pfn_to_phys(x) + (BUS_OFFSET - PHYS_OFFSET))
-#define __bus_to_pfn(x)		__phys_to_pfn((x) - (BUS_OFFSET - PHYS_OFFSET))
 
 #else
 
-- 
2.30.2

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
