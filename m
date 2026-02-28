Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF70E15C14F;
	Sat, 28 Feb 2026 00:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772238698; cv=none; b=sqj4teUMd393UojSGsjjgJyGoI5BfXe+vAXLVAHTD/8VgjP/OcdAlegG171WPEAlZBeObmzktUPZSOtmpByb6HSug2gM1STZPYe4uhbh667DQIOlKtNyeMqMU5XcTEEyTbN1m3Ko+CRV9TKRR3sF+HgPVsKlPq0LjJDn9X9r2j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772238698; c=relaxed/simple;
	bh=LD4tFWeuXgAJwTskOHuWBZgdA6OhPsX/uDsTm/dyMfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHP8kLeE5dfrmpdnxT4KO0Dyu4FcNfmhXOPwhhGk5nlsi/FMW2fA7Gzg3hRW/arolfAGMy0efX4nrQAmA8/HkoGlZwQRGDPHZIJNdHV8cRuksFdQvbP9AWS9LSyPCP88rxE+sKQa2IGUcr4+MDJzCTfJ+CA0HOT2tWhfaM3oYIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZinpZUBy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZinpZUBy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772238697; x=1803774697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LD4tFWeuXgAJwTskOHuWBZgdA6OhPsX/uDsTm/dyMfE=;
  b=ZinpZUByv8oSAQoCEQ1KXBHpN34uisWNb6lBp9gQU3KzBZrI+WPY44U3
   W05wrWqwTRmtPDO/TBwWHchmzVgzWMe2R8ibprIx9R38CREOgl5gnPkw4
   lejeJKIOdpWRex4C4At6TCpouAS1Ut/hE86okwlTi+4DUuJ/6rvqClUMK
   FK2uQb+PGvotkow0uChH9liMEKzFMcSOrK4nIgBfiGaU1kW3H2FgKapJa
   QBzmQxP8VcRrm3sRveTCsCDQCie17+nLMOI5bnuj8gpS1DjZrMJJiniSH
   FU4bJLeeJtZs7v8mUITNuWGqwnSfYW4etEyknulGGrsoSaCmTANUh9/IE
   Q==;
X-CSE-ConnectionGUID: Fip0qnXoRuOTE4Ggx2JvzA==
X-CSE-MsgGUID: C8v0aq/GRLmikuH7wpE55Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="76938745"
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="76938745"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 16:31:36 -0800
X-CSE-ConnectionGUID: 7IEm27nSToGjmy+1hT1wrw==
X-CSE-MsgGUID: GkPb8XHrRT2Jg/+/KBY5/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,315,1763452800"; 
   d="scan'208";a="216181047"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 27 Feb 2026 16:31:33 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vw8Ea-00000000BCN-3Vmw;
	Sat, 28 Feb 2026 00:31:10 +0000
Date: Sat, 28 Feb 2026 08:29:47 +0800
From: kernel test robot <lkp@intel.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	skhawaja@google.com, pasha.tatashin@soleen.com,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 08/11] vfio: Enable cdev noiommu mode under iommufd
Message-ID: <202602280846.BaUZcBnS-lkp@intel.com>
References: <20260227175247.26103-9-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227175247.26103-9-jacob.pan@linux.microsoft.com>

Hi Jacob,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.0-rc1 next-20260227]
[cannot apply to awilliam-vfio/next awilliam-vfio/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jacob-Pan/iommufd-Support-a-HWPT-without-an-iommu-driver-for-noiommu/20260228-020145
base:   linus/master
patch link:    https://lore.kernel.org/r/20260227175247.26103-9-jacob.pan%40linux.microsoft.com
patch subject: [PATCH 08/11] vfio: Enable cdev noiommu mode under iommufd
config: i386-buildonly-randconfig-001-20260228 (https://download.01.org/0day-ci/archive/20260228/202602280846.BaUZcBnS-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260228/202602280846.BaUZcBnS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602280846.BaUZcBnS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: iommu_put_pages_list
   >>> referenced by iommu_pt.h:768 (drivers/iommu/generic_pt/fmt/../iommu_pt.h:768)
   >>>               drivers/iommu/generic_pt/fmt/iommu_amdv1.o:(pt_iommu_amdv1_map_pages) in archive vmlinux.a
   >>> referenced by iommu_pt.h:768 (drivers/iommu/generic_pt/fmt/../iommu_pt.h:768)
   >>>               drivers/iommu/generic_pt/fmt/iommu_amdv1.o:(pt_iommu_amdv1_map_pages) in archive vmlinux.a
   >>> referenced by iommu_pt.h:768 (drivers/iommu/generic_pt/fmt/../iommu_pt.h:768)
   >>>               drivers/iommu/generic_pt/fmt/iommu_amdv1.o:(pt_iommu_amdv1_map_pages) in archive vmlinux.a
   >>> referenced 1 more times

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for IOMMU_PT
   Depends on [n]: IOMMU_SUPPORT [=n] && GENERIC_PT [=y]
   Selected by [y]:
   - VFIO_NOIOMMU [=y] && VFIO [=y] && VFIO_GROUP [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
