Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7162637;
	Wed,  2 Oct 2024 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727836250; cv=none; b=BUaQuw1B1iJePBdFAW3+6ThCVBmNLUUGOXg+uEqlDftUi+qVk8ffRAxGFvp9ILcp4S4Fvbs1B4639WvX4Zn1F/qRb+b3KszZFrMS/BquQpCVCTfhwZOnH/Kp5tPuXP7bBL8dL7YKbWVs1oS7uhfzaA8q9hqI0ZqcWqYRGVdyMSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727836250; c=relaxed/simple;
	bh=Gr7LJLTt0sQ4IO0gdywUesFn2Joxg0Ma4TL2lmiC/zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PntG4SbMgvsOLnaLpPE5eDPE6B58n4a3aJYl8EmjUReYVr8Trt2QE9B5OhRTINsAL8uaAyhqRf4cgEVesLAMuTkvsM1vYHCtfR/yI/dmRtnZUcqWAYVpPK7mj7kmvN+yKi5SLE7DdWnIQ1ph4JYYX3n7STi6NohYFgDc+DSP5rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRXazPp7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRXazPp7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727836248; x=1759372248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gr7LJLTt0sQ4IO0gdywUesFn2Joxg0Ma4TL2lmiC/zE=;
  b=CRXazPp7I5BNIexqODHfHlS0RF/8DMaZ3crGz4c9zgBZjl4W/8YiRAWj
   XSHvt4PG26nYoZn48/2KMuBUP7t1dr41Z5ouSpQrCFBlQJqmc/fwokS+n
   6VXHgwIEYArqKXVzUvfWGU+dmQo0SVdf+CPK2kD9gcG6OSI2g08cKra95
   FKFG0lbAhHW3xN5qSx7tBfmgeDzaNFS4GB2yXqcW07sfsJoxdUJQB8Ch5
   9hkuJ02mZP++GmhAkMF9ZZDn2pSWKYiZWn12RzUBUrhuakrDxJCvkQp+U
   0qyi3Q0O+jskJQ5yrPlAH0PcyGe8mpEbJ4fNBIET9uMxwdLIyxslx4HyU
   A==;
X-CSE-ConnectionGUID: UZKYqFrkSw2SThfGL0XCww==
X-CSE-MsgGUID: kdFD3P47RS6vW+rQwF25lw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="37587871"
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="37587871"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 19:30:47 -0700
X-CSE-ConnectionGUID: 51d/BqTJQkCTQxwMot/A7A==
X-CSE-MsgGUID: I/sGjXBaRpi2pLltPND8qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,170,1725346800"; 
   d="scan'208";a="111347954"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 01 Oct 2024 19:30:43 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svp8S-000RRu-2X;
	Wed, 02 Oct 2024 02:30:40 +0000
Date: Wed, 2 Oct 2024 10:30:08 +0800
From: kernel test robot <lkp@intel.com>
To: Pratyush Brahma <quic_pbrahma@quicinc.com>, will@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
	jsnitsel@redhat.com, robdclark@chromium.org,
	quic_c_gdjako@quicinc.com, dmitry.baryshkov@linaro.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Pratyush Brahma <quic_pbrahma@quicinc.com>,
	Prakash Gupta <quic_guptap@quicinc.com>
Subject: Re: [PATCH] iommu/arm-smmu: Defer probe of clients after smmu device
 bound
Message-ID: <202410021015.OHF2CJsc-lkp@intel.com>
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
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241002/202410021015.OHF2CJsc-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project fef3566a25ff0e34fb87339ba5e13eca17cec00f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241002/202410021015.OHF2CJsc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410021015.OHF2CJsc-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iommu/arm/arm-smmu/arm-smmu.c:20:
   In file included from include/linux/acpi.h:14:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:503:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     503 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     504 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:510:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     510 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     511 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:517:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:523:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     523 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     524 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/iommu/arm/arm-smmu/arm-smmu.c:24:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
         |                                                           ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
         |                                                      ^
   In file included from drivers/iommu/arm/arm-smmu/arm-smmu.c:24:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
         |                                                           ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
   In file included from drivers/iommu/arm/arm-smmu/arm-smmu.c:24:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:93:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     693 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     701 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     709 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     718 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     727 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     736 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> drivers/iommu/arm/arm-smmu/arm-smmu.c:1441:11: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'struct iommu_device *' [-Wint-conversion]
    1441 |                         return dev_err_probe(dev, -EPROBE_DEFER, "smmu dev has not bound yet\n");
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   16 warnings and 1 error generated.


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
