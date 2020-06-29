Return-Path: <SRS0=qe9F=AK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AF7C433E0
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 07:14:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BD12332F
	for <iommu@archiver.kernel.org>; Mon, 29 Jun 2020 07:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kNsaKUFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BD12332F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 08B2887573;
	Mon, 29 Jun 2020 07:14:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gk5p_4W7bGlm; Mon, 29 Jun 2020 07:14:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1273287567;
	Mon, 29 Jun 2020 07:14:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D140CC07FF;
	Mon, 29 Jun 2020 07:14:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4C82C016E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 07:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D42A888580
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 07:14:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GB9qtHORcEaN for <iommu@lists.linux-foundation.org>;
 Mon, 29 Jun 2020 07:14:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7EC3C88558
 for <iommu@lists.linux-foundation.org>; Mon, 29 Jun 2020 07:14:18 +0000 (UTC)
X-UUID: e2139b9aebc44671998cf4bb9b71ebe5-20200629
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=I9I0seo9ClV08oevWNFaWdbIduuTGtTNq1NN+tWkfYQ=; 
 b=kNsaKUFWDINrXeerwZE88Ehw/H+qnL/ZUvuCEObmNBSRzypvw2PAMx1nP4K/EML3BUb/5fT9OKQYGDe9W9CJQ/aO01xSAMsMxIUIbiIkO5EaGP3R+i+EmS/YYou3u5TkwfRxiZ69DGyJsOAc88G3sQKoQWsWntm2KIN5K1Z8OtY=;
X-UUID: e2139b9aebc44671998cf4bb9b71ebe5-20200629
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by
 mailgw02.mediatek.com (envelope-from <chao.hao@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 966718396; Mon, 29 Jun 2020 15:14:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 29 Jun 2020 15:14:10 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 29 Jun 2020 15:14:09 +0800
From: Chao Hao <chao.hao@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v5 01/10] dt-bindings: mediatek: Add bindings for MT6779
Date: Mon, 29 Jun 2020 15:13:01 +0800
Message-ID: <20200629071310.1557-2-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200629071310.1557-1-chao.hao@mediatek.com>
References: <20200629071310.1557-1-chao.hao@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: devicetree@vger.kernel.org, FY Yang <fy.yang@mediatek.com>,
 wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Chao Hao <chao.hao@mediatek.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
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

This patch adds description for MT6779 IOMMU.

MT6779 has two iommus, they are mm_iommu and apu_iommu which
both use ARM Short-Descriptor translation format.

In addition, mm_iommu and apu_iommu are two independent HW instance
, we need to set them separately.

The MT6779 IOMMU hardware diagram is as below, it is only a brief
diagram about iommu, it don't focus on the part of smi_larb, so
I don't describe the smi_larb detailedly.

			     EMI
			      |
	   --------------------------------------
	   |					|
        MM_IOMMU                            APU_IOMMU
	   |					|
       SMI_COMMOM-----------		     APU_BUS
          |		   |			|
    SMI_LARB(0~11)         |	                |
	  |		   |			|
	  |		   |		   --------------
	  |		   |		   |	 |	|
   Multimedia engine	  CCU		  VPU   MDLA   EMDA

All the connections are hardware fixed, software can not adjust it.

Signed-off-by: Chao Hao <chao.hao@mediatek.com>
Reviewed-by: Rob Herring <robh+dt@kernel.org>
---
 .../bindings/iommu/mediatek,iommu.txt         |   2 +
 include/dt-bindings/memory/mt6779-larb-port.h | 206 ++++++++++++++++++
 2 files changed, 208 insertions(+)
 create mode 100644 include/dt-bindings/memory/mt6779-larb-port.h

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
index ce59a505f5a4..c1ccd8582eb2 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
@@ -58,6 +58,7 @@ Required properties:
 - compatible : must be one of the following string:
 	"mediatek,mt2701-m4u" for mt2701 which uses generation one m4u HW.
 	"mediatek,mt2712-m4u" for mt2712 which uses generation two m4u HW.
+	"mediatek,mt6779-m4u" for mt6779 which uses generation two m4u HW.
 	"mediatek,mt7623-m4u", "mediatek,mt2701-m4u" for mt7623 which uses
 						     generation one m4u HW.
 	"mediatek,mt8173-m4u" for mt8173 which uses generation two m4u HW.
@@ -78,6 +79,7 @@ Required properties:
 	Specifies the mtk_m4u_id as defined in
 	dt-binding/memory/mt2701-larb-port.h for mt2701, mt7623
 	dt-binding/memory/mt2712-larb-port.h for mt2712,
+	dt-binding/memory/mt6779-larb-port.h for mt6779,
 	dt-binding/memory/mt8173-larb-port.h for mt8173, and
 	dt-binding/memory/mt8183-larb-port.h for mt8183.
 
diff --git a/include/dt-bindings/memory/mt6779-larb-port.h b/include/dt-bindings/memory/mt6779-larb-port.h
new file mode 100644
index 000000000000..2ad0899fbf2f
--- /dev/null
+++ b/include/dt-bindings/memory/mt6779-larb-port.h
@@ -0,0 +1,206 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Author: Chao Hao <chao.hao@mediatek.com>
+ */
+
+#ifndef _DTS_IOMMU_PORT_MT6779_H_
+#define _DTS_IOMMU_PORT_MT6779_H_
+
+#define MTK_M4U_ID(larb, port)		 (((larb) << 5) | (port))
+
+#define M4U_LARB0_ID			 0
+#define M4U_LARB1_ID			 1
+#define M4U_LARB2_ID			 2
+#define M4U_LARB3_ID			 3
+#define M4U_LARB4_ID			 4
+#define M4U_LARB5_ID			 5
+#define M4U_LARB6_ID			 6
+#define M4U_LARB7_ID			 7
+#define M4U_LARB8_ID			 8
+#define M4U_LARB9_ID			 9
+#define M4U_LARB10_ID			 10
+#define M4U_LARB11_ID			 11
+
+/* larb0 */
+#define M4U_PORT_DISP_POSTMASK0		 MTK_M4U_ID(M4U_LARB0_ID, 0)
+#define M4U_PORT_DISP_OVL0_HDR		 MTK_M4U_ID(M4U_LARB0_ID, 1)
+#define M4U_PORT_DISP_OVL1_HDR		 MTK_M4U_ID(M4U_LARB0_ID, 2)
+#define M4U_PORT_DISP_OVL0		 MTK_M4U_ID(M4U_LARB0_ID, 3)
+#define M4U_PORT_DISP_OVL1		 MTK_M4U_ID(M4U_LARB0_ID, 4)
+#define M4U_PORT_DISP_PVRIC0		 MTK_M4U_ID(M4U_LARB0_ID, 5)
+#define M4U_PORT_DISP_RDMA0		 MTK_M4U_ID(M4U_LARB0_ID, 6)
+#define M4U_PORT_DISP_WDMA0		 MTK_M4U_ID(M4U_LARB0_ID, 7)
+#define M4U_PORT_DISP_FAKE0		 MTK_M4U_ID(M4U_LARB0_ID, 8)
+
+/* larb1 */
+#define M4U_PORT_DISP_OVL0_2L_HDR	 MTK_M4U_ID(M4U_LARB1_ID, 0)
+#define M4U_PORT_DISP_OVL1_2L_HDR	 MTK_M4U_ID(M4U_LARB1_ID, 1)
+#define M4U_PORT_DISP_OVL0_2L		 MTK_M4U_ID(M4U_LARB1_ID, 2)
+#define M4U_PORT_DISP_OVL1_2L		 MTK_M4U_ID(M4U_LARB1_ID, 3)
+#define M4U_PORT_DISP_RDMA1		 MTK_M4U_ID(M4U_LARB1_ID, 4)
+#define M4U_PORT_MDP_PVRIC0		 MTK_M4U_ID(M4U_LARB1_ID, 5)
+#define M4U_PORT_MDP_PVRIC1		 MTK_M4U_ID(M4U_LARB1_ID, 6)
+#define M4U_PORT_MDP_RDMA0		 MTK_M4U_ID(M4U_LARB1_ID, 7)
+#define M4U_PORT_MDP_RDMA1		 MTK_M4U_ID(M4U_LARB1_ID, 8)
+#define M4U_PORT_MDP_WROT0_R		 MTK_M4U_ID(M4U_LARB1_ID, 9)
+#define M4U_PORT_MDP_WROT0_W		 MTK_M4U_ID(M4U_LARB1_ID, 10)
+#define M4U_PORT_MDP_WROT1_R		 MTK_M4U_ID(M4U_LARB1_ID, 11)
+#define M4U_PORT_MDP_WROT1_W		 MTK_M4U_ID(M4U_LARB1_ID, 12)
+#define M4U_PORT_DISP_FAKE1		 MTK_M4U_ID(M4U_LARB1_ID, 13)
+
+/* larb2-VDEC */
+#define M4U_PORT_HW_VDEC_MC_EXT          MTK_M4U_ID(M4U_LARB2_ID, 0)
+#define M4U_PORT_HW_VDEC_UFO_EXT         MTK_M4U_ID(M4U_LARB2_ID, 1)
+#define M4U_PORT_HW_VDEC_PP_EXT          MTK_M4U_ID(M4U_LARB2_ID, 2)
+#define M4U_PORT_HW_VDEC_PRED_RD_EXT     MTK_M4U_ID(M4U_LARB2_ID, 3)
+#define M4U_PORT_HW_VDEC_PRED_WR_EXT     MTK_M4U_ID(M4U_LARB2_ID, 4)
+#define M4U_PORT_HW_VDEC_PPWRAP_EXT      MTK_M4U_ID(M4U_LARB2_ID, 5)
+#define M4U_PORT_HW_VDEC_TILE_EXT        MTK_M4U_ID(M4U_LARB2_ID, 6)
+#define M4U_PORT_HW_VDEC_VLD_EXT         MTK_M4U_ID(M4U_LARB2_ID, 7)
+#define M4U_PORT_HW_VDEC_VLD2_EXT        MTK_M4U_ID(M4U_LARB2_ID, 8)
+#define M4U_PORT_HW_VDEC_AVC_MV_EXT      MTK_M4U_ID(M4U_LARB2_ID, 9)
+#define M4U_PORT_HW_VDEC_UFO_ENC_EXT     MTK_M4U_ID(M4U_LARB2_ID, 10)
+#define M4U_PORT_HW_VDEC_RG_CTRL_DMA_EXT MTK_M4U_ID(M4U_LARB2_ID, 11)
+
+/* larb3-VENC */
+#define M4U_PORT_VENC_RCPU		 MTK_M4U_ID(M4U_LARB3_ID, 0)
+#define M4U_PORT_VENC_REC		 MTK_M4U_ID(M4U_LARB3_ID, 1)
+#define M4U_PORT_VENC_BSDMA		 MTK_M4U_ID(M4U_LARB3_ID, 2)
+#define M4U_PORT_VENC_SV_COMV		 MTK_M4U_ID(M4U_LARB3_ID, 3)
+#define M4U_PORT_VENC_RD_COMV		 MTK_M4U_ID(M4U_LARB3_ID, 4)
+#define M4U_PORT_VENC_NBM_RDMA		 MTK_M4U_ID(M4U_LARB3_ID, 5)
+#define M4U_PORT_VENC_NBM_RDMA_LITE	 MTK_M4U_ID(M4U_LARB3_ID, 6)
+#define M4U_PORT_JPGENC_Y_RDMA		 MTK_M4U_ID(M4U_LARB3_ID, 7)
+#define M4U_PORT_JPGENC_C_RDMA		 MTK_M4U_ID(M4U_LARB3_ID, 8)
+#define M4U_PORT_JPGENC_Q_TABLE		 MTK_M4U_ID(M4U_LARB3_ID, 9)
+#define M4U_PORT_JPGENC_BSDMA		 MTK_M4U_ID(M4U_LARB3_ID, 10)
+#define M4U_PORT_JPGDEC_WDMA		 MTK_M4U_ID(M4U_LARB3_ID, 11)
+#define M4U_PORT_JPGDEC_BSDMA		 MTK_M4U_ID(M4U_LARB3_ID, 12)
+#define M4U_PORT_VENC_NBM_WDMA		 MTK_M4U_ID(M4U_LARB3_ID, 13)
+#define M4U_PORT_VENC_NBM_WDMA_LITE	 MTK_M4U_ID(M4U_LARB3_ID, 14)
+#define M4U_PORT_VENC_CUR_LUMA		 MTK_M4U_ID(M4U_LARB3_ID, 15)
+#define M4U_PORT_VENC_CUR_CHROMA	 MTK_M4U_ID(M4U_LARB3_ID, 16)
+#define M4U_PORT_VENC_REF_LUMA		 MTK_M4U_ID(M4U_LARB3_ID, 17)
+#define M4U_PORT_VENC_REF_CHROMA	 MTK_M4U_ID(M4U_LARB3_ID, 18)
+
+/* larb4-dummy */
+
+/* larb5-IMG */
+#define M4U_PORT_IMGI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 0)
+#define M4U_PORT_IMGBI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 1)
+#define M4U_PORT_DMGI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 2)
+#define M4U_PORT_DEPI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 3)
+#define M4U_PORT_LCEI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 4)
+#define M4U_PORT_SMTI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 5)
+#define M4U_PORT_SMTO_D2		 MTK_M4U_ID(M4U_LARB5_ID, 6)
+#define M4U_PORT_SMTO_D1		 MTK_M4U_ID(M4U_LARB5_ID, 7)
+#define M4U_PORT_CRZO_D1		 MTK_M4U_ID(M4U_LARB5_ID, 8)
+#define M4U_PORT_IMG3O_D1		 MTK_M4U_ID(M4U_LARB5_ID, 9)
+#define M4U_PORT_VIPI_D1		 MTK_M4U_ID(M4U_LARB5_ID, 10)
+#define M4U_PORT_WPE_RDMA1		 MTK_M4U_ID(M4U_LARB5_ID, 11)
+#define M4U_PORT_WPE_RDMA0		 MTK_M4U_ID(M4U_LARB5_ID, 12)
+#define M4U_PORT_WPE_WDMA		 MTK_M4U_ID(M4U_LARB5_ID, 13)
+#define M4U_PORT_TIMGO_D1		 MTK_M4U_ID(M4U_LARB5_ID, 14)
+#define M4U_PORT_MFB_RDMA0		 MTK_M4U_ID(M4U_LARB5_ID, 15)
+#define M4U_PORT_MFB_RDMA1		 MTK_M4U_ID(M4U_LARB5_ID, 16)
+#define M4U_PORT_MFB_RDMA2		 MTK_M4U_ID(M4U_LARB5_ID, 17)
+#define M4U_PORT_MFB_RDMA3		 MTK_M4U_ID(M4U_LARB5_ID, 18)
+#define M4U_PORT_MFB_WDMA		 MTK_M4U_ID(M4U_LARB5_ID, 19)
+#define M4U_PORT_RESERVE1		 MTK_M4U_ID(M4U_LARB5_ID, 20)
+#define M4U_PORT_RESERVE2		 MTK_M4U_ID(M4U_LARB5_ID, 21)
+#define M4U_PORT_RESERVE3		 MTK_M4U_ID(M4U_LARB5_ID, 22)
+#define M4U_PORT_RESERVE4		 MTK_M4U_ID(M4U_LARB5_ID, 23)
+#define M4U_PORT_RESERVE5		 MTK_M4U_ID(M4U_LARB5_ID, 24)
+#define M4U_PORT_RESERVE6		 MTK_M4U_ID(M4U_LARB5_ID, 25)
+
+/* larb6-IMG-VPU */
+#define M4U_PORT_IMG_IPUO		 MTK_M4U_ID(M4U_LARB6_ID, 0)
+#define M4U_PORT_IMG_IPU3O		 MTK_M4U_ID(M4U_LARB6_ID, 1)
+#define M4U_PORT_IMG_IPUI		 MTK_M4U_ID(M4U_LARB6_ID, 2)
+
+/* larb7-DVS */
+#define M4U_PORT_DVS_RDMA		 MTK_M4U_ID(M4U_LARB7_ID, 0)
+#define M4U_PORT_DVS_WDMA		 MTK_M4U_ID(M4U_LARB7_ID, 1)
+#define M4U_PORT_DVP_RDMA		 MTK_M4U_ID(M4U_LARB7_ID, 2)
+#define M4U_PORT_DVP_WDMA		 MTK_M4U_ID(M4U_LARB7_ID, 3)
+
+/* larb8-IPESYS */
+#define M4U_PORT_FDVT_RDA		 MTK_M4U_ID(M4U_LARB8_ID, 0)
+#define M4U_PORT_FDVT_RDB		 MTK_M4U_ID(M4U_LARB8_ID, 1)
+#define M4U_PORT_FDVT_WRA		 MTK_M4U_ID(M4U_LARB8_ID, 2)
+#define M4U_PORT_FDVT_WRB		 MTK_M4U_ID(M4U_LARB8_ID, 3)
+#define M4U_PORT_FE_RD0			 MTK_M4U_ID(M4U_LARB8_ID, 4)
+#define M4U_PORT_FE_RD1			 MTK_M4U_ID(M4U_LARB8_ID, 5)
+#define M4U_PORT_FE_WR0			 MTK_M4U_ID(M4U_LARB8_ID, 6)
+#define M4U_PORT_FE_WR1			 MTK_M4U_ID(M4U_LARB8_ID, 7)
+#define M4U_PORT_RSC_RDMA0		 MTK_M4U_ID(M4U_LARB8_ID, 8)
+#define M4U_PORT_RSC_WDMA		 MTK_M4U_ID(M4U_LARB8_ID, 9)
+
+/* larb9-CAM */
+#define M4U_PORT_CAM_IMGO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 0)
+#define M4U_PORT_CAM_RRZO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 1)
+#define M4U_PORT_CAM_LSCI_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 2)
+#define M4U_PORT_CAM_BPCI_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 3)
+#define M4U_PORT_CAM_YUVO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 4)
+#define M4U_PORT_CAM_UFDI_R2_C		 MTK_M4U_ID(M4U_LARB9_ID, 5)
+#define M4U_PORT_CAM_RAWI_R2_C		 MTK_M4U_ID(M4U_LARB9_ID, 6)
+#define M4U_PORT_CAM_RAWI_R5_C		 MTK_M4U_ID(M4U_LARB9_ID, 7)
+#define M4U_PORT_CAM_CAMSV_1		 MTK_M4U_ID(M4U_LARB9_ID, 8)
+#define M4U_PORT_CAM_CAMSV_2		 MTK_M4U_ID(M4U_LARB9_ID, 9)
+#define M4U_PORT_CAM_CAMSV_3		 MTK_M4U_ID(M4U_LARB9_ID, 10)
+#define M4U_PORT_CAM_CAMSV_4		 MTK_M4U_ID(M4U_LARB9_ID, 11)
+#define M4U_PORT_CAM_CAMSV_5		 MTK_M4U_ID(M4U_LARB9_ID, 12)
+#define M4U_PORT_CAM_CAMSV_6		 MTK_M4U_ID(M4U_LARB9_ID, 13)
+#define M4U_PORT_CAM_AAO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 14)
+#define M4U_PORT_CAM_AFO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 15)
+#define M4U_PORT_CAM_FLKO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 16)
+#define M4U_PORT_CAM_LCESO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 17)
+#define M4U_PORT_CAM_CRZO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 18)
+#define M4U_PORT_CAM_LTMSO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 19)
+#define M4U_PORT_CAM_RSSO_R1_C		 MTK_M4U_ID(M4U_LARB9_ID, 20)
+#define M4U_PORT_CAM_CCUI		 MTK_M4U_ID(M4U_LARB9_ID, 21)
+#define M4U_PORT_CAM_CCUO		 MTK_M4U_ID(M4U_LARB9_ID, 22)
+#define M4U_PORT_CAM_FAKE		 MTK_M4U_ID(M4U_LARB9_ID, 23)
+
+/* larb10-CAM_A */
+#define M4U_PORT_CAM_IMGO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 0)
+#define M4U_PORT_CAM_RRZO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 1)
+#define M4U_PORT_CAM_LSCI_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 2)
+#define M4U_PORT_CAM_BPCI_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 3)
+#define M4U_PORT_CAM_YUVO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 4)
+#define M4U_PORT_CAM_UFDI_R2_A		 MTK_M4U_ID(M4U_LARB10_ID, 5)
+#define M4U_PORT_CAM_RAWI_R2_A		 MTK_M4U_ID(M4U_LARB10_ID, 6)
+#define M4U_PORT_CAM_RAWI_R5_A		 MTK_M4U_ID(M4U_LARB10_ID, 7)
+#define M4U_PORT_CAM_IMGO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 8)
+#define M4U_PORT_CAM_RRZO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 9)
+#define M4U_PORT_CAM_LSCI_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 10)
+#define M4U_PORT_CAM_BPCI_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 11)
+#define M4U_PORT_CAM_YUVO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 12)
+#define M4U_PORT_CAM_UFDI_R2_B		 MTK_M4U_ID(M4U_LARB10_ID, 13)
+#define M4U_PORT_CAM_RAWI_R2_B		 MTK_M4U_ID(M4U_LARB10_ID, 14)
+#define M4U_PORT_CAM_RAWI_R5_B		 MTK_M4U_ID(M4U_LARB10_ID, 15)
+#define M4U_PORT_CAM_CAMSV_0		 MTK_M4U_ID(M4U_LARB10_ID, 16)
+#define M4U_PORT_CAM_AAO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 17)
+#define M4U_PORT_CAM_AFO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 18)
+#define M4U_PORT_CAM_FLKO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 19)
+#define M4U_PORT_CAM_LCESO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 20)
+#define M4U_PORT_CAM_CRZO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 21)
+#define M4U_PORT_CAM_AAO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 22)
+#define M4U_PORT_CAM_AFO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 23)
+#define M4U_PORT_CAM_FLKO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 24)
+#define M4U_PORT_CAM_LCESO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 25)
+#define M4U_PORT_CAM_CRZO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 26)
+#define M4U_PORT_CAM_LTMSO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 27)
+#define M4U_PORT_CAM_RSSO_R1_A		 MTK_M4U_ID(M4U_LARB10_ID, 28)
+#define M4U_PORT_CAM_LTMSO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 29)
+#define M4U_PORT_CAM_RSSO_R1_B		 MTK_M4U_ID(M4U_LARB10_ID, 30)
+
+/* larb11-CAM-VPU */
+#define M4U_PORT_CAM_IPUO		 MTK_M4U_ID(M4U_LARB11_ID, 0)
+#define M4U_PORT_CAM_IPU2O		 MTK_M4U_ID(M4U_LARB11_ID, 1)
+#define M4U_PORT_CAM_IPU3O		 MTK_M4U_ID(M4U_LARB11_ID, 2)
+#define M4U_PORT_CAM_IPUI		 MTK_M4U_ID(M4U_LARB11_ID, 3)
+#define M4U_PORT_CAM_IPU2I		 MTK_M4U_ID(M4U_LARB11_ID, 4)
+
+#endif
-- 
2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
