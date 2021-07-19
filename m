Return-Path: <SRS0=4OKN=ML=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17860C636C9
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 09:12:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A78611CD
	for <iommu@archiver.kernel.org>; Mon, 19 Jul 2021 09:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A78611CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5E2B840437;
	Mon, 19 Jul 2021 09:12:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QC-DIAzES4cW; Mon, 19 Jul 2021 09:12:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9C20940438;
	Mon, 19 Jul 2021 09:12:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 588EDC001A;
	Mon, 19 Jul 2021 09:12:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D56DC000E
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 09:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C7A2830E6
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 09:12:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3fPrxGtQR7u3 for <iommu@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 09:12:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A0DA82D57
 for <iommu@lists.linux-foundation.org>; Mon, 19 Jul 2021 09:12:41 +0000 (UTC)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GSwjL0hSdz6D8tQ;
 Mon, 19 Jul 2021 16:57:58 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 11:12:38 +0200
Received: from [10.47.85.214] (10.47.85.214) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 19 Jul
 2021 10:12:37 +0100
Subject: Re: [PATCH v4 6/6] dma-iommu: Pass iova len for IOVA domain init
To: Dan Carpenter <dan.carpenter@oracle.com>, "kbuild@lists.01.org"
 <kbuild@lists.01.org>, "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org"
 <will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
References: <202107150933.iNUojyx8-lkp@intel.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <70faf101-63c9-ef08-78df-9697f6257778@huawei.com>
Date: Mon, 19 Jul 2021 10:12:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <202107150933.iNUojyx8-lkp@intel.com>
Content-Language: en-US
X-Originating-IP: [10.47.85.214]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Cc: "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
 "lkp@intel.com" <lkp@intel.com>, "airlied@linux.ie" <airlied@linux.ie>,
 Linuxarm <linuxarm@huawei.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 19/07/2021 08:58, Dan Carpenter wrote:
> Hi John,
> 
> url:    https://github.com/0day-ci/linux/commits/John-Garry/iommu-Allow-IOVA-rcache-range-be-configured/20210714-184328
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> config: ia64-randconfig-m031-20210714 (attached as .config)
> compiler: ia64-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/iommu/dma-iommu.c:384 iommu_dma_init_domain() warn: variable dereferenced before check 'dev' (see line 374)
> 

thanks for the notice

> vim +/dev +384 drivers/iommu/dma-iommu.c
> 
> 06d60728ff5c01 Christoph Hellwig     2019-05-20  332  static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
> ac6d704679d343 Jean-Philippe Brucker 2021-06-18  333  				 dma_addr_t limit, struct device *dev)
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  334  {
> fdbe574eb69312 Robin Murphy          2017-01-19  335  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> c61a4633a56aaa Shaokun Zhang         2019-01-24  336  	unsigned long order, base_pfn;
> 6b0c54e7f27159 Yunsheng Lin          2019-08-24  337  	struct iova_domain *iovad;
> de4ba360c3e4ed John Garry            2021-07-14  338  	size_t max_opt_dma_size;
> de4ba360c3e4ed John Garry            2021-07-14  339  	unsigned long iova_len = 0;
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  340
> fdbe574eb69312 Robin Murphy          2017-01-19  341  	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
> fdbe574eb69312 Robin Murphy          2017-01-19  342  		return -EINVAL;
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  343
> 6b0c54e7f27159 Yunsheng Lin          2019-08-24  344  	iovad = &cookie->iovad;
> 6b0c54e7f27159 Yunsheng Lin          2019-08-24  345
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  346  	/* Use the smallest supported page size for IOVA granularity */
> d16e0faab911cc Robin Murphy          2016-04-07  347  	order = __ffs(domain->pgsize_bitmap);
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  348  	base_pfn = max_t(unsigned long, 1, base >> order);
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  349
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  350  	/* Check the domain allows at least some access to the device... */
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  351  	if (domain->geometry.force_aperture) {
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  352  		if (base > domain->geometry.aperture_end ||
> ac6d704679d343 Jean-Philippe Brucker 2021-06-18  353  		    limit < domain->geometry.aperture_start) {
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  354  			pr_warn("specified DMA range outside IOMMU capability\n");
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  355  			return -EFAULT;
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  356  		}
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  357  		/* ...then finally give it a kicking to make sure it fits */
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  358  		base_pfn = max_t(unsigned long, base_pfn,
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  359  				domain->geometry.aperture_start >> order);
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  360  	}
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  361
> f51d7bb79c1124 Robin Murphy          2017-01-16  362  	/* start_pfn is always nonzero for an already-initialised domain */
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  363  	if (iovad->start_pfn) {
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  364  		if (1UL << order != iovad->granule ||
> f51d7bb79c1124 Robin Murphy          2017-01-16  365  		    base_pfn != iovad->start_pfn) {
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  366  			pr_warn("Incompatible range for DMA domain\n");
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  367  			return -EFAULT;
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  368  		}
> 7c1b058c8b5a31 Robin Murphy          2017-03-16  369
> 7c1b058c8b5a31 Robin Murphy          2017-03-16  370  		return 0;
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  371  	}
> 7c1b058c8b5a31 Robin Murphy          2017-03-16  372
> de4ba360c3e4ed John Garry            2021-07-14  373
> de4ba360c3e4ed John Garry            2021-07-14 @374  	max_opt_dma_size = iommu_group_get_max_opt_dma_size(dev->iommu_group);
>                                                                                                              ^^^^^^^^^^^^^^^^
> New unchecked dereference
> 
> de4ba360c3e4ed John Garry            2021-07-14  375  	if (max_opt_dma_size) {
> de4ba360c3e4ed John Garry            2021-07-14  376  		unsigned long shift = __ffs(1UL << order);
> de4ba360c3e4ed John Garry            2021-07-14  377
> de4ba360c3e4ed John Garry            2021-07-14  378  		iova_len = max_opt_dma_size >> shift;
> de4ba360c3e4ed John Garry            2021-07-14  379  		iova_len = roundup_pow_of_two(iova_len);
> de4ba360c3e4ed John Garry            2021-07-14  380  	}
> de4ba360c3e4ed John Garry            2021-07-14  381
> de4ba360c3e4ed John Garry            2021-07-14  382  	init_iova_domain(iovad, 1UL << order, base_pfn, iova_len);
> 2da274cdf998a1 Zhen Lei              2018-09-20  383
> 82c3cefb9f1652 Lu Baolu              2021-02-25 @384  	if (!cookie->fq_domain && (!dev || !dev_is_untrusted(dev)) &&
>                                                                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> 
> a250c23f15c21c Robin Murphy          2021-04-01  385  	    domain->ops->flush_iotlb_all && !iommu_get_dma_strict(domain)) {
> b34e9b0de3c411 Tom Murphy            2020-09-10  386  		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
> 2a2b8eaa5b2566 Tom Murphy            2020-11-24  387  					  iommu_dma_entry_dtor))
> b34e9b0de3c411 Tom Murphy            2020-09-10  388  			pr_warn("iova flush queue initialization failed\n");
> b34e9b0de3c411 Tom Murphy            2020-09-10  389  		else
> 2da274cdf998a1 Zhen Lei              2018-09-20  390  			cookie->fq_domain = domain;
> 2da274cdf998a1 Zhen Lei              2018-09-20  391  	}
> 2da274cdf998a1 Zhen Lei              2018-09-20  392
> 7c1b058c8b5a31 Robin Murphy          2017-03-16  393  	if (!dev)
>                                                              ^^^^
> Old code has checks for NULL
> 

I doubt that in practice we need this check.

Function iommu_dma_init_domain() is only called by 
iommu_setup_dma_ops(). Furthermore, iommu_setup_dma_ops() calls 
iommu_get_domain_for_dev(dev), which cannot safely handle dev == NULL 
for when we call iommu_dma_init_domain() there. As such, the dev == NULL 
checks in iommu_dma_init_domain() are effectively redundant.


> 0db2e5d18f76a6 Robin Murphy          2015-10-01  394  		return 0;
> 7c1b058c8b5a31 Robin Murphy          2017-03-16  395
> 7c1b058c8b5a31 Robin Murphy          2017-03-16  396  	return iova_reserve_iommu_regions(dev, domain);
> 0db2e5d18f76a6 Robin Murphy          2015-10-01  397  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> .
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
