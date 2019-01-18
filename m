From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] PCI: iproc: CRS state check in config request
Date: Fri, 18 Jan 2019 09:08:51 -0600
Message-ID: <20190118150851.GC25249@google.com>
References: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com>
	<1547785403-32268-3-git-send-email-srinath.mannam@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1547785403-32268-3-git-send-email-srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Srinath Mannam <srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 18, 2019 at 09:53:22AM +0530, Srinath Mannam wrote:
> In the current implementation, config read of 0xffff0001 data
> is assumed as CRS completion. but sometimes 0xffff0001 can be
> a valid data.
> IPROC PCIe RC has a register to show config request status flags
> like SC, UR, CRS and CA.
> So that extra check is added in the code to confirm the CRS
> state using this register before reissue config request.

s/. but/.  But/  (Sentences start with a capital letter.)

Please wrap this text correctly.  If it's a single paragraph, wrap it so
the lines are filled.  It *looks* like it's intended to be separate
paragraphs; they should be separated by blank lines.

> Signed-off-by: Srinath Mannam <srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Ray Jui <ray.jui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/pci/controller/pcie-iproc.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> index 13ce80f..ee89d56 100644
> --- a/drivers/pci/controller/pcie-iproc.c
> +++ b/drivers/pci/controller/pcie-iproc.c
> @@ -63,6 +63,10 @@
>  #define APB_ERR_EN_SHIFT		0
>  #define APB_ERR_EN			BIT(APB_ERR_EN_SHIFT)
>  
> +#define CFG_RD_SUCCESS			0
> +#define CFG_RD_UR			1
> +#define CFG_RD_CRS			2
> +#define CFG_RD_CA			3
>  #define CFG_RETRY_STATUS		0xffff0001
>  #define CFG_RETRY_STATUS_TIMEOUT_US	500000 /* 500 milliseconds */
>  
> @@ -300,6 +304,9 @@ enum iproc_pcie_reg {
>  	IPROC_PCIE_IARR4,
>  	IPROC_PCIE_IMAP4,
>  
> +	/* config read status */
> +	IPROC_PCIE_CFG_RD_STATUS,
> +
>  	/* link status */
>  	IPROC_PCIE_LINK_STATUS,
>  
> @@ -370,6 +377,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
>  	[IPROC_PCIE_IMAP3]		= 0xe08,
>  	[IPROC_PCIE_IARR4]		= 0xe68,
>  	[IPROC_PCIE_IMAP4]		= 0xe70,
> +	[IPROC_PCIE_CFG_RD_STATUS]	= 0xee0,
>  	[IPROC_PCIE_LINK_STATUS]	= 0xf0c,
>  	[IPROC_PCIE_APB_ERR_EN]		= 0xf40,
>  	[IPROC_PCIE_ORDERING_CFG]	= 0x2000,
> @@ -501,10 +509,12 @@ static void __iomem *iproc_pcie_map_ep_cfg_reg(struct iproc_pcie *pcie,
>  	return (pcie->base + offset);
>  }
>  
> -static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
> +static unsigned int iproc_pcie_cfg_retry(struct iproc_pcie *pcie,
> +					 void __iomem *cfg_data_p)
>  {
>  	int timeout = CFG_RETRY_STATUS_TIMEOUT_US;
>  	unsigned int data;
> +	u32 status;
>  
>  	/*
>  	 * As per PCIe spec r3.1, sec 2.3.2, CRS Software Visibility only
> @@ -525,6 +535,15 @@ static unsigned int iproc_pcie_cfg_retry(void __iomem *cfg_data_p)
>  	 */
>  	data = readl(cfg_data_p);
>  	while (data == CFG_RETRY_STATUS && timeout--) {
> +		/*
> +		 * CRS state is set in CFG_RD status register
> +		 * This will handle the case where CFG_RETRY_STATUS is
> +		 * valid config data.
> +		 */
> +		status = iproc_pcie_read_reg(pcie, IPROC_PCIE_CFG_RD_STATUS);
> +		if (status != CFG_RD_CRS)
> +			return data;
> +
>  		udelay(1);
>  		data = readl(cfg_data_p);
>  	}
> @@ -603,7 +622,7 @@ static int iproc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
>  	if (!cfg_data_p)
>  		return PCIBIOS_DEVICE_NOT_FOUND;
>  
> -	data = iproc_pcie_cfg_retry(cfg_data_p);
> +	data = iproc_pcie_cfg_retry(pcie, cfg_data_p);
>  
>  	*val = data;
>  	if (size <= 2)
> -- 
> 2.7.4
> 
