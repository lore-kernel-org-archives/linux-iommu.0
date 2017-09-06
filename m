From: Pushkar Jambhlekar <pushkar.iit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] drivers/iommu/tegra: Optimize mutex_unlock function call
Date: Wed,  6 Sep 2017 11:20:37 +0530
Message-ID: <1504677037-3224-1-git-send-email-pushkar.iit@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pushkar Jambhlekar <pushkar.iit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Code can be optimized more by making single exit point of function and calling mutex_unlock at the end

Signed-off-by: Pushkar Jambhlekar <pushkar.iit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 3b6449e..da38833 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -232,20 +232,22 @@ static inline void smmu_flush(struct tegra_smmu *smmu)
 static int tegra_smmu_alloc_asid(struct tegra_smmu *smmu, unsigned int *idp)
 {
 	unsigned long id;
+	int ret = 0;
 
 	mutex_lock(&smmu->lock);
 
 	id = find_first_zero_bit(smmu->asids, smmu->soc->num_asids);
 	if (id >= smmu->soc->num_asids) {
-		mutex_unlock(&smmu->lock);
-		return -ENOSPC;
+		ret = -ENOSPC;
+		goto Exit;
 	}
 
 	set_bit(id, smmu->asids);
 	*idp = id;
 
+Exit:
 	mutex_unlock(&smmu->lock);
-	return 0;
+	return ret;
 }
 
 static void tegra_smmu_free_asid(struct tegra_smmu *smmu, unsigned int id)
-- 
2.7.4
