From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v10 2/5] dt-bindings: mediatek: Add smi dts binding
Date: Tue, 23 Feb 2016 01:20:48 +0800
Message-ID: <1456161651-6136-3-git-send-email-yong.wu@mediatek.com>
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

This patch add smi binding document and smi local arbiter header file.

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../memory-controllers/mediatek,smi-common.txt     |  24 +++++
 .../memory-controllers/mediatek,smi-larb.txt       |  25 +++++
 include/dt-bindings/memory/mt8173-larb-port.h      | 111 +++++++++++++++++++++
 3 files changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
 create mode 100644 include/dt-bindings/memory/mt8173-larb-port.h

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
new file mode 100644
index 0000000..06a83ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
@@ -0,0 +1,24 @@
+SMI (Smart Multimedia Interface) Common
+
+The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
+
+Required properties:
+- compatible : must be "mediatek,mt8173-smi-common"
+- reg : the register and size of the SMI block.
+- power-domains : a phandle to the power domain of this local arbiter.
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : must contain 2 entries, as follows:
+  - "apb" : Advanced Peripheral Bus clock, It's the clock for setting
+	    the register.
+  - "smi" : It's the clock for transfer data and command.
+  They may be the same if both source clocks are the same.
+
+Example:
+	smi_common: smi@14022000 {
+		compatible = "mediatek,mt8173-smi-common";
+		reg = <0 0x14022000 0 0x1000>;
+		power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+		clocks = <&mmsys CLK_MM_SMI_COMMON>,
+			 <&mmsys CLK_MM_SMI_COMMON>;
+		clock-names = "apb", "smi";
+	};
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
diff --git a/include/dt-bindings/memory/mt8173-larb-port.h b/include/dt-bindings/memory/mt8173-larb-port.h
new file mode 100644
index 0000000..5fef5d1
--- /dev/null
+++ b/include/dt-bindings/memory/mt8173-larb-port.h
@@ -0,0 +1,111 @@
+/*
+ * Copyright (c) 2015-2016 MediaTek Inc.
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
