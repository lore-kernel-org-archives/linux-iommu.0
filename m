Return-Path: <SRS0=28v9=7V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79748C433DF
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 00:51:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FBBF20812
	for <iommu@archiver.kernel.org>; Mon,  8 Jun 2020 00:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FBBF20812
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D3A7C8557E;
	Mon,  8 Jun 2020 00:51:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ct6pjyaxTPe5; Mon,  8 Jun 2020 00:51:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A66708554A;
	Mon,  8 Jun 2020 00:51:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83627C0890;
	Mon,  8 Jun 2020 00:51:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43964C016F
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 00:51:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 3EA4720013
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 00:51:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mjMeUKlpJBIz for <iommu@lists.linux-foundation.org>;
 Mon,  8 Jun 2020 00:51:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by silver.osuosl.org (Postfix) with ESMTPS id 6217220133
 for <iommu@lists.linux-foundation.org>; Mon,  8 Jun 2020 00:51:06 +0000 (UTC)
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 434C31893322DC83ADAA;
 Mon,  8 Jun 2020 08:51:03 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.10]) by
 dggemi402-hub.china.huawei.com ([10.3.17.135]) with mapi id 14.03.0487.000;
 Mon, 8 Jun 2020 08:50:56 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Matthias Brugger <matthias.bgg@gmail.com>, Roman Gushchin <guro@fb.com>
Subject: RE: [PATCH 2/3] arm64: mm: reserve hugetlb CMA after numa_init
Thread-Topic: [PATCH 2/3] arm64: mm: reserve hugetlb CMA after numa_init
Thread-Index: AQHWOVDqOQ5Ue+21CU6BOgFAT6Yo26jFs6GAgAdkKACAANEJQA==
Date: Mon, 8 Jun 2020 00:50:56 +0000
Message-ID: <B926444035E5E2439431908E3842AFD24E1ED7@DGGEMI525-MBS.china.huawei.com>
References: <20200603024231.61748-1-song.bao.hua@hisilicon.com>
 <20200603024231.61748-3-song.bao.hua@hisilicon.com>
 <20200603032219.GA548147@carbon.lan>
 <bad059a3-c564-30a1-198f-1c92de601aed@gmail.com>
In-Reply-To: <bad059a3-c564-30a1-198f-1c92de601aed@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.95]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linuxarm <linuxarm@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
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
> From: Matthias Brugger [mailto:matthias.bgg@gmail.com]
> Sent: Monday, June 8, 2020 8:15 AM
> To: Roman Gushchin <guro@fb.com>; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>
> Cc: catalin.marinas@arm.com; John Garry <john.garry@huawei.com>;
> linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>;
> iommu@lists.linux-foundation.org; Zengtao (B) <prime.zeng@hisilicon.com>;
> Jonathan Cameron <jonathan.cameron@huawei.com>;
> robin.murphy@arm.com; hch@lst.de; linux-arm-kernel@lists.infradead.org;
> m.szyprowski@samsung.com
> Subject: Re: [PATCH 2/3] arm64: mm: reserve hugetlb CMA after numa_init
> 
> 
> 
> On 03/06/2020 05:22, Roman Gushchin wrote:
> > On Wed, Jun 03, 2020 at 02:42:30PM +1200, Barry Song wrote:
> >> hugetlb_cma_reserve() is called at the wrong place. numa_init has not been
> >> done yet. so all reserved memory will be located at node0.
> >>
> >> Cc: Roman Gushchin <guro@fb.com>
> >> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> >
> > Acked-by: Roman Gushchin <guro@fb.com>
> >
> 
> When did this break or was it broken since the beginning?
> In any case, could you provide a "Fixes" tag for it, so that it can easily be
> backported to older releases.

I guess it was broken at the first beginning.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cf11e85fc08cc

Fixes: cf11e85fc08c ("mm: hugetlb: optionally allocate gigantic hugepages using cma")

Would you think it is better for me to send v2 for this patch separately with this tag and take this out of my original patch set for per-numa CMA?
Please give your suggestion.

Best Regards
Barry

> 
> Regards,
> Matthias
> 
> > Thanks!
> >
> >> ---
> >>  arch/arm64/mm/init.c | 10 +++++-----
> >>  1 file changed, 5 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> index e42727e3568e..8f0e70ebb49d 100644
> >> --- a/arch/arm64/mm/init.c
> >> +++ b/arch/arm64/mm/init.c
> >> @@ -458,11 +458,6 @@ void __init arm64_memblock_init(void)
> >>  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
> >>
> >>  	dma_contiguous_reserve(arm64_dma32_phys_limit);
> >> -
> >> -#ifdef CONFIG_ARM64_4K_PAGES
> >> -	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> >> -#endif
> >> -
> >>  }
> >>
> >>  void __init bootmem_init(void)
> >> @@ -478,6 +473,11 @@ void __init bootmem_init(void)
> >>  	min_low_pfn = min;
> >>
> >>  	arm64_numa_init();
> >> +
> >> +#ifdef CONFIG_ARM64_4K_PAGES
> >> +	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
> >> +#endif
> >> +
> >>  	/*
> >>  	 * Sparsemem tries to allocate bootmem in memory_present(), so must
> be
> >>  	 * done after the fixed reservations.
> >> --
> >> 2.23.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
