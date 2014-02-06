From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH 1/5] iommu/arm-smmu: fix pud/pmd entry fill sequence
Date: Thu,  6 Feb 2014 18:09:29 +0000
Message-ID: <1391710173-4343-2-git-send-email-will.deacon@arm.com>
References: <1391710173-4343-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1391710173-4343-1-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Yifan Zhang <zhangyf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Yifan Zhang <zhangyf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

The ARM SMMU driver's population of puds and pmds is broken, since we
iterate over the next level of table repeatedly setting the current
level descriptor to point at the pmd being initialised. This is clearly
wrong when dealing with multiple pmds/puds.

This patch fixes the problem by moving the pud/pmd population out of the
loop and instead performing it when we allocate the next level (like we
correctly do for ptes already). The starting address for the next level
is then calculated prior to entering the loop.

Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Signed-off-by: Yifan Zhang <zhangyf-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
---
 drivers/iommu/arm-smmu.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 8911850c9444..9f210de6537e 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1320,6 +1320,11 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
 		pmd = pmd_alloc_one(NULL, addr);
 		if (!pmd)
 			return -ENOMEM;
+
+		pud_populate(NULL, pud, pmd);
+		arm_smmu_flush_pgtable(smmu, pud, sizeof(*pud));
+
+		pmd += pmd_index(addr);
 	} else
 #endif
 		pmd = pmd_offset(pud, addr);
@@ -1328,8 +1333,6 @@ static int arm_smmu_alloc_init_pmd(struct arm_smmu_device *smmu, pud_t *pud,
 		next = pmd_addr_end(addr, end);
 		ret = arm_smmu_alloc_init_pte(smmu, pmd, addr, end, pfn,
 					      flags, stage);
-		pud_populate(NULL, pud, pmd);
-		arm_smmu_flush_pgtable(smmu, pud, sizeof(*pud));
 		phys += next - addr;
 	} while (pmd++, addr = next, addr < end);
 
@@ -1349,6 +1352,11 @@ static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
 		pud = pud_alloc_one(NULL, addr);
 		if (!pud)
 			return -ENOMEM;
+
+		pgd_populate(NULL, pgd, pud);
+		arm_smmu_flush_pgtable(smmu, pgd, sizeof(*pgd));
+
+		pud += pud_index(addr);
 	} else
 #endif
 		pud = pud_offset(pgd, addr);
@@ -1357,8 +1365,6 @@ static int arm_smmu_alloc_init_pud(struct arm_smmu_device *smmu, pgd_t *pgd,
 		next = pud_addr_end(addr, end);
 		ret = arm_smmu_alloc_init_pmd(smmu, pud, addr, next, phys,
 					      flags, stage);
-		pgd_populate(NULL, pud, pgd);
-		arm_smmu_flush_pgtable(smmu, pgd, sizeof(*pgd));
 		phys += next - addr;
 	} while (pud++, addr = next, addr < end);
 
-- 
1.8.2.2
