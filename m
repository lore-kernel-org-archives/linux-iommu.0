From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/1] iommu/tegra: smmu: Fix uninitialized var warning
Date: Fri, 18 May 2012 13:05:39 +0300
Message-ID: <1337335539-8466-1-git-send-email-hdoyu@nvidia.com>
References: <1337022975-23999-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1337022975-23999-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joerg.roedel-5C7GfCeVMHo@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

For the compiler warning, uninitialized var when getting value by a
pointer.

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
Depends:
	[v2 1/2] iommu/tegra: smmu: Simplify allocation at once
	http://marc.info/?l=linux-tegra&m=133706973614667&w=2
---
 drivers/iommu/tegra-smmu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 9c2a99e..192fc4a 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -903,8 +903,8 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	int i, err = 0;
 	u32 asids;
-	dma_addr_t base;
-	size_t bytes, size;
+	dma_addr_t uninitialized_var(base);
+	size_t bytes, uninitialized_var(size);
 
 	if (smmu_handle)
 		return -EIO;
-- 
1.7.5.4
