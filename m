From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] iommu/tegra: smmu: Fix error initial value at domain_init
Date: Mon, 30 Jul 2012 08:39:19 +0300
Message-ID: <1343626759-20680-2-git-send-email-hdoyu@nvidia.com>
References: <1343626759-20680-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343626759-20680-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

err initial value should be -EAGAIN. Otherwise 2nd iteration always
fails in the case as[0] is occupied.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 2be5ac2..7c9174d 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -806,7 +806,7 @@ out:
 
 static int smmu_iommu_domain_init(struct iommu_domain *domain)
 {
-	int i, err = -ENODEV;
+	int i, err = -EAGAIN;
 	unsigned long flags;
 	struct smmu_as *as;
 	struct smmu_device *smmu = smmu_handle;
-- 
1.7.5.4
