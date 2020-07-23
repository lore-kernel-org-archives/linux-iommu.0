Return-Path: <SRS0=BMGV=BC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F27C433E1
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 11:55:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA57020684
	for <iommu@archiver.kernel.org>; Thu, 23 Jul 2020 11:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA57020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D7645898B3;
	Thu, 23 Jul 2020 11:55:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uRUaSFqa3b17; Thu, 23 Jul 2020 11:55:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 65350898B6;
	Thu, 23 Jul 2020 11:55:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3163EC004E;
	Thu, 23 Jul 2020 11:55:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53165C004C
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 11:55:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 33F292C342
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 11:55:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l-kJk4baW3nD for <iommu@lists.linux-foundation.org>;
 Thu, 23 Jul 2020 11:55:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by silver.osuosl.org (Postfix) with ESMTPS id DC86A29DD7
 for <iommu@lists.linux-foundation.org>; Thu, 23 Jul 2020 11:55:31 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6004C68AFE; Thu, 23 Jul 2020 13:55:27 +0200 (CEST)
Date: Thu, 23 Jul 2020 13:55:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v3 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Message-ID: <20200723115527.GA31598@lst.de>
References: <20200628111251.19108-1-song.bao.hua@hisilicon.com>
 <20200628111251.19108-2-song.bao.hua@hisilicon.com>
 <20200722141658.GA17658@lst.de>
 <B926444035E5E2439431908E3842AFD25A15A3@DGGEMI525-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <B926444035E5E2439431908E3842AFD25A15A3@DGGEMI525-MBS.china.huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Steve Capper <steve.capper@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, Linuxarm <linuxarm@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "ganapatrao.kulkarni@cavium.com" <ganapatrao.kulkarni@cavium.com>,
 huangdaode <huangdaode@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@linux.ibm.com>, "will@kernel.org" <will@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
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

On Wed, Jul 22, 2020 at 09:26:03PM +0000, Song Bao Hua (Barry Song) wrote:
> I understand your concern. Anyway, The primary purpose of this patchset is providing
> a general way for users like IOMMU to get local coherent dma buffers to put their
> command queue and page tables in. The first user case is what really made me
> begin to prepare this patchset.
> 
> For the second case, it is probably a positive side effect of this patchset for those users
> who have more concern on performance than dma security, then they maybe skip
> IOMMU by
> 	iommu.passthrough=
> 			[ARM64, X86] Configure DMA to bypass the IOMMU by default.
> 			Format: { "0" | "1" }
> 			0 - Use IOMMU translation for DMA.
> 			1 - Bypass the IOMMU for DMA.
> 			unset - Use value of CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
> In this case, they can get local memory and get better performance.
> However, it is not the primary purpose of this patchset.

That's not what I mean.  Hardcoding the CMA regions in the kernel
config is just a bad idea, and we should not add more hard coded values.
You can always use CONFIG_CMDLINE to force a specific kernel command
line including your options.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
