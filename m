From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [v3 5/5] iommu/tegra: smmu: Fix uninitialized var warning
Date: Mon, 25 Jun 2012 14:23:58 +0300
Message-ID: <1340623438-14958-5-git-send-email-hdoyu@nvidia.com>
References: <1340623438-14958-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1340623438-14958-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

For the compiler warning, uninitizlized var when getting value by a
pointer.

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index cc6aba4..becfc61 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -902,8 +902,8 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	struct smmu_device *smmu;
 	struct device *dev = &pdev->dev;
 	int i, asids, err = 0;
-	dma_addr_t base;
-	size_t bytes, size;
+	dma_addr_t uninitialized_var(base);
+	size_t bytes, uninitialized_var(size);
 
 	if (smmu_handle)
 		return -EIO;
-- 
1.7.5.4
