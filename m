Return-Path: <SRS0=U628=6F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670B0C2BA19
	for <iommu@archiver.kernel.org>; Tue, 21 Apr 2020 05:16:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3688F2076C
	for <iommu@archiver.kernel.org>; Tue, 21 Apr 2020 05:16:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3688F2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D01F78830F;
	Tue, 21 Apr 2020 05:16:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id krSoWyuPrHVQ; Tue, 21 Apr 2020 05:16:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B01D187E79;
	Tue, 21 Apr 2020 05:16:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AC2EC1D85;
	Tue, 21 Apr 2020 05:16:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65D4CC0175
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 05:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4E0178697C
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 05:15:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ICCrUJbdsH0d for <iommu@lists.linux-foundation.org>;
 Tue, 21 Apr 2020 05:15:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6924986966
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 05:15:56 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.72,409,1580742000"; d="scan'208";a="45276363"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 21 Apr 2020 14:15:54 +0900
Received: from localhost.localdomain (unknown [10.166.252.89])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 59E0E40078AC;
 Tue, 21 Apr 2020 14:15:54 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: joro@8bytes.org,
	robh+dt@kernel.org
Subject: [PATCH v5] dt-bindings: iommu: renesas,
 ipmmu-vmsa: convert to json-schema
Date: Tue, 21 Apr 2020 14:15:52 +0900
Message-Id: <1587446152-23886-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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

Note that original documentation doesn't mention renesas,ipmmu-vmsa
for R-Mobile APE6. But, R-Mobile APE6 is similar to the R-Car
Gen2. So, renesas,ipmmu-r8a73a4 belongs the renesas,ipmmu-vmsa
section.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Changes from v4:
 - Fix description about cell counts on #iommu-cells and renesas,ipmmu-main.
 - Fix node name on the example. 
 https://patchwork.kernel.org/patch/11494231/

 Changes from v3:
 - Fix renesas,ipmmu-r8a7795's section
 https://patchwork.kernel.org/patch/11494079/

 Changes from v2:
 - Add a description for R-Mobile APE6 on the commit log.
 - Change renesas,ipmmu-r8a73a4 section on the compatible.
 - Add items on the interrupts.
 - Add power-domains to required.
 - Add oneOf for interrupts and renesas,ipmmu-main
 https://patchwork.kernel.org/patch/11490581/

 Changes from v1:
 - Fix typo in the subject.
 - Add a description on #iommu-cells.
 https://patchwork.kernel.org/patch/11485415/

 .../bindings/iommu/renesas,ipmmu-vmsa.txt          | 73 ----------------
 .../bindings/iommu/renesas,ipmmu-vmsa.yaml         | 98 ++++++++++++++++++++++
 2 files changed, 98 insertions(+), 73 deletions(-)
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
index 00000000..39675cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
@@ -0,0 +1,98 @@
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
+              - renesas,ipmmu-r8a73a4  # R-Mobile APE6
+              - renesas,ipmmu-r8a7743  # RZ/G1M
+              - renesas,ipmmu-r8a7744  # RZ/G1N
+              - renesas,ipmmu-r8a7745  # RZ/G1E
+              - renesas,ipmmu-r8a7790  # R-Car H2
+              - renesas,ipmmu-r8a7791  # R-Car M2-W
+              - renesas,ipmmu-r8a7793  # R-Car M2-N
+              - renesas,ipmmu-r8a7794  # R-Car E2
+          - const: renesas,ipmmu-vmsa  # R-Mobile APE6 or R-Car Gen2 or RZ/G1
+      - items:
+          - enum:
+              - renesas,ipmmu-r8a774a1 # RZ/G2M
+              - renesas,ipmmu-r8a774b1 # RZ/G2N
+              - renesas,ipmmu-r8a774c0 # RZ/G2E
+              - renesas,ipmmu-r8a7795  # R-Car H3
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
+      Specifiers for the MMU fault interrupts. Not required for cache IPMMUs.
+    items:
+      - description: non-secure mode
+      - description: secure mode if supported
+
+  '#iommu-cells':
+    const: 1
+    description:
+      The number of the micro-TLB that the device is connected to.
+
+  power-domains:
+    maxItems: 1
+
+  renesas,ipmmu-main:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Reference to the main IPMMU phandle plus 1 cell. The cell is
+      the interrupt bit number associated with the particular cache IPMMU
+      device. The interrupt bit number needs to match the main IPMMU IMSSTR
+      register. Only used by cache IPMMU instances.
+
+required:
+  - compatible
+  - reg
+  - '#iommu-cells'
+  - power-domains
+
+oneOf:
+  - required:
+      - interrupts
+  - required:
+      - renesas,ipmmu-main
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a7791-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/r8a7791-sysc.h>
+
+    ipmmu_mx: iommu@fe951000 {
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
