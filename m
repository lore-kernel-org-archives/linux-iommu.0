Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B989C433F5
	for <iommu@archiver.kernel.org>; Wed, 27 Apr 2022 11:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 341BE419AB;
	Wed, 27 Apr 2022 11:25:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i-k7q2qbOtaa; Wed, 27 Apr 2022 11:25:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E717B419B0;
	Wed, 27 Apr 2022 11:25:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BB43BC0032;
	Wed, 27 Apr 2022 11:25:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48F53C002D
 for <iommu@lists.linux-foundation.org>; Wed, 27 Apr 2022 11:25:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 27888419B0
 for <iommu@lists.linux-foundation.org>; Wed, 27 Apr 2022 11:25:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X9L6Ot_MZmnc for <iommu@lists.linux-foundation.org>;
 Wed, 27 Apr 2022 11:25:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 12EC0419AB
 for <iommu@lists.linux-foundation.org>; Wed, 27 Apr 2022 11:25:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2093D143D;
 Wed, 27 Apr 2022 04:25:48 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.197.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE14B3F5A1;
 Wed, 27 Apr 2022 04:25:46 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH 01/11] dt-bindings: iommu: arm,smmu-v3: make PRI IRQ optional
Date: Wed, 27 Apr 2022 12:25:18 +0100
Message-Id: <20220427112528.4097815-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427112528.4097815-1-andre.przywara@arm.com>
References: <20220427112528.4097815-1-andre.przywara@arm.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Liviu Dudau <liviu.dudau@arm.com>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

The Page Request Interface (PRI) is an optional PCIe feature. As such, a
SMMU would not need to handle it if the PCIe host bridge or the SMMU
itself do not implement it. Also an SMMU could be connected to a platform
device, without any PRI functionality whatsoever.
In all cases there would be no SMMU PRI queue interrupt to be wired up
to an interrupt controller.

Relax the binding to allow specifying three interrupts, omitting the PRI
IRQ. At the moment, with the "eventq,gerror,priq,cmdq-sync" order, we
would need to sacrifice the command queue sync interrupt as well, which
might not be desired.
The Linux driver does not care about any order at all, just picks IRQs
based on their names, and treats all (wired) IRQs as optional.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../bindings/iommu/arm,smmu-v3.yaml           | 21 ++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
index e87bfbcc69135..6b3111f1f06ce 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
@@ -37,12 +37,23 @@ properties:
           hardware supports just a single, combined interrupt line.
           If provided, then the combined interrupt will be used in preference to
           any others.
-      - minItems: 2
+      - minItems: 1
         items:
-          - const: eventq     # Event Queue not empty
-          - const: gerror     # Global Error activated
-          - const: priq       # PRI Queue not empty
-          - const: cmdq-sync  # CMD_SYNC complete
+          - enum:
+              - eventq     # Event Queue not empty
+              - gerror     # Global Error activated
+              - cmdq-sync  # CMD_SYNC complete
+              - priq       # PRI Queue not empty
+          - enum:
+              - gerror
+              - cmdq-sync
+              - priq
+          - enum:
+              - cmdq-sync
+              - priq
+          - enum:
+              - cmdq-sync
+              - priq
 
   '#iommu-cells':
     const: 1
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
