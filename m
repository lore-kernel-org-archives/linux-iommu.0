Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1C82D47EE
	for <iommu@lists.linux.dev>; Sat, 18 Oct 2025 13:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760794000; cv=none; b=dvf4AMDUZnkI+C4YEM2BZx0ztwJ7VAPVROEy7EFfXPTdp1siixDybPBH5GCKoVb3fkUUPnBz+3ZxS3sRUCNbtBrLL5xQejWnd5p1zpULodP2K5PuURM6p77iofOSmdUALxyAAyWwYMHF8l6kFR6kR1WS1jSuFULGSeaRw0SW94E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760794000; c=relaxed/simple;
	bh=bgUHp5+Q+HzctfUw9LQZMTUSCEiRVV07M0vKGOt/dyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kT1zls2phD7eN3Tp4ngbY4r9cx71aMs40nY8m1kBH253xw4tBV+0PaYiZzHhKsgI6hPtSic2s2OCzqi851Ypklqu3Wr1nSxd7yzl7aXI0z0qO7c4/ks5w9MYv/7aSMnJ7rfBEqtIJUNeoe667EP5ZMiY9bYxJAD2chZn7YlOoyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YMEkti5L; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YMEkti5L"
X-UUID: 0eeaa3d0ac2611f0ae1e63ff8927bad3-20251018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uwJpw1mqmmc3lZbDnKv0ByYQTtNZ7oMlCz+eedgGKKg=;
	b=YMEkti5LTHc99R0agCP2+l+Ii+b56EMGosYj96uICl/ZbTKCB79p4S9UhLFgU1QXTVcqOY3n8sPS8WxUTVhJsWbkmo8ZDwq1TlJ7pdfp+/DjFDkzlxsmUTJuSd26cIOTpCk0bnqBBslu1MgfHIvSTV6h0hS2sMkQTyErpZH/kTs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:6230e67f-db29-47f8-9bc3-39b5f161c969,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:e81a8702-eaf8-4c8c-94de-0bc39887e077,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|836|888|898,TC:-5,Content:
	0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0eeaa3d0ac2611f0ae1e63ff8927bad3-20251018
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <zhengnan.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 863752887; Sat, 18 Oct 2025 21:26:30 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 18 Oct 2025 21:26:26 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Sat, 18 Oct 2025 21:26:25 +0800
From: Zhengnan Chen <zhengnan.chen@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Zhengnan Chen
	<zhengnan.chen@mediatek.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/5] dt-bindings: mediatek: mt8189: Add bindings for MM & APU & INFRA IOMMU
Date: Sat, 18 Oct 2025 21:26:10 +0800
Message-ID: <20251018132625.14428-2-zhengnan.chen@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251018132625.14428-1-zhengnan.chen@mediatek.com>
References: <20251018132625.14428-1-zhengnan.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

There are three iommu in total, namely MM_IOMMU, APU_IOMMU, INFRA_IOMMU,
Add bindings for them.

Signed-off-by: Zhengnan Chen <zhengnan.chen@mediatek.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/iommu/mediatek,iommu.yaml        |   8 +
 .../memory/mediatek,mt8189-memory-port.h      | 283 ++++++++++++++++++
 2 files changed, 291 insertions(+)
 create mode 100644 include/dt-bindings/memory/mediatek,mt8189-memory-port.h

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index f49ed8ac4776..79c573c47b08 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -82,6 +82,9 @@ properties:
           - mediatek,mt8188-iommu-vdo        # generation two
           - mediatek,mt8188-iommu-vpp        # generation two
           - mediatek,mt8188-iommu-infra      # generation two
+          - mediatek,mt8189-iommu-apu        # generation two
+          - mediatek,mt8189-iommu-infra      # generation two
+          - mediatek,mt8189-iommu-mm         # generation two
           - mediatek,mt8192-m4u  # generation two
           - mediatek,mt8195-iommu-vdo        # generation two
           - mediatek,mt8195-iommu-vpp        # generation two
@@ -128,6 +131,7 @@ properties:
       This is the mtk_m4u_id according to the HW. Specifies the mtk_m4u_id as
       defined in
       dt-binding/memory/mediatek,mt8188-memory-port.h for mt8188,
+      dt-binding/memory/mediatek,mt8189-memory-port.h for mt8189,
       dt-binding/memory/mt2701-larb-port.h for mt2701 and mt7623,
       dt-binding/memory/mt2712-larb-port.h for mt2712,
       dt-binding/memory/mt6779-larb-port.h for mt6779,
@@ -164,6 +168,7 @@ allOf:
               - mediatek,mt8186-iommu-mm
               - mediatek,mt8188-iommu-vdo
               - mediatek,mt8188-iommu-vpp
+              - mediatek,mt8189-iommu-mm
               - mediatek,mt8192-m4u
               - mediatek,mt8195-iommu-vdo
               - mediatek,mt8195-iommu-vpp
@@ -180,6 +185,7 @@ allOf:
             - mediatek,mt8186-iommu-mm
             - mediatek,mt8188-iommu-vdo
             - mediatek,mt8188-iommu-vpp
+            - mediatek,mt8189-iommu-mm
             - mediatek,mt8192-m4u
             - mediatek,mt8195-iommu-vdo
             - mediatek,mt8195-iommu-vpp
@@ -208,6 +214,8 @@ allOf:
             contains:
               enum:
                 - mediatek,mt8188-iommu-infra
+                - mediatek,mt8189-iommu-apu
+                - mediatek,mt8189-iommu-infra
                 - mediatek,mt8195-iommu-infra
 
     then:
diff --git a/include/dt-bindings/memory/mediatek,mt8189-memory-port.h b/include/dt-bindings/memory/mediatek,mt8189-memory-port.h
new file mode 100644
index 000000000000..849fead3d0f7
--- /dev/null
+++ b/include/dt-bindings/memory/mediatek,mt8189-memory-port.h
@@ -0,0 +1,283 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Zhengnan chen <zhengnan.chen@mediatek.com>
+ */
+#ifndef _DT_BINDINGS_MEMORY_MEDIATEK_MT8189_MEMORY_PORT_H_
+#define _DT_BINDINGS_MEMORY_MEDIATEK_MT8189_MEMORY_PORT_H_
+
+#include <dt-bindings/memory/mtk-memory-port.h>
+
+#define SMI_L0_ID		(0)
+#define SMI_L1_ID		(1)
+#define SMI_L2_ID		(2)
+#define SMI_L4_ID		(3)
+#define SMI_L7_ID		(4)
+#define SMI_L9_ID		(5)
+#define SMI_L11_ID		(6)
+#define SMI_L13_ID		(7)
+#define SMI_L14_ID		(8)
+#define SMI_L16_ID		(9)
+#define SMI_L17_ID		(10)
+#define SMI_L19_ID		(11)
+#define SMI_L20_ID		(12)
+
+/*
+ * MM IOMMU supports 16GB dma address. We separate it to four ranges:
+ * 0 ~ 4G; 4G ~ 8G; 8G ~ 12G; 12G ~ 16G, we could adjust these masters
+ * locate in anyone region. BUT:
+ * a) Make sure all the ports inside a larb are in one range.
+ * b) The iova of any master can NOT cross the 4G/8G/12G boundary.
+ *
+ * This is the suggested mapping in this SoC:
+ *
+ * modules		dma-address-region	larbs-ports
+ * disp/mdp		0 ~ 4G			larb0/1/2
+ * vcodec		4G ~ 8G                 larb4/7
+ * imgsys/cam/ipesys	8G ~ 12G                the other larbs.
+ * N/A			12G ~ 16G
+ */
+
+/* Larb0 -- disp */
+#define M4U_L0_P0_DISP_OVL0_4L_HDR		MTK_M4U_ID(SMI_L0_ID, 0)
+#define M4U_L0_P1_DISP_OVL0_4L_RDMA0		MTK_M4U_ID(SMI_L0_ID, 1)
+#define M4U_L0_P2_DISP_OVL1_4L_RDMA1		MTK_M4U_ID(SMI_L0_ID, 2)
+#define M4U_L0_P3_DISP_OVL0_4L_RDMA2		MTK_M4U_ID(SMI_L0_ID, 3)
+#define M4U_L0_P4_DISP_OVL1_4L_RDMA3		MTK_M4U_ID(SMI_L0_ID, 4)
+#define M4U_L0_P5_DISP_RDMA0			MTK_M4U_ID(SMI_L0_ID, 5)
+#define M4U_L0_P6_DISP_WDMA0			MTK_M4U_ID(SMI_L0_ID, 6)
+#define M4U_L0_P7_DISP_FAKE_ENG0		MTK_M4U_ID(SMI_L0_ID, 7)
+
+/* Larb1 -- disp */
+#define M4U_L1_P0_DISP_OVL1_4L_HDR		MTK_M4U_ID(SMI_L1_ID, 0)
+#define M4U_L1_P1_DISP_OVL1_4L_RDMA0		MTK_M4U_ID(SMI_L1_ID, 1)
+#define M4U_L1_P2_DISP_OVL0_4L_RDMA1		MTK_M4U_ID(SMI_L1_ID, 2)
+#define M4U_L1_P3_DISP_OVL1_4L_RDMA2		MTK_M4U_ID(SMI_L1_ID, 3)
+#define M4U_L1_P4_DISP_OVL0_4L_RDMA3		MTK_M4U_ID(SMI_L1_ID, 4)
+#define M4U_L1_P5_DISP_RDMA1			MTK_M4U_ID(SMI_L1_ID, 5)
+#define M4U_L1_P6_DISP_WDMA1			MTK_M4U_ID(SMI_L1_ID, 6)
+#define M4U_L1_P7_DISP_FAKE_ENG1		MTK_M4U_ID(SMI_L1_ID, 7)
+
+/* Larb2 -- mmlsys(mdp) */
+#define M4U_L2_P0_MDP_RDMA0			MTK_M4U_ID(SMI_L2_ID, 0)
+#define M4U_L2_P1_MDP_RDMA1			MTK_M4U_ID(SMI_L2_ID, 1)
+#define M4U_L2_P2_MDP_WROT0			MTK_M4U_ID(SMI_L2_ID, 2)
+#define M4U_L2_P3_MDP_WROT1			MTK_M4U_ID(SMI_L2_ID, 3)
+#define M4U_L2_P4_MDP_DUMMY0			MTK_M4U_ID(SMI_L2_ID, 4)
+#define M4U_L2_P5_MDP_DUMMY1			MTK_M4U_ID(SMI_L2_ID, 5)
+#define M4U_L2_P6_MDP_RDMA2			MTK_M4U_ID(SMI_L2_ID, 6)
+#define M4U_L2_P7_MDP_RDMA3			MTK_M4U_ID(SMI_L2_ID, 7)
+#define M4U_L2_P8_MDP_WROT2			MTK_M4U_ID(SMI_L2_ID, 8)
+#define M4U_L2_P9_MDP_WROT3			MTK_M4U_ID(SMI_L2_ID, 9)
+#define M4U_L2_P10_DISP_FAKE0			MTK_M4U_ID(SMI_L2_ID, 10)
+
+/* Larb3: null */
+
+/* Larb4 -- vdec */
+#define M4U_L4_P0_HW_VDEC_MC_EXT		MTK_M4U_ID(SMI_L4_ID, 0)
+#define M4U_L4_P1_HW_VDEC_UFO_EXT		MTK_M4U_ID(SMI_L4_ID, 1)
+#define M4U_L4_P2_HW_VDEC_PP_EXT		MTK_M4U_ID(SMI_L4_ID, 2)
+#define M4U_L4_P3_HW_VDEC_PRED_RD_EXT		MTK_M4U_ID(SMI_L4_ID, 3)
+#define M4U_L4_P4_HW_VDEC_PRED_WR_EXT		MTK_M4U_ID(SMI_L4_ID, 4)
+#define M4U_L4_P5_HW_VDEC_PPWRAP_EXT		MTK_M4U_ID(SMI_L4_ID, 5)
+#define M4U_L4_P6_HW_VDEC_TILE_EXT		MTK_M4U_ID(SMI_L4_ID, 6)
+#define M4U_L4_P7_HW_VDEC_VLD_EXT		MTK_M4U_ID(SMI_L4_ID, 7)
+#define M4U_L4_P8_HW_VDEC_VLD2_EXT		MTK_M4U_ID(SMI_L4_ID, 8)
+#define M4U_L4_P9_HW_VDEC_AVC_MV_EXT		MTK_M4U_ID(SMI_L4_ID, 9)
+#define M4U_L4_P10_HW_VDEC_RG_CTRL_DMA_EXT	MTK_M4U_ID(SMI_L4_ID, 10)
+#define M4U_L4_P11_HW_VDEC_UFO_ENC_EXT		MTK_M4U_ID(SMI_L4_ID, 11)
+
+/* Larb5: null */
+
+/* Larb6: null */
+
+/* Larb7 -- venc */
+#define M4U_L7_P0_VENC_RCPU			MTK_M4U_ID(SMI_L7_ID, 0)
+#define M4U_L7_P1_VENC_REC			MTK_M4U_ID(SMI_L7_ID, 1)
+#define M4U_L7_P2_VENC_BSDMA			MTK_M4U_ID(SMI_L7_ID, 2)
+#define M4U_L7_P3_VENC_SV_COMV			MTK_M4U_ID(SMI_L7_ID, 3)
+#define M4U_L7_P4_VENC_RD_COMV			MTK_M4U_ID(SMI_L7_ID, 4)
+#define M4U_L7_P5_JPGENC_Y_RDMA			MTK_M4U_ID(SMI_L7_ID, 5)
+#define M4U_L7_P6_JPGENC_C_RDMA			MTK_M4U_ID(SMI_L7_ID, 6)
+#define M4U_L7_P7_JPGENC_Q_RDMA			MTK_M4U_ID(SMI_L7_ID, 7)
+#define M4U_L7_P8_VENC_SUB_W_LUMA		MTK_M4U_ID(SMI_L7_ID, 8)
+#define M4U_L7_P9_JPGENC_BSDMA			MTK_M4U_ID(SMI_L7_ID, 9)
+#define M4U_L7_P10_VENC_CUR_LUMA		MTK_M4U_ID(SMI_L7_ID, 10)
+#define M4U_L7_P11_VENC_CUR_CHROMA		MTK_M4U_ID(SMI_L7_ID, 11)
+#define M4U_L7_P12_VENC_REF_LUMA		MTK_M4U_ID(SMI_L7_ID, 12)
+#define M4U_L7_P13_VENC_REF_CHROMA		MTK_M4U_ID(SMI_L7_ID, 13)
+#define M4U_L7_P14_VENC_SUB_R_LUMA		MTK_M4U_ID(SMI_L7_ID, 14)
+#define M4U_L7_P15_JPGDEC_WDMA			MTK_M4U_ID(SMI_L7_ID, 15)
+#define M4U_L7_P16_JPGDEC_BSDMA			MTK_M4U_ID(SMI_L7_ID, 16)
+#define M4U_L7_P17_JPGDEC_HUFF_OFFSET		MTK_M4U_ID(SMI_L7_ID, 17)
+
+/* Larb8: null */
+
+/* Larb9 --imgsys */
+#define M4U_L9_P0_IMGI_D1			MTK_M4U_ID(SMI_L9_ID, 0)
+#define M4U_L9_P1_IMGBI_D1			MTK_M4U_ID(SMI_L9_ID, 1)
+#define M4U_L9_P2_DMGI_D1			MTK_M4U_ID(SMI_L9_ID, 2)
+#define M4U_L9_P3_DEPI_D1			MTK_M4U_ID(SMI_L9_ID, 3)
+#define M4U_L9_P4_LCE_D1			MTK_M4U_ID(SMI_L9_ID, 4)
+#define M4U_L9_P5_SMTI_D1			MTK_M4U_ID(SMI_L9_ID, 5)
+#define M4U_L9_P6_SMTO_D2			MTK_M4U_ID(SMI_L9_ID, 6)
+#define M4U_L9_P7_SMTO_D1			MTK_M4U_ID(SMI_L9_ID, 7)
+#define M4U_L9_P8_CRZO_D1			MTK_M4U_ID(SMI_L9_ID, 8)
+#define M4U_L9_P9_IMG3O_D1			MTK_M4U_ID(SMI_L9_ID, 9)
+#define M4U_L9_P10_VIPI_D1			MTK_M4U_ID(SMI_L9_ID, 10)
+#define M4U_L9_P11_SMTI_D5			MTK_M4U_ID(SMI_L9_ID, 11)
+#define M4U_L9_P12_TIMGO_D1			MTK_M4U_ID(SMI_L9_ID, 12)
+#define M4U_L9_P13_UFBC_W0			MTK_M4U_ID(SMI_L9_ID, 13)
+#define M4U_L9_P14_UFBC_R0			MTK_M4U_ID(SMI_L9_ID, 14)
+#define M4U_L9_P15_WPE_RDMA1			MTK_M4U_ID(SMI_L9_ID, 15)
+#define M4U_L9_P16_WPE_RDMA0			MTK_M4U_ID(SMI_L9_ID, 16)
+#define M4U_L9_P17_WPE_WDMA			MTK_M4U_ID(SMI_L9_ID, 17)
+#define M4U_L9_P18_MFB_RDMA0			MTK_M4U_ID(SMI_L9_ID, 18)
+#define M4U_L9_P19_MFB_RDMA1			MTK_M4U_ID(SMI_L9_ID, 19)
+#define M4U_L9_P20_MFB_RDMA2			MTK_M4U_ID(SMI_L9_ID, 20)
+#define M4U_L9_P21_MFB_RDMA3			MTK_M4U_ID(SMI_L9_ID, 21)
+#define M4U_L9_P22_MFB_RDMA4			MTK_M4U_ID(SMI_L9_ID, 22)
+#define M4U_L9_P23_MFB_RDMA5			MTK_M4U_ID(SMI_L9_ID, 23)
+#define M4U_L9_P24_MFB_WDMA0			MTK_M4U_ID(SMI_L9_ID, 24)
+#define M4U_L9_P25_MFB_WDMA1			MTK_M4U_ID(SMI_L9_ID, 25)
+#define M4U_L9_P26_RESERVE6			MTK_M4U_ID(SMI_L9_ID, 26)
+#define M4U_L9_P27_RESERVE7			MTK_M4U_ID(SMI_L9_ID, 27)
+#define M4U_L9_P28_RESERVE8			MTK_M4U_ID(SMI_L9_ID, 28)
+
+/* Larb10: null */
+
+/* Larb11 -- imgsys */
+#define M4U_L11_P0_IMGI_D1			MTK_M4U_ID(SMI_L11_ID, 0)
+#define M4U_L11_P1_IMGBI_D1			MTK_M4U_ID(SMI_L11_ID, 1)
+#define M4U_L11_P2_DMGI_D1			MTK_M4U_ID(SMI_L11_ID, 2)
+#define M4U_L11_P3_DEPI_D1			MTK_M4U_ID(SMI_L11_ID, 3)
+#define M4U_L11_P4_LCE_D1			MTK_M4U_ID(SMI_L11_ID, 4)
+#define M4U_L11_P5_SMTI_D1			MTK_M4U_ID(SMI_L11_ID, 5)
+#define M4U_L11_P6_SMTO_D2			MTK_M4U_ID(SMI_L11_ID, 6)
+#define M4U_L11_P7_SMTO_D1			MTK_M4U_ID(SMI_L11_ID, 7)
+#define M4U_L11_P8_CRZO_D1			MTK_M4U_ID(SMI_L11_ID, 8)
+#define M4U_L11_P9_IMG3O_D1			MTK_M4U_ID(SMI_L11_ID, 9)
+#define M4U_L11_P10_VIPI_D1			MTK_M4U_ID(SMI_L11_ID, 10)
+#define M4U_L11_P11_SMTI_D5			MTK_M4U_ID(SMI_L11_ID, 11)
+#define M4U_L11_P12_TIMGO_D1			MTK_M4U_ID(SMI_L11_ID, 12)
+#define M4U_L11_P13_UFBC_W0			MTK_M4U_ID(SMI_L11_ID, 13)
+#define M4U_L11_P14_UFBC_R0			MTK_M4U_ID(SMI_L11_ID, 14)
+#define M4U_L11_P15_WPE_RDMA1			MTK_M4U_ID(SMI_L11_ID, 15)
+#define M4U_L11_P16_WPE_RDMA0			MTK_M4U_ID(SMI_L11_ID, 16)
+#define M4U_L11_P17_WPE_WDMA			MTK_M4U_ID(SMI_L11_ID, 17)
+#define M4U_L11_P18_MFB_RDMA0			MTK_M4U_ID(SMI_L11_ID, 18)
+#define M4U_L11_P19_MFB_RDMA1			MTK_M4U_ID(SMI_L11_ID, 19)
+#define M4U_L11_P20_MFB_RDMA2			MTK_M4U_ID(SMI_L11_ID, 20)
+#define M4U_L11_P21_MFB_RDMA3			MTK_M4U_ID(SMI_L11_ID, 21)
+#define M4U_L11_P22_MFB_RDMA4			MTK_M4U_ID(SMI_L11_ID, 22)
+#define M4U_L11_P23_MFB_RDMA5			MTK_M4U_ID(SMI_L11_ID, 23)
+#define M4U_L11_P24_MFB_WDMA0			MTK_M4U_ID(SMI_L11_ID, 24)
+#define M4U_L11_P25_MFB_WDMA1			MTK_M4U_ID(SMI_L11_ID, 25)
+#define M4U_L11_P26_RESERVE6			MTK_M4U_ID(SMI_L11_ID, 26)
+#define M4U_L11_P27_RESERVE7			MTK_M4U_ID(SMI_L11_ID, 27)
+#define M4U_L11_P28_RESERVE8			MTK_M4U_ID(SMI_L11_ID, 28)
+
+/* Larb12: null */
+
+/* Larb13 -- cam */
+#define M4U_L13_P0_MRAWI			MTK_M4U_ID(SMI_L13_ID, 0)
+#define M4U_L13_P1_MRAWO_0			MTK_M4U_ID(SMI_L13_ID, 1)
+#define M4U_L13_P2_MRAWO_1			MTK_M4U_ID(SMI_L13_ID, 2)
+#define M4U_L13_P3_CAMSV_1			MTK_M4U_ID(SMI_L13_ID, 3)
+#define M4U_L13_P4_CAMSV_2			MTK_M4U_ID(SMI_L13_ID, 4)
+#define M4U_L13_P5_CAMSV_3			MTK_M4U_ID(SMI_L13_ID, 5)
+#define M4U_L13_P6_CAMSV_4			MTK_M4U_ID(SMI_L13_ID, 6)
+#define M4U_L13_P7_CAMSV_5			MTK_M4U_ID(SMI_L13_ID, 7)
+#define M4U_L13_P8_CAMSV_6			MTK_M4U_ID(SMI_L13_ID, 8)
+#define M4U_L13_P9_CCUI				MTK_M4U_ID(SMI_L13_ID, 9)
+#define M4U_L13_P10_CCUO			MTK_M4U_ID(SMI_L13_ID, 10)
+#define M4U_L13_P11_FAKE			MTK_M4U_ID(SMI_L13_ID, 11)
+#define M4U_L13_P12_PDAI_0			MTK_M4U_ID(SMI_L13_ID, 12)
+#define M4U_L13_P13_PDAI_1			MTK_M4U_ID(SMI_L13_ID, 13)
+#define M4U_L13_P14_PDAO			MTK_M4U_ID(SMI_L13_ID, 14)
+
+/* Larb14 -- cam */
+#define M4U_L14_P0_RESERVE			MTK_M4U_ID(SMI_L14_ID, 0)
+#define M4U_L14_P1_RESERVE			MTK_M4U_ID(SMI_L14_ID, 1)
+#define M4U_L14_P2_RESERVE			MTK_M4U_ID(SMI_L14_ID, 2)
+#define M4U_L14_P3_CAMSV_0			MTK_M4U_ID(SMI_L14_ID, 3)
+#define M4U_L14_P4_CCUI				MTK_M4U_ID(SMI_L14_ID, 4)
+#define M4U_L14_P5_CCUO				MTK_M4U_ID(SMI_L14_ID, 5)
+#define M4U_L14_P6_CAMSV_7			MTK_M4U_ID(SMI_L14_ID, 6)
+#define M4U_L14_P7_CAMSV_8			MTK_M4U_ID(SMI_L14_ID, 7)
+#define M4U_L14_P8_CAMSV_9			MTK_M4U_ID(SMI_L14_ID, 8)
+#define M4U_L14_P9_CAMSV_10			MTK_M4U_ID(SMI_L14_ID, 9)
+
+/* Larb15: null */
+
+/* Larb16 -- cam */
+#define M4U_L16_P0_IMGO_R1_A			MTK_M4U_ID(SMI_L16_ID, 0)
+#define M4U_L16_P1_RRZO_R1_A			MTK_M4U_ID(SMI_L16_ID, 1)
+#define M4U_L16_P2_CQI_R1_A			MTK_M4U_ID(SMI_L16_ID, 2)
+#define M4U_L16_P3_BPCI_R1_A			MTK_M4U_ID(SMI_L16_ID, 3)
+#define M4U_L16_P4_YUVO_R1_A			MTK_M4U_ID(SMI_L16_ID, 4)
+#define M4U_L16_P5_UFDI_R2_A			MTK_M4U_ID(SMI_L16_ID, 5)
+#define M4U_L16_P6_RAWI_R2_A			MTK_M4U_ID(SMI_L16_ID, 6)
+#define M4U_L16_P7_RAWI_R3_A			MTK_M4U_ID(SMI_L16_ID, 7)
+#define M4U_L16_P8_AAO_R1_A			MTK_M4U_ID(SMI_L16_ID, 8)
+#define M4U_L16_P9_AFO_R1_A			MTK_M4U_ID(SMI_L16_ID, 9)
+#define M4U_L16_P10_FLKO_R1_A			MTK_M4U_ID(SMI_L16_ID, 10)
+#define M4U_L16_P11_LCESO_R1_A			MTK_M4U_ID(SMI_L16_ID, 11)
+#define M4U_L16_P12_CRZO_R1_A			MTK_M4U_ID(SMI_L16_ID, 12)
+#define M4U_L16_P13_LTMSO_R1_A			MTK_M4U_ID(SMI_L16_ID, 13)
+#define M4U_L16_P14_RSSO_R1_A			MTK_M4U_ID(SMI_L16_ID, 14)
+#define M4U_L16_P15_AAHO_R1_A			MTK_M4U_ID(SMI_L16_ID, 15)
+#define M4U_L16_P16_LSCI_R1_A			MTK_M4U_ID(SMI_L16_ID, 16)
+
+/* Larb17 -- cam */
+#define M4U_L17_P0_IMGO_R1_B			MTK_M4U_ID(SMI_L17_ID, 0)
+#define M4U_L17_P1_RRZO_R1_B			MTK_M4U_ID(SMI_L17_ID, 1)
+#define M4U_L17_P2_CQI_R1_B			MTK_M4U_ID(SMI_L17_ID, 2)
+#define M4U_L17_P3_BPCI_R1_B			MTK_M4U_ID(SMI_L17_ID, 3)
+#define M4U_L17_P4_YUVO_R1_B			MTK_M4U_ID(SMI_L17_ID, 4)
+#define M4U_L17_P5_UFDI_R2_B			MTK_M4U_ID(SMI_L17_ID, 5)
+#define M4U_L17_P6_RAWI_R2_B			MTK_M4U_ID(SMI_L17_ID, 6)
+#define M4U_L17_P7_RAWI_R3_B			MTK_M4U_ID(SMI_L17_ID, 7)
+#define M4U_L17_P8_AAO_R1_B			MTK_M4U_ID(SMI_L17_ID, 8)
+#define M4U_L17_P9_AFO_R1_B			MTK_M4U_ID(SMI_L17_ID, 9)
+#define M4U_L17_P10_FLKO_R1_B			MTK_M4U_ID(SMI_L17_ID, 10)
+#define M4U_L17_P11_LCESO_R1_B			MTK_M4U_ID(SMI_L17_ID, 11)
+#define M4U_L17_P12_CRZO_R1_B			MTK_M4U_ID(SMI_L17_ID, 12)
+#define M4U_L17_P13_LTMSO_R1_B			MTK_M4U_ID(SMI_L17_ID, 13)
+#define M4U_L17_P14_RSSO_R1_B			MTK_M4U_ID(SMI_L17_ID, 14)
+#define M4U_L17_P15_AAHO_R1_B			MTK_M4U_ID(SMI_L17_ID, 15)
+#define M4U_L17_P16_LSCI_R1_B			MTK_M4U_ID(SMI_L17_ID, 16)
+
+/* Larb19 -- ipesys */
+#define M4U_L19_P0_DVS_RDMA			MTK_M4U_ID(SMI_L19_ID, 0)
+#define M4U_L19_P1_DVS_WDMA			MTK_M4U_ID(SMI_L19_ID, 1)
+#define M4U_L19_P2_DVP_RDMA			MTK_M4U_ID(SMI_L19_ID, 2)
+#define M4U_L19_P3_DVP_WDMA			MTK_M4U_ID(SMI_L19_ID, 3)
+
+/* Larb20 -- ipesys */
+#define M4U_L20_P0_FDVT_RDA_0			MTK_M4U_ID(SMI_L20_ID, 0)
+#define M4U_L20_P1_FDVT_RDB_0			MTK_M4U_ID(SMI_L20_ID, 1)
+#define M4U_L20_P2_FDVT_WRA_0			MTK_M4U_ID(SMI_L20_ID, 2)
+#define M4U_L20_P3_FDVT_WRB_0			MTK_M4U_ID(SMI_L20_ID, 3)
+#define M4U_L20_P4_RSC_RDMA			MTK_M4U_ID(SMI_L20_ID, 4)
+#define M4U_L20_P5_RSC_WDMA			MTK_M4U_ID(SMI_L20_ID, 5)
+
+/* fake larb21 for gce */
+#define M4U_L21_GCE_DM				MTK_M4U_ID(21, 0)
+#define M4U_L21_GCE_MM				MTK_M4U_ID(21, 1)
+
+/* fake larb & port for svp and dual svp and wfd */
+#define M4U_PORT_SVP_HEAP			MTK_M4U_ID(22, 0)
+#define M4U_PORT_DUAL_SVP_HEAP			MTK_M4U_ID(22, 1)
+#define M4U_PORT_WFD_HEAP			MTK_M4U_ID(22, 2)
+
+/* fake larb0 for apu */
+#define M4U_L0_APU_DATA				MTK_M4U_ID(0, 0)
+#define M4U_L0_APU_CODE				MTK_M4U_ID(0, 1)
+#define M4U_L0_APU_SECURE			MTK_M4U_ID(0, 2)
+#define M4U_L0_APU_VLM				MTK_M4U_ID(0, 3)
+
+/* infra/peri */
+#define IFR_IOMMU_PORT_PCIE_0			MTK_IFAIOMMU_PERI_ID(0, 26)
+
+#endif
-- 
2.46.0

