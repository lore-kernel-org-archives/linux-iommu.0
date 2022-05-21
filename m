Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A2EC43217
	for <iommu@archiver.kernel.org>; Sat, 21 May 2022 00:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1B05D607A1;
	Sat, 21 May 2022 00:16:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PS4b2_MBnIxz; Sat, 21 May 2022 00:16:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D5EB46058C;
	Sat, 21 May 2022 00:16:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A407BC0032;
	Sat, 21 May 2022 00:16:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F2FFC002D
 for <iommu@lists.linux-foundation.org>; Sat, 21 May 2022 00:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 780A660FE1
 for <iommu@lists.linux-foundation.org>; Sat, 21 May 2022 00:16:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tzS_As9LyJlU for <iommu@lists.linux-foundation.org>;
 Sat, 21 May 2022 00:16:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4A99D60A94
 for <iommu@lists.linux-foundation.org>; Sat, 21 May 2022 00:16:32 +0000 (UTC)
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-2ff155c239bso102342637b3.2
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 17:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HMCB35Do4nxxJ5Deq7wXwHlJ7AFN2mSTmdz2CZTa0iA=;
 b=NvEmPTccbXf/sm9VcR2JuXFNK+QOaXohjlLZE5gY0Tji0R59S3gNFYNqP5NKdemCbI
 AXxHxvIQXgoHZKwOD0aSvd8yi/ia1ORjeMkBSAg0HvrzTeGRoyBge7DJC+mUTdpeVAYZ
 +4nv6Z+Copf8E3yLYT2iITd/X7EVZ04k+gb57KzXUi3o/EHGsYrEUVcVmjn+nkNZ6Da+
 skQUS0RdIFyeIFL+Yle2y5GRLCBHqZZOP5XevwC+0xFbCnxGcBFpA1vV14beBv1Up8Yu
 pZjQ7FuclE5eCiQVB/BJk93rqcFhNqOH4cF5CZfPLUf+mWMG2m0AyceY7mD9a8PdgVwQ
 Hh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HMCB35Do4nxxJ5Deq7wXwHlJ7AFN2mSTmdz2CZTa0iA=;
 b=4rLtghyhEQlYGlQKaPxQ6spMcb8qmfjoE7hsm96ZZYuunb4AwxMfaX//EOv29pcEw9
 Hl2gvLaqSzGbIxAY+zTYxKO6DMlDkWlK62SAXX0kTPZjr4EvATCWGMI9lZnzr3ELclca
 j5cqLZkW+F+KlTuAnwvUTRA4NjbcWu5RAHwHLZ5q1E+JGqVpwDXR23RPYd0SAEmOcF3v
 CoeYtVVIV043BrJNKtat+5h0+w2qh2OGtQv+UESz4pFykaeV756SlVZ5KX6qjfW8E2ZJ
 k5X7JXnry/4u/GPUQ4xjsfzjJfYur6EdknVD+kKLsIgyJI1J1oPUCAm6VMI3B3lnE7hJ
 tWeA==
X-Gm-Message-State: AOAM5337ywK3+L1g8ZpSacWU6RpWaW93CVGL2RgDl5otO27VzoX30lDm
 5/kZxcNGOwLs0acgSObb6IL/dqO+NIfdCuasYx6uTw==
X-Google-Smtp-Source: ABdhPJzhnzpqOdgZiqzgNB98UYPOQpFUnarclYeZ96Ou9b+bvQZLF3CorJ9d+9aIjLP2AQ21QaUu7p6eQ3dAVJoU0io=
X-Received: by 2002:a81:2154:0:b0:2f4:d79e:35dc with SMTP id
 h81-20020a812154000000b002f4d79e35dcmr13210290ywh.126.1653092191044; Fri, 20
 May 2022 17:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220429220933.1350374-1-saravanak@google.com>
 <YogkhvFGVcjNQ21Z@dev-arch.thelio-3990X>
 <CAGETcx9nvBs1b4M=2hBhrLX_2-rzLtAmV9WfTXu0MC7JnsBvwA@mail.gmail.com>
 <YogsiMCDupNUhMgL@dev-fedora.thelio-3990X>
In-Reply-To: <YogsiMCDupNUhMgL@dev-fedora.thelio-3990X>
Date: Fri, 20 May 2022 17:15:55 -0700
Message-ID: <CAGETcx-JyWwoGA3o8eep7E29Cm4DcVT6D1JFJh72jLcqm_mjCQ@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver
 registration
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-doc@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, Pavel Machek <pavel@ucw.cz>,
 linux-s390@vger.kernel.org, Will Deacon <will@kernel.org>,
 Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Thierry Reding <treding@nvidia.com>,
 kernel-team@android.com, linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org,
 Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 iommu@lists.linux-foundation.org
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

On Fri, May 20, 2022 at 5:04 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Fri, May 20, 2022 at 04:49:48PM -0700, Saravana Kannan wrote:
> > On Fri, May 20, 2022 at 4:30 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > Hi Saravana,
> > >
> > > On Fri, Apr 29, 2022 at 03:09:32PM -0700, Saravana Kannan wrote:
> > > > The deferred probe timer that's used for this currently starts at
> > > > late_initcall and runs for driver_deferred_probe_timeout seconds. The
> > > > assumption being that all available drivers would be loaded and
> > > > registered before the timer expires. This means, the
> > > > driver_deferred_probe_timeout has to be pretty large for it to cover the
> > > > worst case. But if we set the default value for it to cover the worst
> > > > case, it would significantly slow down the average case. For this
> > > > reason, the default value is set to 0.
> > > >
> > > > Also, with CONFIG_MODULES=y and the current default values of
> > > > driver_deferred_probe_timeout=0 and fw_devlink=on, devices with missing
> > > > drivers will cause their consumer devices to always defer their probes.
> > > > This is because device links created by fw_devlink defer the probe even
> > > > before the consumer driver's probe() is called.
> > > >
> > > > Instead of a fixed timeout, if we extend an unexpired deferred probe
> > > > timer on every successful driver registration, with the expectation more
> > > > modules would be loaded in the near future, then the default value of
> > > > driver_deferred_probe_timeout only needs to be as long as the worst case
> > > > time difference between two consecutive module loads.
> > > >
> > > > So let's implement that and set the default value to 10 seconds when
> > > > CONFIG_MODULES=y.
> > > >
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > Cc: Rob Herring <robh@kernel.org>
> > > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > > Cc: Will Deacon <will@kernel.org>
> > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Cc: Kevin Hilman <khilman@kernel.org>
> > > > Cc: Thierry Reding <treding@nvidia.com>
> > > > Cc: Mark Brown <broonie@kernel.org>
> > > > Cc: Pavel Machek <pavel@ucw.cz>
> > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > Cc: linux-gpio@vger.kernel.org
> > > > Cc: linux-pm@vger.kernel.org
> > > > Cc: iommu@lists.linux-foundation.org
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > >
> > > I bisected a boot hang with ARCH=s390 defconfig in QEMU down to this
> > > change as commit 2b28a1a84a0e ("driver core: Extend deferred probe
> > > timeout on driver registration") in next-20220520 (bisect log below).
> > >
> > > $ make -skj"$(nproc)" ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- defconfig bzImage
> > >
> > > $ timeout --foreground 15m stdbuf -oL -eL \
> > > qemu-system-s390x \
> > > -initrd ... \
> > > -M s390-ccw-virtio \
> > > -display none \
> > > -kernel arch/s390/boot/bzImage \
> > > -m 512m \
> > > -nodefaults \
> > > -serial mon:stdio
> > > ...
> > > [    2.077303] In-situ OAM (IOAM) with IPv6
> > > [    2.077639] NET: Registered PF_PACKET protocol family
> > > [    2.078063] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
> > > [    2.078795] Key type dns_resolver registered
> > > [    2.079317] cio: Channel measurement facility initialized using format extended (mode autodetected)
> > > [    2.081494] Discipline DIAG cannot be used without z/VM
> > > [  260.626363] random: crng init done
> > > qemu-system-s390x: terminating on signal 15 from pid 3815762 (timeout)
> > >
> > > We have a simple rootfs available if necessary:
> > >
> > > https://github.com/ClangBuiltLinux/boot-utils/raw/bc0d17785eb67f1edd0ee0a134970a807895f741/images/s390/rootfs.cpio.zst
> > >
> > > If there is any other information I can provide, please let me know!
> >
> > Hmm... strange. Can you please try the following command line options
> > and tell me which of these has the issue and which don't?
>
> Sure thing!
>
> > 1) deferred_probe_timeout=0
>
> No issue.
>
> > 2) deferred_probe_timeout=1
> > 3) deferred_probe_timeout=300
>
> Both of these appear to hang in the same way, I let each sit for five
> minutes.

Strange that a sufficiently large timeout isn't helping. Is it trying
to boot off a network mount? I'll continue looking into this next
week.

-Saravana

>
> Cheers,
> Nathan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
