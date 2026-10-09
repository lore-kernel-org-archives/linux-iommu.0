Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660144DEC3D
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560242; cv=none; b=MeTplbpy4NvUUyqQclswtJD/+7Z/PjyebNJcgLUGDP/oNn6SVMRyExjIK908aZQxt4qWpXwj/OPfYMyU0VwewWb0wPbwwrI8NGM1CiVKRN9NDMM1H/w+7dfKoHLEh+I/Xmg16/meUZZXhpuuDEtEJ/MonVIJhQzi8gaTpBvQgoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560242; c=relaxed/simple;
	bh=4TGnf+qefgabk6iF56KMINVP9Q/BF98PVmUp+DBTV3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HtC+197OWazTD0P5DhTj02gJVs/6qFmv0/0npgJgRCUUc5C/uK7jfHrV9E6ZXXALTkI4dxOk4R/J50rtRtyzWZE5E97OvQ/28BXg5LcIVHKWFyylPG/QO6iE+ZXFz3G3dww94cBGQgLboc5s0nHijIErB3FgWoi+QUKk27oQzQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sChMW5DB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sChMW5DB"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CE781476;
	Fri,  9 Oct 2026 08:37:16 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C2383F763;
	Fri,  9 Oct 2026 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791560239; bh=4TGnf+qefgabk6iF56KMINVP9Q/BF98PVmUp+DBTV3g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sChMW5DBFwMbrPOQZkTOJPaHM48w5+K+UZ8VdfXK6IkcLrLJtFoD2dYMhW2rxT0rA
	 3vMKTV4yI4GFvRQxB0Se5tUyOkJgNWjrPcFVI5aIOxUeUbzRc5xnLrh2H5ZBH25WGa
	 o6Q8WoExOZPOO14JHHOokMnr8Js3yNMG4xIYZMJ8=
Message-ID: <52ba8a64-2d3d-4c3f-ae8f-54ab4f0f164d@arm.com>
Date: Fri, 9 Oct 2026 16:37:08 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] iommu/io-pgtable-arm: Add support for contiguous hint
 bit
To: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Daniel Mentz <danielmentz@google.com>
Cc: Will Deacon <will@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Prakash Gupta <prakash.gupta@oss.qualcomm.com>
References: <20260921-iommu_contig_hint-v5-1-e7fbd1c3774d@oss.qualcomm.com>
 <20260924001502.GO1540250@ziepe.ca>
 <CAE2F3rCVh0CmW6+a__PcCrBgsMJVompKJX_qYBdQ=exj3bYtCg@mail.gmail.com>
 <20260924225340.GC16465@ziepe.ca>
 <7ab6eab6-ec6e-47dc-b387-eb380e2e365c@oss.qualcomm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <7ab6eab6-ec6e-47dc-b387-eb380e2e365c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/10/2026 11:09 am, Vijayanand Jitta wrote:
> 
> 
> On 9/25/2026 4:23 AM, Jason Gunthorpe wrote:
>> On Thu, Sep 24, 2026 at 11:49:50AM -0700, Daniel Mentz wrote:
>>> On Wed, Sep 23, 2026 at 5:15 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>>>
>>>> On Mon, Sep 21, 2026 at 04:44:07PM +0530, Vijayanand Jitta wrote:
>>>>> From: Prakash Gupta <prakash.gupta@oss.qualcomm.com>
>>>>>
>>>>> Add support for the contiguous hint (CONT) bit in ARM LPAE page tables.
>>>>> When a set of consecutive PTEs map a naturally aligned contiguous block of
>>>>> memory, set CONT on every descriptor in that group so the hardware can
>>>>> combine translations and improve TLB reach.
>>>>>
>>>>> Advertise the supported CONT group sizes in pgsize_bitmap. Callers select
>>>>> those sizes through the normal page-size selection path; io-pgtable-arm
>>>>> then installs the corresponding tagged descriptors directly. A partial
>>>>> unmap of a tagged CONT group is rejected before modifying any descriptor,
>>>>> so a rejected request cannot leave the group partly unmapped.
>>>>>
>>>>> The IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT quirk allows SMMU drivers to disable
>>>>> CONT support for hardware with implementation-specific errata.
>>>>
>>>> smmuv3 has this errata, it must be disabled there too. I didn't notice
>>>> it in this patch?
>>>
>>> SMMU is an architecture specification. I am not aware of errors in
>>> this architecture specification that would preclude the usage of the
>>> contiguous bit. I understand that Arm MMU-700 has the following
>>> erratum
>>>
>>> 3777127 Under invalidation in TBU possible when using contiguous page
>>> table entries
>>
>> And a neoverse one too.
>>
>>> The recommended workaround is described as
>>>
>>> "Ensure that contiguous page tables are removed using a single range
>>> invalidation. Arm recommends using range invalidations to remove
>>> contiguous entries anyway for performance reasons."
>>>
>>> and I believe we are already doing this.
>>
>> No we aren't. Go read my fix on this:
>>
>> https://lore.kernel.org/linux-iommu/1-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com/
>>
>> I have another patch that fixes it for iommu domain mappings too.
>>
>> Jason
> 
> Sure , will disable it for smmuv3 for now.

I still can't see how that would be necessary. Sure SVA has to cope with 
invalidating any old arbitarily-sized range that could have been a mix 
of pages, blocks, cont, whatever - that's fair enough. But for 
io-pgtable through the IOMMU API, a partial unmap of anyhthing which 
could have been mapped as a cont range would already be invalid and 
should fail. Thus for any unmap which could validly include any cont 
ranges, iommu_pgsize() would have already picked a granularity that is 
some multiple of the largest cont range size being unmapped, so even if 
the total gathered size exceeds a single command, we still wouldn't 
split it _within_ any single one of those ranges, only at a boundary 
between two unrelated ones.

Thanks,
Robin.
