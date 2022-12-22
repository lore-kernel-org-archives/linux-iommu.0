Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6258F2563
	for <iommu@lists.linux.dev>; Thu, 22 Dec 2022 09:24:31 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id bp15so1806642lfb.13
        for <iommu@lists.linux.dev>; Thu, 22 Dec 2022 01:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=68vQHDAyfLGGKwktfUmbOivt9MYU5nkUryP23gTK9rc=;
        b=Kip7m14Xx/tarhFOdy0J023i0JBfWs63+4+z8MBWphGmFJuVzcG2VvN8GOJda5dMTq
         7PlAP4gg67X7bhNNylVt/nUYE2COvdoNgidOoxIMVVZCljcEVk2F0f7qTMSNZGSl+1WI
         XeUtodjxd9xDRpqogO5b6pvoTGQbw8UZD1osYWJ7bjCPl6gg5YdaDOIJ2WfNH0UoMXCb
         agWbFKevRVcIQ4SlXRFXWjacmIgLqmjluQ1i4lVWLVe5bvu3vwAT53AlvQ1aLIkcaubX
         qZ7Mlmni4RDfYhwGUBPZ33lOVMQEvSkCXs3gauwe7QtJTI27jH1kPe6f3gSoWaEDWDXL
         C0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68vQHDAyfLGGKwktfUmbOivt9MYU5nkUryP23gTK9rc=;
        b=P3UfkwparQidySGgd5h2panz1dJ7pcOoIUS/2rTU15r9bAZxS3jvhAoHUy2ZxBM655
         0WG5Koizs6ItskF78Js+Yu4n9BrlXh8aEwgYBxknHpjv6+oTzXpQ7cczYTa5g/KY7+a9
         qIpZ4GzUAsZEBCH9R6xF40yGXljmaidVI8tlY+GF5KNn1NpWsW316uX2RmV20tjCiuA4
         OjASUv4p0qxg5yuIJODsNbxGCDYc3Z5eQBP1NbhupQi0LrFT5+JhuPry4Fm4O61Q/ViB
         a8tOrz2F7RYsLYvY446Ay5RNSTafc8TaeHB0swnSqrgjQT0L+nD+MdShO0H9586iJ8AE
         aHJg==
X-Gm-Message-State: AFqh2krN57+AwgACRn2+X4Z4Z2ojUtgfwWIN+3qTRlUumIjcidO90ImY
	i1M3vWd9E1Pw25CTrTubzRuQ1Q==
X-Google-Smtp-Source: AMrXdXvRLGXpw/IldWjcH6Psvsy5FKL2mJyz33k7rd2bZ1PP4sfQulfRObsX2FkVtKHWyRygK0FruQ==
X-Received: by 2002:ac2:4bcc:0:b0:4b6:fae9:c9b7 with SMTP id o12-20020ac24bcc000000b004b6fae9c9b7mr1425029lfq.7.1671701069434;
        Thu, 22 Dec 2022 01:24:29 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i40-20020a0565123e2800b004b0b131453csm10724lfv.49.2022.12.22.01.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 01:24:28 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH] dt-bindings: arm-smmu: disallow clocks when not used
Date: Thu, 22 Dec 2022 10:23:55 +0100
Message-Id: <20221222092355.74586-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disallow clocks for variants other than:
1. SMMUs with platform-specific compatibles which list explicit clocks
   and clock-names,
2. SMMUs using only generic compatibles, e.g. arm,mmu-500, which have a
   variable clocks on different implementations.

This requires such variants with platform-specific compatible, to
explicitly list the clocks or omit them, making the binding more
constraint.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Marijn Suijten <marijn.suijten@somainline.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml   | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 895ec8418465..0d88395e43ad 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -367,6 +367,34 @@ allOf:
             - description: interface clock required to access smmu's registers
                 through the TCU's programming interface.
 
+  # Disallow clocks for all other platforms with specific compatibles
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - cavium,smmu-v2
+              - marvell,ap806-smmu-500
+              - nvidia,smmu-500
+              - qcom,qcm2290-smmu-500
+              - qcom,qdu1000-smmu-500
+              - qcom,sc7180-smmu-500
+              - qcom,sc8180x-smmu-500
+              - qcom,sc8280xp-smmu-500
+              - qcom,sdm670-smmu-500
+              - qcom,sdm845-smmu-500
+              - qcom,sdx55-smmu-500
+              - qcom,sdx65-smmu-500
+              - qcom,sm6115-smmu-500
+              - qcom,sm6350-smmu-500
+              - qcom,sm6375-smmu-500
+              - qcom,sm8350-smmu-500
+              - qcom,sm8450-smmu-500
+    then:
+      properties:
+        clock-names: false
+        clocks: false
+
   - if:
       properties:
         compatible:
-- 
2.34.1

