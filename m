From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 5/6] ARM: dt: tegra114: Add AHB entry
Date: Tue, 15 Jan 2013 10:17:27 +0200
Message-ID: <1358237848-968-5-git-send-email-hdoyu@nvidia.com>
References: <1358237848-968-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358237848-968-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Add AHB entry.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/tegra114.dtsi |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 175cbc3..fd2fd0e 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -26,6 +26,11 @@
 			      0 122 0x04>;
 	};
 
+	ahb: ahb {
+		compatible = "nvidia,tegra114-ahb", "nvidia,tegra30-ahb";
+		reg = <0x6000c004 0x14c>;
+	};
+
 	serial@70006000 {
 		compatible = "nvidia,tegra114-uart", "nvidia,tegra20-uart";
 		reg = <0x70006000 0x40>;
-- 
1.7.9.5
