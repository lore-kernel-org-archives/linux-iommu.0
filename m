From: Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v5 2/6] dt-bindings: mediatek: Add smi dts binding
Date: Fri, 9 Oct 2015 10:23:04 +0800
Message-ID: <1444357388-30257-3-git-send-email-yong.wu@mediatek.com>
References: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, pebolle@tiscali.nl, arnd@arndb.de, mitchelh@codeaurora.org, Sricharan R <sricharan@codeaurora.org>, youhua.li@mediatek.com, k.zhang@mediatek.com, kendrick.hsu@mediatek.com, Yong Wu <yong.wu@mediatek.com>
List-Id: iommu@lists.linux-foundation.org

This patch add smi binding document.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 .../memory-controllers/mediatek,smi-larb.txt       | 25 ++++++++++++++++++++++
 .../bindings/memory-controllers/mediatek,smi.txt   | 24 +++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
new file mode 100644
index 0000000..55ff3b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
@@ -0,0 +1,25 @@
+SMI (Smart Multimedia Interface) Local Arbiter
+
+The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
+
+Required properties:
+- compatible : must be "mediatek,mt8173-smi-larb"
+- reg : the register and size of this local arbiter.
+- mediatek,smi : a phandle to the smi_common node.
+- power-domains : a phandle to the power domain of this local arbiter.
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names: must contain 2 entries, as follows:
+  - "apb" : Advanced Peripheral Bus clock, It's the clock for setting
+	    the register.
+  - "smi" : It's the clock for transfer data and command.
+
+Example:
+	larb1: larb@16010000 {
+		compatible = "mediatek,mt8173-smi-larb";
+		reg = <0 0x16010000 0 0x1000>;
+		mediatek,smi = <&smi_common>;
+		power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
+		clocks = <&vdecsys CLK_VDEC_CKEN>,
+			 <&vdecsys CLK_VDEC_LARB_CKEN>;
+		clock-names = "apb", "smi";
+	};
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi.txt
new file mode 100644
index 0000000..f54e91c
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi.txt
@@ -0,0 +1,24 @@
+SMI (Smart Multimedia Interface)
+
+The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
+
+Required properties:
+- compatible : must be "mediatek,mt8173-smi"
+- reg : the register and size of the SMI block.
+- power-domains : a phandle to the power domain of this local arbiter.
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : must contain 2 entries, as follows:
+  - "apb" : Advanced Peripheral Bus clock, It's the clock for setting
+	    the register.
+  - "smi" : It's the clock for transfer data and command.
+  They may be the same if both source clock are the same.
+
+Example:
+	smi_common: smi@14022000 {
+		compatible = "mediatek,mt8173-smi";
+		reg = <0 0x14022000 0 0x1000>;
+		power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+		clocks = <&mmsys CLK_MM_SMI_COMMON>,
+			 <&mmsys CLK_MM_SMI_COMMON>;
+		clock-names = "apb", "smi";
+	};
-- 
1.8.1.1.dirty
