From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] iommu: arm-smmu: Handle return of iommu_device_register.
Date: Thu, 22 Jun 2017 12:57:42 +0530
Message-ID: <e7d7a3939197315309e1fd3549d1db90315cc8bf.1498116422.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

iommu_device_register can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/iommu/arm-smmu-v3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 7d3f08a..182eb38 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -2736,6 +2736,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	iommu_device_set_fwnode(&smmu->iommu, dev->fwnode);
 
 	ret = iommu_device_register(&smmu->iommu);
+	if (ret)
+		return ret;
 
 #ifdef CONFIG_PCI
 	if (pci_bus_type.iommu_ops != &arm_smmu_ops) {
-- 
1.9.1
