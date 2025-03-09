Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F033209;
	Sun,  9 Mar 2025 03:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741489969; cv=none; b=h+sh1gd7beucuEoi6XsqqVxWsS+gZVEPmlNdIBE9QmTIQaMY6yKMAnVwJHZta4ag+kjPTGewvB4XMVbxDlUpyaA8eo0wHZRTNy5riLrGmofmPTKs1EeZz7WFS7GCSW5PT6sv0F22OJ347rAugiv/qY7n75837GonPvq/ngp5j0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741489969; c=relaxed/simple;
	bh=DHi9MJPnGZGRDihEky9eZ9K5pTtJu5JwGfbsXs63aYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7GcWyr5dNjcMBzc7fpBZMY9ITm7WnTB2aJ1Z3nPMMJZhgnxyu/SfJuquhSoIlRucATdnVg/h0Zu2KgoVa1Ni4iDfKlCUs62X23Yix0ip8NQbuy6NskZTYitCIJeCXriFzO24JEQCtFDkPjgAQhuu8Yt5+8pXzIuIiCSbqcPSUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHYqUUTt; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHYqUUTt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741489968; x=1773025968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DHi9MJPnGZGRDihEky9eZ9K5pTtJu5JwGfbsXs63aYM=;
  b=ZHYqUUTts+vqJUrt3xOJdH+jr3CsKOgyhEpTPNeEK9isI78jW9M3Rhuk
   MfE/2my59jzYhMZRuT5+4lK8yscTiRRLJhZVy7TruHADvXn9udxmIR3Mm
   pX3qcSiVqKXUe8DEkTWK9AcbvgWKeg0Diw5asSTWa4TELkfY1/xCZKuUl
   2jVjWWjaFB6KsiHKRkxkYwr1uKJOut5sYeBvYQcB+xkJ/owAj/zokNRXB
   hadKI0/qbixoXsKxB+xkMm8EQjTwR3rGEGiCxV4NmlEpIiJ2J1bSpniX5
   eFuXLXMRP05zZ+bsD1D0bAMYeO1FJqRfSwpOdFSklLLx6Wm8EylO4SbDd
   g==;
X-CSE-ConnectionGUID: rR5p/5kbShW9jiIUGPwGRg==
X-CSE-MsgGUID: Z0Rki/08Sgqc5x3iNmI0kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="46422511"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="46422511"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 19:12:47 -0800
X-CSE-ConnectionGUID: DqzgJJ8mTwWR1tSSMsjUwA==
X-CSE-MsgGUID: YMO4U9C0R/6Uf0PY2hDqTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="119656338"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 08 Mar 2025 19:12:41 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tr75i-0002bY-13;
	Sun, 09 Mar 2025 03:12:38 +0000
Date: Sun, 9 Mar 2025 11:12:14 +0800
From: kernel test robot <lkp@intel.com>
To: Dmitry Baryshkov <lumag@kernel.org>, Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Krishna Manikandan <quic_mkrishn@quicinc.com>,
	Jonathan Marek <jonathan@marek.ca>,
	Bjorn Andersson <andersson@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/10] drm/msm/mdss: add SAR2130P device configuration
Message-ID: <202503091045.4UVScL8t-lkp@intel.com>
References: <20250308-sar2130p-display-v1-6-1d4c30f43822@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250308-sar2130p-display-v1-6-1d4c30f43822@linaro.org>

Hi Dmitry,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0a2f889128969dab41861b6e40111aa03dc57014]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Baryshkov/dt-bindings-display-msm-dp-controller-describe-SAR2130P/20250308-094544
base:   0a2f889128969dab41861b6e40111aa03dc57014
patch link:    https://lore.kernel.org/r/20250308-sar2130p-display-v1-6-1d4c30f43822%40linaro.org
patch subject: [PATCH 06/10] drm/msm/mdss: add SAR2130P device configuration
config: arm-randconfig-004-20250309 (https://download.01.org/0day-ci/archive/20250309/202503091045.4UVScL8t-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250309/202503091045.4UVScL8t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503091045.4UVScL8t-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/msm/msm_mdss.c:599:10: error: 'const struct msm_mdss_data' has no member named 'ubwc_static'
     599 |         .ubwc_static = 1,
         |          ^~~~~~~~~~~
   drivers/gpu/drm/msm/msm_mdss.c:600:29: warning: initialized field overwritten [-Woverride-init]
     600 |         .highest_bank_bit = 0,
         |                             ^
   drivers/gpu/drm/msm/msm_mdss.c:600:29: note: (near initialization for 'sar2130p_data.highest_bank_bit')


vim +599 drivers/gpu/drm/msm/msm_mdss.c

   594	
   595	static const struct msm_mdss_data sar2130p_data = {
   596		.ubwc_enc_version = UBWC_3_0, /* 4.0.2 in hw */
   597		.ubwc_dec_version = UBWC_4_3,
   598		.ubwc_swizzle = 6,
 > 599		.ubwc_static = 1,
   600		.highest_bank_bit = 0,
   601		.macrotile_mode = 1,
   602		.reg_bus_bw = 74000,
   603	};
   604	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
