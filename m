Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A224C433EF
	for <iommu@archiver.kernel.org>; Fri,  1 Jul 2022 07:39:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA03E84680;
	Fri,  1 Jul 2022 07:39:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA03E84680
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wJdx6_xrLEtJ; Fri,  1 Jul 2022 07:39:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 93E2984667;
	Fri,  1 Jul 2022 07:39:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93E2984667
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B969C0071;
	Fri,  1 Jul 2022 07:39:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B6990C002D
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 07:39:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8FED184674
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 07:39:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8FED184674
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oPuX0cWeCtI9 for <iommu@lists.linux-foundation.org>;
 Fri,  1 Jul 2022 07:39:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BDFF984667
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BDFF984667
 for <iommu@lists.linux-foundation.org>; Fri,  1 Jul 2022 07:39:10 +0000 (UTC)
Received: by mail-qv1-f50.google.com with SMTP id y14so3335687qvs.10
 for <iommu@lists.linux-foundation.org>; Fri, 01 Jul 2022 00:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=b36GzMWyZ+B5pJeIXpOWUar+t32MbUtjaNf9+EBzdK8=;
 b=enD/WXmYbFls4y5ll5BJWad8AQk+/JiBE5ZbCtdwobbpkBjizn+1e9UXZFwDzKYdOB
 IyzcCS4CibXOFPdOdub64lVMUpJgAuSVcPvjIw5Ii9UnMAruGz5/uQN08KyYffYMw+eZ
 AwKvEGxFbHqHP4iKF+jfp0y1+C56h9kK/YRxENqfVFfw4dixalUaDSAExbsjL2/SAhoB
 j9uNradrKw5DPP0MXSpYzuebkBh6LMzuHF/57+P1eEDtvDdJM4SI1quDhWT2PZaoMFw/
 MkgO1NuZebOryyuy9tuBXk3DJcpE1nP7RXQhgP/cpNv+vWD+IYWRoYf7PeZjqxa0bV3s
 U9mg==
X-Gm-Message-State: AJIora8R1lPdPK2yuEXMl1wItlD881Lss298Y5jSwdy24sdHOWAx54nJ
 goO9T74pgu7/+65gpC74xuAgo3pVRsP/Ag==
X-Google-Smtp-Source: AGRyM1ssADItpqMBdZ6kBM62APhxFUxVzpRcEa4QwE5nDBFSA3qIrLaAyoncgxrUbWVixEUz7i9Ykg==
X-Received: by 2002:a05:6214:5199:b0:470:9850:409b with SMTP id
 kl25-20020a056214519900b004709850409bmr16240669qvb.10.1656661149372; 
 Fri, 01 Jul 2022 00:39:09 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com.
 [209.85.128.169]) by smtp.gmail.com with ESMTPSA id
 194-20020a370acb000000b006a8b6848556sm16956241qkk.7.2022.07.01.00.39.07
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Jul 2022 00:39:08 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-3137316bb69so15265047b3.10
 for <iommu@lists.linux-foundation.org>; Fri, 01 Jul 2022 00:39:07 -0700 (PDT)
X-Received: by 2002:a81:1c4b:0:b0:31c:5f22:6bd3 with SMTP id
 c72-20020a811c4b000000b0031c5f226bd3mr1406855ywc.47.1656661147084; Fri, 01
 Jul 2022 00:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
 <20220601070707.3946847-2-saravanak@google.com> <YrFzK6EiVvXmzVG6@atomide.com>
 <CAGETcx_1USPRbFKV5j00qkQ-QXJkp7=FAfnFcfiNnM4J5KF1cQ@mail.gmail.com>
 <YrKhkmj3jCQA39X/@atomide.com>
 <CAGETcx_11wO-HkZ2QsBF8o1+L9L3Xe1QBQ_GzegwozxAx1i0jg@mail.gmail.com>
 <YrQP3OZbe8aCQxKU@atomide.com>
 <CAGETcx9aFBzMcuOiTAEy5SJyWw3UfajZ8DVQfW2DGmzzDabZVg@mail.gmail.com>
 <Yrlz/P6Un2fACG98@atomide.com>
 <CAGETcx8c+P0r6ARmhv+ERaz9zAGBOVJQu3bSDXELBycEGfkYQw@mail.gmail.com>
In-Reply-To: <CAGETcx8c+P0r6ARmhv+ERaz9zAGBOVJQu3bSDXELBycEGfkYQw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 1 Jul 2022 09:38:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW78nybK8LH2cDpM_0TCF-==QojaW8rKjudUhfJWNO0jA@mail.gmail.com>
Message-ID: <CAMuHMdW78nybK8LH2cDpM_0TCF-==QojaW8rKjudUhfJWNO0jA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of
 driver_deferred_probe_check_state()
To: Saravana Kannan <saravanak@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Android Kernel Team <kernel-team@android.com>, Len Brown <len.brown@intel.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Saravana,

On Fri, Jul 1, 2022 at 1:11 AM Saravana Kannan <saravanak@google.com> wrote:
> On Mon, Jun 27, 2022 at 2:10 AM Tony Lindgren <tony@atomide.com> wrote:
> > * Saravana Kannan <saravanak@google.com> [220623 08:17]:
> > > On Thu, Jun 23, 2022 at 12:01 AM Tony Lindgren <tony@atomide.com> wrote:
> > > > * Saravana Kannan <saravanak@google.com> [220622 19:05]:
> > > > > On Tue, Jun 21, 2022 at 9:59 PM Tony Lindgren <tony@atomide.com> wrote:
> > > > > > This issue is no directly related fw_devlink. It is a side effect of
> > > > > > removing driver_deferred_probe_check_state(). We no longer return
> > > > > > -EPROBE_DEFER at the end of driver_deferred_probe_check_state().
> > > > >
> > > > > Yes, I understand the issue. But driver_deferred_probe_check_state()
> > > > > was deleted because fw_devlink=on should have short circuited the
> > > > > probe attempt with an  -EPROBE_DEFER before reaching the bus/driver
> > > > > probe function and hitting this -ENOENT failure. That's why I was
> > > > > asking the other questions.
> > > >
> > > > OK. So where is the -EPROBE_DEFER supposed to happen without
> > > > driver_deferred_probe_check_state() then?
> > >
> > > device_links_check_suppliers() call inside really_probe() would short
> > > circuit and return an -EPROBE_DEFER if the device links are created as
> > > expected.
> >
> > OK
> >
> > > > Hmm so I'm not seeing any supplier for the top level ocp device in
> > > > the booting case without your patches. I see the suppliers for the
> > > > ocp child device instances only.
> > >
> > > Hmmm... this is strange (that the device link isn't there), but this
> > > is what I suspected.
> >
> > Yup, maybe it's because of the supplier being a device in the child
> > interconnect for the ocp.
>
> Ugh... yeah, this is why the normal (not SYNC_STATE_ONLY) device link
> isn't being created.
>
> So the aggregated view is something like (I had to set tabs = 4 space
> to fit it within 80 cols):
>
>     ocp: ocp {         <========================= Consumer
>         compatible = "simple-pm-bus";
>         power-domains = <&prm_per>; <=========== Supplier ref
>
>                 l4_wkup: interconnect@44c00000 {
>             compatible = "ti,am33xx-l4-wkup", "simple-pm-bus";
>
>             segment@200000 {  /* 0x44e00000 */
>                 compatible = "simple-pm-bus";
>
>                 target-module@0 { /* 0x44e00000, ap 8 58.0 */
>                     compatible = "ti,sysc-omap4", "ti,sysc";
>
>                     prcm: prcm@0 {
>                         compatible = "ti,am3-prcm", "simple-bus";
>
>                         prm_per: prm@c00 { <========= Actual Supplier
>                             compatible = "ti,am3-prm-inst", "ti,omap-prm-inst";
>                         };
>                     };
>                 };
>             };
>         };
>     };
>
> The power-domain supplier is the great-great-great-grand-child of the
> consumer. It's not clear to me how this is valid. What does it even
> mean?
>
> Rob, is this considered a valid DT?
>
> Geert, thoughts on whether this is a correct use of simple-pm-bus device?

Well, if the hardware is wired that way...

It's not that dissimilar from CPU cores, and interrupt and GPIO
controllers in power domains and clocked by controllable clocks:
you can cut the branch you're sitting on, and you have to be careful
when going to sleep, and make sure your wake-up sources are still
functional.

> Also, how is the power domain attach/get working in this case? As far
> as I can tell, at least for "simple-pm-bus" devices, the pm domain
> attachment is happening under:
> really_probe() -> call_driver_probe -> platform_probe() ->
> dev_pm_domain_attach()
>
> So, how is the pm domain attach succeeding in the first place without
> my changes?

That's a software thing ;-)

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
