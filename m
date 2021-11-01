Return-Path: <SRS0=fO5g=PU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079B9C433F5
	for <iommu@archiver.kernel.org>; Mon,  1 Nov 2021 07:23:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D466108C
	for <iommu@archiver.kernel.org>; Mon,  1 Nov 2021 07:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A4D466108C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6780660613;
	Mon,  1 Nov 2021 07:23:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eeYHwI66xATh; Mon,  1 Nov 2021 07:23:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E6205605A5;
	Mon,  1 Nov 2021 07:23:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BABAEC0012;
	Mon,  1 Nov 2021 07:23:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A434C000E
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 03:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 14D5280C70
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 03:21:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uV6aa8_etwHE for <iommu@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 03:21:09 +0000 (UTC)
X-Greylist: delayed 00:05:02 by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2CDE980C6C
 for <iommu@lists.linux-foundation.org>; Mon,  1 Nov 2021 03:21:08 +0000 (UTC)
X-UUID: a197251d0ae64fcd84ee44743b2b31b3-20211101
X-UUID: a197251d0ae64fcd84ee44743b2b31b3-20211101
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <walter-zh.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1302630291; Mon, 01 Nov 2021 11:16:01 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 1 Nov 2021 11:15:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Mon, 1 Nov 2021 11:15:59 +0800
From: Walter Wu <walter-zh.wu@mediatek.com>
To: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, "Matthias
 Brugger" <matthias.bgg@gmail.com>
Subject: [PATCH] dma-direct: fix DMA_ATTR_NO_KERNEL_MAPPING
Date: Mon, 1 Nov 2021 11:15:58 +0800
Message-ID: <20211101031558.7184-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
X-MTK: N
X-Mailman-Approved-At: Mon, 01 Nov 2021 07:23:47 +0000
Cc: Walter Wu <walter-zh.wu@mediatek.com>,
 wsd_upstream <wsd_upstream@mediatek.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
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

DMA_ATTR_NO_KERNEL_MAPPING is to avoid creating a kernel mapping
for the allocated buffer, but current implementation is that
PTE of allocated buffer in kernel page table is valid. So we
should set invalid for PTE of allocate buffer so that there are
no kernel mapping for the allocated buffer.

In some cases, we don't hope the allocated buffer to be read
by cpu or speculative execution, so we use DMA_ATTR_NO_KERNEL_MAPPING
to get no kernel mapping in order to achieve this goal.

Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/dma/direct.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 4c6c5e0635e3..aa10b4c5d762 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -13,6 +13,7 @@
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
 #include <linux/slab.h>
+#include <asm/cacheflush.h>
 #include "direct.h"
 
 /*
@@ -169,6 +170,9 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		if (!PageHighMem(page))
 			arch_dma_prep_coherent(page, size);
 		*dma_handle = phys_to_dma_direct(dev, page_to_phys(page));
+		/* remove kernel mapping for pages */
+		set_memory_valid((unsigned long)phys_to_virt(dma_to_phys(dev, *dma_handle)),
+				size >> PAGE_SHIFT, 0);
 		/* return the page pointer as the opaque cookie */
 		return page;
 	}
@@ -278,6 +282,10 @@ void dma_direct_free(struct device *dev, size_t size,
 
 	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
 	    !force_dma_unencrypted(dev) && !is_swiotlb_for_alloc(dev)) {
+		size = PAGE_ALIGN(size);
+		/* create kernel mapping for pages */
+		set_memory_valid((unsigned long)phys_to_virt(dma_to_phys(dev, dma_addr)),
+				size >> PAGE_SHIFT, 1);
 		/* cpu_addr is a struct page cookie, not a kernel address */
 		dma_free_contiguous(dev, cpu_addr, size);
 		return;
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
