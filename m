From: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v4 3/5] iommu/arm-smmu: add support for non-pci devices
Date: Thu, 15 Oct 2015 16:30:45 +0800
Message-ID: <1444897847-18040-4-git-send-email-thunder.leizhen@huawei.com>
References: <1444897847-18040-1-git-send-email-thunder.leizhen@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444897847-18040-1-git-send-email-thunder.leizhen@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-kernel <linux-kernel@vger.kernel.org>
Cc: Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>, Tianhong Ding <dingtianhong@huawei.com>, Hanjun Guo <guohanjun@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>
List-Id: iommu@lists.linux-foundation.org

This patch support a master with multiple stream IDs, but doesn't support a
master behinds more than one SMMUs.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index b577d61..021a846 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -31,6 +31,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/of_iommu.h>
+#include <linux/amba/bus.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>

@@ -1938,9 +1939,36 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
 		return -EINVAL;
 	}

-	/* We only support PCI, for now */
 	if (!dev_is_pci(dev)) {
-		return -ENODEV;
+		struct iommu_group *group;
+
+		if (args->args_count != 1) {
+			dev_err(dev,
+				"only support #iommu-cells = <1>, please check node: %s\n",
+				dev_name(smmu->dev));
+			return -ENODEV;
+		}
+
+		group = iommu_group_get(dev);
+		if (!group) {
+			group = iommu_group_alloc();
+			if (IS_ERR(group)) {
+				dev_err(dev, "failed to allocate IOMMU group\n");
+				return PTR_ERR(group);
+			}
+
+			ret = iommu_group_add_device(group, dev);
+			if (ret) {
+				iommu_group_put(group);
+				dev_err(dev, "failed to add device into IOMMU group\n");
+				return ret;
+			}
+		}
+		iommu_group_put(group);
+
+		ret = __arm_smmu_add_device(dev, args->args[0]);
+		if (ret)
+			return ret;
 	} else {
 		struct device *root;
 		struct pci_dev *pdev = NULL;
@@ -2793,6 +2821,14 @@ static int __init arm_smmu_init(void)
 	if (ret)
 		return ret;

+	if (!iommu_present(&platform_bus_type))
+		bus_set_iommu(&platform_bus_type, &arm_smmu_ops);
+
+#ifdef CONFIG_ARM_AMBA
+	if (!iommu_present(&amba_bustype))
+		bus_set_iommu(&amba_bustype, &arm_smmu_ops);
+#endif
+
 	return bus_set_iommu(&pci_bus_type, &arm_smmu_ops);
 }

--
2.5.0
