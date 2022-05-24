Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30CAC4332F
	for <iommu@archiver.kernel.org>; Tue, 24 May 2022 03:43:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 899C860AEE;
	Tue, 24 May 2022 03:43:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GMwxQR0917jv; Tue, 24 May 2022 03:43:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DC96A60E2D;
	Tue, 24 May 2022 03:43:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95719C0032;
	Tue, 24 May 2022 03:43:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 181A6C002D
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 03:43:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 067BB828B3
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 03:43:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uHs3uU3ng2JZ for <iommu@lists.linux-foundation.org>;
 Tue, 24 May 2022 03:43:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A600382896
 for <iommu@lists.linux-foundation.org>; Tue, 24 May 2022 03:43:43 +0000 (UTC)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-30026b1124bso11604507b3.1
 for <iommu@lists.linux-foundation.org>; Mon, 23 May 2022 20:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kFcU8MB8D+ohTeCCBEOJ8SRbXprR3YxyruL+Vn+38fo=;
 b=m3kfG3aPU2TePLRky/sZTAPS/O8UFZ1VH2Y7ghtxl8F1dCiFtEvBxxlGLFcI91noK3
 PmdoI1PlTIgN3DS5MdQIdf0zpikiGhPuQplZyw6PtJENoVqaQH7D10bacWQPCDfNIbBv
 iUSldiezerkONOrJN5tFqbJTLgOyCvUP3hEgZJaqr2RGVpPUHHGyQiuIopmsEoaVUJpn
 CYm66AIhx5qlpDlhpV6qEI+ysK4msP/h451PP/d7JzDICJuKEioBY0ZsScCLCzAacdJy
 UQf/QVe6paRIxczQp0VNNq8z3K8j02hTkC49RF/1HhmgRlXEglK9yae/vUDQBZI2sG6+
 cOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kFcU8MB8D+ohTeCCBEOJ8SRbXprR3YxyruL+Vn+38fo=;
 b=xGEh6W8HJL+kkgN8QifyB+X9BHwSqJAexIeY1ztsDmpk56BLaFtju2/TP0NjGHAO/Q
 ltVy9+4qG7eoW2gV5Iv7FxBSIRDmPSr5EbxWtGNhigDAy1efxct2YU7qyYkFdsdJhU0g
 2R0SUG8STK7JJF1ZL1cSPCSabV5U21enVeT/vm7vmYlkdcD6FgY3A+/n63mmAd+7GZ04
 2ExaFHlX3HU306WOpdCEagVT8QUOBGJyYbqLBkr76F66VUM0MLTT/HwrM1Oacmq6O6Cw
 dSxgDVdXAtmO4y6KXBfVv8N6zRXnn7yDbRkaGN4BLV52OdEglnKnfV3eKC1VSJT0Gy5R
 RBqw==
X-Gm-Message-State: AOAM530hbKZN42nuKO2farmr8Q1woabRJ8fcHUIW/OaHI58Op3Dk7iRW
 SnzXaiKiSbpuYu9RpCX2x7qgxWuinGhwMo4KUi6ZmA==
X-Google-Smtp-Source: ABdhPJxxclBWP5tFkbFjNa7SsUrOWwTViOz3TwNZEdS4IBh9mbWmiM1ACFR0gCy5bMxNXKWUSpBB+nSOyrtYgANPI38=
X-Received: by 2002:a0d:e903:0:b0:2ff:43a3:90c8 with SMTP id
 s3-20020a0de903000000b002ff43a390c8mr26160017ywe.455.1653363822372; Mon, 23
 May 2022 20:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220429220933.1350374-1-saravanak@google.com>
 <YogkhvFGVcjNQ21Z@dev-arch.thelio-3990X>
 <CAGETcx9nvBs1b4M=2hBhrLX_2-rzLtAmV9WfTXu0MC7JnsBvwA@mail.gmail.com>
 <YogsiMCDupNUhMgL@dev-fedora.thelio-3990X>
 <CAGETcx-JyWwoGA3o8eep7E29Cm4DcVT6D1JFJh72jLcqm_mjCQ@mail.gmail.com>
 <Youleo3Ganxbc1sq@dev-arch.thelio-3990X>
 <CAGETcx-sL08h2toEyxY6ztc6xNuJiPok6iDEeuJ1mOA3nvE+vA@mail.gmail.com>
 <YowHNo4sBjr9ijZr@dev-arch.thelio-3990X>
In-Reply-To: <YowHNo4sBjr9ijZr@dev-arch.thelio-3990X>
Date: Mon, 23 May 2022 20:43:06 -0700
Message-ID: <CAGETcx91_WgpmwEA7mBSvUdyJV0a8ymfaNKTmXq=mAJYAjzq1A@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Extend deferred probe timeout on driver
 registration
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-doc@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>, John Stultz <jstultz@google.com>,
 Pavel Machek <pavel@ucw.cz>, linux-s390@vger.kernel.org,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Mon, May 23, 2022 at 3:14 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, May 23, 2022 at 01:04:03PM -0700, Saravana Kannan wrote:
> > On Mon, May 23, 2022 at 8:17 AM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > On Fri, May 20, 2022 at 05:15:55PM -0700, Saravana Kannan wrote:
> > > > On Fri, May 20, 2022 at 5:04 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > > >
> > > > > On Fri, May 20, 2022 at 04:49:48PM -0700, Saravana Kannan wrote:
> > > > > > On Fri, May 20, 2022 at 4:30 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > > > > > >
> > > > > > > Hi Saravana,
> > > > > > >
> > > > > > > On Fri, Apr 29, 2022 at 03:09:32PM -0700, Saravana Kannan wrote:
> > > > > > > > The deferred probe timer that's used for this currently starts at
> > > > > > > > late_initcall and runs for driver_deferred_probe_timeout seconds. The
> > > > > > > > assumption being that all available drivers would be loaded and
> > > > > > > > registered before the timer expires. This means, the
> > > > > > > > driver_deferred_probe_timeout has to be pretty large for it to cover the
> > > > > > > > worst case. But if we set the default value for it to cover the worst
> > > > > > > > case, it would significantly slow down the average case. For this
> > > > > > > > reason, the default value is set to 0.
> > > > > > > >
> > > > > > > > Also, with CONFIG_MODULES=y and the current default values of
> > > > > > > > driver_deferred_probe_timeout=0 and fw_devlink=on, devices with missing
> > > > > > > > drivers will cause their consumer devices to always defer their probes.
> > > > > > > > This is because device links created by fw_devlink defer the probe even
> > > > > > > > before the consumer driver's probe() is called.
> > > > > > > >
> > > > > > > > Instead of a fixed timeout, if we extend an unexpired deferred probe
> > > > > > > > timer on every successful driver registration, with the expectation more
> > > > > > > > modules would be loaded in the near future, then the default value of
> > > > > > > > driver_deferred_probe_timeout only needs to be as long as the worst case
> > > > > > > > time difference between two consecutive module loads.
> > > > > > > >
> > > > > > > > So let's implement that and set the default value to 10 seconds when
> > > > > > > > CONFIG_MODULES=y.
> > > > > > > >
> > > > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > > > > > Cc: Rob Herring <robh@kernel.org>
> > > > > > > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > > > > > > Cc: Will Deacon <will@kernel.org>
> > > > > > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > > > > Cc: Kevin Hilman <khilman@kernel.org>
> > > > > > > > Cc: Thierry Reding <treding@nvidia.com>
> > > > > > > > Cc: Mark Brown <broonie@kernel.org>
> > > > > > > > Cc: Pavel Machek <pavel@ucw.cz>
> > > > > > > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > > > > > Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > > > > > Cc: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > > > > > Cc: linux-gpio@vger.kernel.org
> > > > > > > > Cc: linux-pm@vger.kernel.org
> > > > > > > > Cc: iommu@lists.linux-foundation.org
> > > > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > > >
> > > > > > > I bisected a boot hang with ARCH=s390 defconfig in QEMU down to this
> > > > > > > change as commit 2b28a1a84a0e ("driver core: Extend deferred probe
> > > > > > > timeout on driver registration") in next-20220520 (bisect log below).
> > > > > > >
> > > > > > > $ make -skj"$(nproc)" ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- defconfig bzImage
> > > > > > >
> > > > > > > $ timeout --foreground 15m stdbuf -oL -eL \
> > > > > > > qemu-system-s390x \
> > > > > > > -initrd ... \
> > > > > > > -M s390-ccw-virtio \
> > > > > > > -display none \
> > > > > > > -kernel arch/s390/boot/bzImage \
> > > > > > > -m 512m \
> > > > > > > -nodefaults \
> > > > > > > -serial mon:stdio
> > > > > > > ...
> > > > > > > [    2.077303] In-situ OAM (IOAM) with IPv6
> > > > > > > [    2.077639] NET: Registered PF_PACKET protocol family
> > > > > > > [    2.078063] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
> > > > > > > [    2.078795] Key type dns_resolver registered
> > > > > > > [    2.079317] cio: Channel measurement facility initialized using format extended (mode autodetected)
> > > > > > > [    2.081494] Discipline DIAG cannot be used without z/VM
> > > > > > > [  260.626363] random: crng init done
> > > > > > > qemu-system-s390x: terminating on signal 15 from pid 3815762 (timeout)
> > > > > > >
> > > > > > > We have a simple rootfs available if necessary:
> > > > > > >
> > > > > > > https://github.com/ClangBuiltLinux/boot-utils/raw/bc0d17785eb67f1edd0ee0a134970a807895f741/images/s390/rootfs.cpio.zst
> > > > > > >
> > > > > > > If there is any other information I can provide, please let me know!
> > > > > >
> > > > > > Hmm... strange. Can you please try the following command line options
> > > > > > and tell me which of these has the issue and which don't?
> > > > >
> > > > > Sure thing!
> > > > >
> > > > > > 1) deferred_probe_timeout=0
> > > > >
> > > > > No issue.
> > > > >
> > > > > > 2) deferred_probe_timeout=1
> > > > > > 3) deferred_probe_timeout=300
> > > > >
> > > > > Both of these appear to hang in the same way, I let each sit for five
> > > > > minutes.
> > > >
> > > > Strange that a sufficiently large timeout isn't helping. Is it trying
> > > > to boot off a network mount? I'll continue looking into this next
> > > > week.
> > >
> > > I don't think so, it seems like doing that requires some extra flags
> > > that we do not have:
> > >
> > > https://wiki.qemu.org/Features/S390xNetworkBoot
> > >
> > > If you need any additional information or want something tested, please
> > > let me know!
> >
> > I'll try to get qemu going on my end, but I'm not too confident I'll
> > be able to get to it in a timely fashion. So if you can help figure
> > out where this boot process is hanging, that'd be very much
> > appreciated.
>
> Sure thing! Information included below, I am more than happy to continue
> to test and debug as you need.
>
> > Couple of suggestions for debugging:
> >
> > Can you add a log to "wait_for_device_probe()" and see if that's
> > getting called right before the boot process hangs? If it does, can
> > you get a stacktrace (I just add a WARN_ON(1) when I need a stack
> > trace)? It's unlikely this is the case because
> > deferred_probe_timeout=1 still causes an issue for you, but I'd be
> > good to rule out.
>
> If I add a pr_info() call at the top of wait_for_device_probe(), I see
> it right before the process hangs. Adding WARN_ON(1) right below that
> reveals dasd_eckd_init() in drivers/s390/block/dasd_eckd.c calls
> wait_for_device_probe():
>
> [    4.610397] ------------[ cut here ]------------
> [    4.610520] WARNING: CPU: 0 PID: 1 at drivers/base/dd.c:742 wait_for_device_probe+0x28/0x110
> [    4.611134] Modules linked in:
> [    4.611593] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.18.0-next-20220523-dirty #1
> [    4.611830] Hardware name: QEMU 8561 QEMU (KVM/Linux)
> [    4.612017] Krnl PSW : 0704c00180000000 0000000000ce4b3c (wait_for_device_probe+0x2c/0x110)
> [    4.612258]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
> [    4.612387] Krnl GPRS: 80000000fffff071 0000000000000027 000000000000000c 00000000017f91d8
> [    4.612457]            00000000fffff071 00000000017f9218 0000000001a655a0 0000000000000006
> [    4.612521]            0000000000000002 0000000001965810 00000000019d51a0 0000000000000000
> [    4.612585]            0000000002218000 000000000125bcc8 0000000000ce4b38 000003800000bc80
> [    4.614814] Krnl Code: 0000000000ce4b2c: e3e0f0980024        stg     %r14,152(%r15)
> [    4.614814]            0000000000ce4b32: c0e5ffff94cb        brasl   %r14,0000000000cd74c8
> [    4.614814]           #0000000000ce4b38: af000000            mc      0,0
> [    4.614814]           >0000000000ce4b3c: c0100054d1fa        larl    %r1,000000000177ef30
> [    4.614814]            0000000000ce4b42: e31010000012        lt      %r1,0(%r1)
> [    4.614814]            0000000000ce4b48: a784002d            brc     8,0000000000ce4ba2
> [    4.614814]            0000000000ce4b4c: d727f0a0f0a0        xc      160(40,%r15),160(%r15)
> [    4.614814]            0000000000ce4b52: 41b0f0a0            la      %r11,160(%r15)
> [    4.615698] Call Trace:
> [    4.616559]  [<0000000000ce4b3c>] wait_for_device_probe+0x2c/0x110
> [    4.616744] ([<0000000000ce4b38>] wait_for_device_probe+0x28/0x110)
> [    4.616841]  [<000000000196593e>] dasd_eckd_init+0x12e/0x178
> [    4.616913]  [<0000000000100936>] do_one_initcall+0x46/0x1e8
> [    4.616983]  [<0000000001920706>] do_initcalls+0x126/0x150
> [    4.617046]  [<000000000192095e>] kernel_init_freeable+0x1ae/0x1f0
> [    4.617110]  [<0000000000ce85a6>] kernel_init+0x2e/0x168
> [    4.617171]  [<0000000000103320>] __ret_from_fork+0x40/0x58
> [    4.617233]  [<0000000000cf5eaa>] ret_from_fork+0xa/0x40
> [    4.617352] Last Breaking-Event-Address:
> [    4.617393]  [<0000000000e0e098>] __s390_indirect_jump_r14+0x0/0xc
> [    4.617481] ---[ end trace 0000000000000000 ]---
>
> > Let's try to rule out if deferred_probe_extend_timeout() is causing
> > some issues. So, without my patch, what happens if you set:
> > deferred_probe_timeout=1
> > deferred_probe_timeout=300
>
> At commit 6ee60e9c9f2f ("MAINTAINERS: add Russ Weight as a firmware
> loader maintainer"), both deferred_probe_timeout=1 and
> deferred_probe_timeout=300 hang the boot.

Thanks for all the help. I think I know what's going on.

If you revert the following commit, then you'll see that your device
no longer hangs with my changes.
35a672363ab3 driver core: Ensure wait_for_device_probe() waits until
the deferred_probe_timeout fires

That commit was made to make sure NFS mounts continue to work even
when deferred_probe_timeout is set to a value greater than the IP auto
config timeout (I think that's 12 seconds). While that definitely
helps the NFS mount case, unfortunately wait_for_device_probe() is
used in some initcalls that happen before late_initcall(). This causes
a deadlock -- earlier initcalls wait for
late_initcall(deferred_probe_initcall) to run but we can't get to
late_initcall() if earlier initcalls don't finish.

Even if wait_for_device_probe() is used only in late_initcalls(), it
can still hang the kernel boot based on the link order of the .c
files as that determined the call order between late_initcalls().

It looks like all the existing users of wait_for_device_probe() seem
to try and "wait for currently probing devices to finish probing", but
the commit mentioned above changes the semantics to "wait until every
device that'll eventually probe finishes probing". I think the
solution is to revert the commit and then do this additional waiting
just in ip_auto_config(). I'll need to think about this a bit before
I'm sure the solution makes sense.

Thanks for all the help so far.

-Saravana




-Saravana



>
> > If deferred_probe_timeout=1 causes an issue even without my patch,
> > then in addition, can you try commenting out the call to
> > fw_devlink_drivers_done() inside deferred_probe_timeout_work_func()
> > and try again?
>
> Sure, that does not appear to make a difference with
> deferred_probe_timeout=1.
>
> Cheers,
> Nathan
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
