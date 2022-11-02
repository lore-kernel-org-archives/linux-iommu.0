Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B6A24F35
	for <iommu@lists.linux.dev>; Wed,  2 Nov 2022 18:44:27 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id be13so29695679lfb.4
        for <iommu@lists.linux.dev>; Wed, 02 Nov 2022 11:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9r2jAN2ifM7pblPIEyP95isDltMBDbHzODH4f5j+ec=;
        b=GkLtVQFrTmCoWJAdWKLUzRF0bkN0rJSMIkzNY/RbLd3/jsknE1BT12p03gt5WipbTl
         P7pXWDwyiNYT9sb9mm5k430Z0UrLLTASEhhOfUmwr5c+CPB+wYCgBd1z/icDwKN386yK
         reLfjyCBHptPoAP7vSkvAPlp9qE2Ngqzma1KeEHxRuwmL/zX6yfcU8q9GbEI/AqUfyug
         1SCfY+ykv999+29pA64kLXlAVLGjMCqEitnJ75oppXpOhmV61r+c8eEb5A5DJPd4Bkyj
         RYmMOmIf5Ssqto3A4akbaYyLmLjv8ATJJpjmUEAPBafJO55IB1PEIaqUIDOewTqNSvJx
         hWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9r2jAN2ifM7pblPIEyP95isDltMBDbHzODH4f5j+ec=;
        b=cQfzha/mCI0xbu31kRE+7AZAplSMed6VSfa6okatl5h27OPibJuAzt1tLp5I4PSioa
         q74BsxvVBVJAnWS+E5iZZG5w49GgmKykM4EcJQnO0Yld8CYl7BD53ZpantteUoiHmpdn
         FmDjqjye9/47Y5gmH4Nw4PWSKA7LfF4JO55TlZvVzdRMm8eeYUgG3sjjdFoAN86eyQLw
         YU9CT6s+p/FIetVsBg1CxrnxVupSLXlkWmD4JVjH8ueYsSsY2fuD25Dv7NE5Xa/P3l/B
         3paM+T6g9BtnKJPnxsYiNAqU+WTOjGGiGdrV2YD0/vkjDQ4fY+EPhDg0i3T4pvfbnVFO
         8lyA==
X-Gm-Message-State: ACrzQf2c2831pSBZrqhXfb0uAnwM3xJIZcQyHt+ukVraS9zYGiNOsHib
	MyR2VONsLV+rC5j9h9StyPnUyA==
X-Google-Smtp-Source: AMsMyM7cRAF+kWHvjLNKh5hA16h9oGLKiTSz4U9zXLRvrHTsSM081VyNEeJEIBJv5/JjmxmjG7nT3g==
X-Received: by 2002:a05:6512:308d:b0:4a2:5958:3443 with SMTP id z13-20020a056512308d00b004a259583443mr9865150lfd.208.1667414665475;
        Wed, 02 Nov 2022 11:44:25 -0700 (PDT)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t8-20020a05651c204800b00277092c03e7sm2277540ljo.33.2022.11.02.11.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:44:25 -0700 (PDT)
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
	freedreno@lists.freedesktop.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFC PATCH v2 05/11] dt-bindings: arm-smmu: Add generic qcom,smmu-500 bindings
Date: Wed,  2 Nov 2022 21:44:14 +0300
Message-Id: <20221102184420.534094-6-dmitry.baryshkov@linaro.org>
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

Add generic bindings for the Qualcomm variant of the ARM MMU-500. It is
expected that all future platforms will use the generic qcom,smmu-500
compat string in addition to SoC-specific and the generic arm,mmu-500
ones. Older bindings are now described as deprecated.

Note: I have split the sdx55 and sdx65 from the legacy bindings. They
are not supported by the qcom SMMU implementation. I can suppose that
they are using the generic implementation rather than the
Qualcomm-speicific one.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml   | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index f44572cbb071..3d4cc8996195 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -31,7 +31,7 @@ properties:
               - qcom,sdm630-smmu-v2
           - const: qcom,smmu-v2
 
-      - description: Qcom SoCs implementing "arm,mmu-500"
+      - description: Qcom SoCs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
               - qcom,qcm2290-smmu-500
@@ -40,8 +40,34 @@ properties:
               - qcom,sc8180x-smmu-500
               - qcom,sc8280xp-smmu-500
               - qcom,sdm845-smmu-500
+              - qcom,sm6350-smmu-500
+              - qcom,sm6375-smmu-500
+              - qcom,sm8150-smmu-500
+              - qcom,sm8250-smmu-500
+              - qcom,sm8350-smmu-500
+              - qcom,sm8450-smmu-500
+          - const: qcom,smmu-500
+          - const: arm,mmu-500
+
+      - description: Qcom SoCs implementing "arm,mmu-500" (non-qcom implementation)
+        deprecated: true
+        items:
+          - enum:
               - qcom,sdx55-smmu-500
               - qcom,sdx65-smmu-500
+          - const: arm,mmu-500
+
+      - description: Qcom SoCs implementing "arm,mmu-500" (legacy binding)
+        deprecated: true
+        items:
+          # Do not add additional SoC to this list. Instead use two previous lists.
+          - enum:
+              - qcom,qcm2290-smmu-500
+              - qcom,sc7180-smmu-500
+              - qcom,sc7280-smmu-500
+              - qcom,sc8180x-smmu-500
+              - qcom,sc8280xp-smmu-500
+              - qcom,sdm845-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
               - qcom,sm8150-smmu-500
-- 
2.35.1

