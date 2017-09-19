From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 2/3] iommu/iova: Make rcache limit_pfn handling more robust
Date: Tue, 19 Sep 2017 14:48:40 +0100
Message-ID: <bf4856683d4130ffd34430452def7ea5d3ebc549.1505827369.git.robin.murphy@arm.com>
References: <cover.1505827369.git.robin.murphy@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1505827369.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

When popping a pfn from an rcache, we are currently checking it directly
against limit_pfn for viability. Since this represents iova->pfn_lo, it
is technically possible for the corresponding iova->pfn_hi to be greater
than limit_pfn. Although we generally get away with it in practice since
limit_pfn is typically a power-of-two boundary and the IOVAs are
size-aligned, it's pretty trivial to make the iova_rcache_get() path
take the allocation size into account for complete safety.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iova.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 35dde0fc7793..8f8b436afd81 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -411,7 +411,7 @@ alloc_iova_fast(struct iova_domain *iovad, unsigned long size,
 	unsigned long iova_pfn;
 	struct iova *new_iova;
 
-	iova_pfn = iova_rcache_get(iovad, size, limit_pfn);
+	iova_pfn = iova_rcache_get(iovad, size, limit_pfn + 1);
 	if (iova_pfn)
 		return iova_pfn;
 
@@ -828,7 +828,7 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
 {
 	BUG_ON(iova_magazine_empty(mag));
 
-	if (mag->pfns[mag->size - 1] >= limit_pfn)
+	if (mag->pfns[mag->size - 1] > limit_pfn)
 		return 0;
 
 	return mag->pfns[--mag->size];
@@ -982,7 +982,7 @@ static unsigned long iova_rcache_get(struct iova_domain *iovad,
 	if (log_size >= IOVA_RANGE_CACHE_MAX_SIZE)
 		return 0;
 
-	return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn);
+	return __iova_rcache_get(&iovad->rcaches[log_size], limit_pfn - size);
 }
 
 /*
-- 
2.13.4.dirty
