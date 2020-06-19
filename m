Return-Path: <SRS0=CQHw=AA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD15BC433E0
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 08:20:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD43420890
	for <iommu@archiver.kernel.org>; Fri, 19 Jun 2020 08:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD43420890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9D88926E9E;
	Fri, 19 Jun 2020 08:20:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZYw6eFo-ZXTA; Fri, 19 Jun 2020 08:20:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B7C7426767;
	Fri, 19 Jun 2020 08:20:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD67EC0865;
	Fri, 19 Jun 2020 08:20:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BD86C016E
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 08:20:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8CBD587282
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 08:20:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZTjmb-suyPOe for <iommu@lists.linux-foundation.org>;
 Fri, 19 Jun 2020 08:20:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9CFA587252
 for <iommu@lists.linux-foundation.org>; Fri, 19 Jun 2020 08:20:51 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AED12B;
 Fri, 19 Jun 2020 01:20:51 -0700 (PDT)
Received: from red-moon.arm.com (unknown [10.57.58.158])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5D353F71F;
 Fri, 19 Jun 2020 01:20:48 -0700 (PDT)
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 08/12] dt-bindings: arm: fsl: Add msi-map device-tree
 binding for fsl-mc bus
Date: Fri, 19 Jun 2020 09:20:09 +0100
Message-Id: <20200619082013.13661-9-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-pci@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Makarand Pawagi <makarand.pawagi@nxp.com>, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Diana Craciun <diana.craciun@oss.nxp.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>
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
In addition, deprecate msi-parent property which no longer makes sense
now that we support translating the MSIs.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 50 ++++++++++++++++---
 1 file changed, 44 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
index 9134e9bcca56..ebd329181c14 100644
--- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
@@ -28,6 +28,16 @@ Documentation/devicetree/bindings/iommu/iommu.txt.
 For arm-smmu binding, see:
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml.
 
+The MSI writes are accompanied by sideband data which is derived from the ICID.
+The msi-map property is used to associate the devices with both the ITS
+controller and the sideband data which accompanies the writes.
+
+For generic MSI bindings, see
+Documentation/devicetree/bindings/interrupt-controller/msi.txt.
+
+For GICv3 and GIC ITS bindings, see:
+Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml.
+
 Required properties:
 
     - compatible
@@ -49,11 +59,6 @@ Required properties:
                         region may not be present in some scenarios, such
                         as in the device tree presented to a virtual machine.
 
-    - msi-parent
-        Value type: <phandle>
-        Definition: Must be present and point to the MSI controller node
-                    handling message interrupts for the MC.
-
     - ranges
         Value type: <prop-encoded-array>
         Definition: A standard property.  Defines the mapping between the child
@@ -119,6 +124,28 @@ Optional properties:
   associated with the listed IOMMU, with the iommu-specifier
   (i - icid-base + iommu-base).
 
+- msi-map: Maps an ICID to a GIC ITS and associated msi-specifier
+  data.
+
+  The property is an arbitrary number of tuples of
+  (icid-base,gic-its,msi-base,length).
+
+  Any ICID in the interval [icid-base, icid-base + length) is
+  associated with the listed GIC ITS, with the msi-specifier
+  (i - icid-base + msi-base).
+
+Deprecated properties:
+
+    - msi-parent
+        Value type: <phandle>
+        Definition: Describes the MSI controller node handling message
+                    interrupts for the MC. When there is no translation
+                    between the ICID and deviceID this property can be used
+                    to describe the MSI controller used by the devices on the
+                    mc-bus.
+                    The use of this property for mc-bus is deprecated. Please
+                    use msi-map.
+
 Example:
 
         smmu: iommu@5000000 {
@@ -128,13 +155,24 @@ Example:
                ...
         };
 
+        gic: interrupt-controller@6000000 {
+               compatible = "arm,gic-v3";
+               ...
+        }
+        its: gic-its@6020000 {
+               compatible = "arm,gic-v3-its";
+               msi-controller;
+               ...
+        };
+
         fsl_mc: fsl-mc@80c000000 {
                 compatible = "fsl,qoriq-mc";
                 reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
                       <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
-                msi-parent = <&its>;
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
