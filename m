From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/10] arm64: use the generic swiotlb_dma_ops
Date: Fri, 12 Oct 2018 16:40:49 +0200
Message-ID: <20181012144049.GA28925@lst.de>
References: <20181008080246.20543-1-hch@lst.de> <20181008080246.20543-11-hch@lst.de> <8ae57670-ced9-5ebb-caf5-cc99f15fdf22@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8ae57670-ced9-5ebb-caf5-cc99f15fdf22@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Oct 12, 2018 at 02:01:00PM +0100, Robin Murphy wrote:
> On 08/10/18 09:02, Christoph Hellwig wrote:
>> Now that the generic swiotlb code supports non-coherent DMA we can switch
>> to it for arm64.  For that we need to refactor the existing
>> alloc/free/mmap/pgprot helpers to be used as the architecture hooks,
>> and implement the standard arch_sync_dma_for_{device,cpu} hooks for
>> cache maintaincance in the streaming dma hooks, which also implies
>> using the generic dma_coherent flag in struct device.
>>
>> Note that we need to keep the old is_device_dma_coherent function around
>> for now, so that the shared arm/arm64 Xen code keeps working.
>
> OK, so when I said last night that it boot-tested OK, that much was true, 
> but then I shut the board down as I left and got a megasplosion of bad page 
> state BUGs, e.g.:

I think this is because I am passing the wrong address to
dma_direct_free_pages.  Please try this patch on top:

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 3c75d69b54e7..4f0f92856c4c 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -126,10 +126,12 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 void arch_dma_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_handle, unsigned long attrs)
 {
-	if (__free_from_pool(vaddr, PAGE_ALIGN(size)))
-		return;
-	vunmap(vaddr);
-	dma_direct_free_pages(dev, size, vaddr, dma_handle, attrs);
+	if (!__free_from_pool(vaddr, PAGE_ALIGN(size)))
+		void *kaddr = phys_to_virt(dma_to_phys(dev, dma_handle));
+
+		vunmap(vaddr);
+		dma_direct_free_pages(dev, size, kaddr, dma_handle, attrs);
+	}
 }
 
 long arch_dma_coherent_to_pfn(struct device *dev, void *cpu_addr,
