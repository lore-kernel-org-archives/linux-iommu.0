From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 5/7] iommu/amd: Restart loop if cmpxchg64 succeeded in alloc_pte()
Date: Fri,  9 Nov 2018 12:07:10 +0100
Message-ID: <20181109110712.12469-6-joro@8bytes.org>
References: <20181109110712.12469-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109110712.12469-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jroedel@suse.de
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

This makes sure that __pte always contains the correct value
when the pointer to the next page-table level is derived.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd_iommu.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 6a88ba9321d1..c539b2a59019 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1474,13 +1474,12 @@ static u64 *alloc_pte(struct protection_domain *domain,
 			__npte = PM_LEVEL_PDE(level, iommu_virt_to_phys(page));
 
 			/* pte could have been changed somewhere. */
-			if (cmpxchg64(pte, __pte, __npte) != __pte) {
+			if (cmpxchg64(pte, __pte, __npte) != __pte)
 				free_page((unsigned long)page);
-				continue;
-			}
-
-			if (pte_level == PAGE_MODE_7_LEVEL)
+			else if (pte_level == PAGE_MODE_7_LEVEL)
 				domain->updated = true;
+
+			continue;
 		}
 
 		/* No level skipping support yet */
@@ -1489,7 +1488,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
 
 		level -= 1;
 
-		pte = IOMMU_PTE_PAGE(*pte);
+		pte = IOMMU_PTE_PAGE(__pte);
 
 		if (pte_page && level == end_lvl)
 			*pte_page = pte;
-- 
2.17.1
