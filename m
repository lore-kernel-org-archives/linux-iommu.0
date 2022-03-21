Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A10C433EF
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 02:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5352140101;
	Mon, 21 Mar 2022 02:54:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id glufcdi6_jPy; Mon, 21 Mar 2022 02:54:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 61339405A4;
	Mon, 21 Mar 2022 02:54:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4733AC001A;
	Mon, 21 Mar 2022 02:54:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 846AFC0082
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 02:53:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65DCF81303
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 02:53:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AX0xcAc_YtxA for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 02:53:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D70080F5C
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 02:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647831238; x=1679367238;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=d7KQds5beDpM3p/NihgSSHXqAj0QSPvdkhy43Lf5WgE=;
 b=k7/MDzlyZs1or9R+FIJUcS3adHRmdomnlhN3qmRwC4UaKTZwYLDSiRLd
 a8g4gXTr9DI8O6NNMXo2Tm4k15d8VvdP9S01je846pl15xLoPDzbAiwYu
 MHfiMqCxivwNLbrsJgWDHVagbSbdddwBfjUEUGTexWLhhmOUfaWAmcvY0
 qCvGqsX3bXahM5F6OpIDUcGmBzAXdBkQCgj7EirA1jULVI7Bck3mBTy12
 MwySMBnLzKbORbFKOykZGfgvBER0+7XO8dDEV4M0YpXWPDZDIMbk7mGmv
 J9WXizqbRguPmo2AGXP/VkJdH1CGxghSy+XNTgBw/qluvxC5V/13Wp9KU g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="256273874"
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; d="scan'208";a="256273874"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2022 19:53:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; d="scan'208";a="784852173"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
 by fmsmga006.fm.intel.com with ESMTP; 20 Mar 2022 19:53:54 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nW8B7-000HOp-TC; Mon, 21 Mar 2022 02:53:53 +0000
Date: Mon, 21 Mar 2022 10:52:43 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
 Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] iommu/amd: Add support to indicate whether DMA remap
 support is enabled
Message-ID: <202203211032.FSaAOkQt-lkp@intel.com>
References: <20220318223104.7049-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220318223104.7049-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kbuild-all@lists.01.org, Michael Jamet <michael.jamet@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
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
[also build test ERROR on v5.17 next-20220318]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Mario-Limonciello/iommu-amd-Add-support-to-indicate-whether-DMA-remap-support-is-enabled/20220319-063131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220321/202203211032.FSaAOkQt-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/105690537e561d997e376617aa6a7d6d7b74a6a6
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mario-Limonciello/iommu-amd-Add-support-to-indicate-whether-DMA-remap-support-is-enabled/20220319-063131
        git checkout 105690537e561d997e376617aa6a7d6d7b74a6a6
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/iommu/amd/iommu.c: In function 'amd_iommu_capable':
>> drivers/iommu/amd/iommu.c:2165:7: error: 'IOMMU_CAP_PRE_BOOT_PROTECTION' undeclared (first use in this function)
    2165 |  case IOMMU_CAP_PRE_BOOT_PROTECTION:
         |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/amd/iommu.c:2165:7: note: each undeclared identifier is reported only once for each function it appears in


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
