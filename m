Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281BB20E2
	for <iommu@lists.linux.dev>; Wed, 30 Aug 2023 12:04:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 974ED2F4;
	Wed, 30 Aug 2023 05:04:58 -0700 (PDT)
Received: from [10.57.4.99] (unknown [10.57.4.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49F9E3F738;
	Wed, 30 Aug 2023 05:04:18 -0700 (PDT)
Message-ID: <b4d0c94e-4bf6-9489-1fc2-5ba5c8779a82@arm.com>
Date: Wed, 30 Aug 2023 13:04:13 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dma-contiguous: fix the Kconfig entry for
 CONFIG_DMA_NUMA_CMA
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>
Cc: m.szyprowski@samsung.com, yajun.deng@linux.dev, iommu@lists.linux.dev
References: <20230830092731.148759-1-hch@lst.de>
 <a33702d2-6024-0129-588d-ce1a879f825c@arm.com>
 <20230830115431.GA23190@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230830115431.GA23190@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-08-30 12:54, Christoph Hellwig wrote:
> On Wed, Aug 30, 2023 at 11:11:29AM +0100, Robin Murphy wrote:
>> I think the "good reason" is that folks who do have NUMA systems are likely
>> to be more interested in getting more consistent DMA performance than
>> losing a bit more non-movable memory capacity, and the runtime impact on
>> non-NUMA systems should be negligible, so I would definitely be inclined to
>> make it "default y". But it's not critically important.
> 
> Well, Linus hates these default y, and usually for a good reason.
> If it's that useful/importanst for numa systems we should just drop
> the option and make the code conditional on CONFIG_NUMA only.

Hmm, good point. In fact, after double-checking, the amount of code 
saved by disabling it looks pretty trivial, and it does need an explicit 
command-line option to activate the "special" behaviour anyway, so 
indeed I'm now starting to doubt whether the separate config option is 
worthwhile at all.

Cheers,
Robin.
