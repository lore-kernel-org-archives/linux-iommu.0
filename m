Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE87C433FE
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 00:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 37A4E8428F;
	Wed, 16 Mar 2022 00:51:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id al3UNRLQbfZf; Wed, 16 Mar 2022 00:51:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0D8678424C;
	Wed, 16 Mar 2022 00:51:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D3460C001D;
	Wed, 16 Mar 2022 00:51:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53871C0012
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 00:51:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F1218424D
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 00:51:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BLfI9eKn0cKl for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 00:51:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2C8EE8424C
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 00:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647391892; x=1678927892;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=YXFKpERtBJQFxnnvLc21al+Vghk+4iLs8WPaY6XgGEQ=;
 b=OAnngdi9oh2AeneZiD1tZm5q+Pn269/V5eCsaPHWqqRLz197rwrIfMYw
 R2UjzsLJ5vLEvSXSzgCmYP5a1X/z/XzVtr6ee4n91QO1cIOjq+hby69zc
 H/Xbv8pTZb1tUtFZwnNEQ5TyM/NegUGbix+k46zTAKrkcBdqUrTSiB8Go
 51p9qgQIAlWg28yQquob5oNc7A99kUXKSRJS3Wh+IJDkZ221Mq6Hncan3
 inz/IfmduQ6kSJh0tczj+dxlR2mHVB8ge0okg9HVsMG54GClezou+SxF5
 0e22/4eRVhhniB/CO4HhyUwx6WoGD4uR5AvlKeMsT4zYMrdAc/0uelFbv w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="236402494"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; d="scan'208";a="236402494"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 17:51:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; d="scan'208";a="714391253"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by orsmga005.jf.intel.com with ESMTP; 15 Mar 2022 17:51:28 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nUHst-000Bj2-F4; Wed, 16 Mar 2022 00:51:27 +0000
Date: Wed, 16 Mar 2022 08:51:16 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/2] iommu/amd: Add support to indicate whether DMA remap
 support is enabled
Message-ID: <202203160844.lKviWR1Q-lkp@intel.com>
References: <20220315162455.5190-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220315162455.5190-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kbuild-all@lists.01.org, Michael Jamet <michael.jamet@intel.com>,
 "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
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
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220316/202203160844.lKviWR1Q-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/fa63035401902e438c5ef3213112901a1054c621
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mario-Limonciello/iommu-amd-Add-support-to-indicate-whether-DMA-remap-support-is-enabled/20220316-002821
        git checkout fa63035401902e438c5ef3213112901a1054c621
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iommu/amd/init.c:3294:6: error: redefinition of 'amd_ivrs_remap_support'
    3294 | bool amd_ivrs_remap_support(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/iommu/amd/init.c:20:
   include/linux/amd-iommu.h:198:20: note: previous definition of 'amd_ivrs_remap_support' was here
     198 | static inline bool amd_ivrs_remap_support(void)
         |                    ^~~~~~~~~~~~~~~~~~~~~~


vim +/amd_ivrs_remap_support +3294 drivers/iommu/amd/init.c

  3284	
  3285	/*
  3286	 * ivrs_remap_support - Is %IOMMU_IVINFO_DMA_REMAP set in IVRS table
  3287	 *
  3288	 * Returns true if the platform has %IOMMU_IVINFO_DMA_REMAP% set in the IOMMU
  3289	 * IVRS IVInfo field.
  3290	 * Presence of this flag indicates to the OS/HV that the IOMMU is used for
  3291	 * Preboot DMA protection and device accessed memory should be remapped after
  3292	 * the OS has loaded.
  3293	 */
> 3294	bool amd_ivrs_remap_support(void)
  3295	{
  3296		return amdr_ivrs_remap_support;
  3297	}
  3298	EXPORT_SYMBOL_GPL(amd_ivrs_remap_support);
  3299	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
