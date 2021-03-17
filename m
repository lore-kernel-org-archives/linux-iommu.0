Return-Path: <SRS0=kdPY=IP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBF9C433DB
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 17:57:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A429164F0F
	for <iommu@archiver.kernel.org>; Wed, 17 Mar 2021 17:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A429164F0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E9AE606CA;
	Wed, 17 Mar 2021 17:57:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jfG6_C49wZtE; Wed, 17 Mar 2021 17:57:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F6A56063F;
	Wed, 17 Mar 2021 17:57:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0349CC000A;
	Wed, 17 Mar 2021 17:57:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B482CC0001
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 17:57:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C71E42FB1
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 17:57:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BlDjIN5hS-n0 for <iommu@lists.linux-foundation.org>;
 Wed, 17 Mar 2021 17:57:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8EEBE4150B
 for <iommu@lists.linux-foundation.org>; Wed, 17 Mar 2021 17:57:46 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6243568BFE; Wed, 17 Mar 2021 18:57:42 +0100 (CET)
Date: Wed, 17 Mar 2021 18:57:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 12/14] swiotlb: move global variables into a new
 io_tlb_mem structure
Message-ID: <20210317175742.GA29280@lst.de>
References: <20210301074436.919889-1-hch@lst.de>
 <20210301074436.919889-13-hch@lst.de>
 <20210317134204.GA315788@konrad-char-us-oracle-com.allregionaliads.osdevelopmeniad.oraclevcn.com>
 <20210317135327.GA10797@lst.de> <YFJBvFjtZUiBQj4k@Konrads-MacBook-Pro.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YFJBvFjtZUiBQj4k@Konrads-MacBook-Pro.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
 Michael Ellerman <mpe@ellerman.id.au>, iommu@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, Claire Chang <tientzu@chromium.org>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
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

On Wed, Mar 17, 2021 at 01:51:56PM -0400, Konrad Rzeszutek Wilk wrote:
> On Wed, Mar 17, 2021 at 02:53:27PM +0100, Christoph Hellwig wrote:
> > On Wed, Mar 17, 2021 at 01:42:07PM +0000, Konrad Rzeszutek Wilk wrote:
> > > > -	alloc_size = PAGE_ALIGN(io_tlb_nslabs * sizeof(size_t));
> > > > -	io_tlb_alloc_size = memblock_alloc(alloc_size, PAGE_SIZE);
> > > > -	if (!io_tlb_alloc_size)
> > > > -		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
> > > > -		      __func__, alloc_size, PAGE_SIZE);
> > > 
> > > Shouldn't this be converted to:
> > > 	mem->alloc_size = memblock_alloc(alloc_size, PAGE_SIZE);
> > > 	if (...)
> > > 
> > > Seems that it got lost in the search and replace?
> > 
> > Yes, I messed that up during the rebase.  That being said it magically
> > gets fixed in the next patch..
> 
> Yes. However if someone does a bisection they are going to be mighty unhappy
> with you.

Sure, I was planning on fixing it anyway.  Just waiting for feedback
on the rest of the patches before doing a respin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
