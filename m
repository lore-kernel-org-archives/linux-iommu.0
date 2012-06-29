From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [v3 1/2] iommu/tegra: smmu: Remove unnecessary sanity check at alloc_pdir()
Date: Fri, 29 Jun 2012 09:15:26 +0300
Message-ID: <1340950527-16482-1-git-send-email-hdoyu@nvidia.com>
References: <20120628.221945.1306825810095951985.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120628.221945.1306825810095951985.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

alloc_pdir() is called with smmu->as[?].pdir_page == NULL. No need to
check pdir_page again inside alloc_pdir().

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index ecd6790..532c8a4 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -546,9 +546,6 @@ static int alloc_pdir(struct smmu_as *as)
 	u32 val;
 	struct smmu_device *smmu = as->smmu;
 
-	if (as->pdir_page)
-		return 0;
-
 	as->pte_count = devm_kzalloc(smmu->dev,
 		     sizeof(as->pte_count[0]) * SMMU_PDIR_COUNT, GFP_KERNEL);
 	if (!as->pte_count) {
-- 
1.7.5.4
