From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 1/3] iommu: Implement common IOMMU ops for DMA mapping
Date: Mon, 26 Oct 2015 16:55:00 +0000
Message-ID: <562E5AE4.9070001@arm.com>
References: <cover.1443718557.git.robin.murphy@arm.com>
	<ab8e1caa40d6da1afa4a49f30242ef4e6e1f17df.1443718557.git.robin.murphy@arm.com>
	<1445867094.30736.14.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1445867094.30736.14.camel@mhfsdcap03>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, djkurtz-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, pochun.lin-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 26/10/15 13:44, Yong Wu wrote:
> On Thu, 2015-10-01 at 20:13 +0100, Robin Murphy wrote:
> [...]
>> +/*
>> + * The DMA API client is passing in a scatterlist which could describe
>> + * any old buffer layout, but the IOMMU API requires everything to be
>> + * aligned to IOMMU pages. Hence the need for this complicated bit of
>> + * impedance-matching, to be able to hand off a suitably-aligned list,
>> + * but still preserve the original offsets and sizes for the caller.
>> + */
>> +int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>> +		int nents, int prot)
>> +{
>> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> +	struct iova_domain *iovad = domain->iova_cookie;
>> +	struct iova *iova;
>> +	struct scatterlist *s, *prev = NULL;
>> +	dma_addr_t dma_addr;
>> +	size_t iova_len = 0;
>> +	int i;
>> +
>> +	/*
>> +	 * Work out how much IOVA space we need, and align the segments to
>> +	 * IOVA granules for the IOMMU driver to handle. With some clever
>> +	 * trickery we can modify the list in-place, but reversibly, by
>> +	 * hiding the original data in the as-yet-unused DMA fields.
>> +	 */
>> +	for_each_sg(sg, s, nents, i) {
>> +		size_t s_offset = iova_offset(iovad, s->offset);
>> +		size_t s_length = s->length;
>> +
>> +		sg_dma_address(s) = s->offset;
>> +		sg_dma_len(s) = s_length;
>> +		s->offset -= s_offset;
>> +		s_length = iova_align(iovad, s_length + s_offset);
>> +		s->length = s_length;
>> +
>> +		/*
>> +		 * The simple way to avoid the rare case of a segment
>> +		 * crossing the boundary mask is to pad the previous one
>> +		 * to end at a naturally-aligned IOVA for this one's size,
>> +		 * at the cost of potentially over-allocating a little.
>> +		 */
>> +		if (prev) {
>> +			size_t pad_len = roundup_pow_of_two(s_length);
>> +
>> +			pad_len = (pad_len - iova_len) & (pad_len - 1);
>> +			prev->length += pad_len;
>
> Hi Robin,
>        While our v4l2 testing, It seems that we met a problem here.
>        Here we update prev->length again, Do we need update
> sg_dma_len(prev) again too?
>
>        Some function like vb2_dc_get_contiguous_size[1] always get
> sg_dma_len(s) to compare instead of s->length. so it may break
> unexpectedly while sg_dma_len(s) is not same with s->length.

This is just tweaking the faked-up length that we hand off to 
iommu_map_sg() (see also the iova_align() above), to trick it into 
bumping this segment up to a suitable starting IOVA. The real length at 
this point is stashed in sg_dma_len(s), and will be copied back into 
s->length in __finalise_sg(), so both will hold the same true length 
once we return to the caller.

Yes, it does mean that if you have a list where the segment lengths are 
page aligned but not monotonically decreasing, e.g. {64k, 16k, 64k}, 
then you'll still end up with a gap between the second and third 
segments, but that's fine because the DMA API offers no guarantees about 
what the resulting DMA addresses will be (consider the no-IOMMU case 
where they would each just be "mapped" to their physical address). If 
that breaks v4l, then it's probably v4l's DMA API use that needs looking 
at (again).

Robin.

> [1]:
> http://lxr.free-electrons.com/source/drivers/media/v4l2-core/videobuf2-dma-contig.c#L70
