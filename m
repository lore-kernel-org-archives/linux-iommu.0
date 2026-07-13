Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FBB23D7F4
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971158; cv=none; b=lZIw0kVfggm5UOyGvG5PCmzkuui688DqKvVOf2DKNHJqWhGJefPVYQbVVQoDVoiWHtxkfyQ1rGpL3vCBcwQIWV2yb2Sg/w5XSoDkstXpQAxe7SjGJbrAhOnp0wpG4TurYFJdwW2Furm1l0IkyD++qRo8z/VV5r9tNdc/h5a2NEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971158; c=relaxed/simple;
	bh=dY77Qv0+81lzwLVi7S75dyv+70oXXvgqRD8f0qnW9jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+jok26kOFJyuQ1x402Nj6XZbZ0yaAuX5uxnmixZd0lb/iefX9kfDKf7mnd5E835fua6G8oK4S2KBcoGTFmzNN4pRG+HJxfKO01JUDrvm9+WPMWOw4v4ckELRzOYBFNJmUXi8o1tv87f1rtxtbVgFGir0KUjNiuY0j4txrgVIiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FcNKbLTx; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FcNKbLTx"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-517dc520840so25078841cf.3
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 12:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971155; x=1784575955; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hGsZNW66zFo4mTPQ6ULtWG3KXt/fdlFbCgUmJIue0mw=;
        b=FcNKbLTxQ9bAHOAULG1W1NhqxE9IeNDkY42qvSwxBcM79MPjPv3NGSRoGmfHMr91cW
         LtioV45mPlJFgcpqmw1v5bcbNWiV4msLfypw9iUAHe2HiIQnSzm/jEn5ZEhAAyAGEbwY
         lPWLNMBWPE8Kx1PujBECNl/oY7b+BT9cbEa1dPJd6HTqcrxh4kVUpPQnxTX/ZyYsjJE1
         xSF57PLkC9tu7Xp+tHq5Pz25ugzFZRqiu7fsi7IhtPAEJsmIUFmme6Dv0pKhw5sWblJA
         nz6VbcE5n2DQPK5xw2QaSqSxFU8HvJoUslQrE+YiFEZ8ifWYGDuJCPCTjlYrVHASXUUR
         N6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971155; x=1784575955;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hGsZNW66zFo4mTPQ6ULtWG3KXt/fdlFbCgUmJIue0mw=;
        b=TtKl7mpBsb+BK1QlRmYIRgmrX68VWymLzm/SH7VPZhaZFsHq9ylN6ylt6pcRgg2rQk
         R7CYm7DH+CdA+fUQRQC855hVCsx5LO1ZegjBCo7wce+3duaQ9SJcj7sJXZLZR4MzUVp5
         zyzXYgqtnhWr/jtOHsW99vBfNAQV115qk8FA2KI8daQkOXZJ/AX7X9WsXT4LcsQxtuNY
         ziEf8b8D0v1R6nZcgvBBtehSHrUNvtOemUvaVwzJNb27C0Bn/lcSZN/Nfr6nAV4W4+0f
         oUlSUNl0rZPuS7+UUY1Jvml4WEnKJvYnBOCaHxteEXU1bm6a4kOzLp8mENMonF3ewjwi
         FwsQ==
X-Gm-Message-State: AOJu0Yy0FZLI6WWBPw90CGIEtRZUtQcE074TGsBp906gzx94Hd3zu6xM
	tD7pG1qXbruNiYkIP7aFKCOVIzL2SeRcmK4QIVbDVA0H+1p3OKeKLFcCgFyDmPCsaPA=
X-Gm-Gg: AfdE7cmmf48cILH/XDpsQhKMsvJ6+KyZ8GCVaum+6LA8plE/G3h1n+2EoCNFiia8vhd
	ABCXxVjKupck3He+O54kWEpQrEob/ApVF/9C9lN4d54qresDENZtz0tGc5GVuADmnTizptdfILg
	EHoDkQeTNjcr3DrCpabdYvJgH3RVeDGyvpGlNOtOrtT33av2cM/Jpjh9jrVNLdvGybiDzSUXP7N
	tQB/KKqvBUHMj6wkAFja+8R20bZH9xKxIpl2rI/qKphHIOkSZeuoxufUQRYOFU4gFu2t5NzhW3j
	f30oK4PIdI/9GOWY9RlTKAx1mxRicEenldkD/GxF9MsGU/AbiSb1sEp9VmgRqFToMhJjkqT/pVU
	vl5R5VBeZa89kw32FYQBifz1uRedjGiFoZb9uGZi3rBnkrOYHzsr6ornhEUAq
X-Received: by 2002:a05:622a:1b22:b0:51c:18e4:38ab with SMTP id d75a77b69052e-51cbf2ee945mr103155851cf.66.1783971155509;
        Mon, 13 Jul 2026 12:32:35 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd7c1ec84sm138505026d6.29.2026.07.13.12.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:32:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMOI-0000000E5wx-1usj;
	Mon, 13 Jul 2026 16:32:34 -0300
Date: Mon, 13 Jul 2026 16:32:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <20260713193234.GV3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-17-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:20AM +0530, Aneesh Kumar K.V (Arm) wrote:
> @@ -88,37 +88,40 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>  {
>  	dma_addr_t dma_addr;
>  
> +	/*
> +	 * For a device requiring unencrypted DMA, MMIO memory is treated
> +	 * as shared by default.
> +	 */
> +	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
> +		attrs |= DMA_ATTR_CC_SHARED;
> +
>  	if (is_swiotlb_force_bounce(dev)) {
> -		if (!(attrs & DMA_ATTR_CC_SHARED)) {
> -			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> -				return DMA_MAPPING_ERROR;
> +		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> +			return DMA_MAPPING_ERROR;
>  
> -			return swiotlb_map(dev, phys, size, dir, attrs);
> -		}
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> -		return DMA_MAPPING_ERROR;
> +		return swiotlb_map(dev, phys, size, dir, attrs);
>  	}
>  
> -	if (attrs & DMA_ATTR_MMIO) {
> -		dma_addr = phys;
> -		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
> -			goto err_overflow;
> -	} else if (attrs & DMA_ATTR_CC_SHARED) {
> +	if (attrs & DMA_ATTR_CC_SHARED)
>  		dma_addr = phys_to_dma_unencrypted(dev, phys);
> +	else
> +		dma_addr = phys_to_dma_encrypted(dev, phys);

Maybe things should be adjusted so this can be
  phys_to_dma_direct(dev, phys, (attrs & DMA_ATTR_CC_SHARED) 

?

It would also be nice if swiotlb.c could do the same

Stated another way, maybe we should get rid of
phys_to_dma_unencrypted/encrypted() entirely and just have the bool
variation since that seems to be what everyone wants.

Jason
