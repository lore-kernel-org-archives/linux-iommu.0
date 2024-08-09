Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AB618C93F
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211099; cv=none; b=hanocPbhL4LtAW3gzotCyw19J7AnP8EmhTGoik27jvm/URnZOeegIc4aWmhA4bpcLVlAtGb/1VdhitItdRhlgcocRdHezLxM2FeRze1WfwBYYeahIWpupK/fzN9k5OImvN2mDDkvYtXdu/j5iknh4HNCTu8ns34ZwSMzQkdu2rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211099; c=relaxed/simple;
	bh=lfxFFCjGgOna6xYDbtOYH6f2MARGQmsMZj6hUNKN6cU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyMR8recQNmYZfnsz5psT3nV5X39oWQA03XVOp2nI/rcQJNsTjixChzO9y/N1vzHwi2C4TZAuz3UG7gDKyW2Dd6KMo4eEdkCVmYCv94lqfy5ghrGhyO5sSNZu8Z5Xds5lyhMmTnbwbh1gfZ84hW++Njp19OarX47cwyqEULTKNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZB5GmqLN; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZB5GmqLN"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a3574acafeso98959985a.1
        for <iommu@lists.linux.dev>; Fri, 09 Aug 2024 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723211096; x=1723815896; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jjlkycOAnzdKLAvtpyBjt8K41iqV3nWLtNN86kHVzeo=;
        b=ZB5GmqLNy+zaZxQWYwLbohwuPjNxOF0vJMr9gvRzbdhE2FnvjDeTVS2qoR3rJxYAlM
         NYKLYgV8fVPAlZRpbiSebFCCSeWYFIYYkPrVA8bSPYktLF/kS9OMseGKVpZD1qk8U7UB
         rfXU2KQQIYwjJ1rWaq/wKlppqeb9Nm+vKdGK1DhSQBB1MtwWiCiecOpeH3bf9vJ5HfKY
         VLRZsjxIk4wjRqsV59kybqd4O5rCKjrQ//bdyoJlARt7sVRhlC9zRA3eGzznMnY87vQT
         GITUQrGJMSFLO4LPofIRGVq7Wx23Tm6aW6jCsTxchovP2rDvJhOhqEIaLI7Cn1BJXSzq
         ie/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723211096; x=1723815896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjlkycOAnzdKLAvtpyBjt8K41iqV3nWLtNN86kHVzeo=;
        b=qD1deG3wD09WpxY6YTpooev5iJSJoEF6yXJLQGkePBc0hsfS5gjoobAzwceYViH2Sa
         PkljXKq4uw8l7cY4Sd9+2cmhnyBNedtzJM6qjwL+7ANhbAcNXDLK9WHXGssE11NlZFGs
         0wx6kIrQV1rMDd5IFOZ2I5gkkjSHB1dbyMVKg7Y9ISpibIwIVmDlnB72ZD+SS5nmIliM
         t+Loy6L/z7lJQj8LKT+l6kjHrZ8DxIW4bLtxp8lQ3oSJkTjmfUspgevNkHwa9+YMZfSU
         d4IcK1ROpaQ1ge5I3aHOnDJ6CWa8nQhZ+d1O0NdW986tWFe1yCTpoO2CF16BTY7+b9Wo
         hF3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXjtpuKhXIaMiGAh6EtrxKMQ87svBrxmF/MN68Q2EyW+3AHo2wZ9ezgiWoi0coB27i/jZ/EPutNGxqb4gqbFuYNUn4B/0=
X-Gm-Message-State: AOJu0YyDaCwmMVsxeKddm/CdY5hbMZB0jJdBfDRp1wU4JqGEFuRHrRkI
	sZ0dusQxEaggmRN720qRc6pjv3ec6Zi0wy5+YT2xDWN2U9eqW/CSZYwa0iuWNlg=
X-Google-Smtp-Source: AGHT+IGPXbnSq+IV8VMI+tqJFX9O7YQDExFPgw8VrqP3MY4y5QmRx6szguaaILLYbvWGrcAoYWQ2lw==
X-Received: by 2002:a05:620a:1a8d:b0:79d:7246:ea67 with SMTP id af79cd13be357-7a4c17c45c7mr211957685a.33.1723211096191;
        Fri, 09 Aug 2024 06:44:56 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3786c1cc5sm262562885a.104.2024.08.09.06.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:44:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1scPvK-00G8gU-AU;
	Fri, 09 Aug 2024 10:44:54 -0300
Date: Fri, 9 Aug 2024 10:44:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
Message-ID: <20240809134454.GF1985367@ziepe.ca>
References: <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
 <20240808011629.GJ8473@ziepe.ca>
 <20240808130814.GA1985367@ziepe.ca>
 <11b95737-e0d5-43de-80ba-69923ee8b249@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11b95737-e0d5-43de-80ba-69923ee8b249@amd.com>

On Fri, Aug 09, 2024 at 12:13:47PM +0530, Vasant Hegde wrote:
> Jason,
> 
> 
> On 8/8/2024 6:38 PM, Jason Gunthorpe wrote:
> > On Wed, Aug 07, 2024 at 10:16:29PM -0300, Jason Gunthorpe wrote:
> >> On Wed, Aug 07, 2024 at 03:29:47PM -0300, Jason Gunthorpe wrote:
> >>>> @Baolu, Do we need to make any changes to intel driver?
> >>>
> >>> I think Intel ignores this issue, they have nice HW and their RID can
> >>> use both of their supported domain formats in all cases.
> >>
> >> On second thought it does need to accept, but ignore the new flags..
> > 
> > And probably HW that does not support PASID should reject the
> > IOMMU_HWPT_ALLOC_PASID flag at least.
> 
> 
> You mean error out if IOMMU or device doesnot support PASID?

Just the iommu, yes.

Like in AMD terms if there is no AMDv2 page table support then fail
it.

> > Maybe IOMMU_HWPT_ALLOC_DEV_PASID can be reasonably ignored if the HW
> > doesn't support PASID.
>  
> You mean make it as optional flag? Meaning if HW doesn't support PASID then
> still allocate a domain without PASID capability?

Yes, for the RID domain it seems harmless to ignore, I'm not really
sure on this though.

Otherwise we'd want to report pasid support through a INFO return so
userspace knows if it should specify this flag.

Jason
