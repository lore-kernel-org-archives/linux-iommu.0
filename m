From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 10/22] iommu: Introduce direct mapped region handling
Date: Fri, 5 Jun 2015 15:17:50 +0100
Message-ID: <20150605141749.GA7420@arm.com>
References: <1432831305-11126-1-git-send-email-joro@8bytes.org>
	<1432831305-11126-11-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432831305-11126-11-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

On Thu, May 28, 2015 at 05:41:33PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> Add two new functions to the IOMMU-API to allow the IOMMU
> drivers to export the requirements for direct mapped regions
> per device.
> This is useful for exporting the information in Intel VT-d's
> RMRR entries or AMD-Vi's unity mappings.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/iommu.c | 16 ++++++++++++++++
>  include/linux/iommu.h | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index a0a38bd..6b8d6e7 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1469,3 +1469,19 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
> +
> +void iommu_get_dm_regions(struct device *dev, struct list_head *list)
> +{
> +	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +
> +	if (ops && ops->get_dm_regions)
> +		ops->get_dm_regions(dev, list);
> +}
> +
> +void iommu_put_dm_regions(struct device *dev, struct list_head *list)
> +{
> +	const struct iommu_ops *ops = dev->bus->iommu_ops;
> +
> +	if (ops && ops->put_dm_regions)
> +		ops->put_dm_regions(dev, list);
> +}
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 683a1c4..6894999 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -114,6 +114,20 @@ enum iommu_attr {
>  	DOMAIN_ATTR_MAX,
>  };
>  
> +/**
> + * struct iommu_dm_region - descriptor for a direct mapped memory region
> + * @list: Linked list pointers
> + * @start: System physical start address of the region
> + * @length: Length of the region in bytes
> + * @prot: IOMMU Protection flags (READ/WRITE/...)
> + */
> +struct iommu_dm_region {
> +	struct list_head	list;
> +	phys_addr_t		start;
> +	size_t			length;
> +	int			prot;
> +};

I'm slightly puzzled about this. It looks to me like we're asking the
IOMMU driver to construct a description of the system's physical address
space, but this information tends to be known elsewhere for things like
initialising lowmem on the CPU using memblock.

Also, it looks like we just use these regions to create the default
domain using iommu_map calls -- why don't we just have an IOMMU callback
to initialise the default domain instead? That would allow IOMMUs with a
per-master bypass mode to avoid allocating page tables altogether.

Will
