Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBE413D267
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 07:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451189; cv=none; b=GJJQwwQz/cOmaTGD9y0Yqo6YqwTWJSwngcrYDuUMu5AIyxVL0sK1S/hGYJK2RbNI7NOrcJOk6TvdnEp2wNBkg3aefRiwc+orB+giGGDZ9gL4k5GPWZNwncjQTvb/QJZ/yGalqvvXELjg7jnzgEub5HPjdXLsvdCj0zK7RvB6YJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451189; c=relaxed/simple;
	bh=0ay0Yn47NrOqnN93lopZBRcCGvUD6z+nzkYwmnVRlwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E1lfM6UsWFq3rDHepFx2Qfgdc1C9KlG7oUL0JFfGhuy/q2r0Wvbj6sXYXFIvZZ9kPH8Fue/5qzgYmZJX0/7JetsRJnTMsh3lnujVzXkji8AdL/BXuIBNzcSA27koWgZyiymwSj+eZ5MagbQbOwmNR/Cn65pJFuAOLawSF55C6qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gDSX9BFK; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gDSX9BFK"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5d67064885so654072166b.1
        for <iommu@lists.linux.dev>; Thu, 23 May 2024 00:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716451185; x=1717055985; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4WPSSyFPYHDjDOFmkODAP7d7g3YRP2Tob53zlF+pvjA=;
        b=gDSX9BFKeWJLyk7ub3/Zqr91z/DzB5k1gB0Ex4hRnR44XdcttzOwUMG5qngbvasjp2
         w4wxTkeX5czD5Ee1aQTOJUKEjeUJyoLdHVftBaDSWzied6TJSvFxwhTMYENziH43gyY4
         Yb22nBSa2d5oVh0Xa3O5qcOJTc8jCWkHnU2LMgASRkCvLJc2cnWoRCuqfASYfH+UgMMU
         ZRXS5dSJ00BbbMGoTSRSYystn3do7PhPjUJE4OdWmkDDJq0gfXQdHGtOW1RlG5X7WMcg
         1NLZb9zL0dIC9qeGTPoYudmznp51YiiEDmsbfjkQmKbjgP/DmutLANMJeQKgGuxSQLvz
         c+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451185; x=1717055985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WPSSyFPYHDjDOFmkODAP7d7g3YRP2Tob53zlF+pvjA=;
        b=vhsW6QaSSQfjgvrISmQIbyqed1dxphO1+O0DZ1o8aRgzBi5+9IpfCnaVxZGNzNgBkC
         tMJEG8QtJgrmxmBR+ot/aeTi05ITTBqcSsAkqRDjh/VFBADCw6B5OSvv4Q3/KlJalHzP
         hELSjyAWIofzmg94M//mvO+8v90AoVWA24WOTdpiZBdw7TzxvzJoK3Mngq4VWfpMKKE/
         NVhhfse5gT13kU12HZLHzu3MhbFW88Z/gZOUKnV+mpzKRZdhJOXOhvTjYXhL981KQi38
         KgPC08n+ZujGyvdt8qlUbr7XAmWUit/MZ83mtLtAw0xtM0nefTpX991m/k8u5pkXx3Aw
         O5tA==
X-Forwarded-Encrypted: i=1; AJvYcCXPKArp99XU/JU9Ot9yNwgxa/FBg0uaF8c75621XMm/pyGS4J6wH7aEKT91YCdAYKVJKMhUfxhAfJ9suFewwad0IONeFiA=
X-Gm-Message-State: AOJu0YzeLMIiaPmIoTm7zWbOb5eLt0OxoQF8rP4gniwrM+5elYZm9zsO
	hTEcWfAb3PxhgnNdGkZe8FUJkcd69nV0k+Iu0V57tWRz+d0xuQvY3t/I9msMXuU=
X-Google-Smtp-Source: AGHT+IFAlFrk2oNOc7MN/MQJ+SjXkX8CWp6ni0YjiGVht6G3145RtkL4LpCLLXSsd4HPh19gL1fA9g==
X-Received: by 2002:a17:906:138b:b0:a5a:8d0f:3ad1 with SMTP id a640c23a62f3a-a62280d4488mr412450266b.17.1716451182867;
        Thu, 23 May 2024 00:59:42 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:825d:600a:c16:a973])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5ec2a8f320sm719100066b.170.2024.05.23.00.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:59:42 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 23 May 2024 09:59:33 +0200
Subject: [PATCH 1/3] dt-bindings: arm: qcom: Add Lenovo Smart Tab M10
 (WiFi)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240523-topic-sdm450-upstream-tbx605f-v1-1-e52b89133226@linaro.org>
References: <20240523-topic-sdm450-upstream-tbx605f-v1-0-e52b89133226@linaro.org>
In-Reply-To: <20240523-topic-sdm450-upstream-tbx605f-v1-0-e52b89133226@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=728;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=0ay0Yn47NrOqnN93lopZBRcCGvUD6z+nzkYwmnVRlwE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmTvdqm2pTjw114fbpM5QaceB+tI7QkOzi9/ZBN
 kUANhqyRaWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZk73agAKCRB33NvayMhJ
 0eT9D/9PPFb5qM86jjg/3zPFU64N2RPv5MFOypyQm3ILniA2eOUJrAnpDkRxhXgZxtwaWT5jw2n
 xucyodXuDRTRdZNmEc6bGXMxi0LjZO/abHDYSoi/VjUR/n8T2BI7g7SXqO/0ixrqVjINTJwgDDg
 1vBkxGgsCp6hKVVca4SVEJaoD8kshuoWKYwHy189+UGpMxGQj1MTUSyIDayvmw0fVvljTd3MP4w
 Z1BNWyGJatS7fBx7ZNiPPbiaDfEyFdO86wO4uTzCItXkwZWADtdywRw8H6oKRqhvTOkAxxCUj6X
 wWbuQdwQHLVJjPxwpvHWbLKDGrY/gxOZ9waVKRWB/v/n5A+b8BLcxzwcvmRFs9fUP7bdPF9Ued/
 krnFo3kqn2UgOLvrh/eIBQzcX3M/tPyIvC99ZNoZS8qV0Y1AT+5VWQ4KKesP5OeJ9BF8SbE+3Wd
 FyuDjdfHiqyGKX6ARYfh+qs29j+7RhDnLsUbNBLSD8UKIMNKxLgL4HoSP79uMkJuNb/vsDBzpb8
 7e8o6R6iNb+MemNPt578ZhXxWJhdsUgnWrlPl3HyZuISq0KeQOqZejb5zkxzxrVQb0gIZOgs/bQ
 CuoFu+2zcSC6CGJQ2iqHJaDLDyU/3Q5aFG1lc9udq3tQHNZYO2i+jkxCF0RvtHEK70sYLlF4qR+
 2sxlQHrSUFrzxqg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

This documents Lenovo Smart Tab M10 (WiFi) (model tbx605f)
which is a 10.1" tablet by Lenovo based on the SDM450 SoC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 66beaac60e1d..ab72a6f855d7 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -801,6 +801,7 @@ properties:
 
       - items:
           - enum:
+              - lenovo,tbx605f
               - motorola,ali
           - const: qcom,sdm450
 

-- 
2.34.1

