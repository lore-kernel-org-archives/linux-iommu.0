Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BC628EA
	for <iommu@lists.linux.dev>; Wed, 15 Mar 2023 10:52:16 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id x17so7596709lfu.5
        for <iommu@lists.linux.dev>; Wed, 15 Mar 2023 03:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678877534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEwHDjEfUnaOF5mDQxskyKGW9CTDYJ/EYRnSGpx6ORg=;
        b=eV+aNYACp1h/O61nrXpn47S06WK2FmoI0XfsVpQnUYKvJmP0LO6n1W+vry1aBDT7lP
         2ALJw0tMMoLKtftidS+syV6KJ9Sna0QpbbXqYGth4e7rGSQxi0cXNUaOtkLdit2dnwrt
         jNt75UfJIoSQsRhRtmZHq7ybWaJk5JZSQ9I+uDC2zI+gO4iHI6abG9RSjvGn1tnU1MFd
         gdBLDGOMn0pvhAGSeo8GPMJ4Nl0CwSqKJTO2udxqIwfQejPqoewfwrFwPTb6iR+Gwoi1
         jff/e5DTzVfs1f4H3XCeNHz2tihnaegcYXjrLISRVd+kvYK1bkZGML827BiKT8FAw+V1
         NVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678877534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEwHDjEfUnaOF5mDQxskyKGW9CTDYJ/EYRnSGpx6ORg=;
        b=huWX6Kf5UfK0PRBSvScEkNp5DoeK6Ceptv1J5rlyMgcXr0Hd/WpJR4ClR0ZzpTTvdg
         JniL+6KsAw0UGy3BYs/Z75xcFG/4bRy03HIwnXE+fNRT3sV/s7EZO8rYbRlvUrKEXdbr
         0fBFUeOysJP2mMu/X41Gv7L6owbBTObVVWlLX7SgdGzzOYEeIR7MKBaeqTVkblZL5cyt
         Gzfj8yM3ybKG2T5UUNhYUB9GMMGnWCjD41f88/tA0vCz/ORPdEUBeeqzt+8Ut6sOvnnj
         EKOHfwSUZfynJrAHRLUxN+Qi6z6uSDD4xvbg/WH4+K4GSg3xcH/MJkG69qbADQoRixPx
         VV0g==
X-Gm-Message-State: AO0yUKVpE1mPGzNMZud9ievXH4EvqfpGbyorUWTOekWm3uhcTQz+eyhk
	D/03D7NcYxUNlir3GSGNJEv2NQ==
X-Google-Smtp-Source: AK7set9YPAexQQAuzQbhCqyy9Nk9G4MaoZQC9AKF39lCT+02JcrgOWL/5/Zw1vuRA0D1GaTerNn0sw==
X-Received: by 2002:a05:6512:114f:b0:4dd:9f03:1f7e with SMTP id m15-20020a056512114f00b004dd9f031f7emr1735699lfg.22.1678877534340;
        Wed, 15 Mar 2023 03:52:14 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id q3-20020ac25fc3000000b004d856fe5121sm767791lfg.194.2023.03.15.03.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 03:52:13 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 15 Mar 2023 11:52:08 +0100
Subject: [PATCH 1/2] dt-bindings: arm-smmu: Document SM61[12]5 GPU SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230315-topic-kamorta_adrsmmu-v1-1-d1c0dea90bd9@linaro.org>
References: <20230315-topic-kamorta_adrsmmu-v1-0-d1c0dea90bd9@linaro.org>
In-Reply-To: <20230315-topic-kamorta_adrsmmu-v1-0-d1c0dea90bd9@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678877530; l=2607;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JaZgFPnneZ9HeE1XCgzUVaq2L6fgv/yMBSZREyHciPk=;
 b=48Y0l+WzxQs+J6eAfEUnHyzPTYixLUt3M2Rwl5Wjv2xfr7A36Ze5/S2CuGUaF3mMhSsxRylG5ps7
 gKNRazM3B660iLR1/7lohJ6QuscG1v1OLkNhjtCwlcP+3YbpnbyT
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Both of these SoCs have a Qualcomm MMU500 implementation of SMMU
in front of their GPUs that expect 3 clocks. Both of them also have
an APPS SMMU that expects no clocks. Remove qcom,sm61[12]5-smmu-500
from the "no clocks" list (intentionally 'breaking' the schema checks
of APPS SMMU, as now it *can* accept clocks - with the current
structure of this file it would have taken a wastefully-long time to
sort this out properly..) and add necessary yaml to describe the
clocks required by the GPU SMMUs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml        | 28 ++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a6224b7e5310..62c7a5ff148e 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -79,6 +79,8 @@ properties:
         items:
           - enum:
               - qcom,sc7280-smmu-500
+              - qcom,sm6115-smmu-500
+              - qcom,sm6125-smmu-500
               - qcom,sm8150-smmu-500
               - qcom,sm8250-smmu-500
               - qcom,sm8350-smmu-500
@@ -375,6 +377,30 @@ allOf:
             - description: interface clock required to access smmu's registers
                 through the TCU's programming interface.
 
+  - if:
+      properties:
+        compatible:
+          items:
+            - enum:
+                - qcom,sm6115-smmu-500
+                - qcom,sm6125-smmu-500
+            - const: qcom,adreno-smmu
+            - const: qcom,smmu-500
+            - const: arm,mmu-500
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: mem
+            - const: hlos
+            - const: iface
+
+        clocks:
+          items:
+            - description: GPU memory bus clock
+            - description: Voter clock required for HLOS SMMU access
+            - description: Interface clock required for register access
+
   # Disallow clocks for all other platforms with specific compatibles
   - if:
       properties:
@@ -394,8 +420,6 @@ allOf:
               - qcom,sdm845-smmu-500
               - qcom,sdx55-smmu-500
               - qcom,sdx65-smmu-500
-              - qcom,sm6115-smmu-500
-              - qcom,sm6125-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
               - qcom,sm8350-smmu-500

-- 
2.39.2

