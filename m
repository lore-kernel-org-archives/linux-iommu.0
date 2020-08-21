Return-Path: <SRS0=6E3Y=B7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A053DC433DF
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 08:29:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716D320658
	for <iommu@archiver.kernel.org>; Fri, 21 Aug 2020 08:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716D320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4A4C988667;
	Fri, 21 Aug 2020 08:29:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2--IjeI5380R; Fri, 21 Aug 2020 08:29:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4095988659;
	Fri, 21 Aug 2020 08:29:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24EB7C07FF;
	Fri, 21 Aug 2020 08:29:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA45CC0051
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 08:29:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 921AF88660
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 08:29:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wmt2unMJDjRS for <iommu@lists.linux-foundation.org>;
 Fri, 21 Aug 2020 08:29:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CC31D88659
 for <iommu@lists.linux-foundation.org>; Fri, 21 Aug 2020 08:29:42 +0000 (UTC)
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id B0E2AF97C94A8C457749;
 Fri, 21 Aug 2020 16:29:37 +0800 (CST)
Received: from dggema771-chm.china.huawei.com (10.1.198.213) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 21 Aug 2020 16:29:37 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggema771-chm.china.huawei.com (10.1.198.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 21 Aug 2020 16:29:36 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Fri, 21 Aug 2020 16:29:37 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Randy Dunlap <rdunlap@infradead.org>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "will@kernel.org" <will@kernel.org>,
 "ganapatrao.kulkarni@cavium.com" <ganapatrao.kulkarni@cavium.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>
Subject: RE: [PATCH v6 1/2] dma-contiguous: provide the ability to reserve
 per-numa CMA
Thread-Topic: [PATCH v6 1/2] dma-contiguous: provide the ability to reserve
 per-numa CMA
Thread-Index: AQHWd2LcxiMeqDASCk2fUz72+ALjbKlBVpwAgADf/CA=
Date: Fri, 21 Aug 2020 08:29:37 +0000
Message-ID: <81b215005152449ca4392862d0676ded@hisilicon.com>
References: <20200821022615.28596-1-song.bao.hua@hisilicon.com>
 <20200821022615.28596-2-song.bao.hua@hisilicon.com>
 <5dbe456d-d408-11ef-788e-63d996435fa8@infradead.org>
In-Reply-To: <5dbe456d-d408-11ef-788e-63d996435fa8@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.192]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: Steve Capper <steve.capper@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linuxarm <linuxarm@huawei.com>, huangdaode <huangdaode@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>,
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
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Randy Dunlap
> Sent: Friday, August 21, 2020 2:50 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; hch@lst.de;
> m.szyprowski@samsung.com; robin.murphy@arm.com; will@kernel.org;
> ganapatrao.kulkarni@cavium.com; catalin.marinas@arm.com
> Cc: iommu@lists.linux-foundation.org; Linuxarm <linuxarm@huawei.com>;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> huangdaode <huangdaode@huawei.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de>; Steve Capper <steve.capper@arm.com>; Andrew
> Morton <akpm@linux-foundation.org>; Mike Rapoport <rppt@linux.ibm.com>
> Subject: Re: [PATCH v6 1/2] dma-contiguous: provide the ability to reserve
> per-numa CMA
> 
> On 8/20/20 7:26 PM, Barry Song wrote:
> >
> >
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
> >  v6: rebase on top of 5.9-rc1;
> >      doc cleanup
> >
> >  .../admin-guide/kernel-parameters.txt         |   9 ++
> >  include/linux/dma-contiguous.h                |   6 ++
> >  kernel/dma/Kconfig                            |  10 ++
> >  kernel/dma/contiguous.c                       | 100
> ++++++++++++++++--
> >  4 files changed, 115 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt
> b/Documentation/admin-guide/kernel-parameters.txt
> > index bdc1f33fd3d1..3f33b89aeab5 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -599,6 +599,15 @@
> >  			altogether. For more information, see
> >  			include/linux/dma-contiguous.h
> >
> > +	pernuma_cma=nn[MG]
> 
> memparse() allows any one of these suffixes: K, M, G, T, P, E
> and nothing in the option parsing function cares what suffix is used...

Hello Randy,
Thanks for your comments.

Actually I am following the suffix of default cma:
	cma=nn[MG]@[start[MG][-end[MG]]]
			[ARM,X86,KNL]
			Sets the size of kernel global memory area for
			contiguous memory allocations and optionally the
			placement constraint by the physical address range of
			memory allocations. A value of 0 disables CMA
			altogether. For more information, see
			include/linux/dma-contiguous.h

I suggest users should set the size in either MB or GB as they set cma. 

> 
> > +			[ARM64,KNL]
> > +			Sets the size of kernel per-numa memory area for
> > +			contiguous memory allocations. A value of 0 disables
> > +			per-numa CMA altogether. DMA users on node nid will
> > +			first try to allocate buffer from the pernuma area
> > +			which is located in node nid, if the allocation fails,
> > +			they will fallback to the global default memory area.
> > +
> >  	cmo_free_hint=	[PPC] Format: { yes | no }
> >  			Specify whether pages are marked as being inactive
> >  			when they are freed.  This is used in CMO environments
> 
> > diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> > index cff7e60968b9..89b95f10e56d 100644
> > --- a/kernel/dma/contiguous.c
> > +++ b/kernel/dma/contiguous.c
> > @@ -69,6 +69,19 @@ static int __init early_cma(char *p)
> >  }
> >  early_param("cma", early_cma);
> >
> > +#ifdef CONFIG_DMA_PERNUMA_CMA
> > +
> > +static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
> > +static phys_addr_t pernuma_size_bytes __initdata;
> 
> why phys_addr_t? couldn't it just be unsigned long long?
> 

Mainly because of following the programming habit in kernel/dma/contiguous.c:
I think the original code probably meant the size should not be larger than the MAXIMUM
value of phys_addr_t:

/*
 * Default global CMA area size can be defined in kernel's .config.
 * This is useful mainly for distro maintainers to create a kernel
 * that works correctly for most supported systems.
 * The size can be set in bytes or as a percentage of the total memory
 * in the system.
 *
 * Users, who want to set the size of global CMA area for their system
 * should use cma= kernel parameter.
 */
static const phys_addr_t size_bytes __initconst =
	(phys_addr_t)CMA_SIZE_MBYTES * SZ_1M;
static phys_addr_t  size_cmdline __initdata = -1;
static phys_addr_t base_cmdline __initdata;
static phys_addr_t limit_cmdline __initdata;

void __init dma_contiguous_reserve(phys_addr_t limit)
{
	phys_addr_t selected_size = 0;
	phys_addr_t selected_base = 0;
	phys_addr_t selected_limit = limit;
	bool fixed = false;

	pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);

	if (size_cmdline != -1) {
		selected_size = size_cmdline;
		selected_base = base_cmdline;
		selected_limit = min_not_zero(limit_cmdline, limit);
		if (base_cmdline + size_cmdline == limit_cmdline)
			fixed = true;

if the whole file is using phys_addr_t for size, I don't want to make the new code weird.

> OK, so cma_declare_contiguous_nid() uses phys_addr_t. Fine.
> 
> > +
> > +static int __init early_pernuma_cma(char *p)
> > +{
> > +	pernuma_size_bytes = memparse(p, &p);
> > +	return 0;
> > +}
> > +early_param("pernuma_cma", early_pernuma_cma);
> > +#endif
> > +
> >  #ifdef CONFIG_CMA_SIZE_PERCENTAGE
> >
> >  static phys_addr_t __init __maybe_unused
> cma_early_percent_memory(void)
> > @@ -96,6 +109,34 @@ static inline __maybe_unused phys_addr_t
> cma_early_percent_memory(void)
> >
> >  #endif
> >
> > +#ifdef CONFIG_DMA_PERNUMA_CMA
> > +void __init dma_pernuma_cma_reserve(void)
> > +{
> > +	int nid;
> > +
> > +	if (!pernuma_size_bytes)
> > +		return;
> > +
> > +	for_each_node_state(nid, N_ONLINE) {
> > +		int ret;
> > +		char name[20];
> > +		struct cma **cma = &dma_contiguous_pernuma_area[nid];
> > +
> > +		snprintf(name, sizeof(name), "pernuma%d", nid);
> > +		ret = cma_declare_contiguous_nid(0, pernuma_size_bytes, 0, 0,
> > +						 0, false, name, cma, nid);
> > +		if (ret) {
> > +			pr_warn("%s: reservation failed: err %d, node %d", __func__,
> > +				ret, nid);
> > +			continue;
> > +		}
> > +
> > +		pr_debug("%s: reserved %llu MiB on node %d\n", __func__,
> > +			(unsigned long long)pernuma_size_bytes / SZ_1M, nid);
> 
> Conversely, if you want to leave pernuma_size_bytes as phys_addr_t,
> you should use %pa (or %pap) to print it.

Here I think it is working as "size" in integer.

> 
> > +	}
> > +}
> > +#endif

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
