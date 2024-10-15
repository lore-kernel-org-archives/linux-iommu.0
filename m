Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE22204CB
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995507; cv=none; b=dgY3QfcgjOz7diXbNBf5SafWLkDsPdarhhwRW/tF5MpUd1AvatvcH6gh0TlMEC5OKjbZCs4F3C4xSf2+encroXruIqr0elix8qQ+WWjfoJ2Zu4YJ9kIxMgRVpxki8XOv7pwWzVQz/JzIf6BW5K88EBF/JwhLNrFaN+BdIkEn3YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995507; c=relaxed/simple;
	bh=zsAS7IW8UWtyFg5LlM/GFw26W2L0dTrPCX8ZvpE3s44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stXFdIQfownXcX1hq7XkvaF/blXTJ8tUhmxGs/Chk73Vu6s1D4vPUAdVMw+7QwQm03pfMUvX58BBzo5bA/8RG+M/BqW3stwNs2TICL9WIX1MUCQcKStE1Q4HB+0vX1rBztoqwii1u9rDuZfUhJ1e57sXma+k/woDQOvTIqGCaNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=mJ0r5zSC; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mJ0r5zSC"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea8ecacf16so1057582a12.1
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 05:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728995504; x=1729600304; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=be1N4fD79AaSp3gd/OUf6fSP5g1uhzqPJx69MrmbUTo=;
        b=mJ0r5zSCKY9eN5qlPn8m6aEf+0riOb1ASSLxudykHZjzkFHz96l/UA/pAwMn9g7+3N
         Oitf4hgpQ16VnCqkxhdru0Ql/hz0yz3sWJsVv6tQiL8QPHGsxJCpXKZhuvNqk3OkEcWT
         V1Gr+tuvCs88JAH01x5RHnUWbYqOaD9ldV1t0VaACXZyN2Id3TmvM3O4H84LYXnKarwF
         eBZ027qQLrnv9mRRchRFC2zB5svpHzzv7SN6xFSaA3w7292hBjYKVrI/pkT52zqD1hrn
         bWvW1XHasovoEmatAgWDqOVyJY2HKt0nLvhJiDUYTV6cO1Irrlf3GFNwjFEfi+4jRvEf
         qITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728995504; x=1729600304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=be1N4fD79AaSp3gd/OUf6fSP5g1uhzqPJx69MrmbUTo=;
        b=T6YghMhKL+/4emtFVwZyeGa3WblZjN88LsKTH8hrYtV7y7g/Pi506AJjjkxfLG4wsG
         EIpx0z5sqdIR/ntTNSS0pDyMRfnnzRoMm9cTVqPk+2oemT1abQ6TSu8r3q7R3RWq7Jfh
         SZpP8Hb9yjT7Kp+m1BSem9nuDpBbqv4myLMOVYTbt+Rtc0Glcsy8iY/ZGEcBStnSMJao
         3bQCxX/pR4gUwAAEuThl6jEyJAVSR6fo4CNVG8hYfoh2Xlwp6VlD7JafLUje8JFsf7bd
         aCO9MeqFwtXHdnRl8smdjv9PBG8br7PD2HODtfDBjZOoHpAob8vBzbFUev0a5jasYv2B
         ZNZg==
X-Forwarded-Encrypted: i=1; AJvYcCWH9mvEVc/4capwuVZtKWr67SLonY3o5+4Z1u1YdMXQt6TvAAST6nUhhg2OhdZHjQGJApknVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPy9Kwe9PuAxXJ5gIDQg/UZRFe37wexQcYhh/z2eoAObxBWpAc
	oUKnEyh3lnC7cHs5JsR3SWNDlw36rDhMNBclkTrf34K4MWGVdL4j4TNzdfNtzHs=
X-Google-Smtp-Source: AGHT+IFUVbglgKjAiaoYl/o8oNhfmPJnFkVaAwv51OulODZxnvD/lQaXubwxcDU8bPqAL1fe3rNAvQ==
X-Received: by 2002:a17:90b:1495:b0:2e2:e6c8:36a7 with SMTP id 98e67ed59e1d1-2e31536e312mr14659570a91.31.1728995504170;
        Tue, 15 Oct 2024 05:31:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392f60650sm1589351a91.42.2024.10.15.05.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 05:31:43 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t0giE-00CyMu-9T;
	Tue, 15 Oct 2024 09:31:42 -0300
Date: Tue, 15 Oct 2024 09:31:42 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>
Subject: Re: [PATCH v2 2/8] iommu: Introduce iommu_paging_domain_alloc_flags()
Message-ID: <20241015123142.GF1825128@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-3-vasant.hegde@amd.com>
 <2e2c18f5-382a-4144-9a78-29e3dfc973c4@linux.intel.com>
 <BN9PR11MB527639C51F172B6A3C6996EB8C452@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527639C51F172B6A3C6996EB8C452@BN9PR11MB5276.namprd11.prod.outlook.com>

On Tue, Oct 15, 2024 at 08:24:44AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Thursday, September 12, 2024 12:05 PM
> > 
> > On 9/11/24 6:19 PM, Vasant Hegde wrote:
> > >   /**
> > > - * iommu_paging_domain_alloc() - Allocate a paging domain
> > > + * iommu_paging_domain_alloc_flags() - Allocate a paging domain
> > >    * @dev: device for which the domain is allocated
> > > + * @flags: Bitmap of iommufd_hwpt_alloc_flags
> > >    *
> > >    * Allocate a paging domain which will be managed by a kernel driver.
> > Return
> > >    * allocated domain if successful, or a ERR pointer for failure.
> > >    */
> > > -struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
> > > +struct iommu_domain *iommu_paging_domain_alloc_flags(struct device
> > *dev,
> > > +						     unsigned int flags)
> > >   {
> > > +	const struct iommu_ops *ops;
> > > +	struct iommu_domain *domain;
> > > +
> > >   	if (!dev_has_iommu(dev))
> > >   		return ERR_PTR(-ENODEV);
> > >
> > > -	return __iommu_domain_alloc(dev_iommu_ops(dev), dev,
> > IOMMU_DOMAIN_UNMANAGED);
> > > +	ops = dev_iommu_ops(dev);
> > > +
> > > +	if (ops->domain_alloc_paging && !flags)
> > > +		domain = ops->domain_alloc_paging(dev);
> > > +	else if (ops->domain_alloc_user)
> > > +		domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
> > > +	else if (ops->domain_alloc && !flags)
> > > +		domain = ops-
> > >domain_alloc(IOMMU_DOMAIN_UNMANAGED);
> > > +	else
> > > +		return ERR_PTR(-EOPNOTSUPP);
> > 
> > How about
> > 
> > 	if (flags) {
> > 		if (!ops->domain_alloc_user)
> > 			return ERR_PTR(-EOPNOTSUPP);
> > 		domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
> > 	} else if (ops->domain_alloc_paging) {
> > 		domain = ops->domain_alloc_paging(dev);
> > 	} else if (ops->domain_alloc) {
> > 		domain = ops-
> > >domain_alloc(IOMMU_DOMAIN_UNMANAGED);
> > 	} else {
> > 		return ERR_PTR(-EOPNOTSUPP);
> > 	}
> > 
> 
> There is slight semantics difference.
> 
> Original code picks domain_alloc_user() if !domain_alloc_paging
> and !flags.
> 
> but your code will pick domain_alloc().
> 
> Based on discussions in this thread domain_alloc_user/ext is the
> preferred one. Then below is the right order?
> 
> 	If (ops->domain_alloc_user) {
> 		domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
> 	} else if (flags) {
> 		return ERR_PTR(-EOPNOTSUPP);
> 	} else if (ops->domain_alloc_paging) {
> 		domain = ops->domain_alloc_paging(dev);
>  	} else if (ops->domain_alloc) {
>  		domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
>  	} else {
>  		return ERR_PTR(-EOPNOTSUPP);
>  	}

This can work too, but I think we need a few more patches still to get
there?

The order above makes sense if drivers implement both
ops->domain_alloc_paging/user, then you'd want to prefer the more
narrow one.

Once drivers don't implement both then it would make sense to switch
to your version

Jason
