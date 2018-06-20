From: Tom Lendacky <thomas.lendacky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/4 V3] Remap the device table of IOMMU in encrypted
	manner for kdump
Date: Wed, 20 Jun 2018 11:42:16 -0500
Message-ID: <60c6f00e-0eb3-d39c-6a1e-8a1dc1e095af@amd.com>
References: <20180616082714.32035-1-lijiang@redhat.com>
	<20180616082714.32035-4-lijiang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180616082714.32035-4-lijiang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lianbo Jiang <lijiang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 6/16/2018 3:27 AM, Lianbo Jiang wrote:
> In kdump mode, it will copy the device table of IOMMU from the old
> device table, which is encrypted when SME is enabled in the first
> kernel. So we must remap it in encrypted manner in order to be
> automatically decrypted when we read.
> 
> Signed-off-by: Lianbo Jiang <lijiang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> Some changes:
> 1. add some comments
> 2. clean compile warning.
> 
>  drivers/iommu/amd_iommu_init.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 904c575..a20af4c 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -889,11 +889,24 @@ static bool copy_device_table(void)
>  	}
>  
>  	old_devtb_phys = entry & PAGE_MASK;
> +
> +	/*
> +	 *  When sme enable in the first kernel, old_devtb_phys includes the
> +	 *  memory encryption mask(sme_me_mask), we must remove the memory
> +	 *  encryption mask to obtain the true physical address in kdump mode.
> +	 */
> +	if (mem_encrypt_active() && is_kdump_kernel())
> +		old_devtb_phys = __sme_clr(old_devtb_phys);
> +

You can probably just use "if (is_kdump_kernel())" here, since memory
encryption is either on in both the first and second kernel or off in
both the first and second kernel.  At which point __sme_clr() will do
the proper thing.

Actually, this needs to be done no matter what.  When doing either the
ioremap_encrypted() or the memremap(), the physical address should not
include the encryption bit/mask.

Thanks,
Tom

>  	if (old_devtb_phys >= 0x100000000ULL) {
>  		pr_err("The address of old device table is above 4G, not trustworthy!\n");
>  		return false;
>  	}
> -	old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
> +	old_devtb = (mem_encrypt_active() && is_kdump_kernel())
> +		    ? (__force void *)ioremap_encrypted(old_devtb_phys,
> +							dev_table_size)
> +		    : memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);> +
>  	if (!old_devtb)
>  		return false;
>  
> 
