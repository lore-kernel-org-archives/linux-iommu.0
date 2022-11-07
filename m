Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117EAD527
	for <iommu@lists.linux.dev>; Mon,  7 Nov 2022 15:24:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B9BC1FB;
	Mon,  7 Nov 2022 07:24:29 -0800 (PST)
Received: from [10.57.36.87] (unknown [10.57.36.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 307573F73D;
	Mon,  7 Nov 2022 07:24:20 -0800 (PST)
Message-ID: <9c453c00-7950-9932-0fa6-5478d5cf44f1@arm.com>
Date: Mon, 7 Nov 2022 15:24:13 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 13/13] dma: arm64: Add
 CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC and enable it for arm64
Content-Language: en-GB
To: Christoph Hellwig <hch@lst.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ard Biesheuvel <ardb@kernel.org>,
 Isaac Manjarres <isaacmanjarres@google.com>,
 Saravana Kannan <saravanak@google.com>, Alasdair Kergon <agk@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Joerg Roedel <joro@8bytes.org>,
 Mark Brown <broonie@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-mm@kvack.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20221106220143.2129263-1-catalin.marinas@arm.com>
 <20221106220143.2129263-14-catalin.marinas@arm.com>
 <6e846f75-b330-9523-4356-41d5f9e48f12@arm.com>
 <20221107143849.GA27946@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221107143849.GA27946@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-11-07 14:38, Christoph Hellwig wrote:
> On Mon, Nov 07, 2022 at 01:03:31PM +0000, Robin Murphy wrote:
>> On 2022-11-06 22:01, Catalin Marinas wrote:
>>> With all the infrastructure in place for bouncing small kmalloc()
>>> buffers, add the corresponding Kconfig entry and select it for arm64.
>>
>> AFAICS we're missing the crucial part to ensure that SWIOTLB is available
>> even when max_pfn <= arm64_dma_phys_limit, which is very likely to be true
>> on low-memory systems that care most about kmalloc wastage. The only way to
>> override that currently is with "swiotlb=force", but bouncing *everything*
>> is not desirable either.
> 
> FYI, one of the reasons for the swiotlb_init refactor that passes
> flags and a boolean a while ago is that we can trivially just either
> pass another flag or check a condition in swiotlb_init to allocate the
> buffer.  There's actually another case for which we need the
> unconditional allocation, and that is the bouncing for untrusted
> external devices with dma-iommu.

Right, I guess machines with Thunderbolt and all the firmware 
annotations but less than 4GB of RAM are unlikely to exist in the wild, 
so the untrusted bouncing logic has been getting lucky so far. There are 
however plenty of arm64 systems with small amounts of RAM and 
non-coherent USB so in this case someone's likely to fall over it pretty 
much right away. I know it's easy to add a new condition, but it still 
has to actually *be* added.

Thanks,
Robin.
