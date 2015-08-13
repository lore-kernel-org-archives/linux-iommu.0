From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v3 08/11] PCI: Clean up ATS error handling
Date: Thu, 13 Aug 2015 09:57:17 +0200
Message-ID: <20150813075717.GG12342@suse.de>
References: <20150811154525.21078.85310.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150811155202.21078.33427.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150811155202.21078.33427.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Gregor Dick <gdick@solarflare.com>, iommu@lists.linux-foundation.org, Yinghai Lu <yinghai@kernel.org>
List-Id: iommu@lists.linux-foundation.org

Hi Bjoern,

On Tue, Aug 11, 2015 at 10:52:02AM -0500, Bjorn Helgaas wrote:
> There's no need to BUG() if we enable ATS when it's already enabled.  We
> don't need to BUG() when disabling ATS on a device that doesn't support ATS
> or if it's already disabled.  If ATS is enabled, certainly we found an ATS
> capability in the past, so it should still be there now.
> 
> Clean up these error paths.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Two comments inline. With these changes:

Reviewed-by: Joerg Roedel <jroedel@suse.de>

> ---
>  drivers/pci/ats.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 0b5b0ed..0f05274 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -44,11 +44,13 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>  	u16 ctrl;
>  	struct pci_dev *pdev;
>  
> -	BUG_ON(dev->ats_cap && dev->ats_enabled);
> -
>  	if (!dev->ats_cap)
>  		return -EINVAL;
>  
> +	WARN_ON(pci_ats_enabled(dev));
> +	if (pci_ats_enabled(dev))
> +		return -EBUSY;
> +

Could be written as

	if (WARN_ON(pci_ats_enabled(dev)))
		return -EBUSY;

>  	if (ps < PCI_ATS_MIN_STU)
>  		return -EINVAL;
>  
> @@ -83,7 +85,8 @@ void pci_disable_ats(struct pci_dev *dev)
>  	struct pci_dev *pdev;
>  	u16 ctrl;
>  
> -	BUG_ON(!dev->ats_cap || !dev->ats_enabled);
> +	if (!pci_ats_enabled(dev))
> +		return;

Probably also:

	if (WARN_ON(!pci_ats_enabled(dev)))

?
