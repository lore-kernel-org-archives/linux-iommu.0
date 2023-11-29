Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB9030340
	for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="biL8EDr9"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9fd0059a967so189303966b.1
        for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 06:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701269061; x=1701873861; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dsjff4lo1TEsrq1gFW/fhWlByzdhetZPF5yWDTWUZEA=;
        b=biL8EDr9LwWVLY7F6FWswT+S3MSUPpW4W/Mj3fgIxt5G7dumdJ9SmqnaekAM/bFt/1
         0TXJdvoLyh31Qib53e0emJlTbRfLtqBwsi9j5PQWVoBZoncFxgbuFT14rH0Gb+haVcM1
         1D6tzhjfmCpjqxoYEaisAU3/HE9p8fn314G6v6KDcOrc9tq8veed1WUSXyWzqhDYWd9s
         xwcW/80rMo0J/gUD+OomlEKDBlpj5Vw/qrNwYRlLg/v9dG1m6l5oCGffx6/F0bPNk/Lx
         L/ZJBjnbJTCE7x68zusnIJsMGiDEVPyhsYhw8Ia02khaeewQsIlcbS5ADU3gIZkskWT6
         PNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269061; x=1701873861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dsjff4lo1TEsrq1gFW/fhWlByzdhetZPF5yWDTWUZEA=;
        b=j94ezeDQJL9+IYEFT0SZOMVD5ZNEe2Z7b4th/Un/qEYeL1exyIr/uMKwvynsebMRBa
         AavQjnrgyLqok3jQtk7zsd3NNnxtUJ8FGXQY2el/i1kugfuu7HmcktROFd0aY+C973QO
         4Dmxg/oDf1W7VqvzHXVqXt22idhI6kE/LghSLuc8giLDToc0bWRFT6cDk4PB+RaqYRtk
         E+qLVSNipKD6gNt2tNzWrEuHt2umPDqf8efZ/p+5uSztHbUQbI5MB2E09zl7SdstMjJe
         luC9oVCqucsMTWFsy4pH+g9prdJySflcucbso1nTODwF/W7R74oYFUuAUYe1WRnscV7G
         R8TA==
X-Gm-Message-State: AOJu0YzyX/8o8JGKaiUS/pGGdrbusB4ZJn4WpJSfN+jIOvnFZ2CCa2hm
	Tyt3RrrWysaY1ogD84TUl3oTrg==
X-Google-Smtp-Source: AGHT+IHImPQ0Kwr3vcyT4G4Q+oZKLib09Ofr5KqKmrosaTuVEe7JUhtFqqgVl+qKUMGIXXd3C0/kEQ==
X-Received: by 2002:a17:906:2c0f:b0:a04:837e:87ad with SMTP id e15-20020a1709062c0f00b00a04837e87admr19485534ejh.16.1701269061261;
        Wed, 29 Nov 2023 06:44:21 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id e27-20020a1709062c1b00b009fda627abd9sm7913738ejh.79.2023.11.29.06.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:44:20 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 29 Nov 2023 15:44:01 +0100
Subject: [PATCH v3 04/12] dt-bindings: firmware: qcom,scm: Allow
 interconnect for everyone
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v3-4-4cbb567743bb@linaro.org>
References: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v3-0-4cbb567743bb@linaro.org>
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
 Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
 cros-qcom-dts-watchers@chromium.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701269042; l=1156;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ATWzTDawV1rfiW1Rmh2AEVyFtBtlEoO5VeMvQ1CdaLU=;
 b=gCLbtSj3IXRE7+/if0uqlBv010cshUZDoa+DZ7Wgb9Nh9NbRTbzIuCXjHUUX/zxf3B95x8WDA
 mNJxa3PkIHpBoWKs0PxWFtCyzT3RZAqByn3YHBkdxhtCsWXsnLGEY7l
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Every Qualcomm SoC physically has a "CRYPTO0<->DDR" interconnect lane.
Allow this property to be present, no matter the SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 0613a37a851a..f3a87a8426d0 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -178,21 +178,6 @@ allOf:
           minItems: 3
           maxItems: 3
 
-  # Interconnects
-  - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              enum:
-                - qcom,scm-qdu1000
-                - qcom,scm-sc8280xp
-                - qcom,scm-sm8450
-                - qcom,scm-sm8550
-    then:
-      properties:
-        interconnects: false
-
   # Interrupts
   - if:
       not:

-- 
2.43.0

