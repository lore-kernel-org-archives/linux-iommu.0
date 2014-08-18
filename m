From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Mon, 18 Aug 2014 23:55:54 +0200
Message-ID: <20140818215553.GJ9809@8bytes.org>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
	<1407797150-515-2-git-send-email-ohaugan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407797150-515-2-git-send-email-ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
Cc: laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Aug 11, 2014 at 03:45:50PM -0700, Olav Haugan wrote:
> +int default_iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
> +			 struct scatterlist *sg, unsigned int nents,
> +			 int prot, unsigned long flags)
> +{
> +	int ret = 0;
> +	unsigned long offset = 0;
> +	unsigned int i;
> +	struct scatterlist *s;
> +
> +	for_each_sg(sg, s, nents, i) {
> +		phys_addr_t phys = page_to_phys(sg_page(s));
> +		size_t page_len = s->offset + s->length;
> +
> +		ret = iommu_map(domain, iova + offset, phys, page_len,
> +				prot);

This isn't going to work, iova + offset, phys and page_len need to be
aligned to the minimum page-size the given IOMMU implementation
supports. See the iommu_map implementation for details.

> +int default_iommu_unmap_sg(struct iommu_domain *domain, unsigned long iova,
> +			       size_t size, unsigned long flags)

Another asymmentry here, why don't you just pass a scatterlist and nents
like in the map_sg function? if you implement it like this it is just a
duplication of iommu_unmap().

> +static inline int iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
> +			       struct scatterlist *sg, unsigned int nents,
> +			       int prot, unsigned long flags)
> +{
> +	return domain->ops->map_sg(domain, iova, sg, nents, prot, flags);
> +}
> +
> +static inline int iommu_unmap_sg(struct iommu_domain *domain,
> +				 unsigned long iova, size_t size,
> +				 unsigned long flags)
> +{
> +	return domain->ops->unmap_sg(domain, iova, size, flags);
> +}

These function pointers need to be checked for != NULL before calling
them.


	Joerg
