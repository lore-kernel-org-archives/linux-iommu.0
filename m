Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112B230F523
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148075; cv=none; b=jSmFIKrBmMk+I8g/ueq8yMs2+TdLAGJRQ7ISNdmVKbb5J0cMInOlIb1PjBpKryFfLdKTu46ni7OPmAoaOUiYyiHyyoGdNyBOUH3NweLWJQ93JJTC7fFb7ckaaYjnDfLk5Oc72Hm0dF+RcptZ7N3cpyjiAWL9gNeXMl8dmkFZxp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148075; c=relaxed/simple;
	bh=q0EI4rNp2Py4ipVMPcubth22UfENKlUF51C+O+Q0xL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdp3F3MeLSdaKkhU9FdINKBf9Bo9YtWPYV/THR0GGXdUgs1eWwcht2j2D8Psh8htGni9htXQwOPAYZgmydQ4QGP+QmZkY5gLtctQ2lEirBvU3Sh67dICR7I8Fel7xPpFlG8a3wJCBo/KsMG90jYSI7wvzO7KuvM9uRzFeB0gjQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rQreKK17; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rQreKK17"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6645143D;
	Mon, 27 Jul 2026 03:27:45 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC6B53FA21;
	Mon, 27 Jul 2026 03:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785148070; bh=q0EI4rNp2Py4ipVMPcubth22UfENKlUF51C+O+Q0xL4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rQreKK17p11RuffLSZL52pe4G7oyjENlF76bAH8Tc0miNBvJGEdSJrVFAZ2U69EzS
	 YFJhBYHt4KuU4N6RuXOVNOGOMUBT+gBi2uH6OWdLEzrjSQadWgTd6NRuxZsl5lTdbY
	 pMpI/WRQiaPODBFdKuph2q5yqgUrw17w3Trm+aIs=
Message-ID: <0a10a19d-690c-42ee-aedc-83906b9fd9e0@arm.com>
Date: Mon, 27 Jul 2026 11:27:47 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: Add HAFT support for SVA
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: catalin.marinas@arm.com, joro@8bytes.org, jpb@kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <cover.1784814923.git.robin.murphy@arm.com>
 <57ae366ec501a142bd20f2cc7d18b3eca8eeac25.1784814923.git.robin.murphy@arm.com>
 <amTH7xHBY2ol4LHw@nvidia.com> <amX25rcF-ETdnUPj@willie-the-truck>
 <amYxa51b2j/Cdw/6@nvidia.com> <amcTBlw16RKuZC8y@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <amcTBlw16RKuZC8y@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/07/2026 9:12 am, Will Deacon wrote:
> On Sun, Jul 26, 2026 at 01:10:19PM -0300, Jason Gunthorpe wrote:
>> On Sun, Jul 26, 2026 at 01:00:38PM +0100, Will Deacon wrote:
>>> On Sat, Jul 25, 2026 at 11:27:59AM -0300, Jason Gunthorpe wrote:
>>>> On Thu, Jul 23, 2026 at 03:19:44PM +0100, Robin Murphy wrote:
>>>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>>>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>>>>> @@ -102,6 +102,8 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
>>>>>   			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA);
>>>>>   		if (master->smmu->features & ARM_SMMU_FEAT_HD)
>>>>>   			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HD);
>>>>> +		if (master->smmu->features & ARM_SMMU_FEAT_HAFT && system_supports_haft())
>>>>> +			target->data[1] |= cpu_to_le64(CTXDESC_CD_1_HAFT);
>>>>>   	} else {
>>>>>   		target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_EPD0);
>>>>
>>>> Based on the Sashiko remark and your note you should lift all the
>>>> HA/HD/HAFT bits outside this if (mm) block.
>>>>
>>>> AFAICT it is fine for HA/HD/HAFT to be set with EPD0, the HW won't
>>>> process any PTEs so they won't have any effect.
>>>
>>> I'm not sure about that. The spec says this about CD.HAFT:
>>
>> Sorry I see this was unclear
>>
>> I ment to move all *three* bits outside the if.
>>
>> There is no reason for EPD0 to also require setting any of those three
>> bits to zero, AFAICT.
> 
> Ah, gotcha! And even if we did want to get to that configuration, I
> guess you could set EPD0, then clear HAFT, then clear HA+HD?

Indeed, it also occurred to me on the way home on Friday that in this 
case we probably could get away with just setting HA/HD/HAFT 
consistently in all SVA CDs irrespective of the mm. Strictly, EPD0 only 
forbids *new* walks from using TTB0, so there might potentially be some 
outstanding PTE updates still made in the window between the config 
update and the TLBI at the end of arm_smmu_mm_release(), but that 
shouldn't be harmful.

Lemme spin a v3...

Cheers,
Robin.

