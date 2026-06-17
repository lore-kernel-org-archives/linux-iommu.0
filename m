Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD614949EB
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781710879; cv=none; b=cTj6rM9h+C0Rq6Q1z3OgKmFUhQSkxgG78LSoyR9npCZKDXzdYOifRtc4tuKtlECBm97nj6z+qTBvRoKDGhjLKvNxFPUmvzB2jcLz88RoR/8F+IRmop3PGN4pA2NnnZa6q6CDqkd62nF3KTLJm36/4tHKf9R90Vu8R28Joy/ySKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781710879; c=relaxed/simple;
	bh=9QIEPp5EWbcjDNMKHBFL5JldJkQ5+OL5Nn42Ql7e+rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kywpk9y/4x2NJ41b5w2+63RHQYr+3LDB7uTWrCqabPdjJYPewwb4povcSssQGCC6Lsj2O+RVKT52YniNKDjshJbTssm3A89JTJs19lsp6BcqhgazBT/Qn1TOR1an6sDKhhfiIRrKBRniPL5j5QDmf7P7srqI9s9NRLWLYNeFuBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IWFEjX/m; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IWFEjX/m"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51758478240so32773551cf.2
        for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781710864; x=1782315664; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ElWjBVhbO2IQzO43OlPWnTyijSop9myiCxf+4rjWyeA=;
        b=IWFEjX/m+dBcDweoZ3io4TEymCPU99r3gA0NCsdiLiogjkklZuUBo+cm4O+0/GFVl7
         n2WPSXTh55L9ttWu2fxPm3hZQ2NhW2nrLA2t6NaK6CtXHnZdEcsrC4Gkz5PeBm14d74A
         QuEx1ELyW1MUuQLTqgP/NWoWgWwgWr5EWbX8ZwHP5FHO+06rw1SNJgZ5rV6aVIpjATED
         f+j3Ic/25TTnuXvi4TZmHjNwJuEdNVr/9k94C9PejX3Df4Sj8X69kBvBAiNBYI3tJKAW
         dpcqQJVYvaqIBnW2TSwjZs7akEtnCM3n/1TTJj67DSwdxhLTaFNwlGGBB1tdDUljFByV
         950A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781710864; x=1782315664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElWjBVhbO2IQzO43OlPWnTyijSop9myiCxf+4rjWyeA=;
        b=pqRRLZI0/tDKElHIYvjXd7WdRqneOZnckudUBFlHMPXCCJ2pz8sxkzG1LUlKwdgiXS
         CVZutO74cVuvVSptwDfweyUEhJ5DjnhjmocOB7d8QyIULN24EBa8xwresEJJsIChm0wC
         gyv29Rf8pGS9OAuwXbLzqJNDnzhSgyI/ucVmc1IOGn2djtAGVhhZiltmRMNRNtQAbhtC
         t1ChUVVq+6bfn8vkPLxrXGsAUebp2fADZaYQvdAIl/qqSt5/9K6VOMkuLXQcUvfV2WkX
         gYUL00W7hSip0dM5gHFC5ggeiufiiQmNDlQN80Ben2Q95ISBDkgphQbSgyjGovF2NRgF
         CqfA==
X-Forwarded-Encrypted: i=1; AFNElJ8nqskYZlWeKfUepUT9u/UT3e5lPU1CMDoLywq7qUT36Ejy9/V5Hhoqc47s7NmMcTKwCG8FGw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwFUw2GRpEsLtNDo+ONyXszzu3w/HyqpVnlPHUwOszxk57gHRnI
	Em/c6dcZMjboqozDekP8dkf9JBjkIN8f3KnfKMEPf1rSH88heaMsYsXRgLmAM3uLnBs=
X-Gm-Gg: Acq92OE3AoAcBx1kenGWvSHfmqEuCLgQK595FdS22jraviweZ3yD9tWJOkLCrCw5xX7
	dduTxt8e7o2+1RYNCCUver8pmykq6pM3mfN/bHg41wzLxThCFNOp8EWh1PT6Yq1pX8ZpnO8F6Cr
	80QDSGCsWSvZNFesgQrqETI1jerUnzYjEmYJ+QgJ4qMyRKA4srlg1O+HodGJ6eX9lk/LDmucy4E
	SunvR3/K8kgZpOu6xYdrhv/c1Qt/qKZ12Pfw89Y83bWyV/ry3IdThN0GDS0GzP2NlyRC7XoYvQY
	XDllZ4F/jqA0SqX9+M1/R8iWbWVf/Txz/g+RJdBpvc5QBUL8GcPq8IbQtfeZK1fzcsk3d6bxOCF
	hcf8weUYUdXaQVx6k5igw+mKurFqp+Yl0Mnerda2JeBI3WSRMs8Z5ucMyudIfltEbV5mNd/3GJd
	zvnJfqB0G+1Dtzbz7pQeLvEBpEbozZkFuyY96raEiRENWuVE+nOJdFOqvQoX+gPUb3/edWa/Cf0
	f4uWA==
X-Received: by 2002:ac8:638b:0:b0:517:7620:20f9 with SMTP id d75a77b69052e-519a8e01895mr53967651cf.19.1781710863733;
        Wed, 17 Jun 2026 08:41:03 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb7a3c4asm171544001cf.14.2026.06.17.08.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:41:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wZsNx-00000000iiO-3Q8i;
	Wed, 17 Jun 2026 12:41:01 -0300
Date: Wed, 17 Jun 2026 12:41:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alexey Kardashevskiy <aik@amd.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
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
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>,
	"Cheloha, Scott" <Scott.Cheloha@amd.com>
Subject: Re: [PATCH v6 03/20] dma-direct: use DMA_ATTR_CC_SHARED in
 alloc/free paths
Message-ID: <20260617154101.GE3577091@ziepe.ca>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-4-aneesh.kumar@kernel.org>
 <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <845d0c8a-6d51-47aa-8e0b-8381e733444a@amd.com>

On Wed, Jun 17, 2026 at 10:50:39AM +1000, Alexey Kardashevskiy wrote:
> > @@ -193,16 +193,31 @@ void *dma_direct_alloc(struct device *dev, size_t size,
> >   		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> >   {
> >   	bool remap = false, set_uncached = false;
> > -	bool mark_mem_decrypt = true;
> > +	bool mark_mem_decrypt = false;
> >   	struct page *page;
> >   	void *ret;
> > +	/*
> > +	 * DMA_ATTR_CC_SHARED is not a caller-visible dma_alloc_*()
> > +	 * attribute. The direct allocator uses it internally after it has
> > +	 * decided that the backing pages must be shared/decrypted, so the
> > +	 * rest of the allocation path can consistently select DMA addresses,
> > +	 * choose compatible pools and restore encryption on free.
> 
> Why this limit?
> 
> Context: I am looking for a memory pool for a few shared pages (to
> do some guest<->host communication), SWIOTLB seems like the right
> fit but swiotlb_alloc() is not exported and
> dma_direct_alloc(DMA_ATTR_CC_SHARED) is not allowed.  Thanks,

Then setup your struct device so that the DMA API knows the
guest<->host channel requires unecrypted and it will work correctly.

I think this is a reasonable API to use for that, and I was just
advocating that hyperv should be using it too.

But it all relies on a properly setup struct device.

Jason
