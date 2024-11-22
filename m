Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827111DDC1F
	for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732267031; cv=none; b=ip67chvawHqTF1TPnNQxrq/JxoqmaSJWD9xyukS6jdMKAgTa8oa65c9oTAKM2u+VTX3yGkR/+TaGXS+iviuB3h36DtntyJWmIAiVTGQgQjetuurJZgDTKzdvO1PBCDHAZ3kSGps/vzLnK8BHjGd6+y2mSIIXttwYY4VAkf+wWqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732267031; c=relaxed/simple;
	bh=i0KZgfH+7J5E6yaLH88UVVa1emy1LqpM5ZO9CYxOrcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyptMWpDwpew5PK7q1rpRjTjX1Ri3WB4Urvyu+/bR1e137S+x3mEK5DERu7nMgHrGf0CfuZQbHq5P33km4IgvVqPA3p4b4yuj1RhWcBuckNM9nWBuQahbLNHP5ZFlnxY6S9VBthtzNqfVE/DWuwhAOPKpruLIHfdxyZUL4x3pwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QYRn1aJS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYRn1aJS"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ff550d37a6so22551231fa.0
        for <iommu@lists.linux.dev>; Fri, 22 Nov 2024 01:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732267028; x=1732871828; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ksABjJAjGrK4WZJYFnwNA4rXTdpvjlAmljWrW/leao=;
        b=QYRn1aJSQ6wwh4CzQghcvayEAO3tJFwle7V1pM7/4t7G4EKChRP8lH1sZ4R5VrY7uF
         FJJNcfHdd0Lbg1j8JHMunCP3a6GtxaObg9GNq7XQ8wrpG2oayBc1C4xSONvR7xwR6PB0
         dWmUVO0MxSsZkJfLew0ysNLInHUCN3N4amoEtd8nA5Km10ESrxgXMVDdprAuM9tfkrKy
         +W/UAd+qx0io7t1KYMRCiqWHaMWRXvDl1hU6H1579Vq967SP/ostqGnLvPAXKtZQJcnM
         MfFM44nj8UWY8wNrz2kHOYc6euHZT+2afzNeb2plKwgoRwiNPB/9KyU+egnGYAb0Eic+
         F9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732267028; x=1732871828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ksABjJAjGrK4WZJYFnwNA4rXTdpvjlAmljWrW/leao=;
        b=nNw/M+2OJUEbiiQ8gjrm9CazdozCtSoJulOz9KpZnaGvyugtw+XKR39dqUryhtnUto
         y7XfZl4dMuvNltVID7XdPAxDpdMdj7jOZFgcybi8N0YcCTohYQlQAaOrE087QKWRAK+T
         PVzw8fYMGGMBlhsDhCZN3DIFnFdvOZPIQQX/jVXB+GmkaNZcGhM5MjJTzPnbijPryuHB
         2Cgz2me5k+AfQiTsS+iRufGvmGsNfI8Dhu4jIDsNjGHIzJkppgjp3rq4bqnHJGIivF4+
         0Me4+hliR0MgbX78qSWkt+F6c5NtuGhzxnGyA/kBimuW0lC22DXEhCV4JTtww0nDRy0W
         2vCg==
X-Forwarded-Encrypted: i=1; AJvYcCVjUUAt7G8YtXTYXxh8vFdbesgBRz1sw2ZbzWmJGY2xx6Nq2qNpNk1WBKI0lJsykF6ZGT62wA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZH8w9lDtxWwBxZ3PF+rHKDkQp6s1u83LlTg9pK1L0e9Yej6tZ
	PuTnVtal/sab37yGbtfvRn3AG5yKA+WZHsWDRW0fs5GC3nlddTLiD2TTjqvHyAo=
X-Gm-Gg: ASbGncv7qT3L7f+gKjcVJB7rrCyPvrnXqRnRB7IACT1Psx9iz4eqFcSUFp/DkDnQvUy
	XGy3CCQf0YYmoweOKj0Zn3jkmZas6iWjMGixVKNW0rEFfRoAnUS8gulwryTU7upIBWmaFuzB32d
	o0ixNNuNgwL/hJUHWcSzw70EeAqzdbl4wZGTly8WMI3Pvgcs2gwApE9UtGF8zih8bE5Rir0GEND
	V4pGYH5akTpt83cXtW0vQp4yaMTfKCM94ONvCJd71xui+qRAiSzTQFKxdpLshKYH76qGKMF/pvi
	CLId8ejs5OfLwGchen433w9GaN/bDg==
X-Google-Smtp-Source: AGHT+IHBSuiJjpzWzU3YdTTbSzmrCvJAhqrd+J4fXw6qs1ZwVFgAFerBo5+LIflY5eRi3hfZUicu7w==
X-Received: by 2002:a2e:8903:0:b0:2ff:a7c1:8c2c with SMTP id 38308e7fff4ca-2ffa7c18d53mr8486111fa.28.1732267027671;
        Fri, 22 Nov 2024 01:17:07 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa538ecc5sm2728601fa.99.2024.11.22.01.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 01:17:06 -0800 (PST)
Date: Fri, 22 Nov 2024 11:17:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Qingqing Zhou <quic_qqzhou@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, robimarko@gmail.com, will@kernel.org, 
	robin.murphy@arm.com, joro@8bytes.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcs615: add the GPU SMMU node
Message-ID: <pzfg7qu7tezw5bg7bo6zo4t7or54437kbhl4shd3ryautjxrpb@e3hlgrz5ya5t>
References: <20241122074922.28153-1-quic_qqzhou@quicinc.com>
 <20241122074922.28153-3-quic_qqzhou@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122074922.28153-3-quic_qqzhou@quicinc.com>

On Fri, Nov 22, 2024 at 01:19:22PM +0530, Qingqing Zhou wrote:
> Add the Adreno GPU SMMU node for QCS615 platform.
> 
> Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
