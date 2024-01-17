Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A12D510
	for <iommu@lists.linux.dev>; Wed, 17 Jan 2024 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705479772; cv=none; b=X5Ka+nOMztfrsd2bJzZwBa3JIi4dhZW08Hms5rQhb3r95erJVw2lkwWkJkcv8ADvIJfEtNJ58b+AhHh3Zkn43z7PfhprWUhUjF8A6F5JkQqUNXrZ8VPwKt302oQQFlOv59MBP97TmmAUn9ktilIZYBnkmcbbHuGphP0vKsIciuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705479772; c=relaxed/simple;
	bh=dTAKx/WvnyQYbWUeQpGK8e4j06ZQKp/QZZb2qlq8/9Q=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Cc:Subject:Content-Language:To:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding; b=p87QdJQwm1JygkGoKgdGHGqvHqT3cvqjMDcB7KYRlaK8E1dIxPBc8mJCZ7n6eeKCX+kogQaoiY5LaNLhcdo2GAncUX0hJLizUvssNQzpiVW0eWos9SXaxpFi5BoIbNYsU0q+Jj6yOlKUsO6VW8Xm6VJxauenI/INyEd5SFoIriI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HltszBHj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HltszBHj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705479771; x=1737015771;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dTAKx/WvnyQYbWUeQpGK8e4j06ZQKp/QZZb2qlq8/9Q=;
  b=HltszBHjE8wThCIX9pne5+mJRyDRMwn+bwmWE4ro/AYTifvG3llPv5lZ
   Jsnt0mYZFRWL61TKU5DyacYwDeA1PYKrD2ECqV0Smdq1NUTdi7uP9ruxX
   /VN+Vm841dQiyLRfcnXzqsPIFe/baeM1l1b0LTOd4rCQ2A6eKLvz97+Tl
   maGbjjMbJIPAaSHE1WD74hmJRA1/xp5Am8m78XEGNq/nvSgPzBTJYRMF3
   7C3XG6JVE0uL53CTwGKImE3phZO100WszGM67qZx/2sKEGpSRL+2hOp21
   EwaGm304EZBIug+DX1Dz2oce+sK5NCclj+EW4YVx5+RUxegDObPfEVQba
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="6863982"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="6863982"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 00:21:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="777373768"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="777373768"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.146]) ([10.249.171.146])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 00:20:52 -0800
Message-ID: <880545b0-82ae-4d3c-b9e5-e623a4c79c5d@linux.intel.com>
Date: Wed, 17 Jan 2024 16:20:50 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, joro@8bytes.org, alex.williamson@redhat.com,
 kevin.tian@intel.com, robin.murphy@arm.com, cohuck@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
 mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
 yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
 shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com, xin.zeng@intel.com,
 yan.y.zhao@intel.com
Subject: Re: [PATCH 8/8] iommu/vt-d: Add set_dev_pasid callback for nested
 domain
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <20231127063428.127436-1-yi.l.liu@intel.com>
 <20231127063428.127436-9-yi.l.liu@intel.com>
 <20240115172213.GM734935@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240115172213.GM734935@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/16 1:22, Jason Gunthorpe wrote:
> On Sun, Nov 26, 2023 at 10:34:28PM -0800, Yi Liu wrote:
> 
>> +static int intel_nested_set_dev_pasid(struct iommu_domain *domain,
>> +				      struct device *dev, ioasid_t pasid)
>> +{
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> +	struct intel_iommu *iommu = info->iommu;
>> +	struct dev_pasid_info *dev_pasid;
>> +	unsigned long flags;
>> +	int ret = 0;
>> +
>> +	if (!pasid_supported(iommu))
>> +		return -EOPNOTSUPP;
>> +
>> +	if (iommu->agaw < dmar_domain->s2_domain->agaw)
>> +		return -EINVAL;
>> +
>> +	ret = prepare_domain_attach_device(&dmar_domain->s2_domain->domain, dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dev_pasid = kzalloc(sizeof(*dev_pasid), GFP_KERNEL);
>> +	if (!dev_pasid)
>> +		return -ENOMEM;
>> +
>> +	ret = domain_attach_iommu(dmar_domain, iommu);
>> +	if (ret)
>> +		goto err_free;
>> +
>> +	ret = intel_pasid_setup_nested(iommu, dev, pasid, dmar_domain);
>> +	if (ret)
>> +		goto err_detach_iommu;
>> +
>> +	dev_pasid->dev = dev;
>> +	dev_pasid->pasid = pasid;
>> +	spin_lock_irqsave(&dmar_domain->lock, flags);
>> +	list_add(&dev_pasid->link_domain, &dmar_domain->dev_pasids);
>> +	spin_unlock_irqrestore(&dmar_domain->lock, flags);
>> +
>> +	return 0;
>> +err_detach_iommu:
>> +	domain_detach_iommu(dmar_domain, iommu);
>> +err_free:
>> +	kfree(dev_pasid);
>> +	return ret;
>> +}
> This seems alot longer than I'd think it should be, why isn't it
> exactly the same code as the other set_dev_pasid's?

Yes. It should be. The only difference is how to configure the pasid
entry.

Best regards,
baolu
