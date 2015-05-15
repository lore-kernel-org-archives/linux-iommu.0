From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 2/6] dt-bindings: mediatek: Add smi dts binding
Date: Fri, 15 May 2015 17:43:25 +0800
Message-ID: <1431683009-18158-3-git-send-email-yong.wu@mediatek.com>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1431683009-18158-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, k.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch add smi binding document.

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 .../bindings/soc/mediatek/mediatek,smi-larb.txt    | 24 ++++++++++++++++++++++
 .../bindings/soc/mediatek/mediatek,smi.txt         | 22 ++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt
new file mode 100644
index 0000000..c06c5b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt
@@ -0,0 +1,24 @@
+SMI(Smart Multimedia Interface) Local Arbiter
+
+The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
+
+Required properties:
+- compatible : must be "mediatek,mt8173-smi-larb"
+- reg : the register and size of each local arbiter.
+- smi : must be "&smi_common". Refer to bindings/soc/mediatek,smi.txt.
+- clocks : must contain one entry for each clock-names.
+	There are 2 clockes:
+	APB clock : Advanced Peripheral Bus clock, It's the clock for setting
+		the register.
+	SMI clock : It's the clock for transfer data and command.
+- clock-name: must be "apb" and "smi".
+
+Example:
+	larb0:larb@14021000 {
+		compatible = "mediatek,mt8173-smi-larb";
+		reg = <0 0x14021000 0 0x1000>;
+		smi = <&smi_common>;
+		clocks = <&mmsys MM_SMI_LARB0>,
+			 <&mmsys MM_SMI_LARB0>;
+		clock-names = "apb", "smi";
+	};
diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
new file mode 100644
index 0000000..c2389b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
@@ -0,0 +1,22 @@
+SMI(Smart Multimedia Interface)
+
+The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
+
+Required properties:
+- compatible : must be "mediatek,mt8173-smi"
+- reg : the register and size of the smi.
+- clocks : must contain one entry for each clock-names.
+	There are 2 clockes:
+	APB clock : Advanced Peripheral Bus clock, It's the clock for setting
+		the register.
+	SMI clock : It's the clock for transfer data and command.
+- clock-name: must be "apb" and "smi".
+
+Example:
+	smi_common:smi@14022000 {
+		compatible = "mediatek,mt8173-smi";
+		reg = <0 0x14022000 0 0x1000>;
+		clocks = <&mmsys MM_SMI_COMMON>,
+			 <&mmsys MM_SMI_COMMON>;
+		clock-names = "apb", "smi";
+	};
-- 
1.8.1.1.dirty
