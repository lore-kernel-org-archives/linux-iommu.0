Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58192229B02
	for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 09:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750324823; cv=none; b=Q4wOLJfrwiPKwrgb3qkjevH5UZVa0XNDa+afFkLu1+DcWwXG2CuvqN6lpmTt3gsDxn2fCaOSfeI0Sndr0wfvdjbkUZbisM/apV1WMW6UpC23c/7F+8ykhjGon+sJBq3A4GiM4P8YqcQAHIgAbS6JtVz5ZZy6u4rfwf2W2v5CZgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750324823; c=relaxed/simple;
	bh=xfFrk+hniYU5BoCwpn9Udt1EIwc5zRCB71cWPF4u8K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nAEnzOppJYUpKUzXvPgHyJjlmCZsoGZ2egWc8+rOPOZ41ob7ljahWqwXdYNkjisyENSPiq4xyZ4ZG0/xZ+gszRyPbK1QMUJbyVCVTSHu89sCwuycC3zjOrbCF+Q13o+69m/pF3f6lryNFiPSKgL0W5nXx6uqqQ+auVrfZs0/ffU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A806113E;
	Thu, 19 Jun 2025 02:19:59 -0700 (PDT)
Received: from [10.57.84.221] (unknown [10.57.84.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B13A3F58B;
	Thu, 19 Jun 2025 02:20:16 -0700 (PDT)
Message-ID: <8c6f1c91-176c-4382-b631-79948e8de16f@arm.com>
Date: Thu, 19 Jun 2025 10:20:14 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/4] arm64: Add BBM Level 2 cpu feature
Content-Language: en-GB
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: yang@os.amperecomputing.com, catalin.marinas@arm.com, will@kernel.org,
 jean-philippe@linaro.org, robin.murphy@arm.com, joro@8bytes.org,
 maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
 james.morse@arm.com, broonie@kernel.org, ardb@kernel.org, baohua@kernel.org,
 suzuki.poulose@arm.com, david@redhat.com, jgg@ziepe.ca, nicolinc@nvidia.com,
 jsnitsel@redhat.com, mshavit@google.com, kevin.tian@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20250617095104.6772-1-miko.lenczewski@arm.com>
 <20250617095104.6772-3-miko.lenczewski@arm.com>
 <e40989e9-9521-4915-9bae-eb7be1d4e056@arm.com>
 <20250619085701.GA10805@e133081.arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250619085701.GA10805@e133081.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/06/2025 09:57, Mikołaj Lenczewski wrote:
> On Wed, Jun 18, 2025 at 03:07:41PM +0100, Ryan Roberts wrote:
>> On 17/06/2025 10:51, Mikołaj Lenczewski wrote:
>>>  #ifdef CONFIG_ARM64_PAN
>>>  static void cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
>>>  {
>>> @@ -2980,6 +3015,11 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>>>  		.matches = has_cpuid_feature,
>>>  		ARM64_CPUID_FIELDS(ID_AA64MMFR2_EL1, EVT, IMP)
>>>  	},
>>> +	{
>>> +		.capability = ARM64_HAS_BBML2_NOABORT,
>>> +		.type = ARM64_CPUCAP_EARLY_LOCAL_CPU_FEATURE,
>>> +		.matches = has_bbml2_noabort,
>>
>> Is there a reason you have removed the .desc from this? Without it, the kernel
>> won't print a "detected" line when it enables the feature. Previously you had:
>>
>> 		.desc = "BBM Level 2 without conflict abort",
>>
>>> +	},
>>>  	{
>>>  		.desc = "52-bit Virtual Addressing for KVM (LPA2)",
>>>  		.capability = ARM64_HAS_LPA2, 
>>
> 
> Damn it! I completely forgot to birng that back. Yet another remenant of
> the NO_BBML2_NOABORT version we had discussed in v6, because a
> description field would have been confusing due to the double negation:
> 
> https://lore.kernel.org/all/83d1f7af-3dc7-45f9-94f3-8a0917c051d2@arm.com/
> 
> Thank you very much for spotting this Ryan! Ill return the description,
> and respin on Monday (unless it is possible to do this as a RESEND or
> similar, but I doubt it since this is technically a functional change) :/
> 

I think probably just send out a new version.

