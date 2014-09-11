From: Kiran Padwal <kiran.padwal@smartplayin.com>
Subject: [PATCH] iommu: Make of_device_id array const
Date: Thu, 11 Sep 2014 19:07:36 +0530
Message-ID: <1410442656-21112-1-git-send-email-kiran.padwal@smartplayin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com, joro@8bytes.org, hdoyu@nvidia.com, swarren@wwwdotorg.org, thierry.reding@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Kiran Padwal <kiran.padwal@smartplayin.com>
List-Id: iommu@lists.linux-foundation.org

Make of_device_id array const, because all OF functions handle it as const.

Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
---
 drivers/iommu/arm-smmu.c   |    2 +-
 drivers/iommu/omap-iommu.c |    2 +-
 drivers/iommu/tegra-gart.c |    2 +-
 drivers/iommu/tegra-smmu.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index ca18d6d..095f4e5 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1993,7 +1993,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_OF
-static struct of_device_id arm_smmu_of_match[] = {
+static const struct of_device_id arm_smmu_of_match[] = {
 	{ .compatible = "arm,smmu-v1", },
 	{ .compatible = "arm,smmu-v2", },
 	{ .compatible = "arm,mmu-400", },
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index e202b0c..47517cf 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1006,7 +1006,7 @@ static int omap_iommu_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id omap_iommu_of_match[] = {
+static const struct of_device_id omap_iommu_of_match[] = {
 	{ .compatible = "ti,omap2-iommu" },
 	{ .compatible = "ti,omap4-iommu" },
 	{ .compatible = "ti,dra7-iommu"	},
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index b10a8ec..d6a3a09 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -416,7 +416,7 @@ static const struct dev_pm_ops tegra_gart_pm_ops = {
 	.resume		= tegra_gart_resume,
 };
 
-static struct of_device_id tegra_gart_of_match[] = {
+static const struct of_device_id tegra_gart_of_match[] = {
 	{ .compatible = "nvidia,tegra20-gart", },
 	{ },
 };
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 3ded389..05860a4 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -1260,7 +1260,7 @@ static const struct dev_pm_ops tegra_smmu_pm_ops = {
 	.resume		= tegra_smmu_resume,
 };
 
-static struct of_device_id tegra_smmu_of_match[] = {
+static const struct of_device_id tegra_smmu_of_match[] = {
 	{ .compatible = "nvidia,tegra30-smmu", },
 	{ },
 };
-- 
1.7.9.5
