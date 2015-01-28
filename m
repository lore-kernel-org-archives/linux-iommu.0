From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 02/15] iommu: Introduce iommu domain types
Date: Wed, 28 Jan 2015 14:19:34 +0000
Message-ID: <20150128141934.GP1569@arm.com>
References: <1422316305-19216-1-git-send-email-joro@8bytes.org>
	<1422316305-19216-3-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1422316305-19216-3-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

Thanks for posting this!

On Mon, Jan 26, 2015 at 11:51:32PM +0000, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> This allows to handle domains differently based on their
> type in the future. An IOMMU driver can implement certain
> optimizations for DMA-API domains for example.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/iommu.c |  5 +++--
>  include/linux/iommu.h | 11 ++++++++++-
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 684efc0..ab24d77 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -909,14 +909,15 @@ struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
>  	ops = bus->iommu_ops;
>  
>  	if (ops->domain_alloc)
> -		domain = ops->domain_alloc();
> +		domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
>  	else
>  		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>  
>  	if (!domain)
>  		return NULL;
>  
> -	domain->ops = bus->iommu_ops;
> +	domain->ops  = bus->iommu_ops;
> +	domain->type = IOMMU_DOMAIN_UNMANAGED;
>  
>  	if (ops->domain_init && domain->ops->domain_init(domain))
>  		goto out_free;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 69d1d12..0b67f65 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -51,7 +51,16 @@ struct iommu_domain_geometry {
>  	bool force_aperture;       /* DMA only allowed in mappable range? */
>  };
>  
> +/* This are the possible domain-types */
> +enum iommu_domain_type {
> +	IOMMU_DOMAIN_DMA,	/* Domain used for DMA-API */
> +	IOMMU_DOMAIN_IDENTITY,	/* Identity mapped domain  */

What happens if somebody calls map or unmap on an identity-mapping domain?
Can we catch that in the IOMMU core before calling the IOMMU driver? That
also implies we need something extra to parameterise the attributes for
the mapping (e.g. cacheable, read-only) and also potentially the address
range.

> +	IOMMU_DOMAIN_UNMANAGED, /* Domain mappings are managed by a third party
> +				   user (like KVM or VFIO) */

We already have the domain attributes (iommu_attr) to describe features
of a domain. Is there really a need for this extra type, or can we extend
the attribute set and allow for domain allocation with attributes?

Will
