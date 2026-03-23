Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B023BC681
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288965; cv=none; b=JXjiukHLokGA3VgZrVX1RQT9Emq+KCpiieeNc2wZwGjyU+aZ9sVBPZeC9UJ7rxz9MilMRBbH1NeLN6eUpq5cBRYg9lAGmG7ylj8Y66iq78dAH5BZOyZ9hkI8OJvTkErqG/IgJLy8NuTyuFwQMPmBNwrAPKZmYYzgSx3gqT1JR2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288965; c=relaxed/simple;
	bh=hvXiGksy7d1b8loTtSIz0F6eW7fiR0+NsCsLlCWuRqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXnClZ8vNFnksXamwihTypRwDnENO/IewQeYtghSGfXh7BQ+QW4hKuwrboMwyH3rzu4B1tGo1x7cuUvepMbfq+3INwBL1plx79fnqpY4m0bIzWkbBfRBcZ8F0KiWOcXx2kUiP5MOpTkZKLQvTPrZ+F6JnNr87zCdUYjMXL1rS68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kkxWPXrT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kkxWPXrT"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b04c9e3eb7so11845ad.0
        for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 11:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774288961; x=1774893761; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jKTCU86A+QPluB3oZAAbNMloBh2V5DRJLQjLnNlG9Sk=;
        b=kkxWPXrTiYC2GSW4rmQiCQGprMxJUC3Xy/lxMGFwRc4k+mYbbkfz3+NflZlS3A7OhN
         NdHeSoqYG1z5L/PNvw/I3pYdOqDXp3lVZOLckLoAQsF9LT2D/Qe0lBLtqkuW6YIW6pQV
         pyV6od3QKaoQks3rF2Gg2LGk0bQB7HfizAm+70G1/W9cR/W6Be7Mb40aeQj9EImrlOVa
         5Ex59p33tr+aAJLZkE5HACHPopOefXaSkroB5i0ZdKmzPB9R40ZQdvyUFUwAxCdVhWTe
         vPb8P5zPmcGQXYJEDKztcciMrdsIIHfw0oLoWzupIqSdSu++Rg0hJIXNPnAdEZzEwy/T
         ZUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774288961; x=1774893761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jKTCU86A+QPluB3oZAAbNMloBh2V5DRJLQjLnNlG9Sk=;
        b=J2xTtokKsjTOfV1iW3O/Vwvqb7qQfQ7B73LGbUjf2kHimEqTcZEDqbusH5t5eIi+EL
         SvzupraIt6EVcL+cXYHWDDh5dC6vyVzditn+JnMyDmrYKVaJtvU1d8Ucnw0vn01i40vS
         CdJKOfOnN52/jACQRkJW+Q3IsvfRYoeGMeoUqnq0/FRKTOHR9dKs0NVtQxYqlj+eYJ0o
         A/yq57p3o0x188ByFSv5bZY1EWFZzNEHVUMbTE1ayBzrbBiEewTHki+s1r3taWKE6vX3
         E9IPFgakc8O62IF8LQFhcSdUJhEWP5oRCwn05EAHi1xOt/+INjFQbnZlfUekPv4oKSUa
         lqZA==
X-Forwarded-Encrypted: i=1; AJvYcCXZqklLPTLHbiTOdJHf7c9eVbLdD7pUQq61sBklHJb6N+rHtrH8UmZbhuSwyZcas+YTRoLsAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrW2lJKCfcKYpnm0WJKrCUsrd+PsCMVAepSPVC8EAymjE05u4d
	wXVq+rUeV1R1J7wrXFVvN5ErK3HgGuhkHg74RIH4MauewSB86Qg0W9LWdf/BYk8B+w==
X-Gm-Gg: ATEYQzy41GHtgFbaS7xeSECTb4udlnrUcNAkZrG+yiwNx07HRj35EDHohzmJo7EJfoc
	Od5PP+4qtSdBM/ib59pH/pRJM/dG3+NUg+RcoPCZiVwlmr4MU8N1ZYp5FZJeDhIm7kqbYBWBwm3
	dVKYz1/NG3mCrKSvahTzdqazK7MKA7jmdYqE4Q/Ay0wJkJru1mVn4mrQiBCXXG9Jkl6xGaVyBjo
	6jADTvimQqIJ5mGToALsH8aw0kfhEuTLQg7wxBU3rk/R6Fbmp0dSbUbf/1KvJmMscz5WRgqZG4G
	3GD16zvdS/iwtxysqUrPp3kz/pUlHtr7BLTZj6hMBU/A/wWh8tGw97gCsal2i+BGwNLSvxomBuF
	yloaONw6FcRAcu8+9kFHiAop/eCzpTojGrJSjypqKw9LtOGfTN6gdPtaxbq4msOBAThebVZrc/I
	11O9nuTN01ZnK0XwZcaiXGSg5ij5DnCMYTYGQiOybgVGZ4ZkRoGAJGR4IuboADBe4YYb5pQ3/g
X-Received: by 2002:a17:902:f68d:b0:2ae:4808:bd99 with SMTP id d9443c01a7336-2b0a53e730fmr297505ad.2.1774288960921;
        Mon, 23 Mar 2026 11:02:40 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083679867sm138118055ad.65.2026.03.23.11.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:02:40 -0700 (PDT)
Date: Mon, 23 Mar 2026 18:02:36 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 08/14] iommu: Restore and reattach preserved domains to
 devices
Message-ID: <acFu5vTAcKULIYOt@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-9-skhawaja@google.com>
 <acBmNM_NIVamBrpm@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <acBmNM_NIVamBrpm@google.com>

On Sun, Mar 22, 2026 at 09:59:16PM +0000, Pranjal Shrivastava wrote:
>On Tue, Feb 03, 2026 at 10:09:42PM +0000, Samiullah Khawaja wrote:
>> Restore the preserved domains by restoring the page tables using restore
>> IOMMU domain op. Reattach the preserved domain to the device during
>> default domain setup. While attaching, reuse the domain ID that was used
>> in the previous kernel. The context entry setup is not needed as that is
>> preserved during liveupdate.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>> ---
>>  drivers/iommu/intel/iommu.c  | 40 ++++++++++++++++++------------
>>  drivers/iommu/intel/iommu.h  |  3 ++-
>>  drivers/iommu/intel/nested.c |  2 +-
>>  drivers/iommu/iommu.c        | 47 ++++++++++++++++++++++++++++++++++--
>>  drivers/iommu/liveupdate.c   | 31 ++++++++++++++++++++++++
>>  include/linux/iommu-lu.h     |  8 ++++++
>>  6 files changed, 112 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 8acb7f8a7627..83faad53f247 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -1029,7 +1029,8 @@ static bool first_level_by_default(struct intel_iommu *iommu)
>>  	return true;
>>  }
>>
>> -int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
>> +int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu,
>> +			int restore_did)
>>  {
>>  	struct iommu_domain_info *info, *curr;
>>  	int num, ret = -ENOSPC;
>> @@ -1049,8 +1050,11 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
>>  		return 0;
>>  	}
>>
>> -	num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
>> -			      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
>> +	if (restore_did >= 0)
>
>I just looked at the code and saw the comment for IDA_START_DID [1] and
>I realized we probably shouldn't allow domain_ids 0 or 1 here, as they
>are reserved?
>
>It seems that DID 0 essentially acts as a blocking domain, and DID 1 is
>used for identity / FLPT_DEFAULT_DID (comparing it to S1DSS in Arm)
>
>If a corrupted KHO image passes restore_did = 0, this check evaluates to
>true. The driver will bypass the IDA, assign DID 0, and program it into
>the context entries. Wouldn't we accidentally attach the device to a
>blocking mode where the VT-d hardware just silently drops/faults all DMA?
>
>Should this check be:
>if (restore_did >= IDA_START_DID) ?

Agreed. Will update.
>
>> +		num = restore_did;
>> +	else
>> +		num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
>> +				      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
>>  	if (num < 0) {
>>  		pr_err("%s: No free domain ids\n", iommu->name);
>>  		goto err_unlock;
>> @@ -1321,10 +1325,14 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>>  {
>>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>>  	struct intel_iommu *iommu = info->iommu;
>> +	struct device_ser *device_ser = NULL;
>>  	unsigned long flags;
>>  	int ret;
>>
>> -	ret = domain_attach_iommu(domain, iommu);
>> +	device_ser = dev_iommu_restored_state(dev);
>> +
>> +	ret = domain_attach_iommu(domain, iommu,
>> +				  dev_iommu_restore_did(dev, &domain->domain));
>>  	if (ret)
>>  		return ret;
>>
>> @@ -1337,16 +1345,18 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>
>[ ------- >8 snip -------- ]
>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index c0632cb5b570..8103b5372364 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/errno.h>
>>  #include <linux/host1x_context_bus.h>
>>  #include <linux/iommu.h>
>> +#include <linux/iommu-lu.h>
>>  #include <linux/iommufd.h>
>>  #include <linux/idr.h>
>>  #include <linux/err.h>
>> @@ -489,6 +490,10 @@ static int iommu_init_device(struct device *dev)
>>  		goto err_free;
>>  	}
>>
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	dev->iommu->device_ser = iommu_get_device_preserved_data(dev);
>> +#endif
>> +
>>  	iommu_dev = ops->probe_device(dev);
>>  	if (IS_ERR(iommu_dev)) {
>>  		ret = PTR_ERR(iommu_dev);
>> @@ -2149,6 +2154,13 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>>  	ret = domain->ops->attach_dev(domain, dev, old);
>>  	if (ret)
>>  		return ret;
>> +
>> +#ifdef CONFIG_IOMMU_LIVEUPDATE
>> +	/* The associated state can be unset once restored. */
>> +	if (dev_iommu_restored_state(dev))
>> +		WRITE_ONCE(dev->iommu->device_ser, NULL);
>> +#endif
>> +
>>  	dev->iommu->attach_deferred = 0;
>>  	trace_attach_device_to_domain(dev);
>>  	return 0;
>> @@ -3061,6 +3073,34 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
>>  }
>>  EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
>>
>> +static struct iommu_domain *__iommu_group_maybe_restore_domain(struct iommu_group *group)
>> +{
>> +	struct device_ser *device_ser;
>> +	struct iommu_domain *domain;
>> +	struct device *dev;
>> +
>> +	dev = iommu_group_first_dev(group);
>> +	if (!dev_is_pci(dev))
>> +		return NULL;
>> +
>> +	device_ser = dev_iommu_restored_state(dev);
>> +	if (!device_ser)
>> +		return NULL;
>> +
>> +	domain = iommu_restore_domain(dev, device_ser);
>> +	if (WARN_ON(IS_ERR(domain)))
>> +		return NULL;
>> +
>> +	/*
>> +	 * The group is owned by the entity (a preserved iommufd) that provided
>> +	 * this token in the previous kernel. It will be used to reclaim it
>> +	 * later.
>> +	 */
>> +	group->owner = (void *)device_ser->token;
>
>Umm.. this is a nak as it looks troubled for the following reasons:
>
>1. The group->owner and group->owner_cnt are being updated directly
>without holding group->mutex. We shouldn't bypass the lock as this
>violates the group's concurrency protections and can cause APIs like
>iommu_device_claim_dma_owner[2] to race or fail.

This function is called with group->mutex held during the setup of
default domain during device iommu probe. So this should fine. I will
add a lockdep to make it clear.
>
>2. Stuff like this shouldn't be open-coded. Presumably, this was
>open-coded because the standard API (__iommu_take_dma_ownership) forces
>the IOMMU group into a blocking_domain, which conflicts with the fact
>that we just restored an active paging domain?
>
>I think we should introduce a proper helper that acquires the lock,
>safely sets the opaque owner, and manages the domain state without
>forcing it into a blocking domain? Please note that the helper shouldn't
>be exposed / exported, we wouldn't want any abusive calls to claim owner
>without attaching to a blocked domain.

The init/restore of owner fields in group should only be done during
restore when restoring the iommu domain for the group with mutex already
held. Adding a separate helper might allow setting it up at some other
place even in the core, so want to avoid that.
>
>3. Please note that owner is an opaque "pointer" but we set it to a u64.
>Setting an opaque void *owner directly to a user-controlled u64 token is
>dangerous. If a malicious or unlucky userspace provides a token value
>that happens to perfectly match a valid kernel pointer (e.g. another
>subsystem's cookie), we'll have an aliasing collision.
>
>If that subsystem subsequently calls iommu_device_claim_dma_owner(), the
>if (group->owner == owner) check will falsely pass, incorrectly granting
>DMA ownership and breaking device isolation.
>
>I understand we can't restore the original owner pointer because the
>original iommufd file/context from the previous kernel no longer exists.
>However, to avoid aliasing could we dynamically allocate a small wrapper
>(e.g., struct iommu_lu_owner { u64 token; }) and set group->owner to the
>uniquely allocated pointer?

Agreed. Will update.
>
>4. In the full RFC [3], we seem to be "transferring" the ownership but
>here we seem to set the owner_cnt = 1 what if it was > 1 earlier? The
>iommu_device_release_dma_owner seems to handle multiple release calls
>well so this shouldn't lead to crashes but the "owning" entity could use
>this count for some book keeping.. it'd be nice if we could have a
>proper restore_owner API / helper here.

This is being done during iommu probe of the device when the default
domain is being set on the group, so group will not have any existing
owner. I will add a WARN for this. The transfer of ownership will happen
after the iommufd is restored. Also note that once initialized here, the
device/group will not be owned by any other driver or iommufd until the
ownership transfer is done.
>
>> +	group->owner_cnt = 1;
>> +	return domain;
>> +}
>> +
>>  /**
>>   * iommu_setup_default_domain - Set the default_domain for the group
>>   * @group: Group to change
>> @@ -3075,8 +3115,8 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>>  				      int target_type)
>>  {
>>  	struct iommu_domain *old_dom = group->default_domain;
>> +	struct iommu_domain *dom, *restored_domain;
>>  	struct group_device *gdev;
>> -	struct iommu_domain *dom;
>>  	bool direct_failed;
>>  	int req_type;
>>  	int ret;
>> @@ -3120,6 +3160,9 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>>  	/* We must set default_domain early for __iommu_device_set_domain */
>>  	group->default_domain = dom;
>>  	if (!group->domain) {
>> +		restored_domain = __iommu_group_maybe_restore_domain(group);
>> +		if (!restored_domain)
>> +			restored_domain = dom;
>>  		/*
>>  		 * Drivers are not allowed to fail the first domain attach.
>>  		 * The only way to recover from this is to fail attaching the
>> @@ -3127,7 +3170,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>>  		 * in group->default_domain so it is freed after.
>>  		 */
>>  		ret = __iommu_group_set_domain_internal(
>> -			group, dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
>> +			group, restored_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED);
>>  		if (WARN_ON(ret))
>>  			goto out_free_old;
>>  	} else {
>> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
>> index 83eb609b3fd7..6b211436ad25 100644
>> --- a/drivers/iommu/liveupdate.c
>> +++ b/drivers/iommu/liveupdate.c
>> @@ -501,3 +501,34 @@ void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
>>
>>  	iommu_unpreserve_locked(iommu->iommu_dev);
>>  }
>> +
>> +struct iommu_domain *iommu_restore_domain(struct device *dev, struct device_ser *ser)
>> +{
>> +	struct iommu_domain_ser *domain_ser;
>> +	struct iommu_lu_flb_obj *flb_obj;
>> +	struct iommu_domain *domain;
>> +	int ret;
>> +
>> +	domain_ser = __va(ser->domain_iommu_ser.domain_phys);
>> +
>> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>> +	guard(mutex)(&flb_obj->lock);
>> +	if (domain_ser->restored_domain)
>> +		return domain_ser->restored_domain;
>> +
>> +	domain_ser->obj.incoming =  true;
>> +	domain = iommu_paging_domain_alloc(dev);
>> +	if (IS_ERR(domain))
>> +		return domain;
>> +
>> +	ret = domain->ops->restore(domain, domain_ser);
>> +	if (ret)
>
>did we miss free-ing domain here?

Yes, Ankit pointed out same. Will update this.
>
>> +		return ERR_PTR(ret);
>> +
>> +	domain->preserved_state = domain_ser;
>> +	domain_ser->restored_domain = domain;
>> +	return domain;
>> +}
>> diff --git a/include/linux/iommu-lu.h b/include/linux/iommu-lu.h
>> index 48c07514a776..4879abaf83d3 100644
>> --- a/include/linux/iommu-lu.h
>> +++ b/include/linux/iommu-lu.h
>> @@ -65,6 +65,8 @@ static inline int dev_iommu_restore_did(struct device *dev, struct iommu_domain
>>  	return -1;
>>  }
>>
>> +struct iommu_domain *iommu_restore_domain(struct device *dev,
>> +					  struct device_ser *ser);
>>  int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
>>  				    void *arg);
>>  struct device_ser *iommu_get_device_preserved_data(struct device *dev);
>> @@ -95,6 +97,12 @@ static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
>>  	return NULL;
>>  }
>>
>> +static inline struct iommu_domain *iommu_restore_domain(struct device *dev,
>> +							struct device_ser *ser)
>> +{
>> +	return NULL;
>> +}
>> +
>>  static inline int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn, void *arg)
>>  {
>>  	return -EOPNOTSUPP;
>
>Thanks,
>Praan
>
>[1] https://elixir.bootlin.com/linux/v7.0-rc4/source/drivers/iommu/intel/iommu.h#L795
>[2] https://elixir.bootlin.com/linux/v7.0-rc4/source/drivers/iommu/iommu.c#L3367

Thanks,
Sami
