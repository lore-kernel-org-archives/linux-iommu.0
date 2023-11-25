Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA7414A86
	for <iommu@lists.linux.dev>; Sat, 25 Nov 2023 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TCTXYH6j"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9fd0059a967so741934566b.1
        for <iommu@lists.linux.dev>; Sat, 25 Nov 2023 06:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700921870; x=1701526670; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqbb19oWFPD8qDhmzNJu7LExFvnUbJSOuyMJKMhlgUE=;
        b=TCTXYH6jqkLGt0Tzlmam1raVOKVewF1jr4Mu+AE85OCMDYJt2uDGLWg5w5viqxF9M2
         UaAI0+f98fO/GGglxAzyr0Ti5JBD3XMKQmgQZgv51qWztSHrkO7A2HVjHFL0ex3J56MK
         S7b30y/OAIqCEKyjNJfEsddCNXi1zurCL3X8erhJ44W/mEKU++rZOC8R/kaIiTPkGrwH
         9hW3mWuZcW+ru9N8mFHXGhMqQ9JybUvfXHjfUVG9SBw8uPBhrGf/c9eH2QM3Gd9bmkzv
         388KWPeumfJ4h5BBvSWJjq9d1SAb07v+xCyNwOt7zcNK0a6dnRy2gj3MaMWuQ0upuiCq
         ozUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700921870; x=1701526670;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqbb19oWFPD8qDhmzNJu7LExFvnUbJSOuyMJKMhlgUE=;
        b=Yqjo/2tS1orSSiv2zvuv63DTEsXCYEhfrOJQhrE8+VxgWuU1e+42Xk+/HjPaUGGF9s
         mcVJfY+TZ2KRBNPTk0CHp1SML6hk1YA9Hs99fmhk04y+kSW0x7p7AAv3ERSDCemYrhKn
         TnPbBJue//daksGntX8t/fd0uZzbyLGPOfDJyr/Yj7O7OMqoPiAsuzb18Q6WWIgvkIto
         ttJU3edzJJ9vjbZDgW9BLlHQxWZ6scs7HjbFUsNF/ctM+KdO/H3oQWwChBnpWyl9FKhC
         YHlPq5QvaBHaQUrIxo/rywNtyqHIWqjSkr3JGHmTEESRXvhNj2BpJi33ve+itOS38yFV
         zf/Q==
X-Gm-Message-State: AOJu0YxmpdI+/77GgesrN8OwLSV5oC2hd2G9PpFRfe5BBQBV4d7Efgrv
	GKbPVzbn224rMF295U0aPafpIA==
X-Google-Smtp-Source: AGHT+IGR9tBJZuW4Oo7JUrMEGXAjwVM/uMciWDFiip2iKnRP19yE7RUhPP5bwCFjfp39Yo++2RfLfQ==
X-Received: by 2002:a17:906:b298:b0:a06:dd05:d695 with SMTP id q24-20020a170906b29800b00a06dd05d695mr5854984ejz.12.1700921870758;
        Sat, 25 Nov 2023 06:17:50 -0800 (PST)
Received: from [10.167.154.1] (178235187180.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.180])
        by smtp.gmail.com with ESMTPSA id 19-20020a170906319300b00992b8d56f3asm3500345ejy.105.2023.11.25.06.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 06:17:50 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Sat, 25 Nov 2023 15:17:31 +0100
Subject: [PATCH 03/12] dt-bindings: display: msm: qcm2290-mdss: Allow 2
 interconnects
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-topic-rb1_feat-v1-3-11d71b12b058@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700921858; l=869;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=xDff6gIDu+CTWuVjzt1GPZpEINlhu/tSsPBU3gWPnHA=;
 b=YmejfvEjbhNqruT3MXv+XMo97zWiskf4GaKaxji8ggapDZtFzdQgC4kASqndzOWm+67Y8bFa6
 0FF93EB3HtBAgsjYb/KgoXzUsvQdlOPj1tPFtCY7pLo2Hh+D+dYuzrA
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

In addition to MDP0, the cpu-cfg interconnect is also necessary.
Allow it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
index 3d82c00a9f85..51f3e9c34dfb 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
@@ -36,10 +36,10 @@ properties:
     maxItems: 2
 
   interconnects:
-    maxItems: 1
+    maxItems: 2
 
   interconnect-names:
-    maxItems: 1
+    maxItems: 2
 
 patternProperties:
   "^display-controller@[0-9a-f]+$":

-- 
2.43.0

