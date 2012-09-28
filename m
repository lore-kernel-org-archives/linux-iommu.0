From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 05/16] iommu/amd: Split device table initialization into
	irq and dma part
Date: Fri, 28 Sep 2012 10:17:53 -0400
Message-ID: <20120928141752.GD7483@localhost.localdomain>
References: <1348835046-3262-1-git-send-email-joerg.roedel@amd.com>
	<1348835046-3262-6-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1348835046-3262-6-git-send-email-joerg.roedel-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 28, 2012 at 02:23:55PM +0200, Joerg Roedel wrote:
> When the IOMMU is enabled very early (as with irq-remapping)
> some devices are still in BIOS hand. When dma is blocked
> early this can cause lots of IO_PAGE_FAULTs. So delay the
> DMA initialization and do it right before the dma_ops are
> initialized.
> To be secure, block all interrupts by default when irq-remapping is

What are you trying to be secure against?

> enabled in the system. They will be reenabled on demand
> later.
> 
> Signed-off-by: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu_init.c |   19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 3f0b68f..8e9d71c 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -1378,7 +1378,7 @@ static int __init init_memory_definitions(struct acpi_table_header *table)
>   * Init the device table to not allow DMA access for devices and
>   * suppress all page faults
>   */
> -static void init_device_table(void)
> +static void init_device_table_dma(void)
>  {
>  	u32 devid;
>  
> @@ -1388,6 +1388,17 @@ static void init_device_table(void)
>  	}
>  }
>  
> +static void init_device_table(void)
> +{
> +	u32 devid;
> +
> +	if (!amd_iommu_irq_remap)
> +		return;
> +
> +	for (devid = 0; devid <= amd_iommu_last_bdf; ++devid)
> +		set_dev_entry_bit(devid, DEV_ENTRY_IRQ_TBL_EN);
> +}
> +
>  static void iommu_init_flags(struct amd_iommu *iommu)
>  {
>  	iommu->acpi_flags & IVHD_FLAG_HT_TUN_EN_MASK ?
> @@ -1778,8 +1789,14 @@ static bool detect_ivrs(void)
>  
>  static int amd_iommu_init_dma(void)
>  {
> +	struct amd_iommu *iommu;
>  	int ret;
>  
> +	init_device_table_dma();
> +
> +	for_each_iommu(iommu)
> +		iommu_flush_all_caches(iommu);
> +
>  	if (iommu_pass_through)
>  		ret = amd_iommu_init_passthrough();
>  	else
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
