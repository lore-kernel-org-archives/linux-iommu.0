From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] iommu/tegra: smmu: Cleanup with lesser nest
Date: Mon, 30 Jul 2012 08:39:18 +0300
Message-ID: <1343626759-20680-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Small clean up with lesser nest for readability.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 4ba325a..2be5ac2 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -814,11 +814,14 @@ static int smmu_iommu_domain_init(struct iommu_domain *domain)
 	/* Look for a free AS with lock held */
 	for  (i = 0; i < smmu->num_as; i++) {
 		as = &smmu->as[i];
-		if (!as->pdir_page) {
-			err = alloc_pdir(as);
-			if (!err)
-				goto found;
-		}
+
+		if (as->pdir_page)
+			continue;
+
+		err = alloc_pdir(as);
+		if (!err)
+			goto found;
+
 		if (err != -EAGAIN)
 			break;
 	}
-- 
1.7.5.4
