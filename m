Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DE03595C
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760019328; cv=none; b=MtCpvsAVaEkRkwllo1gSIKGPVE7nv8SgBOYBzVrInRj15w45h+Q4KCiY32lYenWhdJ2/7f6wO5oo1DcHK8syurgCH06q7GueeVLNdMhjuAgWCR3FUwRNv3FuLZ0TiIG51wbdCNY25lF3hTuvwyGjfWUTyQFlHcr4K2xfNIB9keU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760019328; c=relaxed/simple;
	bh=iMrFC2safYSMJtgSX6iouY6LHlejHyqMTTQx2kOLGT8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=oC86xDppTSKqM3yb0MbQQBitDcaMp739oVWZEmajGsEMr4rGCh76O748EDs32ixgbE+PJ9mV4S/WRij91wYsYEmE0s6uSuEij0jN5z5ZGtBm0M5Bjx/auL7kv0LaniHMvOOZRRZwGkkghrQgvw9cniUmqqZpRGgaLVrROpJsV7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HWLPRzJx; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HWLPRzJx"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251009141522euoutp020689a8ee8865ad5d0bcdd602d796c2ee~s2D-IgLCC2212422124euoutp02i
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 14:15:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251009141522euoutp020689a8ee8865ad5d0bcdd602d796c2ee~s2D-IgLCC2212422124euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760019322;
	bh=sVM2HZjtEWA6YFz2riuKNValcsfE7dfd/YYeO7iZSsQ=;
	h=From:To:Cc:Subject:Date:References:From;
	b=HWLPRzJxeBqXOINEJp2zlmlwmpovDVOPDY5qdedCBZceg8t177uzB/y5Rec8ur3ra
	 6xLQjPOabTix1bsm8jjRXVX2YXgjtHKTSEKAWKp4pzT+nb64rA+L7akZ15I2MESzHd
	 8mZpF3ZmQ4s/EX+CipijDXNw71xXisnrBF7CtjHw=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251009141522eucas1p2c89eadd93fb571c557d3d70975d8ae4f~s2D_3ixxH3205132051eucas1p2H;
	Thu,  9 Oct 2025 14:15:22 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251009141522eusmtip2446b6e4de7b829823b6d4caa0531719d~s2D_gNaFy0900109001eusmtip2_;
	Thu,  9 Oct 2025 14:15:22 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Andrew Morton
	<akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] dma-debug: don't report false positives with
 DMA_BOUNCE_UNALIGNED_KMALLOC
Date: Thu,  9 Oct 2025 16:15:08 +0200
Message-Id: <20251009141508.2342138-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251009141522eucas1p2c89eadd93fb571c557d3d70975d8ae4f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251009141522eucas1p2c89eadd93fb571c557d3d70975d8ae4f
X-EPHeader: CA
X-CMS-RootMailID: 20251009141522eucas1p2c89eadd93fb571c557d3d70975d8ae4f
References: <CGME20251009141522eucas1p2c89eadd93fb571c557d3d70975d8ae4f@eucas1p2.samsung.com>

Commit 370645f41e6e ("dma-mapping: force bouncing if the kmalloc() size
is not cache-line-aligned") introduced DMA_BOUNCE_UNALIGNED_KMALLOC
feature and lets architecture specific code to configure kmalloc slabs
with sizes smaller than the value of dma_get_cache_alignment().

When that feature is enabled, the physical address of some small
kmalloc()-ed buffers might be not aligned to the CPU cachelines, thus not
really suitable for typical DMA. To properly handle that case a SWIOTLB
buffer bouncing is used, so no CPU cache corruption occurs. When that
happens, there is no point reporting a false-positive DMA-API warning
that the buffer is not properly aligned, as this is not a client driver
fault.

Fixes: 370645f41e6e ("dma-mapping: force bouncing if the kmalloc() size is not cache-line-aligned")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 kernel/dma/debug.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index b82399437db0..266598d837c5 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -23,6 +23,7 @@
 #include <linux/ctype.h>
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <linux/swiotlb.h>
 #include <asm/sections.h>
 #include "debug.h"
 
@@ -594,7 +595,9 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
 	if (rc == -ENOMEM) {
 		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
 		global_disable = true;
-	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
+	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
+		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
+		     is_swiotlb_allocated())) {
 		err_printk(entry->dev, entry,
 			"cacheline tracking EEXIST, overlapping mappings aren't supported\n");
 	}
-- 
2.34.1

