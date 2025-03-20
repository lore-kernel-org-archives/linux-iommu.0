Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3630F224AFA
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742490692; cv=none; b=KMbtAdCmlvhOvdjj31UMmaCWR/1RlZJDiiJzLSL++eOP071vhXh6j70ImR2r+0Ml9QcQ1mYCyHT6+6TK0R1EElsEBEvcaJkM6vLW38sweLtOV1bKy2C4vEozh0q1Oib6flw4ARBcM0jJPXJsql9bNUOaOzjXsnIEydkxI9gcFIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742490692; c=relaxed/simple;
	bh=AdqVVkv/pV4tq7Nbasjp5R+AYZLXmvGl7wulY1PUWjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hD5O769y5pV2ThAlPl/RTvdrPSaX2aC8oV9XfU5iInOpg97FP3TR05cHxh8erYTh8N5+MryEVtSAzbJm1DgRCCoDokZpMxo4owsYX5aidgJhxvJVYtMqoj7++l/mNPaPVVU6TNFDFoNQi8VOJanZz4jxLv139Z4wTwGZaoHmXi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51D83113E;
	Thu, 20 Mar 2025 10:11:38 -0700 (PDT)
Received: from [10.57.69.2] (unknown [10.57.69.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3E10F3F673;
	Thu, 20 Mar 2025 10:11:26 -0700 (PDT)
Message-ID: <952cc3ea-ca11-43a3-a8f4-36e3bbb1fa84@arm.com>
Date: Thu, 20 Mar 2025 17:11:25 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] arm64: Add BBM Level 2 cpu feature
Content-Language: en-GB
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: ryan.roberts@arm.com, yang@os.amperecomputing.com, corbet@lwn.net,
 catalin.marinas@arm.com, will@kernel.org, jean-philippe@linaro.org,
 robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
 ardb@kernel.org, mark.rutland@arm.com, joey.gouly@arm.com, maz@kernel.org,
 james.morse@arm.com, broonie@kernel.org, oliver.upton@linux.dev,
 baohua@kernel.org, david@redhat.com, ioworker0@gmail.com, jgg@ziepe.ca,
 nicolinc@nvidia.com, mshavit@google.com, jsnitsel@redhat.com,
 smostafa@google.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev
References: <20250319150533.37440-2-miko.lenczewski@arm.com>
 <20250319150533.37440-3-miko.lenczewski@arm.com>
 <f9c5839e-5d55-497e-9df3-ab778c4eae72@arm.com>
 <20250320170936.GB487465@e133081.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250320170936.GB487465@e133081.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/03/2025 17:09, Mikołaj Lenczewski wrote:
> On Thu, Mar 20, 2025 at 01:24:25PM +0000, Suzuki K Poulose wrote:
>> On 19/03/2025 15:05, Mikołaj Lenczewski wrote:
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index fb8752b42ec8..3e4cc917a07e 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -453,6 +453,9 @@
>>>    	arm64.no32bit_el0 [ARM64] Unconditionally disable the execution of
>>>    			32 bit applications.
>>> +	arm64.nobbml2	[ARM64] Unconditionally disable Break-Before-Make Level
>>> +			2 support
>>> +
>>>    	arm64.nobti	[ARM64] Unconditionally disable Branch Target
>>>    			Identification support
>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>> index 940343beb3d4..49deda2b22ae 100644
>>> --- a/arch/arm64/Kconfig
>>> +++ b/arch/arm64/Kconfig
>>> @@ -2057,6 +2057,17 @@ config ARM64_TLB_RANGE
>>>    	  The feature introduces new assembly instructions, and they were
>>>    	  support when binutils >= 2.30.
>>> +config ARM64_BBML2_NOABORT
>>> +	bool "Enable support for Break-Before-Make Level 2 detection and usage"
>>> +	default y
>>> +	help
>>> +	  FEAT_BBM provides detection of support levels for break-before-make
>>> +	  sequences. If BBM level 2 is supported, some TLB maintenance requirements
>>> +	  can be relaxed to improve performance. We additonally require the
>>> +	  property that the implementation cannot ever raise TLB Conflict Aborts.
>>> +	  Selecting N causes the kernel to fallback to BBM level 0 behaviour
>>> +	  even if the system supports BBM level 2.
>>
>> minor nit: Should we mention that the feature can be disabled at runtime
>> using a kernel parameter ?
> 
> Yes, this sounds very reasonable, I should have thought of that. Will
> mention the commandline parameter in the kconfig option documentation.

And also may be mention this in the patch description and may be also
add the rationale for providing this tunable.

Cheers
Suzuki


> 
>>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>>> index d561cf3b8ac7..1a4adcda267b 100644
>>> --- a/arch/arm64/kernel/cpufeature.c
>>> +++ b/arch/arm64/kernel/cpufeature.c
>>> @@ -2176,6 +2176,67 @@ static bool hvhe_possible(const struct arm64_cpu_capabilities *entry,
>>>    	return arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_HVHE);
>>>    }
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
>>> +static inline unsigned int cpu_read_midr(int cpu)
>>> +{
>>> +	WARN_ON_ONCE(!cpu_online(cpu));
>>> +
>>> +	return per_cpu(cpu_data, cpu).reg_midr;
>>> +}
>>> +
>>> +static bool has_bbml2_noabort(const struct arm64_cpu_capabilities *caps, int scope)
>>> +{
>>> +	if (!IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT))
>>> +		return false;
>>> +
>>> +	if (scope & SCOPE_SYSTEM) {
>>> +		int cpu;
>>> +
>>> +		/* We are a boot CPU, and must verify that all enumerated boot
>>
>> minor nit: See Documentation/process/coding-style.rst,
>> Section 8 Commenting.
> 
> My bad, had skimmed the coding style at one point but clearly missed or
> forgot the section on comments. Will fix up this and all other instances
> of the same issue.
> 

