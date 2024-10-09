Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4764518EBF;
	Wed,  9 Oct 2024 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728437544; cv=none; b=HtIkqNNnOFpy9TE18ozahTJsOQTHWGi/TcOQz9oypQ2p0sSk5hUIg2QrUgNvzawETFM7Ea3EPuSd2yDDbthfKNvqC5jxiFkQJpNV1wzA9v3JPq/yJ9hLOZECMaOiZN0a0biBohUkQzfrdhaf7c/d8GpjSvMi+OyWeOAvRUee6H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728437544; c=relaxed/simple;
	bh=a0+uf+NfJtuPcLf+rkvKkv9Vp5YWhsAqpXpzGodzWmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R53G2T9uGX9jxJyDU8IGk9gzOWHs60OyYzw3R25UobQp41elGS20TJN+DwxoQxQUiSgl7xYvMlgm4ddoS24J58ksUaEAaZxzsDNVfb2dFF7mJ7ddXAQzin5hzI1U6+GRrqtvGEF77ObNjLjTsbNcC3bnVjZEuRRUqsrFnhhtCyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eeeQx1Fb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeeQx1Fb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728437543; x=1759973543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a0+uf+NfJtuPcLf+rkvKkv9Vp5YWhsAqpXpzGodzWmM=;
  b=eeeQx1FbhVCfl0WSWB6MVSKxiGIhsKCV7azwP2vJCsxPB4wd3tjGjMKq
   jaOGoj5GPASutXRLiBWTjpSwoDXb7js60nLi8Var3zF3EjuousbtwHDWB
   BOPLjsfkK+DXlRtqQkmuC7IuzncIEHv0ukvoXEhK6JLqcLLJYGHrOm09v
   QWFqyR/1fg9ZEVwPtS1GNL5xL0Qn1Tzbyv2/e5fM8SZgw47XFv102Nv/2
   kiBM7DA1g/OkkA+cZyT1qcpA/ZkmfIvXNptO1LrU2Kc9GdvsxZ5y5WsFN
   cG+oGgJowTsh/W8TWF2hh7ACtQmTyNcy6WyA32ydaEKdl9io8ERpzyQiJ
   g==;
X-CSE-ConnectionGUID: 251SodlkSLyEGLXX9whCcg==
X-CSE-MsgGUID: XxLqC+VSSLWpATod1/2AuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38270817"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="38270817"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 18:32:22 -0700
X-CSE-ConnectionGUID: 5RhY4zlETvCg1SzjXE5oGQ==
X-CSE-MsgGUID: t+GgeUnaQT+AWsVc7A576A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="80874780"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 08 Oct 2024 18:32:19 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syLYn-0008Zw-2C;
	Wed, 09 Oct 2024 01:32:17 +0000
Date: Wed, 9 Oct 2024 09:32:03 +0800
From: kernel test robot <lkp@intel.com>
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
	joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 8/8] iommu/amd: Add documentation for AMD IOMMU debugfs
 support
Message-ID: <202410090917.z8aO1bNH-lkp@intel.com>
References: <20241008104035.4008-9-dheerajkumar.srivastava@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008104035.4008-9-dheerajkumar.srivastava@amd.com>

Hi Dheeraj,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b]

url:    https://github.com/intel-lab-lkp/linux/commits/Dheeraj-Kumar-Srivastava/iommu-amd-Refactor-AMD-IOMMU-debugfs-initial-setup/20241008-184419
base:   8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
patch link:    https://lore.kernel.org/r/20241008104035.4008-9-dheerajkumar.srivastava%40amd.com
patch subject: [PATCH 8/8] iommu/amd: Add documentation for AMD IOMMU debugfs support
reproduce: (https://download.01.org/0day-ci/archive/20241009/202410090917.z8aO1bNH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410090917.z8aO1bNH-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>> Warning: /sys/kernel/debug/iommu/devtbl is defined 2 times:  ./Documentation/ABI/testing/debugfs-amd-iommu:105  ./Documentation/ABI/testing/debugfs-amd-iommu:119
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
