Return-Path: <SRS0=LOQj=BI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92EBC433E0
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 11:22:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767F420809
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 11:22:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767F420809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4BF0E87FD6;
	Wed, 29 Jul 2020 11:22:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OKgOaCcFZJgC; Wed, 29 Jul 2020 11:22:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9577187F81;
	Wed, 29 Jul 2020 11:22:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86BFBC0050;
	Wed, 29 Jul 2020 11:22:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2B2B7C004D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 11:22:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E79EA8587E
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 11:21:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wyeDSGtYgn0D for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jul 2020 11:21:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3030885876
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 11:21:29 +0000 (UTC)
Received: from dggemi406-hub.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id E3A8BB8278ABC432252B;
 Wed, 29 Jul 2020 19:21:19 +0800 (CST)
Received: from DGGEMI424-HUB.china.huawei.com (10.1.199.153) by
 dggemi406-hub.china.huawei.com (10.3.17.144) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 29 Jul 2020 19:21:19 +0800
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.120]) by
 DGGEMI424-HUB.china.huawei.com ([10.1.199.153]) with mapi id 14.03.0487.000;
 Wed, 29 Jul 2020 19:21:10 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH v4 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Thread-Topic: [PATCH v4 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Thread-Index: AQHWYPN0xh/nM4EZ4kKvOhwzWqp/oakcYyKAgACGKwD//4JGAIACAmig
Date: Wed, 29 Jul 2020 11:21:09 +0000
Message-ID: <B926444035E5E2439431908E3842AFD25C8B1D@DGGEMI525-MBS.china.huawei.com>
References: <20200723131344.41472-1-song.bao.hua@hisilicon.com>
 <20200723131344.41472-2-song.bao.hua@hisilicon.com>
 <20200728115231.GA793@lst.de>
 <B926444035E5E2439431908E3842AFD25C329D@DGGEMI525-MBS.china.huawei.com>
 <20200728122244.GA3639@lst.de>
In-Reply-To: <20200728122244.GA3639@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.121]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Steve Capper <steve.capper@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, Linuxarm <linuxarm@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "ganapatrao.kulkarni@cavium.com" <ganapatrao.kulkarni@cavium.com>,
 Andrew Morton <akpm@linux-foundation.org>, huangdaode <huangdaode@huawei.com>,
 "will@kernel.org" <will@kernel.org>,
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
> From: Christoph Hellwig [mailto:hch@lst.de]
> Sent: Wednesday, July 29, 2020 12:23 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: Christoph Hellwig <hch@lst.de>; m.szyprowski@samsung.com;
> robin.murphy@arm.com; will@kernel.org; ganapatrao.kulkarni@cavium.com;
> catalin.marinas@arm.com; iommu@lists.linux-foundation.org; Linuxarm
> <linuxarm@huawei.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Zengtao (B) <prime.zeng@hisilicon.com>;
> huangdaode <huangdaode@huawei.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>; Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de>; Steve Capper <steve.capper@arm.com>; Andrew
> Morton <akpm@linux-foundation.org>; Mike Rapoport <rppt@linux.ibm.com>
> Subject: Re: [PATCH v4 1/2] dma-direct: provide the ability to reserve
> per-numa CMA
> 
> On Tue, Jul 28, 2020 at 12:19:03PM +0000, Song Bao Hua (Barry Song) wrote:
> > I am sorry I haven't got your point yet. Do you mean something like the
> below?
> >
> > arch/arm64/Kconfig:
> > config CMDLINE
> > 	string "Default kernel command string"
> > -	default ""
> > +	default "pernuma_cma=16M"
> > 	help
> > 	  Provide a set of default command-line options at build time by
> > 	  entering them here. As a minimum, you should specify the the
> > 	  root device (e.g. root=/dev/nfs).
> 
> Yes.
> 
> > A background of the current code is that Linux distributions can usually use
> arch/arm64/configs/defconfig
> > directly to build kernel. cmdline can be easily ignored during the generation
> of Linux distributions.
> 
> I've not actually heard of a distro shipping defconfig yet..
> 
> >
> > > if a way to expose this in the device tree might be useful, but people
> > > more familiar with the device tree and the arm code will have to chime
> > > in on that.
> >
> > Not sure if it is an useful user case as we are using ACPI but not device tree
> since it is an ARM64
> > server with NUMA.
> 
> Well, than maybe ACPI experts need to chime in on this.
> 
> > > This seems to have lost the dma_contiguous_default_area NULL check.
> >
> > cma_alloc() is doing the check by returning NULL if cma is NULL.
> >
> > struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
> > 		       bool no_warn)
> > {
> > 	...
> > 	if (!cma || !cma->count)
> > 		return NULL;
> > }
> >
> > But I agree here the code can check before calling cma_alloc_aligned.
> 
> Oh, indeed.  Please split the removal of the NULL check in to a prep
> patch then.

Do you mean removing the NULL check in cma_alloc()? If so, it seems lot of places
need to be changed:

struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
				       unsigned int align, bool no_warn)
{
	if (align > CONFIG_CMA_ALIGNMENT)
		align = CONFIG_CMA_ALIGNMENT;
+ code to check dev_get_cma_area(dev) is not NULL
	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
}

bool dma_release_from_contiguous(struct device *dev, struct page *pages,
				 int count)
{
+ code to check dev_get_cma_area(dev) is not NULL
	return cma_release(dev_get_cma_area(dev), pages, count);
}

bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
{
	unsigned long pfn;
+ do we need to remove this !cma too if we remove it in cma_alloc()?
	if (!cma || !pages)
		return false;
	...
}

And some other places where cma_alloc() and cma_release() are called:

arch/powerpc/kvm/book3s_hv_builtin.c
drivers/dma-buf/heaps/cma_heap.c
drivers/s390/char/vmcp.c
drivers/staging/android/ion/ion_cma_heap.c
mm/hugetlb.c

it seems many code were written with the assumption that cma_alloc/release will
check if cma is null so they don't check it before calling cma_alloc().

And I am not sure if kernel robot will report error like pointer reference before checking
it if !cma is removed in cma_alloc().

Thanks
Barry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
