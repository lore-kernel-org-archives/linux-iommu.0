Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915F43C73F7
	for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774576; cv=none; b=ZgibqMq1SivwIvF44aIjFbchXZxvWEdWcmRrLat+YqeXZfYLskSQboGxJriQdkLoL+l4DOUIqTZzIWz818Q5eS9WMJa2pmmxmZ+VY8X8S8NfwbYhIbdRFLcvcorwIjpiwRghpV8vy8K68pBw8H7Cc66uttHHMwZ4SIWEipzJTjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774576; c=relaxed/simple;
	bh=ZbEB+BxxW156mJdGKffGPwmuoeWTXhjP/vjLfLnE6u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VK+LGNkoOxm+aZjByFSoRVsInj+xe7JhsH1vWXE8fE37uDg0S3vYrigavChwya0FPo1hJACIcwSYWNLlKE4ioDTQFqXFtYcXPDn+O0uL66AnaivP6T3SBrH0T6JoIWQtYtctOIhmk23kdBSR9ESKqVRltR+0nnHGq5Xhu3XNRMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GDxmDeBO; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GDxmDeBO"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8e0a768331cso524223785a.0
        for <iommu@lists.linux.dev>; Tue, 21 Apr 2026 05:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776774566; x=1777379366; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Lkgvckk4n+YKPH5Ror7L2iowFOIs4a2/xCPuSrRYYA=;
        b=GDxmDeBOylIGyUbGzJMARkSIQ456SZfE+MmpHou2sE56/YYTWadXLAK2Pww8dt4b4E
         1ECKltvRoAezxhcswPU7zk2PgnRAhAob07V7GgZ1pO5AQaKOa0l2iBxE5O6s76pNIUgg
         pYdVR+1uINFz01aVUSR22uyxyO7LTB/aTGmaULT3M1nIolDixOKzlQ/0KA6zGFbuj3Xc
         hlg8UPdC+QhL5iCcfvd+H/GovLnyfEEmri3/A59oqi/2jwcqIAvCckL1GbTjfhRy3AF3
         oYIq8Gv1av4UEBcVuS87CRsXC9PY7xi3znCFm5bTwWD0+x4DZQlH13vyKdvJsx9MOcxH
         XE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776774566; x=1777379366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Lkgvckk4n+YKPH5Ror7L2iowFOIs4a2/xCPuSrRYYA=;
        b=pLMcLG5RLDfJU5f9lM/ngPUMUllVZ4eacxHaBQr41e0QsVUM9iXqCj3f9H18Guw0R0
         yDDGHgG/ArbgIgruymDAbmoCxBnyIi+qtxQHw98MTe8d9IzjnRdDZRrO8/k7qshPt9Jj
         F5w4Jjm2bEbVHqqv8qiJCjiJ22RtP+xvxi7rAbRLACG6/+lImb5WzdvQOBsXKFNj6q/I
         TlwOG8Op4Mdbii1wnQsQC/fNQB5SHSlG3fiut4uQXZPphomowAd5KzHqmgeVd2NRmva+
         lC/4HiW6qVJpWAYYOs4JNPJd0fkXpTKVzGTuU7QGbH/5PbCuofjXjnaItG65ZsoAlViO
         MZFQ==
X-Gm-Message-State: AOJu0YyblRDGvk2D0oQopzO3LJ1JKyFsPVbD6yv5I8h42QaSrh7jCUnG
	v+BQa3/lLIfLYxazx1wKJ76BOWN/y33QMhGW22VJumDq0cQNU0fQR0YimTaF3gfshsM=
X-Gm-Gg: AeBDiesXSbbMoID6+oR47e40i69IAoj3bNHDFm3MKpSoIZ8mLlKacMeBXUkYSSjLCma
	hBeLpzrYL74xHuHNqmA/89mBgmXNUbgU3xKRz3KW9x4mOk5n+GTpTvypmFzkWwF+fN8Iv+tBRC6
	IcyuzCr1cHcq5H9AZjWWAQAgOoKdNhwe08jfkS9NAqRF93RKVAeDmb5hc2nM6sZvgLNYoAI/PaE
	JhxQ99aJC7RMVSmqN3j8cjrqzADPCeihthsRZtnaeHqRVosU4wdZvcarnfy87fHUG+r86AeQeoK
	ZTHjpEOZScjpdGScTnFx+EMbZlwQaBYaGp5LKlwkkF19PcPbabcVV0zNWvKPN+R9m4+/Qa0kBQp
	X3WXXKG+4SmjgMpD3Gu8xEMMPjUUTKo0lBWWjfjGTu1Hmdgx/FeZl4r74BWHE0WiEqXOdL9F5j5
	ElMcGgW3i4
X-Received: by 2002:a05:620a:2993:b0:8cd:8fb8:7ddf with SMTP id af79cd13be357-8e78a625c35mr2179889985a.16.1776774565619;
        Tue, 21 Apr 2026 05:29:25 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae6133dsm99237666d6.25.2026.04.21.05.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:29:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wFAEG-00000001KYN-1Hqk;
	Tue, 21 Apr 2026 09:29:24 -0300
Date: Tue, 21 Apr 2026 09:29:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	robin.murphy@arm.com, m.szyprowski@samsung.com, will@kernel.org,
	maz@kernel.org, suzuki.poulose@arm.com, catalin.marinas@arm.com,
	jiri@resnulli.us, Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v2 6/8] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <20260421122924.GB3611611@ziepe.ca>
References: <20260420061415.3650870-1-aneesh.kumar@kernel.org>
 <20260420061415.3650870-7-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420061415.3650870-7-aneesh.kumar@kernel.org>

On Mon, Apr 20, 2026 at 11:44:13AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Teach dma_direct_map_phys() to select the DMA address encoding based on
> DMA_ATTR_CC_SHARED.
> 
> Use phys_to_dma_unencrypted() for decrypted mappings and
> phys_to_dma_encrypted() otherwise. If a device requires unencrypted DMA
> but the source physical address is still encrypted, force the mapping
> through swiotlb so the DMA address and backing memory attributes remain
> consistent.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.h | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index 7140c208c123..928671ef01e9 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -86,9 +86,14 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>  		phys_addr_t phys, size_t size, enum dma_data_direction dir,
>  		unsigned long attrs, bool flush)
>  {
> +	bool force_swiotlb_map = false;
>  	dma_addr_t dma_addr;
>  
> -	if (is_swiotlb_force_bounce(dev)) {
> +	/* if phys addr attribute is encrypted but the device is forcing an encrypted dma addr */
> +	if (!(attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
> +		force_swiotlb_map = true;

continuing my prior email.. This is really in the wrong spot, it
should be in dma_capable()

> +	if (is_swiotlb_force_bounce(dev) || force_swiotlb_map) {
>  		if (!(attrs & DMA_ATTR_CC_SHARED)) {
>  			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>  				return DMA_MAPPING_ERROR;
> @@ -105,18 +110,16 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>  			goto err_overflow;
>  	} else if (attrs & DMA_ATTR_CC_SHARED) {
>  		dma_addr = phys_to_dma_unencrypted(dev, phys);
> -		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
> -			goto err_overflow;
>  	} else {
> -		dma_addr = phys_to_dma(dev, phys);
> -		if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
> -		    dma_kmalloc_needs_bounce(dev, size, dir)) {

here.

swiotlb because the device can't reach a high address and swiotlb
because the device doesn't have T=1 are really the same thing and
should have the same code flow.

Add attrs to dma_capable() and check force_dma_unencrypted(dev)
inside.

> -			if (is_swiotlb_active(dev) &&
> -			    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
> -				return swiotlb_map(dev, phys, size, dir, attrs);
> +		dma_addr = phys_to_dma_encrypted(dev, phys);
> +	}
>  
> -			goto err_overflow;
> -		}
> +	if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
> +	    dma_kmalloc_needs_bounce(dev, size, dir)) {
> +		if (is_swiotlb_active(dev) &&
> +		    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
> +			return swiotlb_map(dev, phys, size, dir, attrs);
> +		goto err_overflow;
>  	}

Then this movement shouldn't be needed?

Jason
