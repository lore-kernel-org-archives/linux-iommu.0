Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC49F4317D
	for <iommu@lists.linux.dev>; Thu, 11 Dec 2025 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765451113; cv=none; b=b82GU0ewPYRDYYp/3pZUrlE5VumNwJXGZrqOD5ofF7eiYXEMy8yJ1kVpSyL2U+TEYlWzwug3Cd1lKqj/48UYdwrbh+eGZJqGBjil4zycx3fxixsdO7FnId6kfw0C2NyGfjyYCkeqTd29pY8tJhs5/jLV0UQb/cYgM+MFfNfYUKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765451113; c=relaxed/simple;
	bh=xiATBxpdJp6ZaEj5YpXGm5ulnv79Dfm+n4B7qxfpqk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qg1hs2M2q4Hpikdt75QAck6/pvdyUuJn2KcKaJ5GyugV4tV8bQhTlQLMZcc9tHfKHXTQX7yHJInsg8epnZql45qvJuyi/EAfFghG8DylfM53hSMCmcgeTbSGyAyc/p35h7lR3Sx1ttWrhFqAGbSuntJnoVsqgQcd00P32TaEb1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E32C175D;
	Thu, 11 Dec 2025 03:04:58 -0800 (PST)
Received: from [10.57.46.197] (unknown [10.57.46.197])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7028F3F740;
	Thu, 11 Dec 2025 03:05:04 -0800 (PST)
Message-ID: <47689561-ed13-4525-825d-60eb8c36ae4c@arm.com>
Date: Thu, 11 Dec 2025 11:04:29 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/io-pgtable-arm: Add misisng concatenated PGD cases
To: Will Deacon <will@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 joro@8bytes.org, Tomasz Nowicki <tnowicki@google.com>
References: <20251130194506.593700-1-smostafa@google.com>
 <18a39079-2285-47fb-b306-040f2bc1bbaa@arm.com> <aTgX9qhaLyrQ5iye@google.com>
 <498bbad4-ea64-4a24-a63f-e131d271990a@arm.com> <aTjCDvtANr2WIv3L@google.com>
 <8e058f60-60da-47c2-9947-2ea26cca1639@arm.com> <aTonvd9_4hY4-CpS@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aTonvd9_4hY4-CpS@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-11 2:09 am, Will Deacon wrote:
> On Wed, Dec 10, 2025 at 12:06:10PM +0000, Robin Murphy wrote:
>> On 2025-12-10 12:42 am, Will Deacon wrote:
>>> On Tue, Dec 09, 2025 at 01:33:36PM +0000, Robin Murphy wrote:
>>>> On 2025-12-09 12:37 pm, Mostafa Saleh wrote:
>>>>> On Tue, Dec 09, 2025 at 11:34:34AM +0000, Robin Murphy wrote:
>>>>>> On 2025-11-30 7:45 pm, Mostafa Saleh wrote:
>>>>>>> arm_lpae_concat_mandatory() assumes that OAS >= IAS which is not
>>>>>>> correct for SMMUs supporting AArch32, and have OAS = 32/36 bits,
>>>>>>> as IAS would be 40 bits.
>>>>>>
>>>>>> But that is only when *using* AArch32 format. The bit in chapter 3.4 of the
>>>>>> SMMU architecture is talking about the maximum IAS that an SMMU
>>>>>> implementation needs to be able to accommodate based on its configuration,
>>>>>> but it does then attempt to clarify that the actual IPA size in use by any
>>>>>> given context should depend on the VMSA format in use:
>>>>>>
>>>>>> "VMSAv8-32 LPAE always supports an IPA size of 40 bits, whereas VMSAv8-64
>>>>>> and VMSAv9-128 limits the maximum IPA size to the maximum PA size."
>>>>>>
>>>>>> Rule R_SRKBC in the Arm ARM lays out the exact T0SZ constraints with this
>>>>>> AArch32/AArch64 detail.
>>>>>
>>>>> I see, thanks a lot for the explanation, I got confused by the this
>>>>> statement:
>>>>> Note: If AArch32 is implemented, IAS == MAX(40, OAS), otherwise IAS == OAS.
>>>>
>>>> Indeed, that appears confusingly contradictory; I've filed a bug.
>>>
>>> I think the spec has always been worded like this. My reading is that, in
>>> isolation:
>>>
>>>     - VMSAv8-32 LPAE always uses a 40-bit IAS
>>>     - VMSAv8-64 has IAS == OAS and this can be smaller than 40 bits
>>>
>>> so if AArch32 is implemented, we know that the hardware supports at
>>> least a 40-bit IAS and in that case the VMSAv8-64 IAS can be bigger
>>> than the OAS.
>>
>> No, the VMSAv8-64 IAS can never be bigger than OAS, as that would violate
>> VMSA (see rules R_DTLMN and R_SRKBC). The SMMU spec seems mostly fixated on
>> the notional maximum IAS that an SMMU must accommodate in general across all
>> supported formats; the limitations of using any particular format must still
>> apply though (similarly, the fact that AArch32 has a fixed 40-bit output
>> doesn't mean that OAS and S2PS don't still matter for AArch64 format.)
> 
> A VMSAv8-32 stage-1 could still input a 40-bit IAS into a VMSAv8-64
> stage-2 when the OAS < 40-bit though, right? If that's the only case
> where this happens, then I agree we should ditch the complexity from the
> driver on the grounds that we don't ever use the 32-bit formats.

Yes, it is perfectly possible with either format to configure the S1 
*output* size (CD.IPS, or 40 when CD.AA64==0) to be larger than the S2 
input size (STE.S2T0SZ), and if S1 tries to use an IPA beyond the actual 
S2 range then it gets a S2 translation fault, per VMSA rule R_BZHGM.

Cheers,
Robin.
