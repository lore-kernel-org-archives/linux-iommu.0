Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85272161310
	for <iommu@lists.linux.dev>; Tue,  7 May 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715094434; cv=none; b=t5VmeJMSBsMFUkdKJ2EhRXyfL0eodguwRvJ4EOusatLQQYN5oOihMpb5lmfzmhCxTCn0dzv9X8ZPzHt7Huk4ZGDULfZf3XKElpHetWQSGwZoWBUE+XP/ul8TfGeX0fYgWlJ6TuYSWZuACHWR9dgUUe97jicSSMT5SyRH1b0Huqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715094434; c=relaxed/simple;
	bh=ahk8z/0jpn3LkrmX2tqXHOqNH9vnbY5MJKu1/Hg7gQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfoRTEndSbA2fEKJYk9zt2Zw3rysCvrLSGs0mpgaTNuRd3myLEmgU/Pv9satxqpd5dKjxyt3TjNm+Tu+odV2wqLOf76wq7DFV3BwmnU0XTLWJlgCntgPmSX7qxA3vnvPuxq7Y0bos+UODrTzN5SwlGKEoUeiPAb6baPaATrKKIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GaWhLAQw; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GaWhLAQw"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6f43ee95078so2852114b3a.1
        for <iommu@lists.linux.dev>; Tue, 07 May 2024 08:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715094432; x=1715699232; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pe8Of5L/jNNVXIjEUck527DdZ5Tlvy4B1vQ7Xsv5tFE=;
        b=GaWhLAQwqr/VKa6WgZU4GJ+A+yzTAjBmQeBPV6qty5KNL3/PhFdz5/yR3i8iMZfJu/
         vajXSPgamhojax9bm5XdCtYAxEsNi0AtwTeY3snLXbRNZvRjT9hQq9KJi8TYSzUkDptL
         7iGh10MvHkCU5mIcPuXv4ZRlIIYUPD7z4xwj5RbdRrBMOTFM913tQvKGPGN0gHy2ZQJ+
         VPB4T/LSY11Zq58Vc1mjTnsADr1FLOmdlNRDUfbT0c6SFbYrlUEEv/T6WIY1Zkr+ZmxV
         eOA589qoxTdOV/SMUygs1ldKLLF4agHZyLey2/eHsupk65b44cfreaIN5P7SkzLXFxoZ
         p0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715094432; x=1715699232;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe8Of5L/jNNVXIjEUck527DdZ5Tlvy4B1vQ7Xsv5tFE=;
        b=ppBjkh2nSWvTKwCNZ5kfNwLAaUtCLHt5EbqwVx1TnJtEBy/3VVuA01De0NInCmDyp6
         L20zMlkiz5znPNl66hZbDlep810GOP9Ec/MQ94oYibrqchB0biqm6ScMVm//d04nxMnf
         yubF1VtqU2EtXzsVH4xVAr4omNxDEUAhP1lxn8Q3T67wmXJiCueafZknqI1Ys9MYv79B
         wtI+WsGRBJQI4fmtkhnt5lqh9inzP3O4CBAp33od5/SP3m8BWc3LhKa7VlTrc9QguGDe
         clmUYPGvlexHpSHgRKQ4Rxmhk+XDKlO3bxjf0CgZZ6NYTf2wnjVBa7RvZGW2dibnQh6v
         tF6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5rwf+DN//l/yVL+cEvf79yfYTHv9DqkwCwGncJGiOnBADRLyw+NJrYrB1ogUpJrwE8cPTMvL/mq0WzUkIuyb55Pn+lE0=
X-Gm-Message-State: AOJu0Ywq5GhZmCrDsXeCO5sbQPkF9eq9glEBLBZTnasfU3u/+p/1eJgc
	79EL7IpdTAUDC7rtAl9drlMjzVbcNW1Dp6LiEqwRJRY1uQfY2l9W9lik5xm5eRA=
X-Google-Smtp-Source: AGHT+IFrE495OOsCi7iQQKWlztM4Cj8I4S7XCPDC+r9s+ES56ElmV6o6mxWM3Y/uqngKZQ/8eHs0/Q==
X-Received: by 2002:a05:6a20:9704:b0:1af:6911:7ff4 with SMTP id hr4-20020a056a20970400b001af69117ff4mr10623837pzc.7.1715094431651;
        Tue, 07 May 2024 08:07:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id q25-20020aa79839000000b006f44b2532d4sm7874961pfl.132.2024.05.07.08.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 08:07:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4MPM-0082sW-1K;
	Tue, 07 May 2024 12:07:08 -0300
Date: Tue, 7 May 2024 12:07:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH RFC RESEND 5/6] iommu/riscv: support nested iommu for
 creating domains owned by userspace
Message-ID: <20240507150708.GI901876@ziepe.ca>
References: <20240507142600.23844-1-zong.li@sifive.com>
 <20240507142600.23844-6-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507142600.23844-6-zong.li@sifive.com>

On Tue, May 07, 2024 at 10:25:59PM +0800, Zong Li wrote:
> This patch implements .domain_alloc_user operation for creating domains
> owend by userspace, e.g. through IOMMUFD. Add s2 domain for parent
> domain for second stage, s1 domain will be the first stage.
> 
> Don't remove IOMMU private data of dev in blocked domain, because it
> holds the user data of device, which is used when attaching device into
> s1 domain.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  drivers/iommu/riscv/iommu.c  | 227 ++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/iommufd.h |  17 +++
>  2 files changed, 243 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 072251f6ad85..7eda850df475 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -827,6 +827,7 @@ static int riscv_iommu_iodir_set_mode(struct riscv_iommu_device *iommu,
>  
>  /* This struct contains protection domain specific IOMMU driver data. */
>  struct riscv_iommu_domain {
> +	struct riscv_iommu_domain *s2;
>  	struct iommu_domain domain;
>  	struct list_head bonds;
>  	spinlock_t lock;		/* protect bonds list updates. */
> @@ -844,6 +845,7 @@ struct riscv_iommu_domain {
>  /* Private IOMMU data for managed devices, dev_iommu_priv_* */
>  struct riscv_iommu_info {
>  	struct riscv_iommu_domain *domain;
> +	struct riscv_iommu_dc dc_user;
>  };
>  
>  /* Linkage between an iommu_domain and attached devices. */
> @@ -1454,7 +1456,6 @@ static int riscv_iommu_attach_blocking_domain(struct iommu_domain *iommu_domain,
>  
>  	riscv_iommu_iodir_update(iommu, dev, RISCV_IOMMU_FSC_BARE, 0, 0);
>  	riscv_iommu_bond_unlink(info->domain, dev);
> -	info->domain = NULL;

Nope, whatever is going on here, this can't be correct.

Once a domain is detached the driver must drop all references to it
immediately.

>  	return 0;
>  }
> @@ -1486,6 +1487,229 @@ static struct iommu_domain riscv_iommu_identity_domain = {
>  	}
>  };
>  
> +/**
> + * Nested IOMMU operations
> + */
> +
> +static int riscv_iommu_attach_dev_nested(struct iommu_domain *domain, struct device *dev)
> +{
> +	struct riscv_iommu_domain *riscv_domain = iommu_domain_to_riscv(domain);
> +	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> +	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
> +
> +	if (riscv_domain->numa_node == NUMA_NO_NODE)
> +		riscv_domain->numa_node = dev_to_node(iommu->dev);

Why? The kernel doesn't do any memory allocation for nested domains,
does it?

> +	riscv_iommu_bond_unlink(info->domain, dev);
> +
> +	if (riscv_iommu_bond_link(riscv_domain, dev))
> +		return -ENOMEM;
> +
> +	riscv_iommu_iotlb_inval(riscv_domain, 0, ULONG_MAX);

Why? The cache tags should be in good shape before they are assigned
to the device. Wiping it on every attach is just needless flushing
that isn't useful.

> +	riscv_iommu_iodir_update(iommu, dev, info->dc_user.fsc, info->dc_user.ta,
> +				 info->dc_user.iohgatp);

This isn't ideal. Ideally the driver should make changing from S2 to
S2+S1 and back to be hitless. Wiping the valid bit as part of the
programming is not good.

As I said before, this driver probably needs the programming sequencer
from ARM.

> +	info->domain = riscv_domain;
> +
> +	return 0;
> +}
> +
> +static void riscv_iommu_domain_free_nested(struct iommu_domain *domain)
> +{
> +	struct riscv_iommu_domain *riscv_domain = iommu_domain_to_riscv(domain);
> +
> +	kfree(riscv_domain);
> +}

Doesn't the driver already have this function?
> +static struct iommu_domain *
> +riscv_iommu_domain_alloc_nested(struct device *dev,
> +				struct iommu_domain *parent,
> +				const struct iommu_user_data *user_data)
> +{
> +	struct riscv_iommu_domain *s2_domain = iommu_domain_to_riscv(parent);
> +	struct riscv_iommu_domain *s1_domain;
> +	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> +	struct iommu_hwpt_riscv_iommu arg;
> +	int ret, va_bits;
> +
> +	if (user_data->type != IOMMU_HWPT_DATA_RISCV_IOMMU)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	if (parent->type != IOMMU_DOMAIN_UNMANAGED)
> +		return ERR_PTR(-EINVAL);
> +
> +	ret = iommu_copy_struct_from_user(&arg,
> +					  user_data,
> +					  IOMMU_HWPT_DATA_RISCV_IOMMU,
> +					  out_event_uptr);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	s1_domain = kzalloc(sizeof(*s1_domain), GFP_KERNEL);
> +	if (!s1_domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	spin_lock_init(&s1_domain->lock);
> +	INIT_LIST_HEAD_RCU(&s1_domain->bonds);
> +
> +	s1_domain->pscid = ida_alloc_range(&riscv_iommu_pscids, 1,
> +					   RISCV_IOMMU_MAX_PSCID, GFP_KERNEL);
> +	if (s1_domain->pscid < 0) {
> +		iommu_free_page(s1_domain->pgd_root);
> +		kfree(s1_domain);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	/* Get device context of stage-1 from user*/
> +	ret = riscv_iommu_get_dc_user(dev, &arg);
> +	if (ret) {
> +		kfree(s1_domain);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (!iommu) {
> +		va_bits = VA_BITS;
> +	} else if (iommu->caps & RISCV_IOMMU_CAP_S_SV57) {
> +		va_bits = 57;
> +	} else if (iommu->caps & RISCV_IOMMU_CAP_S_SV48) {
> +		va_bits = 48;
> +	} else if (iommu->caps & RISCV_IOMMU_CAP_S_SV39) {
> +		va_bits = 39;
> +	} else {
> +		dev_err(dev, "cannot find supported page table mode\n");
> +		return ERR_PTR(-ENODEV);
> +	}
> +
> +	/*
> +	 * The ops->domain_alloc_user could be directly called by the iommufd core,
> +	 * instead of iommu core. So, this function need to set the default value of
> +	 * following data member:
> +	 *  - domain->pgsize_bitmap
> +	 *  - domain->geometry
> +	 *  - domain->type
> +	 *  - domain->ops
> +	 */
> +	s1_domain->s2 = s2_domain;
> +	s1_domain->domain.type = IOMMU_DOMAIN_NESTED;
> +	s1_domain->domain.ops = &riscv_iommu_nested_domain_ops;

> +	s1_domain->domain.pgsize_bitmap = SZ_4K;
> +	s1_domain->domain.geometry.aperture_start = 0;
> +	s1_domain->domain.geometry.aperture_end = DMA_BIT_MASK(va_bits - 1);
> +	s1_domain->domain.geometry.force_aperture = true;

nested domains don't support paging/map so they don't use any of
this. Don't set it. Will remove the confusing va_bit stuff.


> +static struct iommu_domain *
> +riscv_iommu_domain_alloc_user(struct device *dev, u32 flags,
> +			      struct iommu_domain *parent,
> +			      const struct iommu_user_data *user_data)
> +{
> +	struct iommu_domain *domain;
> +	struct riscv_iommu_domain *riscv_domain;
> +
> +	/* Allocate stage-1 domain if it has stage-2 parent domain */
> +	if (parent)
> +		return riscv_iommu_domain_alloc_nested(dev, parent, user_data);
> +
> +	if (flags & ~((IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
> +		return ERR_PTR(-EOPNOTSUPP);

This if should be moved up to the top and this driver does not support
diry_tracking, so don't test it.

> +	if (user_data)
> +		return ERR_PTR(-EINVAL);

Really? Don't you need to ask for the s2?

> +	/* domain_alloc_user op needs to be fully initialized */
> +	domain = iommu_domain_alloc(dev->bus);

Please no, structure your driver properly so you can call only
internal functions. This was a hack for intel only.

> +	if (!domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/*
> +	 * We assume that nest-parent or g-stage only will come here

No... That isn't right. Normal non-virtualization paging domains come
here too.

The default of this function, with an empty user_data, should be to
create the same domain as alloc_domain_paging.


> +	 * TODO: Shadow page table doesn't be supported now.
> +	 *       We currently can't distinguish g-stage and shadow
> +	 *       page table here. Shadow page table shouldn't be
> +	 *       put at stage-2.
> +	 */
> +	riscv_domain = iommu_domain_to_riscv(domain);

What is a shadow page table?

> +	/* pgd_root may be allocated in .domain_alloc_paging */
> +	if (riscv_domain->pgd_root)
> +		iommu_free_page(riscv_domain->pgd_root);

And this is gross, structure your driver right so you don't have to
undo what prior functions did.
 
> +	riscv_domain->pgd_root = iommu_alloc_pages_node(riscv_domain->numa_node,
> +							GFP_KERNEL_ACCOUNT,
> +							2);
> +	if (!riscv_domain->pgd_root)
> +		return ERR_PTR(-ENOMEM);
> +
> +	riscv_domain->gscid = ida_alloc_range(&riscv_iommu_gscids, 1,
> +					      RISCV_IOMMU_MAX_GSCID, GFP_KERNEL);
> +	if (riscv_domain->gscid < 0) {
> +		iommu_free_pages(riscv_domain->pgd_root, 2);
> +		kfree(riscv_domain);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return domain;
> +}
> +
>  static void *riscv_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
>  {
>  	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> @@ -1587,6 +1811,7 @@ static const struct iommu_ops riscv_iommu_ops = {
>  	.blocked_domain = &riscv_iommu_blocking_domain,
>  	.release_domain = &riscv_iommu_blocking_domain,
>  	.domain_alloc_paging = riscv_iommu_alloc_paging_domain,
> +	.domain_alloc_user = riscv_iommu_domain_alloc_user,
>  	.def_domain_type = riscv_iommu_device_domain_type,
>  	.device_group = riscv_iommu_device_group,
>  	.probe_device = riscv_iommu_probe_device,
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index ec9aafd7d373..e10b6e236647 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -390,14 +390,31 @@ struct iommu_hwpt_vtd_s1 {
>  	__u32 __reserved;
>  };
>  
> +/**
> + * struct iommu_hwpt_riscv_iommu - RISCV IOMMU stage-1 device context table
> + *                                 info (IOMMU_HWPT_TYPE_RISCV_IOMMU)
> + * @dc_len: Length of device context
> + * @dc_uptr: User pointer to the address of device context
> + * @event_len: Length of an event record
> + * @out_event_uptr: User pointer to the address of event record
> + */
> +struct iommu_hwpt_riscv_iommu {
> +	__aligned_u64 dc_len;
> +	__aligned_u64 dc_uptr;

So far other drivers have been inlining their "device context" in this
struct, why do you need a pointer and length?

> +	__aligned_u64 event_len;
> +	__aligned_u64 out_event_uptr;

Weird? Why?

Jason
