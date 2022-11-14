Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705279C9
	for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 17:06:39 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id c1so20323783lfi.7
        for <iommu@lists.linux.dev>; Mon, 14 Nov 2022 09:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JM4WornFiW01h+ev1IYYNxP6M56aNDzG1elE0bGknSE=;
        b=R2I/GCNsc2V2QEHtzal1Vp90xDpVkZt8NWKcqYZoTid6E4u1u+kTkRMftrL6ttqebF
         d/+Lbqs2xyFhGfz7IWQ5f0kg41q2bHlKbOdW2J+/1eKPbCGwXq9lyNTVQ074YWSDeDc/
         9MyquEiEUbyctMIbk4sy2GkMW9igw4O/0Qbl690o83VYDAySX9UhvLsEDH+ZFCGqSDo8
         0CQkuQaUZ3I5hyEMMzLUh/fdXEr2h7IvahInxgRZoVdE290Q4xcW/NV4B+/PfsfbfjoO
         7bpIDD2mKn1BKZZDh6HY7Jw37Poaeyvx+1qEgK+td3RalSsJ+5IejQHx3D1087h2uA6L
         bTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JM4WornFiW01h+ev1IYYNxP6M56aNDzG1elE0bGknSE=;
        b=K0FgLdj7NJNKAGr5ygaJaCGhFd9FUsTS7vthaq5rX7PYgl/u5qAiap3Df1U3Z/yXUj
         CcQQ4Tu6FfmywcBGnWbrai0dg3Wkcft7yvYlmpNMmKDeMAHpCbUdMFvieESNNLauVzmT
         ak8f1/eNG3E6qs068fs7izENH6w2zo8ew0SQHPfebDqvZZy4PRUp5qYezoGSqh+WNO3S
         l+zs/TE7uBs+5BlQG94lZftZEpFitPsGD0GZnsRgxF/Z37/e6EmZt2kNNQppN20nRGDD
         RmN24MiRbkVnNQRkiJ++funMybWjLTFer63lLNGg68tcitmF5E5Q4EcETgQFI2VldHOJ
         /Ohw==
X-Gm-Message-State: ANoB5pmyiMe9ZzproFddVaBiAnQC0cXPXWIU7KPm/SccPpa9z7wfZUYp
	AYfvyAf1nw86W1r2mCB0Ahpr9g==
X-Google-Smtp-Source: AA0mqf6cFV84uzJTbEzIvJ0qgqEPH88ulOsRSQtdVR/y0a4388kfPltmL6scgFiIjbUz32mKcUEg2g==
X-Received: by 2002:a05:6512:3590:b0:4ae:611c:6549 with SMTP id m16-20020a056512359000b004ae611c6549mr5098036lfr.231.1668445597211;
        Mon, 14 Nov 2022 09:06:37 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id q7-20020a056512210700b004a2ae643b99sm1896344lfr.170.2022.11.14.09.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 09:06:36 -0800 (PST)
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
Subject: [PATCH v1 01/10] dt-bindings: arm-smmu: Add missing Qualcomm SMMU compatibles
Date: Mon, 14 Nov 2022 20:06:26 +0300
Message-Id: <20221114170635.1406534-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221114170635.1406534-1-dmitry.baryshkov@linaro.org>
References: <20221114170635.1406534-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing compatibles used for Adreno SMMU on sc7280 and sm8450
platforms and for the Qualcomm v2 SMMU used on SDM630 platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 3ade2dbca70e..aa863811996f 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -28,6 +28,7 @@ properties:
           - enum:
               - qcom,msm8996-smmu-v2
               - qcom,msm8998-smmu-v2
+              - qcom,sdm630-smmu-v2
           - const: qcom,smmu-v2
 
       - description: Qcom SoCs implementing "arm,mmu-500"
@@ -51,10 +52,20 @@ properties:
               - qcom,sm8350-smmu-500
               - qcom,sm8450-smmu-500
           - const: arm,mmu-500
+
+      - description: Qcom Adreno GPUs implementing "arm,smmu-500"
+        items:
+          - enum:
+              - qcom,sc7280-smmu-500
+              - qcom,sm8250-smmu-500
+          - const: qcom,adreno-smmu
+          - const: arm,mmu-500
       - description: Qcom Adreno GPUs implementing "arm,smmu-v2"
         items:
           - enum:
+              - qcom,msm8996-smmu-v2
               - qcom,sc7180-smmu-v2
+              - qcom,sdm630-smmu-v2
               - qcom,sdm845-smmu-v2
           - const: qcom,adreno-smmu
           - const: qcom,smmu-v2
-- 
2.35.1

