Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06ED31EE03C
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889830; cv=none; b=i9ATkIq//BFqymm5JcwUCIWgLrW6wH/XXkD9i8i8hMKoBfU+2v95JWgODsJcP67TWntD+YFXixRSAWb713ePkFh1J8JJeg/VMUg1O1WTRdIvsnNZLEfTMdPWJJGjhzyoFxSwb4Snjidqob4CgysWH37e/zWd4al5FO7jDf/dyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889830; c=relaxed/simple;
	bh=D97hN9+qRh1MAHI4KkogFmA2lZeskHhJ51u2Hz9Q5gQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMosHW2uHpgu1ybu6eVvin7nqqz7k2ZIkMdt5MnVzyE4kPfjTQDM4y6BQ9KxL3lm2ZUcOVrzBVcrZ+pOk/Wr6N725YH5690jPHU8LXiampNkF1sEOuKSIsWFHC+HxfzD7C22ZKaOWxg3Jg9XvDedkpY8B+BB5smskqoljsuE35E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A9A61477;
	Thu, 13 Mar 2025 11:17:18 -0700 (PDT)
Received: from [10.57.85.159] (unknown [10.57.85.159])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17BE53F694;
	Thu, 13 Mar 2025 11:17:03 -0700 (PDT)
Message-ID: <83c04cc2-a170-4d4d-82e3-23aec9749352@arm.com>
Date: Thu, 13 Mar 2025 18:17:02 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] arm64: Add BBM Level 2 cpu feature
Content-Language: en-GB
To: =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>
Cc: suzuki.poulose@arm.com, corbet@lwn.net, catalin.marinas@arm.com,
 will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
 joro@8bytes.org, akpm@linux-foundation.org, mark.rutland@arm.com,
 joey.gouly@arm.com, maz@kernel.org, james.morse@arm.com, broonie@kernel.org,
 anshuman.khandual@arm.com, oliver.upton@linux.dev, ioworker0@gmail.com,
 baohua@kernel.org, david@redhat.com, jgg@ziepe.ca,
 shameerali.kolothum.thodi@huawei.com, nicolinc@nvidia.com,
 mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20250313104111.24196-2-miko.lenczewski@arm.com>
 <20250313104111.24196-3-miko.lenczewski@arm.com>
 <0abe8643-d4ea-4e77-bd77-afe07399eec9@os.amperecomputing.com>
 <20250313181319.GB40525@mazurka.cambridge.arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250313181319.GB40525@mazurka.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/03/2025 18:13, Mikołaj Lenczewski wrote:
> On Thu, Mar 13, 2025 at 10:21:51AM -0700, Yang Shi wrote:
>> On 3/13/25 3:41 AM, Mikołaj Lenczewski wrote:
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index fb8752b42ec8..3e4cc917a07e 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -453,6 +453,9 @@
>>>   	arm64.no32bit_el0 [ARM64] Unconditionally disable the execution of
>>>   			32 bit applications.
>>>   
>>> +	arm64.nobbml2	[ARM64] Unconditionally disable Break-Before-Make Level
>>> +			2 support
>>
>> Hi Miko,
>>
>> A question about the kernel boot parameter. Can this parameter be used 
>> in early boot stage? A quick look at the code shows it should be ok, for 
>> example, cpu_has_bti() is called in map_kernel(). But I'd like to double 
>> check because my patchset needs to check this parameter in map_mem() to 
>> determine whether large block mapping can be used or not.
>>
>> And a nit below.
> 
> I will need to double check exactly when the arm64 software overrides
> are finalised, but as long as those values are finalised in / before (?)
> the early boot stage then it should be fine? Will reply again once I
> check and have an answer.

This will work fine. The override is setup in the PI code before start_kernel().

>    
>>> +static inline bool bbml2_possible(void)
>>> +{
>>> +	return !arm64_test_sw_feature_override(ARM64_SW_FEATURE_OVERRIDE_NOBBML2);
>>> +}
>>
>> Can this be moved to cpufeature.h? My patch will use this, anyway I can 
>> do it in my patchset.

I'd prefer to do the moving as part of the series that needs it moved.

Thanks,
Ryan

>>
>> Thanks,
>> Yang
> 
> I can do so. In fact, on second thought, I will probably extend this to
> also include the `IS_ENABLED(CONFIG_ARM64_BBML2_NOABORT)` check as well,
> and then move it to cpufeature.h, instead of folding said check into
> has_bbml2_noabort().
> 

