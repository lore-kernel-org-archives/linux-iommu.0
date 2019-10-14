Return-Path: <SRS0=ZipC=YH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1AEECE58C
	for <iommu@archiver.kernel.org>; Mon, 14 Oct 2019 19:13:01 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F73C2089C
	for <iommu@archiver.kernel.org>; Mon, 14 Oct 2019 19:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F73C2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 704612D7B;
	Mon, 14 Oct 2019 19:13:01 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C12812D76
	for <iommu@lists.linux-foundation.org>;
	Mon, 14 Oct 2019 19:12:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com
	[209.85.167.195])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D061C821
	for <iommu@lists.linux-foundation.org>;
	Mon, 14 Oct 2019 19:12:58 +0000 (UTC)
Received: by mail-oi1-f195.google.com with SMTP id a15so14700551oic.0
	for <iommu@lists.linux-foundation.org>;
	Mon, 14 Oct 2019 12:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=BKXy075na4ND49CdMbGkDtc/ZP4/qAVkyOLqEDxA11Q=;
	b=QKZ+Rd7ZodfzCZHmo0WoI3XqEBzmmSMu43jwGX4tV0UlegAr2d/tBzLPSSdYt9zlj5
	+P3fqE2Sl3M/iFxAxn/MHiImzw2EjwwLlm+1O38bFCA5v9PJNnt8Jl9y93+WxlzvkEFi
	Q7ZQ5vzOog3yY7wq/LFURiEOSWi6ePLlpegfa7tKEZttZPZTTp8XH1qyZt41FjmHPY0/
	xuF8/D9P/3b4HtEKdEMXsuEvtn6plsJJWQ8BcQ7txl9oeabVMb4WALuUbzR+AFCXDMdw
	XWvjFnb0lp2s3jLGIrCJ9lq6irt2EIz+Mu0z1m0AOFC42xvl4x+6K8mV6ytq3pg6BgnH
	wiLg==
X-Gm-Message-State: APjAAAXyTKmcjmv1GUDeE1vcMopmVHGhqxviFgpHsDvNPsLGOBShUKcD
	2Ii3NjfESgGP7l4n5/r7pA==
X-Google-Smtp-Source: APXvYqyrO4c+jhZ0cqjrdApT7AA5i5nT+lBbo2O8aFYuRslpiPvoVTgj7UWQ1E37xdrNwG9HFKS57w==
X-Received: by 2002:aca:5ed7:: with SMTP id
	s206mr24477966oib.134.1571080377970; 
	Mon, 14 Oct 2019 12:12:57 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net.
	[24.155.109.49]) by smtp.googlemail.com with ESMTPSA id
	o23sm5999596ote.67.2019.10.14.12.12.56
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 14 Oct 2019 12:12:57 -0700 (PDT)
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org
Subject: [PATCH v2] dt-bindings: iommu: Convert Arm SMMUv3 to DT schema
Date: Mon, 14 Oct 2019 14:12:56 -0500
Message-Id: <20191014191256.12697-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	Robin Murphy <Robin.Murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Convert the Arm SMMv3 binding to the DT schema format.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <Robin.Murphy@arm.com>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Refine interrupt definition based on Robin's comments

 .../devicetree/bindings/iommu/arm,smmu-v3.txt |  77 --------------
 .../bindings/iommu/arm,smmu-v3.yaml           | 100 ++++++++++++++++++
 2 files changed, 100 insertions(+), 77 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
deleted file mode 100644
index c9abbf3e4f68..000000000000
--- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
+++ /dev/null
@@ -1,77 +0,0 @@
-* ARM SMMUv3 Architecture Implementation
-
-The SMMUv3 architecture is a significant departure from previous
-revisions, replacing the MMIO register interface with in-memory command
-and event queues and adding support for the ATS and PRI components of
-the PCIe specification.
-
-** SMMUv3 required properties:
-
-- compatible        : Should include:
-
-                      * "arm,smmu-v3" for any SMMUv3 compliant
-                        implementation. This entry should be last in the
-                        compatible list.
-
-- reg               : Base address and size of the SMMU.
-
-- interrupts        : Non-secure interrupt list describing the wired
-                      interrupt sources corresponding to entries in
-                      interrupt-names. If no wired interrupts are
-                      present then this property may be omitted.
-
-- interrupt-names   : When the interrupts property is present, should
-                      include the following:
-                      * "eventq"    - Event Queue not empty
-                      * "priq"      - PRI Queue not empty
-                      * "cmdq-sync" - CMD_SYNC complete
-                      * "gerror"    - Global Error activated
-                      * "combined"  - The combined interrupt is optional,
-				      and should only be provided if the
-				      hardware supports just a single,
-				      combined interrupt line.
-				      If provided, then the combined interrupt
-				      will be used in preference to any others.
-
-- #iommu-cells      : See the generic IOMMU binding described in
-                        devicetree/bindings/pci/pci-iommu.txt
-                      for details. For SMMUv3, must be 1, with each cell
-                      describing a single stream ID. All possible stream
-                      IDs which a device may emit must be described.
-
-** SMMUv3 optional properties:
-
-- dma-coherent      : Present if DMA operations made by the SMMU (page
-                      table walks, stream table accesses etc) are cache
-                      coherent with the CPU.
-
-                      NOTE: this only applies to the SMMU itself, not
-                      masters connected upstream of the SMMU.
-
-- msi-parent        : See the generic MSI binding described in
-                        devicetree/bindings/interrupt-controller/msi.txt
-                      for a description of the msi-parent property.
-
-- hisilicon,broken-prefetch-cmd
-                    : Avoid sending CMD_PREFETCH_* commands to the SMMU.
-
-- cavium,cn9900-broken-page1-regspace
-                    : Replaces all page 1 offsets used for EVTQ_PROD/CONS,
-		      PRIQ_PROD/CONS register access with page 0 offsets.
-		      Set for Cavium ThunderX2 silicon that doesn't support
-		      SMMU page1 register space.
-
-** Example
-
-        smmu@2b400000 {
-                compatible = "arm,smmu-v3";
-                reg = <0x0 0x2b400000 0x0 0x20000>;
-                interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
-                             <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
-                             <GIC_SPI 77 IRQ_TYPE_EDGE_RISING>,
-                             <GIC_SPI 79 IRQ_TYPE_EDGE_RISING>;
-                interrupt-names = "eventq", "priq", "cmdq-sync", "gerror";
-                dma-coherent;
-                #iommu-cells = <1>;
-                msi-parent = <&its 0xff0000>;
-        };
diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
new file mode 100644
index 000000000000..662cbc4592c9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/arm,smmu-v3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM SMMUv3 Architecture Implementation
+
+maintainers:
+  - Will Deacon <will@kernel.org>
+  - Robin Murphy <Robin.Murphy@arm.com>
+
+description: |+
+  The SMMUv3 architecture is a significant departure from previous
+  revisions, replacing the MMIO register interface with in-memory command
+  and event queues and adding support for the ATS and PRI components of
+  the PCIe specification.
+
+properties:
+  $nodename:
+    pattern: "^iommu@[0-9a-f]*"
+  compatible:
+    const: arm,smmu-v3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 4
+
+  interrupt-names:
+    oneOf:
+      - const: combined
+        description:
+          The combined interrupt is optional, and should only be provided if the
+          hardware supports just a single, combined interrupt line.
+          If provided, then the combined interrupt will be used in preference to
+          any others.
+      - items:
+          - const: eventq     # Event Queue not empt
+          - const: priq       # PRI Queue not empty
+          - const: cmdq-sync  # CMD_SYNC complete
+          - const: gerror     # Global Error activated
+      - minItems: 2
+        maxItems: 4
+        items:
+          - const: eventq
+          - const: gerror
+          - const: priq
+          - const: cmdq-sync
+
+  '#iommu-cells':
+    const: 1
+
+  dma-coherent:
+    description: |
+      Present if page table walks made by the SMMU are cache coherent with the
+      CPU.
+
+      NOTE: this only applies to the SMMU itself, not masters connected
+      upstream of the SMMU.
+
+  msi-parent: true
+
+  hisilicon,broken-prefetch-cmd:
+    type: boolean
+    description: Avoid sending CMD_PREFETCH_* commands to the SMMU.
+
+  cavium,cn9900-broken-page1-regspace:
+    type: boolean
+    description:
+      Replaces all page 1 offsets used for EVTQ_PROD/CONS, PRIQ_PROD/CONS
+      register access with page 0 offsets. Set for Cavium ThunderX2 silicon that
+      doesn't support SMMU page1 register space.
+
+required:
+  - compatible
+  - reg
+  - '#iommu-cells'
+
+additionalProperties: false
+
+examples:
+  - |+
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    iommu@2b400000 {
+            compatible = "arm,smmu-v3";
+            reg = <0x2b400000 0x20000>;
+            interrupts = <GIC_SPI 74 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 77 IRQ_TYPE_EDGE_RISING>,
+                         <GIC_SPI 79 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "eventq", "priq", "cmdq-sync", "gerror";
+            dma-coherent;
+            #iommu-cells = <1>;
+            msi-parent = <&its 0xff0000>;
+    };
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
