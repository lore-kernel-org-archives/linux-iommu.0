Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF51C433F5
	for <iommu@archiver.kernel.org>; Thu, 13 Jan 2022 11:11:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCCDF6FC2E;
	Thu, 13 Jan 2022 11:11:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6_iUPgTje5Xp; Thu, 13 Jan 2022 11:11:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C187160ADD;
	Thu, 13 Jan 2022 11:11:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A1E1C0030;
	Thu, 13 Jan 2022 11:11:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FF10C0030
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 11:11:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B31640A59
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 11:11:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xv8uFfCViQkD for <iommu@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 11:11:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2C9B6409EE
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 11:11:15 +0000 (UTC)
X-UUID: b94f5930a4b445a3bfa0152062223c3c-20220113
X-UUID: b94f5930a4b445a3bfa0152062223c3c-20220113
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 698236186; Thu, 13 Jan 2022 19:11:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 13 Jan 2022 19:11:13 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Jan 2022 19:11:12 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Rob Herring
 <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v3 1/7] dt-bindings: memory: mtk-smi: Rename clock to clocks
Date: Thu, 13 Jan 2022 19:10:51 +0800
Message-ID: <20220113111057.29918-2-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220113111057.29918-1-yong.wu@mediatek.com>
References: <20220113111057.29918-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 lc.kan@mediatek.com, anthony.huang@mediatek.com, anan.sun@mediatek.com,
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

The property "clock" should be rename to "clocks", and delete the "items",
the minItems/maxItems should not be put under "items".

Fixes: 27bb0e42855a ("dt-bindings: memory: mediatek: Convert SMI to DT schema")
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 .../mediatek,smi-common.yaml                  | 28 ++++++++-----------
 .../memory-controllers/mediatek,smi-larb.yaml | 14 ++++------
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
index 3a82b0b27fa0..4fca71f34310 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
@@ -88,10 +88,9 @@ allOf:
               - mediatek,mt2701-smi-common
     then:
       properties:
-        clock:
-          items:
-            minItems: 3
-            maxItems: 3
+        clocks:
+          minItems: 3
+          maxItems: 3
         clock-names:
           items:
             - const: apb
@@ -108,10 +107,9 @@ allOf:
       required:
         - mediatek,smi
       properties:
-        clock:
-          items:
-            minItems: 3
-            maxItems: 3
+        clocks:
+          minItems: 3
+          maxItems: 3
         clock-names:
           items:
             - const: apb
@@ -133,10 +131,9 @@ allOf:
 
     then:
       properties:
-        clock:
-          items:
-            minItems: 4
-            maxItems: 4
+        clocks:
+          minItems: 4
+          maxItems: 4
         clock-names:
           items:
             - const: apb
@@ -146,10 +143,9 @@ allOf:
 
     else:  # for gen2 HW that don't have gals
       properties:
-        clock:
-          items:
-            minItems: 2
-            maxItems: 2
+        clocks:
+          minItems: 2
+          maxItems: 2
         clock-names:
           items:
             - const: apb
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
index eaeff1ada7f8..bd7aa8257949 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
@@ -79,10 +79,9 @@ allOf:
 
     then:
       properties:
-        clock:
-          items:
-            minItems: 3
-            maxItems: 3
+        clocks:
+          minItems: 3
+          maxItems: 3
         clock-names:
           items:
             - const: apb
@@ -91,10 +90,9 @@ allOf:
 
     else:
       properties:
-        clock:
-          items:
-            minItems: 2
-            maxItems: 2
+        clocks:
+          minItems: 2
+          maxItems: 2
         clock-names:
           items:
             - const: apb
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
