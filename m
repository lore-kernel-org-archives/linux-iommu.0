Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BF338F8F
	for <iommu@lists.linux.dev>; Mon, 18 Sep 2023 12:53:31 +0000 (UTC)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4124e1909edso26263271cf.1
        for <iommu@lists.linux.dev>; Mon, 18 Sep 2023 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695041610; x=1695646410; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MUSqejwgoG4kFKLq84d1iERlj/5/09g18v6WjLidEnE=;
        b=DAKnOUQHoWw34/hVJWKuAyxSYA2qL9nuoenWA09vHL+txqKrQcbdPvSCnjn0yjV1kU
         MgFBQQUEtGiIgjL8bqurQW0AnPVBnQczF4FcPd1aS79z3SpVDm2XzBkFrsdhCQNuEeXk
         YuYMrnbLQJ2jOukBqk+dtxakkS210AvAbjaI9ldaG4rORcBbj8fKSDjaP501b+sDHoef
         4D8xTs3wueqPlYI0HILhqFGYd7IMs8VcsVmoMOrb0eKa94DILsuLPLErF6oPYR5WzC7t
         E4OSbnjyRATkAf3Sz2ypZ3SBhKf+HLQjbkcOXtV5FUEFXoumEH/BqMktne3uXiCWhaXR
         ScRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695041610; x=1695646410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUSqejwgoG4kFKLq84d1iERlj/5/09g18v6WjLidEnE=;
        b=HLMSGuSmHNwVygU88E1YL6ZoFJAURB6mLyKCST4v4BMLct7I0iRDswwVUrrPG0BNX8
         SgBKT9bSSxYQm9T4xzMJL7VLHHHnkL4aYABrQKOsBrMnIUuaU4mF3oEfWjxJgnSIIehH
         xslt17tDjWJm7UU9CQ7J8ZLydJFjFflYQrrZ4Hs9M1PsyOGrGy2z2m1czmIRZfn8Ptjt
         ZTm2n5e4gs+6U7fo5XSQxHM6fOv4RXC/Js8woZ342gon9dSz2KljpZxahYbEyQ8Fpv+A
         MSNnTUDBtWWoGoTL0Snb1lywGFZz21FIvMUTN/OSOgA2JBSzoJHP10s0jWUabpgC6WZN
         XzUw==
X-Gm-Message-State: AOJu0YwILUViP30NVxDmNr332HnWGyiidl48lBiqJva8GwbXfuDs92bd
	ncl/IkDZXror3j6NStTYS1zKeA==
X-Google-Smtp-Source: AGHT+IG9pr0IaK3PvnoYkO0+ozJ5IHP6XaBvobwiPpB1iqzQEklX6xBHB6lwthk8glbf2LLXEA7LKA==
X-Received: by 2002:ac8:4e89:0:b0:40f:e176:ddc5 with SMTP id 9-20020ac84e89000000b0040fe176ddc5mr11707882qtp.34.1695041610721;
        Mon, 18 Sep 2023 05:53:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id t4-20020ac87604000000b004109d386323sm2955018qtq.66.2023.09.18.05.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 05:53:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qiDkm-0004DD-PC;
	Mon, 18 Sep 2023 09:53:28 -0300
Date: Mon, 18 Sep 2023 09:53:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 04/11] iommu/amd: Initial SVA support for AMD IOMMU
Message-ID: <20230918125328.GD13795@ziepe.ca>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
 <20230911121046.1025732-5-vasant.hegde@amd.com>
 <ZQCWMFFgbbcBN+0n@ziepe.ca>
 <2d863928-6ffa-4bf7-d4d6-689d779ad701@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d863928-6ffa-4bf7-d4d6-689d779ad701@amd.com>

On Fri, Sep 15, 2023 at 02:20:32PM +0530, Vasant Hegde wrote:

> >> +		dev_data = pasid_data->dev_data;
> >> +
> >> +		if ((start ^ (end - 1)) < PAGE_SIZE) {
> >> +			amd_iommu_flush_page(dev_data->domain,
> >> +					     pasid_data->pasid, start);
> >> +		} else {
> >> +			amd_iommu_flush_tlb(dev_data->domain,
> >> +					    pasid_data->pasid);
> >> +		}
> > 
> > It is baffling why dev_data->domain would be used here, and it isn't
> > locked properly so this is a problem.
> > 
> > Looking into __flush_pasid it doesn't really make sense. The PASID
> > domain definately can't assume that the RID domain has the the same
> > set of iommus. Most likely the SVA domain has a wider set of iommus,
> > at least I didn't notice any logic preventing this in set_dev_pasid.
> 
> Right. SVA protection domain will just add dev/PASID combination without
> worrying device protection domain/iommu.
>
> In invalidation path, I walk the `pasid_list` from SVA protection domain, get
> dev_data/PASID info and use those for invaliation. Since invalidation needs
> device protection domain I have to refer dev_data->domain.

See my other email, this area looks quite troubled.

> > Also, didn't you say you wanted to de-duplicate the IOTLB and ATC
> > invalidations like ARM is doing?
> 
> I don't have the understanding of ARM. But our invalidation
> interfaces needs improvement. Like current code does unncessary
> complete_wait() calls. Those will be fixed along with other
> invalidation cleanup.

Future fix is fine
 
> > 
> >> +static const struct mmu_notifier_ops sva_mn = {
> >> +	.invalidate_range = sva_mn_invalidate_range,
> >> +	.release = sva_mn_release,
> >> +};
> > 
> > Why an empty release function?
> > 
> > That can't be right, when release is called the driver has to stop
> > using iommu_virt_to_phys(domain->mm->pgd)) because it will be freed
> > memory. It should replace it with a global empty pgd and flush caches
> > before release returns.
> 
> In remove_dev_pasid() its already removed PASID from GCR3 table, flushing IOMMU.
> Also if its last device unbind, then it also does mmu_notifier_unregister().
>
> I thought remove_dev_pasid() always gets called before mmu notifier releases.
> Is there any chance of mmu notifier relase() getting called before
> remove_dev_pasid().

Yes it can be called in that order. An empty release function here is buggy.

> >> +	pasid_data->pasid = pasid;
> >> +	pasid_data->dev_data = dev_data;
> >> +
> >> +	/* Setup GCR3 table */
> >> +	ret = amd_iommu_set_gcr3(dev_data, pasid,
> >> +				 iommu_virt_to_phys(domain->mm->pgd));
> >> +	if (ret)
> >> +		goto out_free_pasid_data;
> >> +
> >> +	if (list_empty(&sva_pdom->pasid_list)) {
> >> +		sva_pdom->mn.ops = &sva_mn;
> >> +
> >> +		ret = mmu_notifier_register(&sva_pdom->mn, domain->mm);
> >> +		if (ret)
> >> +			goto out_clear_gcr3;
> >> +	}
> > 
> > Looks to me like mmu_notifier_register() should be done before
> > amd_iommu_set_gcr3() so we don't have a risk of stale iotlb data.
> 
> Actually we need to update GCR3 table with PASID before registering mmu
> notifier. So that hardware is ready to handle the invalidations. Otherwise we
> will have a redudant invalidations.

If you register the mmu and the paslid_list is empty (or locked) then the
invalidation handler does nothing. So this cannot be a concern.

Putting it out of order like this creates an edge case where the HW
could concivable cache a translation and miss a notification. It is
definately wrong.

> >> +void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
> >> +{
> >> +	struct pdom_pasid_data *pasid_data;
> >> +	struct protection_domain *sva_pdom;
> >> +	struct iommu_domain *domain;
> >> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> >> +	unsigned long flags;
> >> +
> >> +	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
> >> +		return;
> >> +
> >> +	/* Get protection domain */
> >> +	domain = iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAIN_SVA);
> >> +	if (!domain)
> >> +		return;
> >> +	sva_pdom = to_pdomain(domain);
> >> +
> >> +	/* Ensure that all queued faults have been processed */
> >> +	iopf_queue_flush_dev(dev);
> >> +
> >> +	spin_lock_irqsave(&sva_pdom->lock, flags);
> >> +
> >> +	pasid_data = get_pdom_pasid_data(sva_pdom, dev, pasid);
> >> +	if (!pasid_data) {
> >> +		spin_unlock_irqrestore(&sva_pdom->lock, flags);
> >> +		return;
> >> +	}
> >> +
> >> +	list_del(&pasid_data->pdom_link);
> >> +	kfree(pasid_data);
> >> +
> >> +	/* make it visible */
> >> +	smp_wmb();
> >> +
> >> +	/* Update GCR3 table and flush IOTLB */
> >> +	amd_iommu_clear_gcr3(dev_data, pasid);
> >> +
> >> +	spin_unlock_irqrestore(&sva_pdom->lock, flags);
> >> +
> >> +	if (list_empty(&sva_pdom->pasid_list))
> >> +		mmu_notifier_unregister(&sva_pdom->mn, domain->mm);
> > 
> > Can't drop the spinlock before doing this, it is racy.
> 
> Yeah. Its racy. But we cannot call mmu_notifier_unregister() with spinlock held.
> May be I will introduce some lock to handle notifier.

If you reoganize things so the notifier is always registered then you
don't need to have the spinlock protecting it anymore. this requires
putting the unregister in the domain deallocation routine.

Jason
