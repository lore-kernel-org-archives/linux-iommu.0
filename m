From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH v7 14/14] iommu/rockchip: Support sharing IOMMU between masters
Date: Tue,  6 Mar 2018 11:27:59 +0800
Message-ID: <20180306032759.29069-5-jeffy.chen@rock-chips.com>
References: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
 <20180306032759.29069-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180306032759.29069-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, xxm@rock-chips.com, tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

There would be some masters sharing the same IOMMU device. Put them in
the same iommu group and share the same iommu domain.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---

Changes in v7:
Use iommu_group_ref_get to avoid ref leak

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3:
Remove rk_iommudata->domain.

Changes in v2: None

 drivers/iommu/rockchip-iommu.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index db08978203f7..6a1c7efa7c17 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -104,6 +104,7 @@ struct rk_iommu {
 	struct iommu_device iommu;
 	struct list_head node; /* entry in rk_iommu_domain.iommus */
 	struct iommu_domain *domain; /* domain to which iommu is attached */
+	struct iommu_group *group;
 };
 
 /**
@@ -1091,6 +1092,15 @@ static void rk_iommu_remove_device(struct device *dev)
 	iommu_group_remove_device(dev);
 }
 
+static struct iommu_group *rk_iommu_device_group(struct device *dev)
+{
+	struct rk_iommu *iommu;
+
+	iommu = rk_iommu_from_dev(dev);
+
+	return iommu_group_ref_get(iommu->group);
+}
+
 static int rk_iommu_of_xlate(struct device *dev,
 			     struct of_phandle_args *args)
 {
@@ -1122,7 +1132,7 @@ static const struct iommu_ops rk_iommu_ops = {
 	.add_device = rk_iommu_add_device,
 	.remove_device = rk_iommu_remove_device,
 	.iova_to_phys = rk_iommu_iova_to_phys,
-	.device_group = generic_device_group,
+	.device_group = rk_iommu_device_group,
 	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
 	.of_xlate = rk_iommu_of_xlate,
 };
@@ -1191,9 +1201,15 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	iommu->group = iommu_group_alloc();
+	if (IS_ERR(iommu->group)) {
+		err = PTR_ERR(iommu->group);
+		goto err_unprepare_clocks;
+	}
+
 	err = iommu_device_sysfs_add(&iommu->iommu, dev, NULL, dev_name(dev));
 	if (err)
-		goto err_unprepare_clocks;
+		goto err_put_group;
 
 	iommu_device_set_ops(&iommu->iommu, &rk_iommu_ops);
 	iommu_device_set_fwnode(&iommu->iommu, &dev->of_node->fwnode);
@@ -1217,6 +1233,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	return 0;
 err_remove_sysfs:
 	iommu_device_sysfs_remove(&iommu->iommu);
+err_put_group:
+	iommu_group_put(iommu->group);
 err_unprepare_clocks:
 	clk_bulk_unprepare(iommu->num_clocks, iommu->clocks);
 	return err;
-- 
2.11.0
