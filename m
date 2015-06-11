From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 10/22] iommu: Introduce direct mapped region handling
Date: Thu, 11 Jun 2015 20:22:44 +0100
Message-ID: <5579E004.5080904@arm.com>
References: <1432831305-11126-1-git-send-email-joro@8bytes.org>
	<1432831305-11126-11-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1432831305-11126-11-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 28/05/15 17:41, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>
> Add two new functions to the IOMMU-API to allow the IOMMU
> drivers to export the requirements for direct mapped regions
> per device.
> This is useful for exporting the information in Intel VT-d's
> RMRR entries or AMD-Vi's unity mappings.

Whilst I agree with the utility of a common abstraction for the IOMMU 
core to use (I think we could easily turn Marek's proposal for ARM[1] 
into a generic of_iommu_ backend for this), I'm less convinced that it 
needs to be exported as part of the API.

I was envisioning eventually moving the IOVA data inside the 
iommu_domain itself for the managed DMA-API implementation, so that the 
IOMMU core would be responsible for setting it up. Then the core just 
needs to ask the driver about any relevant reservations as it creates a 
domain/attaches a device, and the callers can remain in blissful 
ignorance. Besides, beyond probe time, I don't see many good reasons at 
all for a caller to have a struct device for something, yet not have 
taken control of any DMA the firmware left running.

Is that at odds with your ideas?

Robin.

[1]:http://article.gmane.org/gmane.linux.kernel.samsung-soc/45429

> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>   drivers/iommu/iommu.c | 16 ++++++++++++++++
>   include/linux/iommu.h | 31 +++++++++++++++++++++++++++++++
>   2 files changed, 47 insertions(+)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index a0a38bd..6b8d6e7 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1469,3 +1469,19 @@ int iommu_domain_set_attr(struct iommu_domain *domain,
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(iommu_domain_set_attr);
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
>   	DOMAIN_ATTR_MAX,
>   };
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
> +
>   #ifdef CONFIG_IOMMU_API
>
>   /**
> @@ -159,6 +173,10 @@ struct iommu_ops {
>   	int (*domain_set_attr)(struct iommu_domain *domain,
>   			       enum iommu_attr attr, void *data);
>
> +	/* Request/Free a list of direct mapping requirements for a device */
> +	void (*get_dm_regions)(struct device *dev, struct list_head *list);
> +	void (*put_dm_regions)(struct device *dev, struct list_head *list);
> +
>   	/* Window handling functions */
>   	int (*domain_window_enable)(struct iommu_domain *domain, u32 wnd_nr,
>   				    phys_addr_t paddr, u64 size, int prot);
> @@ -205,6 +223,9 @@ extern phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t io
>   extern void iommu_set_fault_handler(struct iommu_domain *domain,
>   			iommu_fault_handler_t handler, void *token);
>
> +extern void iommu_get_dm_regions(struct device *dev, struct list_head *list);
> +extern void iommu_put_dm_regions(struct device *dev, struct list_head *list);
> +
>   extern int iommu_attach_group(struct iommu_domain *domain,
>   			      struct iommu_group *group);
>   extern void iommu_detach_group(struct iommu_domain *domain,
> @@ -379,6 +400,16 @@ static inline void iommu_set_fault_handler(struct iommu_domain *domain,
>   {
>   }
>
> +static inline void iommu_get_dm_regions(struct device *dev,
> +					struct list_head *list)
> +{
> +}
> +
> +static inline void iommu_put_dm_regions(struct device *dev,
> +					struct list_head *list)
> +{
> +}
> +
>   static inline int iommu_attach_group(struct iommu_domain *domain,
>   				     struct iommu_group *group)
>   {
>
