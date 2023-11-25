Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9897563BD
	for <iommu@lists.linux.dev>; Sat, 25 Nov 2023 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdE5nrG3"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9e1021dbd28so381062266b.3
        for <iommu@lists.linux.dev>; Sat, 25 Nov 2023 06:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700921882; x=1701526682; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzHhRUdqYzC89phn7gbVveYcCLwhSTvqnPb56NAvVOE=;
        b=kdE5nrG3J/0bpIW75zpuT0k92J4r0K4yf7L+zS4AWrSYLDyG0sNkctKIKGqsExXoBY
         BghPKp79cqz+W4ksl7Izqm4SS+IfavSR5Pzoynuimly7gyLTJi71+Hx3l1ypaG7HhliZ
         klKZwZvGXwt8fJtJFro1vCNqen5xPDnDYg1D5spnnZ9NZkSh8y1ghl0z1RnYkMdEtbHt
         FrRrhwd/FCqVJEMHzAmK/HfVV3rwHSCGhqswqydmADCDSg4Ix2t/7CZ5Hejv5I7i4JjD
         146/A350H5fs/r9Uvp+L6zf7Dknensj8bpJ+7TqDoTPtLtNJ2XRExLXdyqnaHseARFs3
         W55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700921882; x=1701526682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzHhRUdqYzC89phn7gbVveYcCLwhSTvqnPb56NAvVOE=;
        b=aG2SrghXNtFLBned8MQ+7dS7mxcY0BPnyqh+9VaWjbL3/a5MwgBWEjmIKISL9Izpg8
         s2BZvyeFJxWLvyTyV/loYepmqWhNzjHYYOz9POfaSu/v1V/YYbnbmOMEk15vsNR7Phql
         ed6QDzNlxz8Ly6KGb06rj71vY8b++bpYgTIASehu9LWnBGl0dJJYz16OLNrgIaQXOJt7
         ERrxSL+9N7ILsqr3jJ8GFUYKUJGuMjItG8YZeZ950cMLmDLOVjrHQeuDI8HSdSjMjz7x
         okV7XJt3OybKKvVe6v9dbNMAUJeFzPY0ZksTxxGOS1L8/EPR6K+O4oWx40Rr8ZuPFLV6
         QbXA==
X-Gm-Message-State: AOJu0YwqIM8pEMmPA53+WBR+WZme59vJ8mg9wK6yihuIYfj1zB44i971
	d0xSgg4tKM5AbCvHJGXNcAMr6w==
X-Google-Smtp-Source: AGHT+IHXbZJnn2kOU8oXhY8kFLv+tE8yUR0pfflIMAwddWoIAfdAVmz/M0agvUGtae4E5qmsjnU5iw==
X-Received: by 2002:a17:906:2492:b0:9be:30c2:b8fd with SMTP id e18-20020a170906249200b009be30c2b8fdmr4666298ejb.66.1700921882378;
        Sat, 25 Nov 2023 06:18:02 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906319300b00992b8d56f3asm3500345ejy.105.2023.11.25.06.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 06:18:02 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 25 Nov 2023 15:17:35 +0100
Subject: [PATCH 07/12] iommu/arm-smmu-qcom: Add QCM2290 DPU compatible
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v1-7-11d71b12b058@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700921858; l=876;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=G/TOscakzMl5L7lLg+f1aIz+xjyCycciuqgvdkeUR9s=;
 b=ENgDCU5tCX4v9CkymJG/T7LJb4knR81cFyT/XGNKMDSPge5mWTB461TNnqV2zeQTm7ByPYw3U
 DyVZSXIxFr+D79fGF41S3jBKCH0oWSysSTWmlLWRPUZHnV063SCSZUJ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add the QCM2290 DPU compatible to clients compatible list, as it also
needs the workarounds.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 549ae4dba3a6..aea5e85b20ff 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -245,6 +245,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ .compatible = "qcom,adreno" },
 	{ .compatible = "qcom,mdp4" },
 	{ .compatible = "qcom,mdss" },
+	{ .compatible = "qcom,qcm2290-mdss" },
 	{ .compatible = "qcom,sc7180-mdss" },
 	{ .compatible = "qcom,sc7180-mss-pil" },
 	{ .compatible = "qcom,sc7280-mdss" },

-- 
2.43.0

