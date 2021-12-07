Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A256C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 05:55:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B189F40515;
	Tue,  7 Dec 2021 05:55:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j-xDiiNHqZEb; Tue,  7 Dec 2021 05:55:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4055140284;
	Tue,  7 Dec 2021 05:55:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EAB4C002F;
	Tue,  7 Dec 2021 05:55:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 438BAC0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 05:55:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 26D03404FD
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 05:55:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Cn5RTL0xkaHa for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 05:55:18 +0000 (UTC)
X-Greylist: delayed 00:17:19 by SQLgrey-1.8.0
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 81BC640284
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 05:55:17 +0000 (UTC)
Received: from kwepemi100007.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J7Tb66V4FzbjHn;
 Tue,  7 Dec 2021 13:37:38 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 kwepemi100007.china.huawei.com (7.221.188.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 13:37:50 +0800
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 kwepemm600016.china.huawei.com (7.193.23.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 7 Dec 2021 13:37:50 +0800
Received: from kwepemm600014.china.huawei.com ([7.193.23.54]) by
 kwepemm600014.china.huawei.com ([7.193.23.54]) with mapi id 15.01.2308.020;
 Tue, 7 Dec 2021 13:37:50 +0800
To: Robin Murphy <robin.murphy@arm.com>, Jay Chen <jkchen@linux.alibaba.com>, 
 "hch@lst.de" <hch@lst.de>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>
Subject: RE: [RFC PATCH] provide per numa cma with an initial default size
Thread-Topic: [RFC PATCH] provide per numa cma with an initial default size
Thread-Index: AQHX5b5WdkB1fqcI6kSRZ5Tsh5qqyawlEoQAgAF5HwA=
Date: Tue, 7 Dec 2021 05:37:50 +0000
Message-ID: <a3990c9921a44884b0adc448d1281b0a@hisilicon.com>
References: <20211130074556.11091-1-jkchen@linux.alibaba.com>
 <ddcdde8c-5118-048e-d5f8-6b8bc860947d@arm.com>
In-Reply-To: <ddcdde8c-5118-048e-d5f8-6b8bc860947d@arm.com>
Accept-Language: en-GB, zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.109]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>
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
From: "Song Bao Hua \(Barry Song\) via iommu"
 <iommu@lists.linux-foundation.org>
Reply-To: "Song Bao Hua \(Barry Song\)" <song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: Tuesday, December 7, 2021 4:01 AM
> To: Jay Chen <jkchen@linux.alibaba.com>; hch@lst.de; m.szyprowski@samsung.com;
> linux-kernel@vger.kernel.org; iommu@lists.linux-foundation.org; Song Bao Hua
> (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: zhangliguang@linux.alibaba.com
> Subject: Re: [RFC PATCH] provide per numa cma with an initial default size
> 
> [ +Barry ]
> 
> On 2021-11-30 07:45, Jay Chen wrote:
> >    In the actual production environment, when we open
> > cma and per numa cma, if we do not increase the per
> > numa size configuration in cmdline, we find that our
> > performance has dropped by 20%.
> >    Through analysis, we found that the default size of
> > per numa is 0, which causes the driver to allocate
> > memory from cma, which affects performance. Therefore,
> > we think we need to provide a default size.
> 
> Looking back at some of the review discussions, I think it may have been
> intentional that per-node areas are not allocated by default, since it's
> the kind of thing that really wants to be tuned to the particular system
> and workload, and as such it seemed reasonable to expect users to
> provide a value on the command line if they wanted the feature. That's
> certainly what the Kconfig text implies.
> 
> Thanks,
> Robin.
> 
> > Signed-off-by: Jay Chen <jkchen@linux.alibaba.com>
> > ---
> >   kernel/dma/contiguous.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index 3d63d91cba5c..3bef8bf371d9 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -99,7 +99,7 @@ early_param("cma", early_cma);
> >   #ifdef CONFIG_DMA_PERNUMA_CMA
> >
> >   static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
> > -static phys_addr_t pernuma_size_bytes __initdata;
> > +static phys_addr_t pernuma_size_bytes __initdata = size_bytes;

I don't think the size for the default cma can apply to
per-numa CMA.

We did have some discussion regarding the size when per-numa cma was
added, and it was done by a Kconfig option. I think we have decided
to not have any default size other than 0. Default size 0 is perfect,
this will enforce users to set a proper "cma_pernuma=" bootargs.

> >
> >   static int __init early_cma_pernuma(char *p)
> >   {
> >

Thanks
Barry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
