From: <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 5/5] dts: mt8173: Add iommu/smi nodes for mt8173
Date: Fri, 6 Mar 2015 18:48:20 +0800
Message-ID: <1425638900-24989-6-git-send-email-yong.wu@mediatek.com>
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

This patch add the iommu/larbs nodes for mt8173

Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi      |  60 ++++++++++++
 include/dt-bindings/iommu/mt8173-iommu-port.h | 127 ++++++++++++++++++++++++++
 2 files changed, 187 insertions(+)
 create mode 100644 include/dt-bindings/iommu/mt8173-iommu-port.h

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index c2a057f..805a7cd 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -16,6 +16,7 @@
 #include <dt-bindings/reset-controller/mt8173-resets.h>
 #include "mt8173-pinfunc.h"
 #include <dt-bindings/clock/mt8173-clk.h>
+#include <dt-bindings/iommu/mt8173-iommu-port.h>
 
 / {
 	compatible = "mediatek,mt8173";
@@ -249,6 +250,65 @@
 			interrupts = <0 86 8>;
 			clocks = <&uart_clk>;
 		};
+
+		iommu: mmsys_iommu@10205000 {
+			compatible = "mediatek,mt8173-iommu";
+			reg = <0 0x10205000 0 0x1000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infrasys INFRA_M4U>;
+			clock-names = "infra_m4u";
+			larb = <&larb0 &larb1 &larb2 &larb3 &larb4 &larb5>;
+			#iommu-cells = <1>;
+		};
+
+		larb0:larb@14021000 {
+			compatible = "mediatek,mt8173-smi-larb";
+			reg = <0 0x14021000 0 0x1000>;
+			clocks = <&mmsys MM_SMI_COMMON>, <&mmsys MM_SMI_LARB0>;
+			clock-names = "larb_sub0", "larb_sub1";
+		};
+
+		larb1:larb@16010000 {
+			compatible = "mediatek,mt8173-smi-larb";
+			reg = <0 0x16010000 0 0x1000>;
+			clocks = <&mmsys MM_SMI_COMMON>,
+					<&vdecsys VDEC_CKEN>,
+					<&vdecsys VDEC_LARB_CKEN>;
+			clock-names = "larb_sub0", "larb_sub1", "larb_sub2";
+		};
+
+		larb2:larb@16010000 {
+			compatible = "mediatek,mt8173-smi-larb";
+			reg = <0 0x15001000 0 0x1000>;
+			clocks = <&mmsys MM_SMI_COMMON>,
+					<&imgsys IMG_LARB2_SMI>;
+			clock-names = "larb_sub0", "larb_sub1";
+		};
+
+		larb3:larb@18001000 {
+			compatible = "mediatek,mt8173-smi-larb";
+			reg = <0 0x18001000 0 0x1000>;
+			clocks = <&mmsys MM_SMI_COMMON>,
+					<&vencsys VENC_CKE0>,
+					<&vencsys VENC_CKE1>;
+			clock-names = "larb_sub0", "larb_sub1", "larb_sub2";
+		};
+
+		larb4:larb@14027000 {
+			compatible = "mediatek,mt8173-smi-larb";
+			reg = <0 0x14027000 0 0x1000>;
+			clocks = <&mmsys MM_SMI_COMMON>, <&mmsys MM_SMI_LARB4>;
+			clock-names = "larb_sub0", "larb_sub1";
+		};
+
+		larb5:larb@19001000 {
+			compatible = "mediatek,mt8173-smi-larb";
+			reg = <0 0x19001000 0 0x1000>;
+			clocks = <&mmsys MM_SMI_COMMON>,
+					<&vencltsys VENCLT_CKE0>,
+					<&vencltsys VENCLT_CKE1>;
+			clock-names = "larb_sub0", "larb_sub1", "larb_sub2";
+		};
 	};
 
 };
diff --git a/include/dt-bindings/iommu/mt8173-iommu-port.h b/include/dt-bindings/iommu/mt8173-iommu-port.h
new file mode 100644
index 0000000..e9e6569
--- /dev/null
+++ b/include/dt-bindings/iommu/mt8173-iommu-port.h
@@ -0,0 +1,127 @@
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
+#define M4U_LARB0_PORT(n)      ((n) + 0)
+#define M4U_LARB1_PORT(n)      ((n) + 8)
+#define M4U_LARB2_PORT(n)      ((n) + 17)
+#define M4U_LARB3_PORT(n)      ((n) + 38)
+#define M4U_LARB4_PORT(n)      ((n) + 53)
+#define M4U_LARB5_PORT(n)      ((n) + 59)
+#define M4U_PERISYS_PORT(n)    ((n) + 68)
+
+/* larb0 */
+#define	M4U_PORT_DISP_OVL0    M4U_LARB0_PORT(0)
+#define	M4U_PORT_DISP_RDMA0   M4U_LARB0_PORT(1)
+#define	M4U_PORT_DISP_WDMA0   M4U_LARB0_PORT(2)
+#define	M4U_PORT_DISP_OD_R    M4U_LARB0_PORT(3)
+#define	M4U_PORT_DISP_OD_W    M4U_LARB0_PORT(4)
+#define	M4U_PORT_MDP_RDMA0    M4U_LARB0_PORT(5)
+#define	M4U_PORT_MDP_WDMA     M4U_LARB0_PORT(6)
+#define	M4U_PORT_MDP_WROT0    M4U_LARB0_PORT(7)
+
+/* larb1 */
+#define	M4U_PORT_HW_VDEC_MC_EXT       M4U_LARB1_PORT(0)
+#define	M4U_PORT_HW_VDEC_PP_EXT       M4U_LARB1_PORT(1)
+#define	M4U_PORT_HW_VDEC_UFO_EXT      M4U_LARB1_PORT(2)
+#define	M4U_PORT_HW_VDEC_VLD_EXT      M4U_LARB1_PORT(3)
+#define	M4U_PORT_HW_VDEC_VLD2_EXT     M4U_LARB1_PORT(4)
+#define	M4U_PORT_HW_VDEC_AVC_MV_EXT   M4U_LARB1_PORT(5)
+#define	M4U_PORT_HW_VDEC_PRED_RD_EXT  M4U_LARB1_PORT(6)
+#define	M4U_PORT_HW_VDEC_PRED_WR_EXT  M4U_LARB1_PORT(7)
+#define	M4U_PORT_HW_VDEC_PPWRAP_EXT   M4U_LARB1_PORT(8)
+
+/* larb2 */
+#define	M4U_PORT_IMGO      M4U_LARB2_PORT(0)
+#define	M4U_PORT_RRZO      M4U_LARB2_PORT(1)
+#define	M4U_PORT_AAO       M4U_LARB2_PORT(2)
+#define	M4U_PORT_LCSO      M4U_LARB2_PORT(3)
+#define	M4U_PORT_ESFKO     M4U_LARB2_PORT(4)
+#define	M4U_PORT_IMGO_D    M4U_LARB2_PORT(5)
+#define	M4U_PORT_LSCI      M4U_LARB2_PORT(6)
+#define	M4U_PORT_LSCI_D    M4U_LARB2_PORT(7)
+#define	M4U_PORT_BPCI      M4U_LARB2_PORT(8)
+#define	M4U_PORT_BPCI_D    M4U_LARB2_PORT(9)
+#define	M4U_PORT_UFDI      M4U_LARB2_PORT(10)
+#define	M4U_PORT_IMGI      M4U_LARB2_PORT(11)
+#define	M4U_PORT_IMG2O     M4U_LARB2_PORT(12)
+#define	M4U_PORT_IMG3O     M4U_LARB2_PORT(13)
+#define	M4U_PORT_VIPI      M4U_LARB2_PORT(14)
+#define	M4U_PORT_VIP2I     M4U_LARB2_PORT(15)
+#define	M4U_PORT_VIP3I     M4U_LARB2_PORT(16)
+#define	M4U_PORT_LCEI      M4U_LARB2_PORT(17)
+#define	M4U_PORT_RB        M4U_LARB2_PORT(18)
+#define	M4U_PORT_RP        M4U_LARB2_PORT(19)
+#define	M4U_PORT_WR        M4U_LARB2_PORT(20)
+
+/* larb3 */
+#define	M4U_PORT_VENC_RCPU         M4U_LARB3_PORT(0)
+#define	M4U_PORT_VENC_REC          M4U_LARB3_PORT(1)
+#define	M4U_PORT_VENC_BSDMA        M4U_LARB3_PORT(2)
+#define	M4U_PORT_VENC_SV_COMV      M4U_LARB3_PORT(3)
+#define	M4U_PORT_VENC_RD_COMV      M4U_LARB3_PORT(4)
+#define	M4U_PORT_JPGENC_RDMA       M4U_LARB3_PORT(5)
+#define	M4U_PORT_JPGENC_BSDMA      M4U_LARB3_PORT(6)
+#define	M4U_PORT_JPGDEC_WDMA       M4U_LARB3_PORT(7)
+#define	M4U_PORT_JPGDEC_BSDMA      M4U_LARB3_PORT(8)
+#define	M4U_PORT_VENC_CUR_LUMA     M4U_LARB3_PORT(9)
+#define	M4U_PORT_VENC_CUR_CHROMA   M4U_LARB3_PORT(10)
+#define	M4U_PORT_VENC_REF_LUMA     M4U_LARB3_PORT(11)
+#define	M4U_PORT_VENC_REF_CHROMA   M4U_LARB3_PORT(12)
+#define	M4U_PORT_VENC_NBM_RDMA     M4U_LARB3_PORT(13)
+#define	M4U_PORT_VENC_NBM_WDMA     M4U_LARB3_PORT(14)
+
+/* larb4 */
+#define	M4U_PORT_DISP_OVL1        M4U_LARB4_PORT(0)
+#define	M4U_PORT_DISP_RDMA1       M4U_LARB4_PORT(1)
+#define	M4U_PORT_DISP_RDMA2       M4U_LARB4_PORT(2)
+#define	M4U_PORT_DISP_WDMA1       M4U_LARB4_PORT(3)
+#define	M4U_PORT_MDP_RDMA1        M4U_LARB4_PORT(4)
+#define	M4U_PORT_MDP_WROT1        M4U_LARB4_PORT(5)
+
+/* larb5 */
+#define	M4U_PORT_VENC_RCPU_SET2         M4U_LARB5_PORT(0)
+#define	M4U_PORT_VENC_REC_FRM_SET2      M4U_LARB5_PORT(1)
+#define	M4U_PORT_VENC_REF_LUMA_SET2     M4U_LARB5_PORT(2)
+#define	M4U_PORT_VENC_REC_CHROMA_SET2   M4U_LARB5_PORT(3)
+#define	M4U_PORT_VENC_BSDMA_SET2        M4U_LARB5_PORT(4)
+#define	M4U_PORT_VENC_CUR_LUMA_SET2     M4U_LARB5_PORT(5)
+#define	M4U_PORT_VENC_CUR_CHROMA_SET2   M4U_LARB5_PORT(6)
+#define	M4U_PORT_VENC_RD_COMA_SET2      M4U_LARB5_PORT(7)
+#define	M4U_PORT_VENC_SV_COMA_SET2      M4U_LARB5_PORT(8)
+
+/* perisys iommu */
+#define	M4U_PORT_RESERVE      M4U_PERISYS_PORT(0)
+#define	M4U_PORT_SPM          M4U_PERISYS_PORT(1)
+#define	M4U_PORT_MD32         M4U_PERISYS_PORT(2)
+#define	M4U_PORT_PTP_THERM    M4U_PERISYS_PORT(3)
+#define	M4U_PORT_PWM          M4U_PERISYS_PORT(4)
+#define	M4U_PORT_MSDC1        M4U_PERISYS_PORT(5)
+#define	M4U_PORT_MSDC2        M4U_PERISYS_PORT(6)
+#define	M4U_PORT_SPI0         M4U_PERISYS_PORT(7)
+#define	M4U_PORT_NFI          M4U_PERISYS_PORT(8)
+#define	M4U_PORT_AUDIO        M4U_PERISYS_PORT(9)
+#define	M4U_PORT_RESERVED2    M4U_PERISYS_PORT(10)
+#define	M4U_PORT_HSIC_XHCI    M4U_PERISYS_PORT(11)
+
+#define	M4U_PORT_HSIC_MAS     M4U_PERISYS_PORT(12)
+#define	M4U_PORT_HSIC_DEV     M4U_PERISYS_PORT(13)
+#define	M4U_PORT_AP_DMA       M4U_PERISYS_PORT(14)
+#define	M4U_PORT_HSIC_DMA     M4U_PERISYS_PORT(15)
+#define	M4U_PORT_MSDC0        M4U_PERISYS_PORT(16)
+#define	M4U_PORT_MSDC3        M4U_PERISYS_PORT(17)
+
+#endif
+
-- 
1.8.1.1.dirty
