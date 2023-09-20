Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F4736AEE
	for <iommu@lists.linux.dev>; Wed, 20 Sep 2023 13:12:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FF0B1FB;
	Wed, 20 Sep 2023 06:12:45 -0700 (PDT)
Received: from [10.57.67.90] (unknown [10.57.67.90])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D3363F67D;
	Wed, 20 Sep 2023 06:12:07 -0700 (PDT)
Message-ID: <f72e5ab1-c6f2-ec03-68d6-1686145f3a4d@arm.com>
Date: Wed, 20 Sep 2023 14:12:09 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/2] iommu: Allow passing custom allocators to pgtable
 drivers
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
Cc: Rob Clark <robdclark@gmail.com>
References: <20230809121744.2341454-1-boris.brezillon@collabora.com>
Content-Language: en-GB
From: Steven Price <steven.price@arm.com>
In-Reply-To: <20230809121744.2341454-1-boris.brezillon@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/08/2023 13:17, Boris Brezillon wrote:
> Hello,
> 
> This patchset is an attempt at making page table allocation
> customizable. This is useful to some GPU drivers for various reasons:
> 
> - speed-up upcoming page table allocations by managing a pool of free
>   pages
> - batch page table allocation instead of allocating one page at a time
> - pre-reserve pages for page tables needed for map/unmap operations and
>   return the unused page tables to some pool
> 
> The first and last reasons are particularly important for GPU drivers
> wanting to implement asynchronous VM_BIND. Asynchronous VM_BIND requires
> that any page table needed for a map/unmap operation to succeed be
> allocated at VM_BIND job creation time. At the time of the job creation,
> we don't know what the VM will look like when we get to execute the
> map/unmap, and can't guess how many page tables we will need. Because
> of that, we have to over-provision page tables for the worst case
> scenario (page table tree is empty), which means we will allocate/free
> a lot. Having pool a pool of free pages is crucial if we want to
> speed-up VM_BIND requests.
> 
> A real example of how such custom allocators can be used is available
> here[1]. v2 of the Panthor driver is approaching submission, and I
> figured I'd try to upstream the dependencies separately, which is
> why I submit this series now, even though the user of this new API
> will come afterwards. If you'd prefer to have those patches submitted
> along with the Panthor driver, let me know.
> 
> This approach has been discussed with Robin, and is hopefully not too
> far from what he had in mind.

The alternative would be to embed a cache of pages into the IOMMU
framework, however kmem_cache sadly doesn't seem to support the
'reserve' of pages concept that we need. mempools could be a solution
but the mempool would need to be created by the IOMMU framework as the
alloc/free functions are specified when creating the pool. So it would
be a much bigger change (to drivers/iommu).

So, given that so far it's just Panthor this seems like the right
approach for now - when/if other drivers want the same functionality
then it might make sense to revisit the idea of doing the caching within
the IOMMU framework.

Robin: Does this approach sound sensible?

FWIW:

Reviewed-by: Steven Price <steven.price@arm.com>

Steve

> Regards,
> 
> Boris
> 
> [1]https://gitlab.freedesktop.org/panfrost/linux/-/blob/panthor/drivers/gpu/drm/panthor/panthor_mmu.c#L441
> 
> Boris Brezillon (2):
>   iommu: Allow passing custom allocators to pgtable drivers
>   iommu: Extend LPAE page table format to support custom allocators
> 
>  drivers/iommu/io-pgtable-arm.c | 50 +++++++++++++++++++++++-----------
>  drivers/iommu/io-pgtable.c     | 31 +++++++++++++++++++++
>  include/linux/io-pgtable.h     | 21 ++++++++++++++
>  3 files changed, 86 insertions(+), 16 deletions(-)
> 

