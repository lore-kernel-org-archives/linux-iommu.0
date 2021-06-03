Return-Path: <SRS0=MHXQ=K5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57730C47096
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 08:50:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD83613E6
	for <iommu@archiver.kernel.org>; Thu,  3 Jun 2021 08:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD83613E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BA4AA40535;
	Thu,  3 Jun 2021 08:50:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4MhnlV5wS259; Thu,  3 Jun 2021 08:50:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id C07664053A;
	Thu,  3 Jun 2021 08:50:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2BEBC000D;
	Thu,  3 Jun 2021 08:50:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B7A6C0001
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 08:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3AE6E608C4
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 08:50:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=svenpeter.dev header.b="GQyTi/dH";
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.b="qpHKcacl"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xbJE2zBelq9Y for <iommu@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 08:50:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com
 [66.111.4.224])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 175F460B33
 for <iommu@lists.linux-foundation.org>; Thu,  3 Jun 2021 08:50:34 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.nyi.internal (Postfix) with ESMTP id 1700A580F08;
 Thu,  3 Jun 2021 04:50:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Thu, 03 Jun 2021 04:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=fm1; bh=gGQl9SRxrhirr
 YTrU4b/HJo5lcf3YI1dsRlqz4epgR8=; b=GQyTi/dHgPLwCAtvecYogDZ3jMN+u
 3P5m5hN5SMDYk76wbSeqZfdCwWX+aSKWc/aiaq1sT6ad0Y9ueNznZl8UAhtEfzJF
 1K09MoJsF+ByCTav2nVB40yaoW1siaGgl081YcColXrZzwW3LY/YUDpN1PZfFVFp
 ke/ky84YeiL3guBP5m4kcLCSw+FCyZx1DkhoqUPTmCHcVSBAaE2U5J9yDgWhE9ek
 Ig4gJHRNjyarwZjTFmDI1Eymdqc1oWPWVHYzUdJV0tA77RC3w+b3jMC+7Nkn5F4C
 lCxTHVTlZJUj7qiGpMwWJlf4EW+LSX2Px53jwOQpBp4WU+LIlZYQAALDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; bh=gGQl9SRxrhirrYTrU4b/HJo5lcf3YI1dsRlqz4epgR8=; b=qpHKcacl
 OC+UXWdxt2zLAB+FZjA60l5fIOqL7BpEqnVSdeUWTvIGkz+jz9yS97w6JEaJgTCO
 hrPffxQSIRafemdLJUuVauhqXws1NqbU00le9or//JLXo2aPNhdsRSftRY7mjpom
 Hd1aTqsEyIE6JBHMh2T4P1Xgyrwg1QowVi0fzdMNLfBVCe3+BAz85EzNXlYZbGnq
 LRjBCbuPqPW3s2hjQ5XPpNZNhadDe/Qt5pG/7w8U8ODmCNp+t06D4hW8EI5CdiqD
 Z4cYMdpnNTRE+1nr/EmaUdaDDXYWyFfk0iKn9HpWwD1IMdThQGVe0ADKg30HWbZS
 /HTXhXN0OyUHxQ==
X-ME-Sender: <xms:15e4YJpnwlWI4OmQGbvaUdGcEl4H14K5NwCURwitNCa0pSUHyX_kZg>
 <xme:15e4YLqUyIK3jtJDwOuOJiHpkaVvXHzn6AE41VUM-w2o_BZ6hFFh2oA41jjy3HcrH
 G6ZwX3vOasJOFqfnBg>
X-ME-Received: <xmr:15e4YGPH3kNqD54i5KxTMpH2b5JejcmEBVYeWf6bmMb5jukcM9VMJTOAZVMUPTI_IQqm_9W2Yn5rU7W8qZbrqPl4WUdGUVzGj2AGya_m6Ar2SX5y5JGr6wHIX8TLcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdelledgtdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
 rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
 hrnhephfefffejvdekleeitdffiefhhfffveffieejteefhedutdfgffeftdejhedtteeh
 necuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdr
 uggvvh
X-ME-Proxy: <xmx:15e4YE5DJfuI36o2bYlbfNI2ouCnFRsLkegV7-tGdmJgC5fYxHu5Bg>
 <xmx:15e4YI6AgVW8YeGRbInecRk27BPe7vNYoLoXQF5_8n7k81kEv_PqFw>
 <xmx:15e4YMjscenrqRb2mFG2vQ7KOzr7lr4fJ9OPGABzI2KaXzb0uTjxGQ>
 <xmx:2Je4YHQ_SQdIpGZ3fO71-TvGndwZCtZMjBofZDa39khkcDO7jyP7UQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jun 2021 04:50:29 -0400 (EDT)
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 2/3] dt-bindings: iommu: add DART iommu bindings
Date: Thu,  3 Jun 2021 10:50:02 +0200
Message-Id: <20210603085003.50465-3-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210603085003.50465-1-sven@svenpeter.dev>
References: <20210603085003.50465-1-sven@svenpeter.dev>
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@kernel.org>, devicetree@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Alexander Graf <graf@amazon.com>,
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
index 000000000000..db21ca07d121
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
+      iommus = <&{/dart1} 0>;
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
+      iommus = <&{/dart2a} 0>, <&{/dart2b} 1>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 673cadd5107a..4373d63f9ccf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1240,6 +1240,12 @@ L:	linux-input@vger.kernel.org
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
