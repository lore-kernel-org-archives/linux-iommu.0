Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE85F14A92
	for <iommu@lists.linux.dev>; Sun, 12 Nov 2023 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/Di1WVF"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5afabb23900so43961777b3.2
        for <iommu@lists.linux.dev>; Sun, 12 Nov 2023 10:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699814726; x=1700419526; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=au8K9WY/iUombJX3p1nFVf4VIUhW2X2Wokmw1tQzis4=;
        b=W/Di1WVF3uwhOurYZ2RkwAqqRfLrnZLz5v+yWQTpAhU1AtHX0iNE3EPCeJ3tB1uS2R
         325SoGbO3nNskOL0kYMQciZpV5TcsuzqaIPoQK+AuhxzuoCvOaccvre8JM7cfz4Cz1QT
         Ht1GkdQJ03Z5YyKkUaDY1ydI83bZsYFEBulsutsnugQrdDYe7KJR//0TVwLZFyo9YrzY
         d5C4kplHBN4lCxt8fqLVCWYl9sjYucYuCtrre181H2RjpWASWsmucKDRf7055f8MqdU3
         r1kXUTobIHgSFH+SFE2FAqRBQNsegzCQQSVUTGSArDXKMQKlVumQUHY59J2HhSdrU68P
         4SKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699814726; x=1700419526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=au8K9WY/iUombJX3p1nFVf4VIUhW2X2Wokmw1tQzis4=;
        b=HYx3qKhY7eKREIM24c0vFSD3d6njw3DVRPqfCTAK674/n82TVGlUfWbsaW1jxkIbU6
         7e33LuNBPmDCrcNAjHH/yl9jt8DvNGGrCgceRgN5eUEPE9K7ZHxrw3nmvgqELbnx1ZHH
         2zz71NcRrqokfHtbPnjPMHqSQOz1gC6VkbvAtRA8keRmIFlUJukyW5ffHlRAcz1OlL1+
         K6I2tilBtzNC7bhuviVT7wcrSnLYPk5HfDC2rNsgTfUPJizjNgffKjunEX/NRxzAqzQQ
         v25n7xB6eQMnExzoiPwS1s1hZQxPfpu+XpZJW4aRrI0GZuD/NXZjVs9dH41yYbkYk3FF
         4yNw==
X-Gm-Message-State: AOJu0YxijAE1CO/HUtI/5KIJYkmDQr0fAKZz1Qbk590agyeCQkxlwtLp
	EnSyFRY2VLbCeWEbp5TAItdWrQ==
X-Google-Smtp-Source: AGHT+IF2udF2fwlU8PET8WHgbCKxefUzJrVDCjzQhTvpy1I45HhFrhD+hAOgyXZZdHCtBcEhLIyDSA==
X-Received: by 2002:a0d:d781:0:b0:5a7:d9e6:8fc6 with SMTP id z123-20020a0dd781000000b005a7d9e68fc6mr5142491ywd.39.1699814725807;
        Sun, 12 Nov 2023 10:45:25 -0800 (PST)
Received: from krzk-bin.. ([12.161.6.170])
        by smtp.gmail.com with ESMTPSA id u63-20020a0deb42000000b005b3f6c1b5edsm1309473ywe.80.2023.11.12.10.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 10:45:25 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: iommu: arm,smmu: document clocks for the SM8350 GPU SMMU
Date: Sun, 12 Nov 2023 19:45:22 +0100
Message-Id: <20231112184522.3759-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the clocks for Qualcomm SM8350 Adreno GPU SMMU, already used in
DTS:

  sm8350-hdk.dtb: iommu@3da0000: clock-names: False schema does not allow ['bus', 'iface', 'ahb', 'hlos1_vote_gpu_smmu', 'cx_gmu', 'hub_cx_int', 'hub_aon']

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml   | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 54c333ddf916..14dc54b0e7b3 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -429,6 +429,30 @@ allOf:
             - description: interface clock required to access smmu's registers
                 through the TCU's programming interface.
 
+  - if:
+      properties:
+        compatible:
+          items:
+            - enum:
+                - qcom,sm8350-smmu-500
+            - const: qcom,adreno-smmu
+            - const: qcom,smmu-500
+            - const: arm,mmu-500
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: bus
+            - const: iface
+            - const: ahb
+            - const: hlos1_vote_gpu_smmu
+            - const: cx_gmu
+            - const: hub_cx_int
+            - const: hub_aon
+        clocks:
+          minItems: 7
+          maxItems: 7
+
   - if:
       properties:
         compatible:
@@ -472,7 +496,6 @@ allOf:
               - qcom,sdx65-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
-              - qcom,sm8350-smmu-500
               - qcom,sm8450-smmu-500
               - qcom,sm8550-smmu-500
     then:
-- 
2.34.1

