Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA51CC43219
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 10:19:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8846340003;
	Wed, 18 May 2022 10:19:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DP8T72s-PydR; Wed, 18 May 2022 10:19:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3CC11401B3;
	Wed, 18 May 2022 10:19:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18A07C0032;
	Wed, 18 May 2022 10:19:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DA05C002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 10:19:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F30B34012E
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 10:19:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9h4Yxy2yYYkc for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 10:19:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 390A340003
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 10:19:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id B00CE1F44784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652869136;
 bh=ALd+Ex8c5vy9SeM3mRTTqPW6CjY8e4+l7fcCxHrg/jo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MZrUvhYGdr4u6aS2GijsHpgrVN6tt6HSocophBnE/rpCDYGqlSuCeTX6ALMiiqroU
 +149JmNkTtBH2K9VUvA0xOpMShwsMALIDY/ftEy0kTpgnl86/StQwRBkcpfLhd7wWo
 2jnErje6YqK5GmV/n8s+alxjsxcGF68/WdxahayhSrhPcYHuOdtH9+/S5cBXAMWNGP
 By2XxWMGmnT5NKyzBDFFto+tHNKT2h+R0ap/hBET/k6fWfKOWnOfRArByKuhg5S1Ac
 4MxB5ebr2YxVhFuCgJ6p5pnZsMG2N81Lcr34VqZM4TQRludCMHvY2y9l4VXRPNCFX1
 3S5x3e4HMFEZg==
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: yong.wu@mediatek.com
Subject: [PATCH v2 1/2] dt-bindings: mediatek: Add bindings for MT6795 M4U
Date: Wed, 18 May 2022 12:18:48 +0200
Message-Id: <20220518101849.46804-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518101849.46804-1-angelogioacchino.delregno@collabora.com>
References: <20220518101849.46804-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, martin.botka@somainline.org,
 paul.bouchara@somainline.org, konrad.dybcio@somainline.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 ~postmarketos/upstreaming@lists.sr.ht, krzysztof.kozlowski+dt@linaro.org,
 matthias.bgg@gmail.com, marijn.suijten@somainline.org,
 phone-devel@vger.kernel.org, will@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Add bindings for the MediaTek Helio X10 (MT6795) IOMMU/M4U.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/iommu/mediatek,iommu.yaml        |  4 +
 include/dt-bindings/memory/mt6795-larb-port.h | 96 +++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 include/dt-bindings/memory/mt6795-larb-port.h

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index d5e3272a54e8..20902c387520 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -73,6 +73,7 @@ properties:
           - mediatek,mt2701-m4u  # generation one
           - mediatek,mt2712-m4u  # generation two
           - mediatek,mt6779-m4u  # generation two
+          - mediatek,mt6795-m4u  # generation two
           - mediatek,mt8167-m4u  # generation two
           - mediatek,mt8173-m4u  # generation two
           - mediatek,mt8183-m4u  # generation two
@@ -128,6 +129,7 @@ properties:
       dt-binding/memory/mt2701-larb-port.h for mt2701 and mt7623,
       dt-binding/memory/mt2712-larb-port.h for mt2712,
       dt-binding/memory/mt6779-larb-port.h for mt6779,
+      dt-binding/memory/mt6795-larb-port.h for mt6795,
       dt-binding/memory/mt8167-larb-port.h for mt8167,
       dt-binding/memory/mt8173-larb-port.h for mt8173,
       dt-binding/memory/mt8183-larb-port.h for mt8183,
@@ -152,6 +154,7 @@ allOf:
             enum:
               - mediatek,mt2701-m4u
               - mediatek,mt2712-m4u
+              - mediatek,mt6795-m4u
               - mediatek,mt8173-m4u
               - mediatek,mt8186-iommu-mm
               - mediatek,mt8192-m4u
@@ -181,6 +184,7 @@ allOf:
           contains:
             enum:
               - mediatek,mt2712-m4u
+              - mediatek,mt6795-m4u
               - mediatek,mt8173-m4u
 
     then:
diff --git a/include/dt-bindings/memory/mt6795-larb-port.h b/include/dt-bindings/memory/mt6795-larb-port.h
new file mode 100644
index 000000000000..2243bb6414f3
--- /dev/null
+++ b/include/dt-bindings/memory/mt6795-larb-port.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022 Collabora Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef _DT_BINDINGS_MEMORY_MT6795_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT6795_LARB_PORT_H_
+
+#include <dt-bindings/memory/mtk-memory-port.h>
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
+#define M4U_PORT_DISP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 2)
+#define M4U_PORT_DISP_WDMA0		MTK_M4U_ID(M4U_LARB0_ID, 3)
+#define M4U_PORT_DISP_OVL1		MTK_M4U_ID(M4U_LARB0_ID, 4)
+#define M4U_PORT_DISP_RDMA2		MTK_M4U_ID(M4U_LARB0_ID, 5)
+#define M4U_PORT_DISP_WDMA1		MTK_M4U_ID(M4U_LARB0_ID, 6)
+#define M4U_PORT_DISP_OD_R		MTK_M4U_ID(M4U_LARB0_ID, 7)
+#define M4U_PORT_DISP_OD_W		MTK_M4U_ID(M4U_LARB0_ID, 8)
+#define M4U_PORT_MDP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 9)
+#define M4U_PORT_MDP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 10)
+#define M4U_PORT_MDP_WDMA		MTK_M4U_ID(M4U_LARB0_ID, 11)
+#define M4U_PORT_MDP_WROT0		MTK_M4U_ID(M4U_LARB0_ID, 12)
+#define M4U_PORT_MDP_WROT1		MTK_M4U_ID(M4U_LARB0_ID, 13)
+
+/* larb1 */
+#define M4U_PORT_VDEC_MC		MTK_M4U_ID(M4U_LARB1_ID, 0)
+#define M4U_PORT_VDEC_PP		MTK_M4U_ID(M4U_LARB1_ID, 1)
+#define M4U_PORT_VDEC_UFO		MTK_M4U_ID(M4U_LARB1_ID, 2)
+#define M4U_PORT_VDEC_VLD		MTK_M4U_ID(M4U_LARB1_ID, 3)
+#define M4U_PORT_VDEC_VLD2		MTK_M4U_ID(M4U_LARB1_ID, 4)
+#define M4U_PORT_VDEC_AVC_MV		MTK_M4U_ID(M4U_LARB1_ID, 5)
+#define M4U_PORT_VDEC_PRED_RD		MTK_M4U_ID(M4U_LARB1_ID, 6)
+#define M4U_PORT_VDEC_PRED_WR		MTK_M4U_ID(M4U_LARB1_ID, 7)
+#define M4U_PORT_VDEC_PPWRAP		MTK_M4U_ID(M4U_LARB1_ID, 8)
+
+/* larb2 */
+#define M4U_PORT_CAM_IMGO		MTK_M4U_ID(M4U_LARB2_ID, 0)
+#define M4U_PORT_CAM_RRZO		MTK_M4U_ID(M4U_LARB2_ID, 1)
+#define M4U_PORT_CAM_AAO		MTK_M4U_ID(M4U_LARB2_ID, 2)
+#define M4U_PORT_CAM_LCSO		MTK_M4U_ID(M4U_LARB2_ID, 3)
+#define M4U_PORT_CAM_ESFKO		MTK_M4U_ID(M4U_LARB2_ID, 4)
+#define M4U_PORT_CAM_IMGO_S		MTK_M4U_ID(M4U_LARB2_ID, 5)
+#define M4U_PORT_CAM_LSCI		MTK_M4U_ID(M4U_LARB2_ID, 6)
+#define M4U_PORT_CAM_LSCI_D		MTK_M4U_ID(M4U_LARB2_ID, 7)
+#define M4U_PORT_CAM_BPCI		MTK_M4U_ID(M4U_LARB2_ID, 8)
+#define M4U_PORT_CAM_BPCI_D		MTK_M4U_ID(M4U_LARB2_ID, 9)
+#define M4U_PORT_CAM_UFDI		MTK_M4U_ID(M4U_LARB2_ID, 10)
+#define M4U_PORT_CAM_IMGI		MTK_M4U_ID(M4U_LARB2_ID, 11)
+#define M4U_PORT_CAM_IMG2O		MTK_M4U_ID(M4U_LARB2_ID, 12)
+#define M4U_PORT_CAM_IMG3O		MTK_M4U_ID(M4U_LARB2_ID, 13)
+#define M4U_PORT_CAM_VIPI		MTK_M4U_ID(M4U_LARB2_ID, 14)
+#define M4U_PORT_CAM_VIP2I		MTK_M4U_ID(M4U_LARB2_ID, 15)
+#define M4U_PORT_CAM_VIP3I		MTK_M4U_ID(M4U_LARB2_ID, 16)
+#define M4U_PORT_CAM_LCEI		MTK_M4U_ID(M4U_LARB2_ID, 17)
+#define M4U_PORT_CAM_RB			MTK_M4U_ID(M4U_LARB2_ID, 18)
+#define M4U_PORT_CAM_RP			MTK_M4U_ID(M4U_LARB2_ID, 19)
+#define M4U_PORT_CAM_WR			MTK_M4U_ID(M4U_LARB2_ID, 20)
+
+/* larb3 */
+#define M4U_PORT_VENC_RCPU		MTK_M4U_ID(M4U_LARB3_ID, 0)
+#define M4U_PORT_VENC_REC		MTK_M4U_ID(M4U_LARB3_ID, 1)
+#define M4U_PORT_VENC_BSDMA		MTK_M4U_ID(M4U_LARB3_ID, 2)
+#define M4U_PORT_VENC_SV_COMV		MTK_M4U_ID(M4U_LARB3_ID, 3)
+#define M4U_PORT_VENC_RD_COMV		MTK_M4U_ID(M4U_LARB3_ID, 4)
+#define M4U_PORT_JPGENC_BSDMA		MTK_M4U_ID(M4U_LARB3_ID, 5)
+#define M4U_PORT_REMDC_SDMA		MTK_M4U_ID(M4U_LARB3_ID, 6)
+#define M4U_PORT_REMDC_BSDMA		MTK_M4U_ID(M4U_LARB3_ID, 7)
+#define M4U_PORT_JPGENC_RDMA		MTK_M4U_ID(M4U_LARB3_ID, 8)
+#define M4U_PORT_JPGENC_SDMA		MTK_M4U_ID(M4U_LARB3_ID, 9)
+#define M4U_PORT_JPGDEC_WDMA		MTK_M4U_ID(M4U_LARB3_ID, 10)
+#define M4U_PORT_JPGDEC_BSDMA		MTK_M4U_ID(M4U_LARB3_ID, 11)
+#define M4U_PORT_VENC_CUR_LUMA		MTK_M4U_ID(M4U_LARB3_ID, 12)
+#define M4U_PORT_VENC_CUR_CHROMA	MTK_M4U_ID(M4U_LARB3_ID, 13)
+#define M4U_PORT_VENC_REF_LUMA		MTK_M4U_ID(M4U_LARB3_ID, 14)
+#define M4U_PORT_VENC_REF_CHROMA	MTK_M4U_ID(M4U_LARB3_ID, 15)
+#define M4U_PORT_REMDC_WDMA		MTK_M4U_ID(M4U_LARB3_ID, 16)
+#define M4U_PORT_VENC_NBM_RDMA		MTK_M4U_ID(M4U_LARB3_ID, 17)
+#define M4U_PORT_VENC_NBM_WDMA		MTK_M4U_ID(M4U_LARB3_ID, 18)
+
+/* larb4 */
+#define M4U_PORT_MJC_MV_RD		MTK_M4U_ID(M4U_LARB4_ID, 0)
+#define M4U_PORT_MJC_MV_WR		MTK_M4U_ID(M4U_LARB4_ID, 1)
+#define M4U_PORT_MJC_DMA_RD		MTK_M4U_ID(M4U_LARB4_ID, 2)
+#define M4U_PORT_MJC_DMA_WR		MTK_M4U_ID(M4U_LARB4_ID, 3)
+
+#endif
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
