From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 20/22] iommu/tegra: smmu: Get "nvidia,memory-client" from DT
Date: Fri, 5 Jul 2013 13:44:55 +0300
Message-ID: <1373021097-32420-21-git-send-email-hdoyu@nvidia.com>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1373021097-32420-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This provides the info about which swgroups a device belongs to. This
info is passed from DT. This is necessary for the unified SMMU driver
among Tegra SoCs since each has different H/W accelerators.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 .../bindings/iommu/nvidia,tegra30-smmu.txt         |   12 ++++++++++++
 drivers/iommu/tegra-smmu.c                         |   20 +++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
index 0c14dca..20ce1fb 100644
--- a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
@@ -11,6 +11,7 @@ Required properties:
 - nvidia,swgroups: A bitmap of supported HardWare Accelerators(HWA).
   Each bit represents one swgroup. The assignments may be found in header
   file <dt-bindings/memory/tegra-swgroup.h>.
+- nvidia,memory-client: Indicates which swgroups a device belongs to.
 
 Example:
 	iommu {
@@ -23,3 +24,14 @@ Example:
 		nvidia,swgroups = TEGRA30_SWGROUP_ALL;
 		nvidia,ahb = <&ahb>;
 	};
+
+	host1x {
+		compatible = "nvidia,tegra30-host1x", "simple-bus";
+		nvidia,memory-client = <TEGRA_SWGROUP_HC>;
+		....
+		gr3d {
+			compatible = "nvidia,tegra30-gr3d";
+			nvidia,memory-client = <TEGRA_SWGROUP_NV
+						TEGRA_SWGROUP_NV2>;
+			....
+		};
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index ac5d661..8a9434e 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -314,6 +314,24 @@ static inline void smmu_write(struct smmu_device *smmu, u32 val, size_t offs)
 
 #define smmu_client_hwgrp(c)	(c->as->smmu->swgroup)
 
+static u64 smmu_of_get_memory_client(struct device *dev)
+{
+	size_t bytes;
+	const char *propname = "nvidia,memory-client";
+	const __be32 *prop;
+	int i;
+	u64 swgroup = 0;
+
+	prop = of_get_property(dev->of_node, propname, &bytes);
+	if (!prop || !bytes)
+		return 0;
+
+	for (i = 0; i < bytes / sizeof(u32); i++, prop++)
+		swgroup |= 1ULL << be32_to_cpup(prop);
+
+	return swgroup;
+}
+
 static int __smmu_client_set_hwgrp(struct smmu_client *c,
 				   u64 map, int on)
 {
@@ -725,7 +743,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 		return -ENOMEM;
 	client->dev = dev;
 	client->as = as;
-	map = smmu->swgroup;
+	map = smmu_of_get_memory_client(dev);
 	if (!map)
 		return -EINVAL;
 
-- 
1.7.9.5
