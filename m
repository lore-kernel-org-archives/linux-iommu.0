From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 02/23] ARM: dt: tegra30: iommu: Add "nvidia,swgroups"
Date: Wed, 26 Jun 2013 12:28:05 +0300
Message-ID: <1372238906-9346-3-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This is a bitmap that indicates which HardWare Accelerators(HWA) are
supported on Tegra30 SoC.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt | 6 +++++-
 arch/arm/boot/dts/tegra30.dtsi                                  | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
index 89fb543..6be51f6 100644
--- a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
@@ -8,14 +8,18 @@ Required properties:
 - nvidia,#asids : # of ASIDs
 - dma-window : IOVA start address and length.
 - nvidia,ahb : phandle to the ahb bus connected to SMMU.
+- nvidia,swgroups: A bit map of supported HardWare Accelerators(HWA).
+  Each bit represents one sgroup. The assignments may be found in header
+  file <dt-bindings/iommu/tegra-swgid.h>.
 
 Example:
-	smmu {
+	iommu {
 		compatible = "nvidia,tegra30-smmu";
 		reg = <0x7000f010 0x02c
 		       0x7000f1f0 0x010
 		       0x7000f228 0x05c>;
 		nvidia,#asids = <4>;		/* # of ASIDs */
 		dma-window = <0 0x40000000>;	/* IOVA start & length */
+		nvidia,swgroups = <0x00000000 0x000779ff>;
 		nvidia,ahb = <&ahb>;
 	};
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index d8783f0..14ec3f9 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -461,6 +461,7 @@
 		       0x7000f228 0x05c>;
 		nvidia,#asids = <4>;		/* # of ASIDs */
 		dma-window = <0 0x40000000>;	/* IOVA start & length */
+		nvidia,swgroups = <0x00000000 0x000779ff>;
 		nvidia,ahb = <&ahb>;
 	};
 
-- 
1.8.1.5
