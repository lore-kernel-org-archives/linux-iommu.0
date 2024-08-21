Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0EC5D8F0
	for <iommu@lists.linux.dev>; Wed, 21 Aug 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724257912; cv=none; b=kVcJztTFl14ZrxCXwAQD3JYDyoSTPHtgtqUaNK/vEBgA7j2Va3nXIPzjjC/HZ0CR5vxhO8HN9cFkk2oHaGw/P7RspgZBZiXf2LSkrU2lcRss7z8e2tmNuv/HvjR4YWXRZJAFUKyomJyXG9GbHUoYdTbdsjIL7yTvc0xTTWSf3Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724257912; c=relaxed/simple;
	bh=uPn053k9QHgqUIpZYvyfAabNhLKx7qp0ftxfC2sB0/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIVFAG659DB4jHxxGoEm6W9YuUj9gno9WO6W0dXcqkdQSPGxP0pHtuXh8MuoyLIo5xZxWnx3hrK1uT1aGhbjrFpG2H6WvwN/d+M+evD6tEpW30zDgH+INnW8Lm2kT+51Rpdk7ufifll/fI3nEAnqYYjaZ1Knjg9hWBn8wtpLpcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eCPMTnAW; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eCPMTnAW"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a1d3e93cceso88501585a.1
        for <iommu@lists.linux.dev>; Wed, 21 Aug 2024 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724257909; x=1724862709; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qevQVGn3YlPTbWydozKYau8l25ti8W3mZ+K/E3fjXs4=;
        b=eCPMTnAWpsC9idnUljequp4m3AXGGKFASf0SafMVNO4No61Oz85i1eQssa5ggQGd7p
         4eq1tqd/SRZ7pRGTDfD6euir/8JghSaIIxBBsHRj+DmAx6/5zp4m2kmvN+MwhXjK1M4C
         cCsP6Ojq8lftuqAoVcViB/Q9DXoy08dTkKU+boZng+ZVo+Co0Ve5SHh0EUbnBPzYA4gy
         rV+LZtZlkUrbH5tEbRVsXgmtc6wagBAvQP+GuwM7PWVcYPcI1h7Ep1xfFIyhrOPjInTP
         oQgtSda+zJ0jcDAuu4N/WiRIMDkB4zvaN0Mh4GXENkzr8qAPf+qQ55M+HpwrNJUGlUny
         t4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724257909; x=1724862709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qevQVGn3YlPTbWydozKYau8l25ti8W3mZ+K/E3fjXs4=;
        b=iFoiVp1lIRau5lmK6gIe6XBvU1vGdFyXMf+930TUPUnwnn4zhS31ya1V/giy0IQa/J
         W4/uTZ+91D8I6ZlkygiaUpWTyvxlD2+uPqF7rosgarYEtHwHStBItOrG7EZqPiPBmjB2
         fTIzp2W7WgqDnTEC5Sf66QR1cOAeS9C5xvH/fBOIr37JJHuvWjvyt4ngBYXC/j2Nq3s7
         fauV4x+hQn5MG1GsHb7YUR9SMTZLW9fXJ6wGiDYk46JhTywC8Lz/lzg6Qy2fAv2DXls5
         ldQa0GLUKmfW1oddAPnJTSy8HgrxUGY+CvVFOKjMuctACNunkxEXXD3TYtA3OtajWLiX
         QEIg==
X-Gm-Message-State: AOJu0Yyj/Eo6lfYUPw4Pj61mYTLTq73eWNJy830/8zFENCPuvmfOSwny
	TcCEhlPhSAMkSrQ/eBvlyDGOgZGfTURmq0x+YwDPHgSJKDYpx8WKFWGeO1i+4Hs=
X-Google-Smtp-Source: AGHT+IF+TTN32kffFNMtImHrxLkJdAP3s6nTHqyQzDkJNez0Zpmf1sBbmHih9OiBi+qfulMVmr03Eg==
X-Received: by 2002:a05:620a:1aaa:b0:795:e9cd:f5b8 with SMTP id af79cd13be357-7a67d497dd3mr26689385a.23.1724257909306;
        Wed, 21 Aug 2024 09:31:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454de4fa40esm25197391cf.21.2024.08.21.09.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:31:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sgoFP-00BWXN-O0;
	Wed, 21 Aug 2024 13:31:47 -0300
Date: Wed, 21 Aug 2024 13:31:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
Message-ID: <20240821163147.GZ3468552@ziepe.ca>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821133554.7405-2-vasant.hegde@amd.com>

On Wed, Aug 21, 2024 at 01:35:50PM +0000, Vasant Hegde wrote:
> From: Jason Gunthorpe <jgg@ziepe.ca>
> 
> Currently drivers calls iommu_paging_domain_alloc(dev) to get an
> UNAMANAGED domain. This is not sufficient to support PASID with
> UNAMANAGED domain as some HW like AMD requires certain page table type
> to support PASIDs.
> 
> Also domain_alloc_paging() passes device as param for domain
> allocation. This is not sufficient for AMD driver to decide the right
> page table.
> 
> Hence add iommu_paging_domain_alloc_flags() API which takes flags as
> parameter. Also update default domain allocation path to use this new
> API whenever device is PASID capable. HW driver should implement
> domain_alloc_user() to allocate PASID capable domain.
> 
> Finally introduce new flag (IOMMUFD_HWPT_ALLOC_PASID) to
> domain_alloc_users() ops. If both IOMMU and device supports PASID it
> will allocate domain. Otherwise return error.
> 
> Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
> [Added __iommu_paging_domain_alloc_flags() and description - Vasant]
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
> @Jason,
>   Notice that I have added __iommu_paging_domain_alloc_flags() so that
>   it can call iommu_domain_init() with appropriate domain type.

It is okay, but also the type could be fixed in
__iommu_group_alloc_default_domain() using something like:

		ret->type |= req_type;

>   I think instead of having separate function it may be better to
>   enhance __iommu_domain_alloc() such that:
>     - Keep below changes from this patch
>       - iommu_domain_init()
>       - iommu_get_dma_cookie call inside iommu_setup_default_domain()
>     - modify __iommu_domain_alloc() to additional param (flags)
>     - iommu_paging_domain_alloc_flags() will call __iommu_domain_alloc()

My expectation was to basically remove iommu_domain_alloc() entirely
once Lu's work is merged.

Instead we'd have these direct APIs:
  iommu_domain_alloc_paging_flags()
  iommu_group_alloc_blocking_domain()
  iommu_group_alloc_identity_domain()

And then iommu_group_alloc_default_domain() would just call them in
the right order maybe like this:

	if (req_type & __IOMMU_DOMAIN_PAGING)
		return iommu_domain_alloc_paging_flags();
	if (req_type && req_type != IOMMU_DOMAIN_IDENTITY)
		return ERR_PTR(-EOPNOTSUPP);

	if (req_type || iommu_def_domain_type == IOMMU_DOMAIN_IDENTITY) {
		dom = iommu_group_alloc_identity_domain();
		if (req_type || !IS_ERR(dom))
			return dom;
		/*
		 * if iommu_def_domain_type == IDENTITY fails then fall through
		 * to PAGING
		 */
	}

	/* iommu_def_domain_type is PAGING */
	dom = iommu_domain_alloc_paging_flags();
	if (IS_ERR(dom))
		return dom;

	pr_warn("Failed to allocate default IOMMU domain of type %u for group %s - Falling back to IOMMU_DOMAIN_DMA",
		iommu_def_domain_type, group->name);
	return dom;

Which is the only place we need to make a decision based on a type
input.

Hoping Lu's final few patches make it this cycle

> +static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
> +			      const struct iommu_ops *ops)
> +{
> +	domain->type = type;
> +	domain->owner = ops;
> +	if (!domain->ops)
> +		domain->ops = ops->default_domain_ops;
> +
> +	/*
> +	 * If not already set, assume all sizes by default; the driver
> +	 * may override this later
> +	 */
> +	if (!domain->pgsize_bitmap)
> +		domain->pgsize_bitmap = ops->pgsize_bitmap;
> +}

Pedantically the pgsize_bitmap is only needed for paging domains, but
it is OK like this too.

> @@ -359,11 +359,17 @@ struct iommu_vfio_ioas {
>   *                                   enforced on device attachment
>   * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
>   *                             valid.
> + * @IOMMUFD_HWPT_ALLOC_PASID: When the domain is used on a device, with no
> + *                            PASID, the device will support later attaching
> + *                            a PASID as well. Some HW requires a specific
> + *                            domain format on the device to allow PASID to
> + *                            work.

Maybe:

 Requests a domain that can be used with PASID. The domain can be
 attached to any PASID on the device. Any domain attached to the
 non-PASID part of the device must also be flaged, otherwise attaching
 a PASID will blocked.

Yi will need to add a check that IOMMUFD_HWPT_ALLOC_PASID was
specified on the RID domain while processing attach on the PASID
domain.

>  enum iommufd_hwpt_alloc_flags {
>  	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
>  	IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
>  	IOMMU_HWPT_FAULT_ID_VALID = 1 << 2,
> +	IOMMUFD_HWPT_ALLOC_PASID = 1 << 3,

Let's keep the consistent spelling IOMMU_HWPT_ALLOC_PASID

I think the series looks OK. The naming of domain_alloc_user() is now
a little bit weird, it has now turned into
domain_alloc_paging_extended().

Thanks,
Jason
