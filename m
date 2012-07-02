From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [v3.5 1/1] iommu/tegra: smmu: Fix unsleepable memory allocation
Date: Mon, 2 Jul 2012 14:26:09 +0300
Message-ID: <1341228369-6765-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

allo_pdir() is called in smmu_iommu_domain_init() with spin_lock
held. memory allocations in it have to be atomic/unsleepable.

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Reported-by: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
Acked-by: Chris Wright <chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index ecd6790..3f3d09d 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -550,13 +550,13 @@ static int alloc_pdir(struct smmu_as *as)
 		return 0;
 
 	as->pte_count = devm_kzalloc(smmu->dev,
-		     sizeof(as->pte_count[0]) * SMMU_PDIR_COUNT, GFP_KERNEL);
+		     sizeof(as->pte_count[0]) * SMMU_PDIR_COUNT, GFP_ATOMIC);
 	if (!as->pte_count) {
 		dev_err(smmu->dev,
 			"failed to allocate smmu_device PTE cunters\n");
 		return -ENOMEM;
 	}
-	as->pdir_page = alloc_page(GFP_KERNEL | __GFP_DMA);
+	as->pdir_page = alloc_page(GFP_ATOMIC | __GFP_DMA);
 	if (!as->pdir_page) {
 		dev_err(smmu->dev,
 			"failed to allocate smmu_device page directory\n");
-- 
1.7.5.4
