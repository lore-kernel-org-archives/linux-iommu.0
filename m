Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1943D63
	for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 16:55:37 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id c22so4535314lja.6
        for <iommu@lists.linux.dev>; Fri, 21 Oct 2022 09:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k1V79C6sUOMuHke6im7U/KGPAAIEinbvZsKwAJ+skWg=;
        b=SXHRzkKXofttZe/G3LEBQU+cp7BGyaEorRJK3v0SfgIv+2LYZSaavBcnVMmShBLCT+
         mR+qCsr6fAL24q4iwbXkRFBF/O09JVEBGe+ZOSk4Z6DURjJT5NKcBElAADFn7C6iLIxp
         yWtJjh4oEKGBor8y1iRp6v8x9LyKkqcJQ/lX8AclvpnYrmIojbVrcwV7+Itk/6fumpD3
         /p86ms1t81bFbpsWkuyiUiviQuqb6EXNzlabSYJ+u8z6tj+0WUd+4pBCB+iz5uv0r2l/
         RsG9adQ8vkmm8G9truhcbgCtwcsGWr0CUOZ/Nv4oxKncwKTyDLZX0mj6hxJi1+MlscpZ
         tR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1V79C6sUOMuHke6im7U/KGPAAIEinbvZsKwAJ+skWg=;
        b=RuB71JHAz2Gz6j1lX3/x0Q+i4UiuzcMT5RJoeWlq7Xi5YXO+VpN7DuNrD0phbGw56q
         3sHaoQLu02mh3ovoh88msVWqEV9W4yCBPf67AnA7buH31S/r0zCazBVpa0Eg/y68gfBy
         eM5n2r6lPgd2t03HZAm9n8i6nIadIHJh4omglFmFLUZ1z5p+QcvSIaIlNNGIZh3P2Cuf
         gXK0aOy5nLwrtOyysrAmJrYoj914JIDkqgUcIFwWI4k+9gWtWZR7XMBFjbDxVdRpzQKH
         kRxQVIXCAN6ZkRed1k0+1knjHkc0jP2dytdsk5CnyjgBILLW8d9XWP3+4vYgEMDGAd+Y
         fIXQ==
X-Gm-Message-State: ACrzQf110guT9d7gQQPvktBR+lkYWhalk6Gr44zjOc1VXZv7jCqjU4BK
	HaHCvg7CrQfO6OAiqshlHBCgTg==
X-Google-Smtp-Source: AMsMyM4ZwzA/9qYXr0Ylgwy+8+4oJWjtym9xDnym9eNdTzpXpeSZrCYheWZaDSw2pFE6iCh7YY7u+Q==
X-Received: by 2002:a2e:a789:0:b0:26f:c3e0:4e4d with SMTP id c9-20020a2ea789000000b0026fc3e04e4dmr7085266ljf.499.1666371336036;
        Fri, 21 Oct 2022 09:55:36 -0700 (PDT)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x4-20020a056512078400b004946e72711bsm3218532lfr.76.2022.10.21.09.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:55:35 -0700 (PDT)
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
Subject: [RFC PATCH 1/9] dt-bindings: arm-smmu: Add missing Qualcomm SMMU compatibles
Date: Fri, 21 Oct 2022 19:55:26 +0300
Message-Id: <20221021165534.2334329-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221021165534.2334329-1-dmitry.baryshkov@linaro.org>
References: <20221021165534.2334329-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing compatibles used for Adreno SMMU on sc7280 and sm8450
platforms and for the Qualcomm v2 SMMU used on SDM630 platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 9066e6df1ba1..34ee33a62ba5 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -28,6 +28,7 @@ properties:
           - enum:
               - qcom,msm8996-smmu-v2
               - qcom,msm8998-smmu-v2
+              - qcom,sdm630-smmu-v2
           - const: qcom,smmu-v2
 
       - description: Qcom SoCs implementing "arm,mmu-500"
@@ -48,10 +49,20 @@ properties:
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

