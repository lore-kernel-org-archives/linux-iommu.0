From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 9/9] iommu/tegra: Use helper functions to access dev->iommu_fwspec
Date: Tue,  4 Dec 2018 17:30:02 +0100
Message-ID: <20181204163002.15800-10-joro@8bytes.org>
References: <20181204163002.15800-1-joro@8bytes.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204163002.15800-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>, Thierry Reding <thierry.reding@gmail.com>
List-Id: iommu@lists.linux-foundation.org

From: Joerg Roedel <jroedel@suse.de>

Use the new helpers dev_iommu_fwspec_get()/set() to access
the dev->iommu_fwspec pointer. This makes it easier to move
that pointer later into another struct.

Cc: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/tegra-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 0d03341317c4..0d026cb2dfff 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -846,7 +846,7 @@ static struct iommu_group *tegra_smmu_group_get(struct tegra_smmu *smmu,
 
 static struct iommu_group *tegra_smmu_device_group(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct tegra_smmu *smmu = dev->archdata.iommu;
 	struct iommu_group *group;
 
-- 
2.17.1
