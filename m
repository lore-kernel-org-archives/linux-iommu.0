Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA08930338
	for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IFR2j8aw"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-54bec1d3854so309504a12.2
        for <iommu@lists.linux.dev>; Wed, 29 Nov 2023 06:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701269058; x=1701873858; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhPk3gIHMkcRIIJu/Q2shfUhw94w8SwgcuUapNUkT6Q=;
        b=IFR2j8awR5vmSV13BOuyp/mhLUB7V5HPUPGTFZ830ZTuKE46acnxSoOYwOnYiWh8U7
         2pol6k5+3IjmXjaWIrzxi4YsuPYXJwvReIw1997OBaart9caW5a00KP1XkryHyfWZ+Bj
         0ay3Ov2sfYsSN66CvMd58DXVUlJh7T5LH75qHKWGi1zDII2wZUttzz/EF4NsMGNd0irT
         fXQkLJuGADslvBSHDnop1UyugvtKD020lEYmqFUqhgd/Y8Ckvm1x5+nXVHihIWCQdNCv
         57gK+oUJazbCC3Onft1DeDaoAcWqgIgY/f5vaYinQmnHIJtVqodEMXK1s+/qNzqkYIXd
         P8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269058; x=1701873858;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhPk3gIHMkcRIIJu/Q2shfUhw94w8SwgcuUapNUkT6Q=;
        b=ewtNktyupSOuMNogW+TYMFMARvkZS4FF9SYRx9X4WEUW+SsjC9FA4o28C62B9T9584
         LAnP55DoFcN+2JBISq0LDR4wyuLQCHm0YWwyDgcgTwCnvbJhCkm2CHx75tGHeD9YTBB4
         1UD8eYfytorEOm5gJbq35Tq+ttlJ+fjFUn8B/QZnWHi8GnLi9XT/nKPYzaFCVDD1CxtY
         ip47gpY65QpxER9RFzDOxqXc/wm99kzSoOhgYP2+Lza41IeJAs5OAucLgfcewSs3bGTP
         iBMbST4QU1NBjtPo1lnrZ5MjjGedlmOa8CpGRRANTxd9cZ0P5ymhDQSTE2/9JQsRa7++
         nfQA==
X-Gm-Message-State: AOJu0YzUezqGt1TyIVCIk+1vt5uQraEkPgs7iUfze3rN2291ggTgfTnL
	jcqLQdpqx2CaiNwvPUV4afv3bQ==
X-Google-Smtp-Source: AGHT+IELUKZHQLPVXvrqWTCWTWyQ1q5ziCaTJA9OZKmwCNLvITVZ5WvOUuMIs3bTAJCDlyB/ZXSxCA==
X-Received: by 2002:a17:906:e0d3:b0:9fd:3ba:ddcb with SMTP id gl19-20020a170906e0d300b009fd03baddcbmr13503603ejb.29.1701269058026;
        Wed, 29 Nov 2023 06:44:18 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id e27-20020a1709062c1b00b009fda627abd9sm7913738ejh.79.2023.11.29.06.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:44:17 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 29 Nov 2023 15:44:00 +0100
Subject: [PATCH v3 03/12] dt-bindings: interconnect: qcom,msm8998-bwmon:
 Add QCM2290 bwmon instance
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v3-3-4cbb567743bb@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701269042; l=959;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=1AOnfLSu9gHpTFJJhxoEDrJmbQSA5ACPtQkIorVkBaU=;
 b=Bttpjh5YDu8RJ2oiG0axvEhFefhRGDd512/Kb/Ls46aYSNJYNXnDWH6qSWS8RcmRTRCivj3fj
 7wcKLyJ1Ot8Bx4Wi3/Cp5wx9Q0m0AaDIIXjigS8cH3/dBs+PrrTzSLx
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

QCM2290 has a single BWMONv4 intance for CPU. Document it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

