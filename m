From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCHv3 14/19] iommu/tegra: smmu: Get "nvidia,memory-clients" from DT
Date: Fri, 18 Oct 2013 13:26:55 +0300
Message-ID: <1382092020-13170-15-git-send-email-hdoyu@nvidia.com>
References: <1382092020-13170-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1382092020-13170-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This provides the info about which swgroups a device belongs to. This
info is passed from DT. This is necessary for the unified SMMU driver
among Tegra SoCs since each has different H/W accelerators.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 .../bindings/iommu/nvidia,tegra30-smmu.txt         | 16 ++++++++++++-
 drivers/iommu/tegra-smmu.c                         | 27 ++++++++++++++++++++--
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
index 6a844b3..7456104 100644
--- a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
@@ -13,9 +13,12 @@ Required properties:
   file <dt-bindings/memory/tegra-swgroup.h>. Its max is 64. 2 cells
   are required. This unique ID info can be used to calculate
   MC_SMMU_<SWGROUP name>_ASID_0 offset and HOTRESET bit.
+- nvidia,memory-clients: phandle to a smmu device which a device is
+  attached to and indicates which swgroups a device belongs to(SWGROUP ID).
+  SWGROUP ID is from 0 to 63, and a device can belong to multiple SWGROUPS.
 
 Example:
-	smmu {
+	smmu: iommu {
 		compatible = "nvidia,tegra30-smmu";
 		reg = <0x7000f010 0x02c
 		       0x7000f1f0 0x010
@@ -25,3 +28,14 @@ Example:
 		nvidia,swgroups = <0x00000000 0x000779ff>;
 		nvidia,ahb = <&ahb>;
 	};
+
+	host1x {
+		compatible = "nvidia,tegra30-host1x", "simple-bus";
+		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_HC>;
+		....
+		gr3d {
+			compatible = "nvidia,tegra30-gr3d";
+			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_NV
+						       TEGRA_SWGROUP_NV2>;
+			....
+		};
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index f0ff48e..1db9e89 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -368,6 +368,29 @@ static inline void smmu_write(struct smmu_device *smmu, u32 val, size_t offs)
 
 #define smmu_client_hwgrp(c)	(c->as->smmu->swgroups)
 
+static u64 smmu_of_get_memory_client(struct device *dev)
+{
+	size_t bytes;
+	const char *propname = "nvidia,memory-clients";
+	const __be32 *prop;
+	int i;
+	u64 swgroup = 0;
+	struct device_node *np;
+
+	np = of_parse_phandle(dev->of_node, propname, 0);
+	if (np != smmu_handle->dev->of_node)
+		return ~0;
+
+	prop = of_get_property(dev->of_node, propname, &bytes);
+	if (!prop || !bytes)
+		return ~0;
+
+	for (i = 1; i < bytes / sizeof(u32); i++, prop++)
+		swgroup |= 1ULL << be32_to_cpup(prop);
+
+	return swgroup;
+}
+
 static int __smmu_client_set_hwgrp(struct smmu_client *c,
 				   u64 map, int on)
 {
@@ -779,8 +802,8 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 		return -ENOMEM;
 	client->dev = dev;
 	client->as = as;
-	map = smmu->swgroups;
-	if (!map)
+	map = smmu_of_get_memory_client(dev);
+	if (map == ~0)
 		return -EINVAL;
 
 	err = smmu_client_enable_hwgrp(client, map);
-- 
1.8.1.5
