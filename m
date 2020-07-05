Return-Path: <SRS0=UFel=AQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EE1C433E0
	for <iommu@archiver.kernel.org>; Sun,  5 Jul 2020 10:10:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA1120771
	for <iommu@archiver.kernel.org>; Sun,  5 Jul 2020 10:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA1120771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9594E203A7;
	Sun,  5 Jul 2020 10:09:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nhIGqnGHPCyw; Sun,  5 Jul 2020 10:09:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BF4312039E;
	Sun,  5 Jul 2020 10:09:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F190C0893;
	Sun,  5 Jul 2020 10:09:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76456C016F
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jul 2020 10:09:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5EB5487CE1
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jul 2020 10:09:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fTcdK7or8bkq for <iommu@lists.linux-foundation.org>;
 Sun,  5 Jul 2020 10:09:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ADCB087CBE
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jul 2020 10:09:53 +0000 (UTC)
Received: from dggemi401-hub.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id C0F52D6565069815679D;
 Sun,  5 Jul 2020 18:09:47 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.177]) by
 dggemi401-hub.china.huawei.com ([10.3.17.134]) with mapi id 14.03.0487.000;
 Sun, 5 Jul 2020 18:09:39 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Will Deacon <will@kernel.org>
Subject: RE: [PATCH] iommu/arm-smmu-v3: allocate the memory of queues in
 local numa node
Thread-Topic: [PATCH] iommu/arm-smmu-v3: allocate the memory of queues in
 local numa node
Thread-Index: AQHWUVYT12xF5LOssku8nXPfXKnrbaj4wssA
Date: Sun, 5 Jul 2020 10:09:38 +0000
Message-ID: <B926444035E5E2439431908E3842AFD2555A44@DGGEMI525-MBS.china.huawei.com>
References: <20200601113141.69488-1-song.bao.hua@hisilicon.com>
 <20200703162147.GB19780@willie-the-truck>
In-Reply-To: <20200703162147.GB19780@willie-the-truck>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.129]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Linuxarm <linuxarm@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, "hch@lst.de" <hch@lst.de>,
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
> From: Will Deacon [mailto:will@kernel.org]
> Sent: Saturday, July 4, 2020 4:22 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: hch@lst.de; m.szyprowski@samsung.com; robin.murphy@arm.com;
> linux-arm-kernel@lists.infradead.org; iommu@lists.linux-foundation.org;
> Linuxarm <linuxarm@huawei.com>
> Subject: Re: [PATCH] iommu/arm-smmu-v3: allocate the memory of queues in
> local numa node
> 
> On Mon, Jun 01, 2020 at 11:31:41PM +1200, Barry Song wrote:
> > dmam_alloc_coherent() will usually allocate memory from the default CMA.
> For
> > a common arm64 defconfig without reserved memory in device tree, there is
> only
> > one CMA close to address 0.
> > dma_alloc_contiguous() will allocate memory without any idea of  NUMA
> and smmu
> > has no customized per-numa cma_area.
> > struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
> > {
> >         size_t count = size >> PAGE_SHIFT;
> >         struct page *page = NULL;
> >         struct cma *cma = NULL;
> >
> >         if (dev && dev->cma_area)
> >                 cma = dev->cma_area;
> >         else if (count > 1)
> >                 cma = dma_contiguous_default_area;
> >
> > 	...
> >         return page;
> > }
> >
> > if there are N numa nodes, N-1 nodes will put command/evt queues etc in a
> > remote node the default CMA belongs to,probably node 0. Tests show, after
> > sending CMD_SYNC in an empty command queue,
> > on Node2, without this patch, it takes 550ns to wait for the completion
> > of CMD_SYNC; with this patch, it takes 250ns to wait for the completion
> > of CMD_SYNC.
> >
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 63
> ++++++++++++++++++++++++++++---------
> >  1 file changed, 48 insertions(+), 15 deletions(-)
> 
> I would prefer that the coherent DMA allocator learned about NUMA, rather
> than we bodge drivers to use the streaming API where it doesn't really
> make sense.
> 
> I see that you've posted other patches to do that (thanks!), so I'll
> disregard this series.

Thanks for taking a look, Will. For sure I am using the per-numa cma patchset to
replace this patch. So it is ok to ignore this one.


> 
> Cheers,
> 
> Will

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
