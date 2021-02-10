Return-Path: <SRS0=5Lc9=HM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE55C433DB
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 08:25:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70AF964E42
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 08:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70AF964E42
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0AFB6F5A8
	for <iommu@archiver.kernel.org>; Wed, 10 Feb 2021 08:25:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W_7NoLLeVrAr for <iommu@archiver.kernel.org>;
	Wed, 10 Feb 2021 08:25:46 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 77F686F62D; Wed, 10 Feb 2021 08:25:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 734AB6003C;
	Wed, 10 Feb 2021 08:25:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56E3DC0174;
	Wed, 10 Feb 2021 08:25:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CFF6C013A
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 08:25:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8AC938667B
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 08:25:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MBowmNh9GujI for <iommu@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 08:25:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 57FAE8667A
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 08:25:38 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id k204so1165131oih.3
 for <iommu@lists.linux-foundation.org>; Wed, 10 Feb 2021 00:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aGjLISWJ+fszvKmcvo2/oB8kqSJgVo4mq+414YKd0ak=;
 b=R52nMS76edrAIH9Q5X+RcotkCxOQFX+tPt2v5bQ+bIHzymgRt+ftJLKrESVBNMeYou
 FznSIJLhGHWsopal5oCaBVZxYb2KNdhYHLG20Xg9fpPaTFQ7QyA/dKut4APPUxFtShId
 +oe/rDSn3zM3e+duyHLh0we0fXCA6vQD2FcCPF91acnClURAsU43MiAaSj9N0ScUoz/x
 VAYQb7yCvdC1jUE9xcPN8tIXcMjOaMc4z5MeR/tckgKZxUJ3MBmRFR1ePGn4GzD/H+BE
 vgLQHgQ1d5LQUT4k0lUXmeqd5V095OrYzkRvT0UbAb1Z0brFuDeKhL1f0khCm2IGhV+p
 NHdg==
X-Gm-Message-State: AOAM5335ka1p0Yy/F8Ps3Ey2whdm6JKHu0VlM8L53CJ3tHhP2/bCYJEb
 0+inP2MPTJpOSw1DN6JRi9sgSwsph6WJF+pADl4=
X-Google-Smtp-Source: ABdhPJw76RbbTdIjOWOYdNuMSRd5sBeR2j0014yZb4MdeOrBQA1HjGlwkbMtEPnZoE9rsvsL6sEmWZSBR33/719FBhk=
X-Received: by 2002:a54:4e88:: with SMTP id c8mr1277055oiy.148.1612945537621; 
 Wed, 10 Feb 2021 00:25:37 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
 <20210205222644.2357303-5-saravanak@google.com>
 <20210209213320.GA219007@robh.at.kernel.org>
 <CAGETcx_gHRd9UYHvSsHX_=NFF+HEJkamJp3JcpojuJob_a8_DA@mail.gmail.com>
In-Reply-To: <CAGETcx_gHRd9UYHvSsHX_=NFF+HEJkamJp3JcpojuJob_a8_DA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Feb 2021 09:25:26 +0100
Message-ID: <CAMuHMdXi9s_b0xjaQ3n_-qFfdwfBtxnrhYfVuRENJM5UJ9TUwg@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] of: property: Add fw_devlink support for optional
 properties
To: Saravana Kannan <saravanak@google.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Frank Rowand <frowand.list@gmail.com>, linux-clk <linux-clk@vger.kernel.org>,
 Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@kernel.org>,
 Marc Zyngier <maz@kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Android Kernel Team <kernel-team@android.com>, Len Brown <lenb@kernel.org>,
 Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, LKML <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>
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

Hi Saravana,

CC iommu

On Tue, Feb 9, 2021 at 10:55 PM Saravana Kannan <saravanak@google.com> wrote:
> On Tue, Feb 9, 2021 at 1:33 PM Rob Herring <robh@kernel.org> wrote:
> > On Fri, Feb 05, 2021 at 02:26:40PM -0800, Saravana Kannan wrote:
> > > Not all DT bindings are mandatory bindings. Add support for optional DT
> > > bindings and mark iommus, iommu-map, dmas as optional DT bindings.
> >
> > I don't think we can say these are optional or not. It's got to be a
> > driver decision somehow.
>
> Right, so maybe the word "optional" isn't a good name for it. I can
> change that if you want.
>
> The point being, fw_devlink can't block the probe of this driver based
> on iommu property. We let the driver decide if it wants to
> -EPROBE_DEFER or not or however it wants to handle this.

The driver cannot make that decision, cfr. below.

> > For example, if IOMMU is optional, what happens with this sequence:
> >
> > driver probes without IOMMU
> > driver calls dma_map_?()
> > IOMMU driver probes
> > h/w accesses DMA buffer --> BOOM!

Does it really behave that way? Or does it continue without IOMMU?

> Right. But how is this really related to fw_devlink? AFAICT, this is
> an issue even today. If the driver needs the IOMMU, then it needs to
> make sure the IOMMU has probed? What am I missing?

Individual I/O (IOMMU slave) drivers are completely unaware of the
presence or absence of an IOMMU; they just use the DMA API, which is the
same regardless of an IOMMU being used or not.
While for GPIO/IRQ/CLK/DMA/... have request/get_{gpio,irq,clk,dma,...}
APIs for a driver to get a reference, which can return -EPROBE_DEFER, no
such thing exists for IOMMUs.  This is handled by the IOMMU core
instead.

Using the IOMMU or not is more like a system policy decision.

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
