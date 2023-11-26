Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C5B6FB0
	for <iommu@lists.linux.dev>; Sun, 26 Nov 2023 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gP7dxY2B"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40b27726369so23705145e9.0
        for <iommu@lists.linux.dev>; Sun, 26 Nov 2023 06:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701008255; x=1701613055; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QcndzPm7z338RHK94VwEZXvnKMZos/UvhLkmjn4xC/Q=;
        b=gP7dxY2Bn6tjke8uJ5QAbWi/JVQ4RNR5f/s6nqwRVscJX7ST5OAvaYRV4Hcyh1p9FK
         WhDRXI+Y8hxrLC8Orj2XLfxYiIQsjIjgSJ1NI/ULqvCfAhVoxzIOVPD7rfRJ8edQImpK
         aKh904q0XtJKEpR8oNuYeDh9NUaGcuEcPr5gZCZ11wtnXra7EKFF1GwcNYp4I75u6f4R
         20rNbAlCv88UlZNU4Uejx89o66N1UoRJ0PZoJpMvZqtpr4hSRa6jPvPtqKY+6lrDc7+T
         Lf62Bbz+7k1PVDxn8H3nF7EzN2BSHQb1j2xtolw+IbslusssVTbeX3U5lnrtSAiZsoUE
         4ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701008255; x=1701613055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QcndzPm7z338RHK94VwEZXvnKMZos/UvhLkmjn4xC/Q=;
        b=Ov9zQ+UWv2lTVFrQ7teqx0rpwwp/ySxjerLdG4PRuS2CSDs80nOjinkswiEyq/Sos5
         WWBM8yP9YmZB9nj4wtKLtsyZcR+ieSxvZBUa3jD5cogHQwbXjdzfVhLIEOfaUwbchUGl
         2jmx39AtvVHZLuWG2U6h8Z2TfAokeXaP/0g5xu2tt6OZtDDaH93McAeJv7BPlOI202mS
         l1Gw0VikKTmQte8058PpMpy654AgLJKivn8QiAuDIQEWwFyvToXMq6r611W9dxAPI4jC
         jc14lxC6eMoLvadbeOJhQNte7MvslsJ/lIh2RlWNoVVxByIhIaaawaGio7UUjNEzfeYy
         OuUw==
X-Gm-Message-State: AOJu0YzjBhQulra8SbmRbm9ULCq0vJ0JcbVtZYkT8krYsyPa77lOu3Mk
	MvvgyReum/oZQnx9DrAtQ6gxkw==
X-Google-Smtp-Source: AGHT+IGkk9pdn9r7g1J1o/fcsxC78jPge+mZy3lXPIb8wrgrQCxYQ08bQdBSvKnCzAF2mipxLo0QBg==
X-Received: by 2002:a05:600c:154f:b0:40b:3dbf:f39 with SMTP id f15-20020a05600c154f00b0040b3dbf0f39mr2924922wmg.37.1701008254426;
        Sun, 26 Nov 2023 06:17:34 -0800 (PST)
Received: from [192.168.100.102] ([37.228.218.3])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b004064cd71aa8sm10565101wmq.34.2023.11.26.06.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 06:17:33 -0800 (PST)
Message-ID: <1dce7a79-be67-4d44-b03f-63ef5cbb78e3@linaro.org>
Date: Sun, 26 Nov 2023 14:17:31 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] dt-bindings: display: msm: qcm2290-mdss: Use the
 non-deprecated DSI compat
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Clark
 <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Loic Poulain <loic.poulain@linaro.org>,
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
 iommu@lists.linux.dev
References: <20231125-topic-rb1_feat-v1-0-11d71b12b058@linaro.org>
 <20231125-topic-rb1_feat-v1-1-11d71b12b058@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20231125-topic-rb1_feat-v1-1-11d71b12b058@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/11/2023 14:17, Konrad Dybcio wrote:
> The "qcom,dsi-ctrl-6g-qcm2290" has been deprecated in commit 0c0f65c6dd44
> ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every
> current SoC"), but the example hasn't been updated to reflect that.
> 
> Fix that.
> 
> Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> index 5ad155612b6c..3d82c00a9f85 100644
> --- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
> @@ -56,7 +56,9 @@ patternProperties:
>   
>       properties:
>         compatible:
> -        const: qcom,dsi-ctrl-6g-qcm2290
> +        items:
> +          - const: qcom,qcm2290-dsi-ctrl
> +          - const: qcom,mdss-dsi-ctrl
>   
>     "^phy@[0-9a-f]+$":
>       type: object
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
