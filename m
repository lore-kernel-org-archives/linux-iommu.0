Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137EC364AC
	for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708349769; cv=none; b=hEk93RMien0g+qJZuwLgaf8DkS+rEb3fXoI86sxORHg5wySvnt17ikOuwzjBIIST4+NziJznda1YhaTtS4Idk/McF35w9AvIlTzKQcuyU7rtfpgjcScc4r+/3fh5Oqbfg08w+/CmexSdxVtNhwf3yM0c/Mujv0R2j7AQzRAqiRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708349769; c=relaxed/simple;
	bh=iLSWFU0PEB/wfyF1Nv5EVeYr19/e5DAihIhWgNDJAow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=on4nW21EMUfzxJCayv+FklAhuhLpaxUif3Gp1w5JRscidR5vg9GIECvwdTNj5C+ooXVC1Z8gsy7Q1JVZHJDQCyf+NeJohJibDvM8jVSd6Ydl/chNEka28RC5RAaguAhp7hp6tLfzVtV9HoBm9i3oa6dmuX74+ZOQEyVeCnDORYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W6Bky+Ed; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W6Bky+Ed"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so4984209a12.0
        for <iommu@lists.linux.dev>; Mon, 19 Feb 2024 05:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708349764; x=1708954564; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vm4+HsWSLi5Bqiq8guveLonPTq6IX1sdSS8MIp6iya8=;
        b=W6Bky+EdeuccwNg+I0PiXQEhIaT3Vbz3V6pdwaR7xceXhMixGuDWq0DtmVWDx3/UG2
         wdWk6ysHOswNffzpybiDnUl3JMg97QlTqrOO+v68xZFlu1+JtnCdm5zjztJ4jZZvfq3P
         ZCo+FI1NU26KC5uBt3jmvTvZfH6gZ4gUZWeJCIlrys00Zd1O0ImxcF9B71LJJatm0VW5
         k+u2iz35Z+h073eOAbh4QXcwWR1bilbbeJKg8vyzRBdZEG0hvQUyyP3D7yCZTwd/H6oB
         ZCwJgz64HmEFDzAJAguZMB+3Xi+dCMFp0fLZsw4I74WFQwFfjaDblu5SkKubGtbkkThk
         nv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708349764; x=1708954564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vm4+HsWSLi5Bqiq8guveLonPTq6IX1sdSS8MIp6iya8=;
        b=Vdupcx9dLCPxLNuBPZjWDypZTh4W7/uajiuDTQnY+lcA8Ie1r6msenAxhS8vGnO+kx
         7Lk2jaMBuVjfX2x1q/HwYYjeOTBvjHkZdjjW2DS/Y+0AEPqT3n1briAfbCFrnOvbxEYd
         sYlOL697dbnkHPHNM/JeMRXiabcbF+QUp1bCw0QMl52nJVmzqCwmlAnVjdTezwKGkDVZ
         vkI4zgIapDH2NumwzgWDWb5TPGrsRmqu1hxnNP6Wl2rosHt+FqQTx0y5/V8G6abT3tK1
         9GHu2MzbWc+69esPP2T1CpPf3Ct5PxVsr8YWE3rSsnc57JP5MQ6eImxdT1AXGrdCWgED
         UT1A==
X-Forwarded-Encrypted: i=1; AJvYcCVde32sUxbJk8rFULjwJSPgtL7wF8kMs+Bxxik6xRuizTZeagL+IidTnRhncYASJKTfYYtgu23ZkIErjVtY3R5Um2sZAoE=
X-Gm-Message-State: AOJu0YyG+u8+x26qLSwl3f0KXgl5cHq5bo/D2DHindqElJzGVJnc/VSx
	YRTbxMbF+KydYRCnm2jFF+qQoM0Qf6CvqCuZffVfkc9PvvlzeX38Mjxl1+1N6yw=
X-Google-Smtp-Source: AGHT+IHV7bK4ehHh9S5n4E8JdbICBeyKCog4TBxeQJc7jVSQ6sgYL2AGYMpXguUVOZv4iBTFSYicGw==
X-Received: by 2002:aa7:d959:0:b0:564:3191:f407 with SMTP id l25-20020aa7d959000000b005643191f407mr4013903eds.12.1708349764412;
        Mon, 19 Feb 2024 05:36:04 -0800 (PST)
Received: from [10.167.154.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id q29-20020a50cc9d000000b00563a3ff30basm2900168edi.59.2024.02.19.05.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 05:36:04 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 19 Feb 2024 14:35:46 +0100
Subject: [PATCH 1/8] dt-bindings: arm-smmu: Add QCM2290 GPU SMMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240219-topic-rb1_gpu-v1-1-d260fa854707@linaro.org>
References: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
In-Reply-To: <20240219-topic-rb1_gpu-v1-0-d260fa854707@linaro.org>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708349759; l=1444;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=iLSWFU0PEB/wfyF1Nv5EVeYr19/e5DAihIhWgNDJAow=;
 b=71RQnNARetoCSKqpzfQqO6Lapq/qBgUH5HXLBQdA6ZcDXcoSaL+2ynFTnCmi9jFSY8Q7b8KzZ
 O5iL+UfQEyvAPDXeCzVYV8yaVrWJofN/Mv+M8WmxZgIBOjFSCjpHxRD
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

The GPU SMMU on QCM2290 nicely fits into the description we already have
for SM61[12]5. Add it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index a4042ae24770..4a8d4022aebc 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -83,6 +83,7 @@ properties:
       - description: Qcom Adreno GPUs implementing "qcom,smmu-500" and "arm,mmu-500"
         items:
           - enum:
+              - qcom,qcm2290-smmu-500
               - qcom,sa8775p-smmu-500
               - qcom,sc7280-smmu-500
               - qcom,sc8280xp-smmu-500
@@ -462,6 +463,7 @@ allOf:
         compatible:
           items:
             - enum:
+                - qcom,qcm2290-smmu-500
                 - qcom,sm6115-smmu-500
                 - qcom,sm6125-smmu-500
             - const: qcom,adreno-smmu
@@ -534,7 +536,6 @@ allOf:
               - cavium,smmu-v2
               - marvell,ap806-smmu-500
               - nvidia,smmu-500
-              - qcom,qcm2290-smmu-500
               - qcom,qdu1000-smmu-500
               - qcom,sc7180-smmu-500
               - qcom,sc8180x-smmu-500

-- 
2.43.2

