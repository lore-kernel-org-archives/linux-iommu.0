From: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: [PATCH 1/3] docs: dts: Documentation for smmu in hi6220 SoC.
Date: Thu, 8 Oct 2015 15:45:46 +0800
Message-ID: <1444290348-66509-1-git-send-email-puck.chen@hisilicon.com>
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
To: puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, haojian.zhuang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, xuyiping-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, w.f-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, kong.kongxinwei-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, z.liuxinliang-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, yudongbin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, weidong2-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, saberlily.xia-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
Cc: dan.zhao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, peter.panshilin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, qijiwen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Documentation for system mmu in hi6220 platform.

Signed-off-by: Chen Feng <puck.chen-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Signed-off-by: Yu Dongbin <yudongbin-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
---
 .../bindings/iommu/hisi,hi6220-iommu.txt           | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt

diff --git a/Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt b/Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt
new file mode 100644
index 0000000..32d1156
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt
@@ -0,0 +1,52 @@
+Hi6220 SoC SMMU Device Driver devicetree document
+=======================================================================
+The Architecture of SMMU on Hi6220 SoC:
+
+   +------------------------------------------------------------------+
+   |                                                                  |
+   |         +---------+  +--------+  +-------------+   +-------+     |
+   |         |   ADE   |  |  ISP   |  |  V/J codec  |   |  G3D  |     |
+   |         +----|----+  +---|----+  +------|------+   +---|---|     |
+   |              |           |              |              |         |
+   |     ---------v-----------v--------------v--------------v-----    |
+   |                           Media Bus                              |
+   |     --------------------------------|---------------|--------    |
+   |                                     |               |            |
+   |                                 +---v---------------v--------+   |
+   |                                 |            SMMU            |   |
+   |                                 +----------|---------|-------+   |
+   |                                            |         |           |
+   +--------------------------------------------|---------|-----------+
+                                                |         |
+                                   +------------v---------v-----------+
+                                   |              DDRC                |
+                                   +----------------------------------+
+
+Note:
+The media system shared the same smmu IP. to access DDR memory. And all
+media IP used the same page table.
+
+Below binding describes the system mmu for media system in hi6220 platform
+
+Required properties:
+- compatible: Should be "hisilicon,hi6220-smmu" example:
+		compatible = "hisilicon,hi6220-smmu";
+- reg: A tuple of base address and size of System MMU registers.
+- interrupts: An interrupt specifier for interrupt signal of System MMU.
+- clocks: The clock used for smmu IP.
+- clock-names: The name to enable clock with clock framework.
+- #iommu-cells: The iommu-cells should be 1 for muti-master to use.
+
+Examples:
+	smmu@f4210000 {
+		compatible = "hisilicon,hi6220-smmu";
+		reg = <0x0 0xf4210000 0x0 0x1000>;
+		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&sys_ctrl HI6220_MMU_CLK>,
+		       <&media_ctrl HI6220_MED_MMU>,
+		       <&sys_ctrl HI6220_MEDIA_PLL_SRC>;
+		clock-names = "smmu_clk",
+			"media_sc_clk",
+			"smmu_peri_clk";
+		#iommu-cells = <1>;
+	};
-- 
1.9.1
