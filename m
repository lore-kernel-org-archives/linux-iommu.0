Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBDBC2CF
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 14:28:51 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-68730bafa6bso4476488b3a.1
        for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 07:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692800931; x=1693405731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=itMRKiGieSF3qLOynEWyH3QDNPtY5V8NHif54viz2+E=;
        b=Y661EC5Ow9DhzwaoHcE7TXGucck9zWo2iwhjuWUd+DvCiQHxkUTiPRN9iz5RZ1EqNP
         gmf1X8wdmAnpF3bPzSc+I94LFm23ib16oNubSD58k8QtctqPH/jTWdMJbjg8KzLoJJ4h
         VSFgCxC9hVQr91akBcxPrIQUwGl1ZwoQL7qA0QT2qg+3AvhCy5AHsUiSNASKYqEoBjSW
         nrf4CrtgFeNiNpLhV2AeLqm5CIRj4UHr4LOqEg2J/208Tow2M6K3nA0HF/s+mYWKjx+l
         goERHbdx6RUAxVevBJJM+LjSIiYEinlzk3lrx7KoUYusGdvu428agdXnlM0KKM9+Om1E
         ensg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692800931; x=1693405731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itMRKiGieSF3qLOynEWyH3QDNPtY5V8NHif54viz2+E=;
        b=dlHG8Gg2YotWUbQetE7tWiNFvo87GynKLtYNj6PL5qyjAxQ5EFtnJ1/Kv1PtBQY+dS
         Sk601YUQJOu4S9tSEydx5ge0dwyj6nBpUfrHAOYijJ1wAxiaZbhLW/ANJ9n6EuQ5X7FT
         xmueKqsz+LIBjIJkUVSqakhWMRHa8UDzAshHxdDMjNlaOkptoRgUAzKHzG6Q0gfX+z7Z
         qtwQmuhyyl/VGvX1ImCsDMD2AhyGUAIojjvu4sZGXTzm/wHbhUlwg4JxjHMIZ/HK9FFS
         wRay/Fg1QYkUSEWsrWXzyTutctfKKN3cQ7oWYRconoaxZFlIkU5B4/hhX1xOV2C5hYTi
         PkUw==
X-Gm-Message-State: AOJu0Yx7tIudLDaDx+Q6Cbzaq2nx18Bex86/++p28538vEgY2Pnduwh+
	iQ1zEyxK1++/Hk7i9oLXCfMNPw==
X-Google-Smtp-Source: AGHT+IFbdag2P8LKlmG58Za7SIpOyvKLfjg3LlOIn91A/dlgEMtxGxD7Mlwaq0RtT6kwxVQkNV9EkA==
X-Received: by 2002:a05:6a20:7291:b0:149:729c:d065 with SMTP id o17-20020a056a20729100b00149729cd065mr9110780pzk.14.1692800930745;
        Wed, 23 Aug 2023 07:28:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id y3-20020aa78543000000b006875a366acfsm5735108pfn.8.2023.08.23.07.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:28:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qYoqm-00HQTF-LK;
	Wed, 23 Aug 2023 11:28:48 -0300
Date: Wed, 23 Aug 2023 11:28:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH RESEND 03/10] iommu/amd: Initial SVA support for AMD IOMMU
Message-ID: <ZOYXoMPBQZ5KK9IJ@ziepe.ca>
References: <20230823140415.729050-1-vasant.hegde@amd.com>
 <20230823140415.729050-4-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823140415.729050-4-vasant.hegde@amd.com>

On Wed, Aug 23, 2023 at 02:04:08PM +0000, Vasant Hegde wrote:
> diff --git a/drivers/iommu/amd/sva.c b/drivers/iommu/amd/sva.c
> new file mode 100644
> index 000000000000..c7c7e7cb5414
> --- /dev/null
> +++ b/drivers/iommu/amd/sva.c
> @@ -0,0 +1,299 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
> + */
> +
> +#define pr_fmt(fmt)     "AMD-Vi: " fmt
> +#define dev_fmt(fmt)    pr_fmt(fmt)
> +
> +#include <linux/iommu.h>
> +#include <linux/mm_types.h>
> +#include <linux/mmu_notifier.h>
> +
> +#include "amd_iommu.h"
> +#include "../iommu-sva.h"
> +
> +struct amd_sva_pasid {
> +	u32			pasid;	/* PASID index */
> +	struct mm_struct	*mm;	/* mm_struct for the faults */
> +	struct mmu_notifier	mn;	/* mmu_notifier handle */
> +	struct list_head	dev_list; /* List of devices for this pasid */
> +};
> +
> +struct amd_sva_dev {
> +	struct device		*dev;
> +	struct iommu_dev_data	*dev_data;
> +	struct list_head	list;
> +	struct rcu_head		rcu;
> +};
> +
> +static DEFINE_MUTEX(pasid_mutex);
> +static DEFINE_XARRAY_ALLOC(sva_pasid_array);
> +
> +
> +static int sva_pasid_private_add(u32 pasid, void *priv)
> +{
> +	return xa_alloc(&sva_pasid_array, &pasid, priv,
> +			XA_LIMIT(pasid, pasid), GFP_ATOMIC);
> +}
> +
> +static void sva_pasid_private_remove(u32 pasid)
> +{
> +	xa_erase(&sva_pasid_array, pasid);
> +}
> +
> +static void *sva_pasid_private_find(u32 pasid)
> +{
> +	return xa_load(&sva_pasid_array, pasid);
> +}

No PASID stuff in SVA code at all please, all of this is wrong.

The only PASID comes from here, and it should be the only place PASID
shows up:

 +int amd_iommu_set_dev_pasid(struct iommu_domain *domain,
 +			    struct device *dev, ioasid_t pasid)
 +{

> +static int sva_bind_mm(struct device *dev, struct mm_struct *mm)
> +{
> +	struct amd_sva_pasid *sva_pasid;
> +	struct amd_sva_dev *sva_dev;
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	int ret = -EINVAL;
> +
> +	sva_dev = sva_dev_alloc(dev);
> +	if (!sva_dev)
> +		return ret;
> +
> +	sva_pasid = sva_pasid_private_find(mm->pasid);
> +	if (!sva_pasid) {
> +		sva_pasid = sva_pasid_alloc(mm);
> +		if (!sva_pasid)
> +			goto out_sva_dev;

No per-PASID struct. AMD enablement should go after this series:

 https://lore.kernel.org/linux-iommu/20230808074944.7825-1-tina.zhang@intel.com/

Put the mmu_notifier directly into the protection_domain. Assume you
have a single protection_domain per mm.

Also amd_sva_dev is not appropriate, the list of PASIDs (and masters)
a domain is associated with is part of the generic PASID support in
the protection_domain itself.

These details would be clearer if you start from enabling PASID
support for an UNMANAGED domain.

SVA should be a tiny incremental from that which simply calls the
same invalidation and manages the mmu notifier.

> +static struct amd_sva_dev *sva_dev_alloc(struct device *dev)
> +{
> +	struct amd_sva_dev *sva_dev;
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +
> +	sva_dev = kzalloc(sizeof(*sva_dev), GFP_KERNEL);
> +	if (!sva_dev)
> +		return NULL;
> +
> +	sva_dev->dev = dev;
> +	sva_dev->dev_data = dev_data;
> +	init_rcu_head(&sva_dev->rcu);
> +
> +	return sva_dev;
> +}
> +
> +static inline void sva_dev_free(struct amd_sva_dev *sva_dev)
> +{
> +	kfree_rcu(sva_dev, rcu);
> +}
> +
> +static void sva_mn_invalidate_range(struct mmu_notifier *mn,
> +				    struct mm_struct *mm,
> +				    unsigned long start, unsigned long end)
> +{
> +	struct amd_sva_pasid *sva_pasid;
> +	struct amd_sva_dev *sva_dev;
> +
> +	rcu_read_lock();
> +
> +	sva_pasid = container_of(mn, struct amd_sva_pasid, mn);
> +	if (!sva_pasid) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	list_for_each_entry_rcu(sva_dev, &sva_pasid->dev_list, list) {
> +		if ((start ^ (end - 1)) < PAGE_SIZE)
> +			amd_iommu_flush_page(sva_dev->dev_data->domain, sva_pasid->pasid, start);
> +		else
> +			amd_iommu_flush_tlb(sva_dev->dev_data->domain, sva_pasid->pasid);
> +	}

SVA invalidation should be the same as normal PASID invalidation. You
need to track the list of PASIDs a protection_domain is associated
with in the protection domain itself, not in special SVA code. Don't
repeat the SMMU mistakes please.

Use container_of(mn) to get back to the SVA protection domain and then
you can access the protection domains list of PASIDs & masters.

> +static int sva_bind_mm(struct device *dev, struct mm_struct *mm)
> +{
> +	struct amd_sva_pasid *sva_pasid;
> +	struct amd_sva_dev *sva_dev;
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	int ret = -EINVAL;
> +
> +	sva_dev = sva_dev_alloc(dev);
> +	if (!sva_dev)
> +		return ret;
> +
> +	sva_pasid = sva_pasid_private_find(mm->pasid);
> +	if (!sva_pasid) {
> +		sva_pasid = sva_pasid_alloc(mm);
> +		if (!sva_pasid)
> +			goto out_sva_dev;
> +
> +		ret = sva_pasid_private_add(sva_pasid->pasid, sva_pasid);
> +		if (ret)
> +			goto out_sva_pasid;
> +
> +		ret = amd_iommu_set_gcr3(dev_data, sva_pasid->pasid,
> +					 iommu_virt_to_phys(sva_pasid->mm->pgd));
> +		if (ret)
> +			goto out_pasid_remove;
> +
> +		ret = mmu_notifier_register(&sva_pasid->mn, mm);
> +		if (ret)
> +			goto out_clear_gcr3;
> +	}

The mmu_notifier should be setup when the domain is allocated, not
during bind.

This is an issue we need to fix in the core code :(

> +void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_domain *domain;
> +
> +	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
> +		return;

We should probably have the core code pass in the old domain to this
function, it is looking more like a mistake we didn't do that.

> +
> +	/* Get SVA domain */
> +	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
> +	if (!domain)
> +		return;
> +
> +	switch (domain->type) {
> +	case IOMMU_DOMAIN_SVA:
> +		/* Ensure that all queued faults have been processed */
> +		iopf_queue_flush_dev(dev);
> +
> +		mutex_lock(&pasid_mutex);
> +		sva_unbind_mm(dev, pasid);
> +		mutex_unlock(&pasid_mutex);

SVA should not be special for detach, this should all be generic code.

The mmu notifier is freed during SVA domain dealloc.

Jason
