Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EDC36B11;
	Thu, 22 Aug 2024 03:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295860; cv=none; b=U99GibCk5iWFtjPRdBxszWnkg6/onzLEwSBcp6JatNi9i/hTjkl9Al++nTXu+N08DK4w9G/FBSmxpMbcF93cV0Clr8n7l/Nl1jQf96SHxjqjW2+edKoiiL64/xZbXGQVXQQjxWUCr1lpgV7kWREqD8xfnRTohlYQ2mKKLCw6Y6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295860; c=relaxed/simple;
	bh=lvNhs5V8N/5bFG9RwUsUEn2kFnJ+XtKOVbVwLk/GChI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nR8gBKiXrV2BJoMaIihcbipU+u0HOuwJzgrIGdE7yoJQd6qNNnFzEEGEVJFPdB7EQQR+m8D9uTtaKHk4rXdmTrPRHyyfHs1kLrw30U1/ItBdsJZtUmW127mZC15aXR7yaA0JijDxqvxzvv2zd0jbC5YCiBQjB9t5w+UYGgmUV5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqffCBAO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqffCBAO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724295858; x=1755831858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lvNhs5V8N/5bFG9RwUsUEn2kFnJ+XtKOVbVwLk/GChI=;
  b=OqffCBAOaK4Gu4+BT5qtq19g3AJjI7Z58ADcFOfaKjFpuUqk2qDkrn3a
   wT4MxfQnf4r9y0jMatnRC0J0Ozrz3LW2OQz3+BtkpuhR4beAqsDBwBrEH
   J+Bs3ZHtkXdbQmVU8RcNjwv14hf4AW2rrpJb3MYRef4wphL9EhHR7FIiX
   wQ2jNHJQ5rAG6Fzkxs+MVJSMMg8fgkI4Nn4k0AoyQ2ZcRoi993UQvTVY0
   jzTGN+QRnRhsVH7YTz/ui3wz7znonDflOldSD6scmb5cpoPFWw5xi+Aeu
   MexiUY8pFOKq3E3zqDysQ0BlZD5nB8nxqyBbtFNAEMTWfc0fKFMuOTDAp
   A==;
X-CSE-ConnectionGUID: XhpKGiKfRN6CQFfXbiicfQ==
X-CSE-MsgGUID: oC+0hXBUQi6OZI2unOv27w==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="48084083"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="48084083"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 20:04:17 -0700
X-CSE-ConnectionGUID: 18hlvfugSd6Y8gSOMdYkIg==
X-CSE-MsgGUID: PPNOVJfPSbGi3Ff3iLsAzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="65989588"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 21 Aug 2024 20:04:15 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgy7Q-000CCi-1p;
	Thu, 22 Aug 2024 03:04:12 +0000
Date: Thu, 22 Aug 2024 11:03:47 +0800
From: kernel test robot <lkp@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com, jgg@ziepe.ca,
	yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH 1/5] iommu: Enhance domain allocation code to take
 additional flags
Message-ID: <202408221020.wjaKCVvB-lkp@intel.com>
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
config: i386-randconfig-004-20240822 (https://download.01.org/0day-ci/archive/20240822/202408221020.wjaKCVvB-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240822/202408221020.wjaKCVvB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408221020.wjaKCVvB-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/arm/display/komeda/komeda_dev.c:8:
   include/linux/iommu.h:1103:1: error: declaration of anonymous struct must be a definition
    1103 | struct inline iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
         | ^
   include/linux/iommu.h:1103:1: warning: declaration does not declare anything [-Wmissing-declarations]
   include/linux/iommu.h:1478:48: warning: declaration of 'struct msi_desc' will not be visible outside of this function [-Wvisibility]
    1478 | static inline int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
         |                                                ^
   include/linux/iommu.h:1483:53: warning: declaration of 'struct msi_desc' will not be visible outside of this function [-Wvisibility]
    1483 | static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
         |                                                     ^
>> drivers/gpu/drm/arm/display/komeda/komeda_dev.c:250:16: error: call to undeclared function 'iommu_get_domain_for_dev'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     250 |         mdev->iommu = iommu_get_domain_for_dev(mdev->dev);
         |                       ^
>> drivers/gpu/drm/arm/display/komeda/komeda_dev.c:250:14: error: incompatible integer to pointer conversion assigning to 'struct iommu_domain *' from 'int' [-Wint-conversion]
     250 |         mdev->iommu = iommu_get_domain_for_dev(mdev->dev);
         |                     ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   3 warnings and 3 errors generated.


vim +250 drivers/gpu/drm/arm/display/komeda/komeda_dev.c

b25bc78f8a0750 james qian wang (Arm Technology China  2019-12-10  179) 
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  180) struct komeda_dev *komeda_dev_create(struct device *dev)
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  181) {
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  182) 	struct platform_device *pdev = to_platform_device(dev);
b25bc78f8a0750 james qian wang (Arm Technology China  2019-12-10  183) 	komeda_identify_func komeda_identify;
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  184) 	struct komeda_dev *mdev;
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  185) 	int err = 0;
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  186) 
b25bc78f8a0750 james qian wang (Arm Technology China  2019-12-10  187) 	komeda_identify = of_device_get_match_data(dev);
b25bc78f8a0750 james qian wang (Arm Technology China  2019-12-10  188) 	if (!komeda_identify)
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  189) 		return ERR_PTR(-ENODEV);
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  190) 
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  191) 	mdev = devm_kzalloc(dev, sizeof(*mdev), GFP_KERNEL);
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  192) 	if (!mdev)
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  193) 		return ERR_PTR(-ENOMEM);
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  194) 
20d84aa8417910 james qian wang (Arm Technology China  2019-01-22  195) 	mutex_init(&mdev->lock);
20d84aa8417910 james qian wang (Arm Technology China  2019-01-22  196) 
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  197) 	mdev->dev = dev;
50ec5b563bed04 Markus Elfring                         2019-09-21  198  	mdev->reg_base = devm_platform_ioremap_resource(pdev, 0);
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  199) 	if (IS_ERR(mdev->reg_base)) {
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  200) 		DRM_ERROR("Map register space failed.\n");
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  201) 		err = PTR_ERR(mdev->reg_base);
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  202) 		mdev->reg_base = NULL;
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  203) 		goto err_cleanup;
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  204) 	}
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  205) 
6f84da0c74f12f james qian wang (Arm Technology China  2019-06-05  206) 	mdev->aclk = devm_clk_get(dev, "aclk");
6f84da0c74f12f james qian wang (Arm Technology China  2019-06-05  207) 	if (IS_ERR(mdev->aclk)) {
28be315c9c0c0b james qian wang (Arm Technology China  2019-06-05  208) 		DRM_ERROR("Get engine clk failed.\n");
6f84da0c74f12f james qian wang (Arm Technology China  2019-06-05  209) 		err = PTR_ERR(mdev->aclk);
6f84da0c74f12f james qian wang (Arm Technology China  2019-06-05  210) 		mdev->aclk = NULL;
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  211) 		goto err_cleanup;
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  212) 	}
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  213) 
6f84da0c74f12f james qian wang (Arm Technology China  2019-06-05  214) 	clk_prepare_enable(mdev->aclk);
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  215) 
b25bc78f8a0750 james qian wang (Arm Technology China  2019-12-10  216) 	mdev->funcs = komeda_identify(mdev->reg_base, &mdev->chip);
b25bc78f8a0750 james qian wang (Arm Technology China  2019-12-10  217) 	if (!mdev->funcs) {
b25bc78f8a0750 james qian wang (Arm Technology China  2019-12-10  218) 		DRM_ERROR("Failed to identify the HW.\n");
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  219) 		err = -ENODEV;
2ebb6701654e0d Lowry Li (Arm Technology China         2019-09-23  220) 		goto disable_clk;
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  221) 	}
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  222) 
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  223) 	DRM_INFO("Found ARM Mali-D%x version r%dp%d\n",
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  224) 		 MALIDP_CORE_ID_PRODUCT_ID(mdev->chip.core_id),
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  225) 		 MALIDP_CORE_ID_MAJOR(mdev->chip.core_id),
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  226) 		 MALIDP_CORE_ID_MINOR(mdev->chip.core_id));
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  227) 
981d29d2db7c96 james qian wang (Arm Technology China  2019-01-03  228) 	mdev->funcs->init_format_table(mdev);
981d29d2db7c96 james qian wang (Arm Technology China  2019-01-03  229) 
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  230) 	err = mdev->funcs->enum_resources(mdev);
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  231) 	if (err) {
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  232) 		DRM_ERROR("enumerate display resource failed.\n");
2ebb6701654e0d Lowry Li (Arm Technology China         2019-09-23  233) 		goto disable_clk;
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  234) 	}
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  235) 
29e56aec911dd7 james qian wang (Arm Technology China  2019-01-03  236) 	err = komeda_parse_dt(dev, mdev);
29e56aec911dd7 james qian wang (Arm Technology China  2019-01-03  237) 	if (err) {
29e56aec911dd7 james qian wang (Arm Technology China  2019-01-03  238) 		DRM_ERROR("parse device tree failed.\n");
2ebb6701654e0d Lowry Li (Arm Technology China         2019-09-23  239) 		goto disable_clk;
29e56aec911dd7 james qian wang (Arm Technology China  2019-01-03  240) 	}
29e56aec911dd7 james qian wang (Arm Technology China  2019-01-03  241) 
321e925c5813c2 james qian wang (Arm Technology China  2019-01-22  242) 	err = komeda_assemble_pipelines(mdev);
321e925c5813c2 james qian wang (Arm Technology China  2019-01-22  243) 	if (err) {
321e925c5813c2 james qian wang (Arm Technology China  2019-01-22  244) 		DRM_ERROR("assemble display pipelines failed.\n");
2ebb6701654e0d Lowry Li (Arm Technology China         2019-09-23  245) 		goto disable_clk;
321e925c5813c2 james qian wang (Arm Technology China  2019-01-22  246) 	}
321e925c5813c2 james qian wang (Arm Technology China  2019-01-22  247) 
1c831ade9f352d Robin Murphy                           2020-09-03  248  	dma_set_max_seg_size(dev, U32_MAX);
a260e0b847f079 Lowry Li (Arm Technology China         2019-04-11  249) 
e87cae37f6006f Lowry Li (Arm Technology China         2019-06-06 @250) 	mdev->iommu = iommu_get_domain_for_dev(mdev->dev);
e87cae37f6006f Lowry Li (Arm Technology China         2019-06-06  251) 	if (!mdev->iommu)
e87cae37f6006f Lowry Li (Arm Technology China         2019-06-06  252) 		DRM_INFO("continue without IOMMU support!\n");
e87cae37f6006f Lowry Li (Arm Technology China         2019-06-06  253) 
2ebb6701654e0d Lowry Li (Arm Technology China         2019-09-23  254) 	clk_disable_unprepare(mdev->aclk);
2ebb6701654e0d Lowry Li (Arm Technology China         2019-09-23  255) 
55223394d56bab james qian wang (Arm Technology China  2019-01-22  256) 	err = sysfs_create_group(&dev->kobj, &komeda_sysfs_attr_group);
55223394d56bab james qian wang (Arm Technology China  2019-01-22  257) 	if (err) {
55223394d56bab james qian wang (Arm Technology China  2019-01-22  258) 		DRM_ERROR("create sysfs group failed.\n");
55223394d56bab james qian wang (Arm Technology China  2019-01-22  259) 		goto err_cleanup;
55223394d56bab james qian wang (Arm Technology China  2019-01-22  260) 	}
55223394d56bab james qian wang (Arm Technology China  2019-01-22  261) 
8894cd5824e500 Mihail Atanassov                       2019-11-07  262  	mdev->err_verbosity = KOMEDA_DEV_PRINT_ERR_EVENTS;
8894cd5824e500 Mihail Atanassov                       2019-11-07  263  
7d3cfb70a604d2 james qian wang (Arm Technology China  2019-01-22  264) 	komeda_debugfs_init(mdev);
7d3cfb70a604d2 james qian wang (Arm Technology China  2019-01-22  265) 
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  266) 	return mdev;
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  267) 
2ebb6701654e0d Lowry Li (Arm Technology China         2019-09-23  268) disable_clk:
2ebb6701654e0d Lowry Li (Arm Technology China         2019-09-23  269) 	clk_disable_unprepare(mdev->aclk);
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  270) err_cleanup:
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  271) 	komeda_dev_destroy(mdev);
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  272) 	return ERR_PTR(err);
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  273) }
bd628c1bed7902 james qian wang (Arm Technology China  2019-01-03  274) 

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
