Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E20210E0
	for <iommu@lists.linux.dev>; Sat,  9 Nov 2024 00:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111579; cv=none; b=SBsTT3c7Ba/tq+iN74aa9IZr8q7UpEtPI8rohe7+hrZQXJmJtlRSVXGW38ugUbCoUzXp/L20TICGrdbttfXtD/hZHt5Nb0QaXscy8G2aNi5aq6CaLlbo+kCUK6VYVtVbvn0/wGENeHYkiENkNSTgsdXWAcNus96fQfljxQsCiCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111579; c=relaxed/simple;
	bh=L6j9s89naB7opnvnY4tHu4vgTBs+UfFjAA+WV7TeqVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmZZr2mDjEaNO+3Q83IFy/0jds3O/q69wu9tzZz+M7I9BgirtSu2ADak/vrNiX37vwb40wXDZU7Qt5SgOfAoKkANy37b32246mKlRDEh/4Eo8hdxzRqynL9Nxc9VFauQtSBJf12k89Y2NbCuTykif6uUSdZoiUdGiOSLrMFxIcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g5Vs296B; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g5Vs296B"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f1292a9bso3537164e87.2
        for <iommu@lists.linux.dev>; Fri, 08 Nov 2024 16:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731111576; x=1731716376; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BXpnPSSpQgottu2Fv5+e3o4as2xRNwzcJf3h5d26SFI=;
        b=g5Vs296BN6AzkR86kyu+kPDlORy4/ZZcLrKgV2Eo10OHhgF96tTIoH9PsWrPJTAgT7
         cMReWv/9vXGxfvxJyfwRd7eCils6pWB9YUvJcFR0A6N6AjsJ20gfLBn75lcMEFdL9T5S
         Uuo/SwcFM1nD4RjkCqv2TLiU1sAH0NlvdLoo33KY2+VrQpxR0mf5uxfmwhcGuh9ho6+L
         6Hr7DeLb9OXAM/a7IrGOlUFFYaw6LclehltKMT9/uTrm9W6UVZQVz+SUIx0wLBwDnw5O
         lV9K98goDd82jt/S/aQ5QUAtvoDxll6z7g5RZ1O4Q0YYxhZGZrlFnLEKQp+1bEkOMteb
         Hx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731111576; x=1731716376;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXpnPSSpQgottu2Fv5+e3o4as2xRNwzcJf3h5d26SFI=;
        b=kKsM//a+lJI0AAWz3eKMRyHjp22M+6Yk6RZG2gG81u58PkEI3ivtmrl305UYOEUKoF
         jmwPi9fiJBf1I2MrpgKEzgdzIQARCEl6IbEC4jVEsMv0CxAJ8Xm15MmidiJLARcbGDh0
         nsaOcW2WQ0i4Y1Yb6WpHnp310DfGvN0zzSahhOkcwW3lXnT5ED6JqTT6xpmgTGuhtSuf
         XAOMpL+R22bg+0rlkLvOTxqGKOoOJCByXXaqebDsm6KiFrice6gXLeXlTrWdU7CiuJu3
         vTQT+SdhK+zyol1AKJq6kpRU0dCfQixTR57TU7XFJ79du0V1zpYHMogyqToptavA0+lC
         aW9w==
X-Forwarded-Encrypted: i=1; AJvYcCUvif4j4w4KpQnqVThWIpGqPlFd29M3Ita5tdjSzFRwGDcq19xKOART2OSvrys1aaYWdV74PA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxQjZUtU5KLaxDFceWQLPM8c00IaI0CkcsYbvfZVAaJtZmOeglV
	bgWpuzwoEOo7X5+nRq/NfYfanXXEfB1fNSgk+72v8Stc2DA8HXuqAv77DaEftqc=
X-Google-Smtp-Source: AGHT+IGy8JaWW53o7Nak3hWvpUBVz+q/19zh6rKz4u2hY6tZfCVQUBkESW5jVf0+ApmCehnOdBwEyA==
X-Received: by 2002:a05:6512:238c:b0:52f:d0f0:e37e with SMTP id 2adb3069b0e04-53d862e4fc4mr2643346e87.42.1731111576019;
        Fri, 08 Nov 2024 16:19:36 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826af0c6sm785132e87.277.2024.11.08.16.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 16:19:34 -0800 (PST)
Date: Sat, 9 Nov 2024 02:19:32 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Lee Jones <lee@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	Otto =?utf-8?Q?Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: Re: [PATCH v3 07/14] pinctrl: qcom: Add MSM8917 tlmm pinctrl driver
Message-ID: <ohznx4dt63gid324qqsmbb7iuqcpi5xxhftwmh5mfo2w26myrw@q4bfwrgw4mns>
References: <20241107-msm8917-v3-0-6ddc5acd978b@mainlining.org>
 <20241107-msm8917-v3-7-6ddc5acd978b@mainlining.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107-msm8917-v3-7-6ddc5acd978b@mainlining.org>

On Thu, Nov 07, 2024 at 06:02:48PM +0100, Barnabás Czémán wrote:
> From: Otto Pflüger <otto.pflueger@abscue.de>
> 
> It is based on MSM8916 driver with the pinctrl definitions from
> Qualcomm's downstream MSM8917 driver.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
> ---
>  drivers/pinctrl/qcom/Kconfig.msm       |    6 +
>  drivers/pinctrl/qcom/Makefile          |    1 +
>  drivers/pinctrl/qcom/pinctrl-msm8917.c | 1620 ++++++++++++++++++++++++++++++++
>  3 files changed, 1627 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
