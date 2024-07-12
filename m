Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F88A172BD2
	for <iommu@lists.linux.dev>; Fri, 12 Jul 2024 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720797172; cv=none; b=M+bujBudx22eN7QDnhYw2nMkRHIsl+l5j8GTPsmh69SS/atNJ9JcFND2YgKMJ8umsT4KOQsgcW11Meeb+C76yYWv706ZOESg5a9xohpAVHNUzSw3A0OIoOrd9bUePsEf6inq9AjH8un308AaLy8ayJPS7m5UFaXJMqsItiDnn/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720797172; c=relaxed/simple;
	bh=1g6hm+dbeZR9A81JxRMmgTByW4LZcvi65oAxHzKpZxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vt2OnDzh/iO8A3PEuwurXZwbuUICqnNMW+Tuc44fX+j1Qws1b2YkRfqjFYSB2el2HAixvBNetCB1ppCvUwOa/U0iA/qa09WiqsLBqATWLBKXDI+TWkfUT2QrhEOgwK1C97s//tyFEa7dvOtn0C4p81Nljj2J2gGlPZsYMRdA9nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62E921007;
	Fri, 12 Jul 2024 08:13:14 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 384753F762;
	Fri, 12 Jul 2024 08:12:48 -0700 (PDT)
Message-ID: <7f930d79-2309-4b94-a187-0707c6d5b9e8@arm.com>
Date: Fri, 12 Jul 2024 16:12:43 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yi Liu <yi.l.liu@intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Joerg Roedel <joro@8bytes.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
References: <26524622-971f-47f5-936e-d0173d342288@amd.com>
 <Zn77FbsQWmByf16t@ziepe.ca> <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com>
 <ZoLmyOzOVYGLKjmn@ziepe.ca> <68d300af-4d3d-497e-9338-d99dbf88dd21@amd.com>
 <8bfc6cb7-d2d7-4d4c-9970-f4f207fb54b4@intel.com>
 <20240709182303.GK14050@ziepe.ca>
 <3eff5c86-8b5d-491a-955e-794198350ec3@intel.com>
 <20240711234917.GW14050@ziepe.ca>
 <35ff9f32-ae60-4124-9ced-42f82c2b4f93@arm.com>
 <20240712135326.GD14050@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240712135326.GD14050@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/07/2024 2:53 pm, Jason Gunthorpe wrote:
> On Fri, Jul 12, 2024 at 02:40:37PM +0100, Robin Murphy wrote:
>>>> BTW. SVA domain shall not be attached to RID I suppose. This should
>>>> be a common restriction across vendors. Do you think it is valuable
>>>> to let iommu core block such an attempt?
>>>
>>> Yeah, maybe.
>>
>> There's no functional reason to disallow it for Arm SMMUs, at least, so it's
>> something that could potentially want relaxing back to per-driver in
>> future.
> 
> I think everyone can technically do SVA as everyone should be able to
> do PRI on the RID. We want PRI on RID anyhow for unpinned guest KVM
> support someday.
> 
> My specific "maybe" was because SVA is troublesome for MSI, on ARM we
> won't have an ITS page mapped for instance.

Yeah, I think the trick for that is going to be to require the device to 
be happy with shoving any kernel-owned mappings (MSIs, firmware, etc.) 
into the TTB1 range.

>> I've heard murmurings over the years about potential use-cases for SVA with
>> platform and/or non-PASID PCI devices, but never anything concrete for
>> existing hardware. I imagine we can expect to see more SVA-interested
>> on-chip accelerators in future, but whether they'll all be nice and support
>> Substreams (i.e. "platform PASIDs") is the question...
> 
> So I guess they don't send MSI down those special stream ids? It makes
> sense as a use case to me.

Indeed I'd hope that people follow the intuitive usage model and MSIs 
are sent without a SubstreamID, but I guess we're just going to have to 
wait and see what gets built. Of course, the one real SSID-capable 
device I *have* seen so far still only has wired interrupts anyway...

Thanks,
Robin.
