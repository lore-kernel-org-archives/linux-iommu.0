From: Tomasz Nowicki <tnowicki-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v8 11/18] iommu/arm-smmu-v3: Implement reserved region
	get/put callbacks
Date: Tue, 17 Jan 2017 15:13:41 +0100
Message-ID: <dd80a861-4732-73fb-6d66-b74031925d1b@caviumnetworks.com>
References: <1484127714-3263-1-git-send-email-eric.auger@redhat.com>
	<1484127714-3263-12-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1484127714-3263-12-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
> iommu/arm-smmu: Implement reserved region get/put callbacks
>
> The get() populates the list with the MSI IOVA reserved window.
>
> At the moment an arbitray MSI IOVA window is set at 0x8000000
> of size 1MB. This will allow to report those info in iommu-group
> sysfs.
>
> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>

Reviewed-by: Tomasz Nowicki <tomasz.nowicki-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>

Thanks,
Tomasz

>
> ---
>
> v7 -> v8:
> - added Will's A-b
>
> v4: creation
> ---
>  drivers/iommu/arm-smmu-v3.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 4d6ec44..6c4111c 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -412,6 +412,9 @@
>  /* High-level queue structures */
>  #define ARM_SMMU_POLL_TIMEOUT_US	100
>
> +#define MSI_IOVA_BASE			0x8000000
> +#define MSI_IOVA_LENGTH			0x100000
> +
>  static bool disable_bypass;
>  module_param_named(disable_bypass, disable_bypass, bool, S_IRUGO);
>  MODULE_PARM_DESC(disable_bypass,
> @@ -1883,6 +1886,29 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	return iommu_fwspec_add_ids(dev, args->args, 1);
>  }
>
> +static void arm_smmu_get_resv_regions(struct device *dev,
> +				      struct list_head *head)
> +{
> +	struct iommu_resv_region *region;
> +	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
> +
> +	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> +					 prot, IOMMU_RESV_MSI);
> +	if (!region)
> +		return;
> +
> +	list_add_tail(&region->list, head);
> +}
> +
> +static void arm_smmu_put_resv_regions(struct device *dev,
> +				      struct list_head *head)
> +{
> +	struct iommu_resv_region *entry, *next;
> +
> +	list_for_each_entry_safe(entry, next, head, list)
> +		kfree(entry);
> +}
> +
>  static struct iommu_ops arm_smmu_ops = {
>  	.capable		= arm_smmu_capable,
>  	.domain_alloc		= arm_smmu_domain_alloc,
> @@ -1898,6 +1924,8 @@ static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	.domain_get_attr	= arm_smmu_domain_get_attr,
>  	.domain_set_attr	= arm_smmu_domain_set_attr,
>  	.of_xlate		= arm_smmu_of_xlate,
> +	.get_resv_regions	= arm_smmu_get_resv_regions,
> +	.put_resv_regions	= arm_smmu_put_resv_regions,
>  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>  };
>
>
