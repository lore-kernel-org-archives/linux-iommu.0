Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A6D1C861D
	for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741944423; cv=none; b=jPfRFdUEsBpJ1gThwHW1uVfDdAAdnndZ2J9VCTlQoh98wzkre4ywgQlI0pfXOe0LR40wkvSQL1p3MIBuVYmhtYrDAJR7MR3p5MI8BqBEyoo9dwtxRMjOL5VaIgGjUkc3LIehWHPMHMvHLoO/RelYxrWmZK2bpK7AsZxL/0hwCg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741944423; c=relaxed/simple;
	bh=JcldlY/ETPmR3IenknhNxPNgRcWA0ROHMHWWITDho/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqtDtBIi8pw7nja+MEluEiSLuSWQoEw7Sb1w/8jK4z9ZIo5h4UwKZPNr/sUMrjMlhTa/6cDhu6VLnpsC4eB5UXpIkLOnJ8pnW+TpyMBtx11f+J7WFYeuFsO72ywSeNlFsyu7NlHTPonOkLn1cXtsQsTO+C6LMOeRsIecR8vXz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 549631424;
	Fri, 14 Mar 2025 02:27:11 -0700 (PDT)
Received: from [10.57.85.159] (unknown [10.57.85.159])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73EA03F673;
	Fri, 14 Mar 2025 02:26:57 -0700 (PDT)
Message-ID: <d3a15aaf-16a6-4a88-a6c5-9b9afaa5f370@arm.com>
Date: Fri, 14 Mar 2025 09:26:56 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] arm64: Add BBM Level 2 cpu feature
Content-Language: en-GB
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: suzuki.poulose@arm.com, yang@os.amperecomputing.com, corbet@lwn.net,
 catalin.marinas@arm.com, will@kernel.org, jean-philippe@linaro.org,
 robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
 mark.rutland@arm.com, joey.gouly@arm.com, maz@kernel.org,
 james.morse@arm.com, broonie@kernel.org, anshuman.khandual@arm.com,
 oliver.upton@linux.dev, ioworker0@gmail.com, baohua@kernel.org,
 david@redhat.com, jgg@ziepe.ca, shameerali.kolothum.thodi@huawei.com,
 nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
 smostafa@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20250313104111.24196-2-miko.lenczewski@arm.com>
 <20250313104111.24196-3-miko.lenczewski@arm.com>
 <ea10caee-59ef-4a00-9b61-37cb0a379411@arm.com>
 <20250313180833.GA40525@mazurka.cambridge.arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250313180833.GA40525@mazurka.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/03/2025 18:08, Mikołaj Lenczewski wrote:
> On Thu, Mar 13, 2025 at 04:13:22PM +0000, Ryan Roberts wrote:
>> On 13/03/2025 10:41, Mikołaj Lenczewski wrote: 
>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>> index d561cf3b8ac7..b936e0805161 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>> @@ -2176,6 +2176,76 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
>>>  	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
>>>  }
>>>  
>>> +static inline bool bbml2_possible(void)
>>> +{
>>> +	return !arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_NOBBML2);
>>
>> If you're going to keep this helper, I think it really needs to be:
>>
>> return IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT) &&
>>        !arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_NOBBML2);
>>
>> Then you would simplify the caller to remove it's own
>> IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT) check.
>>
>> But personally I would remove the helper and just fold the test into
>> has_bbml2_noabort().
>>
>> Thanks,
>> Ryan
> 
> I was debating folding it into has_bbml2_noabort(), but went ahead and
> implemented it separately to match hvhe_possible(), which was another sw
> feature helper.

hvhe_possible() is a .matches function, so there is nothing to fold it into.

> 
> But I agree, folding it will be simpler and read just as easily (if not
> easier). Will do so.
> 
>>> +}
>>> +
>>> +static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
>>> +{
>>> +	/* We want to allow usage of bbml2 in as wide a range of kernel contexts
>>> +	 * as possible. This list is therefore an allow-list of known-good
>>> +	 * implementations that both support bbml2 and additionally, fulfill the
>>> +	 * extra constraint of never generating TLB conflict aborts when using
>>> +	 * the relaxed bbml2 semantics (such aborts make use of bbml2 in certain
>>> +	 * kernel contexts difficult to prove safe against recursive aborts).
>>> +	 *
>>> +	 * Note that implementations can only be considered "known-good" if their
>>> +	 * implementors attest to the fact that the implementation never raises
>>> +	 * TLBI conflict aborts for bbml2 mapping granularity changes.
>>> +	 */
>>> +	static const struct midr_range supports_bbml2_noabort_list[] = {
>>> +		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
>>> +		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
>>> +		{}
>>> +	};
>>> +
>>> +	return is_midr_in_range_list(cpu_midr, supports_bbml2_noabort_list);
>>> +}
>>> +
>>> +static inline unsigned int __cpu_read_midr(int cpu)
>>
>> nit: why the double underscrore prefix?
> 
> Again copying other helpers I saw that seemed to do similar things.
> Didn't know if this was the expected style, so did as other helpers did.
> Will remove.

Often those double underscores are used when you have a public function wrapping
into a private function, like this:

static void __do_a_thing(bool modify_behaviour_in_some_way);

void do_a_thing(void)
{
	__do_a_thing(false);
}

I'm sure the coding style offers a better explanation.

Thanks,
Ryan

> 
> Thank you for the review.
> 

