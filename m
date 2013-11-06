From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [RFC][PATCHv3+ 1/2] driver/core: Add of_iommu_attach()
Date: Wed, 6 Nov 2013 16:06:23 +0200
Message-ID: <20131106160623.2cb72f91cd071e555d0d4b9a@nvidia.com>
References: <52718122.9000206@wwwdotorg.org>
	<20131031.101232.80781047726461143.hdoyu@nvidia.com>
	<527286CC.9080404@wwwdotorg.org>
	<20131031.184603.979300613649357798.hdoyu@nvidia.com>
	<52729912.9050800@wwwdotorg.org>
	<20131101084909.5ed79987aa3aeb13b14e3f08@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Wed__6_Nov_2013_16_06_23_+0200_O3OzF1QGrKrub1GW"
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131101084909.5ed79987aa3aeb13b14e3f08-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

--Multipart=_Wed__6_Nov_2013_16_06_23_+0200_O3OzF1QGrKrub1GW
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hi,

Experimentally I have implemented "of_iommu_attach()" called from
drvier/core to control the order of device instanciation.

In the Tegra SMMU PATCHv3, we've discussed how to control the order of
device instanciation. Thierry/Stephen proposed to insert a hook in
driver/core to control this order, depending on whether an iommu
device is ready or not."of_iommu_attach()" is implement for that
purpose now. Along with this patch, I attached DT part of modication
to this mail. I used the same iommu bindings which arm,smmu uses.

[RFC][PATCHv3+ 2/2] ARM: DT: tegra30: iommu: Add "stream-id-cells"/"mmu-masters"

"#stream-id-cells" is used to identify whether a device is IOMMU'able
or not. If a device is IOMMU'able, we'll defer to instanciate that
device till an iommu device is instanciated/ready. Once an iommu device
is instanciated, "dev->bus->iommu_ops" is set in the bus. After an
iommu device is instanciated, those defered devices are instanciated
as IOMMU'able with help of the iommu driver via iommu_ops->add_device().

We don't call bus_set_iommu() until an iommu device is instanciated
because we need to support 2 kind of IOMMU drivers, SMMU and GART so
that this bus_set_iommu() needs to be defered till an iommu device is
instanciated. So the single image can support 2 iommu drivers at once.

With this patch, the following HACK patches in v3[1] are not needed
anymore.

  patch 1: [HACK] of: dev_node has struct device pointer
  patch 2: [HACK] ARM: tegra: Populate AHB/IOMMU earlier than others
  patch 3: [HACK] amba: Move AHB to core_initcall
  patch 4: [HACK] iommu/tegra: smmu: Move IOMMU to core_initcall

Any comment would be really appreciated.

[1] Original v3:
http://lists.linuxfoundation.org/pipermail/iommu/2013-October/006724.html

[2]
http://lists.linuxfoundation.org/pipermail/iommu/2013-November/006864.html

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/base/dd.c        |  5 +++++
 drivers/iommu/of_iommu.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/iommu.h    |  7 +++++++
 3 files changed, 46 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 35fa368..ca76290 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -25,6 +25,7 @@
 #include <linux/async.h>
 #include <linux/pm_runtime.h>
 #include <linux/pinctrl/devinfo.h>
+#include <linux/iommu.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -273,6 +274,10 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 
 	dev->driver = drv;
 
+	ret = of_iommu_attach(dev);
+	if (ret)
+		goto probe_failed;
+
 	/* If using pinctrl, bind pins now before probing */
 	ret = pinctrl_bind_pins(dev);
 	if (ret)
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index ee249bc..f211cdc 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -20,6 +20,9 @@
 #include <linux/export.h>
 #include <linux/limits.h>
 #include <linux/of.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/iommu.h>
 
 /**
  * of_get_dma_window - Parse *dma-window property and returns 0 if found.
@@ -88,3 +91,34 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_get_dma_window);
+
+static bool of_is_iommuable(struct device *dev)
+{
+	size_t bytes;
+	const __be32 *prop;
+	const char *propname = "#stream-id-cells";
+
+	prop = of_get_property(dev->of_node, propname, &bytes);
+	if (!prop || !bytes)
+		return false;
+
+	pr_debug("%s=%d %s\n", propname, bytes, dev_name(dev));
+	return true;
+}
+
+int of_iommu_attach(struct device *dev)
+{
+	struct iommu_ops *ops;
+
+	if (!of_is_iommuable(dev))
+		return 0;
+
+	ops = dev->bus->iommu_ops;
+	if (!ops)
+		return -EPROBE_DEFER;
+
+	if (ops->add_device)
+		return ops->add_device(dev);
+
+	return 0;
+}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a444c79..de16bf2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -232,6 +232,8 @@ static inline int report_iommu_fault(struct iommu_domain *domain,
 	return ret;
 }
 
+extern int of_iommu_attach(struct device *dev);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -390,6 +392,11 @@ static inline int iommu_domain_set_attr(struct iommu_domain *domain,
 	return -EINVAL;
 }
 
+static inline int of_iommu_attach(struct device *dev)
+{
+	return 0;
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #endif /* __LINUX_IOMMU_H */
-- 
1.8.1.5


--Multipart=_Wed__6_Nov_2013_16_06_23_+0200_O3OzF1QGrKrub1GW
Content-Type: text/x-diff;
	name="0002-ARM-DT-tegra30-iommu-Add-stream-id-cells-mmu-masters.patch"
Content-Disposition: attachment;
	filename="0002-ARM-DT-tegra30-iommu-Add-stream-id-cells-mmu-masters.patch"
Content-Transfer-Encoding: 7bit

>From fa49c864c1b05df6de16cfc2d12f74fcae843e55 Mon Sep 17 00:00:00 2001
From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Date: Wed, 6 Nov 2013 15:27:03 +0200
Subject: [RFC][PATCHv3+ 2/2] ARM: DT: tegra30: iommu: Add
 "stream-id-cells"/"mmu-masters"

Follow the same syntax as arm,smmu.

FIXME: "nvidia,memory-clients" should be removed.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/tegra30.dtsi | 63 +++++++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 4c7f296..5913ec9 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -87,60 +87,66 @@
 		};
 	};
 
-	host1x {
+	host1x: host1x {
 		compatible = "nvidia,tegra30-host1x", "simple-bus";
 		reg = <0x50000000 0x00024000>;
 		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>, /* syncpt */
 			     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>; /* general */
 		clocks = <&tegra_car TEGRA30_CLK_HOST1X>;
 		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_HC>;
+		#stream-id-cells = <1>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
 
 		ranges = <0x54000000 0x54000000 0x04000000>;
 
-		mpe {
+		mpe: mpe {
 			compatible = "nvidia,tegra30-mpe";
 			reg = <0x54040000 0x00040000>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_MPE>;
 			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_MPE>;
+			#stream-id-cells = <1>;
 		};
 
-		vi {
+		vi: vi {
 			compatible = "nvidia,tegra30-vi";
 			reg = <0x54080000 0x00040000>;
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_VI>;
 			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_VI>;
+			#stream-id-cells = <1>;
 		};
 
-		epp {
+		epp: epp {
 			compatible = "nvidia,tegra30-epp";
 			reg = <0x540c0000 0x00040000>;
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_EPP>;
 			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_EPP>;
+			#stream-id-cells = <1>;
 		};
 
-		isp {
+		isp: isp {
 			compatible = "nvidia,tegra30-isp";
 			reg = <0x54100000 0x00040000>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_ISP>;
 			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_ISP>;
+			#stream-id-cells = <1>;
 		};
 
-		gr2d {
+		gr2d: gr2d {
 			compatible = "nvidia,tegra30-gr2d";
 			reg = <0x54140000 0x00040000>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_GR2D>;
 			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_G2>;
+			#stream-id-cells = <1>;
 		};
 
-		gr3d {
+		gr3d: gr3d {
 			compatible = "nvidia,tegra30-gr3d";
 			reg = <0x54180000 0x00040000>;
 			clocks = <&tegra_car TEGRA30_CLK_GR3D
@@ -148,9 +154,10 @@
 			clock-names = "3d", "3d2";
 			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_NV
 						TEGRA_SWGROUP_NV2>;
+			#stream-id-cells = <2>;
 		};
 
-		dc@54200000 {
+		dc: dc@54200000 {
 			compatible = "nvidia,tegra30-dc", "nvidia,tegra20-dc";
 			reg = <0x54200000 0x00040000>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
@@ -158,13 +165,14 @@
 				 <&tegra_car TEGRA30_CLK_PLL_P>;
 			clock-names = "disp1", "parent";
 			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_DC>;
+			#stream-id-cells = <1>;
 
 			rgb {
 				status = "disabled";
 			};
 		};
 
-		dc@54240000 {
+		dcb: dc@54240000 {
 			compatible = "nvidia,tegra30-dc";
 			reg = <0x54240000 0x00040000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
@@ -172,6 +180,7 @@
 				 <&tegra_car TEGRA30_CLK_PLL_P>;
 			clock-names = "disp2", "parent";
 			nvidia,memory-clients = <&smmu TEGRA_SWGROUP_DCB>;
+			#stream-id-cells = <1>;
 
 			rgb {
 				status = "disabled";
@@ -329,6 +338,7 @@
 		nvidia,dma-request-selector = <&apbdma 8>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTA>;
 		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_PPCS>;
+		#stream-id-cells = <1>;
 		status = "disabled";
 	};
 
@@ -340,6 +350,7 @@
 		nvidia,dma-request-selector = <&apbdma 9>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTB>;
 		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_PPCS>;
+		#stream-id-cells = <1>;
 		status = "disabled";
 	};
 
@@ -351,6 +362,7 @@
 		nvidia,dma-request-selector = <&apbdma 10>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTC>;
 		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_PPCS>;
+		#stream-id-cells = <1>;
 		status = "disabled";
 	};
 
@@ -362,6 +374,7 @@
 		nvidia,dma-request-selector = <&apbdma 19>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTD>;
 		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_PPCS>;
+		#stream-id-cells = <1>;
 		status = "disabled";
 	};
 
@@ -373,6 +386,7 @@
 		nvidia,dma-request-selector = <&apbdma 20>;
 		clocks = <&tegra_car TEGRA30_CLK_UARTE>;
 		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_PPCS>;
+		#stream-id-cells = <1>;
 		status = "disabled";
 	};
 
@@ -550,6 +564,25 @@
 		dma-window = <0 0x40000000>;	/* IOVA start & length */
 		nvidia,swgroups = <0x00000000 0x000779ff>;
 		nvidia,ahb = <&ahb>;
+
+		mmu-masters = <&host1x TEGRA_SWGROUP_HC>,
+			      <&mpe TEGRA_SWGROUP_MPE>,
+			      <&vi TEGRA_SWGROUP_VI>,
+			      <&epp TEGRA_SWGROUP_EPP>,
+			      <&isp TEGRA_SWGROUP_ISP>,
+			      <&gr2d TEGRA_SWGROUP_G2>,
+			      <&gr3d TEGRA_SWGROUP_NV TEGRA_SWGROUP_NV2>,
+			      <&dc TEGRA_SWGROUP_DC>,
+			      <&dcb TEGRA_SWGROUP_DCB>,
+			      <&uarta TEGRA_SWGROUP_PPCS>,
+			      <&uartb TEGRA_SWGROUP_PPCS>,
+			      <&uartc TEGRA_SWGROUP_PPCS>,
+			      <&uartd TEGRA_SWGROUP_PPCS>,
+			      <&uarte TEGRA_SWGROUP_PPCS>,
+			      <&sdhci0 TEGRA_SWGROUP_PPCS>,
+			      <&sdhci1 TEGRA_SWGROUP_PPCS>,
+			      <&sdhci2 TEGRA_SWGROUP_PPCS>,
+			      <&sdhci3 TEGRA_SWGROUP_PPCS>;
 	};
 
 	ahub {
@@ -617,39 +650,43 @@
 		};
 	};
 
-	sdhci@78000000 {
+	sdhci0: sdhci@78000000 {
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000000 0x200>;
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC1>;
 		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_PPCS>;
+		#stream-id-cells = <1>;
 		status = "disabled";
 	};
 
-	sdhci@78000200 {
+	sdhci1: sdhci@78000200 {
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000200 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC2>;
 		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_PPCS>;
+		#stream-id-cells = <1>;
 		status = "disabled";
 	};
 
-	sdhci@78000400 {
+	sdhci2: sdhci@78000400 {
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC3>;
 		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_PPCS>;
+		#stream-id-cells = <1>;
 		status = "disabled";
 	};
 
-	sdhci@78000600 {
+	sdhci3: sdhci@78000600 {
 		compatible = "nvidia,tegra30-sdhci", "nvidia,tegra20-sdhci";
 		reg = <0x78000600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_SDMMC4>;
 		nvidia,memory-clients = <&smmu TEGRA_SWGROUP_PPCS>;
+		#stream-id-cells = <1>;
 		status = "disabled";
 	};
 
-- 
1.8.1.5


--Multipart=_Wed__6_Nov_2013_16_06_23_+0200_O3OzF1QGrKrub1GW--
