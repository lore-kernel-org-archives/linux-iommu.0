Return-Path: <SRS0=sOBO=QE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A20C433FE
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 14:52:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FDB61A3D
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 14:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F0FDB61A3D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AF65F40452;
	Wed, 17 Nov 2021 14:52:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s_UZfsk3twFd; Wed, 17 Nov 2021 14:52:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 43375401F4;
	Wed, 17 Nov 2021 14:52:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCA44C0037;
	Wed, 17 Nov 2021 14:52:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62B3EC0012
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 14:52:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 45129605F8
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 14:52:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZJlB6o1P5bxA for <iommu@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 14:52:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1BE7E6060D
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 14:52:39 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id x6so693235edr.5
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 06:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6a4q4pVmQUXtzn45oqIQ9MFMoZugw/FbbL0Z8a0gnOg=;
 b=rUtkJyDRSqarprvrSuT5wzU3tWckAsA4nxQrLS6fI/rjg9yCAfIUAYsw2Xh78wJir6
 uMpgv0/Dv08euJ1JMFVLijyLbdf3oUHnfoeTp7nKGM/aOEAO4zMIDG0E3MbnKwyJP0GZ
 QA8FRC0w5SQa5Djk+ory93VLGjtjzZbWrm+PzPodr0WyLRNV41q2HFugiwMsSe0XX1y7
 RFsb+j1o5sU/R6CkLqFA1qRZO56JEVcWrtxfajNJW4cBcIEFdKQEjFaf5PLTHz0/SXmD
 ULhxuhsyysxIAWf/l1GMyDFI7K91UWKXZ8T+jWEDwZTsxa3tYoBA1d4m8K5gMn94x6yp
 3hSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6a4q4pVmQUXtzn45oqIQ9MFMoZugw/FbbL0Z8a0gnOg=;
 b=b4VMe/uSjJioxBixYvalb0essUq7dzMDVFf9dG62pxcfrWU3jyLQj5P6xPHjKfcM2d
 KEKx1STEJPl7uTqo5fTI3X+zwctnkpaYgCT3+uOkI2SgOXpAQHe3dxQgDdGTeJZ4iHJy
 iOy+e+chfbkmdIIy72PCnUHTJIgPza8qju5kOaEMZEOx5CgixT7FCpK+BZqQmkAYl3nl
 9mdferC2lHG97ZhaDffB4i9EYC2nDimfu6D/JvSrSzSgnmN35Tir3oJNJ15FYsVgpu9l
 ysfsgaZsTBsaJMg5m4zJ4z1A5PHjXmIzhVyRLwB7FhhEIuK5aECAFQCpBfwNOerzibFN
 VnOg==
X-Gm-Message-State: AOAM533+HKOZ0lPmnFJFwLPd5GEHax9jaZK8OhT4yX9WmHUKoFM4JAVA
 e1ez6kBc1MKbY7/1Jyua7/aRUw==
X-Google-Smtp-Source: ABdhPJwHaeJCQFolHmoVIN0lPrlp5s2Djgnu9qxNlKfuAMmCjAAT2Yf+Qc4rCkHRafGx6mc9LtDV1Q==
X-Received: by 2002:a05:6402:d49:: with SMTP id
 ec9mr22561651edb.235.1637160757182; 
 Wed, 17 Nov 2021 06:52:37 -0800 (PST)
Received: from localhost.localdomain
 (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
 by smtp.gmail.com with ESMTPSA id gs15sm63917ejc.42.2021.11.17.06.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Nov 2021 06:52:36 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: robh+dt@kernel.org
Subject: [PATCH v2 1/3] dt-bindings: Add Arm SMMUv3 PMCG binding
Date: Wed, 17 Nov 2021 14:48:43 +0000
Message-Id: <20211117144844.241072-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211117144844.241072-1-jean-philippe@linaro.org>
References: <20211117144844.241072-1-jean-philippe@linaro.org>
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
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 .../bindings/perf/arm,smmu-v3-pmcg.yaml       | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/arm,smmu-v3-pmcg.yaml

diff --git a/Documentation/devicetree/bindings/perf/arm,smmu-v3-pmcg.yaml b/Documentation/devicetree/bindings/perf/arm,smmu-v3-pmcg.yaml
new file mode 100644
index 000000000000..a4b53a6a1ebf
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/arm,smmu-v3-pmcg.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/arm,smmu-v3-pmcg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm SMMUv3 Performance Monitor Counter Group
+
+maintainers:
+  - Will Deacon <will@kernel.org>
+  - Robin Murphy <robin.murphy@arm.com>
+
+description: |
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
+          - const: arm,mmu-600-pmcg
+          - const: arm,smmu-v3-pmcg
+      - const: arm,smmu-v3-pmcg
+
+  reg:
+    items:
+      - description: Register page 0
+      - description: Register page 1, if SMMU_PMCG_CFGR.RELOC_CTRS = 1
+    minItems: 1
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
+anyOf:
+  - required:
+      - interrupts
+  - required:
+      - msi-parent
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmu@2b420000 {
+            compatible = "arm,smmu-v3-pmcg";
+            reg = <0x2b420000 0x1000>,
+                  <0x2b430000 0x1000>;
+            interrupts = <GIC_SPI 80 IRQ_TYPE_EDGE_RISING>;
+            msi-parent = <&its 0xff0000>;
+    };
+
+    pmu@2b440000 {
+            compatible = "arm,smmu-v3-pmcg";
+            reg = <0x2b440000 0x1000>,
+                  <0x2b450000 0x1000>;
+            interrupts = <GIC_SPI 81 IRQ_TYPE_EDGE_RISING>;
+            msi-parent = <&its 0xff0000>;
+    };
-- 
2.33.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
