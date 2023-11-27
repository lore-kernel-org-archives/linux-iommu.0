Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7515935F1F
	for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZJ0jnk0"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a011e9bf336so611733766b.3
        for <iommu@lists.linux.dev>; Mon, 27 Nov 2023 08:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701102013; x=1701706813; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4Qar7YCtECHHHtbAdP3JjSDpAvBK1JG0fUmDN50K9U=;
        b=WZJ0jnk0bN9SLXwevUBItIdX8/3K1iTdpGYIXqY4lgZkOOYTteU57LF+LysnTPPVUv
         o1LM5FZoU0lW/lz0hZUQeFtPaIUb1Lswu2fIklFexeQyYpCqe1n9osKBRJZsZkq/X3/q
         hZPXgd1jI/TrTe9Ot1qF7oSCafvmwdjlU87njrb21A1XCwZyv21mPQMCK+x+SB1CA/Cn
         OSgvXO1p6vpeyLzMaJ+/+1gDXldQTiXOmvbiCpbfs8BKEuSgopDz6enmxtkVXLYd/D7/
         LtNeH36xxdKE9gSbMLZaXygF7XSntcrKbhsboNJ4KqwC+EgAMHnfyJ+bHZu4+DL7pgvL
         owhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701102013; x=1701706813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4Qar7YCtECHHHtbAdP3JjSDpAvBK1JG0fUmDN50K9U=;
        b=KInAfKoxutvCnCOmRrYuyuQaMSJCccmlQeNciV3oBjie5AuHY6WsIZakC/6hwVsyiV
         y2fjEQvWLVdQ4jbzt2pOus87slNmX7POEEu/AN6Tw3/CUNbn5cjZZbP7n0U0VE14QZLw
         r0fTnyBHf6hxD5s15BCpL7/R+/ckp8GZQDHZ/rH+wZ7a/XXs6n1z8W96ko7aRXSJ2q4b
         ENccE4u2zT4bPaJ5C7cEzF3MfRUf9AYx/hKYizQh2aBAJuyMge82w8Ju2dCWY7Pv26+N
         qiZ/j2i0vx3OUHHUDsQKnTgw/iBtbubvik02qGhICMEuZDYmKIpA5Wk+fpzw0IubgmZw
         pUTw==
X-Gm-Message-State: AOJu0YzixXt8pZopQMLXMdVsSbvUcj8IydT2sgmgd9slRq5f1FcfGg1p
	BnzzbO8rePTlyxlDyv4j6K6Xxg==
X-Google-Smtp-Source: AGHT+IF2zH3PWtUHX1jYKPVrd2c0nOGMkqPFufplsRrEuosRu8zLboazblnBYXTJ0eNzXlHNagLNiA==
X-Received: by 2002:a17:906:fad6:b0:a10:d5ef:ff00 with SMTP id lu22-20020a170906fad600b00a10d5efff00mr1855674ejb.2.1701102012755;
        Mon, 27 Nov 2023 08:20:12 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709062acc00b009c3828fec06sm5734760eje.81.2023.11.27.08.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 08:20:12 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 27 Nov 2023 17:20:03 +0100
Subject: [PATCH 1/6] dt-bindings: arm-smmu: Document SM8[45]50 GPU SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-topic-a7xx_dt-v1-1-a228b8122ebf@linaro.org>
References: <20231127-topic-a7xx_dt-v1-0-a228b8122ebf@linaro.org>
In-Reply-To: <20231127-topic-a7xx_dt-v1-0-a228b8122ebf@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701102008; l=2687;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=74tAYPhFS0JRCe3sr6MjDifnedbnYgVr+albesY88R0=;
 b=No3Vb43Hd8bD4NOsHXSg5ppXhq7oWxb1HCy48OeWtBGzmM/Vf85XVb4qfsN85FKcmgSofqivP
 np1tT3yPxGoBCcURjbxS75Vp3ViOIvu5TsM+75m9B+XJYAMDFfL629i
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

SM8450 and SM8550 both use a Qualcomm-modified MMU500 for their GPU.
In both cases, it requires a set of clocks to be enabled. Describe that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml        | 48 +++++++++++++++++++++-
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index aa9e1c0895a5..19dba93a7654 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -89,6 +89,8 @@ properties:
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
               - qcom,sm8350-smmu-500
+              - qcom,sm8450-smmu-500
+              - qcom,sm8550-smmu-500
           - const: qcom,adreno-smmu
           - const: qcom,smmu-500
           - const: arm,mmu-500
@@ -453,6 +455,50 @@ allOf:
             - description: Voter clock required for HLOS SMMU access
             - description: Interface clock required for register access
 
+  - if:
+      properties:
+        compatible:
+          const: qcom,sm8450-smmu-500
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: gmu
+            - const: hub
+            - const: hlos
+            - const: bus
+            - const: iface
+            - const: ahb
+
+        clocks:
+          items:
+            - description: GMU clock
+            - description: GPU HUB clock
+            - description: HLOS vote clock
+            - description: GPU memory bus clock
+            - description: GPU SNoC bus clock
+            - description: GPU AHB clock
+
+  - if:
+      properties:
+        compatible:
+          const: qcom,sm8550-smmu-500
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: hlos
+            - const: bus
+            - const: iface
+            - const: ahb
+
+        clocks:
+          items:
+            - description: HLOS vote clock
+            - description: GPU memory bus clock
+            - description: GPU SNoC bus clock
+            - description: GPU AHB clock
+
   # Disallow clocks for all other platforms with specific compatibles
   - if:
       properties:
@@ -473,8 +519,6 @@ allOf:
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
               - qcom,sm8350-smmu-500
-              - qcom,sm8450-smmu-500
-              - qcom,sm8550-smmu-500
     then:
       properties:
         clock-names: false

-- 
2.43.0

