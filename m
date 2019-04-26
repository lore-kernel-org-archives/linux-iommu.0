From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 7/9] iommu/vt-d: use helper pci_dev_id
Date: Fri, 26 Apr 2019 15:47:28 +0200
Message-ID: <20190426134727.GE24576@8bytes.org>
References: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
 <0889204c-18aa-8a5f-1781-aaf32ee5beba@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0889204c-18aa-8a5f-1781-aaf32ee5beba@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, David Woodhouse <dwmw2@infradead.org>, Realtek linux nic maintainers <nic_swsd@realtek.com>, "David S. Miller" <davem@davemloft.net>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 24, 2019 at 09:16:10PM +0200, Heiner Kallweit wrote:
> Use new helper pci_dev_id() to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Joerg Roedel <jroedel@suse.de>

> ---
>  drivers/iommu/intel-iommu.c         | 2 +-
>  drivers/iommu/intel_irq_remapping.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index d93c4bd7d..3f475a23a 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1391,7 +1391,7 @@ static void iommu_enable_dev_iotlb(struct device_domain_info *info)
>  
>  		/* pdev will be returned if device is not a vf */
>  		pf_pdev = pci_physfn(pdev);
> -		info->pfsid = PCI_DEVID(pf_pdev->bus->number, pf_pdev->devfn);
> +		info->pfsid = pci_dev_id(pf_pdev);
>  	}
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
> diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel_irq_remapping.c
> index 634d8f059..4160aa9f3 100644
> --- a/drivers/iommu/intel_irq_remapping.c
> +++ b/drivers/iommu/intel_irq_remapping.c
> @@ -424,7 +424,7 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
>  		set_irte_sid(irte, SVT_VERIFY_SID_SQ, SQ_ALL_16, data.alias);
>  	else
>  		set_irte_sid(irte, SVT_VERIFY_SID_SQ, SQ_ALL_16,
> -			     PCI_DEVID(dev->bus->number, dev->devfn));
> +			     pci_dev_id(dev));
>  
>  	return 0;
>  }
> -- 
> 2.21.0
> 
