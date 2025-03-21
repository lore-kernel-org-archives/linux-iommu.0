Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FD7182B4
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 03:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742526699; cv=none; b=uHYM8edoVFiUwsK3UlrnmuJwPqVEJkfLFGZ9VKZ9blQ8I1dX5dHtA3aRFpFiZxySBlsJd+dB/IG9e9vr5VydoIMDUvEtYQAdf3kQZdyEp+eVWO4YH2bKCCq8eu70xdJT+OxD+L4qHyZ0DkRgFDUOHKYlHuPfzCiLn5esfSrSrjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742526699; c=relaxed/simple;
	bh=3AV0decAH8un1LfQ9AOfJmChFXWGJBHrI7UE6tT0VPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a06GDTioBJgZSLVR2wziyL16ojXsRgybikR6FNo2ncN5PbNghJCzUwYtzzwS48A4FNLvwmhB7QyhoRB1yAy79j2wyBDjb6ycqYJnKoY9EZN0Br/UgNV+5kJTI2j1ed1ndtYEl7S32P28OkWe14YD05eFCqC25L/oZEH1ifqIJKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O42uyLFL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O42uyLFL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742526696; x=1774062696;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3AV0decAH8un1LfQ9AOfJmChFXWGJBHrI7UE6tT0VPA=;
  b=O42uyLFLHeKxAt/744Pqk6ozB14yb91ftiPKE3Lr3URffwTWYU6U8rLv
   KewnFjKOPhqWXVYdXOTS5DZ0LKFtUDMi7p8ZKt3sK2FvgwJQ0lddDz5ff
   C405KGAzvhIJxRsHDU+tXlHysBw8+ID5sNTwhcIVQ21+b/FnfSp5awp16
   9hdha2M7kuAPqUyxAYGLsQn5Z0Ahv5ffaHVx5WaoQU9QAqo4QjhBhK173
   TWLTgfc4duoEbdwHdjG4q+ULO1kH9ywMAK7tXcd9Wi1fl3/29Slh+wrim
   5xs5Bryv0LVYg3eCQrWahgacjTX0Lhx5dmuDLer/ABkw/22CPSh+rSUP1
   w==;
X-CSE-ConnectionGUID: SodwTo5yRqiL+/UTg8nWBg==
X-CSE-MsgGUID: bqRt6PxkQVG1We+Nao3qiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="47661839"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="47661839"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 20:11:35 -0700
X-CSE-ConnectionGUID: NfcutVPLRIWzmoz8W/pkgg==
X-CSE-MsgGUID: nJoBxAZGRCeaI4cFwEcCNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="128390789"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 20:11:34 -0700
Message-ID: <bcbe2747-a76c-4f3e-ba40-787a2a55b1e4@linux.intel.com>
Date: Fri, 21 Mar 2025 11:08:03 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/18] iommu: Introduce a replace API for device pasid
To: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, jgg@nvidia.com
Cc: joro@8bytes.org, iommu@lists.linux.dev, nicolinc@nvidia.com
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-3-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250320134744.5777-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 21:47, Yi Liu wrote:
> Provide a high-level API to allow replacements of one domain with another
> for specific pasid of a device. This is similar to
> iommu_replace_group_handle() and it is expected to be used only by IOMMUFD.
> 
> Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
> v9 - > v10: Convert to the v8 version, added a check to fail the case
>              in which the passed handle is equal to the existing one.
> ---
>   drivers/iommu/iommu-priv.h |   4 ++
>   drivers/iommu/iommu.c      | 117 +++++++++++++++++++++++++++++++++++--
>   2 files changed, 117 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index b4508423e13b..2985f05d699f 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -43,4 +43,8 @@ void iommu_detach_group_handle(struct iommu_domain *domain,
>   int iommu_replace_group_handle(struct iommu_group *group,
>   			       struct iommu_domain *new_domain,
>   			       struct iommu_attach_handle *handle);
> +
> +int iommu_replace_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid,
> +			       struct iommu_attach_handle *handle);
>   #endif /* __LINUX_IOMMU_PRIV_H */
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cffd96e3efd2..07134bb85c00 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -513,6 +513,13 @@ static void iommu_deinit_device(struct device *dev)
>   	dev_iommu_free(dev);
>   }
>   
> +static inline struct iommu_domain *pasid_array_entry_to_domain(void *entry)
> +{
> +	if (xa_pointer_tag(entry) == IOMMU_PASID_ARRAY_DOMAIN)
> +		return xa_untag_pointer(entry);
> +	return ((struct iommu_attach_handle *)xa_untag_pointer(entry))->domain;
> +}

It's not good practice to put an inline helper in a C file. Probably
change it to a regular function or move it to iommu_priv.h?

> +
>   DEFINE_MUTEX(iommu_probe_device_lock);
>   
>   static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
> @@ -3311,14 +3318,15 @@ static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
>   }
>   
>   static int __iommu_set_group_pasid(struct iommu_domain *domain,
> -				   struct iommu_group *group, ioasid_t pasid)
> +				   struct iommu_group *group, ioasid_t pasid,
> +				   struct iommu_domain *old)
>   {
>   	struct group_device *device, *last_gdev;
>   	int ret;
>   
>   	for_each_group_device(group, device) {
>   		ret = domain->ops->set_dev_pasid(domain, device->dev,
> -						 pasid, NULL);
> +						 pasid, old);
>   		if (ret)
>   			goto err_revert;
>   	}
> @@ -3330,7 +3338,15 @@ static int __iommu_set_group_pasid(struct iommu_domain *domain,
>   	for_each_group_device(group, device) {
>   		if (device == last_gdev)
>   			break;
> -		iommu_remove_dev_pasid(device->dev, pasid, domain);
> +		/*
> +		 * If no old domain, undo the succeeded devices/pasid.
> +		 * Otherwise, rollback the succeeded devices/pasid to the old
> +		 * domain. And it is a driver bug to fail attaching with a
> +		 * previously good domain.
> +		 */
> +		if (!old || WARN_ON(old->ops->set_dev_pasid(old, device->dev,
> +							    pasid, domain)))
> +			iommu_remove_dev_pasid(device->dev, pasid, domain);
>   	}
>   	return ret;
>   }
> @@ -3399,7 +3415,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>   	if (ret)
>   		goto out_unlock;
>   
> -	ret = __iommu_set_group_pasid(domain, group, pasid);
> +	ret = __iommu_set_group_pasid(domain, group, pasid, NULL);
>   	if (ret) {
>   		xa_release(&group->pasid_array, pasid);
>   		goto out_unlock;
> @@ -3420,6 +3436,99 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>   }
>   EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
>   
> +/**
> + * iommu_replace_device_pasid - Replace the domain that a pasid
> + *                              is attached to
> + * @domain: the new iommu domain
> + * @dev: the attached device.
> + * @pasid: the pasid of the device.
> + * @handle: the attach handle.
> + *
> + * This API allows the pasid to switch domains. The @pasid should have been
> + * attached. Otherwise, this fails. The pasid will keep the old configuration
> + * if replacement failed.
> + *
> + * Caller should always provide a new handle to avoid race with the paths
> + * that have lockless reference to handle if it intends to pass a valid handle.
> + *
> + * Return 0 on success, or an error.
> + */
> +int iommu_replace_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid,
> +			       struct iommu_attach_handle *handle)
> +{
> +	/* Caller must be a probed driver on dev */
> +	struct iommu_group *group = dev->iommu_group;
> +	struct iommu_attach_handle *entry;
> +	struct iommu_domain *curr_domain;
> +	void *curr;
> +	int ret;
> +
> +	if (!group)
> +		return -ENODEV;
> +
> +	if (!domain->ops->set_dev_pasid)
> +		return -EOPNOTSUPP;
> +
> +	if (dev_iommu_ops(dev) != domain->owner ||
> +	    pasid == IOMMU_NO_PASID || !handle)
> +		return -EINVAL;
> +
> +	mutex_lock(&group->mutex);
> +	entry = iommu_make_pasid_array_entry(domain, handle);
> +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
> +			  XA_ZERO_ENTRY, GFP_KERNEL);
> +	if (xa_is_err(curr)) {
> +		ret = xa_err(curr);
> +		goto out_unlock;
> +	}
> +
> +	/*
> +	 * No domain (with or without handle) attached, hence not
> +	 * a replace case.
> +	 */
> +	if (!curr) {
> +		xa_release(&group->pasid_array, pasid);
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	/*
> +	 * Reusing handle is problematic as there are paths that refers
> +	 * the handle without lock. To avoid race, reject the callers that
> +	 * attempt it.
> +	 */
> +	if (handle && curr == entry) {
> +		WARN_ON(1);
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}

"handle" should never be a NULL. Or not?

> +
> +	curr_domain = pasid_array_entry_to_domain(curr);
> +	ret = 0;
> +
> +	if (curr_domain != domain) {

Is there a real use case where a caller needs to replace a domain with a
different attach handle? If not, let start from simple, just don't
support the same domain case...

> +		ret = __iommu_set_group_pasid(domain, group,
> +					      pasid, curr_domain);
> +		if (ret)
> +			goto out_unlock;
> +	}
> +
> +	if (curr != entry) {
> +		/*
> +		 * The above xa_cmpxchg() reserved the memory, and the
> +		 * group->mutex is held, this cannot fail.
> +		 */
> +		WARN_ON(xa_is_err(xa_store(&group->pasid_array,
> +					   pasid, entry, GFP_KERNEL)));
> +	}

... then the code could be simplified like this,

         curr_domain = pasid_array_entry_to_domain(curr);
         if (curr == entry || curr_domain == domain) {
                 ret = -EINVAL;
                 goto out_unlock;
         }

         ret = __iommu_set_group_pasid(domain, group, pasid, curr_domain);
         if (ret)
                 goto out_unlock;

         /*
          * The above xa_cmpxchg() reserved the memory, and the
          * group->mutex is held, this cannot fail.
          */
         WARN_ON(xa_is_err(xa_store(&group->pasid_array, pasid, entry, 
GFP_KERNEL)));

out_unlock:
         mutex_unlock(&group->mutex);
         return ret;

Anything overlooked?

> +
> +out_unlock:
> +	mutex_unlock(&group->mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid, "IOMMUFD_INTERNAL");
> +
>   /*
>    * iommu_detach_device_pasid() - Detach the domain from pasid of device
>    * @domain: the iommu domain.

Thanks,
baolu
