From: Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [PATCH] iommu/vt-d, trivial: Remove unused variable
Date: Thu, 22 Mar 2018 18:18:06 +0800
Message-ID: <1521713886-87177-1-git-send-email-zhangshaokun@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
List-Id: iommu@lists.linux-foundation.org

Unused after commit <42e8c186b595> ("iommu/vt-d: Simplify io/tlb flushing
in intel_iommu_unmap"), cleanup it.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/iommu/intel-iommu.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 582fd01..d49e0d3 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5072,7 +5072,6 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	struct page *freelist = NULL;
-	struct intel_iommu *iommu;
 	unsigned long start_pfn, last_pfn;
 	unsigned int npages;
 	int iommu_id, level = 0;
@@ -5091,12 +5090,9 @@ static size_t intel_iommu_unmap(struct iommu_domain *domain,
 
 	npages = last_pfn - start_pfn + 1;
 
-	for_each_domain_iommu(iommu_id, dmar_domain) {
-		iommu = g_iommus[iommu_id];
-
+	for_each_domain_iommu(iommu_id, dmar_domain)
 		iommu_flush_iotlb_psi(g_iommus[iommu_id], dmar_domain,
 				      start_pfn, npages, !freelist, 0);
-	}
 
 	dma_free_pagelist(freelist);
 
-- 
1.9.1
