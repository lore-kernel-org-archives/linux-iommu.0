Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2612223DDA
	for <iommu@lists.linux.dev>; Wed, 15 Oct 2025 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536289; cv=none; b=pmY6WoHwliaur7odREsujbZDpAgJgzMLaY01TrZNYenf2waACFVG+ZrWPk2O/m6sivNctuT7qlXtPYPaoDejgc/1/wj7XkIJhrhdxeBPyK/TO9noe8RzYTIcC5p4QAn82ODQMJe8IMyctDUE8f55IsrKgzg3YEzgv+L2pHlSbM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536289; c=relaxed/simple;
	bh=9KliX0Fwm0mxs+TvtbruCt12qrdzG68qq9h/Z4Zuejc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T38rYPgPXtHi+hdcOdZjpSAIQ/sZvTKz1+AmAQWPZ61SPVo/2tjnuapDnIiIyKJkr+N6jo1eClWJ/HFcfXuxPVC0+gWResQi/ERuU2BDK7Lzp6+mwpivUNVylius5wHR7JbwQgLtwqTAWbT8iIhm/JlAm5fMhVfwTWfBI8SAlg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CCE2106F;
	Wed, 15 Oct 2025 06:51:19 -0700 (PDT)
Received: from [10.57.36.191] (unknown [10.57.36.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C10573F6A8;
	Wed, 15 Oct 2025 06:51:25 -0700 (PDT)
Message-ID: <b48193a4-a37b-41ba-b4ba-8b5c67d812bd@arm.com>
Date: Wed, 15 Oct 2025 14:51:15 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, will@kernel.org, joro@8bytes.org,
 jgg@ziepe.ca, praan@google.com, Jason Gunthorpe <jgg@nvidia.com>
References: <20250929155001.3287719-1-smostafa@google.com>
 <20250929155001.3287719-5-smostafa@google.com>
 <86ca3918-4992-41a2-894f-f1fd8ce4121f@arm.com> <aO9vI1aEhnyZx1PL@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <aO9vI1aEhnyZx1PL@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-15 10:53 am, Mostafa Saleh wrote:
[...]
>>> +		KUNIT_FAIL(test, "");						\
>>> +		kunit_err(test, "selftest: test failed for fmt idx %d\n", (i));	\
>>
>> This looks suspect - AFAICS open-coded kunit_err() is intended for test
>> infrastucture errors (like the allocation in the next hunk below), while for
>> an actual test report message it seems it should just be:
>>
>> 	KUNIT_FAIL(test, "selftest: test failed for fmt idx %d\n", (i));
> 
> I see, I used kunit_err, as KUNIT_FAIL adds extra information which was
> noisy to be printed more than once as:
>    # arm_lpae_do_selftests: EXPECTATION FAILED at drivers/iommu/io-pgtable-arm-selftests.c:91
> I will check if there is a better way to do this.

But isn't that exactly what we want? The tests should not fail, but if 
they ever do then inevitably you're going to be asked to debug it from 
nothing more than a dmesg snippet in a forwarded email. Loud and 
detailed is good ;)

If anything we can trim the generic message to just the minimal useful 
information about the format, if KUnit can now provide the rest of the 
attribution for us. Ultimately we should aim to log all the test 
conditions together in one place (and probably only upon a failure, such 
that normal successful runs are quiet), but that can be a job for the 
future follow-up refactoring.

[...]
>>> +	dev = kunit_device_register(test, "io-pgtable-test");
>>> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, dev);
>>
>> Conversely, this is infrastructure, not an actual test of expected
>> io-pgtable behaviour, so I think just:
>>
>> 	cfg.iommu_dev = kunit_device_register(test, "io-pgtable-test");
>> 	if (IS_ERR(cfg.iommu_dev))
>> 		return;
>>
>> (it doesn't return NULLs either)
>>
> 
> Yes, I was not sure about this one, when checking the code base, every test
> handles kunit_device_register() failure differently, this seemed the
> most strict one so I used it, I will update that in the next version.

Yeah, my impression is that those have likely been copied from the 
lib/kunit/ code where it is actually testing its own API. I've now sent 
a patch for the example in the docs...

Cheers,
Robin.
