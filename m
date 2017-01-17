From: Tomasz Nowicki <tnowicki-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v8 04/18] iommu: iommu_alloc_resv_region
Date: Tue, 17 Jan 2017 13:12:29 +0100
Message-ID: <6b6f2af5-74b4-cf51-3c48-6ebc8c040885@caviumnetworks.com>
References: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
	<1484127714-3263-5-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1484127714-3263-5-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, geethasowjanya.akula-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, shankerd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, gpkulkarni-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 11.01.2017 10:41, Eric Auger wrote:
> Introduce a new helper serving the purpose to allocate a reserved
> region. This will be used in iommu driver implementing reserved
> region callbacks.
>
> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

Reviewed-by: Tomasz Nowicki <tomasz.nowicki-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>

Thanks,
Tomasz

>
> ---
>
> v3 -> v4:
> - add INIT_LIST_HEAD(&region->list)
> - use int for prot param and add int type param
> - remove implementation outside of CONFIG_IOMMU_API
> ---
>  drivers/iommu/iommu.c | 18 ++++++++++++++++++
>  include/linux/iommu.h |  2 ++
>  2 files changed, 20 insertions(+)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 1cee5c3..927878d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1575,6 +1575,24 @@ void iommu_put_resv_regions(struct device *dev, struct list_head *list)
>  		ops->put_resv_regions(dev, list);
>  }
>
> +struct iommu_resv_region *iommu_alloc_resv_region(phys_addr_t start,
> +						  size_t length,
> +						  int prot, int type)
> +{
> +	struct iommu_resv_region *region;
> +
> +	region = kzalloc(sizeof(*region), GFP_KERNEL);
> +	if (!region)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&region->list);
> +	region->start = start;
> +	region->length = length;
> +	region->prot = prot;
> +	region->type = type;
> +	return region;
> +}
> +
>  /* Request that a device is direct mapped by the IOMMU */
>  int iommu_request_dm_for_dev(struct device *dev)
>  {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 233a6bf..f6bb55d3 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -244,6 +244,8 @@ extern void iommu_set_fault_handler(struct iommu_domain *domain,
>  extern void iommu_get_resv_regions(struct device *dev, struct list_head *list);
>  extern void iommu_put_resv_regions(struct device *dev, struct list_head *list);
>  extern int iommu_request_dm_for_dev(struct device *dev);
> +extern struct iommu_resv_region *
> +iommu_alloc_resv_region(phys_addr_t start, size_t length, int prot, int type);
>
>  extern int iommu_attach_group(struct iommu_domain *domain,
>  			      struct iommu_group *group);
>
