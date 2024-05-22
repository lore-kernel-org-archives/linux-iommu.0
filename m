Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4182B7F460
	for <iommu@lists.linux.dev>; Wed, 22 May 2024 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716371856; cv=none; b=Ogz53AWn9nPyd3xvcOokz9UOM2BV+bILxP8lW0BdbpyEOgSLmxj8HXmY7paYBdyzYbXKjImySkpLmV0GKtLZGJ1VLC4lJ5+FKANEJseBYh/JkLYaXMmLNZ6wJ1MRc2d9E2qXblMnMALIXTIaHvQinCJX85YmfdQBCfg24aDrgEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716371856; c=relaxed/simple;
	bh=dxxOdiXH9g1wuJ/3cBi6DHlb9NEtTWrT0Fmqvonz0d4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nHzXcjtK0rnsT8XohWEjco5Z/NGYHpDnJ8//88RViUvqb8CD2ka5xXn0OHLhiPApIgDQEcGGAZ9lB2B4ll8iud3D24vVnVHIr9iukTLPWSbHedfIh8rcacJ8h3Oe37I38YcSStjcR+TQ0tefIV31qpatnU0cra0XrXByYTWVLuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AtB4w8j/; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AtB4w8j/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716371855; x=1747907855;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dxxOdiXH9g1wuJ/3cBi6DHlb9NEtTWrT0Fmqvonz0d4=;
  b=AtB4w8j/ro9/jpLNHlZ7Tdj5xaecSCUYjSPno8ys4Vbyif3RVphxpmJl
   iA9ypoyO+afCYJ2wrLAnyoQIomxXsf7F0E3A9a3RyDQ2LTd1ezR+r0PcN
   jk+34aqYqYe1hQ08XWUmABdhP7G7DzG+uStZ8vAdERk9vd2yOzKXjJzYS
   AEXms55LzZNkfmMFLwovvyfPuwPFBKwJVPGfYCve1xOVoYQfPLf0CyLIP
   s/umZXE3fjwmUui8iE30XhpG0Od59kbFRuKGXJClGVveWkjctItfkWhwr
   6eioSJhuPJdJdN6KO95hZYykLWKkPLQyWRRP8EADCqF0nuaS5IaeqBEzV
   A==;
X-CSE-ConnectionGUID: oJQgEHvCRouk/exKQG1gpg==
X-CSE-MsgGUID: k2h70UkBStO2lMa2jGr4cg==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="23742132"
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="23742132"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 02:57:33 -0700
X-CSE-ConnectionGUID: yYYhyTfXTjiSS1atoHXAkw==
X-CSE-MsgGUID: tHrzgwNSSZ+GNrt630I2bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,179,1712646000"; 
   d="scan'208";a="37627845"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 02:57:28 -0700
Message-ID: <d18d7fea-642f-4b75-ae11-4a0792b14784@linux.intel.com>
Date: Wed, 22 May 2024 17:57:26 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
 "jon.grimm@amd.com" <jon.grimm@amd.com>,
 "santosh.shukla@amd.com" <santosh.shukla@amd.com>,
 "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
 "shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH RFCv1 04/14] iommufd: Add struct iommufd_viommu and
 iommufd_viommu_ops
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <8610498e3fc00000e78bb9cef6fac9f6a54978a4.1712978212.git.nicolinc@nvidia.com>
 <ZkDMSfd9BXmsFfb+@nvidia.com> <ZkGKKoHnykAdGJq6@nvidia.com>
 <ZkOJgvMNFaZZ06OO@nvidia.com>
 <BN9PR11MB5276423A0BFBDA8346E1ED3C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276423A0BFBDA8346E1ED3C8CEB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/22 16:58, Tian, Kevin wrote:
>> From: Jason Gunthorpe<jgg@nvidia.com>
>> Sent: Tuesday, May 14, 2024 11:56 PM
>>
>> On Sun, May 12, 2024 at 08:34:02PM -0700, Nicolin Chen wrote:
>>> On Sun, May 12, 2024 at 11:03:53AM -0300, Jason Gunthorpe wrote:
>>>> On Fri, Apr 12, 2024 at 08:47:01PM -0700, Nicolin Chen wrote:
>>>>> Add a new iommufd_viommu core structure to represent a vIOMMU
>> instance in
>>>>> the user space, typically backed by a HW-accelerated feature of an
>> IOMMU,
>>>>> e.g. NVIDIA CMDQ-Virtualization (an ARM SMMUv3 extension) and
>> AMD Hardware
>>>>> Accelerated Virtualized IOMMU (vIOMMU).
>>>> I expect this will also be the only way to pass in an associated KVM,
>>>> userspace would supply the kvm when creating the viommu.
>>>>
>>>> The tricky bit of this flow is how to manage the S2. It is necessary
>>>> that the S2 be linked to the viommu:
>>>>
>>>>   1) ARM BTM requires the VMID to be shared with KVM
>>>>   2) AMD and others need the S2 translation because some of the HW
>>>>      acceleration is done inside the guest address space
>>>>
>>>> I haven't looked closely at AMD but presumably the VIOMMU create will
>>>> have to install the S2 into a DID or something?
>>>>
>>>> So we need the S2 to exist before the VIOMMU is created, but the
>>>> drivers are going to need some more fixing before that will fully
>>>> work.
> Can you elaborate on this point? VIOMMU is a dummy container when
> it's created and the association to S2 comes relevant only until when
> VQUEUE is created inside and linked to a device? then there should be
> a window in between allowing the userspace to configure S2.
> 
> Not saying against setting S2 up before vIOMMU creation. Just want
> to better understand the rationale here.
> 
>>>> Does the nesting domain create need the viommu as well (in place of
>>>> the S2 hwpt)? That feels sort of natural.
>>> Yes, I had a similar thought initially: each viommu is backed by
>>> a nested IOMMU HW, and a special HW accelerator like VCMDQ could
>>> be treated as an extension on top of that. It might not be very
>>> straightforward like the current design having vintf<->viommu and
>>> vcmdq <-> vqueue though...
>> vqueue should be considered a sub object of the viommu and hold a
>> refcount on the viommu object for its lifetime.
>>
>>> In that case, we can then support viommu_cache_invalidate, which
>>> is quite natural for SMMUv3. Yet, I recall Kevin said that VT-d
>>> doesn't want or need that.
>> Right, Intel currently doesn't need it, but I feel like everyone will
>> need this eventually as the fast invalidation path is quite important.
>>
> yes, there is no need but I don't see any harm of preparing for such
> extension on VT-d. Logically it's clearer, e.g. if we decide to move
> device TLB invalidation to a separate uAPI then vIOMMU is certainly
> a clearer object to carry it. and hardware extensions really looks like
> optimization on software implementations.
> 
> and we do need make a decision now, given if we make vIOMMU as
> a generic object for all vendors it may have potential impact on
> the user page fault support which Baolu is working on. the so-called
> fault object will be contained in vIOMMU, which is software managed
> on VT-d/SMMU but passed through on AMD. And probably we don't
> need another handle mechanism in the attach path, suppose the
> vIOMMU object already contains necessary information to find out
> iommufd_object for a reported fault.

Yes, if the vIOMMU object tracks all iommufd devices that it manages.

Best regards,
baolu
