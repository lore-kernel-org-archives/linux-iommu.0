Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE60719D897;
	Wed,  5 Mar 2025 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741193546; cv=none; b=J3tmBJuC2Dh99Ia0CcSIMr90QDgftKtnuTy9i1NEs1C5cRhBe0FrW4BSGUrLEm5PzBG5dQZncGfkuL4DKl0H/77SQ8Ds1D5Nth6Xm7ZuHUhBN/qaAYbjbrrMydjNwFP8Ue07Sxs7VjNID8LohDCJ8XlRqgIZMQcYpfegwS48iMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741193546; c=relaxed/simple;
	bh=oNLRiyEoV4xCj83UWo/dahMiQbq+mZnndaBBd9xY8vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcPl72CvIsw4WD/wKbOMGlCrqlVeDwB/X7YQ1JcSWj7143Bud4YEI/cAvBcUo76pHhZMtyAHYDec3oDNbbYQMuScpau6n3+ERIZcMGd12nNMTy7F9Pg47EUaPN31pBxNMIujd29P3RRzOHlXHmFW8BeepOW+cl3gIdhdSlnqGzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZTHYZm7J; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZTHYZm7J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741193545; x=1772729545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oNLRiyEoV4xCj83UWo/dahMiQbq+mZnndaBBd9xY8vs=;
  b=ZTHYZm7JivdnEjPCzgl5JmSZH9gjvDDmJ9IRg9Qo6iJgzQjPO4GtJtCN
   XtG9T9dbK8kkX3B7b71fxv1ICalK0LntPpNo7q6FuhdI9YpJBBWCeebgF
   0ovcoANCKKYgTudPINuiP6KwtX4d1PpzM4pYuUm+XEZV5a/ojIfFQW/bQ
   EM9t+A93VYnkOvlmB6f1E58o3IqhEK9g3arUsuK+nVpLzGvlJwgcLp4Ih
   OaDz5O/IX7eI2+Ps1zrCMVT+o2PRd/ULaGpW7VF/0wRU0w/LSwlmkb2so
   4pH9Zo6Xm73Z8vlrR8pXaVpEqBkuzzrUpXVOaglV6RCzebUGSQsuvnMyj
   A==;
X-CSE-ConnectionGUID: oj++AUU/QLO7rbj2oGPELw==
X-CSE-MsgGUID: FOZxwVTqRYGRU4N7/EDZTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52812578"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="52812578"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 08:52:14 -0800
X-CSE-ConnectionGUID: Plc3JRZMRO+T+qlp9sSgsw==
X-CSE-MsgGUID: RK2WnX4WTa6bKnxRGbiL4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149683033"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 05 Mar 2025 08:52:11 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpryb-000LG6-0I;
	Wed, 05 Mar 2025 16:52:09 +0000
Date: Thu, 6 Mar 2025 00:51:18 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
	kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iommu: Sort out domain user data
Message-ID: <202503060014.ddw19ThY-lkp@intel.com>
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
config: powerpc-randconfig-001-20250305 (https://download.01.org/0day-ci/archive/20250306/202503060014.ddw19ThY-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250306/202503060014.ddw19ThY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503060014.ddw19ThY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/iommu.c:2040:2: warning: label at end of compound statement is a C2x extension [-Wc2x-extensions]
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
