Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DA1320D
	for <iommu@lists.linux.dev>; Thu,  6 Apr 2023 18:47:40 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id e9so26354391ljq.4
        for <iommu@lists.linux.dev>; Thu, 06 Apr 2023 11:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680806859;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CvX4uOfDerQJEiGG++jroZtpgDOEVq0GfGUeYaZgx8s=;
        b=v/BHjuwL/W3yJBdECVyZD7LaGC2CHy6gj97JcJ1wRz6HR7EGBNJiesD6gj2KAxn405
         4yoggUPu/hRFqvwE1f5LoC+RFlJ5dcA2LPPqFYy3Xm40pfpLErANR7IyOUzRZkMQFGgR
         qkB0WSmLlfY6DR4qxRHWy26PLkyFRI8zfI7rDm5XSj/rn7Fb81WN4MkdbweK2IDIx4Qd
         vhGwjPCAaU9oFw2XI1SNhQinhVmzDznr5ZFXax3hAQDtu7kjphS6Ubef4RMenMlW9wmB
         71LhHubgOBlC3yk3poATD3A1rcraA33UjizvcWeE2ZKnrHfwH5F8D+VO2mhamUSTaMP1
         xHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680806859;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvX4uOfDerQJEiGG++jroZtpgDOEVq0GfGUeYaZgx8s=;
        b=nlDbWC86o6C/3AsnRPUBelATmgBxJANiOaCJHieIIERUgVSSvM3d+D4HKqStVJOdO3
         iOoqSRktdIWtGaZSsrCGlT+KlLy45RVLd0UwQ8TopEIzt8DPZODfKLskP21iAD3QjaQO
         FWz5oSImCkyh4qaJyvzj47fbpsx+TSV2BPY8iflvNIBCn+GqwFt5iLun7/nj1qpmldFB
         ap/emD9jlmZ2+nUZm3NJWoWln/y1dw714g1VhBXhz9sd4m6hXHJDAhAFz9A24inBV7Am
         QZoHBMC1FQztsbcLL7vTMDNIHHeSOe5zENi1wDs5U6DDh2/hJcCMVAG8QLdq3kf5JoNM
         Wh9w==
X-Gm-Message-State: AAQBX9cggn+HzdIWWzMAKrdVCFCd/P1mtpTYY9GFt2xtjzFsqfhDum9H
	yr0bEPrA2dMvZDKQhYAXgz3r0g==
X-Google-Smtp-Source: AKy350ZUVNs5nFG3t5xqZrgCAwKWlrsZSt1QoIp3BKwXk/yZf4HiXWPS5g61CaPCGdZgatLUoCDl3g==
X-Received: by 2002:a2e:2e14:0:b0:298:b365:81c with SMTP id u20-20020a2e2e14000000b00298b365081cmr3420662lju.15.1680806858779;
        Thu, 06 Apr 2023 11:47:38 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id h2-20020a2e3a02000000b002a618eb72b1sm388878lja.98.2023.04.06.11.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 11:47:38 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Thu, 06 Apr 2023 20:47:28 +0200
Subject: [PATCH v3] dt-bindings: iommu: Convert QCOM IOMMU to YAML
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-topic-qciommu-v3-1-aa0e4f018191@linaro.org>
X-B4-Tracking: v=1; b=H4sIAL8TL2QC/32NTQ7CIBgFr2JYi+HPUl15D+MCKLRf0kKFlmia3
 l3anQtdzktm3oKSjWATuh4WFG2GBMEX4McDMp3yrcXQFEaMME4EqfAURjD4aSAMw4ylkZQ3tnb
 uYlFxtEoW66i86Yrl574v4xitg9d+cn8U7iBNIb73z0y39Vc+U0wx4Y5KSaUSQt568CqGU4gt2
 lKZ/dVZ0XV9FrJiTDMlvvR1XT+O3BT7/wAAAA==
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680806855; l=7713;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=trP7jAYihw9MB02Y8nwMb0R/A9JM9SNGCT+bkmwUPqM=;
 b=Y0D4lt4ge+lgZeQV4osnobm6mkMdSo1ILo+BXILaH/IS8ilbLXb/r0c+rxjZGMVCaV7AUIBTtzA0
 s7x+3GmoBCm+UPTiyPdJT1F+ERPpMi9uBPXmOEAw2iLVHlidGsVC
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Convert the Qualcomm IOMMU bindings to YAML.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
v2 -> v3:
- Add additionalProperties:false & required for ctx subnodes
- Drop the IOMMU consumer device from the DT example

v2: https://lore.kernel.org/r/20230406-topic-qciommu-v2-1-b8547622b2a4@linaro.org

v1 -> v2:
- Include missing header
- pad the addresses to 8 hex digits
- add 'reg' to the mdp device

v1: https://lore.kernel.org/r/20230406-topic-qciommu-v1-1-03f17717a447@linaro.org
---
 .../devicetree/bindings/iommu/qcom,iommu.txt       | 122 ---------------------
 .../devicetree/bindings/iommu/qcom,iommu.yaml      | 113 +++++++++++++++++++
 2 files changed, 113 insertions(+), 122 deletions(-)

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
index 000000000000..d9fabdf930d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
@@ -0,0 +1,113 @@
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
+    additionalProperties: false
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
+    required:
+      - compatible
+      - interrupts
+      - reg
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

---
base-commit: 8417c8f5007bf4567ccffda850a3157c7d905f67
change-id: 20230406-topic-qciommu-7c713de8ff9e

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

