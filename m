Return-Path: <SRS0=ylBP=CQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436A9C43461
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 10:17:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7B7421473
	for <iommu@archiver.kernel.org>; Mon,  7 Sep 2020 10:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="i4VYynak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B7421473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A4FA585F3E;
	Mon,  7 Sep 2020 10:17:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Mtp0ATWKToYl; Mon,  7 Sep 2020 10:17:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B964685F0B;
	Mon,  7 Sep 2020 10:17:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 968E6C0052;
	Mon,  7 Sep 2020 10:17:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3D87C0051
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 10:17:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A116C870F3
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 10:17:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7vUxo2X2Hx4o for <iommu@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 10:16:58 +0000 (UTC)
X-Greylist: delayed 18:57:23 by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9D8DB86F5E
 for <iommu@lists.linux-foundation.org>; Mon,  7 Sep 2020 10:16:58 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id c15so15159126wrs.11
 for <iommu@lists.linux-foundation.org>; Mon, 07 Sep 2020 03:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=o7KIQGaZLRrmrAAlxdI4JNMVSiQlEJ8fSUoBN8I+Xf8=;
 b=i4VYynakNDb2WI/pIy79r9zqh8yP1EVq+qeDo4qGHXp6XQgH1ROgPsIkGIWc1nFutG
 5jepqFgTB+vcAG3t2zeStqop0UdEX6MXpv3tB4Cj5b2RssOnT5VPAs1aaE0/iAPESeiM
 OtPy1xSO8kcCtXB6IN5xY34elUra0SQkPrXuB2zC/spDCmucT9x7TD8xqwMmk6SaCJ49
 ml7kphiRwIc4RFi1AROi2GqTNj5g5K9jB4exHnQ0wfWRrKFdDqtGIJrO8dydH53ntpFX
 aY5rfeEj8/CF7dhqCYZaECerEPGZi5FMVpZheuA3v2emjVRQOMpBu3njhrdBDCRBPeVt
 O/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=o7KIQGaZLRrmrAAlxdI4JNMVSiQlEJ8fSUoBN8I+Xf8=;
 b=PxJj1D3p3UMddZumTPHRxKr4jr1xKANjh0HqGUiMCv+9wiJL1bg3VgDQ6OVYQxmitz
 SHwxFViKwZAfzn6c3RAbiN/z9fBlgspXAzOuFdtLK1fzj7fzes+ZpUdmaQ++mtb061Qz
 mr32hO0Tg9Ivon8BYyCV19uyPG2JwLRywH+JSnUocYTYyWdOSGet6QjLYjx9X+xO1+zm
 rGhMS7eqxIVciQrFHXf/9pN5CB7B93fLUBB9vA5J6R6/bcjYi2D4o0SOrU4zx2wyqIlR
 EU1MBUtZD8yr2GWLaPPhseOpFUNvwy8sRKxFfsVJ1eJYsrcWa63IG5tnfe/WQTJ4FyIk
 QIyg==
X-Gm-Message-State: AOAM530gn6yZCMbR+ang3rFNBfTtb8spaPQiaa99QmRJ7sBDiUqDlODj
 Dcl89p7gpTpQWJBxHYjqwqgxF03Zzqz4rw==
X-Google-Smtp-Source: ABdhPJzoP9v7yuMPfMOlA8vMx95R4j+MIfrbjA33m48SJ7NXSflBVbFFQtTensuBMDC6CFNSOjR9aQ==
X-Received: by 2002:adf:f4c6:: with SMTP id h6mr20427607wrp.310.1599473816656; 
 Mon, 07 Sep 2020 03:16:56 -0700 (PDT)
Received: from localhost.localdomain (122.105.23.93.rev.sfr.net.
 [93.23.105.122])
 by smtp.gmail.com with ESMTPSA id j7sm28728689wrw.35.2020.09.07.03.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 03:16:56 -0700 (PDT)
From: Fabien Parent <fparent@baylibre.com>
To: iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: [PATCH v4 1/3] dt-bindings: iommu: Add binding for MediaTek MT8167
 IOMMU
Date: Mon,  7 Sep 2020 12:16:47 +0200
Message-Id: <20200907101649.1573134-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: Rob Herring <robh@kernel.org>, Fabien Parent <fparent@baylibre.com>,
 miles.chen@mediatek.com, robh+dt@kernel.org, matthias.bgg@gmail.com
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

This commit adds IOMMU binding documentation and larb port definitions
for the MT8167 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
---

V4:
	* Added path to mt8167 larb header file
	* Added Honghui Zhang in copyright header
V3: Added mt8167-larb-port.h file for iommu port definitions
V2: no change

---
 .../bindings/iommu/mediatek,iommu.txt         |  2 +
 include/dt-bindings/memory/mt8167-larb-port.h | 51 +++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 include/dt-bindings/memory/mt8167-larb-port.h

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
index c1ccd8582eb2..ac949f7fe3d4 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
@@ -61,6 +61,7 @@ Required properties:
 	"mediatek,mt6779-m4u" for mt6779 which uses generation two m4u HW.
 	"mediatek,mt7623-m4u", "mediatek,mt2701-m4u" for mt7623 which uses
 						     generation one m4u HW.
+	"mediatek,mt8167-m4u" for mt8167 which uses generation two m4u HW.
 	"mediatek,mt8173-m4u" for mt8173 which uses generation two m4u HW.
 	"mediatek,mt8183-m4u" for mt8183 which uses generation two m4u HW.
 - reg : m4u register base and size.
@@ -80,6 +81,7 @@ Required properties:
 	dt-binding/memory/mt2701-larb-port.h for mt2701, mt7623
 	dt-binding/memory/mt2712-larb-port.h for mt2712,
 	dt-binding/memory/mt6779-larb-port.h for mt6779,
+	dt-binding/memory/mt8167-larb-port.h for mt8167,
 	dt-binding/memory/mt8173-larb-port.h for mt8173, and
 	dt-binding/memory/mt8183-larb-port.h for mt8183.
 
diff --git a/include/dt-bindings/memory/mt8167-larb-port.h b/include/dt-bindings/memory/mt8167-larb-port.h
new file mode 100644
index 000000000000..000fb299a408
--- /dev/null
+++ b/include/dt-bindings/memory/mt8167-larb-port.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Copyright (c) 2020 BayLibre, SAS
+ * Author: Honghui Zhang <honghui.zhang@mediatek.com>
+ * Author: Fabien Parent <fparent@baylibre.com>
+ */
+#ifndef __DTS_IOMMU_PORT_MT8167_H
+#define __DTS_IOMMU_PORT_MT8167_H
+
+#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
+
+#define M4U_LARB0_ID			0
+#define M4U_LARB1_ID			1
+#define M4U_LARB2_ID			2
+
+/* larb0 */
+#define M4U_PORT_DISP_OVL0		MTK_M4U_ID(M4U_LARB0_ID, 0)
+#define M4U_PORT_DISP_RDMA0		MTK_M4U_ID(M4U_LARB0_ID, 1)
+#define M4U_PORT_DISP_WDMA0		MTK_M4U_ID(M4U_LARB0_ID, 2)
+#define M4U_PORT_DISP_RDMA1		MTK_M4U_ID(M4U_LARB0_ID, 3)
+#define M4U_PORT_MDP_RDMA		MTK_M4U_ID(M4U_LARB0_ID, 4)
+#define M4U_PORT_MDP_WDMA		MTK_M4U_ID(M4U_LARB0_ID, 5)
+#define M4U_PORT_MDP_WROT		MTK_M4U_ID(M4U_LARB0_ID, 6)
+#define M4U_PORT_DISP_FAKE		MTK_M4U_ID(M4U_LARB0_ID, 7)
+
+/* larb1*/
+#define M4U_PORT_CAM_IMGO		MTK_M4U_ID(M4U_LARB1_ID, 0)
+#define M4U_PORT_CAM_IMG2O		MTK_M4U_ID(M4U_LARB1_ID, 1)
+#define M4U_PORT_CAM_LSCI		MTK_M4U_ID(M4U_LARB1_ID, 2)
+#define M4U_PORT_CAM_ESFKO		MTK_M4U_ID(M4U_LARB1_ID, 3)
+#define M4U_PORT_CAM_AAO		MTK_M4U_ID(M4U_LARB1_ID, 4)
+#define M4U_PORT_VENC_REC		MTK_M4U_ID(M4U_LARB1_ID, 5)
+#define M4U_PORT_VENC_BSDMA		MTK_M4U_ID(M4U_LARB1_ID, 6)
+#define M4U_PORT_VENC_RD_COMV		MTK_M4U_ID(M4U_LARB1_ID, 7)
+#define M4U_PORT_CAM_IMGI		MTK_M4U_ID(M4U_LARB1_ID, 8)
+#define M4U_PORT_VENC_CUR_LUMA		MTK_M4U_ID(M4U_LARB1_ID, 9)
+#define M4U_PORT_VENC_CUR_CHROMA	MTK_M4U_ID(M4U_LARB1_ID, 10)
+#define M4U_PORT_VENC_REF_LUMA		MTK_M4U_ID(M4U_LARB1_ID, 11)
+#define M4U_PORT_VENC_REF_CHROMA	MTK_M4U_ID(M4U_LARB1_ID, 12)
+
+/* larb2*/
+#define M4U_PORT_HW_VDEC_MC_EXT		MTK_M4U_ID(M4U_LARB2_ID, 0)
+#define M4U_PORT_HW_VDEC_PP_EXT		MTK_M4U_ID(M4U_LARB2_ID, 1)
+#define M4U_PORT_HW_VDEC_VLD_EXT	MTK_M4U_ID(M4U_LARB2_ID, 2)
+#define M4U_PORT_HW_VDEC_AVC_MV_EXT	MTK_M4U_ID(M4U_LARB2_ID, 3)
+#define M4U_PORT_HW_VDEC_PRED_RD_EXT	MTK_M4U_ID(M4U_LARB2_ID, 4)
+#define M4U_PORT_HW_VDEC_PRED_WR_EXT	MTK_M4U_ID(M4U_LARB2_ID, 5)
+#define M4U_PORT_HW_VDEC_PPWRAP_EXT	MTK_M4U_ID(M4U_LARB2_ID, 6)
+
+#endif
-- 
2.28.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
