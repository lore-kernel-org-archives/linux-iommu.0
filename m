Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B54C10F14
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 17:22:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A5920693
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 17:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A5920693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9CE402A61;
	Thu, 11 Apr 2019 17:22:21 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6ED582A58
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 17:21:44 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F23A1884
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 17:21:43 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id C814268B02; Thu, 11 Apr 2019 19:21:30 +0200 (CEST)
Date: Thu, 11 Apr 2019 19:21:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
Message-ID: <20190411172130.GA30189@lst.de>
References: <20190410102754.387743324@linutronix.de>
	<20190410103646.130022106@linutronix.de>
	<20190410110818.GA13904@lst.de>
	<alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, iommu@lists.linux-foundation.org,
	Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190411172130.-mkgsFx8gSXcG_5CTzMV8f2CO53cZkAAAgHTMw-lH7U@z>

On Wed, Apr 10, 2019 at 02:08:19PM +0200, Thomas Gleixner wrote:
> On Wed, 10 Apr 2019, Christoph Hellwig wrote:
> 
> > On Wed, Apr 10, 2019 at 12:28:22PM +0200, Thomas Gleixner wrote:
> > > Replace the indirection through struct stack_trace with an invocation of
> > > the storage array based interface.
> > 
> > This seems to be missing some context, at least stack_trace_save does
> > not actually exist in mainline.
> > 
> > Please always send the whole series out to everyone on the To and Cc
> > list, otherwise patch series are not reviewable.
>  
> Bah. People complain about overly broad cc-lists and the context is on
> lkml. But sure, I just bounced it to you.

People should stop complaining about that.  Deleting a mail is a single
keystroke.  Finding all the patches to apply them and test, or even
to review them is a nightmare.  That is why depending on my mood I'll
either complain like now when people do that crap, or if I feel bad
enough just ignore them.  If you don't give me the full context you
can't expect me to have an informed opinion.

Btw, the private forwarding is the worst of all worlds - now I have
the patches, but can't sensibly reply to them..
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
