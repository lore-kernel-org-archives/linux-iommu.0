Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255922367DD
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744388936; cv=none; b=IvYlBtw43lYw88ySJPC3Wrf5ygZMLtmqPOK8lpvX1bo6PAxYtKWlhwaTifNqWADu3EyseO7TTD53DOJ6ku1kpwp/p4p4mpc+WWWLVYf6I7TSiS0kI3OghE0V7Nx6XRhXAYaZhKKlMbGwD4fTcvP6gOzNas8LNLcW88nUknxF2Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744388936; c=relaxed/simple;
	bh=RLRjKzr3kAPLL94JcxvssJpW8PLKHZA1+W6xj7rg1cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4K0wEs6eGTx6ZNbolIx8UJBe/RPmPhZcy9/K5ledtBp7FJ10/rz4aEyw6Xx7StC7jB5tINR1DkVNZ3EX47QG7SOtVuuItzu+KJYKHlpjrvWGsdLdotiSiQyL1mf3wQseR8FnVnqPo1oL65Ktkxe4QnKPRXxOXZXVLz20KUyxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE9F4106F;
	Fri, 11 Apr 2025 09:28:52 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C25B43F694;
	Fri, 11 Apr 2025 09:28:51 -0700 (PDT)
Message-ID: <ab75a444-22a1-47f5-b3c0-253660395b5a@arm.com>
Date: Fri, 11 Apr 2025 17:28:50 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/io-pgtable-arm: dynamically allocate selftest
 device struct
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>
Cc: Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Rob Clark <robdclark@chromium.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250411125423.1411061-1-arnd@kernel.org>
 <60c980c1-16b6-460e-89a4-203e9f0cbf3b@arm.com>
 <9c010a5d-a2a7-4002-9411-58009c1a21c8@app.fastmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <9c010a5d-a2a7-4002-9411-58009c1a21c8@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/2025 2:44 pm, Arnd Bergmann wrote:
> On Fri, Apr 11, 2025, at 15:19, Robin Murphy wrote:
>> On 11/04/2025 1:54 pm, Arnd Bergmann wrote:
>>> @@ -1433,15 +1434,17 @@ static int __init arm_lpae_do_selftests(void)
>>>    	};
>>>    
>>>    	int i, j, k, pass = 0, fail = 0;
>>> -	struct device dev;
>>
>> Could we not simply make this static? Per the comment it's only here to
>> serve a NUMA node lookup buried deep in the pagetable allocator (TBH my
>> first thought was to just put an int on the stack and contrive a pointer
>> as the inverse of dev_to_node(), but I decided that would probably be
>> too contentious...)
> 
> A static device would work here, but that has other (small)
> downsides:
> 
>   - static devices are discouraged for any real purpose because
>     of the problematic lifetime rules. I think Greg would still
>     want to eliminate these entirely.
> 
>   - there is slightly more memory usage: the __init function
>     gets eliminated after boot, while a static allocation says
>     around. It could perhaps be made __initdata.
> 
>   - If we ever need anything beyond the NUMA node from it, the
>     dynamic allocation is probably close enough to make that
>     work.
> 
>>> +	struct platform_device *pdev;
>>>    	struct io_pgtable_cfg cfg = {
>>>    		.tlb = &dummy_tlb_ops,
>>>    		.coherent_walk = true,
>>> -		.iommu_dev = &dev,
>>>    	};
>>>    
>>> -	/* __arm_lpae_alloc_pages() merely needs dev_to_node() to work */
>>> -	set_dev_node(&dev, NUMA_NO_NODE);
>>> +	pdev = platform_device_alloc("io-pgtable-test", 0);
>>
>> Otherwise, this would seem to be another perfect case for the new
>> faux_device.
> 
> Good point, that is clearly better than platform_device in this
> case. Shall I send a new version with that?

Sure, I'm happy to consciously err on the side of caution and 
robustness, just making sure :)

Thanks,
Robin.
