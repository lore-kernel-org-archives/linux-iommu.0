Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60248158DAC
	for <iommu@lists.linux.dev>; Thu, 11 Jul 2024 23:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720741056; cv=none; b=mAqJBsepTYg1ElnAmOSzQkqY6x3t9H6rJ/zbuCAU71U643/qQRKWag97DRxVt+2pcSyo83xfbjseyNf6rcbgkKG49o1bppV0lWHcDpTTwI2ZccuEq8nW6aR5yqeZWPgVB0HEE1oLfIIqI13I6aEiTC2gKbq4Hzytu6V9PJdzTMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720741056; c=relaxed/simple;
	bh=2nqbbEAsVwbmaZoW7HNnsobSTISWs4X9BhTkCvVZ4rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJYZ8/xUIBMVqc4QNyZXjoJWczvN5SSrguYMZjErnvero4W4/xJKM+AtZLF6Y9V9i/hz68Pf2rFtza1FoArzwk5bToBkddf1n5GiAVFIb8tGcdL3y3dF+I6Xovu4ycV8so1vqwJK9Z0FeTjtNhYSgxBiieV1etYO8j7j3vyonzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=OmLtkUy+; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OmLtkUy+"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e035ecb35ffso1379889276.2
        for <iommu@lists.linux.dev>; Thu, 11 Jul 2024 16:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720741052; x=1721345852; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X+KdXhfnlGfYruNnuxczBUgWH1eqq9zVhnZGK1VHbw0=;
        b=OmLtkUy+OG0PE5kYZwJJozencKmESUXxx8CFmi5ReuU2g7GMV0W/IE3YhzT/qfyZ1q
         a/dQJ8wJGaX6/DrXwGXSWEVxGyKslIJXpMKGGvgBOv3jXkr/Q9JhBSaW/rI6JyhcJDMw
         to8WfzJYHJ5VQnQ3sbVSUKLIpEBEIho2gJhSmMRwLtT1xdUDsz3edXv/x6lH30aH3eT9
         /1aBbJo4ZBMC6/O767LPfKdJubt4ZvZHvHNyx17CRW2uVXPwAvV9Gvc8LX50Tr47ZSa6
         0sHfQ1tswt+NhTO4J41fH/5ghy4CEO90ynAcqNBQuj1ofrp+gCdwD5j1SFsOLJp8tvT4
         LQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720741052; x=1721345852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+KdXhfnlGfYruNnuxczBUgWH1eqq9zVhnZGK1VHbw0=;
        b=HuAUkhv4CtzXiLxvmVSlAGFiu2B+J4A4Lx/rDMb+MhBtURY0WuU6RNdhJtVn5I++pC
         wbtTcL1UeJLFRAyTPTR4uyZdDsTrwpuNzHBAfI4RC5v6jHyEKlEaVTqj8Yp3HdGkIUbL
         vP0u1v/fDbj4Jog6eNHbB5u6FPP+dC97wSrMHqsGbFjZJzSe/y6cVKBvKC0QSx7PNWrO
         RDrhFrVi/sEJ891B1mrGKzlEzn7ZQVmsgpwZtNqRmhQX2C1ATXKFzPWsOW/CXs+mGdKJ
         xvwNDrYzyfpMy8+cBgcAFVoKh7Ykfivk5S9uwLAlhvDqHQmpQLm9h9WiW16nszdI6t+o
         YqtA==
X-Forwarded-Encrypted: i=1; AJvYcCXpsOLlhg6OmiHLVqeXVmWpkUEssyo5Wjnv8+ggykpaX/NWlyZRHmECbXrNWdYRH83rKOdLBWTaVQ4p5XZlH/+fxMXUK6s=
X-Gm-Message-State: AOJu0YwM13Z7mBt6HB2kDdZ6oK4YYQwImUAKhaxz0I28lC6Xu/n+nJQJ
	trgogXaVCUDtG7yoclz2tdiWJM216Uj8NO+ypWiBqCeovX5Nb2R5zM/hoyqmaq9X389Als+ctuq
	TQ2o=
X-Google-Smtp-Source: AGHT+IE2w1iEvTJQgL110JqQwHO+CGC/PXq7/sUcslpRneSFJpeAVANOPh84CWfAbXtIrXm5qsA1pg==
X-Received: by 2002:a25:9902:0:b0:e03:a248:7dd3 with SMTP id 3f1490d57ef6-e041b061cb3mr11759264276.23.1720741052384;
        Thu, 11 Jul 2024 16:37:32 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9d606csm30110476d6.36.2024.07.11.16.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:37:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sS3Lu-00FSPx-5b;
	Thu, 11 Jul 2024 20:37:30 -0300
Date: Thu, 11 Jul 2024 20:37:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iommu: Convert response code from failure to invalid
Message-ID: <20240711233730.GT14050@ziepe.ca>
References: <20240710083341.44617-1-baolu.lu@linux.intel.com>
 <20240710083341.44617-4-baolu.lu@linux.intel.com>
 <BN9PR11MB5276EC68D1BBB52C9E6DDE558CA42@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276EC68D1BBB52C9E6DDE558CA42@BN9PR11MB5276.namprd11.prod.outlook.com>

On Wed, Jul 10, 2024 at 09:56:34AM +0000, Tian, Kevin wrote:
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > Sent: Wednesday, July 10, 2024 4:34 PM
> > 
> > In the iopf deliver path, iommu_report_device_fault() currently responds
> > a code of "Response Failure" to the hardware if it can't find a suitable
> > iopf-capable domain where the page faults should be handled. The Response
> > Failure is defined in PCI spec (section 10.4.2.1) as a catastrophic error,
> > and the device will disable PRI for the function.
> > 
> > Failing to dispatch a set of fault messages is not a catastrophic error
> > and the iommu core has no code to recover the PRI once it is disabled.
> > 
> > Replace it with a response code of "Invalid Response".
> > 
> > Fixes: b554e396e51c ("iommu: Make iopf_group_response() return void")
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > ---
> >  drivers/iommu/io-pgfault.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> > index cd679c13752e..b8270ee5dcdb 100644
> > --- a/drivers/iommu/io-pgfault.c
> > +++ b/drivers/iommu/io-pgfault.c
> > @@ -229,7 +229,7 @@ void iommu_report_device_fault(struct device *dev,
> > struct iopf_fault *evt)
> >  err_abort:
> >  	dev_warn_ratelimited(dev, "iopf with pasid %d aborted\n",
> >  			     fault->prm.pasid);
> > -	iopf_group_response(group, IOMMU_PAGE_RESP_FAILURE);
> > +	iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
> >  	if (group == &abort_group)
> >  		__iopf_free_group(group);
> >  	else
> 
> this doesn't match the spec words on the use of INVALID:
> 
>   One or more pages within the associated PRG do not exist or
>   requests access privilege(s) that cannot be granted. Unless the
>   page mapping associated with the Function is altered, re-issuance
>   of the associated request will never result in success.
> 
> this situation is not related to the permission of page mapping. Instead
> it's a global problem applying to all functions submitting page requests
> at this moment.
> 
> Though using FAILURE affects more functions sharing the PRI interface,
> it also proactively avoids adding more in-fly requests to worsen the
> low memory situation.
> 
> So none of the options looks perfect to me, but the existing code
> responding FAILURE is more aligned to the spec?

Yeah, I don't know what to do here either, I guess the system is going
to explode if you OOM during this stage.

If it is some problem we'd probably have to preallocate this memory in
a pool and rate limite the number of PRIs we allow open at once, using
INVALID to create some back pressure. Seems wild.

Lets keep it as FAILURE for now, or at least it can be rediscussed
another time.

Jason
