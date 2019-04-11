Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31D5C10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 17:36:54 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46242084D
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 17:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46242084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 762812A95;
	Thu, 11 Apr 2019 17:36:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 015752A5D
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 17:36:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 7C03D875
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 17:36:05 +0000 (UTC)
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com
	[66.24.58.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 63DD62084D;
	Thu, 11 Apr 2019 17:36:04 +0000 (UTC)
Date: Thu, 11 Apr 2019 13:36:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
Message-ID: <20190411133602.17e8ebdf@gandalf.local.home>
In-Reply-To: <20190411172130.GA30189@lst.de>
References: <20190410102754.387743324@linutronix.de>
	<20190410103646.130022106@linutronix.de>
	<20190410110818.GA13904@lst.de>
	<alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de>
	<20190411172130.GA30189@lst.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org, Alexander Potapenko <glider@google.com>,
	Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Robin Murphy <robin.murphy@arm.com>
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
Message-ID: <20190411173602.hW-gEPgM14-kjFD7j34JCQ6fgbAKHIamoXvCwd15CA4@z>

On Thu, 11 Apr 2019 19:21:30 +0200
Christoph Hellwig <hch@lst.de> wrote:

> > Bah. People complain about overly broad cc-lists and the context is on
> > lkml. But sure, I just bounced it to you.  
> 
> People should stop complaining about that.  Deleting a mail is a single
> keystroke.  Finding all the patches to apply them and test, or even
> to review them is a nightmare.  That is why depending on my mood I'll
> either complain like now when people do that crap, or if I feel bad
> enough just ignore them.  If you don't give me the full context you
> can't expect me to have an informed opinion.

I guess the issue is when you get a 41 patch series, and there's only
one patch you need to look at. There's times I get Cc'd on patch sets
that I have no idea why I'm on the Cc. If I skim the patch set and
don't see a relevance, I simply ignore it.

But there may be one patch I was suppose to review and I miss it. I
personally prefer to get only Cc'd on the cover letter and the patch I
need to review. Now, if that patch is dependent on other patches, then
perhaps it would be nice to be Cc'd on them too.

In other words, I much rather be Cc'd on only the patches that pertain
to me (and the supporting patches for it) then the entire series.
Especially when it's 40 patches or more.

Yes, it's a single click to delete patches that I don't need to look
at, but what I usually do in these cases is just delete the entire
series.

Note, as I do a lot with stack traces, this entire series pertains to
me and I'm happy I was on the full Cc list. But there's other examples
where it does not.

> 
> Btw, the private forwarding is the worst of all worlds - now I have
> the patches, but can't sensibly reply to them..

BTW, lore.kernel.org has a way to reply back to the list.

-- Steve
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
