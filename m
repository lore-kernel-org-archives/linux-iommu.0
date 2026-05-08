Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6B93E3C52
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247088; cv=none; b=f+M92uLD7MKYyzfkwqb5yNy54xhzCb5SZ6V4KU4YkEmbKN3UUTay5IhyIwUSvDv0+2XyQlsZPLchmIF7imLwQ1AWwAGSTmkP9or/j/wglP1x+R3tzIz7dRTDzRAmrmYnUBHP8+6oXUSRsHAaWblH7JGMykuR450O/DE5xbN9fKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247088; c=relaxed/simple;
	bh=JYZqDBKKjLeeqvrl+VwK6aI+mrwXx8FfCqW46Btn9cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGFli+dHTTHg/8qZD0kAkBEzFQk0Ji+LCCWsEguQalTaI9/xkhJOqyTCYuZtmqau/tnlSlyjQF8nZCu3w3ACHDaXBchfZNdgtpvVeuUp2ehGnta8rbF5ST/U5IzpHnP5qQDSo8K8UTTSRAQCdTDDgQJEUlfpCLeLVs7pq2zm/8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LYmZgXXU; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LYmZgXXU"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB72C32CE;
	Fri,  8 May 2026 06:31:12 -0700 (PDT)
Received: from [10.57.63.248] (unknown [10.57.63.248])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22E883F836;
	Fri,  8 May 2026 06:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778247078; bh=JYZqDBKKjLeeqvrl+VwK6aI+mrwXx8FfCqW46Btn9cY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LYmZgXXUj7zK2hyjZUFAIchohbj0LAGJFNR9LLv5EKkNPemzSuxgHqpv1OFcM7FvY
	 Wf+TQr60SS0pm6uyVXyx+cNrTxBdhSj4b3TMy4LnxBec3FyCdZPvRXw5SNF8AMEVJm
	 AMdMHrpIzXGjylSN20xzJbMkGHXey5GnjB01pdpg=
Message-ID: <f31043cc-45dd-457f-8031-0cef51c9470e@arm.com>
Date: Fri, 8 May 2026 14:31:11 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3-sva: Enable Hardware Access and
 Hardware Dirty bits
To: Pranjal Shrivastava <praan@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jean-Philippe Brucker <jpb@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260503135413.1108138-1-nicolinc@nvidia.com>
 <af0SdkjQOZxnnaQb@google.com> <20260508123550.GB9254@nvidia.com>
 <af3hWGp3etGOIdEn@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <af3hWGp3etGOIdEn@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-05-08 2:12 pm, Pranjal Shrivastava wrote:
> On Fri, May 08, 2026 at 09:35:50AM -0300, Jason Gunthorpe wrote:
>> On Thu, May 07, 2026 at 10:30:14PM +0000, Pranjal Shrivastava wrote:
>>>> @@ -92,6 +92,16 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
>>>>   
>>>>   		target->data[1] = cpu_to_le64(virt_to_phys(mm->pgd) &
>>>>   					      CTXDESC_CD_1_TTB0_MASK);
>>>> +
>>>> +		/*
>>>> +		 * Enable Hardware Access and Dirty updates (DBM) if supported.
>>>> +		 * This is safe to enable by default, as PTE_WRITE and PTE_DBM
>>>> +		 * share the same bit.
>>>> +		 */
>>>> +		if (master->smmu->features & ARM_SMMU_FEAT_HA)
>>>> +			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA);
>>>> +		if (master->smmu->features & ARM_SMMU_FEAT_HD)
>>>> +			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HD);
>>>
>>> IIUC, we should be setting these if IO_PGTABLE_QUIRK_ARM_HD is present?
>>
>> SVA does not use IO_PGTABLE at all, and it directly constructs its own
>> CD.
>>
>> No relation between those two flows.
> 
> I understand that but I mean we need to know if the system supports
> HTTU ? Like for SMMU we use the IO_PGTABLE_QUIRK, shouldn't we be
> checking if the CPU's tables support HTTU?
> 
> Are we assuming that if the SMMU IDR presents HTTU capability the MMU
> would also have it? I think an unconditional enablement is risky as we
> may not have system-wide HTTU support.
> 
> If we look at arm_smmu_master_sva_supported, the driver already
> maintains a strict agreement between the CPU and SMMU for SVA.
> It checks sanitized CPU ID registers for things like PARANGE & ASIDBITS,
> and it uses system_supports_bbml2_noabort() to decide whether to enable
> FEAT_BBML2.
> 
> Shouldn't we follow this exact same pattern for HTTU ?
> We should probably be checking cpu_has_hw_af() (from asm/cpufeature.h)
> in the SVA support check or here if we wanna enable HTTU.

It might make sense to depend on CONFIG_ARM64_HW_AFDBM - when that is 
enabled, then IIRC we already expect to cope with some CPUs not 
supporting hardware updates, so it should still be fine for an SMMU to 
make them even if no CPU does. However, if it's disabled then I'm not 
sure if missing access flag faults (if SMMU HA silently sets them) might 
be an issue - for dirty, we'd just never put down the Writeable-Clean 
permission so enabling SMMU HD wouldn't do anything anyway.

Thanks,
Robin.
