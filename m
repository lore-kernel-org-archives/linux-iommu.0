Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4E72E92D1;
	Mon,  8 Dec 2025 15:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209039; cv=none; b=MI+Hy0Fkv0/hRjsala8iq0fXdexHxKt5Mzc2M0TrC9Ervd9GIMQFpWq1T0d45ZywyJuJqw4FGHN1fS+HMealuMrV8h8agUz9O7IV1JUSrUYG954U1dRRmxMbwhqmPJjHBQuqaKL4HruvPRuUhfNyoiwHNrbXMPlDSTQEgwyWl+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209039; c=relaxed/simple;
	bh=nCmBMCTdqKuF6orCzN9rcW3rZjzQU3+wHJUFmK8AJXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSl+ZA0477eUyiBjC3H1B61XKQEcGIkuSUVH8sHS0ZdWl+syrmtn8dmXfFJX6cLHnNatTCa6sPxcTGVcvZgYoeN06KaNcESjrMixt/d8OkdFohW+1OY8P5pnoxllBuLIO2Eo5oXbyoczffjrL09W4WWF0fcEy29iFUuYwtUnBCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c3EIRwG0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c3EIRwG0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765209037; x=1796745037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nCmBMCTdqKuF6orCzN9rcW3rZjzQU3+wHJUFmK8AJXw=;
  b=c3EIRwG0cCx3liWwlVyNi/wBnR9j6cVqbxpWR290IYYTiW3JP0d1bFCq
   m/NltKj98EebnOEfhtaxCCWzOA2ayf3MA4dQEzGNzZO1GGJB7PY4cRZVb
   6GszGRuMkPQplTNq3bkZ7k2g5y3t+zG0/AU9jN17T/G4EhGr8IJXRUpbo
   +AGJzYpKdbVoGiOGEV4a81ChNpRUauFAGW6VjUEcgI/1rWUod6ATeAoSV
   3vbe/hMzE+aR6qQFMLgWUJLNwwBlBGZ6uIoWq2cPHGrZAC4gT2w2jsCw3
   P8pybDmox1EZJFeJQO3HBqpTIoXFjFkcAuyLqFDPYEF19EaAwRqp4kMOW
   g==;
X-CSE-ConnectionGUID: YvgQOxnQT5WbduGDSUkmJQ==
X-CSE-MsgGUID: EoHHYaUpS9ensYVYG5mwjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="71005052"
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="71005052"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 07:50:37 -0800
X-CSE-ConnectionGUID: 4Q8AgonESGmtXU2ILNqkiQ==
X-CSE-MsgGUID: IG7JkONMRTC8bVJiJVVH0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="195025726"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 08 Dec 2025 07:50:36 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vSdVQ-000000000Wr-2mDX;
	Mon, 08 Dec 2025 15:50:32 +0000
Date: Mon, 8 Dec 2025 23:50:06 +0800
From: kernel test robot <lkp@intel.com>
To: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: oe-kbuild-all@lists.linux.dev, joro@8bytes.org, yi.l.liu@intel.com,
	iommu@lists.linux.dev, jgg@nvidia.com
Subject: Re: [PATCH] iommu/vt-d: Flush piotlb for SVM and Nested domain
Message-ID: <202512082342.IdZjYepb-lkp@intel.com>
References: <20251208091907.74719-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208091907.74719-1-yi.l.liu@intel.com>

Hi Yi,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.18 next-20251208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yi-Liu/iommu-vt-d-Flush-piotlb-for-SVM-and-Nested-domain/20251208-172359
base:   linus/master
patch link:    https://lore.kernel.org/r/20251208091907.74719-1-yi.l.liu%40intel.com
patch subject: [PATCH] iommu/vt-d: Flush piotlb for SVM and Nested domain
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20251208/202512082342.IdZjYepb-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251208/202512082342.IdZjYepb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512082342.IdZjYepb-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `dmar_domain_attach_device':
>> iommu.c:(.text+0x70aa38): undefined reference to `intel_svm_domain_ops'
   ld: vmlinux.o: in function `paging_domain_compatible':
>> (.text+0x70ab8f): undefined reference to `intel_svm_domain_ops'
   ld: vmlinux.o: in function `intel_iommu_set_dev_pasid':
   iommu.c:(.text+0x70b487): undefined reference to `intel_svm_domain_ops'
   ld: vmlinux.o: in function `cache_tag_flush_iotlb':
>> cache.c:(.text+0x70e74a): undefined reference to `intel_svm_domain_ops'
   ld: vmlinux.o: in function `cache_tag_flush_range_np':
   (.text+0x70f2d3): undefined reference to `intel_svm_domain_ops'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
