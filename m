Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9558536AE7;
	Thu, 26 Oct 2023 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l1pLh7QC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698333991; x=1729869991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AaJUnn8yXQ+rUIuyIoWotDShX4ZQE4ZU64dKYmfhtS8=;
  b=l1pLh7QC/z+pX7RfLvj2R02i+oCCwvVjvKPuSBEWTWJezULVrKH+AO2b
   iAW8lgCaSyEzQN4WytBm00XrgH5zXdOzBODpfY6YJ0M8zY5QiWvLZpZ6I
   sl79hN12bnrGWlXSG0wyhsm+6TDKr0g/hlbkx4FlnLE/EKXHcbVbl3MMl
   opqopFhxItphBaDvUXarGjSqFYRZbe9RTORH1ghvqsDbc+GYvIYoaSdeZ
   X6/PBO6fjgi1CYb62GVlbR0moEx54hUE0DHCnQA9HQabvoa9BFha8iECl
   rfvxVG0/6+p6aX0OK/O6dEddIPM++msXnQR09B8PjwFd8+wshf8qim+pe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="377940157"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="377940157"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 08:26:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="902943379"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="902943379"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 26 Oct 2023 08:23:59 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qw2Fb-0009t5-1O;
	Thu, 26 Oct 2023 15:26:23 +0000
Date: Thu, 26 Oct 2023 23:25:35 +0800
From: kernel test robot <lkp@intel.com>
To: Georgi Djakov <quic_c_gdjako@quicinc.com>, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	will@kernel.org, robin.murphy@arm.com, joro@8bytes.org
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	quic_cgoldswo@quicinc.com, quic_sukadev@quicinc.com,
	quic_pdaly@quicinc.com, quic_sudaraja@quicinc.com,
	djakov@kernel.org
Subject: Re: [PATCH 3/6] iommu/arm-smmu-qcom: Add Qualcomm TBU driver
Message-ID: <202310262330.pfzI76DH-lkp@intel.com>
References: <20231019021923.13939-4-quic_c_gdjako@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019021923.13939-4-quic_c_gdjako@quicinc.com>

Hi Georgi,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on arm/for-next arm/fixes arm64/for-next/core clk/clk-next kvmarm/next rockchip/for-next shawnguo/for-next soc/for-next linus/master v6.6-rc7 next-20231025]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Georgi-Djakov/dt-bindings-iommu-Add-Translation-Buffer-Unit-bindings/20231019-102257
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231019021923.13939-4-quic_c_gdjako%40quicinc.com
patch subject: [PATCH 3/6] iommu/arm-smmu-qcom: Add Qualcomm TBU driver
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231026/202310262330.pfzI76DH-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231026/202310262330.pfzI76DH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310262330.pfzI76DH-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: drivers/iommu/arm/arm-smmu/arm-smmu-qcom.o: in function `qsmmuv500_tbu_driver_init':
>> arm-smmu-qcom.c:(.init.text+0x8): multiple definition of `init_module'; drivers/iommu/arm/arm-smmu/arm-smmu.o:arm-smmu.c:(.init.text+0x8): first defined here
   aarch64-linux-ld: drivers/iommu/arm/arm-smmu/arm-smmu-qcom.o: in function `qsmmuv500_tbu_driver_exit':
>> arm-smmu-qcom.c:(.exit.text+0x0): multiple definition of `cleanup_module'; drivers/iommu/arm/arm-smmu/arm-smmu.o:arm-smmu.c:(.exit.text+0x0): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
