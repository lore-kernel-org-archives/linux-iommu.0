From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/dma: Respect IOMMU aperture when allocating
Date: Tue, 9 Aug 2016 17:08:41 +0100
Message-ID: <73572deb-967d-a8ba-58d4-28cd67b7505e@arm.com>
References: <3feb8016c2def4aabc5513b548e17bbf57c27959.1470755555.git.robin.murphy@arm.com>
	<6d73ab5fb671089057b31beb73667c09147a0f0e.1470755555.git.robin.murphy@arm.com>
	<20160809153602.GD29650@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160809153602.GD29650-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

On 09/08/16 16:36, Joerg Roedel wrote:
> On Tue, Aug 09, 2016 at 04:23:18PM +0100, Robin Murphy wrote:
>> Where a device driver has set a 64-bit DMA mask to indicate the absence
>> of addressing limitations, we still need to ensure that we don't
>> allocate IOVAs beyond the actual input size of the IOMMU. The reported
>> aperture is the most reliable way we have of inferring that input
>> address size, so use that to enforce a hard upper limit.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> 
> Also missing 'Fixes:' line.
> 
>> ---
>>
>> This is the only other thing I currently have which could perhaps be
>> considered a fix; otherwise I'll pull it into the PCI/SMMU series.
>>
>>  drivers/iommu/dma-iommu.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index 7d991c81c4fa..092d781f5f35 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -158,6 +158,8 @@ static struct iova *__alloc_iova(struct iova_domain *iovad, size_t size,
>>  	unsigned long shift = iova_shift(iovad);
>>  	unsigned long length = iova_align(iovad, size) >> shift;
>>  
>> +	if (domain->geometry.force_aperture)
>> +		dma_limit &= domain->geometry.aperture_end;
> 
> This might work, but is misleading as limits and aperture_end are
> neither a mask nor a bitfield. It is more descriptive to use min()
> here:
> 
> 	dma_limit = min(dma_limit, omain->geometry.aperture_end);
> 

Well, dma_limit is always a DMA mask, but I suppose you're right that an
IOMMU driver could in theory set a wacky non-power-of-two aperture if it
really wanted to. I'll respin...

Thanks,
Robin.
