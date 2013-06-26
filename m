From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 21/23] iommu/tegra: smmu: Get swgroup ID from DT
Date: Wed, 26 Jun 2013 12:28:24 +0300
Message-ID: <1372238906-9346-22-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Get swgroup ID from DT. "nvidia,swgroups" indicates which swgroup IDs
a device belongs to.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/tegra30.dtsi |  1 -
 drivers/iommu/tegra-smmu.c     | 20 +++++++++++++++++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 7c480f2..a116737 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -1,6 +1,5 @@
 #include <dt-bindings/clock/tegra30-car.h>
 #include <dt-bindings/gpio/tegra-gpio.h>
-#include <dt-bindings/iommu/tegra-swgid.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include "skeleton.dtsi"
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 50eb843..96dbef3 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -314,6 +314,24 @@ static inline void smmu_write(struct smmu_device *smmu, u32 val, size_t offs)
 
 #define smmu_client_hwgrp(c)	(c->as->smmu->swgroups)
 
+static u64 tegra_smmu_of_get_swgids(struct device *dev)
+{
+	size_t bytes;
+	const char *propname = "nvidia,memory-clients";
+	const __be32 *prop;
+	int i;
+	u64 swgids = 0;
+
+	prop = of_get_property(dev->of_node, propname, &bytes);
+	if (!prop || !bytes)
+		return 0;
+
+	for (i = 0; i < bytes / sizeof(u32); i++, prop++)
+		swgids |= 1ULL << be32_to_cpup(prop);
+
+	return swgids;
+}
+
 static int __smmu_client_set_hwgrp(struct smmu_client *c,
 				   u64 map, int on)
 {
@@ -725,7 +743,7 @@ static int smmu_iommu_attach_dev(struct iommu_domain *domain,
 		return -ENOMEM;
 	client->dev = dev;
 	client->as = as;
-	map = smmu->swgroups;
+	map = tegra_smmu_of_get_swgids(dev);
 	if (!map)
 		return -EINVAL;
 
-- 
1.8.1.5
