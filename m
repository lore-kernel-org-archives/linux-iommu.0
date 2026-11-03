Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694319;
	b=mRsnCuFvIFrAanjvV3wtpsqHftI0j7k06ohPoP4Z3eY7J8+j2jbKARu4hadhFM9KCa41
	 M/UEJpYf5BdsALA49jy3JUFOb4sbvkttMcRXbIQAOXU3t+H4CJMhFl2tiwQz1r146kitm
	 ym0hp3Iw3PE/Tpd92HozdN7P6YogZOOz/JEpDBwEGpjEAznAh35j1hmDhHXf5gvqWYilN
	 kVS6VZ5xO+W4UhpbQBIF/vMje0P1DA/x+UywmxOU8DjWjNJeGDQ8Df3IB1o660RGWw1Ag
	 9rPsa0V+qLupmQVEBNcG1bfZEZPW6YlGt8fjNpItZ2MqQut0PriY+/NvAz2v4SoA1fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694319;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=C/3oiEJrrgISDj6VHltYxSNS0bTbSGPe28QqrXWzDyw=;
	b=URkqdCZCBi6zK0qKdjzkNZRtHK+qJb3zZV1DKsBr5+lh8tEBeMjOtc056bp/y3SlsqtZ
	 xTlgjGiORQpg8P6IfbeTVOVr3UY1dOF2y2W623J7vNKrqpvHi4To+cbxuL5OSPdcQDsps
	 5uvAOVTKTQF/ZUwnOItuGYCeD74lgnZIJloFUC+g8olI8zZzdSdM6iAzzAwKMW3ByMaeb
	 aLoH6WcEdEEd+yQAGhXmuFGrJxiOsyefJLv0Kvg5Vr2mRMIKMoA4K4YQ7GNzEckDbzFbM
	 vYSwhGZiXdmGpFuDZ6cQUEx9rEuLbESjEX3kZsn4hlrTDFnBQn/rlPdxABRtBnjuYzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mxsWwFZ+;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E05A606A331;
	Tue,  3 Nov 2026 08:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E05A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mxsWwFZ+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793694317; x=1825230317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UnGE9ewV3SGTBwGzdYg4KybWaWjSn9+eL7CYGNT63s8=;
  b=mxsWwFZ+MA4sn0TcP2mJ2vMFigrF5jwawZ4pHwvQb+Rv5Y10hPwDRJFW
   YUvvenKpLmN62ZGXyT0JFfDzYNXTUKcjORk4HHQdbVlr/fERbCY0AzDH1
   HLQjceQ3k7UoGGdtOERFQ0ANUZvIgpex6TuxOB3OJaDj8CsUONVN6bNYd
   tWa90wKfFMZ/IOdV0TjNPRCrOfVzUr+4o1lm6BAIcb6G+C6fKpztZudov
   IjLeAZRVJWyNz+JuHXfwgBcqYJO2CVvBEX3kfpEIPN4Ah7YM8bgRjLz67
   D+4I/sjrWQEsSxJoAjxG9xOARC/yRbU2F8XN1dc1fYgINWGJNlH8WwAWi
   Q==;
X-CSE-ConnectionGUID: NbIoqSwNQo67mAhymMhS7w==
X-CSE-MsgGUID: iXa/LJ9sQHyOpH74zuOW6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2287621"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2287621"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 00:25:17 -0800
X-CSE-ConnectionGUID: ZHqYrjrJRoCXZA6PU6ZdQg==
X-CSE-MsgGUID: jrcaaq4rQHOdXmodazj03A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6740307"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 03 Nov 2026 00:25:12 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xO9pN-00000000iUO-0oT5;
	Tue, 03 Nov 2026 08:25:09 +0000
Date: Tue, 3 Nov 2026 16:24:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Frank Li <Frank.Li@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Larisa IIeana Grigore <larisa.grigore@nxp.com>, imx@lists.linux.dev,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-tegra@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3 6/7] dmaengine: fsl-edma: support per-channel DT child
 nodes
Message-ID: <202611031650.EONIRpF4-lkp@intel.com>
References: <20261102-edma-iommu-v3-v3-6-9d0e62a954eb@Example.Com>
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
In-Reply-To: <20261102-edma-iommu-v3-v3-6-9d0e62a954eb@Example.Com>

Hi Peng,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/dmaengine-fsl-edma-unregister-channels-before-vchan-cleanup/20261102-144955
base:   6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
patch link:    https://lore.kernel.org/r/20261102-edma-iommu-v3-v3-6-9d0e62a954eb%40Example.Com
patch subject: [PATCH v3 6/7] dmaengine: fsl-edma: support per-channel DT child nodes
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20261103/202611031650.EONIRpF4-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611031650.EONIRpF4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611031650.EONIRpF4-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/dma/fsl-edma.ko: symbol '__udivdi3' undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
