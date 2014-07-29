From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Tue, 29 Jul 2014 10:25:47 +0100
Message-ID: <20140729092547.GB9245@arm.com>
References: <1406572731-6216-1-git-send-email-ohaugan@codeaurora.org>
	<1406572731-6216-2-git-send-email-ohaugan@codeaurora.org>
	<20140728191111.GW15536@arm.com> <53D6EFC0.1060308@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53D6EFC0.1060308-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Olav,

On Tue, Jul 29, 2014 at 01:50:08AM +0100, Olav Haugan wrote:
> On 7/28/2014 12:11 PM, Will Deacon wrote:
> > On Mon, Jul 28, 2014 at 07:38:51PM +0100, Olav Haugan wrote:
> >> +int iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
> >> +			struct scatterlist *sg, unsigned int nents,
> >> +			int prot, unsigned long flags)
> >> +{
> >> +	int ret = 0;
> >> +	unsigned long offset = 0;
> >> +
> >> +	BUG_ON(iova & (~PAGE_MASK));
> >> +
> >> +	if (unlikely(domain->ops->map_sg == NULL)) {
> >> +		unsigned int i;
> >> +		struct scatterlist *s;
> >> +
> >> +		for_each_sg(sg, s, nents, i) {
> >> +			phys_addr_t phys = page_to_phys(sg_page(s));
> >> +			u32 page_len = PAGE_ALIGN(s->offset + s->length);
> > 
> > Hmm, this is a pretty horrible place where CPU page size (from the sg list)
> > meets the IOMMU and I think we need to do something better to avoid spurious
> > failures. In other words, the sg list should be iterated in such a way that
> > we always pass a multiple of a supported iommu page size to iommu_map.
> > 
> > All the code using PAGE_MASK and PAGE_ALIGN needn't match what is supported
> > by the IOMMU hardware.
> 
> I am not sure what you mean. How can we iterate over the sg list in a
> different way to ensure we pass a multiple of a supported iommu page
> size? Each entry in the sg list are physically discontinuous from each
> other. If the page is too big iommu_map will take care of it for us. It
> already finds the biggest supported page size and splits up the calls to
> domain->ops->map(). Also, whoever allocates memory for use by IOMMU
> needs to be aware of what the supported minimum size is or else they
> would get mapping failures anyway.

I agree that we can't handle IOMMUs that have a minimum page size larger
than the CPU page size, but we should be able to handle the case where the
maximum supported page size on the IOMMU is smaller than the CPU page size
(e.g. 4k IOMMU with 64k pages on the CPU). I think that could trip a BUG_ON
with your patch, although the alignment would be ok in iommu_map because
page sizes are always a power-of-2. You also end up rounding the size to
64k, which could lead to mapping more than you really need to.

> (The code in __map_sg_chunk in arch/arm/mm/dma-mapping.c does the same
> thing btw.)

I have the same objection to that code :)

Will
