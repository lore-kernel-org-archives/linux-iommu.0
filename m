Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24AB1AA1E0
	for <iommu@lists.linux.dev>; Sat,  8 Mar 2025 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741447522; cv=none; b=jOtQ1klZ6KQrSVQ6Q15+9Tblq4tq7eHnBRynkm+XzAIyma5vZjJYni/D0s4IKJwlYd4xhksGTm1eYVOPSHV7z0iG1mjv8raIXrKTMF5pmeA5nQWrrX7/aw4fETfQRI7RriECgvMXie1g2Fb38qFc1y7RrhxxUnniQ86JTBXxOyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741447522; c=relaxed/simple;
	bh=ffB1xJN8TgDrXjwkJtY5En7Rvk6xDEMsDSqKlqlZbog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6GhLHhyMTh2e0VgAYYtMXSYENGkmMOwNlJIS4ROgjBAHTzikSaf8YeKHl+p8b0ac4c6u52ZIcRqG6Cj3O/sx3z3hk8sX6gm75bFb4bBGGavzp0sUFbLYyCpG861oYsI/K/5svYGXp8a1dVAirySEtgyDxbAdy/r0bEMO4w4HMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ufb1B2ze; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ufb1B2ze"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bfed67e08so7518561fa.2
        for <iommu@lists.linux.dev>; Sat, 08 Mar 2025 07:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741447519; x=1742052319; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HKBg6m2ZBD+SRolEbJmxTaEbWBs0aYZ+E9F5kWCXB5g=;
        b=ufb1B2ze+x7FLoz4O7SRWslEkt2Pk9yhmQJUs+bfhxSeKp1uXUpmaYGVO2aG3mVvQ7
         FAWKZddJJGwPD/fTclq47gQhhmACkLBh2OKi2U2PAuqNUYjbc3ZJIFklkm1OmlKUxqNg
         QAW7pFksLcuoZ4Wzrhc0wK2yBscptGJfALx6GCInadupT9aO11YDasqzzxIHOS8maJVy
         GVeUOqKL5nyPjDTPF1waybNgeh7CAeIBwJ9kU1101ZMPy4PWYD7cRlxk1CUPtnrHg5w7
         JkbSjZt1+eOn/Bh0uCIlQ4LVqdARE/Q6MCxBvEjrc85mYg1/C1LVwFxJ8UM0zGdk1M7v
         h2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741447519; x=1742052319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKBg6m2ZBD+SRolEbJmxTaEbWBs0aYZ+E9F5kWCXB5g=;
        b=g/lPkICqd11Ys2mQrNdgUSqKIHoPE3b6VeqyUsSaNCTQ2s8Bkw/p2yOGs1CdKjhHIh
         3IsqUfpnWXLhGUCZGVQxXpTb5f2HpTkPrLAllob2DljLbdQDIihmRdkBuUsntxsB1Fr1
         f0GFPgJiULHk0huHDvvRYxxxFqF415/1lxiObRlXJLb4vnVAY/2BKDbH4DFuHoVt+Qnw
         AmZ/DKzA5a9ApqVb6Gy8NjWlmvA8ZVLEjsgpoZEK3Fbbms2nI+kVXFRKGXDobYTnJY9R
         26Nvpa/rTAHNWCy6BRquqp4omptM4xlAqpvtGO3BRvka1ZQ86TikSm7atbe4o4t7sKz1
         x99w==
X-Forwarded-Encrypted: i=1; AJvYcCVI4ACmtwOm9wK1DpJWg0fue071v8DS1WIdJrE4FNkOo0yi+rJd67SDOm3oL77TZE3Gs5pAaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyBQmL1nWVNnjkheKo2bfseU4POm+jT8AB9lqaa2ScjZXj1K1ff
	aduDuQnJohgBSpewUvoidAvdtgiu8mQ50xibmbWWw7wzM7Bfy7GHhYfOY54i9/Q=
X-Gm-Gg: ASbGncvV00yF1OryIub4FXY6tj2CJ1Hzv5Ywhvis/AjvtDuVDxI/mX3HM2UlwiuHjlD
	EP96AiQjhDKnjxvS9wOIXnqUOHcklAain+35XmeJzIEo1HIANpi4BCT4toxMWJw6j+b/W+FVwMV
	/UohKRjuki1Rs6wA6b89vKyI6fHu8+1kF5L1+zVonEChPQJkikPFGVrnMVwC8ZJEQJUF2dr8Vri
	Z8cbnUcPShOiswF2X5Q6/SIGaRoqxk3gvcHJVA2z6Utxyywu5/gQaTQ1aXjzo48+UYK6VKbbZ9K
	FUs7CBNq8wNhk75nLbnezhMzCAFQq/QJMaEXO55/zrZLCMyavZkPwIldagLtP9AzwPy94ioxXHt
	CAkdLOdYQMZOzN8Zsmw8IcTrz
X-Google-Smtp-Source: AGHT+IGa+Ul+zGmtbtHzOv+NiUo+h+jc38TvQkxrCnLVKsfBxUNjbh9YNgRAJWxI0GRtuRncaHMZ6w==
X-Received: by 2002:a05:651c:19a1:b0:30b:ec4d:e5df with SMTP id 38308e7fff4ca-30bf466dbcfmr32754081fa.34.1741447518937;
        Sat, 08 Mar 2025 07:25:18 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be99c85c0sm9452071fa.87.2025.03.08.07.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 07:25:17 -0800 (PST)
Date: Sat, 8 Mar 2025 17:25:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Dmitry Baryshkov <lumag@kernel.org>, Rob Clark <robdclark@gmail.com>, 
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
Subject: Re: [PATCH 07/10] drm/msm/dsi/phy: add configuration for SAR2130P
Message-ID: <qextyfjeniihulyilehcldd5x5pdpaxo3etstlcq4a43cka3a4@4n3mqkjjysqt>
References: <20250308-sar2130p-display-v1-0-1d4c30f43822@linaro.org>
 <20250308-sar2130p-display-v1-7-1d4c30f43822@linaro.org>
 <53c3d2c3-2bfb-43f9-ad25-0d1fdd96f19f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53c3d2c3-2bfb-43f9-ad25-0d1fdd96f19f@oss.qualcomm.com>

On Sat, Mar 08, 2025 at 03:17:23PM +0100, Konrad Dybcio wrote:
> On 8.03.2025 2:42 AM, Dmitry Baryshkov wrote:
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > 
> > Qualcomm SAR2130P requires slightly different setup for the DSI PHY. It
> > is a 5nm PHY (like SM8450), so supplies are the same, but the rest of
> > the configuration is the same as SM8550 DSI PHY.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c     |  2 ++
> >  drivers/gpu/drm/msm/dsi/phy/dsi_phy.h     |  1 +
> >  drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 23 +++++++++++++++++++++++
> >  3 files changed, 26 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> > index c0bcc68289633fd7506ce4f1f963655d862e8f08..a58bafe9fe8635730cb82e8c82ec1ded394988cd 100644
> > --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> > +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
> > @@ -581,6 +581,8 @@ static const struct of_device_id dsi_phy_dt_match[] = {
> >  	  .data = &dsi_phy_7nm_cfgs },
> >  	{ .compatible = "qcom,dsi-phy-7nm-8150",
> >  	  .data = &dsi_phy_7nm_8150_cfgs },
> > +	{ .compatible = "qcom,sar2130p-dsi-phy-5nm",
> > +	  .data = &dsi_phy_5nm_sar2130p_cfgs },
> >  	{ .compatible = "qcom,sc7280-dsi-phy-7nm",
> >  	  .data = &dsi_phy_7nm_7280_cfgs },
> >  	{ .compatible = "qcom,sm6375-dsi-phy-7nm",
> > diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> > index 1925418d9999a24263d6621299cae78f1fb9455c..1ed08b56e056094bc0096d07d4470b89d9824060 100644
> > --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> > +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> > @@ -59,6 +59,7 @@ extern const struct msm_dsi_phy_cfg dsi_phy_7nm_8150_cfgs;
> >  extern const struct msm_dsi_phy_cfg dsi_phy_7nm_7280_cfgs;
> >  extern const struct msm_dsi_phy_cfg dsi_phy_5nm_8350_cfgs;
> >  extern const struct msm_dsi_phy_cfg dsi_phy_5nm_8450_cfgs;
> > +extern const struct msm_dsi_phy_cfg dsi_phy_5nm_sar2130p_cfgs;
> >  extern const struct msm_dsi_phy_cfg dsi_phy_4nm_8550_cfgs;
> >  extern const struct msm_dsi_phy_cfg dsi_phy_4nm_8650_cfgs;
> >  
> > diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> > index a92decbee5b5433853ed973747f7705d9079068d..cad55702746b8d35949d22090796cca60f03b9e1 100644
> > --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> > +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
> > @@ -1289,6 +1289,29 @@ const struct msm_dsi_phy_cfg dsi_phy_5nm_8450_cfgs = {
> >  	.quirks = DSI_PHY_7NM_QUIRK_V4_3,
> >  };
> >  
> > +const struct msm_dsi_phy_cfg dsi_phy_5nm_sar2130p_cfgs = {
> > +	.has_phy_lane = true,
> > +	.regulator_data = dsi_phy_7nm_97800uA_regulators,
> > +	.num_regulators = ARRAY_SIZE(dsi_phy_7nm_97800uA_regulators),
> > +	.ops = {
> > +		.enable = dsi_7nm_phy_enable,
> > +		.disable = dsi_7nm_phy_disable,
> > +		.pll_init = dsi_pll_7nm_init,
> > +		.save_pll_state = dsi_7nm_pll_save_state,
> > +		.restore_pll_state = dsi_7nm_pll_restore_state,
> > +		.set_continuous_clock = dsi_7nm_set_continuous_clock,
> > +	},
> > +	.min_pll_rate = 600000000UL,
> > +#ifdef CONFIG_64BIT
> > +	.max_pll_rate = 5000000000UL,
> > +#else
> > +	.max_pll_rate = ULONG_MAX,
> > +#endif
> > +	.io_start = { 0xae95000, 0xae97000 },
> > +	.num_dsi_phy = 2,
> > +	.quirks = DSI_PHY_7NM_QUIRK_V5_2,
> > +};
> 
> I'm squinting very very hard and can't tell how this is different from
> dsi_phy_4nm_8550_cfgs

97800 uA vs 98400 uA is the only difference AFAIK.

-- 
With best wishes
Dmitry
