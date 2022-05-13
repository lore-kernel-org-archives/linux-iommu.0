Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C783C433EF
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 17:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B10958126C;
	Fri, 13 May 2022 17:26:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cupX9pAaAdc3; Fri, 13 May 2022 17:26:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8476C8126A;
	Fri, 13 May 2022 17:26:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43B33C0032;
	Fri, 13 May 2022 17:26:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB2F5C002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 17:26:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 840B28124F
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 17:26:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j17ABqu0uIKJ for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 17:26:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A0EA381242
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 17:26:29 +0000 (UTC)
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-2f7bb893309so97086627b3.12
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 10:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yncJ85+SIlrUyfibchlOo3nGcBtZSYvrpkr6At33oFM=;
 b=tELgWSqPJ2XeK5KWJc0j3Izxo5P0JYNJpS1LDlgAuPlebbh9e6WMDgeVVLegGeIaAG
 VVkPFzkgs9492PO60P9XWePlc06wmWZFRlwvZJOZcx5xgrMhBpFW0sOXiKbdsVgYAIRK
 zjP+gEQNqrUKj69da/qFLQkvCuZ4GjCjn29S2q5SXBtTpeqs0++CM4HRgIxA5FD6F1rD
 PV/soEr2Mv4iexAm30OrWfc/UQepJQ0ZaQQ+CqJ76d1FTyEX4rQxfaOahQA70NByLksO
 DRAsanWwPBz8CdNJ7IaHIeXq66XPKKcVg1BFmGAU10mdurV7Lixpw2rYJxRhb1PbLjk0
 QcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yncJ85+SIlrUyfibchlOo3nGcBtZSYvrpkr6At33oFM=;
 b=JqklXwBTH2eZq3MHCi2WVOP7BakWJ26q1DyDyBJU3yOSkILh/KyZch0/5x3Fwyd/dN
 P5wl8SVAAltw3naX6auii9kx9SlzPZGptITohd16yv/64KRaI1R5JWt2yCTbbwTt5mXB
 uUFApRtTnlUE2PTcGzGDFvVZ1DbPviVCHujjtuyiCZDj0HrLwiLVUUZNNqhaS3CxdR7R
 Pyl+7vL6/R9moS5MDg9G/OcdFh0fFpgZkVryc1jomYhDEItGERJuL59fUBQ0/EwGG1QG
 ie+AR/567z8Rv5L/bgluWpihaz+RT2xvj6DVv6JwpDfJGlbwWy6tLu2wq2BzNJKqbQY9
 i16w==
X-Gm-Message-State: AOAM5305xNkGTazsElHmXHl5hicBphYSS4hTdUmNY9u1bZa2ytVZHms2
 aJyx/MydvdtHXQBqvw9nTJseVvMDDH/rR8XXTSUggA==
X-Google-Smtp-Source: ABdhPJwDc39YV2aEhsT7aNk3yasAQxRbPZaXjabeYzrpzhFybpEVGwlpZU8+hsRWlLkM/kxsOCa4BRf6isC84kd7cTg=
X-Received: by 2002:a81:1e09:0:b0:2fe:c53c:a0aa with SMTP id
 e9-20020a811e09000000b002fec53ca0aamr2051320ywe.455.1652462788378; Fri, 13
 May 2022 10:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220429220933.1350374-1-saravanak@google.com>
 <CAL_Jsq+2A7mRVV24XW0YcP8GkFCK_Ri4KDcqvW4e0p3TkQMWVg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+2A7mRVV24XW0YcP8GkFCK_Ri4KDcqvW4e0p3TkQMWVg@mail.gmail.com>
Date: Fri, 13 May 2022 10:25:52 -0700
Message-ID: <CAGETcx8=ZX+Pb4ioMVb7LfuF9c3HNP8g1+WMqZR=Pq7-9=DUCA@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver
 registration
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Android Kernel Team <kernel-team@android.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
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
From: Saravana Kannan via iommu <iommu@lists.linux-foundation.org>
Reply-To: Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, May 13, 2022 at 6:58 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Apr 29, 2022 at 5:09 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > The deferred probe timer that's used for this currently starts at
> > late_initcall and runs for driver_deferred_probe_timeout seconds. The
> > assumption being that all available drivers would be loaded and
> > registered before the timer expires. This means, the
> > driver_deferred_probe_timeout has to be pretty large for it to cover the
> > worst case. But if we set the default value for it to cover the worst
> > case, it would significantly slow down the average case. For this
> > reason, the default value is set to 0.
> >
> > Also, with CONFIG_MODULES=y and the current default values of
> > driver_deferred_probe_timeout=0 and fw_devlink=on, devices with missing
> > drivers will cause their consumer devices to always defer their probes.
> > This is because device links created by fw_devlink defer the probe even
> > before the consumer driver's probe() is called.
> >
> > Instead of a fixed timeout, if we extend an unexpired deferred probe
> > timer on every successful driver registration, with the expectation more
> > modules would be loaded in the near future, then the default value of
> > driver_deferred_probe_timeout only needs to be as long as the worst case
> > time difference between two consecutive module loads.
> >
> > So let's implement that and set the default value to 10 seconds when
> > CONFIG_MODULES=y.
>
> We had to revert a non-zero timeout before (issue with NFS root IIRC).
> Does fw_devlink=on somehow fix that?

If it's the one where ip autoconfig was timing out, then John Stultz
fixed it by fixing wait_for_device_probe().
https://lore.kernel.org/all/20200422203245.83244-4-john.stultz@linaro.org/

If you are referring to some other issue, then I'd need more details.

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
