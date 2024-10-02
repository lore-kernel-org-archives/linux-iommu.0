Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC551FA4;
	Wed,  2 Oct 2024 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727831265; cv=none; b=Pr4wzP2D6t8RaUDqDnxckqLskb6H7HfjG2YjkOi41/dpmpq1z0vqUdgqFkcNFv+xj+yuI3s/uiwS7piivdIyQ4qBMf4zw0KLGhAMIwcfKKYzIpfZdN2ab2RWUFGwnKLcWbpxQpnWivFbniyUcKxH1MxfT+RpEOY65pInL/WgkX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727831265; c=relaxed/simple;
	bh=LkjFi6v3vLf+bfDTftYzlcbFaz3AIiseSki2Mn1jeb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gtx+dfKkmP+7sME368asrftvt4hFmJbjcfFMV/QbBkXQ92DSFjba33Vz4Rk3ofKScAh/sppgewmSJe5sRL6X6j2SshSJtT2R7T+x5DNpE3jHIzDx6effHx4xImVPUGhkgKEW5xsi/Vnwm/7r+0yVl283lH6jUheo+ErDFXJQSag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QnOqz1U0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QnOqz1U0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727831264; x=1759367264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LkjFi6v3vLf+bfDTftYzlcbFaz3AIiseSki2Mn1jeb8=;
  b=QnOqz1U0go9uQv2oUpoTxEqjziTkt3GSjvHjGra+5NFJz64rhxidAAlH
   opn6i0UyhVzjwYpXsVvug4xsQhMPbl3ydb3tmH9xRmqWScNR3gdq6cxCf
   o7iNjHQyiUZaz72ec/pMfbiwHJ4I6Xoft8x3eMeC7PUgWeK8NMx3Ifqtf
   4/xZcOJ4qURmMWzXwqf+UIg5UAV/tmTDHGQ3ipK1DxwgFMS1ydGci44bu
   EgJYfqY+6C6L+f4UnduYU1QMemyIGYN6j9qEFb2ni4MEANucBG3KFGJYj
   K1pbM82sksYj/9gQHF0cLFLy/Oxst4YYqyF3vWyIJ5ZRPOpS/2wDiNdYS
   w==;
X-CSE-ConnectionGUID: 4CUPj3OwRE+qXZigoUZPgw==
X-CSE-MsgGUID: Dua8mH7JTn+x/PhIy+FtiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="26457719"
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="26457719"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 18:07:43 -0700
X-CSE-ConnectionGUID: ElPzYp++TlKRUIodJxJzpg==
X-CSE-MsgGUID: 1jj51WQsRMijeU3fBjmjIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="77882719"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 01 Oct 2024 18:07:40 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svnq5-000ROB-2G;
	Wed, 02 Oct 2024 01:07:37 +0000
Date: Wed, 2 Oct 2024 09:07:09 +0800
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
Message-ID: <202410020856.Gp3LtJKA-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on soc/for-next]
[also build test ERROR on linus/master v6.12-rc1 next-20241001]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Pratyush-Brahma/iommu-arm-smmu-Defer-probe-of-clients-after-smmu-device-bound/20241001-135852
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20241001055633.21062-1-quic_pbrahma%40quicinc.com
patch subject: [PATCH] iommu/arm-smmu: Defer probe of clients after smmu device bound
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20241002/202410020856.Gp3LtJKA-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410020856.Gp3LtJKA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410020856.Gp3LtJKA-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iommu/arm/arm-smmu/arm-smmu.c: In function 'arm_smmu_probe_device':
>> drivers/iommu/arm/arm-smmu/arm-smmu.c:1441:32: error: returning 'int' from a function with return type 'struct iommu_device *' makes pointer from integer without a cast [-Wint-conversion]
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
