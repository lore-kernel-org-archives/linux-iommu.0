Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3329624;
	Wed,  2 Oct 2024 00:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727828062; cv=none; b=pVt3k9pVW4WiHhWZeR+uYF7qbIvUvV7dBFOWes7QC4HpKXtbBEs2bEt6pe1t/3ZqpAXa55r7TuezKrPZEKrQtrzle3xAlSWtoHZf8066Nj2GTtSeRSp4jcQxW1Wi87+elENWSadh1nRAazP5gENl9hg3o7HGyy5pZodFo+oLyC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727828062; c=relaxed/simple;
	bh=v9C6ilDiJg0A0ytpHCTqTr0C3nnG5RgBkwEzFypgyZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6ivMANMK6BKHfKByDLiz7bTHUxEpmNBtbu4yzb0LEV0YlCPq3tZrWw/NFfZx37Z1/FXgWKLCrL+330fn6xGCgIDVBs3hySP58J2Pr27eHvbxUARD5VKQ4dtsLPYuM8hvuXJt/pFQthl//z8jzZA0Glp7G6Dys87ZJr+5j/5En4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O+JQIHMu; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O+JQIHMu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727828059; x=1759364059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v9C6ilDiJg0A0ytpHCTqTr0C3nnG5RgBkwEzFypgyZg=;
  b=O+JQIHMuDPZT52G8AVStUlWX88VmH4YU82LpPyBFlIYJ+FFeMYiiezmi
   DVyMZNpeP8nX4/WSB9u0s23tHi+sbNzZO+I5iUh9DchR/nycMzGK3qqXa
   6bGnDystb30xAUq/4cnbguzCoUewtf34vFFs9uPtLWwoXr/BHEPK/Y+Q/
   pUPXZDuF521WYTdpD886epoa6/PkQWFnEijxXIh2F9SdAgPer2VawpuRe
   PyAMgObCXPar8eycmJUbYv1QKkT7nL178CEoychcFDDafOtAm8Rlda6zp
   C8I+1yY/XJ8FZNbcUMCKDg7Nl+ksHYyv8+xwVQ693nVNUYwJkSr8ZOtni
   Q==;
X-CSE-ConnectionGUID: bZ5AuMJNSGiyiMg2HUXKyQ==
X-CSE-MsgGUID: RFvSD5jmSqmxwoW4yiEUJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="27080702"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="27080702"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 17:14:19 -0700
X-CSE-ConnectionGUID: 7UNkonJCRau/To8i+iMeHA==
X-CSE-MsgGUID: HV1l8ql8RUWkOv1auV4sDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="78816944"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 01 Oct 2024 17:14:16 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svn0P-000RLV-1R;
	Wed, 02 Oct 2024 00:14:13 +0000
Date: Wed, 2 Oct 2024 08:14:00 +0800
From: kernel test robot <lkp@intel.com>
To: Pratyush Brahma <quic_pbrahma@quicinc.com>, will@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, robin.murphy@arm.com, joro@8bytes.org,
	jgg@ziepe.ca, jsnitsel@redhat.com, robdclark@chromium.org,
	quic_c_gdjako@quicinc.com, dmitry.baryshkov@linaro.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pratyush Brahma <quic_pbrahma@quicinc.com>,
	Prakash Gupta <quic_guptap@quicinc.com>
Subject: Re: [PATCH] iommu/arm-smmu: Defer probe of clients after smmu device
 bound
Message-ID: <202410020820.gY0d4AkK-lkp@intel.com>
References: <20241001055633.21062-1-quic_pbrahma@quicinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001055633.21062-1-quic_pbrahma@quicinc.com>

Hi Pratyush,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on linus/master v6.12-rc1 next-20241001]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pratyush-Brahma/iommu-arm-smmu-Defer-probe-of-clients-after-smmu-device-bound/20241001-135852
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20241001055633.21062-1-quic_pbrahma%40quicinc.com
patch subject: [PATCH] iommu/arm-smmu: Defer probe of clients after smmu device bound
config: i386-buildonly-randconfig-004-20241002 (https://download.01.org/0day-ci/archive/20241002/202410020820.gY0d4AkK-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410020820.gY0d4AkK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410020820.gY0d4AkK-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iommu/arm/arm-smmu/arm-smmu.c: In function 'arm_smmu_probe_device':
>> drivers/iommu/arm/arm-smmu/arm-smmu.c:1441:32: warning: returning 'int' from a function with return type 'struct iommu_device *' makes pointer from integer without a cast [-Wint-conversion]
    1441 |                         return dev_err_probe(dev, -EPROBE_DEFER, "smmu dev has not bound yet\n");
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1441 drivers/iommu/arm/arm-smmu/arm-smmu.c

  1419	
  1420	static struct iommu_device *arm_smmu_probe_device(struct device *dev)
  1421	{
  1422		struct arm_smmu_device *smmu = NULL;
  1423		struct arm_smmu_master_cfg *cfg;
  1424		struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
  1425		int i, ret;
  1426	
  1427		if (using_legacy_binding) {
  1428			ret = arm_smmu_register_legacy_master(dev, &smmu);
  1429	
  1430			/*
  1431			 * If dev->iommu_fwspec is initally NULL, arm_smmu_register_legacy_master()
  1432			 * will allocate/initialise a new one. Thus we need to update fwspec for
  1433			 * later use.
  1434			 */
  1435			fwspec = dev_iommu_fwspec_get(dev);
  1436			if (ret)
  1437				goto out_free;
  1438		} else {
  1439			smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
  1440			if (!smmu)
> 1441				return dev_err_probe(dev, -EPROBE_DEFER, "smmu dev has not bound yet\n");
  1442		}
  1443	
  1444		ret = -EINVAL;
  1445		for (i = 0; i < fwspec->num_ids; i++) {
  1446			u16 sid = FIELD_GET(ARM_SMMU_SMR_ID, fwspec->ids[i]);
  1447			u16 mask = FIELD_GET(ARM_SMMU_SMR_MASK, fwspec->ids[i]);
  1448	
  1449			if (sid & ~smmu->streamid_mask) {
  1450				dev_err(dev, "stream ID 0x%x out of range for SMMU (0x%x)\n",
  1451					sid, smmu->streamid_mask);
  1452				goto out_free;
  1453			}
  1454			if (mask & ~smmu->smr_mask_mask) {
  1455				dev_err(dev, "SMR mask 0x%x out of range for SMMU (0x%x)\n",
  1456					mask, smmu->smr_mask_mask);
  1457				goto out_free;
  1458			}
  1459		}
  1460	
  1461		ret = -ENOMEM;
  1462		cfg = kzalloc(offsetof(struct arm_smmu_master_cfg, smendx[i]),
  1463			      GFP_KERNEL);
  1464		if (!cfg)
  1465			goto out_free;
  1466	
  1467		cfg->smmu = smmu;
  1468		dev_iommu_priv_set(dev, cfg);
  1469		while (i--)
  1470			cfg->smendx[i] = INVALID_SMENDX;
  1471	
  1472		ret = arm_smmu_rpm_get(smmu);
  1473		if (ret < 0)
  1474			goto out_cfg_free;
  1475	
  1476		ret = arm_smmu_master_alloc_smes(dev);
  1477		arm_smmu_rpm_put(smmu);
  1478	
  1479		if (ret)
  1480			goto out_cfg_free;
  1481	
  1482		device_link_add(dev, smmu->dev,
  1483				DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_SUPPLIER);
  1484	
  1485		return &smmu->iommu;
  1486	
  1487	out_cfg_free:
  1488		kfree(cfg);
  1489	out_free:
  1490		iommu_fwspec_free(dev);
  1491		return ERR_PTR(ret);
  1492	}
  1493	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
