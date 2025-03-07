Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC172153D4
	for <iommu@lists.linux.dev>; Fri,  7 Mar 2025 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345639; cv=none; b=a3KWznZL9CwX6x6r125g/DCaA3Yx3RiUv63EHBKDEsirzPxiLCJjQ4K+tpXYTGRSgM03BkxefEgUWdzGBTuqOMdZSS3ClmjyuqDg4Yz/UQQxSsl6lYQ5Z4bRW0+oJA934H5ruykmusMQ8GS/4E37G/IgvexWBZ00IJkT0Mi36fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345639; c=relaxed/simple;
	bh=HPiNzXTTHqoN0cuKMmWCn9O3pvGZPQvws6UsejGOLII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXV+Gz2wDlL3JSYnGzi6AzuWuVuSYk2L2NpmuhS9Larw8YI3mxIC8giBLFwQ5PSINojRL9CiPHE34L64pEwp/s+yiHGDxKhA1GNiO38S4RJt+1fcQfEzmrv/80PD7aFDRUqPCHupF+8d4KL63V+s2bylgKSd+5dZws0eWI5Zz+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hLzSk58b; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hLzSk58b"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-abbd96bef64so264168666b.3
        for <iommu@lists.linux.dev>; Fri, 07 Mar 2025 03:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741345634; x=1741950434; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yfDn9FH6gBIL3kasCeeYhlqgNKvkAd8JgXjYP0PTb+0=;
        b=hLzSk58bUBt/sORLUmQuAjNXD1Bs80tTuCTW0ISvL219v5yXGAV/vdFPMi1GzvxUNF
         ZTEgEXOkNXIlLyKHEWC3vHbGBQHhcC8Y+qo2mp1oUQW/6qXcUuDg23ErZM7t6RUeROSc
         6ymh0kNagKrPmRz8HpRuLXhKd4faFfHBkF2/WAZnst/acEL2lCy9ot+P1Qlv60mG37Gb
         vjD92uwRiCp/VCGSEwaMg/tZiSUT14XukFxoSAqz16fx4fjwGmVicEQah+RHTJtbdE4P
         e4/RrU5mW9AlIEpU4rW79JpdlY1qDAmo6M7FpaQ819P4N/ES4IjJ0E1M4QMexE9eGlhy
         E5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741345634; x=1741950434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfDn9FH6gBIL3kasCeeYhlqgNKvkAd8JgXjYP0PTb+0=;
        b=RFTS1n0ystbn7uWOL2W/jrGQnYtXKYB1AST9KXrUdGpjT6xyHVUrdJpIsv11zvUcTM
         pNdyaFsS3r5dSEeKadaBDRDOfiB33VKXVvYYW4PuoK/YkdpcxlMgmVfDGwG8QvUtKwhN
         f4akd6rslGXgzPL2kW76YtZs0LrnJ/Lnlns4vqWm1fx5cNho2UD99VAUBMIrnT9vd32H
         TYf4hH11HJWIy12cytmOjYW68teGiLEYxod3MlX4tpZO/re2jL3iKGDLQBAHoFR9NKRl
         jJv8JFydTQdkAftcG0Jv8G/A2KYZdg4EevgP7CpEIkDwzpu+iCrYiXoSRp+RB+PBPLhN
         Kj2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkb1o3fSoHxWB1zBUTKQItQu2boa6It0ASSGJYuGngbTQsyP8MKvdppMrcNCiI41/y8HIFOA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzEQ/69sFjDsH1B98Km4QdbMtYVI0t9hxbgzr9KxdXvqrvWgaxy
	Yxegjw9JcPwmdkyhLTyBVCipqqUe4diJBLHftpBEIqORA+yXPBW5mozCoQaE+2g=
X-Gm-Gg: ASbGncvfR6oQ99fm3KyYrMQFm5+7YgzOBnWQ1IObHNA1SpwOIIdT6dEkFp0bRJ2RFyW
	oE6wx16pkm3wt4UenUGxWuVMoVQW3JwQnNCO7vj32dsGihRcWVAS0d2fOtgCNII9+BfTenXCvtT
	awG6edUkvgDGK+AjDMBts84c4gbmwlu9z8on5H1L8LuUR/zHM924sVALpf+CbahOqlhsAJU49wB
	COO4kYhCstbKdGanObtM1yOnuaCdmKjoS1poJ5Oz7fN4KbADQxylIkweEiFto0grNlXpoUS48/H
	W5sKsICm6LJVatqUJkHSeD8ZmEE+XkiolxMFyz0P+q45OFwbthke
X-Google-Smtp-Source: AGHT+IGgkdI1f8j3o1gNtZn8e4RQmGqfj9SGVx8IYAmQaeWhqRp49yPnbjkO8kd42BMMr1gZ+zPEWw==
X-Received: by 2002:a17:906:f59c:b0:abf:fb7b:8d09 with SMTP id a640c23a62f3a-ac252ed8b2cmr349617466b.51.1741345633855;
        Fri, 07 Mar 2025 03:07:13 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef30:c140:2ce9:b81:70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239481685sm264956366b.58.2025.03.07.03.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 03:07:13 -0800 (PST)
Date: Fri, 7 Mar 2025 12:07:07 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Robert Foss <rfoss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Rohit Agarwal <quic_rohiagar@quicinc.com>,
	Kyle Deng <quic_chunkaid@quicinc.com>,
	Vinod Koul <vkoul@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-usb@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 03/11] dt-bindings: power: qcom,kpss-acc-v2: Add MSM8916
 compatible
Message-ID: <Z8rTW3fQObiZ7del@linaro.org>
References: <20250306-topic-dt_bindings_fixups-v1-0-0c84aceb0ef9@oss.qualcomm.com>
 <20250306-topic-dt_bindings_fixups-v1-3-0c84aceb0ef9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250306-topic-dt_bindings_fixups-v1-3-0c84aceb0ef9@oss.qualcomm.com>

On Thu, Mar 06, 2025 at 07:11:15PM +0100, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> MSM8916 seems to reuse the same hardware as MSM8974 and friends (for
> whom this binding document was created). Add a new compatible for it.
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

Hm, MSM8916 doesn't have a *K*PSS (Krait Processor SubSystem), it has an
*A*PSS (ARM Cortex – A53 SubSystem, or Application Processor SubSystem).

I think this should be either qcom,msm8916-apss-acc, or you just keep
the qcom,msm8916-acc we already use. I'm guessing ACC stands for
"Application Clock Controller", so it would be unique enough already.

There is actually a patch from Rayyan already with a R-b from Krzysztof.
Maybe you, or whoever is responsible, can pick it up?

https://lore.kernel.org/linux-arm-msm/20240710155226.130086-1-rayyan.ansari@linaro.org/

Thanks,
Stephan
