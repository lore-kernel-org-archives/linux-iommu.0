Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7EC291C3D
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 10:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752058311; cv=none; b=FGnXMuFKRSSQ4ETw+E+zEM4Efnez91hHHr1dcLfOyxgIt6AcJE509V4c/8aJnlY378V6nssA2QtVvG6Hp0fQOCxj41/W/coOfUJnO1Zj90kzcRTgWXDP+P+ZB7Ce+5fEKzR+wMyVm28xqeBkcAO78Plw632Z74UVBlDkXFPGhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752058311; c=relaxed/simple;
	bh=6tHK7VmG/sTT6rc1fJyf/ntd/H5qItiTB1SYdutKi8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVsf5jsAR8F60rsIlsrnN2pYnMx0Nky1yItAxDsPZgOYlSRMtIrROCLe+8sH2r6B0Kgjyk4TCjEUFsnr7YRiOEanX75Lfos9KBxSWwbmGVVx+E4npLnp/ZuvGOYbJnDQnRkQPnkCf6wFfBHSj0Bq3LE+7mV/peFpc7s7faW6S6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED311153B
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 03:51:37 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 555063F738
	for <iommu@lists.linux.dev>; Wed,  9 Jul 2025 03:51:49 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:51:47 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Remove unused macro iopte_prot
Message-ID: <aG5JwzypmNwh78oX@e110455-lin.cambridge.arm.com>
References: <20250708211705.1567787-1-danielmentz@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250708211705.1567787-1-danielmentz@google.com>

On Tue, Jul 08, 2025 at 09:17:05PM +0000, Daniel Mentz wrote:
> Commit 33729a5fc0ca ("iommu/io-pgtable-arm: Remove split on unmap
> behavior") removed the last user of the macro iopte_prot. Remove the
> macro definition of iopte_prot as well as three other related
> definitions.
> 
> Fixes: 33729a5fc0ca ("iommu/io-pgtable-arm: Remove split on unmap behavior")
> Signed-off-by: Daniel Mentz <danielmentz@google.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/iommu/io-pgtable-arm.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 96425e92f313..7e8e2216c294 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -85,11 +85,6 @@
>  #define ARM_LPAE_PTE_NS			(((arm_lpae_iopte)1) << 5)
>  #define ARM_LPAE_PTE_VALID		(((arm_lpae_iopte)1) << 0)
>  
> -#define ARM_LPAE_PTE_ATTR_LO_MASK	(((arm_lpae_iopte)0x3ff) << 2)
> -/* Ignore the contiguous bit for block splitting */
> -#define ARM_LPAE_PTE_ATTR_HI_MASK	(ARM_LPAE_PTE_XN | ARM_LPAE_PTE_DBM)
> -#define ARM_LPAE_PTE_ATTR_MASK		(ARM_LPAE_PTE_ATTR_LO_MASK |	\
> -					 ARM_LPAE_PTE_ATTR_HI_MASK)
>  /* Software bit for solving coherency races */
>  #define ARM_LPAE_PTE_SW_SYNC		(((arm_lpae_iopte)1) << 55)
>  
> @@ -155,8 +150,6 @@
>  #define iopte_type(pte)					\
>  	(((pte) >> ARM_LPAE_PTE_TYPE_SHIFT) & ARM_LPAE_PTE_TYPE_MASK)
>  
> -#define iopte_prot(pte)	((pte) & ARM_LPAE_PTE_ATTR_MASK)
> -
>  #define iopte_writeable_dirty(pte)				\
>  	(((pte) & ARM_LPAE_PTE_AP_WR_CLEAN_MASK) == ARM_LPAE_PTE_DBM)
>  
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
