Return-Path: <SRS0=GrUw=AH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7400C433E1
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 03:52:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948A220775
	for <iommu@archiver.kernel.org>; Fri, 26 Jun 2020 03:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948A220775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EB5CD20464;
	Fri, 26 Jun 2020 03:44:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KkrNwWxwSa+b; Fri, 26 Jun 2020 03:44:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 52EF92042D;
	Fri, 26 Jun 2020 03:44:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CAE0C0863;
	Fri, 26 Jun 2020 03:44:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 389A0C016F
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 03:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 20C6E863D0
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 03:44:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t5OsVVyff0-q for <iommu@lists.linux-foundation.org>;
 Fri, 26 Jun 2020 03:44:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 568FA8639E
 for <iommu@lists.linux-foundation.org>; Fri, 26 Jun 2020 03:44:17 +0000 (UTC)
Received: from dggemi403-hub.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id 06A23F95B094670A2D2B;
 Fri, 26 Jun 2020 11:44:13 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.126]) by
 dggemi403-hub.china.huawei.com ([10.3.17.136]) with mapi id 14.03.0487.000;
 Fri, 26 Jun 2020 11:44:06 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Robin Murphy <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "will@kernel.org"
 <will@kernel.org>, "ganapatrao.kulkarni@cavium.com"
 <ganapatrao.kulkarni@cavium.com>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>
Subject: RE: [PATCH v2 2/2] arm64: mm: reserve per-numa CMA after numa_init
Thread-Topic: [PATCH v2 2/2] arm64: mm: reserve per-numa CMA after numa_init
Thread-Index: AQHWSsSbzGzpbLEug0S/DFMz+d2fJKjoqFEAgAGYvPA=
Date: Fri, 26 Jun 2020 03:44:04 +0000
Message-ID: <B926444035E5E2439431908E3842AFD2524297@DGGEMI525-MBS.china.huawei.com>
References: <20200625074330.13668-1-song.bao.hua@hisilicon.com>
 <20200625074330.13668-3-song.bao.hua@hisilicon.com>
 <53b97598-6c83-1cb2-5763-4ded441403c5@arm.com>
In-Reply-To: <53b97598-6c83-1cb2-5763-4ded441403c5@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.18]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Steve Capper <steve.capper@arm.com>, Linuxarm <linuxarm@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
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
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: Thursday, June 25, 2020 11:16 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; hch@lst.de;
> m.szyprowski@samsung.com; will@kernel.org;
> ganapatrao.kulkarni@cavium.com; catalin.marinas@arm.com
> Cc: iommu@lists.linux-foundation.org; Linuxarm <linuxarm@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Nicolas
> Saenz Julienne <nsaenzjulienne@suse.de>; Steve Capper
> <steve.capper@arm.com>; Andrew Morton <akpm@linux-foundation.org>;
> Mike Rapoport <rppt@linux.ibm.com>
> Subject: Re: [PATCH v2 2/2] arm64: mm: reserve per-numa CMA after
> numa_init
> 
> On 2020-06-25 08:43, Barry Song wrote:
> > Right now, smmu is using dma_alloc_coherent() to get memory to save
> queues
> > and tables. Typically, on ARM64 server, there is a default CMA located at
> > node0, which could be far away from node2, node3 etc.
> > with this patch, smmu will get memory from local numa node to save
> command
> > queues and page tables. that means dma_unmap latency will be shrunk
> much.
> > Meanwhile, when iommu.passthrough is on, device drivers which call dma_
> > alloc_coherent() will also get local memory and avoid the travel between
> > numa nodes.
> >
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Cc: Steve Capper <steve.capper@arm.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@linux.ibm.com>
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >   arch/arm64/mm/init.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 1e93cfc7c47a..07d4d1fe7983 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -420,6 +420,8 @@ void __init bootmem_init(void)
> >
> >   	arm64_numa_init();
> >
> > +	dma_pernuma_cma_reserve();
> > +
> 
> It might be worth putting this after the hugetlb_cma_reserve() call for
> clarity, since the comment below applies equally to this call too.

Yep, it looks even better though dma_pernuma_cma_reserve() is self-documenting by name.

> 
> Robin.
> 
> >   	/*
> >   	 * must be done after arm64_numa_init() which calls numa_init() to
> >   	 * initialize node_online_map that gets used in hugetlb_cma_reserve()
> >
Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
