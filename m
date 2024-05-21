Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9505B1C69C
	for <iommu@lists.linux.dev>; Tue, 21 May 2024 04:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716266751; cv=none; b=dE1+wMJnffuea/YJTCh+Mp46M/N1CEzAHkOiCISuT0pmIFQNy73voxblvgv85PfJnTnvWuBDJQTr8I3Yn3fPv4Xt2rxuKoWTgxJq4Q/Ch0ppnYcEExACud4d427m71h0v6Fy8w7FmdqgykUT3PEyml4H2BU+hbd5AosgA8On/8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716266751; c=relaxed/simple;
	bh=p3Y9bg7d+YbBIYXEb4Y1aAsTwlznHdS3rV/1bUmAjz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ng2rgAkTrzbKt1yLMBYx1GrlmzDyyXcAfFBWLHukbyt1nUCljjB70QAxmWogivmOrNDQT04EiheYVrYgYKDz8R1rgYW/z5e+Hg8vQaIp2iHuYXI3n7OqhsdfQr73aO/dCdqJ1Wtp7YUV+6AaD1mE09v2k0+t2rDyc3BqKjL8xKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g5pYsOCh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5pYsOCh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716266748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xr/Lj/QEJVokUuTusNqYmXna8XGFmwM2A2fm3gIEflI=;
	b=g5pYsOChPT3axFZ4gTpIfwlcmH6FEDvGbQPieLS4AlVCx/NsB8BGxHr3xqLvwp5qt6K8ec
	zMYxiNspLTXobhH/1TJJDVmGzH6GFNDZ6ErC4HoBegk/VcwfqfX/SDZnhOZ2WsjqvQ8fp3
	LAehdERlu+xDZ7L2URM8eWhhvp5uMNI=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-WcvzOqPKPs6Sprs-meh8KQ-1; Tue, 21 May 2024 00:45:46 -0400
X-MC-Unique: WcvzOqPKPs6Sprs-meh8KQ-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-4df4bf734abso6124160e0c.3
        for <iommu@lists.linux.dev>; Mon, 20 May 2024 21:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716266745; x=1716871545;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xr/Lj/QEJVokUuTusNqYmXna8XGFmwM2A2fm3gIEflI=;
        b=uKTgCov/1DYskVTUH9mdjYVjk6L4pITGLZlIYgJcZzsK/nSwgdQp0igiXE8E6vB/cd
         u0PIyZpZxJbTJcIe6hfAu3LRBNVg/DQOpcM6uK4niNKXMMWrvDtecgd/RpnGJMovg1Gn
         tazUZGkXRx/wJ73oj1+W0UuLtQUqiff8LQB16319DSvy1GJgPLjIEFhxLra6WgB9McZp
         gegeyrTLv1ykAwyvXCBeMMocacddNV8EY5WedUJEoTvWjOAvW4UUHae7BcKvrwjHorYe
         vi5eH6JaN2stp0MyXQK4FZjHr8y4mIiIpAlDxVrYYOD0R/vA5djXZfna+Y8CXyEKACeW
         1qng==
X-Forwarded-Encrypted: i=1; AJvYcCXShD8PiA5QqNwLd5SaNm5OgIiV2lVsxwy6xjWiPpGJXyoJVLZCkFhYuqoeyj98nkeKP/+xkA1kWE8JI+Y3I1XnpwXJDd8=
X-Gm-Message-State: AOJu0Yw9yGppiGHHXp4M6c56dJLnZErkENiJL0vSZRLhaN+/SGxNbR2r
	HG7I5o7jK5G1tEKXN/gM62zL3r1/fhB5mu3TY0VzCu85wvMqGNY9JsmvlrV3jTcZkUk29qqrR0b
	pmZevT4ATJjKMJxm75D+kd6RLuO+IjhEc81zvXXtiPllnMVAdqONx
X-Received: by 2002:a05:6102:f0c:b0:47e:f6f4:ff55 with SMTP id ada2fe7eead31-48077e0b862mr33274799137.20.1716266745668;
        Mon, 20 May 2024 21:45:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZqTatzHAFDg1/LKoHiRtJSPbxNMP2E08/6y7nLNNsNstKTAorXNYaCEOr/mxCeVmpvaha5Q==
X-Received: by 2002:a05:6102:f0c:b0:47e:f6f4:ff55 with SMTP id ada2fe7eead31-48077e0b862mr33274791137.20.1716266745335;
        Mon, 20 May 2024 21:45:45 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e25735ceesm99142321cf.11.2024.05.20.21.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 21:45:44 -0700 (PDT)
Date: Mon, 20 May 2024 21:45:43 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, iommu@lists.linux.dev, will@kernel.org, 
	linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] iommu/dma: Fix domain init
Message-ID: <jrzrf3vz2rhcrwazsxuljuyhru4mstyzuhjx4uawcfmjlmvipd@lu6usxz22ved>
References: <721fa6baebb0924aa40db0b8fb86bcb4538434af.1716232484.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <721fa6baebb0924aa40db0b8fb86bcb4538434af.1716232484.git.robin.murphy@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 20, 2024 at 08:14:44PM GMT, Robin Murphy wrote:
> Despite carefully rewording the kerneldoc to describe the new direct
> interaction with dma_range_map, it seems I managed to confuse myself in
> removing the redundant force_aperture check and ended up making the code
> not do that at all. This led to dma_range_maps inadvertently being able
> to set iovad->start_pfn = 0, and all the nonsensical chaos which ensues
> from there. Restore the correct behaviour of constraining base_pfn to
> the domain aperture regardless of dma_range_map, and not trying to apply
> dma_range_map constraints to the basic IOVA domain since they will be
> properly handled with reserved regions later.
> 
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Fixes: e28a114243d1 ("iommu/dma: Make limit checks self-contained")

I'm seeing this upstream as ad4750b07d34 ("iommu/dma: Make limit checks self-contained") now.

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---

Tested-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

>  drivers/iommu/dma-iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 89a53c2f2cf9..1ec89ca75c59 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -685,15 +685,15 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
>  
>  	/* Check the domain allows at least some access to the device... */
>  	if (map) {
> -		dma_addr_t base = dma_range_map_min(map);
> -		if (base > domain->geometry.aperture_end ||
> +		if (dma_range_map_min(map) > domain->geometry.aperture_end ||
>  		    dma_range_map_max(map) < domain->geometry.aperture_start) {
>  			pr_warn("specified DMA range outside IOMMU capability\n");
>  			return -EFAULT;
>  		}
> -		/* ...then finally give it a kicking to make sure it fits */
> -		base_pfn = max(base, domain->geometry.aperture_start) >> order;
>  	}
> +	/* ...then finally give it a kicking to make sure it fits */
> +	base_pfn = max_t(unsigned long, base_pfn,
> +			 domain->geometry.aperture_start >> order);
>  
>  	/* start_pfn is always nonzero for an already-initialised domain */
>  	mutex_lock(&cookie->mutex);
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 

