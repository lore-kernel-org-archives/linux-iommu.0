From: Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v6 1/5] dt-bindings: iommu: Add binding for mediatek IOMMU
Date: Tue, 8 Dec 2015 17:49:09 +0800
Message-ID: <1449568153-15643-2-git-send-email-yong.wu@mediatek.com>
References: <1449568153-15643-1-git-send-email-yong.wu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449568153-15643-1-git-send-email-yong.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Thierry Reding <treding@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@google.com>, Tomasz Figa <tfiga@google.com>, Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, Sasha Hauer <kernel@pengutronix.de>, srv_heupstream@mediatek.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, pebolle@tiscali.nl, arnd@arndb.de, mitchelh@codeaurora.org, p.zabel@pengutronix.de, yingjoe.chen@mediatek.com, Yong Wu <yong.wu@mediatek.com>
List-Id: iommu@lists.linux-foundation.org

This patch add mediatek iommu dts binding document.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 .../devicetree/bindings/iommu/mediatek,iommu.txt   |  68 +++++++++++++
 include/dt-bindings/memory/mt8173-larb-port.h      | 111 +++++++++++++++++++++
 2 files changed, 179 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
 create mode 100644 include/dt-bindings/memory/mt8173-larb-port.h

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
new file mode 100644
index 0000000..c2fb06e
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
+access EMI. SMI is a brige between m4u and the Multimedia HW. It contain
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
diff --git a/include/dt-bindings/memory/mt8173-larb-port.h b/include/dt-bindings/memory/mt8173-larb-port.h
new file mode 100644
index 0000000..50ccb93
--- /dev/null
+++ b/include/dt-bindings/memory/mt8173-larb-port.h
@@ -0,0 +1,111 @@
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
+#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
+/* Local arbiter ID */
+#define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0x7)
+/* PortID within the local arbiter */
+#define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
+
+#define M4U_LARB0_ID			0
+#define M4U_LARB1_ID			1
+#define M4U_LARB2_ID			2
+#define M4U_LARB3_ID			3
+#define M4U_LARB4_ID			4
+#define M4U_LARB5_ID			5
+
+/* larb0 */
+#define M4U_PORT_DISP_OVL0		MTK_M4U_ID(M4U_LARB0_ID, 0)
+#define M4U_PORT_DISP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 1)
+#define M4U_PORT_DISP_WDMA0		MTK_M4U_ID(M4U_LARB0_ID, 2)
+#define M4U_PORT_DISP_OD_R		MTK_M4U_ID(M4U_LARB0_ID, 3)
+#define M4U_PORT_DISP_OD_W		MTK_M4U_ID(M4U_LARB0_ID, 4)
+#define M4U_PORT_MDP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 5)
+#define M4U_PORT_MDP_WDMA		MTK_M4U_ID(M4U_LARB0_ID, 6)
+#define M4U_PORT_MDP_WROT0		MTK_M4U_ID(M4U_LARB0_ID, 7)
+
+/* larb1 */
+#define M4U_PORT_HW_VDEC_MC_EXT		MTK_M4U_ID(M4U_LARB1_ID, 0)
+#define M4U_PORT_HW_VDEC_PP_EXT		MTK_M4U_ID(M4U_LARB1_ID, 1)
+#define M4U_PORT_HW_VDEC_UFO_EXT	MTK_M4U_ID(M4U_LARB1_ID, 2)
+#define M4U_PORT_HW_VDEC_VLD_EXT	MTK_M4U_ID(M4U_LARB1_ID, 3)
+#define M4U_PORT_HW_VDEC_VLD2_EXT	MTK_M4U_ID(M4U_LARB1_ID, 4)
+#define M4U_PORT_HW_VDEC_AVC_MV_EXT	MTK_M4U_ID(M4U_LARB1_ID, 5)
+#define M4U_PORT_HW_VDEC_PRED_RD_EXT	MTK_M4U_ID(M4U_LARB1_ID, 6)
+#define M4U_PORT_HW_VDEC_PRED_WR_EXT	MTK_M4U_ID(M4U_LARB1_ID, 7)
+#define M4U_PORT_HW_VDEC_PPWRAP_EXT	MTK_M4U_ID(M4U_LARB1_ID, 8)
+#define M4U_PORT_HW_VDEC_TILE		MTK_M4U_ID(M4U_LARB1_ID, 9)
+
+/* larb2 */
+#define M4U_PORT_IMGO			MTK_M4U_ID(M4U_LARB2_ID, 0)
+#define M4U_PORT_RRZO			MTK_M4U_ID(M4U_LARB2_ID, 1)
+#define M4U_PORT_AAO			MTK_M4U_ID(M4U_LARB2_ID, 2)
+#define M4U_PORT_LCSO			MTK_M4U_ID(M4U_LARB2_ID, 3)
+#define M4U_PORT_ESFKO			MTK_M4U_ID(M4U_LARB2_ID, 4)
+#define M4U_PORT_IMGO_D			MTK_M4U_ID(M4U_LARB2_ID, 5)
+#define M4U_PORT_LSCI			MTK_M4U_ID(M4U_LARB2_ID, 6)
+#define M4U_PORT_LSCI_D			MTK_M4U_ID(M4U_LARB2_ID, 7)
+#define M4U_PORT_BPCI			MTK_M4U_ID(M4U_LARB2_ID, 8)
+#define M4U_PORT_BPCI_D			MTK_M4U_ID(M4U_LARB2_ID, 9)
+#define M4U_PORT_UFDI			MTK_M4U_ID(M4U_LARB2_ID, 10)
+#define M4U_PORT_IMGI			MTK_M4U_ID(M4U_LARB2_ID, 11)
+#define M4U_PORT_IMG2O			MTK_M4U_ID(M4U_LARB2_ID, 12)
+#define M4U_PORT_IMG3O			MTK_M4U_ID(M4U_LARB2_ID, 13)
+#define M4U_PORT_VIPI			MTK_M4U_ID(M4U_LARB2_ID, 14)
+#define M4U_PORT_VIP2I			MTK_M4U_ID(M4U_LARB2_ID, 15)
+#define M4U_PORT_VIP3I			MTK_M4U_ID(M4U_LARB2_ID, 16)
+#define M4U_PORT_LCEI			MTK_M4U_ID(M4U_LARB2_ID, 17)
+#define M4U_PORT_RB			MTK_M4U_ID(M4U_LARB2_ID, 18)
+#define M4U_PORT_RP			MTK_M4U_ID(M4U_LARB2_ID, 19)
+#define M4U_PORT_WR			MTK_M4U_ID(M4U_LARB2_ID, 20)
+
+/* larb3 */
+#define M4U_PORT_VENC_RCPU		MTK_M4U_ID(M4U_LARB3_ID, 0)
+#define M4U_PORT_VENC_REC		MTK_M4U_ID(M4U_LARB3_ID, 1)
+#define M4U_PORT_VENC_BSDMA		MTK_M4U_ID(M4U_LARB3_ID, 2)
+#define M4U_PORT_VENC_SV_COMV		MTK_M4U_ID(M4U_LARB3_ID, 3)
+#define M4U_PORT_VENC_RD_COMV		MTK_M4U_ID(M4U_LARB3_ID, 4)
+#define M4U_PORT_JPGENC_RDMA		MTK_M4U_ID(M4U_LARB3_ID, 5)
+#define M4U_PORT_JPGENC_BSDMA		MTK_M4U_ID(M4U_LARB3_ID, 6)
+#define M4U_PORT_JPGDEC_WDMA		MTK_M4U_ID(M4U_LARB3_ID, 7)
+#define M4U_PORT_JPGDEC_BSDMA		MTK_M4U_ID(M4U_LARB3_ID, 8)
+#define M4U_PORT_VENC_CUR_LUMA		MTK_M4U_ID(M4U_LARB3_ID, 9)
+#define M4U_PORT_VENC_CUR_CHROMA	MTK_M4U_ID(M4U_LARB3_ID, 10)
+#define M4U_PORT_VENC_REF_LUMA		MTK_M4U_ID(M4U_LARB3_ID, 11)
+#define M4U_PORT_VENC_REF_CHROMA	MTK_M4U_ID(M4U_LARB3_ID, 12)
+#define M4U_PORT_VENC_NBM_RDMA		MTK_M4U_ID(M4U_LARB3_ID, 13)
+#define M4U_PORT_VENC_NBM_WDMA		MTK_M4U_ID(M4U_LARB3_ID, 14)
+
+/* larb4 */
+#define M4U_PORT_DISP_OVL1		MTK_M4U_ID(M4U_LARB4_ID, 0)
+#define M4U_PORT_DISP_RDMA1		MTK_M4U_ID(M4U_LARB4_ID, 1)
+#define M4U_PORT_DISP_RDMA2		MTK_M4U_ID(M4U_LARB4_ID, 2)
+#define M4U_PORT_DISP_WDMA1		MTK_M4U_ID(M4U_LARB4_ID, 3)
+#define M4U_PORT_MDP_RDMA1		MTK_M4U_ID(M4U_LARB4_ID, 4)
+#define M4U_PORT_MDP_WROT1		MTK_M4U_ID(M4U_LARB4_ID, 5)
+
+/* larb5 */
+#define M4U_PORT_VENC_RCPU_SET2		MTK_M4U_ID(M4U_LARB5_ID, 0)
+#define M4U_PORT_VENC_REC_FRM_SET2	MTK_M4U_ID(M4U_LARB5_ID, 1)
+#define M4U_PORT_VENC_REF_LUMA_SET2	MTK_M4U_ID(M4U_LARB5_ID, 2)
+#define M4U_PORT_VENC_REC_CHROMA_SET2	MTK_M4U_ID(M4U_LARB5_ID, 3)
+#define M4U_PORT_VENC_BSDMA_SET2	MTK_M4U_ID(M4U_LARB5_ID, 4)
+#define M4U_PORT_VENC_CUR_LUMA_SET2	MTK_M4U_ID(M4U_LARB5_ID, 5)
+#define M4U_PORT_VENC_CUR_CHROMA_SET2	MTK_M4U_ID(M4U_LARB5_ID, 6)
+#define M4U_PORT_VENC_RD_COMA_SET2	MTK_M4U_ID(M4U_LARB5_ID, 7)
+#define M4U_PORT_VENC_SV_COMA_SET2	MTK_M4U_ID(M4U_LARB5_ID, 8)
+
+#endif
-- 
1.8.1.1.dirty
