Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FC830F7EF
	for <iommu@lists.linux.dev>; Fri, 24 Oct 2025 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301249; cv=none; b=VrPG1NnIXUeWqsM4osQpd6Axy1DEF68P49GfJpEbsriAHMjjajMZKPUJeWF2R8/66WC7kQRbL6I8a7k2yz38PUFO89UCEaIfi+ufb51UiQoZpKySHPsiAFkcjSdul9dtz8akKQ7LDAVn2XKKF5oohSvTRkIaN5NjmkeyPVEYmNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301249; c=relaxed/simple;
	bh=j3FZcvyVc7uVHCdm8JHf7dDO483uOgihIOxjv4IX4No=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7FXHg2PDmEB0CJ103edP8UicEA1aXYetEuYhSC1lQhNijot94SckaBpS6fkbsPfBmky3MA4jb9PrIVlTdjEK8SCC+Xd71xK6J40LHoM7By5Bp22XE6dyIlOjpFcngn7+VJ6WDwrG5X9OHc204xmV+l89NT7GQEZvsFIOpIKgrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EF9C175A;
	Fri, 24 Oct 2025 03:20:39 -0700 (PDT)
Received: from [10.57.33.202] (unknown [10.57.33.202])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 158A83F66E;
	Fri, 24 Oct 2025 03:20:45 -0700 (PDT)
Message-ID: <8a75e90f-596e-407b-976f-e8a509c9065d@arm.com>
Date: Fri, 24 Oct 2025 11:20:33 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: fix probe device bug due to duplicated
 stream IDS.
To: Jason Gunthorpe <jgg@ziepe.ca>, Reaper Li <reaperlioc@glenfly.com>
Cc: will@kernel.org, joro@8bytes.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20251011023003.159922-1-reaperlioc@glenfly.com>
 <20251023181235.GH21554@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251023181235.GH21554@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-23 7:12 pm, Jason Gunthorpe wrote:
> On Sat, Oct 11, 2025 at 10:30:03AM +0800, Reaper Li wrote:
>> From: Reaper <reaperlioc@glenfly.com>
>>
>> Commit 9246b487ab3c ("PCI: Add function 0 DMA alias quirk for Glenfly Arise
>> chip ") add quirk to fix hda dma request issue, but IORT logic populaties
>> two identical IDs into the fwspec->ids array via DMA aliasing in
>> iort_pci_iommu_init() called by pci_for_each_dma_alias().
> 
> I'd rather we not have duplicate IDs in the same fwspec, can we avoid
> that at the source?

The original reason for not doing that is that there are multiple 
sources - the drivers' own .of_xlate routines for DT, but the 
IORT/VIOT/RIMT/whatever code for ACPI. Yes, iommu_fwspec_add_ids() is in 
a common path there, but that's only responsible for appending an opaque 
block of data to another opaque block of data - only the producer or 
consumer of that data know how to interpret it (e.g. for SMMUv2, 
[0x00000002, 0x00000003] may or may not be considered equivalent to 
[0x00010002]).

Anyway, this patch is wrong regardless, and it is definitely not fixing 
any bug. SMMUv3 has explicitly never supported StreamID aliasing between 
*different* devices, because doing that correctly is a challenge. It 
needs custom group assignment based on StreamID-to-group lookup (like 
SMMUv2) - we can't just assume it's OK for PCI devices, since as soon as 
we allow aliasing at all then we also allow it outside the PCI hierarchy 
where pci_device_group() can't see it (like on the Arm Juno platform). 
These days we do have arm_smmu_find_master() which makes *that* 
feasible, but conversely means we now also have to be concerned with 
disallowing ATS/PRI and working out what to do with anything else that 
is subtly broken by no longer having the assumed 1:1 correspondence of 
StreamID:device.

Thanks,
Robin.
