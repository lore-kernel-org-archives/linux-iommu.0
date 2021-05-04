Return-Path: <SRS0=4008=J7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A42C43461
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 08:42:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52571611AE
	for <iommu@archiver.kernel.org>; Tue,  4 May 2021 08:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52571611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E88D640F89;
	Tue,  4 May 2021 08:42:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7cy3mT4PRiuU; Tue,  4 May 2021 08:41:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81E6A40F9A;
	Tue,  4 May 2021 08:41:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F12BC000E;
	Tue,  4 May 2021 08:41:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80D19C0001
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 08:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F5BB40563
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 08:41:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Siygiku1joZG for <iommu@lists.linux-foundation.org>;
 Tue,  4 May 2021 08:41:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 57DD840136
 for <iommu@lists.linux-foundation.org>; Tue,  4 May 2021 08:41:57 +0000 (UTC)
Received: from localhost.localdomain (unknown
 [IPv6:2a01:e0a:4cb:a870:3951:839d:24c0:e20d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: benjamin.gaignard)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 58BFA1F423F0;
 Tue,  4 May 2021 09:41:54 +0100 (BST)
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
To: joro@8bytes.org, will@kernel.org, robh+dt@kernel.org, heiko@sntech.de,
 xxm@rock-chips.com
Subject: [PATCH v3 1/4] dt-bindings: iommu: rockchip: Convert IOMMU to DT
 schema
Date: Tue,  4 May 2021 10:41:21 +0200
Message-Id: <20210504084124.131884-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504084124.131884-1-benjamin.gaignard@collabora.com>
References: <20210504084124.131884-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux-foundation.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org
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

Convert Rockchip IOMMU to DT schema

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 2:
 - Change maintainer
 - Change reg maxItems
 - Change interrupt maxItems

 .../bindings/iommu/rockchip,iommu.txt         | 38 ---------
 .../bindings/iommu/rockchip,iommu.yaml        | 79 +++++++++++++++++++
 2 files changed, 79 insertions(+), 38 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
deleted file mode 100644
index 6ecefea1c6f9..000000000000
--- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-Rockchip IOMMU
-==============
-
-A Rockchip DRM iommu translates io virtual addresses to physical addresses for
-its master device.  Each slave device is bound to a single master device, and
-shares its clocks, power domain and irq.
-
-Required properties:
-- compatible      : Should be "rockchip,iommu"
-- reg             : Address space for the configuration registers
-- interrupts      : Interrupt specifier for the IOMMU instance
-- interrupt-names : Interrupt name for the IOMMU instance
-- #iommu-cells    : Should be <0>.  This indicates the iommu is a
-                    "single-master" device, and needs no additional information
-                    to associate with its master device.  See:
-                    Documentation/devicetree/bindings/iommu/iommu.txt
-- clocks          : A list of clocks required for the IOMMU to be accessible by
-                    the host CPU.
-- clock-names     : Should contain the following:
-	"iface" - Main peripheral bus clock (PCLK/HCL) (required)
-	"aclk"  - AXI bus clock (required)
-
-Optional properties:
-- rockchip,disable-mmu-reset : Don't use the mmu reset operation.
-			       Some mmu instances may produce unexpected results
-			       when the reset operation is used.
-
-Example:
-
-	vopl_mmu: iommu@ff940300 {
-		compatible = "rockchip,iommu";
-		reg = <0xff940300 0x100>;
-		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "vopl_mmu";
-		clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
-		clock-names = "aclk", "iface";
-		#iommu-cells = <0>;
-	};
diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
new file mode 100644
index 000000000000..0db208cf724a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/rockchip,iommu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip IOMMU
+
+maintainers:
+  - Heiko Stuebner <heiko@sntech.de>
+
+description: |+
+  A Rockchip DRM iommu translates io virtual addresses to physical addresses for
+  its master device. Each slave device is bound to a single master device and
+  shares its clocks, power domain and irq.
+
+  For information on assigning IOMMU controller to its peripheral devices,
+  see generic IOMMU bindings.
+
+properties:
+  compatible:
+    const: rockchip,iommu
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    items:
+      - description: Core clock
+      - description: Interface clock
+
+  clock-names:
+    items:
+      - const: aclk
+      - const: iface
+
+  "#iommu-cells":
+    const: 0
+
+  rockchip,disable-mmu-reset:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Do not use the mmu reset operation.
+      Some mmu instances may produce unexpected results
+      when the reset operation is used.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - "#iommu-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3399-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    vopl_mmu: iommu@ff940300 {
+      compatible = "rockchip,iommu";
+      reg = <0xff940300 0x100>;
+      interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "vopl_mmu";
+      clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
+      clock-names = "aclk", "iface";
+      #iommu-cells = <0>;
+    };
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
