Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAD3EEBB
	for <iommu@lists.linux.dev>; Sat,  8 Mar 2025 02:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741399224; cv=none; b=arJKbHQtxHCEC3Uuy4Lko3q1azvqQJOOgeF/cGI21EFwCy3RMNelGpNcLi977GvgqH1xdsAuivXDWQ0A8p1GcrbNy9r/gb06K06jHLDC8/W4dO/wJAG/AMk5+WodEeLbPj0AkBg9uYbN5ZCtmZLhOR1RNHSfgfBkli7HgWBREGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741399224; c=relaxed/simple;
	bh=S8N+QxxiOhUsGd3S0a1x+yo4CeNlEdKYrscPJ0aeCTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxJG6XiA5OJ+BVPqewn8wACJaGxbFilBLv761EMUmCbCRKVAeP+XwpUj+kO6tbrAv/xt80ofEGeoVtgXfote5YEIcsB+LqD4+CKCXBHaSBocn8fUU3Ifm4X5/6y28KSa6Z0JW0bYhsgUGNjgNR+rM5jgJD+OSWqHC0ec37FcxF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zZEUNWb7; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZEUNWb7"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30bf8632052so11118821fa.0
        for <iommu@lists.linux.dev>; Fri, 07 Mar 2025 18:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741399219; x=1742004019; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NjVkCifx/RSQQ8Da117ebd6rVOl6XM9uzHnpVWsZ5zs=;
        b=zZEUNWb7PwMwRdrWZyNPzolSqmydeBs1tbh0EVdjpBifBuJZw4UtjivuY9BJGSs+PK
         dOhYHiM6Mz03aH3VWgZXWSJo9vWkfT2JN/uYHHe6QrqePcEvy5YFvelSc/bWoUOz7YRf
         Ww54J1mIAqyQtQzakoeWcrcM2I67cYPWmJ0XbhURnmofR33lIGBen8PchSBaGqO9u9/S
         aZ5l5m36i3PdW/zJnXPPRzeCFsTQfuEeO+RySmjwAO+XxNurIN3NKR/R7MA/qGq8fXOG
         dJwMPjSZOzgoC70e41n+gj+EXttWv19gHVKF0Fx6ruxYgG0yqE+SuePkmnzSP3dwR0n1
         xQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741399219; x=1742004019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjVkCifx/RSQQ8Da117ebd6rVOl6XM9uzHnpVWsZ5zs=;
        b=lJyqMc979nrQQZkGFhYvQHqGSgoux21l6IAF0fL9CZCxnyDbfbsoNtLsVKQhK9VgA/
         1+AfjTyv6TClyMU0EOcmc3t1PoC5KFJ4CVEuSmnVY/le/rprK0+1tD9CryFLZIaG+mN1
         N2Kky5UqLd1iSWWTtBnHLz2m2nh7JHRDAkrSvePpczhgoMou5AXYgEL9waf4O3metY3P
         VXJXmNmFlGvVtsN8WrPehtAWkLgoexZY9crazYGLIGauTVuOv76TWxNkK6UO7v+EhMbv
         AZsEtrgUfWmL59+ibYwRgTVj6Wy9HQxI25fOGaAG8rj9z6BdcWT93khDqdLnh7Snwk+1
         HWKA==
X-Forwarded-Encrypted: i=1; AJvYcCUaVuEusWTG9i2r+0KhOMFIiU7jFyMPBi5e11GdKyxjq1IhHRjEYHp7FWr07b0/Sp70OvxpPg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf1MfGO7ra93ibK1i/Q3Yf8EWH8wUp/MFOcHuBjbRUzYswhdOt
	YWkqKgGhhDDQapAIM191iU6ylukmup9jtC/dXZCL4ESpP++Q0qK6rcF2ZR46yMk=
X-Gm-Gg: ASbGncszDBa2W26y2S0vTRg6wlh4olSttk+Lu91WbxFGx6CmYy2iwoYqj2iJ7nWDt6x
	YC6XEbef4wQ4cu22HoWuJlhYB+/Tyb1H8kXoMmaL5wVsOMa45b+yg1/I3PbV8UQfYoqGZeeaB9J
	CGF2R2RbrROZIVIaw3GQzge9IFo4lx4X7zqsas/XIZSrt8EpEc3M6OQTEKKRU4LTii2I4CWFZg4
	d2jCZfDHYjlf0dtqw+xpgEFKyusS5D9XwPkQj0rtOL9vLm/GjWJAdzOzwzU9zBpVZQdCBoUVFbA
	rtYro/9pRk45Gh8meuZa7/IaEP/g0atFCeDkapyqiOqe2sK9jZyJsbuJuVz0ApJ66JUllk42cMy
	lqmiURXX24SEmelMd+sf59Ao8
X-Google-Smtp-Source: AGHT+IHD+uwBqwVOK6PF+JlAvIXYtVL34Ab2L2yfhLPX2xkxj8BVZbxw9BTY9Ei5g5385gK2RsIBIw==
X-Received: by 2002:a05:6512:3dab:b0:549:8ed4:fb46 with SMTP id 2adb3069b0e04-54990e676f0mr1813977e87.26.1741399219383;
        Fri, 07 Mar 2025 18:00:19 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c33bfsm680563e87.236.2025.03.07.18.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 18:00:18 -0800 (PST)
Date: Sat, 8 Mar 2025 04:00:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Dmitry Baryshkov <lumag@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Krishna Manikandan <quic_mkrishn@quicinc.com>, Jonathan Marek <jonathan@marek.ca>, 
	Bjorn Andersson <andersson@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/10] drm/msm/mdss: add SAR2130P device configuration
Message-ID: <kifzy754m7zygspknsk4a4aeuqxkt4bkyp5jbu6ul43gon7je3@yleqikfmh4lp>
References: <20250308-sar2130p-display-v1-0-1d4c30f43822@linaro.org>
 <20250308-sar2130p-display-v1-6-1d4c30f43822@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308-sar2130p-display-v1-6-1d4c30f43822@linaro.org>

On Sat, Mar 08, 2025 at 03:42:24AM +0200, Dmitry Baryshkov wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Add compatible and device configuration for the Qualcomm SAR2130P
> platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/msm/msm_mdss.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
> index dcb49fd30402b80edd2cb5971f95a78eaad6081f..3e82ba0885d03107d54eab9569bb4c5395454c7a 100644
> --- a/drivers/gpu/drm/msm/msm_mdss.c
> +++ b/drivers/gpu/drm/msm/msm_mdss.c
> @@ -592,6 +592,16 @@ static const struct msm_mdss_data sa8775p_data = {
>  	.reg_bus_bw = 74000,
>  };
>  
> +static const struct msm_mdss_data sar2130p_data = {
> +	.ubwc_enc_version = UBWC_3_0, /* 4.0.2 in hw */
> +	.ubwc_dec_version = UBWC_4_3,
> +	.ubwc_swizzle = 6,
> +	.ubwc_static = 1,

This should have been .ubwc_bank_spread = true.
I have been rebasing the series from the earlier kernel and I'm not sure
why this didn't show up during the build phase.

> +	.highest_bank_bit = 0,
> +	.macrotile_mode = 1,
> +	.reg_bus_bw = 74000,
> +};
> +
>  static const struct msm_mdss_data sc7180_data = {
>  	.ubwc_enc_version = UBWC_2_0,
>  	.ubwc_dec_version = UBWC_2_0,
> @@ -738,6 +748,7 @@ static const struct of_device_id mdss_dt_match[] = {
>  	{ .compatible = "qcom,msm8998-mdss", .data = &msm8998_data },
>  	{ .compatible = "qcom,qcm2290-mdss", .data = &qcm2290_data },
>  	{ .compatible = "qcom,sa8775p-mdss", .data = &sa8775p_data },
> +	{ .compatible = "qcom,sar2130p-mdss", .data = &sar2130p_data },
>  	{ .compatible = "qcom,sdm670-mdss", .data = &sdm670_data },
>  	{ .compatible = "qcom,sdm845-mdss", .data = &sdm845_data },
>  	{ .compatible = "qcom,sc7180-mdss", .data = &sc7180_data },
> 
> -- 
> 2.39.5
> 

-- 
With best wishes
Dmitry
