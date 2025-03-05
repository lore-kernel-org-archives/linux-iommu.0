Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E781B2500C6;
	Wed,  5 Mar 2025 15:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187936; cv=none; b=SSgWbLDcPbcuzZgwL2O7auqQOFgMMk+YLgsXhGiKNlbkrtLkmEmCH0zp+NFTJumkv7EBg6zXNCRWjDVQWZd/GVo8dq4ASp139v3CeLLQm03ru0clXmIf6x4ZhcPwuRcMDkyPiiG+/e7AZO8bWdkSupQrbCALWrlWM5IK1gTWeig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187936; c=relaxed/simple;
	bh=fCi4eYnBHmDuJkaUele7hwa8bg9ukcHgMGcXdRZmHaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLTaH8FOyEariFZTDszNFjWEuOwqyx0wFIgO4npB66TYbpkOmhC3/SXwLHWfKyrlSqZPJK4ifJa+sbAzZ/sjg3210syhqgIy3GWNcfQBAi/BLDN5VplcJ4RSsl8+zZfSp7Wua+WPuiG15hYq0I/tBNKhpErt8T/my4uFWKRa0Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kg1m83Ki; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kg1m83Ki"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741187935; x=1772723935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fCi4eYnBHmDuJkaUele7hwa8bg9ukcHgMGcXdRZmHaA=;
  b=Kg1m83KizneA5e8GjVG4cw+mJ9QMBdiHjJHt9UzJTlm6KLSyco6du/rc
   JlVRslXVqqLCOrG8i3HP8etrGzRt5MKV1Ofq17Np1uZJ8UUR3X/cn9UNH
   wbLv01DhUm0lsVn0VCMtzeJrJhzTT+zJmMmrRQRdI1G53gzAXaFnPIfF7
   NtBA5eRxj+dAeiMywsL6wbJ1SM8iAVKDsDD9/jKEJswoarcHCuyHNoW51
   jqJ2so8ll8RPO4UCl7VmDYlqnE0IyBhfMtwFB6L9uH0/nBL6IQwFvs/IR
   t2S/d/REvMI/FVusjI8HN63te8cb1g+JVv7Pl77QyJD37YrqjCNJzhpJP
   A==;
X-CSE-ConnectionGUID: x+y3wsE4QGu29uGoQPX6NA==
X-CSE-MsgGUID: bhsATyTOT9OOkKUtbZKHCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29737367"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="29737367"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 07:18:54 -0800
X-CSE-ConnectionGUID: vC9yvyekSh62wIhLpJelDQ==
X-CSE-MsgGUID: PW3/NR+xSzGz68Qq0wXc/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="123816764"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 05 Mar 2025 07:18:52 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpqWH-000L8c-1u;
	Wed, 05 Mar 2025 15:18:49 +0000
Date: Wed, 5 Mar 2025 23:18:45 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
	kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iommu: Sort out domain user data
Message-ID: <202503052255.t1N6KrAn-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on 5e9f822c9c683ae884fa5e71df41d1647b2876c6]

url:    https://github.com/intel-lab-lkp/linux/commits/Nicolin-Chen/iommu-Sort-out-domain-user-data/20250304-045529
base:   5e9f822c9c683ae884fa5e71df41d1647b2876c6
patch link:    https://lore.kernel.org/r/74a3bf91b52563faaf7ef7de065931e4df47e63f.1741034886.git.nicolinc%40nvidia.com
patch subject: [PATCH v3 1/3] iommu: Sort out domain user data
config: mips-randconfig-r071-20250305 (https://download.01.org/0day-ci/archive/20250305/202503052255.t1N6KrAn-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250305/202503052255.t1N6KrAn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503052255.t1N6KrAn-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iommu/iommu.c:2039:10: error: label at end of compound statement: expected statement
           default:
                   ^
                    ;
   1 error generated.


vim +2039 drivers/iommu/iommu.c

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
> 2039		default:
  2040		}
  2041		if (domain->ops->free)
  2042			domain->ops->free(domain);
  2043	}
  2044	EXPORT_SYMBOL_GPL(iommu_domain_free);
  2045	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
