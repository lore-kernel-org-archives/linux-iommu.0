From: Auger Eric <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v12 09/11] genirq/msi: Introduce msi_desc flags
Date: Tue, 9 Aug 2016 08:52:21 +0200
Message-ID: <ae002707-4bdf-1f58-1723-600748119167@redhat.com>
References: <1470158617-7022-1-git-send-email-eric.auger@redhat.com>
	<1470158617-7022-10-git-send-email-eric.auger@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1470158617-7022-10-git-send-email-eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: eric.auger.pro-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: drjones-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Manish.Jaggi-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dennis.chen-5wv7dgnIgG8@public.gmane.org, robert.richter-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org, yehuday-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 02/08/2016 19:23, Eric Auger wrote:
> This new flags member is meant to store additional information about
> the msi descriptor, starting with allocation status information.
> 
> MSI_DESC_FLAG_ALLOCATED bit tells the associated base IRQ is allocated.
> This information is currently used at deallocation time. We also
> introduce MSI_DESC_FLAG_FUNCTIONAL telling the MSIs are functional.
> 
> For the time being ALLOCATED and FUNCTIONAL are set at the same time
> but this is going to change in subsequent patch. Indeed in some situations
> some additional tasks need to be carried out for the MSI to be functional.
> For instance the MSI doorbell may need to be mapped in an IOMMU.
> 
> FUNCTIONAL value already gets used when enumerating the usable MSIs in
> msix_capability_init.
> 
> Signed-off-by: Eric Auger <eric.auger-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> ---
> 
> v12: new
> ---
>  drivers/pci/msi.c   |  2 +-
>  include/linux/msi.h | 14 ++++++++++++++
>  kernel/irq/msi.c    |  7 ++++++-
>  3 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index a080f44..d7733ea 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -793,7 +793,7 @@ out_avail:
>  		int avail = 0;
>  
>  		for_each_pci_msi_entry(entry, dev) {
> -			if (entry->irq != 0)
> +			if (entry->flags & MSI_DESC_FLAG_FUNCTIONAL)
>  				avail++;
>  		}
>  		if (avail != 0)
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 8b425c6..18f894f 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -47,6 +47,7 @@ struct fsl_mc_msi_desc {
>   * @nvec_used:	The number of vectors used
>   * @dev:	Pointer to the device which uses this descriptor
>   * @msg:	The last set MSI message cached for reuse
> + * @flags:	flags to describe the MSI descriptor status or features
>   *
>   * @masked:	[PCI MSI/X] Mask bits
>   * @is_msix:	[PCI MSI/X] True if MSI-X
> @@ -67,6 +68,7 @@ struct msi_desc {
>  	unsigned int			nvec_used;
>  	struct device			*dev;
>  	struct msi_msg			msg;
> +	u32						flags;
I will fix this bad alignment on next version

>  
>  	union {
>  		/* PCI MSI/X specific data */
> @@ -99,6 +101,18 @@ struct msi_desc {
>  	};
>  };
>  
> +/* Flags for msi_desc */
> +enum {
> +	/* the base IRQ is allocated */
> +	MSI_DESC_FLAG_ALLOCATED	=	(1 << 0),
> +	/**
> +	 * the MSI is functional; in some cases the fact the base IRQ is
> +	 * allocated is not sufficient for the MSIs to be functional: for
> +	 * example the MSI doorbell(s) may need to be IOMMU mapped.
> +	 */
> +	MSI_DESC_FLAG_FUNCTIONAL =	(1 << 1),
> +};
> +
>  /* Helpers to hide struct msi_desc implementation details */
>  #define msi_desc_to_dev(desc)		((desc)->dev)
>  #define dev_to_msi_list(dev)		(&(dev)->msi_list)
> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index 72bf4d6..9b93766 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -361,6 +361,9 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>  			return ret;
>  		}
>  
> +		desc->flags |= MSI_DESC_FLAG_ALLOCATED;
> +		desc->flags |= MSI_DESC_FLAG_FUNCTIONAL;
> +
>  		for (i = 0; i < desc->nvec_used; i++)
>  			irq_set_msi_desc_off(virq, i, desc);
>  	}
> @@ -395,9 +398,11 @@ void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
>  		 * enough that there is no IRQ associated to this
>  		 * entry. If that's the case, don't do anything.
>  		 */
> -		if (desc->irq) {
> +		if (desc->flags & MSI_DESC_FLAG_ALLOCATED) {
>  			irq_domain_free_irqs(desc->irq, desc->nvec_used);
>  			desc->irq = 0;
> +			desc->flags &= ~MSI_DESC_FLAG_ALLOCATED;
> +			desc->flags &= ~MSI_DESC_FLAG_FUNCTIONAL;
Also I will combine those settings

Thanks

Eric
>  		}
>  	}
>  }
> 
