Return-Path: <SRS0=UphA=BH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0005CC433EA
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 12:22:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE5AC206D4
	for <iommu@archiver.kernel.org>; Tue, 28 Jul 2020 12:22:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE5AC206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 98FCB8840E;
	Tue, 28 Jul 2020 12:22:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YOa6n2CYO3qP; Tue, 28 Jul 2020 12:22:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E4F3588408;
	Tue, 28 Jul 2020 12:22:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8963C0050;
	Tue, 28 Jul 2020 12:22:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31A76C004D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 12:22:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2086387D5A
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 12:22:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p4d8VOlxS9oU for <iommu@lists.linux-foundation.org>;
 Tue, 28 Jul 2020 12:22:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A915687D4B
 for <iommu@lists.linux-foundation.org>; Tue, 28 Jul 2020 12:22:48 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id E2E8B68B05; Tue, 28 Jul 2020 14:22:44 +0200 (CEST)
Date: Tue, 28 Jul 2020 14:22:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Subject: Re: [PATCH v4 1/2] dma-direct: provide the ability to reserve
 per-numa CMA
Message-ID: <20200728122244.GA3639@lst.de>
References: <20200723131344.41472-1-song.bao.hua@hisilicon.com>
 <20200723131344.41472-2-song.bao.hua@hisilicon.com>
 <20200728115231.GA793@lst.de>
 <B926444035E5E2439431908E3842AFD25C329D@DGGEMI525-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <B926444035E5E2439431908E3842AFD25C329D@DGGEMI525-MBS.china.huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Steve Capper <steve.capper@arm.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>, Linuxarm <linuxarm@huawei.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "Zengtao \(B\)" <prime.zeng@hisilicon.com>,
 "ganapatrao.kulkarni@cavium.com" <ganapatrao.kulkarni@cavium.com>,
 Andrew Morton <akpm@linux-foundation.org>, huangdaode <huangdaode@huawei.com>,
 "will@kernel.org" <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
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

On Tue, Jul 28, 2020 at 12:19:03PM +0000, Song Bao Hua (Barry Song) wrote:
> I am sorry I haven't got your point yet. Do you mean something like the below?
> 
> arch/arm64/Kconfig:
> config CMDLINE
> 	string "Default kernel command string"
> -	default ""
> +	default "pernuma_cma=16M"
> 	help
> 	  Provide a set of default command-line options at build time by
> 	  entering them here. As a minimum, you should specify the the
> 	  root device (e.g. root=/dev/nfs).

Yes.

> A background of the current code is that Linux distributions can usually use arch/arm64/configs/defconfig
> directly to build kernel. cmdline can be easily ignored during the generation of Linux distributions.

I've not actually heard of a distro shipping defconfig yet..

> 
> > if a way to expose this in the device tree might be useful, but people
> > more familiar with the device tree and the arm code will have to chime
> > in on that.
> 
> Not sure if it is an useful user case as we are using ACPI but not device tree since it is an ARM64
> server with NUMA.

Well, than maybe ACPI experts need to chime in on this.

> > This seems to have lost the dma_contiguous_default_area NULL check.
> 
> cma_alloc() is doing the check by returning NULL if cma is NULL.
> 
> struct page *cma_alloc(struct cma *cma, size_t count, unsigned int align,
> 		       bool no_warn)
> {
> 	...
> 	if (!cma || !cma->count)
> 		return NULL;
> }
> 
> But I agree here the code can check before calling cma_alloc_aligned.

Oh, indeed.  Please split the removal of the NULL check in to a prep
patch then.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
