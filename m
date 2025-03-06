Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323CC1362
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 03:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741231363; cv=none; b=K/Hm+qGlqJhi2xL2IUeP22e8ppavC0BM/VbFp39Q996JPR3v7TbhRjgneVLKcrsQGsU8ifjiv5qaZHRVK/2I3svTy11wHFYoQGCUuDGtwTLP9MvmPvNKiwzgTxPiVxlt5s3vR2wLicJlnKt6C6EjLG0w6ct9ugJsGOLqPf39sCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741231363; c=relaxed/simple;
	bh=NAkqSxZxIYJbA34rN88SL/2ptvc58O77///ilOXA/vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5XvSPZg5mGfQao/AOlzfd7P3H74wu/aC1cMOGz7dLwJSA+tC3GJYMXQDaCVH15H9sTBB1WnAmozp1jpPyaj2g6+kNG+Ce5tCTH+mh3TABetbXHIX1v1DhGMT1snkBdKAzMa+CLwlzq/2UCRr/zbwEiuXX2Hph+TCFm8ZZUvzaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mz1AXuuv; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mz1AXuuv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741231362; x=1772767362;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NAkqSxZxIYJbA34rN88SL/2ptvc58O77///ilOXA/vs=;
  b=mz1AXuuvm9v5P2RKbAYsYLJLl3w6xaPgtftuGP0jN32F5lH7Afkuwrnb
   MMqs/bM377jhWomBnnSoV5Ag+kGx0YjJD2YPETVo1CXuj7EI8XeQ6yrci
   CNKlzSd7on7cDZ5if+UdA22e335WpdaoAqXWsG7TBitCDT8nfTF4i0bnu
   sAs1KWglyeMJetzkjvm2/Y1HTuxPOzgHjszjeCdmZjZ/hfSUho90UhHoP
   P0KeNNUQyP/TedWevYwJR8vKSo0CzFvqdLDda83i1zn/R8LBp9IatQ81B
   XthRwdu6KtNdsBN1QNVZvpBjAMLPTgE4v5W7eyrrJCFBk8mimBeBmkMh/
   w==;
X-CSE-ConnectionGUID: ummZr8RRR3+8hqsc5NLDBA==
X-CSE-MsgGUID: mARyVNGyQny4YXYLpkjh/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42359586"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="42359586"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 19:22:40 -0800
X-CSE-ConnectionGUID: eqNMVitITSeaWZdUPNFzYg==
X-CSE-MsgGUID: il/XcATeTWenLJWAtiPRxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119801370"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 19:22:39 -0800
Message-ID: <f64b5980-b16d-4199-81f4-5c6816c19a59@linux.intel.com>
Date: Thu, 6 Mar 2025 11:19:32 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommufd: Use accurate dev_id in the PRI forwarding path
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20250305130356.126424-1-yi.l.liu@intel.com>
 <20250305171838.GC133783@nvidia.com>
 <BN9PR11MB5276771968FF57AC0FE74BCB8CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276771968FF57AC0FE74BCB8CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 11:10, Tian, Kevin wrote:
>> From: Jason Gunthorpe<jgg@nvidia.com>
>> Sent: Thursday, March 6, 2025 1:19 AM
>>
>> On Wed, Mar 05, 2025 at 05:03:56AM -0800, Yi Liu wrote:
>>> Hi Jason, Kevin, Baolu,
>>>
>>> This is more a query, the patch here does not really work as there
>>> is locking issue. So I'd like to hear from you if any good idea.
>>>
>>> Detail as below:
>>>
>>> Existing code has a problem when the PRI happens on a device that has
>>> alias. The PRI reporting path uses the idev stored in the handle. While
>>> this idev is the first idev that attachs to the domain.  If the PRI
>>> happens on devices other than the first attached device, then the idev
>>> stored in handle does not match.
>> Do you actually care about this? Can we say that devices that have
>> aliases do not allow PRI?
>>
>> I'm confused about how that can even work if the RID is erased in the
>> fabric, how do we deliver the PRI response to the correct entity?
>>
> Another tricky thing is when some devices in the group support PRI
> but others don't...
> 
> I'm inclined to agree that it's simpler to disable PRI on non-singleton
> group, than trying to fix and eanble it.

+1

Thanks,
baolu
