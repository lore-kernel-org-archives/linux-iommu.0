Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B39D8827
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719252018; cv=none; b=EB1FCgb/Nknqnxgkho+AQzhLaCk1FLSiq98h7v5iQdqlVGskTqsWD47bQGyq9aWArMI0Cmf5P/S7DIYMlZxw6EiLc7e7HnbQ0MQklwG0ZWjx8OMoedJ1gaVYY0AmO/2EfLgkb002zBcF97jqVtNVNvd0xP5yaMMdiHM+5nRmtDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719252018; c=relaxed/simple;
	bh=qLdodehS1vuZuflPuyTbvTPrVgCy3JPNLfMyO20KnQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fI8PxVPrHfiCp0bbyn7azf931gkf7NkMdmJW/BIECL3sw8w7woiB3Gw1x1iyuuAJam0rOaE8uBJQZCpO5P4O7gBOuqHJH195KupM4CJ8thF+yREzAkJwT2B8piY56ltqYztGuIP5k/53yLv0+HDdwNgkLwHMfGO3FktojRaOzDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DCDBDA7;
	Mon, 24 Jun 2024 11:00:39 -0700 (PDT)
Received: from [10.57.74.124] (unknown [10.57.74.124])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94FA63F73B;
	Mon, 24 Jun 2024 11:00:12 -0700 (PDT)
Message-ID: <b65e089b-f8b0-4588-adaf-af555ab5781a@arm.com>
Date: Mon, 24 Jun 2024 19:00:10 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] iommu/xen: Add Xen PV-IOMMU driver
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Teddy Astie <teddy.astie@vates.tech>
Cc: xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
 Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
References: <24d7ec005e77e4e0127995ba6f4ad16f33737fa5.1718981216.git.teddy.astie@vates.tech>
 <da3ec316-b001-4711-b323-70af3e6bb014@arm.com>
 <a04e169d-b38a-43dc-b783-a8af1e1b0468@vates.tech>
 <20240624163254.GT791043@ziepe.ca>
 <900edf8a-885c-4bf3-84bd-5e7b165a1ed7@linux.microsoft.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <900edf8a-885c-4bf3-84bd-5e7b165a1ed7@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-06-24 6:36 pm, Easwar Hariharan wrote:
> Hi Jason,
> 
> On 6/24/2024 9:32 AM, Jason Gunthorpe wrote:
>> On Mon, Jun 24, 2024 at 02:36:45PM +0000, Teddy Astie wrote:
>>>>> +bool xen_iommu_capable(struct device *dev, enum iommu_cap cap)
>>>>> +{
>>>>> +    switch (cap) {
>>>>> +    case IOMMU_CAP_CACHE_COHERENCY:
>>>>> +        return true;
>>>>
>>>> Will the PV-IOMMU only ever be exposed on hardware where that really is
>>>> always true?
>>>>
>>>
>>> On the hypervisor side, the PV-IOMMU interface always implicitely flush
>>> the IOMMU hardware on map/unmap operation, so at the end of the
>>> hypercall, the cache should be always coherent IMO.
>>
>> Cache coherency is a property of the underlying IOMMU HW and reflects
>> the ability to prevent generating transactions that would bypass the
>> cache.
>>
>> On AMD and Intel IOMMU HW this maps to a bit in their PTEs that must
>> always be set to claim this capability.
>>
>> No ARM SMMU supports it yet.
>>
> 
> Unrelated to this patch: Both the arm-smmu and arm-smmu-v3 drivers claim
> this capability if the device tree/IORT table have the corresponding flags.
> 
> I read through DEN0049 to determine what are the knock-on effects, or
> equivalently the requirements to set those flags in the IORT, but came
> up empty. Could you help with what I'm missing to resolve the apparent
> contradiction between your statement and the code?

We did rejig things slightly a while back. The status quo now is that 
IOMMU_CAP_CACHE_COHERENCY mostly covers whether IOMMU mappings can make 
device accesses coherent at all, tied in with the IOMMU_CACHE prot value 
- this is effectively forced for Intel and AMD, while for SMMU we have 
to take a guess, but as commented it's a pretty reasonable assumption 
that if the SMMU's own output for table walks etc. is coherent then its 
translation outputs are likely to be too. The further property of being 
able to then enforce a coherent mapping regardless of what an endpoint 
might try to get around it (PCIe No Snoop etc.) is now under the 
enforce_cache_coherency op - that's what SMMU can't guarantee for now 
due to the IMP-DEF nature of whether S2FWB overrides No Snoop or not.

Thanks,
Robin.
