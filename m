Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E44618644;
	Sat,  4 Nov 2023 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQ475Ml+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699111839; x=1730647839;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NWJpfRizHfLZNHX5VvGvvq9eA1w3votDvF33jxdOllo=;
  b=eQ475Ml+de8eJHvGmvGS3Six4dOjgCDYrNYMJWgUH2/224ftMGcVet9s
   qCRm2MHw18aKjJKccnVpT6j78R9mcRQGKPTPH+GeoYI9sAJ7ZBNKcpUPH
   oYiBboCf06VFFCUD1tVMAo32z7R2BR4aEvw/XWFFh7dbFjPo2HA6EJzUk
   ba2JrrZhBi4iw33oXjXCtzppTb8cc/q9Y+OUsTFyyED+JFDEpgHI4vhI/
   RsDhn7NLvE94nD39FMzEAfs3QeScxQRSKKDzffiUEYBlJ0AlKQ4XoznHF
   4TKiIeGntlSB8QNJUrwPidCG+6BAiOBT3NH5elMF4L7Tf2itHbfhzCYTl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10884"; a="7725941"
X-IronPort-AV: E=Sophos;i="6.03,277,1694761200"; 
   d="scan'208";a="7725941"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2023 08:30:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,277,1694761200"; 
   d="scan'208";a="3024829"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 04 Nov 2023 08:30:35 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qzIbY-0004W0-18;
	Sat, 04 Nov 2023 15:30:32 +0000
Date: Sat, 4 Nov 2023 23:29:37 +0800
From: kernel test robot <lkp@intel.com>
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, dmitry.baryshkov@linaro.org,
	a39.skl@gmail.com, konrad.dybcio@linaro.org,
	quic_saipraka@quicinc.com, quic_pkondeti@quicinc.com,
	quic_molvera@quicinc.com
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	qipl.kernel.upstream@quicinc.com,
	Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Subject: Re: [PATCH 2/3] iommu/arm-smmu: add ACTLR data and support for SM8550
Message-ID: <202311042304.pVLm1ZYk-lkp@intel.com>
References: <20231103215124.1095-3-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103215124.1095-3-quic_bibekkum@quicinc.com>

Hi Bibek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.6]
[also build test WARNING on linus/master next-20231103]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bibek-Kumar-Patro/iommu-arm-smmu-introduction-of-ACTLR-for-custom-prefetcher-settings/20231104-055625
base:   v6.6
patch link:    https://lore.kernel.org/r/20231103215124.1095-3-quic_bibekkum%40quicinc.com
patch subject: [PATCH 2/3] iommu/arm-smmu: add ACTLR data and support for SM8550
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20231104/202311042304.pVLm1ZYk-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311042304.pVLm1ZYk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311042304.pVLm1ZYk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:614:42: warning: 'sm8550_smmu_500_impl0_data' defined but not used [-Wunused-const-variable=]
     614 | static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/sm8550_smmu_500_impl0_data +614 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c

   612	
   613	
 > 614	static const struct qcom_smmu_match_data sm8550_smmu_500_impl0_data = {
   615		.impl = &sm8550_smmu_500_impl,
   616		.adreno_impl = &qcom_adreno_smmu_500_impl,
   617		.cfg = &qcom_smmu_impl0_cfg,
   618		.actlrcfg = &sm8550_actlrcfg,
   619	};
   620	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
