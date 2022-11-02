Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE2929A0
	for <iommu@lists.linux.dev>; Wed,  2 Nov 2022 18:44:25 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id o12so29664106lfq.9
        for <iommu@lists.linux.dev>; Wed, 02 Nov 2022 11:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjQd6UNyWrjAhnyztqxtFEHn1LDMyyYEmKpO/gpJ2tY=;
        b=zenGWiy2/WRie8W8g1NmvOF9TdFYAf8HEHRLJMfi+XmNrepGLOxAuvnP1khA1iikla
         azp/w7c+h2AnoUSvUSdxrUqoBuwGH1CBPi78U6CS1xoqf1sb+gmMusiqptOfVWhYSqoE
         e596zEFEsmEhhBhXLJlsVPVam8zbxHqQ6mhxjnDJfoWRj8UsjmQfuC9NXWWyHWRs8BXC
         OLFI3RlbX2AsD/Ybz9gHrpoBVrvbCisYBGR2ntAK1V2naFDwQFXFe7+BaB0U5SmyFoH1
         SX3jeg1Lv2of6z8ricOV1yHSxgDI1vriT9LcnQy6WxHPwPfy5H/iUOLKFI6TXyq8ckL7
         QiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjQd6UNyWrjAhnyztqxtFEHn1LDMyyYEmKpO/gpJ2tY=;
        b=yfWrkX9Q7EzePIXX9wuhZdx0dZ7MM0CnEbaaADJBYvuvJT1xBWs8v5iqj0eB0JWFnl
         hg3AQTsnZAmG6u8hIiCUKDyJYL58STF68QeHScnvSdSDbcuPUoY/RA9IpD16gMlNgwaB
         Qo6ynHACOAZ1tpJ1JaKjEc22aXZWz4cMa/+dqKIwL8sdHpB7GU5KeExPbgNPW+72zxSy
         3N7BPCOG5SvcA2aBT4h2ba5lguze9GONampjja++rw9baqJKU+b19oNcr0zIQGQ9zSwI
         a46mPlEosNO+F5kf5EAxNti0hOukACsSVDNmsAuK2U8FUATLR6FnTqmTey5lcDLa6h8h
         /F7Q==
X-Gm-Message-State: ACrzQf3uEjJzvZVlMRLFLjK6PaHBCvVxiq9TgdthtN6zeWoHSZk7KJne
	7Kbre2CQfDc6betRDwlOWqI3mg==
X-Google-Smtp-Source: AMsMyM5DrJtqmEAzjAJr5iy1tm2AWNkMmin7gc/opRXu5QHBbk7rrZC6RTdVxgLgi/5d3MSHFV7TRw==
X-Received: by 2002:a19:5f16:0:b0:4ae:8476:2d1 with SMTP id t22-20020a195f16000000b004ae847602d1mr9379390lfb.688.1667414664034;
        Wed, 02 Nov 2022 11:44:24 -0700 (PDT)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t8-20020a05651c204800b00277092c03e7sm2277540ljo.33.2022.11.02.11.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:44:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Rob Clark <robdclark@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	freedreno@lists.freedesktop.org
Subject: [RFC PATCH v2 03/11] dt-bindings: arm-smmu: fix clocks/clock-names schema
Date: Wed,  2 Nov 2022 21:44:12 +0300
Message-Id: <20221102184420.534094-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221102184420.534094-1-dmitry.baryshkov@linaro.org>
References: <20221102184420.534094-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework clocks/clock-names properties schema to property describe
possible usage cases.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml   | 129 ++++++++++++++++--
 1 file changed, 121 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 34ee33a62ba5..abcb1ee4b58f 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -158,16 +158,12 @@ properties:
       present in such cases.
 
   clock-names:
-    items:
-      - const: bus
-      - const: iface
+    minItems: 1
+    maxItems: 7
 
   clocks:
-    items:
-      - description: bus clock required for downstream bus access and for the
-          smmu ptw
-      - description: interface clock required to access smmu's registers
-          through the TCU's programming interface.
+    minItems: 1
+    maxItems: 7
 
   power-domains:
     maxItems: 1
@@ -217,6 +213,123 @@ allOf:
         reg:
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8998-smmu-v2
+              - qcom,sdm630-smmu-v2
+    then:
+      anyOf:
+        - properties:
+            clock-names:
+              items:
+                - const: bus
+            clocks:
+              items:
+                - description: bus clock required for downstream bus access and for
+                    the smmu ptw
+        - properties:
+            clock-names:
+              items:
+                - const: iface
+                - const: mem
+                - const: mem_iface
+            clocks:
+              items:
+                - description: interface clock required to access smmu's registers
+                    through the TCU's programming interface.
+                - description: bus clock required for memory access
+                - description: bus clock required for GPU memory access
+        - properties:
+            clock-names:
+              items:
+                - const: iface-mm
+                - const: iface-smmu
+                - const: bus-mm
+                - const: bus-smmu
+            clocks:
+              items:
+                - description: interface clock required to access mnoc's registers
+                    through the TCU's programming interface.
+                - description: interface clock required to access smmu's registers
+                    through the TCU's programming interface.
+                - description: bus clock required for downstream bus access
+                - description: bus clock required for the smmu ptw
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8996-smmu-v2
+              - qcom,sc7180-smmu-v2
+              - qcom,sdm845-smmu-v2
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: bus
+            - const: iface
+
+        clocks:
+          items:
+            - description: bus clock required for downstream bus access and for
+                the smmu ptw
+            - description: interface clock required to access smmu's registers
+                through the TCU's programming interface.
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sc7280-smmu-500
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: gcc_gpu_memnoc_gfx_clk
+            - const: gcc_gpu_snoc_dvm_gfx_clk
+            - const: gpu_cc_ahb_clk
+            - const: gpu_cc_hlos1_vote_gpu_smmu_clk
+            - const: gpu_cc_cx_gmu_clk
+            - const: gpu_cc_hub_cx_int_clk
+            - const: gpu_cc_hub_aon_clk
+
+        clocks:
+          items:
+            - description: GPU memnoc_gfx clock
+            - description: GPU snoc_dvm_gfx clock
+            - description: GPU ahb clock
+            - description: GPU hlos1_vote_GPU smmu clock
+            - description: GPU cx_gmu clock
+            - description: GPU hub_cx_int clock
+            - description: GPU hub_aon clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8150-smmu-500
+              - qcom,sm8250-smmu-500
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: ahb
+            - const: bus
+            - const: iface
+
+        clocks:
+          items:
+            - description: bus clock required for AHB bus access
+            - description: bus clock required for downstream bus access and for
+                the smmu ptw
+            - description: interface clock required to access smmu's registers
+                through the TCU's programming interface.
+
 examples:
   - |+
     /* SMMU with stream matching or stream indexing */
-- 
2.35.1

