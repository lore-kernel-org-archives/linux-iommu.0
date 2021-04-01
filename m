Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B285C433ED
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 09:14:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE8E610A5
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 09:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE8E610A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07EE860A9A;
	Thu,  1 Apr 2021 09:14:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k6PgkUK7fUit; Thu,  1 Apr 2021 09:14:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB61E60A97;
	Thu,  1 Apr 2021 09:14:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C137CC000B;
	Thu,  1 Apr 2021 09:14:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A9F1C000A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 09:14:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 336894062D
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 09:14:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eNXALUrmS2Ap for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 09:14:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE32B40629
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 09:14:50 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1617268488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fNVeVEJsE2NrNnpG1ONXT+uOw5bYJLkau4SXRA3zVtY=;
 b=GRFP7NyKhoU4R3Df8eXeg/mty4f651aCNMyk12y/rdwQeK6fl4bVrfiimdQlcVB0giY/k6
 NLUIG/qpYN1Odp3Xmygn+0Z+MjnFMv47Lp9hQJTw4JhqBOsBl8MNXXPsZhYruek/IXkQzp
 GNzwnEg1mD2Q4UsVtqYP3SO7sHaryIc=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id F3BD8AE6D;
 Thu,  1 Apr 2021 09:14:47 +0000 (UTC)
Date: Thu, 1 Apr 2021 11:14:47 +0200
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] tracing: Use pr_crit() instead of long fancy messages
Message-ID: <YGWPB8hPVVOIx4AG@alley>
References: <20210331093104.383705-1-geert+renesas@glider.be>
 <20210331093104.383705-3-geert+renesas@glider.be>
 <20210331094007.77aa5194@gandalf.local.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210331094007.77aa5194@gandalf.local.home>
Cc: Marco Elver <elver@google.com>, linux-embedded@vger.kernel.org,
 John Ogness <john.ogness@linutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
 Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Will Deacon <will@kernel.org>, Gary R Hook <gary.hook@amd.com>
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

On Wed 2021-03-31 09:40:07, Steven Rostedt wrote:
> On Wed, 31 Mar 2021 11:31:03 +0200
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> 
> > This reduces kernel size by ca. 0.5 KiB.
> 
> If you are worried about size, disable tracing and it will go away
> entirely. 0.5KiB is a drop in the bucket compared to what tracing adds in
> size overhead.
> 
> Sorry, but NAK.
> 
> This has been very successful in stopping people from adding trace_printk()
> to the kernel, and I like to keep it that way.

I agree with Steven. I believe that the eye-catching form is
important.

Anyway, all three patches are replacing text that have
many common parts. It is:

	pr_warn("\n");
	pr_warn("**********************************************************\n");
	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
	pr_warn("**                                                      **\n");
	pr_warn("** <Something is enabled/used.>			 **\n");
	pr_warn("**                                                      **\n");
	pr_warn("** <Description of the effect and why it should not     **\n");
	pr_warn("** happen on production kernel>			**\n");
	pr_warn("**                                                      **\n");
	pr_warn("** If you see this message and you are not debugging    **\n");
	pr_warn("** the kernel, report this immediately to your vendor!  **\n");
	pr_warn("**                                                      **\n");
	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
	pr_warn("**********************************************************\n");

It might be useful to avoid cut&pasting this entire blob and unify the
common parts.

My only concern is how to define the caller-specific lines so that
they fit with the common ones. They should not be longer than the
header and footer. We need to find a good compromise between
usability and over-engineering.

Also we have to keep bikeshading under control ;-)

Best Regards,
Petr
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
