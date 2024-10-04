Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939A91D933C
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045973; cv=none; b=QyShGAqfuDzsnL4+KpWTlItnde202RAfxVJgBLBLOdG1xQhEyW0lfRtrLgoWeenX4vbk8u2rvCHJuWbc/Jb7z8sbZ7PMnpqq0W30a6tW7e0OXawRZPFvnbRAAAYuAsuVoOXjH1tAXPR2zMABMYDpf1zg0tF/xS4BYpPqSMp3J0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045973; c=relaxed/simple;
	bh=Q59lECets5zov6wOyLnCdpZ5ByNW5KpgnuYbpapfuW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CgsDamx9h/1N/hQwan2rZ+Jvni5aPaRGJgeAEjCvfY+1Rd9YeXk8Twg6kNCmXXpDuAf5+CDLrZXxMcobek6ocgiuidJbjuJDUA9m/I42NxoiZBln+juZVevlqcnYEcLsaGaSPKYhhMfcmIlFtDZjFvAaIT0+mFCVZElmRjOb4Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SMO80SEt; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SMO80SEt"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7ac83a98e5eso180822085a.0
        for <iommu@lists.linux.dev>; Fri, 04 Oct 2024 05:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728045970; x=1728650770; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NUqJ1lqrztPnsiL6S1ATML/I9zR7m+XbmcBrj3KrVdk=;
        b=SMO80SEteBD6+5BgNUGWOdLwuGrcocOWqsqCr3hFQdSS5FUlG5txsiMS2/uIccRP8l
         N8dzVnXrYQ4rOuxcXBHx7A4aTp3Uazc8TkkfLQCIlxFwUtJEKv337a0Jy1a7w5htqtRX
         1e6BnTa7tqJhylfMQC5tfC4/awXeCndxWWA/Dx0fHQgvSTlwM4fuBqNKxmzoc5XdcMNY
         UPlIa+26Ctgn8tf+aqnKtX3EbnYamzxZD6uxnFKFmiYk6XRqS5w6CmbhFoHtUyrmuHzw
         2srB7bs8XRqgvB7TeBafaDzG55srlGbXw+p9yQJFUQwUHhvRfFSdpGEo+bgJ7WAYImRa
         XVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728045970; x=1728650770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NUqJ1lqrztPnsiL6S1ATML/I9zR7m+XbmcBrj3KrVdk=;
        b=q/ldtcyGNgNzHSvSTYck2vPHRh5lXAZnIyrFp2LOatGjjWrCsaVjKtDSz3iwAENf/X
         9PWcf+bjigRD9vuDYUtJY3UliYFuvKVrd0WLdfj5Kj7boWZEgnRHAOS21sJydzggG0Me
         2Rur2kl+g2i3KQvnVi6ikkahedZIDU6jFybpF7igxpdDExfTYATvGhVVEWrEw899dugb
         AlvYvghTPR5HoiIdggbI7+U+AIByS3xw6XiQDA0oYXN5HEOCvOYi6AN39PAlTrJk8+H/
         313VTteZ3coRUM5h0We7zTWNmcG0X81G7XD6f3oMTY2kF5uAE470JMlUlae/5GPxMvmD
         Ccmg==
X-Gm-Message-State: AOJu0YzpqYyg5zQpyUFkXjKQe+aNROYrNCkftiob6u6XYrqPBQC0swC4
	VEckE/53ciupYXFAO2gaWzrl10lI5usENHEdJTpldmC3zeyXqH+ZP4FVOsTOymU=
X-Google-Smtp-Source: AGHT+IHkbLLFI61cloRylp8XJ3WXP3o3Vej2qxLczLehcTkAjD+KKFAEpSNowuaCxE0ofzzE6H06PA==
X-Received: by 2002:a05:620a:3724:b0:7a9:bdb5:196d with SMTP id af79cd13be357-7ae67d8942fmr1164560785a.0.1728045970065;
        Fri, 04 Oct 2024 05:46:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b3d3c0fsm133536185a.76.2024.10.04.05.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 05:46:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1swhhB-00CejO-2V;
	Fri, 04 Oct 2024 09:46:09 -0300
Date: Fri, 4 Oct 2024 09:46:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 3/8] iommu: Add new flag to explictly request PASID
 capable domain
Message-ID: <20241004124609.GF2456194@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-4-vasant.hegde@amd.com>
 <20241002192320.GP1369530@ziepe.ca>
 <62b1b771-fd79-4e1f-a494-4edfeac65d0a@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62b1b771-fd79-4e1f-a494-4edfeac65d0a@amd.com>

On Fri, Oct 04, 2024 at 01:42:24PM +0530, Vasant Hegde wrote:

> >> +struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
> >> +						     unsigned int flags)
> >> +{
> >> +	return __iommu_paging_domain_alloc_flags(dev,
> >> +					 IOMMU_DOMAIN_UNMANAGED, flags);
> > 
> > Can we get rid of the type parameter here? Like this:
> 
> This will create original problem for AMD driver. i. e. for VFIO we want to
> allocate V1 page table (at least for now).

At this point yes, but at the end of the series no, as the page table
type decision should only be based on IOMMU_HWPT_ALLOC_PASID

And this is why I wonder if it really matters for bisection purposes
as both options will be functionally fine.

Jason
