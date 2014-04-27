From: Shaik Ameer Basha <shaik.ameer@samsung.com>
Subject: [PATCH v12 11/31] documentation: iommu: add binding document of Exynos
 System MMU
Date: Sun, 27 Apr 2014 13:07:43 +0530
Message-ID: <1398584283-22846-12-git-send-email-shaik.ameer@samsung.com>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: kgene.kim@samsung.com, tomasz.figa@gmail.com, pullip.cho@samsung.com, a.motakis@virtualopensystems.com, grundler@chromium.org, joro@8bytes.org, prathyush.k@samsung.com, rahul.sharma@samsung.com, sachin.kamat@linaro.org, supash.ramaswamy@linaro.org, Varun.Sethi@freescale.com, s.nawrocki@samsung.com, t.figa@samsung.com, joshi@samsung.com
List-Id: iommu@lists.linux-foundation.org

From: Cho KyongHo <pullip.cho@samsung.com>

This patch adds a description of the device tree binding for the
Samsung Exynos System MMU.

Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
---
 .../devicetree/bindings/iommu/samsung,sysmmu.txt   |   79 ++++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt

diff --git a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt
new file mode 100644
index 0000000..16e13a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt
@@ -0,0 +1,79 @@
+Samsung Exynos IOMMU H/W, System MMU (System Memory Management Unit)
+
+Samsung's Exynos architecture contains System MMUs that enables scattered
+physical memory chunks visible as a contiguous region to DMA-capable peripheral
+devices like MFC, FIMC, FIMD, GScaler, FIMC-IS and so forth.
+
+System MMU is an IOMMU and supports identical translation table format to
+ARMv7 translation tables with minimum set of page properties including access
+permissions, shareability and security protection. In addition, System MMU has
+another capabilities like L2 TLB or block-fetch buffers to minimize translation
+latency.
+
+System MMUs are in many to one relation with peripheral devices, i.e. single
+peripheral device might have multiple System MMUs (usually one for each bus
+master), but one System MMU can handle transactions from only one peripheral
+device. The relation between a System MMU and the peripheral device needs to be
+defined in device node of the peripheral device.
+
+MFC in all Exynos SoCs and FIMD, M2M Scalers and G2D in Exynos5420 has 2 System
+MMUs.
+* MFC has one System MMU on its left and right bus.
+* FIMD in Exynos5420 has one System MMU for window 0 and 4, the other system MMU
+  for window 1, 2 and 3.
+* M2M Scalers and G2D in Exynos5420 has one System MMU on the read channel and
+  the other System MMU on the write channel.
+The drivers must consider how to handle those System MMUs. One of the idea is
+to implement child devices or sub-devices which are the client devices of the
+System MMU.
+
+Required properties:
+- compatible: Should be one of:
+		"samsung,sysmmu-v1"
+		"samsung,sysmmu-v2"
+		"samsung,sysmmu-v3.1"
+		"samsung,sysmmu-v3.2"
+		"samsung,sysmmu-v3.3"
+
+- reg: A tuple of base address and size of System MMU registers.
+- interrupt-parent: The phandle of the interrupt controller of System MMU
+- interrupts: An interrupt specifier for interrupt signal of System MMU,
+	      according to the format defined by a particular interrupt
+	      controller.
+- clock-names: Should be "sysmmu" if the System MMU is needed to gate its clock.
+	       Optional "master" if the clock to the System MMU is gated by
+	       another gate clock other than "sysmmu".
+	       Exynos4 SoCs, there needs no "master" clock.
+	       Exynos5 SoCs, some System MMUs must have "master" clocks.
+- clocks: Required if the System MMU is needed to gate its clock.
+- samsung,power-domain: Required if the System MMU is needed to gate its power.
+	  Please refer to the following document:
+	  Documentation/devicetree/bindings/arm/exynos/power_domain.txt
+- mmu-masters: A phandle to device nodes representing the master for which
+               the System MMU can provide a translation. Any additional values
+	       after the phandle will be ignored because a System MMU never
+	       have two or more masters. "#stream-id-cells" specified in the
+	       master's node will be also ignored.
+	       If more than one phandle is specified, only the first phandle
+	       will be treated.
+
+Examples:
+	gsc_0: gsc@13e00000 {
+		compatible = "samsung,exynos5-gsc";
+		reg = <0x13e00000 0x1000>;
+		interrupts = <0 85 0>;
+		samsung,power-domain = <&pd_gsc>;
+		clocks = <&clock CLK_GSCL0>;
+		clock-names = "gscl";
+	};
+
+	sysmmu_gsc0: sysmmu@13E80000 {
+		compatible = "samsung,sysmmu-v3.2";
+		reg = <0x13E80000 0x1000>;
+		interrupt-parent = <&combiner>;
+		interrupts = <2 0>;
+		clock-names = "sysmmu", "master";
+		clocks = <&clock CLK_SMMU_GSCL0>, <&clock CLK_GSCL0>;
+		samsung,power-domain = <&pd_gsc>;
+		mmu-masters = <&gsc_0>;
+	};
-- 
1.7.9.5
