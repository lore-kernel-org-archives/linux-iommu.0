Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4F623D4
	for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 17:07:42 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-68bedc0c268so4960390b3a.0
        for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1693415261; x=1694020061; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BPtOk4nAWpCoQrnZ5URDfrV7N8ATFbLSilEsMcZXv04=;
        b=Ra6c4cCj6mUl+cZ/GN4K8p9pWI8CuKDmFw9WmqvKGsqBiX9IqPVNY+NlxwkQKlpaBr
         J235IkymdFczL/zkw68kUUivRLRT0IoVajHYW45WfY/2u5p7b/ZUYZOAywer8heKHsIA
         Buq/40DV3fE8qtJwLOLAjhYt1TK6ouA/MBPypBJ/7HDBzWCPrlS2ALeOplf6jvK3EABa
         Ym2u0L0yPlZc8RAe3Szq9W3ECh7CyrKnUQHmE33fc04zlPp9M1j+px1lqxBLg7+4mJWF
         SSnXLfOWSonCsUjCoPPUkBkaLJRANdDMR9ogihVc8zieFvHHVf0XI7+nFPwxr0h/vNG0
         E+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693415261; x=1694020061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPtOk4nAWpCoQrnZ5URDfrV7N8ATFbLSilEsMcZXv04=;
        b=K+68u/SwE8hC7pm13WiUzh8fu8yc+FFAw/pkPYY+Rx18DC3qUMcksUQ93cZnItuApN
         8mTy/T9apHO0KS6CM0Vg8FAoyiGRHgga6SQIMa+mKg3vqUo5Ja/1u0CU7Sc6kvkIKx18
         0hMVH4VkirVOi3Vu5R/M/GRgDJYGMQJkf+X7ltwQlAdJEgvubdZGE5j0efReKQfhzbj9
         HS5jOGf9Dr93iIs2oM+LlccI7iwhWyOFcgEfLwLt+XIcOhvqhgrs7IBuAqcUQMCDATH7
         ZSvZ4c1CTVBN6aGZZ0KgtHcb+8fAilNp/+RnpnGxwpF/JDGH+pcLC1YRSrMRfVoGUSYx
         vYsQ==
X-Gm-Message-State: AOJu0YwHg2DTsvRIOJ38UrabXMXy6zUZPmydswpIJS0fA5D9nBgTACeJ
	QWq90kYDshUiPHsBV5Jb9obnuQ==
X-Google-Smtp-Source: AGHT+IEHQrYbIyXx6GrdOzRo54x6D50brlBFB+mqyWzJLV6bm8i8+qC6Lq2LzsM82EAbl615yU+0Ig==
X-Received: by 2002:a05:6a20:3954:b0:13d:b318:5c70 with SMTP id r20-20020a056a20395400b0013db3185c70mr3465182pzg.19.1693415261255;
        Wed, 30 Aug 2023 10:07:41 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id 21-20020aa79115000000b0068a2d78890csm10255155pfh.68.2023.08.30.10.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 10:07:40 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qbOfI-00061R-Oc;
	Wed, 30 Aug 2023 14:07:36 -0300
Date: Wed, 30 Aug 2023 14:07:36 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH RESEND 03/10] iommu/amd: Initial SVA support for AMD IOMMU
Message-ID: <ZO93WJnhxl+sC9zA@ziepe.ca>
References: <20230823140415.729050-1-vasant.hegde@amd.com>
 <20230823140415.729050-4-vasant.hegde@amd.com>
 <ZOYXoMPBQZ5KK9IJ@ziepe.ca>
 <fc17e0fb-e712-824f-93f9-f9edf5707395@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc17e0fb-e712-824f-93f9-f9edf5707395@amd.com>

On Mon, Aug 28, 2023 at 04:09:16PM +0530, Vasant Hegde wrote:

> >> +static void *sva_pasid_private_find(u32 pasid)
> >> +{
> >> +	return xa_load(&sva_pasid_array, pasid);
> >> +}
> > 
> > No PASID stuff in SVA code at all please, all of this is wrong.
> 
> This is based on upstream code!

Yes, and we are changing all of this because how wrong the drivers
went with stuff like this. :(

> > No per-PASID struct. AMD enablement should go after this series:
> > 
> >  https://lore.kernel.org/linux-iommu/20230808074944.7825-1-tina.zhang@intel.com/
> > 
> > Put the mmu_notifier directly into the protection_domain. Assume you
> > have a single protection_domain per mm.
> 
> Actually we have protection domain for each IOMMU group (or multiple group in
> case of VM). 

Why would you do that for SVA? That is not the direction we are going.
One iommu_domain per mm, managed by the core code.

Driver assumes this and optimizes based on it.

If driver needs per device/pasid/whatever data then it keeps only that
data in a list hanging off the single iommu_domain.

It should be *exactly the same* data that an unmanaged domain needs to
manage its invalidations and ATC.

> > Also amd_sva_dev is not appropriate, the list of PASIDs (and masters)
> > a domain is associated with is part of the generic PASID support in
> > the protection_domain itself.
> 
> You mean to say, we maintain PASID list in device protection_domain
> and then in

yes, a linked list of devices RID and PASIDs that the domain is
attached to.

This is mandatory to issue any form of invalidation, an UNMANAGED
domains should use the same list, and same mechanism to invalidate
their PASID attachments as well.

> invalidation path (somehow) we retrieve protection domain and use it
> for

Yes, obtain the domain trivially via container_of(mmu_notifier). Store
the notifier in the SVA iommu_domain's driver struct
(protection_domain) to do this.

This is why the core code helps the driver by de-duplicating the SVA
domains, it can assume the iommu_domain is already minimal and it can
then safely place the notifier there. The drivers should not try to
de-duplicate the notifier with refcounting/etc.

> > These details would be clearer if you start from enabling PASID
> > support for an UNMANAGED domain.
> 
> We don't support PASID with V1 page table.

I didn't say V1 page table, I said enabling PASID support for
UNMANGED domains. This means you need a flavour of UNMANAGED domain
that is V2 page table. Just like ARM does. You already have this
support in the driver.

> >> +static void sva_mn_invalidate_range(struct mmu_notifier *mn,
> >> +				    struct mm_struct *mm,
> >> +				    unsigned long start, unsigned long end)
> >> +{
> >> +	struct amd_sva_pasid *sva_pasid;
> >> +	struct amd_sva_dev *sva_dev;
> >> +
> >> +	rcu_read_lock();
> >> +
> >> +	sva_pasid = container_of(mn, struct amd_sva_pasid, mn);
> >> +	if (!sva_pasid) {
> >> +		rcu_read_unlock();
> >> +		return;
> >> +	}
> >> +
> >> +	list_for_each_entry_rcu(sva_dev, &sva_pasid->dev_list, list) {
> >> +		if ((start ^ (end - 1)) < PAGE_SIZE)
> >> +			amd_iommu_flush_page(sva_dev->dev_data->domain, sva_pasid->pasid, start);
> >> +		else
> >> +			amd_iommu_flush_tlb(sva_dev->dev_data->domain, sva_pasid->pasid);
> >> +	}
> > 
> > SVA invalidation should be the same as normal PASID invalidation. You
> 
> Its same (Currently we have two different functions based on PAGE_SIZE. We have
> a separate series to improve our invalidation logic).

It is not the same, you have this weird sva_pasid thing in here. PASID
is NOT part of the SVA layer.

The API expects UNMANAGED domains will support PASID attach as well,
that is a significant use case.

> > Use container_of(mn) to get back to the SVA protection domain and then
> > you can access the protection domains list of PASIDs & masters.
> 
> I don't think I understood this. Even with Tina's patch series, we can get the
> SVA domain list. But we don't have a way to get device base protection domain.

Tina's patch series allows you to place the mmu_notifier struct
directly in the protection_domain struct.

When you get the invalidate() callback you go back to the
iommu_domain/protection domain that is affiliated with this MM.

From there you have all the information you can possibly need:

 - Global information in the protect_domain shared by all the devices
   (eg ARM uses this to put the shared cache tag)

 - Per attachment information (RID & PASID/etc) for each attachment.
   Iterate over this list to get the PASID/etc.

> >> +static int sva_bind_mm(struct device *dev, struct mm_struct *mm)
> >> +{
> >> +	struct amd_sva_pasid *sva_pasid;
> >> +	struct amd_sva_dev *sva_dev;
> >> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> >> +	int ret = -EINVAL;
> >> +
> >> +	sva_dev = sva_dev_alloc(dev);
> >> +	if (!sva_dev)
> >> +		return ret;
> >> +
> >> +	sva_pasid = sva_pasid_private_find(mm->pasid);
> >> +	if (!sva_pasid) {
> >> +		sva_pasid = sva_pasid_alloc(mm);
> >> +		if (!sva_pasid)
> >> +			goto out_sva_dev;
> >> +
> >> +		ret = sva_pasid_private_add(sva_pasid->pasid, sva_pasid);
> >> +		if (ret)
> >> +			goto out_sva_pasid;
> >> +
> >> +		ret = amd_iommu_set_gcr3(dev_data, sva_pasid->pasid,
> >> +					 iommu_virt_to_phys(sva_pasid->mm->pgd));
> >> +		if (ret)
> >> +			goto out_pasid_remove;
> >> +
> >> +		ret = mmu_notifier_register(&sva_pasid->mn, mm);
> >> +		if (ret)
> >> +			goto out_clear_gcr3;
> >> +	}
> > 
> > The mmu_notifier should be setup when the domain is allocated, not
> > during bind.
> 
> We need to program (at least with AMD IOMMU) device PASID table before it can
> handle the invalidation notifications. Not sure how it will work if we move mmu
> notifier setup to domain allocation path.

The device list will be empty so there will be no PASIDs to
invalidate at this point. There will be seperate locking to protect
the device list, ensure that locking properly covers populating the
device list and setting up the HW to respond to the PASID.

> >> +void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
> >> +{
> >> +	struct iommu_domain *domain;
> >> +
> >> +	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
> >> +		return;
> > 
> > We should probably have the core code pass in the old domain to this
> > function, it is looking more like a mistake we didn't do that.
> 
> I don't think I understood this. Well, honestly I never understood why
> remove_dev_pasid() is part of iommu_ops while set_dev_pasid is part of domain ops.

Yeah, that is a bit weird, not sure there is a good reason

Regardless, the API should take in the current domain parmeter and
drivers shouldn't call the core to look it up in the xarray if that is
what drivers need to do.

> My understanding is in this path we necessary things like in AMD case updating
> device table entry and finally remove mmu notifier.

You should remove the RID&PASID from the device list and flush out the
HW caches under a lock.

mmu_notifier should be removed when the domain is deallocated.

Jason
