From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/4 V3] Remap the device table of IOMMU in encrypted
	manner for kdump
Date: Thu, 21 Jun 2018 09:57:11 +0800
Message-ID: <20180621015711.GH29979@MiWiFi-R3L-srv>
References: <20180616082714.32035-1-lijiang@redhat.com>
	<20180616082714.32035-4-lijiang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180616082714.32035-4-lijiang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lianbo Jiang <lijiang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: thomas.lendacky-5C7GfCeVMHo@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 06/16/18 at 04:27pm, Lianbo Jiang wrote:
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

This is my question asked in cover letter. If 1st kernel sme is off, 2nd
kernel sme is on, you remap it with sme enabled or disabled on purpose,
why does that not work? It's not concern to this patch.

> +
>  	if (old_devtb_phys >= 0x100000000ULL) {
>  		pr_err("The address of old device table is above 4G, not trustworthy!\n");
>  		return false;
>  	}
> -	old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
> +	old_devtb = (mem_encrypt_active() && is_kdump_kernel())
> +		    ? (__force void *)ioremap_encrypted(old_devtb_phys,
> +							dev_table_size)
> +		    : memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
> +
>  	if (!old_devtb)
>  		return false;
>  
> -- 
> 2.9.5
> 
> 
> _______________________________________________
> kexec mailing list
> kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/kexec
