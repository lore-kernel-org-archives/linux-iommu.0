Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116C119E7FA
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305831; cv=none; b=QtlFpqhA/V8AeVyXKPBsNU5TlWphM8IcYYyNTX7iwaWCqrgC995zU+52O2aZyL/JzXJF8uIKez4BKx6cOg5kWZCO/myxnqGDKrraKS9a5msQjW/b/tdZz1sdfYHxPQmhl8fIcuQfkUCuc0rwTpl2BgptGD+8MxrJ1ZeNo7h8mws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305831; c=relaxed/simple;
	bh=qP3fvc4Dfpr9tBsfZuw+Oza0mw5eWl4ajkiYlF9OWDU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H7X/rccfOWt0htR8guMe7+Kk93VUR3r5bfZ/1IECKlYBMyx/ahHFtsNfTqD2nW9KOe9on5Cff847jE4w5E9XehiOr+9+OJevmzJWsM1GAC/yGWYxbnB6ZYWLsS/uLTcZkIWnSHxDoDdM6RaXryrCoSjrwyQpbBk9W6YG08s8s5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=at6Tt4x8; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="at6Tt4x8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742305830; x=1773841830;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qP3fvc4Dfpr9tBsfZuw+Oza0mw5eWl4ajkiYlF9OWDU=;
  b=at6Tt4x8trq9msWqbNpCIW+RVtwdw1Bc6uijJCf6UqHbSjfrXnwyoR3j
   ZxhH7FAzpnsv2E48HYnxCbH8QL8mYZ9LBv1Ku3tizZPPcmxwAwL5HuJp8
   gsp9JaZwuCQ2MHDlzQZ2rpJJwURYs4OJ+QRvLZWSEbRz9YA7LubwQRh52
   Y5uTqb0xPrvmKw30QYDwP5ogA/1rAacweTaiSjYsYoc+4ZI0YkI4jTi6J
   ih/+EcUoVa/cw//0MZFKzCkFSRwYpatw8BnM+vKsxN9975nubUC+gg1yv
   PTxTamYDNpLsY3UWKDqFk9wN9IlMeoSiCE8nK8QXDX+Ubg8gekatfanSY
   Q==;
X-CSE-ConnectionGUID: dhbU11jVTt62iZ+Rl+8BHw==
X-CSE-MsgGUID: /0xiGn1zQO+auzPARvGXBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="47334131"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="47334131"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 06:50:24 -0700
X-CSE-ConnectionGUID: USk7+2nBQ/yU0ErM3QgDLw==
X-CSE-MsgGUID: HRdPiBGeRieS0ZeuvVat5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="159429236"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.241.41]) ([10.124.241.41])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 06:50:22 -0700
Message-ID: <4cadf709-cd24-46f1-a0d7-029dfdc1842c@linux.intel.com>
Date: Tue, 18 Mar 2025 21:50:20 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, kevin.tian@intel.com, joro@8bytes.org,
 iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v9 03/21] iommu: Introduce a replace API for device pasid
To: Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-4-yi.l.liu@intel.com>
 <20250318121941.GF9311@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250318121941.GF9311@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/2025 8:19 PM, Jason Gunthorpe wrote:
> On Thu, Mar 13, 2025 at 05:35:14AM -0700, Yi Liu wrote:
>> +int iommu_replace_device_pasid(struct iommu_domain *domain,
>> +			       struct device *dev, ioasid_t pasid,
>> +			       struct iommu_attach_handle *handle)
>> +{
>> +	/* Caller must be a probed driver on dev */
>> +	struct iommu_group *group = dev->iommu_group;
>> +	struct iommu_domain *curr_domain;
>> +	void *curr;
>> +	int ret;
>> +
>> +	if (!group)
>> +		return -ENODEV;
>> +
>> +	if (!domain->ops->set_dev_pasid)
>> +		return -EOPNOTSUPP;
>> +
>> +	if (dev_iommu_ops(dev) != domain->owner ||
>> +	    pasid == IOMMU_NO_PASID || !handle)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&group->mutex);
>> +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
>> +			  XA_ZERO_ENTRY, GFP_KERNEL);
>> +	if (xa_is_err(curr)) {
>> +		ret = xa_err(curr);
>> +		goto out_unlock;
>> +	}
>> +
>> +	/*
>> +	 * No domain (with or without handle) attached, hence not
>> +	 * a replace case.
>> +	 */
>> +	if (!curr) {
>> +		xa_release(&group->pasid_array, pasid);
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +
>> +	curr_domain = pasid_array_entry_to_domain(curr);
>> +	ret = 0;
>> +
>> +	if (curr_domain != domain) {
>> +		ret = __iommu_set_group_pasid(domain, group,
>> +					      pasid, curr_domain);
>> +		if (ret)
>> +			goto out_unlock;
>> +	}
>> +
>> +	/*
>> +	 * The above xa_cmpxchg() reserved the memory, and the
>> +	 * group->mutex is held, this cannot fail.
>> +	 */
>> +	iommu_group_pasid_store(group, pasid, curr, domain, handle);
> This has the order problem as well :\
> 
> It is really problematic to fix since either placement of the store is
> creating error case bugs.
> 
> Maybe we need to give up on having the driver fence the PRI hidden
> inside attach calls and directly add a new fault fencing op. Then the
> core code can sequence the fencing as required to make all the error
> cases work and the driver doesn't see the complexity?

Good suggestion. A new fault fencing op will make the code much simpler.
Basically, iommu_replace_device_pasid() could be implemented like this:

- Replace the new domain on the hardware.
- Store the new handle in the xarray.
- Fence the PRI.

Before PRI fencing, the outstanding IOPFs might be routed through the
new or old handle, but that doesn't matter, as we discussed before.
After the PRI fencing, all IOPFs will use the new handle, and there will
not be any UAF issues anymore.

Do I understand it right?

Thanks,
baolu
