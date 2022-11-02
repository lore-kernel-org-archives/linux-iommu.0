Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D25824F35
	for <iommu@lists.linux.dev>; Wed,  2 Nov 2022 18:44:25 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id l8so15273754ljh.13
        for <iommu@lists.linux.dev>; Wed, 02 Nov 2022 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNK2wPK1fBXzQbq904VPM/ONG2+wLYMEqkAMyzLrb8A=;
        b=KE32gHX+t1m490OwcBj+IkhZR8UOU08WEyAZi+sKyor5it0XstYkmXHnVDrhAoT5Uy
         TkvdwmH4D+up3wFvlx5XjEqdg7lGPpKiIendw0DP5CESgouWvczajXJYDbbqVBEhzY4K
         Qv9e3bwD03OY7ICzdnIzaEF8MKPXMWkYdnVA5prwA2v78Yz2Kwl2jO28JYDk9EAQtyA0
         rSf2CcTyxnhtpfuGuVudDASovJbqojnscV4p08OdZZelTbpYFLCZzThr/vdwsZBDtdGR
         NpXwGc0QDLD/4PpVPfLuwCZJPHfYAIQSTWgp9nR5mTZoeRTe+p0xPMHP+rlDDkyvMjC8
         spvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNK2wPK1fBXzQbq904VPM/ONG2+wLYMEqkAMyzLrb8A=;
        b=YPBJ0RQLKALUhlhYOcIeexKqKllpmh9mLvqI5Hw53qLu4+3ClVljbqaacfqH8h9e3t
         RARnYBV61SsLEXpQ+b+e/Pg7TtKNHV5W+5QhGNOaD8zVB7jdXhy4pGLhhvbiN5Pp3swE
         2P7WbXSisVt8tNok+u3T9m3ixP/3lkq6NZEFhKBh6lTlSMgJ93Dnb3HxyktKvia47FiZ
         yM5qeZ1KKh+tcDXorOIxCw5w8N4VG3FGp14HCI082RVx8lqv4gJoHGDDrY2AhG5ecjoc
         sDwVzPDnnAJf6cX6e8rAGTdPLoXTZdfgSKNmYxTjvtOWF1kdq+67S1bLvc+Q50XwmsQW
         rz2g==
X-Gm-Message-State: ACrzQf0zI0I+onROtvu1Ohl+49OVNMGUaiYf+AFLCLkIn6YjkgyuMYXP
	TXxUxVm+2zLhWaK2kBjUlZnpQg==
X-Google-Smtp-Source: AMsMyM7KfCrG5aH4B0J1QoogQr2JYMpYNPRytIihbQ+rgBpmAm8Qs6bm6jnsdHrAN3rJpYFmyKYhQg==
X-Received: by 2002:a2e:a887:0:b0:25e:3174:fb67 with SMTP id m7-20020a2ea887000000b0025e3174fb67mr9624008ljq.337.1667414663267;
        Wed, 02 Nov 2022 11:44:23 -0700 (PDT)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t8-20020a05651c204800b00277092c03e7sm2277540ljo.33.2022.11.02.11.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:44:22 -0700 (PDT)
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
Subject: [RFC PATCH v2 02/11] dt-bindings: arm-smmu: Add missing Qualcomm SMMU compatibles
Date: Wed,  2 Nov 2022 21:44:11 +0300
Message-Id: <20221102184420.534094-3-dmitry.baryshkov@linaro.org>
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

Add missing compatibles used for Adreno SMMU on sc7280 and sm8450
platforms and for the Qualcomm v2 SMMU used on SDM630 platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

