Return-Path: <SRS0=qwh6=M2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAA1C4320A
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 12:17:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B105860F35
	for <iommu@archiver.kernel.org>; Tue,  3 Aug 2021 12:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B105860F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8958960754;
	Tue,  3 Aug 2021 12:17:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SurAf1R4m2lM; Tue,  3 Aug 2021 12:17:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5F96F606E9;
	Tue,  3 Aug 2021 12:17:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B774C0010;
	Tue,  3 Aug 2021 12:17:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16B88C000E
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 12:17:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1423340488
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 12:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="P/6WrLCi";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="pSGmlI/y"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7lig4IGWkqLc for <iommu@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 12:17:18 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3306E4048B
 for <iommu@lists.linux-foundation.org>; Tue,  3 Aug 2021 12:17:18 +0000 (UTC)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
 by mailnew.nyi.internal (Postfix) with ESMTP id 69B025808BD;
 Tue,  3 Aug 2021 08:17:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Tue, 03 Aug 2021 08:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm2; bh=hmVh+YpDYoC5L
 PGnQ5g2GbgA4TF7yf+6pbjyOsKutcA=; b=P/6WrLCisKddnNFhnlKElPgCYdSqF
 3nVDuiyQopSLXzWD7rTjuZ3eTuEoqnhKf7jXWdcorV73p+fl5TIQRY9x+BV0sUiD
 ERUJ2s3PubNKiI9lLoH+SCscR87DrM11rwXmiIAxKVV5DQYPFTFzYq1lCvEs+6wx
 EEtCIgnN3dOvZfuonnhY8HicfQGPj/AR7kgiKvE0ClihsMETgWfqZfcJQkt/gi2m
 zC1kiTYgN5At93+wxGOoT1iE0riSvaM543gUy3JtfXqsMiKYWbtMJHWVuMwiiuO/
 pCxqFNuU7cTG2uC8advd1J1k4ZhEu3VYRlyPcAocG7MS6vVlXrS89DN8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=hmVh+YpDYoC5LPGnQ5g2GbgA4TF7yf+6pbjyOsKutcA=; b=pSGmlI/y
 G2hZA462r3eGZlaPGGYsUXnhif+ahtVMdcVkQlC6dMZLEXlYV4mWF74HnHVlAAax
 kSHs0NZZVrk3k1/fK4/OCdF5kIJmJPb0CN9LSZYkOWiytJ0H5Axoo8Xkdj+6nCma
 I+LRKTG3jN19k7DofiiGlf5eJpXVRQ+avg39o6Zun9P3aAJ1oC3ek6VFz5FS+F4N
 oA69CS0UcCgY08YxAQ0Gz1pP38fGD7LkUHkGSKATHxuSxzz7W27fZmgnEnlh/t85
 ldUUQ6C5rBYmJoPNNqfDzTIaEMIRGjhjOKgJkF1qUOthi8odwBbzVVhYZEMpSQJY
 KLF/53L+CKoxZg==
X-ME-Sender: <xms:zDMJYVUqm31aiWS_sxWUsEnCwI-q0g6fYSRdgvKAdETfKA3nmu8V3w>
 <xme:zDMJYVmAa-eQUAykQsF5TbVrK6CDK2yHa0FMQjGR8sk5AZAvee6GGwrs_m7mWXPb9
 9bi_61PkUstTGBuYPU>
X-ME-Received: <xmr:zDMJYRb0gZUjSvE6SYaU-Z39kusnO4dI46BpDABVeHZd87fIQCIt7QwC3ZyAEmygYH_8Ke45zFD2KANksr6l_L5HgcfFA1cHfhsSA3UADyS6MfaQjlAUNZY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieeggdegkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhvvghnucfr
 vghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrh
 hnpefhfeffjedvkeeliedtffeihffhffevffeijeetfeehuddtgffffedtjeehtdetheen
 ucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuihiivg
 eptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdgu
 vghv
X-ME-Proxy: <xmx:zDMJYYUdzMai4QGAZM1ANUh_Xf3zww7G-wMgcq3DVdd9ExjJjJ0VoA>
 <xmx:zDMJYfnTTdBr-REHN_P76ophJn45e1rIEMz1cd5J_RzOEsEmdScigw>
 <xmx:zDMJYVeTB3YDzfjV9QUVM9y5AnNzzIcjL_EX6f124uYfh9ChYJLc7w>
 <xmx:zTMJYSquYtMVi10wCUy4Uwz4GBpXJ3xticNFzyDnIg-m9hCiD6_D8w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Aug 2021 08:17:14 -0400 (EDT)
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v5 2/3] dt-bindings: iommu: add DART iommu bindings
Date: Tue,  3 Aug 2021 14:16:50 +0200
Message-Id: <20210803121651.61594-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210803121651.61594-1-sven@svenpeter.dev>
References: <20210803121651.61594-1-sven@svenpeter.dev>
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@kernel.org>, r.czerwinski@pengutronix.de,
 devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Alexander Graf <graf@amazon.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Stan Skowronek <stan@corellium.com>
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

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 .../devicetree/bindings/iommu/apple,dart.yaml | 81 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/apple,dart.yaml

diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
new file mode 100644
index 000000000000..94aa9e9afa59
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
+    dart1: iommu@82f80000 {
+      compatible = "apple,t8103-dart";
+      reg = <0x82f80000 0x4000>;
+      interrupts = <1 781 4>;
+      #iommu-cells = <1>;
+    };
+
+    master1 {
+      iommus = <&dart1 0>;
+    };
+
+  - |+
+    dart2a: iommu@82f00000 {
+      compatible = "apple,t8103-dart";
+      reg = <0x82f00000 0x4000>;
+      interrupts = <1 781 4>;
+      #iommu-cells = <1>;
+    };
+    dart2b: iommu@82f80000 {
+      compatible = "apple,t8103-dart";
+      reg = <0x82f80000 0x4000>;
+      interrupts = <1 781 4>;
+      #iommu-cells = <1>;
+    };
+
+    master2 {
+      iommus = <&dart2a 0>, <&dart2b 1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c9467d2839f5..0f450f7d5336 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1262,6 +1262,12 @@ L:	linux-input@vger.kernel.org
 S:	Odd fixes
 F:	drivers/input/mouse/bcm5974.c
 
+APPLE DART IOMMU DRIVER
+M:	Sven Peter <sven@svenpeter.dev>
+L:	iommu@lists.linux-foundation.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
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
