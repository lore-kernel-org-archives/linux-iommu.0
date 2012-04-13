From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/1] arm/dts: Tegra30: Add device tree support for SMMU
Date: Fri, 13 Apr 2012 12:22:05 +0200
Message-ID: <20120413.132205.1766846402066131036.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Cc: "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Add device tree support for Tegra30 IOMMU(SMMU).

Signed-off-by: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/arm/tegra/tegra30-smmu.txt |   19 +++++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi                     |   10 ++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/tegra30-smmu.txt b/Documentation/devicetree/bindings/arm/tegra/tegra30-smmu.txt
new file mode 100644
index 0000000..4bd8cd0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/tegra30-smmu.txt
@@ -0,0 +1,19 @@
+NVIDIA Tegra 30 IOMMU H/W, SMMU (System Memory Management Unit)
+
+Required properties:
+- compatible : "nvidia,tegra30-smmu"
+- reg : Should contain MC registers location and length
+- reg : Should contain AHB Arbitration registers and length
+- reg : Should contain virtual address space range
+- interrupts : Should contain MC General interrupt
+
+Example:
+	smmu: smmu@7000f000 {
+		compatible = "nvidia,tegra30-smmu";
+		reg = < 0x7000f000 0x400	/* controller registers */
+			0x6000c000 0x150	/* AHB Arbitration registers */
+			0x00001000 0x3ffff000 >;/* Virtual address space range
+						 * Exclude the 1st & last page
+						 */
+		interrupts = < 0 13 0x40 >;
+	};
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index 62a7b39..c640a5b 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -183,4 +183,14 @@
 		reg = < 0x70000868 0xd0     /* Pad control registers */
 			0x70003000 0x3e0 >; /* Mux registers */
 	};
+
+	smmu: smmu@7000f000 {
+		compatible = "nvidia,tegra30-smmu";
+		reg = < 0x7000f000 0x400	/* controller registers */
+			0x6000c000 0x150	/* AHB Arbitration registers */
+			0x00001000 0x3ffff000 >;/* Virtual address space range
+						 * Exclude the 1st & last page
+						 */
+		interrupts = < 0 13 0x40 >;
+	};
 };
-- 
1.7.5.4
