From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/3] iommu/dma: Use correct offset in map_sg
Date: Mon, 4 Jan 2016 16:08:23 +0000
Message-ID: <568A98F7.3050902@arm.com>
References: <9a84191ed813c23db7901f8c73f514d081495bdf.1450457730.git.robin.murphy@arm.com>
	<4812a34857b081e45c36d7e887840f3675da74dc.1450457730.git.robin.murphy@arm.com>
	<20151228160551.GA17673@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20151228160551.GA17673-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 28/12/15 16:05, Joerg Roedel wrote:
> On Fri, Dec 18, 2015 at 05:01:47PM +0000, Robin Murphy wrote:
>> When mapping a non-page-aligned scatterlist entry, we copy the original
>> offset to the output DMA address before aligning it to hand off to
>> iommu_map_sg(), then later adding the IOVA page address portion to get
>> the final mapped address. However, when the IOVA page size is smaller
>> than the CPU page size, it is the offset within the IOVA page we want,
>> not that within the CPU page, which can easily be larger than an IOVA
>> page and thus result in an incorrect final address.
>>
>> Fix the bug by taking only the IOVA-aligned part of the offset as the
>> basis of the DMA address, not the whole thing.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>   drivers/iommu/dma-iommu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 982e716..03811e3 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -458,7 +458,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>>   		size_t s_length = s->length;
>>   		size_t pad_len = (mask - iova_len + 1) & mask;
>>
>> -		sg_dma_address(s) = s->offset;
>> +		sg_dma_address(s) = s_offset;
>
> Does not apply on v4.4-rc7.

Ah, I did these on top of the map_sg tweak[1] locally, and failed to 
spot that that leaks into a context line here. There's no actual 
dependency so I'll rebase and repost this bugfix momentarily - as that 
other thread seems to have stalled, I'll probably have another crack at 
a proper scatterlist segment merging implementation sometime after the 
merge window.

Thanks,
Robin.

[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/11512
