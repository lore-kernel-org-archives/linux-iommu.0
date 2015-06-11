From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 06/22] iommu: Allocate a default domain for iommu groups
Date: Thu, 11 Jun 2015 18:33:08 +0100
Message-ID: <5579C654.80900@arm.com>
References: <1432831305-11126-1-git-send-email-joro@8bytes.org>
	<1432831305-11126-7-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1432831305-11126-7-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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

Hi Joerg,

On 28/05/15 17:41, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
>
> The default domain will be used (if supported by the iommu
> driver) when the devices in the iommu group are not attached
> to any other domain.
>
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>   drivers/iommu/iommu.c | 32 ++++++++++++++++++++++++++++----
>   1 file changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d69e0ca..fbfc015 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -51,6 +51,7 @@ struct iommu_group {
>   	void (*iommu_data_release)(void *iommu_data);
>   	char *name;
>   	int id;
> +	struct iommu_domain *default_domain;
>   };
>
>   struct iommu_device {
> @@ -75,6 +76,9 @@ struct iommu_group_attribute iommu_group_attr_##_name =		\
>   #define to_iommu_group(_kobj)		\
>   	container_of(_kobj, struct iommu_group, kobj)
>
> +static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
> +						 unsigned type);
> +
>   static ssize_t iommu_group_attr_show(struct kobject *kobj,
>   				     struct attribute *__attr, char *buf)
>   {
> @@ -137,6 +141,9 @@ static void iommu_group_release(struct kobject *kobj)
>   	ida_remove(&iommu_group_ida, group->id);
>   	mutex_unlock(&iommu_group_mutex);
>
> +	if (group->default_domain)
> +		iommu_domain_free(group->default_domain);
> +
>   	kfree(group->name);
>   	kfree(group);
>   }
> @@ -701,7 +708,18 @@ static struct iommu_group *iommu_group_get_for_pci_dev(struct pci_dev *pdev)
>   		return group;
>
>   	/* No shared group found, allocate new */
> -	return iommu_group_alloc();
> +	group = iommu_group_alloc();
> +	if (group) {
> +		/*
> +		 * Try to allocate a default domain - needs support from the
> +		 * IOMMU driver.
> +		 */
> +		group->default_domain = __iommu_domain_alloc(pdev->dev.bus,
> +							     IOMMU_DOMAIN_DMA);
> +		group->domain = group->default_domain;
> +	}
> +
> +	return group;
>   }
>
>   /**
> @@ -922,22 +940,28 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
>   }
>   EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
>
> -struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
> +static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
> +						 unsigned type)

I'd be happier if we passed the iommu_ops in here...

>   {
>   	struct iommu_domain *domain;
>
>   	if (bus == NULL || bus->iommu_ops == NULL)
>   		return NULL;
>
> -	domain = bus->iommu_ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
> +	domain = bus->iommu_ops->domain_alloc(type);
>   	if (!domain)
>   		return NULL;
>
>   	domain->ops  = bus->iommu_ops;
> -	domain->type = IOMMU_DOMAIN_UNMANAGED;
> +	domain->type = type;
>
>   	return domain;
>   }
> +
> +struct iommu_domain *iommu_domain_alloc(struct bus_type *bus)
> +{

..having pulled them out of the bus here.

> +	return __iommu_domain_alloc(bus, IOMMU_DOMAIN_UNMANAGED);
> +}
>   EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>
>   void iommu_domain_free(struct iommu_domain *domain)
>

Even if it's only to symbolically inch us closer to having some other 
solution for platform bus devices. The SMMU page size debate is one 
thing, but it's really only a subtle case of the "IOMMU instances" 
problem. Once there are two different IOMMU drivers in the system each 
serving a subset of platform devices, how can we make sure the domain 
allocated here is wrapped in the right driver-private struct? I've had a 
try with making iommu_ops per-instance, but even that doesn't work in 
this case.

Robin.
