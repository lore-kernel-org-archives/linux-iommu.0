Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9EF3FB055
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 14:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373034; cv=none; b=SojrZWymiX3IRpLBwTUBrDvoAE3attNsaCQ5gRdL7FrBGmJsKf4stguH0HK3vI+YhL1gBnxoFBUG5xFTPk0IGT8RIhvmUZhchv3+dcpjAAT9t21Skf1Jno2h2WtrdvMm0a17DpoGL4TqEEBH/1cErXtxE/MW3eIStGhNOWJFq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373034; c=relaxed/simple;
	bh=VkzYFuLchlwJSvO1cByJNfVkdEU8sgvxxagzcKl5gOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWGSq7J64muwcZACW8YfqOPnG9rxSPofbJyNmth6CN3vPSDhQs/05dAFLIP1SD7wSJpEvqgY032iYDP64dpKw0If63GE3rnMCAtkLnko1w7RjYhAHl3XADXh5y5bsb6CQXPvrlyK3YWhbzK4aveFlpYV4mK8DqeC/opCpwFXJIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PlCzdKPM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PlCzdKPM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09F9614BF;
	Mon, 10 Aug 2026 07:43:48 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3913F3F86F;
	Mon, 10 Aug 2026 07:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786373032; bh=VkzYFuLchlwJSvO1cByJNfVkdEU8sgvxxagzcKl5gOw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PlCzdKPMm7x8K/Od7wLEqiKm4370YEMfmHX6sOtFxEmJv4P+H/fq9tlb/QcAhYlCr
	 aOtpeqkDDW596Dn0G3/QTbUN3QbtjRIHy/+JKR/LEvBVldPLO4Id3mXUcMDo+dbSca
	 sTa8ERLD3CQI3uA6xMHGRZkirzcWeb3WtnGb3770=
Message-ID: <048c8d59-d47d-4f64-b93d-3b041636e230@arm.com>
Date: Mon, 10 Aug 2026 15:43:46 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Override for Inst/Data attribute
To: Jason Gunthorpe <jgg@ziepe.ca>, Peter Griffin <peter.griffin@linaro.org>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Pranjal Shrivastava <praan@google.com>,
 Daniel Mentz <danielmentz@google.com>, Mostafa Saleh <smostafa@google.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org,
 willmcvicker@google.com, jyescas@google.com
References: <20260724-arm-smmu-v3-instcfg-override-v1-0-e7acf4a8a525@linaro.org>
 <20260724-arm-smmu-v3-instcfg-override-v1-2-e7acf4a8a525@linaro.org>
 <amOpSPmc36+YXgCQ@nvidia.com>
 <CADrjBPoOctsStZn84vtCymdKen2R9XcM880=wxXSv1tpQ5+vyg@mail.gmail.com>
 <20260810141553.GP200537@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260810141553.GP200537@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/08/2026 3:15 pm, Jason Gunthorpe wrote:
> On Fri, Aug 07, 2026 at 03:37:37PM +0100, Peter Griffin wrote:
> 
>>>> @@ -1222,7 +1224,8 @@ void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits)
>>>>        if (cfg & BIT(1)) {
>>>>                used_bits[1] |=
>>>>                        cpu_to_le64(STRTAB_STE_1_S2FWB | STRTAB_STE_1_EATS |
>>>> -                                 STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV);
>>>> +                                 STRTAB_STE_1_SHCFG | STRTAB_STE_1_MEV |
>>>> +                                 STRTAB_STE_1_INSTCFG);
>>>>                used_bits[2] |=
>>>>                        cpu_to_le64(STRTAB_STE_2_S2VMID | STRTAB_STE_2_VTCR |
>>>>                                    STRTAB_STE_2_S2AA64 | STRTAB_STE_2_S2ENDI |
>>>
>>> This adds for "stage-1" and "stage-2", while missing "bypass"?
>>
>> I need to follow up again on this point, but I don't believe currently
>> we require the override for Laguna when it's in bypass.
> 
> Oh? Why not?
> 
> Is the issue the IOPTEs are set to no-exec or something like that?

In general, there isn't expected to be anything in the memory system 
downstream of the SMMU that makes use of the Privileged or 
Instruction/Data attributes, so I would assume that is the case on this 
SoC. FWIW, hardware folks would be quite keen on relaxing the 
architecture to say that an SMMU isn't even required to propagate those 
attributes at all.

Thanks,
Robin.
