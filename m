Return-Path: <SRS0=lnwu=5U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8042CC43331
	for <iommu@archiver.kernel.org>; Sat,  4 Apr 2020 04:26:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110BB2051A
	for <iommu@archiver.kernel.org>; Sat,  4 Apr 2020 04:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bk8YVcnE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110BB2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B4ABD8808D;
	Sat,  4 Apr 2020 04:26:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DHCBaTmdvOkr; Sat,  4 Apr 2020 04:26:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E8AEC88031;
	Sat,  4 Apr 2020 04:26:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7D96C1AE2;
	Sat,  4 Apr 2020 04:26:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B58C6C07FF
 for <iommu@lists.linux-foundation.org>; Sat,  4 Apr 2020 04:26:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id ACAB58808D
 for <iommu@lists.linux-foundation.org>; Sat,  4 Apr 2020 04:26:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HfFJ4D4Eytc3 for <iommu@lists.linux-foundation.org>;
 Sat,  4 Apr 2020 04:26:10 +0000 (UTC)
X-Greylist: delayed 00:07:07 by SQLgrey-1.7.6
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 878EA88031
 for <iommu@lists.linux-foundation.org>; Sat,  4 Apr 2020 04:26:10 +0000 (UTC)
Received: by mail-oi1-f194.google.com with SMTP id t25so8149415oij.2
 for <iommu@lists.linux-foundation.org>; Fri, 03 Apr 2020 21:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=je7nuNsfXk26lRmkb6ciZHwSXJTBCDyjnYltMGy9GKw=;
 b=Bk8YVcnE/cBJl2ujaD7DGjNm//e+RUaeMJE3R4oTnEdfER1QAwCHybt2WimOnaczqF
 1UQOyXoQ5Ng6kLHJ49G+EIv+Hp/OFZPCGcmy+f4NwDYWKCk+BOUadj6lUbHedg82lHBR
 aAx/e06OeA3U0eb5Hx5UBQ1gvFdpxplndrMBMnx5B85/dam1NdoOJBBTMzFG784StGTe
 5AyOdVM3AakZGc1Z0N11r2ZZwEg+1tpABlQzQ9+PZSXdXahsklsQqJZURGFY0Zy4FH3y
 2IVsQg9Z9Y0CW14QOuODdQpbGCdj6CcArqPWQe1KA+rV8YGGieKYlryjTjtfk8bxgvVK
 kctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=je7nuNsfXk26lRmkb6ciZHwSXJTBCDyjnYltMGy9GKw=;
 b=ICqii7jhUzcrQMd4xBTM6bshbntdCbuARO7Fnlgw9o4w6IB1a28twZjWDbWUxNlKw+
 Z+aYf7hHwLM67UZmNQAfHFDjahostD1peZku/EjzN94e0pJfFF8N5lMYDy6BLRIqv79u
 H1YUbag4ZxkFv9okb8kicMF0wNPGxnbs3mXwxM6a7jvhESl2hFVhsg6O4mQneN7/Hjl2
 9mHgkm/VMu1SX5ipg3ZCB8+ECgsNAR9COEPIRE9iHLyFoFAVuINYQlxUrVlUR2ITsQH8
 qgJ4QE269GAEgkBjOjTymNYQx07EynEaZZQwbjOs0+eHTolrIKn8Kf0U9GJOlNuGbpd0
 1GVQ==
X-Gm-Message-State: AGi0PuZl4nGBEyHHH16Obps4Z2qU8hbcOdhMhYBZyvjxocuaWSWovg/0
 qiNpZPD6QjbXJlQ6QUwi7+I22dJytSXG1V5vRfYtv+Oue44=
X-Google-Smtp-Source: APiQypLmrSfzfYdNvicoaCyhCetap9MoAIFDaZdmEHGJohfwM7HjZ6WmIj82QvstEFNnMH986goMroldCiSCq9icpyk=
X-Received: by 2002:a05:6808:a0a:: with SMTP id
 n10mr5721046oij.10.1585973942770; 
 Fri, 03 Apr 2020 21:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CALAqxLWopjCkiM=NR868DTcX-apPc1MPnONJMppm1jzCboAheg@mail.gmail.com>
 <CAMuHMdVtHhq9Nef1pBtBUKfRU2L-KgDffiOv28VqhrewR_j1Dw@mail.gmail.com>
In-Reply-To: <CAMuHMdVtHhq9Nef1pBtBUKfRU2L-KgDffiOv28VqhrewR_j1Dw@mail.gmail.com>
From: John Stultz <john.stultz@linaro.org>
Date: Fri, 3 Apr 2020 21:18:50 -0700
Message-ID: <CALAqxLX2AEFJxqXXXKPs8SU7Su2FqNjwbSt5BxwmQJqYQuST9A@mail.gmail.com>
Subject: Re: How to fix WARN from drivers/base/dd.c in next-20200401 if
 CONFIG_MODULES=y?
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "rafael@kernel.org" <rafael@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 netdev <netdev@vger.kernel.org>
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

On Fri, Apr 3, 2020 at 4:47 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Apr 2, 2020 at 7:27 PM John Stultz <john.stultz@linaro.org> wrote:
> > On Thu, Apr 2, 2020 at 3:17 AM Yoshihiro Shimoda
> > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > >
> > > I found an issue after applied the following patches:
> > > ---
> > > 64c775f driver core: Rename deferred_probe_timeout and make it global
> > > 0e9f8d0 driver core: Remove driver_deferred_probe_check_state_continue()
> > > bec6c0e pinctrl: Remove use of driver_deferred_probe_check_state_continue()
> > > e2cec7d driver core: Set deferred_probe_timeout to a longer default if CONFIG_MODULES is set
>
> Note that just setting deferred_probe_timeout = -1 like for the
> CONFIG_MODULES=n case doesn't help.

Yea. I can see why in that case, as we're checking
!IS_ENABLED(CONFIG_MODULES) directly in
driver_deferred_probe_check_state.

I guess we could switch that to checking
(driver_deferred_probe_timeout == -1) which would have the same logic
and at least make it consistent if someone specifies -1 on the command
line (since now it will effectively have it EPROBE_DEFER forever in
that case). But also having a timeout=infinity could be useful if
folks don't want the deferring to time out.  Maybe in the !modules
case setting it to =0 would be the most clear.

But that's sort of a further cleanup. I'm still more worried about the
NFS failure below.


> > Hey,
> >   Terribly sorry for the trouble. So as Robin mentioned I have a patch
> > to remove the WARN messages, but I'm a bit more concerned about why
> > after the 30 second delay, the ethernet driver loads:
> >   [   36.218666] ravb e6800000.ethernet eth0: Base address at
> > 0xe6800000, 2e:09:0a:02:eb:2d, IRQ 117.
> > but NFS fails.
> >
> > Is it just that the 30 second delay is too long and NFS gives up?
>
> I added some debug code to mount_nfs_root(), which shows that the first
> 3 tries happen before ravb is instantiated, and the last 3 tries happen
> after.  So NFS root should work, if the network works.
>
> However, it seems the Ethernet PHY is never initialized, hence the link
> never becomes ready.  Dmesg before/after:
>
>      ravb e6800000.ethernet eth0: Base address at 0xe6800000,
> 2e:09:0a:02:ea:ff, IRQ 108.
>
> Good.
>
>      ...
>     -gpio_rcar e6052000.gpio: sense irq = 11, type = 8
>
> This is the GPIO the PHY IRQ is connected to.
> Note that that GPIO controller has been instantiated before.
>
>      ...
>     -Micrel KSZ9031 Gigabit PHY e6800000.ethernet-ffffffff:00:
> attached PHY driver [Micrel KSZ9031 Gigabit PHY]
> (mii_bus:phy_addr=e6800000.ethernet-ffffffff:00, irq=197)
>      ...
>     -ravb e6800000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
>
> Oops.
>
>     -Sending DHCP requests .., OK
>     -IP-Config: Got DHCP answer from ...
>      ...
>     +VFS: Unable to mount root fs via NFS, trying floppy.
>     +VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6
>
> > Does booting with deferred_probe_timeout=0 work?
>
> It does, as now everything using optional links (DMA and IOMMU) is now
> instantiated on first try.

Thanks so much for helping clarify this!

So it's at least good to hear that booting with
deferred_probe_timeout=0 is working!  But I'm bummed the NFS (or as
you pointed out in your later mail,  ip_auto_config) falls over
because the network isn't immediately there.

Looking a little closer at the ip_auto_config() code, I think the
issue may be that wait_for_device_probe() is effectively returning too
early, since the probe_defer_timeout is still active? I need to dig a
bit more on that code, on Monday, as I don't fully understand it yet.

If I can't find a way to address that, I think the best course will be
to set the driver_deferred_probe_timeout value to default to 0
regardless of the value of CONFIG_MODULES, so we don't cause any
apparent regression from previous behavior. That will also sort out
the less intuitive = -1 initialization in the non-modules case.

In any case, I'll try to have a patch to send out on Monday.

thanks
-john
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
