From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] swiotlb: Make DIRECT_MAPPING_ERROR viable
Date: Tue, 20 Nov 2018 15:01:33 +0000
Message-ID: <7ea5809e-1e1d-6bac-b723-9f55fafeaaae@arm.com>
References: <cover.1542722463.git.robin.murphy@arm.com>
	<e90da5fbab881c502ac3412fb05c44b26c99f73a.1542722463.git.robin.murphy@arm.com>
	<20181120144918.GH10917@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181120144918.GH10917-he5eyhs8q0BAdwtm4QZOy9BPR1lH4CV8@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 20/11/2018 14:49, Konrad Rzeszutek Wilk wrote:
> On Tue, Nov 20, 2018 at 02:09:52PM +0000, Robin Murphy wrote:
>> With the overflow buffer removed, we no longer have a unique address
>> which is guaranteed not to be a valid DMA target to use as an error
>> token. The DIRECT_MAPPING_ERROR value of 0 tries to at least represent
>> an unlikely DMA target, but unfortunately there are already SWIOTLB
>> users with DMA-able memory at physical address 0 which now gets falsely
>> treated as a mapping failure and leads to all manner of misbehaviour.
>>
>> The best we can do to mitigate that is flip DIRECT_MAPPING_ERROR to the
>> commonly-used all-bits-set value, since the last single byte of memory
>> is by far the least-likely-valid DMA target.
> 
> Are all the callers checking for DIRECT_MAPPING_ERROR or is it more of
> a comparison (as in if (!ret)) ?

dma_direct_map_page() and dma_direct_mapping_error() were already doing 
the right thing, and external callers must rely on the latter via 
dma_mapping_error() rather than trying to inspect the actual value 
themselves, since that varies between implementations anyway. AFAICS all 
the new return paths from swiotlb_map_page() are also robust in 
referencing the macro explicitly, so I think we're good.

Thanks,
Robin.

>> Fixes: dff8d6c1ed58 ("swiotlb: remove the overflow buffer")]
>> Reported-by: John Stultz <john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>   include/linux/dma-direct.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
>> index bd73e7a91410..9de9c7ab39d6 100644
>> --- a/include/linux/dma-direct.h
>> +++ b/include/linux/dma-direct.h
>> @@ -5,7 +5,7 @@
>>   #include <linux/dma-mapping.h>
>>   #include <linux/mem_encrypt.h>
>>   
>> -#define DIRECT_MAPPING_ERROR		0
>> +#define DIRECT_MAPPING_ERROR		~(dma_addr_t)0
>>   
>>   #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
>>   #include <asm/dma-direct.h>
>> -- 
>> 2.19.1.dirty
>>
