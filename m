From: Don Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] intel_iommu,dmar: reserve mmio of IOMMU registers
Date: Fri, 09 Mar 2012 11:10:27 -0500
Message-ID: <4F5A2B73.9010103@redhat.com>
References: <1331250676-55926-1-git-send-email-ddutile@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1331250676-55926-1-git-send-email-ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: chrisw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

self-nak.
Found an iounmap() with a  missing release_mem_region();
will post V2 shortly.

On 03/08/2012 06:51 PM, Donald Dutile wrote:
> Intel-iommu initialization doesn't currently reserve the memory used
> for the IOMMU registers. This can allow the pci resource allocator
> to assign a device BAR to the same address as the IOMMU registers.
> This can cause some not so nice side affects when the driver
> ioremap's that region.
>
> Signed-off-by: Donald Dutile<ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/iommu/dmar.c |   18 ++++++++++++++++--
>   1 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index 35c1e17..1fcbd96 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -599,10 +599,16 @@ int alloc_iommu(struct dmar_drhd_unit *drhd)
>   	iommu->seq_id = iommu_allocated++;
>   	sprintf (iommu->name, "dmar%d", iommu->seq_id);
>
> +	map_size = VTD_PAGE_SIZE;
> +	if (!request_mem_region(drhd->reg_base_addr, map_size, iommu->name)) {
> +		printk(KERN_ERR "IOMMU: can't reserve memory\n");
> +		goto error;
> +	}
> +
>   	iommu->reg = ioremap(drhd->reg_base_addr, VTD_PAGE_SIZE);
>   	if (!iommu->reg) {
>   		printk(KERN_ERR "IOMMU: can't map the region\n");
> -		goto error;
> +		goto err_release;
>   	}
>   	iommu->cap = dmar_readq(iommu->reg + DMAR_CAP_REG);
>   	iommu->ecap = dmar_readq(iommu->reg + DMAR_ECAP_REG);
> @@ -637,10 +643,16 @@ int alloc_iommu(struct dmar_drhd_unit *drhd)
>   	map_size = VTD_PAGE_ALIGN(map_size);
>   	if (map_size>  VTD_PAGE_SIZE) {
>   		iounmap(iommu->reg);
> +		release_mem_region(drhd->reg_base_addr, VTD_PAGE_SIZE);
> +		if (!request_mem_region(drhd->reg_base_addr, map_size,
> +					iommu->name)) {
> +			printk(KERN_ERR "IOMMU: can't reserve memory\n");
> +			goto error;
> +		}
>   		iommu->reg = ioremap(drhd->reg_base_addr, map_size);
>   		if (!iommu->reg) {
>   			printk(KERN_ERR "IOMMU: can't map the region\n");
> -			goto error;
> +			goto err_release;
>   		}
>   	}
>
> @@ -659,6 +671,8 @@ int alloc_iommu(struct dmar_drhd_unit *drhd)
>
>    err_unmap:
>   	iounmap(iommu->reg);
> + err_release:
> +	release_mem_region(drhd->reg_base_addr, VTD_PAGE_SIZE);
>    error:
>   	kfree(iommu);
>   	return -1;
