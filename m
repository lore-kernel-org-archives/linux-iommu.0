Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45303214
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 11:58:25 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id x17so50539554lfu.5
        for <iommu@lists.linux.dev>; Thu, 06 Apr 2023 04:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680782303;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wEz7vgw5uhU097Ka8WcVBT886eUanKE5TMj9tFqtF7o=;
        b=byAot6+WRARtE+tR55I6QnRD1vOMNjSZjOixlqR0Jqf3sTZA6yyuLbMrdKeojOkkqZ
         ByTZ45h9eLg029PvTTfbEqVsvb6OpxWcDkmphKm/7wdJrK2SxrSYAKUrIjPhIGYDB6Ey
         IqVQLI5rIkI/uC49CTdLCol0n+kpZLLGOHWg2eXgOYH30frOJMUoj0BNyAm2uwd0JpbH
         xZzFKHVoGiO0sg3wTXXZgDLBdySxLe8I/Tet8a1qrAt005NeNTIrbmx8ytUPFVVSbyCd
         zX9WVrgTuXvIOyRRkDPeodUB2cJcg9X615NAOWaYdkAIEwTwzuppykTHEoCqNGEf2VWi
         QwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680782303;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEz7vgw5uhU097Ka8WcVBT886eUanKE5TMj9tFqtF7o=;
        b=dE/GqOdDG2G7Abx6Jjf/nujKCl61do7sNdjipKZLrAxRHQWb07RXcPrOw5O6ZP7vW2
         ERmfk7Znaceme2M98xpWfz+NmFyyYv5NmkSBXyPF54fYyY4ClmmovEglCEmbyhLgcgME
         vfPvvlfxNtK5l4WWuFCpR117WjLo9r+ocyQgpy3gyNM94RVrEEDA4DDdeCtv2YNn/Qru
         W+qZuLB/sWHGqwhZprBzFg+I90SYB71XXUKrEphgWeOBelOQoVmlHTfwVejXiv9Lq0GH
         q4Rak+Fj3h1bzv4zpt0pHKROR4fCdpgJ9iZqyFGxcqEgfrydY6ia+ATV9LLPXfQxe2sy
         V2iw==
X-Gm-Message-State: AAQBX9cEVrloKI7xVLshYe8Yoq0wgv7WtItYhSigZi2x+v+iG92ZAbVo
	lK7y//HlBT2INOHk+mtYmgZq7g==
X-Google-Smtp-Source: AKy350aT2NUYR0Lrggq1FuR12xhrlDLL2yJ+g0CdIbOZYjd4kzHcKDKxnuePX+7mzAqoxKUhPx9wDA==
X-Received: by 2002:ac2:4309:0:b0:4e8:43e2:a8 with SMTP id l9-20020ac24309000000b004e843e200a8mr2300539lfh.8.1680782303599;
        Thu, 06 Apr 2023 04:58:23 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id w3-20020a056512098300b004dd7fefd2c8sm231338lft.242.2023.04.06.04.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:58:23 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 06 Apr 2023 13:58:19 +0200
Subject: [PATCH v2] dt-bindings: iommu: Convert QCOM IOMMU to YAML
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-topic-qciommu-v2-1-b8547622b2a4@linaro.org>
X-B4-Tracking: v=1; b=H4sIANqzLmQC/3WNQQ6CMBBFr0K6dkwLxKor72FYlDKFSaDFKRAN6
 d2t7F2+l/z/dhGRCaO4F7tg3ChS8BnKUyHsYHyPQF1mUcqykrW8wBJmsvCyFKZpBW21qjq8Ond
 DkTetiQgtG2+HvPLrOGY5Mzp6H5Fnk3mguAT+HM1N/ey/+02BAlk5pbXSpq71YyRvOJwD96JJK
 X0BD1/xEsAAAAA=
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680782302; l=7496;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=hbr4tzXSxd2ffGS4hFOwUKVc93mD2kMGyhvcAspOwI4=;
 b=DenXYPio0tCOKPyO9yuknO35YDNBAxKz78rm5tpZrAdgUcAoPBpKB55NrCHEvhQGBBDDnThZeInQ
 ULe3hHBmAF+O+JX5fTHZbHrCMzc7VymjX4MIanXuFGyWAWQ7yOQY
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Convert the Qualcomm IOMMU bindings to YAML.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v1 -> v2:
- Include missing header
- pad the addresses to 8 hex digits
- add 'reg' to the mdp device

v1: https://lore.kernel.org/r/20230406-topic-qciommu-v1-1-03f17717a447@linaro.org
---
 .../devicetree/bindings/iommu/qcom,iommu.txt       | 122 ---------------------
 .../devicetree/bindings/iommu/qcom,iommu.yaml      | 112 +++++++++++++++++++
 2 files changed, 112 insertions(+), 122 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
deleted file mode 100644
index e6cecfd360eb..000000000000
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
+++ /dev/null
@@ -1,122 +0,0 @@
-* QCOM IOMMU v1 Implementation
-
-Qualcomm "B" family devices which are not compatible with arm-smmu have
-a similar looking IOMMU but without access to the global register space,
-and optionally requiring additional configuration to route context irqs
-to non-secure vs secure interrupt line.
-
-** Required properties:
-
-- compatible       : Should be one of:
-
-                        "qcom,msm8916-iommu"
-                        "qcom,msm8953-iommu"
-
-                     Followed by "qcom,msm-iommu-v1".
-
-- clock-names      : Should be a pair of "iface" (required for IOMMUs
-                     register group access) and "bus" (required for
-                     the IOMMUs underlying bus access).
-
-- clocks           : Phandles for respective clocks described by
-                     clock-names.
-
-- #address-cells   : must be 1.
-
-- #size-cells      : must be 1.
-
-- #iommu-cells     : Must be 1.  Index identifies the context-bank #.
-
-- ranges           : Base address and size of the iommu context banks.
-
-- qcom,iommu-secure-id  : secure-id.
-
-- List of sub-nodes, one per translation context bank.  Each sub-node
-  has the following required properties:
-
-  - compatible     : Should be one of:
-        - "qcom,msm-iommu-v1-ns"  : non-secure context bank
-        - "qcom,msm-iommu-v1-sec" : secure context bank
-  - reg            : Base address and size of context bank within the iommu
-  - interrupts     : The context fault irq.
-
-** Optional properties:
-
-- reg              : Base address and size of the SMMU local base, should
-                     be only specified if the iommu requires configuration
-                     for routing of context bank irq's to secure vs non-
-                     secure lines.  (Ie. if the iommu contains secure
-                     context banks)
-
-
-** Examples:
-
-	apps_iommu: iommu@1e20000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		#iommu-cells = <1>;
-		compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";
-		ranges = <0 0x1e20000 0x40000>;
-		reg = <0x1ef0000 0x3000>;
-		clocks = <&gcc GCC_SMMU_CFG_CLK>,
-			 <&gcc GCC_APSS_TCU_CLK>;
-		clock-names = "iface", "bus";
-		qcom,iommu-secure-id = <17>;
-
-		// mdp_0:
-		iommu-ctx@4000 {
-			compatible = "qcom,msm-iommu-v1-ns";
-			reg = <0x4000 0x1000>;
-			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		// venus_ns:
-		iommu-ctx@5000 {
-			compatible = "qcom,msm-iommu-v1-sec";
-			reg = <0x5000 0x1000>;
-			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
-		};
-	};
-
-	gpu_iommu: iommu@1f08000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		#iommu-cells = <1>;
-		compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";
-		ranges = <0 0x1f08000 0x10000>;
-		clocks = <&gcc GCC_SMMU_CFG_CLK>,
-			 <&gcc GCC_GFX_TCU_CLK>;
-		clock-names = "iface", "bus";
-		qcom,iommu-secure-id = <18>;
-
-		// gfx3d_user:
-		iommu-ctx@1000 {
-			compatible = "qcom,msm-iommu-v1-ns";
-			reg = <0x1000 0x1000>;
-			interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		// gfx3d_priv:
-		iommu-ctx@2000 {
-			compatible = "qcom,msm-iommu-v1-ns";
-			reg = <0x2000 0x1000>;
-			interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
-		};
-	};
-
-	...
-
-	venus: video-codec@1d00000 {
-		...
-		iommus = <&apps_iommu 5>;
-	};
-
-	mdp: mdp@1a01000 {
-		...
-		iommus = <&apps_iommu 4>;
-	};
-
-	gpu@1c00000 {
-		...
-		iommus = <&gpu_iommu 1>, <&gpu_iommu 2>;
-	};
diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
new file mode 100644
index 000000000000..5bb376aeb958
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/qcom,iommu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies legacy IOMMU implementations
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description: |
+  Qualcomm "B" family devices which are not compatible with arm-smmu have
+  a similar looking IOMMU, but without access to the global register space
+  and optionally requiring additional configuration to route context IRQs
+  to non-secure vs secure interrupt line.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,msm8916-iommu
+          - qcom,msm8953-iommu
+      - const: qcom,msm-iommu-v1
+
+  clocks:
+    items:
+      - description: Clock required for IOMMU register group access
+      - description: Clock required for underlying bus access
+
+  clock-names:
+    items:
+      - const: iface
+      - const: bus
+
+  power-domains:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  ranges: true
+
+  qcom,iommu-secure-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The SCM secure ID of the IOMMU instance.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  '#iommu-cells':
+    const: 1
+
+patternProperties:
+  "^iommu-ctx@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        enum:
+          - qcom,msm-iommu-v1-ns
+          - qcom,msm-iommu-v1-sec
+
+      interrupts:
+        maxItems: 1
+
+      reg:
+        maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - ranges
+  - '#address-cells'
+  - '#size-cells'
+  - '#iommu-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-msm8916.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    apps_iommu: iommu@1e20000 {
+      compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";
+      reg = <0x01ef0000 0x3000>;
+      clocks = <&gcc GCC_SMMU_CFG_CLK>,
+               <&gcc GCC_APSS_TCU_CLK>;
+      clock-names = "iface", "bus";
+      qcom,iommu-secure-id = <17>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      #iommu-cells = <1>;
+      ranges = <0 0x01e20000 0x40000>;
+
+      /* mdp_0: */
+      iommu-ctx@4000 {
+        compatible = "qcom,msm-iommu-v1-ns";
+        reg = <0x4000 0x1000>;
+        interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+      };
+    };
+
+    mdp: mdp@1a01000 {
+      reg = <0x01a01000 0x1000>;
+      iommus = <&apps_iommu 4>;
+    };

---
base-commit: 8417c8f5007bf4567ccffda850a3157c7d905f67
change-id: 20230406-topic-qciommu-7c713de8ff9e

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

