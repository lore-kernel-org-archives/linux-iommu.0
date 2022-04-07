Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAB5C433EF
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 04:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4CE0D40641;
	Thu,  7 Apr 2022 04:28:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Dhk7agXjKAP; Thu,  7 Apr 2022 04:28:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 17DE740360;
	Thu,  7 Apr 2022 04:28:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB113C002C;
	Thu,  7 Apr 2022 04:28:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54753C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 04:28:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 397C060A9F
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 04:28:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qaBUevREukwP for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 04:28:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 45AF460782
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 04:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649305707; x=1680841707;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ts+o/jr2ZC6MZBkFgb5YbXFIFLPZBtS2sjuEohSRpHM=;
 b=gEqD8mIKpe7XVOjU5dKHkcC7NVLnew1P2oAFrhAYlbrfmb7DpEX8A1Vz
 NN6qp09ZQSOs/WZT11YJUmmtdv+NbHjZ+I8NkjVGgK3tEy/BCWOe+kV4A
 4GWJEaJxf71xsxjlDcw0XgIOi+ECvaV8m8nhCBfWWgIFgB/znYKneMPou
 +ERs0EtJO+mrXHXZkR3GECx0D9/0IUaSM6FSiOIGAe05f5t/sqv0Jv6dn
 d89S9NZ/ZpnL4hCkVDeSt+QGABDowdFYiMvhP4zfnZubVIQMD1iKsfkn7
 DS+5tdPAxSkZbwFUCfqSDgeI0TGAGoJOigP/4CXWZAoofytP/crafi/vA w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="261403881"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; d="scan'208";a="261403881"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2022 21:28:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; d="scan'208";a="621093362"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
 by fmsmga004.fm.intel.com with ESMTP; 06 Apr 2022 21:28:20 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1ncJkp-000543-At;
 Thu, 07 Apr 2022 04:28:19 +0000
Date: Thu, 7 Apr 2022 12:28:05 +0800
From: kernel test robot <lkp@intel.com>
To: Yicong Yang <yangyicong@hisilicon.com>, gregkh@linuxfoundation.org,
 helgaas@kernel.org, alexander.shishkin@linux.intel.com,
 lorenzo.pieralisi@arm.com, will@kernel.org, mark.rutland@arm.com,
 mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
 mike.leach@linaro.org, leo.yan@linaro.org,
 jonathan.cameron@huawei.com, daniel.thompson@linaro.org,
 joro@8bytes.org, john.garry@huawei.com,
 shameerali.kolothum.thodi@huawei.com, robin.murphy@arm.com,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 coresight@lists.linaro.org, linux-pci@vger.kernel.org,
 linux-perf-users@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v6 4/7] hisi_ptt: Add tune function support for HiSilicon
 PCIe Tune and Trace device
Message-ID: <202204071201.AcePULOR-lkp@intel.com>
References: <20220406071730.41031-5-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220406071730.41031-5-yangyicong@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: kbuild-all@lists.01.org, prime.zeng@huawei.com, linuxarm@huawei.com,
 yangyicong@hisilicon.com, zhangshaokun@hisilicon.com, liuqi115@huawei.com
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

Hi Yicong,

I love your patch! Perhaps something to improve:

[auto build test WARNING on joro-iommu/next]
[also build test WARNING on linus/master linux/master v5.18-rc1 next-20220406]
[cannot apply to tip/perf/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Yicong-Yang/Add-support-for-HiSilicon-PCIe-Tune-and-Trace-device/20220406-200044
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220407/202204071201.AcePULOR-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9400668b70cbcd5ec74a52f043c3a333b80135f8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yicong-Yang/Add-support-for-HiSilicon-PCIe-Tune-and-Trace-device/20220406-200044
        git checkout 9400668b70cbcd5ec74a52f043c3a333b80135f8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/hwtracing/ptt/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/hwtracing/ptt/hisi_ptt.c: In function 'hisi_ptt_tune_data_get':
>> drivers/hwtracing/ptt/hisi_ptt.c:46:16: warning: conversion from 'long unsigned int' to 'u32' {aka 'unsigned int'} changes value from '18446744073709551615' to '4294967295' [-Woverflow]
      46 |         writel(~0UL, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
         |                ^~~~
   drivers/hwtracing/ptt/hisi_ptt.c: At top level:
   drivers/hwtracing/ptt/hisi_ptt.c:1131:6: warning: no previous prototype for 'hisi_ptt_remove' [-Wmissing-prototypes]
    1131 | void hisi_ptt_remove(struct pci_dev *pdev)
         |      ^~~~~~~~~~~~~~~


vim +46 drivers/hwtracing/ptt/hisi_ptt.c

    33	
    34	static int hisi_ptt_tune_data_get(struct hisi_ptt *hisi_ptt,
    35					  u32 event, u16 *data)
    36	{
    37		u32 reg;
    38	
    39		reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
    40		reg &= ~(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB);
    41		reg |= FIELD_PREP(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB,
    42				  event);
    43		writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
    44	
    45		/* Write all 1 to indicates it's the read process */
  > 46		writel(~0UL, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
    47	
    48		if (!hisi_ptt_wait_tuning_finish(hisi_ptt))
    49			return -ETIMEDOUT;
    50	
    51		reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
    52		reg &= HISI_PTT_TUNING_DATA_VAL_MASK;
    53		*data = FIELD_GET(HISI_PTT_TUNING_DATA_VAL_MASK, reg);
    54	
    55		return 0;
    56	}
    57	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
