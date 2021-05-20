Return-Path: <SRS0=ObaZ=KP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D0AEC433B4
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 12:51:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE27861163
	for <iommu@archiver.kernel.org>; Thu, 20 May 2021 12:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE27861163
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 91FBD40218;
	Thu, 20 May 2021 12:51:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vQgbBowwn6F4; Thu, 20 May 2021 12:51:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8268D400CC;
	Thu, 20 May 2021 12:51:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CD06C000E;
	Thu, 20 May 2021 12:51:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5895CC0001
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 12:51:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 324AD400CC
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 12:51:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OC4BG25OdpJA for <iommu@lists.linux-foundation.org>;
 Thu, 20 May 2021 12:51:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3C1A2400AB
 for <iommu@lists.linux-foundation.org>; Thu, 20 May 2021 12:51:54 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1621515111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VbT6WFYy0bkSk8HAYhg7anUqtgOM3QEr3KjCoKwSfHQ=;
 b=gOKAeXWpE3pQwkKpXwPHYoc4ERb31lQ3gBN7nTVt1yldwdnn1/3/XyAFth9rfgDimJkoQH
 agqxk+9Aox0SUUfXdjH85VkMEQazH8fYJyaFRs2tPVAJC3VdcHlyCnVzQyWN5LMIv2YHXJ
 O5RoTQ3j+3gflRxjf1BSBzx8QDoYDOo=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8A566ABE8;
 Thu, 20 May 2021 12:51:51 +0000 (UTC)
Date: Thu, 20 May 2021 14:51:50 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 3/3] lib/vsprintf: Use pr_crit() instead of long fancy
 messages
Message-ID: <YKZbZhACyIENhM8S@alley>
References: <20210331093104.383705-1-geert+renesas@glider.be>
 <20210331093104.383705-4-geert+renesas@glider.be>
 <CAMuHMdXQArCn9BS_8p0iUAgomfEHWe8ypg=B_SGfvJu8c_L5vg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdXQArCn9BS_8p0iUAgomfEHWe8ypg=B_SGfvJu8c_L5vg@mail.gmail.com>
Cc: Marco Elver <elver@google.com>,
 Linux Embedded <linux-embedded@vger.kernel.org>,
 John Ogness <john.ogness@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Will Deacon <will@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
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
From: Petr Mladek via iommu <iommu@lists.linux-foundation.org>
Reply-To: Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon 2021-05-17 08:21:12, Geert Uytterhoeven wrote:
> On Wed, Mar 31, 2021 at 11:59 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > While long fancy messages have a higher probability of being seen than
> > small messages, they may scroll of the screen fast, if visible at all,
> > and may still be missed.  In addition, they increase boot time and
> > kernel size.
> >
> > The correct mechanism to increase importance of a kernel message is not
> > to draw fancy boxes with more text, but to shout louder, i.e. increase
> > the message's reporting level.  Making sure the administrator of the
> > system is aware of such a message is a system policy, and is the
> > responsability of a user-space log daemon.
> >
> > Fix this by increasing the reporting level from KERN_WARNING to
> > KERN_CRIT, and removing irrelevant text and graphics.
> >
> > This reduces kernel size by ca. 0.5 KiB.
> >
> > Fixes: 5ead723a20e0447b ("lib/vsprintf: no_hash_pointers prints all addresses as unhashed")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> No comments?
> Unlike the cases handled by the other two patches in this series,
> this one cannot be configured out.

IMHO, the best solution would be to create a generic API for
eye-catching messages.

I am sure that WARN() is misused on many locations all over the kernel
because people just wanted eye-catching message, for example, see
https://lore.kernel.org/r/2149df3f542d25ce15d049e81d6188bb7198478c.camel@fi.rohmeurope.com

It might be a win-win solution.

Best Regards,
Petr
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
