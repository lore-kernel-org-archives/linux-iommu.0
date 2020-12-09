Return-Path: <SRS0=OQvg=FN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68469C4361B
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 08:02:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4B923B84
	for <iommu@archiver.kernel.org>; Wed,  9 Dec 2020 08:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4B923B84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DD326877CA;
	Wed,  9 Dec 2020 08:02:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PXL1txNbXoLB; Wed,  9 Dec 2020 08:02:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 395EC8761F;
	Wed,  9 Dec 2020 08:02:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26BCAC0FA7;
	Wed,  9 Dec 2020 08:02:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 067D0C013B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 08:02:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 025288761F
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 08:02:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JymC1hZSqkt0 for <iommu@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 08:02:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by hemlock.osuosl.org (Postfix) with ESMTP id 14E6E872D0
 for <iommu@lists.linux-foundation.org>; Wed,  9 Dec 2020 08:02:14 +0000 (UTC)
X-UUID: 49c9e5100ff546779371ca6321fdc86f-20201209
X-UUID: 49c9e5100ff546779371ca6321fdc86f-20201209
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1512407944; Wed, 09 Dec 2020 16:02:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Dec 2020 16:02:09 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Dec 2020 16:02:08 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v5 05/27] dt-bindings: memory: mediatek: Rename header guard
 for SMI header file
Date: Wed, 9 Dec 2020 16:00:40 +0800
Message-ID: <20201209080102.26626-6-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201209080102.26626-1-yong.wu@mediatek.com>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>, anan.sun@mediatek.com,
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

Only rename the header guard for all the SoC larb port header file.
No funtional change.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 include/dt-bindings/memory/mt2701-larb-port.h | 4 ++--
 include/dt-bindings/memory/mt2712-larb-port.h | 4 ++--
 include/dt-bindings/memory/mt6779-larb-port.h | 4 ++--
 include/dt-bindings/memory/mt8167-larb-port.h | 4 ++--
 include/dt-bindings/memory/mt8173-larb-port.h | 4 ++--
 include/dt-bindings/memory/mt8183-larb-port.h | 4 ++--
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/dt-bindings/memory/mt2701-larb-port.h b/include/dt-bindings/memory/mt2701-larb-port.h
index 2d85c2ec6cfd..25d03526f142 100644
--- a/include/dt-bindings/memory/mt2701-larb-port.h
+++ b/include/dt-bindings/memory/mt2701-larb-port.h
@@ -4,8 +4,8 @@
  * Author: Honghui Zhang <honghui.zhang@mediatek.com>
  */
 
-#ifndef _MT2701_LARB_PORT_H_
-#define _MT2701_LARB_PORT_H_
+#ifndef _DT_BINDINGS_MEMORY_MT2701_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT2701_LARB_PORT_H_
 
 /*
  * Mediatek m4u generation 1 such as mt2701 has flat m4u port numbers,
diff --git a/include/dt-bindings/memory/mt2712-larb-port.h b/include/dt-bindings/memory/mt2712-larb-port.h
index b6b2c6bf4459..5c7f303f078c 100644
--- a/include/dt-bindings/memory/mt2712-larb-port.h
+++ b/include/dt-bindings/memory/mt2712-larb-port.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2017 MediaTek Inc.
  * Author: Yong Wu <yong.wu@mediatek.com>
  */
-#ifndef __DTS_IOMMU_PORT_MT2712_H
-#define __DTS_IOMMU_PORT_MT2712_H
+#ifndef _DT_BINDINGS_MEMORY_MT2712_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT2712_LARB_PORT_H_
 
 #include <dt-bindings/memory/mtk-smi-larb-port.h>
 
diff --git a/include/dt-bindings/memory/mt6779-larb-port.h b/include/dt-bindings/memory/mt6779-larb-port.h
index 60f57f54393e..bc93757df2bf 100644
--- a/include/dt-bindings/memory/mt6779-larb-port.h
+++ b/include/dt-bindings/memory/mt6779-larb-port.h
@@ -4,8 +4,8 @@
  * Author: Chao Hao <chao.hao@mediatek.com>
  */
 
-#ifndef _DTS_IOMMU_PORT_MT6779_H_
-#define _DTS_IOMMU_PORT_MT6779_H_
+#ifndef _DT_BINDINGS_MEMORY_MT6779_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT6779_LARB_PORT_H_
 
 #include <dt-bindings/memory/mtk-smi-larb-port.h>
 
diff --git a/include/dt-bindings/memory/mt8167-larb-port.h b/include/dt-bindings/memory/mt8167-larb-port.h
index fcb9a49ec60e..8570aab09db8 100644
--- a/include/dt-bindings/memory/mt8167-larb-port.h
+++ b/include/dt-bindings/memory/mt8167-larb-port.h
@@ -5,8 +5,8 @@
  * Author: Honghui Zhang <honghui.zhang@mediatek.com>
  * Author: Fabien Parent <fparent@baylibre.com>
  */
-#ifndef __DTS_IOMMU_PORT_MT8167_H
-#define __DTS_IOMMU_PORT_MT8167_H
+#ifndef _DT_BINDINGS_MEMORY_MT8167_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT8167_LARB_PORT_H_
 
 #include <dt-bindings/memory/mtk-smi-larb-port.h>
 
diff --git a/include/dt-bindings/memory/mt8173-larb-port.h b/include/dt-bindings/memory/mt8173-larb-port.h
index d8c99c946053..1b568973fc2d 100644
--- a/include/dt-bindings/memory/mt8173-larb-port.h
+++ b/include/dt-bindings/memory/mt8173-larb-port.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2015-2016 MediaTek Inc.
  * Author: Yong Wu <yong.wu@mediatek.com>
  */
-#ifndef __DTS_IOMMU_PORT_MT8173_H
-#define __DTS_IOMMU_PORT_MT8173_H
+#ifndef _DT_BINDINGS_MEMORY_MT8173_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT8173_LARB_PORT_H_
 
 #include <dt-bindings/memory/mtk-smi-larb-port.h>
 
diff --git a/include/dt-bindings/memory/mt8183-larb-port.h b/include/dt-bindings/memory/mt8183-larb-port.h
index 275c095a6fd6..3095630bb190 100644
--- a/include/dt-bindings/memory/mt8183-larb-port.h
+++ b/include/dt-bindings/memory/mt8183-larb-port.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2018 MediaTek Inc.
  * Author: Yong Wu <yong.wu@mediatek.com>
  */
-#ifndef __DTS_IOMMU_PORT_MT8183_H
-#define __DTS_IOMMU_PORT_MT8183_H
+#ifndef _DT_BINDINGS_MEMORY_MT8183_LARB_PORT_H_
+#define _DT_BINDINGS_MEMORY_MT8183_LARB_PORT_H_
 
 #include <dt-bindings/memory/mtk-smi-larb-port.h>
 
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
