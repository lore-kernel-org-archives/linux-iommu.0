Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B22A314B8F;
	Sat, 19 Sep 2026 04:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789790675; cv=none; b=Wvs9Dqv0bxelpRyTWMx812kS8sY7J2OOVW2RtVAcuu636ewVrZT8OYQ25yEJergJGUQXahl7vEkdV/ImFdKgHP7zjSJHE4ZWlKxkdOc33e+wNLivmcTZwssRmVcvwLkGENVZhYLleO1FRX/KIXEyRHZmpIuilSh8ue0egCKvxLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789790675; c=relaxed/simple;
	bh=nZJBvPIh95jUAFnRv6ZrsC/RbI3DEcyGbYX5M7J1+5U=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Wzqe6ktAr9n2FX2JrYgXGgy7tH1xz1+OuO0ITXEOqWt5ePG4BMAnsrbRsMKpMHV4GML38zLywkpFsVgyJFq6aLbNu2Z/XE84FXiopmV8FMzGho1aY7eJ0jFdZsNH1uHnRazF/aHbqn5P1V2Vz/w0yy2WUVL/1LXoHcF+PMNhijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bcD3Enh1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bcD3Enh1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789790674; x=1821326674;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nZJBvPIh95jUAFnRv6ZrsC/RbI3DEcyGbYX5M7J1+5U=;
  b=bcD3Enh1pUm/mGYwR0Tbk/NqFoNSN78FvHvJGmwh/Ppu4YYPIzuj8qNV
   W5CocJyznyeXyGrBgm9AhTxlrg508VBEu2huWr4OQwhQOYODbG+LuX7AT
   wq4Jt4IGAvCnU0bAmhLfR4fu9kjX6gL0yBYrI+0zG9QmRVylextiwEx31
   5POWJA9w5rp43zEQfgKvpzu5QvlqQqAq89tEsR73M8RbNNKCsNlj2IoTW
   FEA9WuSW+BRt7n11q63OgG9xylv/N34c/x9rkGuoUVteuolgR6v1ThxBI
   v01StGr8GqniiwJdHURrhJFtvirU7gzRR/PfuBwmhszhvuabDhskQfdq4
   Q==;
X-CSE-ConnectionGUID: fmHQs6ItSoyBFu846WKlRg==
X-CSE-MsgGUID: gBNuDP4CQhGCr6kuAz1gKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="100926606"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="100926606"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 21:04:33 -0700
X-CSE-ConnectionGUID: mKrWvurVSxqw55S/Q6751w==
X-CSE-MsgGUID: l1N3vmyUSQ2LY2XhlDkSmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="270403709"
Received: from unknown (HELO [10.238.1.188]) ([10.238.1.188])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 21:04:29 -0700
Message-ID: <48f71e6e-7240-428d-a8a7-31542a880a18@linux.intel.com>
Date: Sat, 19 Sep 2026 12:04:27 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen <dave.hansen@linux.intel.com>,
 Kiryl Shutsemau <kas@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao" <chao.gao@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] iommu/vt-d: Introduce trusted DMA initialization
 support
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
References: <20260915074235.1219183-1-baolu.lu@linux.intel.com>
 <CO1PR11MB48351B13F0143DE043EF15378C872@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <CO1PR11MB48351B13F0143DE043EF15378C872@CO1PR11MB4835.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/2026 10:30 AM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, September 15, 2026 3:42 PM
>>
>> Hi,
>>
>> This series adds Intel VT-d trusted extension support to the host Intel
>> IOMMU driver as groundwork for TEE I/O trusted DMA (e.g. TDX Connect).
>>
>> The trusted extension introduces a parallel, extension-specific path for
>> trusted DMA assets used by confidential device assignment. Existing VT-d
>> functionality remains unchanged for regular host DMA paths.
>>
>>  From the TDX Connect architecture perspective, VT-d is enhanced with:
>>
>>    1) Trusted DMA translation root table
>>       - A second root-table address register, restricted to SEAM SAI.
>>       - Programmed by the TDX module with the root of TDX-managed DMA
>>         translation tables for TD-assigned devices.
>>
>>    2) Trusted invalidation queue
>>       - A second invalidation-queue address register plus dedicated
>>         head/tail registers, also restricted to SEAM SAI.
>>
>>    3) IOTLB / DID isolation
>>       - When TDX Connect is enabled, VT-d restricts VMM DID usage and
>>         reserves the DID MSB namespace bit for TDX-module use.
>>
>> This posting focuses on VT-d-side enablement only: it enables those
>> extension-defined resources and control points while preserving existing
>> host VT-d behavior for non-trusted flows. Higher-layer integration
>> (TDX guest/device flows) will be posted separately.
>>
> 
> Jason had a comment on this from another thread [1]:
> 
> "
> Okay, so I saw the driver posting for basic iommu support, can we try
> to rework that to be split out like Aneesh is doing so everything
> about TDX calls lives in tsm and intel iommu only provides a small API
> surface to exchange whatever details are needed to bootstrap TDX
> module?
> "
> 
> [1] https://lore.kernel.org/all/20260916123954.GC3196566@ziepe.ca/

Yes, I will head in this direction in the next version.

Thanks,
baolu
