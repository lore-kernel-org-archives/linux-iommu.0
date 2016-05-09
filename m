From: <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 1/5] dt-bindings: mediatek: add descriptions for mediatek mt2701 iommu and smi
Date: Mon, 9 May 2016 16:00:12 +0800
Message-ID: <1462780816-5288-2-git-send-email-honghui.zhang@mediatek.com>
References: <1462780816-5288-1-git-send-email-honghui.zhang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462780816-5288-1-git-send-email-honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org, kendrick.hsu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, youlin.pei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, erin.lo-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>

This patch defines the local arbitor port IDs for mediatek SoC MT2701 and
add descriptions of binding for mediatek generation one iommu and smi.

Signed-off-by: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
---
 .../devicetree/bindings/iommu/mediatek,iommu.txt   | 13 +++-
 .../memory-controllers/mediatek,smi-common.txt     | 21 +++++-
 .../memory-controllers/mediatek,smi-larb.txt       |  4 +-
 include/dt-bindings/memory/mt2701-larb-port.h      | 85 ++++++++++++++++++++++
 4 files changed, 115 insertions(+), 8 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt2701-larb-port.h

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
index cd1b1cd..9a4a5b5 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
@@ -1,7 +1,9 @@
 * Mediatek IOMMU Architecture Implementation
 
-  Some Mediatek SOCs contain a Multimedia Memory Management Unit (M4U) which
-uses the ARM Short-Descriptor translation table format for address translation.
+  Some Mediatek SOCs contain a Multimedia Memory Management Unit (M4U), and
+this M4U have two generations of HW architecture. Generation one use flat
+pagetable, and only support 4K size page mapping. Generation two uses the
+ARM Short-Descriptor translation table format for address translation.
 
   About the M4U Hardware Block Diagram, please check below:
 
@@ -36,7 +38,9 @@ in each larb. Take a example, There are many ports like MC, PP, VLD in the
 video decode local arbiter, all these ports are according to the video HW.
 
 Required properties:
-- compatible : must be "mediatek,mt8173-m4u".
+- compatible : must be one of the following string:
+	"mediatek,mt2701-m4u" for mt2701 which use generation one m4u HW.
+	"mediatek,mt8173-m4u" for mt8173 which use generation two m4u HW.
 - reg : m4u register base and size.
 - interrupts : the interrupt of m4u.
 - clocks : must contain one entry for each clock-names.
@@ -46,7 +50,8 @@ Required properties:
 	according to the local arbiter index, like larb0, larb1, larb2...
 - iommu-cells : must be 1. This is the mtk_m4u_id according to the HW.
 	Specifies the mtk_m4u_id as defined in
-	dt-binding/memory/mt8173-larb-port.h.
+	dt-binding/memory/mt2701-larb-port.h for mt2701 and
+	dt-binding/memory/mt8173-larb-port.h for mt8173
 
 Example:
 	iommu: iommu@10205000 {
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
index 06a83ce..80c0e22 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
@@ -2,16 +2,31 @@ SMI (Smart Multimedia Interface) Common
 
 The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
 
+Mediatek SMI have two generation HW architecture, mt8173 use the secondary
+generation of SMI HW while mt2701 use the first generation HW of SMI.
+
+There's slight differences between the two SMI, for generation 2, the
+register which control the iommu port is at each larb's register base. But
+for generation 1, the register is at smi ao base(smi always on register
+base). Besides that, the smi async clock should be prepare and enabled for
+SMI generation 1 to transform the smi clock into emi clock domain, but no
+needed for SMI generation 2.
+
 Required properties:
-- compatible : must be "mediatek,mt8173-smi-common"
+- compatible : must be one of :
+	"mediatek,mt2701-smi-common"
+	"mediatek,mt8173-smi-common"
 - reg : the register and size of the SMI block.
 - power-domains : a phandle to the power domain of this local arbiter.
 - clocks : Must contain an entry for each entry in clock-names.
-- clock-names : must contain 2 entries, as follows:
+- clock-names : must contain 3 entries for generation 1 smi HW and 2 entries
+  for generation 2 smi HW as follows:
   - "apb" : Advanced Peripheral Bus clock, It's the clock for setting
 	    the register.
   - "smi" : It's the clock for transfer data and command.
-  They may be the same if both source clocks are the same.
+	    They may be the same if both source clocks are the same.
+  - "async" : asynchronous clock, it help transform the smi clock into the emi
+	      clock domain, this clock is only needed by generation 1 smi HW.
 
 Example:
 	smi_common: smi@14022000 {
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
index 55ff3b7..21277a5 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
@@ -3,7 +3,9 @@ SMI (Smart Multimedia Interface) Local Arbiter
 The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
 
 Required properties:
-- compatible : must be "mediatek,mt8173-smi-larb"
+- compatible : must be one of :
+		"mediatek,mt8173-smi-larb"
+		"mediatek,mt2701-smi-larb"
 - reg : the register and size of this local arbiter.
 - mediatek,smi : a phandle to the smi_common node.
 - power-domains : a phandle to the power domain of this local arbiter.
diff --git a/include/dt-bindings/memory/mt2701-larb-port.h b/include/dt-bindings/memory/mt2701-larb-port.h
new file mode 100644
index 0000000..bd5a418
--- /dev/null
+++ b/include/dt-bindings/memory/mt2701-larb-port.h
@@ -0,0 +1,85 @@
+/*
+ * Copyright (c) 2015 MediaTek Inc.
+ * Author: Honghui Zhang <honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
+
+#ifndef _MT2701_LARB_PORT_H_
+#define _MT2701_LARB_PORT_H_
+
+/*
+ * Mediatek m4u generation 1 such as mt2701 have flat m4u port numbers,
+ * the first port's id for larb[N] would be the last port's id of larb[N - 1]
+ * plus one while larb[0]'s first port number is 0. The definition of
+ * MT2701_M4U_ID_LARBx is following HW register REG_SMI_SECUR_CON_BASE spec.
+ * But m4u generation 2 like mt8173 have different port number, it use fixed
+ * offset for each larb, the first port's id for larb[N] would be (N * 32).
+ */
+#define LARB0_PORT_OFFSET		0
+#define LARB1_PORT_OFFSET		11
+#define LARB2_PORT_OFFSET		21
+#define LARB3_PORT_OFFSET		43
+
+#define MT2701_M4U_ID_LARB0(port)	((port) + LARB0_PORT_OFFSET)
+#define MT2701_M4U_ID_LARB1(port)	((port) + LARB1_PORT_OFFSET)
+#define MT2701_M4U_ID_LARB2(port)	((port) + LARB2_PORT_OFFSET)
+
+/* Port define for larb0 */
+#define MT2701_M4U_PORT_DISP_OVL_0		MT2701_M4U_ID_LARB0(0)
+#define MT2701_M4U_PORT_DISP_RDMA1		MT2701_M4U_ID_LARB0(1)
+#define MT2701_M4U_PORT_DISP_RDMA		MT2701_M4U_ID_LARB0(2)
+#define MT2701_M4U_PORT_DISP_WDMA		MT2701_M4U_ID_LARB0(3)
+#define MT2701_M4U_PORT_MM_CMDQ			MT2701_M4U_ID_LARB0(4)
+#define MT2701_M4U_PORT_MDP_RDMA		MT2701_M4U_ID_LARB0(5)
+#define MT2701_M4U_PORT_MDP_WDMA		MT2701_M4U_ID_LARB0(6)
+#define MT2701_M4U_PORT_MDP_ROTO		MT2701_M4U_ID_LARB0(7)
+#define MT2701_M4U_PORT_MDP_ROTCO		MT2701_M4U_ID_LARB0(8)
+#define MT2701_M4U_PORT_MDP_ROTVO		MT2701_M4U_ID_LARB0(9)
+#define MT2701_M4U_PORT_MDP_RDMA1		MT2701_M4U_ID_LARB0(10)
+
+/* Port define for larb1 */
+#define MT2701_M4U_PORT_VDEC_MC_EXT		MT2701_M4U_ID_LARB1(0)
+#define MT2701_M4U_PORT_VDEC_PP_EXT		MT2701_M4U_ID_LARB1(1)
+#define MT2701_M4U_PORT_VDEC_PPWRAP_EXT		MT2701_M4U_ID_LARB1(2)
+#define MT2701_M4U_PORT_VDEC_AVC_MV_EXT		MT2701_M4U_ID_LARB1(3)
+#define MT2701_M4U_PORT_VDEC_PRED_RD_EXT	MT2701_M4U_ID_LARB1(4)
+#define MT2701_M4U_PORT_VDEC_PRED_WR_EXT	MT2701_M4U_ID_LARB1(5)
+#define MT2701_M4U_PORT_VDEC_VLD_EXT		MT2701_M4U_ID_LARB1(6)
+#define MT2701_M4U_PORT_VDEC_VLD2_EXT		MT2701_M4U_ID_LARB1(7)
+#define MT2701_M4U_PORT_VDEC_TILE_EXT		MT2701_M4U_ID_LARB1(8)
+#define MT2701_M4U_PORT_VDEC_IMG_RESZ_EXT	MT2701_M4U_ID_LARB1(9)
+
+/* Port define for larb2 */
+#define MT2701_M4U_PORT_VENC_RCPU		MT2701_M4U_ID_LARB2(0)
+#define MT2701_M4U_PORT_VENC_REC_FRM		MT2701_M4U_ID_LARB2(1)
+#define MT2701_M4U_PORT_VENC_BSDMA		MT2701_M4U_ID_LARB2(2)
+#define MT2701_M4U_PORT_JPGENC_RDMA		MT2701_M4U_ID_LARB2(3)
+#define MT2701_M4U_PORT_VENC_LT_RCPU		MT2701_M4U_ID_LARB2(4)
+#define MT2701_M4U_PORT_VENC_LT_REC_FRM		MT2701_M4U_ID_LARB2(5)
+#define MT2701_M4U_PORT_VENC_LT_BSDMA		MT2701_M4U_ID_LARB2(6)
+#define MT2701_M4U_PORT_JPGDEC_BSDMA		MT2701_M4U_ID_LARB2(7)
+#define MT2701_M4U_PORT_VENC_SV_COMV		MT2701_M4U_ID_LARB2(8)
+#define MT2701_M4U_PORT_VENC_RD_COMV		MT2701_M4U_ID_LARB2(9)
+#define MT2701_M4U_PORT_JPGENC_BSDMA		MT2701_M4U_ID_LARB2(10)
+#define MT2701_M4U_PORT_VENC_CUR_LUMA		MT2701_M4U_ID_LARB2(11)
+#define MT2701_M4U_PORT_VENC_CUR_CHROMA		MT2701_M4U_ID_LARB2(12)
+#define MT2701_M4U_PORT_VENC_REF_LUMA		MT2701_M4U_ID_LARB2(13)
+#define MT2701_M4U_PORT_VENC_REF_CHROMA		MT2701_M4U_ID_LARB2(14)
+#define MT2701_M4U_PORT_IMG_RESZ		MT2701_M4U_ID_LARB2(15)
+#define MT2701_M4U_PORT_VENC_LT_SV_COMV		MT2701_M4U_ID_LARB2(16)
+#define MT2701_M4U_PORT_VENC_LT_RD_COMV		MT2701_M4U_ID_LARB2(17)
+#define MT2701_M4U_PORT_VENC_LT_CUR_LUMA	MT2701_M4U_ID_LARB2(18)
+#define MT2701_M4U_PORT_VENC_LT_CUR_CHROMA	MT2701_M4U_ID_LARB2(19)
+#define MT2701_M4U_PORT_VENC_LT_REF_LUMA	MT2701_M4U_ID_LARB2(20)
+#define MT2701_M4U_PORT_VENC_LT_REF_CHROMA	MT2701_M4U_ID_LARB2(21)
+#define MT2701_M4U_PORT_JPGDEC_WDMA		MT2701_M4U_ID_LARB2(22)
+
+#endif
-- 
1.8.1.1.dirty

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
