Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD953882B
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 21:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680126333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lXHz4bzMg4iWUG5B7slBefzvXR6XUmGmK2zNQpGdaVY=;
	b=FRhR7Jb+JzFmaxCyU73PYxYc90O8iamWw4myXbckYs+rdDm7D+Zv/IHhwm5NXDIOZB/6uU
	kkpJfp9JRBqHMDsnfG3BaL0TAppdf4FugN2hiWO5Ts6xi2ukiUP6r6BBuspsPb4dGqjFSt
	gaOCYI8dOFhO27DGlujFvL1zduXFxBA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-zlfqfSiTNnS6BVKqBHMCMQ-1; Wed, 29 Mar 2023 17:45:29 -0400
X-MC-Unique: zlfqfSiTNnS6BVKqBHMCMQ-1
Received: by mail-qt1-f197.google.com with SMTP id m7-20020a05622a118700b003e4e203bc30so8734755qtk.7
        for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 14:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680126329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lXHz4bzMg4iWUG5B7slBefzvXR6XUmGmK2zNQpGdaVY=;
        b=VGWEsKyWfg5ZQ/5SaBboN7u6MHeDbZtz70cmPJLJYo7S5Y3iFMYHJnwikrJk7k5+IQ
         GrOi4dwzFPycpRllrXJaW72zI4E3rHJAI6m5tWbnIGmOsqIiDPeiWfx4dkP5FQgBsNgm
         wCgGTKYshiMt/NoK8ureO2nwFNpgRV/CBVOz21SWzWgvtoUbnnPbBol2y4KV0Is9fBZA
         H1uf5Kn0xbckeFmcYl7w0f8cjyqcy6fTjeNhkCsa6B8cBkDueiw+CJ69LMrLq+B5clim
         73/Wo9F1hNGDbRk6niDwOKOnhQE18G7dnqYG/RVGKb0xzv2p4Wlg90jGZgKurel2A/y2
         wdGg==
X-Gm-Message-State: AAQBX9fezscU9q82tVysqbNj+Que2cmEVtzlbt7XvsCrT5GvizW28zGv
	sDEETaojk+K05r8wfQ+wl3PY+rLgL1XpJ5oQR6OPSXEpgygid5MLMJ0fR2rcXqep6+XIXelZsqk
	hnbBrA/K7whFGxYE=
X-Received: by 2002:a05:6214:d62:b0:5bd:14f9:650d with SMTP id 2-20020a0562140d6200b005bd14f9650dmr38886236qvs.36.1680126328884;
        Wed, 29 Mar 2023 14:45:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350aXpUk7Ahea0RsCDHilKgsMiNK6MkJ17b/YCavFdWrxMeMIWUmS9AOXV0Ct+MbDYKgIhr9e1w==
X-Received: by 2002:a05:6214:d62:b0:5bd:14f9:650d with SMTP id 2-20020a0562140d6200b005bd14f9650dmr38886207qvs.36.1680126328605;
        Wed, 29 Mar 2023 14:45:28 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id g11-20020ad457ab000000b005dd8b9345c2sm4968709qvx.90.2023.03.29.14.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 14:45:28 -0700 (PDT)
Date: Wed, 29 Mar 2023 14:45:26 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: Reserved Memory Regions (was: AMD v2 page tables)
Message-ID: <ikavmqdtuwuajzzyg6teyhsowvv5wbqcidaz4rituuzdm2uore@ried6bsjdxsx>
References: <bfugskdi4oawsiqobmarhifwh2iy55av6unl2yuvbjyludy7cn@lw3pgvhuk52a>
 <6zanf6rxogeyaiavva2e5z2b3vdjod4bzyddy2o73xpuhf3lym@zwag664axipl>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <6zanf6rxogeyaiavva2e5z2b3vdjod4bzyddy2o73xpuhf3lym@zwag664axipl>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 29, 2023 at 01:48:23PM -0700, Jerry Snitselaar wrote:
> On Mon, Mar 27, 2023 at 11:33:12PM -0700, Jerry Snitselaar wrote:
> > I was looking at this the other day, and by chance booted it up on a
> > system with a megaraid_sas controller in it. So it had an IVMD block
> > for the scratchpad or whatever it is they do. During probing
> > iommu_create_device_direct_mappings() gets called, and pgsize_bitmap
> > for the iommu_domain is set to the V1 bitmap because that is the
> > amd_iommu_ops default. So iommu_pgsize() uses that to figure out what
> > page size to use for the mapping. Then when it gets into the amd
> > mapping code it checks that page size against the io_pgtable_cfg
> > pgsize_bitmap, which is set to the V2 bitmap, sees that it isn't
> > a supported page size, and bails out of iommu_v2_map_pages().
> > 
> > The following worked, but I'm not sure it is the right answer.
> > 
> > Regards,
> > Jerry
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index 5a505ba5467e..040199ac8546 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -2048,6 +2048,8 @@ static int protection_domain_init_v2(struct protection_domain *domain)
> >  
> >  	domain->flags |= PD_GIOV_MASK;
> >  
> > +	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
> > +
> >  	if (domain_enable_v2(domain, 1)) {
> >  		domain_id_free(domain->id);
> >  		return -ENOMEM;
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 10db680acaed..e70e5cbec8cc 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1964,8 +1964,13 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
> >  		return NULL;
> >  
> >  	domain->type = type;
> > -	/* Assume all sizes by default; the driver may override this later */
> > -	domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
> > +	/*
> > +	 * Assume all sizes by default if not already set;
> > +	 * the driver may override this later
> > +	 */
> > +	if (!domain->pgsize_bitmap)
> > +		domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;
> > +
> >  	if (!domain->ops)
> >  		domain->ops = bus->iommu_ops->default_domain_ops;
> >  
> > -- 
> > 2.38.1
> > 
> 
> Hi Will and Robin,
> 
> Is this a potential issue for arm with the recent RMR changes, and the default page size bitmap being -1UL?
> Where I ran into this for the AMD code was in the loop in bus_iommu_probe():
> 
> 		/* Try to allocate default domain */
> 		probe_alloc_default_domain(bus, group);
> 
> 		if (!group->default_domain) {
> 			mutex_unlock(&group->mutex);
> 			continue;
> 		}
> 
> 		iommu_group_create_direct_mappings(group);
> 
> 		ret = __iommu_group_dma_first_attach(group);
> 
> 
> 
> IIUC, arm will set the domain bitmap with the attach after the call to iommu_group_create_direct_mappings()?
> 

Ah, I see that the default gets set during the probe of the smmu, and avoids this.

> Regards,
> Jerry
> 

