From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 1/2] iommu/dma: Implement dma_{map,unmap}_resource()
Date: Thu, 10 Nov 2016 14:30:04 +0000
Message-ID: <1ae5dc0f-2e59-3e10-a61a-1f5452ad560f@arm.com>
References: <4e84146ae49a4edd5f1226d76617be9aa92a58ee.1477503578.git.robin.murphy@arm.com>
	<20161110122420.GH9996@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161110122420.GH9996-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: catalin.marinas-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 10/11/16 12:24, Joerg Roedel wrote:
> On Wed, Oct 26, 2016 at 06:43:56PM +0100, Robin Murphy wrote:
>> With the new dma_{map,unmap}_resource() functions added to the DMA API
>> for the benefit of cases like slave DMA, add suitable implementations to
>> the arsenal of our generic layer. Since cache maintenance should not be
>> a concern, these can both be standalone callback implementations without
>> the need for arch code wrappers.
>>
>> CC: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>
>> v2: Use iommu_dma_unmap_page for symmetry, instead of being sneaky.
>>
>>  drivers/iommu/dma-iommu.c | 13 +++++++++++++
>>  include/linux/dma-iommu.h |  4 ++++
>>  2 files changed, 17 insertions(+)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index c5ab8667e6f2..a2fd90a6a782 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -624,6 +624,19 @@ void iommu_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
>>  	__iommu_dma_unmap(iommu_get_domain_for_dev(dev), sg_dma_address(sg));
>>  }
>>  
>> +dma_addr_t iommu_dma_map_resource(struct device *dev, phys_addr_t phys,
>> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	return iommu_dma_map_page(dev, phys_to_page(phys), offset_in_page(phys),
>> +			size, dma_direction_to_prot(dir, false) | IOMMU_MMIO);
>> +}
> 
> Isn't the whole point of map_resource that we can map regions which have
> no 'struct page' associated? The use phys_to_page() will certainly not
> do the right thing here.

Perhaps it's a bit cheeky, but the struct page pointer is never
dereferenced - the only thing iommu_dma_map_page() does with it is
immediately convert it back again. Is there ever a case where
page_to_phys(phys_to_page(phys)) != phys ?

Robin.
