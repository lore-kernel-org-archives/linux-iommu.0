Return-Path: <SRS0=PKzM=EC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0179C4363A
	for <iommu@archiver.kernel.org>; Tue, 27 Oct 2020 08:23:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 954FF21556
	for <iommu@archiver.kernel.org>; Tue, 27 Oct 2020 08:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 954FF21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 298918613C;
	Tue, 27 Oct 2020 08:23:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id swj5k1OpA1td; Tue, 27 Oct 2020 08:22:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E9A9186124;
	Tue, 27 Oct 2020 08:22:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B99D7C088B;
	Tue, 27 Oct 2020 08:22:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B331C0051
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 08:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 203DF85629
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 08:22:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VmBPQdobDCk4 for <iommu@lists.linux-foundation.org>;
 Tue, 27 Oct 2020 08:22:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9C2DC8559B
 for <iommu@lists.linux-foundation.org>; Tue, 27 Oct 2020 08:22:55 +0000 (UTC)
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CL4TC5rK3zXgBg;
 Tue, 27 Oct 2020 16:22:55 +0800 (CST)
Received: from dggemi711-chm.china.huawei.com (10.3.20.110) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 27 Oct 2020 16:22:50 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi711-chm.china.huawei.com (10.3.20.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 27 Oct 2020 16:22:50 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Tue, 27 Oct 2020 16:22:50 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: "hch@lst.de" <hch@lst.de>, "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH] dma: Per-NUMA-node CMA should depend on NUMA
Thread-Topic: [PATCH] dma: Per-NUMA-node CMA should depend on NUMA
Thread-Index: AQHWq5MUDdH3/+jmF0KiWtaQJmX8fKmqTnfwgABBLQCAAIoLgA==
Date: Tue, 27 Oct 2020 08:22:50 +0000
Message-ID: <767d181165f74ce78c86b20bbe09cd9b@hisilicon.com>
References: <74b66725883f065eb7d156f866678abb5be934bd.1603714996.git.robin.murphy@arm.com>
 <75cad228694b4f1587265a887069b241@hisilicon.com>
 <20201027075452.GA22487@lst.de>
In-Reply-To: <20201027075452.GA22487@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.177]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linuxarm <linuxarm@huawei.com>
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
> From: hch@lst.de [mailto:hch@lst.de]
> Sent: Tuesday, October 27, 2020 8:55 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Robin Murphy <robin.murphy@arm.com>; hch@lst.de;
> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] dma: Per-NUMA-node CMA should depend on NUMA
> 
> On Mon, Oct 26, 2020 at 08:07:43PM +0000, Song Bao Hua (Barry Song)
> wrote:
> > > diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> > > index c99de4a21458..964b74c9b7e3 100644
> > > --- a/kernel/dma/Kconfig
> > > +++ b/kernel/dma/Kconfig
> > > @@ -125,7 +125,8 @@ if  DMA_CMA
> > >
> > >  config DMA_PERNUMA_CMA
> > >  	bool "Enable separate DMA Contiguous Memory Area for each NUMA
> > > Node"
> > > -	default NUMA && ARM64
> > > +	depends on NUMA
> > > +	default ARM64
> >
> > On the other hand, at this moment, only ARM64 is calling the init code
> > to get per_numa cma. Do we need to
> > depends on NUMA && ARM64 ?
> > so that this is not enabled by non-arm64?
> 
> I actually hate having arch symbols in common code.  A new
> ARCH_HAS_DMA_PERNUMA_CMA, only selected by arm64 for now would be
> more
> clean I think.

Sounds good to me.

BTW,  +Will.

Last time we talked about default pernuma cma size, you suggested a bootargs
in arch/arm64/Kconfig but Will seems to have different idea. Am I right, Will?

Would we let aarch64 call dma_pernuma_cma_reserve(16MB) rather than
dma_pernuma_cma_reserve()?

In this way, users will at least get a default pernuma CMA which is required
at least by IOMMU. If users set a "cma_pernuma" bootargs, it will overwrite
the default size from aarch64 code?

I mean

- void __init dma_pernuma_cma_reserve(size_t size)
+ void __init dma_pernuma_cma_reserve(size_t size)
{
	if (!pernuma_size_bytes)
+		pernuma_size_bytes = size;
	....
}

Right now, it is easy that users will forget to set cma_pernuma in bootargs.
Probably this feature is not enabled by users.

Thanks
Barry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
