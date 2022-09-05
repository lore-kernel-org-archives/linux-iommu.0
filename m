Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFAA4416
	for <iommu@lists.linux.dev>; Mon,  5 Sep 2022 15:51:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E6EC139F;
	Mon,  5 Sep 2022 08:51:16 -0700 (PDT)
Received: from [10.57.15.199] (unknown [10.57.15.199])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 131AD3F534;
	Mon,  5 Sep 2022 08:51:08 -0700 (PDT)
Message-ID: <318d9157-6f2b-4ae5-70fc-a54d5919496e@arm.com>
Date: Mon, 5 Sep 2022 16:51:04 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 0/3] iova: Some misc changes
Content-Language: en-GB
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1660730984-30333-1-git-send-email-john.garry@huawei.com>
 <11d9f054-fe7b-7646-a8f4-7d45a22e2a96@huawei.com>
 <e8b232be-dfe9-0a67-c464-83fe5109070e@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <e8b232be-dfe9-0a67-c464-83fe5109070e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-09-02 13:18, John Garry wrote:
> On 17/08/2022 11:24, John Garry wrote:
>> On 17/08/2022 11:09, John Garry wrote:
>>> This series includes:
>>> - remove checks in the code which are not required
>>> - the re-org, which I had originally posted separately
>>
>> BTW, Can we drop the !IOMMU_IOVA stubs in iova.h? I could not find a 
>> kernel config which actually exercises that code (so testing changes 
>> there is difficult).
> 
> Any thoughts on this? Since I got no review of patch #3 I assume that it 
> is not keenly welcome either.

Yeah, I applied patch #3 to have a look at the result, but couldn't 
really convince myself either way - there are certainly a few functions 
in weirdly incongruous places at the moment, but afterwards we end up 
with certain other things in rather contrived order for the sake of 
avoiding declarations, so overall it just didn't feel objectively better 
to me. Plus the fact that rewriting nearly 2/3 of the file stands to 
make backporting tweaks or fixes unnecessarily painful is hard to 
overlook. Hence I guess I'm leaning towards "worth trying to see how it 
looked, but let's not".

As for the stubs, it seems that they're currently unused due to linkage 
issues with IOMMU_IOVA=m - if we want better compile-test coverage, I 
wonder if we couldn't replace the IS_ENABLED() with IS_REACHABLE() and 
restore some of the previously-conditional selects?

Robin.
