Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538ED58101
	for <iommu@lists.linux.dev>; Fri, 16 Feb 2024 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081439; cv=none; b=Y1Tt2g1wtMcFfKDAXMnLUgDp6w6d21Tvq1UJHXj9s0M8m7Kp6jouwxG7MIZogwAO/CtUZxelqJY64FfpfHzXdukktBIhQF7+hHkaVg60gPuXiHsFL85SifMHusv4m96pK9I9IbMxsq/Vsro9RFM0/qk5dG0t1T6tWUe0KBloVMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081439; c=relaxed/simple;
	bh=7rJgqOrASH1+9XrvkT4uAGIQBP7+drYr4P1tenEnLrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QEb5RNc7bGQnR5saA8msJ5shyyTnV9AxGOKw9PSnbwXqh7KD8SJlLbm6s+CRPTuVSaCfWqK7i9ZFNtHJb54rub8vmb2Lw1VbHMeKnNE9rW+EMPZulbrGFhTwsklM+PCRl4YYHHEAbpV013rHPqz16Z67zeSSt0+ZTAHm0HFF0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zEThOtlS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zEThOtlS"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412191ed8aaso12125255e9.2
        for <iommu@lists.linux.dev>; Fri, 16 Feb 2024 03:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708081434; x=1708686234; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3p79qEtfp2ZjIJ+XTjXE+1hnr3OUwv786b7yeYiOaw=;
        b=zEThOtlSjQCHef2ShSkYYfu0/DSsSS3ksi/uBr5dCqblUEa8m2FISHYSwOHkrLdluc
         oI3MRmsCRm8qkJxqajRmNlmb3TlJm5OuQpfVXPw4HfiRMbQ5woD4YiaC+UPtQx/9fBcp
         GzsNOCgXrFo6vS0tEqjBuHphI6Rdi2Htn+8xJInKx7KIEIDUgZb03Hth7AcaZxHi7O7E
         D0aSCTwysxu3EFBBizcLORUgsK0K2c29yc6uZGr+DMLorviIil0AtPBqMtTT6Q1vF15u
         XVCxdtRbsxjPYZ65hHc9+aoWudhwdENSdjUslTK4R5xLRxR1mxs5q5+S+7ouu/PUe4tA
         +IXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708081434; x=1708686234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3p79qEtfp2ZjIJ+XTjXE+1hnr3OUwv786b7yeYiOaw=;
        b=El1iWsPJd1FYM3qfNvhrhBJnOh5OVNyLSLUtJv/FgAXoH30lFwvcUUqvKGnVyFIUxT
         sMYv/CkIkLkoSLpb1UhfMCWwJYDDarssL9MrAUZD77q8WSopHhHVNe+QjOzQUxlqBDL6
         /M5A7L6ydps4IsdKVLKt22b6JTBaeTDi77noGUNVTp9b+TVBqFGRd2Ss4NnUEbON4UDp
         0W6dHQ533mnlGBl2DrppPV8f7bsgkG/BGwExhy+E4vVrz85Hh/rRf3XyjfSvvbeU6gWj
         YCeQRy7tfonIGZ2ATOvtR+rTyYVoGO2IgXIa2fkn39aYZ2Zj8ni/hyYcE0V9h+0gD6xm
         MW0g==
X-Forwarded-Encrypted: i=1; AJvYcCUfzlthccSjqRDtePI6I4QyA9epvY42mCJx2yt0cVk2qe8Mfc4ZTY3ULsDv9LuQ174+RIE95B6YoDmDvzakyznZGCDT+04=
X-Gm-Message-State: AOJu0Yw+tcym2NxyZlbvu21tfm1b7T0U0qdtYyjeDnIn/hUC+CTyf2PG
	ABE6x6WhCnDFEHHA2VR1ltBrXmCkQWAxRmx6ZoAkMgGXJJcvqHSBsjmtvmRaf1o=
X-Google-Smtp-Source: AGHT+IGBdNL8KeMG/RG+D3xrVj+pgMbj754F04oy4yi1RpZ6V0RRLQa/LsZkNh4S2dCingJr9VMEQQ==
X-Received: by 2002:a05:600c:198f:b0:40f:ddc8:f804 with SMTP id t15-20020a05600c198f00b0040fddc8f804mr3001191wmq.17.1708081434548;
        Fri, 16 Feb 2024 03:03:54 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r2-20020a05600c35c200b004123b049f86sm1993174wmq.37.2024.02.16.03.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 03:03:54 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 16 Feb 2024 12:03:48 +0100
Subject: [PATCH v3 1/7] dt-bindings: display/msm/gmu: Document Adreno 750
 GMU
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240216-topic-sm8650-gpu-v3-1-eb1f4b86d8d3@linaro.org>
References: <20240216-topic-sm8650-gpu-v3-0-eb1f4b86d8d3@linaro.org>
In-Reply-To: <20240216-topic-sm8650-gpu-v3-0-eb1f4b86d8d3@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=852;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=7rJgqOrASH1+9XrvkT4uAGIQBP7+drYr4P1tenEnLrU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlz0EVKmuMnelD+jPOCbPUzTsHxLthOrLTOHgLjSTa
 xPs9FyKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZc9BFQAKCRB33NvayMhJ0UhfD/
 oDuWdTNYoa15dCO3oA5HvDkWIEClqPqQZHvjaUyI02QCzOQZbQS7T7thHZbOFed88h2oi6jIbXWzgV
 KxWH7h8S+J7gQL4u5XD9bhu5Vcgt4wqA+DABnmw2rxLW3UrwVUkiPnnG95WLAheF81uTwWkWjFfgLX
 y1XQ7DMFEmSUgEubL7Q3WAyicXwmHy26yaqP/Et0eGr7vrRSPwLJuPkXp4JNSZ5itASbwbEItH8PVu
 SncEDTCd8qFewiyGcpenZiCcy/1KNythe/3892+ASMfBHrU3bfAxkHGusUoG75tHoxkfnA+XpjIx4j
 YbIjYFCotP4yelFiFH0ll2Jy4japCWmcRYNg9bjZK7cRqXUjuIT1CPtZYllK4RC8JWY5Kg4PxPNFZP
 kTHo3d3pIPQs1EfRodWBPD3BOM0Vir6ynTmSchUKvskzoG4RUtPx2iu44CEvZ1LWVoe4tj44QQnNtA
 bs+omtQ3D3SkHCQ/04RN+kLEZtBIXrSzdNOV4eLdvPN6yzDvXq0GpNVUIVAJeTrueIS1tDhmghfzLi
 F9PuzzDWB+BSPKDkfkYCK6dWICYAjdb02YJuuC1zuN5gBd8r+dBhyuBMRgOBFd2YjERvpVuX9GU5Fd
 SD5S4DilqNQ8hWaCpNhf6b3skPzzzmSq5FTK+/cGKy8Tn2KWa4l+597zsTdQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Adreno 750 GMU found on the SM8650 platform.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/gmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 4e1c25b42908..b3837368a260 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -224,6 +224,7 @@ allOf:
             enum:
               - qcom,adreno-gmu-730.1
               - qcom,adreno-gmu-740.1
+              - qcom,adreno-gmu-750.1
     then:
       properties:
         reg:

-- 
2.34.1

