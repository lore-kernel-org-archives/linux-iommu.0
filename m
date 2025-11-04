Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C008B2EDD74;
	Tue,  4 Nov 2025 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261569; cv=none; b=lZpeGy908cDB3nqyQguwMlI7Wi+PbLK4ZbivAQuw7pq8PyjUUYVHJzj2Sd9sbjxXidEZhtrn74ph4Gd6uTrMc408APGOSR07WHbjFkdFSimr3y994+VwXlPTyMJtvBdB0RiQITMXUnhN5OMPl8j98MRt9mMsKongc3envMV+8/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261569; c=relaxed/simple;
	bh=uM+xb4jok103os8tzQky4xYv8R0/kY5bXK9YP0mICyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLdid3DBEq2qdJfSjnEqedGzu7BIpA0f6EpQDtnNFw2vRt5L9kVB3AxFGNnLreEHNXRPVXD+79c0O3OHWVD7ZsV+oNcGdUwWMAM/gKnkhQeabgUcun0dlFHf54oOhRYEHdG42lcfbzTWdYNLCEQLw+oRC8jASnbVBB5AdxvLvGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bvDz1a42; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bvDz1a42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762261568; x=1793797568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uM+xb4jok103os8tzQky4xYv8R0/kY5bXK9YP0mICyE=;
  b=bvDz1a42Vxgpcpf8uhebjDyCm8R9WAdF0IwGbVuz1QIeP/6ejLYaO800
   WQhpapDDZ5dMtNb7GvC46p+xBYIyfv9rPNfGsdBwMT9ckLLvn0E7dSmZj
   0b62uaaJ+KIrpwE0NndhGjbsiuK/nsokIQdTZNUflZmMqWKOw3w70eUne
   YzayxwgeD1J7iVZHya+OWLEgFaKujV18tBFvJdfnuEqE9fRieB1SZjMt+
   osixfmOk/JAjC4vbQay/XlUMzSHwlDS8JYGKYhjLdQwRoXugHG24Co3d0
   KocnZHJn/hObicRg4rxpHL/gzqI12ge/xDsfIKbHkBGVSzyuubxyqH2P4
   g==;
X-CSE-ConnectionGUID: HefAIo+6QCKWJNzHTyivXw==
X-CSE-MsgGUID: aTMwak8+SMu9d+DcJMD4ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="63365387"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="63365387"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 05:06:05 -0800
X-CSE-ConnectionGUID: 33vOWdfsTgqD0OkKZjmu2A==
X-CSE-MsgGUID: 6P7NkPMcT9a9kTAyDW6AFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="187104013"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 04 Nov 2025 05:06:01 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGGij-000RPb-2E;
	Tue, 04 Nov 2025 13:05:22 +0000
Date: Tue, 4 Nov 2025 21:02:23 +0800
From: kernel test robot <lkp@intel.com>
To: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, robh@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
	bjorn.andersson@oss.qualcomm.com, bod@kernel.org,
	conor+dt@kernel.org, krzk+dt@kernel.org, saravanak@google.com,
	prakash.gupta@oss.qualcomm.com, vikash.garodia@oss.qualcomm.com
Cc: oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: Re: [PATCH 5/6] of: add infra to parse iommu-map per IOMMU cell count
Message-ID: <202511042005.MXfsNx3W-lkp@intel.com>
References: <74d4ddf90c0fb485fda1feec5116dc38e5fd23cf.1762235099.git.charan.kalla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74d4ddf90c0fb485fda1feec5116dc38e5fd23cf.1762235099.git.charan.kalla@oss.qualcomm.com>

Hi Charan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.18-rc4 next-20251104]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Charan-Teja-Kalla/of-create-a-wrapper-for-of_map_id/20251104-170223
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/74d4ddf90c0fb485fda1feec5116dc38e5fd23cf.1762235099.git.charan.kalla%40oss.qualcomm.com
patch subject: [PATCH 5/6] of: add infra to parse iommu-map per IOMMU cell count
config: microblaze-allnoconfig (https://download.01.org/0day-ci/archive/20251104/202511042005.MXfsNx3W-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251104/202511042005.MXfsNx3W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511042005.MXfsNx3W-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/of/base.c:2123 function parameter 'cells' not described in 'of_iommu_map_id_cell_count'
>> Warning: drivers/of/base.c:2240 function parameter 'np' not described in 'of_map_id_or_funcid'
>> Warning: drivers/of/base.c:2240 function parameter 'id' not described in 'of_map_id_or_funcid'
>> Warning: drivers/of/base.c:2240 function parameter 'map_name' not described in 'of_map_id_or_funcid'
>> Warning: drivers/of/base.c:2240 function parameter 'map_mask_name' not described in 'of_map_id_or_funcid'
>> Warning: drivers/of/base.c:2240 function parameter 'target' not described in 'of_map_id_or_funcid'
>> Warning: drivers/of/base.c:2240 function parameter 'id_out' not described in 'of_map_id_or_funcid'
>> Warning: drivers/of/base.c:2240 function parameter 'arg' not described in 'of_map_id_or_funcid'
>> Warning: drivers/of/base.c:2240 function parameter 'pargs' not described in 'of_map_id_or_funcid'
>> Warning: drivers/of/base.c:2240 function parameter 'fn' not described in 'of_map_id_or_funcid'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
