From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v5 1/1] iommu-api: Add map_sg/unmap_sg functions
Date: Tue, 12 Aug 2014 18:55:05 +0200
Message-ID: <4605275.P2SLc4fsBd@avalon>
References: <1407797150-515-1-git-send-email-ohaugan@codeaurora.org>
	<1407797150-515-2-git-send-email-ohaugan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Cc: kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Olav,

Thank you for the patch.

On Monday 11 August 2014 15:45:50 Olav Haugan wrote:
> Mapping and unmapping are more often than not in the critical path.
> map_sg and unmap_sg allows IOMMU driver implementations to optimize
> the process of mapping and unmapping buffers into the IOMMU page tables.
> 
> Instead of mapping a buffer one page at a time and requiring potentially
> expensive TLB operations for each page, this function allows the driver
> to map all pages in one go and defer TLB maintenance until after all
> pages have been mapped.
> 
> Additionally, the mapping operation would be faster in general since
> clients does not have to keep calling map API over and over again for
> each physically contiguous chunk of memory that needs to be mapped to a
> virtually contiguous region.
> 
> Signed-off-by: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c      |  2 ++
>  drivers/iommu/arm-smmu.c       |  2 ++
>  drivers/iommu/exynos-iommu.c   |  2 ++
>  drivers/iommu/intel-iommu.c    |  2 ++
>  drivers/iommu/iommu.c          | 33 +++++++++++++++++++++++++++++++
>  drivers/iommu/ipmmu-vmsa.c     |  2 ++
>  drivers/iommu/msm_iommu.c      |  2 ++
>  drivers/iommu/omap-iommu.c     |  2 ++
>  drivers/iommu/shmobile-iommu.c |  2 ++
>  drivers/iommu/tegra-smmu.c     |  2 ++
>  include/linux/iommu.h          | 44 +++++++++++++++++++++++++++++++++++++++
>  11 files changed, 95 insertions(+)

[snip]

> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 1698360..24cf727 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1088,6 +1088,39 @@ size_t iommu_unmap(struct iommu_domain *domain,
> unsigned long iova, size_t size)

[snip]

> +int default_iommu_unmap_sg(struct iommu_domain *domain, unsigned long iova,
> +			       size_t size, unsigned long flags)

I would have called this iommu_default_unmap_sg (and same comment for 
default_iommu_map_sg) to keep the iommu_ prefix, but that's up to you.

> +{
> +	return iommu_unmap(domain, iova, size);
> +}
> +EXPORT_SYMBOL_GPL(default_iommu_unmap_sg);

Do you expect drivers to need to override this ? What are the use cases for 
non-default implementation of unmap_sg different than this ?

[snip]

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 20f9a52..ee106ce 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h

[snip]

> @@ -240,6 +256,20 @@ static inline int report_iommu_fault(struct
> iommu_domain *domain, return ret;
>  }
> 
> +static inline int iommu_map_sg(struct iommu_domain *domain, unsigned long
> iova,
> +			       struct scatterlist *sg, unsigned int nents,
> +			       int prot, unsigned long flags)
> +{
> +	return domain->ops->map_sg(domain, iova, sg, nents, prot, flags);

Instead of having to modify all IOMMU drivers to set the map_sg operation to 
default_iommu_map_sg, how about calling it automatically as a fallback when 
map_sg is NULL ? Something like

	if (domain->ops->map_sg)
		return domain->ops->map_sg(domain, iova, sg, nents, prot, flags);

	return default_iommu_map_sg(domain, iova, sg, nents, prot, flags);

> +}
> +
> +static inline int iommu_unmap_sg(struct iommu_domain *domain,
> +				 unsigned long iova, size_t size,
> +				 unsigned long flags)
> +{
> +	return domain->ops->unmap_sg(domain, iova, size, flags);
> +}
> +

-- 
Regards,

Laurent Pinchart
