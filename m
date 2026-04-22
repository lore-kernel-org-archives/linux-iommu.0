Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88F2371048
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776848595; cv=none; b=OfeuefQWJk3ejvlfk3VwI4BCfX2IyBW5wkZbPDJYUZrZbGY+jassx+ymBWCirzybDzfPaTxoZ1H2ydYBuNpn0HucbJxvB3Nw8hlDWpbT58M5hJ1WDbFNU95Z/LiI+MDi/lYQ4huidCuz2VRd8+3rkLLj71a1vJxZmGhzAIpAnms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776848595; c=relaxed/simple;
	bh=xP+zsW7GuZ9O9hYcEHASdfz/vCcClZkt+ww52NoIyfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1CanmMrgXIEk2ivIkWqjhQZpodzkAK7azdZxegGXBBmfFCpBHf2hSHVqWukVIYKt3J5WvSSBqFcasPewDUTSsA8PYAgHaVxeIn3h5QfJmv9tpDdtOzmzMC9JcNK1UnJlu6RWJY12bLym1O5BEOtASBmSzbgtmMZAEe7uzuekqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=I7hVS9R1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="I7hVS9R1"
Received: from localhost (unknown [167.220.233.210])
	by linux.microsoft.com (Postfix) with ESMTPSA id A4A4920B710C;
	Wed, 22 Apr 2026 02:03:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A4A4920B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776848592;
	bh=O39Wyth5HqAqOJ/yMI3N3ejsjyRa139VNPSNcY5LlXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I7hVS9R1zEBtX+0uK4U11TvLARI5Q0YGoMOjQ7FutjStviymD/MB+kepMGtadVAjr
	 NSHp33lQwYiGp8MYRojXEY6QKWtO8qRhUzUvgwzd64L3AmuKntSeSmOe4s4hp4wYsU
	 Z6PLGFs/gKsZ6LorglZPEEnCfzF/vJDGGYrob2Vg=
Date: Wed, 22 Apr 2026 17:03:09 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
	jon.grimm@amd.com, vasant.hegde@amd.com, frank.gorishek@amd.com, 
	thomas.lendacky@amd.com, santosh.shukla@amd.com, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH 1/4] iommu/amd: Drop unused global exclusion range fields
 and init
Message-ID: <fj6hhycko3nsxq7w3oj7mbnsa4ttmd5c7xcnjkcqmv4qyrednr@qbsiizpo4dma>
References: <20260420170033.6780-1-suravee.suthikulpanit@amd.com>
 <20260420170033.6780-2-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420170033.6780-2-suravee.suthikulpanit@amd.com>

This patch overlaps with mine [1], which was sent on March 31st with
you on Cc. Jacob has reviewed it.

While I was still waiting on your comments, I realized your series
goes beyond the dead code removal. So I believe I do not need to follow
up on mine.

[1] https://lore.kernel.org/all/20260331152550.479841-1-zhangyu1@linux.microsoft.com/

Thanks,
Yu


On Mon, Apr 20, 2026 at 05:00:30PM +0000, Suravee Suthikulpanit wrote:
> Remove unused struct amd_iommu.exclusion_start/exclusion_length, the
> MMIO_EXCL_* flag masks, and iommu_set_exclusion_range(). These struct
> amd_iommu fields were never assigned, so early_enable_iommu() never
> programmed the hardware exclusion registers through this path.
> 
> Please note that the exclusion range registers have been repurposed
> to SNP completion-wait store base / limit registers. So, rename
> MMIO_EXCL_BASE/LIMIT via to MMIO_COMPL_STORE_BASE/LIMIT instead.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 13 ++-----------
>  drivers/iommu/amd/init.c            | 29 +++--------------------------
>  2 files changed, 5 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index c685d3771436..c4ea701b7cab 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -50,17 +50,13 @@
>  #define MMIO_GET_BUS(x) (((x) & MMIO_RANGE_BUS_MASK) >> MMIO_RANGE_BUS_SHIFT)
>  #define MMIO_MSI_NUM(x)	((x) & 0x1f)
>  
> -/* Flag masks for the AMD IOMMU exclusion range */
> -#define MMIO_EXCL_ENABLE_MASK 0x01ULL
> -#define MMIO_EXCL_ALLOW_MASK  0x02ULL
> -
>  /* Used offsets into the MMIO space */
>  #define MMIO_DEV_TABLE_OFFSET   0x0000
>  #define MMIO_CMD_BUF_OFFSET     0x0008
>  #define MMIO_EVT_BUF_OFFSET     0x0010
>  #define MMIO_CONTROL_OFFSET     0x0018
> -#define MMIO_EXCL_BASE_OFFSET   0x0020
> -#define MMIO_EXCL_LIMIT_OFFSET  0x0028
> +#define MMIO_COMPL_STORE_BASE_OFFSET   0x0020
> +#define MMIO_COMPL_STORE_LIMIT_OFFSET  0x0028
>  #define MMIO_EXT_FEATURES	0x0030
>  #define MMIO_PPR_LOG_OFFSET	0x0038
>  #define MMIO_GA_LOG_BASE_OFFSET	0x00e0
> @@ -680,11 +676,6 @@ struct amd_iommu {
>  	/* pci domain of this IOMMU */
>  	struct amd_iommu_pci_seg *pci_seg;
>  
> -	/* start of exclusion range of that IOMMU */
> -	u64 exclusion_start;
> -	/* length of exclusion range of that IOMMU */
> -	u64 exclusion_length;
> -
>  	/* command buffer virtual address */
>  	u8 *cmd_buf;
>  	u32 cmd_buf_head;
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index f3fd7f39efb4..866249d3673e 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -352,28 +352,6 @@ static void iommu_write_l2(struct amd_iommu *iommu, u8 address, u32 val)
>   *
>   ****************************************************************************/
>  
> -/*
> - * This function set the exclusion range in the IOMMU. DMA accesses to the
> - * exclusion range are passed through untranslated
> - */
> -static void iommu_set_exclusion_range(struct amd_iommu *iommu)
> -{
> -	u64 start = iommu->exclusion_start & PAGE_MASK;
> -	u64 limit = (start + iommu->exclusion_length - 1) & PAGE_MASK;
> -	u64 entry;
> -
> -	if (!iommu->exclusion_start)
> -		return;
> -
> -	entry = start | MMIO_EXCL_ENABLE_MASK;
> -	memcpy_toio(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET,
> -			&entry, sizeof(entry));
> -
> -	entry = limit;
> -	memcpy_toio(iommu->mmio_base + MMIO_EXCL_LIMIT_OFFSET,
> -			&entry, sizeof(entry));
> -}
> -
>  static void iommu_set_cwwb_range(struct amd_iommu *iommu)
>  {
>  	u64 start = iommu_virt_to_phys((void *)iommu->cmd_sem);
> @@ -386,14 +364,14 @@ static void iommu_set_cwwb_range(struct amd_iommu *iommu)
>  	 * Re-purpose Exclusion base/limit registers for Completion wait
>  	 * write-back base/limit.
>  	 */
> -	memcpy_toio(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET,
> +	memcpy_toio(iommu->mmio_base + MMIO_COMPL_STORE_BASE_OFFSET,
>  		    &entry, sizeof(entry));
>  
>  	/* Note:
>  	 * Default to 4 Kbytes, which can be specified by setting base
>  	 * address equal to the limit address.
>  	 */
> -	memcpy_toio(iommu->mmio_base + MMIO_EXCL_LIMIT_OFFSET,
> +	memcpy_toio(iommu->mmio_base + MMIO_COMPL_STORE_LIMIT_OFFSET,
>  		    &entry, sizeof(entry));
>  }
>  
> @@ -1013,7 +991,7 @@ static int __init remap_or_alloc_cwwb_sem(struct amd_iommu *iommu)
>  		 * completion wait buffer (CWB) address. Read and re-use it.
>  		 */
>  		pr_info_once("Re-using CWB buffers from the previous kernel\n");
> -		paddr = readq(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET) & PM_ADDR_MASK;
> +		paddr = readq(iommu->mmio_base + MMIO_COMPL_STORE_BASE_OFFSET) & PM_ADDR_MASK;
>  		iommu->cmd_sem = iommu_memremap(paddr, PAGE_SIZE);
>  		if (!iommu->cmd_sem)
>  			return -ENOMEM;
> @@ -2891,7 +2869,6 @@ static void early_enable_iommu(struct amd_iommu *iommu)
>  	iommu_set_device_table(iommu);
>  	iommu_enable_command_buffer(iommu);
>  	iommu_enable_event_buffer(iommu);
> -	iommu_set_exclusion_range(iommu);
>  	iommu_enable_gt(iommu);
>  	iommu_enable_ga(iommu);
>  	iommu_enable_xt(iommu);
> -- 
> 2.34.1
> 
