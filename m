Return-Path: <SRS0=JP6a=XN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23DCC4CEC9
	for <iommu@archiver.kernel.org>; Wed, 18 Sep 2019 20:01:16 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F487207FC
	for <iommu@archiver.kernel.org>; Wed, 18 Sep 2019 20:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F487207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AE067DDC;
	Wed, 18 Sep 2019 20:01:14 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id AE288DD8
	for <iommu@lists.linux-foundation.org>;
	Wed, 18 Sep 2019 20:01:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 5CF3E711
	for <iommu@lists.linux-foundation.org>;
	Wed, 18 Sep 2019 20:01:12 +0000 (UTC)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23994220AbfIRTsi136uQ (ORCPT
	<rfc822;iommu@lists.linux-foundation.org>);
	Wed, 18 Sep 2019 21:48:38 +0200
Date: Wed, 18 Sep 2019 20:48:38 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: DMA_ATTR_WRITE_COMBINE on mips
In-Reply-To: <20190802063712.GA7553@lst.de>
Message-ID: <alpine.LFD.2.21.1909160545010.32531@eddie.linux-mips.org>
References: <20190802063712.GA7553@lst.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Cc: James Hogan <jhogan@kernel.org>, Paul Burton <paul.burton@mips.com>,
	iommu@lists.linux-foundation.org, linux-mips@vger.kernel.org,
	Alex Smith <alex.smith@imgtec.com>,
	Sadegh Abbasi <Sadegh.Abbasi@imgtec.com>, linux-kernel@vger.kernel.org
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

Hi Christoph,

> [I hope the imgtec address still works, but maybe the mips folks know
> if it moved to mips]

 Alex left Imagination long before the transition to the interim MIPS 
company.

> you added DMA_ATTR_WRITE_COMBINE support in dma_mmap_attrs to mips
> in commit 8c172467be36f7c9591e59b647e4cd342ce2ef41
> ("MIPS: Add implementation of dma_map_ops.mmap()"), but that commit
> only added the support in mmap, not in dma_alloc_attrs.  This means
> the memory is now used in kernel space through KSEG1, and thus uncached,
> while for userspace mappings through dma_mmap_* pgprot_writebombine
> is used, which creates a write combine mapping, which on some MIPS CPUs
> sets the _CACHE_UNCACHED_ACCELERATED pte bit instead of the
> _CACHE_UNCACHED one.  I know at least on arm, powerpc and x86 such
> mixed page cachability attributes can cause pretty severe problems.
> Are they ok on mips?

 The uncached accelerated mode is implementation-specific, so you won't 
find its definition in the architecture, however the original R10000 
implementation explicitly documents[1] interactions between bus accesses 
using the two modes (essentially a _CACHE_UNCACHED store acts as a barrier 
for any outstanding _CACHE_UNCACHED_ACCELERATED stores; for loads the 
modes are equivalent), so that's clearly supported.

 I've glanced over the interAptiv manual[2] too and it seems to define the 
caching modes similarly.

>  Or was the DMA_ATTR_WRITE_COMBINE supported
> unintended and not correct and we should remove it?

 I don't know, so regrettably I can't comment on this.

References:

[1] "MIPS R10000 Microprocessor", Version 2.0, MIPS Technologies, Inc., 
    January 29, 1997
    <http://techpubs.sgi.com/library/manuals/2000/007-2490-001/pdf/007-2490-001.pdf>

[2] "MIPS32 interAptiv Multiprocessing System Software User's Manual", 
    Imagination Technologies Ltd., Document Number: MD00904, Revision 
    02.01, June 15, 2016

  Maciej
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
