Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4B5C433F5
	for <iommu@archiver.kernel.org>; Thu, 13 Jan 2022 11:11:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DD176400C5;
	Thu, 13 Jan 2022 11:11:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9xD5lxlqvSiz; Thu, 13 Jan 2022 11:11:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7F5E940187;
	Thu, 13 Jan 2022 11:11:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B371C0030;
	Thu, 13 Jan 2022 11:11:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2A6ABC001E
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 11:11:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0949B40124
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 11:11:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nRcvDPUFZc-o for <iommu@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 11:11:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 11900400C5
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 11:11:41 +0000 (UTC)
X-UUID: b2c4df995e2c40e7804aa2a2995d8f5f-20220113
X-UUID: b2c4df995e2c40e7804aa2a2995d8f5f-20220113
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1837132579; Thu, 13 Jan 2022 19:11:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 13 Jan 2022 19:11:35 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Jan 2022 19:11:34 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Rob Herring
 <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v3 4/7] dt-bindings: memory: mediatek: Add mt8186 support
Date: Thu, 13 Jan 2022 19:10:54 +0800
Message-ID: <20220113111057.29918-5-yong.wu@mediatek.com>
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

Add mt8186 smi support in the bindings.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/memory-controllers/mediatek,smi-common.yaml      | 4 +++-
 .../bindings/memory-controllers/mediatek,smi-larb.yaml        | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
index 4fca71f34310..a98b359bf909 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
@@ -16,7 +16,7 @@ description: |
   MediaTek SMI have two generations of HW architecture, here is the list
   which generation the SoCs use:
   generation 1: mt2701 and mt7623.
-  generation 2: mt2712, mt6779, mt8167, mt8173, mt8183, mt8192 and mt8195.
+  generation 2: mt2712, mt6779, mt8167, mt8173, mt8183, mt8186, mt8192 and mt8195.
 
   There's slight differences between the two SMI, for generation 2, the
   register which control the iommu port is at each larb's register base. But
@@ -35,6 +35,7 @@ properties:
           - mediatek,mt8167-smi-common
           - mediatek,mt8173-smi-common
           - mediatek,mt8183-smi-common
+          - mediatek,mt8186-smi-common
           - mediatek,mt8192-smi-common
           - mediatek,mt8195-smi-common-vdo
           - mediatek,mt8195-smi-common-vpp
@@ -125,6 +126,7 @@ allOf:
           enum:
             - mediatek,mt6779-smi-common
             - mediatek,mt8183-smi-common
+            - mediatek,mt8186-smi-common
             - mediatek,mt8192-smi-common
             - mediatek,mt8195-smi-common-vdo
             - mediatek,mt8195-smi-common-vpp
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
index c5c32c910045..4db8690829cd 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
@@ -23,6 +23,7 @@ properties:
           - mediatek,mt8167-smi-larb
           - mediatek,mt8173-smi-larb
           - mediatek,mt8183-smi-larb
+          - mediatek,mt8186-smi-larb
           - mediatek,mt8192-smi-larb
           - mediatek,mt8195-smi-larb
 
@@ -75,6 +76,7 @@ allOf:
         compatible:
           enum:
             - mediatek,mt8183-smi-larb
+            - mediatek,mt8186-smi-larb
             - mediatek,mt8195-smi-larb
 
     then:
@@ -107,6 +109,7 @@ allOf:
               - mediatek,mt2701-smi-larb
               - mediatek,mt2712-smi-larb
               - mediatek,mt6779-smi-larb
+              - mediatek,mt8186-smi-larb
               - mediatek,mt8192-smi-larb
               - mediatek,mt8195-smi-larb
 
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
