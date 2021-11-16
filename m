Return-Path: <SRS0=BhyV=QD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C114AC433EF
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 11:52:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 828A561507
	for <iommu@archiver.kernel.org>; Tue, 16 Nov 2021 11:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 828A561507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54922607E6;
	Tue, 16 Nov 2021 11:52:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dsiA_5vkb4px; Tue, 16 Nov 2021 11:52:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2975A607ED;
	Tue, 16 Nov 2021 11:52:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38237C003E;
	Tue, 16 Nov 2021 11:52:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 074ADC0012
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 11:52:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DD30A607E2
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 11:52:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pP_yF_vhJsOa for <iommu@lists.linux-foundation.org>;
 Tue, 16 Nov 2021 11:52:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4B6E60648
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 11:52:15 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id i5so37040013wrb.2
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 03:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Uzf6TNNMxMPnOfXBHYbEbeDQIC8p4g1MVfRgzs5DDGs=;
 b=oKTFvd4w68oBu2CeuPt31sqqYIjNp9IAcQ7NcI6owvfCJYmX6gfLEBtIhuxK/esVRG
 BUShtrErXbhwl0N3F5y1vzNLm8bzBGb+qUKBYDEpXGohxzSNg3Z+1ik+QjFpZ2Ive+7Y
 kgILxurA4lyt2wId8zgdPW/qvoKrKIFLn5tRCbu//hAodJmEkp94+YympfrF6+0t4Xzw
 2akgbzEimSjJ6cV8zz8hv69AsEEIHbwCEU4ppcPOb6d4aA8Z/zADjAaH4fLri2kIu3HX
 IPBhXSMMEuDHKaUD4FYqxNWA0TpqElOmD8f+W1waO92gvbgXhHBAIRcTvWuGJHetCN+3
 hnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Uzf6TNNMxMPnOfXBHYbEbeDQIC8p4g1MVfRgzs5DDGs=;
 b=0t8FShJOb6VM5hpId60x6xuLHRGvrduZjyMByDsW8eAtLBEL87M5icVRiEIzmnPlw0
 YFISDJ3q07gN1nF+OdbHlOl7wigKbLlhHnUQtIaQS5vQzmf8QCnQi1fKlDd1OF1qcPNY
 hZDdwmnRR5Di1mJyi9+huNBNH+m3SN1x8Ba/FFlRLhL1hO+/DYVcDRajEv80vwEP1bcg
 gwfDph7ohtq8zJEmqpajnMr1xXtxorvHebq8vtNEtNDc6n1bybiNU/3MFsQldN0n1f3c
 Usrwe8NKer2lT7x+4hChEzgEFq6mYDHyFMdJo0MP1u0RvwQlDxYGHjt8iO0HGmkrrb3V
 fnBg==
X-Gm-Message-State: AOAM533AfIw2EEO4/nDBbW9JR8lNxdDo7OdMWrU0QFpY/qMunFMkinuu
 1iUC0J5pq+1VjtRJ3Gi1+tOpOKjeY/bdCA==
X-Google-Smtp-Source: ABdhPJzIvcIdlgIhMAdlJboo29rVKBN0AAQX8dR01v87R/BtaSGuwYHNT8+GzAGQsOFuKHHGbQ/WSA==
X-Received: by 2002:a5d:6d07:: with SMTP id e7mr8159934wrq.311.1637063534170; 
 Tue, 16 Nov 2021 03:52:14 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id b6sm2232846wmq.45.2021.11.16.03.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Nov 2021 03:52:13 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: robh+dt@kernel.org
Subject: [PATCH 1/2] dt-bindings: Add Arm SMMUv3 PMCG binding
Date: Tue, 16 Nov 2021 11:35:36 +0000
Message-Id: <20211116113536.69758-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211116113536.69758-1-jean-philippe@linaro.org>
References: <20211116113536.69758-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, uchida.jun@socionext.com, leo.yan@linaro.org,
 will@kernel.org, linux-arm-kernel@lists.infradead.org
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

Add binding for the Arm SMMUv3 PMU. Each node represents a PMCG, and is
placed as a sibling node of the SMMU. Although the PMCGs registers may
be within the SMMU MMIO region, they are separate devices, and there can
be multiple PMCG devices for each SMMU (for example one for the TCU and
one for each TBU).

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 .../bindings/iommu/arm,smmu-v3-pmcg.yaml      | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.yaml

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.yaml
new file mode 100644
index 000000000000..a893e071fdb4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/arm,smmu-v3-pmcg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm SMMUv3 Performance Monitor Counter Group
+
+maintainers:
+  - Will Deacon <will@kernel.org>
+  - Robin Murphy <Robin.Murphy@arm.com>
+
+description: |+
+  An SMMUv3 may have several Performance Monitor Counter Group (PMCG).
+  They are standalone performance monitoring units that support both
+  architected and IMPLEMENTATION DEFINED event counters.
+
+properties:
+  $nodename:
+    pattern: "^pmu@[0-9a-f]*"
+  compatible:
+    oneOf:
+      - items:
+        - enum:
+          - hisilicon,smmu-v3-pmcg-hip08
+        - const: arm,smmu-v3-pmcg
+      - const: arm,smmu-v3-pmcg
+
+  reg:
+    description: |
+      Base addresses of the PMCG registers. Either a single address for Page 0
+      or an additional address for Page 1, where some registers can be
+      relocated with SMMU_PMCG_CFGR.RELOC_CTRS.
+    minItems: 1
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  msi-parent: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |+
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmu@2b420000 {
+            compatible = "arm,smmu-v3-pmcg";
+            reg = <0 0x2b420000 0 0x1000>,
+                  <0 0x2b430000 0 0x1000>;
+            interrupts = <GIC_SPI 80 IRQ_TYPE_EDGE_RISING>;
+            msi-parent = <&its 0xff0000>;
+    };
+
+    pmu@2b440000 {
+            compatible = "arm,smmu-v3-pmcg";
+            reg = <0 0x2b440000 0 0x1000>,
+                  <0 0x2b450000 0 0x1000>;
+            interrupts = <GIC_SPI 81 IRQ_TYPE_EDGE_RISING>;
+            msi-parent = <&its 0xff0000>;
+    };
-- 
2.33.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
