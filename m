Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E2562B
	for <iommu@lists.linux.dev>; Thu,  4 Aug 2022 02:16:00 +0000 (UTC)
X-UUID: 65d4213d94204fa2b3d091275f641ecf-20220804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uUnAQ8+VO+KSo5++5udCSf7bJEyj4UDAzmYdV8JOLBM=;
	b=IbqfML3lHNTgiHk9f2W+8jvLdTdxr9l+CJBLRsVL1WN4+dIvcQxS8yJ+LdqbYZ9YejOjaxGayZ5CuCLGRVOGlFqzYF6ppFUgnBOBEZEv22I3vlmVIbT0qSd6wCC4DYR4XKFZq+iFv9/rBsMR9ZQvcKW6Hxbyftm3dTrfMX4+JfI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:93c8fde1-5a4b-4b42-ac9b-696d1d1a2d1f,OB:0,LO
	B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:4b432cd1-841b-4e95-ad42-8f86e18f54fc,C
	OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
	,QS:nil,BEC:nil,COL:0
X-UUID: 65d4213d94204fa2b3d091275f641ecf-20220804
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
	(envelope-from <tinghan.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 1858609253; Thu, 04 Aug 2022 10:15:56 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 4 Aug 2022 10:15:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Aug 2022 10:15:55 +0800
From: Tinghan Shen <tinghan.shen@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Lee Jones <lee@kernel.org>, "Matthias
 Brugger" <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Tinghan Shen
	<tinghan.shen@mediatek.com>, MandyJH Liu <mandyjh.liu@mediatek.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v5 01/20] dt-bindings: iommu: mediatek: Increase max interrupt number
Date: Thu, 4 Aug 2022 10:15:34 +0800
Message-ID: <20220804021553.14867-2-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220804021553.14867-1-tinghan.shen@mediatek.com>
References: <20220804021553.14867-1-tinghan.shen@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

mt8195 infra iommu uses 5 interrupts.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
---
 .../bindings/iommu/mediatek,iommu.yaml        | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
 b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
index fee0241b50988..e3cf35e68d8d1 100644
--- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
@@ -91,7 +91,8 @@ properties:
     maxItems: 1
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    maxItems: 5
 
   clocks:
     items:
@@ -183,14 +184,28 @@ allOf:
       required:
         - mediatek,infracfg
 
-  - if: # The IOMMUs don't have larbs.
-      not:
-        properties:
-          compatible:
-            contains:
-              const: mediatek,mt8195-iommu-infra
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8195-iommu-infra
 
     then:
+      properties:
+        interrupts:
+          description: The IOMMU has 5 banks. Each bank has its own
 interrupt.
+          items:
+            - description: The interrupt for IOMMU bank0
+            - description: The interrupt for IOMMU bank1
+            - description: The interrupt for IOMMU bank2
+            - description: The interrupt for IOMMU bank3
+            - description: The interrupt for IOMMU bank4
+
+    else: # The IOMMUs don't have larbs.
+      properties:
+        interrupts:
+          maxItems: 1
+
       required:
         - mediatek,larbs
 
-- 
2.18.0

