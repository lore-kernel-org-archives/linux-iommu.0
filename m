From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 10/13] iommu: exynos: update device tree documentation
Date: Thu, 18 Feb 2016 15:12:57 +0100
Message-ID: <1455804780-9616-11-git-send-email-m.szyprowski@samsung.com>
References: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1455804780-9616-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: iommu@lists.linux-foundation.org

Exynos SYSMMU bindings documentation was merged before generic IOMMU
binding have been introduced. This patch updates documentation to match
current state.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 .../devicetree/bindings/iommu/samsung,sysmmu.txt      | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt
index bc620fe32a70..f61ca25ca136 100644
--- a/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt
+++ b/Documentation/devicetree/bindings/iommu/samsung,sysmmu.txt
@@ -23,28 +23,23 @@ MMUs.
   for window 1, 2 and 3.
 * M2M Scalers and G2D in Exynos5420 has one System MMU on the read channel and
   the other System MMU on the write channel.
-The drivers must consider how to handle those System MMUs. One of the idea is
-to implement child devices or sub-devices which are the client devices of the
-System MMU.
 
-Note:
-The current DT binding for the Exynos System MMU is incomplete.
-The following properties can be removed or changed, if found incompatible with
-the "Generic IOMMU Binding" support for attaching devices to the IOMMU.
+For information on assigning System MMU controller to its peripheral devices,
+see generic IOMMU bindings.
 
 Required properties:
 - compatible: Should be "samsung,exynos-sysmmu"
 - reg: A tuple of base address and size of System MMU registers.
+- #iommu-cells: Should be <0>.
 - interrupt-parent: The phandle of the interrupt controller of System MMU
 - interrupts: An interrupt specifier for interrupt signal of System MMU,
 	      according to the format defined by a particular interrupt
 	      controller.
 - clock-names: Should be "sysmmu" if the System MMU is needed to gate its clock.
 	       Optional "master" if the clock to the System MMU is gated by
-	       another gate clock other than "sysmmu".
-	       Exynos4 SoCs, there needs no "master" clock.
-	       Exynos5 SoCs, some System MMUs must have "master" clocks.
-- clocks: Required if the System MMU is needed to gate its clock.
+	       another gate clock other than "sysmmu" (usually main gate clock
+	       of peripheral device this SYSMMU belongs to).
+- clocks: Phandles for respective clocks described by clock-names.
 - power-domains: Required if the System MMU is needed to gate its power.
 	  Please refer to the following document:
 	  Documentation/devicetree/bindings/power/pd-samsung.txt
@@ -57,6 +52,7 @@ Examples:
 		power-domains = <&pd_gsc>;
 		clocks = <&clock CLK_GSCL0>;
 		clock-names = "gscl";
+		iommus = <&sysmmu_gsc0>;
 	};
 
 	sysmmu_gsc0: sysmmu@13E80000 {
@@ -67,4 +63,5 @@ Examples:
 		clock-names = "sysmmu", "master";
 		clocks = <&clock CLK_SMMU_GSCL0>, <&clock CLK_GSCL0>;
 		power-domains = <&pd_gsc>;
+		#iommu-cells = <0>;
 	};
-- 
1.9.2
