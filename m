Return-Path: <SRS0=/53O=JI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F253EC433ED
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 20:09:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A3C610A6
	for <iommu@archiver.kernel.org>; Sun, 11 Apr 2021 20:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A3C610A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43301402F5;
	Sun, 11 Apr 2021 20:09:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bih51rPLTEd3; Sun, 11 Apr 2021 20:09:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2ACFF402F4;
	Sun, 11 Apr 2021 20:09:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 04AA3C000B;
	Sun, 11 Apr 2021 20:09:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96D21C000A
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 19:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 83E054016B
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 19:53:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linutronix.de header.b="O/8j5zxz";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=linutronix.de header.b="2Y4rHV+3"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ymo8RNwRNT3j for <iommu@lists.linux-foundation.org>;
 Sun, 11 Apr 2021 19:53:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7687940015
 for <iommu@lists.linux-foundation.org>; Sun, 11 Apr 2021 19:53:07 +0000 (UTC)
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1618170784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pLj4iEVWjEfoLen81vZfMShrSTB9qSmLODc6mlQpPts=;
 b=O/8j5zxzfsEoacpfhIMlDwyDAz7fG7rq7z9JL6tjjONsrnRrZK3LmpvKG7f5vrbfj2osqG
 /kxV++4YLHFHu4vYFOnWVqgqX7k/WbXnLpnRJlSWMbeLsp+PTY7z4b7M1Ew0/Um7A+lIIS
 S39G86Niw50FPBAFqTqr9IKWMvYumjXG5PN4auJCHTEVklilcXagfJUsudNyIQXu9rPSEW
 tv+qFSubOPggachPQ8Z3aqPneHg80AGBMXlPrGnFds10/51LSSOYFTt8zdXnyHHpn2LycM
 jB8fj1VvhOpsPWz1lBmV6SdKTwpHnsEkG/4LxXPe95kvcwa2BR1g088OnA2OnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1618170784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pLj4iEVWjEfoLen81vZfMShrSTB9qSmLODc6mlQpPts=;
 b=2Y4rHV+3K/SSU3S87el+srxsqJ4vYV/VrqXTNMHSIIHaTf73PBDwsjK0DVnA+RWITyCh2u
 7T7KRgT74c07zcCw==
To: Alexander Monakov <amonakov@ispras.ru>
Subject: Re: [PATCH] iommu/amd: Fix extended features logging
References: <20210410211152.1938-1-amonakov@ispras.ru>
 <e884200f-55a4-59b5-4311-964e6ddc94d1@molgen.mpg.de>
 <alpine.LNX.2.20.13.2104111410340.11104@monopod.intra.ispras.ru>
Date: Sun, 11 Apr 2021 21:52:59 +0200
In-Reply-To: <alpine.LNX.2.20.13.2104111410340.11104@monopod.intra.ispras.ru>
 (Alexander Monakov's message of "Sun, 11 Apr 2021 14:22:14 +0300
 (MSK)")
Message-ID: <87o8ekioo4.fsf@jogness.linutronix.de>
MIME-Version: 1.0
X-Mailman-Approved-At: Sun, 11 Apr 2021 20:09:47 +0000
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Joerg Roedel <jroedel@suse.de>,
 Petr Mladek <pmladek@suse.com>, LKML <linux-kernel@vger.kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-04-11, Alexander Monakov <amonakov@ispras.ru> wrote:
>>> The second line is emitted via 'pr_cont', which causes it to have a
>>> different ('warn') loglevel compared to the previous line ('info').
>>> 
>>> Commit 9a295ff0ffc9 attempted to rectify this by removing the newline
>>> from the pci_info format string, but this doesn't work, as pci_info
>>> calls implicitly append a newline anyway.
>> 
>> Hmm, did I really screw that up during my testing? I am sorry about that.
>> 
>> I tried to wrap my head around, where the newline is implicitly appended, and
>> only found the definitions below.
>> 
>>     include/linux/pci.h:#define pci_info(pdev, fmt, arg...)
>> dev_info(&(pdev)->dev, fmt, ##arg)
>> 
>>     include/linux/dev_printk.h:#define dev_info(dev, fmt, ...)
>> \
>>     include/linux/dev_printk.h:     _dev_info(dev, dev_fmt(fmt),
>> ##__VA_ARGS__)
>> 
>>     include/linux/dev_printk.h:__printf(2, 3) __cold
>>     include/linux/dev_printk.h:void _dev_info(const struct device *dev, const
>> char *fmt, ...);
>> 
>>     include/linux/compiler_attributes.h:#define __printf(a, b)
>> __attribute__((__format__(printf, a, b)))
>
> Yeah, it's not obvious: it happens in kernel/printk/printk.c:vprintk_store
> where it does
>
> 	if (dev_info)
> 		lflags |= LOG_NEWLINE;
>
> It doesn't seem to be documented; I think it prevents using pr_cont with
> "rich" printk facilities that go via _dev_info.
>
> I suspect it quietly changed in commit c313af145b9bc ("printk() - isolate
> KERN_CONT users from ordinary complete lines").

Yes, this behavior has been around for a while. I see no reason why it
should be that way. These days printk does not care if there is dev_info
included or not.

>> In the discussion *smpboot: CPU numbers printed as warning* [1] John wrote:
>> 
>>> It is supported to provide loglevels for CONT messages. The loglevel is
>>> then only used if the append fails:
>>> 
>>>     pr_cont(KERN_INFO "message part");
>>> 
>>> I don't know if we want to go down that path. But it is supported.
>
> Yeah, I saw that, but decided to go with the 'pr_info("")' solution, because
> it is less magic, and already used in two other drivers.

Note that what I was suggesting was to fix a different issue: If the
pr_cont() caller is interrupted by another printk user, then the
following pr_cont() calls will use the default loglevel. By explicitly
specifying the loglevel in pr_cont(), you can be sure that those pieces
get the desired loglevel, even if those pieces get separated off because
of an interrupting printk user.

So even if we fix dev_info to allow pr_cont continuation, it still may
be desirable to specify the loglevel in the pr_cont pieces.

> pr_info("") will also prepend 'AMD-Vi:' to the feature list, which is
> nice.

I'd rather fix dev_info callers to allow pr_cont and then fix any code
that is using this workaround.

And if the print maintainers agree it is OK to encourage
pr_cont(LOGLEVEL "...") usage, then people should really start using
that if the loglevel on those pieces is important.

John Ogness
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
