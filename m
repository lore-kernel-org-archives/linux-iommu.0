Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DE6C433E1
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 19:17:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14ECB20735
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 19:17:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14ECB20735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DDB4086E5E;
	Fri, 21 Aug 2020 19:17:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1MjU-tZqo9Ly; Fri, 21 Aug 2020 19:17:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C86FF86EB4;
	Fri, 21 Aug 2020 19:17:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5887C0890;
	Fri, 21 Aug 2020 19:17:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E809EC0890
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 19:17:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C5DD986E97
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 19:17:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mXcjXp_YKftm for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 19:17:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8F0E386EAA
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 19:17:07 +0000 (UTC)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 29221672D2BB94E0A5A2;
 Sat, 22 Aug 2020 03:17:05 +0800 (CST)
Received: from dggema722-chm.china.huawei.com (10.3.20.86) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sat, 22 Aug 2020 03:17:04 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggema722-chm.china.huawei.com (10.3.20.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 22 Aug 2020 03:17:04 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Sat, 22 Aug 2020 03:17:04 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Randy Dunlap <rdunlap@infradead.org>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "will@kernel.org" <will@kernel.org>,
 "ganapatrao.kulkarni@cavium.com" <ganapatrao.kulkarni@cavium.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: RE: [PATCH v7 1/3] dma-contiguous: provide the ability to reserve
 per-numa CMA
Thread-Topic: [PATCH v7 1/3] dma-contiguous: provide the ability to reserve
 per-numa CMA
Thread-Index: AQHWd69ix8OgXlSJiUCOYl4oKg5K9qlCNSCAgAC5sFA=
Date: Fri, 21 Aug 2020 19:17:04 +0000
Message-ID: <b24cfc9fca7842b78ff6b7af575c0843@hisilicon.com>
References: <20200821113355.6140-1-song.bao.hua@hisilicon.com>
 <20200821113355.6140-2-song.bao.hua@hisilicon.com>
 <5eafce91-cc92-e6ed-23b0-98f253129e1b@infradead.org>
In-Reply-To: <5eafce91-cc92-e6ed-23b0-98f253129e1b@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.113]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Mike Rapoport <rppt@linux.ibm.com>, Steve Capper <steve.capper@arm.com>,
 Linuxarm <linuxarm@huawei.com>,
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
> From: Randy Dunlap [mailto:rdunlap@infradead.org]
> Sent: Saturday, August 22, 2020 4:08 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; hch@lst.de;
> m.szyprowski@samsung.com; robin.murphy@arm.com; will@kernel.org;
> ganapatrao.kulkarni@cavium.com; catalin.marinas@arm.com;
> akpm@linux-foundation.org
> Cc: iommu@lists.linux-foundation.org; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Zengtao (B) <prime.zeng@hisilicon.com>;
> huangdaode <huangdaode@huawei.com>; Linuxarm <linuxarm@huawei.com>;
> Jonathan Cameron <jonathan.cameron@huawei.com>; Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de>; Steve Capper <steve.capper@arm.com>; Mike
> Rapoport <rppt@linux.ibm.com>
> Subject: Re: [PATCH v7 1/3] dma-contiguous: provide the ability to reserve
> per-numa CMA
> 
> On 8/21/20 4:33 AM, Barry Song wrote:
> > ---
> >  -v7: with respect to Will's comments
> >  * move to use for_each_online_node
> >  * add description if users don't specify pernuma_cma
> >  * provide default value for CONFIG_DMA_PERNUMA_CMA
> >
> >  .../admin-guide/kernel-parameters.txt         |  11 ++
> >  include/linux/dma-contiguous.h                |   6 ++
> >  kernel/dma/Kconfig                            |  11 ++
> >  kernel/dma/contiguous.c                       | 100
> ++++++++++++++++--
> >  4 files changed, 118 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> > index bdc1f33fd3d1..c609527fc35a 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -599,6 +599,17 @@
> >  			altogether. For more information, see
> >  			include/linux/dma-contiguous.h
> >
> > +	pernuma_cma=nn[MG]
> > +			[ARM64,KNL]
> > +			Sets the size of kernel per-numa memory area for
> > +			contiguous memory allocations. A value of 0 disables
> > +			per-numa CMA altogether. And If this option is not
> > +			specificed, the default value is 0.
> > +			With per-numa CMA enabled, DMA users on node nid will
> > +			first try to allocate buffer from the pernuma area
> > +			which is located in node nid, if the allocation fails,
> > +			they will fallback to the global default memory area.
> > +
> 
> Entries in kernel-parameters.txt are supposed to be in alphabetical order
> but this one is not.  If you want to keep it near the cma= entry, you can
> rename it like Mike suggested.  Otherwise it needs to be moved.

As I've replied in Mike's comment, I'd like to rename it to cma_per...

> 
> 
> >  	cmo_free_hint=	[PPC] Format: { yes | no }
> >  			Specify whether pages are marked as being inactive
> >  			when they are freed.  This is used in CMO environments
> 
> 
> 
> --
> ~Randy

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
