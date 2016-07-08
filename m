From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 06/20] iommu/amd: Pass gfp-flags to iommu_map_page()
Date: Fri,  8 Jul 2016 13:44:57 +0200
Message-ID: <1467978311-28322-7-git-send-email-joro@8bytes.org>
References: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467978311-28322-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Vincent.Wan@amd.com, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Make this function ready to be used in the DMA-API path.
Reorder parameters a bit while at it.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 5ea5679..e7c042b 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1415,8 +1415,9 @@ static u64 *fetch_pte(struct protection_domain *domain,
 static int iommu_map_page(struct protection_domain *dom,
 			  unsigned long bus_addr,
 			  unsigned long phys_addr,
+			  unsigned long page_size,
 			  int prot,
-			  unsigned long page_size)
+			  gfp_t gfp)
 {
 	u64 __pte, *pte;
 	int i, count;
@@ -1428,7 +1429,7 @@ static int iommu_map_page(struct protection_domain *dom,
 		return -EINVAL;
 
 	count = PAGE_SIZE_PTE_COUNT(page_size);
-	pte   = alloc_pte(dom, bus_addr, page_size, NULL, GFP_KERNEL);
+	pte   = alloc_pte(dom, bus_addr, page_size, NULL, gfp);
 
 	if (!pte)
 		return -ENOMEM;
@@ -3277,7 +3278,7 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 		prot |= IOMMU_PROT_IW;
 
 	mutex_lock(&domain->api_lock);
-	ret = iommu_map_page(domain, iova, paddr, prot, page_size);
+	ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
 	mutex_unlock(&domain->api_lock);
 
 	return ret;
-- 
1.9.1
