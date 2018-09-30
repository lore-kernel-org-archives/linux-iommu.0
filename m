From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v5 07/21] ARM: dts: tegra20: Update Memory Controller node to the new binding
Date: Mon,  1 Oct 2018 01:48:19 +0300
Message-ID: <20180930224833.28809-8-digetx@gmail.com>
References: <20180930224833.28809-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180930224833.28809-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Device tree binding of Memory Controller has been changed: GART has been
squashed into the MC, there are a new mandatory clock and #iommu-cells
properties, the compatible has been changed to 'tegra20-mc-gart'.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index dcad6d6128cf..8c942e60703e 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -616,17 +616,14 @@
 	};
 
 	mc: memory-controller@7000f000 {
-		compatible = "nvidia,tegra20-mc";
-		reg = <0x7000f000 0x024
-		       0x7000f03c 0x3c4>;
+		compatible = "nvidia,tegra20-mc-gart";
+		reg = <0x7000f000 0x400		/* controller registers */
+		       0x58000000 0x02000000>;	/* GART aperture */
+		clocks = <&tegra_car TEGRA20_CLK_MC>;
+		clock-names = "mc";
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		#reset-cells = <1>;
-	};
-
-	iommu@7000f024 {
-		compatible = "nvidia,tegra20-gart";
-		reg = <0x7000f024 0x00000018	/* controller registers */
-		       0x58000000 0x02000000>;	/* GART aperture */
+		#iommu-cells = <0>;
 	};
 
 	memory-controller@7000f400 {
-- 
2.19.0
