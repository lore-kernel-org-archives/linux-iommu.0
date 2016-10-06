From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v13 03/15] iommu/dma: Allow MSI-only cookies
Date: Thu, 6 Oct 2016 14:17:17 -0600
Message-ID: <20161006141717.13c9c111@t450s.home>
References: <1475743531-4780-1-git-send-email-eric.auger@redhat.com>
	<1475743531-4780-4-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1475743531-4780-4-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu,  6 Oct 2016 08:45:19 +0000
Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> 
> IOMMU domain users such as VFIO face a similar problem to DMA API ops
> with regard to mapping MSI messages in systems where the MSI write is
> subject to IOMMU translation. With the relevant infrastructure now in
> place for managed DMA domains, it's actually really simple for other
> users to piggyback off that and reap the benefits without giving up
> their own IOVA management, and without having to reinvent their own
> wheel in the MSI layer.
> 
> Allow such users to opt into automatic MSI remapping by dedicating a
> region of their IOVA space to a managed cookie.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> ---
> 
> v1 -> v2:
> - compared to Robin's version
> - add NULL last param to iommu_dma_init_domain
> - set the msi_geometry aperture
> - I removed
>   if (base < U64_MAX - size)
>      reserve_iova(iovad, iova_pfn(iovad, base + size), ULONG_MAX);
>   don't get why we would reserve something out of the scope of the iova domain?
>   what do I miss?
> ---
>  drivers/iommu/dma-iommu.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/dma-iommu.h |  9 +++++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c5ab866..11da1a0 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -716,3 +716,43 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
>  		msg->address_lo += lower_32_bits(msi_page->iova);
>  	}
>  }
> +
> +/**
> + * iommu_get_dma_msi_region_cookie - Configure a domain for MSI remapping only

Should this perhaps be iommu_setup_dma_msi_region_cookie, or something
along those lines.  I'm not sure what we're get'ing.  Thanks,

Alex

> + * @domain: IOMMU domain to prepare
> + * @base: Base address of IOVA region to use as the MSI remapping aperture
> + * @size: Size of the desired MSI aperture
> + *
> + * Users who manage their own IOVA allocation and do not want DMA API support,
> + * but would still like to take advantage of automatic MSI remapping, can use
> + * this to initialise their own domain appropriately.
> + */
> +int iommu_get_dma_msi_region_cookie(struct iommu_domain *domain,
> +		dma_addr_t base, u64 size)
> +{
> +	struct iommu_dma_cookie *cookie;
> +	struct iova_domain *iovad;
> +	int ret;
> +
> +	if (domain->type == IOMMU_DOMAIN_DMA)
> +		return -EINVAL;
> +
> +	ret = iommu_get_dma_cookie(domain);
> +	if (ret)
> +		return ret;
> +
> +	ret = iommu_dma_init_domain(domain, base, size, NULL);
> +	if (ret) {
> +		iommu_put_dma_cookie(domain);
> +		return ret;
> +	}
> +
> +	domain->msi_geometry.aperture_start = base;
> +	domain->msi_geometry.aperture_end = base + size - 1;
> +
> +	cookie = domain->iova_cookie;
> +	iovad = &cookie->iovad;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(iommu_get_dma_msi_region_cookie);
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 32c5890..1c55413 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -67,6 +67,9 @@ int iommu_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
>  /* The DMA API isn't _quite_ the whole story, though... */
>  void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
>  
> +int iommu_get_dma_msi_region_cookie(struct iommu_domain *domain,
> +		dma_addr_t base, u64 size);
> +
>  #else
>  
>  struct iommu_domain;
> @@ -90,6 +93,12 @@ static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
>  {
>  }
>  
> +static inline int iommu_get_dma_msi_region_cookie(struct iommu_domain *domain,
> +		dma_addr_t base, u64 size)
> +{
> +	return -ENODEV;
> +}
> +
>  #endif	/* CONFIG_IOMMU_DMA */
>  #endif	/* __KERNEL__ */
>  #endif	/* __DMA_IOMMU_H */
