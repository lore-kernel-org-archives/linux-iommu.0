Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A6EC433F5
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 01:33:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EDEAB4014E;
	Wed, 16 Mar 2022 01:33:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vMvKhWsy8_87; Wed, 16 Mar 2022 01:33:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9B04B40592;
	Wed, 16 Mar 2022 01:33:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55D7AC001A;
	Wed, 16 Mar 2022 01:33:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F01F7C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 01:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D80DE41715
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 01:33:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kIxzRQ45zKdC for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 01:33:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84C6B41635
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 01:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647394415; x=1678930415;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xAHtXDDav9BrhYDuigVnMmC1A+VvTM+jKpTIjJx+T54=;
 b=No5L+gykqVV4ix9o2A3UnhQqKnpcLOp86V/EfF+gddP1uzAU8LFvivqW
 DXFpIA5jzXoToplYQxIgmJPuxmtx1I9zPK1z1ukSPTLJck6bhbE35MHQT
 iAgs89jrYnVLr4WyrmMhJ3JyKbqOY2fosNeL5utV1U9ujx5F7pLtSWSI3
 1aSZpgJb4ibd/HXI3OKJE5j7RZukpmqqSrVVn3EdDq52jfWBw55tbjnHW
 yuj3Eol49Jfkex9WLna8Uw2qVNSnPO1YpyuPUpDrEaho7D/JtNj0hMO7y
 9i36wYJKZKKsXx+BoZvBa1XkiXYmocW95JdpicibFfP8zgLxuqhieaIr4 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256653006"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; d="scan'208";a="256653006"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 18:33:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; d="scan'208";a="646451611"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by orsmga004.jf.intel.com with ESMTP; 15 Mar 2022 18:33:31 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nUIXa-000BlM-8n; Wed, 16 Mar 2022 01:33:30 +0000
Date: Wed, 16 Mar 2022 09:32:41 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] thunderbolt: Use pre-boot DMA protection on AMD
 systems
Message-ID: <202203160904.VB4alCdg-lkp@intel.com>
References: <20220315162455.5190-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220315162455.5190-2-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
 kbuild-all@lists.01.org, Michael Jamet <michael.jamet@intel.com>,
 llvm@lists.linux.dev, open list <linux-kernel@vger.kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 "open list:AMD IOMMU \(AMD-VI\)" <iommu@lists.linux-foundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Andreas Noever <andreas.noever@gmail.com>, Will Deacon <will@kernel.org>
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

Hi Mario,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on joro-iommu/next]
[also build test ERROR on arm-perf/for-next/perf linus/master v5.17-rc8 next-20220315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Mario-Limonciello/iommu-amd-Add-support-to-indicate-whether-DMA-remap-support-is-enabled/20220316-002821
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220316/202203160904.VB4alCdg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6b2f50fb47da3baeee10b1906da6e30ac5d26ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/9b0b7079d348c607cba7af4c87eaae1a79e52d91
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mario-Limonciello/iommu-amd-Add-support-to-indicate-whether-DMA-remap-support-is-enabled/20220316-002821
        git checkout 9b0b7079d348c607cba7af4c87eaae1a79e52d91
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/thunderbolt/domain.c:9:
>> include/linux/amd-iommu.h:159:52: error: use of undeclared identifier 'ENODEV'
   static inline int amd_iommu_detect(void) { return -ENODEV; }
                                                      ^
   1 error generated.


vim +/ENODEV +159 include/linux/amd-iommu.h

6a9401a7ac13e6 arch/x86/include/asm/amd_iommu.h Joerg Roedel          2009-11-20  158  
480125ba49ba62 arch/x86/include/asm/amd_iommu.h Konrad Rzeszutek Wilk 2010-08-26 @159  static inline int amd_iommu_detect(void) { return -ENODEV; }
6a9401a7ac13e6 arch/x86/include/asm/amd_iommu.h Joerg Roedel          2009-11-20  160  

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
