Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFB0C4741F
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 09:18:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C94F9207DE
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 09:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="TJo4HaEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94F9207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 365F286250;
	Fri, 30 Oct 2020 09:18:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k6NP4VCOJgZ5; Fri, 30 Oct 2020 09:18:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 051BB86237;
	Fri, 30 Oct 2020 09:18:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D21ABC088B;
	Fri, 30 Oct 2020 09:18:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98B31C0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 09:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 93A41868D6
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 09:18:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c44mj+0suNvY for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 09:18:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by whitealder.osuosl.org (Postfix) with ESMTP id CE377868D0
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 09:18:36 +0000 (UTC)
X-UUID: 3d0a318df38949c691fd42f554b25db8-20201030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=w7gy7SucjIOx9PSFlRyJ6C5ZEwoiSnoYyoOz+LDwkns=; 
 b=TJo4HaEWasxWcjgpKRgAOCwInSHIRVU5Fc1GCxpdyii50rdgqq2N2hLwI7jkDjxuGEtMmLfokK7m5ke+eOjdkQFcuw28YMCGtUht1kslDDmKKrHNUNIxBZilm3UXfKQU5sfKW9H8XM80nHpk3EykuQE4YV/WzKZv4CZhbpCVkUY=;
X-UUID: 3d0a318df38949c691fd42f554b25db8-20201030
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2
 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 321243066; Fri, 30 Oct 2020 17:13:24 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 30 Oct 2020 17:13:21 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Oct 2020 17:13:21 +0800
From: Yong Wu <yong.wu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 1/3] dt-bindings: memory: mediatek: Convert SMI to DT schema
Date: Fri, 30 Oct 2020 17:12:52 +0800
Message-ID: <20201030091254.26382-2-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201030091254.26382-1-yong.wu@mediatek.com>
References: <20201030091254.26382-1-yong.wu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Fabien Parent <fparent@baylibre.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

Convert MediaTek SMI to DT schema.

CC: Fabien Parent <fparent@baylibre.com>
CC: Ming-Fan Chen <ming-fan.chen@mediatek.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 .../mediatek,smi-common.txt                   |  50 -------
 .../mediatek,smi-common.yaml                  | 140 ++++++++++++++++++
 .../memory-controllers/mediatek,smi-larb.txt  |  50 -------
 .../memory-controllers/mediatek,smi-larb.yaml | 129 ++++++++++++++++
 4 files changed, 269 insertions(+), 100 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
 delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
deleted file mode 100644
index dbafffe3f41e..000000000000
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-SMI (Smart Multimedia Interface) Common
-
-The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
-
-Mediatek SMI have two generations of HW architecture, here is the list
-which generation the SoCs use:
-generation 1: mt2701 and mt7623.
-generation 2: mt2712, mt6779, mt8167, mt8173 and mt8183.
-
-There's slight differences between the two SMI, for generation 2, the
-register which control the iommu port is at each larb's register base. But
-for generation 1, the register is at smi ao base(smi always on register
-base). Besides that, the smi async clock should be prepared and enabled for
-SMI generation 1 to transform the smi clock into emi clock domain, but that is
-not needed for SMI generation 2.
-
-Required properties:
-- compatible : must be one of :
-	"mediatek,mt2701-smi-common"
-	"mediatek,mt2712-smi-common"
-	"mediatek,mt6779-smi-common"
-	"mediatek,mt7623-smi-common", "mediatek,mt2701-smi-common"
-	"mediatek,mt8167-smi-common"
-	"mediatek,mt8173-smi-common"
-	"mediatek,mt8183-smi-common"
-- reg : the register and size of the SMI block.
-- power-domains : a phandle to the power domain of this local arbiter.
-- clocks : Must contain an entry for each entry in clock-names.
-- clock-names : must contain 3 entries for generation 1 smi HW and 2 entries
-  for generation 2 smi HW as follows:
-  - "apb" : Advanced Peripheral Bus clock, It's the clock for setting
-	    the register.
-  - "smi" : It's the clock for transfer data and command.
-	    They may be the same if both source clocks are the same.
-  - "async" : asynchronous clock, it help transform the smi clock into the emi
-	      clock domain, this clock is only needed by generation 1 smi HW.
-  and these 2 option clocks for generation 2 smi HW:
-  - "gals0": the path0 clock of GALS(Global Async Local Sync).
-  - "gals1": the path1 clock of GALS(Global Async Local Sync).
-  Here is the list which has this GALS: mt6779 and mt8183.
-
-Example:
-	smi_common: smi@14022000 {
-		compatible = "mediatek,mt8173-smi-common";
-		reg = <0 0x14022000 0 0x1000>;
-		power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
-		clocks = <&mmsys CLK_MM_SMI_COMMON>,
-			 <&mmsys CLK_MM_SMI_COMMON>;
-		clock-names = "apb", "smi";
-	};
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
new file mode 100644
index 000000000000..e050a0c2aed6
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
@@ -0,0 +1,140 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2020 MediaTek Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/mediatek,smi-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SMI (Smart Multimedia Interface) Common
+
+maintainers:
+  - Yong Wu <yong.wu@mediatek.com>
+
+description: |+
+  The hardware block diagram please check bindings/iommu/mediatek,iommu.yaml
+
+  MediaTek SMI have two generations of HW architecture, here is the list
+  which generation the SoCs use:
+  generation 1: mt2701 and mt7623.
+  generation 2: mt2712, mt6779, mt8167, mt8173 and mt8183.
+
+  There's slight differences between the two SMI, for generation 2, the
+  register which control the iommu port is at each larb's register base. But
+  for generation 1, the register is at smi ao base(smi always on register
+  base). Besides that, the smi async clock should be prepared and enabled for
+  SMI generation 1 to transform the smi clock into emi clock domain, but that is
+  not needed for SMI generation 2.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - mediatek,mt2701-smi-common
+          - mediatek,mt2712-smi-common
+          - mediatek,mt6779-smi-common
+          - mediatek,mt8167-smi-common
+          - mediatek,mt8173-smi-common
+          - mediatek,mt8183-smi-common
+
+      - description: for mt7623
+        items:
+          - const: mediatek,mt7623-smi-common
+          - const: mediatek,mt2701-smi-common
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  clocks:
+    description: |
+      apb and smi are mandatory. the async is only for generation 1 smi HW.
+      gals(global async local sync) also is optional, see below.
+    minItems: 2
+    maxItems: 4
+    items:
+      - description: apb is Advanced Peripheral Bus clock, It's the clock for
+          setting the register.
+      - description: smi is the clock for transfer data and command.
+      - description: async is asynchronous clock, it help transform the smi clock
+          into the emi clock domain.
+      - description: gals0 is the path0 clock of gals.
+      - description: gals1 is the path1 clock of gals.
+
+  clock-names:
+    minItems: 2
+    maxItems: 4
+
+required:
+  - compatible
+  - reg
+  - power-domains
+  - clocks
+  - clock-names
+
+allOf:
+  - if: #only for gen1 HW
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt2701-smi-common
+    then:
+       properties:
+         clock:
+           items:
+             minItems: 3
+             maxItems: 3
+         clock-names:
+           items:
+             - const: apb
+             - const: smi
+             - const: async
+
+  - if: #for gen2 HW that have gals
+      properties:
+        compatible:
+            enum:
+              - mediatek,mt6779-smi-common
+              - mediatek,mt8183-smi-common
+
+    then:
+      properties:
+        clock:
+          items:
+            minItems: 4
+            maxItems: 4
+        clock-names:
+          items:
+            - const: apb
+            - const: smi
+            - const: gals0
+            - const: gals1
+
+    else: #for gen2 HW that don't have gals
+      properties:
+        clock:
+          items:
+            minItems: 2
+            maxItems: 2
+        clock-names:
+          items:
+            - const: apb
+            - const: smi
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8173-clk.h>
+    #include <dt-bindings/power/mt8173-power.h>
+
+    smi_common: smi@14022000 {
+            compatible = "mediatek,mt8173-smi-common";
+            reg = <0x14022000 0x1000>;
+            power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+            clocks = <&mmsys CLK_MM_SMI_COMMON>,
+                     <&mmsys CLK_MM_SMI_COMMON>;
+            clock-names = "apb", "smi";
+    };
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
deleted file mode 100644
index 0c5de12b5496..000000000000
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-SMI (Smart Multimedia Interface) Local Arbiter
-
-The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
-
-Required properties:
-- compatible : must be one of :
-		"mediatek,mt2701-smi-larb"
-		"mediatek,mt2712-smi-larb"
-		"mediatek,mt6779-smi-larb"
-		"mediatek,mt7623-smi-larb", "mediatek,mt2701-smi-larb"
-		"mediatek,mt8167-smi-larb"
-		"mediatek,mt8173-smi-larb"
-		"mediatek,mt8183-smi-larb"
-- reg : the register and size of this local arbiter.
-- mediatek,smi : a phandle to the smi_common node.
-- power-domains : a phandle to the power domain of this local arbiter.
-- clocks : Must contain an entry for each entry in clock-names.
-- clock-names: must contain 2 entries, as follows:
-  - "apb" : Advanced Peripheral Bus clock, It's the clock for setting
-	    the register.
-  - "smi" : It's the clock for transfer data and command.
-  and this optional clock name:
-  - "gals": the clock for GALS(Global Async Local Sync).
-  Here is the list which has this GALS: mt8183.
-
-Required property for mt2701, mt2712, mt6779, mt7623 and mt8167:
-- mediatek,larb-id :the hardware id of this larb.
-
-Example:
-	larb1: larb@16010000 {
-		compatible = "mediatek,mt8173-smi-larb";
-		reg = <0 0x16010000 0 0x1000>;
-		mediatek,smi = <&smi_common>;
-		power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
-		clocks = <&vdecsys CLK_VDEC_CKEN>,
-			 <&vdecsys CLK_VDEC_LARB_CKEN>;
-		clock-names = "apb", "smi";
-	};
-
-Example for mt2701:
-	larb0: larb@14010000 {
-		compatible = "mediatek,mt2701-smi-larb";
-		reg = <0 0x14010000 0 0x1000>;
-		mediatek,smi = <&smi_common>;
-		mediatek,larb-id = <0>;
-		clocks = <&mmsys CLK_MM_SMI_LARB0>,
-			 <&mmsys CLK_MM_SMI_LARB0>;
-		clock-names = "apb", "smi";
-		power-domains = <&scpsys MT2701_POWER_DOMAIN_DISP>;
-	};
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
new file mode 100644
index 000000000000..a11a105e872f
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2020 MediaTek Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/mediatek,smi-larb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SMI (Smart Multimedia Interface) Local Arbiter
+
+maintainers:
+  - Yong Wu <yong.wu@mediatek.com>
+
+description: |+
+  The hardware block diagram please check bindings/iommu/mediatek,iommu.yaml
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - mediatek,mt2701-smi-larb
+          - mediatek,mt2712-smi-larb
+          - mediatek,mt6779-smi-larb
+          - mediatek,mt8167-smi-larb
+          - mediatek,mt8173-smi-larb
+          - mediatek,mt8183-smi-larb
+
+      - description: for mt7623
+        items:
+          - const: mediatek,mt7623-smi-larb
+          - const: mediatek,mt2701-smi-larb
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: |
+      apb and smi are mandatory. gals(global async local sync) is optional.
+    minItems: 2
+    maxItems: 3
+    items:
+       - description: apb is Advanced Peripheral Bus clock, It's the clock for
+           setting the register.
+       - description: smi is the clock for transfer data and command.
+       - description: the clock for gals.
+
+  clock-names:
+    minItems: 2
+    maxItems: 3
+
+  power-domains:
+    maxItems: 1
+
+  mediatek,smi:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: a phandle to the smi_common node.
+
+  mediatek,larb-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 31
+    description: the hardware id of this larb.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - power-domains
+
+allOf:
+  - if: # HW has gals
+      properties:
+        compatible:
+          enum:
+            - mediatek,mt8183-smi-larb
+
+    then:
+      properties:
+        clock:
+          items:
+            minItems: 3
+            maxItems: 3
+        clock-names:
+          items:
+            - const: apb
+            - const: smi
+            - const: gals
+
+    else:
+      properties:
+        clock:
+          items:
+            minItems: 2
+            maxItems: 2
+        clock-names:
+          items:
+            - const: apb
+            - const: smi
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt2701-smi-larb
+              - mediatek,mt2712-smi-larb
+              - mediatek,mt6779-smi-larb
+              - mediatek,mt8167-smi-larb
+
+    then:
+      required:
+        - mediatek,larb-id
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8173-clk.h>
+    #include <dt-bindings/power/mt8173-power.h>
+
+    larb1: larb@16010000 {
+      compatible = "mediatek,mt8173-smi-larb";
+      reg = <0x16010000 0x1000>;
+      mediatek,smi = <&smi_common>;
+      power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
+      clocks = <&vdecsys CLK_VDEC_CKEN>,
+               <&vdecsys CLK_VDEC_LARB_CKEN>;
+      clock-names = "apb", "smi";
+    };
-- 
2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
