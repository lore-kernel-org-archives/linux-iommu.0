Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECDE1E3769
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456222; cv=none; b=ge/C9BMYWEzzzkU9tcpS7iIcRkgg2rOzlttjGCVAeZQ2dsvho2k1bL///GZA8rWCL20+PQya5dpIOYAZGT4E6uknV8BN9MGSDglyKzbgYjEWQizSqlj/6CaNP5uQR+K/HwmlfVgDzsEMJ9O+7PCj4SGiYb3xde2LERiZXWSRQIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456222; c=relaxed/simple;
	bh=QUGY3rkmtVoD3tHpG62iITmUH7/XB4DVazXPbAB7JRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lx9ucH5KFGMXyd/wW5oXlvL2ddEKwtznPpAfkscnOkcgbHf0G/RZyJsDTHK8yy5jUOO2dOfeI+s7wA2oCWayJXDHIijAngWs2WY9xOBSWpj2TVtSwPbqvtkIgA/W295JC1wo/ofwHxvik4imj41XV3kBwcZyiSZeeYQrBXuIXew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=mUJETuyh; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="mUJETuyh"
X-UUID: 1872f8ae055e11f0aae1fd9735fae912-20250320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5qHAYtFd6rXrz8mhxpnZgWVp55Rzbc1r0E1fWMbG0Ao=;
	b=mUJETuyhnamsQGHDKgsn13o+3+cr7Dd0dUSWBBHhcxuuxa8CbIPZskOXboLiLSYg4RESsMDUROBfb2l6pA/HB+HFbX4nPFPRAifH1dpYdoyqTEDcXp66vgpgrazET88qWC7wrlXud8WWnrCQ/j7ApNFyV1Viuh2raKCIGWiM5TI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:0422b30b-9916-4e5c-90eb-c21b74cd40cf,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:d81194c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1872f8ae055e11f0aae1fd9735fae912-20250320
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <xueqi.zhang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 594627337; Thu, 20 Mar 2025 15:36:54 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 20 Mar 2025 15:36:52 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 20 Mar 2025 15:36:52 +0800
From: Xueqi Zhang <xueqi.zhang@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob
 Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Wendy-st Lin <wendy-st.lin@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<iommu@lists.linux.dev>, Xueqi Zhang <xueqi.zhang@mediatek.com>
Subject: [PATCH 1/3] dt-bindings: memory: mediatek: Add mt8196 support
Date: Thu, 20 Mar 2025 15:36:16 +0800
Message-ID: <20250320073625.25225-2-xueqi.zhang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250320073625.25225-1-xueqi.zhang@mediatek.com>
References: <20250320073625.25225-1-xueqi.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add mt8196 smi support in the bindings.
Since mt8196 has more than 32 SMI larbs, update 'mediatek,larb-id'
maximum to 63.

Signed-off-by: Xueqi Zhang <xueqi.zhang@mediatek.com>
---
 .../mediatek,smi-common.yaml                  |   4 +-
 .../memory-controllers/mediatek,smi-larb.yaml |   4 +-
 .../dt-bindings/memory/mt8196-memory-port.h   | 460 ++++++++++++++++++
 include/dt-bindings/memory/mtk-memory-port.h  |   4 +-
 4 files changed, 468 insertions(+), 4 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt8196-memory-port.h

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
index 2f36ac23604c..70418c3a227c 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
@@ -16,7 +16,7 @@ description: |
   MediaTek SMI have two generations of HW architecture, here is the list
   which generation the SoCs use:
   generation 1: mt2701 and mt7623.
-  generation 2: mt2712, mt6779, mt8167, mt8173, mt8183, mt8186, mt8188, mt8192 and mt8195.
+  generation 2: mt2712, mt6779, mt8167, mt8173, mt8183, mt8186, mt8188, mt8192, mt8195 and mt8196.
 
   There's slight differences between the two SMI, for generation 2, the
   register which control the iommu port is at each larb's register base. But
@@ -43,6 +43,8 @@ properties:
           - mediatek,mt8195-smi-common-vdo
           - mediatek,mt8195-smi-common-vpp
           - mediatek,mt8195-smi-sub-common
+          - mediatek,mt8196-smi-common
+          - mediatek,mt8196-smi-sub-common
           - mediatek,mt8365-smi-common
 
       - description: for mt7623
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
index 2381660b324c..a6b561ba217b 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
@@ -28,6 +28,7 @@ properties:
           - mediatek,mt8188-smi-larb
           - mediatek,mt8192-smi-larb
           - mediatek,mt8195-smi-larb
+          - mediatek,mt8196-smi-larb
 
       - description: for mt7623
         items:
@@ -65,7 +66,7 @@ properties:
   mediatek,larb-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
-    maximum: 31
+    maximum: 63
     description: the hardware id of this larb. It's only required when this
       hardware id is not consecutive from its M4U point of view.
 
@@ -120,6 +121,7 @@ allOf:
               - mediatek,mt8188-smi-larb
               - mediatek,mt8192-smi-larb
               - mediatek,mt8195-smi-larb
+              - mediatek,mt8196-smi-larb
 
     then:
       required:
diff --git a/include/dt-bindings/memory/mt8196-memory-port.h b/include/dt-bindings/memory/mt8196-memory-port.h
new file mode 100644
index 000000000000..8fd29780311b
--- /dev/null
+++ b/include/dt-bindings/memory/mt8196-memory-port.h
@@ -0,0 +1,460 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Mingyuan Ma <mingyuan.ma@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_MEMORY_MT8196_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT8196_LARB_PORT_H_
+
+#include <dt-bindings/memory/mtk-memory-port.h>
+
+/* Larb0 -- 13 */
+#define MT8196_SMI_L0_P0_OVL_RDMA2_HDR                  MTK_M4U_ID(0, 0)
+#define MT8196_SMI_L0_P1_OVL_RDMA7_HDR		        MTK_M4U_ID(0, 1)
+#define MT8196_SMI_L0_P2_OVL_RDMA2			MTK_M4U_ID(0, 2)
+#define MT8196_SMI_L0_P3_OVL_RDMA7			MTK_M4U_ID(0, 3)
+#define MT8196_SMI_L0_P4_RESERVED			MTK_M4U_ID(0, 4)
+#define MT8196_SMI_L0_P5_RESERVED			MTK_M4U_ID(0, 5)
+#define MT8196_SMI_L0_P6_OVL_RDMA2_HDR_STASH		MTK_M4U_ID(0, 6)
+#define MT8196_SMI_L0_P7_OVL_RDMA7_HDR_STASH		MTK_M4U_ID(0, 7)
+#define MT8196_SMI_L0_P8_OVL_RDMA2_STASH		MTK_M4U_ID(0, 8)
+#define MT8196_SMI_L0_P9_OVL_RDMA7_STASH		MTK_M4U_ID(0, 9)
+#define MT8196_SMI_L0_P10_RESERVED			MTK_M4U_ID(0, 10)
+#define MT8196_SMI_L0_P11_RESERVED			MTK_M4U_ID(0, 11)
+#define MT8196_SMI_L0_P12_DISP_FAKE0			MTK_M4U_ID(0, 12)
+
+/* Larb1 -- 16 */
+#define MT8196_SMI_L1_P0_OVL_RDMA3_HDR		        MTK_M4U_ID(1, 0)
+#define MT8196_SMI_L1_P1_OVL_RDMA6_HDR		        MTK_M4U_ID(1, 1)
+#define MT8196_SMI_L1_P2_OVL_RDMA3			MTK_M4U_ID(1, 2)
+#define MT8196_SMI_L1_P3_OVL_RDMA6			MTK_M4U_ID(1, 3)
+#define MT8196_SMI_L1_P4_MDP_RDMA1			MTK_M4U_ID(1, 4)
+#define MT8196_SMI_L1_P5_RESERVED			MTK_M4U_ID(1, 5)
+#define MT8196_SMI_L1_P6_DISP_WDMA1			MTK_M4U_ID(1, 6)
+#define MT8196_SMI_L1_P7_OVL_RDMA3_HDR_STASH		MTK_M4U_ID(1, 7)
+#define MT8196_SMI_L1_P8_OVL_RDMA6_HDR_STASH		MTK_M4U_ID(1, 8)
+#define MT8196_SMI_L1_P9_OVL_RDMA3_STASH		MTK_M4U_ID(1, 9)
+#define MT8196_SMI_L1_P10_OVL_RDMA6_STASH		MTK_M4U_ID(1, 10)
+#define MT8196_SMI_L1_P11_MDP_RDMA1_STASH		MTK_M4U_ID(1, 11)
+#define MT8196_SMI_L1_P12_DISP_BWM0			MTK_M4U_ID(1, 12)
+#define MT8196_SMI_L1_P13_DISP_BWM0_STASH		MTK_M4U_ID(1, 13)
+#define MT8196_SMI_L1_P14_RESERVED			MTK_M4U_ID(1, 14)
+#define MT8196_SMI_L1_P15_DISP_FAKE1			MTK_M4U_ID(1, 15)
+
+/* Larb2 -- 18 */
+#define MT8196_SMI_L2_P0_MDP_RDMA2			MTK_M4U_ID(2, 0)
+#define MT8196_SMI_L2_P1_MDP_WROT2			MTK_M4U_ID(2, 1)
+#define MT8196_SMI_L2_P2_MDP_RDMA1			MTK_M4U_ID(2, 2)
+#define MT8196_SMI_L2_P3_MDP_WROT1			MTK_M4U_ID(2, 3)
+#define MT8196_SMI_L2_P4_MDP_RDMA0			MTK_M4U_ID(2, 4)
+#define MT8196_SMI_L2_P5_MDP_WROT0			MTK_M4U_ID(2, 5)
+#define MT8196_SMI_L2_P6_MDP_RROT0			MTK_M4U_ID(2, 6)
+#define MT8196_SMI_L2_P7_MDP_FG0			MTK_M4U_ID(2, 7)
+#define MT8196_SMI_L2_P8_RESERVED			MTK_M4U_ID(2, 8)
+#define MT8196_SMI_L2_P9_MDP_WROT2_STASH		MTK_M4U_ID(2, 9)
+#define MT8196_SMI_L2_P10_MDP_RDMA1_STASH		MTK_M4U_ID(2, 10)
+#define MT8196_SMI_L2_P11_MDP_WROT1_STASH		MTK_M4U_ID(2, 11)
+#define MT8196_SMI_L2_P12_MDP_RDMA0_STASH		MTK_M4U_ID(2, 12)
+#define MT8196_SMI_L2_P13_MDP_WROT0_STASH		MTK_M4U_ID(2, 13)
+#define MT8196_SMI_L2_P14_MDP_RROT0_STASH		MTK_M4U_ID(2, 14)
+#define MT8196_SMI_L2_P15_MDP_RDMA2_STASH		MTK_M4U_ID(2, 15)
+#define MT8196_SMI_L2_P16_RESERVED			MTK_M4U_ID(2, 16)
+#define MT8196_SMI_L2_P17_MDP_FAKE_ENG0		        MTK_M4U_ID(2, 17)
+
+/* Larb3 -- 18 */
+#define MT8196_SMI_L3_P0_MDP_RDMA2			MTK_M4U_ID(3, 0)
+#define MT8196_SMI_L3_P1_MDP_WROT2			MTK_M4U_ID(3, 1)
+#define MT8196_SMI_L3_P2_MDP_RDMA1			MTK_M4U_ID(3, 2)
+#define MT8196_SMI_L3_P3_MDP_WROT1			MTK_M4U_ID(3, 3)
+#define MT8196_SMI_L3_P4_MDP_RDMA0			MTK_M4U_ID(3, 4)
+#define MT8196_SMI_L3_P5_MDP_WROT0			MTK_M4U_ID(3, 5)
+#define MT8196_SMI_L3_P6_MDP_RROT0			MTK_M4U_ID(3, 6)
+#define MT8196_SMI_L3_P7_MDP_FG0			MTK_M4U_ID(3, 7)
+#define MT8196_SMI_L3_P8_RESERVED			MTK_M4U_ID(3, 8)
+#define MT8196_SMI_L3_P9_MDP_RDMA0_STASH		MTK_M4U_ID(3, 9)
+#define MT8196_SMI_L3_P10_MDP_WROT0_STASH		MTK_M4U_ID(3, 10)
+#define MT8196_SMI_L3_P11_MDP_RROT0_STASH		MTK_M4U_ID(3, 11)
+#define MT8196_SMI_L3_P12_MDP_RDMA2_STASH		MTK_M4U_ID(3, 12)
+#define MT8196_SMI_L3_P13_MDP_WROT2_STASH		MTK_M4U_ID(3, 13)
+#define MT8196_SMI_L3_P14_MDP_RDMA1_STASH		MTK_M4U_ID(3, 14)
+#define MT8196_SMI_L3_P15_MDP_WROT1_STASH		MTK_M4U_ID(3, 15)
+#define MT8196_SMI_L3_P16_RESERVED			MTK_M4U_ID(3, 16)
+#define MT8196_SMI_L3_P17_MDP_FAKE_ENG0		        MTK_M4U_ID(3, 17)
+
+/* Larb4 -- 8 */
+#define MT8196_SMI_L4_P0_VDEC_MC_C			MTK_M4U_ID(4, 0)
+#define MT8196_SMI_L4_P1_VDEC_UFO			MTK_M4U_ID(4, 1)
+#define MT8196_SMI_L4_P2_VDEC_PP			MTK_M4U_ID(4, 2)
+#define MT8196_SMI_L4_P3_VDEC_UFO_C			MTK_M4U_ID(4, 3)
+#define MT8196_SMI_L4_P4_VDEC_TILE			MTK_M4U_ID(4, 4)
+#define MT8196_SMI_L4_P5_VDEC_VLD			MTK_M4U_ID(4, 5)
+#define MT8196_SMI_L4_P6_VDEC_VLD2			MTK_M4U_ID(4, 6)
+#define MT8196_SMI_L4_P7_VDEC_AVC_MV			MTK_M4U_ID(4, 7)
+
+/* Larb5 -- 8 */
+#define MT8196_SMI_L5_P0_VDEC_LAT0_VLD		        MTK_M4U_ID(5, 0)
+#define MT8196_SMI_L5_P1_VDEC_LAT0_VLD2		        MTK_M4U_ID(5, 1)
+#define MT8196_SMI_L5_P2_VDEC_MC			MTK_M4U_ID(5, 2)
+#define MT8196_SMI_L5_P3_VDEC_UFO_ENC			MTK_M4U_ID(5, 3)
+#define MT8196_SMI_L5_P4_VDEC_LAT0_WDMA		        MTK_M4U_ID(5, 4)
+#define MT8196_SMI_L5_P5_VDEC_LAT0_AVC_MV		MTK_M4U_ID(5, 5)
+#define MT8196_SMI_L5_P6_VDEC_LAT0_TILE		        MTK_M4U_ID(5, 6)
+#define MT8196_SMI_L5_P7_VDEC_LAT0_UNIWRAP		MTK_M4U_ID(5, 7)
+
+/* Larb6 -- 3 */
+#define MT8196_SMI_L6_P0_VDEC_MC_PORT2		        MTK_M4U_ID(6, 0)
+#define MT8196_SMI_L6_P1_VDEC_UFO_ENC_C		        MTK_M4U_ID(6, 1)
+#define MT8196_SMI_L6_P2_VDEC_UNIWRAP			MTK_M4U_ID(6, 2)
+
+/* Larb7 -- 32 */
+#define MT8196_SMI_L7_P0_RCPU				MTK_M4U_ID(7, 0)
+#define MT8196_SMI_L7_P1_REC_FRM			MTK_M4U_ID(7, 1)
+#define MT8196_SMI_L7_P2_BS				MTK_M4U_ID(7, 2)
+#define MT8196_SMI_L7_P3_SVCOMV			        MTK_M4U_ID(7, 3)
+#define MT8196_SMI_L7_P4_RDCOMV			        MTK_M4U_ID(7, 4)
+#define MT8196_SMI_L7_P5_NBM_R			        MTK_M4U_ID(7, 5)
+#define MT8196_SMI_L7_P6_NBM_R_LITE			MTK_M4U_ID(7, 6)
+#define MT8196_SMI_L7_P7_JPGENC_YRD			MTK_M4U_ID(7, 7)
+#define MT8196_SMI_L7_P8_JPGENC_CRD			MTK_M4U_ID(7, 8)
+#define MT8196_SMI_L7_P9_JPGENC_QT			MTK_M4U_ID(7, 9)
+#define MT8196_SMI_L7_P10_FCS_SUB_W			MTK_M4U_ID(7, 10)
+#define MT8196_SMI_L7_P11_FCS_NBM_R			MTK_M4U_ID(7, 11)
+#define MT8196_SMI_L7_P12_WPP_BS			MTK_M4U_ID(7, 12)
+#define MT8196_SMI_L7_P13_WPP_RDMA			MTK_M4U_ID(7, 13)
+#define MT8196_SMI_L7_P14_DB_SYSRAM_W			MTK_M4U_ID(7, 14)
+#define MT8196_SMI_L7_P15_DB_SYSRAM_R			MTK_M4U_ID(7, 15)
+#define MT8196_SMI_L7_P16_JPGENC_BS			MTK_M4U_ID(7, 16)
+#define MT8196_SMI_L7_P17_JPGDEC_W			MTK_M4U_ID(7, 17)
+#define MT8196_SMI_L7_P18_JPGDEC_BS			MTK_M4U_ID(7, 18)
+#define MT8196_SMI_L7_P19_NBM_W			        MTK_M4U_ID(7, 19)
+#define MT8196_SMI_L7_P20_NBM_W_LITE			MTK_M4U_ID(7, 20)
+#define MT8196_SMI_L7_P21_CUR_LUMA			MTK_M4U_ID(7, 21)
+#define MT8196_SMI_L7_P22_CUR_CHROMA			MTK_M4U_ID(7, 22)
+#define MT8196_SMI_L7_P23_REF_LUMA			MTK_M4U_ID(7, 23)
+#define MT8196_SMI_L7_P24_REF_CHROMA			MTK_M4U_ID(7, 24)
+#define MT8196_SMI_L7_P25_FCS_SUB_R			MTK_M4U_ID(7, 25)
+#define MT8196_SMI_L7_P26_FCS_NBM_W			MTK_M4U_ID(7, 26)
+#define MT8196_SMI_L7_P27_JPGDEC_W_1			MTK_M4U_ID(7, 27)
+#define MT8196_SMI_L7_P28_JPGDEC_BS_1			MTK_M4U_ID(7, 28)
+#define MT8196_SMI_L7_P29_JPGDEC_HUF_1		        MTK_M4U_ID(7, 29)
+#define MT8196_SMI_L7_P30_JPGDEC_HUF			MTK_M4U_ID(7, 30)
+#define MT8196_SMI_L7_P31_EC_SYSRAM			MTK_M4U_ID(7, 31)
+
+/* Larb8 -- 32 */
+#define MT8196_SMI_L8_P0_RCPU				MTK_M4U_ID(8, 0)
+#define MT8196_SMI_L8_P1_REC_FRM			MTK_M4U_ID(8, 1)
+#define MT8196_SMI_L8_P2_BS				MTK_M4U_ID(8, 2)
+#define MT8196_SMI_L8_P3_SVCOMV			        MTK_M4U_ID(8, 3)
+#define MT8196_SMI_L8_P4_RDCOMV			        MTK_M4U_ID(8, 4)
+#define MT8196_SMI_L8_P5_NBM_R			        MTK_M4U_ID(8, 5)
+#define MT8196_SMI_L8_P6_NBM_R_LITE			MTK_M4U_ID(8, 6)
+#define MT8196_SMI_L8_P7_JPGENC_YRD			MTK_M4U_ID(8, 7)
+#define MT8196_SMI_L8_P8_JPGENC_CRD			MTK_M4U_ID(8, 8)
+#define MT8196_SMI_L8_P9_JPGENC_QT			MTK_M4U_ID(8, 9)
+#define MT8196_SMI_L8_P10_FCS_SUB_W			MTK_M4U_ID(8, 10)
+#define MT8196_SMI_L8_P11_FCS_NBM_R			MTK_M4U_ID(8, 11)
+#define MT8196_SMI_L8_P12_WPP_BS			MTK_M4U_ID(8, 12)
+#define MT8196_SMI_L8_P13_WPP_RDMA			MTK_M4U_ID(8, 13)
+#define MT8196_SMI_L8_P14_DB_SYSRAM_W			MTK_M4U_ID(8, 14)
+#define MT8196_SMI_L8_P15_DB_SYSRAM_R			MTK_M4U_ID(8, 15)
+#define MT8196_SMI_L8_P16_JPGENC_BS			MTK_M4U_ID(8, 16)
+#define MT8196_SMI_L8_P17_JPGDEC_W			MTK_M4U_ID(8, 17)
+#define MT8196_SMI_L8_P18_JPGDEC_BS			MTK_M4U_ID(8, 18)
+#define MT8196_SMI_L8_P19_NBM_W			        MTK_M4U_ID(8, 19)
+#define MT8196_SMI_L8_P20_NBM_W_LITE			MTK_M4U_ID(8, 20)
+#define MT8196_SMI_L8_P21_CUR_LUMA			MTK_M4U_ID(8, 21)
+#define MT8196_SMI_L8_P22_CUR_CHROMA			MTK_M4U_ID(8, 22)
+#define MT8196_SMI_L8_P23_REF_LUMA			MTK_M4U_ID(8, 23)
+#define MT8196_SMI_L8_P24_REF_CHROMA			MTK_M4U_ID(8, 24)
+#define MT8196_SMI_L8_P25_FCS_SUB_R			MTK_M4U_ID(8, 25)
+#define MT8196_SMI_L8_P26_FCS_NBM_W			MTK_M4U_ID(8, 26)
+#define MT8196_SMI_L8_P27_JPGDEC_W_1			MTK_M4U_ID(8, 27)
+#define MT8196_SMI_L8_P28_JPGDEC_BS_1			MTK_M4U_ID(8, 28)
+#define MT8196_SMI_L8_P29_JPGDEC_HUF_1		        MTK_M4U_ID(8, 29)
+#define MT8196_SMI_L8_P30_JPGDEC_HUF			MTK_M4U_ID(8, 30)
+#define MT8196_SMI_L8_P31_EC_SYSRAM			MTK_M4U_ID(8, 31)
+
+/* Larb20 -- 15 */
+#define MT8196_SMI_L20_P0_OVL_RDMA4_HDR		        MTK_M4U_ID(20, 0)
+#define MT8196_SMI_L20_P1_OVL_RDMA9_HDR		        MTK_M4U_ID(20, 1)
+#define MT8196_SMI_L20_P2_OVL_RDMA0_HDR		        MTK_M4U_ID(20, 2)
+#define MT8196_SMI_L20_P3_OVL_RDMA4			MTK_M4U_ID(20, 3)
+#define MT8196_SMI_L20_P4_OVL_RDMA9			MTK_M4U_ID(20, 4)
+#define MT8196_SMI_L20_P5_OVL_RDMA0			MTK_M4U_ID(20, 5)
+#define MT8196_SMI_L20_P6_RESERVED			MTK_M4U_ID(20, 6)
+#define MT8196_SMI_L20_P7_OVL_RDMA4_HDR_STASH		MTK_M4U_ID(20, 7)
+#define MT8196_SMI_L20_P8_OVL_RDMA9_HDR_STASH		MTK_M4U_ID(20, 8)
+#define MT8196_SMI_L20_P9_OVL_RDMA0_HDR_STASH		MTK_M4U_ID(20, 9)
+#define MT8196_SMI_L20_P10_OVL_RDMA4_STASH		MTK_M4U_ID(20, 10)
+#define MT8196_SMI_L20_P11_OVL_RDMA9_STASH		MTK_M4U_ID(20, 11)
+#define MT8196_SMI_L20_P12_OVL_RDMA0_STASH		MTK_M4U_ID(20, 12)
+#define MT8196_SMI_L20_P13_RESERVED			MTK_M4U_ID(20, 13)
+#define MT8196_SMI_L20_P14_RESERVED			MTK_M4U_ID(20, 14)
+
+/* Larb21 -- 18 */
+#define MT8196_SMI_L21_P0_OVL_RDMA5_HDR		        MTK_M4U_ID(21, 0)
+#define MT8196_SMI_L21_P1_OVL_RDMA8_HDR		        MTK_M4U_ID(21, 1)
+#define MT8196_SMI_L21_P2_OVL_RDMA1_HDR		        MTK_M4U_ID(21, 2)
+#define MT8196_SMI_L21_P3_OVL_RDMA5			MTK_M4U_ID(21, 3)
+#define MT8196_SMI_L21_P4_OVL_RDMA8			MTK_M4U_ID(21, 4)
+#define MT8196_SMI_L21_P5_OVL_RDMA1			MTK_M4U_ID(21, 5)
+#define MT8196_SMI_L21_P6_RESERVED			MTK_M4U_ID(21, 6)
+#define MT8196_SMI_L21_P7_MDP_RDMA0			MTK_M4U_ID(21, 7)
+#define MT8196_SMI_L21_P8_DISP_WDMA0			MTK_M4U_ID(21, 8)
+#define MT8196_SMI_L21_P9_DISP_UFBC_WDMA0		MTK_M4U_ID(21, 9)
+#define MT8196_SMI_L21_P10_OVL_RDMA5_HDR_STASH	        MTK_M4U_ID(21, 10)
+#define MT8196_SMI_L21_P11_OVL_RDMA8_HDR_STASH	        MTK_M4U_ID(21, 11)
+#define MT8196_SMI_L21_P12_OVL_RDMA1_HDR_STASH	        MTK_M4U_ID(21, 12)
+#define MT8196_SMI_L21_P13_OVL_RDMA5_STASH		MTK_M4U_ID(21, 13)
+#define MT8196_SMI_L21_P14_OVL_RDMA8_STASH		MTK_M4U_ID(21, 14)
+#define MT8196_SMI_L21_P15_OVL_RDMA1_STASH		MTK_M4U_ID(21, 15)
+#define MT8196_SMI_L21_P16_MDP_RDMA0_STASH		MTK_M4U_ID(21, 16)
+#define MT8196_SMI_L21_P17_RESERVED			MTK_M4U_ID(21, 17)
+
+/* Larb24 -- 32 */
+#define MT8196_SMI_L24_P0_RCPU			        MTK_M4U_ID(24, 0)
+#define MT8196_SMI_L24_P1_REC_FRM			MTK_M4U_ID(24, 1)
+#define MT8196_SMI_L24_P2_BS				MTK_M4U_ID(24, 2)
+#define MT8196_SMI_L24_P3_SVCOMV			MTK_M4U_ID(24, 3)
+#define MT8196_SMI_L24_P4_RDCOMV			MTK_M4U_ID(24, 4)
+#define MT8196_SMI_L24_P5_NBM_R			        MTK_M4U_ID(24, 5)
+#define MT8196_SMI_L24_P6_NBM_R_LITE			MTK_M4U_ID(24, 6)
+#define MT8196_SMI_L24_P7_JPGENC_YRD			MTK_M4U_ID(24, 7)
+#define MT8196_SMI_L24_P8_JPGENC_CRD			MTK_M4U_ID(24, 8)
+#define MT8196_SMI_L24_P9_JPGENC_QT			MTK_M4U_ID(24, 9)
+#define MT8196_SMI_L24_P10_FCS_SUB_W			MTK_M4U_ID(24, 10)
+#define MT8196_SMI_L24_P11_FCS_NBM_R			MTK_M4U_ID(24, 11)
+#define MT8196_SMI_L24_P12_WPP_BS			MTK_M4U_ID(24, 12)
+#define MT8196_SMI_L24_P13_WPP_RDMA			MTK_M4U_ID(24, 13)
+#define MT8196_SMI_L24_P14_DB_SYSRAM_W		        MTK_M4U_ID(24, 14)
+#define MT8196_SMI_L24_P15_DB_SYSRAM_R		        MTK_M4U_ID(24, 15)
+#define MT8196_SMI_L24_P16_JPGENC_BS			MTK_M4U_ID(24, 16)
+#define MT8196_SMI_L24_P17_JPGDEC_W			MTK_M4U_ID(24, 17)
+#define MT8196_SMI_L24_P18_JPGDEC_BS			MTK_M4U_ID(24, 18)
+#define MT8196_SMI_L24_P19_NBM_W			MTK_M4U_ID(24, 19)
+#define MT8196_SMI_L24_P20_NBM_W_LITE			MTK_M4U_ID(24, 20)
+#define MT8196_SMI_L24_P21_CUR_LUMA			MTK_M4U_ID(24, 21)
+#define MT8196_SMI_L24_P22_CUR_CHROMA			MTK_M4U_ID(24, 22)
+#define MT8196_SMI_L24_P23_REF_LUMA			MTK_M4U_ID(24, 23)
+#define MT8196_SMI_L24_P24_REF_CHROMA			MTK_M4U_ID(24, 24)
+#define MT8196_SMI_L24_P25_FCS_SUB_R			MTK_M4U_ID(24, 25)
+#define MT8196_SMI_L24_P26_FCS_NBM_W			MTK_M4U_ID(24, 26)
+#define MT8196_SMI_L24_P27_JPGDEC_W_1			MTK_M4U_ID(24, 27)
+#define MT8196_SMI_L24_P28_JPGDEC_BS_1		        MTK_M4U_ID(24, 28)
+#define MT8196_SMI_L24_P29_JPGDEC_HUF_1		        MTK_M4U_ID(24, 29)
+#define MT8196_SMI_L24_P30_JPGDEC_HUF			MTK_M4U_ID(24, 30)
+#define MT8196_SMI_L24_P31_EC_SYSRAM			MTK_M4U_ID(24, 31)
+
+/* Larb32 -- 10 */
+#define MT8196_SMI_L32_P0_DISP_RESERVED_0		MTK_M4U_ID(32, 0)
+#define MT8196_SMI_L32_P1_DISP_RESERVED_1		MTK_M4U_ID(32, 1)
+#define MT8196_SMI_L32_P2_DISP_RESERVED_2		MTK_M4U_ID(32, 2)
+#define MT8196_SMI_L32_P3_DISP_RESERVED_3		MTK_M4U_ID(32, 3)
+#define MT8196_SMI_L32_P4_DISP_POSTMASK0		MTK_M4U_ID(32, 4)
+#define MT8196_SMI_L32_P5_DISP_POSTMASK1		MTK_M4U_ID(32, 5)
+#define MT8196_SMI_L32_P6_DISP_MDP_RDMA0		MTK_M4U_ID(32, 6)
+#define MT8196_SMI_L32_P7_DISP_WDMA0			MTK_M4U_ID(32, 7)
+#define MT8196_SMI_L32_P8_DISP_FAKE_ENG0		MTK_M4U_ID(32, 8)
+#define MT8196_SMI_L32_P9_DISP_MDP_RDMA0_STASH	        MTK_M4U_ID(32, 9)
+
+/* Larb33 -- 16 */
+#define MT8196_SMI_L33_P0_DISP1_ODDMR0_DMRR0		MTK_M4U_ID(33, 0)
+#define MT8196_SMI_L33_P1_RESERVED			MTK_M4U_ID(33, 1)
+#define MT8196_SMI_L33_P2_RESERVED			MTK_M4U_ID(33, 2)
+#define MT8196_SMI_L33_P3_RESERVED			MTK_M4U_ID(33, 3)
+#define MT8196_SMI_L33_P4_DISP1_ODDMR0_DBIR		MTK_M4U_ID(33, 4)
+#define MT8196_SMI_L33_P5_DISP1_ODDMR0_ODR		MTK_M4U_ID(33, 5)
+#define MT8196_SMI_L33_P6_DISP1_ODDMR0_ODW		MTK_M4U_ID(33, 6)
+#define MT8196_SMI_L33_P7_RESERVED			MTK_M4U_ID(33, 7)
+#define MT8196_SMI_L33_P8_DISP1_GDMA0			MTK_M4U_ID(33, 8)
+#define MT8196_SMI_L33_P9_DISP1_MDP_RDMA1		MTK_M4U_ID(33, 9)
+#define MT8196_SMI_L33_P10_DISP1_WDMA1		        MTK_M4U_ID(33, 10)
+#define MT8196_SMI_L33_P11_DISP1_WDMA2		        MTK_M4U_ID(33, 11)
+#define MT8196_SMI_L33_P12_DISP1_WDMA3		        MTK_M4U_ID(33, 12)
+#define MT8196_SMI_L33_P13_DISP1_WDMA4		        MTK_M4U_ID(33, 13)
+#define MT8196_SMI_L33_P14_DISP1_MDP_RDMA1_STASH	MTK_M4U_ID(33, 14)
+#define MT8196_SMI_L33_P15_RESERVED			MTK_M4U_ID(33, 15)
+
+/* Larb34 -- 13 */
+#define MT8196_SMI_L34_P0_OVL_RDMA2_HDR		        MTK_M4U_ID(34, 0)
+#define MT8196_SMI_L34_P1_OVL_RDMA7_HDR		        MTK_M4U_ID(34, 1)
+#define MT8196_SMI_L34_P2_OVL_RDMA2			MTK_M4U_ID(34, 2)
+#define MT8196_SMI_L34_P3_OVL_RDMA7			MTK_M4U_ID(34, 3)
+#define MT8196_SMI_L34_P4_RESERVED			MTK_M4U_ID(34, 4)
+#define MT8196_SMI_L34_P5_RESERVED			MTK_M4U_ID(34, 5)
+#define MT8196_SMI_L34_P6_OVL_RDMA2_HDR_STASH		MTK_M4U_ID(34, 6)
+#define MT8196_SMI_L34_P7_OVL_RDMA7_HDR_STASH		MTK_M4U_ID(34, 7)
+#define MT8196_SMI_L34_P8_OVL_RDMA2_STASH		MTK_M4U_ID(34, 8)
+#define MT8196_SMI_L34_P9_OVL_RDMA7_STASH		MTK_M4U_ID(34, 9)
+#define MT8196_SMI_L34_P10_RESERVED			MTK_M4U_ID(34, 10)
+#define MT8196_SMI_L34_P11_RESERVED			MTK_M4U_ID(34, 11)
+#define MT8196_SMI_L34_P12_DISP_FAKE0			MTK_M4U_ID(34, 12)
+
+/* Larb35 -- 16 */
+#define MT8196_SMI_L35_P0_OVL_RDMA3_HDR		        MTK_M4U_ID(35, 0)
+#define MT8196_SMI_L35_P1_OVL_RDMA6_HDR		        MTK_M4U_ID(35, 1)
+#define MT8196_SMI_L35_P2_OVL_RDMA3			MTK_M4U_ID(35, 2)
+#define MT8196_SMI_L35_P3_OVL_RDMA6			MTK_M4U_ID(35, 3)
+#define MT8196_SMI_L35_P4_MDP_RDMA1			MTK_M4U_ID(35, 4)
+#define MT8196_SMI_L35_P5_RESERVED			MTK_M4U_ID(35, 5)
+#define MT8196_SMI_L35_P6_DISP_WDMA1			MTK_M4U_ID(35, 6)
+#define MT8196_SMI_L35_P7_OVL_RDMA3_HDR_STASH		MTK_M4U_ID(35, 7)
+#define MT8196_SMI_L35_P8_OVL_RDMA6_HDR_STASH		MTK_M4U_ID(35, 8)
+#define MT8196_SMI_L35_P9_OVL_RDMA3_STASH		MTK_M4U_ID(35, 9)
+#define MT8196_SMI_L35_P10_OVL_RDMA6_STASH		MTK_M4U_ID(35, 10)
+#define MT8196_SMI_L35_P11_MDP_RDMA1_STASH		MTK_M4U_ID(35, 11)
+#define MT8196_SMI_L35_P12_DISP_BWM0			MTK_M4U_ID(35, 12)
+#define MT8196_SMI_L35_P13_DISP_BWM0_STASH		MTK_M4U_ID(35, 13)
+#define MT8196_SMI_L35_P14_RESERVED			MTK_M4U_ID(35, 14)
+#define MT8196_SMI_L35_P15_DISP_FAKE1			MTK_M4U_ID(35, 15)
+
+/* Larb36 -- 15 */
+#define MT8196_SMI_L36_P0_OVL_RDMA4_HDR		        MTK_M4U_ID(36, 0)
+#define MT8196_SMI_L36_P1_OVL_RDMA9_HDR		        MTK_M4U_ID(36, 1)
+#define MT8196_SMI_L36_P2_OVL_RDMA0_HDR		        MTK_M4U_ID(36, 2)
+#define MT8196_SMI_L36_P3_OVL_RDMA4			MTK_M4U_ID(36, 3)
+#define MT8196_SMI_L36_P4_OVL_RDMA9			MTK_M4U_ID(36, 4)
+#define MT8196_SMI_L36_P5_OVL_RDMA0			MTK_M4U_ID(36, 5)
+#define MT8196_SMI_L36_P6_RESERVED			MTK_M4U_ID(36, 6)
+#define MT8196_SMI_L36_P7_OVL_RDMA4_HDR_STASH		MTK_M4U_ID(36, 7)
+#define MT8196_SMI_L36_P8_OVL_RDMA9_HDR_STASH		MTK_M4U_ID(36, 8)
+#define MT8196_SMI_L36_P9_OVL_RDMA0_HDR_STASH		MTK_M4U_ID(36, 9)
+#define MT8196_SMI_L36_P10_OVL_RDMA4_STASH		MTK_M4U_ID(36, 10)
+#define MT8196_SMI_L36_P11_OVL_RDMA9_STASH		MTK_M4U_ID(36, 11)
+#define MT8196_SMI_L36_P12_OVL_RDMA0_STASH		MTK_M4U_ID(36, 12)
+#define MT8196_SMI_L36_P13_RESERVED			MTK_M4U_ID(36, 13)
+#define MT8196_SMI_L36_P14_RESERVED			MTK_M4U_ID(36, 14)
+
+/* Larb37 -- 18 */
+#define MT8196_SMI_L37_P0_OVL_RDMA5_HDR		        MTK_M4U_ID(37, 0)
+#define MT8196_SMI_L37_P1_OVL_RDMA8_HDR		        MTK_M4U_ID(37, 1)
+#define MT8196_SMI_L37_P2_OVL_RDMA1_HDR		        MTK_M4U_ID(37, 2)
+#define MT8196_SMI_L37_P3_OVL_RDMA5			MTK_M4U_ID(37, 3)
+#define MT8196_SMI_L37_P4_OVL_RDMA8			MTK_M4U_ID(37, 4)
+#define MT8196_SMI_L37_P5_OVL_RDMA1			MTK_M4U_ID(37, 5)
+#define MT8196_SMI_L37_P6_RESERVED			MTK_M4U_ID(37, 6)
+#define MT8196_SMI_L37_P7_MDP_RDMA0			MTK_M4U_ID(37, 7)
+#define MT8196_SMI_L37_P8_DISP_WDMA0			MTK_M4U_ID(37, 8)
+#define MT8196_SMI_L37_P9_DISP_UFBC_WDMA0		MTK_M4U_ID(37, 9)
+#define MT8196_SMI_L37_P10_OVL_RDMA5_HDR_STASH	        MTK_M4U_ID(37, 10)
+#define MT8196_SMI_L37_P11_OVL_RDMA8_HDR_STASH	        MTK_M4U_ID(37, 11)
+#define MT8196_SMI_L37_P12_OVL_RDMA1_HDR_STASH	        MTK_M4U_ID(37, 12)
+#define MT8196_SMI_L37_P13_OVL_RDMA5_STASH		MTK_M4U_ID(37, 13)
+#define MT8196_SMI_L37_P14_OVL_RDMA8_STASH		MTK_M4U_ID(37, 14)
+#define MT8196_SMI_L37_P15_OVL_RDMA1_STASH		MTK_M4U_ID(37, 15)
+#define MT8196_SMI_L37_P16_MDP_RDMA0_STASH		MTK_M4U_ID(37, 16)
+#define MT8196_SMI_L37_P17_RESERVED			MTK_M4U_ID(37, 17)
+
+/* Larb41 -- 32 */
+#define MT8196_SMI_L41_P0_ADAB_FORMATTER_R		MTK_M4U_ID(41, 0)
+#define MT8196_SMI_L41_P1_REC_FRM			MTK_M4U_ID(41, 1)
+#define MT8196_SMI_L41_P2_ADAB_FORMATTER_W		MTK_M4U_ID(41, 2)
+#define MT8196_SMI_L41_P3_ADAB_CUR_LUMA_R		MTK_M4U_ID(41, 3)
+#define MT8196_SMI_L41_P4_ADAB_REF_LUMA_R		MTK_M4U_ID(41, 4)
+#define MT8196_SMI_L41_P5_NBM_R			        MTK_M4U_ID(41, 5)
+#define MT8196_SMI_L41_P6_NBM_R_LITE			MTK_M4U_ID(41, 6)
+#define MT8196_SMI_L41_P7_JPGENC_YRD			MTK_M4U_ID(41, 7)
+#define MT8196_SMI_L41_P8_JPGENC_CRD			MTK_M4U_ID(41, 8)
+#define MT8196_SMI_L41_P9_JPGENC_QT			MTK_M4U_ID(41, 9)
+#define MT8196_SMI_L41_P10_FCS_SUB_W			MTK_M4U_ID(41, 10)
+#define MT8196_SMI_L41_P11_FCS_NBM_R			MTK_M4U_ID(41, 11)
+#define MT8196_SMI_L41_P12_WPP_BS			MTK_M4U_ID(41, 12)
+#define MT8196_SMI_L41_P13_WPP_RDMA			MTK_M4U_ID(41, 13)
+#define MT8196_SMI_L41_P14_DB_SYSRAM_W		        MTK_M4U_ID(41, 14)
+#define MT8196_SMI_L41_P15_DB_SYSRAM_R		        MTK_M4U_ID(41, 15)
+#define MT8196_SMI_L41_P16_JPGENC_BS			MTK_M4U_ID(41, 16)
+#define MT8196_SMI_L41_P17_JPGDEC_W			MTK_M4U_ID(41, 17)
+#define MT8196_SMI_L41_P18_JPGDEC_BS			MTK_M4U_ID(41, 18)
+#define MT8196_SMI_L41_P19_NBM_W			MTK_M4U_ID(41, 19)
+#define MT8196_SMI_L41_P20_NBM_W_LITE			MTK_M4U_ID(41, 20)
+#define MT8196_SMI_L41_P21_CUR_LUMA			MTK_M4U_ID(41, 21)
+#define MT8196_SMI_L41_P22_CUR_CHROMA			MTK_M4U_ID(41, 22)
+#define MT8196_SMI_L41_P23_REF_LUMA			MTK_M4U_ID(41, 23)
+#define MT8196_SMI_L41_P24_REF_CHROMA			MTK_M4U_ID(41, 24)
+#define MT8196_SMI_L41_P25_FCS_SUB_R			MTK_M4U_ID(41, 25)
+#define MT8196_SMI_L41_P26_FCS_NBM_W			MTK_M4U_ID(41, 26)
+#define MT8196_SMI_L41_P27_JPGDEC_W_1			MTK_M4U_ID(41, 27)
+#define MT8196_SMI_L41_P28_JPGDEC_BS_1		        MTK_M4U_ID(41, 28)
+#define MT8196_SMI_L41_P29_JPGDEC_HUF_1		        MTK_M4U_ID(41, 29)
+#define MT8196_SMI_L41_P30_JPGDEC_HUF			MTK_M4U_ID(41, 30)
+#define MT8196_SMI_L41_P31_EC_SYSRAM			MTK_M4U_ID(41, 31)
+
+/* Larb42 -- 32 */
+#define MT8196_SMI_L42_P0_RCPU			        MTK_M4U_ID(42, 0)
+#define MT8196_SMI_L42_P1_REC_FRM			MTK_M4U_ID(42, 1)
+#define MT8196_SMI_L42_P2_BS				MTK_M4U_ID(42, 2)
+#define MT8196_SMI_L42_P3_SVCOMV			MTK_M4U_ID(42, 3)
+#define MT8196_SMI_L42_P4_RDCOMV			MTK_M4U_ID(42, 4)
+#define MT8196_SMI_L42_P5_NBM_R			        MTK_M4U_ID(42, 5)
+#define MT8196_SMI_L42_P6_NBM_R_LITE			MTK_M4U_ID(42, 6)
+#define MT8196_SMI_L42_P7_JPGENC_YRD			MTK_M4U_ID(42, 7)
+#define MT8196_SMI_L42_P8_JPGENC_CRD			MTK_M4U_ID(42, 8)
+#define MT8196_SMI_L42_P9_JPGENC_QT			MTK_M4U_ID(42, 9)
+#define MT8196_SMI_L42_P10_FCS_SUB_W			MTK_M4U_ID(42, 10)
+#define MT8196_SMI_L42_P11_FCS_NBM_R			MTK_M4U_ID(42, 11)
+#define MT8196_SMI_L42_P12_WPP_BS			MTK_M4U_ID(42, 12)
+#define MT8196_SMI_L42_P13_WPP_RDMA			MTK_M4U_ID(42, 13)
+#define MT8196_SMI_L42_P14_DB_SYSRAM_W		        MTK_M4U_ID(42, 14)
+#define MT8196_SMI_L42_P15_DB_SYSRAM_R		        MTK_M4U_ID(42, 15)
+#define MT8196_SMI_L42_P16_JPGENC_BS			MTK_M4U_ID(42, 16)
+#define MT8196_SMI_L42_P17_JPGDEC_W			MTK_M4U_ID(42, 17)
+#define MT8196_SMI_L42_P18_JPGDEC_BS			MTK_M4U_ID(42, 18)
+#define MT8196_SMI_L42_P19_NBM_W			MTK_M4U_ID(42, 19)
+#define MT8196_SMI_L42_P20_NBM_W_LITE			MTK_M4U_ID(42, 20)
+#define MT8196_SMI_L42_P21_CUR_LUMA			MTK_M4U_ID(42, 21)
+#define MT8196_SMI_L42_P22_CUR_CHROMA			MTK_M4U_ID(42, 22)
+#define MT8196_SMI_L42_P23_REF_LUMA			MTK_M4U_ID(42, 23)
+#define MT8196_SMI_L42_P24_REF_CHROMA			MTK_M4U_ID(42, 24)
+#define MT8196_SMI_L42_P25_FCS_SUB_R			MTK_M4U_ID(42, 25)
+#define MT8196_SMI_L42_P26_FCS_NBM_W			MTK_M4U_ID(42, 26)
+#define MT8196_SMI_L42_P27_JPGDEC_W_1			MTK_M4U_ID(42, 27)
+#define MT8196_SMI_L42_P28_JPGDEC_BS_1		        MTK_M4U_ID(42, 28)
+#define MT8196_SMI_L42_P29_JPGDEC_HUF_1		        MTK_M4U_ID(42, 29)
+#define MT8196_SMI_L42_P30_JPGDEC_HUF			MTK_M4U_ID(42, 30)
+#define MT8196_SMI_L42_P31_EC_SYSRAM			MTK_M4U_ID(42, 31)
+
+/* Larb47 -- 32 */
+#define MT8196_SMI_L47_P0_RCPU			        MTK_M4U_ID(47, 0)
+#define MT8196_SMI_L47_P1_REC_FRM			MTK_M4U_ID(47, 1)
+#define MT8196_SMI_L47_P2_BS				MTK_M4U_ID(47, 2)
+#define MT8196_SMI_L47_P3_SVCOMV			MTK_M4U_ID(47, 3)
+#define MT8196_SMI_L47_P4_RDCOMV			MTK_M4U_ID(47, 4)
+#define MT8196_SMI_L47_P5_NBM_R			        MTK_M4U_ID(47, 5)
+#define MT8196_SMI_L47_P6_NBM_R_LITE			MTK_M4U_ID(47, 6)
+#define MT8196_SMI_L47_P7_JPGENC_YRD			MTK_M4U_ID(47, 7)
+#define MT8196_SMI_L47_P8_JPGENC_CRD			MTK_M4U_ID(47, 8)
+#define MT8196_SMI_L47_P9_JPGENC_QT			MTK_M4U_ID(47, 9)
+#define MT8196_SMI_L47_P10_FCS_SUB_W			MTK_M4U_ID(47, 10)
+#define MT8196_SMI_L47_P11_FCS_NBM_R			MTK_M4U_ID(47, 11)
+#define MT8196_SMI_L47_P12_WPP_BS			MTK_M4U_ID(47, 12)
+#define MT8196_SMI_L47_P13_WPP_RDMA			MTK_M4U_ID(47, 13)
+#define MT8196_SMI_L47_P14_DB_SYSRAM_W		        MTK_M4U_ID(47, 14)
+#define MT8196_SMI_L47_P15_DB_SYSRAM_R		        MTK_M4U_ID(47, 15)
+#define MT8196_SMI_L47_P16_JPGENC_BS			MTK_M4U_ID(47, 16)
+#define MT8196_SMI_L47_P17_JPGDEC_W			MTK_M4U_ID(47, 17)
+#define MT8196_SMI_L47_P18_JPGDEC_BS			MTK_M4U_ID(47, 18)
+#define MT8196_SMI_L47_P19_NBM_W			MTK_M4U_ID(47, 19)
+#define MT8196_SMI_L47_P20_NBM_W_LITE			MTK_M4U_ID(47, 20)
+#define MT8196_SMI_L47_P21_CUR_LUMA			MTK_M4U_ID(47, 21)
+#define MT8196_SMI_L47_P22_CUR_CHROMA			MTK_M4U_ID(47, 22)
+#define MT8196_SMI_L47_P23_REF_LUMA			MTK_M4U_ID(47, 23)
+#define MT8196_SMI_L47_P24_REF_CHROMA			MTK_M4U_ID(47, 24)
+#define MT8196_SMI_L47_P25_FCS_SUB_R			MTK_M4U_ID(47, 25)
+#define MT8196_SMI_L47_P26_FCS_NBM_W			MTK_M4U_ID(47, 26)
+#define MT8196_SMI_L47_P27_JPGDEC_W_1			MTK_M4U_ID(47, 27)
+#define MT8196_SMI_L47_P28_JPGDEC_BS_1		        MTK_M4U_ID(47, 28)
+#define MT8196_SMI_L47_P29_JPGDEC_HUF_1		        MTK_M4U_ID(47, 29)
+#define MT8196_SMI_L47_P30_JPGDEC_HUF			MTK_M4U_ID(47, 30)
+#define MT8196_SMI_L47_P31_EC_SYSRAM			MTK_M4U_ID(47, 31)
+
+/* Fake larb48 */
+#define MT8196_SMI_L48_CCU0				MTK_M4U_ID(48, 0)
+#define MT8196_SMI_L48_CCU1				MTK_M4U_ID(48, 1)
+
+/* Fake larb49 */
+#define MT8196_SMI_L49_MMUP				MTK_M4U_ID(49, 0)
+#define MT8196_SMI_L49_GCE_D				MTK_M4U_ID(49, 1)
+#define MT8196_SMI_L49_GCE_M				MTK_M4U_ID(49, 2)
+
+#endif
diff --git a/include/dt-bindings/memory/mtk-memory-port.h b/include/dt-bindings/memory/mtk-memory-port.h
index 2f68a0511a25..fc47fcfc090e 100644
--- a/include/dt-bindings/memory/mtk-memory-port.h
+++ b/include/dt-bindings/memory/mtk-memory-port.h
@@ -6,10 +6,10 @@
 #ifndef __DT_BINDINGS_MEMORY_MTK_MEMORY_PORT_H_
 #define __DT_BINDINGS_MEMORY_MTK_MEMORY_PORT_H_
 
-#define MTK_LARB_NR_MAX			32
+#define MTK_LARB_NR_MAX			64
 
 #define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
-#define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0x1f)
+#define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0x3f)
 #define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
 
 #define MTK_IFAIOMMU_PERI_ID(port)	MTK_M4U_ID(0, port)
-- 
2.46.0

