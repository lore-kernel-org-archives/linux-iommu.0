Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CFBC433FE
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 02:54:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89E49402AA;
	Mon, 21 Mar 2022 02:54:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id auKteLPIz4_9; Mon, 21 Mar 2022 02:53:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 41A2840263;
	Mon, 21 Mar 2022 02:53:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00A47C001A;
	Mon, 21 Mar 2022 02:53:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B050C000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 02:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 04A208128E
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 02:53:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aLWkJDRU-Yb8 for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 02:53:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 67D5980F5C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 02:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647831236; x=1679367236;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qFCBBl+Sw+dHadJW+S6qeiLknxva1nkER2nqihe0HKQ=;
 b=OXrUfc3h7S5l8XQ+l2bdmnUvvPRRlnkZaQU7zSTwXyogCe7cBtTvnPO1
 af3p0zJ68I83oLhPBXO4xmdGetXjd7P99z3zEzklCIZHUm/p4d/O2u7Xo
 LLDk3+vCd4al64rviv3UoABbFmAAk4RgLZU5TA12jC6nv/KwvxFhro5pH
 KZzK43Ze26YmBXH/7Otjj3RjPg6Ro6fclbuqTW9r1OPw3pSXiEDOR22tl
 f2kwz9Fx431RO50Z7yffcghL9bO4QGIUM2fW4p8G61c2vTxiH/sz/jPyJ
 pMN2AHtnp7PyD0P8KS3ruV1q155ydfIK3zph0hUxAm07NGPr3v67Ogjd+ A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="257402706"
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; d="scan'208";a="257402706"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2022 19:53:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; d="scan'208";a="600335412"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by fmsmga008.fm.intel.com with ESMTP; 20 Mar 2022 19:53:51 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nW8B4-000HOm-GE; Mon, 21 Mar 2022 02:53:50 +0000
Date: Mon, 21 Mar 2022 10:52:47 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] iommu/amd: Add support to indicate whether DMA remap
 support is enabled
Message-ID: <202203211052.WEPydSQ9-lkp@intel.com>
References: <20220318223104.7049-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220318223104.7049-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
 kbuild-all@lists.01.org, Michael Jamet <michael.jamet@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, llvm@lists.linux.dev,
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
[also build test ERROR on v5.17 next-20220318]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Mario-Limonciello/iommu-amd-Add-support-to-indicate-whether-DMA-remap-support-is-enabled/20220319-063131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: x86_64-buildonly-randconfig-r004-20220321 (https://download.01.org/0day-ci/archive/20220321/202203211052.WEPydSQ9-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 85e9b2687a13d1908aa86d1b89c5ce398a06cd39)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/105690537e561d997e376617aa6a7d6d7b74a6a6
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mario-Limonciello/iommu-amd-Add-support-to-indicate-whether-DMA-remap-support-is-enabled/20220319-063131
        git checkout 105690537e561d997e376617aa6a7d6d7b74a6a6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/iommu/amd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iommu/amd/iommu.c:2165:7: error: use of undeclared identifier 'IOMMU_CAP_PRE_BOOT_PROTECTION'
           case IOMMU_CAP_PRE_BOOT_PROTECTION:
                ^
   1 error generated.


vim +/IOMMU_CAP_PRE_BOOT_PROTECTION +2165 drivers/iommu/amd/iommu.c

  2155	
  2156	static bool amd_iommu_capable(enum iommu_cap cap)
  2157	{
  2158		switch (cap) {
  2159		case IOMMU_CAP_CACHE_COHERENCY:
  2160			return true;
  2161		case IOMMU_CAP_INTR_REMAP:
  2162			return (irq_remapping_enabled == 1);
  2163		case IOMMU_CAP_NOEXEC:
  2164			return false;
> 2165		case IOMMU_CAP_PRE_BOOT_PROTECTION:
  2166			return amdr_ivrs_remap_support;
  2167		default:
  2168			break;
  2169		}
  2170	
  2171		return false;
  2172	}
  2173	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
