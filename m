Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3CA35EF3
	for <iommu@lists.linux.dev>; Fri,  5 Jan 2024 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KZTcCS1n"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7815aca9a4eso103700785a.0
        for <iommu@lists.linux.dev>; Fri, 05 Jan 2024 10:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1704480951; x=1705085751; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VyUZK8igZHNbsf3inn1diFJcS+bW+KUDH/Ilmg6zYc0=;
        b=KZTcCS1nnpQKVO6OCBau7A1T+GMtdu9XdMWYey6VzfE0w9EKRK18XXUEBBUSCXAI80
         eV01c3XrtVI6dLfsDgSPOjCAarHDXy4P+UPCHTUUxXqyEkZ1JLJVQFkrBk2WzSmM8yXs
         s/YcAvJRHQyCT/jm20bV2wGMhgwX+7pcx+gchS6iVYdW/f14+W3otALxRkbW5nLmxiaT
         JZJ4fzobAZhvNFmMR5FF0Od+nRfybf47YWZyNrOBILVDd97K5wGFMA3pWXYAkKTMUFiE
         DQR7Ay64n27aXX/AhOYY5Rnyi18Rf0tCb3rto8tkRm90afVndF4K0P++ryoG9FKnq1v9
         AE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704480951; x=1705085751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyUZK8igZHNbsf3inn1diFJcS+bW+KUDH/Ilmg6zYc0=;
        b=df2aVqAHeTnEmcq5ovKPEmBf053S7ROAnInFyl6LQGS9HHoer/EQb6nYAmJbnXenie
         SO+lrdVS09DqC0jFCDStfU2DBW2E7k5ilNn9xqRiwwzRtOfhq1tan9BBmCUUFpcPhhRv
         Conh5bSTaTllotjo0WduOaJe/sHUAokQU5lZEhWz5VoYRGsZ1EQGEv9BC7tNk3iaMfL7
         a6/8cIBvV0ws0VKorl3cL1sDN9I0t/LK7517nzhX+l0c5jwet5g4aZQp+UkQGAtD/vdv
         aI0HcNheNq0pFkC36FdJIOrjFPtxzgxGZXAj8kfisZyDJq6oh4wWC1BlDmROH7hv484m
         cwBw==
X-Gm-Message-State: AOJu0YzZuXC0h9tOg+0WdzjC/rvtnrhzV0RHztjzVkHGHp3W/TZG0y5L
	Q/bdQz7l0xIZdAzuHJfx8zHs3R4NwJwoWQ==
X-Google-Smtp-Source: AGHT+IHhfXdlhAMU/dLQlwX39vqGZrVvcGtsoK4w+uPyi1mRNdWlnpYItXcNkNobZ10D+vrme610ew==
X-Received: by 2002:a05:620a:1187:b0:781:38f6:198b with SMTP id b7-20020a05620a118700b0078138f6198bmr2808282qkk.39.1704480951031;
        Fri, 05 Jan 2024 10:55:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id c1-20020a05620a268100b00781baa4db60sm776225qkp.66.2024.01.05.10.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 10:55:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rLpMD-001VT9-R9;
	Fri, 05 Jan 2024 14:55:49 -0400
Date: Fri, 5 Jan 2024 14:55:49 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v4 07/16] iommu/amd: Introduce per-device domain ID to
 workaround potential TLB aliasing issue
Message-ID: <20240105185549.GM50608@ziepe.ca>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-8-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212085224.6985-8-vasant.hegde@amd.com>

On Tue, Dec 12, 2023 at 08:52:15AM +0000, Vasant Hegde wrote:
> With v1 page table, the AMD IOMMU spec states that the hardware must use
> the domain ID to tag its internal translation caches. I/O devices with
> different v1 page tables must be given different domain IDs. I/O devices
> that share the same v1 page table __may__ be given the same domain ID.
> This domain ID management policy is currently implemented by the AMD
> IOMMU driver. In this case, only the domain ID is needed when issuing the
> INVALIDATE_IOMMU_PAGES command to invalidate the IOMMU translation cache
> (TLB).
> 
> With v2 page table, the hardware uses domain ID and PASID as parameters
> to tag and issue the INVALIDATE_IOMMU_PAGES command. Since the GCR3 table
> is setup per-device, and there is no guarantee for PASID to be unique
> across multiple devices. The same PASID for different devices could
> have different v2 page tables. In such case, if multiple devices share the
> same domain ID, IOMMU translation cache for these devices would be polluted
> due to TLB aliasing.
> 
> Hence, avoid the TLB aliasing issue with v2 page table by allocating unique
> domain ID for each device even when multiple devices are sharing the same v1
> page table. Please note that this workaround would result in multiple
> INVALIDATE_IOMMU_PAGES commands (one per domain id) when unmapping a
> translation on the shared v1 page table.

Huh? This is a typo? "the same v2 page table"  "unmapping a
translation on the shared v2 page table" ??

The code seems to be fine, domain_flush_pages_v1() looks optimal?

> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index fead9033796f..51daf5dd4729 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -842,6 +842,8 @@ struct iommu_dev_data {
>  	u8 ppr          :1;		  /* Enable device PPR support */
>  	bool use_vapic;			  /* Enable device to use vapic mode */
>  	bool defer_attach;
> +	/* Per device domain ID. Used with V2 page table */
> +	u16 domid;

This should really be put into the 'struct gcr3_tbl_info' - logically
that is the struct the HW cache tag is linked to. ie if the gcr3 table
is the same pointer then the cache tag can be re-used by the HW.

Then when you want to optimize for the no-pasid case then the right
way to do it is putting a 'struct gcr3_tbl_info' inside the v2
protection_domain.

The DTE will point at the v2 protection_domain's version of the gcr3
if the PASID table is empty, otherwise the DTE will point at the
struct iommu_dev_data version of the gcr3 table.

Naturally this will optimize the lifecycle of the domain_id.

Then put the domain_id alloc/dealloc inside the functions that
alloc/free the memory under the struct gcr3_tbl_info - ie it is part
of the gcr3 layer.

> +/*
> + * Allocate per device domain ID when using V2 page table
> + */
> +static inline bool domain_id_is_per_dev(struct protection_domain *pdom)
> +{
> +	return (pdom && pdom->pd_mode != PD_MODE_V1);
> +}

Under that view this function probably would make more sense as:

domain_requires_gcr3(pdom)

But frankly I'd just stick with pdom_is_v2_pgtbl_mode().

Also pdom should never be null when this is called, right?

> -/*
> - * TLB invalidation function which is called from the mapping functions.
> - * It invalidates a single PTE if the range to flush is within a single
> - * page. Otherwise it flushes the whole TLB of the IOMMU.
> - */
> -static void __domain_flush_pages(struct protection_domain *domain,
> +static int domain_flush_pages_v2(struct protection_domain *pdom,
>  				 u64 address, size_t size)
>  {
>  	struct iommu_dev_data *dev_data;
>  	struct iommu_cmd cmd;
> -	int ret = 0, i;
> -	ioasid_t pasid = IOMMU_NO_PASID;
> -	bool gn = false;
> +	int ret = 0;
>  
> -	if (pdom_is_v2_pgtbl_mode(domain))
> -		gn = true;
> +	list_for_each_entry(dev_data, &pdom->dev_list, list) {
> +		struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
> +
> +		build_inv_iommu_pages(&cmd, address, size,
> +				      dev_data->domid, IOMMU_NO_PASID, true);
> +
> +		ret |= iommu_queue_command(iommu, &cmd);
> +	}

This is fine for where things are here, but what you want to get to
long term is what I've been talking about of having the attachment
list on the protection_domain.

Each attachment entry would hold:
  struct device *dev;
  unsigned int pasid;

Keep the list sorted by (iommu, gcr.domain_id).

Then optimized invalidation is simply this:

for_each:
  if (get_amd_iommu_from_dev(entry->dev) == last_iommu &&
      get_gcr(entry, pdom)->domain_id == last_domain_id)
     continue;
  build_inv_iommu_pages(..)
  last_iommu = get_amd_iommu_from_dev(entry->dev)
  domain_id = get_gcr(entry, pdom)->domain_id;

And this algorithm matches what Intel and SMMU need and I'm strongly
thinking about making a driver utility library to handle it, so
we can revisit this later on.

> +static int domain_flush_pages_v1(struct protection_domain *pdom,
> +				 u64 address, size_t size)
> +{
> +	struct iommu_cmd cmd;
> +	int ret = 0, i;
>  
> -	build_inv_iommu_pages(&cmd, address, size, domain->id, pasid, gn);
> +	build_inv_iommu_pages(&cmd, address, size,
> +			      pdom->id, IOMMU_NO_PASID, false);
>  
>  	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
> -		if (!domain->dev_iommu[i])
> +		if (!pdom->dev_iommu[i])
>  			continue;

Right, iterate over every iommu

Jason
