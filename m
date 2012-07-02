From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [v3.6 1/3] Revert "iommu/tegra: smmu: Fix unsleepable memory allocation"
Date: Mon, 2 Jul 2012 14:26:36 +0300
Message-ID: <1341228398-6878-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This reverts commit 64b3aeed242ae55611e0f6286159957873cf968d.

For the succeeding commits.

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 3f3d09d..ecd6790 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -550,13 +550,13 @@ static int alloc_pdir(struct smmu_as *as)
 		return 0;
 
 	as->pte_count = devm_kzalloc(smmu->dev,
-		     sizeof(as->pte_count[0]) * SMMU_PDIR_COUNT, GFP_ATOMIC);
+		     sizeof(as->pte_count[0]) * SMMU_PDIR_COUNT, GFP_KERNEL);
 	if (!as->pte_count) {
 		dev_err(smmu->dev,
 			"failed to allocate smmu_device PTE cunters\n");
 		return -ENOMEM;
 	}
-	as->pdir_page = alloc_page(GFP_ATOMIC | __GFP_DMA);
+	as->pdir_page = alloc_page(GFP_KERNEL | __GFP_DMA);
 	if (!as->pdir_page) {
 		dev_err(smmu->dev,
 			"failed to allocate smmu_device page directory\n");
-- 
1.7.5.4
