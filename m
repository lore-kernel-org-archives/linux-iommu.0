From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v2 4/4] iommu/rockchip: Move irq request past pm_runtime_enable
Date: Fri, 24 Aug 2018 16:06:37 +0100
Message-ID: <20180824150637.15316-5-marc.zyngier@arm.com>
References: <20180824150637.15316-1-marc.zyngier@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180824150637.15316-1-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Heiko Stuebner <heiko@sntech.de>, Jeffy Chen <jeffy.chen@rock-chips.com>, arm@kernel.org
List-Id: iommu@lists.linux-foundation.org

Enabling the interrupt early, before power has been applied to the
device, can result in an interrupt being delivered too early if:

- the IOMMU shares an interrupt with a VOP
- the VOP has a pending interrupt (after a kexec, for example)

In these conditions, we end-up taking the interrupt without
the IOMMU being ready to handle the interrupt (not powered on).

Moving the interrupt request past the pm_runtime_enable() call
makes sure we can at least access the IOMMU registers. Note that
this is only a partial fix, and that the VOP interrupt will still
be screaming until the VOP driver kicks in, which advocates for
a more synchronized interrupt enabling/disabling approach.

Fixes: 0f181d3cf7d98 ("iommu/rockchip: Add runtime PM support")
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/iommu/rockchip-iommu.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 4e0f9b61cd7f..2b1724e8d307 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1161,17 +1161,6 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (iommu->num_mmu == 0)
 		return PTR_ERR(iommu->bases[0]);
 
-	i = 0;
-	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO) {
-		if (irq < 0)
-			return irq;
-
-		err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
-				       IRQF_SHARED, dev_name(dev), iommu);
-		if (err)
-			return err;
-	}
-
 	iommu->reset_disabled = device_property_read_bool(dev,
 					"rockchip,disable-mmu-reset");
 
@@ -1228,6 +1217,19 @@ static int rk_iommu_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
+	i = 0;
+	while ((irq = platform_get_irq(pdev, i++)) != -ENXIO) {
+		if (irq < 0)
+			return irq;
+
+		err = devm_request_irq(iommu->dev, irq, rk_iommu_irq,
+				       IRQF_SHARED, dev_name(dev), iommu);
+		if (err) {
+			pm_runtime_disable(dev);
+			goto err_remove_sysfs;
+		}
+	}
+
 	return 0;
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
-- 
2.18.0
