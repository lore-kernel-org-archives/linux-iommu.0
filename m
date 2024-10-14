Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC5DF9DA
	for <iommu@lists.linux.dev>; Mon, 14 Oct 2024 01:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728869109; cv=none; b=d5lhvE5qSWLUB5qIOfM2T/vFk2tIu6AtgdEGTPje4HS7t678uo5mrgmK9ia+ko8lRW/bAITK+uQuy6s34nnXKXOH4C9EaxE5jgZ5/9uEz8GCe9/dkCgYw5cUQwOANVlHeHzzLICZS8EhYIKxVA69FeOqQUbaEyjYUTWNIXPIXhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728869109; c=relaxed/simple;
	bh=/UGDAC+4PK1ck+fBKjjaMv0EW+NPqEfMx+m4dWl/y/g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=do/YWJa0HBiHNdEyBrjElU5jS8HBwWR5t/HzmqEewjufw4qHdpd46/eA11l4npKiGi+CDbJ0ZRLWbWJ/hp17/D8PJ3cwJ7mJd5hPwlUPDQTTE3zRjHeR8cpAG9XN2o8SNHA+w7PasAyW/Tqf5R+pxnsO8if3o+3+IzOO3tGEwRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DR9/Piwp; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DR9/Piwp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728869108; x=1760405108;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/UGDAC+4PK1ck+fBKjjaMv0EW+NPqEfMx+m4dWl/y/g=;
  b=DR9/Piwp9GCmnIrS7628fEwxs3R66gJpPcPw/d5wAmryUD5k0Zs3TicO
   1Xz7MHNQs0kXaWthNszrHX9+yLtEdOurBZgxN+jMGLukVjDu8H9Bl4gXl
   C8OpzrY276mJdEBJeT9qeUh5jgABqMnLFiIbDLooLYf2z/SC+bj0/btaV
   gAsp5Lkj4LSvC4pg3+7UexPkHE3jn5mpkOUGyzgNpPpCkxFovj7eTh7nU
   3O2wFeSZF+7sabrpet/Le59aHkFzshK7+H22X54Ap1DLybHGzRBY2dUH3
   +LnBUWAfqWz7slWNY1lhIvIUGo0B5rY5qHKSXx8UYFEn1B+b3cl1NchSU
   Q==;
X-CSE-ConnectionGUID: ZpdogJenSpWgzvc4XHfwIg==
X-CSE-MsgGUID: jwSXcqwYQTyHlFsoYrEZCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="38847170"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="38847170"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 18:25:08 -0700
X-CSE-ConnectionGUID: ynU1ahT2T1amC3rS/YcacQ==
X-CSE-MsgGUID: qCjarkRsQHu5eA7haGiJyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="81420591"
Received: from unknown (HELO [10.238.0.51]) ([10.238.0.51])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 18:25:06 -0700
Message-ID: <7f829e9e-5db9-4861-8a58-27a57edbd9da@linux.intel.com>
Date: Mon, 14 Oct 2024 09:25:03 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iommu/vt-d: Enhance compatibility check for paging
 domain attach
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20241011042722.73930-1-baolu.lu@linux.intel.com>
 <20241011042722.73930-4-baolu.lu@linux.intel.com>
 <20241011162703.GL762027@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20241011162703.GL762027@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/12 0:27, Jason Gunthorpe wrote:
> On Fri, Oct 11, 2024 at 12:27:18PM +0800, Lu Baolu wrote:
> 
>> @@ -1623,27 +1623,15 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
>>   
>>   	copied_context_tear_down(iommu, context, bus, devfn);
>>   	context_clear_entry(context);
>> -
>>   	context_set_domain_id(context, did);
>>   
>> -	/*
>> -	 * Skip top levels of page tables for iommu which has
>> -	 * less agaw than default. Unnecessary for PT mode.
>> -	 */
>> -	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
>> -		ret = -ENOMEM;
>> -		pgd = phys_to_virt(dma_pte_addr(pgd));
>> -		if (!dma_pte_present(pgd))
>> -			goto out_unlock;
>> -	}
> 
> Yikes, this is nasty racy stuff, glad to see it go
> 
> But should the agaw stuff be in its own patch?

The agaw stuff is now in the paging domain allocation path.

'agaw' represents the levels that the page table could support. With the
domain allocation callbacks always have a valid device pointer, the page
table levels of a domain could be determined during allocation.

When the domain is attached to a new device, the domain's levels will be
checked again the iommu capabilities of the device. If the iommu is not
capable of supporting the page levels, -EINVAL (not compatible) will be
returned, suggesting that the caller should use a new domain for the
device.

> 
>> @@ -3506,27 +3483,26 @@ int prepare_domain_attach_device(struct iommu_domain *domain,
>>   	if (domain->dirty_ops && !ssads_supported(iommu))
>>   		return -EINVAL;
>>   
>> -	/* check if this iommu agaw is sufficient for max mapped address */
>> -	addr_width = agaw_to_width(iommu->agaw);
>> -	if (addr_width > cap_mgaw(iommu->cap))
>> -		addr_width = cap_mgaw(iommu->cap);
>> -
>> -	if (dmar_domain->max_addr > (1LL << addr_width))
>> +	if (dmar_domain->iommu_coherency !=
>> +			iommu_paging_structure_coherency(iommu))
>>   		return -EINVAL;
>> -	dmar_domain->gaw = addr_width;
>> -
>> -	/*
>> -	 * Knock out extra levels of page tables if necessary
>> -	 */
>> -	while (iommu->agaw < dmar_domain->agaw) {
>> -		struct dma_pte *pte;
>> -
>> -		pte = dmar_domain->pgd;
>> -		if (dma_pte_present(pte)) {
>> -			dmar_domain->pgd = phys_to_virt(dma_pte_addr(pte));
>> -			iommu_free_page(pte);
>> -		}
>> -		dmar_domain->agaw--;
>> +
>> +	if (domain->type & __IOMMU_DOMAIN_PAGING) {
> 
> It looks like this entire function is already never called for
> anything but paging?
> 
> The only three callers are:
> 
> 	.default_domain_ops = &(const struct iommu_domain_ops) {
> 		.attach_dev		= intel_iommu_attach_device,
> 		.set_dev_pasid		= intel_iommu_set_dev_pasid,
> 
> and
> 
> static const struct iommu_domain_ops intel_nested_domain_ops = {
> 	.attach_dev		= intel_nested_attach_dev,
> 
> And none of those cases can be anything except a paging domain by
> definition.

A nested domain is not a paging domain. It represents a user-space page
table that nested on a parent paging domain. Perhaps I overlooked
anything?

> 
> So this if should go away, or be turned into a WARN_ON.
> 
> Jason

Thanks,
baolu
