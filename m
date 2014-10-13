From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 06/12] ARM: tegra: Add memory controller support for Tegra20
Date: Mon, 13 Oct 2014 12:33:48 +0200
Message-ID: <1413196434-5292-6-git-send-email-thierry.reding@gmail.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1413196434-5292-1-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Collapses the old memory-controller and IOMMU device tree nodes into a
single node to more accurately describe the hardware.

Note that this is an incompatible change, but while a GART driver has
existed for a few years it has never been used to do any translations.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/tegra20.dtsi | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index 3b374c49d04d..a195c1975f3c 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -538,15 +538,14 @@
 
 	memory-controller@7000f000 {
 		compatible = "nvidia,tegra20-mc";
-		reg = <0x7000f000 0x024
-		       0x7000f03c 0x3c4>;
+		reg = <0x7000f000 0x00000400   /* controller registers */
+		       0x58000000 0x02000000>; /* GART aperture */
+		clocks = <&tegra_car TEGRA20_CLK_MC>;
+		clock-names = "mc";
+
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
-	};
 
-	iommu@7000f024 {
-		compatible = "nvidia,tegra20-gart";
-		reg = <0x7000f024 0x00000018	/* controller registers */
-		       0x58000000 0x02000000>;	/* GART aperture */
+		#iommu-cells = <1>;
 	};
 
 	memory-controller@7000f400 {
-- 
2.1.2
