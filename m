From: Chris Wright <chrisw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] intel_iommu,dmar: reserve mmio of IOMMU registers
Date: Thu, 5 Apr 2012 13:58:06 -0700
Message-ID: <20120405205806.GV10418@x200.localdomain>
References: <1331332723-19522-1-git-send-email-ddutile@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1331332723-19522-1-git-send-email-ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Donald Dutile <ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: chrisw-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

* Donald Dutile (ddutile-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org) wrote:
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -581,7 +581,7 @@ int __init detect_intel_iommu(void)
>  int alloc_iommu(struct dmar_drhd_unit *drhd)
>  {
>  	struct intel_iommu *iommu;
> -	int map_size;
> +	resource_size_t map_size;
>  	u32 ver;
>  	static int iommu_allocated = 0;
>  	int agaw = 0;
> @@ -599,10 +599,17 @@ int alloc_iommu(struct dmar_drhd_unit *drhd)
>  	iommu->seq_id = iommu_allocated++;
>  	sprintf (iommu->name, "dmar%d", iommu->seq_id);
>  
> -	iommu->reg = ioremap(drhd->reg_base_addr, VTD_PAGE_SIZE);

I think it'd be nice to create a helper function that does the request
and map.  This should include the map, read cap/ecap, calculate size and
possbily remap.  Would probably simplify the error cleanup too.

> +	iommu->reg_phys = drhd->reg_base_addr;
> +	iommu->reg_size = VTD_PAGE_SIZE;
> +	if (!request_mem_region(iommu->reg_phys, iommu->reg_size, iommu->name)) {
> +		printk(KERN_ERR "IOMMU: can't reserve memory\n");
> +		goto error;
> +	}
> +
> +	iommu->reg = ioremap(iommu->reg_phys, iommu->reg_size);
>  	if (!iommu->reg) {
>  		printk(KERN_ERR "IOMMU: can't map the region\n");
> -		goto error;
> +		goto err_release;
>  	}
>  	iommu->cap = dmar_readq(iommu->reg + DMAR_CAP_REG);
>  	iommu->ecap = dmar_readq(iommu->reg + DMAR_ECAP_REG);
> @@ -635,19 +642,26 @@ int alloc_iommu(struct dmar_drhd_unit *drhd)
>  	map_size = max_t(int, ecap_max_iotlb_offset(iommu->ecap),
>  		cap_max_fault_reg_offset(iommu->cap));
>  	map_size = VTD_PAGE_ALIGN(map_size);
> -	if (map_size > VTD_PAGE_SIZE) {
> +	if (map_size > iommu->reg_size) {
>  		iounmap(iommu->reg);
> -		iommu->reg = ioremap(drhd->reg_base_addr, map_size);
> +		release_mem_region(iommu->reg_phys, iommu->reg_size);
> +		iommu->reg_size = map_size;
> +		if (!request_mem_region(iommu->reg_phys, iommu->reg_size, 
> +					iommu->name)) {
> +			printk(KERN_ERR "IOMMU: can't reserve memory\n");
> +			goto error;
> +		}
> +		iommu->reg = ioremap(iommu->reg_phys, iommu->reg_size);
>  		if (!iommu->reg) {
>  			printk(KERN_ERR "IOMMU: can't map the region\n");
> -			goto error;
> +			goto err_release;
>  		}
>  	}
>  
>  	ver = readl(iommu->reg + DMAR_VER_REG);
>  	pr_info("IOMMU %d: reg_base_addr %llx ver %d:%d cap %llx ecap %llx\n",
>  		iommu->seq_id,
> -		(unsigned long long)drhd->reg_base_addr,
> +		(unsigned long long)iommu->reg_phys,
>  		DMAR_VER_MAJOR(ver), DMAR_VER_MINOR(ver),
>  		(unsigned long long)iommu->cap,
>  		(unsigned long long)iommu->ecap);
> @@ -659,6 +673,8 @@ int alloc_iommu(struct dmar_drhd_unit *drhd)
>  
>   err_unmap:
>  	iounmap(iommu->reg);
> + err_release:
> +	release_mem_region(iommu->reg_phys, iommu->reg_size);
>   error:
>  	kfree(iommu);
>  	return -1;
> @@ -671,8 +687,11 @@ void free_iommu(struct intel_iommu *iommu)
>  
>  	free_dmar_iommu(iommu);
>  
> -	if (iommu->reg)
> +	if (iommu->reg) {
>  		iounmap(iommu->reg);
> +		release_mem_region(iommu->reg_phys, iommu->reg_size);
> +	}
> +
>  	kfree(iommu);
>  }
>  
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index e6ca56d..c6d132b 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -308,6 +308,8 @@ enum {
>  
>  struct intel_iommu {
>  	void __iomem	*reg; /* Pointer to hardware regs, virtual addr */
> +	resource_size_t reg_phys;
> +	resource_size_t reg_size;

I'd make these u64
