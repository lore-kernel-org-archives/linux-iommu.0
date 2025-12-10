Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02827286A4
	for <iommu@lists.linux.dev>; Wed, 10 Dec 2025 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765368383; cv=none; b=HcsDaV2eYTC3BbSQBuK4wewlPaL2RyPA/1wKjkEXwU1cyhoQrnbTkw1bzY8Qb+kSUau/8Jsp45p4taSafZTD/DO+2zD1mh4xYFil2ELE8H94GynFrUMVasugz++99NhAyxY9RNi1y+jLtUI9vLaQMS8KvmzlOdCWOzb4bbQCIqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765368383; c=relaxed/simple;
	bh=kmC9hhbaXSanbfJwRxX/To1YiW7m3Jbun3vWTww+S5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkNxGXmajvf9cvTwkMYHWfVccgNFbW0S8cw1V33rHqGpKqlkdGVoWOV3aUSMl+x1JhL+Iddwz/O9USQ2y0Im9jjH1wCTIJDKZxqY6uHkJTEC1/ytKsLanugRS6p/9Ot91ZUzPvXDxmSwc149eWGJwGCmipnfz/QFTzRZZJZlp6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08616153B;
	Wed, 10 Dec 2025 04:06:14 -0800 (PST)
Received: from [10.57.45.247] (unknown [10.57.45.247])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D648B3F73B;
	Wed, 10 Dec 2025 04:06:19 -0800 (PST)
Message-ID: <8e058f60-60da-47c2-9947-2ea26cca1639@arm.com>
Date: Wed, 10 Dec 2025 12:06:10 +0000
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
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aTjCDvtANr2WIv3L@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-12-10 12:42 am, Will Deacon wrote:
> On Tue, Dec 09, 2025 at 01:33:36PM +0000, Robin Murphy wrote:
>> On 2025-12-09 12:37 pm, Mostafa Saleh wrote:
>>> On Tue, Dec 09, 2025 at 11:34:34AM +0000, Robin Murphy wrote:
>>>> On 2025-11-30 7:45 pm, Mostafa Saleh wrote:
>>>>> arm_lpae_concat_mandatory() assumes that OAS >= IAS which is not
>>>>> correct for SMMUs supporting AArch32, and have OAS = 32/36 bits,
>>>>> as IAS would be 40 bits.
>>>>
>>>> But that is only when *using* AArch32 format. The bit in chapter 3.4 of the
>>>> SMMU architecture is talking about the maximum IAS that an SMMU
>>>> implementation needs to be able to accommodate based on its configuration,
>>>> but it does then attempt to clarify that the actual IPA size in use by any
>>>> given context should depend on the VMSA format in use:
>>>>
>>>> "VMSAv8-32 LPAE always supports an IPA size of 40 bits, whereas VMSAv8-64
>>>> and VMSAv9-128 limits the maximum IPA size to the maximum PA size."
>>>>
>>>> Rule R_SRKBC in the Arm ARM lays out the exact T0SZ constraints with this
>>>> AArch32/AArch64 detail.
>>>
>>> I see, thanks a lot for the explanation, I got confused by the this
>>> statement:
>>> Note: If AArch32 is implemented, IAS == MAX(40, OAS), otherwise IAS == OAS.
>>
>> Indeed, that appears confusingly contradictory; I've filed a bug.
> 
> I think the spec has always been worded like this. My reading is that, in
> isolation:
> 
>    - VMSAv8-32 LPAE always uses a 40-bit IAS
>    - VMSAv8-64 has IAS == OAS and this can be smaller than 40 bits
> 
> so if AArch32 is implemented, we know that the hardware supports at
> least a 40-bit IAS and in that case the VMSAv8-64 IAS can be bigger
> than the OAS.

No, the VMSAv8-64 IAS can never be bigger than OAS, as that would 
violate VMSA (see rules R_DTLMN and R_SRKBC). The SMMU spec seems mostly 
fixated on the notional maximum IAS that an SMMU must accommodate in 
general across all supported formats; the limitations of using any 
particular format must still apply though (similarly, the fact that 
AArch32 has a fixed 40-bit output doesn't mean that OAS and S2PS don't 
still matter for AArch64 format.)

Note that AArch32 is still free to use less than 40 bits of IAS if it 
wants to, by setting S2T0SZ appropriately, it's just guaranteed to 
support a *minimum* S2T0SZ of 24 regardless of OAS, unlike AArch64.

Cheers,
Robin.

> That seems consistent to me; where is the contradiction?
> 
> Will (jet-lagged so may well be talking rubbish!)

