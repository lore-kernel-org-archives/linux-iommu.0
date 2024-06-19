Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7004D15099A
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 16:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812936; cv=none; b=GNN3sjpjwmpTXHazKxa4+J7uIqqaMk4bfwcKOvhqknnD/hyueuc/7/u1VqNxX8v2GLUel6pBU32hAAzV9fj4s01JDZFAG1F/+jiBjBmKUMmQo2Lff1VNdSsFfG0hIfqIKqs2fBox0VjZfad+OOUrQZcapmHKPSrJGlBpUoZcAq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812936; c=relaxed/simple;
	bh=VfLQUOIfOc5Klr84E5HyQ0hKPEVMSLE8UcsP3wSjOyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVPG36oeul+LC2BcQccC4m89mTrgBDInq5/aE2Tv5g64fkhGCdWL1OKM1EW/EQVcDX/scu5/LWEmF/kOiB5E1YySViBT3QSlXqWNMbKbLGvtYZBslCy1ZluOxdeku0jgAmLwORNeHPIqIbvgiJB+kH9cgJd+ZG3XKjpkwrLZWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=le1R3wUF; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="le1R3wUF"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7954dcf3158so391589285a.3
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718812933; x=1719417733; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RMG38VvaZOpUh70iiE4L/zQoQv1cHzQG+9/P79OpBlo=;
        b=le1R3wUFHRrC90IOPoOcavzIMoe3BgzKRp8kTtrUiWnL8V1fe02yNV6H1nBE70uf8i
         L44f88AEDYvrM9Ra4fCCLdlOU2zSlkApWOzrlpNMA0rg9SakKGcgdo9WTuF/YpP052Tv
         CHFFm7o1nEUZzqIFzoiOZ46nLvc3xG1jfCd50w3aorPNl63Lmo3fJQWJL23T+fuXOhU7
         admBPSh4BtA2evxcqsPpNzNORXvK5jrEoYQYAgsBnbAbEsscJ48Rz2oOPHqZpO2dsF+M
         Gzl4pBVNbzxIjSjcnldWF9QXl3MKrr1JmS6Jw/8WdrQ0sq0xALaIpqvXUa7o5nU7L54M
         rWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718812933; x=1719417733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RMG38VvaZOpUh70iiE4L/zQoQv1cHzQG+9/P79OpBlo=;
        b=MV0Tuq0hWvqM2CU6ZgjhATJ4hic998L8kTyBJ/usi4tFW0xJf1tUEeFtHrt+4l/GY+
         5zk/XXScaI/LUTKxh9CS5LVyJ0H9YgNscy/Jgj1IQmH/W3ewAkDEu+cSc7Ze8Tdf80Qp
         iLDMAA3DoptRFZjTvy7hE+EI7EAckOR4+R5B/ocj69hyT+vLzd31a2WbaSs1IInEG4F2
         STQNs5acAeq2zo+NogB5Efb3v6sOeRmz+BJCSciw37YN5bAPmD2RsZpj1JRsTD+3+v3j
         a2jLvbahU8bMB8swoNdht9Xs6Ny236cHflhfbGJc+wIaUkt6v8IyJhozEMtiw52fXaTp
         9PLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNKC0xhXZJHvmiuwOPU02FQR6tmPsweZrtrkABfWAm9QjFUybKNpuG1vQbtOWVpzhudzOoq2iurtma6JS6Urxglm33J90=
X-Gm-Message-State: AOJu0YzQlpzPnpKzDpnHpGTIcj2jHSfY6SIP59S7PVmWlLf1fG/DPL7l
	Jys0v+tokhlVEiIX0v5Cvz88axnEZZs6l2ogUf00IAo2cLDHuZl4xxIvlqTWB/4=
X-Google-Smtp-Source: AGHT+IFAZu+7EYaEUAG4cCP50G/RTGHBQc4N5S+TCXNrJ9Eqk9VbuFGXZo9VdN3NMZQe71v4p6Tf7w==
X-Received: by 2002:a05:620a:459e:b0:797:a72e:6793 with SMTP id af79cd13be357-79bb3e1176emr329833485a.8.1718812932938;
        Wed, 19 Jun 2024 09:02:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe69dffsm618459085a.126.2024.06.19.09.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 09:02:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJxlD-0051Ca-Va;
	Wed, 19 Jun 2024 13:02:11 -0300
Date: Wed, 19 Jun 2024 13:02:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, kevin.tian@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: Re: [RFC PATCH v2 07/10] iommu/riscv: support nested iommu for
 creating domains owned by userspace
Message-ID: <20240619160211.GO1091770@ziepe.ca>
References: <20240614142156.29420-1-zong.li@sifive.com>
 <20240614142156.29420-8-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614142156.29420-8-zong.li@sifive.com>

On Fri, Jun 14, 2024 at 10:21:53PM +0800, Zong Li wrote:
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
>  drivers/iommu/riscv/iommu.c  | 236 ++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/iommufd.h |  17 +++
>  2 files changed, 252 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 2130106e421f..410b236e9b24 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -846,6 +846,8 @@ static int riscv_iommu_iodir_set_mode(struct riscv_iommu_device *iommu,
>  
>  /* This struct contains protection domain specific IOMMU driver data. */
>  struct riscv_iommu_domain {
> +	struct riscv_iommu_domain *s2;
> +	struct riscv_iommu_device *iommu;

IMHO you should create a riscv_iommu_domain_nested and not put these
here, like ARM did.

The kernel can't change the nested domain so it can't recieve and
distribute invalidations.

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
> +	/*
> +	 * Add bond to the new domain's list, but don't unlink in current domain.
> +	 * We need to flush entries in stage-2 page table by iterating the list.
> +	 */
> +	if (riscv_iommu_bond_link(riscv_domain, dev))
> +		return -ENOMEM;
> +
> +	riscv_iommu_iotlb_inval(riscv_domain, 0, ULONG_MAX);
> +	info->dc_user.ta |= RISCV_IOMMU_PC_TA_V;

Seems odd??

> +	riscv_iommu_iodir_update(iommu, dev, &info->dc_user);

This will be need some updating to allow changes that don't toggle
V=0, like in arm.

> +	info->domain = riscv_domain;
> +
> +	return 0;
> +}
> +
> +static void riscv_iommu_domain_free_nested(struct iommu_domain *domain)
> +{
> +	struct riscv_iommu_domain *riscv_domain = iommu_domain_to_riscv(domain);
> +	struct riscv_iommu_bond *bond;
> +
> +	/* Unlink bond in s2 domain, because we link bond both on s1 and s2 domain */
> +	list_for_each_entry_rcu(bond, &riscv_domain->s2->bonds, list)
> +		riscv_iommu_bond_unlink(riscv_domain->s2, bond->dev);
> +
> +	if ((int)riscv_domain->pscid > 0)
> +		ida_free(&riscv_iommu_pscids, riscv_domain->pscid);
> +
> +	kfree(riscv_domain);
> +}
> +
> +static const struct iommu_domain_ops riscv_iommu_nested_domain_ops = {
> +	.attach_dev	= riscv_iommu_attach_dev_nested,
> +	.free		= riscv_iommu_domain_free_nested,
> +};
> +
> +static int
> +riscv_iommu_get_dc_user(struct device *dev, struct iommu_hwpt_riscv_iommu *user_arg)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> +	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
> +	struct riscv_iommu_dc dc;
> +	struct riscv_iommu_fq_record event;
> +	u64 dc_len = sizeof(struct riscv_iommu_dc) >>
> +		     (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_MSI_FLAT));
> +	u64 event_len = sizeof(struct riscv_iommu_fq_record);
> +	void __user *event_user = NULL;
> +
> +	for (int i = 0; i < fwspec->num_ids; i++) {
> +		event.hdr =
> +			FIELD_PREP(RISCV_IOMMU_FQ_HDR_CAUSE, RISCV_IOMMU_FQ_CAUSE_DDT_INVALID) |
> +			FIELD_PREP(RISCV_IOMMU_FQ_HDR_DID, fwspec->ids[i]);
> +
> +		/* Sanity check DC of stage-1 from user data */
> +		if (!user_arg->out_event_uptr || user_arg->event_len != event_len)
> +			return -EINVAL;

This is not extensible, see below about just inlining it.

> +		event_user = u64_to_user_ptr(user_arg->out_event_uptr);
> +
> +		if (!user_arg->dc_uptr || user_arg->dc_len != dc_len)
> +			return -EINVAL;
> +
> +		if (copy_from_user(&dc, u64_to_user_ptr(user_arg->dc_uptr), dc_len))
> +			return -EFAULT;
> +
> +		if (!(dc.tc & RISCV_IOMMU_DDTE_V)) {
> +			dev_dbg(dev, "Invalid DDT from user data\n");
> +			if (copy_to_user(event_user, &event, event_len))
> +				return -EFAULT;
> +		}

On ARM we are going to support non-valid STEs. It should put the the
translation into blocking and ideally emulate translation failure
events.

> +
> +		if (!dc.fsc || dc.iohgatp) {
> +			dev_dbg(dev, "Wrong page table from user data\n");
> +			if (copy_to_user(event_user, &event, event_len))
> +				return -EFAULT;
> +		}
> +
> +		/* Save DC of stage-1 from user data */
> +		memcpy(&info->dc_user,
> +		       riscv_iommu_get_dc(iommu, fwspec->ids[i]),

This does not seem right, the fwspec shouldn't be part of domain
allocation, even arguably for nesting. The nesting domain should
represent the user_dc only. Any customization of kernel controlled bits
should be done during attach only, nor do I really understand why this
is looping over all the fwspecs but only memcpying the last one..

> +		       sizeof(struct riscv_iommu_dc));
> +		info->dc_user.fsc = dc.fsc;
> +	}
> +
> +	return 0;
> +}
> +
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
> +	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57) {
> +		va_bits = 57;
> +	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48) {
> +		va_bits = 48;
> +	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39) {
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
> +	s1_domain->iommu = iommu;
> +	s1_domain->domain.type = IOMMU_DOMAIN_NESTED;
> +	s1_domain->domain.ops = &riscv_iommu_nested_domain_ops;
> +	s1_domain->domain.pgsize_bitmap = SZ_4K;
> +	s1_domain->domain.geometry.aperture_start = 0;
> +	s1_domain->domain.geometry.aperture_end = DMA_BIT_MASK(va_bits - 1);
> +	s1_domain->domain.geometry.force_aperture = true;

There is no geometry or page size of nesting domains.

> +
> +	return &s1_domain->domain;
> +}
> +
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
> +
> +	if (user_data)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* domain_alloc_user op needs to be fully initialized */
> +	domain = iommu_domain_alloc(dev->bus);

Please organize your driver to avoid calling this core function
through a pointer and return the correct type from the start so you
don't have to cast.

> +	if (!domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/*
> +	 * We assume that nest-parent or g-stage only will come here
> +	 * TODO: Shadow page table doesn't be supported now.
> +	 *       We currently can't distinguish g-stage and shadow
> +	 *       page table here. Shadow page table shouldn't be
> +	 *       put at stage-2.
> +	 */
> +	riscv_domain = iommu_domain_to_riscv(domain);
> +
> +	/* pgd_root may be allocated in .domain_alloc_paging */
> +	if (riscv_domain->pgd_root)
> +		iommu_free_page(riscv_domain->pgd_root);

And don't do stuff like this, if domain_alloc didn't do the right
stuff then reorganize it so that it does. Most likely pass in a flag
that you are allocating the nest so it can setup properly if it is
only a small change like this.

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

Do we really want this to be a pointer? ARM just inlined it in the
struct, why not do that?

> +	__aligned_u64 event_len;
> +	__aligned_u64 out_event_uptr;
> +};

Similar here too, why not just inline the response memory?

Jason
