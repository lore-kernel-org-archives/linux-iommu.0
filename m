Return-Path: <SRS0=eGnl=LK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE90CC48BE6
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 11:49:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765DA610CD
	for <iommu@archiver.kernel.org>; Wed, 16 Jun 2021 11:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765DA610CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4C72F4042A;
	Wed, 16 Jun 2021 11:49:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zNLSavutjuVU; Wed, 16 Jun 2021 11:49:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 37D20403E8;
	Wed, 16 Jun 2021 11:49:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14987C000D;
	Wed, 16 Jun 2021 11:49:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F233C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:49:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B6354042A
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:49:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gogmXekPFLaB for <iommu@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 11:49:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [210.61.82.183])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2F610403E8
 for <iommu@lists.linux-foundation.org>; Wed, 16 Jun 2021 11:49:16 +0000 (UTC)
X-UUID: a84b44cca9fc4c9897e638fd711e96fd-20210616
X-UUID: a84b44cca9fc4c9897e638fd711e96fd-20210616
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 86501162; Wed, 16 Jun 2021 19:44:09 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 19:44:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 19:44:07 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Rob Herring
 <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 1/9] dt-bindings: memory: mediatek: Add mt8195 smi binding
Date: Wed, 16 Jun 2021 19:43:38 +0800
Message-ID: <20210616114346.18812-2-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210616114346.18812-1-yong.wu@mediatek.com>
References: <20210616114346.18812-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, anthony.huang@mediatek.com,
 ming-fan.chen@mediatek.com, yi.kuo@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

This patch adds mt8195 smi supporting in the bindings.

In mt8195, there are two smi-common HW, one is for vdo(video output),
the other is for vpp(video processing pipe). They connects with different
smi-larbs, then some setting(bus_sel) is different. Differentiate them
with the compatible string.

Something like this:

    IOMMU(VDO)          IOMMU(VPP)
       |                   |
  SMI_COMMON_VDO      SMI_COMMON_VPP
  ---------------     ----------------
  |      |   ...      |      |     ...
larb0 larb2  ...    larb1 larb3    ...

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 .../bindings/memory-controllers/mediatek,smi-common.yaml    | 6 +++++-
 .../bindings/memory-controllers/mediatek,smi-larb.yaml      | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
index a08a32340987..6317025bd203 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
@@ -16,7 +16,7 @@ description: |
   MediaTek SMI have two generations of HW architecture, here is the list
   which generation the SoCs use:
   generation 1: mt2701 and mt7623.
-  generation 2: mt2712, mt6779, mt8167, mt8173, mt8183 and mt8192.
+  generation 2: mt2712, mt6779, mt8167, mt8173, mt8183, mt8192 and mt8195.
 
   There's slight differences between the two SMI, for generation 2, the
   register which control the iommu port is at each larb's register base. But
@@ -36,6 +36,8 @@ properties:
           - mediatek,mt8173-smi-common
           - mediatek,mt8183-smi-common
           - mediatek,mt8192-smi-common
+          - mediatek,mt8195-smi-common-vdo
+          - mediatek,mt8195-smi-common-vpp
 
       - description: for mt7623
         items:
@@ -100,6 +102,8 @@ allOf:
             - mediatek,mt6779-smi-common
             - mediatek,mt8183-smi-common
             - mediatek,mt8192-smi-common
+            - mediatek,mt8195-smi-common-vdo
+            - mediatek,mt8195-smi-common-vpp
 
     then:
       properties:
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
index 7ed7839ff0a7..a100283903bd 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
@@ -24,6 +24,7 @@ properties:
           - mediatek,mt8173-smi-larb
           - mediatek,mt8183-smi-larb
           - mediatek,mt8192-smi-larb
+          - mediatek,mt8195-smi-larb
 
       - description: for mt7623
         items:
@@ -75,6 +76,7 @@ allOf:
         compatible:
           enum:
             - mediatek,mt8183-smi-larb
+            - mediatek,mt8195-smi-larb
 
     then:
       properties:
@@ -109,6 +111,7 @@ allOf:
               - mediatek,mt6779-smi-larb
               - mediatek,mt8167-smi-larb
               - mediatek,mt8192-smi-larb
+              - mediatek,mt8195-smi-larb
 
     then:
       required:
-- 
2.18.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
