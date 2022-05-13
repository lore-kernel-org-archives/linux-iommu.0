Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C97BC433EF
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 02:43:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB46241730;
	Fri, 13 May 2022 02:43:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id md8rF9loBKeq; Fri, 13 May 2022 02:43:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E8C344170E;
	Fri, 13 May 2022 02:43:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BAB0BC0032;
	Fri, 13 May 2022 02:43:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E0DBC002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 02:43:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1798760B25
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 02:43:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ou96-_cu_1Mv for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 02:43:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2E909607FE
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 02:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652409811; x=1683945811;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+cUtYQK4Km2C++rGq/ah79HG9mDpGf2y1yRstGxDmSo=;
 b=CLIEJdttLFmo70jGG/g1HslKRHVgZd6B+RpSGTQkquIu/6mbc6W8IfB3
 EJvSaf2UCtxWLsUIsQxhYwFY9hW2jl13iyn6D6JwekwQNA6m+cLstopi4
 2tqcJZNq+HXXqlTwwAA8A3v8wRv7fUbnPzAE129BazsP3t4GmuOrJufgC
 nQkf0tw0uAcXwoGiuAXIyWnXaE2XEb+QwCY9TleO9plso4Vph5XdCts0W
 xYcP7TMZIzpviNKKnvjpFVaQhrr/NG4y9AieEDzWyt6Qw5zmb+qKZJIM/
 Dfr0xWwcbpO+ZZhyCHnN820VwUDlVREsybjFyK31ULKUcXxMX3rRbsuj2 Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="333230776"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; d="scan'208";a="333230776"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2022 19:43:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; d="scan'208";a="566987110"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
 by orsmga007.jf.intel.com with ESMTP; 12 May 2022 19:43:26 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1npLH3-000LCz-Bl;
 Fri, 13 May 2022 02:43:25 +0000
Date: Fri, 13 May 2022 10:43:03 +0800
From: kernel test robot <lkp@intel.com>
To: yf.wang@mediatek.com, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 Georgi Djakov <quic_c_gdjako@quicinc.com>, Sven Peter <sven@svenpeter.dev>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v3 1/2] iommu/io-pgtable-arm-v7s: Add a quirk to allow
 pgtable PA up to 35bit
Message-ID: <202205131021.3GskEbg2-lkp@intel.com>
References: <20220512144557.18025-2-yf.wang@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220512144557.18025-2-yf.wang@mediatek.com>
Cc: Ning Li <ning.li@mediatek.com>, kbuild-all@lists.01.org,
 Libo Kang <Libo.Kang@mediatek.com>, wsd_upstream@mediatek.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on arm-perf/for-next/perf]
[also build test WARNING on linus/master v5.18-rc6]
[cannot apply to joro-iommu/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/yf-wang-mediatek-com/iommu-io-pgtable-arm-v7s-Add-a-quirk-to-allow-pgtable-PA-up-to-35bit/20220512-234603
base:   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-next/perf
config: arm-qcom_defconfig (https://download.01.org/0day-ci/archive/20220513/202205131021.3GskEbg2-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/916a5fc41cbb8ddfe343193598f250d06b09e3fa
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review yf-wang-mediatek-com/iommu-io-pgtable-arm-v7s-Add-a-quirk-to-allow-pgtable-PA-up-to-35bit/20220512-234603
        git checkout 916a5fc41cbb8ddfe343193598f250d06b09e3fa
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/iommu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/ratelimit_types.h:5,
                    from include/linux/ratelimit.h:5,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:7,
                    from drivers/iommu/io-pgtable-arm-v7s.c:25:
   drivers/iommu/io-pgtable-arm-v7s.c: In function 'arm_v7s_alloc_pgtable':
   include/linux/bits.h:35:29: warning: left shift count >= width of type [-Wshift-count-overflow]
      35 |         (((~UL(0)) - (UL(1) << (l)) + 1) & \
         |                             ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/iommu/io-pgtable-arm-v7s.c:154:46: note: in expansion of macro 'GENMASK'
     154 |         ((ttbr & ((u32)(~0U << 3))) | ((pa & GENMASK(34, 32)) >> 32))
         |                                              ^~~~~~~
   drivers/iommu/io-pgtable-arm-v7s.c:886:25: note: in expansion of macro 'ARM_V7S_TTBR_35BIT_PA'
     886 |                         ARM_V7S_TTBR_35BIT_PA(cfg->arm_v7s_cfg.ttbr, paddr);
         |                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:36:18: warning: right shift count is negative [-Wshift-count-negative]
      36 |          (~UL(0) >> (BITS_PER_LONG - 1 - (h))))
         |                  ^~
   include/linux/bits.h:38:38: note: in expansion of macro '__GENMASK'
      38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/iommu/io-pgtable-arm-v7s.c:154:46: note: in expansion of macro 'GENMASK'
     154 |         ((ttbr & ((u32)(~0U << 3))) | ((pa & GENMASK(34, 32)) >> 32))
         |                                              ^~~~~~~
   drivers/iommu/io-pgtable-arm-v7s.c:886:25: note: in expansion of macro 'ARM_V7S_TTBR_35BIT_PA'
     886 |                         ARM_V7S_TTBR_35BIT_PA(cfg->arm_v7s_cfg.ttbr, paddr);
         |                         ^~~~~~~~~~~~~~~~~~~~~
>> drivers/iommu/io-pgtable-arm-v7s.c:154:63: warning: right shift count >= width of type [-Wshift-count-overflow]
     154 |         ((ttbr & ((u32)(~0U << 3))) | ((pa & GENMASK(34, 32)) >> 32))
         |                                                               ^~
   drivers/iommu/io-pgtable-arm-v7s.c:886:25: note: in expansion of macro 'ARM_V7S_TTBR_35BIT_PA'
     886 |                         ARM_V7S_TTBR_35BIT_PA(cfg->arm_v7s_cfg.ttbr, paddr);
         |                         ^~~~~~~~~~~~~~~~~~~~~


vim +154 drivers/iommu/io-pgtable-arm-v7s.c

   145	
   146	#define ARM_V7S_TTBR_S			BIT(1)
   147	#define ARM_V7S_TTBR_NOS		BIT(5)
   148	#define ARM_V7S_TTBR_ORGN_ATTR(attr)	(((attr) & 0x3) << 3)
   149	#define ARM_V7S_TTBR_IRGN_ATTR(attr)					\
   150		((((attr) & 0x1) << 6) | (((attr) & 0x2) >> 1))
   151	
   152	/* Mediatek extend ttbr bits[2:0] for PA bits[34:32] */
   153	#define ARM_V7S_TTBR_35BIT_PA(ttbr, pa)					\
 > 154		((ttbr & ((u32)(~0U << 3))) | ((pa & GENMASK(34, 32)) >> 32))
   155	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
