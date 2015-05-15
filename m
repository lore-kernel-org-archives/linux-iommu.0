From: Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v2 1/6] dt-bindings: iommu: Add binding for mediatek IOMMU
Date: Fri, 15 May 2015 17:43:24 +0800
Message-ID: <1431683009-18158-2-git-send-email-yong.wu@mediatek.com>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Lucas Stach <l.stach@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, pebolle@tiscali.nl, arnd@arndb.de, mitchelh@codeaurora.org, k.zhang@mediatek.com, youhua.li@mediatek.com, Yong Wu <yong.wu@mediatek.com>
List-Id: iommu@lists.linux-foundation.org

This patch add mediatek iommu dts binding document.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 .../devicetree/bindings/iommu/mediatek,iommu.txt   |  51 ++++++++++
 include/dt-bindings/iommu/mt8173-iommu-port.h      | 112 +++++++++++++++++++++
 2 files changed, 163 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
 create mode 100644 include/dt-bindings/iommu/mt8173-iommu-port.h

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
new file mode 100644
index 0000000..f2cc7c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
@@ -0,0 +1,51 @@
+/******************************************************/
+/*    Mediatek IOMMU Hardware Block Diagram           */
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
+- compatible : must be "mediatek,mt8173-m4u".
+- reg : m4u register base and size.
+- interrupts : the interrupt of m4u.
+- clocks : must contain one entry for each clock-names.
+- clock-names : must be "bclk", It is the block clock of m4u.
+- larb-portes-nr : must contain the number of the portes for each larb(local
+	arbiter). The number is defined in dt-binding/iommu/mt8173-iommu-port.h.
+- larb : must contain the local arbiters of the current platform. Refer to
+	bindings/soc/mediatek/mediatek,smi.txt. It must sort according to the
+	local arbiter index, like larb0, larb1, larb2...
+- iommu-cells : must be 1. Specifies the client PortID as defined in
+	dt-binding/iommu/mt8173-iommu-port.h
+
+Example:
+		iommu: mmsys_iommu@10205000 {
+			compatible = "mediatek,mt8173-m4u";
+			reg = <0 0x10205000 0 0x1000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infrasys INFRA_M4U>;
+			clock-names = "bclk";
+			larb-portes-nr = <M4U_LARB0_PORT_NR
+					  M4U_LARB1_PORT_NR
+					  M4U_LARB2_PORT_NR
+					  M4U_LARB3_PORT_NR
+					  M4U_LARB4_PORT_NR
+					  M4U_LARB5_PORT_NR>;
+			larb = <&larb0 &larb1 &larb2 &larb3 &larb4 &larb5>;
+			#iommu-cells = <1>;
+		};
\ No newline at end of file
diff --git a/include/dt-bindings/iommu/mt8173-iommu-port.h b/include/dt-bindings/iommu/mt8173-iommu-port.h
new file mode 100644
index 0000000..09bac4f
--- /dev/null
+++ b/include/dt-bindings/iommu/mt8173-iommu-port.h
@@ -0,0 +1,112 @@
+/*
+ * Copyright (c) 2014-2015 MediaTek Inc.
+ * Author: Yong Wu <yong.wu@mediatek.com>
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
+#define M4U_LARB0_PORT_NR	8
+#define M4U_LARB1_PORT_NR	10
+#define M4U_LARB2_PORT_NR	21
+#define M4U_LARB3_PORT_NR	15
+#define M4U_LARB4_PORT_NR	6
+#define M4U_LARB5_PORT_NR	9
+
+#define M4U_LARB0_PORT(n)	(n)
+#define M4U_LARB1_PORT(n)	((n) + M4U_LARB0_PORT_NR + M4U_LARB0_PORT(0))
+#define M4U_LARB2_PORT(n)	((n) + M4U_LARB1_PORT_NR + M4U_LARB1_PORT(0))
+#define M4U_LARB3_PORT(n)	((n) + M4U_LARB2_PORT_NR + M4U_LARB2_PORT(0))
+#define M4U_LARB4_PORT(n)	((n) + M4U_LARB3_PORT_NR + M4U_LARB3_PORT(0))
+#define M4U_LARB5_PORT(n)	((n) + M4U_LARB4_PORT_NR + M4U_LARB4_PORT(0))
+
+/* larb0 */
+#define	M4U_PORT_DISP_OVL0		M4U_LARB0_PORT(0)
+#define	M4U_PORT_DISP_RDMA0		M4U_LARB0_PORT(1)
+#define	M4U_PORT_DISP_WDMA0		M4U_LARB0_PORT(2)
+#define	M4U_PORT_DISP_OD_R		M4U_LARB0_PORT(3)
+#define	M4U_PORT_DISP_OD_W		M4U_LARB0_PORT(4)
+#define	M4U_PORT_MDP_RDMA0		M4U_LARB0_PORT(5)
+#define	M4U_PORT_MDP_WDMA		M4U_LARB0_PORT(6)
+#define	M4U_PORT_MDP_WROT0		M4U_LARB0_PORT(7)
+
+/* larb1 */
+#define	M4U_PORT_HW_VDEC_MC_EXT		M4U_LARB1_PORT(0)
+#define	M4U_PORT_HW_VDEC_PP_EXT		M4U_LARB1_PORT(1)
+#define	M4U_PORT_HW_VDEC_UFO_EXT	M4U_LARB1_PORT(2)
+#define	M4U_PORT_HW_VDEC_VLD_EXT	M4U_LARB1_PORT(3)
+#define	M4U_PORT_HW_VDEC_VLD2_EXT	M4U_LARB1_PORT(4)
+#define	M4U_PORT_HW_VDEC_AVC_MV_EXT	M4U_LARB1_PORT(5)
+#define	M4U_PORT_HW_VDEC_PRED_RD_EXT	M4U_LARB1_PORT(6)
+#define	M4U_PORT_HW_VDEC_PRED_WR_EXT	M4U_LARB1_PORT(7)
+#define	M4U_PORT_HW_VDEC_PPWRAP_EXT	M4U_LARB1_PORT(8)
+#define	M4U_PORT_HW_VDEC_TILE		M4U_LARB1_PORT(9)
+
+/* larb2 */
+#define	M4U_PORT_IMGO			M4U_LARB2_PORT(0)
+#define	M4U_PORT_RRZO			M4U_LARB2_PORT(1)
+#define	M4U_PORT_AAO			M4U_LARB2_PORT(2)
+#define	M4U_PORT_LCSO			M4U_LARB2_PORT(3)
+#define	M4U_PORT_ESFKO			M4U_LARB2_PORT(4)
+#define	M4U_PORT_IMGO_D			M4U_LARB2_PORT(5)
+#define	M4U_PORT_LSCI			M4U_LARB2_PORT(6)
+#define	M4U_PORT_LSCI_D			M4U_LARB2_PORT(7)
+#define	M4U_PORT_BPCI			M4U_LARB2_PORT(8)
+#define	M4U_PORT_BPCI_D			M4U_LARB2_PORT(9)
+#define	M4U_PORT_UFDI			M4U_LARB2_PORT(10)
+#define	M4U_PORT_IMGI			M4U_LARB2_PORT(11)
+#define	M4U_PORT_IMG2O			M4U_LARB2_PORT(12)
+#define	M4U_PORT_IMG3O			M4U_LARB2_PORT(13)
+#define	M4U_PORT_VIPI			M4U_LARB2_PORT(14)
+#define	M4U_PORT_VIP2I			M4U_LARB2_PORT(15)
+#define	M4U_PORT_VIP3I			M4U_LARB2_PORT(16)
+#define	M4U_PORT_LCEI			M4U_LARB2_PORT(17)
+#define	M4U_PORT_RB			M4U_LARB2_PORT(18)
+#define	M4U_PORT_RP			M4U_LARB2_PORT(19)
+#define	M4U_PORT_WR			M4U_LARB2_PORT(20)
+
+/* larb3 */
+#define	M4U_PORT_VENC_RCPU		M4U_LARB3_PORT(0)
+#define	M4U_PORT_VENC_REC		M4U_LARB3_PORT(1)
+#define	M4U_PORT_VENC_BSDMA		M4U_LARB3_PORT(2)
+#define	M4U_PORT_VENC_SV_COMV		M4U_LARB3_PORT(3)
+#define	M4U_PORT_VENC_RD_COMV		M4U_LARB3_PORT(4)
+#define	M4U_PORT_JPGENC_RDMA		M4U_LARB3_PORT(5)
+#define	M4U_PORT_JPGENC_BSDMA		M4U_LARB3_PORT(6)
+#define	M4U_PORT_JPGDEC_WDMA		M4U_LARB3_PORT(7)
+#define	M4U_PORT_JPGDEC_BSDMA		M4U_LARB3_PORT(8)
+#define	M4U_PORT_VENC_CUR_LUMA		M4U_LARB3_PORT(9)
+#define	M4U_PORT_VENC_CUR_CHROMA	M4U_LARB3_PORT(10)
+#define	M4U_PORT_VENC_REF_LUMA		M4U_LARB3_PORT(11)
+#define	M4U_PORT_VENC_REF_CHROMA	M4U_LARB3_PORT(12)
+#define	M4U_PORT_VENC_NBM_RDMA		M4U_LARB3_PORT(13)
+#define	M4U_PORT_VENC_NBM_WDMA		M4U_LARB3_PORT(14)
+
+/* larb4 */
+#define	M4U_PORT_DISP_OVL1		M4U_LARB4_PORT(0)
+#define	M4U_PORT_DISP_RDMA1		M4U_LARB4_PORT(1)
+#define	M4U_PORT_DISP_RDMA2		M4U_LARB4_PORT(2)
+#define	M4U_PORT_DISP_WDMA1		M4U_LARB4_PORT(3)
+#define	M4U_PORT_MDP_RDMA1		M4U_LARB4_PORT(4)
+#define	M4U_PORT_MDP_WROT1		M4U_LARB4_PORT(5)
+
+/* larb5 */
+#define	M4U_PORT_VENC_RCPU_SET2		M4U_LARB5_PORT(0)
+#define	M4U_PORT_VENC_REC_FRM_SET2	M4U_LARB5_PORT(1)
+#define	M4U_PORT_VENC_REF_LUMA_SET2	M4U_LARB5_PORT(2)
+#define	M4U_PORT_VENC_REC_CHROMA_SET2	M4U_LARB5_PORT(3)
+#define	M4U_PORT_VENC_BSDMA_SET2	M4U_LARB5_PORT(4)
+#define	M4U_PORT_VENC_CUR_LUMA_SET2	M4U_LARB5_PORT(5)
+#define	M4U_PORT_VENC_CUR_CHROMA_SET2	M4U_LARB5_PORT(6)
+#define	M4U_PORT_VENC_RD_COMA_SET2	M4U_LARB5_PORT(7)
+#define	M4U_PORT_VENC_SV_COMA_SET2	M4U_LARB5_PORT(8)
+
+#endif
-- 
1.8.1.1.dirty
