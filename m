Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8501FC43461
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 05:40:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76FEE20809
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 05:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g3AubYaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76FEE20809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 110388764E;
	Thu, 10 Sep 2020 05:40:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kncgKtA2tw3A; Thu, 10 Sep 2020 05:40:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 427CE8764F;
	Thu, 10 Sep 2020 05:40:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3284CC0893;
	Thu, 10 Sep 2020 05:40:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5077FC0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 05:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3B1D18764E
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 05:40:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aagG1ucsBFLQ for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 05:40:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8F6708764C
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 05:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=AejDhfpStRmmAUITPY0SPUzsCVthQd7GlxM8LC74OlI=; b=g3AubYaE2IhosN7e0K+4N1KmwV
 rn4GxoQidptH+3MNhEENY+wWyzzvNKETWx5Q/0/QGMv+7FS67wwit5aQiZlqB7mdP4JcSIaWzpv4o
 1o9BkbTfoYw/PMuvyXSFa8g1z8Fw7uLccQf/DRZ8N4f9GsFi1R5Ed7mJVOdBvUw6yKfvigGshALqz
 Wc3F1UcFwneAHHMVXl2vaazHsvlovTvZnzAecOPy/3zJNq8AW2E1FNRmE2L+lmuf7Mlw8VH2rBgHZ
 gRZTQZKNzhISOjQ77Er3VlfsGXclqV7O5f/zDILi7qW5cTzM6VkETrAA3D27fBGoFfAVw5POCEOMg
 2TAailxQ==;
Received: from [2001:4bb8:184:af1:d8d0:3027:a666:4c4e] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGFK4-0001tP-AL; Thu, 10 Sep 2020 05:40:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>,
 Santosh Shilimkar <ssantosh@kernel.org>
Subject: [PATCH 1/3] ARM/dma-mapping: move various helpers from dma-mapping.h
 to dma-direct.h
Date: Thu, 10 Sep 2020 07:40:36 +0200
Message-Id: <20200910054038.324517-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910054038.324517-1-hch@lst.de>
References: <20200910054038.324517-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 linux-sh@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Move the helpers to translate to and from direct mapping DMA addresses
to dma-direct.h.  This not only is the most logical place, but the new
placement also avoids dependency loops with pending commits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/common/dmabounce.c        |  2 +-
 arch/arm/include/asm/dma-direct.h  | 70 ++++++++++++++++++++++++++++++
 arch/arm/include/asm/dma-mapping.h | 70 ------------------------------
 3 files changed, 71 insertions(+), 71 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index f4b719bde76367..d3e00ea9208834 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -24,7 +24,7 @@
 #include <linux/slab.h>
 #include <linux/page-flags.h>
 #include <linux/device.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <linux/dmapool.h>
 #include <linux/list.h>
 #include <linux/scatterlist.h>
diff --git a/arch/arm/include/asm/dma-direct.h b/arch/arm/include/asm/dma-direct.h
index 7c3001a6a775bf..de0f4ff9279615 100644
--- a/arch/arm/include/asm/dma-direct.h
+++ b/arch/arm/include/asm/dma-direct.h
@@ -2,6 +2,76 @@
 #ifndef ASM_ARM_DMA_DIRECT_H
 #define ASM_ARM_DMA_DIRECT_H 1
 
+#include <asm/memory.h>
+
+#ifdef __arch_page_to_dma
+#error Please update to __arch_pfn_to_dma
+#endif
+
+/*
+ * dma_to_pfn/pfn_to_dma/dma_to_virt/virt_to_dma are architecture private
+ * functions used internally by the DMA-mapping API to provide DMA
+ * addresses. They must not be used by drivers.
+ */
+#ifndef __arch_pfn_to_dma
+static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
+{
+	if (dev)
+		pfn -= dev->dma_pfn_offset;
+	return (dma_addr_t)__pfn_to_bus(pfn);
+}
+
+static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
+{
+	unsigned long pfn = __bus_to_pfn(addr);
+
+	if (dev)
+		pfn += dev->dma_pfn_offset;
+
+	return pfn;
+}
+
+static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
+{
+	if (dev) {
+		unsigned long pfn = dma_to_pfn(dev, addr);
+
+		return phys_to_virt(__pfn_to_phys(pfn));
+	}
+
+	return (void *)__bus_to_virt((unsigned long)addr);
+}
+
+static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
+{
+	if (dev)
+		return pfn_to_dma(dev, virt_to_pfn(addr));
+
+	return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
+}
+
+#else
+static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
+{
+	return __arch_pfn_to_dma(dev, pfn);
+}
+
+static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
+{
+	return __arch_dma_to_pfn(dev, addr);
+}
+
+static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
+{
+	return __arch_dma_to_virt(dev, addr);
+}
+
+static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
+{
+	return __arch_virt_to_dma(dev, addr);
+}
+#endif
+
 static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	unsigned int offset = paddr & ~PAGE_MASK;
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index bdd80ddbca3451..0a1a536368c3a4 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -8,8 +8,6 @@
 #include <linux/scatterlist.h>
 #include <linux/dma-debug.h>
 
-#include <asm/memory.h>
-
 #include <xen/xen.h>
 #include <asm/xen/hypervisor.h>
 
@@ -23,74 +21,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return NULL;
 }
 
-#ifdef __arch_page_to_dma
-#error Please update to __arch_pfn_to_dma
-#endif
-
-/*
- * dma_to_pfn/pfn_to_dma/dma_to_virt/virt_to_dma are architecture private
- * functions used internally by the DMA-mapping API to provide DMA
- * addresses. They must not be used by drivers.
- */
-#ifndef __arch_pfn_to_dma
-static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	if (dev)
-		pfn -= dev->dma_pfn_offset;
-	return (dma_addr_t)__pfn_to_bus(pfn);
-}
-
-static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
-{
-	unsigned long pfn = __bus_to_pfn(addr);
-
-	if (dev)
-		pfn += dev->dma_pfn_offset;
-
-	return pfn;
-}
-
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
-static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
-{
-	if (dev)
-		return pfn_to_dma(dev, virt_to_pfn(addr));
-
-	return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
-}
-
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
-static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
-{
-	return __arch_dma_to_virt(dev, addr);
-}
-
-static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
-{
-	return __arch_virt_to_dma(dev, addr);
-}
-#endif
-
 /**
  * arm_dma_alloc - allocate consistent memory for DMA
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
