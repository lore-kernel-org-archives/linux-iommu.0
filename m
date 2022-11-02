Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A493424F3A
	for <iommu@lists.linux.dev>; Wed,  2 Nov 2022 18:44:26 +0000 (UTC)
Received: by mail-lf1-f52.google.com with SMTP id f37so29655825lfv.8
        for <iommu@lists.linux.dev>; Wed, 02 Nov 2022 11:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9IFAoIiE6zk/68PG4L50nqjshUlH8V6wR65bpY1Vak=;
        b=yn/vfHE6LozuJmD95+HrWoH82ZlB0zLDoaY4bc4O2qtmL9V2/xY8NRF3Jeb9iDtN0v
         bVVa7tfENlg6q3FEb49B86k9ykRduXKY+gtj9DbpoHY8SzqUTxFfAom5RqUMSQqNxMFx
         mxd6dfEwVYEYq4yYNh61eFuHvx8zUEpV+OlWp/9zoWYwe/ONtca9c0vwGT+H+SzJs5ak
         yR4BekvoCsZNPeszYxengsxi3k0sZyExV+gL0NiMo/u1FisyfAceJa3CYObOX03KsC8f
         Q6xl7sOdMLWj8I5+qs+q14IQP8kFJWI5YniMTrT9OkAlzEBsYUE5xdX45UmFVXrzofEu
         tGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9IFAoIiE6zk/68PG4L50nqjshUlH8V6wR65bpY1Vak=;
        b=vusmZ7V9ImvDVVST3BsZr78M+8aR0TNDFjkNUt0JFa3P7Q88WQOWbKBFdgVzIMJMpz
         yW/XAQc97LXD2paIUQSvRhLvTSiBNFFbDjLJfW9UYq1aCWtlpx3nPa3yre3fNaoOEWRS
         7xCo++uw8gWxDfM5eLtOwg7Jdn4O0UOVmpbQ4zWmKsNPV/ZS99Gbtlsu8bF2jVSMlVVn
         I3sMFTH2aZeg7LeBi22Vt3LhWx8V0DNpkqv/nyu6XrhuKfNFUs3T7hUp2yCgyqtEzJsj
         dxVYShU5cAIJlNlHdZOj7g5GMDZpyLYPngYj5uDk7yNPAqldSGPbr82tpJQ5NowbahzC
         lUXQ==
X-Gm-Message-State: ACrzQf38sRNKnj2Cw74B9WQKcRC26TYxqL9Sq3iGUjbHu+K/yddjopmm
	TO2U/LK0b9hui4ITCuNabZVUiQ==
X-Google-Smtp-Source: AMsMyM4yJnkpdkDouKkNsFT3wdHhrbQSpdR2Dk71mqLLaRPuqYXDy19etdJWvMoHbhsWFCKlUNnNaA==
X-Received: by 2002:a05:6512:ac8:b0:4a2:61e7:7963 with SMTP id n8-20020a0565120ac800b004a261e77963mr9685893lfu.363.1667414664824;
        Wed, 02 Nov 2022 11:44:24 -0700 (PDT)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t8-20020a05651c204800b00277092c03e7sm2277540ljo.33.2022.11.02.11.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:44:24 -0700 (PDT)
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
Subject: [RFC PATCH v2 04/11] dt-bindings: arm-smmu: add special case for Google Cheza platform
Date: Wed,  2 Nov 2022 21:44:13 +0300
Message-Id: <20221102184420.534094-5-dmitry.baryshkov@linaro.org>
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

Cheza fw does not properly program the GPU aperture to allow the
GPU to update the SMMU pagetables for context switches. The board file
works around this by dropping the "qcom,adreno-smmu" compat string.
Add this usecase to arm,smmu.yaml schema.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index abcb1ee4b58f..f44572cbb071 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -66,6 +66,10 @@ properties:
               - qcom,sdm845-smmu-v2
           - const: qcom,adreno-smmu
           - const: qcom,smmu-v2
+      - description: Qcom Adreno GPUs on Google Cheza platform
+        items:
+          - const: qcom,sdm845-smmu-v2
+          - const: qcom,smmu-v2
       - description: Marvell SoCs implementing "arm,mmu-500"
         items:
           - const: marvell,ap806-smmu-500
-- 
2.35.1

