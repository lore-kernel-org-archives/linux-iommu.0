From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 07/23] ARM: dt: tegra114: Add "nvidia,memory-clients"
Date: Wed, 26 Jun 2013 12:28:10 +0300
Message-ID: <1372238906-9346-8-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Add "nvidia,memory-clients" to identify which swgroup ID a device
belongs to.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/tegra114.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 715b5d6..980a3b1 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -1,5 +1,6 @@
 #include <dt-bindings/clock/tegra114-car.h>
 #include <dt-bindings/gpio/tegra-gpio.h>
+#include <dt-bindings/iommu/tegra-swgid.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include "skeleton.dtsi"
@@ -411,6 +412,7 @@
 		reg = <0x78000200 0x200>;
 		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA114_CLK_SDMMC2>;
+		nvidia,memory-clients = <SWGID_PPCS>;
 		status = "disable";
 	};
 
@@ -419,6 +421,7 @@
 		reg = <0x78000400 0x200>;
 		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA114_CLK_SDMMC3>;
+		nvidia,memory-clients = <SWGID_PPCS>;
 		status = "disable";
 	};
 
@@ -427,6 +430,7 @@
 		reg = <0x78000600 0x200>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA114_CLK_SDMMC4>;
+		nvidia,memory-clients = <SWGID_PPCS>;
 		status = "disable";
 	};
 
-- 
1.8.1.5
