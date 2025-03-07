Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D78194A66
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 05:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326518; cv=none; b=M8L24RNm9bW7ZWCf10cfdrEslGWtTisCybM2SpQT2fkTEplYO52/8oYyWyR0C7E393A/iQMhXMStwwQHVZU2XZEjkhn95+vtn/+Cdbe8xDGp8uqNhZwOXVp2K99LOgzKVjkqVDx4gv6bkSNjr3+fwZX8w7T7ZbST6wSer8zn3bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326518; c=relaxed/simple;
	bh=f6dKyFo3BkLrXoBHgGJQ+69N8B1GLf2n1hpUnfgTQTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jpdo9dVF/Y+JIh7IyfEoKUyf1lAxy8i8SVLf7OVe2jLEyDxz4/3Qi8T1pDWvS1vhO+JZd7zrqC+1spg+tC5HmpCMu9emNMV4o6XOrMNUMz+SPB1pagr+I6Rb6rE17DYstzG61lglNHJtOWFPCdjf9a1MW94Gg5atrdKOlMCDb1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=moV2kvYB; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="moV2kvYB"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30b9f7c4165so12802111fa.3
        for <iommu@lists.linux.dev>; Thu, 06 Mar 2025 21:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741326514; x=1741931314; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xIUlPQiEEjx7lB+nUPvIprXpkiiTW4hGNlxewbBn0Vo=;
        b=moV2kvYBS9PA/9VaC8GUvQl/CuCWZf+1jV79wp4ebfGtRbBPRcM8tIptrIQeQvmumZ
         tDKBZyszVTuE725NIJfjBERSt38Gw5LhM4cof2MpmL3P5y5iPKRAtl0d/ZCE+mAng7rj
         z+WobuPhgLpaWTp0Ildbj4FXo3G3X8CCyJyccVxpUt1iBRcmI7YnIrSS2bUiKhiIsZXj
         1T9TerZ/LDncYMqqKMRmOIt7oFLN0eueCdRyec/bO9omCQ/qf3SJWzdcUpeOf8GW3I5C
         mDKHPB0BCnp/vl+5dYKHTLeV7sJHQvJ9hXlXzzpVfxy53INJAY3lxFQwLMkP8OaMSsKX
         yMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741326514; x=1741931314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIUlPQiEEjx7lB+nUPvIprXpkiiTW4hGNlxewbBn0Vo=;
        b=Yb6JqYVs64g5kYGy/hgjyy+t7ZwZvlTGnC7l4/TrYlSQwLltP7IDf0GwEDo6s6ZQzk
         FWRnW/1U4admutesbbWMXiynar4gMXgdFyBdd9VtK2LLrbP8otAQ6aB1QC++AYZFUkAc
         M0eCSqyp6EQ7nVEaiQKkhmsbFMrk6zZPhrd8UBdm8jBAaBkR1Z2ZHk75m4Mkcadoq2Gj
         wJwa/ewAUQJwZwylDJL88VtVo7hihDMCKyKPYTzXmQYx9M1m1VVjKTD7SHM4GK4sRTsI
         JNbDqawvQTS/NGbF1FqeUv5eKGR65nRu1+FyamjXjnf48P78LyFB964au2i8ZdV3/KJI
         sZBg==
X-Forwarded-Encrypted: i=1; AJvYcCUKJYVyma5pkQ+FkDGphf9OA7WequSAInVLBSscZdQwlMm3NlQMQaiAPqzat/dqA3Ko+GqXvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwGsuz5kkKKtv4N55DFqqYDBJNgwc0r3K2FWMmKiirD32OlWlw
	cmFxVgx9yhppoC7RMLOaL2i5kCMUYGsNV565FEqw6dFUnkbWrr+0ogEhcwiRdpg=
X-Gm-Gg: ASbGnct44Gx1K+zJGz9AzEqHWkX+6P4uqUG9FXz2s6Rh3N34UjglHzdr2giEugwjrV3
	aFZXJqj5CaAfDrNVxxLANRA3poFanvaKJmWmd8pOO9RojPA8iPS0KcrV0mIwQUv6YKGL2xMYuxT
	eVNiDOvr7DTHGThfxupJ8JHpJZnHNOK0vZXQK1XDPVAg5aI+I20HzZ4ZVMCDh3bYLRc/0ww2eDd
	QSBukgXW8m6My4bAZNIoaYRh9ag4cioC7upRKIE7fjwVydJ3YyKN/UD2UR9h02IBvnNzPeS9kCx
	+jFdYH2SkTxesiaZS0vjxRqjsATuonPbS5CK3neQi2ruk3d6MRq6TBoV2/oTmUCE5QPlOogcgLr
	WDslPZFCXAhT9iwIt02W65hT2
X-Google-Smtp-Source: AGHT+IFLgCjDUK+ssfV3W8fYXWF3IcyBRSZKJMxl/h3Pqf22SL2LHsOB83+2OXk5a+mSVQE5lVC+4w==
X-Received: by 2002:a05:651c:b2c:b0:300:2a29:d47c with SMTP id 38308e7fff4ca-30bf4606942mr5189011fa.24.1741326514230;
        Thu, 06 Mar 2025 21:48:34 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be9a07204sm4342721fa.114.2025.03.06.21.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 21:48:33 -0800 (PST)
Date: Fri, 7 Mar 2025 07:48:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Robert Foss <rfoss@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, Christian Marangi <ansuelsmth@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Rohit Agarwal <quic_rohiagar@quicinc.com>, 
	Kyle Deng <quic_chunkaid@quicinc.com>, Vinod Koul <vkoul@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	linux-usb@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 06/11] arm64: dts: qcom: sdx75: Rename AOSS_QMP to
 power-management
Message-ID: <zmy54zmhuai5vip7fvdjkf5hr2tsnmmh6ts2labnh3amkg4s2l@6pjfprdfxn56>
References: <20250306-topic-dt_bindings_fixups-v1-0-0c84aceb0ef9@oss.qualcomm.com>
 <20250306-topic-dt_bindings_fixups-v1-6-0c84aceb0ef9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-topic-dt_bindings_fixups-v1-6-0c84aceb0ef9@oss.qualcomm.com>

On Thu, Mar 06, 2025 at 07:11:18PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> The node is currently named power-controller, which requires the device
> underneath is a power domain provider. Rename it to align with other
> SoCs and resolve this sort of warnings:
> 
> power-controller@c310000: '#power-domain-cells' is a required property
> 
> Fixes: 91f767eb6938 ("arm64: dts: qcom: sdx75: Add AOSS node")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sdx75.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
