Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFF4800
	for <iommu@lists.linux.dev>; Fri, 20 Dec 2024 03:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734665568; cv=none; b=SBzCqJMuwuUI5wC1/C6GAKJwTXyYB9FiKynH3ytkbnisQgPdB2OA9khakyznwc6fVtNIIE8+pedA4vHMXi3rOrdC3/aGBVbdnYgXAb254v5a5VkubImI4ZNSpwrvxv65G899A1Dn+c2VF3oamgHQ3MexUe/IIR+26V0C/3qtqp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734665568; c=relaxed/simple;
	bh=tzwrjYI2kRtktBkgUXO14r3tN4Ap7GNJE9FPTljqlbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iU8dgvp7Dm6WfF1orE9u4un4vN80jJU+kM8QaXp8Z5YKv93TdtOVItE5WmortJXSQ6cAH5wJ04GF634zk1gK+F7Lu4HBFglHnWrvNIBuK0bWAR3Fk4OdfoWNvn7vBrUSYFnpBJFvhMiBvXIt5w+KShnpu71R68lMK4A2xHnNMmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENd+ALmo; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENd+ALmo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734665566; x=1766201566;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tzwrjYI2kRtktBkgUXO14r3tN4Ap7GNJE9FPTljqlbg=;
  b=ENd+ALmoInrSRXs8j9Nqbsgx4XGqlrnfeWtqnIYIkdyWk6JTx9iQaRcK
   /KdddDi0TpygK3JqDizI5aJQYyc3kEOAWCcZBxbTFHMbx5h4WgSPOuoi0
   F8LhDtOIxtA1DNMLpaUvxDL6v3NEGVF8H0PgBylOvKsjuayRNce0I3KAH
   x0trP5EVMaQqo7o37j8L2nA42PXotlchsJCakfl7l+lqbzm6WAK+PpC24
   0H4yz73NYtN/CIX9Wn68XAqMpwQhXyJ3IXq/6MfM5CD9JWZsmszkr2BXo
   8eGM/Zoq2PiumRjmoMh23tXTxMgoubh8n0M/YIFd/4rK6G+2+ygy5gu6a
   A==;
X-CSE-ConnectionGUID: /ebEcUOAR+G5HCnllDOFBQ==
X-CSE-MsgGUID: OprPuwlxT/i9pje6mK2byw==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="35372486"
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="35372486"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 19:32:45 -0800
X-CSE-ConnectionGUID: B7kQJmOIRECwugTPGL22RQ==
X-CSE-MsgGUID: ZsgceLDDTdul/8EVsSuBGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="103266530"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 19:32:43 -0800
Message-ID: <a2f363e7-88e4-46ef-8755-8a5e0cc47ecc@linux.intel.com>
Date: Fri, 20 Dec 2024 11:31:03 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/14] iommufd: Move the iommufd_handle helpers to
 device.c
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: eric.auger@redhat.com, nicolinc@nvidia.com, chao.p.peng@linux.intel.com,
 iommu@lists.linux.dev, vasant.hegde@amd.com, will@kernel.org
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-4-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241219132746.16193-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/24 21:27, Yi Liu wrote:
> The iommu_attach_handle is now only passed when attaching iopf-capable
> domain, while it is not convenient for the iommu core to track the
> attached domain of pasids. To address it, the iommu_attach_handle will
> be passed to iommu core for non-fault-able domain as well. Hence the
> iommufd_handle related helpers are no longer fault specific, it makes
> more sense to move it out of fault.c.
> 
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/device.c          | 62 +++++++++++++++++++++++++
>   drivers/iommu/iommufd/fault.c           | 56 +---------------------
>   drivers/iommu/iommufd/iommufd_private.h |  8 ++++
>   3 files changed, 72 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index dfd0898fb6c1..0e1baf84e887 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -293,6 +293,68 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
>   }
>   EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, "IOMMUFD");
>   
> +/**
> + * iommufd_device_get_attach_handle - Return the attach handle for the RID
> + *
> + * @idev: The device to get attach_handle
> + *
> + * Currently there is no locking to synchronize threads that access the
> + * returned handle with those attaching or replacing the domain which might
> + * change the handle. It's caller's duty to guarantee no use-after-free.

It's better to make "It's caller's duty to guarantee no use-after-free"
more specific. Something like, the caller is responsible for ensuring
that the returned pointer is not used after the domain is removed from
the device's RID.

> + *
> + * Return valid attach_handle if there is, otherwise NULL.
> + */
> +struct iommufd_attach_handle *
> +iommufd_device_get_attach_handle(struct iommufd_device *idev)
> +{
> +	struct iommu_attach_handle *handle;
> +
> +	handle = iommu_attach_handle_get(idev->igroup->group, IOMMU_NO_PASID, 0);
> +	if (IS_ERR(handle))
> +		return NULL;
> +
> +	return to_iommufd_handle(handle);
> +}
> +
> +int iommufd_dev_attach_handle(struct iommufd_hw_pagetable *hwpt,
> +			      struct iommufd_device *idev)
> +{
> +	struct iommufd_attach_handle *handle;
> +	int ret;
> +
> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> +	if (!handle)
> +		return -ENOMEM;
> +
> +	handle->idev = idev;
> +	ret = iommu_attach_group_handle(hwpt->domain, idev->igroup->group,
> +					&handle->handle);
> +	if (ret)
> +		kfree(handle);
> +
> +	return ret;
> +}
> +
> +int iommufd_dev_replace_handle(struct iommufd_device *idev,
> +			       struct iommufd_hw_pagetable *hwpt,
> +			       struct iommufd_hw_pagetable *old)
> +{
> +	struct iommufd_attach_handle *handle;
> +	int ret;
> +
> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
> +	if (!handle)
> +		return -ENOMEM;
> +
> +	handle->idev = idev;
> +	ret = iommu_replace_group_handle(idev->igroup->group,
> +					 hwpt->domain, &handle->handle);
> +	if (ret)
> +		kfree(handle);
> +
> +	return ret;
> +}

Where will the old handle be freed? It seems unreasonable to allocate
the handle in these helper functions, only to have it freed by callers
in other files.

Thanks,
baolu
