Return-Path: <SRS0=Mf8z=KM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C77C433B4
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 06:21:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6990E61241
	for <iommu@archiver.kernel.org>; Mon, 17 May 2021 06:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6990E61241
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 278DF83A65;
	Mon, 17 May 2021 06:21:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S7t2QKC2U9Mn; Mon, 17 May 2021 06:21:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01ECF834D5;
	Mon, 17 May 2021 06:21:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B766DC000D;
	Mon, 17 May 2021 06:21:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BDECC0001
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 06:21:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05F2D6075D
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 06:21:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1mS8fYmFnKFa for <iommu@lists.linux-foundation.org>;
 Mon, 17 May 2021 06:21:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E0A7B6079E
 for <iommu@lists.linux-foundation.org>; Mon, 17 May 2021 06:21:25 +0000 (UTC)
Received: by mail-vk1-f170.google.com with SMTP id v188so1128960vkf.5
 for <iommu@lists.linux-foundation.org>; Sun, 16 May 2021 23:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+soxiwcsp656/78/AvClx6ZPB3VDNbEc7o/vVgGMog4=;
 b=B8BYIljGv9c5cT5Z+6jKAtz2lhQy0dKHokm7g/KXv+H7nFmLpwETpczVQI6jcdQdSx
 1arScB9VhcqwBmQA//iON78fjjGIWhaF1ECa0toqnjjl7MX7+CjX5cmdW3SYAUJr4Z44
 hkd/pjzCaZ+uwitiTVrTVv6vT1NeNrLU6vg89CPaTQXhkApKUJuDPlsRSOuvODBSBAfQ
 tmX/53L6LISqXazrS+EiC09lRanTFeYz5HJnJ2jmXrDCUHUr4sdqAn7WiedG3J/p/xb8
 DB6rQLtCa699Edme8KWX4e8bT5P1ae7Lvv/wR967ZRlgn6q2KWz9YocV99VhbGJB28J/
 LR2A==
X-Gm-Message-State: AOAM531VnZOuCMoOxBGX94ttyT1SNFQxXR90Lwd5rt/7BJI/g0uAn6/f
 MJAn7hV/JwRPN0Z0q7etW7zF9eRGNFP3WojXWtI=
X-Google-Smtp-Source: ABdhPJxqu67241VYbrxg5v7ZVCJWJgKvmEh9hQtt3sFTA/LiQZuzefbOW0dD0vuwF5zYW6osx9/cw/4rucqOcoEGcqg=
X-Received: by 2002:a1f:a388:: with SMTP id m130mr44908380vke.1.1621232484718; 
 Sun, 16 May 2021 23:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210331093104.383705-1-geert+renesas@glider.be>
 <20210331093104.383705-4-geert+renesas@glider.be>
In-Reply-To: <20210331093104.383705-4-geert+renesas@glider.be>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 May 2021 08:21:12 +0200
Message-ID: <CAMuHMdXQArCn9BS_8p0iUAgomfEHWe8ypg=B_SGfvJu8c_L5vg@mail.gmail.com>
Subject: Re: [PATCH 3/3] lib/vsprintf: Use pr_crit() instead of long fancy
 messages
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 Petr Mladek <pmladek@suse.com>, 
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Marco Elver <elver@google.com>,
 Linux Embedded <linux-embedded@vger.kernel.org>,
 John Ogness <john.ogness@linutronix.de>, Randy Dunlap <rdunlap@infradead.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Vlastimil Babka <vbabka@suse.cz>
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

On Wed, Mar 31, 2021 at 11:59 AM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> While long fancy messages have a higher probability of being seen than
> small messages, they may scroll of the screen fast, if visible at all,
> and may still be missed.  In addition, they increase boot time and
> kernel size.
>
> The correct mechanism to increase importance of a kernel message is not
> to draw fancy boxes with more text, but to shout louder, i.e. increase
> the message's reporting level.  Making sure the administrator of the
> system is aware of such a message is a system policy, and is the
> responsability of a user-space log daemon.
>
> Fix this by increasing the reporting level from KERN_WARNING to
> KERN_CRIT, and removing irrelevant text and graphics.
>
> This reduces kernel size by ca. 0.5 KiB.
>
> Fixes: 5ead723a20e0447b ("lib/vsprintf: no_hash_pointers prints all addresses as unhashed")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

No comments?
Unlike the cases handled by the other two patches in this series,
this one cannot be configured out.

Thanks!

> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2193,20 +2193,9 @@ static int __init no_hash_pointers_enable(char *str)
>
>         no_hash_pointers = true;
>
> -       pr_warn("**********************************************************\n");
> -       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> -       pr_warn("**                                                      **\n");
> -       pr_warn("** This system shows unhashed kernel memory addresses   **\n");
> -       pr_warn("** via the console, logs, and other interfaces. This    **\n");
> -       pr_warn("** might reduce the security of your system.            **\n");
> -       pr_warn("**                                                      **\n");
> -       pr_warn("** If you see this message and you are not debugging    **\n");
> -       pr_warn("** the kernel, report this immediately to your system   **\n");
> -       pr_warn("** administrator!                                       **\n");
> -       pr_warn("**                                                      **\n");
> -       pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> -       pr_warn("**********************************************************\n");
> -
> +       pr_crit("This system shows unhashed kernel memory addresses\n");
> +       pr_crit("via the console, logs, and other interfaces. This\n");
> +       pr_crit("might reduce the security of your system.\n");
>         return 0;
>  }
>  early_param("no_hash_pointers", no_hash_pointers_enable);

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
