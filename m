From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH 9/9] iommu/rockchip: Use OF_IOMMU to attach devices automatically
Date: Thu, 11 Jan 2018 16:22:29 +0800
Message-ID: <20180111082229.24011-10-jeffy.chen@rock-chips.com>
References: <20180111082229.24011-1-jeffy.chen@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180111082229.24011-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jcliang@chromium.org, robin.murphy@arm.com, tfiga@chromium.org, Jeffy Chen <jeffy.chen@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Converts the rockchip-iommu driver to use the OF_IOMMU infrastructure,
which allows attaching master devices to their IOMMUs automatically
according to DT properties.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/iommu/rockchip-iommu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index ab18a80fdd12..c375a2522bfd 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_iommu.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -1091,6 +1092,13 @@ static struct iommu_group *rk_iommu_device_group(struct device *dev)
 	return ERR_PTR(ret);
 }
 
+static int rk_iommu_of_xlate(struct device *dev,
+			     struct of_phandle_args *spec)
+{
+	/* We don't have any phandle args, so just return 0. */
+	return 0;
+}
+
 static const struct iommu_ops rk_iommu_ops = {
 	.domain_alloc = rk_iommu_domain_alloc,
 	.domain_free = rk_iommu_domain_free,
@@ -1104,6 +1112,7 @@ static const struct iommu_ops rk_iommu_ops = {
 	.iova_to_phys = rk_iommu_iova_to_phys,
 	.device_group = rk_iommu_device_group,
 	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
+	.of_xlate = rk_iommu_of_xlate,
 };
 
 static int rk_iommu_probe(struct platform_device *pdev)
@@ -1166,6 +1175,8 @@ static int rk_iommu_probe(struct platform_device *pdev)
 		return err;
 
 	iommu_device_set_ops(&iommu->iommu, &rk_iommu_ops);
+	iommu_device_set_fwnode(&iommu->iommu, &dev->of_node->fwnode);
+
 	err = iommu_device_register(&iommu->iommu);
 	if (err) {
 		iommu_device_sysfs_remove(&iommu->iommu);
@@ -1241,6 +1252,8 @@ static void __exit rk_iommu_exit(void)
 subsys_initcall(rk_iommu_init);
 module_exit(rk_iommu_exit);
 
+IOMMU_OF_DECLARE(rk_iommu_of, "rockchip,iommu");
+
 MODULE_DESCRIPTION("IOMMU API for Rockchip");
 MODULE_AUTHOR("Simon Xue <xxm@rock-chips.com> and Daniel Kurtz <djkurtz@chromium.org>");
 MODULE_ALIAS("platform:rockchip-iommu");
-- 
2.11.0
