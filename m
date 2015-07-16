From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 1/6] dt-bindings: iommu: Add binding for mediatek IOMMU
Date: Thu, 16 Jul 2015 17:04:30 +0800
Message-ID: <1437037475-9065-2-git-send-email-yong.wu@mediatek.com>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1437037475-9065-1-git-send-email-yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sasha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, cloud.chou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, frederic.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This patch add mediatek iommu dts binding document.

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 .../devicetree/bindings/iommu/mediatek,iommu.txt   |   61 ++++++++++++
 include/dt-bindings/memory/mt8173-larb-port.h      |  105 ++++++++++++++++++++
 2 files changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
 create mode 100644 include/dt-bindings/memory/mt8173-larb-port.h

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
new file mode 100644
index 0000000..ffdc130
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
@@ -0,0 +1,61 @@
+* Mediatek IOMMU Architecture Implementation
+
+  Mediatek Socs may contain a implementation of Multimedia Memory
+Management Unit(M4U),which use ARM Short-descriptor translation table
+to achieve address translation.
+
+  The IOMMU Hardware Block Diagram, please check below:
+
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
+  As above, The Multimedia HW will go through SMI and M4U while it
+access EMI. SMI is a brige between m4u and the Multimedia HW. It contain
+smi local arbiter and smi common. It will control whether the Multimedia
+HW should go though the m4u for translation or bypass it and talk
+directly with EMI. And also SMI help control the clocks for each
+local arbiter.
+  Normally we specify a local arbiter(larb) for each multimedia HW
+like display, video decode, and camera. And there are different ports
+in each larb. Take a example, There are some ports like MC, PP, VLD in the
+video decode local arbiter, all the ports are according to the video HW.
+
+Required properties:
+- compatible : must be "mediatek,mt8173-m4u".
+- reg : m4u register base and size.
+- interrupts : the interrupt of m4u.
+- clocks : must contain one entry for each clock-names.
+- clock-names : must be "bclk", It is the block clock of m4u.
+- mediatek,larb : List of phandle to the local arbiters in the current Socs.
+	Refer to bindings/memory-controllers/mediatek,smi-larb.txt. It must sort
+	according to the local arbiter index, like larb0, larb1, larb2...
+- iommu-cells : must be 2. There are 2 cells needed to enable/disable iommu.
+	The first one is local arbiter index(larbid), and the other is port
+	index(portid) within local arbiter. Specifies the larbid and portid as
+	defined in dt-binding/memory/mt8173-larb-port.h.
+
+Example:
+	iommu: mmsys_iommu@10205000 {
+		compatible = "mediatek,mt8173-m4u";
+		reg = <0 0x10205000 0 0x1000>;
+		interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_INFRA_M4U>;
+		clock-names = "bclk";
+		mediatek,larb = <&larb0 &larb1 &larb2 &larb3 &larb4 &larb5>;
+		#iommu-cells = <2>;
+	};
\ No newline at end of file
diff --git a/include/dt-bindings/memory/mt8173-larb-port.h b/include/dt-bindings/memory/mt8173-larb-port.h
new file mode 100644
index 0000000..7517087
--- /dev/null
+++ b/include/dt-bindings/memory/mt8173-larb-port.h
@@ -0,0 +1,105 @@
+/*
+ * Copyright (c) 2014-2015 MediaTek Inc.
+ * Author: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef __DTS_IOMMU_PORT_MT8173_H
+#define __DTS_IOMMU_PORT_MT8173_H
+
+#define M4U_LARB0_ID			0
+#define M4U_LARB1_ID			1
+#define M4U_LARB2_ID			2
+#define M4U_LARB3_ID			3
+#define M4U_LARB4_ID			4
+#define M4U_LARB5_ID			5
+
+/* larb0 */
+#define	M4U_PORT_DISP_OVL0		0
+#define	M4U_PORT_DISP_RDMA0		1
+#define	M4U_PORT_DISP_WDMA0		2
+#define	M4U_PORT_DISP_OD_R		3
+#define	M4U_PORT_DISP_OD_W		4
+#define	M4U_PORT_MDP_RDMA0		5
+#define	M4U_PORT_MDP_WDMA		6
+#define	M4U_PORT_MDP_WROT0		7
+
+/* larb1 */
+#define	M4U_PORT_HW_VDEC_MC_EXT		0
+#define	M4U_PORT_HW_VDEC_PP_EXT		1
+#define	M4U_PORT_HW_VDEC_UFO_EXT	2
+#define	M4U_PORT_HW_VDEC_VLD_EXT	3
+#define	M4U_PORT_HW_VDEC_VLD2_EXT	4
+#define	M4U_PORT_HW_VDEC_AVC_MV_EXT	5
+#define	M4U_PORT_HW_VDEC_PRED_RD_EXT	6
+#define	M4U_PORT_HW_VDEC_PRED_WR_EXT	7
+#define	M4U_PORT_HW_VDEC_PPWRAP_EXT	8
+#define	M4U_PORT_HW_VDEC_TILE		9
+
+/* larb2 */
+#define	M4U_PORT_IMGO			0
+#define	M4U_PORT_RRZO			1
+#define	M4U_PORT_AAO			2
+#define	M4U_PORT_LCSO			3
+#define	M4U_PORT_ESFKO			4
+#define	M4U_PORT_IMGO_D			5
+#define	M4U_PORT_LSCI			6
+#define	M4U_PORT_LSCI_D			7
+#define	M4U_PORT_BPCI			8
+#define	M4U_PORT_BPCI_D			9
+#define	M4U_PORT_UFDI			10
+#define	M4U_PORT_IMGI			11
+#define	M4U_PORT_IMG2O			12
+#define	M4U_PORT_IMG3O			13
+#define	M4U_PORT_VIPI			14
+#define	M4U_PORT_VIP2I			15
+#define	M4U_PORT_VIP3I			16
+#define	M4U_PORT_LCEI			17
+#define	M4U_PORT_RB			18
+#define	M4U_PORT_RP			19
+#define	M4U_PORT_WR			20
+
+/* larb3 */
+#define	M4U_PORT_VENC_RCPU		0
+#define	M4U_PORT_VENC_REC		1
+#define	M4U_PORT_VENC_BSDMA		2
+#define	M4U_PORT_VENC_SV_COMV		3
+#define	M4U_PORT_VENC_RD_COMV		4
+#define	M4U_PORT_JPGENC_RDMA		5
+#define	M4U_PORT_JPGENC_BSDMA		6
+#define	M4U_PORT_JPGDEC_WDMA		7
+#define	M4U_PORT_JPGDEC_BSDMA		8
+#define	M4U_PORT_VENC_CUR_LUMA		9
+#define	M4U_PORT_VENC_CUR_CHROMA	10
+#define	M4U_PORT_VENC_REF_LUMA		11
+#define	M4U_PORT_VENC_REF_CHROMA	12
+#define	M4U_PORT_VENC_NBM_RDMA		13
+#define	M4U_PORT_VENC_NBM_WDMA		14
+
+/* larb4 */
+#define	M4U_PORT_DISP_OVL1		0
+#define	M4U_PORT_DISP_RDMA1		1
+#define	M4U_PORT_DISP_RDMA2		2
+#define	M4U_PORT_DISP_WDMA1		3
+#define	M4U_PORT_MDP_RDMA1		4
+#define	M4U_PORT_MDP_WROT1		5
+
+/* larb5 */
+#define	M4U_PORT_VENC_RCPU_SET2		0
+#define	M4U_PORT_VENC_REC_FRM_SET2	1
+#define	M4U_PORT_VENC_REF_LUMA_SET2	2
+#define	M4U_PORT_VENC_REC_CHROMA_SET2	3
+#define	M4U_PORT_VENC_BSDMA_SET2	4
+#define	M4U_PORT_VENC_CUR_LUMA_SET2	5
+#define	M4U_PORT_VENC_CUR_CHROMA_SET2	6
+#define	M4U_PORT_VENC_RD_COMA_SET2	7
+#define	M4U_PORT_VENC_SV_COMA_SET2	8
+
+#endif
-- 
1.7.9.5
