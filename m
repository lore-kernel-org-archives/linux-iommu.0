Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CDB171B3
	for <iommu@lists.linux.dev>; Thu, 11 Jan 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CAqzo8mx"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3bba0ac2e88so2815923b6e.0
        for <iommu@lists.linux.dev>; Thu, 11 Jan 2024 05:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704981594; x=1705586394; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IAeKCHYzTWddk4XaM2efRytM7sMA2fUgMysURotw6hc=;
        b=CAqzo8mxcY+KuVkFV5nMWL7MXP3yPE8n8x1hMusLFgHHIYVcHOpHGiF2SHw6oceS6u
         m195cWw5OdZ7AV6NuD88Zba1sE2HJrl0R2VDdwJI0alF+tbquGsDHe76V7Vc0hGfLQiJ
         lt4cGnXxZ8H3+l5Xs+4bDqHd5WiZ8RHYYhq3tyJ9Ef3vmfRbFMZBG/Y0+N9IO9sfT8yn
         8rOK8apLt/FRC1B3UzpKfaao7LK9w1CxjLoiwNTdnGM8fhbwpLM8UX8yCB4BWU6rm6v+
         9FKF3U0YcNmUVK/uICHEXWGAN3K8KxeHrHNekg75/hfId52w0UyraayaDjjire4mLDuu
         6joQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704981594; x=1705586394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAeKCHYzTWddk4XaM2efRytM7sMA2fUgMysURotw6hc=;
        b=NV3/TcsYMVdW4R3iiFWtQrI+eF92nNO5dYpvaibKCR6I8mMsoKHAKl1sacvW7vs+Cv
         TmzY2NjyHjAWOxkLSEWsioQMrr3G93+QCKr6p2ZmoV+Lr7qSnDBV+8C2ISvtlkNZYtzM
         xzPRi0TDoWMXP46/h+sRTNxy8W6A6x52PFwFrZK6lg+JqybKSUKrbv32unuVloqcufhT
         rRwzCwWGRks5Bw5i3ozB+CdKZaOPvuS5wtRCf/frVkXVpZ/uXk/XwdSnCHZ7hG/3J731
         1PMuCZwpCbKMfUpsxG7EJn8uLPnX8FgiVzqORhHfNrT842fKO3fEV7/wNYt9Y8JCMoj8
         6vTQ==
X-Gm-Message-State: AOJu0YzlSbKh3UAuZjY4x6jZ5wcYFBU1pyfwTpTUNcVBSNOssthqEjs4
	SEMFiW6D9Hp3dANvsbrDHIz8mDu2CR6Xqg==
X-Google-Smtp-Source: AGHT+IGIRLZrYDAcpB83sZ5Zm7opz+k/UxB7HWTgMhzb+LTkNPKRJX+8g7iztuMRTmIz0wfpPKI5Dg==
X-Received: by 2002:aca:230e:0:b0:3bd:3808:d587 with SMTP id e14-20020aca230e000000b003bd3808d587mr348297oie.16.1704981594234;
        Thu, 11 Jan 2024 05:59:54 -0800 (PST)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id y18-20020a056870389200b00205dced6035sm225808oan.39.2024.01.11.05.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 05:59:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rNvb6-0031EV-6L;
	Thu, 11 Jan 2024 09:59:52 -0400
Date: Thu, 11 Jan 2024 09:59:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 07/16] iommu/amd: Introduce per-device domain ID to
 workaround potential TLB aliasing issue
Message-ID: <20240111135952.GV50608@ziepe.ca>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-8-vasant.hegde@amd.com>
 <20240105185549.GM50608@ziepe.ca>
 <d71a2bc0-ed07-53eb-faf1-bd36b6ff6ffb@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d71a2bc0-ed07-53eb-faf1-bd36b6ff6ffb@amd.com>

On Thu, Jan 11, 2024 at 04:48:01PM +0530, Vasant Hegde wrote:

> > The code seems to be fine, domain_flush_pages_v1() looks optimal?
> 
> I'd say its optimal for given state. I have a patch to move dev_iommu[] to
> xarray. I am planning to fine tune and post those patches after SVA. With that
> changes it will be better.

I'm not keen on an xarray, that isn't fully addressing the problem and
when Intel did it they messed up the locking..

I would like to make a shared helper to solve this problem. A rcu
backed linked list, with a helper API to iterate once per-iommu.
The RCU is a bit tricky.

> >> --- a/drivers/iommu/amd/amd_iommu_types.h
> >> +++ b/drivers/iommu/amd/amd_iommu_types.h
> >> @@ -842,6 +842,8 @@ struct iommu_dev_data {
> >>  	u8 ppr          :1;		  /* Enable device PPR support */
> >>  	bool use_vapic;			  /* Enable device to use vapic mode */
> >>  	bool defer_attach;
> >> +	/* Per device domain ID. Used with V2 page table */
> >> +	u16 domid;
> > 
> > This should really be put into the 'struct gcr3_tbl_info' - logically
> > that is the struct the HW cache tag is linked to. ie if the gcr3 table
> > is the same pointer then the cache tag can be re-used by the HW.
> > 
> 
> The reason we put it in dev_data is because its per device ID, not specific to
> GCR3 table.

But from a HW perspective it is actually linked to the GCR3 table as
that is the data pointer that is being cached. Two devices that share
a GCR3 pointer can share a domain ID.

If you want to optimize the domain ID tagging the logical way to do it
is to add code to share the GCR3 tables across devices. If the GCR3
table is the same then the domain ID can be the same.

> > Then when you want to optimize for the no-pasid case then the right
> > way to do it is putting a 'struct gcr3_tbl_info' inside the v2
> > protection_domain.
> > 
> > The DTE will point at the v2 protection_domain's version of the gcr3
> > if the PASID table is empty, otherwise the DTE will point at the
> > struct iommu_dev_data version of the gcr3 table.
> 
> This makese sense if we are sure we will do per-device-domain-ID only with V2
> page table. I still need to see how SVA support with vIOMMU works. For now I
> will keep this in my list. Once I have better picture I will fine tune.

SVA support is ugly on AMD - you need to flow through the virtual
domain ID to a consistent physical domain ID even though the guest may
have a DTEs tagged with the same domain ID but different GCR3
pointers.

Most likely the implementation will have the physical domain ID be
part of the nesting domain to achieve this.

> UNAMANGED Domain and PASID support:
>   - I was considering this scenario as well. I don't think I understood the use
> case of and how invalidation is suppose to work here.
> 
>    Can you explain (again?) the use case and how invalidation is suppose to work?

Invalidation is no different than any other V2 domain use case. The
domain ops trigger invalidation. In AMD HW you need to record that an
unmanaged domain is connected to a domain ID & PASID and push the
right invalidate. The driver can't just assume the PASID is 0 for V2
unmanaged domains.

So the implementation is to track the attacked devices, iommus and
PASIDs in a linked list and use that linked list to generate
invalidations. Intel and SMMU (after my patches) both have
implementations of this. I would like to unify them to a helper
because they are both kind of bad.

There are many use cases for PASID mappings without SVA, including
SIOV-like devices and virtualization modes with non-SVA PRI.

>   - For PASID capable device we will have per-device-domain-ID
>   - We will have default page table setup (PASID zero in our case) during domain
> initialization.

Domain initialization???

>   - We attach PASIDs to same domain. We can add this to list (protection domain
> device List info - which will have dev_data/PASID). So set/remove PASIDs is fine.

Right

>   - iommu_ops->iotlb_sync_map/flush_iotlb_all will flush PASID zero.
>     Looking into intel driver they seems to be invalidating all PASIDs in this
> path. I didn't get why it has to flush all PASIDs here.

You iterate ove the list above and flush every PASID in the list. I
don't know what Intel is doing, fush all PASID on domain invalidation
sounds like overkill.
 
>   - For other PASIDs do we have mmu notifier to invalidate as its attached to
> some process?

mmu notifier has nothing to do with PASID.

The driver should have a general scheme to keep track of a
iommu_domain's cache tags. This is the per-domain linked list of
pasid/device/iommu.

When the page table changes (however that page table is stored) it
walks that linked list and pushes invalidation commands.

For an unmanaged domain this common code is called by the
iommu_domain ops unmap/flush/etc.

For a SVA domain this common code is called by the MMU notifier
arch_invalidate_range

> > And this algorithm matches what Intel and SMMU need and I'm strongly
> > thinking about making a driver utility library to handle it, so
> > we can revisit this later on.
> 
> If things are common across drivers then it makes sense. We can consider common
> set of functions.

I have been meaning to try to make something, lets see next week

Jason
