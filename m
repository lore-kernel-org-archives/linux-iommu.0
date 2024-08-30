Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745FE13049E
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037361; cv=none; b=InMfhq0EEQ2lv8mEVbCvYIT1syiGsiATIEBnhoF5fJ4866QoZuLZmWhkt2bW3oQuY9vmHhq5u2dIggxTvQ8X1EX/GALDR+dspiqpXEKZMKtkUlAdbwVtQICMv1jp7eG3nBfCL4JGPjBniELB4sftihbWL6tuswLo6Ej6rFeulPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037361; c=relaxed/simple;
	bh=Nj/aMAhItkBEFA253aJJn+6DPehCDcVHyJfTY5N7N78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBmjyhJ8PNeU26lXO9FYfX0fUTjVp1fbfAcfYkOPomxf5JcnLYF6TL+s0BlpJeIVu7VrQaTXK1/Wm7rbSOYGr86yodRnfBuodkfDsM4Tm8hw+5Fc9rLwiadljMbU06f1qZQgG07gDqR83HL1Ji7JBzeGEm8TDqCIK+npxzG6Y94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6F701063;
	Fri, 30 Aug 2024 10:03:04 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 188D13F66E;
	Fri, 30 Aug 2024 10:02:36 -0700 (PDT)
Message-ID: <19c91b5f-e615-4198-b9e3-d0d00084d139@arm.com>
Date: Fri, 30 Aug 2024 18:02:35 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] iommu/arm-smmu-v3: Match Stall behaviour for S2
To: Nicolin Chen <nicolinc@nvidia.com>, Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, will@kernel.org, joro@8bytes.org,
 jean-philippe@linaro.org, jgg@ziepe.ca, mshavit@google.com
References: <20240830110349.797399-1-smostafa@google.com>
 <20240830110349.797399-2-smostafa@google.com>
 <ZtHznQwkJmugKef2@Asurada-Nvidia>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ZtHznQwkJmugKef2@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/08/2024 5:30 pm, Nicolin Chen wrote:
> On Fri, Aug 30, 2024 at 11:03:47AM +0000, Mostafa Saleh wrote:
>   
>> According to the spec (ARM IHI 0070 F.b), in
>> "5.5 Fault configuration (A, R, S bits)":
>>      A STE with stage 2 translation enabled and STE.S2S == 0 is
>>      considered ILLEGAL if SMMU_IDR0.STALL_MODEL == 0b10.
>>
>> Also described in the pseudocode “SteIllegal()”
>>      if STE.Config == '11x' then
>>          [..]
>>          if eff_idr0_stall_model == '10' && STE.S2S == '0' then
>>              // stall_model forcing stall, but S2S == 0
>>              return TRUE;
>>
>> Which means, S2S must be set when stall model is
>> "ARM_SMMU_FEAT_STALL_FORCE", but currently the driver ignores that.
>>
>> Although, the driver can do the minimum and only set S2S for
>> “ARM_SMMU_FEAT_STALL_FORCE”, it is more consistent to match S1
>> behaviour, which also sets it for “ARM_SMMU_FEAT_STALL” if the
>> master has requested stalls.
> 
> If I read the SteIllegal() correctly, it seems S2S would conflict
> against the STE.EATS settings?
> 
> // Check ATS configuration
> if ((sec_sid == SS_NonSecure && SMMU_IDR0.ATS == '1') ||
>      (sec_sid == SS_Realm && SMMU_R_IDR0.ATS == '1')) &&
>      STE.Config != 'x00' then
>      // Needs to be NS/Realm, ATS enabled, and not Bypass
>          if STE.EATS == '01' && STE.S2S == '1' then
>              // Full ATS mode
>              if STE.Config == '11x' || constr_unpred_EATS_S2S then
>                  // if stage 2 enabled or CONSTRAINED UNPREDICTABLE for SMMUv3.0
>                  return TRUE;
> 	
> So, if master->stall_enabled and master->ats_enabled, there would
> be a bad STE?

Indeed, but as discussed previously, to get there would require either 
firmware or hardware to bogusly advertise both stall and ATS 
capabilities for the same device, which we decided is beyond the scope 
of what's worth trying to reason about. If a nonsensical system leads to 
obviously blowing up with C_BAD_STE, that's arguably not such a bad thing.

Thanks,
Robin.
