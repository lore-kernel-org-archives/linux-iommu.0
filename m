Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1264D524
	for <iommu@lists.linux.dev>; Tue,  5 Sep 2023 18:14:11 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1c336f3f449so18662835ad.3
        for <iommu@lists.linux.dev>; Tue, 05 Sep 2023 11:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1693937651; x=1694542451; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ab15kX97rlpqHg6MUlPoWpa3FqFGfOPtAfNi1KYolt4=;
        b=RD9X7bwYENoPIlpmOYw53M3cp0mDBWcWSe7chVIui5vsiitYcjbKJa4Dv9iv0fU6oJ
         EHxACh76Bu+K25L8WicEC9YDTNJ35kgIcvTcCnhm+DxlwNt+oYt4rYmLpDUfamymv6jp
         g7KLwIRFS1tExWztF7MtF0RMrlS//j1LzVtH0QM+xDg3VNvYIt2PJuNVLPeFn2aObRn9
         Zop7iMXMRZU3OTleDyj/boBPqSWwGWfDSyYzYXFo4aL/RCFdP8TZSwOhZoOT0Q2aISVU
         IBO7HSGK8mqY+67YeBDgunl4v9JKVJs9lc2+O2ofrGBjNDPUH5x3307lvP46LFKsdLQ2
         pFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693937651; x=1694542451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ab15kX97rlpqHg6MUlPoWpa3FqFGfOPtAfNi1KYolt4=;
        b=a1ZchBTaQWNRFKppy7xHK9qgFlFuzpsP2726b+ohRIpy6aIfGjtfJWbrlZn+HMYSuk
         LiyJ/i5kx7qokZbcDiIIncAAg2xvrxw9eRtWNE8VD4jekjrG7I9oI4gexotq0/5VpEFi
         jgh/Zbl5PbXVGYqU0fU0brTat0UYg8xanHKzA4ML1yfDRoWx2ndJw1iLo/l/TokpWShM
         AKKjYbqEP4kcHv4AWUZfKFZZYHQ3Zv2p41a8RcY22qVxHNczrjrBVwley1V0aBJtdmup
         lEaROG3Djy4/molYjDomIpG009cB9v+pauu5t6eDU6VL207+RD0y49t4LLgfg2sB3WbS
         sSZg==
X-Gm-Message-State: AOJu0Yy41c2KnT26CA1580XKlmPxLJcdx3tdg9W+EMiApnU5de3aZSbT
	M0f2x5Z1GlQpEtIVtK0qzTd6W/B+loKyygsYWcw=
X-Google-Smtp-Source: AGHT+IEH7DwyynJmdBo/9GRzeD8Hk3+KTEi68Av5ohoSEfcYWTkxcroTXtvdHcTWZgLoTczoW3fYHA==
X-Received: by 2002:a17:902:da87:b0:1bd:f45e:b5cf with SMTP id j7-20020a170902da8700b001bdf45eb5cfmr18420910plx.22.1693937651040;
        Tue, 05 Sep 2023 11:14:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id l11-20020a170902f68b00b001b8af7f632asm9613509plg.176.2023.09.05.11.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 11:14:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qdaYy-000s2B-8A;
	Tue, 05 Sep 2023 15:14:08 -0300
Date: Tue, 5 Sep 2023 15:14:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH RESEND 03/10] iommu/amd: Initial SVA support for AMD IOMMU
Message-ID: <ZPdv8P4zTNJODcXD@ziepe.ca>
References: <20230823140415.729050-1-vasant.hegde@amd.com>
 <20230823140415.729050-4-vasant.hegde@amd.com>
 <ZOYXoMPBQZ5KK9IJ@ziepe.ca>
 <fc17e0fb-e712-824f-93f9-f9edf5707395@amd.com>
 <ZO93WJnhxl+sC9zA@ziepe.ca>
 <d64d8066-7cee-46c6-2403-76eaa969fe53@amd.com>
 <ZPcejmNW153rcRFA@ziepe.ca>
 <38845842-d535-b621-1e6b-16d8db52a1bb@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38845842-d535-b621-1e6b-16d8db52a1bb@amd.com>

On Tue, Sep 05, 2023 at 08:09:39PM +0530, Vasant Hegde wrote:
> >>   - set_dev_pasid() will check the compatibility and bind device/pasid only if
> >> its compatibility. In AMD case we will check against protection domain. Ex:
> >>  If we have two devices (devA and devB) in two different protection domain then:
> >>    set_dev_pasid(sva_domain, devA, pasidX) - SUCCESS
> >>    set_dev_pasid(sva_domain, devB, pasidX) - Compatibility check fail
> 
> Here I expect it to fails as devB is in different protection domain. From
> invalidation point of view, devA and devB are not compatible. Hence I think it
> should fail binding.

No, that isn't the best thing to do - you could do this, but it will
be more inefficient.

The domain should represent the ioptes not the target of invalidation.

> >>   - During invalidation, we will retrieve SVA protection domain using mmu
> >> notifier. Use device protection domain which was tracked in this SVA domain for
> >> invalidation.
> > 
> > The iommu_domain/protection_domain must NOT be 1:1 with a device. The
> > driver must maintain a list of devices attached to the domain, and the
> > per-device-attachment parameters like PASID/cache tags/etc.
> 
> We want to track SVA protection domain to device protection domain link. So that
> invalidation becomes straight.
> If we track dev/PASID then I am not sure how we can solve duplicate invalidation
> issue that we have today (i. e. if we have two devices within same protection
> domain and if we track dev/pasid combinatin, then will call invalidation twice).

Look at what Michael is doing for SMMUv3, they have a per-smmu
instance cache tag and a per-device ATC invalidation they need to
issue. They keep a sorted list of device attachments and simply do one
invalidation per-smmu instance and one invalidation per entry.

It is pretty simple logic.

> > PAGING domains need to support PASID+PRI, in today's language that
> > means UNMANAGED domains.
> > 
> > We have many use cases for PRI support with generic PAGING domains.
> 
> What is that usecase? That's what I am trying to understand it better.

iommufd will require this for generic vSVA in all paths that don't use
nesting.

We have use cases to share a KVM page table with PRI.

Google apparently has some usecase since they are fixing it in ARM.

Besides that, it is the IOMMU API, drivers have to implement it, you
don't get to pick and choose.

> > SVA is a special case of a PAGING domain where there is no map/unmap/invalidate
> > API and the IO page table comes from a mm_struct.
> > 
> > Start by making UNMANAGED (aka PAGING) domains work with PASID + PRI
> > and then SVA is a very small incremental step.
> 
> If there is a real use case then why not? We can do that. But for now we want
> the proper SVA to go first.

You are not going to get SVA without also properly doing all
infrastructure to enable paging and unmanaged - I won't support
another shortcut hackjob for SVA that needs unwinding like ARM has.

PASID and PRI must not be tightly linked to SVA.
      
Jason
