Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C061C36
	for <iommu@lists.linux.dev>; Thu, 20 Jun 2024 01:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718846219; cv=none; b=a9RLdo1Kfdbpjmr6TaZOOnEeZJlhHkIYlBBM2SozP32KbfulokLqVBc66qxKIfGoQY7NC3l3zf6bMbeqeI3gilEu3Y+h0pumfyYxf9e3Q6ujTwpFI/fd6O18fA6lPOo1zibgFh1V1zPkXIcYiKPzOF3eigiSqm3KFTNtWDESVbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718846219; c=relaxed/simple;
	bh=eiW/MHJ0UdJLO8lrujvSRMTbc/MZOUzVpzfOqp/fsrc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=odt4moXZVu7anL9vMtSq2XFuyzAi1MBBajKcOFb5hbtP2jbOiymYjYec6BglWIwFiGfblmDpZfeG+uT9pcboAJFKfEKYTgxf1SwgAIjXD2uM/hFOWD9Ue3XMRYDcCJU8oKnkHs1QVAFm7/82I4o5Kime9o691aXOqPNjEFdya0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ARvqJxjU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ARvqJxjU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718846218; x=1750382218;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eiW/MHJ0UdJLO8lrujvSRMTbc/MZOUzVpzfOqp/fsrc=;
  b=ARvqJxjUcYfCGDypHHqellxYCiY1ltlsCvbao583AlcOxV+HPN8qWz+V
   v1ZI9boDqBjIYezWSQSKtQuJpxxkAKRa1Mw+fCg/w4rA6Um04h9PxWf4q
   8a6rTRPTFWCBd00TB087dM69UquvYrIeKotU5L4UbzN4VWvVWfflDDlxd
   b6Kkmww4ghP8EJBex6whINwx6Ath0sSaYQdRfWiBmISnIY5KkRqZRDcWW
   hFDKO3CXUkbuf8Vf9GuAUyPGnlwPoBpe4HFhIVMFJ32NSeZktntWLw1nh
   8CzXz01eO3+lDID4NGvr/YxLclLUSOi55821mro8Ds/6nh+zRX/Fm5x3P
   g==;
X-CSE-ConnectionGUID: w8jeY3DzSLKrYX51C6Ww7w==
X-CSE-MsgGUID: x7klGInrRmWrH55YiiefXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="18715947"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="18715947"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 18:16:57 -0700
X-CSE-ConnectionGUID: DcNvoBqKR3Cd0EDhpcHZ6A==
X-CSE-MsgGUID: koFwvhFKTT2QQL91tyJqgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="73272079"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 19 Jun 2024 18:16:52 -0700
Message-ID: <d4cfdc8f-12a4-44d1-85ee-ce05dd88b3e3@linux.intel.com>
Date: Thu, 20 Jun 2024 09:14:24 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Kalle Valo <kvalo@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
 Jason Wang <jasowang@redhat.com>, Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, iommu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/21] iommu/vt-d: Add helper to allocate paging domain
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240610085555.88197-1-baolu.lu@linux.intel.com>
 <20240610085555.88197-16-baolu.lu@linux.intel.com>
 <20240619151254.GI1091770@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240619151254.GI1091770@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/24 11:12 PM, Jason Gunthorpe wrote:
> On Mon, Jun 10, 2024 at 04:55:49PM +0800, Lu Baolu wrote:
>> The domain_alloc_user operation is currently implemented by allocating a
>> paging domain using iommu_domain_alloc(). This is because it needs to fully
>> initialize the domain before return. Add a helper to do this to avoid using
>> iommu_domain_alloc().
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 87 +++++++++++++++++++++++++++++++++----
>>   1 file changed, 78 insertions(+), 9 deletions(-)
> It seems Ok, but I have some small thoughts
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> 
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index 2e9811bf2a4e..ccde5f5972e4 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -3633,6 +3633,79 @@ static struct iommu_domain blocking_domain = {
>>   	}
>>   };
>>   
>> +static int iommu_superpage_capability(struct intel_iommu *iommu, bool first_stage)
>> +{
>> +	if (!intel_iommu_superpage)
>> +		return 0;
>> +
>> +	if (first_stage)
>> +		return cap_fl1gp_support(iommu->cap) ? 2 : 1;
>> +
>> +	return fls(cap_super_page_val(iommu->cap));
>> +}
>> +
>> +static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_stage)
>> +{
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct intel_iommu *iommu = info->iommu;
>> +	struct dmar_domain *domain;
>> +	int addr_width;
>> +
>> +	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>> +	if (!domain)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	INIT_LIST_HEAD(&domain->devices);
>> +	INIT_LIST_HEAD(&domain->dev_pasids);
>> +	INIT_LIST_HEAD(&domain->cache_tags);
>> +	spin_lock_init(&domain->lock);
>> +	spin_lock_init(&domain->cache_lock);
>> +	xa_init(&domain->iommu_array);
> You should probably split more, with an 'alloc struct dmar_domain'
> function that can be used by SVA and others too.
> 
>> +	domain->nid = dev_to_node(dev);
>> +	domain->has_iotlb_device = info->ats_enabled;
>> +	domain->use_first_level = first_stage;
>> +
>> +	/* calculate the address width */
>> +	addr_width = agaw_to_width(iommu->agaw);
>> +	if (addr_width > cap_mgaw(iommu->cap))
>> +		addr_width = cap_mgaw(iommu->cap);
>> +	domain->gaw = addr_width;
>> +	domain->agaw = iommu->agaw;
>> +	domain->max_addr = __DOMAIN_MAX_ADDR(addr_width);
>> +
>> +	/* iommu memory access coherency */
>> +	domain->iommu_coherency = iommu_paging_structure_coherency(iommu);
>> +
>> +	/* pagesize bitmap */
>> +	domain->domain.pgsize_bitmap = SZ_4K;
>> +	domain->iommu_superpage = iommu_superpage_capability(iommu, first_stage);
>> +	domain->domain.pgsize_bitmap |= domain_super_pgsize_bitmap(domain);
> Then some of this stuff is really just paging only. Like
> SVA/identity/etc don't have pgszie and other things.

Yeah, good suggestion. I could do this in this series if it needs a new
version or in my next series which will add domain_alloc_paging for the
intel driver.

Best regards,
baolu
