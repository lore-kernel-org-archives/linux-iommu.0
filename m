Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBE47F460
	for <iommu@lists.linux.dev>; Fri, 13 Sep 2024 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726247290; cv=none; b=AaOXG0MBMMg85h6sDIp6zunaEnvx4xHuapdUn3Ow9sEMd3yrcUFJ67hEGOd/ZdBPDdNk/eKdHuy4WSyQ5aKpKyCac0jUcECahUxfVVOS2BSE0Kv3fEH/Na7zQxVifyYttuMm83rhYbEyu8ZjLIBdmPdntA91n0PSpYq4CCG+XDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726247290; c=relaxed/simple;
	bh=SYIvHR4lbwPCbzRxpMDIkq+VkRTF1J0osCQa5FQTInQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsxbfuSN4aYXoRQMWTfIfpnoRyK0nHBL5vINAfObpIsX/ICU8cgdQ2tKen1fIOmSI7L00Be+rr7W3s8e4ntR6Aj6DekdiFuKGqkeLhBXWa0Hh2tI18BEj+5s4R0DWV4Kb8AiIH4VHX55vfIJM7xICp3AEhzP3bMErZJuEnB7Zhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mb6B88yG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mb6B88yG"
Received: from DESKTOP-0403QTC. (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id DAF4620BE5B7;
	Fri, 13 Sep 2024 10:08:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DAF4620BE5B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726247288;
	bh=b4Cu7+BLgup4AJyZjQOG+CimKm0g6vYLf0exBbWZ2R0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
	b=mb6B88yGsSuGTPidEJDzJbC9ZNolToYl1U5mE1J0HBK1guVvixSZnIZJl3QHKBeb9
	 m2PMKaC6VcMj+3N/7Dgxbaf5wNkHcE7Rl18t9pQ7m/FcIVBVsEEY9xeGp09nMQptfF
	 Evf8bzJr8OGKPDudM+HpJZXf9Mc9kypK7RjIkrL4=
Date: Fri, 13 Sep 2024 10:08:05 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: <iommu@lists.linux.dev>, <joro@8bytes.org>, <will@kernel.org>,
 <robin.murphy@arm.com>, <suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>,
 <yi.l.liu@intel.com>, <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v2 4/8] iommu/amd: Separate page table setup from domain
 allocation
Message-ID: <20240913100805.517e97c5@DESKTOP-0403QTC.>
In-Reply-To: <20240911101911.6269-5-vasant.hegde@amd.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
	<20240911101911.6269-5-vasant.hegde@amd.com>
Reply-To: jacob.pan@linux.microsoft.com
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Vasant,

On Wed, 11 Sep 2024 10:19:07 +0000
Vasant Hegde <vasant.hegde@amd.com> wrote:

> Currently protection_domain_alloc() allocates domain and also sets up
> page table. Page table setup is required for PAGING domain only.
> Domain type like SVA doesn't need page table. Hence move page table
> setup code to separate function.
> 
> Also SVA domain allocation path does not call pdom_setup_pgtable().
> Hence remove IOMMU_DOMAIN_SVA type check.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 42
> ++++++++++++++++++++++++--------------- 1 file changed, 26
> insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 2d0a681a2052..6844040b3702 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2264,28 +2264,36 @@ void protection_domain_free(struct
> protection_domain *domain) 
>  struct protection_domain *protection_domain_alloc(unsigned int type,
> int nid) {
> -	struct io_pgtable_ops *pgtbl_ops;
>  	struct protection_domain *domain;
> -	int pgtable;
>  
>  	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>  	if (!domain)
>  		return NULL;
>  
>  	domain->id = domain_id_alloc();
> -	if (!domain->id)
> -		goto err_free;
> +	if (!domain->id) {
> +		kfree(domain);
> +		return NULL;
> +	}
>  
>  	spin_lock_init(&domain->lock);
>  	INIT_LIST_HEAD(&domain->dev_list);
>  	INIT_LIST_HEAD(&domain->dev_data_list);
>  	domain->iop.pgtbl.cfg.amd.nid = nid;
>  
> +	return domain;
> +}
> +
> +static int pdom_setup_pgtable(struct protection_domain *domain,
> +			      unsigned int type)
> +{
> +	struct io_pgtable_ops *pgtbl_ops;
> +	int pgtable;
> +
>  	switch (type) {
>  	/* No need to allocate io pgtable ops in passthrough mode */
>  	case IOMMU_DOMAIN_IDENTITY:
> -	case IOMMU_DOMAIN_SVA:
> -		return domain;
> +		return 0;
>  	case IOMMU_DOMAIN_DMA:
>  		pgtable = amd_iommu_pgtable;
>  		break;
> @@ -2297,7 +2305,7 @@ struct protection_domain
> *protection_domain_alloc(unsigned int type, int nid) pgtable =
> AMD_IOMMU_V1; break;
>  	default:
> -		goto err_id;
> +		return -EINVAL;
>  	}
>  
>  	switch (pgtable) {
> @@ -2308,20 +2316,14 @@ struct protection_domain
> *protection_domain_alloc(unsigned int type, int nid) domain->pd_mode
> = PD_MODE_V2; break;
>  	default:
> -		goto err_id;
> +		return -EINVAL;
>  	}
> -
>  	pgtbl_ops =
>  		alloc_io_pgtable_ops(pgtable,
> &domain->iop.pgtbl.cfg, domain); if (!pgtbl_ops)
> -		goto err_id;
> +		return -ENOMEM;
>  
> -	return domain;
> -err_id:
> -	domain_id_free(domain->id);
> -err_free:
> -	kfree(domain);
> -	return NULL;
> +	return 0;
>  }
>  
>  static inline u64 dma_max_address(void)
> @@ -2344,6 +2346,7 @@ static struct iommu_domain
> *do_iommu_domain_alloc(unsigned int type, bool dirty_tracking = flags
> & IOMMU_HWPT_ALLOC_DIRTY_TRACKING; struct protection_domain *domain;
>  	struct amd_iommu *iommu = NULL;
> +	int ret;
>  
>  	if (dev)
>  		iommu = get_amd_iommu_from_dev(dev);
> @@ -2363,6 +2366,13 @@ static struct iommu_domain
> *do_iommu_domain_alloc(unsigned int type, if (!domain)
>  		return ERR_PTR(-ENOMEM);
>  
> +	ret = pdom_setup_pgtable(domain, type);
> +	if (ret) {
> +		domain_id_free(domain->id);
> +		kfree(domain);
> +		return ERR_PTR(ret);
> +	}
> +
>  	domain->domain.geometry.aperture_start = 0;
>  	domain->domain.geometry.aperture_end   = dma_max_address();
>  	domain->domain.geometry.force_aperture = true;

Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
