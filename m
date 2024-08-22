Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2D21E517
	for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330678; cv=none; b=EAT8qq/VAMw8scSKrvPLirmhAFGk02SmQDikVz9/saBMxJh26Bv6qmydmdcndTOdI79qUHr91Zx29CQCTXmk0imoNYsGx8wHZIaaSDkStjEOJS+hqW5qSgD2JA2iBwbDpYv8nL6UTgmij2PyH0SWng2rvE4dI66HFW8MbDYDi+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330678; c=relaxed/simple;
	bh=Eo4Q90aSXQLIbH5bn39FIBLcH3VMhCx3Ukh3tnsN5sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1jXQlpVVikj82VkwTc/QCv/YqtQpOQDjvug/VGbBXq+O3GrLfCYbLgkg11dIy9CDimtM+g4POjuSqy/CMgkk/FJj/3/m1Mcrf6c8Q3azKJCjqZWzpzNHrRjqo3NGQLwctbLWHihJjtME09Lvx5ns9I6D6PlFkorkgPDjcG5NKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=f0fpuMxS; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="f0fpuMxS"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6bf99fee82aso3322416d6.2
        for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 05:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1724330675; x=1724935475; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4OJ/aULfLjKGrcsHGSEX0857UGG+aEOFQmc48I5QK8=;
        b=f0fpuMxSYfOlDGKC13yizHiwFGCPdvrIBF1/ifNKZ2X/siElDSWhGSSimIg0qPX684
         Wytf1Pgedpyq7muth4VT3JlEQEcba99nW92rnwg5rW5eZuJbeEAmn1ahp4B3I9T2WyTL
         4tmT7NDlGosqDXHIMmPBODPWQ9BLg+ANpQAoI8VeA4akth3WyiLeTmIE6+pM4hFQU6Ek
         gldCQ2XaYppUjmnQ1wahMv4F5pbJj7PrG2eYehRtVQjH+wKPUexo10Z1otxXu/1s1dna
         Ai8SMBL6TS27LTgTle+zEHVqLUESRttAL7dutQOY8oHyqeRfZAIZPTmxsSyh1/VIKlX3
         b2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724330675; x=1724935475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4OJ/aULfLjKGrcsHGSEX0857UGG+aEOFQmc48I5QK8=;
        b=rR957O2+ZFhSh4nzL52OBJgd/KqmGAOz2wV2oFZnBGGemqPZe2xBZbLVmfn3g9rRXf
         Pr0Z14X+rbaWq++qfDuHo3zz5jJjoDEm9QsYNyPZN52OAndOXHHzNZvhQbcfqMJMD4TX
         TtgoJvKNM3grj9H7uDszJbJXx9Basg0Nv0O4Gcxk7MEQgBud3aRv4/zonJVLl5gPK/2d
         SF0dOOXO65ixxi+VzX0qa1zW4eGu7wedL2Sd28f2+NIG9HJHkxLTU8evGHymA7JQy5y4
         fEWV6UvLkQ2SJAJ9pOscV3OuABUkZoc/rgmtGrmiYlF2LKa1cfz2ldIhGbw5vDGtOJYY
         XGoA==
X-Forwarded-Encrypted: i=1; AJvYcCUtGOZs6c323ann2EVKImx5Q56Qi+dAIX9pn2Rc1/WnR7Jkp3Eh2lrj/pKtX2P80yjj6i9bCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEGfq7xyV9jEZ1Ay8go6vmZo8u1mjrJf2nYLoyEwpN56N+ZBHu
	FHDXitOkvps11/nQIeUEJ7n3145a6xBZklT+tbib7ZhNL3mpAGwzGIebAoCSuXI=
X-Google-Smtp-Source: AGHT+IEzTDayWXcC+u5XAi2uCaOicKQOOR5kmRk9KALb+41yBuori/AsIkf3wg7ZHCDl3Sd8lbv1rA==
X-Received: by 2002:a05:6214:3110:b0:6b5:7e97:7151 with SMTP id 6a1803df08f44-6c1646cae91mr15408186d6.17.1724330675033;
        Thu, 22 Aug 2024 05:44:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d4bb74sm7107186d6.36.2024.08.22.05.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 05:44:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sh7B3-00HQFO-UU;
	Thu, 22 Aug 2024 09:44:33 -0300
Date: Thu, 22 Aug 2024 09:44:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
	kevin.tian@intel.com
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
Message-ID: <20240822124433.GD3468552@ziepe.ca>
References: <20240821133554.7405-1-vasant.hegde@amd.com>
 <20240821133554.7405-2-vasant.hegde@amd.com>
 <20240821163147.GZ3468552@ziepe.ca>
 <67436cba-3d05-4528-9519-231b8396ed51@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67436cba-3d05-4528-9519-231b8396ed51@intel.com>

On Thu, Aug 22, 2024 at 07:27:39PM +0800, Yi Liu wrote:
> On 2024/8/22 00:31, Jason Gunthorpe wrote:
> 
> > > @@ -359,11 +359,17 @@ struct iommu_vfio_ioas {
> > >    *                                   enforced on device attachment
> > >    * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
> > >    *                             valid.
> > > + * @IOMMUFD_HWPT_ALLOC_PASID: When the domain is used on a device, with no
> > > + *                            PASID, the device will support later attaching
> > > + *                            a PASID as well. Some HW requires a specific
> > > + *                            domain format on the device to allow PASID to
> > > + *                            work.
> > 
> > Maybe:
> > 
> >   Requests a domain that can be used with PASID. The domain can be
> >   attached to any PASID on the device. Any domain attached to the
> >   non-PASID part of the device must also be flaged, otherwise attaching
> >   a PASID will blocked.
> > 
> > Yi will need to add a check that IOMMUFD_HWPT_ALLOC_PASID was
> > specified on the RID domain while processing attach on the PASID
> > domain.
> 
> this means if userspace wants to user pasid on a device, it should allocate
> hwpt with this flag, no matter the hwpt is going to be attached to RID or
> pasid. is it?

Yes

> I still have a confusion. Say on AMD, is it a legitimate configuration that
> the RID is attached to a domain that uses V1 page table while pasid is
> attached to domains that use V2 page table? From architecture p.o.v., it
> seems allowed.

I think that is exactly what they have been saying their design cannot
do.

If you want to use PASID you must install a GCR3 table full of V2
tables. Doing this denies use of the V1 format for anything except a
NESTING_PARENT.

Jason
