From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v10 1/5] dt-bindings: iommu: Add binding for mediatek IOMMU
Date: Tue, 23 Feb 2016 01:20:47 +0800
Message-ID: <1456161651-6136-2-git-send-email-yong.wu@mediatek.com>
References: <1456161651-6136-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1456161651-6136-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
Cc: p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, youhua.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch add mediatek iommu dts binding document.

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/iommu/mediatek,iommu.txt   | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
new file mode 100644
index 0000000..cd1b1cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
@@ -0,0 +1,68 @@
+* Mediatek IOMMU Architecture Implementation
+
+  Some Mediatek SOCs contain a Multimedia Memory Management Unit (M4U) which
+uses the ARM Short-Descriptor translation table format for address translation.
+
+  About the M4U Hardware Block Diagram, please check below:
+
+              EMI (External Memory Interface)
+               |
+              m4u (Multimedia Memory Management Unit)
+               |
+           SMI Common(Smart Multimedia Interface Common)
+               |
+       +----------------+-------
+       |                |
+       |                |
+   SMI larb0        SMI larb1   ... SoCs have several SMI local arbiter(larb).
+   (display)         (vdec)
+       |                |
+       |                |
+ +-----+-----+     +----+----+
+ |     |     |     |    |    |
+ |     |     |...  |    |    |  ... There are different ports in each larb.
+ |     |     |     |    |    |
+OVL0 RDMA0 WDMA0  MC   PP   VLD
+
+  As above, The Multimedia HW will go through SMI and M4U while it
+access EMI. SMI is a bridge between m4u and the Multimedia HW. It contain
+smi local arbiter and smi common. It will control whether the Multimedia
+HW should go though the m4u for translation or bypass it and talk
+directly with EMI. And also SMI help control the power domain and clocks for
+each local arbiter.
+  Normally we specify a local arbiter(larb) for each multimedia HW
+like display, video decode, and camera. And there are different ports
+in each larb. Take a example, There are many ports like MC, PP, VLD in the
+video decode local arbiter, all these ports are according to the video HW.
+
+Required properties:
+- compatible : must be "mediatek,mt8173-m4u".
+- reg : m4u register base and size.
+- interrupts : the interrupt of m4u.
+- clocks : must contain one entry for each clock-names.
+- clock-names : must be "bclk", It is the block clock of m4u.
+- mediatek,larbs : List of phandle to the local arbiters in the current Socs.
+	Refer to bindings/memory-controllers/mediatek,smi-larb.txt. It must sort
+	according to the local arbiter index, like larb0, larb1, larb2...
+- iommu-cells : must be 1. This is the mtk_m4u_id according to the HW.
+	Specifies the mtk_m4u_id as defined in
+	dt-binding/memory/mt8173-larb-port.h.
+
+Example:
+	iommu: iommu@10205000 {
+		compatible = "mediatek,mt8173-m4u";
+		reg = <0 0x10205000 0 0x1000>;
+		interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_INFRA_M4U>;
+		clock-names = "bclk";
+		mediatek,larbs = <&larb0 &larb1 &larb2 &larb3 &larb4 &larb5>;
+		#iommu-cells = <1>;
+	};
+
+Example for a client device:
+	display {
+		compatible = "mediatek,mt8173-disp";
+		iommus = <&iommu M4U_PORT_DISP_OVL0>,
+			 <&iommu M4U_PORT_DISP_RDMA0>;
+		...
+	};
-- 
1.8.1.1.dirty
