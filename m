Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0B5C433F5
	for <iommu@archiver.kernel.org>; Tue,  1 Feb 2022 07:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C23860F1F;
	Tue,  1 Feb 2022 07:01:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LAxYvGsyjfh6; Tue,  1 Feb 2022 07:01:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1031360B00;
	Tue,  1 Feb 2022 07:01:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3738C001A;
	Tue,  1 Feb 2022 07:01:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D6A5C000B
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 07:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C7904158B
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 07:01:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5MCkTvmWXmYM for <iommu@lists.linux-foundation.org>;
 Tue,  1 Feb 2022 07:01:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6EDAD41590
 for <iommu@lists.linux-foundation.org>; Tue,  1 Feb 2022 07:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1643698886; x=1675234886;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jRNs7ogHWPGoLBMk4Bb5fE9HNjneVYvi8uKyHW569M4=;
 b=CLUb5T/Ih/geyATsMU4HgzdzJeUZGgaisXbUzY5f3GhLaPlK5yWirmLo
 830Jd9WnZ7f68hFnTXTEx+mr/sZHv3ie+VOz1W0p1V68q3UFQlTEzhfw8
 Ka//lkjwqOdPIy06tw+JetFJpQHzb7nKPlgJcTLZ+6z2t7CldRKDjf5OR
 WI4SNfpAQ0co9ekQmjJw56+TwRsnOoRSgS/1+wSBDY1U9GCWceJ9kGKK3
 D1s7K3CwJJCQo7XdoMi5TXQ1ZZGY/5DLS/jcIBXS1mzFSiqBRNrO0W9Qn
 nIN6SqVuYbEgB5L4ICrquzvFGCOQrvcFTP/cALFC229dN/8eDWh2K9pcS Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="227605194"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; d="scan'208";a="227605194"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2022 23:01:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; d="scan'208";a="768845209"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
 by fmsmga006.fm.intel.com with ESMTP; 31 Jan 2022 23:01:23 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nEnAI-000SvW-VH; Tue, 01 Feb 2022 07:01:22 +0000
Date: Tue, 1 Feb 2022 15:01:19 +0800
From: kernel test robot <lkp@intel.com>
To: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/amd: Fix loop timeout issue in iommu_ga_log_enable()
Message-ID: <202202011448.2UFIiZHD-lkp@intel.com>
References: <20220131161749.4021-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220131161749.4021-1-joro@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
 Maxim Levitsky <mlevitsk@redhat.com>, Will Deacon <will@kernel.org>
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

Hi Joerg,

I love your patch! Yet something to improve:

[auto build test ERROR on joro-iommu/next]
[also build test ERROR on v5.17-rc2 next-20220131]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Joerg-Roedel/iommu-amd-Fix-loop-timeout-issue-in-iommu_ga_log_enable/20220201-002214
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220201/202202011448.2UFIiZHD-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/5b5785526da0e2a6e793d2107d09afc9f310f17f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Joerg-Roedel/iommu-amd-Fix-loop-timeout-issue-in-iommu_ga_log_enable/20220201-002214
        git checkout 5b5785526da0e2a6e793d2107d09afc9f310f17f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/iommu/amd/init.c: In function 'iommu_ga_log_enable':
>> drivers/iommu/amd/init.c:837:3: error: implicit declaration of function 'udelay' [-Werror=implicit-function-declaration]
     837 |   udelay(1);
         |   ^~~~~~
   cc1: some warnings being treated as errors


vim +/udelay +837 drivers/iommu/amd/init.c

   804	
   805	static int iommu_ga_log_enable(struct amd_iommu *iommu)
   806	{
   807	#ifdef CONFIG_IRQ_REMAP
   808		u32 status, i;
   809		u64 entry;
   810	
   811		if (!iommu->ga_log)
   812			return -EINVAL;
   813	
   814		/* Check if already running */
   815		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
   816		if (WARN_ON(status & (MMIO_STATUS_GALOG_RUN_MASK)))
   817			return 0;
   818	
   819		entry = iommu_virt_to_phys(iommu->ga_log) | GA_LOG_SIZE_512;
   820		memcpy_toio(iommu->mmio_base + MMIO_GA_LOG_BASE_OFFSET,
   821			    &entry, sizeof(entry));
   822		entry = (iommu_virt_to_phys(iommu->ga_log_tail) &
   823			 (BIT_ULL(52)-1)) & ~7ULL;
   824		memcpy_toio(iommu->mmio_base + MMIO_GA_LOG_TAIL_OFFSET,
   825			    &entry, sizeof(entry));
   826		writel(0x00, iommu->mmio_base + MMIO_GA_HEAD_OFFSET);
   827		writel(0x00, iommu->mmio_base + MMIO_GA_TAIL_OFFSET);
   828	
   829	
   830		iommu_feature_enable(iommu, CONTROL_GAINT_EN);
   831		iommu_feature_enable(iommu, CONTROL_GALOG_EN);
   832	
   833		for (i = 0; i < LOOP_TIMEOUT; ++i) {
   834			status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
   835			if (status & (MMIO_STATUS_GALOG_RUN_MASK))
   836				break;
 > 837			udelay(1);
   838		}
   839	
   840		if (WARN_ON(i >= LOOP_TIMEOUT))
   841			return -EINVAL;
   842	#endif /* CONFIG_IRQ_REMAP */
   843		return 0;
   844	}
   845	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
