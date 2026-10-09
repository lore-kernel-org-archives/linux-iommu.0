Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8696F3546D3;
	Fri,  9 Oct 2026 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564188; cv=none; b=XpT2GpmShMbMXcQsBBXAot7ARwM7+Q5+ap8LRvflH7AD8wEDblFDZfBVb0AzFZsoLNJZFYgHacs0aE5ekuyN1wiGngXoKkvzixqepK7P3TIc4kFDERvgZGIUdg1xVljORdXBxy2Uh+X8+xcMd+LSQmf5CzN+JroCARZYda8vmg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564188; c=relaxed/simple;
	bh=HL4dLnQazmu9eond2oaF2ZCcsFOHB8BI0FASnIbUEk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIoJUrnsv7J2BDm3yqBINUftakb1RRt3aPbT+ZePOoG/LA6nDAJXkV6c83DuQoqwGrtRycShuA1xDTQwzEKvkmSIHbm3VZ04l9FfA+P8PDyZs453PSJL/4fhY62gfYsVgdatas7E1Xp5JwASjecKZuu8NIGoDjVgSsEYQvAHh/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drO0Mp0r; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drO0Mp0r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791564186; x=1823100186;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HL4dLnQazmu9eond2oaF2ZCcsFOHB8BI0FASnIbUEk8=;
  b=drO0Mp0rpBtNc6uIThJsJKdGp5RjJ0VNoigfdMonSUgCwFa1UblGbR1k
   G7m3MrFx4sF4Jyf9TMgztRkHUNb9xPFyl+fXrSdxiBVU1cPki0rcqDy3q
   AyQYN3tmpNci8o++Eh0HCkmr5VQzemhw65K5fQq0hrSd3F5tf51GHJX44
   z5t+62BoC7+s9lWimZ3RXyWOXtqchimQiuBA8j/p7nnnB4nj09SMxfhpB
   509s2hldYDR9S/i6dL9i/Dy+0u+kLKDp3ijD2OdUf4yGtz93dKFlkY0rT
   hfQtkSOqRSmlu/zYbTrBBKpLgPwd1RKzysEqWMy0vfqH63t73PgFZVJ5A
   Q==;
X-CSE-ConnectionGUID: v5R9gWcBTe+zOhANKqvSXQ==
X-CSE-MsgGUID: M5FzHXKKS6G3G4AAkNVN5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="259599"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="259599"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 09:43:05 -0700
X-CSE-ConnectionGUID: tUi5YPRHSZWPTE6paRwA/Q==
X-CSE-MsgGUID: QM0uw6PORcuqyvHNUpy+Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="2094648"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa013.fm.intel.com with ESMTP; 09 Oct 2026 09:43:02 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFDgR-0000000061U-0JFK;
	Fri, 09 Oct 2026 16:42:59 +0000
Date: Sat, 10 Oct 2026 00:42:14 +0800
From: kernel test robot <lkp@intel.com>
To: Haotian Zhang <vulab@iscas.ac.cn>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Joerg Roedel <jroedel@suse.de>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/exynos: fix NULL pointer dereference on
 device_link_add() failure
Message-ID: <202610100049.FvaUUeCb-lkp@intel.com>
References: <20261009034539.3073100-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009034539.3073100-1-vulab@iscas.ac.cn>

Hi Haotian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on krzk/for-next]
[also build test WARNING on arm-perf/for-next/perf pinctrl-samsung/for-next linus/master v7.3-rc6 next-20261008]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haotian-Zhang/iommu-exynos-fix-NULL-pointer-dereference-on-device_link_add-failure/20261009-114539
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git for-next
patch link:    https://lore.kernel.org/r/20261009034539.3073100-1-vulab%40iscas.ac.cn
patch subject: [PATCH] iommu/exynos: fix NULL pointer dereference on device_link_add() failure
config: arm-defconfig (https://download.01.org/0day-ci/archive/20261010/202610100049.FvaUUeCb-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 242243a5814307de825db3428662d67b064e2cbc)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261010/202610100049.FvaUUeCb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610100049.FvaUUeCb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/exynos-iommu.c:1434:39: warning: variable 'tmp' is uninitialized when used here [-Wuninitialized]
    1434 |         list_for_each_entry_continue_reverse(tmp, &owner->controllers,
         |                                              ^~~
   drivers/iommu/exynos-iommu.c:1406:35: note: initialize the variable 'tmp' to silence this warning
    1406 |         struct sysmmu_drvdata *data, *tmp;
         |                                          ^
         |                                           = NULL
   1 warning generated.


vim +/tmp +1434 drivers/iommu/exynos-iommu.c

  1402	
  1403	static struct iommu_device *exynos_iommu_probe_device(struct device *dev)
  1404	{
  1405		struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
  1406		struct sysmmu_drvdata *data, *tmp;
  1407	
  1408		if (!has_sysmmu(dev))
  1409			return ERR_PTR(-ENODEV);
  1410	
  1411		list_for_each_entry(data, &owner->controllers, owner_node) {
  1412			/*
  1413			 * SYSMMU will be runtime activated via device link
  1414			 * (dependency) to its master device, so there are no
  1415			 * direct calls to pm_runtime_get/put in this driver.
  1416			 */
  1417			data->link = device_link_add(dev, data->sysmmu,
  1418						     DL_FLAG_STATELESS |
  1419						     DL_FLAG_PM_RUNTIME);
  1420			if (!data->link) {
  1421				dev_err(dev, "Unable to link %s\n",
  1422					dev_name(data->sysmmu));
  1423				goto err_unlink;
  1424			}
  1425		}
  1426	
  1427		/* There is always at least one entry, see exynos_iommu_of_xlate() */
  1428		data = list_first_entry(&owner->controllers,
  1429					struct sysmmu_drvdata, owner_node);
  1430	
  1431		return &data->iommu;
  1432	
  1433	err_unlink:
> 1434		list_for_each_entry_continue_reverse(tmp, &owner->controllers,
  1435						     owner_node)
  1436			device_link_del(tmp->link);
  1437	
  1438		return ERR_PTR(-ENODEV);
  1439	}
  1440	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
