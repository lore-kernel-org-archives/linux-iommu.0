Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7726E1DB551
	for <iommu@lists.linux.dev>; Thu, 17 Jul 2025 02:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752720125; cv=none; b=rxtkorRp7bPSB7HYF/Piq4JI+Huha7UO6nkHPw5xc1CLflJCIUGSBzUirtFU37YFZvWyLn1L/D1EdJF58ZB8ziazkvIw7H7tNkutHlt7A3dXh1NvaMoAeyS8pVq4j7pNcNmNbdo5O3UXHibN9Ko4M/fYF46Lhf9Z9ecHmEe/iRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752720125; c=relaxed/simple;
	bh=WIpCLItC2ezfA0UV9Dlo9EYwXZqp5BLSvGaPx6T5xOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ojj2rhxgD/D0cmFRMJ0bKwePTCymULyYVIfsCp3m9aDZZJ15ZnqGQlDd5Q1XllrKtX+PrFLPMpQGuBZ28/XJpyvaZXASWZ+7BbNCdQ0gnzdOefNnRauxG/mFa2z9tBrMygPEdLjzuzsRQmhKN9f1Xnzj8iA/t3vtdc3BR9WR8vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJ7vt248; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJ7vt248"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752720123; x=1784256123;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WIpCLItC2ezfA0UV9Dlo9EYwXZqp5BLSvGaPx6T5xOE=;
  b=YJ7vt248IcAb9IGO/dC5ZgUk1vKPJwp74SDqMLtL2yWwFl6Kve+p2t0A
   6+mN0pdmS+hBxy1T2zoiFjcqdsCXoP8hzgrJsGFUkeczGrVsiskwlRNks
   Mxinidge/CYazsUUeaQjRjdtMC6hDTz62DFFRbRjlEtFK1mqdhWzN1rky
   9PhgO9r2+DksAXdg6yfv6SHMusahyAjUyreDRfZYP2ZvRTMgCtxXj6mXx
   whPQN+dZ+xbUvuH22VsFAt7zzs7ktWgiDH6TqIAIB1l0RwE2osX25IwO9
   fdwUMn59EqM9+l06OggGAiqvnDyMn4Qxjea2lYw//Gr7OoJT2wFOxq7Rv
   g==;
X-CSE-ConnectionGUID: hmMn9OVNSci2vC0YHnlZBQ==
X-CSE-MsgGUID: HnsWk1J7QxiX5wKUtVGLAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="55131652"
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="55131652"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 19:41:55 -0700
X-CSE-ConnectionGUID: sPRbPZyyTUK4BL9DzAqfRg==
X-CSE-MsgGUID: vAzme0n+QtizLgyIyw6dmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,317,1744095600"; 
   d="scan'208";a="163300039"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 19:41:54 -0700
Message-ID: <8aedbbcc-9f4c-4700-acb7-43ec4f540135@linux.intel.com>
Date: Thu, 17 Jul 2025 10:40:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] iommu/vt-d: Optimize iotlb_sync_map for
 non-caching/non-RWBF modes
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250714045028.958850-1-baolu.lu@linux.intel.com>
 <20250714045028.958850-3-baolu.lu@linux.intel.com>
 <20250716141218.GA2166806@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250716141218.GA2166806@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/16/25 22:12, Jason Gunthorpe wrote:
> On Mon, Jul 14, 2025 at 12:50:19PM +0800, Lu Baolu wrote:
>> @@ -1833,6 +1845,8 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>>   	if (ret)
>>   		goto out_block_translation;
>>   
>> +	domain->iotlb_sync_map |= domain_need_iotlb_sync_map(domain, iommu);
> 
> This has no locking and is in the wrong order anyhow :(
> 
> Any change to how invalidation works has to be done before attaching
> the HW so that the required invalidations are already happening before
> the HW can walk the page table.
> 
> And you need to serialize somehow with concurrent map/unmap as iommufd
> doesn't prevent userspace from racing attach with map/unmap.

domain->iotlb_sync_map does not change the driver's behavior. It simply
indicates that there's no need to waste time calling
cache_tag_flush_range_np(), as it's just a no-op.

> 
> The cache_tag_assign_domain() looks similarly wrong too, it needs to
> start invalidating the cache tag of the new domain, then change the
> context then stop invalidating the cache tag of the old
> domain. Otherwise there are invalidation races.
> 
> Finally, if the HW needs RWBF then this also needs to do the buffer
> flush in this thread before installing the context to prevent a race.
> 
> Overall this dynamic behavior may just be a bad idea, and perhaps you
> can live with domains having the domain->iotlb_sync_map as a static
> property set once during paging domain allocation.
> 
> If the iommu requires iotlb_sync_map but the domain does not have it
> then the attach is rejected. This reduces domain sharing
> possibilities, but maybe that is just fine??

I previously discussed this with Kevin, and we agreed on a phase-by-
phase approach. As I mentioned, domain->iotlb_sync_map is merely a hint
for the driver, preventing it from looping through all cache tags to
determine if any cache invalidation work needs to be performed. We
already know it's predetermined that no work needs to be done.

RWBF is only required on some early implementations where memory
coherence was not yet implemented by the VT-d engine. It should be
difficult to find such systems in modern environments. Thus,
iotlb_sync_map is primarily relevant for nested translation that
utilizes S2 shadowing page tables. This, too, is a legacy feature, as
Intel has supported hardware-assisted nested translation for years.

Making iotlb_sync_map static is a feature, not an optimization. We are
still evaluating the value of this, as it's only truly helpful if there
are real use cases.

Thanks,
baolu
