Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C088C43334
	for <iommu@archiver.kernel.org>; Tue,  7 Jun 2022 18:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D9F6541868;
	Tue,  7 Jun 2022 18:07:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E1YFNJ992xka; Tue,  7 Jun 2022 18:07:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0C23D417D2;
	Tue,  7 Jun 2022 18:07:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2F87C0039;
	Tue,  7 Jun 2022 18:07:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B03C1C002D
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:07:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9E0F160806
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:07:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bMm9K5cKa564 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jun 2022 18:07:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 339A8600D4
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jun 2022 18:07:18 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id c144so11316866qkg.11
 for <iommu@lists.linux-foundation.org>; Tue, 07 Jun 2022 11:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Sk8ELHtWexUUrH4wjT93cWzy6OVcezs2TB9a8yknN/0=;
 b=Sqffbt43aYC7JuWF6vSIFeCZ5ZJiUwie4D+4dBDs23ANUxu6j7qug+Bgp4EAg85VTf
 xnKQnGzFlGNBXckUFZo8VJYjVYym0TCvXTOcKp9s7FGQAG5Sf7kV50ZNshOnTsfqc+U6
 KS7r7+Nmii+LCdbKoodRNiC7UKc8t57tATQdhUuEiOVf+e8W1JOsvqioT1Cd2AKfPyMX
 EbK6QF+1e83O58s1h8f8hYkF5cIZgoBsCGYZWXkOm45KQr2vAxPSpjg2mKYv2AgKFBCy
 B4GeZcrs7xfUIeYwvvJMcb8zarBZmyWcT8J0899FOimqsyXzd2YxXIKo1CBNVY6qUCK0
 COjA==
X-Gm-Message-State: AOAM530zdyHo7dLMlOnMPYYcd3slmsLrfpH2h8N/3eAdk7HPw2BRHuTn
 /FjlymBssBF2t61iLTMdE7ayausO2HR5lw==
X-Google-Smtp-Source: ABdhPJyEWzGGLDaiM31v9rQkxRvny6uoqUpkP1Fq0Q5cWnOHldh7BgSddlhT8E9tzkrtWH5tGoFG6A==
X-Received: by 2002:a37:4549:0:b0:69f:556c:4e38 with SMTP id
 s70-20020a374549000000b0069f556c4e38mr20728994qka.202.1654625236649; 
 Tue, 07 Jun 2022 11:07:16 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com.
 [209.85.219.175]) by smtp.gmail.com with ESMTPSA id
 u11-20020a05622a17cb00b00302ce666d3esm12116615qtk.38.2022.06.07.11.07.15
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jun 2022 11:07:16 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id f34so32444861ybj.6
 for <iommu@lists.linux-foundation.org>; Tue, 07 Jun 2022 11:07:15 -0700 (PDT)
X-Received: by 2002:a05:6902:120e:b0:634:6f29:6b84 with SMTP id
 s14-20020a056902120e00b006346f296b84mr32057546ybu.604.1654625235683; Tue, 07
 Jun 2022 11:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com>
In-Reply-To: <20220601070707.3946847-1-saravanak@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 7 Jun 2022 20:07:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXkX-SXtBuTRGJOUnpw9goSP6RFr_PTt_3w_yWgBpWsqg@mail.gmail.com>
Message-ID: <CAMuHMdXkX-SXtBuTRGJOUnpw9goSP6RFr_PTt_3w_yWgBpWsqg@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] deferred_probe_timeout logic clean up
To: Saravana Kannan <saravanak@google.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Android Kernel Team <kernel-team@android.com>, Len Brown <len.brown@intel.com>,
 Linux PM list <linux-pm@vger.kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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

On Wed, Jun 1, 2022 at 12:46 PM Saravana Kannan <saravanak@google.com> wrote:
> This series is based on linux-next + these 2 small patches applies on top:
> https://lore.kernel.org/lkml/20220526034609.480766-1-saravanak@google.com/
>
> A lot of the deferred_probe_timeout logic is redundant with
> fw_devlink=on.  Also, enabling deferred_probe_timeout by default breaks
> a few cases.
>
> This series tries to delete the redundant logic, simplify the frameworks
> that use driver_deferred_probe_check_state(), enable
> deferred_probe_timeout=10 by default, and fixes the nfsroot failure
> case.
>
> The overall idea of this series is to replace the global behavior of
> driver_deferred_probe_check_state() where all devices give up waiting on
> supplier at the same time with a more granular behavior:
>
> 1. Devices with all their suppliers successfully probed by late_initcall
>    probe as usual and avoid unnecessary deferred probe attempts.
>
> 2. At or after late_initcall, in cases where boot would break because of
>    fw_devlink=on being strict about the ordering, we
>
>    a. Temporarily relax the enforcement to probe any unprobed devices
>       that can probe successfully in the current state of the system.
>       For example, when we boot with a NFS rootfs and no network device
>       has probed.
>    b. Go back to enforcing the ordering for any devices that haven't
>       probed.
>
> 3. After deferred probe timeout expires, we permanently give up waiting
>    on supplier devices without drivers. At this point, whatever devices
>    can probe without some of their optional suppliers end up probing.
>
> In the case where module support is disabled, it's fairly
> straightforward and all device probes are completed before the initcalls
> are done.
>
> Patches 1 to 3 are fairly straightforward and can probably be applied
> right away.
>
> Patches 4 to 6 are for fixing the NFS rootfs issue and setting the
> default deferred_probe_timeout back to 10 seconds when modules are
> enabled.
>
> Patches 7 to 9 are further clean up of the deferred_probe_timeout logic
> so that no framework has to know/care about deferred_probe_timeout.
>
> Yoshihiro/Geert,
>
> If you can test this patch series and confirm that the NFS root case
> works, I'd really appreciate that.

Thanks, I gave this a try on various boards I have access to.
The results were quite positive. E.g. the compile error I saw on v1
(implicit declation of fw_devlink_unblock_may_probe(), which is no longer
 used in v2) is gone.

However, I'm seeing a weird error when userspace (Debian9 nfsroot) is
starting:

    [  OK  ] Started D-Bus System Message Bus.
    Unable to handle kernel NULL pointer dereference at virtual
address 0000000000000000
    Unable to handle kernel NULL pointer dereference at virtual
address 0000000000000000
    Mem abort info:
      ESR = 0x0000000096000004
    Mem abort info:
      ESR = 0x0000000096000004
      EC = 0x25: DABT (current EL), IL = 32 bits
      SET = 0, FnV = 0
      EC = 0x25: DABT (current EL), IL = 32 bits
      EA = 0, S1PTW = 0
      FSC = 0x04: level 0 translation fault
      SET = 0, FnV = 0
    Data abort info:
      ISV = 0, ISS = 0x00000004
      EA = 0, S1PTW = 0
      FSC = 0x04: level 0 translation fault
      CM = 0, WnR = 0
    user pgtable: 4k pages, 48-bit VAs, pgdp=000000004ec45000
    [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
    Data abort info:
    Internal error: Oops: 96000004 [#1] PREEMPT SMP
    CPU: 0 PID: 374 Comm: v4l_id Tainted: G        W
5.19.0-rc1-arm64-renesas-00799-gc13c3e49e8bd #1660
      ISV = 0, ISS = 0x00000004
    Hardware name: Renesas Ebisu-4D board based on r8a77990 (DT)
    pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
      CM = 0, WnR = 0
    pc : subdev_open+0x8c/0x128
    lr : subdev_open+0x78/0x128
    sp : ffff80000aadba60
    x29: ffff80000aadba60 x28: 0000000000000000 x27: ffff80000aadbc58
    x26: 0000000000020000 x25: ffff00000b3aaf00 x24: 0000000000000000
    x23: ffff00000c331c00 x22: ffff000009aa61b8 x21: ffff000009aa6000
    x20: ffff000008bae3e8 x19: ffff00000c3fe200 x18: 0000000000000000
    x17: ffff800076945000 x16: ffff800008004000 x15: 00008cc6bf550c7c
    x14: 000000000000038f x13: 000000000000001a x12: ffff00007fba8618
    x11: 0000000000000001 x10: 0000000000000000 x9 : ffff800009253954
    x8 : ffff00000b3aaf00 x7 : 0000000000000004 x6 : 000000000000001a
    x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000001
    x2 : 0000000100000001 x1 : 0000000000000000 x0 : 0000000000000000
    Call trace:
     subdev_open+0x8c/0x128
     v4l2_open+0xa4/0x120
     chrdev_open+0x78/0x178
     do_dentry_open+0xfc/0x398
     vfs_open+0x28/0x30
     path_openat+0x584/0x9c8
     do_filp_open+0x80/0x108
     do_sys_openat2+0x20c/0x2d8
    user pgtable: 4k pages, 48-bit VAs, pgdp=000000004ec53000
     do_sys_open+0x54/0xa0
     __arm64_sys_openat+0x20/0x28
     invoke_syscall+0x40/0xf8
     el0_svc_common.constprop.0+0xf0/0x110
     do_el0_svc+0x20/0x78
     el0_svc+0x48/0xd0
     el0t_64_sync_handler+0xb0/0xb8
     el0t_64_sync+0x148/0x14c
    Code: f9405280 f9400400 b40000e0 f9400280 (f9400000)
    ---[ end trace 0000000000000000 ]---

This only happens on the Ebisu-4D board (r8a77990-ebisu.dts).
I do not see this on the Salvator-X(S) boards.

Bisection shows this starts to happen with "[PATCH v2 7/9] driver core:
Set fw_devlink.strict=1 by default".

Adding more debug info:

    subdev_open:54: file v4l-subdev1
    Unable to handle kernel NULL pointer dereference at virtual
address 0000000000000000
    subdev_open:54: file v4l-subdev2
    Unable to handle kernel NULL pointer dereference at virtual
address 0000000000000000

Matching the subdev using sysfs gives:

    /sys/devices/platform/soc/e6500000.i2c/i2c-0/0-0070/video4linux/v4l-subdev1
    /sys/devices/platform/soc/e6500000.i2c/i2c-0/0-0070/video4linux/v4l-subdev2

The i2c device is the adi,adv7482 at address 0x70.
But now I'm lost...

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
