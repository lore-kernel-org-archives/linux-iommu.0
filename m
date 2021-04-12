Return-Path: <SRS0=Qw7g=JJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35FCC433B4
	for <iommu@archiver.kernel.org>; Mon, 12 Apr 2021 10:49:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4283461350
	for <iommu@archiver.kernel.org>; Mon, 12 Apr 2021 10:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4283461350
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DFDD740227;
	Mon, 12 Apr 2021 10:49:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k8spWES4XsyR; Mon, 12 Apr 2021 10:49:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id DE2FE40123;
	Mon, 12 Apr 2021 10:49:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97F1AC000B;
	Mon, 12 Apr 2021 10:49:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B1BFC000A
 for <iommu@lists.linux-foundation.org>; Mon, 12 Apr 2021 10:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 78ECA60662
 for <iommu@lists.linux-foundation.org>; Mon, 12 Apr 2021 10:49:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ukJjOzpv19nm for <iommu@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 10:49:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 773196062C
 for <iommu@lists.linux-foundation.org>; Mon, 12 Apr 2021 10:49:21 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1618224560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y3nWrWViWarEokL29oGWFlAfkjkUJE9MTrNl0iKBD4M=;
 b=iazxBz9y39JUxT0qYbRCWlWacub+aN8E+OF5PwpMp3XYR7fk1Y89jH05DbfB9yZTlgznn6
 Fa0yFGQz0FO7Ij6sjXFzSX3P5cKCD/CmrBIrY9zgvVCZaAx3l6m624mYvnxAmbjGxiWANL
 a/wz3IsjUw2mxO+V8c8nxw2mlTdisq4=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6983CB250;
 Mon, 12 Apr 2021 10:49:20 +0000 (UTC)
Date: Mon, 12 Apr 2021 12:49:19 +0200
To: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] iommu/amd: Fix extended features logging
Message-ID: <YHQlr5XTvlqxXnvX@alley>
References: <20210410211152.1938-1-amonakov@ispras.ru>
 <e884200f-55a4-59b5-4311-964e6ddc94d1@molgen.mpg.de>
 <alpine.LNX.2.20.13.2104111410340.11104@monopod.intra.ispras.ru>
 <87o8ekioo4.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87o8ekioo4.fsf@jogness.linutronix.de>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Joerg Roedel <jroedel@suse.de>,
 Alexander Monakov <amonakov@ispras.ru>, LKML <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 iommu@lists.linux-foundation.org, Joe Perches <joe@perches.com>
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

On Sun 2021-04-11 21:52:59, John Ogness wrote:
> On 2021-04-11, Alexander Monakov <amonakov@ispras.ru> wrote:
> >>> The second line is emitted via 'pr_cont', which causes it to have a
> >>> different ('warn') loglevel compared to the previous line ('info').
> >>> 
> >>> Commit 9a295ff0ffc9 attempted to rectify this by removing the newline
> >>> from the pci_info format string, but this doesn't work, as pci_info
> >>> calls implicitly append a newline anyway.
> >> 
> >> Hmm, did I really screw that up during my testing? I am sorry about that.
> >> 
> >> I tried to wrap my head around, where the newline is implicitly appended, and
> >> only found the definitions below.
> >> 
> > Yeah, it's not obvious: it happens in kernel/printk/printk.c:vprintk_store
> > where it does
> >
> > 	if (dev_info)
> > 		lflags |= LOG_NEWLINE;
> >
> > It doesn't seem to be documented; I think it prevents using pr_cont with
> > "rich" printk facilities that go via _dev_info.
> >
> > I suspect it quietly changed in commit c313af145b9bc ("printk() - isolate
> > KERN_CONT users from ordinary complete lines").
> 
> Yes, this behavior has been around for a while. I see no reason why it
> should be that way. These days printk does not care if there is dev_info
> included or not.

It seems that it has been this way since the dev_info was
introduced. It was called "dict" at that time. See

	if (buflen && (!cont || dict)) {
		/* no continuation; flush existing buffer */
		log_store(facility, buflevel, NULL, 0, buf, buflen);

in the commit 7ff9554bb578ba02166071d2d ("printk: convert byte-buffer
to variable-length record buffer").

I am not sure why. Well, dev_printk() previously printed the extra
information for every piece. See, the commit c4e00daaa96d3a0786f
("driver-core: extend dev_printk() to pass structured data").


> > Yeah, I saw that, but decided to go with the 'pr_info("")' solution, because
> > it is less magic, and already used in two other drivers.
> 
> Note that what I was suggesting was to fix a different issue: If the
> pr_cont() caller is interrupted by another printk user, then the
> following pr_cont() calls will use the default loglevel. By explicitly
> specifying the loglevel in pr_cont(), you can be sure that those pieces
> get the desired loglevel, even if those pieces get separated off because
> of an interrupting printk user.
> 
> So even if we fix dev_info to allow pr_cont continuation, it still may
> be desirable to specify the loglevel in the pr_cont pieces.
> 
> > pr_info("") will also prepend 'AMD-Vi:' to the feature list, which is
> > nice.
> 
> I'd rather fix dev_info callers to allow pr_cont and then fix any code
> that is using this workaround.
> 
> And if the print maintainers agree it is OK to encourage
> pr_cont(LOGLEVEL "...") usage, then people should really start using
> that if the loglevel on those pieces is important.

To be sure. We would need to repeat also the dev_info() information
in the continuous piece.

By other words. The clean solution would be:

   + remove the automatic newline in
     kernel/printk/printk.c:vprintk_store

   + create wrappers, for example, dev_cont_info()

Best Regards,
Petr
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
