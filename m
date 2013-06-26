From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 06/23] ARM: dt: tegra114: iommu: Add "nvidia,swgroups"
Date: Wed, 26 Jun 2013 12:28:09 +0300
Message-ID: <1372238906-9346-7-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This is a bitmap that indicates which HardWare Accelerators(HWA) are
supported on Tegra114 SoC.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/tegra114.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 1f45cf5..715b5d6 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -323,7 +323,7 @@
 		       0x70019228 0x074>;
 		nvidia,#asids = <4>;
 		dma-window = <0 0x40000000>;
-		nvidia,swgroups = <0x18659fe>;
+		nvidia,swgroups = <0x00000000 0x01b659fe>;
 		nvidia,ahb = <&ahb>;
 	};
 
-- 
1.8.1.5
