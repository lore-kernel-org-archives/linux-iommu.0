Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA606192D76
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741326732; cv=none; b=P4gZUmRpzSRVhfEThWCoIbdqaOViQLseBYAww6nNNC44abbGVXTDXpr7ZzO+2ydvT/itqipcvKNj1afInod/Xc2cGeX5mtxPIzGQVN6ESqQEmVqSKAtWO8R86YqTn58OWgHsCIngcfHh4gj1fFwhqfxkEs1Z8xIa3NNrBs0ycDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741326732; c=relaxed/simple;
	bh=YJnxjBOJNGJpsAtvdYJofjwEZlD5vwrDmuoRdMrN4PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFkS6GdF3NQkVVjl2UbMKdl8mAqnCGJEXnvPp4Jm9jL0Ng/Ba/HgT/2ODt1dA9GMd507wg9yub15ZSd4z1vEs5vY7vXhOVu5fBR9MXsfUgkFt/Jh85kkcmfZMbeJHKIbtoa60AxV7w/eIUQzIWAuf6xBKscfdMGj97/T1AeBCv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lw6yAgMA; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lw6yAgMA"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54965898051so1459104e87.2
        for <iommu@lists.linux.dev>; Thu, 06 Mar 2025 21:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741326729; x=1741931529; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=97xCV+Gvyecw927R3SbsNwJBWiMKRLeo3l2nPZL/r98=;
        b=Lw6yAgMAdIiuYGSdDMqUF2w8u8fQx3/AB3WUz7PG7C5SHxOOAhjlf425tjYBMbERpT
         qAVDZ7ITKp9qZ2RqNEJoASlJtcjS3l6hHVexUh1dFfnGXNwu5BSF1naS0I+Wp6Xoh69U
         SqLmiA/DcBuI/+Xyoiba1qNikwUVdiL84puFi357dLETm7fbXSHSqbVUmJs5M+JZlzbU
         zdNG3cJeBSWlVj5737b39WI8U9kwIBzsJh1RWyujnfCuJtcedwPeKMmL443wQAdgolAV
         IIyNbNPAUk4C6w4dgtTeF2CY2V4MSdgOL4iDTpgheRwJfj/GBB2ZtEqqH/SZWPF+XVKI
         FOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741326729; x=1741931529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97xCV+Gvyecw927R3SbsNwJBWiMKRLeo3l2nPZL/r98=;
        b=grHy6RLRHEnWKoD+a0Di9dsuMTKNtkRmbKdKutOJ3hFEIP5FNIYbRMP9UU/B72iYrI
         QPi5cZXKqS05sBUwCbLxcxD15HE3/9I2/nROUjJIwLhJxu+FdkhOtBBNt9sjddt/fC+H
         hIlRQ5i1Do1Ud1K3qNSrMHdzew/DFMMdH9cJW7bl0L3Ds/X18smTUyMFrCyNkkmrLBQK
         gHwW2qbsyVAF4DaVxombnZW5ZdJr9zF9ka5a5MdzyZbpSWoxy4pNnSFu3+hBvMfKZC2m
         1TK2jrV3ZzX9th5zl07KGB3RG1yKL0O4QtgpOrVWEWaI/2M49hOD41Ukb531cx+K2AyY
         MlrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAEh0RNamRvTpofAisXq/DFPOQcitT1e+M+CyDWxihuNeLzcrH8+ovXqLivaDeqLRsUdoN/A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxt2zVD/dhbuRsieZAIEkcSstYlgIhcF+RzTeD7LJLvZBxQEWT3
	wFx2jyjBGYWKz+Eef8KyuTcb8mruLVyj5Lpe80rYMPZAqbfH9X2/M0p+DejrZzk=
X-Gm-Gg: ASbGncudE8mjornsMKyX4oi4dv1Mayie5GZoeFzw8psRUZmYFZdtrb9bskVEAOS5kE+
	/Ljlr0ko9dnYFBCL0X1uGspdYv3mGA8of4zpGfO3/YyuddGRBI0IXW1TJpXA90iuBABJDj+ZE4k
	nrZxnR/cSetMyd1xrI6Rg8deBj5FIvei5mBGI3l4+1TnDc0rs4oozulL5qPttTCWIZmXFw1Eq9a
	DcInAUTEjsiqldinV1/szr4qYHJy+bMTYqEVHI0m6g2awQ3Y06SrnPOoNP6q4BXrniMvYjWOz+C
	ArbQwEcTkwUPLJnSwdlhQ7RNlhBBdcWKTZnRncFaO0aCb0nYIfs2lnV7u3ty9usicFokD62dAgS
	WQaVvQJtIguvFcEn658k7VC17
X-Google-Smtp-Source: AGHT+IHunk8+MpzZDHTJkBgYb12y6m7jhuOmcjA3ogw1gP8DkwdgKWszNP4J5Id48vGNdylVuIQYaw==
X-Received: by 2002:a05:6512:2342:b0:549:4de9:22df with SMTP id 2adb3069b0e04-54990da2057mr687182e87.0.1741326729036;
        Thu, 06 Mar 2025 21:52:09 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae45f8dsm384613e87.34.2025.03.06.21.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 21:52:07 -0800 (PST)
Date: Fri, 7 Mar 2025 07:52:05 +0200
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
Subject: Re: [PATCH 03/11] dt-bindings: power: qcom,kpss-acc-v2: Add MSM8916
 compatible
Message-ID: <nolgnvhb4ipmt64bhy3swibrjb5cxncz7nwk56osn7bkbrsy2b@6ntbn5pk22gf>
References: <20250306-topic-dt_bindings_fixups-v1-0-0c84aceb0ef9@oss.qualcomm.com>
 <20250306-topic-dt_bindings_fixups-v1-3-0c84aceb0ef9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-topic-dt_bindings_fixups-v1-3-0c84aceb0ef9@oss.qualcomm.com>

On Thu, Mar 06, 2025 at 07:11:15PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> MSM8916 seems to reuse the same hardware as MSM8974 and friends (for
> whom this binding document was created). Add a new compatible for it.

Ok, I should have read dt-bindigns before sending a comment. But this
commit doesn't explain, why do you need an extra compat string.

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml b/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
> index 202a5d51ee88c7190805efe8f1bf493bdb69ec45..27dae49163fa0790ceb6fda8a5c674f739d4a41a 100644
> --- a/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
> +++ b/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
> @@ -18,7 +18,9 @@ description:
>  
>  properties:
>    compatible:
> -    const: qcom,kpss-acc-v2
> +    enum:
> +      - qcom,msm8916-kpss-acc
> +      - qcom,kpss-acc-v2
>  
>    reg:
>      items:
> 
> -- 
> 2.48.1
> 

-- 
With best wishes
Dmitry
