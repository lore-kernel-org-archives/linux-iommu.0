Return-Path: <SRS0=PEfB=AW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595E0C433E4
	for <iommu@archiver.kernel.org>; Sat, 11 Jul 2020 06:50:51 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ED9520725
	for <iommu@archiver.kernel.org>; Sat, 11 Jul 2020 06:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FGKUaNfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED9520725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1973B88367;
	Sat, 11 Jul 2020 06:50:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nxv3RhMOkLxv; Sat, 11 Jul 2020 06:50:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3FAF288BC8;
	Sat, 11 Jul 2020 06:50:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 222F2C08A5;
	Sat, 11 Jul 2020 06:50:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 480D8C088E
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 06:50:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6D4E488406
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 06:50:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id C-bNyR86hmvV for <iommu@lists.linux-foundation.org>;
 Sat, 11 Jul 2020 06:50:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by whitealder.osuosl.org (Postfix) with ESMTP id C49AF887D9
 for <iommu@lists.linux-foundation.org>; Sat, 11 Jul 2020 06:50:24 +0000 (UTC)
X-UUID: 7a1b844b3f6643fb8fb197707b745c10-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=fiDQHBU5nIBkpUa50jKoZWUs4WGEo9NYLxOR1V7+NMU=; 
 b=FGKUaNfUzL0jTHu8Kem4YfXbimrTlof5LitlBQrXSfkJjHA2CmPNBGjrxE6OGhIOAVoB1jPgQ1auwHzY1nKVUB+SdYtRz/iz4WyUImWD8HvSTcgevZpqR7CiDlBw3KOIVlaiwa35EdkqlvtdIO7QXLH0MIp1/3GMjI1/0+CVicc=;
X-UUID: 7a1b844b3f6643fb8fb197707b745c10-20200711
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
 with ESMTP id 175413566; Sat, 11 Jul 2020 14:50:22 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:50:18 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:50:17 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 04/21] dt-binding: mediatek: Add binding for mt8192 IOMMU and
 SMI
Date: Sat, 11 Jul 2020 14:48:29 +0800
Message-ID: <20200711064846.16007-5-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 863514BC022277D3E11B5DB7473085309A608F8775DEB0365CC6D72CC10424512000:8
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, cui.zhang@mediatek.com,
 srv_heupstream@mediatek.com, chao.hao@mediatek.com,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, ming-fan.chen@mediatek.com,
 anan.sun@mediatek.com, Will Deacon <will@kernel.org>,
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

This patch adds decriptions for mt8192 IOMMU and SMI.

mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
table format. The M4U-SMI HW diagram is as below:

                          EMI
                           |
                          M4U
                           |
                      ------------
                       SMI Common
                      ------------
                           |
  +-------+------+------+----------------------+-------+
  |       |      |      |       ......         |       |
  |       |      |      |                      |       |
larb0   larb1  larb2  larb4     ......      larb19   larb20
disp0   disp1   mdp    vdec                   IPE      IPE

All the connections are HW fixed, SW can NOT adjust it.

mt8192 M4U support 0~16GB iova range. we preassign different engines
into different iova ranges:

domain-id  module     iova-range                  larbs
   0       disp        0 ~ 4G                      larb0/1
   1       vcodec      4G ~ 8G                     larb4/5/7
   2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
   3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
   4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5

The iova range for CCU0/1(camera control unit) is HW requirement.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 .../bindings/iommu/mediatek,iommu.txt         |   8 +-
 .../mediatek,smi-common.txt                   |   5 +-
 .../memory-controllers/mediatek,smi-larb.txt  |   3 +-
 include/dt-bindings/memory/mt8192-larb-port.h | 237 ++++++++++++++++++
 4 files changed, 247 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
index c1ccd8582eb2..76ee64b593ef 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
@@ -63,13 +63,14 @@ Required properties:
 						     generation one m4u HW.
 	"mediatek,mt8173-m4u" for mt8173 which uses generation two m4u HW.
 	"mediatek,mt8183-m4u" for mt8183 which uses generation two m4u HW.
+	"mediatek,mt8192-m4u" for mt8192 which uses generation two m4u HW.
 - reg : m4u register base and size.
 - interrupts : the interrupt of m4u.
 - clocks : must contain one entry for each clock-names.
 - clock-names : Only 1 optional clock:
   - "bclk": the block clock of m4u.
   Here is the list which require this "bclk":
-  - mt2701, mt2712, mt7623 and mt8173.
+  - mt2701, mt2712, mt7623, mt8173 and mt8192.
   Note that m4u use the EMI clock which always has been enabled before kernel
   if there is no this "bclk".
 - mediatek,larbs : List of phandle to the local arbiters in the current Socs.
@@ -80,8 +81,9 @@ Required properties:
 	dt-binding/memory/mt2701-larb-port.h for mt2701, mt7623
 	dt-binding/memory/mt2712-larb-port.h for mt2712,
 	dt-binding/memory/mt6779-larb-port.h for mt6779,
-	dt-binding/memory/mt8173-larb-port.h for mt8173, and
-	dt-binding/memory/mt8183-larb-port.h for mt8183.
+	dt-binding/memory/mt8173-larb-port.h for mt8173,
+	dt-binding/memory/mt8183-larb-port.h for mt8183, and
+	dt-binding/memory/mt8192-larb-port.h for mt8192.
 
 Example:
 	iommu: iommu@10205000 {
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
index 01744ec6a75b..7c79fa488378 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
@@ -5,7 +5,7 @@ The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
 Mediatek SMI have two generations of HW architecture, here is the list
 which generation the SoCs use:
 generation 1: mt2701 and mt7623.
-generation 2: mt2712, mt8173 and mt8183.
+generation 2: mt2712, mt8173, mt8183 and mt8192.
 
 There's slight differences between the two SMI, for generation 2, the
 register which control the iommu port is at each larb's register base. But
@@ -21,6 +21,7 @@ Required properties:
 	"mediatek,mt7623-smi-common", "mediatek,mt2701-smi-common"
 	"mediatek,mt8173-smi-common"
 	"mediatek,mt8183-smi-common", "syscon"
+	"mediatek,mt8192-smi-common"
 - reg : the register and size of the SMI block.
 - power-domains : a phandle to the power domain of this local arbiter.
 - clocks : Must contain an entry for each entry in clock-names.
@@ -35,7 +36,7 @@ Required properties:
   and these 2 option clocks for generation 2 smi HW:
   - "gals0": the path0 clock of GALS(Global Async Local Sync).
   - "gals1": the path1 clock of GALS(Global Async Local Sync).
-  Here is the list which has this GALS: mt8183.
+  Here is the list which has this GALS: mt8183, mt8192.
 
 Example:
 	smi_common: smi@14022000 {
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
index 4b369b3e1a69..d9adae4cd9e3 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
@@ -9,6 +9,7 @@ Required properties:
 		"mediatek,mt7623-smi-larb", "mediatek,mt2701-smi-larb"
 		"mediatek,mt8173-smi-larb"
 		"mediatek,mt8183-smi-larb"
+		"mediatek,mt8192-smi-larb"
 - reg : the register and size of this local arbiter.
 - mediatek,smi : a phandle to the smi_common node.
 - power-domains : a phandle to the power domain of this local arbiter.
@@ -21,7 +22,7 @@ Required properties:
   - "gals": the clock for GALS(Global Async Local Sync).
   Here is the list which has this GALS: mt8183.
 
-Required property for mt2701, mt2712 and mt7623:
+Required property for mt2701, mt2712, mt7623 and mt8192:
 - mediatek,larb-id :the hardware id of this larb.
 
 Example:
diff --git a/include/dt-bindings/memory/mt8192-larb-port.h b/include/dt-bindings/memory/mt8192-larb-port.h
new file mode 100644
index 000000000000..fbe0d5d50f1c
--- /dev/null
+++ b/include/dt-bindings/memory/mt8192-larb-port.h
@@ -0,0 +1,237 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Author: Chao Hao <chao.hao@mediatek.com>
+ * Author: Yong Wu <yong.wu@mediatek.com>
+ */
+#ifndef _DTS_IOMMU_PORT_MT8192_H_
+#define _DTS_IOMMU_PORT_MT8192_H_
+
+#include <dt-bindings/memory/mtk-smi-larb-port.h>
+
+/*
+ * MM IOMMU:
+ * domain 0: display: larb0, larb1.
+ * domain 1: vcodec: larb4, larb5, larb7.
+ * domain 2: CAM/MDP: larb2, larb9, larb11, larb13, larb14, larb16,
+ *           larb17, larb18, larb19, larb20,
+ * domain 3: CCU0: larb13 - port9/10.
+ * domain 4: CCU1: larb14 - port4/5.
+ *
+ * larb3/6/8/10/12/15 is null.
+ */
+
+/* larb0 */
+#define M4U_PORT_L0_DISP_POSTMASK0		MTK_M4U_DOM_ID(0, 0, 0)
+#define M4U_PORT_L0_OVL_RDMA0_HDR		MTK_M4U_DOM_ID(0, 0, 1)
+#define M4U_PORT_L0_OVL_RDMA0			MTK_M4U_DOM_ID(0, 0, 2)
+#define M4U_PORT_L0_DISP_RDMA0			MTK_M4U_DOM_ID(0, 0, 3)
+#define M4U_PORT_L0_DISP_WDMA0			MTK_M4U_DOM_ID(0, 0, 4)
+#define M4U_PORT_L0_DISP_FAKE0			MTK_M4U_DOM_ID(0, 0, 5)
+
+/* larb1 */
+#define M4U_PORT_L1_OVL_2L_RDMA0_HDR		MTK_M4U_DOM_ID(0, 1, 0)
+#define M4U_PORT_L1_OVL_2L_RDMA2_HDR		MTK_M4U_DOM_ID(0, 1, 1)
+#define M4U_PORT_L1_OVL_2L_RDMA0		MTK_M4U_DOM_ID(0, 1, 2)
+#define M4U_PORT_L1_OVL_2L_RDMA2		MTK_M4U_DOM_ID(0, 1, 3)
+#define M4U_PORT_L1_DISP_MDP_RDMA4		MTK_M4U_DOM_ID(0, 1, 4)
+#define M4U_PORT_L1_DISP_RDMA4			MTK_M4U_DOM_ID(0, 1, 5)
+#define M4U_PORT_L1_DISP_UFBC_WDMA0		MTK_M4U_DOM_ID(0, 1, 6)
+#define M4U_PORT_L1_DISP_FAKE1			MTK_M4U_DOM_ID(0, 1, 7)
+
+/* larb2 */
+#define M4U_PORT_L2_MDP_RDMA0			MTK_M4U_DOM_ID(2, 2, 0)
+#define M4U_PORT_L2_MDP_RDMA1			MTK_M4U_DOM_ID(2, 2, 1)
+#define M4U_PORT_L2_MDP_WROT0			MTK_M4U_DOM_ID(2, 2, 2)
+#define M4U_PORT_L2_MDP_WROT1			MTK_M4U_DOM_ID(2, 2, 3)
+#define M4U_PORT_L2_MDP_DISP_FAKE0		MTK_M4U_DOM_ID(2, 2, 4)
+
+/* larb3: null */
+
+/* larb4 */
+#define M4U_PORT_L4_VDEC_MC_EXT			MTK_M4U_DOM_ID(1, 4, 0)
+#define M4U_PORT_L4_VDEC_UFO_EXT		MTK_M4U_DOM_ID(1, 4, 1)
+#define M4U_PORT_L4_VDEC_PP_EXT			MTK_M4U_DOM_ID(1, 4, 2)
+#define M4U_PORT_L4_VDEC_PRED_RD_EXT		MTK_M4U_DOM_ID(1, 4, 3)
+#define M4U_PORT_L4_VDEC_PRED_WR_EXT		MTK_M4U_DOM_ID(1, 4, 4)
+#define M4U_PORT_L4_VDEC_PPWRAP_EXT		MTK_M4U_DOM_ID(1, 4, 5)
+#define M4U_PORT_L4_VDEC_TILE_EXT		MTK_M4U_DOM_ID(1, 4, 6)
+#define M4U_PORT_L4_VDEC_VLD_EXT		MTK_M4U_DOM_ID(1, 4, 7)
+#define M4U_PORT_L4_VDEC_VLD2_EXT		MTK_M4U_DOM_ID(1, 4, 8)
+#define M4U_PORT_L4_VDEC_AVC_MV_EXT		MTK_M4U_DOM_ID(1, 4, 9)
+#define M4U_PORT_L4_VDEC_RG_CTRL_DMA_EXT	MTK_M4U_DOM_ID(1, 4, 10)
+
+/* larb5 */
+#define M4U_PORT_L5_VDEC_LAT0_VLD_EXT		MTK_M4U_DOM_ID(1, 5, 0)
+#define M4U_PORT_L5_VDEC_LAT0_VLD2_EXT		MTK_M4U_DOM_ID(1, 5, 1)
+#define M4U_PORT_L5_VDEC_LAT0_AVC_MV_EXT	MTK_M4U_DOM_ID(1, 5, 2)
+#define M4U_PORT_L5_VDEC_LAT0_PRED_RD_EXT	MTK_M4U_DOM_ID(1, 5, 3)
+#define M4U_PORT_L5_VDEC_LAT0_TILE_EXT		MTK_M4U_DOM_ID(1, 5, 4)
+#define M4U_PORT_L5_VDEC_LAT0_WDMA_EXT		MTK_M4U_DOM_ID(1, 5, 5)
+#define M4U_PORT_L5_VDEC_LAT0_RG_CTRL_DMA_EXT	MTK_M4U_DOM_ID(1, 5, 6)
+#define M4U_PORT_L5_VDEC_UFO_ENC_EXT		MTK_M4U_DOM_ID(1, 5, 7)
+
+/* larb6: null */
+
+/* larb7 */
+#define M4U_PORT_L7_VENC_RCPU			MTK_M4U_DOM_ID(1, 7, 0)
+#define M4U_PORT_L7_VENC_REC			MTK_M4U_DOM_ID(1, 7, 1)
+#define M4U_PORT_L7_VENC_BSDMA			MTK_M4U_DOM_ID(1, 7, 2)
+#define M4U_PORT_L7_VENC_SV_COMV		MTK_M4U_DOM_ID(1, 7, 3)
+#define M4U_PORT_L7_VENC_RD_COMV		MTK_M4U_DOM_ID(1, 7, 4)
+#define M4U_PORT_L7_VENC_CUR_LUMA		MTK_M4U_DOM_ID(1, 7, 5)
+#define M4U_PORT_L7_VENC_CUR_CHROMA		MTK_M4U_DOM_ID(1, 7, 6)
+#define M4U_PORT_L7_VENC_REF_LUMA		MTK_M4U_DOM_ID(1, 7, 7)
+#define M4U_PORT_L7_VENC_REF_CHROMA		MTK_M4U_DOM_ID(1, 7, 8)
+#define M4U_PORT_L7_JPGENC_Y_RDMA		MTK_M4U_DOM_ID(1, 7, 9)
+#define M4U_PORT_L7_JPGENC_Q_RDMA		MTK_M4U_DOM_ID(1, 7, 10)
+#define M4U_PORT_L7_JPGENC_C_TABLE		MTK_M4U_DOM_ID(1, 7, 11)
+#define M4U_PORT_L7_JPGENC_BSDMA		MTK_M4U_DOM_ID(1, 7, 12)
+#define M4U_PORT_L7_VENC_SUB_R_LUMA		MTK_M4U_DOM_ID(1, 7, 13)
+#define M4U_PORT_L7_VENC_SUB_W_LUMA		MTK_M4U_DOM_ID(1, 7, 14)
+
+/* larb9 */
+#define M4U_PORT_L9_IMG_IMGI_D1			MTK_M4U_DOM_ID(2, 9, 0)
+#define M4U_PORT_L9_IMG_IMGBI_D1		MTK_M4U_DOM_ID(2, 9, 1)
+#define M4U_PORT_L9_IMG_DMGI_D1			MTK_M4U_DOM_ID(2, 9, 2)
+#define M4U_PORT_L9_IMG_DEPI_D1			MTK_M4U_DOM_ID(2, 9, 3)
+#define M4U_PORT_L9_IMG_ICE_D1			MTK_M4U_DOM_ID(2, 9, 4)
+#define M4U_PORT_L9_IMG_SMTI_D1			MTK_M4U_DOM_ID(2, 9, 5)
+#define M4U_PORT_L9_IMG_SMTO_D2			MTK_M4U_DOM_ID(2, 9, 6)
+#define M4U_PORT_L9_IMG_SMTO_D1			MTK_M4U_DOM_ID(2, 9, 7)
+#define M4U_PORT_L9_IMG_CRZO_D1			MTK_M4U_DOM_ID(2, 9, 8)
+#define M4U_PORT_L9_IMG_IMG3O_D1		MTK_M4U_DOM_ID(2, 9, 9)
+#define M4U_PORT_L9_IMG_VIPI_D1			MTK_M4U_DOM_ID(2, 9, 10)
+#define M4U_PORT_L9_IMG_SMTI_D5			MTK_M4U_DOM_ID(2, 9, 11)
+#define M4U_PORT_L9_IMG_TIMGO_D1		MTK_M4U_DOM_ID(2, 9, 12)
+#define M4U_PORT_L9_IMG_UFBC_W0			MTK_M4U_DOM_ID(2, 9, 13)
+#define M4U_PORT_L9_IMG_UFBC_R0			MTK_M4U_DOM_ID(2, 9, 14)
+
+/* larb10: null */
+
+/* larb11 */
+#define M4U_PORT_L11_IMG_IMGI_D1		MTK_M4U_DOM_ID(2, 11, 0)
+#define M4U_PORT_L11_IMG_IMGBI_D1		MTK_M4U_DOM_ID(2, 11, 1)
+#define M4U_PORT_L11_IMG_DMGI_D1		MTK_M4U_DOM_ID(2, 11, 2)
+#define M4U_PORT_L11_IMG_DEPI_D1		MTK_M4U_DOM_ID(2, 11, 3)
+#define M4U_PORT_L11_IMG_ICE_D1			MTK_M4U_DOM_ID(2, 11, 4)
+#define M4U_PORT_L11_IMG_SMTI_D1		MTK_M4U_DOM_ID(2, 11, 5)
+#define M4U_PORT_L11_IMG_SMTO_D2		MTK_M4U_DOM_ID(2, 11, 6)
+#define M4U_PORT_L11_IMG_SMTO_D1		MTK_M4U_DOM_ID(2, 11, 7)
+#define M4U_PORT_L11_IMG_CRZO_D1		MTK_M4U_DOM_ID(2, 11, 8)
+#define M4U_PORT_L11_IMG_IMG3O_D1		MTK_M4U_DOM_ID(2, 11, 9)
+#define M4U_PORT_L11_IMG_VIPI_D1		MTK_M4U_DOM_ID(2, 11, 10)
+#define M4U_PORT_L11_IMG_SMTI_D5		MTK_M4U_DOM_ID(2, 11, 11)
+#define M4U_PORT_L11_IMG_TIMGO_D1		MTK_M4U_DOM_ID(2, 11, 12)
+#define M4U_PORT_L11_IMG_UFBC_W0		MTK_M4U_DOM_ID(2, 11, 13)
+#define M4U_PORT_L11_IMG_UFBC_R0		MTK_M4U_DOM_ID(2, 11, 14)
+#define M4U_PORT_L11_IMG_WPE_RDMA1		MTK_M4U_DOM_ID(2, 11, 15)
+#define M4U_PORT_L11_IMG_WPE_RDMA0		MTK_M4U_DOM_ID(2, 11, 16)
+#define M4U_PORT_L11_IMG_WPE_WDMA		MTK_M4U_DOM_ID(2, 11, 17)
+#define M4U_PORT_L11_IMG_MFB_RDMA0		MTK_M4U_DOM_ID(2, 11, 18)
+#define M4U_PORT_L11_IMG_MFB_RDMA1		MTK_M4U_DOM_ID(2, 11, 19)
+#define M4U_PORT_L11_IMG_MFB_RDMA2		MTK_M4U_DOM_ID(2, 11, 20)
+#define M4U_PORT_L11_IMG_MFB_RDMA3		MTK_M4U_DOM_ID(2, 11, 21)
+#define M4U_PORT_L11_IMG_MFB_RDMA4		MTK_M4U_DOM_ID(2, 11, 22)
+#define M4U_PORT_L11_IMG_MFB_RDMA5		MTK_M4U_DOM_ID(2, 11, 23)
+#define M4U_PORT_L11_IMG_MFB_WDMA0		MTK_M4U_DOM_ID(2, 11, 24)
+#define M4U_PORT_L11_IMG_MFB_WDMA1		MTK_M4U_DOM_ID(2, 11, 25)
+
+/* larb12: null */
+
+/* larb13 */
+#define M4U_PORT_L13_CAM_MRAWI			MTK_M4U_DOM_ID(2, 13, 0)
+#define M4U_PORT_L13_CAM_MRAWO0			MTK_M4U_DOM_ID(2, 13, 1)
+#define M4U_PORT_L13_CAM_MRAWO1			MTK_M4U_DOM_ID(2, 13, 2)
+#define M4U_PORT_L13_CAM_CAMSV1			MTK_M4U_DOM_ID(2, 13, 3)
+#define M4U_PORT_L13_CAM_CAMSV2			MTK_M4U_DOM_ID(2, 13, 4)
+#define M4U_PORT_L13_CAM_CAMSV3			MTK_M4U_DOM_ID(2, 13, 5)
+#define M4U_PORT_L13_CAM_CAMSV4			MTK_M4U_DOM_ID(2, 13, 6)
+#define M4U_PORT_L13_CAM_CAMSV5			MTK_M4U_DOM_ID(2, 13, 7)
+#define M4U_PORT_L13_CAM_CAMSV6			MTK_M4U_DOM_ID(2, 13, 8)
+#define M4U_PORT_L13_CAM_CCUI			MTK_M4U_DOM_ID(3, 13, 9)
+#define M4U_PORT_L13_CAM_CCUO			MTK_M4U_DOM_ID(3, 13, 10)
+#define M4U_PORT_L13_CAM_FAKE			MTK_M4U_DOM_ID(2, 13, 11)
+
+/* larb14 */
+#define M4U_PORT_L14_CAM_RESERVE1		MTK_M4U_DOM_ID(2, 14, 0)
+#define M4U_PORT_L14_CAM_RESERVE2		MTK_M4U_DOM_ID(2, 14, 1)
+#define M4U_PORT_L14_CAM_RESERVE3		MTK_M4U_DOM_ID(2, 14, 2)
+#define M4U_PORT_L14_CAM_CAMSV0			MTK_M4U_DOM_ID(2, 14, 3)
+#define M4U_PORT_L14_CAM_CCUI			MTK_M4U_DOM_ID(4, 14, 4)
+#define M4U_PORT_L14_CAM_CCUO			MTK_M4U_DOM_ID(4, 14, 5)
+
+/* larb15: null */
+
+/* larb16 */
+#define M4U_PORT_L16_CAM_IMGO_R1_A		MTK_M4U_DOM_ID(2, 16, 0)
+#define M4U_PORT_L16_CAM_RRZO_R1_A		MTK_M4U_DOM_ID(2, 16, 1)
+#define M4U_PORT_L16_CAM_CQI_R1_A		MTK_M4U_DOM_ID(2, 16, 2)
+#define M4U_PORT_L16_CAM_BPCI_R1_A		MTK_M4U_DOM_ID(2, 16, 3)
+#define M4U_PORT_L16_CAM_YUVO_R1_A		MTK_M4U_DOM_ID(2, 16, 4)
+#define M4U_PORT_L16_CAM_UFDI_R2_A		MTK_M4U_DOM_ID(2, 16, 5)
+#define M4U_PORT_L16_CAM_RAWI_R2_A		MTK_M4U_DOM_ID(2, 16, 6)
+#define M4U_PORT_L16_CAM_RAWI_R3_A		MTK_M4U_DOM_ID(2, 16, 7)
+#define M4U_PORT_L16_CAM_AAO_R1_A		MTK_M4U_DOM_ID(2, 16, 8)
+#define M4U_PORT_L16_CAM_AFO_R1_A		MTK_M4U_DOM_ID(2, 16, 9)
+#define M4U_PORT_L16_CAM_FLKO_R1_A		MTK_M4U_DOM_ID(2, 16, 10)
+#define M4U_PORT_L16_CAM_LCESO_R1_A		MTK_M4U_DOM_ID(2, 16, 11)
+#define M4U_PORT_L16_CAM_CRZO_R1_A		MTK_M4U_DOM_ID(2, 16, 12)
+#define M4U_PORT_L16_CAM_LTMSO_R1_A		MTK_M4U_DOM_ID(2, 16, 13)
+#define M4U_PORT_L16_CAM_RSSO_R1_A		MTK_M4U_DOM_ID(2, 16, 14)
+#define M4U_PORT_L16_CAM_AAHO_R1_A		MTK_M4U_DOM_ID(2, 16, 15)
+#define M4U_PORT_L16_CAM_LSCI_R1_A		MTK_M4U_DOM_ID(2, 16, 16)
+
+/* larb17 */
+#define M4U_PORT_L17_CAM_IMGO_R1_B		MTK_M4U_DOM_ID(2, 17, 0)
+#define M4U_PORT_L17_CAM_RRZO_R1_B		MTK_M4U_DOM_ID(2, 17, 1)
+#define M4U_PORT_L17_CAM_CQI_R1_B		MTK_M4U_DOM_ID(2, 17, 2)
+#define M4U_PORT_L17_CAM_BPCI_R1_B		MTK_M4U_DOM_ID(2, 17, 3)
+#define M4U_PORT_L17_CAM_YUVO_R1_B		MTK_M4U_DOM_ID(2, 17, 4)
+#define M4U_PORT_L17_CAM_UFDI_R2_B		MTK_M4U_DOM_ID(2, 17, 5)
+#define M4U_PORT_L17_CAM_RAWI_R2_B		MTK_M4U_DOM_ID(2, 17, 6)
+#define M4U_PORT_L17_CAM_RAWI_R3_B		MTK_M4U_DOM_ID(2, 17, 7)
+#define M4U_PORT_L17_CAM_AAO_R1_B		MTK_M4U_DOM_ID(2, 17, 8)
+#define M4U_PORT_L17_CAM_AFO_R1_B		MTK_M4U_DOM_ID(2, 17, 9)
+#define M4U_PORT_L17_CAM_FLKO_R1_B		MTK_M4U_DOM_ID(2, 17, 10)
+#define M4U_PORT_L17_CAM_LCESO_R1_B		MTK_M4U_DOM_ID(2, 17, 11)
+#define M4U_PORT_L17_CAM_CRZO_R1_B		MTK_M4U_DOM_ID(2, 17, 12)
+#define M4U_PORT_L17_CAM_LTMSO_R1_B		MTK_M4U_DOM_ID(2, 17, 13)
+#define M4U_PORT_L17_CAM_RSSO_R1_B		MTK_M4U_DOM_ID(2, 17, 14)
+#define M4U_PORT_L17_CAM_AAHO_R1_B		MTK_M4U_DOM_ID(2, 17, 15)
+#define M4U_PORT_L17_CAM_LSCI_R1_B		MTK_M4U_DOM_ID(2, 17, 16)
+
+/* larb18 */
+#define M4U_PORT_L18_CAM_IMGO_R1_C		MTK_M4U_DOM_ID(2, 18, 0)
+#define M4U_PORT_L18_CAM_RRZO_R1_C		MTK_M4U_DOM_ID(2, 18, 1)
+#define M4U_PORT_L18_CAM_CQI_R1_C		MTK_M4U_DOM_ID(2, 18, 2)
+#define M4U_PORT_L18_CAM_BPCI_R1_C		MTK_M4U_DOM_ID(2, 18, 3)
+#define M4U_PORT_L18_CAM_YUVO_R1_C		MTK_M4U_DOM_ID(2, 18, 4)
+#define M4U_PORT_L18_CAM_UFDI_R2_C		MTK_M4U_DOM_ID(2, 18, 5)
+#define M4U_PORT_L18_CAM_RAWI_R2_C		MTK_M4U_DOM_ID(2, 18, 6)
+#define M4U_PORT_L18_CAM_RAWI_R3_C		MTK_M4U_DOM_ID(2, 18, 7)
+#define M4U_PORT_L18_CAM_AAO_R1_C		MTK_M4U_DOM_ID(2, 18, 8)
+#define M4U_PORT_L18_CAM_AFO_R1_C		MTK_M4U_DOM_ID(2, 18, 9)
+#define M4U_PORT_L18_CAM_FLKO_R1_C		MTK_M4U_DOM_ID(2, 18, 10)
+#define M4U_PORT_L18_CAM_LCESO_R1_C		MTK_M4U_DOM_ID(2, 18, 11)
+#define M4U_PORT_L18_CAM_CRZO_R1_C		MTK_M4U_DOM_ID(2, 18, 12)
+#define M4U_PORT_L18_CAM_LTMSO_R1_C		MTK_M4U_DOM_ID(2, 18, 13)
+#define M4U_PORT_L18_CAM_RSSO_R1_C		MTK_M4U_DOM_ID(2, 18, 14)
+#define M4U_PORT_L18_CAM_AAHO_R1_C		MTK_M4U_DOM_ID(2, 18, 15)
+#define M4U_PORT_L18_CAM_LSCI_R1_C		MTK_M4U_DOM_ID(2, 18, 16)
+
+/* larb19 */
+#define M4U_PORT_L19_IPE_DVS_RDMA		MTK_M4U_DOM_ID(2, 19, 0)
+#define M4U_PORT_L19_IPE_DVS_WDMA		MTK_M4U_DOM_ID(2, 19, 1)
+#define M4U_PORT_L19_IPE_DVP_RDMA		MTK_M4U_DOM_ID(2, 19, 2)
+#define M4U_PORT_L19_IPE_DVP_WDMA		MTK_M4U_DOM_ID(2, 19, 3)
+
+/* larb20 */
+#define M4U_PORT_L20_IPE_FDVT_RDA		MTK_M4U_DOM_ID(2, 20, 0)
+#define M4U_PORT_L20_IPE_FDVT_RDB		MTK_M4U_DOM_ID(2, 20, 1)
+#define M4U_PORT_L20_IPE_FDVT_WRA		MTK_M4U_DOM_ID(2, 20, 2)
+#define M4U_PORT_L20_IPE_FDVT_WRB		MTK_M4U_DOM_ID(2, 20, 3)
+#define M4U_PORT_L20_IPE_RSC_RDMA0		MTK_M4U_DOM_ID(2, 20, 4)
+#define M4U_PORT_L20_IPE_RSC_WDMA		MTK_M4U_DOM_ID(2, 20, 5)
+
+#endif
-- 
2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
