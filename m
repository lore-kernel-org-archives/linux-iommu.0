Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253C134A8;
	Thu, 22 Aug 2024 02:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724292679; cv=none; b=OLGJdaWcVZfexHjvjGQ0dI4wM00FYNw46yVQ2Du1+CAPN5R8O5EM6S573+L0K8rg+keJmN4wPpBSZ6sznHMXZ4vXhWEs0OhJVjvzQuuq+IayI+btApltiQvMwsFBArn+AITeNfQW0Nf+RjkTk1citc05FX8wQij8fvpR3DVujNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724292679; c=relaxed/simple;
	bh=7tI+a9J6WKLcjG3lt9eZdPuNH9ibyraMNMaMzs1ZhLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1I8kM4AYYgrCsnaRSYSwA4hkacd4qFheAj9HkSURobH45Gs0V5CDpjqru0PuftafkGoetFnNiH4Z07bWBiKzcGBog5XzOUc1YCMEQhx0D4nbVdowkjGKp7dhABQIAUp9LRs35O0lER0B54gv5oxc6EDi6+pe2ifACmuchfZSVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nCcBPb3K; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nCcBPb3K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724292677; x=1755828677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7tI+a9J6WKLcjG3lt9eZdPuNH9ibyraMNMaMzs1ZhLo=;
  b=nCcBPb3KZrKu+BwVsFbwGvXQ9NUcPAIPvK8fs5HYiZZTnulRgVRAbeEu
   /rZzrBN5v1ajARfT8uxrIFfoU6qbuTcA88x6A57KDkLPQ3MibzdK7kQm3
   +0zQdroTPG3SGbHvUjPRgUdTRFCqdg+HYgJhtZ3mUGO/ZVxyBMWeuvnIN
   yKEiKc8/j9gaYf3L0d+3ViXJNk97B0VdFNZGSZG/C/5Ow7ycppeZqIIjI
   Zm2YGb2CIDHLuo6zbp5JHpPSnFwGZHbggdIYKwOD7jWX6hCXsmSPGuTZW
   ejRs0GOScMxE7g7Ji40/cSzSqfsvLyT+N2L4X24MwGEVHMCv+BXML7upj
   g==;
X-CSE-ConnectionGUID: F4bI6NmmRQmWE4q5JPKvyg==
X-CSE-MsgGUID: 328PemzoS8eHYnINRfvE1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22567158"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="22567158"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 19:11:16 -0700
X-CSE-ConnectionGUID: 7wvPVKSTShyRHIY/GYiB3g==
X-CSE-MsgGUID: UGyYoflzTgaC9C3Pf/klbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="92028655"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 21 Aug 2024 19:11:13 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgxI6-000CAI-1z;
	Thu, 22 Aug 2024 02:11:10 +0000
Date: Thu, 22 Aug 2024 10:10:50 +0800
From: kernel test robot <lkp@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com, jgg@ziepe.ca,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
Message-ID: <202408220940.YjSy3Avg-lkp@intel.com>
References: <20240821133554.7405-2-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821133554.7405-2-vasant.hegde@amd.com>

Hi Vasant,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11-rc4 next-20240821]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vasant-Hegde/iommu-Enhance-domain-allocation-code-to-take-additional-flags/20240821-214124
base:   linus/master
patch link:    https://lore.kernel.org/r/20240821133554.7405-2-vasant.hegde%40amd.com
patch subject: [PATCH 1/5] iommu: Enhance domain allocation code to take additional flags
config: arm-footbridge_defconfig (https://download.01.org/0day-ci/archive/20240822/202408220940.YjSy3Avg-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 26670e7fa4f032a019d23d56c6a02926e854e8af)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240822/202408220940.YjSy3Avg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408220940.YjSy3Avg-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/pci/pci-driver.c:7:
   In file included from include/linux/pci.h:1646:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from drivers/pci/pci-driver.c:23:
   include/linux/iommu.h:1103:1: error: declaration of anonymous struct must be a definition
    1103 | struct inline iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
         | ^
   include/linux/iommu.h:1103:1: warning: declaration does not declare anything [-Wmissing-declarations]
>> drivers/pci/pci-driver.c:1657:9: error: call to undeclared function 'iommu_device_use_default_domain'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1657 |                 ret = iommu_device_use_default_domain(dev);
         |                       ^
>> drivers/pci/pci-driver.c:1670:3: error: call to undeclared function 'iommu_device_unuse_default_domain'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1670 |                 iommu_device_unuse_default_domain(dev);
         |                 ^
   2 warnings and 3 errors generated.


vim +/iommu_device_use_default_domain +1657 drivers/pci/pci-driver.c

02e0bea6c83c657 Phil Sutter       2017-01-18  1629  
07397df29e57cde Nipun Gupta       2018-04-28  1630  /**
07397df29e57cde Nipun Gupta       2018-04-28  1631   * pci_dma_configure - Setup DMA configuration
07397df29e57cde Nipun Gupta       2018-04-28  1632   * @dev: ptr to dev structure
07397df29e57cde Nipun Gupta       2018-04-28  1633   *
07397df29e57cde Nipun Gupta       2018-04-28  1634   * Function to update PCI devices's DMA configuration using the same
07397df29e57cde Nipun Gupta       2018-04-28  1635   * info from the OF node or ACPI node of host bridge's parent (if any).
07397df29e57cde Nipun Gupta       2018-04-28  1636   */
07397df29e57cde Nipun Gupta       2018-04-28  1637  static int pci_dma_configure(struct device *dev)
07397df29e57cde Nipun Gupta       2018-04-28  1638  {
512881eacfa72c2 Lu Baolu          2022-04-18  1639  	struct pci_driver *driver = to_pci_driver(dev->driver);
07397df29e57cde Nipun Gupta       2018-04-28  1640  	struct device *bridge;
07397df29e57cde Nipun Gupta       2018-04-28  1641  	int ret = 0;
07397df29e57cde Nipun Gupta       2018-04-28  1642  
07397df29e57cde Nipun Gupta       2018-04-28  1643  	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
07397df29e57cde Nipun Gupta       2018-04-28  1644  
07397df29e57cde Nipun Gupta       2018-04-28  1645  	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
07397df29e57cde Nipun Gupta       2018-04-28  1646  	    bridge->parent->of_node) {
3d6ce86ee79465e Christoph Hellwig 2018-05-03  1647  		ret = of_dma_configure(dev, bridge->parent->of_node, true);
07397df29e57cde Nipun Gupta       2018-04-28  1648  	} else if (has_acpi_companion(bridge)) {
07397df29e57cde Nipun Gupta       2018-04-28  1649  		struct acpi_device *adev = to_acpi_device_node(bridge->fwnode);
07397df29e57cde Nipun Gupta       2018-04-28  1650  
e5361ca29f2fea3 Robin Murphy      2018-12-06  1651  		ret = acpi_dma_configure(dev, acpi_get_dma_attr(adev));
07397df29e57cde Nipun Gupta       2018-04-28  1652  	}
07397df29e57cde Nipun Gupta       2018-04-28  1653  
07397df29e57cde Nipun Gupta       2018-04-28  1654  	pci_put_host_bridge_device(bridge);
512881eacfa72c2 Lu Baolu          2022-04-18  1655  
512881eacfa72c2 Lu Baolu          2022-04-18  1656  	if (!ret && !driver->driver_managed_dma) {
512881eacfa72c2 Lu Baolu          2022-04-18 @1657  		ret = iommu_device_use_default_domain(dev);
512881eacfa72c2 Lu Baolu          2022-04-18  1658  		if (ret)
512881eacfa72c2 Lu Baolu          2022-04-18  1659  			arch_teardown_dma_ops(dev);
512881eacfa72c2 Lu Baolu          2022-04-18  1660  	}
512881eacfa72c2 Lu Baolu          2022-04-18  1661  
07397df29e57cde Nipun Gupta       2018-04-28  1662  	return ret;
07397df29e57cde Nipun Gupta       2018-04-28  1663  }
07397df29e57cde Nipun Gupta       2018-04-28  1664  
512881eacfa72c2 Lu Baolu          2022-04-18  1665  static void pci_dma_cleanup(struct device *dev)
512881eacfa72c2 Lu Baolu          2022-04-18  1666  {
512881eacfa72c2 Lu Baolu          2022-04-18  1667  	struct pci_driver *driver = to_pci_driver(dev->driver);
512881eacfa72c2 Lu Baolu          2022-04-18  1668  
512881eacfa72c2 Lu Baolu          2022-04-18  1669  	if (!driver->driver_managed_dma)
512881eacfa72c2 Lu Baolu          2022-04-18 @1670  		iommu_device_unuse_default_domain(dev);
512881eacfa72c2 Lu Baolu          2022-04-18  1671  }
512881eacfa72c2 Lu Baolu          2022-04-18  1672  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
