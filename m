Return-Path: <SRS0=03l9=BB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6966EC433E4
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 21:26:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 298CE20825
	for <iommu@archiver.kernel.org>; Wed, 22 Jul 2020 21:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 298CE20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id F073387CE4;
	Wed, 22 Jul 2020 21:26:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V+NUgKbeuKJ7; Wed, 22 Jul 2020 21:26:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8D03F87C88;
	Wed, 22 Jul 2020 21:26:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80AF9C004D;
	Wed, 22 Jul 2020 21:26:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C363C004C
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 21:26:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7354D20381
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 21:26:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sFLHqc02xgfv for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jul 2020 21:26:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by silver.osuosl.org (Postfix) with ESMTPS id 4CB832035B
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jul 2020 21:26:15 +0000 (UTC)
Received: from dggemi404-hub.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 351ECD2A31C70E876290;
 Thu, 23 Jul 2020 05:26:12 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.52]) by
 dggemi404-hub.china.huawei.com ([10.3.17.142]) with mapi id 14.03.0487.000;
 Thu, 23 Jul 2020 05:26:04 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH v3 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Thread-Topic: [PATCH v3 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Thread-Index: AQHWTT1ZxTwLmOgUCE+K/2/rfDv6P6kTRO0AgAD4soA=
Date: Wed, 22 Jul 2020 21:26:03 +0000
Message-ID: <B926444035E5E2439431908E3842AFD25A15A3@DGGEMI525-MBS.china.huawei.com>
References: <20200628111251.19108-1-song.bao.hua@hisilicon.com>
 <20200628111251.19108-2-song.bao.hua@hisilicon.com>
 <20200722141658.GA17658@lst.de>
In-Reply-To: <20200722141658.GA17658@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.4]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Steve Capper <steve.capper@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, Linuxarm <linuxarm@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "ganapatrao.kulkarni@cavium.com" <ganapatrao.kulkarni@cavium.com>,
 huangdaode <huangdaode@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@linux.ibm.com>, "will@kernel.org" <will@kernel.org>,
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
> Sent: Thursday, July 23, 2020 2:17 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: hch@lst.de; m.szyprowski@samsung.com; robin.murphy@arm.com;
> will@kernel.org; ganapatrao.kulkarni@cavium.com;
> catalin.marinas@arm.com; iommu@lists.linux-foundation.org; Linuxarm
> <linuxarm@huawei.com>; linux-arm-kernel@lists.infradead.org;
> linux-kernel@vger.kernel.org; Jonathan Cameron
> <jonathan.cameron@huawei.com>; Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de>; Steve Capper <steve.capper@arm.com>; Andrew
> Morton <akpm@linux-foundation.org>; Mike Rapoport <rppt@linux.ibm.com>
> Subject: Re: [PATCH v3 1/2] dma-direct: provide the ability to reserve
> per-numa CMA
> 

+cc Prime and Daode who are interested in this patchset.

> On Sun, Jun 28, 2020 at 11:12:50PM +1200, Barry Song wrote:
> > This is useful for at least two scenarios:
> > 1. ARM64 smmu will get memory from local numa node, it can save its
> > command queues and page tables locally. Tests show it can decrease
> > dma_unmap latency at lot. For example, without this patch, smmu on
> > node2 will get memory from node0 by calling dma_alloc_coherent(),
> > typically, it has to wait for more than 560ns for the completion of
> > CMD_SYNC in an empty command queue; with this patch, it needs 240ns
> > only.
> > 2. when we set iommu passthrough, drivers will get memory from CMA,
> > local memory means much less latency.
> 
> I really don't like the config options.  With the boot parameters
> you can always hardcode that in CONFIG_CMDLINE anyway.

I understand your concern. Anyway, The primary purpose of this patchset is providing
a general way for users like IOMMU to get local coherent dma buffers to put their
command queue and page tables in. The first user case is what really made me
begin to prepare this patchset.

For the second case, it is probably a positive side effect of this patchset for those users
who have more concern on performance than dma security, then they maybe skip
IOMMU by
	iommu.passthrough=
			[ARM64, X86] Configure DMA to bypass the IOMMU by default.
			Format: { "0" | "1" }
			0 - Use IOMMU translation for DMA.
			1 - Bypass the IOMMU for DMA.
			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
In this case, they can get local memory and get better performance.
However, it is not the primary purpose of this patchset.

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
