From: Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [PATCH] iommu/dma: Remove unused variable
Date: Thu, 24 Jan 2019 15:10:02 +0800
Message-ID: <1548313802-64412-1-git-send-email-zhangshaokun@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>, Joerg Roedel <jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>, Zhen Lei <thunder.leizhen@huawei.com>
List-Id: iommu@lists.linux-foundation.org

end_pfn is never used after commit <aa3ac9469c18> ('iommu/iova: Make dma
32bit pfn implicit'), cleanup it.

Cc: Joerg Roedel <jroedel@suse.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/iommu/dma-iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d19f3d6b43c1..77aabe637a60 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -289,7 +289,7 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iova_domain *iovad = &cookie->iovad;
-	unsigned long order, base_pfn, end_pfn;
+	unsigned long order, base_pfn;
 	int attr;
 
 	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
@@ -298,7 +298,6 @@ int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	/* Use the smallest supported page size for IOVA granularity */
 	order = __ffs(domain->pgsize_bitmap);
 	base_pfn = max_t(unsigned long, 1, base >> order);
-	end_pfn = (base + size - 1) >> order;
 
 	/* Check the domain allows at least some access to the device... */
 	if (domain->geometry.force_aperture) {
-- 
2.7.4
