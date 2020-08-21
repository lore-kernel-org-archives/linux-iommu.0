Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CCDC433DF
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 20:47:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A224F20738
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 20:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A224F20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 38E39230FE;
	Fri, 21 Aug 2020 20:47:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VUT443DaVY44; Fri, 21 Aug 2020 20:47:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id C5DED2318D;
	Fri, 21 Aug 2020 20:47:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 980BBC07FF;
	Fri, 21 Aug 2020 20:47:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86F0AC0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 20:47:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 68BFC2318D
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 20:47:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Grw3YRFYv7t for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 20:47:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by silver.osuosl.org (Postfix) with ESMTPS id 021C3230FE
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 20:47:46 +0000 (UTC)
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 0B449708F77DCF66FDA3;
 Sat, 22 Aug 2020 04:47:43 +0800 (CST)
Received: from dggema773-chm.china.huawei.com (10.1.198.217) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 22 Aug 2020 04:47:42 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggema773-chm.china.huawei.com (10.1.198.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 22 Aug 2020 04:47:42 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Sat, 22 Aug 2020 04:47:42 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Mike Kravetz <mike.kravetz@oracle.com>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "will@kernel.org" <will@kernel.org>,
 "ganapatrao.kulkarni@cavium.com" <ganapatrao.kulkarni@cavium.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH v7 0/3] make dma_alloc_coherent NUMA-aware by per-NUMA CMA
Thread-Topic: [PATCH v7 0/3] make dma_alloc_coherent NUMA-aware by per-NUMA CMA
Thread-Index: AQHWd+P3Cxxhv5+npUG1WD6UP12kNalC7yyQgAAUM8A=
Date: Fri, 21 Aug 2020 20:47:42 +0000
Message-ID: <0a1636c9a3cc4bafb64ef43bed19f2fe@hisilicon.com>
References: <20200821113355.6140-1-song.bao.hua@hisilicon.com>
 <e47f4bfd-3af7-f682-23a1-51800f992d35@oracle.com> 
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
> From: Song Bao Hua (Barry Song)
> Sent: Saturday, August 22, 2020 7:27 AM
> To: 'Mike Kravetz' <mike.kravetz@oracle.com>; hch@lst.de;
> m.szyprowski@samsung.com; robin.murphy@arm.com; will@kernel.org;
> ganapatrao.kulkarni@cavium.com; catalin.marinas@arm.com;
> akpm@linux-foundation.org
> Cc: iommu@lists.linux-foundation.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Zengtao (B) <prime.zeng@hisilicon.com>;
> huangdaode <huangdaode@huawei.com>; Linuxarm <linuxarm@huawei.com>
> Subject: RE: [PATCH v7 0/3] make dma_alloc_coherent NUMA-aware by
> per-NUMA CMA
> 
> 
> 
> > -----Original Message-----
> > From: Mike Kravetz [mailto:mike.kravetz@oracle.com]
> > Sent: Saturday, August 22, 2020 5:53 AM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; hch@lst.de;
> > m.szyprowski@samsung.com; robin.murphy@arm.com; will@kernel.org;
> > ganapatrao.kulkarni@cavium.com; catalin.marinas@arm.com;
> > akpm@linux-foundation.org
> > Cc: iommu@lists.linux-foundation.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; Zengtao (B) <prime.zeng@hisilicon.com>;
> > huangdaode <huangdaode@huawei.com>; Linuxarm
> <linuxarm@huawei.com>
> > Subject: Re: [PATCH v7 0/3] make dma_alloc_coherent NUMA-aware by
> > per-NUMA CMA
> >
> > Hi Barry,
> > Sorry for jumping in so late.
> >
> > On 8/21/20 4:33 AM, Barry Song wrote:
> > >
> > > with per-numa CMA, smmu will get memory from local numa node to save
> > command
> > > queues and page tables. that means dma_unmap latency will be shrunk
> > much.
> >
> > Since per-node CMA areas for hugetlb was introduced, I have been thinking
> > about the limited number of CMA areas.  In most configurations, I believe
> > it is limited to 7.  And, IIRC it is not something that can be changed at
> > runtime, you need to reconfig and rebuild to increase the number.  In
> contrast
> > some configs have NODES_SHIFT set to 10.  I wasn't too worried because of
> > the limited hugetlb use case.  However, this series is adding another user
> > of per-node CMA areas.
> >
> > With more users, should try to sync up number of CMA areas and number of
> > nodes?  Or, perhaps I am worrying about nothing?
> 
> Hi Mike,
> The current limitation is 8. If the server has 4 nodes and we enable both
> pernuma
> CMA and hugetlb, the last node will fail to get one cma area as the default
> global cma area will take 1 of 8. So users need to change menuconfig.
> If the server has 8 nodes, we enable one of pernuma cma and hugetlb, one
> node
> will fail to get cma.
> 
> We may set the default number of CMA areas as 8+MAX_NODES(if hugetlb
> enabled) +
> MAX_NODES(if pernuma cma enabled) if we don't expect users to change
> config, but
> right now hugetlb has not an option in Kconfig to enable or disable like
> pernuma cma
> has DMA_PERNUMA_CMA.

I would prefer we make some changes like:

config CMA_AREAS
	int "Maximum count of the CMA areas"
	depends on CMA
+	default 19 if NUMA
	default 7
	help
	  CMA allows to create CMA areas for particular purpose, mainly,
	  used as device private area. This parameter sets the maximum
	  number of CMA area in the system.

-	  If unsure, leave the default value "7".
+	  If unsure, leave the default value "7" or "19" if NUMA is used.

1+ CONFIG_CMA_AREAS should be quite enough for almost all servers in the markets.

If 2 numa nodes, and both hugetlb cma and pernuma cma is enabled, we need 2*2 + 1 = 5
If 4 numa nodes, and both hugetlb cma and pernuma cma is enabled, we need 2*4 + 1 = 9    -> default ARM64 config.
If 8 numa nodes, and both hugetlb cma and pernuma cma is enabled, we need 2*8 + 1 = 17

The default value is supporting the most common case and is not going to support those servers
with NODES_SHIFT=10, they can make their own config just like users need to increase CMA_AREAS
if they add many cma areas in device tree in a system even without NUMA.

How do you think, mike?

Thanks
Barry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
