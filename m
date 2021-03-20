Return-Path: <SRS0=maFY=IS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C399C433E1
	for <iommu@archiver.kernel.org>; Sat, 20 Mar 2021 16:05:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D1061966
	for <iommu@archiver.kernel.org>; Sat, 20 Mar 2021 16:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D1061966
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F3428401DC;
	Sat, 20 Mar 2021 16:05:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T8sVYrVBkjIv; Sat, 20 Mar 2021 16:05:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 061F5401ED;
	Sat, 20 Mar 2021 16:05:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60B23C0018;
	Sat, 20 Mar 2021 16:05:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7B17C000B
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 15:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E2BCF6075D
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 15:29:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5bx_ySEBdNzU for <iommu@lists.linux-foundation.org>;
 Sat, 20 Mar 2021 15:29:51 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch
 [185.70.41.104])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D71D260605
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 15:29:50 +0000 (UTC)
Received: from mail-03.mail-europe.com (mail-03.mail-europe.com
 [91.134.188.129])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail-41104.protonmail.ch (Postfix) with ESMTPS id 4F2kwW4WRmz4xn8X
 for <iommu@lists.linux-foundation.org>; Sat, 20 Mar 2021 15:20:27 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev
 header.b="KeSAi5xx"
Date: Sat, 20 Mar 2021 15:20:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 s=protonmail3; t=1616253616;
 bh=GOagsrEw4SsLChHE8bqUY6XXHswLBJsU8M1xRpDR/Ds=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=KeSAi5xxj8JV35umMvuVdhLCnkXdNmc1FJg13DceRY9y+ke3LFGuKi940tD9QfctT
 9cz7qsJouqCq2S7gqnwS2yysEs145gQe7Visufh2rB5j1KEpKoJxuY9dE5cxXueRGZ
 mwE95gf7pZaGSAeRxFX8dF4/O76TDSxwm/US4tOevxHYeZwjJpGXIZNQCTMI1I5dW+
 Y6lUFwnyUnE5HzboyzKtYBXz+2V4UPOHmT4OnpMfANF5FosIDgQf2yshTj32Q0Wuoo
 93iccrC3DxKRvbNZQkhPX0MIplCxahVX/bvRusvQjYuaaheeQVZWtcb6lzTIOD5tER
 xovotgbJ8Bb3A==
To: iommu@lists.linux-foundation.org
Subject: [PATCH 2/3] dt-bindings: iommu: add DART iommu bindings
Message-ID: <20210320151903.60759-3-sven@svenpeter.dev>
In-Reply-To: <20210320151903.60759-1-sven@svenpeter.dev>
References: <20210320151903.60759-1-sven@svenpeter.dev>
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 20 Mar 2021 16:05:05 +0000
Cc: Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
 Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Sven Peter <sven@svenpeter.dev>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Stan Skowronek <stan@corellium.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Mark Kettenis <mark.kettenis@xs4all.nl>
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
From: Sven Peter via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sven Peter <sven@svenpeter.dev>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

DART (Device Address Resolution Table) is the iommu found on Apple
ARM SoCs such as the M1.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 .../bindings/iommu/apple,t8103-dart.yaml      | 82 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/apple,t8103-dart.yaml

diff --git a/Documentation/devicetree/bindings/iommu/apple,t8103-dart.yaml b/Documentation/devicetree/bindings/iommu/apple,t8103-dart.yaml
new file mode 100644
index 000000000000..2ec2d905a2ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/apple,t8103-dart.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/apple,t8103-dart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple DART IOMMU Implementation
+
+maintainers:
+  - Sven Peter <sven@svenpeter.dev>
+
+description: |+
+  Apple SoCs may contain an implementation of their Device Address
+  Resolution Table which provides a mandatory layer of address
+  translations for various masters external to the CPU.
+
+  Each DART instance is capable of handling up to 16 masters
+  mapped to up tp 16 different virtual address spaces with
+  page-level read/write access control flags.
+
+  This DART IOMMU also raises interrupts in response to various
+  fault conditions.
+
+properties:
+  compatible:
+    const: apple,t8103-dart
+
+  reg:
+    const: 1
+
+  interrupts:
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  '#iommu-cells':
+    const: 1
+    description:
+      The number of the master connected to this DART.
+
+required:
+  - compatible
+  - reg
+  - '#iommu-cells'
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |+
+    dart1: dart1@382f80000 {
+      compatible = "apple,t8103-dart";
+      reg = <0x3 0x82f80000 0x0 0x4000>;
+      interrupt-parent = <&aic>;
+      interrupts = <AIC_IRQ 781 IRQ_TYPE_LEVEL_HIGH>;
+      #iommu-cells = <1>;
+    };
+
+    master1 {
+      iommus = <&dart1 0>;
+    };
+
+  - |+
+    usb_dart0: usb_dart0@382f80000 {
+      compatible = "apple,t8103-dart";
+      reg = <0x3 0x82f80000 0x0 0x4000>;
+      interrupt-parent = <&aic>;
+      interrupts = <AIC_IRQ 781 IRQ_TYPE_LEVEL_HIGH>;
+      #iommu-cells = <1>;
+    };
+
+    usbdrd_dwc3_0: dwc3@382280000 {
+      compatible = "snps,dwc3";
+      reg = <0x3 0x82280000 0x0 0x100000>;
+      interrupt-parent = <&aic>;
+      interrupts = <AIC_IRQ 777 IRQ_TYPE_LEVEL_HIGH>;
+      iommus = <&usb_dart0 1>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      dr_mode = "peripheral";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index d5e4d93a536a..1f9a4f2de88b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1236,6 +1236,12 @@ L:	linux-input@vger.kernel.org
 S:	Odd fixes
 F:	drivers/input/mouse/bcm5974.c

+APPLE DART IOMMU DRIVER
+M:	Sven Peter <sven@svenpeter.dev>
+L:	iommu@lists.linux-foundation.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iommu/apple,t8103-dart.yaml
+
 APPLE SMC DRIVER
 M:	Henrik Rydberg <rydberg@bitmath.org>
 L:	linux-hwmon@vger.kernel.org
--
2.25.1


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
