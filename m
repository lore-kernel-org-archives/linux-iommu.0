Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5761C2B
	for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 16:47:46 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-64cca551ae2so37212566d6.0
        for <iommu@lists.linux.dev>; Tue, 12 Sep 2023 09:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694537266; x=1695142066; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VZAbo0RdmX4py505oq/hIpt+sW9dUIWEUDrJMZnDOxM=;
        b=dUVaxy6A47nIT6x0drEKj2kKZdVqTIlAZqBW03njhunZwx771QJfLuSNxIdvuiQ23h
         Hta8Diu1495T95F/x5aTHBGWU+VwIxJKGfaeLrY33kYmcNb7eo1yks2MRagv3Ll/AKRV
         9EIS8dewBWK2ebW6Ln3jZWELKwfZlKTQUmMy+g5iivl5gVqTLL9YCOcKQ69eSX0ZprU4
         2MebTtobTFlonTb3vEbUZEqbxXwOOKX+nuO23LFRIAEtupw8LuGcWML/9SNiPR8CZn+R
         5tHg/7jmM+5c/jE/mlEBN8JOkO/skYzL9FHSe6dC6iz/rDitxmOoC+TUVCODdooHKbZS
         LJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694537266; x=1695142066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZAbo0RdmX4py505oq/hIpt+sW9dUIWEUDrJMZnDOxM=;
        b=kaBXqJMY3CM6enH2lQ/1Fj6c21zDoG5xHhCG3UWbLayecgENe9kTDQgvXb6WZmejgD
         lcS+Aq0vBgeU6EljjQpky/FFVBW84cCHmBbyiV/9nOb6m8X/F6t28mJPQaJFdSur2jnz
         Rbe6uybIEttKa8WqwV93GxU5Ci0LIxuZnK/vCJ7mSlFDi4BTW6s9YNyarZT6ZcEqzjUj
         6r5gRYL8zHAfx8OXnR8EKXAkTthdhEtMnrUQ0BSkW2bRNAAB4etwulJ0gv9nZUy7WHKg
         f5jhR08ufofNiY1cfvKEN6lGGHaLs0OTGsFfTEWt4bR0AD8jZtXkbgN+NnNmeo2aFkr+
         yS9w==
X-Gm-Message-State: AOJu0YwdAICQHvO8eYsGToPg2Wp3Vl2k5kTg3g//s4lgalEQXS3v93WI
	cvjh034x6rTpzCM6F4dsmDXQSA==
X-Google-Smtp-Source: AGHT+IExTwHuHsM3WcPAmTkjgrBXSQ/hy5BwUfu9AsS9DA6kq4TJ3YgT+JyhTzIoPUc618ulbmwfsA==
X-Received: by 2002:a0c:f08e:0:b0:655:db86:6c95 with SMTP id g14-20020a0cf08e000000b00655db866c95mr10095071qvk.37.1694537265933;
        Tue, 12 Sep 2023 09:47:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id a1-20020a0cb341000000b0063d1f967268sm3817236qvf.111.2023.09.12.09.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 09:47:45 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qg6YC-002FbL-G0;
	Tue, 12 Sep 2023 13:47:44 -0300
Date: Tue, 12 Sep 2023 13:47:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 04/11] iommu/amd: Initial SVA support for AMD IOMMU
Message-ID: <ZQCWMFFgbbcBN+0n@ziepe.ca>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
 <20230911121046.1025732-5-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911121046.1025732-5-vasant.hegde@amd.com>

On Mon, Sep 11, 2023 at 12:10:39PM +0000, Vasant Hegde wrote:

> +static inline struct protection_domain *amd_iommu_get_pdomain(struct device *dev)
> +{
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +
> +	if (!dev_data || !dev_data->domain)
> +		return NULL;
> +
> +	return dev_data->domain;
> +}

Not used in this patch

> @@ -2192,6 +2188,11 @@ static int protection_domain_init_v2(struct protection_domain *pdom)
>  	return 0;
>  }
>  
> +static const struct iommu_domain_ops amd_svm_domain_ops = {
> +	.set_dev_pasid = amd_iommu_set_dev_pasid,
> +	.free	       = amd_iommu_domain_free
> +};

"amd_sva_domain_ops" please

> new file mode 100644
> index 000000000000..d18dc3f676b9
> --- /dev/null
> +++ b/drivers/iommu/amd/sva.c
> @@ -0,0 +1,158 @@
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
> +
> +static void sva_mn_invalidate_range(struct mmu_notifier *mn,
> +				    struct mm_struct *mm,
> +				    unsigned long start, unsigned long end)
> +{
> +	struct protection_domain *sva_pdom;
> +	struct pdom_pasid_data *pasid_data;
> +	struct iommu_dev_data *dev_data;
> +
> +	sva_pdom = container_of(mn, struct protection_domain, mn);
> +
> +	list_for_each_entry(pasid_data, &sva_pdom->pasid_list, pdom_link) {

Need to hold sva_pdom->lock if iterating over pasid_list

> +		dev_data = pasid_data->dev_data;
> +
> +		if ((start ^ (end - 1)) < PAGE_SIZE) {
> +			amd_iommu_flush_page(dev_data->domain,
> +					     pasid_data->pasid, start);
> +		} else {
> +			amd_iommu_flush_tlb(dev_data->domain,
> +					    pasid_data->pasid);
> +		}

It is baffling why dev_data->domain would be used here, and it isn't
locked properly so this is a problem.

Looking into __flush_pasid it doesn't really make sense. The PASID
domain definately can't assume that the RID domain has the the same
set of iommus. Most likely the SVA domain has a wider set of iommus,
at least I didn't notice any logic preventing this in set_dev_pasid.

Also, didn't you say you wanted to de-duplicate the IOTLB and ATC
invalidations like ARM is doing?

> +static const struct mmu_notifier_ops sva_mn = {
> +	.invalidate_range = sva_mn_invalidate_range,
> +	.release = sva_mn_release,
> +};

Why an empty release function?

That can't be right, when release is called the driver has to stop
using iommu_virt_to_phys(domain->mm->pgd)) because it will be freed
memory. It should replace it with a global empty pgd and flush caches
before release returns.

> +int amd_iommu_set_dev_pasid(struct iommu_domain *domain,
> +			    struct device *dev, ioasid_t pasid)
> +{
> +	struct protection_domain *sva_pdom = to_pdomain(domain);

Just call this pdom, there is nothing about this function that is sva
specific anymore.

> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	struct pdom_pasid_data *pasid_data;
> +	int ret = -EINVAL;
> +	unsigned long flags;
> +
> +	/* PASID zero is used for requests from the I/O device without PASID */
> +	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
> +		return ret;
> +
> +	/* Use SVA protection domain lock */
> +	spin_lock_irqsave(&sva_pdom->lock, flags);
> +
> +	/* Add PASID to protection domain pasid list */
> +	pasid_data = kzalloc(sizeof(*pasid_data), GFP_KERNEL);
> +	if (pasid_data == NULL) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	pasid_data->pasid = pasid;
> +	pasid_data->dev_data = dev_data;
> +
> +	/* Setup GCR3 table */
> +	ret = amd_iommu_set_gcr3(dev_data, pasid,
> +				 iommu_virt_to_phys(domain->mm->pgd));
> +	if (ret)
> +		goto out_free_pasid_data;
> +
> +	if (list_empty(&sva_pdom->pasid_list)) {
> +		sva_pdom->mn.ops = &sva_mn;
> +
> +		ret = mmu_notifier_register(&sva_pdom->mn, domain->mm);
> +		if (ret)
> +			goto out_clear_gcr3;
> +	}

Looks to me like mmu_notifier_register() should be done before
amd_iommu_set_gcr3() so we don't have a risk of stale iotlb data.

> +
> +	list_add(&pasid_data->pdom_link, &sva_pdom->pasid_list);
> +	spin_unlock_irqrestore(&sva_pdom->lock, flags);
> +	return ret;
> +
> +out_clear_gcr3:
> +	amd_iommu_clear_gcr3(dev_data, pasid);
> +
> +out_free_pasid_data:
> +	kfree(pasid_data);
> +
> +out:
> +	spin_unlock_irqrestore(&sva_pdom->lock, flags);
> +	return ret;
> +}

But this looks fine, it is entirely generic.

> +static struct pdom_pasid_data *get_pdom_pasid_data(struct protection_domain *pdom,
> +						   struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	struct pdom_pasid_data *pasid_data;
> +
> +	list_for_each_entry(pasid_data, &pdom->pasid_list, pdom_link)
> {

Add a lockdep assert for pdom->lock here

> +		if (pasid_data->pasid == pasid &&
> +		    pasid_data->dev_data == dev_data)
> +			return pasid_data;
> +	}
> +
> +	return NULL;
> +}
> +
> +void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
> +{
> +	struct pdom_pasid_data *pasid_data;
> +	struct protection_domain *sva_pdom;
> +	struct iommu_domain *domain;
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	unsigned long flags;
> +
> +	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
> +		return;
> +
> +	/* Get protection domain */
> +	domain = iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAIN_SVA);
> +	if (!domain)
> +		return;
> +	sva_pdom = to_pdomain(domain);
> +
> +	/* Ensure that all queued faults have been processed */
> +	iopf_queue_flush_dev(dev);
> +
> +	spin_lock_irqsave(&sva_pdom->lock, flags);
> +
> +	pasid_data = get_pdom_pasid_data(sva_pdom, dev, pasid);
> +	if (!pasid_data) {
> +		spin_unlock_irqrestore(&sva_pdom->lock, flags);
> +		return;
> +	}
> +
> +	list_del(&pasid_data->pdom_link);
> +	kfree(pasid_data);
> +
> +	/* make it visible */
> +	smp_wmb();
> +
> +	/* Update GCR3 table and flush IOTLB */
> +	amd_iommu_clear_gcr3(dev_data, pasid);
> +
> +	spin_unlock_irqrestore(&sva_pdom->lock, flags);
> +
> +	if (list_empty(&sva_pdom->pasid_list))
> +		mmu_notifier_unregister(&sva_pdom->mn, domain->mm);

Can't drop the spinlock before doing this, it is racy.

It would be best if the mmu notifier was registered at domain
allocation time and freed at domain destruction

Jason
