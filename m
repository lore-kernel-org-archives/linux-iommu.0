Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE3E1EB27;
	Mon, 26 Feb 2024 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948184; cv=none; b=cSpI3MsqquELjYLmIWgFpNhJPGqw10yUGogAtEv7GBlhmCFDrU+Duuo7stDve9q1lSB54Zw66A8eIIMQbFFWrDSruYwo9QCrQ9oFVsr50aYXYjgEM+3KN+HAFwjviEe/UtAJUNI5gpmKn7e4Er4wo7gJrM3bgPqFliHNB13amnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948184; c=relaxed/simple;
	bh=0g9GcCs8vfketXgTlugah+18Pi8X9CkkeR2K4H65dqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyB4/XgQWdDc8hK07hTE2mFobr1bV3UxDc6I2pQaKNv96fw71P48LWCPXlFTj3sttyZyUPeTcxCmESsDAbaXffuhbTJe/GCKszK5puqOCpMrIc6oQYRLUfN/qRScSt1Vaevw8PX29dglRsIfdG3zN/TcAs9S4vKaCAaYvpJIl3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZB7w19GZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZB7w19GZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708948184; x=1740484184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0g9GcCs8vfketXgTlugah+18Pi8X9CkkeR2K4H65dqY=;
  b=ZB7w19GZfHRMi+PmoUTRS32wjRqYQZF7MklVYaU12MhjJ2LEZueue1KB
   JMTzse1us15K0pJCk7YK8gg5KtV0W1o3gcczoAQgQ+XfRlpoQ3hW1viP5
   reabMFxboKglMcIZQqmF5wxY7CpQJAeUOzCnlQc+SgbDYAz4Oe5dYnaSw
   cRKhBEE2JdCX1mRAXKS8/f/tLkpfgli7yatoaIbLT5tOMLrSpTFPF/gG9
   ExQuB7fmRbLV3ovu63XcQlUiE90HwDYqx1OrpCHs45X1CP2ENI3bPHOvx
   9WK24W2KMT5elxNtkyTJwJaqDM3M8KpKkFXEyNaPFhwDy7SHYHfdZaVyz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="28652383"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="28652383"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 03:49:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6678310"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 26 Feb 2024 03:49:35 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1reZTn-000AHf-22;
	Mon, 26 Feb 2024 11:49:15 +0000
Date: Mon, 26 Feb 2024 19:48:08 +0800
From: kernel test robot <lkp@intel.com>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, baolu.lu@linux.intel.com,
	bhelgaas@google.com, robin.murphy@arm.com, jgg@ziepe.ca
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	kevin.tian@intel.com, dwmw2@infradead.org, will@kernel.org,
	lukas@wunner.de, yi.l.liu@intel.com, dan.carpenter@linaro.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: Re: [PATCH v13 3/3] iommu/vt-d: improve ITE fault handling if target
 device isn't valid
Message-ID: <202402261910.IZ3PGmH3-lkp@intel.com>
References: <20240222090251.2849702-4-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222090251.2849702-4-haifeng.zhao@linux.intel.com>

Hi Ethan,

kernel test robot noticed the following build errors:

[auto build test ERROR on e60bf5aa1a74c0652cd12d0cdc02f5c2b5fe5c74]

url:    https://github.com/intel-lab-lkp/linux/commits/Ethan-Zhao/PCI-make-pci_dev_is_disconnected-helper-public-for-other-drivers/20240222-170625
base:   e60bf5aa1a74c0652cd12d0cdc02f5c2b5fe5c74
patch link:    https://lore.kernel.org/r/20240222090251.2849702-4-haifeng.zhao%40linux.intel.com
patch subject: [PATCH v13 3/3] iommu/vt-d: improve ITE fault handling if target device isn't valid
config: x86_64-randconfig-074-20240226 (https://download.01.org/0day-ci/archive/20240226/202402261910.IZ3PGmH3-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240226/202402261910.IZ3PGmH3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402261910.IZ3PGmH3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: device_rbtree_find
   >>> referenced by dmar.c:1346 (drivers/iommu/intel/dmar.c:1346)
   >>>               drivers/iommu/intel/dmar.o:(qi_submit_sync) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
