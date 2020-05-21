Return-Path: <SRS0=DnMm=7D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D306AC433DF
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 13:00:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B414D2078B
	for <iommu@archiver.kernel.org>; Thu, 21 May 2020 13:00:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B414D2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A946F893CA;
	Thu, 21 May 2020 13:00:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yu5fGh-uqZ5h; Thu, 21 May 2020 13:00:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 00E88893C3;
	Thu, 21 May 2020 13:00:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2079C088B;
	Thu, 21 May 2020 13:00:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6438DC0176
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 13:00:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5257F871AD
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 13:00:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Amdxw5GgI7Ml for <iommu@lists.linux-foundation.org>;
 Thu, 21 May 2020 13:00:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E25C38705B
 for <iommu@lists.linux-foundation.org>; Thu, 21 May 2020 13:00:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C5DC1045;
 Thu, 21 May 2020 06:00:41 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.29.145])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30A613F305;
 Thu, 21 May 2020 06:00:39 -0700 (PDT)
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/12] dt-bindings: arm: fsl: Add msi-map device-tree binding
 for fsl-mc bus
Date: Thu, 21 May 2020 14:00:05 +0100
Message-Id: <20200521130008.8266-10-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Makarand Pawagi <makarand.pawagi@nxp.com>, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>
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

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The existing bindings cannot be used to specify the relationship
between fsl-mc devices and GIC ITSes.

Add a generic binding for mapping fsl-mc devices to GIC ITSes, using
msi-map property.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
index 9134e9bcca56..b0813b2d0493 100644
--- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
@@ -18,9 +18,9 @@ same hardware "isolation context" and a 10-bit value called an ICID
 the requester.
 
 The generic 'iommus' property is insufficient to describe the relationship
-between ICIDs and IOMMUs, so an iommu-map property is used to define
-the set of possible ICIDs under a root DPRC and how they map to
-an IOMMU.
+between ICIDs and IOMMUs, so the iommu-map and msi-map properties are used
+to define the set of possible ICIDs under a root DPRC and how they map to
+an IOMMU and a GIC ITS respectively.
 
 For generic IOMMU bindings, see
 Documentation/devicetree/bindings/iommu/iommu.txt.
@@ -28,6 +28,9 @@ Documentation/devicetree/bindings/iommu/iommu.txt.
 For arm-smmu binding, see:
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml.
 
+For GICv3 and GIC ITS bindings, see:
+Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml.
+
 Required properties:
 
     - compatible
@@ -119,6 +122,15 @@ Optional properties:
   associated with the listed IOMMU, with the iommu-specifier
   (i - icid-base + iommu-base).
 
+- msi-map: Maps an ICID to a GIC ITS and associated iommu-specifier
+  data.
+
+  The property is an arbitrary number of tuples of
+  (icid-base,iommu,iommu-base,length).
+
+  Any ICID in the interval [icid-base, icid-base + length) is
+  associated with the listed GIC ITS, with the iommu-specifier
+  (i - icid-base + iommu-base).
 Example:
 
         smmu: iommu@5000000 {
@@ -128,6 +140,16 @@ Example:
                ...
         };
 
+	gic: interrupt-controller@6000000 {
+		compatible = "arm,gic-v3";
+		...
+		its: gic-its@6020000 {
+			compatible = "arm,gic-v3-its";
+			msi-controller;
+			...
+		};
+	};
+
         fsl_mc: fsl-mc@80c000000 {
                 compatible = "fsl,qoriq-mc";
                 reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
@@ -135,6 +157,8 @@ Example:
                 msi-parent = <&its>;
                 /* define map for ICIDs 23-64 */
                 iommu-map = <23 &smmu 23 41>;
+                /* define msi map for ICIDs 23-64 */
+                msi-map = <23 &its 23 41>;
                 #address-cells = <3>;
                 #size-cells = <1>;
 
-- 
2.26.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
