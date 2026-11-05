Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793869888;
	b=jtnz6XwT50hDvjMiQRhHK/RbWg9aSuUBQvq3epa51YAh7eOMyZVdsOE8C28/CTXha58t
	 A4HQKVLKBgb1ZM482QR2AOsnWDsPK7/YAMytD4XPtXDMqy3mI2oqRKsoeflCAdCpChs5m
	 UgErgweWYCmVvHNU66KQ73uxC7bAQKPYLyG4DNcmjUek/ejg7iLazJFX1RgKT7ZmRowUP
	 iCTRlr4Hi9Gbr8Ejs7SVOJb+fuIHeoZPPs9fIpqeWbagvArkYL8joqQ3OCOYxCKhKkv78
	 8IqEvXbQinfpoHDzAujWMacEzqCXSGxqvJc8atACulo42yLdk+iGVVNv7oP02xb1G1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793869888;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=rmEfX5MB+z5qNLqON5R/iyjm6saIez2uOt9Qp74A9Mo=;
	b=TS/efB5H2tKqzofX/oO0uoyIrCGLvy7supMdyEvRGSzH1G/jKoMi4NmQeTjkDrwgvePA
	 OZc34xTIWsz5SijRoW8Tj0rw4owpYlCK74peqUN+5aqECfsBQHcUk1fhhRAnM5MCadcEI
	 3koGr3kgv6HmsiScEBZh5vkKYcwcZE12yV8f6ZKBkjaMiw+d0d3D+gPrsN3u7vIyC0ciW
	 hnD46izsjN5h+sR4v/M1BIXwHNC5vrhxTPEo3lr42sVQ2VvKpSvYCHCGJPNVx/O+cK/d1
	 n24UF5V1LzWSCTeQWiodpjo3L1h2bbUq3AC/U/Vu8Zn4AUdN5C7vvgqH3uwBAOjFSCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BVJ60ZoY;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF6F606A33E;
	Thu,  5 Nov 2026 09:11:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BF6F606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BVJ60ZoY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793869887; x=1825405887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cA9g6szely6p7/mFb90LkK3gklsmstrV8QekqHlOipY=;
  b=BVJ60ZoY6WYfFgKZhH3TrCaQ1W5Ydu9u3ZTzcONxgTgs69fuFMN2QetM
   6LmKL1JNHwRV3MThfRr/IhWBUoq3p65Bl00mySE1q1i6CuI9bokrPQwtu
   wQadrwDEnl1bJKMUKipjAVI2PnfHWIcyUaRGjZ9afhjNLdFanhXl+iE8q
   drWhpX7raRPeWGA9lF7Q+dKsSo61E7cMD6Wji7xo7jdc9CQYO+lmpuOLA
   dn4IgN6zqVFoYbYDm/Q8XPqLMK+BIRukLEmzziiM3MLplCPDb21UiyOox
   ctU6+VoYD/0IdA5G4Rp/4KsPmVsk8Z4ZbDijRfFJR3sQMGECVY48tE3Du
   A==;
X-CSE-ConnectionGUID: a2fwYRL4T/GXe6RfgEZdyA==
X-CSE-MsgGUID: 3S35OliSSk6MWITq6xEqpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2533677"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2533677"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 01:11:25 -0800
X-CSE-ConnectionGUID: FZgqFD1XTuezdhmfpzDg0g==
X-CSE-MsgGUID: sBnwJd+kSPi601QzmYFddg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6970208"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 01:11:17 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOtV3-00000000lzN-1PRo;
	Thu, 05 Nov 2026 09:11:13 +0000
Date: Thu, 5 Nov 2026 17:10:56 +0800
From: kernel test robot <lkp@intel.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	iommu@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Ortiz <sameo@rivosinc.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Steven Price <steven.price@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 11/15] iommufd/viommu: Select vIOMMU operations before
 allocation
Message-ID: <202611051602.nH0L0uqs-lkp@intel.com>
References: <20261104161632.3547423-12-aneesh.kumar@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104161632.3547423-12-aneesh.kumar@kernel.org>

Hi Aneesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4]

url:    https://github.com/intel-lab-lkp/linux/commits/Aneesh-Kumar-K-V-Arm/PCI-TSM-Move-core-code-into-its-own-directory/20261104-214618
base:   6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
patch link:    https://lore.kernel.org/r/20261104161632.3547423-12-aneesh.kumar%40kernel.org
patch subject: [PATCH v8 11/15] iommufd/viommu: Select vIOMMU operations before allocation
config: x86_64-buildonly-randconfig-1001-20261105 (https://download.01.org/0day-ci/archive/20261105/202611051602.nH0L0uqs-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611051602.nH0L0uqs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611051602.nH0L0uqs-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iommu/amd/iommufd.c:81:40: warning: 'amd_viommu_ops' defined but not used [-Wunused-const-variable=]
      81 | static const struct iommufd_viommu_ops amd_viommu_ops = {
         |                                        ^~~~~~~~~~~~~~


vim +/amd_viommu_ops +81 drivers/iommu/amd/iommufd.c

757d2b1fdf5b7d6 Suravee Suthikulpanit 2026-01-15  76  
757d2b1fdf5b7d6 Suravee Suthikulpanit 2026-01-15  77  /*
757d2b1fdf5b7d6 Suravee Suthikulpanit 2026-01-15  78   * See include/linux/iommufd.h
757d2b1fdf5b7d6 Suravee Suthikulpanit 2026-01-15  79   * struct iommufd_viommu_ops - vIOMMU specific operations
757d2b1fdf5b7d6 Suravee Suthikulpanit 2026-01-15  80   */
757d2b1fdf5b7d6 Suravee Suthikulpanit 2026-01-15 @81  static const struct iommufd_viommu_ops amd_viommu_ops = {

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
