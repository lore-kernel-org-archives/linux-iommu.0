From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: Propagate IOVA allocation failure
Date: Tue, 30 May 2017 18:31:05 +0100
Message-ID: <b16a9e15-9dc3-40cb-58f0-426ab25d7832@arm.com>
References: <8c0c3a31fe97dd57102b35f9be1cd69487ef04a3.1495823154.git.robin.murphy@arm.com>
	<20170530094837.GH2818@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170530094837.GH2818-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 30/05/17 10:48, Joerg Roedel wrote:
> On Fri, May 26, 2017 at 07:31:26PM +0100, Robin Murphy wrote:
>> Unlike the old allocator, alloc_iova_fast() will return 0 if it failed
>> to allocate a PFN. Since the callers of dma_ops_alloc_iova() would end
>> up treating that as a valid address, translate it to the DMA_ERROR_CODE
>> that they would expect.
>>
>> Fixes: 256e4621c21a ("iommu/amd: Make use of the generic IOVA allocator")
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>
>> Just something I spotted whilst comparing dma_map_page() callchains...
>>
>>  drivers/iommu/amd_iommu.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>> index 63cacf5d6cf2..489dc302899e 100644
>> --- a/drivers/iommu/amd_iommu.c
>> +++ b/drivers/iommu/amd_iommu.c
>> @@ -1555,6 +1555,9 @@ static unsigned long dma_ops_alloc_iova(struct device *dev,
>>  	if (!pfn)
>>  		pfn = alloc_iova_fast(&dma_dom->iovad, pages, IOVA_PFN(dma_mask));
>>  
>> +	if (!pfn)
>> +		return DMA_ERROR_CODE;
>> +
> 
> That shouldn't make a difference on x86 because the DMA_ERROR_CODE is 0
> as well.

Ha, now that I did manage to overlook. Oh well, never mind then :)

Thanks,
Robin.

> 
> 
> 	Joerg
> 
