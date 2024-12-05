Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292C9199920
	for <iommu@lists.linux.dev>; Thu,  5 Dec 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733414116; cv=none; b=SM0ZXzGSZBPkocg0Ge4kzoZTGZRKFBlFtFiXv8N2sf+6CzaJ7bqpSUc3WIe/6Z4s3B54FYpt6M1gFjhSkJyeAJ1WsAEqYDciU7jED4pREeDJN0+yYQaqMUE4/NKDelSWPwIq1QyxIihsqURNz2Fal/EL8YFm6HKH0qn/LCMs4Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733414116; c=relaxed/simple;
	bh=id3bJfPOzglkZ/VyTZlmgf6gLIm4bz8v6hnzDUEjsn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GD6f3yY6lwdfR2OQNKycpx/Kr422o4pW0goj8hyDQhAjooU7SpLDb/bjYFTgN7PT2IjyhkKPux3wXzh2kbpjTYv0VtvFbcnKv1HhQQe/XTpW6TtAXHnlNWW+68ESag1jl/xVhDqsRx0XqEd6wpV09/sv4q3HYSE2SsIn7f5PU+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54CD41063;
	Thu,  5 Dec 2024 07:55:42 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC4DD3F5A1;
	Thu,  5 Dec 2024 07:55:12 -0800 (PST)
Message-ID: <6129a590-6b1b-4368-8bcc-a09a8754bbe5@arm.com>
Date: Thu, 5 Dec 2024 15:55:11 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: cpufeature: Add GCS to cpucap_is_possible()
To: Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>
Cc: will@kernel.org, joro@8bytes.org, jean-philippe@linaro.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 mark.rutland@arm.com, joey.gouly@arm.com, ryan.roberts@arm.com
References: <68a37b00a720f0827cac0e4f40e4d3a688924054.1733406275.git.robin.murphy@arm.com>
 <416c7369fcdce4ebb2a8f12daae234507be27e38.1733406275.git.robin.murphy@arm.com>
 <051c017c-a60f-48a7-b09f-07f0f32e48e3@sirena.org.uk>
 <Z1HF3i-mAAXDHKUP@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <Z1HF3i-mAAXDHKUP@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/12/2024 3:25 pm, Catalin Marinas wrote:
> On Thu, Dec 05, 2024 at 03:04:11PM +0000, Mark Brown wrote:
>> On Thu, Dec 05, 2024 at 01:48:10PM +0000, Robin Murphy wrote:
>>> Since system_supports_gcs() ends up referring to cpucap_is_possible(),
>>> teach the latter about GCS for consistency with similar features.
>>
>> Not clear why this is part of a series, there's no obvious relationship
>> with patch 1?
> 
> No, probably Robing forgot to pass --no-thread to git.

Yeah, this was just a tangent from poking around figuring out how to 
detect GCS being enabled for the main patch.

>>>   static inline bool system_supports_gcs(void)
>>>   {
>>> -	return IS_ENABLED(CONFIG_ARM64_GCS) &&
>>> -		alternative_has_cap_unlikely(ARM64_HAS_GCS);
>>> +	return alternative_has_cap_unlikely(ARM64_HAS_GCS);
>>>   }
>>
>> Ah, this is bitrot since the series was on the list for so long.  As
>> well as HAFT which Rutland mentioned it looks like _bti_kernel(),
>> _irq_prio_masking() and possibly others have the same thing.  Ideally
>> we'd have no uses of IS_ENABLED() in these functions so it's a bit more
>> obvious.  In any case
>>
>> Reviewed-by: Mark Brown <broonie@kernel.org>
> 
> Thanks. This patch will go in via the arm64 tree. I'll leave the other
> for the smmu tree.

Thanks!

Robin.
