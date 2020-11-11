Return-Path: <SRS0=hwFB=ER=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FA7C55ABD
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 12:39:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EAC220659
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 12:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EAC220659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9212687528;
	Wed, 11 Nov 2020 12:39:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VOBmbqX4zQSX; Wed, 11 Nov 2020 12:39:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C73D787559;
	Wed, 11 Nov 2020 12:39:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A61E6C088B;
	Wed, 11 Nov 2020 12:39:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D23FC016F
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 12:39:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4BFD987559
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 12:39:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bvjjDVs3wd3r for <iommu@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 12:39:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6D3CF87552
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 12:39:07 +0000 (UTC)
X-UUID: 25826fb48a314b3ab30193fa8d8f9342-20201111
X-UUID: 25826fb48a314b3ab30193fa8d8f9342-20201111
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 613552493; Wed, 11 Nov 2020 20:39:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Nov 2020 20:39:03 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Nov 2020 20:39:02 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v4 02/24] dt-bindings: memory: mediatek: Add a common
 larb-port header file
Date: Wed, 11 Nov 2020 20:38:16 +0800
Message-ID: <20201111123838.15682-3-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201111123838.15682-1-yong.wu@mediatek.com>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, kernel-team@android.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>, anan.sun@mediatek.com,
 Greg Kroah-Hartman <gregkh@google.com>, linux-arm-kernel@lists.infradead.org
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

Put all the macros about smi larb/port togethers, this is a preparing
patch for extending LARB_NR and adding new dom-id support.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/memory/mt2712-larb-port.h  |  2 +-
 include/dt-bindings/memory/mt6779-larb-port.h  |  2 +-
 include/dt-bindings/memory/mt8167-larb-port.h  |  2 +-
 include/dt-bindings/memory/mt8173-larb-port.h  |  2 +-
 include/dt-bindings/memory/mt8183-larb-port.h  |  2 +-
 include/dt-bindings/memory/mtk-smi-larb-port.h | 15 +++++++++++++++
 6 files changed, 20 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/memory/mtk-smi-larb-port.h

diff --git a/include/dt-bindings/memory/mt2712-larb-port.h b/include/dt-bindings/memory/mt2712-larb-port.h
index 6f9aa7349cef..b6b2c6bf4459 100644
--- a/include/dt-bindings/memory/mt2712-larb-port.h
+++ b/include/dt-bindings/memory/mt2712-larb-port.h
@@ -6,7 +6,7 @@
 #ifndef __DTS_IOMMU_PORT_MT2712_H
 #define __DTS_IOMMU_PORT_MT2712_H
 
-#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
+#include <dt-bindings/memory/mtk-smi-larb-port.h>
 
 #define M4U_LARB0_ID			0
 #define M4U_LARB1_ID			1
diff --git a/include/dt-bindings/memory/mt6779-larb-port.h b/include/dt-bindings/memory/mt6779-larb-port.h
index 2ad0899fbf2f..60f57f54393e 100644
--- a/include/dt-bindings/memory/mt6779-larb-port.h
+++ b/include/dt-bindings/memory/mt6779-larb-port.h
@@ -7,7 +7,7 @@
 #ifndef _DTS_IOMMU_PORT_MT6779_H_
 #define _DTS_IOMMU_PORT_MT6779_H_
 
-#define MTK_M4U_ID(larb, port)		 (((larb) << 5) | (port))
+#include <dt-bindings/memory/mtk-smi-larb-port.h>
 
 #define M4U_LARB0_ID			 0
 #define M4U_LARB1_ID			 1
diff --git a/include/dt-bindings/memory/mt8167-larb-port.h b/include/dt-bindings/memory/mt8167-larb-port.h
index 000fb299a408..fcb9a49ec60e 100644
--- a/include/dt-bindings/memory/mt8167-larb-port.h
+++ b/include/dt-bindings/memory/mt8167-larb-port.h
@@ -8,7 +8,7 @@
 #ifndef __DTS_IOMMU_PORT_MT8167_H
 #define __DTS_IOMMU_PORT_MT8167_H
 
-#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
+#include <dt-bindings/memory/mtk-smi-larb-port.h>
 
 #define M4U_LARB0_ID			0
 #define M4U_LARB1_ID			1
diff --git a/include/dt-bindings/memory/mt8173-larb-port.h b/include/dt-bindings/memory/mt8173-larb-port.h
index 9f31ccfeca21..d8c99c946053 100644
--- a/include/dt-bindings/memory/mt8173-larb-port.h
+++ b/include/dt-bindings/memory/mt8173-larb-port.h
@@ -6,7 +6,7 @@
 #ifndef __DTS_IOMMU_PORT_MT8173_H
 #define __DTS_IOMMU_PORT_MT8173_H
 
-#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
+#include <dt-bindings/memory/mtk-smi-larb-port.h>
 
 #define M4U_LARB0_ID			0
 #define M4U_LARB1_ID			1
diff --git a/include/dt-bindings/memory/mt8183-larb-port.h b/include/dt-bindings/memory/mt8183-larb-port.h
index 2c579f305162..275c095a6fd6 100644
--- a/include/dt-bindings/memory/mt8183-larb-port.h
+++ b/include/dt-bindings/memory/mt8183-larb-port.h
@@ -6,7 +6,7 @@
 #ifndef __DTS_IOMMU_PORT_MT8183_H
 #define __DTS_IOMMU_PORT_MT8183_H
 
-#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
+#include <dt-bindings/memory/mtk-smi-larb-port.h>
 
 #define M4U_LARB0_ID			0
 #define M4U_LARB1_ID			1
diff --git a/include/dt-bindings/memory/mtk-smi-larb-port.h b/include/dt-bindings/memory/mtk-smi-larb-port.h
new file mode 100644
index 000000000000..2ec7fe5ce4e9
--- /dev/null
+++ b/include/dt-bindings/memory/mtk-smi-larb-port.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Author: Yong Wu <yong.wu@mediatek.com>
+ */
+#ifndef __DTS_MTK_IOMMU_PORT_H_
+#define __DTS_MTK_IOMMU_PORT_H_
+
+#define MTK_LARB_NR_MAX			16
+
+#define MTK_M4U_ID(larb, port)		(((larb) << 5) | (port))
+#define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0xf)
+#define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
+
+#endif
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
