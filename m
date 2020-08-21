Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871F8C433DF
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 19:30:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 662AA2076E
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 19:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 662AA2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 43E36887C0;
	Fri, 21 Aug 2020 19:30:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cdg9wkEbGpQO; Fri, 21 Aug 2020 19:30:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 16786887C7;
	Fri, 21 Aug 2020 19:30:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D38BAC0890;
	Fri, 21 Aug 2020 19:30:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1140FC0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 19:30:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EFC8A86E41
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 19:30:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9q84HreGpLTp for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 19:30:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 87EF586E29
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 19:30:01 +0000 (UTC)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id AED36C3FAF846FD56BCF;
 Sat, 22 Aug 2020 03:29:55 +0800 (CST)
Received: from dggema722-chm.china.huawei.com (10.3.20.86) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 22 Aug 2020 03:29:55 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggema722-chm.china.huawei.com (10.3.20.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 22 Aug 2020 03:29:55 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Sat, 22 Aug 2020 03:29:55 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Mike Kravetz <mike.kravetz@oracle.com>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "will@kernel.org" <will@kernel.org>,
 "ganapatrao.kulkarni@cavium.com" <ganapatrao.kulkarni@cavium.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH v7 0/3] make dma_alloc_coherent NUMA-aware by per-NUMA CMA
Thread-Topic: [PATCH v7 0/3] make dma_alloc_coherent NUMA-aware by per-NUMA CMA
Thread-Index: AQHWd+P3Cxxhv5+npUG1WD6UP12kNalC7yyQ
Date: Fri, 21 Aug 2020 19:29:55 +0000
Message-ID: <328438204e9e4afba84b20c6b778c504@hisilicon.com>
References: <20200821113355.6140-1-song.bao.hua@hisilicon.com>
 <e47f4bfd-3af7-f682-23a1-51800f992d35@oracle.com>
In-Reply-To: <e47f4bfd-3af7-f682-23a1-51800f992d35@oracle.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.113]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Linuxarm <linuxarm@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>, huangdaode <huangdaode@huawei.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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
> From: Mike Kravetz [mailto:mike.kravetz@oracle.com]
> Sent: Saturday, August 22, 2020 5:53 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; hch@lst.de;
> m.szyprowski@samsung.com; robin.murphy@arm.com; will@kernel.org;
> ganapatrao.kulkarni@cavium.com; catalin.marinas@arm.com;
> akpm@linux-foundation.org
> Cc: iommu@lists.linux-foundation.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Zengtao (B) <prime.zeng@hisilicon.com>;
> huangdaode <huangdaode@huawei.com>; Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH v7 0/3] make dma_alloc_coherent NUMA-aware by
> per-NUMA CMA
> 
> Hi Barry,
> Sorry for jumping in so late.
> 
> On 8/21/20 4:33 AM, Barry Song wrote:
> >
> > with per-numa CMA, smmu will get memory from local numa node to save
> command
> > queues and page tables. that means dma_unmap latency will be shrunk
> much.
> 
> Since per-node CMA areas for hugetlb was introduced, I have been thinking
> about the limited number of CMA areas.  In most configurations, I believe
> it is limited to 7.  And, IIRC it is not something that can be changed at
> runtime, you need to reconfig and rebuild to increase the number.  In contrast
> some configs have NODES_SHIFT set to 10.  I wasn't too worried because of
> the limited hugetlb use case.  However, this series is adding another user
> of per-node CMA areas.
> 
> With more users, should try to sync up number of CMA areas and number of
> nodes?  Or, perhaps I am worrying about nothing?

Hi Mike,
The current limitation is 8. If the server has 4 nodes and we enable both pernuma
CMA and hugetlb, the last node will fail to get one cma area as the default
global cma area will take 1 of 8. So users need to change menuconfig.
If the server has 8 nodes, we enable one of pernuma cma and hugetlb, one node
will fail to get cma.

We may set the default number of CMA areas as 8+MAX_NODES(if hugetlb enabled) +
MAX_NODES(if pernuma cma enabled) if we don't expect users to change config, but
right now hugetlb has not an option in Kconfig to enable or disable like pernuma cma
has DMA_PERNUMA_CMA.

> --
> Mike Kravetz

Thanks
Barry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
