Return-Path: <SRS0=dWuT=5T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E76C43331
	for <iommu@archiver.kernel.org>; Fri,  3 Apr 2020 11:48:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7AFC2078C
	for <iommu@archiver.kernel.org>; Fri,  3 Apr 2020 11:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7AFC2078C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C161F86B60;
	Fri,  3 Apr 2020 11:48:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j4VNFg5D33I6; Fri,  3 Apr 2020 11:48:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 69DE584EEB;
	Fri,  3 Apr 2020 11:48:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61E4FC1831;
	Fri,  3 Apr 2020 11:48:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 919CFC07FF
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 11:48:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 761A2204E0
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 11:48:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OMLdH00116-0 for <iommu@lists.linux-foundation.org>;
 Fri,  3 Apr 2020 11:47:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 06F031FFFE
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 11:47:59 +0000 (UTC)
Received: by mail-ot1-f65.google.com with SMTP id l23so6945118otf.3
 for <iommu@lists.linux-foundation.org>; Fri, 03 Apr 2020 04:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WLQ125LqNkhbday+yt6StLeA1O5IE8GF+ApE3jgSAcg=;
 b=SPCeBnRBJFhBTMimS0yed8FvN6Ixm5SQq7wAzZI5Yy68ABlBmWdl6iV3gHtHEMEzRV
 Yo0exiV61rOcwFL9daJoX+VjvTgL71RyE8fRhHmFXjxjv/tDbgfaYwev0qmELYLC4+It
 ++A4OQdiqn3J9a5G/TwK7sjUPFN502Z0xMw1jNr8yU4acKGAG/cAqQGkrNMopj06vMv/
 AtYdeZI3Ttnl7Vfn1TyxADmwJA5dkXlFoAi4brRdACxbTXM6UcG+ByhIQ9bXgkjBuNx/
 n1YE/hL6CEqZdR6feLLB+elEZTHsbGDqPnIJcGgJcZ537p2S+40rUi+9OUQGBWn9CEL6
 WJ8Q==
X-Gm-Message-State: AGi0Pua57TvI2cZDkDOVqIRj4kV0y+/gQLMsGBTkw/7u5nTKiu7A8gMn
 ei9qjRnWyIAPu/Mqj2cMYw1IWcDPgxIYR/bM0Bc=
X-Google-Smtp-Source: APiQypIQnT36feP1REJN0BpBj//TWYHjNINlgwaxwuafaHrbCiASiBVronQFLnu7NrC4WBQhkb3N9W8X9h1DOwvWbJ4=
X-Received: by 2002:a4a:a442:: with SMTP id w2mr6218727ool.90.1585914478184;
 Fri, 03 Apr 2020 04:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CALAqxLWopjCkiM=NR868DTcX-apPc1MPnONJMppm1jzCboAheg@mail.gmail.com>
In-Reply-To: <CALAqxLWopjCkiM=NR868DTcX-apPc1MPnONJMppm1jzCboAheg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 3 Apr 2020 13:47:46 +0200
Message-ID: <CAMuHMdVtHhq9Nef1pBtBUKfRU2L-KgDffiOv28VqhrewR_j1Dw@mail.gmail.com>
Subject: Re: How to fix WARN from drivers/base/dd.c in next-20200401 if
 CONFIG_MODULES=y?
To: John Stultz <john.stultz@linaro.org>
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

Hi John,

On Thu, Apr 2, 2020 at 7:27 PM John Stultz <john.stultz@linaro.org> wrote:
> On Thu, Apr 2, 2020 at 3:17 AM Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
> >
> > I found an issue after applied the following patches:
> > ---
> > 64c775f driver core: Rename deferred_probe_timeout and make it global
> > 0e9f8d0 driver core: Remove driver_deferred_probe_check_state_continue()
> > bec6c0e pinctrl: Remove use of driver_deferred_probe_check_state_continue()
> > e2cec7d driver core: Set deferred_probe_timeout to a longer default if CONFIG_MODULES is set

Note that just setting deferred_probe_timeout = -1 like for the
CONFIG_MODULES=n case doesn't help.

> > c8c43ce driver core: Fix driver_deferred_probe_check_state() logic
> > ---
> >
> > Before these patches, on my environment [1], some device drivers
> > which has iommus property output the following message when probing:
> >
> > [    3.222205] ravb e6800000.ethernet: ignoring dependency for device, assuming no driver
> > [    3.257174] ravb e6800000.ethernet eth0: Base address at 0xe6800000, 2e:09:0a:02:eb:2d, IRQ 117.
> >
> > So, since ravb driver is probed within 4 seconds, we can use NFS rootfs correctly.
> >
> > However, after these patches are applied, since the patches are always waiting for 30 seconds
> > for of_iommu_configure() when IOMMU hardware is disabled, drivers/base/dd.c output WARN.
> > Also, since ravb cannot be probed for 30 seconds, we cannot use NFS rootfs anymore.
> > JFYI, I copied the kernel log to the end of this email.
>
> Hey,
>   Terribly sorry for the trouble. So as Robin mentioned I have a patch
> to remove the WARN messages, but I'm a bit more concerned about why
> after the 30 second delay, the ethernet driver loads:
>   [   36.218666] ravb e6800000.ethernet eth0: Base address at
> 0xe6800000, 2e:09:0a:02:eb:2d, IRQ 117.
> but NFS fails.
>
> Is it just that the 30 second delay is too long and NFS gives up?

I added some debug code to mount_nfs_root(), which shows that the first
3 tries happen before ravb is instantiated, and the last 3 tries happen
after.  So NFS root should work, if the network works.

However, it seems the Ethernet PHY is never initialized, hence the link
never becomes ready.  Dmesg before/after:

     ravb e6800000.ethernet eth0: Base address at 0xe6800000,
2e:09:0a:02:ea:ff, IRQ 108.

Good.

     ...
    -gpio_rcar e6052000.gpio: sense irq = 11, type = 8

This is the GPIO the PHY IRQ is connected to.
Note that that GPIO controller has been instantiated before.

     ...
    -Micrel KSZ9031 Gigabit PHY e6800000.ethernet-ffffffff:00:
attached PHY driver [Micrel KSZ9031 Gigabit PHY]
(mii_bus:phy_addr=e6800000.ethernet-ffffffff:00, irq=197)
     ...
    -ravb e6800000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off

Oops.

    -Sending DHCP requests .., OK
    -IP-Config: Got DHCP answer from ...
     ...
    +VFS: Unable to mount root fs via NFS, trying floppy.
    +VFS: Cannot open root device "nfs" or unknown-block(2,0): error -6

> Does booting with deferred_probe_timeout=0 work?

It does, as now everything using optional links (DMA and IOMMU) is now
instantiated on first try.

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
