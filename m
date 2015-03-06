From: <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 4/5] dt-bindings: iommu: Add binding for mediatek IOMMU
Date: Fri, 6 Mar 2015 18:48:19 +0800
Message-ID: <1425638900-24989-5-git-send-email-yong.wu@mediatek.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1425638900-24989-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

This patch add mediatek iommu dts binding document.

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 .../devicetree/bindings/iommu/mediatek,iommu.txt   | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
new file mode 100644
index 0000000..db01c92
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
@@ -0,0 +1,41 @@
+/******************************************************/
+/*    Mediatek IOMMU Hardware block diagram           */
+/******************************************************/
+              EMI (External Memory Interface)
+               |
+              m4u (Multimedia Memory Management Unit)
+               |
+              smi (Smart Multimedia Interface)
+               |
+        +---------------+-------
+        |               |
+        |               |
+    vdec larb       disp larb      ... SoCs have different local arbiter(larb).
+        |               |
+        |               |
+   +----+----+    +-----+-----+
+   |    |    |    |     |     |    ...
+   |    |    |    |     |     |    ...
+   |    |    |    |     |     |    ...
+  MC   PP   VLD  OVL0 RDMA0 WDMA0  ... There are different ports in each larb.
+
+Required properties:
+- compatible : must be "mediatek,mt8173-iommu"
+- reg : m4u register base
+- interrupts : must contain the interrupts from each internal translation unit
+- clocks : must contain one entry for each clock-name
+- clock-name: m4u clock
+- larb : must contain the larbes of current platform
+- iommu-cells : must be 1. Specifies the client PortID as defined in
+dt-binding/iommu/mt**-iommu-port.h
+
+Example:
+		iommu: mmsys_iommu@10205000 {
+			compatible = "mediatek,mt8173-iommu";
+			reg = <0 0x10205000 0 0x1000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infrasys INFRA_M4U>;
+			clock-names = "infra_m4u";
+			larb = <&larb0 &larb1 &larb2 &larb3 &larb4 &larb5>;
+			#iommu-cells = <1>;
+		};
\ No newline at end of file
-- 
1.8.1.1.dirty
