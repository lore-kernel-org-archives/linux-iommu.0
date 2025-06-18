Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6759C19D880;
	Wed, 18 Jun 2025 04:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750222443; cv=none; b=S0SEGGzSjF4TWN2xwhr9OeZytiafn+x+VD6qu40yIQtFFQcMfgd2jpMjGe0JhHhjkQcExBLiU+JhPXf+gh80ou+68k7fHL1YXJkinMBQRO+3Qz0Gz1phKZtq4BcuPK6RRBBwhWRhi9nqAdk5/3IgmELjxRe2NjRmHQK2dBi+8xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750222443; c=relaxed/simple;
	bh=DEKlm+ejo/0mzszOUsL53ctVVQ1j4m3qewxhIFLcv0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLHbfGUo5xUWsK+obR0jTu9LzaVhRer8xUTjsnQPIWp8zreMJyysMT0TEERC53S5J92bZtpptOVk3bdIu2jaYfj89mMvYNSPUFVkNbj1fHuegPPi+TykYiJIQXVTFj7OgiPZ71LrmdSXCk9dkcYZuTQsiVWFxSPGzcAC/+wIW/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBmDeLa5; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBmDeLa5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750222441; x=1781758441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DEKlm+ejo/0mzszOUsL53ctVVQ1j4m3qewxhIFLcv0M=;
  b=aBmDeLa52izon3Pw2x1Sg9K9GJsDE8F0Ta/cPwgethzmwYQ5ZkiJmtHP
   1v0hz+npA9+kH3Aqkl7J0z3yTCzWlJxdR5oHDsXWWJeQen8LhM23wUZ4T
   3jL6paYgCv+RAFOnZYVEoWEuA+DXbPu0GXRaiOhDYWHKw6M7Q+C7BKkWb
   rVkG7MUMQZ7d+uAgLuM0UflEUaLrswCpxWWs/iC9g9p2MiAw111FU2z+h
   Xg9ZsjUhRhemA1l29QkA/hOGRrRJ9MLeEmzhLqCQdn1Frgwm6nzVhQh/9
   SQ3UColpFyv3vrbSlCyHvKeXArPcTdSKztItwoIocNYjyv6UnT7KSiA/7
   Q==;
X-CSE-ConnectionGUID: hIFTR1n+SQ2cpCzGnBwS/Q==
X-CSE-MsgGUID: EymeTMhZSaail8WpXmJX3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63460454"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="63460454"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 21:54:01 -0700
X-CSE-ConnectionGUID: IlMBVbuZTBeIdVORDtt5FA==
X-CSE-MsgGUID: fyNBzSTZSCeodXZuqA5+kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="149026086"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 17 Jun 2025 21:53:57 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uRko7-000JPW-1J;
	Wed, 18 Jun 2025 04:53:55 +0000
Date: Wed, 18 Jun 2025 12:53:41 +0800
From: kernel test robot <lkp@intel.com>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, p.zabel@pengutronix.de,
	mchehab@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
	kernel@collabora.com,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH 3/5] iommu: Add verisilicon IOMMU driver
Message-ID: <202506181230.D53QwmdL-lkp@intel.com>
References: <20250616145607.116639-4-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616145607.116639-4-benjamin.gaignard@collabora.com>

Hi Benjamin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on rockchip/for-next linus/master v6.16-rc2 next-20250617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Gaignard/dt-bindings-vendor-prefixes-Add-Verisilicon/20250616-225842
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20250616145607.116639-4-benjamin.gaignard%40collabora.com
patch subject: [PATCH 3/5] iommu: Add verisilicon IOMMU driver
config: arm64-randconfig-r111-20250618 (https://download.01.org/0day-ci/archive/20250618/202506181230.D53QwmdL-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 15.1.0
reproduce: (https://download.01.org/0day-ci/archive/20250618/202506181230.D53QwmdL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506181230.D53QwmdL-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iommu/vsi-iommu.c:890:24: sparse: sparse: symbol 'rockchip_vsi_iommu_driver' was not declared. Should it be static?

vim +/rockchip_vsi_iommu_driver +890 drivers/iommu/vsi-iommu.c

   889	
 > 890	struct platform_driver rockchip_vsi_iommu_driver = {

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
