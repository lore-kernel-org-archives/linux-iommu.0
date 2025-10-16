Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578F930C376
	for <iommu@lists.linux.dev>; Thu, 16 Oct 2025 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635062; cv=none; b=Xdbpnibqt0FEll6lggiCvCNNrZu8JYRljSQ0nFsz4SKgC967tRh/zFOUWFiHLLwFLTWgzmfh4w5EV8fWdH6vFrwJ/NiQvBOGJtpiyhJPaS+RfTEaC51t2ROqZTE1rW/3jblgPu1NSAwdlP7rHa0hhDTFU09xXvCjjpkCjUx1mfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635062; c=relaxed/simple;
	bh=cwIHUhRsMLJsQkWr4HfOu/7/fl3QvoFPf39FKcgG5uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLKUe2fl0oAGQz334ZIy5Q/NaSXfpLzRkER+g12q8Rm8opQMeIYEoTjbCxLjrY+ymHpw6H9Tj4qFfFt+TImm18PLdHXWKiavMc2n5zGbFMGb8AjuXNTnoeNnr5tvdpKb3Gl+Vka6pPgNJTOJQMckagXHjmA9wUUZuaGOctdzLm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 798601713;
	Thu, 16 Oct 2025 10:17:31 -0700 (PDT)
Received: from [10.57.35.229] (unknown [10.57.35.229])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 038B53F66E;
	Thu, 16 Oct 2025 10:17:37 -0700 (PDT)
Message-ID: <73a1d5d0-8077-450c-a38f-c1b027088258@arm.com>
Date: Thu, 16 Oct 2025 18:17:35 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] iommu/io-pgtable-arm-selftests: Use KUnit
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 will@kernel.org, joro@8bytes.org, praan@google.com
References: <20250929155001.3287719-1-smostafa@google.com>
 <20250929155001.3287719-5-smostafa@google.com>
 <86ca3918-4992-41a2-894f-f1fd8ce4121f@arm.com> <aO9vI1aEhnyZx1PL@google.com>
 <b48193a4-a37b-41ba-b4ba-8b5c67d812bd@arm.com>
 <20251015151002.GH3938986@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251015151002.GH3938986@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-15 4:10 pm, Jason Gunthorpe wrote:
> On Wed, Oct 15, 2025 at 02:51:15PM +0100, Robin Murphy wrote:
>> On 2025-10-15 10:53 am, Mostafa Saleh wrote:
>>>> Conversely, this is infrastructure, not an actual test of expected
>>>> io-pgtable behaviour, so I think just:
>>>>
>>>> 	cfg.iommu_dev = kunit_device_register(test, "io-pgtable-test");
>>>> 	if (IS_ERR(cfg.iommu_dev))
>>>> 		return;
>>>>
>>>> (it doesn't return NULLs either)
>>>>
>>>
>>> Yes, I was not sure about this one, when checking the code base, every test
>>> handles kunit_device_register() failure differently, this seemed the
>>> most strict one so I used it, I will update that in the next version.
>>
>> Yeah, my impression is that those have likely been copied from the
>> lib/kunit/ code where it is actually testing its own API. I've now sent a
>> patch for the example in the docs...
> 
> I think any failure to run the test should be reported, either with an
> err or a skip. Tests that didn't do anything and silently report
> success are not a good design.

Sure, a test that hasn't completed hasn't succeeded, but it hasn't 
failed either, in the sense of there being no fault found in the actual 
code being tested. Hence it seems intuitive to me that reporting a 
failure in the test infrastructure itself as if it were incorrect 
behaviour of the target code is not right.

In this case AFAICS kunit_device_register() can only fail due to OOM or 
something unexpectedly messed up in the kobject/sysfs hierarchy, all of 
which should already scream (and represent the system being sufficiently 
hosed that any actual test results probably no longer matter anyway) - 
otherwise I would have suggested a kunit_err() message too.

> Looking at the existing users I see alot are in init functions, so
> they propogate an error code and fail the init.

Indeed I think this one ultimately wants to end up in an init function 
too once everything is unpicked, but for now...
> And the rest inside tests do something like this:
> 
> 	dev = kunit_device_register(test, dev_name);			
> 	KUNIT_ASSERT_FALSE_MSG(test, IS_ERR(dev);
> 			       "Cannot register test device\n");

The confusion is that most of those KUNIT_ASSERTs are where the KUnit 
API *is* the thing under test, or have clearly copy-pasted the same 
example soon after, and some are in init functions which could fail 
gracefully, so it's far from clear how much considered intent they 
actually represent. In fact AFAICS it's only the two cases of that exact 
pattern in overflow and fortify that hint at being an older notion.

However, on further inspection, I see that there also about as many of 
examples of kunit_skip() being used when failing to allocate per-test 
resources, so I guess that's the pattern I was after, hurrah! I wouldn't 
consider the difference between "test skipped because it unexpectedly 
couldn't run" and "test skipped because it knowingly wouldn't have been 
meaningful or possible to run" significant enough to be worth trying to 
split further.

Thanks,
Robin.
