Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08D2156EF
	for <iommu@lists.linux.dev>; Fri,  5 May 2023 18:55:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3874A1FB;
	Fri,  5 May 2023 11:56:06 -0700 (PDT)
Received: from [10.57.81.246] (unknown [10.57.81.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FD023F64C;
	Fri,  5 May 2023 11:55:20 -0700 (PDT)
Message-ID: <7324a84b-09e5-c86d-4e11-dc970f124fea@arm.com>
Date: Fri, 5 May 2023 19:55:17 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] iommu/iova: Don't reset cached_node in dac deallocation
Content-Language: en-GB
To: Zaid Alali <zaidal@os.amperecomputing.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev
Cc: D Scott Phillips <scott@os.amperecomputing.com>
References: <ZFOri/cwNVeEIPAf@zaid-VirtualBox>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZFOri/cwNVeEIPAf@zaid-VirtualBox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2023-05-04 13:56, Zaid Alali wrote:
> The iova allocator has two rbtrees for allocations that are not satisfied
> by rcache. The two rbtrees track iovas for the ranges of 32bit address
> space and larger address space >32bit. On deallocation, the cached_node
> is updated to point to the deallocated iova.
> 
> Because the cached_node is moved to point to the recently deallocated
> iova with higher address, the first-fit allocator needs to walk the
> rbtree backwards skipping holes that do not fit while holding
> iova_rbtree_lock, which impacts performance and can cause soft-lockups.
> On deallocation, do not reset the cached_node to the freed iova for the
> rbtree tracking the dac addresses and keep moving forward with new
> allocations. This only affects addresses > 32bit.

The trouble with this is the long-term impact: the cached node basically 
never moves upwards, so over time as new IOVA allocations continue, DMA 
working sets slowly and steadily move down through their respective 
address spaces, leaving allocated-but-empty pagetables above. Given 
enough time, all memory is pagetables and the system withers and dies :(

> This patch was tested with ‘iommu.forcedac=1’ and 20 dd read instances
> of 8GB from nvme as well as kernel compilation running in parallel.

Hmm, if it's the case that you're hitting the rbtree all the time 
because your NVMe thinks it wants chunks that are too big for the IOVA 
rcaches, you might like this thread even more:

https://lore.kernel.org/linux-iommu/20230503161759.GA1614@lst.de/

Thanks,
Robin.

> The test results obtained from /proc/lock_stat shows the following
> improvements for iovad->iova_rbtree_lock:
> 
> 	Wait time average: reduced by 31%
> 	Hold time average: reduced by 60%
> 
> Signed-off-by: D Scott Phillips <scott@os.amperecomputing.com>
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>   drivers/iommu/iova.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index fe452ce46..d2a6cb573 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -106,7 +106,7 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
> 		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
>   
> 	cached_iova = to_iova(iovad->cached_node);
> -	if (free->pfn_lo >= cached_iova->pfn_lo)
> +	if (free == cached_iova)
> 		iovad->cached_node = rb_next(&free->node);
>   }
>   
