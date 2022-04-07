Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4C5C4332F
	for <iommu@archiver.kernel.org>; Thu,  7 Apr 2022 08:42:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91A7081306;
	Thu,  7 Apr 2022 08:42:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xN-9MIARX7lh; Thu,  7 Apr 2022 08:42:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 55ABB81292;
	Thu,  7 Apr 2022 08:42:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1BA60C001D;
	Thu,  7 Apr 2022 08:42:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07CC8C0012
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 08:42:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA37C812F0
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 08:42:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lbKLwvvcAuMx for <iommu@lists.linux-foundation.org>;
 Thu,  7 Apr 2022 08:42:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6716581292
 for <iommu@lists.linux-foundation.org>; Thu,  7 Apr 2022 08:42:42 +0000 (UTC)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KYvwh6pJ9zgYQL;
 Thu,  7 Apr 2022 16:40:52 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 16:42:35 +0800
Subject: Re: [PATCH v6 4/7] hisi_ptt: Add tune function support for HiSilicon
 PCIe Tune and Trace device
To: kernel test robot <lkp@intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
 <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
 <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
 <will@kernel.org>, <mark.rutland@arm.com>, <mathieu.poirier@linaro.org>,
 <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <leo.yan@linaro.org>,
 <jonathan.cameron@huawei.com>, <daniel.thompson@linaro.org>,
 <joro@8bytes.org>, <john.garry@huawei.com>,
 <shameerali.kolothum.thodi@huawei.com>, <robin.murphy@arm.com>,
 <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
 <linux-perf-users@vger.kernel.org>, <iommu@lists.linux-foundation.org>
References: <20220406071730.41031-5-yangyicong@hisilicon.com>
 <202204071201.AcePULOR-lkp@intel.com>
Message-ID: <73483350-8df9-967f-ba35-d910aa39b635@huawei.com>
Date: Thu, 7 Apr 2022 16:42:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <202204071201.AcePULOR-lkp@intel.com>
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Cc: zhangshaokun@hisilicon.com, liuqi115@huawei.com, kbuild-all@lists.01.org,
 linuxarm@huawei.com, prime.zeng@huawei.com
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
From: Yicong Yang via iommu <iommu@lists.linux-foundation.org>
Reply-To: Yicong Yang <yangyicong@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/4/7 12:28, kernel test robot wrote:
> Hi Yicong,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on joro-iommu/next]
> [also build test WARNING on linus/master linux/master v5.18-rc1 next-20220406]
> [cannot apply to tip/perf/core]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yicong-Yang/Add-support-for-HiSilicon-PCIe-Tune-and-Trace-device/20220406-200044
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220407/202204071201.AcePULOR-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/9400668b70cbcd5ec74a52f043c3a333b80135f8
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Yicong-Yang/Add-support-for-HiSilicon-PCIe-Tune-and-Trace-device/20220406-200044
>         git checkout 9400668b70cbcd5ec74a52f043c3a333b80135f8
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/hwtracing/ptt/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/hwtracing/ptt/hisi_ptt.c: In function 'hisi_ptt_tune_data_get':
>>> drivers/hwtracing/ptt/hisi_ptt.c:46:16: warning: conversion from 'long unsigned int' to 'u32' {aka 'unsigned int'} changes value from '18446744073709551615' to '4294967295' [-Woverflow]
>       46 |         writel(~0UL, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
>          |                ^~~~

Thanks for the report. using of ~0U will fix this.

>    drivers/hwtracing/ptt/hisi_ptt.c: At top level:
>    drivers/hwtracing/ptt/hisi_ptt.c:1131:6: warning: no previous prototype for 'hisi_ptt_remove' [-Wmissing-prototypes]
>     1131 | void hisi_ptt_remove(struct pci_dev *pdev)
>          |      ^~~~~~~~~~~~~~~
> 

for here I missed the static identifier. will fix. thanks.

> 
> vim +46 drivers/hwtracing/ptt/hisi_ptt.c
> 
>     33	
>     34	static int hisi_ptt_tune_data_get(struct hisi_ptt *hisi_ptt,
>     35					  u32 event, u16 *data)
>     36	{
>     37		u32 reg;
>     38	
>     39		reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
>     40		reg &= ~(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB);
>     41		reg |= FIELD_PREP(HISI_PTT_TUNING_CTRL_CODE | HISI_PTT_TUNING_CTRL_SUB,
>     42				  event);
>     43		writel(reg, hisi_ptt->iobase + HISI_PTT_TUNING_CTRL);
>     44	
>     45		/* Write all 1 to indicates it's the read process */
>   > 46		writel(~0UL, hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
>     47	
>     48		if (!hisi_ptt_wait_tuning_finish(hisi_ptt))
>     49			return -ETIMEDOUT;
>     50	
>     51		reg = readl(hisi_ptt->iobase + HISI_PTT_TUNING_DATA);
>     52		reg &= HISI_PTT_TUNING_DATA_VAL_MASK;
>     53		*data = FIELD_GET(HISI_PTT_TUNING_DATA_VAL_MASK, reg);
>     54	
>     55		return 0;
>     56	}
>     57	
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
