Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E5E17BD6;
	Sun,  9 Mar 2025 03:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741489296; cv=none; b=fgR17b8ynGs54CZ9b8zJd8DGpntHIb9IhBribYDcnrTNgYbDQQfS74AZSGJvuKSAxjAFl8dm++dr6xV+XevhesXw9UF6gjKr3sNXWLXasOgEXbFvAN5rvAGrETr7y+4W4WfqpOUmjujGyi0jVkC4rOwn76fE89gG+RXvawGRpsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741489296; c=relaxed/simple;
	bh=IVS3L5J251tbHNugEZ3AM4WfhMC0Zjdnd3Dl1hMO1o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=met3arJToEKCF341zQOvI0U4/J0AN5RdmxwLxMk1K2Xi+AjlolLEl8q2GNDU3JQ+E1hjxls+pZozwW1Br9srVJtm5AONXuZK0C2c+IxttX2XkKtvmB5xXJulZLOEpTeth2V6xv3KJTTTSuCa9cmxAP8w5lSuwSHBMKe55pijGW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrLdCJov; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrLdCJov"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741489294; x=1773025294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IVS3L5J251tbHNugEZ3AM4WfhMC0Zjdnd3Dl1hMO1o4=;
  b=IrLdCJov/vuzFQu+S6ObguXMEOLk72PvmmgoEW/1nuxbzE5P6wrjg29Q
   lDJKKo+Cj46O8xWzda1cXLo1I1cGFPq+5yuw++TfVYBWqp0WlPx8SyhV3
   MgIcvHgTTNBhjz9OAxbxhD1nHR9fQ6Gf4jxkaTdMn3bkmnoGvUytb5Qvl
   1XjHPat7xRvXBUXT5eMg9uiDg5mzP7DW15fte1XdQ0Mm/k1xZBplo9Was
   SBH5NTkrKCePdm/zOZ+cZubIHEFYByA6wvwSArDg3ypleRjnNtAYdPcni
   d6SrzXgAKxDRQ4fRKba9WBfi9A+nf4h+6bXSLyPz7vwupOKvOEPvZq7G0
   A==;
X-CSE-ConnectionGUID: bdgFgtXgR3yUrw8QOTIQSw==
X-CSE-MsgGUID: YWVMeJJNRjCsoZZy7nem+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="46422268"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="46422268"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 19:01:34 -0800
X-CSE-ConnectionGUID: 7SGGoZ+fS2+Az4L8zuyXfw==
X-CSE-MsgGUID: fcPirFXBQJGdbTUBxsPpng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="119408689"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 08 Mar 2025 19:01:28 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tr6ur-0002b0-1Z;
	Sun, 09 Mar 2025 03:01:25 +0000
Date: Sun, 9 Mar 2025 11:01:06 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 06/10] drm/msm/mdss: add SAR2130P device configuration
Message-ID: <202503091011.Kwbj8DQz-lkp@intel.com>
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
config: arm64-randconfig-001-20250309 (https://download.01.org/0day-ci/archive/20250309/202503091011.Kwbj8DQz-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250309/202503091011.Kwbj8DQz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503091011.Kwbj8DQz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/gpu/drm/msm/msm_mdss.c:599:3: error: field designator 'ubwc_static' does not refer to any field in type 'const struct msm_mdss_data'
           .ubwc_static = 1,
            ^
   1 error generated.


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
