From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v7 14/24] memory: tegra: Do not try to probe SMMU on Tegra20
Date: Wed, 12 Dec 2018 23:38:57 +0300
Message-ID: <20181212203907.23461-15-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Tegra20 doesn't have SMMU. Move out checking of the SMMU presence from
the SMMU driver into the Memory Controller driver. This change makes code
consistent in regards to how GART/SMMU presence checking is performed.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 4 ----
 drivers/memory/tegra/mc.c  | 6 ++++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 97b3c0461831..32ea81e9f012 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -982,10 +982,6 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 	u32 value;
 	int err;
 
-	/* This can happen on Tegra20 which doesn't have an SMMU */
-	if (!soc)
-		return NULL;
-
 	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index e684e234361a..3545868c51c0 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -695,11 +695,13 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to register reset controller: %d\n",
 			err);
 
-	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_SMMU)) {
+	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_SMMU) && mc->soc->smmu) {
 		mc->smmu = tegra_smmu_probe(&pdev->dev, mc->soc->smmu, mc);
-		if (IS_ERR(mc->smmu))
+		if (IS_ERR(mc->smmu)) {
 			dev_err(&pdev->dev, "failed to probe SMMU: %ld\n",
 				PTR_ERR(mc->smmu));
+			mc->smmu = NULL;
+		}
 	}
 
 	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_GART) && !mc->soc->smmu) {
-- 
2.20.0
