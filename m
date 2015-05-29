From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 2/4] iommu: Implement common IOMMU ops for DMA mapping
Date: Fri, 29 May 2015 18:13:36 +0100
Message-ID: <55689E40.7010604@arm.com>
References: <cover.1432735420.git.robin.murphy@arm.com>	
	<141cbb28b55e3d748c6426f56016c46e8cf93109.1432735420.git.robin.murphy@arm.com>
	<1432877219.721.237.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1432877219.721.237.camel@mhfsdcap03>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: "laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "tiffany.lin-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <tiffany.lin-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 29/05/15 06:26, Yong Wu wrote:
> Hi Robin,
>      Thanks.
>
>      While we test venc in v4l2, we get a problem:

Thanks as always for testing!

>      When we enter the funtion[0], it will be break unexpectedly in the
> funcion[1] while the offset of sg table is not zero. It is ok if the
> offset is zero. Then I add more log in dma-iommu.c, please help check
> below.

Bah, non-zero offset was about the only scatterlist case I wasn't able 
to get out of the EHCI driver...

>      All we tested it based on dma v2. and have not tested it on v3 yet.
> The code of iommu-map-sg seems the same. if it's fixed in v3, I'm very
> sorry. The map_sg in mtk-iommu use default_iommu_map_sg.
>      Any question please tell me, Thanks very much.
>
> [0]http://lxr.free-electrons.com/source/drivers/media/v4l2-core/videobuf2-dma-contig.c#L564	[1]http://lxr.free-electrons.com/source/drivers/media/v4l2-core/videobuf2-dma-contig.c#L70
>
>
> On Wed, 2015-05-27 at 15:09 +0100, Robin Murphy wrote:
>> Taking inspiration from the existing arch/arm code, break out some
>> generic functions to interface the DMA-API to the IOMMU-API. This will
>> do the bulk of the heavy lifting for IOMMU-backed dma-mapping.
>>
>> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
>> ---
>>   drivers/iommu/Kconfig     |   7 +
>>   drivers/iommu/Makefile    |   1 +
>>   drivers/iommu/dma-iommu.c | 560 ++++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/dma-iommu.h |  94 ++++++++
>>   4 files changed, 662 insertions(+)
>>   create mode 100644 drivers/iommu/dma-iommu.c
>>   create mode 100644 include/linux/dma-iommu.h
>>
> [snip]
>> +static int __finalise_sg(struct device *dev, struct scatterlist *sg, int nents,
>> +		dma_addr_t dma_addr)
>> +{
>> +	struct scatterlist *s, *seg = sg;
>> +	unsigned long seg_mask = dma_get_seg_boundary(dev);
>> +	unsigned int max_len = dma_get_max_seg_size(dev);
>> +	unsigned int seg_len = 0, seg_dma = 0;
>> +	int i, count = 1;
>> +
>> +	for_each_sg(sg, s, nents, i) {
>> +		/* Un-swizzling the fields here, hence the naming mismatch */
>> +		unsigned int s_offset = sg_dma_address(s);
>> +		unsigned int s_length = sg_dma_len(s);
>> +		unsigned int s_dma_len = s->length;
>> +
>> +		s->offset = s_offset;
>> +		s->length = s_length;
>> +		sg_dma_address(s) = DMA_ERROR_CODE;
>> +		sg_dma_len(s) = 0;
>> +
>> +		if (seg_len && (seg_dma + seg_len == dma_addr + s_offset) &&
>> +		    (seg_len + s_dma_len <= max_len) &&
>> +		    ((seg_dma & seg_mask) <= seg_mask - (seg_len + s_length))
>> +		   ) {
>> +			sg_dma_len(seg) += s_dma_len;
>> +		} else {
>> +			if (seg_len) {
>> +				seg = sg_next(seg);
>> +				count++;
>> +			}
>> +			sg_dma_len(seg) = s_dma_len;

Does changing this to
			sg_dma_len(seg) = s_dma_len - s_offset;

make things behave as expected? Since the new unmap code no longer 
relies on adding up the individual segments to equal the IOVA size I 
don't _think_ that'll break anything here.

Robin.
