Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB39A1DE4FC
	for <iommu@lists.linux.dev>; Tue, 28 Jan 2025 17:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738085408; cv=none; b=qU0ewdsBsqzM/zu/1DyzLfxPLd/+hXXpr/3RrqOw8MTDIsKUNwGsG5shMdL0BYkbfYqG83uFWjrQljXa3ED4fF50mDKzIfhkA3mjzr48qCbmlL0jtAG/rBTo5yg6GOePFKtJ2beIN/oB6ICvxCpDgIZBwa/6GQUZb+vdYX0YJH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738085408; c=relaxed/simple;
	bh=tysSkBR0Z8lEM3foLBv4kTY9Hl+FQOveKxPM9tZicv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmDGG5/Oa41PdM7JbTCRsLhfZaqjbIN8vgqqUZTzGkk4C1aM93vk5LtNRjGWM4+ZSqIVzHshSCQ8a2LgqR6nF03PcL/VdR+0oAo/7VQRL6rzJEBkPr4p3PY8oLEV3rvbgHixSXezwD0Vjn/KWWfoI9cq+ltFvPv2caDBVVm5Xok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Nwci7+Dw; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Nwci7+Dw"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6d888fc8300so29533636d6.3
        for <iommu@lists.linux.dev>; Tue, 28 Jan 2025 09:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738085404; x=1738690204; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WDYik77/xun0xe9niWU6y+mgX3x25FoUK2bntOot5h8=;
        b=Nwci7+DwF496Bh+3E0UaGMx9VGZwcKS5nQHWtiGjFJMrIl/wTniI63mQSrsYYmgfEB
         d0JOO/xCo0XARz4SlqLDv7UsW0YtxH1I13+Qlr09mEBgjXlTLAtMQUA2G2A/IGTOZLpI
         E29ITso2AIFhMc8usTY2BOSSFzZZ0K0TJQsVxFQJdu7g80zhaHO2SCoJIZknvqgSQ1o+
         y8+HSijWa1qHMAzjJ/K1mmoxjljRSH33AOr1yaSwf4TRqx4gRKzt22tnFVFXouH7Cfwm
         mQDTgRyLzNDu0V1ac+KbRV+6KqXb9OM2dxZw8s+m50R7Ze3WaG7/ik8dqFLaFvS3rzAP
         Eb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738085404; x=1738690204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDYik77/xun0xe9niWU6y+mgX3x25FoUK2bntOot5h8=;
        b=F+QvN4/U7/WKw1vfYhIPOt10jr4Gv8UHWoTyI0L29SYF2RbmUv35ikl++O80geJ+r6
         r8OsppbdeyTojMt+wq5SRHgA4uXjBzirB62cC0ShZLyAShSmAhMD0w1Hzgs+6nc3X3bg
         f6klMEIuwpY4jjC948zrLjpX/uu6l8RU5CrOjPhW/HdHbBQ+rIcH4YykTZXTw7QpyhcZ
         u7NNFKsQtnTKrC30+D/2hUJbaGjq8Pw2bLbU9cwVtYMuBhLOJfZ3YI7RloghPEZDcx4v
         W5qAchYkMzxHb4qdlqHisTerVVWQ3c0FIa8y27z7ecQEc+X7ngSTN4qiQQDcEkpmwTnd
         qkbA==
X-Forwarded-Encrypted: i=1; AJvYcCUqyVxpBj1NGIqlEuBdN8PmFoS84aQb2UQieaQhHwpsT2Ne3jtz1esdIwaZvTxOr3LHf7pgLA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzu1mBdOlksXVu3EmDP2pI2lvt53aMymUhpyLcRpk/938mq+dTt
	e0GtKDiUV8sa8oq8KgwjKziIJX86kXZXzqmf3iZh0AL6ZBf94Ss0D0afkReejlE=
X-Gm-Gg: ASbGnctUSE4xCbgB6mo0eUaPyeZhpqnL9I3CPKTflFTZAZUSJ2O6GaNnQGQIGQn6SM6
	vwJTaQk9Hyb7U+Mzn0cs4Pta0Ps0nMIoMJkcIV7yVFtB9LZjEq70rXiOt3zFJZZ50ac7quWWwag
	I/Ibun8BdfTWTUW2/G/8vvCDq7xfjg3oMGICKV296CA9lQbFhgyRG3jH+7MGx98ytgxx4TIuq/w
	dFlJMBnsR/P/L8//33oQin2R5XaQ6iXiMbWwPT0tmp57EXlPVICaG3c/8B65rcYa+uvuvtv17fw
	4gehxTpMr+d1tMjyRpv24JQLspWKFn/imILV/jGwPs2/K/sRuwsv3XpW6EzEFCcF
X-Google-Smtp-Source: AGHT+IHXPALu4u+DKA7wUGmdN7CK3HwJKRJc2DZTgmFqwqNFpsajznD1cDb3S1znrg8mB76NY8eQ8Q==
X-Received: by 2002:a05:6214:224e:b0:6e1:5076:c400 with SMTP id 6a1803df08f44-6e1b21e52edmr675377206d6.39.1738085403769;
        Tue, 28 Jan 2025 09:30:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e20524c9afsm47259876d6.48.2025.01.28.09.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 09:30:03 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tcpPW-00000007fAp-37V1;
	Tue, 28 Jan 2025 13:30:02 -0400
Date: Tue, 28 Jan 2025 13:30:02 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	svens@linux.ibm.com, borntraeger@linux.ibm.com,
	farman@linux.ibm.com, clegoate@redhat.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iommu/s390: implement iommu passthrough via
 identity domain
Message-ID: <20250128173002.GE1524382@ziepe.ca>
References: <20250124201717.348736-1-mjrosato@linux.ibm.com>
 <20250124201717.348736-4-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124201717.348736-4-mjrosato@linux.ibm.com>

On Fri, Jan 24, 2025 at 03:17:17PM -0500, Matthew Rosato wrote:
> Enabled via the kernel command-line 'iommu.passthrough=1' option.
> 
> Introduce the concept of identity domains to s390-iommu, which relies on
> the bus_dma_region to offset identity mappings to the start of the DMA
> aperture advertized by CLP.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  arch/s390/pci/pci.c        |  6 ++-
>  drivers/iommu/s390-iommu.c | 95 +++++++++++++++++++++++++++++---------
>  2 files changed, 76 insertions(+), 25 deletions(-)

Seems Ok

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> -static const struct iommu_ops s390_iommu_ops = {
> -	.blocked_domain		= &blocking_domain,
> -	.release_domain		= &blocking_domain,
> -	.capable = s390_iommu_capable,
> -	.domain_alloc_paging = s390_domain_alloc_paging,
> -	.probe_device = s390_iommu_probe_device,
> -	.device_group = generic_device_group,
> -	.pgsize_bitmap = SZ_4K,
> -	.get_resv_regions = s390_iommu_get_resv_regions,
> -	.default_domain_ops = &(const struct iommu_domain_ops) {
> -		.attach_dev	= s390_iommu_attach_device,
> -		.map_pages	= s390_iommu_map_pages,
> -		.unmap_pages	= s390_iommu_unmap_pages,
> -		.flush_iotlb_all = s390_iommu_flush_iotlb_all,
> -		.iotlb_sync      = s390_iommu_iotlb_sync,
> -		.iotlb_sync_map  = s390_iommu_iotlb_sync_map,
> -		.iova_to_phys	= s390_iommu_iova_to_phys,
> -		.free		= s390_domain_free,
> +#define S390_IOMMU_COMMON_OPS() \
> +	.blocked_domain		= &blocking_domain, \
> +	.release_domain		= &blocking_domain, \
> +	.capable = s390_iommu_capable, \
> +	.domain_alloc_paging = s390_domain_alloc_paging, \
> +	.probe_device = s390_iommu_probe_device, \
> +	.device_group = generic_device_group, \
> +	.pgsize_bitmap = SZ_4K, \
> +	.get_resv_regions = s390_iommu_get_resv_regions, \
> +	.default_domain_ops = &(const struct iommu_domain_ops) { \
> +		.attach_dev	= s390_iommu_attach_device, \
> +		.map_pages	= s390_iommu_map_pages, \
> +		.unmap_pages	= s390_iommu_unmap_pages, \
> +		.flush_iotlb_all = s390_iommu_flush_iotlb_all, \
> +		.iotlb_sync      = s390_iommu_iotlb_sync, \
> +		.iotlb_sync_map  = s390_iommu_iotlb_sync_map, \
> +		.iova_to_phys	= s390_iommu_iova_to_phys, \
> +		.free		= s390_domain_free, \
>  	}
> +
> +static const struct iommu_ops s390_iommu_ops = {
> +	S390_IOMMU_COMMON_OPS()
> +};
> +
> +static const struct iommu_ops s390_iommu_rtr_ops = {
> +	.identity_domain	= &s390_identity_domain,
> +	S390_IOMMU_COMMON_OPS()
>  };

Though it is a pattern in iommu drivers to use a non-cost ops and
mutate them during probe. For instance you could NULL
s390_iommu_rtr_ops->identity_domain if the platform does not support
it.

On the other hand your version with a const ops is security nicer.

Alternatively, I have a patch series that adds a
domain_alloc_identity() function to get virtio-iommu moved to the new
APIs, that could work well here too and keep the const ops.

Jason
