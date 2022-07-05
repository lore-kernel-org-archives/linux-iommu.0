Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E0CCCA47B
	for <iommu@archiver.kernel.org>; Tue,  5 Jul 2022 08:44:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3B8B60EE4;
	Tue,  5 Jul 2022 08:44:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A3B8B60EE4
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=oVdJFaZL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id USvHXS5T6bnt; Tue,  5 Jul 2022 08:44:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9F86560E72;
	Tue,  5 Jul 2022 08:44:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F86560E72
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E159C0032;
	Tue,  5 Jul 2022 08:44:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72E2DC002D
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 08:44:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4A62D41748
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 08:44:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4A62D41748
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20210112 header.b=oVdJFaZL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0NnMRYU0XCjL for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jul 2022 08:44:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E3FDF41719
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E3FDF41719
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jul 2022 08:44:44 +0000 (UTC)
Received: by mail-yb1-xb2f.google.com with SMTP id 76so5017276ybd.0
 for <iommu@lists.linux-foundation.org>; Tue, 05 Jul 2022 01:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2nqg94hUDjf5VEy31mCYebRLyQWKOgGJpJElSft6kJk=;
 b=oVdJFaZLt6iik+gYVPoDhE3E0/T/qMpp81wNqUxEUTmekiaqU9ynpZ0mDpnp2WD8cV
 1XxBK2Tr40GZWioBld+i2V2kPexOZDXUouMVZ8Ta2CmvZ6vewWiUjnGTEovIbce1WKpR
 nRulH13G0QJpSAV8IrG/vyGQL8xWb2qk/6ax3FTz3YAu5ngRNie2xDTdyn/3wo8LdI4n
 4XMCNJA3C+XzvqbqeIqouGJjzVPFaCYGN7b0gBNrXW2dEfwZAh5IeAKq/qf7jDjP6DxQ
 sJuscQX3dxs/MUyavOF2DrQo82K7EPd+OrV7QEVmkdbS/+lXRLFYmWGyqUhmElgGNChc
 XHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2nqg94hUDjf5VEy31mCYebRLyQWKOgGJpJElSft6kJk=;
 b=8Qc7CO5xew17sKPvvYi/sxqcgWdwsSmzkKwiYvY6yEvB8ZCZk9eVPggDx1ZyMByexw
 r+kuxW6KS20Kbf+ANyxo/XwYoVvi7w/GQDXZHSIvA7DzO5DqogZbEOMcKY8/T1DzqnOd
 q8+L21UiA3t0sOcLYb3C98wLjJsrLC0qJWKw8XFNZ7wzXlXUo2YQAlK2ckbnp7qQnfef
 g6fBWTjP8rTnpZDWPkJ/9As5mDh8hYZKnBENLfS/ik33RdzCofd8rKj8+zIdqhK+8i3e
 O/lJlrYkVCVV2YW6IJ7+l0ijc6RYDfQKaLl5P17oSMXgwnvlE1vowfYRd2WGd1gzCI7y
 KJMA==
X-Gm-Message-State: AJIora/9UF14r1txYNI4HwYYSR2bAXAugOycLARmPL79tXRsblD58foe
 00FxxOkw/0czT1E+qMxzPhu4Mf3xrJVZdoa6RLPfOw==
X-Google-Smtp-Source: AGRyM1s3KR9timt0Nv154BBVjZtVup9YxTIdAuMg5rdc0L5tuSQBdw4qLUFuMUr86cFiFJimYkgebSO//Pbzv6BbJEU=
X-Received: by 2002:a25:abce:0:b0:66e:38e8:d286 with SMTP id
 v72-20020a25abce000000b0066e38e8d286mr12961807ybi.447.1657010683689; Tue, 05
 Jul 2022 01:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <YrQP3OZbe8aCQxKU@atomide.com>
 <CAGETcx9aFBzMcuOiTAEy5SJyWw3UfajZ8DVQfW2DGmzzDabZVg@mail.gmail.com>
 <Yrlz/P6Un2fACG98@atomide.com>
 <CAGETcx8c+P0r6ARmhv+ERaz9zAGBOVJQu3bSDXELBycEGfkYQw@mail.gmail.com>
 <CAL_JsqJd3J6k6pRar7CkHVaaPbY7jqvzAePd8rVDisRV-dLLtg@mail.gmail.com>
 <CAGETcx9ZmeTyP1sJCFZ9pBbMyXeifQFohFvWN3aBPx0sSOJ2VA@mail.gmail.com>
 <Yr6HQOtS4ctUYm9m@atomide.com> <Yr6QUzdoFWv/eAI6@atomide.com>
 <CAGETcx-0bStPx8sF3BtcJFiu74NwiB0btTQ+xx_B=8B37TEb8w@mail.gmail.com>
 <CAGETcx-Yp2JKgCNfaGD0SzZg9F2Xnu8A3zXmV5=WX1hY7uR=0g@mail.gmail.com>
 <20220701150848.75eeprptmb5beip7@bogus>
 <CAGETcx_Y-9WBeRwf22v3NSuY8PGpPrTxtx_uBqe_Q7rD6mEQMQ@mail.gmail.com>
In-Reply-To: <CAGETcx_Y-9WBeRwf22v3NSuY8PGpPrTxtx_uBqe_Q7rD6mEQMQ@mail.gmail.com>
Date: Tue, 5 Jul 2022 01:44:07 -0700
Message-ID: <CAGETcx8hECfU9-rXpXnnB5m4HcTBJVKNuG77FjhpqRcBkOOotw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Android Kernel Team <kernel-team@android.com>,
 Len Brown <len.brown@intel.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, Jul 1, 2022 at 12:13 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Fri, Jul 1, 2022 at 8:08 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Hi, Saravana,
> >
> > On Fri, Jul 01, 2022 at 01:26:12AM -0700, Saravana Kannan wrote:
> >
> > [...]
> >
> > > Can you check if this hack helps? If so, then I can think about
> > > whether we can pick it up without breaking everything else. Copy-paste
> > > tab mess up warning.
> >
> > Sorry for jumping in late and not even sure if this is right thread.
> > I have not bisected anything yet, but I am seeing issues on my Juno R2
> > with SCMI enabled power domains and Coresight AMBA devices.
> >
> > OF: amba_device_add() failed (-19) for /etf@20010000
> > OF: amba_device_add() failed (-19) for /tpiu@20030000
> > OF: amba_device_add() failed (-19) for /funnel@20040000
> > OF: amba_device_add() failed (-19) for /etr@20070000
> > OF: amba_device_add() failed (-19) for /stm@20100000
> > OF: amba_device_add() failed (-19) for /replicator@20120000
> > OF: amba_device_add() failed (-19) for /cpu-debug@22010000
> > OF: amba_device_add() failed (-19) for /etm@22040000
> > OF: amba_device_add() failed (-19) for /cti@22020000
> > OF: amba_device_add() failed (-19) for /funnel@220c0000
> > OF: amba_device_add() failed (-19) for /cpu-debug@22110000
> > OF: amba_device_add() failed (-19) for /etm@22140000
> > OF: amba_device_add() failed (-19) for /cti@22120000
> > OF: amba_device_add() failed (-19) for /cpu-debug@23010000
> > OF: amba_device_add() failed (-19) for /etm@23040000
> > OF: amba_device_add() failed (-19) for /cti@23020000
> > OF: amba_device_add() failed (-19) for /funnel@230c0000
> > OF: amba_device_add() failed (-19) for /cpu-debug@23110000
> > OF: amba_device_add() failed (-19) for /etm@23140000
> > OF: amba_device_add() failed (-19) for /cti@23120000
> > OF: amba_device_add() failed (-19) for /cpu-debug@23210000
> > OF: amba_device_add() failed (-19) for /etm@23240000
> > OF: amba_device_add() failed (-19) for /cti@23220000
> > OF: amba_device_add() failed (-19) for /cpu-debug@23310000
> > OF: amba_device_add() failed (-19) for /etm@23340000
> > OF: amba_device_add() failed (-19) for /cti@23320000
> > OF: amba_device_add() failed (-19) for /cti@20020000
> > OF: amba_device_add() failed (-19) for /cti@20110000
> > OF: amba_device_add() failed (-19) for /funnel@20130000
> > OF: amba_device_add() failed (-19) for /etf@20140000
> > OF: amba_device_add() failed (-19) for /funnel@20150000
> > OF: amba_device_add() failed (-19) for /cti@20160000
> >
> > These are working fine with deferred probe in the mainline.
> > I tried the hack you have suggested here(rather Tony's version),
>
> Thanks for trying that.
>
> > also
> > tried with fw_devlink=0 and fw_devlink=1
>
> 0 and 1 aren't valid input to fw_devlink. But yeah, I don't expect
> disabling it to make anything better.
>
> > && fw_devlink.strict=0
> > No change in the behaviour.
> >
> > The DTS are in arch/arm64/boot/dts/arm/juno-*-scmi.dts and there
> > coresight devices are mostly in juno-cs-r1r2.dtsi
>
> Thanks
>
> > Let me know if there is anything obvious or you want me to bisect which
> > means I need more time. I can do that next week.
>
> I'll let you know once I poke at the DTS. We need to figure out why
> fw_devlink wasn't blocking these from getting to the error (same as in
> Tony's case). But since these are amba devices, I think I have some
> guesses.
>
> This is an old series that had some issues in some cases and I haven't
> gotten around to looking at it. You can give that a shot if you can
> apply it to a recent tree.
> https://lore.kernel.org/lkml/20210304195101.3843496-1-saravanak@google.com/

I rebased it to driver-core-next and tested the patch  (for
correctness, not with your issue though). I'm fairly sure it should
help with your issue. Can you give it a shot please?

https://lore.kernel.org/lkml/20220705083934.3974140-1-saravanak@google.com/T/#u

-Saravana

>
> After looking at that old patch again, I think I know what's going on.
> For normal devices, the pm domain attach happens AFTER the device is
> added and fw_devlink has had a chance to set up device links. And if
> the suppliers aren't ready, really_probe() won't get as far as
> dev_pm_domain_attach(). But for amba, the clock and pm domain
> suppliers are "grabbed" before adding the device.
>
> So with that old patch + always returning -EPROBE_DEFER in
> amba_device_add() if amba_read_periphid() fails should fix your issue.
>
> -Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
