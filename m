Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEF21EBFE2
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890129; cv=none; b=uag3m9SHMLTkbg1NSzhJB3NtZfyXMXw/9ZwYe+3I7ioJae21pDfc6ylUQ4e4xu4R183JOTr1z6uAUwXk7JcYLuQ/pln8b2hK1R3YBLQ+lT6O2iUm6s/UuvGB0E31EmzlS6drXZd1RZbWAKAPE7dJAqXfNEy+o+/dJqfYox+YpxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890129; c=relaxed/simple;
	bh=dSLOfULCK1nvX6fb6LcmM+RyZWiKWlg/3qr7YVmQ6/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfpXc6/bHIx9YyY/Cm60phM8gVy+P+55Z52Rqzbq4/CO6I/dajgT7YtlVw0Sd6s7GMkJDAK37OOB6EyTbdgCc8loUke6435kghHo8O6Uu2pevOxivcuzxDTn9dgfPttGAp1mnYs32cFPlCaerncIeqnKUbHYFE7Iy8Pp9L5smNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 332BC1477;
	Thu, 13 Mar 2025 11:22:17 -0700 (PDT)
Received: from [10.57.85.159] (unknown [10.57.85.159])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10FAC3F694;
	Thu, 13 Mar 2025 11:22:01 -0700 (PDT)
Message-ID: <f244c20e-e11c-477b-9487-cb6738c028ca@arm.com>
Date: Thu, 13 Mar 2025 18:22:00 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] arm64: Add BBM Level 2 cpu feature
Content-Language: en-GB
To: Marc Zyngier <maz@kernel.org>,
 =?UTF-8?Q?Miko=C5=82aj_Lenczewski?= <miko.lenczewski@arm.com>
Cc: suzuki.poulose@arm.com, yang@os.amperecomputing.com, corbet@lwn.net,
 catalin.marinas@arm.com, will@kernel.org, jean-philippe@linaro.org,
 robin.murphy@arm.com, joro@8bytes.org, akpm@linux-foundation.org,
 mark.rutland@arm.com, joey.gouly@arm.com, james.morse@arm.com,
 broonie@kernel.org, anshuman.khandual@arm.com, oliver.upton@linux.dev,
 ioworker0@gmail.com, baohua@kernel.org, david@redhat.com, jgg@ziepe.ca,
 shameerali.kolothum.thodi@huawei.com, nicolinc@nvidia.com,
 mshavit@google.com, jsnitsel@redhat.com, smostafa@google.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <20250313104111.24196-2-miko.lenczewski@arm.com>
 <20250313104111.24196-3-miko.lenczewski@arm.com>
 <86ikocomvd.wl-maz@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <86ikocomvd.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/03/2025 17:34, Marc Zyngier wrote:
> On Thu, 13 Mar 2025 10:41:10 +0000,
> Mikołaj Lenczewski <miko.lenczewski@arm.com> wrote:
>>
>> diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
>> index c6b185b885f7..9728faa10390 100644
>> --- a/arch/arm64/kernel/pi/idreg-override.c
>> +++ b/arch/arm64/kernel/pi/idreg-override.c
>> @@ -209,6 +209,7 @@ static const struct ftr_set_desc sw_features __prel64_initconst = {
>>  		FIELD("nokaslr", ARM64_SW_FEATURE_OVERRIDE_NOKASLR, NULL),
>>  		FIELD("hvhe", ARM64_SW_FEATURE_OVERRIDE_HVHE, hvhe_filter),
>>  		FIELD("rodataoff", ARM64_SW_FEATURE_OVERRIDE_RODATA_OFF, NULL),
>> +		FIELD("nobbml2", ARM64_SW_FEATURE_OVERRIDE_NOBBML2, NULL),
>>  		{}
>>  	},
>>  };
>> @@ -246,6 +247,7 @@ static const struct {
>>  	{ "rodata=off",			"arm64_sw.rodataoff=1" },
>>  	{ "arm64.nolva",		"id_aa64mmfr2.varange=0" },
>>  	{ "arm64.no32bit_el0",		"id_aa64pfr0.el0=1" },
>> +	{ "arm64.nobbml2",		"arm64_sw.nobbml2=1" },
> 
> Why is that a SW feature? This looks very much like a HW feature to
> me, and you should instead mask out ID_AA64MMFR2_EL1.BBM, and be done
> with it. Something like:

I think this implies that we would expect the BBM field to be advertising BBML2
support normally and we would check for that as part of the cpufeature
detection. That's how Miko was doing it in v2, but Yang pointed out that
AmpereOne, which supports BBML2+NOABORT semantics, doesn't actually advertise
BBML2 in its MMFR2. So we don't want to check that field, and instead rely
solely on the MIDR allow-list + a command line override. It was me that
suggested putting that in the SW feature register, and I think that still sounds
like the right solution for this situation?

Thanks,
Ryan

> 
> diff --git a/arch/arm64/kernel/pi/idreg-override.c b/arch/arm64/kernel/pi/idreg-override.c
> index c6b185b885f70..803a0c99f7b46 100644
> --- a/arch/arm64/kernel/pi/idreg-override.c
> +++ b/arch/arm64/kernel/pi/idreg-override.c
> @@ -102,6 +102,7 @@ static const struct ftr_set_desc mmfr2 __prel64_initconst = {
>  	.override	= &id_aa64mmfr2_override,
>  	.fields		= {
>  		FIELD("varange", ID_AA64MMFR2_EL1_VARange_SHIFT, mmfr2_varange_filter),
> +		FIELD("bbm", ID_AA64MMFR2_EL1_BBM_SHIFT, NULL),
>  		{}
>  	},
>  };
> @@ -246,6 +247,7 @@ static const struct {
>  	{ "rodata=off",			"arm64_sw.rodataoff=1" },
>  	{ "arm64.nolva",		"id_aa64mmfr2.varange=0" },
>  	{ "arm64.no32bit_el0",		"id_aa64pfr0.el0=1" },
> +	{ "arm64.nobbml2",		"id_aa64mmfr2.bbm=0" },
>  };
>  
>  static int __init parse_hexdigit(const char *p, u64 *v)
> 
> 
> Thanks,
> 
> 	M.
> 

