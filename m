Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177C8C8F3
	for <iommu@lists.linux.dev>; Thu, 14 Sep 2023 16:48:27 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-770ef0f51ccso79606485a.1
        for <iommu@lists.linux.dev>; Thu, 14 Sep 2023 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694710107; x=1695314907; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vleLn+/TxUJA0UnnATKhAS2qb4SN0X1rKnSo5Hiz2zU=;
        b=au+2lWxAAiisKdTJKK/DWt3EkjWjDWzaGcCf7WJ9oN5lZ+1zCgNZun82lLBT63HXPv
         R8lt00MrGo8rYhzwoyTF3UzgA9ZkqpWp7Y/eeT8btWuQRDnvHkC2r2IWYsOLlzrbvBOu
         llP7pXPHoVBeTT6gePD7mc5+00PuuYYP4eckO1Vf/5fManEHnptrzNWbaw6Pa0UGwnR+
         Pg1ztjhvIkKVT8Mkvp+YS2XsYshlNt3+gBhor8Gu7kQd0JY6rGAB+ebhW8/PMpOy27Nt
         eeFHmgeZMikxWnFKxo+8XiD8G5pDvPSyAkDLTaF3XiAZaxvkmwGG7Ztop0HnwTAqqjPi
         sU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694710107; x=1695314907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vleLn+/TxUJA0UnnATKhAS2qb4SN0X1rKnSo5Hiz2zU=;
        b=pPdanIkL7OoddBctiDPjghJymT1HGrPW+xGPjTNUv8UpInHCn2rLbfKjtf/OxMthr9
         thM9MqJyE+ywasfrhJZKwmu9LEHIsBE0id6S98iNeKknDBSlpofxnhjsozn/60zO5+U1
         QlPPSSXhSZ0RWBOYSBayprq07uw+JdXJVBy+j11lAkmFTprBhEtSuGWwVJwi+BRM7REo
         HK2AxeZe0ogdIuNO1A8JSQaAA44TMv4wo0rKqbNrYVaQ0Cl1cAZ3dR6CZrtEhzbTYECT
         hVFClW214VQx0lv0Y0K8aSUNPnhtIgqZWdtoyyaI8hBvWrYdUOyXL1djWzycSTewDuPr
         l2kw==
X-Gm-Message-State: AOJu0YxPWcI1lDG7m5M7jdo68oMytAUYzwvSPg+3xSIQnKR28Qp/fsdY
	3kAyv7GziTRWXXnkEhbncWkHDQ==
X-Google-Smtp-Source: AGHT+IGVPyeNiq8Zhyhxuf4x5ukVqx4KlCu3pFo4CdDip+Ntg98qbqRJSTtUDOkhqU8AnrThQmiWHA==
X-Received: by 2002:a05:620a:400b:b0:772:6443:daf3 with SMTP id h11-20020a05620a400b00b007726443daf3mr5041185qko.66.1694710106839;
        Thu, 14 Sep 2023 09:48:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id a13-20020a05620a102d00b0076cb3690ae7sm592094qkk.68.2023.09.14.09.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 09:48:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qgpVx-003lo6-D7;
	Thu, 14 Sep 2023 13:48:25 -0300
Date: Thu, 14 Sep 2023 13:48:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com,
	heiko@sntech.de, jernej.skrabec@gmail.com, thierry.reding@gmail.com,
	vdumpa@nvidia.com
Subject: Re: [PATCH 8/8] iommu: Improve map/unmap sanity checks
Message-ID: <ZQM5WRzyQkk7sq+t@ziepe.ca>
References: <cover.1694525662.git.robin.murphy@arm.com>
 <524db1ec0139c964d26928a6a264945aa66d010c.1694525662.git.robin.murphy@arm.com>
 <ZQHJoK0Er/nekjL6@ziepe.ca>
 <8c8451aa-d0d7-058e-cfc2-7402f9002234@arm.com>
 <ZQMBLFB20ke4hv9t@ziepe.ca>
 <e37085dc-cac4-b7f4-8c2e-e51e56a66887@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e37085dc-cac4-b7f4-8c2e-e51e56a66887@arm.com>

On Thu, Sep 14, 2023 at 03:23:46PM +0100, Robin Murphy wrote:
> > > > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > > > index c83f2e4c56f5..391bcae4d02d 100644
> > > > > --- a/drivers/iommu/iommu.c
> > > > > +++ b/drivers/iommu/iommu.c
> > > > > @@ -2427,12 +2427,12 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
> > > > >    	phys_addr_t orig_paddr = paddr;
> > > > >    	int ret = 0;
> > > > > -	if (unlikely(!ops->map_pages || domain->pgsize_bitmap == 0UL))
> > > > > -		return -ENODEV;
> > > > > -
> > > > >    	if (unlikely(!(domain->type & __IOMMU_DOMAIN_PAGING)))
> > > > >    		return -EINVAL;
> > > > 
> > > > Why isn't this a WARN_ON? The caller is clearly lost its mind if it
> > > > is calling map on a non paging domain..
> > > 
> > > Sure it's a dumb thing to do, however I don't think we can reasonably say
> > > without question that an external caller being dumb represents an unexpected
> > > and serious loss of internal consistency.
> > 
> > WARN_ON is not just for "serious loss of internal consistency" it
> > should be use in all places where invariant are violated. We can't
> > guess why the caller is using this wrong (most likely it is UAF or
> > memory corruption), but if this fires something definately has gone
> > wrong with the kernel.
> 
> Has it? It's not *functionally* incorrect to obtain a valid domain by
> calling iommu_get_domain_for_dev(), pass that domain to iommu_map(), and
> handle any failure returned. 

This is not a theoretical question - does any in-kernel code actually
do that and expect it to work? I didn't notice any..

It doesn't matter that someone *could*, our task is not to make an
overly general API. We can, and should, have tight invarients because
it allows discovery of more bug classes, and prevents "creative" use
of APIs.

> is calling iommu_iova_to_phys() on non-paging domains, and we have to
> support that, because callers are dumb, and "callers aren't dumb" is not a
> realistic invariant which we can uphold.

Someone does that? :(

> > eg if syzkaller somehow hits this we want the WARN_ON so it reports
> > it.
> 
> But then an "IOMMU bug" is reported to us, and we say "yeah, that's not
> ours, that's some code somewhere down in the middle of that callstack being
> dumb", and then what?

The report gets handed off to the part of the callstack that is making
the problem.

> iommu_map() can already fail for numerous reasons that may or may not
> represent a bug in the caller, like the IOVA or PA being out-of-range, or
> the IOVA already being mapped, or whatever. 

IMHO some of those certainly could be WARN too, depends what you think
the API should be.

eg iommufd and vfio both are designed to never double map/use out of
aperture IOVA/etc, if they do it is a significant bug and a WARN_ON
would be welcomed.

> another reason to fail (in, as far as we're concerned, an entirely safe and
> manageable way). Callers have to be prepared to handle failure, but it's up
> to them how unexpected or serious it is; we can't second-guess them.

We can always convert things into error codes, but that can also hide
bugs if no existing caller needs that functionality. IMHO it is always
better to have tighter invarients, and be noisy when they fail. This
gives us better understandablity, bug discoverability and discourages
people from introducing new code doing crazy things.

Jason
