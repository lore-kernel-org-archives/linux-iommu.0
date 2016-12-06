From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC v3 04/10] iommu: iommu_alloc_resv_region
Date: Tue, 6 Dec 2016 17:30:44 +0000
Message-ID: <25fd2c22-1e4d-dd6b-d9fa-e3ad3573abf9@arm.com>
References: <1479215363-2898-1-git-send-email-eric.auger@redhat.com>
	<1479215363-2898-5-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1479215363-2898-5-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 15/11/16 13:09, Eric Auger wrote:
> Introduce a new helper serving the purpose to allocate a reserved
> region.  This will be used in iommu driver implementing reserved
> region callbacks.
> 
> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/iommu/iommu.c | 16 ++++++++++++++++
>  include/linux/iommu.h |  8 ++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index c7ed334..6ee529f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1562,6 +1562,22 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
>  		ops->put_resv_regions(dev, list);
>  }
>  
> +struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
> +						  size_t length,
> +						  unsigned int prot)
> +{
> +	struct iommu_resv_region *region;
> +
> +	region = kzalloc(sizeof(*region), GFP_KERNEL);
> +	if (!region)
> +		return NULL;
> +
> +	region->start = start;
> +	region->length = length;
> +	region->prot = prot;
> +	return region;
> +}

I think you need an INIT_LIST_HEAD() in here as well, or
CONFIG_DEBUG_LIST might get unhappy about using an uninitialised head later.

Robin.

> +
>  /* Request that a device is direct mapped by the IOMMU */
>  int iommu_request_dm_for_dev(struct device *dev)
>  {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 02cf565..0aea877 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -241,6 +241,8 @@ extern void iommu_set_fault_handler(struct iommu_domain *domain,
>  extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
>  extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
>  extern int iommu_request_dm_for_dev(struct device *dev);
> +extern struct iommu_resv_region *
> +iommu_alloc_resv_region(phys_addr_t start, size_t length, unsigned int prot);
>  
>  extern int iommu_attach_group(struct iommu_domain *domain,
>  			      struct iommu_group *group);
> @@ -454,6 +456,12 @@ static inline void iommu_put_resv_regions(struct device *dev,
>  {
>  }
>  
> +static inline struct iommu_resv_region *
> +iommu_alloc_resv_region(phys_addr_t start, size_t length, unsigned int prot)
> +{
> +	return NULL;
> +}
> +
>  static inline int iommu_request_dm_for_dev(struct device *dev)
>  {
>  	return -ENODEV;
> 
