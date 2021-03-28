Return-Path: <SRS0=8IIh=I2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_RED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434DAC433DB
	for <iommu@archiver.kernel.org>; Sun, 28 Mar 2021 07:41:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD216196D
	for <iommu@archiver.kernel.org>; Sun, 28 Mar 2021 07:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD216196D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0FF083D34;
	Sun, 28 Mar 2021 07:41:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q8f93kUIDPdi; Sun, 28 Mar 2021 07:41:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7648683D2B;
	Sun, 28 Mar 2021 07:41:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C0A2C0014;
	Sun, 28 Mar 2021 07:41:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AA92C000A
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 07:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A7E783D17
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 07:41:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xe079WNIRai2 for <iommu@lists.linux-foundation.org>;
 Sun, 28 Mar 2021 07:41:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A3F383B67
 for <iommu@lists.linux-foundation.org>; Sun, 28 Mar 2021 07:40:43 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 73EFF580836;
 Sun, 28 Mar 2021 03:40:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sun, 28 Mar 2021 03:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=j4WtA/c99G3MW
 B2xtKbwx07LS76G+wGQ7cjL4klOJIc=; b=xrYi3SfvW8aBnh9hh/PojnH7f5ET7
 PYua1UQ5hZUr/xP6I2ntLUHRvGl2BD6d3KBYId4Mj8QBcJJDyrOc6CeSVvRAO6Zh
 34e+oyHSg40Br8u17I/qlohjprXZ9UZG7sZNmbhj3ltVqd1Ks1+LvJCiMDfuuJdQ
 7Y5iO8fJPzLk3X6FnQTiBUxnZ1p80xrUbynmMoBe9OCPYwK9MMyrsE94rb6a+dTj
 6wIXZtIcdak2e+TyMat7JFrL/87pwjVZuqfxfKm6B6m8Rjk3KMcowu0KWBdGGVSz
 /y+IK6G8HTfvan0gtYRHcqzxqzoxnHtjDJbDsEuYhuMooF2BwP7SmuHSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=j4WtA/c99G3MWB2xtKbwx07LS76G+wGQ7cjL4klOJIc=; b=OMYAYvBr
 oUItYXlkSL4/itO01lmVEhWwQ+Rr80AAkqwRR3GnVwHamShAf5sRwJszig+SvRP+
 ZoUpMrJrmjuA036Dd4H/xZ0uXz2JfE+lgahkTHdz7qLEg0TRcLrWrNX4iUeyOvSl
 0AcA4mWkX2UOostSZ7VILS0Ft0N4a54kn7FEOe/gEY1bMOvTzWNI0L/FyD/DJVhl
 bossRSoou8s6vlGVcazMXfc2o/F+K0ZxcnTxRcbHRscuSYDeGBlrEhPck2V4dD0k
 29Sfx3r2muEl/MA6oI6YS7HtcAhU/d10Dy2kIR3yench0viSBg+qtqX7lwhxrTh/
 YJn1tssWpy+qxg==
X-ME-Sender: <xms:-TJgYKxIK7g7wbpEJa-mSzR3QkhboDVaPyGmE50FXVo9W6Bu6S5EnA>
 <xme:-TJgYGSVPrxro6tUItWfHm6uyUXMeQW6657seAlIq7hKtztES4oOSsDnhsJmJZxqk
 b9qaCmD0KYK1B4VWh8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehhedguddutdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghn
 ucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtth
 gvrhhnpefhfeffjedvkeeliedtffeihffhffevffeijeetfeehuddtgffffedtjeehtdet
 heenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppedujeeirddule
 elrddvuddtrdduheeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
 lhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:-TJgYMXLbcj4F4qFnoaqGj0F0W9Iqtj9W0wiHy2TOiduKaE6Z9a_-Q>
 <xmx:-TJgYAgtUvDSg8kUE2HJzhDKB0-FoL1FQlVmcA2aS0x2LENqoAAQWA>
 <xmx:-TJgYMAgFtfEkP6ABZo2n3dTgvGEh05QSVHGEDP_Eb5dAR2jpizbfA>
 <xmx:-jJgYI7nw4TFF6bFOn3TaGro9SN0x7qFRVJgul62NtOYMrAgNR7uubZzopM>
Received: from localhost.localdomain
 (ip-176-199-210-156.hsi06.unitymediagroup.de [176.199.210.156])
 by mail.messagingengine.com (Postfix) with ESMTPA id 8E4E4240057;
 Sun, 28 Mar 2021 03:40:39 -0400 (EDT)
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 2/3] dt-bindings: iommu: add DART iommu bindings
Date: Sun, 28 Mar 2021 09:40:08 +0200
Message-Id: <20210328074009.95932-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210328074009.95932-1-sven@svenpeter.dev>
References: <20210328074009.95932-1-sven@svenpeter.dev>
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Sven Peter <sven@svenpeter.dev>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, linux-arm-kernel@lists.infradead.org,
 Stan Skowronek <stan@corellium.com>
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
 .../devicetree/bindings/iommu/apple,dart.yaml | 81 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/apple,dart.yaml

diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
new file mode 100644
index 000000000000..c0b43d90c157
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/apple,dart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple DART IOMMU
+
+maintainers:
+  - Sven Peter <sven@svenpeter.dev>
+
+description: |+
+  Apple SoCs may contain an implementation of their Device Address
+  Resolution Table which provides a mandatory layer of address
+  translations for various masters.
+
+  Each DART instance is capable of handling up to 16 different streams
+  with individual pagetables and page-level read/write protection flags.
+
+  This DART IOMMU also raises interrupts in response to various
+  fault conditions.
+
+properties:
+  compatible:
+    const: apple,t8103-dart
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description:
+      Reference to the gate clock phandle if required for this IOMMU.
+      Optional since not all IOMMUs are attached to a clock gate.
+
+  '#iommu-cells':
+    const: 1
+    description:
+      Has to be one. The single cell describes the stream id emitted by
+      a master to the IOMMU.
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
+    dart1: dart1@82f80000 {
+      compatible = "apple,t8103-dart";
+      reg = <0x82f80000 0x4000>;
+      interrupts = <1 781 4>;
+      #iommu-cells = <1>;
+    };
+
+    master1 {
+      iommus = <&{/dart1} 0>;
+    };
+
+  - |+
+    dart2a: dart2a@82f00000 {
+      compatible = "apple,t8103-dart";
+      reg = <0x82f00000 0x4000>;
+      interrupts = <1 781 4>;
+      #iommu-cells = <1>;
+    };
+    dart2b: dart2@82f80000 {
+      compatible = "apple,t8103-dart";
+      reg = <0x82f80000 0x4000>;
+      interrupts = <1 781 4>;
+      #iommu-cells = <1>;
+    };
+
+    master2 {
+      iommus = <&{/dart2a} 0>, <&{/dart2b} 1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9ac46317840b..f5397328fa1f 100644
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
