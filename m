Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70967C433EF
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 13:49:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1743540B5E;
	Mon, 16 May 2022 13:49:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v2zrbbMjHAJV; Mon, 16 May 2022 13:49:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ED56D40283;
	Mon, 16 May 2022 13:49:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C34B6C0039;
	Mon, 16 May 2022 13:49:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E96EC002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 13:49:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 59D4F402C9
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 13:49:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X68YyR_NnJ6T for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 13:49:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 11E6C408DA
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 13:49:19 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9D96361403
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 13:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838D0C3411E
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 13:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652708957;
 bh=Z1XATC9uFabr/cJUUJjAm1EmvJAVsCV0ZzQGqjrP+zA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Z+GBZ3HlMnS5S30k9vIXcOgsZZ9s2NTFIiE1HhvkWvPHy1bjZ00LgZTijr0M8KGmr
 STXCnHM85F+TIeIvpPTpG9lJp1vA2Dm/Llye5llcupfFc3DrhRP+8bTa1WAu66TGeA
 j/DsK4XK2TUXXSmd4/EUmmfxHNWV6eBhb+iN8YrybsUGbavpI8spHpzmskqUGIvWti
 bNesjElLh27daCKCjj83GRo5P9odygoLEUSbXWLeoVpn5VGXa0/BMtY5u5Z+8Zq3Yz
 Dxa7iXnhmdyqASNVfz96SqOorM96PaPLHL4R1RBqW+eHT3/L6di0va0g0SOjYdn1qn
 w4pbcCKlq/PAQ==
Received: by mail-ed1-f42.google.com with SMTP id j28so4370553eda.13
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 06:49:17 -0700 (PDT)
X-Gm-Message-State: AOAM5312Fb0FFdDoPdSFKjuXcquIuvYYGCmvvPtxmzzmiJhuonMoEwlX
 Y60nx3caVRKRmzuDOBPAkZcuZjqFLtCizMI/QA==
X-Google-Smtp-Source: ABdhPJzHJM/87Poo6lwZbFjNTMwh5WnjP4kK2zZNYqsvkYOJYJ8e9tfRTKjYaXJU+LODgXXZ2NtySTJTP3q9QRcur+c=
X-Received: by 2002:a05:6402:35c7:b0:427:d231:3740 with SMTP id
 z7-20020a05640235c700b00427d2313740mr13373747edc.40.1652708955614; Mon, 16
 May 2022 06:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220429220933.1350374-1-saravanak@google.com>
 <CAL_Jsq+2A7mRVV24XW0YcP8GkFCK_Ri4KDcqvW4e0p3TkQMWVg@mail.gmail.com>
 <CAGETcx8=ZX+Pb4ioMVb7LfuF9c3HNP8g1+WMqZR=Pq7-9=DUCA@mail.gmail.com>
In-Reply-To: <CAGETcx8=ZX+Pb4ioMVb7LfuF9c3HNP8g1+WMqZR=Pq7-9=DUCA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 16 May 2022 08:49:03 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+Y9p2UEgQ=ctFjcsHG9M6iXuGFY-N6uMAqhPM5KLwDjA@mail.gmail.com>
Message-ID: <CAL_Jsq+Y9p2UEgQ=ctFjcsHG9M6iXuGFY-N6uMAqhPM5KLwDjA@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver
 registration
To: Saravana Kannan <saravanak@google.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Android Kernel Team <kernel-team@android.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Kevin Hilman <khilman@kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Pavel Machek <pavel@ucw.cz>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 Thierry Reding <treding@nvidia.com>, Will Deacon <will@kernel.org>
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

On Fri, May 13, 2022 at 12:26 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Fri, May 13, 2022 at 6:58 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Apr 29, 2022 at 5:09 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > The deferred probe timer that's used for this currently starts at
> > > late_initcall and runs for driver_deferred_probe_timeout seconds. The
> > > assumption being that all available drivers would be loaded and
> > > registered before the timer expires. This means, the
> > > driver_deferred_probe_timeout has to be pretty large for it to cover the
> > > worst case. But if we set the default value for it to cover the worst
> > > case, it would significantly slow down the average case. For this
> > > reason, the default value is set to 0.
> > >
> > > Also, with CONFIG_MODULES=y and the current default values of
> > > driver_deferred_probe_timeout=0 and fw_devlink=on, devices with missing
> > > drivers will cause their consumer devices to always defer their probes.
> > > This is because device links created by fw_devlink defer the probe even
> > > before the consumer driver's probe() is called.
> > >
> > > Instead of a fixed timeout, if we extend an unexpired deferred probe
> > > timer on every successful driver registration, with the expectation more
> > > modules would be loaded in the near future, then the default value of
> > > driver_deferred_probe_timeout only needs to be as long as the worst case
> > > time difference between two consecutive module loads.
> > >
> > > So let's implement that and set the default value to 10 seconds when
> > > CONFIG_MODULES=y.
> >
> > We had to revert a non-zero timeout before (issue with NFS root IIRC).
> > Does fw_devlink=on somehow fix that?
>
> If it's the one where ip autoconfig was timing out, then John Stultz
> fixed it by fixing wait_for_device_probe().
> https://lore.kernel.org/all/20200422203245.83244-4-john.stultz@linaro.org/

Yeah, that was it.

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
