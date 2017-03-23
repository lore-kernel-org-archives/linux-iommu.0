From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] iommu: use sg_phys()
Date: Thu, 23 Mar 2017 21:16:31 +0800
Message-ID: <5d70b2e8ad624149bfa75436f62e96e1e485d36a.1490258587.git.geliangtang@gmail.com>
References: <a41fae798473b657f09859ae113403655b1717f9.1490258141.git.geliangtang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a41fae798473b657f09859ae113403655b1717f9.1490258141.git.geliangtang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: Geliang Tang <geliangtang@gmail.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Use sg_phys() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/iommu/intel-iommu.c | 2 +-
 drivers/iommu/iommu.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index d412a31..9d09a9e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3892,7 +3892,7 @@ static int intel_nontranslate_map_sg(struct device *hddev,
 
 	for_each_sg(sglist, sg, nelems, i) {
 		BUG_ON(!sg_page(sg));
-		sg->dma_address = page_to_phys(sg_page(sg)) + sg->offset;
+		sg->dma_address = sg_phys(sg);
 		sg->dma_length = sg->length;
 	}
 	return nelems;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3b67144..26f57b3 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1603,7 +1603,7 @@ size_t default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 	min_pagesz = 1 << __ffs(domain->pgsize_bitmap);
 
 	for_each_sg(sg, s, nents, i) {
-		phys_addr_t phys = page_to_phys(sg_page(s)) + s->offset;
+		phys_addr_t phys = sg_phys(s);
 
 		/*
 		 * We are mapping on IOMMU page boundaries, so offset within
-- 
2.9.3
