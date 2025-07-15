Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2D94C81;
	Tue, 15 Jul 2025 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612342; cv=none; b=sqlvDJdWUVagI6QLpZqFMErMuPWnOushSsEurLX955eXQAqTM1YX7EGCnLTeyHVsXUIhZBRwDVYxRiaGeU/CAIJxsbaRNj6d5ESD38Cf6tQLsgkoz5PhQzg8Xp1C9OJdVtvc3DiYf8gfq/DMa6vXK+bz6/H8KZeeSoHsggbCVFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612342; c=relaxed/simple;
	bh=i0jIU5/DS4GdwKEU3LoAR0J+8jJlfbT9Pjilk9/G/wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEqB/f1UysQwTYsY1cKzJbU7q92EY4+y1ENXGAFQze/egOJwFy+1QhsVY7DpCNPdUKurZifEZOMIiMj0SQwKZ9cyF+MRrHItmyFLfR+MUkOqputibJTHHNBrQZ637saLuwhqpELwe6L4FcxPBsajTeAyCC9ol/rs+SYD8Uj3fbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqfZwrWL; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqfZwrWL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752612341; x=1784148341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i0jIU5/DS4GdwKEU3LoAR0J+8jJlfbT9Pjilk9/G/wc=;
  b=CqfZwrWLjftG8eeAQ3fw+jX/YBAHK5NRjsa/xXclBG8uAZ7EfAmlj17w
   5paWBZIW68cETb6P3Tulp5xt62Yy9tQH4wPtUSLH/XGOlfqE+klP/n5DQ
   7BHDnZTKWXWfw4ejGedbMo88x1iodO68oOwhW/+9+6LcE6X+fpQM0jHHi
   3+DiLtVgyif7uQFCZ0aklSOBo+CfklGUtOJgdq3fYHxd6Yh2NedeLWBlZ
   D2OLhYa0Ue41T6PN+YNV2/K4wpnUrxjOQPzU/MuCBCNKwvoO8G8qu1e3Z
   nyG43qZDd7qJPC5PgI3oP501kQXwLHyy8JudqQjhpzsS0YhJMv5hH//qJ
   Q==;
X-CSE-ConnectionGUID: dwiq/TXbR+q5dWBk1QsYEw==
X-CSE-MsgGUID: mD2FstyDQbyMjBGXDCEd7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="42476845"
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="42476845"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 13:45:40 -0700
X-CSE-ConnectionGUID: LLieUtQbSHu2EBMh8oD7ow==
X-CSE-MsgGUID: L6tg7xQQR9Ws3Tb2pIwI1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,314,1744095600"; 
   d="scan'208";a="188322879"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 15 Jul 2025 13:45:36 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubmWs-000BWl-0g;
	Tue, 15 Jul 2025 20:45:34 +0000
Date: Wed, 16 Jul 2025 04:44:49 +0800
From: kernel test robot <lkp@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, jgg@nvidia.com, jgg@ziepe.ca,
	kevin.tian@intel.com, will@kernel.org, aneesh.kumar@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, shuah@kernel.org,
	nicolinc@nvidia.com, aik@amd.com, dan.j.williams@intel.com,
	baolu.lu@linux.intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v5 5/8] iommufd/vdevice: Remove struct device reference
 from struct vdevice
Message-ID: <202507160404.4hMp40iv-lkp@intel.com>
References: <20250715063245.1799534-6-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715063245.1799534-6-yilun.xu@linux.intel.com>

Hi Xu,

kernel test robot noticed the following build errors:

[auto build test ERROR on 601b1d0d9395c711383452bd0d47037afbbb4bcf]

url:    https://github.com/intel-lab-lkp/linux/commits/Xu-Yilun/iommufd-viommu-Roll-back-to-use-iommufd_object_alloc-for-vdevice/20250715-144326
base:   601b1d0d9395c711383452bd0d47037afbbb4bcf
patch link:    https://lore.kernel.org/r/20250715063245.1799534-6-yilun.xu%40linux.intel.com
patch subject: [PATCH v5 5/8] iommufd/vdevice: Remove struct device reference from struct vdevice
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20250716/202507160404.4hMp40iv-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250716/202507160404.4hMp40iv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507160404.4hMp40iv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:1221:64: error: incomplete definition of type 'struct iommufd_device'
    1221 |         struct arm_smmu_master *master = dev_iommu_priv_get(vdev->idev->dev);
         |                                                             ~~~~~~~~~~^
   include/linux/iommufd.h:24:8: note: forward declaration of 'struct iommufd_device'
      24 | struct iommufd_device;
         |        ^
   1 error generated.


vim +1221 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c

  1218	
  1219	static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
  1220	{
> 1221		struct arm_smmu_master *master = dev_iommu_priv_get(vdev->idev->dev);
  1222		struct tegra241_vintf *vintf = viommu_to_vintf(vdev->viommu);
  1223		struct tegra241_vintf_sid *vsid = vdev_to_vsid(vdev);
  1224		struct arm_smmu_stream *stream = &master->streams[0];
  1225		u64 virt_sid = vdev->virt_id;
  1226		int sidx;
  1227	
  1228		if (virt_sid > UINT_MAX)
  1229			return -EINVAL;
  1230	
  1231		WARN_ON_ONCE(master->num_streams != 1);
  1232	
  1233		/* Find an empty pair of SID_REPLACE and SID_MATCH */
  1234		sidx = ida_alloc_max(&vintf->sids, vintf->cmdqv->num_sids_per_vintf - 1,
  1235				     GFP_KERNEL);
  1236		if (sidx < 0)
  1237			return sidx;
  1238	
  1239		writel(stream->id, REG_VINTF(vintf, SID_REPLACE(sidx)));
  1240		writel(virt_sid << 1 | 0x1, REG_VINTF(vintf, SID_MATCH(sidx)));
  1241		dev_dbg(vintf->cmdqv->dev,
  1242			"VINTF%u: allocated SID_REPLACE%d for pSID=%x, vSID=%x\n",
  1243			vintf->idx, sidx, stream->id, (u32)virt_sid);
  1244	
  1245		vsid->idx = sidx;
  1246		vsid->vintf = vintf;
  1247		vsid->sid = stream->id;
  1248	
  1249		vdev->destroy = &tegra241_vintf_destroy_vsid;
  1250		return 0;
  1251	}
  1252	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
