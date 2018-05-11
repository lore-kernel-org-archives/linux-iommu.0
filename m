From: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 7/9] iommu/tegra: gart: Provide single domain and group
	for all devices
Date: Fri, 11 May 2018 14:12:56 +0300
Message-ID: <2f966990-7961-63de-87ec-f6a67c95d0bf@gmail.com>
References: <20180508181700.5169-1-digetx@gmail.com>
	<20180508181700.5169-8-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180508181700.5169-8-digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 08.05.2018 21:16, Dmitry Osipenko wrote:
> GART aperture is shared by all devices, hence there is a single IOMMU
> domain and group shared by these devices. Allocation of a group per
> device only wastes resources and allowance of having more than one domain
> is simply wrong because IOMMU mappings made by the users of "different"
> domains will stomp on each other.
> 
> Signed-off-by: Dmitry Osipenko <digetx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/tegra-gart.c | 107 +++++++++----------------------------
>  1 file changed, 24 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
> index 5b2d27620350..ebc105c201bd 100644
> --- a/drivers/iommu/tegra-gart.c
> +++ b/drivers/iommu/tegra-gart.c
> @@ -19,7 +19,6 @@
>  
>  #include <linux/io.h>
>  #include <linux/iommu.h>
> -#include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
>  #include <linux/slab.h>
> @@ -44,22 +43,17 @@
>  #define GART_PAGE_MASK						\
>  	(~(GART_PAGE_SIZE - 1) & ~GART_ENTRY_PHYS_ADDR_VALID)
>  
> -struct gart_client {
> -	struct device		*dev;
> -	struct list_head	list;
> -};
> -
>  struct gart_device {
>  	void __iomem		*regs;
>  	u32			*savedata;
>  	u32			page_count;	/* total remappable size */
>  	dma_addr_t		iovmm_base;	/* offset to vmm_area */
>  	spinlock_t		pte_lock;	/* for pagetable */
> -	struct list_head	client;
> -	spinlock_t		client_lock;	/* for client list */
>  	struct device		*dev;
>  
>  	struct iommu_device	iommu;		/* IOMMU Core handle */
> +	struct iommu_group	*group;		/* Common IOMMU group */
> +	struct gart_domain	*domain;	/* Unique IOMMU domain */
>  
>  	struct tegra_mc_gart_handle mc_gart_handle;
>  };
> @@ -169,81 +163,31 @@ static inline bool gart_iova_range_valid(struct gart_device *gart,
>  static int gart_iommu_attach_dev(struct iommu_domain *domain,
>  				 struct device *dev)
>  {
> -	struct gart_domain *gart_domain = to_gart_domain(domain);
> -	struct gart_device *gart = gart_domain->gart;
> -	struct gart_client *client, *c;
> -	int err = 0;
> -
> -	client = devm_kzalloc(gart->dev, sizeof(*c), GFP_KERNEL);
> -	if (!client)
> -		return -ENOMEM;
> -	client->dev = dev;
> -
> -	spin_lock(&gart->client_lock);
> -	list_for_each_entry(c, &gart->client, list) {
> -		if (c->dev == dev) {
> -			dev_err(gart->dev,
> -				"%s is already attached\n", dev_name(dev));
> -			err = -EINVAL;
> -			goto fail;
> -		}
> -	}
> -	list_add(&client->list, &gart->client);
> -	spin_unlock(&gart->client_lock);
> -	dev_dbg(gart->dev, "Attached %s\n", dev_name(dev));
>  	return 0;
> -
> -fail:
> -	devm_kfree(gart->dev, client);
> -	spin_unlock(&gart->client_lock);
> -	return err;
>  }
>  
>  static void gart_iommu_detach_dev(struct iommu_domain *domain,
>  				  struct device *dev)
>  {
> -	struct gart_domain *gart_domain = to_gart_domain(domain);
> -	struct gart_device *gart = gart_domain->gart;
> -	struct gart_client *c;
> -
> -	spin_lock(&gart->client_lock);
> -
> -	list_for_each_entry(c, &gart->client, list) {
> -		if (c->dev == dev) {
> -			list_del(&c->list);
> -			devm_kfree(gart->dev, c);
> -			dev_dbg(gart->dev, "Detached %s\n", dev_name(dev));
> -			goto out;
> -		}
> -	}
> -	dev_err(gart->dev, "Couldn't find\n");
> -out:
> -	spin_unlock(&gart->client_lock);
>  }
>  
>  static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
>  {
> -	struct gart_domain *gart_domain;
> -	struct gart_device *gart;
> -
> -	if (type != IOMMU_DOMAIN_UNMANAGED)
> -		return NULL;
> +	struct gart_device *gart = gart_handle;
>  
> -	gart = gart_handle;
> -	if (!gart)
> +	if (type != IOMMU_DOMAIN_UNMANAGED || gart->domain)
>  		return NULL;
>  
> -	gart_domain = kzalloc(sizeof(*gart_domain), GFP_KERNEL);
> -	if (!gart_domain)
> -		return NULL;
> -
> -	gart_domain->gart = gart;
> -	gart_domain->domain.geometry.aperture_start = gart->iovmm_base;
> -	gart_domain->domain.geometry.aperture_end = gart->iovmm_base +
> +	gart->domain = kzalloc(sizeof(*gart->domain), GFP_KERNEL);
> +	if (gart->domain) {
> +		gart->domain->domain.geometry.aperture_start = gart->iovmm_base;
> +		gart->domain->domain.geometry.aperture_end = gart->iovmm_base +
>  					gart->page_count * GART_PAGE_SIZE - 1;
> -	gart_domain->domain.geometry.force_aperture = true;
> +		gart->domain->domain.geometry.force_aperture = true;
> +		gart->domain->gart = gart;
> +	}
>  
> -	return &gart_domain->domain;
> +	return &gart->domain->domain;
>  }

I've missed a NULL-check and locking here, this will be fixed in v2. For now
I'll wait for the review comments (please review).
