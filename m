Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAA92594B7
	for <iommu@lists.linux.dev>; Fri, 20 Dec 2024 02:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734662952; cv=none; b=Wi3H3fj2TDNl3zGX2c7QsJnoi/gfBBi1hcVIQPMN2paErb19EY7OykCqHyFunYdk/6JzvwNkgKCVyVEDyZ6icQ7ZQR85SqrBcQtPTT9qZD0veeaiHSTZaInRRGbvl+HDsmOqOSag1jx/B12LUjWZ3j8swIJ/t3/sGvGxUPUmhDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734662952; c=relaxed/simple;
	bh=Wn9hC+zL5oUv/1XyzbIM0DzONa2fE4aCDLKICttGjUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSniPV4epAPvN4nLITxn8igRk8aXkW37e2sYGzoU6neXGavKT98kySNPHDMz9jGpt5d576h+djCoO1hHnFOP5vDGN0mv2JyDECHI2aU1rUxOXkRMq57oNU/D4/iMnZMc0SJViDvm9C/Vzg+OOsQrq0SBB1XwOoX+IxtuQQO+5ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXW/kCLH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXW/kCLH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734662950; x=1766198950;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wn9hC+zL5oUv/1XyzbIM0DzONa2fE4aCDLKICttGjUM=;
  b=KXW/kCLHYGvNAczQ1v/gjj7pZMtEUUqu8SsFKUBeFCjjiG1fesE+ins2
   4KHFQny6t0NrcXB8zSTSeMNjyfDvX4UYTwLiQy6D/ec8RE9FQWILzHKuP
   1CD4J0FFlqroKslFMpYyMf+3+i03Ko7yKixg1H8vFq7lQH1XxYhczV88k
   kXOEP2nqPCPgxRjKrOSSXqI9qfl7KZLfjZLjqxqqaEdMPkOUwibeNeuxM
   ycNL7yKCSbX1jbaK0UBL8X6bR1GOLxaCmnr/rw7XtYA2GSuKEFruNLqYv
   0MYWtGHrkBy5P8USgeaFsUt+D1IoXrbkUzf7b8uG/GkbMvVfuLC3w71b/
   w==;
X-CSE-ConnectionGUID: wA0pAG3xTrKGiu83U+wGhw==
X-CSE-MsgGUID: 80l+sqUgSWiec8zUGpOCkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="60586840"
X-IronPort-AV: E=Sophos;i="6.12,249,1728975600"; 
   d="scan'208";a="60586840"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 18:49:09 -0800
X-CSE-ConnectionGUID: fkZ+aafpTNCOLeLgfOn0Dw==
X-CSE-MsgGUID: eyjSScBrQaG5Ldcnng9stg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="99208836"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 18:49:07 -0800
Message-ID: <2eb64aac-2a17-4026-90ce-4e0c6e06d89f@linux.intel.com>
Date: Fri, 20 Dec 2024 10:47:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: eric.auger@redhat.com, nicolinc@nvidia.com, chao.p.peng@linux.intel.com,
 iommu@lists.linux.dev, vasant.hegde@amd.com, will@kernel.org
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-2-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241219132746.16193-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/24 21:27, Yi Liu wrote:
> +/**
> + * iommu_replace_device_pasid - Replace the domain that a pasid is attached to
> + * @domain: the new iommu domain
> + * @dev: the attached device.
> + * @pasid: the pasid of the device.
> + * @handle: the attach handle.
> + *
> + * This API allows the pasid to switch domains. Return 0 on success, or an
> + * error. The pasid will keep the old configuration if replacement failed.
> + * This is supposed to be used by iommufd, and iommufd can guarantee that
> + * both iommu_attach_device_pasid() and iommu_replace_device_pasid() would
> + * pass in a valid @handle.
> + */
> +int iommu_replace_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid,
> +			       struct iommu_attach_handle *handle)
> +{
> +	/* Caller must be a probed driver on dev */
> +	struct iommu_group *group = dev->iommu_group;
> +	struct iommu_attach_handle *curr;
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
> +	handle->domain = domain;
> +
> +	mutex_lock(&group->mutex);
> +	/*
> +	 * The iommu_attach_handle of the pasid becomes inconsistent with the
> +	 * actual handle per the below operation. The concurrent PRI path will
> +	 * deliver the PRQs per the new handle, this does not have a functional
> +	 * impact. The PRI path would eventually become consistent when the
> +	 * replacement is done.
> +	 */
> +	curr = (struct iommu_attach_handle *)xa_store(&group->pasid_array,
> +						      pasid, handle,
> +						      GFP_KERNEL);

The pointer type cast seems unnecessary.

> +	if (!curr) {
> +		xa_erase(&group->pasid_array, pasid);
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	ret = xa_err(curr);
> +	if (ret)
> +		goto out_unlock;

xa_store() returns either the old pointer or an error code. It's better
to handle error code first, as shown below:

	/* Failed to store the new pointer: */
	if (xa_is_err(curr)) {
		ret = xa_err(curr);
		goto out_unlock;
	}

	/* Not a replace case: */
	if (!curr) {
		xa_erase(&group->pasid_array, pasid);
		ret = -EINVAL;
		goto out_unlock;
	}

Your code is already functional, just suggest making it more readable.

Thanks,
baolu
