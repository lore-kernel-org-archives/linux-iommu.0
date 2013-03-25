From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu: add a function to find an iommu group by id
Date: Mon, 25 Mar 2013 08:28:32 -0600
Message-ID: <1364221712.24132.632.camel@bling.home>
References: <1364167429-6432-1-git-send-email-aik@ozlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1364167429-6432-1-git-send-email-aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
Cc: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2013-03-25 at 10:23 +1100, Alexey Kardashevskiy wrote:
> As IOMMU groups are exposed to the user space by their numbers,
> the user space can use them in various kernel APIs so the kernel
> might need an API to find a group by its ID.
> 
> As an example, QEMU VFIO on PPC64 platform needs it to associate
> a logical bus number (LIOBN) with a specific IOMMU group in order
> to support in-kernel handling of DMA map/unmap requests.
> 
> The patch adds the iommu_group_get_by_id(id) function which performs
> such search.

Subject: [PATCH v3]....

v2 was the last one, where's the changelog for v3?
> v2: fixed reference counting.
> 
> Signed-off-by: Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
> ---

Acked-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

>  drivers/iommu/iommu.c |   29 +++++++++++++++++++++++++++++
>  include/linux/iommu.h |    1 +
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 1065a1a..0de83eb 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -204,6 +204,35 @@ again:
>  }
>  EXPORT_SYMBOL_GPL(iommu_group_alloc);
>  
> +struct iommu_group *iommu_group_get_by_id(int id)
> +{
> +	struct kobject *group_kobj;
> +	struct iommu_group *group;
> +	const char *name;
> +
> +	if (!iommu_group_kset)
> +		return NULL;
> +
> +	name = kasprintf(GFP_KERNEL, "%d", id);
> +	if (!name)
> +		return NULL;
> +
> +	group_kobj = kset_find_obj(iommu_group_kset, name);
> +	kfree(name);
> +
> +	if (!group_kobj)
> +		return NULL;
> +
> +	group = container_of(group_kobj, struct iommu_group, kobj);
> +	BUG_ON(group->id != id);
> +
> +	kobject_get(group->devices_kobj);
> +	kobject_put(&group->kobj);
> +
> +	return group;
> +}
> +EXPORT_SYMBOL_GPL(iommu_group_get_by_id);
> +
>  /**
>   * iommu_group_get_iommudata - retrieve iommu_data registered for a group
>   * @group: the group
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index f3b99e1..00e5d7d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -113,6 +113,7 @@ struct iommu_ops {
>  extern int bus_set_iommu(struct bus_type *bus, struct iommu_ops *ops);
>  extern bool iommu_present(struct bus_type *bus);
>  extern struct iommu_domain *iommu_domain_alloc(struct bus_type *bus);
> +extern struct iommu_group *iommu_group_get_by_id(int id);
>  extern void iommu_domain_free(struct iommu_domain *domain);
>  extern int iommu_attach_device(struct iommu_domain *domain,
>  			       struct device *dev);
