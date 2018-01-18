From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v4 13/13] iommu/rockchip: Support sharing IOMMU between masters
Date: Thu, 18 Jan 2018 19:52:51 +0800
Message-ID: <20180118115251.5542-14-jeffy.chen@rock-chips.com>
References: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180118115251.5542-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com, tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

There would be some masters sharing the same IOMMU device. Put them in
the same iommu group and share the same iommu domain.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v4: None
Changes in v3:
Remove rk_iommudata->domain.

Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index e2e7acc3039d..e07929bbcc2a 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -97,6 +97,7 @@ struct rk_iommu {
 	struct iommu_device iommu;
 	struct list_head node; /* entry in rk_iommu_domain.iommus */
 	struct iommu_domain *domain; /* domain to which iommu is attached */
+	struct iommu_group *group;
 };
 
 struct rk_iommudata {
@@ -1157,6 +1158,15 @@ static void rk_iommu_remove_device(struct device *dev)
 	iommu_group_remove_device(dev);
 }
 
+static struct iommu_group *rk_iommu_device_group(struct device *dev)
+{
+	struct rk_iommu *iommu;
+
+	iommu = rk_iommu_from_dev(dev);
+
+	return iommu->group;
+}
+
 static int rk_iommu_of_xlate(struct device *dev,
 			     struct of_phandle_args *args)
 {
@@ -1192,7 +1202,7 @@ static const struct iommu_ops rk_iommu_ops = {
 	.add_device = rk_iommu_add_device,
 	.remove_device = rk_iommu_remove_device,
 	.iova_to_phys = rk_iommu_iova_to_phys,
-	.device_group = generic_device_group,
+	.device_group = rk_iommu_device_group,
 	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
 	.of_xlate = rk_iommu_of_xlate,
 };
@@ -1248,9 +1258,15 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	iommu->reset_disabled = device_property_read_bool(dev,
 					"rockchip,disable-mmu-reset");
 
+	iommu->group = iommu_group_alloc();
+	if (IS_ERR(iommu->group)) {
+		err = PTR_ERR(iommu->group);
+		goto err_put_clocks;
+	}
+
 	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
 	if (err)
-		goto err_put_clocks;
+		goto err_put_group;
 
 	iommu_device_set_ops(&iommu->iommu, &rk_iommu_ops);
 	iommu_device_set_fwnode(&iommu->iommu, &dev->of_node->fwnode);
@@ -1274,6 +1290,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	return 0;
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
+err_put_group:
+	iommu_group_put(iommu->group);
 err_put_clocks:
 	rk_iommu_put_clocks(iommu);
 	return err;
-- 
2.11.0
