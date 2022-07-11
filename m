Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F76923A8
	for <iommu@lists.linux.dev>; Mon, 11 Jul 2022 10:07:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CCC316A3;
	Mon, 11 Jul 2022 03:07:23 -0700 (PDT)
Received: from [10.57.85.194] (unknown [10.57.85.194])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D04B13F73D;
	Mon, 11 Jul 2022 03:07:21 -0700 (PDT)
Message-ID: <e6c43ef0-870b-5fe6-141e-0a3d566b030e@arm.com>
Date: Mon, 11 Jul 2022 11:07:17 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always
 initialised
Content-Language: en-GB
To: Ben Dooks <ben.dooks@sifive.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, iommu@lists.linux-foundation.org,
 Christoph Hellwig <hch@lst.de>
Cc: Sudip Mukherjee <sudip.mukherjee@sifive.com>,
 Jude Onyenegecha <jude.onyenegecha@sifive.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20220708170811.270589-1-ben.dooks@sifive.com>
 <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com>
 <683344bd-dc9b-0bb5-9377-b3e9ab410a74@sifive.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <683344bd-dc9b-0bb5-9377-b3e9ab410a74@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-07-11 08:26, Ben Dooks wrote:
> On 08/07/2022 21:32, Robin Murphy wrote:
>> On 2022-07-08 18:08, Ben Dooks wrote:
>>> If the io_tlb_default_mem is used by a device that then gets used
>>> by the swiotlb code, the spinlock warning is triggered causing a
>>> lot of stack-trace.
>>
>> Hang on, how have we got as far as trying to allocate out of an 
>> uninitialised SWIOTLB at all? That seems like either something's gone 
>> more fundamentally wrong or we're missing a proper check somewhere. I 
>> don't think papering over it like this is right.
>>
>> Thanks,
>> Robin
> We have a system where we have no DMA capable memory in the 32bit
> window, which means even if we initialise swiotlb we don't have
> any dma capable memory. The code says go use an IOMMU but we don't
> have one of those either (and all peripherals are capable of DMA
> from any of the memory, so there shouldn't be the need for one)
> 
> Is there any other way of fixing this DMA allocation issue?

If none of your peripherals should need SWIOTLB, then the fact that
you're ending up in swiotlb_map() at all is a clear sign that
something's wrong. Most likely someone's forgotten to set their DMA
masks correctly.

However, by inspection it seems we do have a bug here as well, for which
the correct fix should be as below. The fireworks you're *supposed* to
get in that situation are considerably louder and more obvious than a
DEBUG_SPINLOCK complaint ;)

Thanks,
Robin.

----->8-----
Subject: [PATCH] swiotlb: Fail map correctly with failed io_tlb_default_mem

In the failure case of trying to use a buffer which we'd previously
failed to allocate, the "!mem" condition is no longer sufficient since
io_tlb_default_mem became static and assigned by default. Update the
condition to work as intended per the rest of that conversion.

Fixes: 463e862ac63e ("swiotlb: Convert io_default_tlb_mem to static allocation")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
  kernel/dma/swiotlb.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index cb50f8d38360..5830dce6081b 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -580,7 +580,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
  	int index;
  	phys_addr_t tlb_addr;
  
-	if (!mem)
+	if (!mem || !mem->nslabs)
  		panic("Can not allocate SWIOTLB buffer earlier and can't now provide you with the DMA bounce buffer");
  
  	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-- 
2.36.1.dirty

