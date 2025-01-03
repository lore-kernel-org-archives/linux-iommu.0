Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957AE19D06E
	for <iommu@lists.linux.dev>; Fri,  3 Jan 2025 12:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735906926; cv=none; b=I1h9Errvn8KPxj59oj6cDpBxBVGG7YakONS0y4SGp6L2JLG8uIouXm4w2swqHLgUA3lPlE2kxY2Lg2muq1oZ5MQZm82V2AxspoBPOsRbEJd8NiV4l3cUA+cP3KrjrTkWQx4vv2klkHNK1ga97OdRid6y20uNEEtVNRyechMl3LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735906926; c=relaxed/simple;
	bh=O8EXrmDhtANaIfvlDnTl772IIDoJbmLJdAgbz8+k41Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rG1XzVz/gBzWfqHcxxR4zKHYCdQ+CNZQTagWyCVBS/lmYVTYUR7YrUffnxONk82GsqWxeP8boTbUQvXt/ipQJVJPaOr1TQ7fW6zMjsJ7vrOjDI88bXeiJcexZbO7FfwrSdMQjnK/z12L7BHjLU+uCoH/2LzcqOggV+vPiJpGo2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K3U9Jt5G; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K3U9Jt5G"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5401b7f7141so10993614e87.1
        for <iommu@lists.linux.dev>; Fri, 03 Jan 2025 04:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735906922; x=1736511722; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cYsxb7BeQ7ZfzNcH7+s2mWWWWWRZcp/zu7awCW8Opwg=;
        b=K3U9Jt5G33NX21Zaily3KDktzCgbtFuVxZLcHnduApU4Gg1LB1p09wtSzUom1fQBTo
         4bkHcDPTy4NYzXFJExE2Qk0W/7dlD7uU9j0s7K0CcSZZGedZgQK8EHXBs1b4T4dn6wDw
         TQZBOXCOuFiZQVpaT6qXMptN8wgoB0qDUJtDWdtadBMfUCxB212DX0R8DSEGyqzCKmIc
         zflEjyW7pJRjHnr0v3ycQXz9EEuIdsiEkad70vKwhzpiBP20Z/9XtuaA0UDnJTvSPi3r
         zrMjW9QMiQZxr/EB/Q5TYTIkVMcOv/4aJfMyMkQHiR2jWIA8IdM35oEhJp0rz3+a3VWh
         VQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735906922; x=1736511722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYsxb7BeQ7ZfzNcH7+s2mWWWWWRZcp/zu7awCW8Opwg=;
        b=bJR7yZy4ey4ZMVpe21ISw12GywvPydyId5HVQZQ2xHxnijIa35M1U0CPBBWlCJpok1
         CheS06yd9gFvElurUcAKaQAXF+vmsAs8gJ7ebx621QfX/Mjc3H0Ir/RJMx1ePcoxkl4U
         5EAFXyWaDYOyumKXKJt8RXoziU9hSfqnPJgzY5PL3uXEReZ80G6IWvVlmPVAMaV+52JM
         7IwrguO2AwxulBy2LimeBH4Sr+7YlDJOWjPiZNF6BfB6vMKJHm+eeovzPFabz1797aTd
         gV8+yYFyGAMM/8ck6gsXrFxkB/OxyNuG0jxWzibMB2aktAX49y6KS2LupFc2gzIbjxIF
         W79g==
X-Forwarded-Encrypted: i=1; AJvYcCWMB4Z46ggrZKDPvFlBLJRgINvEynlttThCj41b6UBUzis7qZwNnF6Zkby/hceeooSXI7265w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzMXdkYwjx1iMJb9Bt6e9SG1emcUY9pLS8UgPsnpfA0c8OWRf+l
	dlVDVRlpZP8OPWA3CiBaYf1qmBkdjSSqcL8zNaeEppVZv9FBblRAjB6T1lm2Ib4=
X-Gm-Gg: ASbGncuMpcNwwVtgNFwUSsMKhio4nA2AfCyaanMZwP6Uxc5wEuLpLH9E0uogClclrLl
	rVWC8bfDZCVHESjYGGJi1QUUpNC/iC564vaEvNf1r4nLAosz7qtYAB/1VpouJ13sO0DrzKqAaf3
	OOLEuBw3WHwn8wOQn33vQgF+dA8ctnIU5p2BUscsSfFPU/stfMzkGEr9ykDwBSHoD4KpuM6zyUR
	hpypTO6Ptxh1/UjNdaKtU39mOSO4lM0wycC3FQ2r4WG0S25ZjMURThN6gPMtma63Hy78ntdcN0S
	DxefBQL122AvFpGrz5mTTNWGg4ihZQRqkqWl
X-Google-Smtp-Source: AGHT+IEkhlCStgRTYUkM2Z53ttoD7NcBvl2lyibDklVtolD0F7cE8yDUolsmvkDCrs4FxF9c6Igm9g==
X-Received: by 2002:a05:6512:3f20:b0:53d:dd02:7cc5 with SMTP id 2adb3069b0e04-54229524640mr15589362e87.7.1735906921736;
        Fri, 03 Jan 2025 04:22:01 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54223830207sm4216554e87.251.2025.01.03.04.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 04:22:00 -0800 (PST)
Date: Fri, 3 Jan 2025 14:21:58 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: robdclark@gmail.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/msm: Use helper function devm_clk_get_prepared()
Message-ID: <4okyywneygbskczj3ooay3ir7p2sfwfjvyde7jaixbrht7xu36@yiqlcvrwhypl>
References: <20250103113059.463033-1-zhangheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103113059.463033-1-zhangheng@kylinos.cn>

On Fri, Jan 03, 2025 at 07:30:59PM +0800, Zhang Heng wrote:
> Since commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
> and enabled clocks"), devm_clk_get() and clk_prepare() can now be replaced
> by devm_clk_get_prepared() when driver prepares the clocks for the whole
> lifetime of the device. Moreover, it is no longer necessary to unprepare
> the clocks explicitly.
> 
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
> ---
>  drivers/iommu/msm_iommu.c | 51 +++++++++------------------------------
>  1 file changed, 11 insertions(+), 40 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
