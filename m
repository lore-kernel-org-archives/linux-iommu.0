From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 23/29] iommu: exynos: init iommu controllers from device tree
Date: Tue, 05 Aug 2014 12:47:51 +0200
Message-ID: <1407235677-26324-24-git-send-email-m.szyprowski@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linaro-mm-sig@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Shaik Ameer Basha <shaik.ameer@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Olof Johansson <olof@lixom.net>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: iommu@lists.linux-foundation.org

This patch adds code to initialize and assign SYSMMU controllers to
their master devices defined in device tree.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 152 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 145 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 46e0edc..845f547 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/mm.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/iommu.h>
 #include <linux/errno.h>
 #include <linux/list.h>
@@ -211,6 +212,9 @@ struct sysmmu_drvdata {
 	struct list_head owner_node;
 	phys_addr_t pgtable;
 	int version;
+	const char *name;
+	dma_addr_t base;
+	size_t size;
 };
 
 static bool set_sysmmu_active(struct sysmmu_drvdata *data)
@@ -574,6 +578,11 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 	}
 
 	data->sysmmu = dev;
+
+	/* default io address space parameters */
+	data->base = SZ_1G;
+	data->size = SZ_2G;
+
 	spin_lock_init(&data->lock);
 
 	platform_set_drvdata(pdev, data);
@@ -1055,30 +1064,159 @@ static phys_addr_t exynos_iommu_iova_to_phys(struct iommu_domain *domain,
 	return phys;
 }
 
+static void __free_owner_struct(struct exynos_iommu_owner *owner,
+				struct device *dev)
+{
+	while (!list_empty(&owner->clients))
+		list_del_init(owner->clients.next);
+
+	kfree(owner);
+	dev->archdata.iommu = NULL;
+}
+
+static int __init_master_sysmmu(struct device *dev)
+{
+	struct of_phandle_args sysmmu_spec;
+	struct exynos_iommu_owner *owner;
+	int i = 0;
+	int ret;
+
+	owner = kzalloc(sizeof(*owner), GFP_KERNEL);
+	if (!owner)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&owner->clients);
+
+	while (!of_parse_phandle_with_args(dev->of_node, "iommus",
+					   "#iommu-cells", i,
+					   &sysmmu_spec)) {
+		struct platform_device *sysmmu;
+		struct sysmmu_drvdata *data;
+
+		sysmmu = of_find_device_by_node(sysmmu_spec.np);
+		if (!sysmmu) {
+			dev_err(dev, "sysmmu node not found\n");
+			ret = -ENODEV;
+			goto err;
+		}
+		data = platform_get_drvdata(sysmmu);
+		if (!data) {
+			ret = -ENODEV;
+			goto err;
+		}
+
+		of_property_read_string_index(dev->of_node, "iommu-names", i,
+					      &data->name);
+
+		if (sysmmu_spec.args_count == 2) {
+			data->base = sysmmu_spec.args[0];
+			data->size = sysmmu_spec.args[1];
+		} else if (sysmmu_spec.args_count != 0) {
+			dev_err(dev, "incorrect iommu property specified\n");
+			ret = -EINVAL;
+			goto err;
+		}
+
+		list_add_tail(&data->owner_node, &owner->clients);
+
+		i++;
+	}
+
+	if (i == 0) {
+		ret = -ENODEV;
+		goto err;
+	}
+
+	dev->archdata.iommu = owner;
+	dev_dbg(dev, "registered %d sysmmu controllers\n", i);
+
+	return 0;
+err:
+	__free_owner_struct(owner, dev);
+	return ret;
+}
+
+static int __init_subdevice_sysmmu(struct device *dev)
+{
+	struct device *parent = dev->parent;
+	struct exynos_iommu_owner *owner;
+	struct sysmmu_drvdata *data;
+	char *name;
+
+	name = strrchr(dev_name(dev), ':');
+	if (!name)
+		return -ENODEV;
+	name++;
+
+	owner = parent->archdata.iommu;
+	if (!owner)
+		return -ENODEV;
+
+	list_for_each_entry(data, &owner->clients, owner_node)
+		if (strcmp(name, data->name) == 0)
+			break;
+	if (!data)
+		return -ENODEV;
+
+	owner = kzalloc(sizeof(*owner), GFP_KERNEL);
+	if (!owner)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&owner->clients);
+
+	/* move sysmmu from parent to child device */
+	list_del(&data->owner_node);
+	list_add_tail(&data->owner_node, &owner->clients);
+
+	dev->archdata.iommu = owner;
+	dev_dbg(dev->parent,
+		"registered sysmmu controller for %s subdevice\n", data->name);
+
+	return 0;
+}
+
 static int exynos_iommu_add_device(struct device *dev)
 {
 	struct iommu_group *group;
 	int ret;
 
-	group = iommu_group_get(dev);
+	BUG_ON(dev->archdata.iommu != NULL);
 
-	if (!group) {
-		group = iommu_group_alloc();
-		if (IS_ERR(group)) {
-			dev_err(dev, "Failed to allocate IOMMU group\n");
-			return PTR_ERR(group);
-		}
+	if (of_get_property(dev->of_node, "iommus", NULL))
+		ret = __init_master_sysmmu(dev);
+	else if (dev->parent &&
+		 of_get_property(dev->parent->of_node, "iommus", NULL))
+		ret = __init_subdevice_sysmmu(dev);
+	else
+		return -ENODEV;
+
+	if (ret)
+		return ret;
+
+	group = iommu_group_alloc();
+	if (IS_ERR(group)) {
+		dev_err(dev, "Failed to allocate IOMMU group\n");
+		ret = PTR_ERR(group);
+		goto err;
 	}
 
 	ret = iommu_group_add_device(group, dev);
+	if (ret != 0)
+		goto err;
+
 	iommu_group_put(group);
 
+	return 0;
+err:
+	__free_owner_struct(dev->archdata.iommu, dev);
 	return ret;
 }
 
 static void exynos_iommu_remove_device(struct device *dev)
 {
+	struct exynos_iommu_owner *owner = dev->archdata.iommu;
+
 	iommu_group_remove_device(dev);
+	if (owner)
+		__free_owner_struct(owner, dev);
 }
 
 static const struct iommu_ops exynos_iommu_ops = {
-- 
1.9.2
