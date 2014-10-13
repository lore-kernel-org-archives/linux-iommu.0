From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 07/12] ARM: tegra: Add memory controller support for Tegra30
Date: Mon, 13 Oct 2014 12:33:49 +0200
Message-ID: <1413196434-5292-7-git-send-email-thierry.reding@gmail.com>
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

While this is an incompatible change there are no users of the IOMMU on
Tegra, even though a driver has existed for some time.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/tegra30.dtsi | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index aa6ccea13d30..fa7e5b642434 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -623,23 +623,15 @@
 		clock-names = "pclk", "clk32k_in";
 	};
 
-	memory-controller@7000f000 {
+	mc: memory-controller@7000f000 {
 		compatible = "nvidia,tegra30-mc";
-		reg = <0x7000f000 0x010
-		       0x7000f03c 0x1b4
-		       0x7000f200 0x028
-		       0x7000f284 0x17c>;
+		reg = <0x7000f000 0x400>;
+		clocks = <&tegra_car TEGRA30_CLK_MC>;
+		clock-names = "mc";
+
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
-	};
 
-	iommu@7000f010 {
-		compatible = "nvidia,tegra30-smmu";
-		reg = <0x7000f010 0x02c
-		       0x7000f1f0 0x010
-		       0x7000f228 0x05c>;
-		nvidia,#asids = <4>;		/* # of ASIDs */
-		dma-window = <0 0x40000000>;	/* IOVA start & length */
-		nvidia,ahb = <&ahb>;
+		#iommu-cells = <1>;
 	};
 
 	fuse@7000f800 {
-- 
2.1.2
