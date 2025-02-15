Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5FB1714CF
	for <iommu@lists.linux.dev>; Sat, 15 Feb 2025 06:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739602657; cv=none; b=P6x7Ij+JFTpF3m56S3uk3zNZIzep7oCHM8g6WRUNH8Vp/aMoJhs4JtUsaOIk9a1igy3Afy0i3SE1Zt50MGujd3YdYRQZS3Sy6aY/5DuA782NGmlHj4i4X9g5A11x39kMWyi8NUwtp7r3Szeh1WXw5tvnmAhT7T3YVsVNH0nMHYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739602657; c=relaxed/simple;
	bh=rIdKxCqzCmgcBJkHw+Ie5Ae9HYLdkSFC4U+5Q5OEoXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFG5BkMGflIh4VpEw/FjUcEt6QRqDUOMxS2lchf1ihODAzwY9MZmNC+zUDZM/sIXg8GF+CwA97rJdMadvzPiw6piHqd/r2nVKhugEL3OEsAWTbpHAK9PJZAnx9juMn8q9YXwIVzZleg6jrIvmfR0WpMkV40Pz69PDpqRdmJqshg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApMWscXl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApMWscXl"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso30702775e9.1
        for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 22:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739602653; x=1740207453; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b/74yZYlKWVL03d8QxZ+9D71zx2gtM8eY6+b6yqz9TE=;
        b=ApMWscXl4ob4WGrOwo4Ww9NIsuwFWVk6j4EQcDqBPYFU9K2/bFfw/v1FHv8ylmtLGk
         VwrBFhbK9H0wMZ7jwaJGdedQMZnBIgoDvQe1vfE/KuWnSyI63WSVBcszwEcDwOr0lOgi
         +F/N+CtRYxB4ZruWJyBQuhflGGxCUhfS03SKpb9w9FJ5vebS7j/TPH3KWUIJQFg1k1N8
         kUOmIHq8406G+9XENz3P0hy1JQzNAhDoQ1qIqnygWwRU9ZH6KHmY4eN2WImGkJVxVhsa
         2Yw5TntMDf4g4LVhb5HKI0uPr7NBYLlJbpsXigI433Ui/LLeELGkM2BtPSsJuPs2oZyh
         z4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739602653; x=1740207453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/74yZYlKWVL03d8QxZ+9D71zx2gtM8eY6+b6yqz9TE=;
        b=JYdMZrkI1pYTbQdhw+T4ltCwx/VcwEgaEbqLZpdCceHePZiRZ3LN5yMHkvli08LGHe
         Lw7YWemOlYpT8CWqAk+XID6hrhjiG2IllXr5o4xDQMOHnzj2EYXWov2v5JkmmUHXnOtm
         zXzUgqWa8Kanss3e2bU89QIlPlq6mJCCbf/OgL1nV+EBo1wLifGvgVcrBrgQaG8j5ocO
         Hpmg14kciz8M5dyWzfDzoDEeRzaL5+Bgowt4zUZ7+giCeRqMI30cPdd/briT1irPoJ1c
         4+YXesNavZ6dCGRmH/E3TkSi8BahmU9qsejMNXDKtmC5Lhh0b0wNPqoiTTib0S/j9Pym
         TnLg==
X-Forwarded-Encrypted: i=1; AJvYcCU0gbM+en2PJnFMNtU9/jpsjdICWFQ4vsZ+X+njpm62q8cAbvDJal+MggtY78biCdLVyhGhhg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVOixDn0K5aHwWVxp/Wv7a2S4VTcZDHD1bcZd7h3DHVqOrm74q
	gq1dfwZoQ2jiPmfWEfdhe5lJ76NX2POvqUuauBiMYrujqXxzFRsO
X-Gm-Gg: ASbGnctQv4/b3ruF7aW/9rDL3lEJaX47N+M/+oU3GQQwM5YtgKIp4fQmSB914JNCF0N
	rO/Oon76LO8n5nVOWQZk4m6HPe02zfox6UQ5MxCUqOIbobmuuGQNbBpFN4iVyO58CFig0Psay7U
	IE6MgqrJaDClQwg0NuAIhrmjjZJSxK/HCcJe+RIcgyj1Yv/FeVWFmDLD8NvLQlEb5U2N5CzRhMQ
	jRcwrDTVLZL/QMwcDGXyq8sW99gv/E0xnJfDDalBnMrlk0T6gKD4T5U68rLKpcdM9RUA10wiB6f
	0Ur7Q/kWnm/EC3umsnI=
X-Google-Smtp-Source: AGHT+IFjxR9kB7o/X7jJm3qzTaeRczgFmTbgBjdGs7eBWawd+pTz+2SLwRWzP2UGPPBOmUSQ10hDtw==
X-Received: by 2002:a5d:59a7:0:b0:38d:c087:98d5 with SMTP id ffacd0b85a97d-38f33f125d2mr2434940f8f.8.1739602652764;
        Fri, 14 Feb 2025 22:57:32 -0800 (PST)
Received: from tp440p.steeds.sam ([41.84.244.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b412esm6401172f8f.1.2025.02.14.22.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 22:57:32 -0800 (PST)
Date: Sat, 15 Feb 2025 08:57:24 +0200
From: Sicelo <absicsz@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, laurent.pinchart@ideasonboard.com,
	mchehab@kernel.org, andersson@kernel.org,
	mathieu.poirier@linaro.org, hns@goldelico.com, b-padhi@ti.com,
	andreas@kemnade.info, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
	linux-media@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 2/4] media: omap3isp: Handle ARM dma_iommu_mapping
Message-ID: <Z7A61N13dZpu53xI@tp440p.steeds.sam>
References: <cover.1730136799.git.robin.murphy@arm.com>
 <34542c9552ce8cd12a5c292e79589acd964075d5.1730136799.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34542c9552ce8cd12a5c292e79589acd964075d5.1730136799.git.robin.murphy@arm.com>

Hi

On Mon, Oct 28, 2024 at 05:58:36PM +0000, Robin Murphy wrote:
> It's no longer practical for the OMAP IOMMU driver to trick
> arm_setup_iommu_dma_ops() into ignoring its presence, so let's use the
> same tactic as other IOMMU API users on 32-bit ARM and explicitly kick
> the arch code's dma_iommu_mapping out of the way to avoid problems.
> 
> Fixes: 4720287c7bf7 ("iommu: Remove struct iommu_ops *iommu from arch_setup_dma_ops()")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/media/platform/ti/omap3isp/isp.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/media/platform/ti/omap3isp/isp.c b/drivers/media/platform/ti/omap3isp/isp.c
> index 91101ba88ef0..b2210841a320 100644
> --- a/drivers/media/platform/ti/omap3isp/isp.c
> +++ b/drivers/media/platform/ti/omap3isp/isp.c
> @@ -1961,6 +1961,13 @@ static int isp_attach_iommu(struct isp_device *isp)
>  	struct dma_iommu_mapping *mapping;
>  	int ret;
>  
> +	/* We always want to replace any default mapping from the arch code */
> +	mapping = to_dma_iommu_mapping(isp->dev);
> +	if (mapping) {
> +		arm_iommu_detach_device(isp->dev);
> +		arm_iommu_release_mapping(mapping);
> +	}
> +
>  	/*
>  	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
>  	 * VAs. This will allocate a corresponding IOMMU domain.
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

I have finally found time to test this patch on the Nokia N900 and can
confirm it is working fine.

I was wondering - is there a reason that it is not merged yet? I tested
on 6.14-rc2, which did not have it, and notice it is also not in
linux-next.

If it helps:

Tested-by: Sicelo A. Mhlongo <absicsz@gmail.com>

