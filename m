Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E71C2BB85
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 09:02:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71122206E9
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 09:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71122206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 253552040F;
	Wed, 15 Apr 2020 09:02:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3c7Cv7-ZvuZB; Wed, 15 Apr 2020 09:02:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 109B720358;
	Wed, 15 Apr 2020 09:02:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD069C1AE2;
	Wed, 15 Apr 2020 09:02:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C05FC0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 09:02:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3217B85D3F
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 09:02:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RB6ap-Op7gJR for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 09:02:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6D3BE85BEC
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 09:02:26 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.72,386,1580742000"; d="scan'208";a="44568584"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 15 Apr 2020 18:02:24 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 967D14009BF5;
 Wed, 15 Apr 2020 18:02:24 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: joro@8bytes.org,
	robh+dt@kernel.org
Subject: [PATCH v2] dt-bindings: iommu: renesas,
 ipmmu-vmsa: convert to json-schema
Date: Wed, 15 Apr 2020 18:02:17 +0900
Message-Id: <1586941337-20842-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Convert Renesas VMSA-Compatible IOMMU bindings documentation
to json-schema.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Changes from v1:
 - Fix typo in the subject.
 - Add a description on #iommu-cells.
 https://patchwork.kernel.org/patch/11485415/

 .../bindings/iommu/renesas,ipmmu-vmsa.txt          | 73 -----------------
 .../bindings/iommu/renesas,ipmmu-vmsa.yaml         | 94 ++++++++++++++++++++++
 2 files changed, 94 insertions(+), 73 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml

diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
deleted file mode 100644
index 020d6f2..00000000
--- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
+++ /dev/null
@@ -1,73 +0,0 @@
-* Renesas VMSA-Compatible IOMMU
-
-The IPMMU is an IOMMU implementation compatible with the ARM VMSA page tables.
-It provides address translation for bus masters outside of the CPU, each
-connected to the IPMMU through a port called micro-TLB.
-
-
-Required Properties:
-
-  - compatible: Must contain SoC-specific and generic entry below in case
-    the device is compatible with the R-Car Gen2 VMSA-compatible IPMMU.
-
-    - "renesas,ipmmu-r8a73a4" for the R8A73A4 (R-Mobile APE6) IPMMU.
-    - "renesas,ipmmu-r8a7743" for the R8A7743 (RZ/G1M) IPMMU.
-    - "renesas,ipmmu-r8a7744" for the R8A7744 (RZ/G1N) IPMMU.
-    - "renesas,ipmmu-r8a7745" for the R8A7745 (RZ/G1E) IPMMU.
-    - "renesas,ipmmu-r8a774a1" for the R8A774A1 (RZ/G2M) IPMMU.
-    - "renesas,ipmmu-r8a774b1" for the R8A774B1 (RZ/G2N) IPMMU.
-    - "renesas,ipmmu-r8a774c0" for the R8A774C0 (RZ/G2E) IPMMU.
-    - "renesas,ipmmu-r8a7790" for the R8A7790 (R-Car H2) IPMMU.
-    - "renesas,ipmmu-r8a7791" for the R8A7791 (R-Car M2-W) IPMMU.
-    - "renesas,ipmmu-r8a7793" for the R8A7793 (R-Car M2-N) IPMMU.
-    - "renesas,ipmmu-r8a7794" for the R8A7794 (R-Car E2) IPMMU.
-    - "renesas,ipmmu-r8a7795" for the R8A7795 (R-Car H3) IPMMU.
-    - "renesas,ipmmu-r8a7796" for the R8A7796 (R-Car M3-W) IPMMU.
-    - "renesas,ipmmu-r8a77965" for the R8A77965 (R-Car M3-N) IPMMU.
-    - "renesas,ipmmu-r8a77970" for the R8A77970 (R-Car V3M) IPMMU.
-    - "renesas,ipmmu-r8a77980" for the R8A77980 (R-Car V3H) IPMMU.
-    - "renesas,ipmmu-r8a77990" for the R8A77990 (R-Car E3) IPMMU.
-    - "renesas,ipmmu-r8a77995" for the R8A77995 (R-Car D3) IPMMU.
-    - "renesas,ipmmu-vmsa" for generic R-Car Gen2 or RZ/G1 VMSA-compatible
-			   IPMMU.
-
-  - reg: Base address and size of the IPMMU registers.
-  - interrupts: Specifiers for the MMU fault interrupts. For instances that
-    support secure mode two interrupts must be specified, for non-secure and
-    secure mode, in that order. For instances that don't support secure mode a
-    single interrupt must be specified. Not required for cache IPMMUs.
-
-  - #iommu-cells: Must be 1.
-
-Optional properties:
-
-  - renesas,ipmmu-main: reference to the main IPMMU instance in two cells.
-    The first cell is a phandle to the main IPMMU and the second cell is
-    the interrupt bit number associated with the particular cache IPMMU device.
-    The interrupt bit number needs to match the main IPMMU IMSSTR register.
-    Only used by cache IPMMU instances.
-
-
-Each bus master connected to an IPMMU must reference the IPMMU in its device
-node with the following property:
-
-  - iommus: A reference to the IPMMU in two cells. The first cell is a phandle
-    to the IPMMU and the second cell the number of the micro-TLB that the
-    device is connected to.
-
-
-Example: R8A7791 IPMMU-MX and VSP1-D0 bus master
-
-	ipmmu_mx: mmu@fe951000 {
-		compatible = "renasas,ipmmu-r8a7791", "renasas,ipmmu-vmsa";
-		reg = <0 0xfe951000 0 0x1000>;
-		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 221 IRQ_TYPE_LEVEL_HIGH>;
-		#iommu-cells = <1>;
-	};
-
-	vsp@fe928000 {
-		...
-		iommus = <&ipmmu_mx 13>;
-		...
-	};
diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
new file mode 100644
index 00000000..2c69f1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/renesas,ipmmu-vmsa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas VMSA-Compatible IOMMU
+
+maintainers:
+  - Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
+
+description:
+  The IPMMU is an IOMMU implementation compatible with the ARM VMSA page tables.
+  It provides address translation for bus masters outside of the CPU, each
+  connected to the IPMMU through a port called micro-TLB.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - renesas,ipmmu-r8a7743  # RZ/G1M
+              - renesas,ipmmu-r8a7744  # RZ/G1N
+              - renesas,ipmmu-r8a7745  # RZ/G1E
+              - renesas,ipmmu-r8a7790  # R-Car H2
+              - renesas,ipmmu-r8a7791  # R-Car M2-W
+              - renesas,ipmmu-r8a7793  # R-Car M2-N
+              - renesas,ipmmu-r8a7794  # R-Car E2
+              - renesas,ipmmu-r8a7795  # R-Car H3
+          - const: renesas,ipmmu-vmsa  # R-Car Gen2 or RZ/G1
+      - items:
+          - enum:
+              - renesas,ipmmu-r8a73a4  # R-Mobile APE6
+              - renesas,ipmmu-r8a774a1 # RZ/G2M
+              - renesas,ipmmu-r8a774b1 # RZ/G2N
+              - renesas,ipmmu-r8a774c0 # RZ/G2E
+              - renesas,ipmmu-r8a7796  # R-Car M3-W
+              - renesas,ipmmu-r8a77965 # R-Car M3-N
+              - renesas,ipmmu-r8a77970 # R-Car V3M
+              - renesas,ipmmu-r8a77980 # R-Car V3H
+              - renesas,ipmmu-r8a77990 # R-Car E3
+              - renesas,ipmmu-r8a77995 # R-Car D3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+    description:
+      Specifiers for the MMU fault interrupts. For instances that support
+      secure mode two interrupts must be specified, for non-secure and secure
+      mode, in that order. For instances that don't support secure mode a
+      single interrupt must be specified. Not required for cache IPMMUs.
+
+  '#iommu-cells':
+    const: 1
+    description:
+      A reference to the IPMMU in two cells. The first cell is a phandle
+      to the IPMMU and the second cell the number of the micro-TLB that the
+      device is connected to.
+
+  power-domains:
+    maxItems: 1
+
+  renesas,ipmmu-main:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Reference to the main IPMMU instance in two cells. The first cell is
+      a phandle to the main IPMMU and the second cell is the interrupt bit
+      number associated with the particular cache IPMMU device. The interrupt
+      bit number needs to match the main IPMMU IMSSTR register. Only used by
+      cache IPMMU instances.
+
+required:
+  - compatible
+  - reg
+  - '#iommu-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a7791-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/r8a7791-sysc.h>
+
+    ipmmu_mx: mmu@fe951000 {
+        compatible = "renasas,ipmmu-r8a7791", "renasas,ipmmu-vmsa";
+        reg = <0xfe951000 0x1000>;
+        interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+        #iommu-cells = <1>;
+    };
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
