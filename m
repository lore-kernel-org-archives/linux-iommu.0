Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373E215C126;
	Sat,  7 Sep 2024 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725716270; cv=none; b=MlF2LobqUw9Spoy43+YByWtyr6bQ1PsqSawwIsO9nj7WnAac2OFFPdQJB/Yussq5Oy5hmL4F3Jmr8tVa9BT/DZE8+0TIenvf/xzJau9aBbSW/jXUpnyJjBTwid/QXknNpPhB9j3GD5cRY1TNplGw9ostiO6kz6TKNhsD4HoUPQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725716270; c=relaxed/simple;
	bh=xtrkjOHGGevMlNpIsMiOVof/a2y3wxes9ScvEXZzsx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6W0r+CPJ3CpmurTr02vhgg6XA+5laLfiOPEwOvUytLe3USQWirkNgO0A8Vh+E0QD/avnW35a4JOTY1cTEmn65nB232YYF8hqupQmjfk7eaZF97NuefuJ72nJAncJ7OiHeC+UHIY/tyLMQkxuDfOoXRD5XPhW1ZSzHAiNkNW0W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ly94zhzW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ly94zhzW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725716267; x=1757252267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xtrkjOHGGevMlNpIsMiOVof/a2y3wxes9ScvEXZzsx8=;
  b=ly94zhzWU7KISHcTYeRK0s0d34NZLRVAUnP3rNxB6OwquceQFjZHOHV4
   EnWpHK7K8fzhS4PAheyQHc2rpvnE8O3mKdRd8cPfhxUISIdvPad4aoYd2
   9/63Zsw+yu+WrxahSH9lTapjJsMz2U92hhMlt9rR0rzVfiaUnk/ueSCxb
   XnemUdiF7o2cR8Ut7y13NHYP4yC+nJ0b8a/yf+JZFSotaX3oSLIVd77sU
   TEqyjvUViT2OT++f2UBBybb3dVSqsYVaRIRM+TRfJ19knJsHGfRk5XWlo
   xjrmQj0/ivnkynYuDx+TsMv/eAHGjPPcAcpU1dG6oVgbho11mCeutSKu2
   g==;
X-CSE-ConnectionGUID: sNvulLAoRgibCP2UBCXbsA==
X-CSE-MsgGUID: bBU4MWVlQ+edfZpEqBDCEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="24656489"
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="24656489"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 06:37:47 -0700
X-CSE-ConnectionGUID: Ya/UwRVhRJmfAeJC8+8PXA==
X-CSE-MsgGUID: PU+2OfopTCG9a4Aj+3uTPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,210,1719903600"; 
   d="scan'208";a="89485404"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 07 Sep 2024 06:37:43 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1smvdF-000Cac-16;
	Sat, 07 Sep 2024 13:37:41 +0000
Date: Sat, 7 Sep 2024 21:36:46 +0800
From: kernel test robot <lkp@intel.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, ubizjak@gmail.com,
	jgg@nvidia.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	pandoh@google.com, kumaranand@google.com,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v3 2/5] iommu/amd: Introduce helper functions to access
 and update 256-bit DTE
Message-ID: <202409072100.WaB846Yg-lkp@intel.com>
References: <20240906121308.5013-3-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906121308.5013-3-suravee.suthikulpanit@amd.com>

Hi Suravee,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on joro-iommu/next v6.11-rc6 next-20240906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Suravee-Suthikulpanit/iommu-amd-Disable-AMD-IOMMU-if-CMPXCHG16B-feature-is-not-supported/20240906-201533
base:   linus/master
patch link:    https://lore.kernel.org/r/20240906121308.5013-3-suravee.suthikulpanit%40amd.com
patch subject: [PATCH v3 2/5] iommu/amd: Introduce helper functions to access and update 256-bit DTE
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240907/202409072100.WaB846Yg-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240907/202409072100.WaB846Yg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409072100.WaB846Yg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/amd/iommu.c:299:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     299 |         if (!alias_data) {
         |             ^~~~~~~~~~~
   drivers/iommu/amd/iommu.c:309:9: note: uninitialized use occurs here
     309 |         return ret;
         |                ^~~
   drivers/iommu/amd/iommu.c:299:2: note: remove the 'if' if its condition is always true
     299 |         if (!alias_data) {
         |         ^~~~~~~~~~~~~~~~
   drivers/iommu/amd/iommu.c:279:9: note: initialize the variable 'ret' to silence this warning
     279 |         int ret;
         |                ^
         |                 = 0
   1 warning generated.


vim +299 drivers/iommu/amd/iommu.c

   272	
   273	static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
   274	{
   275		struct dev_table_entry dte;
   276		struct amd_iommu *iommu;
   277		struct iommu_dev_data *dev_data, *alias_data;
   278		u16 devid = pci_dev_id(pdev);
   279		int ret;
   280	
   281		if (devid == alias)
   282			return 0;
   283	
   284		iommu = rlookup_amd_iommu(&pdev->dev);
   285		if (!iommu)
   286			return 0;
   287	
   288		/* Get DTE for pdev */
   289		dev_data = dev_iommu_priv_get(&pdev->dev);
   290		if (!dev_data)
   291			return -EINVAL;
   292	
   293		spin_lock(&dev_data->dte_lock);
   294		get_dte256(iommu, dev_data, &dte);
   295		spin_unlock(&dev_data->dte_lock);
   296	
   297		/* Setup for alias */
   298		alias_data = search_dev_data(iommu, alias);
 > 299		if (!alias_data) {
   300			ret = -EINVAL;
   301			goto out;
   302		}
   303	
   304		spin_lock(&alias_data->dte_lock);
   305		update_dte256(iommu, alias_data, &dte);
   306		amd_iommu_set_rlookup_table(iommu, alias);
   307		spin_unlock(&alias_data->dte_lock);
   308	out:
   309		return ret;
   310	}
   311	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
