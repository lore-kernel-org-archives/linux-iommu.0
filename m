Return-Path: <SRS0=MJs7=WM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6DDC3A59C
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 13:01:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439842064A
	for <iommu@archiver.kernel.org>; Fri, 16 Aug 2019 13:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WcGB+9g0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439842064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id ADD30EF7;
	Fri, 16 Aug 2019 13:01:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id E9093EB9
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 13:01:10 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from bombadil.infradead.org (bombadil.infradead.org
	[198.137.202.133])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 906B58A9
	for <iommu@lists.linux-foundation.org>;
	Fri, 16 Aug 2019 13:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6T2bIq6UFYJmeZ97WTx/gfyH1ZZrxlJ6ERHLefhwaXQ=;
	b=WcGB+9g0nH6xsYXHf0S0Ob5X68
	g0HKp0cJ1ZXnldOw4TjrNrTOzHdlm7mOEnnetHeh51Y5GME02Zwr26s7OugylZG+ZUQ3kKlftdrRd
	RjIE3xh7oZCtGlEEHec9kOZqLNDcgfkbYZ1lRoZ/qvdA1app8N3Vb0NQ3FP26Nkk0n4BdgumkZaLU
	3PVncaIsoNxfYsqfsLaAGBT3KLAlHRp1OTyMFNFWQyqgMWwoJidktGRcHxuUmEa/z9yCbUJbvv4qY
	3liY84h8fUYj2YwE2y9/S/3+IwSLsfVtLziL/vVAc4UDnkTI7RlE0S/xMjjxbGgD+LlRs8XawYZZt
	y/n3MfXA==;
Received: from [91.112.187.46] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
	id 1hybqT-0006Wg-Ci; Fri, 16 Aug 2019 13:00:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Stefano Stabellini <sstabellini@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 07/11] swiotlb-xen: provide a single page-coherent.h header
Date: Fri, 16 Aug 2019 15:00:09 +0200
Message-Id: <20190816130013.31154-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816130013.31154-1-hch@lst.de>
References: <20190816130013.31154-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
	bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Merge the various page-coherent.h files into a single one that either
provides prototypes or stubs depending on the need for cache
maintainance.

For extra benefits alo include <xen/page-coherent.h> in the file
actually implementing the interfaces provided.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/xen/page-coherent.h   |  2 --
 arch/arm/xen/mm.c                          |  1 +
 arch/arm64/include/asm/xen/page-coherent.h |  2 --
 arch/x86/include/asm/xen/page-coherent.h   | 22 ------------------
 drivers/xen/swiotlb-xen.c                  |  4 +---
 include/Kbuild                             |  2 +-
 include/xen/{arm => }/page-coherent.h      | 27 +++++++++++++++++++---
 7 files changed, 27 insertions(+), 33 deletions(-)
 delete mode 100644 arch/arm/include/asm/xen/page-coherent.h
 delete mode 100644 arch/arm64/include/asm/xen/page-coherent.h
 delete mode 100644 arch/x86/include/asm/xen/page-coherent.h
 rename include/xen/{arm => }/page-coherent.h (76%)

diff --git a/arch/arm/include/asm/xen/page-coherent.h b/arch/arm/include/asm/xen/page-coherent.h
deleted file mode 100644
index 27e984977402..000000000000
--- a/arch/arm/include/asm/xen/page-coherent.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <xen/arm/page-coherent.h>
diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index a59980f1aa54..85482cdda1e5 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -15,6 +15,7 @@
 #include <xen/interface/grant_table.h>
 #include <xen/interface/memory.h>
 #include <xen/page.h>
+#include <xen/page-coherent.h>
 #include <xen/swiotlb-xen.h>
 
 #include <asm/cacheflush.h>
diff --git a/arch/arm64/include/asm/xen/page-coherent.h b/arch/arm64/include/asm/xen/page-coherent.h
deleted file mode 100644
index 27e984977402..000000000000
--- a/arch/arm64/include/asm/xen/page-coherent.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <xen/arm/page-coherent.h>
diff --git a/arch/x86/include/asm/xen/page-coherent.h b/arch/x86/include/asm/xen/page-coherent.h
deleted file mode 100644
index 8ee33c5edded..000000000000
--- a/arch/x86/include/asm/xen/page-coherent.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_XEN_PAGE_COHERENT_H
-#define _ASM_X86_XEN_PAGE_COHERENT_H
-
-#include <asm/page.h>
-#include <linux/dma-mapping.h>
-
-static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
-	     dma_addr_t dev_addr, unsigned long offset, size_t size,
-	     enum dma_data_direction dir, unsigned long attrs) { }
-
-static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
-		size_t size, enum dma_data_direction dir,
-		unsigned long attrs) { }
-
-static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir) { }
-
-static inline void xen_dma_sync_single_for_device(struct device *hwdev,
-		dma_addr_t handle, size_t size, enum dma_data_direction dir) { }
-
-#endif /* _ASM_X86_XEN_PAGE_COHERENT_H */
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index f9dd4cb6e4b3..7b23929854e7 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -31,12 +31,10 @@
 #include <linux/export.h>
 #include <xen/swiotlb-xen.h>
 #include <xen/page.h>
+#include <xen/page-coherent.h>
 #include <xen/xen-ops.h>
 #include <xen/hvc-console.h>
 
-#include <asm/dma-mapping.h>
-#include <asm/xen/page-coherent.h>
-
 #include <trace/events/swiotlb.h>
 /*
  * Used to do a quick range check in swiotlb_tbl_unmap_single and
diff --git a/include/Kbuild b/include/Kbuild
index c38f0d46b267..e2ae52ef9e1e 100644
--- a/include/Kbuild
+++ b/include/Kbuild
@@ -1189,7 +1189,6 @@ header-test-			+= video/vga.h
 header-test-			+= video/w100fb.h
 header-test-			+= xen/acpi.h
 header-test-			+= xen/arm/hypercall.h
-header-test-			+= xen/arm/page-coherent.h
 header-test-			+= xen/arm/page.h
 header-test-			+= xen/balloon.h
 header-test-			+= xen/events.h
@@ -1231,6 +1230,7 @@ header-test-			+= xen/interface/xen.h
 header-test-			+= xen/interface/xenpmu.h
 header-test-			+= xen/mem-reservation.h
 header-test-			+= xen/page.h
+header-test-			+= xen/page-coherent.h
 header-test-			+= xen/platform_pci.h
 header-test-			+= xen/swiotlb-xen.h
 header-test-			+= xen/xen-front-pgdir-shbuf.h
diff --git a/include/xen/arm/page-coherent.h b/include/xen/page-coherent.h
similarity index 76%
rename from include/xen/arm/page-coherent.h
rename to include/xen/page-coherent.h
index 4294a31305ca..7c32944de051 100644
--- a/include/xen/arm/page-coherent.h
+++ b/include/xen/page-coherent.h
@@ -1,10 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _XEN_ARM_PAGE_COHERENT_H
-#define _XEN_ARM_PAGE_COHERENT_H
+#ifndef _XEN_PAGE_COHERENT_H
+#define _XEN_PAGE_COHERENT_H
 
 #include <linux/dma-mapping.h>
 #include <asm/page.h>
 
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU)
 void __xen_dma_map_page(struct device *hwdev, struct page *page,
 	     dma_addr_t dev_addr, unsigned long offset, size_t size,
 	     enum dma_data_direction dir, unsigned long attrs);
@@ -71,5 +73,24 @@ static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
 	else
 		__xen_dma_unmap_page(hwdev, handle, size, dir, attrs);
 }
+#else
+static inline void xen_dma_map_page(struct device *hwdev, struct page *page,
+	     dma_addr_t dev_addr, unsigned long offset, size_t size,
+	     enum dma_data_direction dir, unsigned long attrs)
+{
+}
+static inline void xen_dma_unmap_page(struct device *hwdev, dma_addr_t handle,
+		size_t size, enum dma_data_direction dir, unsigned long attrs)
+{
+}
+static inline void xen_dma_sync_single_for_cpu(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir)
+{
+}
+static inline void xen_dma_sync_single_for_device(struct device *hwdev,
+		dma_addr_t handle, size_t size, enum dma_data_direction dir)
+{
+}
+#endif
 
-#endif /* _XEN_ARM_PAGE_COHERENT_H */
+#endif /* _XEN_PAGE_COHERENT_H */
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
