From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/6] iommu/tegra124: smmu: optionaly AHB enables SMMU
Date: Thu, 5 Dec 2013 14:25:14 +0200
Message-ID: <1386246319-17851-2-git-send-email-hdoyu@nvidia.com>
References: <1386246319-17851-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386246319-17851-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

SMMU used to depend on AHB bus. AHB driver needs to be populated and
AHB_XBAR_CTRL_SMMU_INIT_DONE bit needs to be set earliear than SMMU
being populated. Later Tegra SoC (>= T124) doesn't need AHB to enable
SMMU on AHB_XBAR_CTRL for AHB_XBAR_CTRL_SMMU_INIT_DONE any more. This
setting bit is now optional, depending on DT passing ahb phandle or
not.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index d0f0ba7..f63d54a 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -500,7 +500,10 @@ static int smmu_setup_regs(struct smmu_device *smmu)
 
 	smmu_flush_regs(smmu, 1);
 
-	return tegra_ahb_enable_smmu(smmu->ahb);
+	if (smmu->ahb)
+		return tegra_ahb_enable_smmu(smmu->ahb);
+
+	return 0;
 }
 
 static void flush_ptc_and_tlb(struct smmu_device *smmu,
@@ -1284,9 +1287,6 @@ static int tegra_smmu_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	smmu->ahb = of_parse_phandle(dev->of_node, "nvidia,ahb", 0);
-	if (!smmu->ahb)
-		return -ENODEV;
-
 	smmu->iommu.dev = dev;
 	smmu->num_as = asids;
 	smmu->iovmm_base = base;
-- 
1.8.1.5
