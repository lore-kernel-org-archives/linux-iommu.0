Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91401BD004
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693621; cv=none; b=Ln7QpB+FpZUca/A8gqSxB5Dctpc7z6H/AKI0nLlKJKpNjuszEqF0t9fc+P5OH0u5leKQkmOVSwneoH/M7QexgcW4Hbok1LuHD0YnlZTJPJRQC0uxBVndlrPprb1+VbFcLuctZFCPz4Wbzn0C7uBrh65HJp0ECtK2m9tMOWJeh8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693621; c=relaxed/simple;
	bh=Qhp2YA1Yov+hw/pFm+DmnujaM29sd0Ga849k5wbeBPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3+LKmBXJDwhexr29jd1aePfrgcit4spj2LI398MuvpnG4Q7o3Z/d5YzQdeKFqrABVTENBQ6vir11j9IHrhsU4VKdRLmjwboJ/KZNn9sh5sB01rnOS0USTevxvN2hf85vkXcRKhe1uR7k8FQyGXe0cDcUwthHKJL9/Y0gwvY9AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 299C0339;
	Wed, 23 Oct 2024 07:27:22 -0700 (PDT)
Received: from [10.1.32.28] (010265703453.arm.com [10.1.32.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7D813F71E;
	Wed, 23 Oct 2024 07:26:50 -0700 (PDT)
Message-ID: <c683ddc1-981e-498b-be27-32d887f95c1c@arm.com>
Date: Wed, 23 Oct 2024 15:26:48 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] iommu: Introduce
 iommu_paging_domain_alloc_flags()
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: will@kernel.org, suravee.suthikulpanit@amd.com, jgg@ziepe.ca,
 yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
 jacob.pan@linux.microsoft.com, Jason Gunthorpe <jgg@nvidia.com>
References: <20241023104207.5894-1-vasant.hegde@amd.com>
 <20241023104207.5894-3-vasant.hegde@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241023104207.5894-3-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-23 11:41 am, Vasant Hegde wrote:
> From: Jason Gunthorpe <jgg@ziepe.ca>
> 
> Currently drivers calls iommu_paging_domain_alloc(dev) to get an
> UNMANAGED domain. This is not sufficient to support PASID with
> UNMANAGED domain as some HW like AMD requires certain page table type
> to support PASIDs.
> 
> Also the domain_alloc_paging op only passes device as param for domain
> allocation. This is not sufficient for AMD driver to decide the right
> page table.
> 
> Instead of extending ops->domain_alloc_paging() it was decided to
> enhance ops->domain_alloc_user() so that caller can pass various
> additional flags.

Wait, what? So iommu_paging_domain_alloc_flags() opaquely may or may not 
actually allocate a regular paging domain or a user domain depending on 
the flags? But then per patch #3 we allocate default domains - the most 
kernel-owned of all - as *user* domains, by virtue of passing the PASID 
flag?? Except then per patch #4 it's actually a big double-bluff, 
because asking a driver's .domain_alloc_user op for PASIDs is in fact 
expected to return an unfinished non-user domain, in spite of the 
explicitly documented behaviour:

| Unlike @domain_alloc, it is called only by IOMMUFD and
| must fully initialize the new domain before return.

???

This is insane. Please implement it in manner which is not insane.

Thanks,
Robin.

> Hence add iommu_paging_domain_alloc_flags() API which takes flags as
> parameter. Caller can pass additional parameter to indicate type of
> domain required, etc. iommu_paging_domain_alloc_flags() internally calls
> appropriate callback function to allocate a domain.
> 
> Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
> [Added description - Vasant]
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommu.c | 32 +++++++++++++++++++++++++++-----
>   include/linux/iommu.h | 14 +++++++++++---
>   2 files changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 811748bec4b0..69fc0b9ba31a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2027,20 +2027,42 @@ struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
>   EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>   
>   /**
> - * iommu_paging_domain_alloc() - Allocate a paging domain
> + * iommu_paging_domain_alloc_flags() - Allocate a paging domain
>    * @dev: device for which the domain is allocated
> + * @flags: Enum of iommufd_hwpt_alloc_flags
>    *
>    * Allocate a paging domain which will be managed by a kernel driver. Return
> - * allocated domain if successful, or a ERR pointer for failure.
> + * allocated domain if successful, or an ERR pointer for failure.
>    */
> -struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
> +struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
> +						     unsigned int flags)
>   {
> +	const struct iommu_ops *ops;
> +	struct iommu_domain *domain;
> +
>   	if (!dev_has_iommu(dev))
>   		return ERR_PTR(-ENODEV);
>   
> -	return __iommu_domain_alloc(dev_iommu_ops(dev), dev, IOMMU_DOMAIN_UNMANAGED);
> +	ops = dev_iommu_ops(dev);
> +
> +	if (ops->domain_alloc_paging && !flags)
> +		domain = ops->domain_alloc_paging(dev);
> +	else if (ops->domain_alloc_user)
> +		domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
> +	else if (ops->domain_alloc && !flags)
> +		domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
> +	else
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	if (IS_ERR(domain))
> +		return domain;
> +	if (!domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	iommu_domain_init(domain, IOMMU_DOMAIN_UNMANAGED, ops);
> +	return domain;
>   }
> -EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc);
> +EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
>   
>   void iommu_domain_free(struct iommu_domain *domain)
>   {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index bd722f473635..42243183e81d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -511,8 +511,6 @@ static inline int __iommu_copy_struct_from_user_array(
>    *                the caller iommu_domain_alloc() returns.
>    * @domain_alloc_user: Allocate an iommu domain corresponding to the input
>    *                     parameters as defined in include/uapi/linux/iommufd.h.
> - *                     Unlike @domain_alloc, it is called only by IOMMUFD and
> - *                     must fully initialize the new domain before return.
>    *                     Upon success, if the @user_data is valid and the @parent
>    *                     points to a kernel-managed domain, the new domain must be
>    *                     IOMMU_DOMAIN_NESTED type; otherwise, the @parent must be
> @@ -789,7 +787,11 @@ extern bool iommu_present(const struct bus_type *bus);
>   extern bool device_iommu_capable(struct device *dev, enum iommu_cap cap);
>   extern bool iommu_group_has_isolated_msi(struct iommu_group *group);
>   extern struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus);
> -struct iommu_domain *iommu_paging_domain_alloc(struct device *dev);
> +struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev, unsigned int flags);
> +static inline struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
> +{
> +	return iommu_paging_domain_alloc_flags(dev, 0);
> +}
>   extern void iommu_domain_free(struct iommu_domain *domain);
>   extern int iommu_attach_device(struct iommu_domain *domain,
>   			       struct device *dev);
> @@ -1096,6 +1098,12 @@ static inline struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus
>   	return NULL;
>   }
>   
> +struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
> +						     unsigned int flags)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
>   static inline struct iommu_domain *iommu_paging_domain_alloc(struct device *dev)
>   {
>   	return ERR_PTR(-ENODEV);

