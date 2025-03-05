Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F1C24BC17;
	Wed,  5 Mar 2025 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741196727; cv=none; b=tH9BAwEO3QSdF0Gjxw0cR/YNM76e6oD2QPGQZj7/D5tb65J7WXLlGEjg6Tzwbntzw2P0p4XTK/M8lvNWcOz9FjZCl4RyG2os8C/KkDxX/TdfpGgHJumJeKUspVhvudOOi9SqjM28R890MoSTC6olnFcsJr67BJsd/T11XoH3le0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741196727; c=relaxed/simple;
	bh=XjEOiS/qFvdC8RqvVQX+N3LEfTa/dkn8FPGhmC3N5cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vxu+iBMQNSscgVelz97DaUIuz4iEFML+9vg/dM21hkeZzXsgveTNfz4LBN2eTWgfUFhaVtxoawxxEk53YhzlSaoL4Au5cPT6+mHu04fIv/pt7MaeBFF9bZLLRa36mZjRG8bRU/wg1tWqF3a5jy/eG6IRT+X+PPIaEfOp8AugMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aad0WjM2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aad0WjM2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741196725; x=1772732725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XjEOiS/qFvdC8RqvVQX+N3LEfTa/dkn8FPGhmC3N5cg=;
  b=Aad0WjM2VSQY9GmcL1F3XOKpTF1FI+hH3AuivSzK/DRQyeUhy1FGOd7x
   UKcW+DHO5FnqgQ92z3zfxt/uItdH5oSYMBTUO4hHbihxdoPwtQ2UdCo1+
   jKf/SsCqhqIKkHA4UyKIw55kGc6EeevQyOuhvYQuyrxe5P+pKqhzc1XBb
   wbqOHi3tZ7priehyY4OXuaYmFRDO3LZULqSKJgTjbB3Yax9Wt8RS5saag
   +KS0lZP/8/3bZxNkTjKH6sL44CrwR7xmMptNgC+MQwEyRB+6mykktZmo5
   P1IuVZHk8F37Mi/snvn3LuIIfi7nSygRk27cVGYib1zG2XOc5jH2u7Iq8
   g==;
X-CSE-ConnectionGUID: IAhRHhWCTxK/rGBYEFK5sw==
X-CSE-MsgGUID: ArkIgS4+TxahCGmdAA4bcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42313821"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="42313821"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 09:45:16 -0800
X-CSE-ConnectionGUID: eTHwaUUkQAiiW+OWn98utg==
X-CSE-MsgGUID: tbds7TsvRSqUoqM3Yaunxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; 
   d="scan'208";a="118930553"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 05 Mar 2025 09:45:05 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tpsnk-000LLi-26;
	Wed, 05 Mar 2025 17:45:00 +0000
Date: Thu, 6 Mar 2025 01:44:41 +0800
From: kernel test robot <lkp@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com,
	kevin.tian@intel.com, robin.murphy@arm.com, joro@8bytes.org,
	will@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iommu: Sort out domain user data
Message-ID: <202503060130.fkBIRmys-lkp@intel.com>
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
config: csky-randconfig-r111-20250305 (https://download.01.org/0day-ci/archive/20250306/202503060130.fkBIRmys-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250306/202503060130.fkBIRmys-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503060130.fkBIRmys-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iommu/iommu.c:2040:9: sparse: sparse: statement expected after case label
   drivers/iommu/iommu.c: note: in included file (through include/linux/mutex.h, include/linux/notifier.h, include/linux/clk.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

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
