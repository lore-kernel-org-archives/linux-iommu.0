Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5197CC433F5
	for <iommu@archiver.kernel.org>; Fri, 13 May 2022 13:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB91060EC7;
	Fri, 13 May 2022 13:58:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d9meJeNRHHce; Fri, 13 May 2022 13:58:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C19C060EB7;
	Fri, 13 May 2022 13:58:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C635C0032;
	Fri, 13 May 2022 13:58:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D854C002D
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 13:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1BAEB8266A
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 13:58:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T_oKoU1-pnkv for <iommu@lists.linux-foundation.org>;
 Fri, 13 May 2022 13:58:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7159782611
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 13:58:27 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CE5DF62100
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 13:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370BEC34114
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 13:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652450305;
 bh=Q9uWqroQBrMhNpZ56AYK8kAafrfYjv57IuXu6ljniEI=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=kP2duuHmNgNTr23wQ3jJV4ACqVDoXiHvJmOEfYJk9MtvU/pYg6PV8inmVYuf8+isB
 OWLyTHjbPFfaEjxgSziDDit9HdhUJhWWhqRm5d2BsSBvMqiC2R4TR7y+3zJ8IjEiVG
 WabOU9VbStlIep5W1f5eZh/z3GxAg+zdPHTSMXcFiNzrXBt07iC7jTjCXO/cCBD7Tr
 g5R8OCcieFgvfgNaw51Kue7VWHPY/Pe4dB6Y+VHDOsIT1B/hzKlmblJJQzwBpfQCxE
 omgpjYXMk/DBrwTM8vOrcZbjODXWEn7uaBq22v744sg/OpLNPSfRbQREn5rP1vkkil
 WY3HkUDaQCkLg==
Received: by mail-pl1-f182.google.com with SMTP id c11so7992554plg.13
 for <iommu@lists.linux-foundation.org>; Fri, 13 May 2022 06:58:25 -0700 (PDT)
X-Gm-Message-State: AOAM5338PH0UUnluDcVRj8Zcw48LlFIpWY6fKtUI+4oemt0srSI9Hn5M
 eJiBooGaPf9e3cCDTUrsQtxhrbDOWsufkIcdJA==
X-Google-Smtp-Source: ABdhPJzeUi/T2UXmS90oIyfTH4jE3xb7KHEsioE2ug9DOGlHySktMSjKYgLM3J6rQcaXmuC2h+ylwtxmks7pbqNurVU=
X-Received: by 2002:a17:902:9345:b0:15f:186b:e478 with SMTP id
 g5-20020a170902934500b0015f186be478mr4834270plp.117.1652450304740; Fri, 13
 May 2022 06:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220429220933.1350374-1-saravanak@google.com>
In-Reply-To: <20220429220933.1350374-1-saravanak@google.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 13 May 2022 08:58:11 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+2A7mRVV24XW0YcP8GkFCK_Ri4KDcqvW4e0p3TkQMWVg@mail.gmail.com>
Message-ID: <CAL_Jsq+2A7mRVV24XW0YcP8GkFCK_Ri4KDcqvW4e0p3TkQMWVg@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver
 registration
To: Saravana Kannan <saravanak@google.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, Apr 29, 2022 at 5:09 PM Saravana Kannan <saravanak@google.com> wrote:
>
> The deferred probe timer that's used for this currently starts at
> late_initcall and runs for driver_deferred_probe_timeout seconds. The
> assumption being that all available drivers would be loaded and
> registered before the timer expires. This means, the
> driver_deferred_probe_timeout has to be pretty large for it to cover the
> worst case. But if we set the default value for it to cover the worst
> case, it would significantly slow down the average case. For this
> reason, the default value is set to 0.
>
> Also, with CONFIG_MODULES=y and the current default values of
> driver_deferred_probe_timeout=0 and fw_devlink=on, devices with missing
> drivers will cause their consumer devices to always defer their probes.
> This is because device links created by fw_devlink defer the probe even
> before the consumer driver's probe() is called.
>
> Instead of a fixed timeout, if we extend an unexpired deferred probe
> timer on every successful driver registration, with the expectation more
> modules would be loaded in the near future, then the default value of
> driver_deferred_probe_timeout only needs to be as long as the worst case
> time difference between two consecutive module loads.
>
> So let's implement that and set the default value to 10 seconds when
> CONFIG_MODULES=y.

We had to revert a non-zero timeout before (issue with NFS root IIRC).
Does fw_devlink=on somehow fix that?

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
