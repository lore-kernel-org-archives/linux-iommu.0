Return-Path: <SRS0=dWuT=5T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B407C43331
	for <iommu@archiver.kernel.org>; Fri,  3 Apr 2020 13:06:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F5252077D
	for <iommu@archiver.kernel.org>; Fri,  3 Apr 2020 13:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F5252077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E91A488266;
	Fri,  3 Apr 2020 13:06:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 745k987324Cr; Fri,  3 Apr 2020 13:06:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 891C3882F5;
	Fri,  3 Apr 2020 13:06:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71B09C1AE2;
	Fri,  3 Apr 2020 13:06:09 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0A05C07FF
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 13:06:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9900F8831B
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 13:06:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NmaLBy7yTphA for <iommu@lists.linux-foundation.org>;
 Fri,  3 Apr 2020 13:06:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B3533882FC
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 13:06:06 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id m14so6036998oic.0
 for <iommu@lists.linux-foundation.org>; Fri, 03 Apr 2020 06:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OqCaoyULkRti7vSZNQ9Yg7YDSRokCroTLEsyV92N24k=;
 b=VKGP0egvTiOTRnxpNu7TqG3L8p6c/7NJ/Q/szBatDpHQ9nTJRw046rWvdfodqlUahN
 NKsFPVR6SVAXxSBwLWmhZ5HMxM0nXN6VMhrhPJdwdVSCc+UkORnKOw8yWYgJLXBC3dHy
 mvFCySV3sb4X2gg6bqvkYtzNzIdRKErggKrkVyzjnjXbqa3YSArCZT0CAdK0iPZyZIie
 81bQ4//HbE/ygU64WSFXgOnnWVIurz9bBL7kJdKdWvJbWflNaQrxR2XQwywrtu8WWIvC
 +CV9q1G83YZjRydT7hL9gEAGLFHa7zv8l4y2fIBgQ64He3PHgsBzX2qIWATlScqfaztm
 4rMQ==
X-Gm-Message-State: AGi0PuZpxsOKgQ2l3jk0n7OevT+Y5G7TAlG2N1v3vojByp6fOSN0SOZI
 9AH6UWVdu0OqrDmzi+WmqUBG2qDBkWP083pVg6o=
X-Google-Smtp-Source: APiQypLi6mhOGXOuNWGE5LKpAmZQ+POe3LwGn5mnAx7luDfu0zthSY9F3kKpkDv+5OX3zFZqkIIqtWChzdEZhSWTxfY=
X-Received: by 2002:aca:ad93:: with SMTP id w141mr2963325oie.54.1585919165884; 
 Fri, 03 Apr 2020 06:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <TYAPR01MB45443DF63B9EF29054F7C41FD8C60@TYAPR01MB4544.jpnprd01.prod.outlook.com>
 <CALAqxLWopjCkiM=NR868DTcX-apPc1MPnONJMppm1jzCboAheg@mail.gmail.com>
 <CAMuHMdVtHhq9Nef1pBtBUKfRU2L-KgDffiOv28VqhrewR_j1Dw@mail.gmail.com>
In-Reply-To: <CAMuHMdVtHhq9Nef1pBtBUKfRU2L-KgDffiOv28VqhrewR_j1Dw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 3 Apr 2020 15:05:54 +0200
Message-ID: <CAMuHMdXotufr5Hq39O2MsLtwAHK0v34OYbaxYOV21rYrdBD=kw@mail.gmail.com>
Subject: Re: How to fix WARN from drivers/base/dd.c in next-20200401 if
 CONFIG_MODULES=y?
To: John Stultz <john.stultz@linaro.org>
Cc: "rafael@kernel.org" <rafael@kernel.org>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 netdev <netdev@vger.kernel.org>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
 "David S. Miller" <davem@davemloft.net>
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

On Fri, Apr 3, 2020 at 1:47 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
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
>
> > > c8c43ce driver core: Fix driver_deferred_probe_check_state() logic
> > > ---
> > >
> > > Before these patches, on my environment [1], some device drivers
> > > which has iommus property output the following message when probing:
> > >
> > > [    3.222205] ravb e6800000.ethernet: ignoring dependency for device, assuming no driver
> > > [    3.257174] ravb e6800000.ethernet eth0: Base address at 0xe6800000, 2e:09:0a:02:eb:2d, IRQ 117.
> > >
> > > So, since ravb driver is probed within 4 seconds, we can use NFS rootfs correctly.
> > >
> > > However, after these patches are applied, since the patches are always waiting for 30 seconds
> > > for of_iommu_configure() when IOMMU hardware is disabled, drivers/base/dd.c output WARN.
> > > Also, since ravb cannot be probed for 30 seconds, we cannot use NFS rootfs anymore.
> > > JFYI, I copied the kernel log to the end of this email.
> >
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
> never becomes ready.

So the issue is not nfsroot in-se, but the ip-config that needs to
happen before that.

The call to wait_for_devices() in ip_auto_config() (which is a
late_initcall()) returns -ENODEV, as the network device hasn't probed
successfully yet, so ip-config is aborted.

The (whitespace-damaged) patch below fixes that, but may have unintended
side-effects.

--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -1469,7 +1469,11 @@ static int __init ip_auto_config(void)
        /* Wait for devices to appear */
        err = wait_for_devices();
        if (err)
+#ifdef IPCONFIG_DYNAMIC
+               goto try_try_again;
+#else
                return err;
+#endif

        /* Setup all network devices */
        err = ic_open_devs();

Probably we want at least some CONFIG_ROOT_NFS || CONFIG_CIFS_ROOT,
and ROOT_DEV == Root_NFS || ROOT_DEV == Root_CIFS checks.

Thanks for your comments!

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
