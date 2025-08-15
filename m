Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B151C6B4
	for <iommu@lists.linux.dev>; Fri, 15 Aug 2025 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755267339; cv=none; b=l/5WUmJ3iWvvq5zEdJrz5egzqcpsMkmKXWWnK0Rwz0eP6O4QUzU0ZPYgCkYyZj44MSjrbPXaXQ72DWR+0ijJ62xFogJQRq2nd1wE3BJhCI3oIBdeAeYSExlrfRhw950PZLlBjgr2kEATXaATQcO1uyhvsv5mtuiIHlzijmQe4wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755267339; c=relaxed/simple;
	bh=Kt1Gw0fpeefQHQWfL0Ytu+0Auuv6QUBdOhJDaAvEl/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zoh0I4UjOaQUr07aqRo6kSjvpSzZcfheB9vuG+YBCQyx/uzm55LF2N0A5YG0dTMykVcGEfLKWnXijgwYuHQJsyK/ybAi9h+ySTVPmasfDQ3qYYBxOIBEEDQHuFCPpLMf8B5Jfp88/a2riV5mRwu21to0z+2A2U4b9USogxUEMy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9B361691;
	Fri, 15 Aug 2025 07:15:28 -0700 (PDT)
Received: from [10.1.196.50] (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E46E3F738;
	Fri, 15 Aug 2025 07:15:35 -0700 (PDT)
Message-ID: <5f0fa597-2f60-4110-8c52-6d006f5707b3@foss.arm.com>
Date: Fri, 15 Aug 2025 15:15:33 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommufd: viommu: free memory allocated by kvcalloc()
 using kvfree()
To: Markus Elfring <Markus.Elfring@web.de>,
 Akhilesh Patil <akhilesh@ee.iitb.ac.in>, iommu@lists.linux.dev
Cc: akhileshpatilvnit@gmail.com, LKML <linux-kernel@vger.kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Pranjal Shrivastava <praan@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>
References: <aJifyVV2PL6WGEs6@bhairav-test.ee.iitb.ac.in>
 <712b3b74-cfbd-45d8-8c19-6f2929b71358@web.de>
From: Robin Murphy <robin.murphy@foss.arm.com>
Content-Language: en-GB
In-Reply-To: <712b3b74-cfbd-45d8-8c19-6f2929b71358@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/08/2025 2:42 pm, Markus Elfring wrote:
>> Use kvfree() instead of kfree() to free pages allocated by kvcalloc()
>> in iommufs_hw_queue_alloc_phys() to fix potential memory corruption.
>> Ensure the memory is properly freed, as kvcalloc may internally use
>> vmalloc or kmalloc depending on available memory in the system.
> 
> Will another bit of background information become helpful
> for an improved change description?

No it will not. Please stop pointlessly nitpicking. A thing that is 
allocated with kv*alloc() must be freed with kvfree(); that alone is all 
that needs to be said to explain and justify any patch fixing this 
particular bug.

Thanks,
Robin.
