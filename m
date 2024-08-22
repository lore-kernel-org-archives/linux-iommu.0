Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A571DFD1
	for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330591; cv=none; b=JtUD4I9a4bwZfrHs8iZvP8BR1ppv22pjwIab5U1aQg+rCUjmwRxC9YNUBnF80aHULk6nVjONu69etmndBCtueZMNXmtfhEn//NOkZnMbpmarcVBT6z1wwUpCBIeKWZ2AiKXo6ExzXJLZ8UYMPK16xe9HV3c2lch+xKdNh+Icmk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330591; c=relaxed/simple;
	bh=cBca2Dxd2FwPEeVAcY/X/BVhnFScfylr8N6+r0zqTEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WuQBL7HtyTQNtQvhKfWziYx0xP3kgIMEhhpDg0H6Yg2NMY84flUY4Gj0wD0G4lcnwguNH+6cQ/dYHzQogmySKCWOwwZ7KuMuNEffrpmjkj1Up9fSJwfR/VV0MGxBUYQAoGrRCLoJT+RgfppLxEAWxYreK1hH5/uyUHb7+/Ym8CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=lrWAaUy4; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="lrWAaUy4"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5dca990cf58so564376eaf.1
        for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 05:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724330588; x=1724935388; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=myRjqnULCXjWETJu8AwCIumeGEzoyOvDac9Y4lH5z80=;
        b=lrWAaUy4pHGnjTrHazlvIauTeunrNOtCHA3pgubF2fe4xk/BKvI6R2BX2grxiA/eR+
         6G40a7Xh5GKA1EzwtK2ldqEFFZa8cd71ILRwYLzytDVJU6v5gHUXiH6gDCcWeAu0r1pE
         t7Rn+e0EfX2QlKKHFuKbwBBx2LmNPYsN++Mctuil45gQaAolofFNIMV+IdkBdcFbzUxx
         mSU1cUDX3bRax/MADGgfxuUbJboY2ENMs9dynkwZI6kLFjTxFOp5rgMKB14r//tnx2C5
         B4G99miGyqnvbrd51CagcUzF5hUSqtaraksPwyVzT+JjC1Sus8KypWvvZAb/emSDwKD7
         3nUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724330588; x=1724935388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myRjqnULCXjWETJu8AwCIumeGEzoyOvDac9Y4lH5z80=;
        b=j5BniLmsTdPQjQzlu/JEqUlKj/72usIuE4rJAi+PXtmck1SDSnVEcEc0U04fsXDWi8
         KIgHhSxv1p03uINzvdVLUtioaCuRDZpQSnSoAm+MxCOplVTadCH3jTqlAYsl4qkYN2gw
         Ez99+IWZf4UFli2Cju3SbuZZ+W2suaDjFUcNDuqncwf1noAp6KLNDGgT/qd6PyM+mXiq
         JyD/t0qKvYYo5Ij6et3nX9fTbBCaekzgLQAQroS7ZxaDNi3l3inyTL4ca+Mn2bMEe8sZ
         rJYKohWtCxD6hx9ptJD4s+PX5ijpdiYLnDz4koy4PbPPUSarr6yRYVdKBvqc0ixdXkZ4
         FOKA==
X-Forwarded-Encrypted: i=1; AJvYcCV262QaAK/Bk0EfZrsVv17xISBRFcR8nk1cFf6YfD7q5JdWotiBPV+jP3bqPLGsFNH9pPzpdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMMEFJNQko+BpW4WzqfXPpwzuXfDUlm+aPpr2G04pCF4JYyf/j
	2wVX2Do09hxqQCt4Z/OTXSvMokIhcD+JAimnzex0Hh5IlMF9/cPmmn7pHJTE0iY=
X-Google-Smtp-Source: AGHT+IHKi2Rz67iZ5NVeF/p9WJXK9pOE5vsg+ajAjx+NqKd+3MG0bRYHpZbp8cFqR92hwHjLkcOAnA==
X-Received: by 2002:a05:6358:938c:b0:1aa:c492:1d34 with SMTP id e5c5f4694b2df-1b59fbeded6mr721956955d.23.1724330588509;
        Thu, 22 Aug 2024 05:43:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f361ee4sm65593685a.67.2024.08.22.05.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 05:43:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sh79f-00HPq3-36;
	Thu, 22 Aug 2024 09:43:07 -0300
Date: Thu, 22 Aug 2024 09:43:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
	kevin.tian@intel.com
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
Message-ID: <20240822124307.GC3468552@ziepe.ca>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
 <689eee1c-4b84-454b-8dc5-a5f35abe1631@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <689eee1c-4b84-454b-8dc5-a5f35abe1631@linux.intel.com>

On Thu, Aug 22, 2024 at 09:50:57AM +0800, Baolu Lu wrote:
> On 8/22/24 12:31 AM, Jason Gunthorpe wrote:
> > >    I think instead of having separate function it may be better to
> > >    enhance __iommu_domain_alloc() such that:
> > >      - Keep below changes from this patch
> > >        - iommu_domain_init()
> > >        - iommu_get_dma_cookie call inside iommu_setup_default_domain()
> > >      - modify __iommu_domain_alloc() to additional param (flags)
> > >      - iommu_paging_domain_alloc_flags() will call __iommu_domain_alloc()
> > My expectation was to basically remove iommu_domain_alloc() entirely
> > once Lu's work is merged.
> > 
> > Instead we'd have these direct APIs:
> >    iommu_domain_alloc_paging_flags()
> 
> Is it possible to use different domain allocation APIs for kernel DMA
> and user-space DMA? Right now, we differentiate between these two types
> of domains using IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_UNMANAGED.

I really don't want to have such a distinction.

> I'm thinking about this because the Intel iommu driver has a similar
> need to AMD. They both recommend using different page table formats for
> IOMMU_DOMAIN_DMA and IOMMU_DOMAIN_UNMANAGED, which is currently stopping
> us from implementing domain_alloc_paging in the Intel iommu driver.

Why? What exactly is the issue?

It is inhernetly wrong to behave differently based on DMA API or VFIO.
They are not different things.

If you have different behaviors and different properies, like AMD's
PASID, then they should be described and mapped to some kind of flag.

Otherwise the driver should always allocate a paging domain that gives
the highest performance.

Jason
