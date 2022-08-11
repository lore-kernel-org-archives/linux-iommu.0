Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A764D20F7
	for <iommu@lists.linux.dev>; Thu, 11 Aug 2022 02:58:32 +0000 (UTC)
X-UUID: 784b02e7c29944c0bfc137fede4b0e99-20220811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IAzpKAyBxTJKfd38JIir+9CzoM68fRjIC8f+N8h9/fY=;
	b=JNoCuDhYgHOMJwXXD8W8Iny4R/O9G3F/n3wrb04xtTxtH76P/h/6hajT5nBDGLGr5ZS7mS3lT1v+VHKJQPhEL3hfp6ZqjSnw7U9BR52NQHd4c9hYKl+J9as/0EnnHwrQj7d8f0q2xA6DJNmW11qAKUkYq1aEDdJAy6+ofFK4e7Q=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.9,REQID:6519210b-0e46-45ca-9874-79bdcc09f8a1,OB:10,L
	OB:70,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam
	_GS6885AD,ACTION:quarantine,TS:125
X-CID-INFO: VERSION:1.1.9,REQID:6519210b-0e46-45ca-9874-79bdcc09f8a1,OB:10,LOB
	:70,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_G
	S981B3D,ACTION:quarantine,TS:125
X-CID-META: VersionHash:3d8acc9,CLOUDID:04087cae-9535-44a6-aa9b-7f62b79b6ff6,C
	OID:9b7b11d3ea1c,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 784b02e7c29944c0bfc137fede4b0e99-20220811
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
	(envelope-from <tinghan.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
	with ESMTP id 243120275; Thu, 11 Aug 2022 10:58:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 11 Aug 2022 10:58:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 11 Aug 2022 10:58:15 +0800
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
Subject: [PATCH v6 06/20] dt-bindings: power: mediatek: Add bindings for MediaTek SCPSYS
Date: Thu, 11 Aug 2022 10:57:59 +0800
Message-ID: <20220811025813.21492-7-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220811025813.21492-1-tinghan.shen@mediatek.com>
References: <20220811025813.21492-1-tinghan.shen@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

The System Control Processor System (SCPSYS) has several power
management related tasks in the system. Add the bindings for it.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mfd/mediatek,mt8195-scpsys.yaml  | 67 +++++++++++++++++++
 .../power/mediatek,power-controller.yaml      |  2 +-
 2 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
new file mode 100644
index 0000000000000..3737207d85046
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek System Control Processor System
+
+maintainers:
+  - MandyJH Liu <mandyjh.liu@mediatek.com>
+
+description:
+  MediaTek System Control Processor System (SCPSYS) has several
+  power management tasks. The tasks include MTCMOS power
+  domain control, thermal measurement, DVFS, etc.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8167-scpsys
+          - mediatek,mt8173-scpsys
+          - mediatek,mt8183-scpsys
+          - mediatek,mt8192-scpsys
+          - mediatek,mt8195-scpsys
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  power-controller:
+    $ref: /schemas/power/mediatek,power-controller.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8195-clk.h>
+    #include <dt-bindings/power/mt8195-power.h>
+
+    syscon@10006000 {
+      compatible = "mediatek,mt8195-scpsys", "syscon", "simple-mfd";
+      reg = <0x10006000 0x100>;
+
+      spm: power-controller {
+        compatible = "mediatek,mt8195-power-controller";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #power-domain-cells = <1>;
+
+        /* sample of power domain nodes */
+        power-domain@MT8195_POWER_DOMAIN_PCIE_PHY {
+          reg = <MT8195_POWER_DOMAIN_PCIE_PHY>;
+          #power-domain-cells = <0>;
+        };
+
+        power-domain@MT8195_POWER_DOMAIN_SSUSB_PCIE_PHY {
+          reg = <MT8195_POWER_DOMAIN_SSUSB_PCIE_PHY>;
+          #power-domain-cells = <0>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 03b7f6aa591d4..605ec7ab5f633 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -135,7 +135,7 @@ examples:
         #size-cells = <2>;
 
         scpsys: syscon@10006000 {
-            compatible = "syscon", "simple-mfd";
+            compatible = "mediatek,mt8173-scpsys", "syscon", "simple-mfd";
             reg = <0 0x10006000 0 0x1000>;
 
             spm: power-controller {
-- 
2.18.0

