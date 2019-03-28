From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 00/10] iommu/vt-d: Bounce buffer for untrusted devices
Date: Thu, 28 Mar 2019 14:33:04 +0800
Message-ID: <04b41eb3-5584-5c7d-5f5e-7c6f28a19b50@linux.intel.com>
References: <20190327063506.32564-1-baolu.lu@linux.intel.com>
 <20190327064823.GA13309@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327064823.GA13309@infradead.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 3/27/19 2:48 PM, Christoph Hellwig wrote:
> On Wed, Mar 27, 2019 at 02:34:56PM +0800, Lu Baolu wrote:
>>    - During the v1 review cycle, we discussed the possibility
>>      of reusing swiotlb code to avoid code dumplication, but
>>      we found the swiotlb implementations are not ready for the
>>      use of bounce page pool.
>>      https://lkml.org/lkml/2019/3/19/259
> 
> So make it ready.  You too can contribute to common code.  Robin
> also explicitly asked to make the bounce policy iommu-subsystem wide.
> 

Sure. I am glad to make the code common. I will try to make it with a
new version.

For the swiotlb APIs, I am thinking about keeping current APIs untouched
and adding below new ones for bounce page.

/**
  * swiotlb_bounce_page_map - create a bounce page mapping
  * @dev: the device
  * @phys: the physical address of the buffer requiring bounce
  * @size: the size of the buffer
  * @align: IOMMU page align
  * @dir: DMA direction
  * @attrs: DMA attributions
  *
  * This creates a swiotlb bounce page mapping for the buffer at @phys,
  * and in case of DMAing to the device copy the data into it as well.
  * Return the tlb addr on success, otherwise DMA_MAPPING_ERROR.
  */
dma_addr_t
swiotlb_bounce_page_map(struct device *dev, phys_addr_t phys,
                         size_t size, unsigned long align,
                         enum dma_data_direction dir, unsigned long attrs)
{
         return 0;
}

/**
  * swiotlb_bounce_page_unmap - destroy a bounce page mapping
  * @dev: the device
  * @tlb_addr: the tlb address of the buffer requiring bounce
  * @size: the size of the buffer
  * @align: IOMMU page align
  * @dir: DMA direction
  * @attrs: DMA attributions
  *
  * This destroys a swiotlb bounce page mapping for the buffer at @tlb_addr,
  * and in case of DMAing from the device copy the data from it as well.
  */
void
swiotlb_bounce_page_unmap(struct device *dev, phys_addr_t tlb_addr,
                           size_t size, unsigned long align,
                           enum dma_data_direction dir, unsigned long attrs)
{
}

/**
  * swiotlb_bounce_page_sync - sync bounce page mapping
  * @dev: the device
  * @tlb_addr: the tlb address of the buffer requiring bounce
  * @size: the size of the buffer
  * @align: IOMMU page align
  * @dir: DMA direction
  * @attrs: DMA attributions
  *
  * This syncs a swiotlb bounce page mapping for the buffer at @tlb_addr.
  */
void
swiotlb_bounce_page_sync(struct device *dev, phys_addr_t tlb_addr,
                           size_t size, unsigned long align,
                           enum dma_data_direction dir, unsigned long attrs)
{
}

Any comments?

Best regards,
Lu Baolu
