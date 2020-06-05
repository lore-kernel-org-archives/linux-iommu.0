Return-Path: <SRS0=1g3H=7S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3657AC433E0
	for <iommu@archiver.kernel.org>; Fri,  5 Jun 2020 06:04:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E277B207D5
	for <iommu@archiver.kernel.org>; Fri,  5 Jun 2020 06:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E277B207D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A434186EB4;
	Fri,  5 Jun 2020 06:04:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vFYeQuSw1gH8; Fri,  5 Jun 2020 06:04:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A8B1786EA2;
	Fri,  5 Jun 2020 06:04:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91FFAC0888;
	Fri,  5 Jun 2020 06:04:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B6DAC016E
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 06:04:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4C8B988778
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 06:04:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BPCKZXwMH8Qz for <iommu@lists.linux-foundation.org>;
 Fri,  5 Jun 2020 06:04:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 60A2685A58
 for <iommu@lists.linux-foundation.org>; Fri,  5 Jun 2020 06:04:46 +0000 (UTC)
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 3647AF0A6493C43752CF;
 Fri,  5 Jun 2020 14:04:42 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.10]) by
 dggemi402-hub.china.huawei.com ([10.3.17.135]) with mapi id 14.03.0487.000;
 Fri, 5 Jun 2020 14:04:32 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, "kbuild@lists.01.org"
 <kbuild@lists.01.org>, "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>
Subject: RE: [PATCH 1/3] dma-direct: provide the ability to reserve per-numa
 CMA
Thread-Topic: [PATCH 1/3] dma-direct: provide the ability to reserve
 per-numa CMA
Thread-Index: AQHWOVDkjt//8Ixq2UKuAS4YcS/rw6jH0AqAgAG65oA=
Date: Fri, 5 Jun 2020 06:04:31 +0000
Message-ID: <B926444035E5E2439431908E3842AFD24E0011@DGGEMI525-MBS.china.huawei.com>
References: <20200603024231.61748-2-song.bao.hua@hisilicon.com>
 <20200604113631.GP30374@kadam>
In-Reply-To: <20200604113631.GP30374@kadam>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.128]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
 "lkp@intel.com" <lkp@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linuxarm <linuxarm@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Dan Carpenter <error27@gmail.com>
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



> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Thursday, June 4, 2020 11:37 PM
> To: kbuild@lists.01.org; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>; hch@lst.de; m.szyprowski@samsung.com;
> robin.murphy@arm.com; catalin.marinas@arm.com
> Cc: lkp@intel.com; Dan Carpenter <error27@gmail.com>;
> kbuild-all@lists.01.org; iommu@lists.linux-foundation.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Linuxarm
> <linuxarm@huawei.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; John Garry <john.garry@huawei.com>
> Subject: Re: [PATCH 1/3] dma-direct: provide the ability to reserve per-numa
> CMA
> 
> Hi Barry,
> 
> url:
> https://github.com/0day-ci/linux/commits/Barry-Song/support-per-numa-CM
> A-for-ARM-server/20200603-104821
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
> for-next/core
> config: x86_64-randconfig-m001-20200603 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

Dan, thanks! Good catch!
as this patch has not been in mainline yet, is it correct to add these "reported-by" in patch v2?

Barry

> 
> smatch warnings:
> kernel/dma/contiguous.c:274 dma_alloc_contiguous() warn: variable
> dereferenced before check 'dev' (see line 272)
> 
> #
> https://github.com/0day-ci/linux/commit/adb919e972c1cac3d8b11905d525
> 8d23d3aac6a4
> git remote add linux-review https://github.com/0day-ci/linux git remote
> update linux-review git checkout
> adb919e972c1cac3d8b11905d5258d23d3aac6a4
> vim +/dev +274 kernel/dma/contiguous.c
> 
> b1d2dc009dece4 kernel/dma/contiguous.c       Nicolin Chen
> 2019-05-23  267  struct page *dma_alloc_contiguous(struct device *dev,
> size_t size, gfp_t gfp)
> b1d2dc009dece4 kernel/dma/contiguous.c       Nicolin Chen
> 2019-05-23  268  {
> 90ae409f9eb3bc kernel/dma/contiguous.c       Christoph Hellwig
> 2019-08-20  269  	size_t count = size >> PAGE_SHIFT;
> b1d2dc009dece4 kernel/dma/contiguous.c       Nicolin Chen
> 2019-05-23  270  	struct page *page = NULL;
> bd2e75633c8012 kernel/dma/contiguous.c       Nicolin Chen
> 2019-05-23  271  	struct cma *cma = NULL;
> adb919e972c1ca kernel/dma/contiguous.c       Barry Song
> 2020-06-03 @272  	int nid = dev_to_node(dev);
> 
> ^^^ Dereferenced inside function.
> 
> bd2e75633c8012 kernel/dma/contiguous.c       Nicolin Chen
> 2019-05-23  273
> bd2e75633c8012 kernel/dma/contiguous.c       Nicolin Chen
> 2019-05-23 @274  	if (dev && dev->cma_area)
> 
> ^^^ Too late.
> 
> bd2e75633c8012 kernel/dma/contiguous.c       Nicolin Chen
> 2019-05-23  275  		cma = dev->cma_area;
> adb919e972c1ca kernel/dma/contiguous.c       Barry Song
> 2020-06-03  276  	else if ((nid != NUMA_NO_NODE) &&
> dma_contiguous_pernuma_area[nid]
> adb919e972c1ca kernel/dma/contiguous.c       Barry Song
> 2020-06-03  277  		&& !(gfp & (GFP_DMA | GFP_DMA32)))
> adb919e972c1ca kernel/dma/contiguous.c       Barry Song
> 2020-06-03  278  		cma = dma_contiguous_pernuma_area[nid];
> bd2e75633c8012 kernel/dma/contiguous.c       Nicolin Chen
> 2019-05-23  279  	else if (count > 1)
> bd2e75633c8012 kernel/dma/contiguous.c       Nicolin Chen
> 2019-05-23  280  		cma = dma_contiguous_default_area;
> b1d2dc009dece4 kernel/dma/contiguous.c       Nicolin Chen
> 2019-05-23  281
> b1d2dc009dece4 kernel/dma/contiguous.c       Nicolin Chen
> 2019-05-23  282  	/* CMA can be used only in the context which permits
> sleeping */
> b1d2dc009dece4 kernel/dma/contiguous.c       Nicolin Chen
> 2019-05-23  283  	if (cma && gfpflags_allow_blocking(gfp)) {
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
