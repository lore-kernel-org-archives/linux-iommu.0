Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D061632E4;
	Wed,  5 Mar 2025 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187335; cv=none; b=Mp6S9R1wtXz44s01ZdY0Iwy8G/zolfpVjmWXlRykGryUXWIPit3ScVCII/JHXjspUPhg6U8w0gG+16i8iNKyj2hBvJgH/yCnKkCL0gL4tOeuYlO9Gp/3e6D02XtY5uv62RUPABQcEjx7cmkyMDa6ZyxLv6xxtcWtVhokIUeC/y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187335; c=relaxed/simple;
	bh=P97unTsYBrzFpLCQPC7HD7BnygqZcNRa+0uClEv2C7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tarVl5Cl7cFgfcK2WOowAukOS7+ZCLjPgC77HXS2k1KyKK5YAXHA0PU+6FW9898kUEla8jlgtF+adSnnCmaL7HSFlLzgiiY5JlnSWaxqgbVKg/YH2jnGVTzO+7ChdTijDVvhuZPg3ziap3VpFHB0mqIQBZYUC9zzO6nNoka4P1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cN0KULXL; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cN0KULXL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741187334; x=1772723334;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P97unTsYBrzFpLCQPC7HD7BnygqZcNRa+0uClEv2C7I=;
  b=cN0KULXLctFxXjNCyHkpoEfFMsiwkIP2l35xk3wVJjwJKF91FlRtrnYC
   wVGVK5gfStfQreO1RYLA1spc1i9UPPBrTkPy0MXRLnGFhwTixDR8Nv+4Q
   iCgnKc3dcztSyce/I24n32czcpN8DmdGXsNoOnmoRITc83v+0GpdZ7dGz
   TfLQl6QgC+l8WZm7mrTrpIehERRjSI04aEEPkDq3L/IrjE71Bc8Ikhjzf
   x1Il0eMwz0rkHDn9AEn4Nq5kiuAU8JjjqxmnPX2XaSEsqnaFkUBWowMl5
   Iq09J3Lj6c1z4obABvBtcAPXSUDD9beC42Ng5zvFrpTf97dKgXWES2fIC
   g==;
X-CSE-ConnectionGUID: 3fOkDaUDROCufSvlEgGwxg==
X-CSE-MsgGUID: uDtbOFO7QpGAwqh8HXhQ0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52797057"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="52797057"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:08:53 -0800
X-CSE-ConnectionGUID: ZCoGvxanS6ecmauRis3jOQ==
X-CSE-MsgGUID: 9MxfVJqSTHK6Bz0QnCuqbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="118732078"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 05 Mar 2025 07:08:49 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpqMa-000L7o-1i;
	Wed, 05 Mar 2025 15:08:48 +0000
Date: Wed, 5 Mar 2025 23:08:21 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
	kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iommu: Sort out domain user data
Message-ID: <202503052232.H3gZRJRp-lkp@intel.com>
References: <74a3bf91b52563faaf7ef7de065931e4df47e63f.1741034886.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74a3bf91b52563faaf7ef7de065931e4df47e63f.1741034886.git.nicolinc@nvidia.com>

Hi Nicolin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5e9f822c9c683ae884fa5e71df41d1647b2876c6]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolin-Chen/iommu-Sort-out-domain-user-data/20250304-045529
base:   5e9f822c9c683ae884fa5e71df41d1647b2876c6
patch link:    https://lore.kernel.org/r/74a3bf91b52563faaf7ef7de065931e4df47e63f.1741034886.git.nicolinc%40nvidia.com
patch subject: [PATCH v3 1/3] iommu: Sort out domain user data
config: hexagon-randconfig-002-20250305 (https://download.01.org/0day-ci/archive/20250305/202503052232.H3gZRJRp-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250305/202503052232.H3gZRJRp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503052232.H3gZRJRp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/iommu.c:2040:2: warning: label at end of compound statement is a C23 extension [-Wc23-extensions]
    2040 |         }
         |         ^
   1 warning generated.


vim +2040 drivers/iommu/iommu.c

  2026	
  2027	void iommu_domain_free(struct iommu_domain *domain)
  2028	{
  2029		switch (domain->cookie_type) {
  2030		case IOMMU_COOKIE_DMA_IOVA:
  2031			iommu_put_dma_cookie(domain);
  2032			break;
  2033		case IOMMU_COOKIE_DMA_MSI:
  2034			iommu_put_msi_cookie(domain);
  2035			break;
  2036		case IOMMU_COOKIE_SVA:
  2037			mmdrop(domain->mm);
  2038			break;
  2039		default:
> 2040		}
  2041		if (domain->ops->free)
  2042			domain->ops->free(domain);
  2043	}
  2044	EXPORT_SYMBOL_GPL(iommu_domain_free);
  2045	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
