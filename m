Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6891514F8
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 02:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009111; cv=none; b=sQRWgYGEz83s8geH8Suzplv8EcYLWy6s2YfvaMwPOCY6Hfr9lfHSHQBrzAfE7W2lBUjf54G5goC7EsaEvjRHB7ubgLxxuUnbR6PaYA4hMpdWXbvVtuUaB4u3q745N6j5IfAA6ynOHVO9/3ZZ6TKrwcuD9McyRrIsyjLZLfbZnXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009111; c=relaxed/simple;
	bh=JbNc2o0u3C8QGaR7GHqDGQejtg7vpRmM1jVYQKHei4w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=XgXgYewqdRhte49OXEwelcEUSvptDZdjpSv2W9f9k5N1tgBaZt8XrTv0Co+xQhHn9ji3WvFx8SIZ0zNdT+RhCpOvqb2BuA+4BLHczfcXgS9kY6FAFqjXDyJoPB6xH9MRc0okLbCDJh8lKvRFL0kptyI26nrY45qGlXJgVRwQSpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNfpE+nA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNfpE+nA"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b23f90f53aso39540625ad.0
        for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 19:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775009108; x=1775613908; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJMfA7CNqV0/pOxot929IT3yuZq+Zmc7WLvwY3fmaj4=;
        b=YNfpE+nAvSfQfcOmbwgNa0gB3ElDJpnf8VqNmD8iIXU/ENXcrNq4ClrxVl9YJ7Vqv3
         WnAmuoX6R52Trju5DbPxDbePLX+buoar8ZjgaX7AsArAie/GYZJWVACIh9MkwW/i2EQz
         9DN21OMmC8UZ6T2K49lobRGGt1iqZdTHhLh/RAvpSI9ES4AUJ9GlQz58mlb4U42H39WS
         DeiIAxFNXHcGT3plWIoG0lnNhibV9qkRxL/QLQTrfmRe3CpkgLTxgLLAnlPpH5vWyoKh
         EibJjndKzNLW2yFTJPMl48qxRndn/U88yyvvNqcjTxhMLwasWrFB0KqLwSGbj9g6770Y
         NPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775009108; x=1775613908;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SJMfA7CNqV0/pOxot929IT3yuZq+Zmc7WLvwY3fmaj4=;
        b=AnQ2J/TmU8Vv4vZ2mLfZRdi3o7InkY538p0txpg3GfXZWVgT/XA4zGi9O3DGRe636p
         XO8vWGLopauLL3nEFr45ACtS3p3Sj7aXD91iNvzDd23ZCJPzwsoXRnUONNgxA7v6cmpt
         m669BAUmK5V94ZgS3gUXOTDJhfAtQbc448IDZVl25bVBZWF+tkin0ILNqDfnKS9uQYXv
         6xFNIwa+Tx/WWkkYclkUDJ5IyfAmhYyOgqxFW5yD0fPeA7H9bj3N8yjrrX5ToZUtDs9l
         IKE01Y4MCds8wxMk+01oAeqd/bXaYZywn/ZCeYOdKsCZysmfKTlBQYWeoSsO3nZzexAm
         zxQw==
X-Forwarded-Encrypted: i=1; AJvYcCVV6LT1CfQER+lJxW2+7/gJJ5NyKr1SkPNuweqn46XdWkbB61TMhs2idVLOYiuVxlxCSE5hug==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8RAVZrnzZ8jZNacv7EGcRTnASfWKuNLjClXsRnuwaDbTJhWeJ
	KVmX6q+ZBYipaPase+K7gVZiYWMEgCGL5JIVpW4fEiLwatDQAMEPXwkM+O9V2sN9
X-Gm-Gg: ATEYQzwSsbwqhddP4hAiE9ONX0fja3mhl5cjMFLH6Nzr1Gwgty7xHjwmMNvY8Wpnsw3
	sm5Hh5brl8scO++nGOQEoqckQ5sqMdCIr8MkwYfPXDkdFuQ2f6LMAbaJM1quzWfpVfJrSheOuns
	xPYKC6Kk+bWeGv+KjBFW1eWUKl3E3YMk/A3QLKHocMAiivlo1YxaDmir3SkWrFTEdQsV6cwtEiP
	MG5+q1VBddzYgNTJ7XIDI2l6NibwvqmdYMw90eS8yvMF9GO4AOyPWswq/XwnLRclCjrAxTT8Fhw
	wnYub6vto1Mc4mxm1Hosn+z0216eUcb0mL/5c+3igrzHtCHsB3CHHzPsCw0JrKdUC8Le+qEpf7Q
	RzqOcK5GFLBth4Hb+nkiLSeNORuIhR6ZWNNGOK529pBKC/3k0/AFHiRy1UPUXfSPzusT1s3+LFj
	rQaIVZWFkF5gJgrQkgPtTNXQ==
X-Received: by 2002:a17:903:287:b0:2b2:4bf9:1766 with SMTP id d9443c01a7336-2b269d28734mr13881265ad.33.1775009108361;
        Tue, 31 Mar 2026 19:05:08 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24268e7f5sm125994015ad.35.2026.03.31.19.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 19:05:07 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Batra <gbatra@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Gaurav Batra <gbatra@linux.ibm.com>, Dan
 =?utf-8?Q?Hor=C3=A1k?= <dan@danny.cz>, Timothy Pearson
 <tpearson@raptorengineering.com>, Shivaprasad G Bhat <sbhat@linux.ibm.com>
Subject: Re: [PATCH] powerpc/powernv/iommu: iommu incorrectly bypass DMA APIs
In-Reply-To: <20260331223022.47488-1-gbatra@linux.ibm.com>
Date: Wed, 01 Apr 2026 06:35:23 +0530
Message-ID: <o6k3mqwc.ritesh.list@gmail.com>
References: <20260331223022.47488-1-gbatra@linux.ibm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit


++CC few people who would be interested in this fix.

Gaurav Batra <gbatra@linux.ibm.com> writes:

> In a PowerNV environment, for devices that supports DMA mask less than
> 64 bit but larger than 32 bits, iommu is incorrectly bypassing DMA
> APIs while allocating and mapping buffers for DMA operations.
>
> Devices are failing with ENOMEN during probe with the following messages
>
> amdgpu 0000:01:00.0: [drm] Detected VRAM RAM=4096M, BAR=4096M
> amdgpu 0000:01:00.0: [drm] RAM width 128bits GDDR5
> amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
> amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff
> amdgpu 0000:01:00.0:  4096M of VRAM memory ready
> amdgpu 0000:01:00.0:  32570M of GTT memory ready.
> amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
> amdgpu 0000:01:00.0: [drm] Debug VRAM access will use slowpath MM access
> amdgpu 0000:01:00.0: [drm] GART: num cpu pages 4096, num gpu pages 65536
> amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF80000).
> amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
> amdgpu 0000:01:00.0: (-12) create WB bo failed
> amdgpu 0000:01:00.0: amdgpu_device_wb_init failed -12
> amdgpu 0000:01:00.0: amdgpu_device_ip_init failed
> amdgpu 0000:01:00.0: Fatal error during GPU init
> amdgpu 0000:01:00.0: finishing device.
> amdgpu 0000:01:00.0: probe with driver amdgpu failed with error -12
> amdgpu 0000:01:00.0:  ttm finalized
>
> Fixes: 1471c517cf7d ("powerpc/iommu: bypass DMA APIs for coherent allocations for pre-mapped memory")
> Reported-by: Dan Horák <dan@danny.cz>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5039

We could even add the lore link so that in future people can find the
discussion.
Closes: https://lore.kernel.org/linuxppc-dev/20260313142351.609bc4c3efe1184f64ca5f44@danny.cz/

> Tested-by: Dan Horak <dan@danny.cz>
> Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>

Feel free to change this to the following, I mainly only suggested the fix :)

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


> Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
> ---

Generally this info...
> I am working on testing the patch in an LPAR with AMDGPU. I will update the
> results soon.

... goes below the three dashes in here ^^^
This is the same place where people also update the patch change log.

But sure, thanks for updating. As for this patch, it looks good to me.
So, feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>


>  arch/powerpc/kernel/dma-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
> index 73e10bd4d56d..8b4de508d2eb 100644
> --- a/arch/powerpc/kernel/dma-iommu.c
> +++ b/arch/powerpc/kernel/dma-iommu.c
> @@ -67,7 +67,7 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
>  }
>  bool arch_dma_alloc_direct(struct device *dev)
>  {
> -	if (dev->dma_ops_bypass)
> +	if (dev->dma_ops_bypass && dev->bus_dma_limit)
>  		return true;
>  
>  	return false;
> @@ -75,7 +75,7 @@ bool arch_dma_alloc_direct(struct device *dev)
>  
>  bool arch_dma_free_direct(struct device *dev, dma_addr_t dma_handle)
>  {
> -	if (!dev->dma_ops_bypass)
> +	if (!dev->dma_ops_bypass || !dev->bus_dma_limit)
>  		return false;
>  
>  	return is_direct_handle(dev, dma_handle);
> -- 
>
> I am working on testing the patch in an LPAR with AMDGPU. I will update the
> results soon.

This should go up, as mentioned above.

-ritesh
