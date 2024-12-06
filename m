Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F05D206266
	for <iommu@lists.linux.dev>; Fri,  6 Dec 2024 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504453; cv=none; b=joPWdzi95Q6654/wE14yrc6io1K8VCSN54UWx9Co7/1eBETVq+jQ+dCkpQYKn/5pnQ2gK3SfggiPODzHBsp2EIBY0aSlkNXRDapdLwIyBFPpkRfCc2y2f+1y3h8a0Lncba+hAJWIaPA8FByvxmyglHc438iiv7LGLcpexT/Yv50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504453; c=relaxed/simple;
	bh=AlM2HQKnhAqkHaHldpOlnbg/9RAFWWXbJZ22NutgHjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwj+5j9EXTL7Z7biWwX+dysA6MA+1DansOEXDqMxBhUtbZKK/wcNcYglMnVejynWsA46BiT4RPXscB0ig0ZQQAYYwPSbalegLHjwHJG7KikGK/+o6ZCS8WdxR0UB6Y6DW4xg+chXV+Ss/yrRmVG0xiVyC/Ub2VsPNYtNF7PlYdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aVNVAmRn; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVNVAmRn"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-725c49b5e45so549283b3a.2
        for <iommu@lists.linux.dev>; Fri, 06 Dec 2024 09:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733504451; x=1734109251; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VxGgnsUUhsUmBPGq3PK5RvOu24w5vOz9HNq8JtdHRk0=;
        b=aVNVAmRnl3Btn3NFv6kp6nhKF4VDCspIn5hLMj0046wPMpP5TVfiu8wIe0lVE0r92N
         y0IBClUuaUYdo2aD87mjmDyCpDLgERzHo7kIs+IjilCExcx4m2us6R0I6OsVKCEtb+GN
         CZ7tdQobexV/CAbp9z6R9ywWRP8kBuwNr5yvGYM1IXIhV44ze5Fupw54cb4YLclJgDaO
         QZbkpwwot1tDSr0T7QhlNTq3gwSuGIKm7rMmRPOwcFMLEyCvfDvTycfrv5AJlS9mhLKc
         EEIza651yIcpIkQ5NkDW8D9mqV0NOLnJCWOwYGlTNweGuE8/VYmbZMlgx+ML4GqEYiLS
         27qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733504451; x=1734109251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxGgnsUUhsUmBPGq3PK5RvOu24w5vOz9HNq8JtdHRk0=;
        b=tMnIBQzk3hUuq99Q5bAtI0jhayfUQaqmrONL060p+f8LXOcgEuIcXpeKaldlFfkFJ1
         g4ETVIoFeudpzjOh1HLsLy/dcRfuKW5+k3DHIdjzY0odn9U8MMumGp4rO4v0yM3C7un5
         oBc1+IPojy4MabBXormCr7EdSaTaMn1QzHanEVAesoKUGaS+iOLsHdYlHRQnsRXFKOgF
         gikXAnDjLL7ZHKWHtivMuAlwO3cUTQbF2QXz3kWP+kSQytrsK7MUkD4UfTYHrVOM2vBE
         cdCPklNFBv6j7/BebIbcP5vGamxwJCDRZj0Q1D83ebaQI7ahclEjv/o9S50BBM2/7kdx
         qdPA==
X-Forwarded-Encrypted: i=1; AJvYcCUhsLoEjPLjj4D08Cpx4ZvDRCC5XSTkUXOuKsjvH/bhHuHGLiddE43zzi6FghVFy/dZu2ULIA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzFpXiBRGPGTV/Xfg8Emyinb1IGSHxicZXbtKMFPvYBLLfkrTq
	LYyvfDkNSW6wwgS8QFlzH6NzFqx5y5tX1Y0Ke1gLaqtQJKR4Zbtai7pseXeivWI=
X-Gm-Gg: ASbGncu/wDkGV6jRAdzrVMuERSI78NuB3BBoh7QuuJ+qW1WqG6TyYHTTHTfJtM6ecFv
	a56JtBV9gx594XF+y5o7xZ46ohBdQeljbE9czsAvHC8SxPZmm+GFZ4jZk2RPdNeUWGKGw+mnoWm
	BgKg/bFr6jgD5wdndVUmxsFbiOokeWpVGxXxJQxX0NF0FErSVsLT++4bJ7DMBQTUSwgJDJdtFLv
	SpZOnEDUqNiac4+ElheGiT2la3G26KIKbxvVBRwYpEn6tNiJzzjXw==
X-Google-Smtp-Source: AGHT+IHio60POCQwXssDzXQZiYwth3e7luERgW9BPvBLeRV3WmOnlH5qo/y/wAO+5VJ4oh5kZtaUUw==
X-Received: by 2002:a17:902:db04:b0:215:9f5a:a236 with SMTP id d9443c01a7336-21614d1edeamr35753815ad.6.1733504450793;
        Fri, 06 Dec 2024 09:00:50 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:85b9:bc9c:71ff:f6c3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21627341853sm1522445ad.240.2024.12.06.09.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 09:00:50 -0800 (PST)
Date: Fri, 6 Dec 2024 10:00:47 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, laurent.pinchart@ideasonboard.com,
	mchehab@kernel.org, andersson@kernel.org, hns@goldelico.com,
	b-padhi@ti.com, andreas@kemnade.info, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
	linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 1/4] remoteproc/omap: Handle ARM dma_iommu_mapping
Message-ID: <Z1Mtv9cEobzvMSsS@p14s>
References: <cover.1730136799.git.robin.murphy@arm.com>
 <6186e311cb6f64a787f87fd41e49a73f409b789c.1730136799.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6186e311cb6f64a787f87fd41e49a73f409b789c.1730136799.git.robin.murphy@arm.com>

On Mon, Oct 28, 2024 at 05:58:35PM +0000, Robin Murphy wrote:
> It's no longer practical for the OMAP IOMMU driver to trick
> arm_setup_iommu_dma_ops() into ignoring its presence, so let's use the
> same tactic as other IOMMU API users on 32-bit ARM and explicitly kick
> the arch code's dma_iommu_mapping out of the way to avoid problems.
> 
> Fixes: 4720287c7bf7 ("iommu: Remove struct iommu_ops *iommu from arch_setup_dma_ops()")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/remoteproc/omap_remoteproc.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
> index 9ae2e831456d..3260dd512491 100644
> --- a/drivers/remoteproc/omap_remoteproc.c
> +++ b/drivers/remoteproc/omap_remoteproc.c
> @@ -37,6 +37,10 @@
>  
>  #include <linux/platform_data/dmtimer-omap.h>
>  
> +#ifdef CONFIG_ARM_DMA_USE_IOMMU
> +#include <asm/dma-iommu.h>
> +#endif
> +
>  #include "omap_remoteproc.h"
>  #include "remoteproc_internal.h"
>  
> @@ -1323,6 +1327,19 @@ static int omap_rproc_probe(struct platform_device *pdev)
>  	/* All existing OMAP IPU and DSP processors have an MMU */
>  	rproc->has_iommu = true;
>  
> +#ifdef CONFIG_ARM_DMA_USE_IOMMU
> +	/*
> +	 * Throw away the ARM DMA mapping that we'll never use, so it doesn't
> +	 * interfere with the core rproc->domain and we get the right DMA ops.
> +	 */
> +	if (pdev->dev.archdata.mapping) {
> +		struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(&pdev->dev);
> +
> +		arm_iommu_detach_device(&pdev->dev);
> +		arm_iommu_release_mapping(mapping);
> +	}
> +#endif
> +

Despite acknowledging this patch I never applied it, something I have corrected
now.

Thanks for Beleswar for bringing this to my attention.

Regards,
Mathieu

>  	ret = omap_rproc_of_get_internal_memories(pdev, rproc);
>  	if (ret)
>  		return ret;
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 
