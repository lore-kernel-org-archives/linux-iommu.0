Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9316DD07
	for <iommu@lists.linux.dev>; Fri, 12 Jan 2024 14:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KcfPFnl/"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bc4f49a3b6so6968360b6e.1
        for <iommu@lists.linux.dev>; Fri, 12 Jan 2024 06:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705071576; x=1705676376; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZJijTlH6ZCHR8tBeqJ0Y2HgFz2mIGBuXHRJwRUztyg=;
        b=KcfPFnl/oqMBshSeYQsRXNGkHu1cLNGbNYOaGXceOslLx09qhClMKVvp9Ro6jV5FX5
         GeOGMfB5NdppHWMQk/cVTyx4ig0V7HIRdoz2lKvRPxsmeHDRtNNtlNLhw8STLHucyLwR
         QjsnFPRjNnNVjnwDoYZeUIIAES7652Sou4b36XbPyUlGgny87tXS4MNva+9dMGU8WwPb
         HLfbTWgTE2Yhk3bb6TjiK+INu/PdKAsc/AjOavWAy8aF2crztTjFRffkbeUUa1kIJVSQ
         jDCgRZ2ySXjbFrFeSkI8qo0togOOoWwqhnQgnLT6fbJb/N2F5xiRK6Us9J0QDfb6pnby
         XWQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705071576; x=1705676376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZJijTlH6ZCHR8tBeqJ0Y2HgFz2mIGBuXHRJwRUztyg=;
        b=Dij3YW9qb5saNke1K4Q6VHOKZLE1Xpi+OuKmNeJMcZCbW7Z8K3leBW6f5l+DG7SJWD
         9eNFkSgqIE4JOO5qSzFy95+hJxfbD0UWUQjvYvHrTeEvCY8BLBDzsOK+Rnul8V0d2Hto
         YOvWPty43cXfs+rTvcR0YwHuSaD0fse4Fj2uEiQO/aWTQEfPTZ08nwfnaxSfPEfFMZXa
         ZBDwHNFhWi5i446hPurNTBn1PzOoRmE4dR7dLvmpZQALkmXC10o+a35Jad+nwz4o0rYG
         iJq/mrtY3DCzOYNxl/oOBWCfChOZOxS9uh0c13Gt7cbhnX9VqP2iNHyaV62cSyCgBX9a
         Yxlw==
X-Gm-Message-State: AOJu0Yzj4DI7vrfirf1YoPs6yxHN5/mlWMDdhTffc2tBvP8D72yzJ0Bd
	Wprsz6Y9pI3eyjG2OGC67+Hn8YWgbKlHtg==
X-Google-Smtp-Source: AGHT+IH9w/pZb9ZmcDjPaY9IzMusr3uVNAhVDEAtskC+kKODbEt2XiCdfn4E97nfuN+IsZScpls+ng==
X-Received: by 2002:a05:6808:148f:b0:3bd:5520:9046 with SMTP id e15-20020a056808148f00b003bd55209046mr1301072oiw.26.1705071576194;
        Fri, 12 Jan 2024 06:59:36 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id dj17-20020a056808419100b003bd39c80e2bsm599264oib.38.2024.01.12.06.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 06:59:35 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rOJ0Q-003LuE-2e;
	Fri, 12 Jan 2024 10:59:34 -0400
Date: Fri, 12 Jan 2024 10:59:34 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 07/16] iommu/amd: Introduce per-device domain ID to
 workaround potential TLB aliasing issue
Message-ID: <20240112145934.GY50608@ziepe.ca>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-8-vasant.hegde@amd.com>
 <20240105185549.GM50608@ziepe.ca>
 <d71a2bc0-ed07-53eb-faf1-bd36b6ff6ffb@amd.com>
 <20240111135952.GV50608@ziepe.ca>
 <0215990a-dff1-c6c3-bfa1-c90fa63b0c7b@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0215990a-dff1-c6c3-bfa1-c90fa63b0c7b@amd.com>

On Fri, Jan 12, 2024 at 06:15:07PM +0530, Vasant Hegde wrote:

> Right. It makes sense when using V2 page table. But when we are in V1 page table
> we don't have GCR3. We will revisit once we finalize some of the vIOMMU stuff.

But in v1 mode the domain_id comes from the iommu_domain struct, there
is no case where it logically is part of the device.

> > Invalidation is no different than any other V2 domain use case. The
> > domain ops trigger invalidation. In AMD HW you need to record that an
> > unmanaged domain is connected to a domain ID & PASID and push the
> > right invalidate. The driver can't just assume the PASID is 0 for V2
> > unmanaged domains.
> > 
> > So the implementation is to track the attacked devices, iommus and
> > PASIDs in a linked list and use that linked list to generate
> > invalidations. Intel and SMMU (after my patches) both have
> > implementations of this. I would like to unify them to a helper
> > because they are both kind of bad.
> > 
> > There are many use cases for PASID mappings without SVA, including
> > SIOV-like devices and virtualization modes with non-SVA PRI.
> 
> What kind of page table will be attached with non zero PASID? like KVM page table?

Probably at copy of the KVM page table in some for, certainly today
starting with an UNAMANGED domain as is normal. I think people will
want to do different things here..

> >>   - iommu_ops->iotlb_sync_map/flush_iotlb_all will flush PASID zero.
> >>     Looking into intel driver they seems to be invalidating all PASIDs in this
> >> path. I didn't get why it has to flush all PASIDs here.
> > 
> > You iterate ove the list above and flush every PASID in the list. I
> > don't know what Intel is doing, fush all PASID on domain invalidation
> > sounds like overkill.
> 
> IIUC with UNMANAGED domain with PASID, we will have device/pasid list with
> different PASIDs pointing to different page tables.
>   ex: PASID 0 with DMA-API mode , PASID1 pointing to some other page table.

The *device* has a list of PASID's that point to iommu_domains. This
is stored in an xarray inside the iommu_group.

The *iommu_domain* has a list of *devices & PASIDs* that can use this
domain for translation (ie that it was attached to)

The RID attach is just PASID 0.

> This is where the confusion is. Current iommu ops doesn't take pasid as
> parameter. So if we go over entire dev/pasid list and flush it becomes overkill
> right?

If I have a v2 paging iommu domain (unmanaged) and I change the IOPTE
to effect a certain IOVA range then I have to invalidate it at every
place that is caching it.

For ATC that means I need to issue an invalidation to every
(iommu, RID, PASID) combination that has it in cache.

For V2 AMD IOTLB I need to issue an invalidation for every
(iommu, device->gcr3->domain_id, PASID) that has it in the cache.

For V1 AMD IOTLB I need to invalidate every
(iommu, domain->domain_id) combination.

It is a data structure problem to store a minimal list of those
things off of the iommu_domain.

No new op parameters are needed.

ATC is a list of every attached struct device and PASID, populated by
ops->attach_dev (PASID=0) or ops->set_dev_pasid.

V2 IOTLB is that same list with duplicate device->gcr3->domain_id's
removed

IOMMU is that same list with duplicate device->amd_iommu's removed,
which is the list V1 IOTLB needs.

So, store one linked list for ATC in the iommu_domain.

Sort it by (device->amd_iommu, device->gcr3->domain_id, device->id)

Skip consecutive runs of same domain_id or same iommu when generating
the invalidation sequences.

Use RCU to lock the list so the invalidation fast path is
lockless. (this is tricky)

Jason
