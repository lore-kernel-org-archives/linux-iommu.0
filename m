From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v4 2/6] dt-bindings: mediatek: Add smi dts binding
Date: Mon, 3 Aug 2015 18:21:15 +0800
Message-ID: <1438597279-2937-3-git-send-email-yong.wu@mediatek.com>
References: <1438597279-2937-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1438597279-2937-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch add smi binding document.

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
