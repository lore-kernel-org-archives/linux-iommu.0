Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B81A192B91
	for <iommu@lists.linux.dev>; Tue,  5 Nov 2024 03:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730779167; cv=none; b=DjWogxX7aZlJQXx7KUzwtSZp0ZAMwh59h98oP3Y0lb6D2kl9N0UL/etcuRJjZQFQnbkJ2PfVPDfv1l0bfdTUzEOSm3aU+JrYHKzQHWPliJ2vu4dTefA1YBh5Unik0m/b6CiLT1nRwXbdpYP8ZzwsyjjAn5vLKbZSOOUu1JW4SKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730779167; c=relaxed/simple;
	bh=kGBq+d3R+Hh8of2SkeqKhgopn5RgHSwjU/41XNNpnHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CH43J2pQcoNJukM9yb/yhCwyhR51QT2ieWhihDNT7Ap/7/2R0N3Tlu3pWwz6+Bh7TjHM1XbBfXwzE3So3gD12Uj+XAzbum1TOmRC6rg0SaenxdUIP1cOKjEt71SYOXHJ4YD0kAe1NURupeBFqukXaxIf97voVZUmiZWYRbXRM3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+j10IX+; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+j10IX+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730779165; x=1762315165;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kGBq+d3R+Hh8of2SkeqKhgopn5RgHSwjU/41XNNpnHY=;
  b=l+j10IX+SPgWDai5vsQk/xGMawyFO4ruy3Q2be0FXTVF+Z1AhgNfjFX+
   GZfT8CaWXv1tvtU1fRjOQceJWIheaIpNIkEe/j0c8O0YfV3JVvOuheqrs
   GekhRbGT3+alPR7PwnH+6Sopi6qw5PhYthQwS8I2WKWTQ+H5iAYomQFzj
   QfKccpsIuGT+XIVuRz8/yKeRqiFpzv4DMcEXUwQrWVFZNbS+kLp/otl2n
   xvzfjoXphBCQ0k3DjB7tdSDFVvEXHOK0muo1vpSmGak6akXfJl7Q2ViTD
   eFM2NBrv1MogfH9GcMwMzxdUfj2h1XsEpnM33gQyTgBjqLtpFcSbp2r0g
   g==;
X-CSE-ConnectionGUID: pi1oplY+SBGrgQZHd9LXlg==
X-CSE-MsgGUID: jW7Fjb+JR5yAFU2CGgRbOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="30723644"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="30723644"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 19:59:25 -0800
X-CSE-ConnectionGUID: FVn2spouSmy40ipyVhKgog==
X-CSE-MsgGUID: ZkKyxblLSdmPZUtvB47/IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; 
   d="scan'208";a="84192702"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 19:59:22 -0800
Message-ID: <9846d58f-c6c8-41e8-b9fc-aa782ea8b585@linux.intel.com>
Date: Tue, 5 Nov 2024 11:58:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/12] iommu: Introduce a replace API for device pasid
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, vasant.hegde@amd.com
References: <20241104132513.15890-1-yi.l.liu@intel.com>
 <20241104132513.15890-2-yi.l.liu@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241104132513.15890-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/24 21:25, Yi Liu wrote:
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
> +	if (!domain->ops->set_dev_pasid)
> +		return -EOPNOTSUPP;
> +
> +	if (!group)
> +		return -ENODEV;
> +
> +	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner ||
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

The iommu drivers can only flush pending PRs in the hardware queue when
__iommu_set_group_pasid() is called. So, it appears more reasonable to
reorder things like this:

	__iommu_set_group_pasid();
	switch_attach_handle();

Or anything I overlooked?

> +	if (!curr) {
> +		xa_erase(&group->pasid_array, pasid);
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	ret = xa_err(curr);
> +	if (ret)
> +		goto out_unlock;
> +
> +	if (curr->domain == domain)
> +		goto out_unlock;
> +
> +	ret = __iommu_set_group_pasid(domain, group, pasid, curr->domain);
> +	if (ret)
> +		WARN_ON(handle != xa_store(&group->pasid_array, pasid,
> +					   curr, GFP_KERNEL));
> +out_unlock:
> +	mutex_unlock(&group->mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid, IOMMUFD_INTERNAL);
> +
>   /*
>    * iommu_detach_device_pasid() - Detach the domain from pasid of device
>    * @domain: the iommu domain.

--
baolu
