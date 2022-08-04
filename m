Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3561B635
	for <iommu@lists.linux.dev>; Thu,  4 Aug 2022 02:16:03 +0000 (UTC)
X-UUID: f43a4d9cd53f419882eceb99d85043e8-20220804
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VPSE6LwfZKJSU76x6Go4zXpriX5YsP3PfReQI8hw8b0=;
	b=nL9YRI3y2cKOVKTwUDC4KnDWoo4DPno+k/G9UaHXxFkyqfgPljJcx59pxfsxp/n+39bScaUl5cnM4CRg1HoDYOQiZQWoOzTa82tMip14EZAUsXJZ1CtWEicevyoDqe9Mp6JyvhiNLfT4C2Dp5qZraSjvmn+VnPMyPAQ9MLBhlyk=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.8,REQID:3cdfd3d5-e0f9-45ec-b66d-4b462256e99e,OB:0,LO
	B:10,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS6885AD
	,ACTION:quarantine,TS:120
X-CID-INFO: VERSION:1.1.8,REQID:3cdfd3d5-e0f9-45ec-b66d-4b462256e99e,OB:0,LOB:
	10,IP:0,URL:25,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
	CTION:quarantine,TS:120
X-CID-META: VersionHash:0f94e32,CLOUDID:1b653525-a982-4824-82d2-9da3b6056c2a,C
	OID:b1b8cfa02809,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: f43a4d9cd53f419882eceb99d85043e8-20220804
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <tinghan.shen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1004579850; Thu, 04 Aug 2022 10:15:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 4 Aug 2022 10:15:56 +0800
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
Subject: [PATCH v5 06/20] dt-bindings: power: mediatek: Add bindings for MediaTek SCPSYS
Date: Thu, 4 Aug 2022 10:15:39 +0800
Message-ID: <20220804021553.14867-7-tinghan.shen@mediatek.com>
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

The System Control Processor System (SCPSYS) has several power
management related tasks in the system. Add the bindings for it.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/mfd/mediatek,mt8195-scpsys.yaml  | 67 +++++++++++++++++++
 .../power/mediatek,power-controller.yaml      |  2 +-
 2 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644
 Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml

diff --git
 a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
 b/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
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
diff --git
 a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
 b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
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

