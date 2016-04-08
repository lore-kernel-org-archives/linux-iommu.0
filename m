From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5 5/6] PCI: Add DMA alias quirk for mic_x200_dma
Date: Fri, 8 Apr 2016 14:19:36 -0600
Message-ID: <20160408141936.36df3dc7@t450s.home>
References: <20160224194423.7585.46582.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<1457016800-11903-1-git-send-email-jacek.lawrynowicz@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1457016800-11903-1-git-send-email-jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacek Lawrynowicz <jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu,  3 Mar 2016 15:53:20 +0100
Jacek Lawrynowicz <jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> MIC x200 NTB forwards PCIe traffic using multiple alien RID. They have to
> be added as aliases to the DMA device in order to allow buffer access
> when IOMMU is enabled.
> 
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Acked-by: David Woodhouse <David.Woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---

Reviewed-by: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>


>  Updated quirk comment with requirement that aliases have to be matching
>  values programmed in the EEPROM. The LUT table on x200 is static so there
>  is no need to program it from the driver.
> 
>  drivers/pci/quirks.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 51927a5..e66f09d 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3696,6 +3696,20 @@ DECLARE_PCI_FIXUP_HEADER(0x1283, 0x8892, quirk_use_pcie_bridge_dma_alias);
>  DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
>  
>  /*
> + * MIC x200 NTB forwards PCIe traffic using multiple alien RIDs. They have to
> + * be added as aliases to the DMA device in order to allow buffer access
> + * when IOMMU is enabled. Following devfns have to match RIT-LUT table
> + * programmed in the EEPROM.
> + */
> +static void quirk_mic_x200_dma_alias(struct pci_dev *pdev)
> +{
> +	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0));
> +	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0));
> +	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3));
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264, quirk_mic_x200_dma_alias);
> +
> +/*
>   * Intersil/Techwell TW686[4589]-based video capture cards have an empty (zero)
>   * class code.  Fix it.
>   */
