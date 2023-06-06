Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A937B77
	for <iommu@lists.linux.dev>; Tue,  6 Jun 2023 12:44:13 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4f61735676fso5066753e87.2
        for <iommu@lists.linux.dev>; Tue, 06 Jun 2023 05:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686055451; x=1688647451;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtO5yZHuSM0t6c/z6X2y/6soY6yAi0KjD9hnj5CK/NU=;
        b=JkVQ+vlBiy5SsARr1oxpTEpZiPuNikdXZK1X5zUDZDuoy1j/p9XoKY1vV3mByXlkRO
         uDuNUz4zKKRoLuAByb2Jogv3Z5ks3tWdrtobpA7TYo5woi6t3vVMle73kZybwK2kF17s
         7B++dwLR4cxQsOURr2jFrHXWkmrXaFvbSlT4dZZpl65/ZHqrUAsiEfH0ckoGF5sw5HLl
         5QrajCUCDQeMalbBnLvtKPjkPZeHnwVxvVYLUJrkBUaLs1rK8QZI1tuJifrL09NuK8XF
         zV8OW8IVuc60s+EqSDJoOzBmTnG9vde0m8NxFyhLQTxysDjBRvfu+OePAZXXKQyXkAm4
         4Zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686055451; x=1688647451;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZtO5yZHuSM0t6c/z6X2y/6soY6yAi0KjD9hnj5CK/NU=;
        b=lENRRcjro2s0e4F4kYyPcyMdKoE4M6oBWHslKYdR5VHSnQC0Cm9EB3Midk7Ra+SNGJ
         +O375bQ66dqEEERQ33kT4sQxm6Y7l4RXSQU4kTUN69r4vZ2nYw5oHLyLaG8UabPrEKm3
         z6a0tGxOc+skNhmzlgc8FoHsI+jnnsoWZciQl0O7dgAo8QwI86Hv/PosXN2Q8KO86zBK
         /NOGdigFMWDnhWtK7za5ezBODU2B+nGPNOi119ag765byu1wk0VinfdXr2ebkRXnf4o7
         UcYAEvagYRwr+RLT0ylYKz0pGsRUENz5VFvMj1pUwkoCVe6GxaD5iVhQ7jLa/lQWocWg
         P8kQ==
X-Gm-Message-State: AC+VfDzqxZNiHbUpq1wzjGiaNfHMC1GQB0mSd3vwHn96DhZHFeec6EPZ
	q0aytQ5A8GjiNw8Er9+eAydZcA==
X-Google-Smtp-Source: ACHHUZ4qu3rtG31QF/b3MvYS8AxWhGz2z1v7iP/p0tcwkqC+YgogLZ9rWxWfacJ05P9IxlvSNcvCUw==
X-Received: by 2002:a05:6512:518:b0:4f1:4040:8143 with SMTP id o24-20020a056512051800b004f140408143mr739001lfb.60.1686055451516;
        Tue, 06 Jun 2023 05:44:11 -0700 (PDT)
Received: from [192.168.1.101] (abyl150.neoplus.adsl.tpnet.pl. [83.9.31.150])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e9f17000000b002a9ebff8431sm1830823ljk.94.2023.06.06.05.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 05:44:11 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 06 Jun 2023 14:43:54 +0200
Subject: [PATCH v6 03/12] dt-bindings: display/msm: sc7180-dpu: Describe
 SM6350 and SM6375
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v6-3-dee6a882571b@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v6-0-dee6a882571b@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686055444; l=2184;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=kGZixoL9TdPt1fMj+QOtYWJQqvd3Vxxtj53Bf9LtZ4g=;
 b=Ha0c1GfN6BOvbA1JGOlqNyY8GUzXWKddEAnl3zWJJypmPfDROIBAWotA7BM9urvvax9qz3WoC
 Z0wfcvYoHdvAwUVAf45k4Px4t4z7IbxF7wB3gjfGR9gB+zGS3FfJyMh
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

SC7180, SM6350 and SM6375 use a rather similar hw setup for DPU, with
the main exception being that the last one requires an additional
throttle clock.

It is not well understood yet, but failing to toggle it on makes the
display hardware stall and not output any frames.

Document SM6350 and SM6375 DPU.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/display/msm/qcom,sc7180-dpu.yaml      | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
index 1fb8321d9ee8..630b11480496 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
@@ -13,7 +13,10 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 
 properties:
   compatible:
-    const: qcom,sc7180-dpu
+    enum:
+      - qcom,sc7180-dpu
+      - qcom,sm6350-dpu
+      - qcom,sm6375-dpu
 
   reg:
     items:
@@ -26,6 +29,7 @@ properties:
       - const: vbif
 
   clocks:
+    minItems: 6
     items:
       - description: Display hf axi clock
       - description: Display ahb clock
@@ -33,8 +37,10 @@ properties:
       - description: Display lut clock
       - description: Display core clock
       - description: Display vsync clock
+      - description: Display core throttle clock
 
   clock-names:
+    minItems: 6
     items:
       - const: bus
       - const: iface
@@ -42,6 +48,7 @@ properties:
       - const: lut
       - const: core
       - const: vsync
+      - const: throttle
 
 required:
   - compatible
@@ -52,6 +59,20 @@ required:
 
 unevaluatedProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: qcom,sm6375-dpu
+
+    then:
+      properties:
+        clocks:
+          minItems: 7
+
+        clock-names:
+          minItems: 7
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,dispcc-sc7180.h>

-- 
2.40.1

