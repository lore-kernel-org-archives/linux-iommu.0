Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A7D263F21;
	Mon, 24 Mar 2025 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833563; cv=none; b=QKkNaH1sHuMS3n7nCipc7Wq+nJ8Re2QSNwZUvcQIJDC3pqERKO+H6q7Pkea7lLrhRCd4H3vL+jaN8949c2DHO88engqExONRWo/c8JldsGDnRHgEXWIRrT8FPCaVZn8gwyU0XFxIcwiH35WZFkOCM8VAtA95nU9xdrkuDOcaOh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833563; c=relaxed/simple;
	bh=yjzLT9sNkYBtQn04PzYXBf8JmpbH0c2Hbzy2z/jNUCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/IE6Tb1k4TNZzvbypy3H3ko0gLbjplu/HayJfxJiBFfqQ+N+HH/IwCmREj/oQz4AFzkgQpD042VHBjGiuLxsR4gTSZw7PSdJmIijE0S8++0hS7wq9E1Vl9tJUJpxoA+Lsw5BBaI5tL2mdINIXGDReDL6kdhSAaWt3jwtLrqc2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kX9GIdTp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kX9GIdTp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31986C4CEDD;
	Mon, 24 Mar 2025 16:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742833562;
	bh=yjzLT9sNkYBtQn04PzYXBf8JmpbH0c2Hbzy2z/jNUCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kX9GIdTpk/+pvShA5TfopygRzam8rq7yeegkk5IfSQxRsV4xaBzcu4WNeMeVE5YhD
	 874tOE5b778POetW+uyDG8R9qnDgLU1yhPQAVYLmk+YIM6+jGZDUs2o5dN9x6A/qqm
	 TOODwgEBomjlP12HMiMHdLvVegp+9jM7/sdBi04sJyEWJ1H0MJZ1jQt8a8VxnLX2YJ
	 Esajf7aXlI1+FmwxTrtZ/3vOXXlTTcUdabvS8iGdyFhXRb9pn+QF2rZRE0pLbG654c
	 1s6RqtR3CuZxWnKxF7mhl8As6u4t7LtpJCDCKNa8NnSoT/kmEToKtqpCeReOSUcjoL
	 +5Kg4xbkacLdA==
Date: Mon, 24 Mar 2025 09:25:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, robin.murphy@arm.com,
	joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iommu: Drop sw_msi from iommu_domain
Message-ID: <20250324162558.GA198799@ax162>
References: <cover.1741294235.git.nicolinc@nvidia.com>
 <6d4b493d20926c8d14e29bc776639cdcf2095146.1741294235.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d4b493d20926c8d14e29bc776639cdcf2095146.1741294235.git.nicolinc@nvidia.com>

Hi Nicolin,

On Thu, Mar 06, 2025 at 01:00:49PM -0800, Nicolin Chen wrote:
> There are only two sw_msi implementations in the entire system, thus it's
> not very necessary to have an sw_msi pointer.
> 
> Instead, check domain->cookie_type to call the two sw_msi implementations
> directly from the core code.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/dma-iommu.h            |  9 +++++++++
>  include/linux/iommu.h                | 15 ---------------
>  drivers/iommu/dma-iommu.c            | 14 ++------------
>  drivers/iommu/iommu.c                | 17 +++++++++++++++--
>  drivers/iommu/iommufd/hw_pagetable.c |  3 ---
>  5 files changed, 26 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
> index 9cca11806e5d..eca201c1f963 100644
> --- a/drivers/iommu/dma-iommu.h
> +++ b/drivers/iommu/dma-iommu.h
> @@ -19,6 +19,9 @@ int iommu_dma_init_fq(struct iommu_domain *domain);
>  
>  void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>  
> +int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> +		     phys_addr_t msi_addr);
> +
>  extern bool iommu_dma_forcedac;
>  
>  #else /* CONFIG_IOMMU_DMA */
> @@ -49,5 +52,11 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
>  {
>  }
>  
> +static inline int iommu_dma_sw_msi(struct iommu_domain *domain,
> +				   struct msi_desc *desc, phys_addr_t msi_addr)
> +{
> +	return -ENODEV;
> +}
> +
>  #endif	/* CONFIG_IOMMU_DMA */
>  #endif	/* __DMA_IOMMU_H */
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 06cc14e9993d..e01c855ae8a7 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -229,11 +229,6 @@ struct iommu_domain {
>  	struct iommu_domain_geometry geometry;
>  	int (*iopf_handler)(struct iopf_group *group);
>  
> -#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> -	int (*sw_msi)(struct iommu_domain *domain, struct msi_desc *desc,
> -		      phys_addr_t msi_addr);
> -#endif
> -
>  	union { /* cookie */
>  		struct iommu_dma_cookie *iova_cookie;
>  		struct iommu_dma_msi_cookie *msi_cookie;
> @@ -254,16 +249,6 @@ struct iommu_domain {
>  	};
>  };
>  
> -static inline void iommu_domain_set_sw_msi(
> -	struct iommu_domain *domain,
> -	int (*sw_msi)(struct iommu_domain *domain, struct msi_desc *desc,
> -		      phys_addr_t msi_addr))
> -{
> -#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> -	domain->sw_msi = sw_msi;
> -#endif
> -}
> -
>  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
>  {
>  	return domain->type & __IOMMU_DOMAIN_DMA_API;
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 31a7b4b81656..2bd9f80a83fe 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -94,9 +94,6 @@ static int __init iommu_dma_forcedac_setup(char *str)
>  }
>  early_param("iommu.forcedac", iommu_dma_forcedac_setup);
>  
> -static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> -			    phys_addr_t msi_addr);
> -
>  /* Number of entries per flush queue */
>  #define IOVA_DEFAULT_FQ_SIZE	256
>  #define IOVA_SINGLE_FQ_SIZE	32768
> @@ -377,7 +374,6 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
>  
>  	mutex_init(&cookie->mutex);
>  	INIT_LIST_HEAD(&cookie->msi_page_list);
> -	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
>  	domain->cookie_type = IOMMU_COOKIE_DMA_IOVA;
>  	domain->iova_cookie = cookie;
>  	return 0;
> @@ -411,7 +407,6 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
>  
>  	cookie->msi_iova = base;
>  	INIT_LIST_HEAD(&cookie->msi_page_list);
> -	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
>  	domain->cookie_type = IOMMU_COOKIE_DMA_MSI;
>  	domain->msi_cookie = cookie;
>  	return 0;
> @@ -427,11 +422,6 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>  	struct iommu_dma_msi_page *msi, *tmp;
>  
> -#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> -	if (domain->sw_msi != iommu_dma_sw_msi)
> -		return;
> -#endif
> -
>  	if (cookie->iovad.granule) {
>  		iommu_dma_free_fq(cookie);
>  		put_iova_domain(&cookie->iovad);
> @@ -1826,8 +1816,8 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>  	return NULL;
>  }
>  
> -static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> -			    phys_addr_t msi_addr)
> +int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> +		     phys_addr_t msi_addr)
>  {
>  	struct device *dev = msi_desc_to_dev(desc);
>  	const struct iommu_dma_msi_page *msi_page;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index c92e47f333cb..0f4cc15ded1c 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -18,6 +18,7 @@
>  #include <linux/errno.h>
>  #include <linux/host1x_context_bus.h>
>  #include <linux/iommu.h>
> +#include <linux/iommufd.h>
>  #include <linux/idr.h>
>  #include <linux/err.h>
>  #include <linux/pci.h>
> @@ -3650,8 +3651,20 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>  		return 0;
>  
>  	mutex_lock(&group->mutex);
> -	if (group->domain && group->domain->sw_msi)
> -		ret = group->domain->sw_msi(group->domain, desc, msi_addr);
> +	if (group->domain) {
> +		switch (group->domain->cookie_type) {
> +		case IOMMU_COOKIE_DMA_MSI:
> +		case IOMMU_COOKIE_DMA_IOVA:
> +			ret = iommu_dma_sw_msi(group->domain, desc, msi_addr);
> +			break;
> +		case IOMMU_COOKIE_IOMMUFD:
> +			ret = iommufd_sw_msi(group->domain, desc, msi_addr);
> +			break;
> +		default:
> +			ret = -EOPNOTSUPP;
> +			break;
> +		}
> +	}
>  	mutex_unlock(&group->mutex);
>  	return ret;
>  }
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index cefe71a4e9e8..f97c4e49d486 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -161,7 +161,6 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>  	}
>  	hwpt->domain->iommufd_hwpt = hwpt;
>  	hwpt->domain->cookie_type = IOMMU_COOKIE_IOMMUFD;
> -	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
>  
>  	/*
>  	 * Set the coherency mode before we do iopt_table_add_domain() as some
> @@ -259,7 +258,6 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
>  	hwpt->domain->owner = ops;
>  	hwpt->domain->iommufd_hwpt = hwpt;
>  	hwpt->domain->cookie_type = IOMMU_COOKIE_IOMMUFD;
> -	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
>  
>  	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
>  		rc = -EINVAL;
> @@ -318,7 +316,6 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
>  	hwpt->domain->iommufd_hwpt = hwpt;
>  	hwpt->domain->owner = viommu->iommu_dev->ops;
>  	hwpt->domain->cookie_type = IOMMU_COOKIE_IOMMUFD;
> -	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
>  
>  	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
>  		rc = -EINVAL;
> -- 
> 2.43.0
> 

I bisected a loss of networking on one of my machines to this change as
commit e009e088d88e ("iommu: Drop sw_msi from iommu_domain") in -next.

With the parent change, I see:

  [  +0.000000] Linux version 6.14.0-rc2-00032-g916a207692ce (nathan@ax162) (aarch64-linux-gcc (GCC) 14.2.0, GNU ld (GNU Binutils) 2.42) #1 SMP PREEMPT_DYNAMIC Mon Mar 24 09:13:34 MST 2025
  ...
  [  +0.002375] fsl_mc_bus NXP0008:00: Adding to iommu group 0
  [  +0.000532] fsl_mc_bus NXP0008:00: MC firmware version: 10.28.1
  [  +0.002566] fsl_mc_dprc dprc.1: DMA mask not set
  [  +0.019213] fsl_mc_dprc dprc.1: Adding to iommu group 1
  [  +0.050801] fsl_mc_allocator dpbp.0: Adding to iommu group 1
  [  +0.006767] fsl_mc_allocator dpmcp.35: Adding to iommu group 1
  ...

At this change, I see:

  [  +0.000000] Linux version 6.14.0-rc2-00033-ge009e088d88e (nathan@ax162) (aarch64-linux-gcc (GCC) 14.2.0, GNU ld (GNU Binutils) 2.42) #1 SMP PREEMPT_DYNAMIC Mon Mar 24 08:57:49 MST 2025
  ...
  [  +0.002355] fsl_mc_bus NXP0008:00: Adding to iommu group 0
  [  +0.000533] fsl_mc_bus NXP0008:00: MC firmware version: 10.28.1
  [  +0.002565] fsl_mc_dprc dprc.1: DMA mask not set
  [  +0.019255] fsl_mc_dprc dprc.1: Adding to iommu group 1
  [  +0.046820] fsl_mc_dprc dprc.1: Failed to allocate IRQs
  [  +0.005798] fsl_mc_dprc dprc.1: fsl_mc_driver_probe failed: -28
  [  +0.005931] fsl_mc_dprc dprc.1: probe with driver fsl_mc_dprc failed with error -28
  ...

I know this is not much to go on initially but I am more than happy to
provide any additional information and test patches as necessary.

Cheers,
Nathan

# bad: [9388ec571cb1adba59d1cded2300eeb11827679c] Add linux-next specific files for 20250321
# good: [b5329d5a35582abbef57562f9fb6cb26a643f252] Merge tag 'vfs-6.14-final.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
git bisect start '9388ec571cb1adba59d1cded2300eeb11827679c' 'b5329d5a35582abbef57562f9fb6cb26a643f252'
# good: [81a405abf1b06a6088197fe1d039ec5dbfd17989] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git
git bisect good 81a405abf1b06a6088197fe1d039ec5dbfd17989
# good: [1afe6ad5ffa395d0809210a3b609751109de3f44] Merge branch 'apparmor-next' of git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor
git bisect good 1afe6ad5ffa395d0809210a3b609751109de3f44
# good: [b97539c1de91aa73b589e145e3c804b9ba5178f2] Merge branch 'driver-core-next' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
git bisect good b97539c1de91aa73b589e145e3c804b9ba5178f2
# good: [db08813487b74820cb40f507fc6ea38994a44776] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux.git
git bisect good db08813487b74820cb40f507fc6ea38994a44776
# good: [8dc029f217de83114fe7a59803ea0ac398db414c] Merge branch 'hyperv-next' of git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
git bisect good 8dc029f217de83114fe7a59803ea0ac398db414c
# good: [33239be7f682bf0ef9293c0b8ad53e691275e3a2] Merge branch 'rust-next' of https://github.com/Rust-for-Linux/linux.git
git bisect good 33239be7f682bf0ef9293c0b8ad53e691275e3a2
# good: [f57f2954197b265b6d793ac89d774aae1473854d] Merge branch 'for-next/kspp' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
git bisect good f57f2954197b265b6d793ac89d774aae1473854d
# good: [acf9f8da5e19fc1cbf26f2ecb749369e13e7cd85] x86/crc: drop the avx10_256 functions and rename avx10_512 to avx512
git bisect good acf9f8da5e19fc1cbf26f2ecb749369e13e7cd85
# good: [da0c56520e880441d0503d0cf0d6853dcfb5f1a4] iommu/arm-smmu-v3: Set MEV bit in nested STE for DoS mitigations
git bisect good da0c56520e880441d0503d0cf0d6853dcfb5f1a4
# bad: [fe0cdd47410f7d5fc26e81c958cde3fe1d57d0a0] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
git bisect bad fe0cdd47410f7d5fc26e81c958cde3fe1d57d0a0
# good: [447c98c1ca4a4b0d43be99f76c558c09956484f3] tools/power turbostat: Add idle governor statistics reporting
git bisect good 447c98c1ca4a4b0d43be99f76c558c09956484f3
# good: [916a207692ce0a6f82ced6b37ca895d5219efb17] iommufd: Move iommufd_sw_msi and related functions to driver.c
git bisect good 916a207692ce0a6f82ced6b37ca895d5219efb17
# bad: [71c4c1a2a057bd800e08b752bac660f5426bf6b5] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git
git bisect bad 71c4c1a2a057bd800e08b752bac660f5426bf6b5
# bad: [e009e088d88e8402539f9595b10c0014125a70c1] iommu: Drop sw_msi from iommu_domain
git bisect bad e009e088d88e8402539f9595b10c0014125a70c1
# first bad commit: [e009e088d88e8402539f9595b10c0014125a70c1] iommu: Drop sw_msi from iommu_domain
