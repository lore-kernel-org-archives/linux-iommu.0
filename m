Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714550;
	b=iJbKsFpaj/GdH5JLCNAK0KPScJobKhxDc2Jv+BY3uLzct3HCjvON4oeqpJM6oCsPB8Vn
	 t/rlfKvqDpc06TFTQzK7vQsS9ovOLBy9q8yHtIpZ/fOFl9D2uOc96C+8qck9cJBsHkyem
	 PfreRIosVE4X9dN19pFw+RfheB5WDTM4dTZirO8xz1dsgn3G+AtTe+9MzmzFb1SSkOFF8
	 +tEbAxLkFPdULWRzr08wRmlXv5036guEoJ+69DUHPViUmnNBfctQHn+/Te4eaBUle2ssc
	 W43zv68rwdkyZLT4OPpOSi1TqF71AUvqS4DDZ187vDS7eHb5gKBtq6aCslclCDCHxsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714550;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=U2kSEVRi2hxXG2GFOz4rcCNrV0dltOZ+Pl3QkTNM8Pc=;
	b=XQ++BGVEj8Zn12NIQghkGTA/73c5aAeRLxbaAPXWf2nxZBS3Kl0k6y47Uww/IKw8w/Bf
	 7y9AKhgCFKh1w71QNeI1p8ICEj8fFHXFbwyUcDpJAM3EUWkmW7UmrvcSUkrzaNrzCG4C/
	 h076geQQeqLBEK9Su+63uystyzdaS7DDx+zUgmJx5I9Cip9AUXLHjImu21+RkaAHShuoa
	 naFQUQ/gIp4X+7gGyVug90bqSClIV6MppBR52FdmDnjT/6SyeQcQ2SGRMAXAkxpaXMXdu
	 4sDs4Bpf2tXzGpH79E31ImgThLEyxfYLi9SqNRy36ZGWt/YZTGf6A5Jq68aNLZ0oeQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dIF4YyTT;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E103860A2603;
	Tue,  3 Nov 2026 14:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E103860A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dIF4YyTT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793714550; x=1825250550;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=21/dBFytCw06WfTSnztehqTIWH3fJ3UemgDQsPHVjOg=;
  b=dIF4YyTTboUQu6daqPnfWosES/Wzgd0ka1i2WrKovstKerg+u4FtzG4W
   ttQS8E85prPFCELWsKszsgi09I5X3USCSH0r4zMDZSHXynHAQZEFwibTy
   EpHSa8vFjcnNJKR1I/Soj2WxKNs6XilV1IIWKgxlNIfcgHLFpac7mnggK
   TR+eTILL25+7ql4HtU9DCZzYKL7YAzD15JC/ya1qxfLYgbsi/8d0biyRR
   iz/l4jYyi826GrAiGW0zCimDhckuksSKdXGcQlUJN//d+Y9BiWkgUaQgV
   zaIafSor9ZznlTRH8+w/7F4J/B65TDKNZpffhxYETYir1R88hxnywispV
   A==;
X-CSE-ConnectionGUID: FaIns5gURJiZZVOAuKOp0A==
X-CSE-MsgGUID: GYIq29CHS+OlHoCKYoTlnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2329161"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2329161"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 06:02:29 -0800
X-CSE-ConnectionGUID: Y42j3A5eTQ6QKttsrzyCkA==
X-CSE-MsgGUID: 5M+a3Yp+QLeE0Ajy1Oi1EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6755557"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 03 Nov 2026 06:02:23 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOF5g-00000000ioO-0URQ;
	Tue, 03 Nov 2026 14:02:20 +0000
Date: Tue, 3 Nov 2026 22:01:24 +0800
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
Message-ID: <202611032138.hVbEmkem-lkp@intel.com>
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
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20261103/202611032138.hVbEmkem-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611032138.hVbEmkem-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611032138.hVbEmkem-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/dma/fsl-edma-main.o: in function `fsl_edma_child_to_chan_id.isra.0':
>> fsl-edma-main.c:(.text+0xa99): undefined reference to `__udivdi3'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
