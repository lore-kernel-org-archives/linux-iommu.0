From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 10/22] PCI: Add pci_resource_to_peer()
Date: Thu, 24 Sep 2015 16:36:43 -0500
Message-ID: <20150924213643.GG10481@localhost>
References: <1442337067-22964-1-git-send-email-wdavis@nvidia.com>
	<1442337067-22964-11-git-send-email-wdavis@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1442337067-22964-11-git-send-email-wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Jerome Glisse <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Terence Ripperda <tripperda-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 15, 2015 at 12:10:55PM -0500, Will Davis wrote:
> Add helper to convert a struct resource to a peer DMA address.
> 
> Signed-off-by: Will Davis <wdavis-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  include/linux/pci.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index db0cb51..2a9deff 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1508,6 +1508,22 @@ static inline void pci_resource_to_user(const struct pci_dev *dev, int bar,
>  }
>  #endif /* HAVE_ARCH_PCI_RESOURCE_TO_USER */
>  
> +#ifdef CONFIG_HAS_DMA_P2P
> +static inline bool pci_resource_to_peer(struct pci_dev *dev,

I'm not really a fan of functions that return bool unless the
function name is obviously a predicate.  So in this case, I'd
return 0 or a negative errno.

> +					struct pci_dev *peer,
> +					struct resource *res,
> +					dma_peer_addr_t *peer_addr) {
> +	if (pci_peer_traffic_supported(dev, peer)) {
> +		struct pci_bus_region region;
> +
> +		pcibios_resource_to_bus(dev->bus, &region, res);
> +		*peer_addr = region.start;
> +		return true;
> +	}
> +
> +	return false;

It's trivial, but I'd structure it like this, which is sort of the
typical "return errors early" pattern, and reduces indentation of the
mainline path:

  if (!pci_peer_traffic_supported(dev, peer))
    return -EINVAL;

  pcibios_resource_to_bus(dev->bus, &region, res);
  *peer_addr = region.start;
  return 0;

> +}
> +#endif /* CONFIG_HAS_DMA_P2P */
>  
>  /*
>   *  The world is not perfect and supplies us with broken PCI devices.
> -- 
> 2.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
