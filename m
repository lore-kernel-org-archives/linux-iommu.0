Return-Path: <SRS0=oZX7=VP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634BAC76191
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 09:52:27 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3572C2173E
	for <iommu@archiver.kernel.org>; Thu, 18 Jul 2019 09:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3572C2173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D2A1E1442;
	Thu, 18 Jul 2019 09:52:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 54E6B114E
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 09:52:05 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A175012E
	for <iommu@lists.linux-foundation.org>;
	Thu, 18 Jul 2019 09:52:04 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2EDA768B05; Thu, 18 Jul 2019 11:52:01 +0200 (CEST)
Date: Thu, 18 Jul 2019 11:52:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH] powerpc/dma: Fix invalid DMA mmap behavior
Message-ID: <20190718095200.GA25744@lst.de>
References: <20190717235437.12908-1-shawn@anastas.io>
	<8b6963ac-521a-5752-2cfb-bcd87cad9dc4@ozlabs.ru>
	<f9753335-b62c-67b4-84d7-7b67fe1b64ca@anastas.io>
	<CAOSf1CGA_fDH7aAqRkc4maJUByaX7adGcjyt3cj4KFsMJNnocA@mail.gmail.com>
	<20190718084934.GF24562@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190718084934.GF24562@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Shawn Anastasio <shawn@anastas.io>, Sam Bobroff <sbobroff@linux.ibm.com>,
	iommu@lists.linux-foundation.org,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Christoph Hellwig <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, Jul 18, 2019 at 10:49:34AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 18, 2019 at 01:45:16PM +1000, Oliver O'Halloran wrote:
> > > Other than m68k, mips, and arm64, everybody else that doesn't have
> > > ARCH_NO_COHERENT_DMA_MMAP set uses this default implementation, so
> > > I assume this behavior is acceptable on those architectures.
> > 
> > It might be acceptable, but there's no reason to use pgport_noncached
> > if the platform supports cache-coherent DMA.
> > 
> > Christoph (+cc) made the change so maybe he saw something we're missing.
> 
> I always found the forcing of noncached access even for coherent
> devices a little odd, but this was inherited from the previous
> implementation, which surprised me a bit as the different attributes
> are usually problematic even on x86.  Let me dig into the history a
> bit more, but I suspect the righ fix is to default to cached mappings
> for coherent devices.

Ok, some history:

The generic dma mmap implementation, which we are effectively still
using today was added by:

commit 64ccc9c033c6089b2d426dad3c56477ab066c999
Author: Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Thu Jun 14 13:03:04 2012 +0200

    common: dma-mapping: add support for generic dma_mmap_* calls

and unconditionally uses pgprot_noncached in dma_common_mmap, which is
then used as the fallback by dma_mmap_attrs if no ->mmap method is
present.  At that point we already had the powerpc implementation
that only uses pgprot_noncached for non-coherent mappings, and
the arm one, which uses pgprot_writecombine if DMA_ATTR_WRITE_COMBINE
is set and otherwise pgprot_dmacoherent, which seems to be uncached.
Arm did support coherent platforms at that time, but they might have
been an afterthought and not handled properly.

So it migt have been that we were all wrong for that time and might
have to fix it up.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
