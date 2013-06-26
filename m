From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 04/23] ARM: dt: tegra30: Register AHB/IOMMU device first
Date: Wed, 26 Jun 2013 12:28:07 +0300
Message-ID: <1372238906-9346-5-git-send-email-hdoyu@nvidia.com>
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

Move up AHB/IOMMU to register them earlier than others. IOMMU needs
AHB, and IOMMU needs to register all platform devices as
IOMMU'able. So AHB/IOMMU needs to be instanciated at very beginning.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/tegra30.dtsi | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 3fcee3f..7c480f2 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -17,6 +17,23 @@
 		serial4 = &uarte;
 	};
 
+	/* FIXME: ahb/iommu needs to be populated first. */
+	ahb: ahb {
+		compatible = "nvidia,tegra30-ahb";
+		reg = <0x6000c004 0x14c>; /* AHB Arbitration + Gizmo Controller */
+	};
+
+	iommu {
+		compatible = "nvidia,tegra30-smmu";
+		reg = <0x7000f010 0x02c
+		       0x7000f1f0 0x010
+		       0x7000f228 0x05c>;
+		nvidia,#asids = <4>;		/* # of ASIDs */
+		dma-window = <0 0x40000000>;	/* IOVA start & length */
+		nvidia,swgroups = <0x00000000 0x000779ff>;
+		nvidia,ahb = <&ahb>;
+	};
+
 	host1x {
 		compatible = "nvidia,tegra30-host1x", "simple-bus";
 		reg = <0x50000000 0x00024000>;
@@ -213,11 +230,6 @@
 		clocks = <&tegra_car TEGRA30_CLK_APBDMA>;
 	};
 
-	ahb: ahb {
-		compatible = "nvidia,tegra30-ahb";
-		reg = <0x6000c004 0x14c>; /* AHB Arbitration + Gizmo Controller */
-	};
-
 	gpio: gpio {
 		compatible = "nvidia,tegra30-gpio";
 		reg = <0x6000d000 0x1000>;
@@ -469,17 +481,6 @@
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	iommu {
-		compatible = "nvidia,tegra30-smmu";
-		reg = <0x7000f010 0x02c
-		       0x7000f1f0 0x010
-		       0x7000f228 0x05c>;
-		nvidia,#asids = <4>;		/* # of ASIDs */
-		dma-window = <0 0x40000000>;	/* IOVA start & length */
-		nvidia,swgroups = <0x00000000 0x000779ff>;
-		nvidia,ahb = <&ahb>;
-	};
-
 	ahub {
 		compatible = "nvidia,tegra30-ahub";
 		reg = <0x70080000 0x200
-- 
1.8.1.5
