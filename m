Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27117C433EF
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 11:08:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AAFD940520;
	Thu, 16 Jun 2022 11:08:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tzm8NX8iHBFw; Thu, 16 Jun 2022 11:08:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 824B14011D;
	Thu, 16 Jun 2022 11:08:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C5A0C0081;
	Thu, 16 Jun 2022 11:08:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 06764C002D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 11:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D59C94088D
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 11:08:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BOMA4NlYHmSL for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 11:08:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D855B40510
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 11:08:41 +0000 (UTC)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it
 [2.237.20.237])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 47FA5660174C;
 Thu, 16 Jun 2022 12:08:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1655377720;
 bh=JcxQv5eisp72VR6ziotoygEYFijE1my8ajQHmQfSnPw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mrjA6BFXLCa8xCLLpLd9AqjCPd6qOqYEKdO+mTDGdMfaHWX5mg16VaFTdEIEsSTH1
 vwvoVikh7KrO4nZFSt/XyXab153cG31FWduHrHgwa30Ndn1G+DrXWM4iorI2dwMhP8
 UeoPt6PCCmp3iiE1U51ypgOJoQCti9a+JF7PFXajrUgFI8SDGwRgkEefWrkOFqVAu7
 QNu57zAjyf2b2g8bwpJ25r//++44tOWt3rIVDdqyE7wx1K0LLHB4+z4FVT1YZ9eoqU
 5qrKykUIQG4Ro/3s0IQv19xqjL2DjV5ItBZ6r9zgP4y4G5i6OqwnqaN951bnTWXvBU
 BPqXbOJvvbviQ==
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: yong.wu@mediatek.com
Subject: [PATCH v4 1/5] dt-bindings: iommu: mediatek: Add mediatek,
 infracfg phandle
Date: Thu, 16 Jun 2022 13:08:26 +0200
Message-Id: <20220616110830.26037-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
References: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 krzysztof.kozlowski@linaro.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, linux-mediatek@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, miles.chen@mediatek.com,
 matthias.bgg@gmail.com, will@kernel.org, linux-arm-kernel@lists.infradead.org,
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

Add property "mediatek,infracfg" to let the mtk_iommu driver retrieve
a phandle to the infracfg syscon instead of performing a per-soc
compatible lookup in the entire devicetree and set it as a required
property for MT2712 and MT8173.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/iommu/mediatek,iommu.yaml          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index 2ae3bbad7f1a..fee0241b5098 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -101,6 +101,10 @@ properties:
     items:
       - const: bclk
 
+  mediatek,infracfg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle to the mediatek infracfg syscon
+
   mediatek,larbs:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     minItems: 1
@@ -167,6 +171,18 @@ allOf:
       required:
         - power-domains
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt2712-m4u
+              - mediatek,mt8173-m4u
+
+    then:
+      required:
+        - mediatek,infracfg
+
   - if: # The IOMMUs don't have larbs.
       not:
         properties:
@@ -191,6 +207,7 @@ examples:
             interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
             clocks = <&infracfg CLK_INFRA_M4U>;
             clock-names = "bclk";
+            mediatek,infracfg = <&infracfg>;
             mediatek,larbs = <&larb0>, <&larb1>, <&larb2>,
                              <&larb3>, <&larb4>, <&larb5>;
             #iommu-cells = <1>;
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
