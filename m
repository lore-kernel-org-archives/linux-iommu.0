Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C91C10F13
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 17:45:23 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CB72082E
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 17:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CB72082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AE3ED2AAB;
	Thu, 11 Apr 2019 17:45:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 986E52A97
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 17:44:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 39176855
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 17:44:46 +0000 (UTC)
Received: by newverein.lst.de (Postfix, from userid 2407)
	id F289E68AFE; Thu, 11 Apr 2019 19:44:31 +0200 (CEST)
Date: Thu, 11 Apr 2019 19:44:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
Message-ID: <20190411174431.GA32109@lst.de>
References: <20190410102754.387743324@linutronix.de>
	<20190410103646.130022106@linutronix.de>
	<20190410110818.GA13904@lst.de>
	<alpine.DEB.2.21.1904101407190.3479@nanos.tec.linutronix.de>
	<20190411172130.GA30189@lst.de>
	<20190411133602.17e8ebdf@gandalf.local.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190411133602.17e8ebdf@gandalf.local.home>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org, Alexander Potapenko <glider@google.com>,
	Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20190411174431.jbeKBO-6qs11he0f1Clcc5fHrgV_Dk_fNqunTDTwrxE@z>

On Thu, Apr 11, 2019 at 01:36:02PM -0400, Steven Rostedt wrote:
> I guess the issue is when you get a 41 patch series, and there's only
> one patch you need to look at. There's times I get Cc'd on patch sets
> that I have no idea why I'm on the Cc. If I skim the patch set and
> don't see a relevance, I simply ignore it.

I sometimes do that as well, but then again ignoring/deleting is easy.
I wish people would think a little more on whom to Cc.  In general
I don't really need a personal Cc for drive by patches - I'll happily
pick them up from the mailing list and actually prefer it that way.
But I have received contrary feedback from people that do want to be
CCed on every little thing.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
