Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1D738238D
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123980; cv=none; b=Afh5pNCBc37T85KjpfyOyxbKJbZ+FD/qULEq57YZjZ4FupTDwXZHqpTdgJ5TJ0UH38M4DZcSrNmalk1Yunqo9kFHu6Cc1t8wtxGdl4YWA9xmnNJHAsWsIn+rKsqanE5P+WwSo73XYd+Fj7GBvaZyGFKD58x+aohFdHgiHYgn7Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123980; c=relaxed/simple;
	bh=t9OxCZoF6YbRVKylmH+0HlyPwlgHH9K8/ORJEjD0asQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQddxLg7lTw1O7mJcRPa46ZluRuwiE4IGVxZLjQ3rEHy/ohvzgWHg+3e1+nY0vchpRfTK0jjxNZDvt9g8cu/mdRSSxrV1/fd5273FpWEhN+bWHmmJHQIVXVsJDFPp3eczGc/dek2KGniTZbIbv2vgNZijsFi0fOA20O/XGgfYhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jRVU9cMF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jRVU9cMF"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso2465ad.0
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779123978; x=1779728778; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dkqatbApjTcUOlv+bi7ee5TYL+ejmFz/3nd+bMkwd8c=;
        b=jRVU9cMFljyyq8S8MDb2hdnGDLdxiD9gInupkYJ+Kvpr6JmFmhuuCOfhoTL5wqWxql
         bgd8u7Ln/BugjAynFUxDn1gqPBFILDkI4u7NpjDBLbyObvuilrz1uRtVPEaAI8JZ5L5P
         4b+zHpfYjv13uzXuBKjDMjXn4TK3FAZ7iUC6bWIVvXSECnVnPW5+gjrzeSzxqOE2aRPU
         doHo+yuF58hh/CpT1dj/egytpcl8oF9lxqOlgI1cXKwh0IQl5GbFmi0OKIz9ufpoLI90
         qq0Axgwz5Crz1MUHs0UyxNdJ5689acyRN121eBkondZUdBjM804bARqTwFgq0zrMxar9
         Y+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123978; x=1779728778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkqatbApjTcUOlv+bi7ee5TYL+ejmFz/3nd+bMkwd8c=;
        b=AJutSQ6T3IjUMLFWamchd2nwYM0c+xCpRqq/Pzb+qhNJ+497+fWknfde2alnSWEEs5
         sufB/VTWGgOlDzyD7bkTubVTJ3wImRUmIJI6daYfAKphdnHp6fsvyh7HBswn/XHc+2pV
         PCJwjfk2HWO+Ud40icdaWgLVnDBjj0qx1+buQEM89bwHtw901HNEt4kRdZDlDQWcAkhu
         3/xzBcqPTt144HlB5skXbe0wXq93kyGbuzCcEhcUeuuJfpn4pNdGB6l6Oj3XzOCExuVW
         Ez8T0ftTEN+rkOQwRwIOzzxwHcsEBGjK97F7o1Eh29b+6xltBdswJAnx353dfqEf24AN
         uOZw==
X-Forwarded-Encrypted: i=1; AFNElJ8RJnjf0SmOeHToWZ8VIOGgKTpsdQpuMwR1qAfMJsOCEuJ1Ibw6cAWoB/noXsEEgayXQB7zLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvEFuuCPYF0zHToIcK026dQE2Kewo1jsOxVsXWgcrw51+1KPtv
	2/caYqW5/TdPwbkZpBLp+LPLoH4P733i7z+3z5xfVtfV27RE+9c5g3alw1Jz0wVXSg==
X-Gm-Gg: Acq92OHoIwcfw63n7L8bE+wrfm6TYnjFEwW4/dxTIh7kXHJnXaLSl1afF00ceyX+k1H
	WN5WzYeE537Fw7w1w258IX6iYxr2JhAKNo4nTwjDHTY6h/vV1thxmnApT11GHHHaPe5bXOMgCWT
	+Ryv+eP7zqf3m7MlAS0zihYY8hi5K8fFoYKDE3gCgRMvkCb1IZMv6yKgfxY0KMF45VH6Shprv1r
	49AbjXmRtTWGJ5styffhVYRkYALWvc8KRzvQ/rJDHnV6Nn/x8uQ4EaHrqoAnvMZgzowtsB45FWN
	lGEoiWALH4SohTDQkKmC1VBZbhdCPBh54CW/u4RoQzTmJqum/kXZ5rJDN8dWlR3SfoRMrohgpXk
	ElJluv2B0S934+3ECLb3mPSM9GrLMC1Xi7YJe72qojRcMLsJmqbYOoYIT6SPV4CZNtwJOfdBc53
	lOJt3d0zzrJvvVaCaLOvqmyPl7unNOwBp3JKxlXzYksx026K753YahNx1bk4IVOWdPsHvPmA==
X-Received: by 2002:a17:903:37d0:b0:2b7:b03d:9dce with SMTP id d9443c01a7336-2bdb041671dmr3410875ad.18.1779123977360;
        Mon, 18 May 2026 10:06:17 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695a09e95esm4591161a91.9.2026.05.18.10.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 10:06:16 -0700 (PDT)
Date: Mon, 18 May 2026 17:06:12 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: David Matlack <dmatlack@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 02/16] iommu: Implement IOMMU Live update FLB callbacks
Message-ID: <agtEPKMDWV7hh5Ce@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-3-skhawaja@google.com>
 <afUe71D8JfgmA0BG@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <afUe71D8JfgmA0BG@google.com>

On Fri, May 01, 2026 at 09:45:19PM +0000, David Matlack wrote:
>On 2026-04-27 05:56 PM, Samiullah Khawaja wrote:
>> Add liveupdate FLB for IOMMU state preservation. Use KHO preserve memory
>> alloc/free helper functions to allocate memory for the IOMMU Live update
>> FLB object and the serialization structs for device, domain and iommu.
>>
>> During retrieve, walk through the preserved obj array headers and
>> restore each folio. Also recreate the FLB obj.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>
>> +static void *iommu_liveupdate_restore_array(u64 array_phys)
>> +{
>> +	struct iommu_array_hdr_ser *array_hdr;
>> +	void *vaddr = array_phys ? phys_to_virt(array_phys) : NULL;
>> +
>> +	while (array_phys) {
>> +		/*
>> +		 * Failure to restore preserved IOMMU state is considered fatal.
>> +		 *
>> +		 * This is because the IOMMU translations for preserved IOMMUs
>> +		 * were kept enabled in the previous kernel and the preserved
>> +		 * devices have their IOMMU domains still present. Not being
>> +		 * able to restore means that the memory mapped into preserved
>> +		 * domains might be already corrupted by the preserved devices.
>> +		 *
>> +		 * There is no way to confirm the integrity of the memory that
>> +		 * was mapped. BUG_ON is the safest option at this point.
>> +		 */
>> +		BUG_ON(!kho_restore_folio(array_phys));
>> +		array_hdr = phys_to_virt(array_phys);
>> +		array_phys = array_hdr->next_array_phys;
>> +	}
>> +
>> +	return vaddr;
>> +}
>
>> +static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
>> +{
>> +	struct iommu_flb_obj *obj;
>> +	struct iommu_flb_ser *ser;
>> +
>> +	obj = kzalloc_obj(*obj, GFP_KERNEL);
>> +	if (!obj)
>> +		return -ENOMEM;
>
>Should this be considered fatal for the same reason
>iommu_liveupdate_restore_array() is considered fatal? If anything in
>iommu_liveupdate_flb_retrieve() fails then the risk of corruption as
>described in iommu_liveupdate_restore_array() is possible.

This one is a little tricky, it is not really fatal as it doesn't
represent a corruption or unexpected behaviour. I think if this fails
the probe of IOMMUs should fail and with a rescan, the user can retry
this.

I will handle this properly in the caller to make sure a retry can
happen for these.
>
>> +
>> +	/* Data must be present and valid from the previous kernel */
>> +	BUG_ON(!kho_restore_folio(argp->data));
>> +
>> +	mutex_init(&obj->lock);
>> +	ser = phys_to_virt(argp->data);
>> +	obj->ser = ser;
>> +
>> +	obj->curr_domain_array = iommu_liveupdate_restore_array(ser->iommu_domain_array_phys);
>> +	obj->curr_device_array = iommu_liveupdate_restore_array(ser->device_array_phys);
>> +	obj->curr_iommu_array = iommu_liveupdate_restore_array(ser->iommu_array_phys);
>> +	argp->obj = obj;
>> +	return 0;
>> +}
>> +
>> +static struct liveupdate_flb_ops iommu_flb_ops = {
>> +	.preserve = iommu_liveupdate_flb_preserve,
>> +	.unpreserve = iommu_liveupdate_flb_unpreserve,
>> +	.finish = iommu_liveupdate_flb_finish,
>> +	.retrieve = iommu_liveupdate_flb_retrieve,
>
>nit: I think it's helpful to put these in the order they are expected to
>be called.
>
>  .preserve = iommu_liveupdate_flb_preserve,
>  .unpreserve = iommu_liveupdate_flb_unpreserve,
>  .retrieve = iommu_liveupdate_flb_retrieve,
>  .finish = iommu_liveupdate_flb_finish,

Agreed. I will do this.
>
>> diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
>> new file mode 100644
>> index 000000000000..37b967820f14
>
>> +enum iommu_type_ser {
>> +	IOMMU_INVALID,
>> +};
>
>Please document this enum.

Agreed. Will do.
>
>> +
>> +/**
>> + * struct iommu_hdr_ser - Common header for all serialized IOMMU objects
>> + * @ref_count: Reference count for the object
>> + * @deleted: Flag indicating if the object is deleted
>> + * @incoming: Flag indicating if the object was preserved in previous kernel
>> + */
>> +struct iommu_hdr_ser {
>> +	u32 ref_count;
>> +	u32 deleted:1;
>> +	u32 incoming:1;
>
>Are C bitfields safe to use in Live Update ABI?
>
>> +} __packed;
>
>> +/**
>> + * struct iommu_flb_obj - FLB object allocated in current kernel pointing to
>> + *			  preserved state in FLB
>> + * @lock: Mutex protecting the object
>> + * @ser: Pointer to the serialized state in FLB
>> + * @curr_iommu_array: Pointer to the current array of IOMMU instances
>> + * @curr_domain_array: Pointer to the current array of domains
>> + * @curr_device_array: Pointer to the current array of devices
>> + */
>> +struct iommu_flb_obj {
>> +	/* @lock: Protects the serialized objects during concurrent preservation */
>> +	struct mutex lock;
>> +	struct iommu_flb_ser *ser;
>> +
>> +	struct iommu_hw_array_ser *curr_iommu_array;
>> +	struct iommu_domain_array_ser *curr_domain_array;
>> +	struct iommu_device_array_ser *curr_device_array;
>> +} __packed;
>
>This struct is not ABI so it should not be __packed nor defined in this
>file. I haven't read the whole series yet but this definition can
>probably go in drivers/iommu/liveupdate.c.

Agreed on both points. I think it can be moved to liveupdate.c. Will do.

Thanks,
Sami
