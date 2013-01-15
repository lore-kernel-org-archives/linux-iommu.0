From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 6/6] ARM: dt: tegra114: Add SMMU entry
Date: Tue, 15 Jan 2013 10:17:28 +0200
Message-ID: <1358237848-968-6-git-send-email-hdoyu@nvidia.com>
References: <1358237848-968-1-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1358237848-968-1-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Add SMMU entry.

Signed-off-by: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 arch/arm/boot/dts/tegra114.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index fd2fd0e..c3a602c 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -82,6 +82,17 @@
 		reg = <0x7000e400 0x400>;
 	};
 
+	smmu {
+		compatible = "nvidia,tegra114-smmu", "nvidia,tegra30-smmu";
+		reg = <0x7000f010 0x02c
+		       0x7000f1f0 0x010
+		       0x7000f228 0x074>;
+		nvidia,#asids = <4>;
+		dma-window = <0 0x40000000>;
+		nvidia,swgroups = <0x18659fe>;
+		nvidia,ahb = <&ahb>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.7.9.5
