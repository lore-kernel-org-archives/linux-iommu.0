Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A274FC433EF
	for <iommu@archiver.kernel.org>; Sat, 25 Dec 2021 19:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 19497409AC;
	Sat, 25 Dec 2021 19:36:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xqkPsMKx_xsU; Sat, 25 Dec 2021 19:36:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3BD04402B7;
	Sat, 25 Dec 2021 19:36:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D82AC002F;
	Sat, 25 Dec 2021 19:36:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 947B6C0012
 for <iommu@lists.linux-foundation.org>; Sat, 25 Dec 2021 19:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 69BC740922
 for <iommu@lists.linux-foundation.org>; Sat, 25 Dec 2021 19:36:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id igdyEYyBLZ3A for <iommu@lists.linux-foundation.org>;
 Sat, 25 Dec 2021 19:36:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ixit.cz (ixit.cz [94.230.151.217])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F354D402B7
 for <iommu@lists.linux-foundation.org>; Sat, 25 Dec 2021 19:36:03 +0000 (UTC)
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz
 [89.176.96.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ixit.cz (Postfix) with ESMTPSA id BEFF62243C;
 Sat, 25 Dec 2021 20:35:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
 t=1640460958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=we33I2lFt1104ro/jr1vXl0TNl00Kzt/KcJ9jQrLBcU=;
 b=niTTxBekArUg0HTB5XTNoOds1fJl3vvLC8ZXXIbYCpZzH3V2ZRU/neFoOy2zRgZDGRRCiz
 wwWOkMJd3Z9DvR5I9rbInwWc9PosFmAxdSIzcHsfRNjQWuwPJETIraKxa/G9pxaTmPUjkD
 1Buu+kB/FNYBQdK+jIlv8SdTxsm0mjc=
From: David Heidelberg <david@ixit.cz>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH v2] dt-bindings: iommu: Convert msm,iommu-v0 to yaml
Date: Sat, 25 Dec 2021 20:35:55 +0100
Message-Id: <20211225193556.66804-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Spam: Yes
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>,
 iommu@lists.linux-foundation.org, ~okias/devicetree@lists.sr.ht
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

Convert Qualcomm IOMMU v0 implementation to yaml format.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
v2:
 - fix wrong path in binding $id
 - comment qcom,mdp4 node example (we don't want to validate it yet)

 .../bindings/iommu/msm,iommu-v0.txt           | 64 -------------
  .../bindings/iommu/qcom,iommu-v0.yaml         | 96 +++++++++++++++++++
 2 files changed, 96 insertions(+), 64 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml

diff --git a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
deleted file mode 100644
index 20236385f26e..000000000000
--- a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
+++ /dev/null
@@ -1,64 +0,0 @@
-* QCOM IOMMU
-
-The MSM IOMMU is an implementation compatible with the ARM VMSA short
-descriptor page tables. It provides address translation for bus masters outside
-of the CPU, each connected to the IOMMU through a port called micro-TLB.
-
-Required Properties:
-
-  - compatible: Must contain "qcom,apq8064-iommu".
-  - reg: Base address and size of the IOMMU registers.
-  - interrupts: Specifiers for the MMU fault interrupts. For instances that
-    support secure mode two interrupts must be specified, for non-secure and
-    secure mode, in that order. For instances that don't support secure mode a
-    single interrupt must be specified.
-  - #iommu-cells: The number of cells needed to specify the stream id. This
-		  is always 1.
-  - qcom,ncb:	  The total number of context banks in the IOMMU.
-  - clocks	: List of clocks to be used during SMMU register access. See
-		  Documentation/devicetree/bindings/clock/clock-bindings.txt
-		  for information about the format. For each clock specified
-		  here, there must be a corresponding entry in clock-names
-		  (see below).
-
-  - clock-names	: List of clock names corresponding to the clocks specified in
-		  the "clocks" property (above).
-		  Should be "smmu_pclk" for specifying the interface clock
-		  required for iommu's register accesses.
-		  Should be "smmu_clk" for specifying the functional clock
-		  required by iommu for bus accesses.
-
-Each bus master connected to an IOMMU must reference the IOMMU in its device
-node with the following property:
-
-  - iommus: A reference to the IOMMU in multiple cells. The first cell is a
-	    phandle to the IOMMU and the second cell is the stream id.
-	    A single master device can be connected to more than one iommu
-	    and multiple contexts in each of the iommu. So multiple entries
-	    are required to list all the iommus and the stream ids that the
-	    master is connected to.
-
-Example: mdp iommu and its bus master
-
-                mdp_port0: iommu@7500000 {
-			compatible = "qcom,apq8064-iommu";
-			#iommu-cells = <1>;
-			clock-names =
-			    "smmu_pclk",
-			    "smmu_clk";
-			clocks =
-			    <&mmcc SMMU_AHB_CLK>,
-			    <&mmcc MDP_AXI_CLK>;
-			reg = <0x07500000 0x100000>;
-			interrupts =
-			    <GIC_SPI 63 0>,
-			    <GIC_SPI 64 0>;
-			qcom,ncb = <2>;
-		};
-
-		mdp: qcom,mdp@5100000 {
-			compatible = "qcom,mdp";
-			...
-			iommus = <&mdp_port0 0
-				  &mdp_port0 2>;
-		};
diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml
new file mode 100644
index 000000000000..6f166c30b9ec
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: "http://devicetree.org/schemas/iommu/qcom,iommu-v0.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm IOMMU for APQ8064
+
+maintainers:
+  - Will Deacon <will@kernel.org>
+
+description: >
+  The MSM IOMMU is an implementation compatible with the ARM VMSA short
+  descriptor page tables. It provides address translation for bus masters
+  outside of the CPU, each connected to the IOMMU through a port called micro-TLB.
+
+properties:
+  compatible:
+    const: qcom,apq8064-iommu
+
+  clocks:
+    items:
+      - description: interface clock for register accesses
+      - description: functional clock for bus accesses
+
+  clock-names:
+    oneOf:
+      - items:
+          - const: smmu_pclk
+          - const: smmu_clk
+      - items:
+          - const: smmu_pclk
+          - const: iommu_clk
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: >
+      Specifiers for the MMU fault interrupts. For instances that
+      support secure mode two interrupts must be specified, for non-secure and
+      secure mode, in that order. For instances that don't support secure mode a
+      single interrupt must be specified.
+
+  "#iommu-cells":
+    const: 1
+
+  qcom,ncb:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: The total number of context banks in the IOMMU.
+
+# Each bus master connected to an IOMMU must reference the IOMMU
+# in its device node with the following property:
+#   A reference to the IOMMU in multiple cells. The first cell is a
+#   phandle to the IOMMU and the second cell is the stream id.
+#   A single master device can be connected to more than one iommu
+#   and multiple contexts in each of the iommu. So multiple entries
+#   are required to list all the iommus and the stream ids that the
+#   master is connected to.
+
+required:
+  - clocks
+  - clock-names
+  - reg
+  - interrupts
+  - qcom,ncb
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
+
+    mdp_port0: iommu@7500000 {
+            compatible = "qcom,apq8064-iommu";
+            #iommu-cells = <1>;
+            clock-names =
+                "smmu_pclk",
+                "smmu_clk";
+            clocks =
+                <&clk SMMU_AHB_CLK>,
+                <&clk MDP_AXI_CLK>;
+            reg = <0x07500000 0x100000>;
+            interrupts =
+                <0 63 0>,
+                <0 64 0>;
+            qcom,ncb = <2>;
+    };
+
+    /* mdp: mdp@5100000 {
+            compatible = "qcom,mdp4";
+            ...
+
+            iommus = <&mdp_port0 0
+                      &mdp_port0 2>;
+    };*/
-- 
2.34.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
