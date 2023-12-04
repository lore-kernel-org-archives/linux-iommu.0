Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDEA24215
	for <iommu@lists.linux.dev>; Mon,  4 Dec 2023 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pFEBrg2U"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40c032962c5so25281315e9.3
        for <iommu@lists.linux.dev>; Mon, 04 Dec 2023 04:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701694538; x=1702299338; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VYbVKXhxANMzmAo5DevDefivd0gCsbNC7OR7kQaPmk=;
        b=pFEBrg2U9udT8J1s+E/UFSgHH8RbxphNQTNYY1Oba22RBkWyTSbzgZnMEKRc1R6MFj
         niC1CFCkcX5WmqeL2YYv59HoCT/6Mj8sP5ODkO5y8pyhy3e4Q1Hkc6sl2ALKh4bEfFbK
         kpn36iAvcFx7FTMo6bLUDTARh/CqcLl9cH2l/yAKr6wG3hozUsn1IB5fWM92Jwk+BIjd
         KkVbKmIu46n0F46cpBz1paj6TSGImbNYoip2bWJix4QTRioFer4AzOBDWkEz3gAGy1VS
         DoxckAQiOq6Xpk49zBOA7Snw/+BT04ABM+DLnMWXr2zlztZY/97HcrW0L+ekJUpUF7aM
         OjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701694538; x=1702299338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4VYbVKXhxANMzmAo5DevDefivd0gCsbNC7OR7kQaPmk=;
        b=AwA/vg4Tqlv2A0jy9pa06MYz17UJzz/DZEjUd7LcMneTfYamKG6BY0t6I95rthHosF
         33ui/55BsgM2cE0XSvDpvo2rUUTdFebNuhBMXKhVfCc77e73pofZHJRIsAQHWUkNS6iI
         UrqdoSjYi+zYtTHZ3AekX0+DkxmUxuH6vKeXsKtE6AfphvfOaLvCpxan2nLiokGD9DT/
         Eb8IQ/GqHi1W6X0XnFKS/e2py/Wyjvid2tR2WEO7Wt7RmFqeNgsbYbr9IPQKnsO5S8b5
         FXFmN9xRU9I4D+If7vHw0UdfPyJEsS6lqmXOgeQXL6+0V4MLfQkpG0dfZ2Qgxk/CsPRW
         vMnA==
X-Gm-Message-State: AOJu0Ywp7MrR8E+ZtAMJvlQA5D/+rmBzVFiFTKCdlV/nVQJYjaZuuB36
	ELBcSegD4cB5leG4KypWP6FUSQ==
X-Google-Smtp-Source: AGHT+IF20KkqSBNgI0V5q5M23rtNvOl2oHvkQdd+994YeANMyI+Y4stIiq0gluNCbAppjSBRCJtivg==
X-Received: by 2002:a05:600c:1385:b0:40b:3fc7:c88a with SMTP id u5-20020a05600c138500b0040b3fc7c88amr1831169wmf.39.1701694537845;
        Mon, 04 Dec 2023 04:55:37 -0800 (PST)
Received: from [10.167.154.1] (178235179097.dynamic-4-waw-k-1-3-0.vectranet.pl. [178.235.179.97])
        by smtp.gmail.com with ESMTPSA id ay22-20020a170906d29600b009efe6fdf615sm5241373ejb.150.2023.12.04.04.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:55:37 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 04 Dec 2023 13:55:20 +0100
Subject: [PATCH v2 1/6] dt-bindings: arm-smmu: Document SM8[45]50 GPU SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231127-topic-a7xx_dt-v2-1-2a437588e563@linaro.org>
References: <20231127-topic-a7xx_dt-v2-0-2a437588e563@linaro.org>
In-Reply-To: <20231127-topic-a7xx_dt-v2-0-2a437588e563@linaro.org>
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
 linux-arm-msm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701694533; l=2754;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1ykSmvOZZDjJjgZpitbyB4XwAgvbWrZhIXxM64S4nPE=;
 b=lj3IMiwPIJxgczSTOsCkVKkVF04JuQ2p6btaSUMQQGimuIK9Sqsb4x4moWx+oYn8OzCWFpfam
 br91WBeade2BjmO2oLO7ObprbqxSPbY8KcKz1j29Mnt3F70tYkAnC9D
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

SM8450 and SM8550 both use a Qualcomm-modified MMU500 for their GPU.
In both cases, it requires a set of clocks to be enabled. Describe that.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

