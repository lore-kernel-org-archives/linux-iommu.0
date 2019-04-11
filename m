Return-Path: <SRS0=Ap1T=SN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63481C10F11
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 03:09:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F18920850
	for <iommu@archiver.kernel.org>; Thu, 11 Apr 2019 03:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F18920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E6D6121E0;
	Thu, 11 Apr 2019 03:09:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 89E191964
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 03:09:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 43CF57FB
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Apr 2019 03:09:36 +0000 (UTC)
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com
	[66.24.58.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 19D8C20818;
	Thu, 11 Apr 2019 03:09:35 +0000 (UTC)
Date: Wed, 10 Apr 2019 23:09:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC patch 28/41] dma/debug: Simplify stracktrace retrieval
Message-ID: <20190410230933.7d1138b3@oasis.local.home>
In-Reply-To: <20190411030201.uko3njal44w2ea4b@treble>
References: <20190410102754.387743324@linutronix.de>
	<20190410103646.130022106@linutronix.de>
	<20190411030201.uko3njal44w2ea4b@treble>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
	iommu@lists.linux-foundation.org, Alexander Potapenko <glider@google.com>,
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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
Message-ID: <20190411030933.Bn_9GEPQBrqA-bOTLQDEGGqJUE2cT1fVnqPPWRB8fZM@z>

On Wed, 10 Apr 2019 22:02:01 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> >  #ifdef CONFIG_STACKTRACE
> > -	struct		 stack_trace stacktrace;
> > -	unsigned long	 st_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
> > +	unsigned int	st_len;
> > +	unsigned long	st_entries[DMA_DEBUG_STACKTRACE_ENTRIES];  
> 
> nit: st_entries isn't very readable.  Thanks to the magic of compilers,
> the characters are free, so why not call them "stacktrace_entries" and
> "stacktrace_len".

But doesn't that slow down the time it takes to compile?

/me runs...

-- Steve
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
