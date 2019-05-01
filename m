Return-Path: <SRS0=GORt=TB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A563C43219
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 17:50:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EABE2063F
	for <iommu@archiver.kernel.org>; Wed,  1 May 2019 17:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EABE2063F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B8D2A2B42;
	Wed,  1 May 2019 17:50:07 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6D80D2B3D
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 17:49:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 08D43711
	for <iommu@lists.linux-foundation.org>;
	Wed,  1 May 2019 17:49:23 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id BB11B68AFE; Wed,  1 May 2019 19:49:05 +0200 (CEST)
Date: Wed, 1 May 2019 19:49:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 4/7] dma-direct: provide generic support for uncached
	kernel segments
Message-ID: <20190501174905.GA20458@lst.de>
References: <20190430110032.25301-1-hch@lst.de>
	<20190430110032.25301-5-hch@lst.de>
	<20190501171857.chfxqntvm6r4xrr4@pburton-laptop>
	<20190501172912.GA19375@lst.de>
	<20190501174033.6rj5aiopdeo4uqpw@pburton-laptop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190501174033.6rj5aiopdeo4uqpw@pburton-laptop>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Michal Simek <monstr@monstr.eu>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	James Hogan <jhogan@kernel.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>, Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190501174905.6GKykxZXcEtZs5yK4PePHu9HW95v-fHq_OWbpaQKquI@z>

On Wed, May 01, 2019 at 05:40:34PM +0000, Paul Burton wrote:
> > > If it is necessary then as-is this code will clear the allocated memory
> > > using uncached writes which will be pretty slow. It would be much more
> > > efficient to perform the memset before arch_dma_prep_coherent() & before
> > > converting ret to an uncached address.
> > 
> > Yes, we could do that.
> 
> Great; using cached writes would match the existing MIPS behavior.

Can you test the stack with the two updated patches and ack them if
they are fine?  That would allow getting at least the infrastructure
and mips in for this merge window.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
