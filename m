Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AA120F7
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 03:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 3AR3A8oq076077
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 11:10:08 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 3AR39aK1072979;
	Mon, 27 Nov 2023 11:09:36 +0800 (+08)
	(envelope-from zhaoyang.huang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Sdr5d2Pt5z2K85d4;
	Mon, 27 Nov 2023 11:04:05 +0800 (CST)
Received: from bj03382pcu01.spreadtrum.com (10.0.73.40) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 27 Nov 2023 11:09:33 +0800
From: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
To: Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski
	<m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang
	<huangzhaoyang@gmail.com>, <steve.kang@unisoc.com>
Subject: [PATCH] kernel: dma: let dma use vmalloc area
Date: Mon, 27 Nov 2023 11:09:30 +0800
Message-ID: <20231127030930.1074374-1-zhaoyang.huang@unisoc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 3AR39aK1072979

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

memremap within dma_init_coherent_memory will map the given phys_addr
into vmalloc area if the pa is not found during iterating iomem_resources,
which conflict the rejection of vmalloc area in dma_map_single_attrs.
IMO, it is find to let all valid virtual address be valid for DMA as the
user will keep corresponding RAM safe for transfer.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 include/linux/dma-mapping.h | 12 +++++++-----
 kernel/dma/debug.c          |  4 ----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f0ccca16a0ac..7a7b87289d55 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -328,12 +328,14 @@ static inline void dma_free_noncoherent(struct device *dev, size_t size,
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	/* DMA must never operate on areas that might be remapped. */
-	if (dev_WARN_ONCE(dev, is_vmalloc_addr(ptr),
-			  "rejecting DMA map of vmalloc memory\n"))
-		return DMA_MAPPING_ERROR;
+	struct page *page;
+
 	debug_dma_map_single(dev, ptr, size);
-	return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(ptr),
+	if (is_vmalloc_addr(ptr))
+		page = vmalloc_to_page(ptr);
+	else
+		page = virt_to_page(ptr);
+	return dma_map_page_attrs(dev, page, offset_in_page(ptr),
 			size, dir, attrs);
 }
 
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 06366acd27b0..51e1fe9a70aa 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1198,10 +1198,6 @@ void debug_dma_map_single(struct device *dev, const void *addr,
 	if (!virt_addr_valid(addr))
 		err_printk(dev, NULL, "device driver maps memory from invalid area [addr=%p] [len=%lu]\n",
 			   addr, len);
-
-	if (is_vmalloc_addr(addr))
-		err_printk(dev, NULL, "device driver maps memory from vmalloc area [addr=%p] [len=%lu]\n",
-			   addr, len);
 }
 EXPORT_SYMBOL(debug_dma_map_single);
 
-- 
2.25.1

