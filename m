Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5832E23AD
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 09:02:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35B324B3;
	Wed, 22 Mar 2023 02:03:30 -0700 (PDT)
Received: from [10.57.53.137] (unknown [10.57.53.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 40A923F6C4;
	Wed, 22 Mar 2023 02:02:44 -0700 (PDT)
Message-ID: <85607806-b888-2d5e-67a4-e9d63ebd1976@arm.com>
Date: Wed, 22 Mar 2023 09:02:41 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] iommu/rockchip: Add missing set_platform_dma_ops callback
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Heiko Stuebner <heiko@sntech.de>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Lu Baolu <baolu.lu@linux.intel.com>
References: <20230315164152.333251-1-steven.price@arm.com>
 <ZBnBU9OU4iV6CV0W@ziepe.ca>
Content-Language: en-GB
From: Steven Price <steven.price@arm.com>
In-Reply-To: <ZBnBU9OU4iV6CV0W@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2023 14:38, Jason Gunthorpe wrote:
> On Wed, Mar 15, 2023 at 04:41:52PM +0000, Steven Price wrote:
>> Similar to exynos, we need a set_platform_dma_ops() callback for proper
>> operation on ARM 32 bit after recent changes in the IOMMU framework
>> (detach ops removal).
>>
>> Fixes: c1fe9119ee70 ("iommu: Add set_platform_dma_ops callbacks")
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> ---
>> This fixes a splat I was seeing on a Firefly-RK3288, more details here:
>> https://lore.kernel.org/all/26a5d1b8-40b3-b1e4-bc85-740409c26838@arm.com/
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks for the review.

> Do you know what state the iommu is left in after
> rk_iommu_detach_device()? Ie is it blocking DMA or doing identity or
> something else?

To be honest I really don't know for sure. But from my small
understanding of the code: rk_iommu_detach_device() ends up in
rk_iommu_disable_paging() which appears to switch to identity mode
("Disable memory translation").

But I don't actually have any familiarity with the hardware block, so I
might be missing something.

Steve
