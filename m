Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31139C433F5
	for <iommu@archiver.kernel.org>; Mon, 24 Jan 2022 16:40:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D01D360B5C;
	Mon, 24 Jan 2022 16:40:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ijMzSvHhuL52; Mon, 24 Jan 2022 16:40:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CE71860D63;
	Mon, 24 Jan 2022 16:40:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D7EEC0039;
	Mon, 24 Jan 2022 16:40:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8850C002F
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 16:40:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C94EF4090E
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 16:40:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8g6UetMovsed for <iommu@lists.linux-foundation.org>;
 Mon, 24 Jan 2022 16:40:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 07B71400F1
 for <iommu@lists.linux-foundation.org>; Mon, 24 Jan 2022 16:40:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65E95113E;
 Mon, 24 Jan 2022 08:40:25 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 80B043F793;
 Mon, 24 Jan 2022 08:40:24 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: hch@lst.de,
	konrad@kernel.org
Subject: [PATCH 2/3] swiotlb: Tidy up includes
Date: Mon, 24 Jan 2022 16:40:18 +0000
Message-Id: <57acdf35aa8a66e40ba99d97713ed97b2e40a1f6.1643028164.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1643028164.git.robin.murphy@arm.com>
References: <cover.1643028164.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: tientzu@chromium.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, guozhengkui@vivo.com
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

SWIOTLB's includes have become a great big mess. Restore some order by
consolidating the random different blocks, sorting alphabetically, and
purging some clearly unnecessary entries - linux/io.h is now included
unconditionally, so need not be duplicated in the restricted DMA pool
case; similarly, linux/io.h subsumes asm/io.h; and by now it's a
mystery why asm/dma.h was ever here at all.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 kernel/dma/swiotlb.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index bdce89e053bd..f56d6504903c 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -21,38 +21,33 @@
 #define pr_fmt(fmt) "software IO TLB: " fmt
 
 #include <linux/cache.h>
+#include <linux/cc_platform.h>
+#include <linux/ctype.h>
+#include <linux/debugfs.h>
 #include <linux/dma-direct.h>
 #include <linux/dma-map-ops.h>
-#include <linux/mm.h>
 #include <linux/export.h>
+#include <linux/gfp.h>
+#include <linux/highmem.h>
+#include <linux/io.h>
+#include <linux/iommu-helper.h>
+#include <linux/init.h>
+#include <linux/memblock.h>
+#include <linux/mm.h>
+#include <linux/pfn.h>
+#include <linux/scatterlist.h>
+#include <linux/set_memory.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/swiotlb.h>
-#include <linux/pfn.h>
 #include <linux/types.h>
-#include <linux/ctype.h>
-#include <linux/highmem.h>
-#include <linux/gfp.h>
-#include <linux/scatterlist.h>
-#include <linux/cc_platform.h>
-#include <linux/set_memory.h>
-#include <linux/debugfs.h>
 #ifdef CONFIG_DMA_RESTRICTED_POOL
-#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/slab.h>
 #endif
 
-#include <asm/io.h>
-#include <asm/dma.h>
-
-#include <linux/io.h>
-#include <linux/init.h>
-#include <linux/memblock.h>
-#include <linux/iommu-helper.h>
-
 #define CREATE_TRACE_POINTS
 #include <trace/events/swiotlb.h>
 
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
