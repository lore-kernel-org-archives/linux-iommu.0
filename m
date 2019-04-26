From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 6/9] iommu/amd: use helper pci_dev_id
Date: Fri, 26 Apr 2019 15:47:10 +0200
Message-ID: <20190426134710.GD24576@8bytes.org>
References: <2e1f9a57-6d08-d017-24da-3e6b97fa2449@gmail.com>
 <f673e8ac-cc9a-75a6-09b8-35b94bfc868b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f673e8ac-cc9a-75a6-09b8-35b94bfc868b@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Oded Gabbay <oded.gabbay@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, David Woodhouse <dwmw2@infradead.org>, Realtek linux nic maintainers <nic_swsd@realtek.com>, "David S. Miller" <davem@davemloft.net>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Benson Leung <bleung@chromium.org>, Enric Balletbo i Serra <enric.balletbo@>
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 24, 2019 at 09:15:25PM +0200, Heiner Kallweit wrote:
> Use new helper pci_dev_id() to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Joerg Roedel <jroedel@suse.de>

> ---
>  drivers/iommu/amd_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index f467cc4b4..5cb201422 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -165,7 +165,7 @@ static inline u16 get_pci_device_id(struct device *dev)
>  {
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  
> -	return PCI_DEVID(pdev->bus->number, pdev->devfn);
> +	return pci_dev_id(pdev);
>  }
>  
>  static inline int get_acpihid_device_id(struct device *dev,
> -- 
> 2.21.0
> 
