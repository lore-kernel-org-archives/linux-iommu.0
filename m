From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V1 1/1] iommu: Make sure device's ID array elements are
	unique
Date: Tue, 19 Dec 2017 09:37:26 -0700
Message-ID: <20171219093726.432e16e7@t450s.home>
References: <1513696436-31834-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
	<1513696821-32291-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1513696821-32291-1-git-send-email-tomasz.nowicki-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tomasz Nowicki <tomasz.nowicki-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: Jayachandran.Nair-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ganapatrao.Kulkarni-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 19 Dec 2017 16:20:21 +0100
Tomasz Nowicki <tomasz.nowicki-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org> wrote:

> While iterating over DMA aliases for a PCI device, for some rare cases
> (i.e. PCIe-to-PCI/X bridges) we may get exactly the same ID as initial child
> device. In turn, the same ID may get registered for a device multiple times.
> Eventually IOMMU  driver may try to configure the same ID within domain
> multiple times too which for some IOMMU drivers is illegal and causes kernel
> panic.
> 
> Rule out ID duplication prior to device ID array registration.
> 
> CC: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org	# v4.14+

You've identified a release, is there a specific commit this fixes?

> Signed-off-by: Tomasz Nowicki <tomasz.nowicki-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
> ---
>  drivers/iommu/iommu.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3de5c0b..9b2c138 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1945,6 +1945,31 @@ void iommu_fwspec_free(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(iommu_fwspec_free);
>  
> +static void iommu_fwspec_remove_ids_dup(struct device *dev, u32 *ids,
> +					int *num_ids)
> +{
> +	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> +	int i, j, k, valid_ids = *num_ids;
> +
> +	for (i = 0; i < valid_ids; i++) {
> +		for (j = 0; j < fwspec->num_ids; j++) {
> +			if (ids[i] != fwspec->ids[j])
> +				continue;
> +
> +			dev_info(dev, "found 0x%x ID duplication, skipped\n",
> +				 ids[i]);
> +
> +			for (k = i + 1; k < valid_ids; k++)
> +				ids[k - 1] = ids[k];

Use memmove()?

> +
> +			valid_ids--;
> +			break;

At this point ids[i] is not the ids[i] that we tested for dupes, it's
what was ids[i + 1], but we're going to i++ on the next iteration and
we therefore never test that entry.

> +		}
> +	}
> +
> +	*num_ids = valid_ids;
> +}
> +
>  int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
>  {
>  	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
> @@ -1954,6 +1979,9 @@ int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
>  	if (!fwspec)
>  		return -EINVAL;
>  
> +	/* Rule out IDs already registered */
> +	iommu_fwspec_remove_ids_dup(dev, ids, &num_ids);
> +
>  	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + num_ids]);
>  	if (size > sizeof(*fwspec)) {
>  		fwspec = krealloc(dev->iommu_fwspec, size, GFP_KERNEL);
