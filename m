Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420BE15C122
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046124; cv=none; b=s76TNdwr6NxGUTHAVJz79eV7DQJrskpVW9ecqimvEj1fH0h/z5dljRXCJHs9xK8TwD2LmDj6ujb0BVkkevIrnRMesZB/uCsX4NT/hkDIfuIS7YmonuOMq6rmG5LL7zMhaL+alMYXptWcRBrrQ3qxLzaxEGPH1jZw1PsTX1upQUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046124; c=relaxed/simple;
	bh=VUk5ah0q6Gv8DvfFXgVOy+akUpbARvrKQmsBDhSBPWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdXJkLkzovGNSpbZvEWZkdyYPED9hBPNWko44DN5a4r4E+doNmnFz+HnrYMzS0GyD623Fr71NGGyI5oVUiJGrMCBcLtkKkDGgUS34VVKn5mxkIp4leFCEWoKIVTZ8DFumDrpILyioT2UYshW42Gh9tn4/8WusZ8wVN/grYnf9WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Cm+DjCm7; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Cm+DjCm7"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6cb2c5128d5so15308336d6.0
        for <iommu@lists.linux.dev>; Fri, 04 Oct 2024 05:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1728046122; x=1728650922; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3xdtcRXG1rFn//xX6cfssSSki+G9p6GGM0qqdnDxZao=;
        b=Cm+DjCm7ZFFMNPFCFXKPdwAPXVpA3aaf+pO5YhNb1qSHowflI2bKdxsw/yWXt5qufc
         dVrLqDJcFKVrsFnVCt7L+q4vXk6nHf7mDkQSVwOBkWyxM4fqPefKgi25mBFB0RSI3tnB
         d32iMphd0BnDf9uZTwZzIt7k8WADOvRKQ0Hn8a8rZP2pOqVfJ1U0XnS39vIqER4z5MVR
         Lsk3iQaYyG4uIK2Uhbe+HJqk7RcT45qynug8eExTxHtAk+wUvnZ2xOg/bnTbOkhWX01g
         Lq6FeV+v/aiNNT6SB/o6ROBsTsGdR2qpmp5DEDzk93FqIT0JZ5yqCRUBdrCq6ppA6dqp
         a1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728046122; x=1728650922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xdtcRXG1rFn//xX6cfssSSki+G9p6GGM0qqdnDxZao=;
        b=mIhXqBBE4KgxrPnbuL5mG4LZ1iG3gl8/bMK+MNyguzQudbqXWQECxP6BtQnN8exaeU
         T3AWvI11rqvagGwIXEo8R3AL1Cu9d11QbgXYGZYCKyeLLMtCQzLRBSDenhJwDibbQWLz
         UbLStzSNw7bpwrRUSxxjL3cqvIZH5uduYobpoGAcnkbHsB6vRsmTQqOfuqmciy0jverh
         OHWMaellxxUMRqEAVKpw60tthryyXw58wYM7LgB+IotBop1o2Ve1VWzZOJjp5i520RjK
         3v1cGSbP9MWZVwqn3/4NaU6gPJj3v60yv04aMsGJf8Mp+tBQ4liTakMuuHsOa9eIH/sa
         C63w==
X-Gm-Message-State: AOJu0Yz1hCrv8Xd1wlVCZYS9MkwwJWDLze1GhU7f7+q3vj76shuNIfFY
	FRVD0Hx67H68zF6eSL9BGSifctQrUomLtR9bnmCjcSx0AvEna/WYY76L+HZJzoc=
X-Google-Smtp-Source: AGHT+IFZoUzob7IWYK3aw5sLjdRu82gq1dtFqIL4wU78UoCZLl62ViFTIKC543YiChTc6HHx6z16FQ==
X-Received: by 2002:a05:6214:320a:b0:6cb:4225:d85d with SMTP id 6a1803df08f44-6cb9a30384emr36288366d6.1.1728046122086;
        Fri, 04 Oct 2024 05:48:42 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb9359c01esm15303706d6.2.2024.10.04.05.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 05:48:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1swhjc-00CewW-NV;
	Fri, 04 Oct 2024 09:48:40 -0300
Date: Fri, 4 Oct 2024 09:48:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 6/8] iommu/amd: Enhance domain_alloc_user() to
 allocate PASID capable domain
Message-ID: <20241004124840.GG2456194@ziepe.ca>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-7-vasant.hegde@amd.com>
 <20241002193116.GA2428925@ziepe.ca>
 <ab325171-10b4-4bc9-978b-049f09c445a6@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab325171-10b4-4bc9-978b-049f09c445a6@amd.com>

On Fri, Oct 04, 2024 at 01:48:16PM +0530, Vasant Hegde wrote:
> >> -	return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);
> >> +	/* Allocate v2 page table if IOMMU and device supports PASID. */
> >> +	if (flags & IOMMU_HWPT_ALLOC_PASID) {
> >> +		if (!amd_iommu_pasid_supported() ||
> >> +		    !pdev_pasid_supported(dev_data))
> > 
> > The test to disable v2 support uses:
> > 
> > 	if (!check_feature(FEATURE_GIOSUP) ||
> > 	    !check_feature(FEATURE_GT)) {
> > 
> > But this doesn't check FEATURE_GIOSUP, just GT? Is it OK?
> 
> Ah! You are right. To support V2 page table, yes. Will fix it.

I think you should eventually define more useful feature flags:

FEATURE_AMD_PGTBL_V1
FEATURE_AMD_PGTBL_V2
FEATURE_AMD_PASID

etc

GIOSUP is too narrow

Then all the figuring out can be done once in the init code. There is
also some CC stuff changing this as well :\

Jason
