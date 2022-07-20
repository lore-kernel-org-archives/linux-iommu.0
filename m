Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59454693
	for <iommu@lists.linux.dev>; Wed, 20 Jul 2022 12:35:40 +0000 (UTC)
X-UUID: ee89a98b0a9645f69f88404e95b4eaa0-20220720
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:a474bfb0-74ef-464d-a6ab-d0254daa7b12,OB:10,L
	OB:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
	CTION:release,TS:95
X-CID-INFO: VERSION:1.1.8,REQID:a474bfb0-74ef-464d-a6ab-d0254daa7b12,OB:10,LOB
	:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
	CTION:quarantine,TS:95
X-CID-META: VersionHash:0f94e32,CLOUDID:78547d33-b9e4-42b8-b28a-6364427c76bb,C
	OID:bdb3ebc4ff7c,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: ee89a98b0a9645f69f88404e95b4eaa0-20220720
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
	(envelope-from <tinghan.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 2114801822; Wed, 20 Jul 2022 20:30:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 20 Jul 2022 20:30:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 20 Jul 2022 20:30:24 +0800
From: Tinghan Shen <tinghan.shen@mediatek.com>
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Lee Jones <lee.jones@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, Tinghan Shen
	<tinghan.shen@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, MandyJH Liu
	<mandyjh.liu@mediatek.com>
CC: <iommu@lists.linux.dev>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3 03/21] dt-bindings: power: mediatek: Refine multiple level power domain nodes
Date: Wed, 20 Jul 2022 20:30:05 +0800
Message-ID: <20220720123023.13500-4-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220720123023.13500-1-tinghan.shen@mediatek.com>
References: <20220720123023.13500-1-tinghan.shen@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

Extract duplicated properties and support more levels of power
domain nodes.

This change fix following error when do dtbs_check,
    arch/arm64/boot/dts/mediatek/mt8195-evb.dtb: power-controller: power-domain@15:power-domain@16:power-domain@18: 'power-domain@19', 'power-domain@20', 'power-domain@21' do not match any of the regexes: 'pinctrl-[0-9]+'
	 From schema: Documentation/devicetree/bindings/power/mediatek,power-controller.yaml

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 .../power/mediatek,power-controller.yaml      | 131 +++---------------
 1 file changed, 17 insertions(+), 114 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index b448101fac43..321802c95308 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -42,6 +42,23 @@ properties:
 
 patternProperties:
   "^power-domain@[0-9a-f]+$":
+    $ref: "#/$defs/power-domain-node"
+    patternProperties:
+      "^power-domain@[0-9a-f]+$":
+        $ref: "#/$defs/power-domain-node"
+        patternProperties:
+          "^power-domain@[0-9a-f]+$":
+            $ref: "#/$defs/power-domain-node"
+            patternProperties:
+              "^power-domain@[0-9a-f]+$":
+                $ref: "#/$defs/power-domain-node"
+                unevaluatedProperties: false
+            unevaluatedProperties: false
+        unevaluatedProperties: false
+    unevaluatedProperties: false
+
+$defs:
+  power-domain-node:
     type: object
     description: |
       Represents the power domains within the power controller node as documented
@@ -100,123 +117,9 @@ patternProperties:
         $ref: /schemas/types.yaml#/definitions/phandle
         description: phandle to the device containing the SMI register range.
 
-    patternProperties:
-      "^power-domain@[0-9a-f]+$":
-        type: object
-        description: |
-          Represents a power domain child within a power domain parent node.
-
-        properties:
-
-          '#power-domain-cells':
-            description:
-              Must be 0 for nodes representing a single PM domain and 1 for nodes
-              providing multiple PM domains.
-
-          '#address-cells':
-            const: 1
-
-          '#size-cells':
-            const: 0
-
-          reg:
-            maxItems: 1
-
-          clocks:
-            description: |
-              A number of phandles to clocks that need to be enabled during domain
-              power-up sequencing.
-
-          clock-names:
-            description: |
-              List of names of clocks, in order to match the power-up sequencing
-              for each power domain we need to group the clocks by name. BASIC
-              clocks need to be enabled before enabling the corresponding power
-              domain, and should not have a '-' in their name (i.e mm, mfg, venc).
-              SUSBYS clocks need to be enabled before releasing the bus protection,
-              and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
-
-              In order to follow properly the power-up sequencing, the clocks must
-              be specified by order, adding first the BASIC clocks followed by the
-              SUSBSYS clocks.
-
-          domain-supply:
-            description: domain regulator supply.
-
-          mediatek,infracfg:
-            $ref: /schemas/types.yaml#/definitions/phandle
-            description: phandle to the device containing the INFRACFG register range.
-
-          mediatek,smi:
-            $ref: /schemas/types.yaml#/definitions/phandle
-            description: phandle to the device containing the SMI register range.
-
-        patternProperties:
-          "^power-domain@[0-9a-f]+$":
-            type: object
-            description: |
-              Represents a power domain child within a power domain parent node.
-
-            properties:
-
-              '#power-domain-cells':
-                description:
-                  Must be 0 for nodes representing a single PM domain and 1 for nodes
-                  providing multiple PM domains.
-
-              '#address-cells':
-                const: 1
-
-              '#size-cells':
-                const: 0
-
-              reg:
-                maxItems: 1
-
-              clocks:
-                description: |
-                  A number of phandles to clocks that need to be enabled during domain
-                  power-up sequencing.
-
-              clock-names:
-                description: |
-                  List of names of clocks, in order to match the power-up sequencing
-                  for each power domain we need to group the clocks by name. BASIC
-                  clocks need to be enabled before enabling the corresponding power
-                  domain, and should not have a '-' in their name (i.e mm, mfg, venc).
-                  SUSBYS clocks need to be enabled before releasing the bus protection,
-                  and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
-
-                  In order to follow properly the power-up sequencing, the clocks must
-                  be specified by order, adding first the BASIC clocks followed by the
-                  SUSBSYS clocks.
-
-              domain-supply:
-                description: domain regulator supply.
-
-              mediatek,infracfg:
-                $ref: /schemas/types.yaml#/definitions/phandle
-                description: phandle to the device containing the INFRACFG register range.
-
-              mediatek,smi:
-                $ref: /schemas/types.yaml#/definitions/phandle
-                description: phandle to the device containing the SMI register range.
-
-            required:
-              - reg
-
-            additionalProperties: false
-
-        required:
-          - reg
-
-        additionalProperties: false
-
     required:
       - reg
 
-    additionalProperties: false
-
 required:
   - compatible
 
-- 
2.18.0

