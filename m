Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9C2BA41
	for <iommu@lists.linux.dev>; Mon,  7 Nov 2022 13:26:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DF911FB;
	Mon,  7 Nov 2022 05:26:35 -0800 (PST)
Received: from [10.57.36.87] (unknown [10.57.36.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D39B3F73D;
	Mon,  7 Nov 2022 05:26:26 -0800 (PST)
Message-ID: <b7315166-1e2c-27f4-ab6a-b7a7eb41c079@arm.com>
Date: Mon, 7 Nov 2022 13:26:21 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 03/13] iommu/dma: Force bouncing of the size is not
 cacheline-aligned
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>, Christoph Hellwig <hch@lst.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 <20221106220143.2129263-4-catalin.marinas@arm.com>
 <20221107094603.GB6055@lst.de> <Y2jj7PlrIC6weDch@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Y2jj7PlrIC6weDch@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2022-11-07 10:54, Catalin Marinas wrote:
> On Mon, Nov 07, 2022 at 10:46:03AM +0100, Christoph Hellwig wrote:
>>> +static inline bool dma_sg_kmalloc_needs_bounce(struct device *dev,
>>> +					       struct scatterlist *sg, int nents,
>>> +					       enum dma_data_direction dir)
>>> +{
>>> +	struct scatterlist *s;
>>> +	int i;
>>> +
>>> +	if (!IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) ||
>>> +	    dir == DMA_TO_DEVICE || dev_is_dma_coherent(dev))
>>> +		return false;
>>
>> This part should be shared with dma-direct in a well documented helper.
>>
>>> +	for_each_sg(sg, s, nents, i) {
>>> +		if (dma_kmalloc_needs_bounce(dev, s->length, dir))
>>> +			return true;
>>> +	}
>>
>> And for this loop iteration I'd much prefer it to be out of line, and
>> also not available in a global helper.
>>
>> But maybe someone can come up with a nice tweak to the dma-iommu
>> code to not require the extra sglist walk anyway.
> 
> An idea: we could add another member to struct scatterlist to track the
> bounced address. We can then do the bouncing in a similar way to
> iommu_dma_map_sg_swiotlb() but without the iova allocation. The latter
> would be a common path for both the bounced and non-bounced cases.

FWIW I spent a little time looking at this as well; I'm pretty confident
it can be done without the extra walk if the iommu-dma bouncing is
completely refactored (and it might want a SWIOTLB helper to retrieve
the original page from a bounced address). That's going to be a bigger
job than I'll be able to finish this cycle, and I concluded that this
in-between approach wouldn't be worth posting for its own sake, but as
part of this series I think it's a reasonable compromise. What we have
here is effectively a pretty specialist config that trades DMA mapping
performance for memory efficiency, so trading a little more performance
initially for the sake of keeping it manageable seems fair to me.

The one thing I did get as far as writing up is the patch below, which
I'll share as an indirect review comment on this patch - feel free to
pick it up or squash it in if you think it's worthwhile.

Thanks,
Robin.

----->8-----
From: Robin Murphy <robin.murphy@arm.com>
Date: Wed, 2 Nov 2022 17:35:09 +0000
Subject: [PATCH] scatterlist: Add dedicated config for DMA flags

The DMA flags field will be useful for users beyond PCI P2P, so upgrade
to its own dedicated config option.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
  drivers/pci/Kconfig         | 1 +
  include/linux/scatterlist.h | 4 ++--
  kernel/dma/Kconfig          | 3 +++
  3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 55c028af4bd9..0303604d9de9 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -173,6 +173,7 @@ config PCI_P2PDMA
  	#
  	depends on 64BIT
  	select GENERIC_ALLOCATOR
+	select NEED_SG_DMA_FLAGS
  	help
  	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
  	  BARs that are exposed in other devices that are the part of
diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index 375a5e90d86a..87aaf8b5cdb4 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -16,7 +16,7 @@ struct scatterlist {
  #ifdef CONFIG_NEED_SG_DMA_LENGTH
  	unsigned int	dma_length;
  #endif
-#ifdef CONFIG_PCI_P2PDMA
+#ifdef CONFIG_NEED_SG_DMA_FLAGS
  	unsigned int    dma_flags;
  #endif
  };
@@ -249,7 +249,7 @@ static inline void sg_unmark_end(struct scatterlist *sg)
  }
  
  /*
- * CONFGI_PCI_P2PDMA depends on CONFIG_64BIT which means there is 4 bytes
+ * CONFIG_PCI_P2PDMA depends on CONFIG_64BIT which means there is 4 bytes
   * in struct scatterlist (assuming also CONFIG_NEED_SG_DMA_LENGTH is set).
   * Use this padding for DMA flags bits to indicate when a specific
   * dma address is a bus address.
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 56866aaa2ae1..48016c4f67ac 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -24,6 +24,9 @@ config DMA_OPS_BYPASS
  config ARCH_HAS_DMA_MAP_DIRECT
  	bool
  
+config NEED_SG_DMA_FLAGS
+	bool
+
  config NEED_SG_DMA_LENGTH
  	bool
  
-- 
