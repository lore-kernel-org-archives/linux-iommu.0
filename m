Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8FC15572E
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723724190; cv=none; b=Djptz5l9XT+WJAXufNjJZpzjhnmiAh2tvH2euYB2hqHW/jvIFmMRQalPUKpLdKpa84l2HasrTnV4wzxX6JBa82Owlgjb8ToVN47hDb8cBWdJeX5DhQbEWxs6qTZuJi6XNq6gTZWhq8MN2ItCAcpaBrEZH/08CJqu+lic6NILW+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723724190; c=relaxed/simple;
	bh=f8gmWffMskUMaA4rGBasmLTckzOc5vjIU3yXzHvy4NY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmM2NJqAvvTIIqwPDLQpKfXY4hIGR/HTLFcMnjPAOJQXNXucWsXbE1PCrjzCtjuOmq3ch+1mrda23zSSKrdZFwszZgAaTWXAEbdzx/Va260+XFnTuYi+7/mOZFtf8ApRdh3u9ZY9K1JkZMREvQUs4lXNv1fmLaHXkjyZDV5xnq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A40514BF;
	Thu, 15 Aug 2024 05:16:48 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CDCE3F6A8;
	Thu, 15 Aug 2024 05:16:20 -0700 (PDT)
Message-ID: <91d6574d-c67e-484c-ad96-91c9fd3d0c43@arm.com>
Date: Thu, 15 Aug 2024 13:16:19 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/arm-smmu-v3: Match Stall behaviour for S2
To: Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, will@kernel.org, joro@8bytes.org,
 jean-philippe@linaro.org, nicolinc@nvidia.com, mshavit@google.com
References: <20240814145633.2565126-1-smostafa@google.com>
 <20240814155151.GB3468552@ziepe.ca> <Zr3m4YCY7Ape3R6y@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Zr3m4YCY7Ape3R6y@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15/08/2024 12:30 pm, Mostafa Saleh wrote:
> Hi Jason,
> 
> On Wed, Aug 14, 2024 at 12:51:51PM -0300, Jason Gunthorpe wrote:
>> On Wed, Aug 14, 2024 at 02:56:33PM +0000, Mostafa Saleh wrote:
>>
>>> Also described in the pseudocode “SteIllegal()”
>>>      if eff_idr0_stall_model == '10' && STE.S2S == '0' then
>>>          // stall_model forcing stall, but S2S == 0
>>>          return TRUE;
>>
>> This clips out an important bit:
>>
>> if STE.Config == '11x' then
>>    [..]
>>    if eff_idr0_stall_model == '10' && STE.S2S == '0' then
>>        // stall_model forcing stall, but S2S == 0
>>        return TRUE;
>>
>> And here we are using STRTAB_STE_0_CFG_S1_TRANS which is 101 and won't
>> match the STE.Config qualification.
>>
>> The plain text language said the S2S is only required if the S2 is
>> translating, STRTAB_STE_0_CFG_S1_TRANS puts it in bypass.
> 
> Yes, my bad, this should be for stage-2 only which is populated in
> arm_smmu_make_s2_domain_ste()
> 
>>
>>> +	/*
>>> +	 * S2S is ignored if stage-2 exists but not enabled.
>>> +	 * S2S is not compatible with ATS.
>>> +	 */
>>> +	if (master->stall_enabled && !ats_enabled &&
>>> +	    smmu->features & ARM_SMMU_FEAT_TRANS_S2)
>>> +		target->data[2] |= STRTAB_STE_2_S2S;
>>
>> We can't ignore ATS if it was requested here.

I don't see much value in adding effectively-dead checks for something 
which is already forbidden by the architecture. The definition of 
STALL_MODEL explicitly states:

"An SMMU associated with a PCI system must not have STALL_MODEL == 0b10".

Thanks,
Robin.
