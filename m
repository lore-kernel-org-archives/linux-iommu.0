Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D512EB1F
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 23:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MF0IBzmd"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-41cd4cc515fso34845831cf.1
        for <iommu@lists.linux.dev>; Mon, 06 Nov 2023 15:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1699312713; x=1699917513; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5d2mC9+MnZTm/A2X4zQrOCgNekbH1vVJ+sMINk+Ywjs=;
        b=MF0IBzmdo8TvUOcd7o1NmJEAN+WRyJd6HyIlz/ogyWN+z5np8a1j+uE1sXrxmZKSpb
         h73Z1uUV9leQVE4iMIwhIkONcuOFXk6XVvB48F7snDneI1zsV5FrCRX6IXstXGESPi4r
         q6OTrB9wHJz9UmY+TZXhi2xWbpJzGqzGdkKnZ6YoAG6/zQZqVrwh8zEym8s83gHZRLqZ
         9iTzLtpZ7AWPH84LoS+TKypfqu+wt1E/HM+BN6c8jC3N1zPKI0V32xM94MVMMKbgEEhG
         EgJMCKcQ9jobW027FNY8uzaNtmL/UepGfr3mUqcRP3J22S4TsKvfD4wQBO0mPiwNWu03
         aWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699312713; x=1699917513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5d2mC9+MnZTm/A2X4zQrOCgNekbH1vVJ+sMINk+Ywjs=;
        b=RophWBHd5mnMWHsIw+3FhWKPiJRA7mvsLGG0BixKF8csXBgtmJKiw6Ga9iis0yQspp
         nTpMzAUzBO+Lgb8i1p8G6ZZFDk/OyWSjV0K1K744hbhumMNIBjdeCZKYYR7/gwKEEGrK
         wU67JRgmvda2zbdIEX9M0ffXqgPQn2DSnZQ7grZg9SvhXM9rYco5fEVF1ZluLqH4cZpr
         EWJoGBiLddKLI66Vk3Uf+vw7V4IC9wF5E3BBZs7QA5qB/dqsRXksrqVFBQgbuO6V47p0
         HpBh4gRNonuC+eiwJXSo1dscB8/uRVMKeZlQK8CqTHIXJN4Ri+W1bqoG8qvwBtblDxh0
         tU5g==
X-Gm-Message-State: AOJu0YzfwH8ZxLOFePFRunsA7fQpJ9sjL3dlWw0mX/4UKX2cxaNKMklx
	c475QjzmQfoq2uAjSJSXsNXWuA==
X-Google-Smtp-Source: AGHT+IE+oRy5xpdhxlB0FSo825w1wotK1STL2niPXgU1TjQDo7EFB5iRW7nJond5ryXhxt62NzgZww==
X-Received: by 2002:a05:622a:1828:b0:41e:22a2:8ab with SMTP id t40-20020a05622a182800b0041e22a208abmr37603628qtc.46.1699312713145;
        Mon, 06 Nov 2023 15:18:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id ki23-20020a05622a771700b004166ab2e509sm3813318qtb.92.2023.11.06.15.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 15:18:32 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r08rX-001Rpd-Vn;
	Mon, 06 Nov 2023 19:18:31 -0400
Date: Mon, 6 Nov 2023 19:18:31 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 05/12] iommu/amd: Initial SVA support for AMD IOMMU
Message-ID: <20231106231831.GV4634@ziepe.ca>
References: <20231016104351.5749-1-vasant.hegde@amd.com>
 <20231016104351.5749-6-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016104351.5749-6-vasant.hegde@amd.com>

On Mon, Oct 16, 2023 at 10:43:44AM +0000, Vasant Hegde wrote:
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index da94dca1eb92..20961353460d 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -8,7 +8,9 @@
>  #ifndef _ASM_X86_AMD_IOMMU_TYPES_H
>  #define _ASM_X86_AMD_IOMMU_TYPES_H
>  
> +#include <linux/iommu.h>
>  #include <linux/types.h>
> +#include <linux/mmu_notifier.h>
>  #include <linux/mutex.h>
>  #include <linux/msi.h>
>  #include <linux/list.h>
> @@ -541,6 +543,16 @@ enum protection_domain_mode {
>  	PD_MODE_V2,
>  };
>  
> +/* Track PASID list for the protection domain */
> +struct pdom_pasid_data {
> +	/* PASID attached to the protection domain */
> +	ioasid_t pasid;
> +	/* Points to attached device data */
> +	struct iommu_dev_data *dev_data;
> +	/* Link to protection domain */
> +	struct list_head pdom_link;
> +};
> +
>  /*
>   * This structure contains generic data for  IOMMU protection domains
>   * independent of their use.
> @@ -556,6 +568,9 @@ struct protection_domain {
>  	enum protection_domain_mode pd_mode; /* Track page table type */
>  	unsigned dev_cnt;	/* devices assigned to this domain */
>  	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
> +
> +	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
> +	struct list_head pasid_list; /* List of pdom_pasid_data */
>  };

Oh, see here is the data structure I mentioned earlier, it just needs
to be done as part of the invalidation cleanup and replace the other
things I mentioned. Has nothing to do with SVA.

> @@ -2432,6 +2428,8 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
>  	case IOMMU_DOMAIN_UNMANAGED:
>  		pgtable = AMD_IOMMU_V1;
>  		break;
> +	case IOMMU_DOMAIN_SVA:
> +		return amd_iommu_sva_domain_alloc(domain);

Same remark as I gave intel, you should take my patch (strip the ARM
parts) to give this it's own op which significantly cleans up this
flow.

https://lore.kernel.org/linux-iommu/20-v2-16665a652079+5947-smmuv3_newapi_p2_jgg@nvidia.com/

> +static void dev_pasid_remove(struct pdom_pasid_data *pasid_data)
> +{
> +	/* make it visible */
> +	smp_wmb();

What is "it"? Don't put barriers like this, the barrier should
immediately follow whatever store it is protecting.

> +static struct pdom_pasid_data *get_pdom_pasid_data(struct protection_domain *pdom,
> +					   struct device *dev, ioasid_t pasid)
> +{
> +	struct pdom_pasid_data *pasid_data;
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +

Add a lockdep assertion, but it seems strange a function like this
would even exist.. Better to call it "remove_pdom_pasid_data" and
include the list_del(). And then pull the locking into here too.

> +static void sva_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
> +				    struct mm_struct *mm,
> +				    unsigned long start, unsigned long end)
> +{
> +	struct protection_domain *sva_pdom;
> +	struct pdom_pasid_data *pasid_data;
> +	struct iommu_dev_data *dev_data;
> +	unsigned long flags;
> +
> +	sva_pdom = container_of(mn, struct protection_domain, mn);
> +
> +	spin_lock_irqsave(&sva_pdom->lock, flags);
> +
> +	list_for_each_entry(pasid_data, &sva_pdom->pasid_list, pdom_link) {
> +		dev_data = pasid_data->dev_data;
> +
> +		spin_lock(&dev_data->lock);
> +		amd_iommu_dev_flush_pasid_pages(dev_data, pasid_data->pasid,
> +						start, end - start);

Nope, can't unlock while still holding the pointer. Use a mutex or a
rcu scheme. Again this should all be general non-SVA code to fix the
entire invalidation logic.

> +static void sva_mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
> +{
> +	struct pdom_pasid_data *pasid_data, *next;
> +	struct protection_domain *sva_pdom;
> +	unsigned long flags;
> +
> +	sva_pdom = container_of(mn, struct protection_domain, mn);
> +
> +	spin_lock_irqsave(&sva_pdom->lock, flags);
> +
> +	/* Assume pasid_list contains same PASID with different devices */
> +	list_for_each_entry_safe(pasid_data, next,
> +				 &sva_pdom->pasid_list, pdom_link) {
> +		dev_pasid_remove(pasid_data);
> +	}

Be mindful of any logging in other parts of the driver.. Ideally a
non-present PASID translation will generate a debugging log but a
released SVA will not.

> +static int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
> +				   struct device *dev, ioasid_t pasid)
> +{
> +	struct pdom_pasid_data *pasid_data;
> +	struct protection_domain *sva_pdom = to_pdomain(domain);
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	unsigned long flags;
> +	int ret = -EINVAL;
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

GFP_KERNEL under a spinlock - did you test this with full debugging?

> +	if (pasid_data == NULL) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	pasid_data->pasid = pasid;
> +	pasid_data->dev_data = dev_data;
> +
> +	if (list_empty(&sva_pdom->pasid_list)) {
> +		sva_pdom->mn.ops = &sva_mn;
> +
> +		ret = mmu_notifier_register(&sva_pdom->mn, domain->mm);
> +		if (ret) {
> +			sva_pdom->mn.ops = NULL;
> +			goto out_free_pasid_data;
> +		}
> +	}
> +
> +	/* Setup GCR3 table */
> +	ret = amd_iommu_set_gcr3(dev_data, pasid,
> +				 iommu_virt_to_phys(domain->mm->pgd));
> +	if (ret)
> +		goto out_unreg_notifier;

Something looks missing, what if the RID domain hasn't installed a
GCR3? Eg it is a v1 domain or something?

> +	list_add(&pasid_data->pdom_link, &sva_pdom->pasid_list);
> +	spin_unlock_irqrestore(&sva_pdom->lock, flags);
> +	return ret;
> +
> +out_unreg_notifier:
> +	mmu_notifier_unregister(&sva_pdom->mn, domain->mm);
> +	sva_pdom->mn.ops = NULL;

I'm pretty sure you can't actually unregister while holding the
spinlock without creating a deadlock.

Take my SVA patch and move notifier registration to alloc/free and out
of attach to fix this.

Jason
