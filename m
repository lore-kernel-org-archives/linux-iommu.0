Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448E12D045
	for <iommu@lists.linux.dev>; Fri,  6 Sep 2024 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640755; cv=none; b=s+wVTnqD3TbE4Cn+EfqexvLwpALsOCTGKEqruBuCDO1FSqzE4Y6QjSp1tgT6idY3NE2t2+Quym7axZbHQ2cwYo64XB4XWMK7gDTkNo1j0NVVBmEvaLHEnAWLzqEwn4Qd6izIvK6QRfoHydOFUQqf3yFzKZpsOPhbGmiPD+SCmeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640755; c=relaxed/simple;
	bh=fH61CHAmTBUiPWS7zRM82OfEWmS8nRRZTkmzfvor7b8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RF+X7Mot6BalwPAqGLeA1CR5u0mwbZ+roq8Z52aiOMAWAsIXnJJi6xw17+Amujk+/PETnaBTH7Reb0zjnLbaF+ngWCMvU84n8R9ZozAHK6OWSOzVz5676eNTrho3YxXoD36H1CLLUy6ysyGRglaW++JHrAtI5t763EP4hxj4GEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E0C8FEC;
	Fri,  6 Sep 2024 09:39:33 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1310C3F73B;
	Fri,  6 Sep 2024 09:39:04 -0700 (PDT)
Message-ID: <392451a1-784c-4c35-9924-1a1f4cba9120@arm.com>
Date: Fri, 6 Sep 2024 17:39:03 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iommu/arm-smmu-v3: Print better events records
To: Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
 Mostafa Saleh <smostafa@google.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Daniel Mentz <danielmentz@google.com>
References: <20240827193026.3993039-1-praan@google.com>
 <20240827193026.3993039-2-praan@google.com> <ZtAW0hVPFD6JbLTL@Asurada-Nvidia>
 <ZtEKMknbGaD9q170@google.com> <ZtEkUQ7tI3Nb0NOc@Asurada-Nvidia>
 <ZtV1-IL8AZu--jGp@google.com> <ZtZEFKnKasX6433r@Asurada-Nvidia>
 <ZtnXADX3b6qdqVs0@google.com> <ZtphFYr1jUhHOSnC@nvidia.com>
 <20240906125524.GA16773@willie-the-truck>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240906125524.GA16773@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/09/2024 1:55 pm, Will Deacon wrote:
> On Thu, Sep 05, 2024 at 06:55:33PM -0700, Nicolin Chen wrote:
>> On Thu, Sep 05, 2024 at 04:06:24PM +0000, Pranjal Shrivastava wrote:
>>
>>>>>>> Also, the printing would become
>>>>>>> more complicated as we'd have to log different fields for different
>>>>>>> events. Additionally, I don't see that many unions being defined
>>>>>>> elsewhere in the kernel.
>>>>>>
>>>>>> OK. That's a fair point. I think we could have just one common
>>>>>> union for the "good stuff" fields. Then, if something isn't in
>>>>>> the common union, do a FIELD_GET(raw)?
>>>>>>
>>>>>
>>>>> I'm not sure if I get this right, but are you suggesting something like:
>>>>>
>>>>> +struct arm_smmu_event {
>>>>> +       union {
>>>>> +       u64 raw_evt[4];
>>>>> +       struct {
>>>>> +               /* "Good stuff" fields */
>>>>> +       };
>>>>> +};
>>>>>
>>>>> and then based on the fault type we can use the "good stuff" or raw_evt?
>>>>> So, basically just add a union between raw_evt and the other fields to
>>>>> improve struct arm_smmu_event present in v2?
>>>>
>>>> Yea, I attached a test code at the EOM for your reference. Please
>>>> feel free to drop fields if they aren't common enough, and confirm
>>>> those bits are correctly written too.
>>>>
>>>
>>> Hmm, so you're suggesting to make the event a union instead of a struct
>>> thus, making reading event fields easy.
>>>
>>> The only thing I'm slightly worried about is if the bitfields don't
>>> remain constant if more events are added in the future.
>>>
>>> For example, the "IPA" field is in dword[3] for now, but if it changes
>>> in the future, it may get difficult to scale the union for future events
>>> If we can guarantee that it doesn't happen then I think union is better.
>>
>> I believe HW has its own reason to put those fields constantly
>> following the same pattern, and must have its tendency to keep
>> in that way.
>>
>> The "union { u64 raw; struct {} }" way isn't that uncommon in
>> the kernel, here are a few existing examples:
>> 	drivers/crypto/marvell/octeontx2/otx2_cpt_hw_types.h
>> 	drivers/crypto/cavium/nitrox/nitrox_req.h
>> 	include/asm-generic/hyperv-tlfs.h
>>
>> Taking a step back, if one field in a new event in the future
>> happens to be odd, we could still fetch field in its own way:
>> event->evt[4] is still available to extract via FIELD_GET; or
>> just define another union exclusively for that event, neither
>> of which sounds like the end of world.
>>
>> Having said that, I'd defer to Will. So, here is just my two
>> cents.
> 
> My only real concern is the fragility of using bitfields. I don't _think_
> the compiler is obliged to lay them out in the obvious way and I can't
> think of anything worse than being given a bad pretty-print when debugging
> a real driver issue!

Shall I mention big-endian? :D

FWIW I'm not a fan of the bitfield trickery either. However, unions 
aside, I do still think it would be a good idea for the raw event data 
storage to be in struct arm_smmu_event itself - having one local 
variable carry a pointer to another local variable in the same scope 
seems a bit silly.

Thanks,
Robin.
