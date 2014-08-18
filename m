From: Olav Haugan <ohaugan@codeaurora.org>
Subject: Re: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Mon, 18 Aug 2014 15:47:56 -0700
Message-ID: <53F2829C.2040809@codeaurora.org>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org> <1407797150-515-2-git-send-email-ohaugan@codeaurora.org> <20140818215553.GJ9809@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20140818215553.GJ9809@8bytes.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: laurent.pinchart+renesas@ideasonboard.com, robdclark@gmail.com, will.deacon@arm.com, thierry.reding@gmail.com, kgene.kim@samsung.com, dwmw2@infradead.org, hdoyu@nvidia.com, Varun.Sethi@freescale.com, konrad.wilk@oracle.com, s-anna@ti.com, mitchelh@codeaurora.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 8/18/2014 2:55 PM, Joerg Roedel wrote:
> On Mon, Aug 11, 2014 at 03:45:50PM -0700, Olav Haugan wrote:
>> +int default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>> +			 struct scatterlist *sg, unsigned int nents,
>> +			 int prot, unsigned long flags)
>> +{
>> +	int ret = 0;
>> +	unsigned long offset = 0;
>> +	unsigned int i;
>> +	struct scatterlist *s;
>> +
>> +	for_each_sg(sg, s, nents, i) {
>> +		phys_addr_t phys = page_to_phys(sg_page(s));
>> +		size_t page_len = s->offset + s->length;
>> +
>> +		ret = iommu_map(domain, iova + offset, phys, page_len,
>> +				prot);
> 
> This isn't going to work, iova + offset, phys and page_len need to be
> aligned to the minimum page-size the given IOMMU implementation
> supports. See the iommu_map implementation for details.

If the alignment is not correct then iommu_map() will return error. Not
sure what other option we have here (and why make it different behavior
than iommu_map which just return error when it is not aligned properly).
I don't think we want to force any kind of alignment automatically. I
would rather have the API tell me I am doing something wrong than having
the function aligning the values and possibly undermap or overmap.

>> +int default_iommu_unmap_sg(struct iommu_domain *domain, unsigned long iova,
>> +			       size_t size, unsigned long flags)
> 
> Another asymmentry here, why don't you just pass a scatterlist and nents
> like in the map_sg function? if you implement it like this it is just a
> duplication of iommu_unmap().

Yes, I am aware of that. However, several people prefer this than
passing in scatterlist. It is not very convenient to pass a scatterlist
in some use cases. Someone mentioned a use case where they would have to
create a dummy sg list and populate it with the iova just to do an
unmap. I believe we would have to do this also. There is no use for
sglist when unmapping. However, would like to keep separate API from
iommu_unmap() to keep the API function names symmetric (map_sg/unmap_sg).

>> +static inline int iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>> +			       struct scatterlist *sg, unsigned int nents,
>> +			       int prot, unsigned long flags)
>> +{
>> +	return domain->ops->map_sg(domain, iova, sg, nents, prot, flags);
>> +}
>> +
>> +static inline int iommu_unmap_sg(struct iommu_domain *domain,
>> +				 unsigned long iova, size_t size,
>> +				 unsigned long flags)
>> +{
>> +	return domain->ops->unmap_sg(domain, iova, size, flags);
>> +}
> 
> These function pointers need to be checked for != NULL before calling
> them.

I thought that was why we added the default fallback and set all the
drivers to point to these fallback functions. Several people wanted this
so that we don't have to have NULL-check in these functions (and have
the functions be simple inline functions).

Thanks,

Olav

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
