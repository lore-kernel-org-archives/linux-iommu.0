Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC2918041
	for <iommu@lists.linux.dev>; Sat, 25 Nov 2023 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zyvm38LW"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a00ac0101d9so379732766b.0
        for <iommu@lists.linux.dev>; Sat, 25 Nov 2023 06:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700921877; x=1701526677; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWCPgxbV31hYh8dy6WyfWoyvdSmmu8EadahKhw6DkWw=;
        b=zyvm38LWtuz3TP/KvZza5vAerCksn3gyTLDSB13ht/PLMRq/8wafBIInXPnGR19Gn4
         I6xzGgg06fU20u8ZA16+GLqZ/bD7QSoqLnM8Lkds5zNHonLmAj/2faqL3iZ8uq7oKnna
         7Ov/pM3t5OVoQ2AzGoK4aQ3SRdpA0WKQoQzf/mCTFyLgPydqL8AX+DiNbwf4pQR4EZlp
         eWVdiV44sPtFM3gLRrb5zclGvd8oY4WncOXkR/o4mR/cqDK1mhgB1O4jVTD6pmKdHHR7
         KGdYoHF4KzjO8JPm5KGCAHhn7nyaaHH9c9wbEy1XqD/ElCTusmYiWf9U3dSSlveFN4sF
         EA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700921877; x=1701526677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWCPgxbV31hYh8dy6WyfWoyvdSmmu8EadahKhw6DkWw=;
        b=VCdH9lYKH2UdYm1l8h1kPBzNGhHFAeqiE9/solYumLS9Ote8LU7oVQ6YKAIpA7yOmI
         2MRBxDcJAg2/LgnS0kJjAup7Bh2XsSiIr+/DCjO2sR2nWGpAbAp84rQOC4cjCxfrR17V
         NJNHkzjTQ8pOPRl9DwBt4e0F8AbFTQ9oyMDJ7S+dS/cpb09QWDVNznh6y1BQKbaKUwoV
         iaa4YlvC5Vy60DlZ7BehikNuFn7LdigM9KabUXh5ZQOo0IOPYAkf0gHzT25LPaqdxU2P
         wmudSklR0HEDW/JtyIC/RqJ+D6lT/Vzvy4m9oQbW7iqFQ/ffGE/0Fie0MT7kH2iZTzx2
         MHXw==
X-Gm-Message-State: AOJu0YyWhjt3HpAmekHyCX4Jz1vFzBKvERFcV/sWSsK78oAOveTOilAt
	6LafWU+5rB3rHZ9e/Dtw9M1LLg==
X-Google-Smtp-Source: AGHT+IHvD1QUH58vfrh+JuFXiAspD6f2yTyYe0BNJ9QJi9uFvF8FzZqrsK628r6rcj/cdkeKg5L5Ow==
X-Received: by 2002:a17:906:608d:b0:9d2:20ee:b18b with SMTP id t13-20020a170906608d00b009d220eeb18bmr4065922ejj.42.1700921877219;
        Sat, 25 Nov 2023 06:17:57 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906319300b00992b8d56f3asm3500345ejy.105.2023.11.25.06.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 06:17:56 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 25 Nov 2023 15:17:33 +0100
Subject: [PATCH 05/12] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 QCM2290 bwmon instance
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v1-5-11d71b12b058@linaro.org>
References: <20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Loic Poulain <loic.poulain@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Georgi Djakov <djakov@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700921858; l=892;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=4p1t3ladITCzScGHKWRD4AUO04YXuJiZkuRiWJFiujo=;
 b=HgtcxdLyklPczRRLJMxdrlC1sVeNSeCuWIN6F4Xkr9dxy/a75RHP8Tm9mVxVipeW+jkpJiDqG
 jjrxeMEwW5LBwHqcbF7tqgSlw1eWMPkjI1ABsatTSpX8EHUOrDEKyaC
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

QCM2290 has a single BWMONv4 intance for CPU. Document it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 7cb8df757477..a88cea732370 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -25,6 +25,7 @@ properties:
       - const: qcom,msm8998-bwmon       # BWMON v4
       - items:
           - enum:
+              - qcom,qcm2290-cpu-bwmon
               - qcom,sc7180-cpu-bwmon
               - qcom,sc7280-cpu-bwmon
               - qcom,sc8280xp-cpu-bwmon

-- 
2.43.0

