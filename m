Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3E763D1
	for <iommu@lists.linux.dev>; Mon, 20 Feb 2023 15:22:14 +0000 (UTC)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PL5C70mBjz9xyNC
	for <iommu@lists.linux.dev>; Mon, 20 Feb 2023 22:58:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.81.223.230])
	by APP1 (Coremail) with SMTP id LxC2BwCXHwuAjPNjH5A6AQ--.54716S2;
	Mon, 20 Feb 2023 16:06:47 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev (open list:DMA MAPPING HELPERS),
	linux-kernel@vger.kernel.org (open list)
Cc: roberto.sassu@huaweicloud.com,
	Petr Tesarik <petrtesarik@huaweicloud.com>
Subject: [PATCH] dma-direct: cleanup parameters to dma_direct_optimal_gfp_mask
Date: Mon, 20 Feb 2023 16:06:22 +0100
Message-Id: <20230220150622.454-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwCXHwuAjPNjH5A6AQ--.54716S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr48CFyDtr4rAr4kCw48Zwb_yoW8KF1kpr
	4xGFy3GrWFvF1fZa9rZa1kCryYy3sYka1fJFyxtwn3ArZ8Wr9aqF9rKw15tw1fJF9Y9r1f
	XFs5Ja45Ars8ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAKzI0EY4vE
	52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUj
	dHUDUUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected

Since both callers of dma_direct_optimal_gfp_mask() pass
dev->coherent_dma_mask as the second argument, it is better to
remove that parameter altogether.

Not only is reducing number of parameters good for readability, but
the new function signature is also more logical: The optimal flags
depend only on data contained in struct device.

While touching this code, let's also rename phys_mask to phys_limit
in dma_direct_alloc_from_pool(), because it is indeed a limit.

Signed-off-by: Petr Tesarik <petrtesarik@huaweicloud.com>
---
 kernel/dma/direct.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 63859a101ed8..5595d1d5cdcc 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -44,10 +44,11 @@ u64 dma_direct_get_required_mask(struct device *dev)
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
 
-static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
-				  u64 *phys_limit)
+static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
 {
-	u64 dma_limit = min_not_zero(dma_mask, dev->bus_dma_limit);
+	u64 dma_limit = min_not_zero(
+		dev->coherent_dma_mask,
+		dev->bus_dma_limit);
 
 	/*
 	 * Optimistically try the zone that the physical address mask falls
@@ -126,8 +127,7 @@ static struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 	if (is_swiotlb_for_alloc(dev))
 		return dma_direct_alloc_swiotlb(dev, size);
 
-	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
-					   &phys_limit);
+	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
 	page = dma_alloc_contiguous(dev, size, gfp);
 	if (page) {
 		if (!dma_coherent_ok(dev, page_to_phys(page), size) ||
@@ -172,14 +172,13 @@ static void *dma_direct_alloc_from_pool(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
 {
 	struct page *page;
-	u64 phys_mask;
+	u64 phys_limit;
 	void *ret;
 
 	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_DMA_COHERENT_POOL)))
 		return NULL;
 
-	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
-					   &phys_mask);
+	gfp |= dma_direct_optimal_gfp_mask(dev, &phys_limit);
 	page = dma_alloc_from_pool(dev, size, &ret, gfp, dma_coherent_ok);
 	if (!page)
 		return NULL;
-- 
2.25.1

