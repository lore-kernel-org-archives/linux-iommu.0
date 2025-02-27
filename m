Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD9C17BA6
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 01:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740620065; cv=none; b=KW5QHN5oCODHV5j6WlTEtZIyY8HYlwL2E7qwV2ijFrYhLKYciNI8+U6HugKk+80lotMnRGqe3s4Lw9cUpJU8isNB24bUSPSm/9ONC/tXtWShvuz7EIITq0rCmDxyNtl/UgxxzRNwDQoKqhY42lC4meW+YMVz+3yOX83CjJPH2fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740620065; c=relaxed/simple;
	bh=yKJHFh4D9fIpKoj9SXkVAOzBlasSz2/WA937DGEpLMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mQX+j78eQkWj0UssbyY0TpBZsxMxD+MWowm3TRgff3DgzvJUBIsjaid6N2qKXJBa5pckuAUmgVDtL+YTbLF6jzVBQ8R6QDNuODJfoY9Bn6Y5+MksS5vNEDqxiQn7X48CRvFsYcFclupNEDAkYebXcSonq+JqHzlyLT5G/sQl41w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OkyWArEL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OkyWArEL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740620063; x=1772156063;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yKJHFh4D9fIpKoj9SXkVAOzBlasSz2/WA937DGEpLMY=;
  b=OkyWArELd6plEVjXn5dStAd7rLMIw97SDDNJ3SqknY6X+Jork/GAeja4
   QMhPACdfvqDzcG9+z2Sj+mk7BV2pg6+CdkZtq/A2l1cyJrHAdrZyGbxLQ
   O38UYyNtW3EAzyTJEvpiSaZ52Lwa+XWHjWQn+LyZ8inu9ltKg5ZmdThEg
   d1TUCcxHmB9m5BIGRHHsK7hXEFldYQu54g8rwOxsNpPrm96xYqh9hw59W
   gyE3aFZbXnqgePnt018hDmfetxT6KIKDzTCaXtvusGiooIFtI1GCeptKb
   ls7CNS4YQa9xBRkgvmYw+WUBOjmnWDsbgnh7xvntn+xZ+Psz1mifhvl8b
   Q==;
X-CSE-ConnectionGUID: SjEJhnY1R5aEHOA9w34gWA==
X-CSE-MsgGUID: EyhPtZiaTBSXxvIlKyxy4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="66867799"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="66867799"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 17:34:22 -0800
X-CSE-ConnectionGUID: RTxROSexSu6IT4BrLiHeRw==
X-CSE-MsgGUID: vmaL95JqQt2Ctl0V6TJnDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="116653086"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 17:34:21 -0800
Message-ID: <5c2d63d1-78ee-4466-9574-a6e4a2da8ee4@linux.intel.com>
Date: Thu, 27 Feb 2025 09:31:04 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/12] iommu: Introduce a replace API for device pasid
To: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, jgg@nvidia.com
Cc: joro@8bytes.org, iommu@lists.linux.dev, nicolinc@nvidia.com
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-3-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250226114032.4591-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/25 19:40, Yi Liu wrote:
> +/**
> + * iommu_replace_device_pasid_handle - Replace the domain that a pasid
> + *                                     is attached to
> + * @domain: the new iommu domain
> + * @dev: the attached device.
> + * @pasid: the pasid of the device.
> + * @handle: the attach handle.
> + *
> + * This API allows the pasid to switch domains. The @pasid should have been
> + * attached. Otherwise, this fails.
> + * The pasid will keep the old configuration if replacement failed.
> + * Return 0 on success, or an error.
> + */
> +int iommu_replace_device_pasid_handle(struct iommu_domain *domain,
> +				      struct device *dev, ioasid_t pasid,
> +				      struct iommu_attach_handle *handle)
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
> +	/* Not a replace case */
> +	if (!curr) {
> +		xa_release(&group->pasid_array, pasid);
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	curr_domain = pasid_array_entry_to_domain(curr);
> +	ret = 0;
> +
> +	if (curr_domain != domain) {
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
> +
> +out_unlock:
> +	mutex_unlock(&group->mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid_handle, "IOMMUFD_INTERNAL");

Perhaps you can compact your code with guard(muext). Something like
below:

         guard(mutex)(&group->mutex);
         entry = iommu_make_pasid_array_entry(domain, handle);
         curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
                           XA_ZERO_ENTRY, GFP_KERNEL);
         if (xa_is_err(curr))
                 return xa_err(curr);

         /* Not a replace case */
         if (!curr) {
                 xa_release(&group->pasid_array, pasid);
                 return -EINVAL;
         }

         curr_domain = pasid_array_entry_to_domain(curr);
         if (curr_domain == domain)
                 return 0;

         ret = __iommu_set_group_pasid(domain, group, pasid, curr_domain);
         if (ret)
                 return ret;

         /*
          * The above xa_cmpxchg() reserved the memory, and the
          * group->mutex is held, this cannot fail.
          */
         WARN_ON(xa_is_err(xa_store(&group->pasid_array, pasid, entry, 
GFP_KERNEL)));

         return 0;

Thanks,
baolu
