From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/9] PCI: Move ATS declarations outside of CONFIG_PCI
Date: Wed, 17 Apr 2019 14:47:47 -0500
Message-ID: <20190417194747.GA18308@google.com>
References: <20190417182448.12382-1-jean-philippe.brucker@arm.com>
	<20190417182448.12382-2-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190417182448.12382-2-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: zhongmiao-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, okaya-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 17, 2019 at 07:24:40PM +0100, Jean-Philippe Brucker wrote:
> At the moment, the ATS functions are only defined when CONFIG_PCI is
> enabled. Since we're about to use them in the Arm SMMUv3 driver, which
> could be built with CONFIG_PCI disabled, and they are already guarded by
> CONFIG_PCI_ATS which depends on CONFIG_PCI, move the definitions outside
> of CONFIG_PCI.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>

I guess this is OK with me, although AFAICS they're only used in
arm_smmu_enable_ats() and arm_smmu_disable_ats() and I personally
wouldn't find it objectionable to wrap the bodies of those functions
in "#ifdef CONFIG_PCI".  That might even be a useful hint to the
reader, as opposed to relying on all these stub functions
(dev_is_pci(), pci_ats_disabled(), pci_enable_ats(),
pci_disable_ats(), as well as the complete struct pci_dev declaration)
that depend on config settings that aren't obvious in the caller.

Acked-by: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>

> ---
>  include/linux/pci.h | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 77448215ef5b..169c6a18d0b0 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1521,21 +1521,6 @@ static inline void pcie_ecrc_get_policy(char *str) { }
>  
>  bool pci_ats_disabled(void);
>  
> -#ifdef CONFIG_PCI_ATS
> -/* Address Translation Service */
> -void pci_ats_init(struct pci_dev *dev);
> -int pci_enable_ats(struct pci_dev *dev, int ps);
> -void pci_disable_ats(struct pci_dev *dev);
> -int pci_ats_queue_depth(struct pci_dev *dev);
> -int pci_ats_page_aligned(struct pci_dev *dev);
> -#else
> -static inline void pci_ats_init(struct pci_dev *d) { }
> -static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
> -static inline void pci_disable_ats(struct pci_dev *d) { }
> -static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
> -static inline int pci_ats_page_aligned(struct pci_dev *dev) { return 0; }
> -#endif
> -
>  #ifdef CONFIG_PCIE_PTM
>  int pci_enable_ptm(struct pci_dev *dev, u8 *granularity);
>  #else
> @@ -1730,6 +1715,21 @@ static inline const struct pci_device_id *pci_match_id(const struct pci_device_i
>  { return NULL; }
>  #endif /* CONFIG_PCI */
>  
> +#ifdef CONFIG_PCI_ATS
> +/* Address Translation Service */
> +void pci_ats_init(struct pci_dev *dev);
> +int pci_enable_ats(struct pci_dev *dev, int ps);
> +void pci_disable_ats(struct pci_dev *dev);
> +int pci_ats_queue_depth(struct pci_dev *dev);
> +int pci_ats_page_aligned(struct pci_dev *dev);
> +#else
> +static inline void pci_ats_init(struct pci_dev *d) { }
> +static inline int pci_enable_ats(struct pci_dev *d, int ps) { return -ENODEV; }
> +static inline void pci_disable_ats(struct pci_dev *d) { }
> +static inline int pci_ats_queue_depth(struct pci_dev *d) { return -ENODEV; }
> +static inline int pci_ats_page_aligned(struct pci_dev *dev) { return 0; }
> +#endif
> +
>  /* Include architecture-dependent settings and functions */
>  
>  #include <asm/pci.h>
> -- 
> 2.21.0
> 
