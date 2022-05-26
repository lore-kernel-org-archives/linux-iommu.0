Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B45C433FE
	for <iommu@archiver.kernel.org>; Thu, 26 May 2022 08:15:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08C7C84592;
	Thu, 26 May 2022 08:15:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OSKrC6QZuTne; Thu, 26 May 2022 08:15:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D56F984568;
	Thu, 26 May 2022 08:15:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AC3F0C0039;
	Thu, 26 May 2022 08:15:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E145C002D
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:15:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 15F5B8458F
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:15:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 17nx6AusW7nw for <iommu@lists.linux-foundation.org>;
 Thu, 26 May 2022 08:15:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E3A384568
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 08:15:55 +0000 (UTC)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-30026cf9af8so7669747b3.3
 for <iommu@lists.linux-foundation.org>; Thu, 26 May 2022 01:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=7ovu32HwfTXJZkxeBDrxZ8ZPAGcSmwTvZEaaoxjr5Ec=;
 b=A5IYs6L7vf+F2QJ35kvDWANbcirKT5v6KM8ClXGKhMKZlBtap4tK4FtzcxDnuCZUM2
 1MdoAe53oMAaYvVh0NBFN9zWi/1tedJ/pn3STJRgI5TEod6qqS5bjJ3jgTMLlV99IZhw
 bl3dncSWym4j3vdDRkPBP/r8/LapBYRpkuhgixrNPw8jT1gSt1jGIUlXIVWE+skTmA3c
 UiVFS3E4a6ZW/wMqG/NYeMaiXjyckaYyfNFSNiQXSwHzsKYDmuhGTQK/QI9HHSYBlqd6
 JMuIjD5Suc2/VSV47X/GXl0XsU/o8j5RWYmL6mQ93nQKXWtTvW2fr+ez+gfWLJc3fFan
 uYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=7ovu32HwfTXJZkxeBDrxZ8ZPAGcSmwTvZEaaoxjr5Ec=;
 b=cEhgezYyWUkQ2SC+ccQru/Y+9n8/9H+IIz5lDcpoz8I8BuY4qEdlS42hRHLzcnmKph
 zqCgm8xpCIlH1OE/7nlMkeIzOUkaFYiYoBfiTLD8euYkmh+t3j3AiL0Q97hCH/cdgufa
 2BsSP1suljLakJnpRqnoJBi8f7tKpujaRh0kRapzFtq1DiD3O3FrtjZ8mOmq7bQwIRif
 JDy00q3v6aAcyrUZVZce3aNKFFGXyuYDInHPO/f2fCRrBxOYFEf43iGcYqPhgSJf4Ymf
 5+ANvBauPiMaod7eNTasY0IsnrmvPoN6ugfAn+PujEaym0dMQ5Y7L5XOILTpMPOrQADS
 HW5A==
X-Gm-Message-State: AOAM5331VZIBOVqVZtytkZyHTITooGd/cGgIZ2y2vwPOLgvBeLS6Om5u
 nEPcMGFuwxQ47YS0vHIu8FkXzFBhNbj5lo0=
X-Google-Smtp-Source: ABdhPJwgygNcXLfgS/GhNtXfKLT0ANRPU/9nFzxb/3BLRPqGqHSVhLefDjnDtbT8PzPoRD3rLYHQCxeGMGeZcX4=
X-Received: from saravanak.san.corp.google.com
 ([2620:15c:2d:3:ff1f:a3b7:b6de:d30f])
 (user=saravanak job=sendgmr) by 2002:a25:ab4a:0:b0:64f:b782:f941 with SMTP id
 u68-20020a25ab4a000000b0064fb782f941mr20119540ybi.408.1653552953895; Thu, 26
 May 2022 01:15:53 -0700 (PDT)
Date: Thu, 26 May 2022 01:15:39 -0700
Message-Id: <20220526081550.1089805-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC PATCH v1 0/9] deferred_probe_timeout logic clean up
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
 Joerg Roedel <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, 
 David Ahern <dsahern@kernel.org>
Cc: Rob Herring <robh@kernel.org>, linux-acpi@vger.kernel.org,
 Saravana Kannan <saravanak@google.com>, linux-pm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, linux-gpio@vger.kernel.org,
 iommu@lists.linux-foundation.org, Mark Brown <broonie@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, John Stultz <jstultz@google.com>,
 kernel-team@android.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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

This series is based on linux-next + these 2 small patches applies on top:
https://lore.kernel.org/lkml/20220526034609.480766-1-saravanak@google.com/

A lot of the deferred_probe_timeout logic is redundant with
fw_devlink=on.  Also, enabling deferred_probe_timeout by default breaks
a few cases.

This series tries to delete the redundant logic, simplify the frameworks
that use driver_deferred_probe_check_state(), enable
deferred_probe_timeout=10 by default, and fixes the nfsroot failure
case.

Patches 1 to 3 are fairly straightforward and can probably be applied
right away.

Patches 4 to 9 are related and are the complicated bits of this series.

Patch 8 is where someone with more knowledge of the IP auto config code
can help rewrite the patch to limit the scope of the workaround by
running the work around only if IP auto config fails the first time
around. But it's also something that can be optimized in the future
because it's already limited to the case where IP auto config is enabled
using the kernel commandline.

Yoshihiro/Geert,

If you can test this patch series and confirm that the NFS root case
works, I'd really appreciate that.

Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: John Stultz <jstultz@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Saravana Kannan (9):
  PM: domains: Delete usage of driver_deferred_probe_check_state()
  pinctrl: devicetree: Delete usage of driver_deferred_probe_check_state()
  net: mdio: Delete usage of driver_deferred_probe_check_state()
  Revert "driver core: Set default deferred_probe_timeout back to 0."
  driver core: Set fw_devlink.strict=1 by default
  iommu/of: Delete usage of driver_deferred_probe_check_state()
  driver core: Add fw_devlink_unblock_may_probe() helper function
  net: ipconfig: Force fw_devlink to unblock any devices that might probe
  driver core: Delete driver_deferred_probe_check_state()

 drivers/base/base.h            |  1 +
 drivers/base/core.c            | 60 +++++++++++++++++++++++++++++++++-
 drivers/base/dd.c              | 37 ++++-----------------
 drivers/base/power/domain.c    |  2 +-
 drivers/iommu/of_iommu.c       |  2 +-
 drivers/net/mdio/fwnode_mdio.c |  4 +--
 drivers/pinctrl/devicetree.c   |  2 +-
 include/linux/device/driver.h  |  1 -
 include/linux/fwnode.h         |  2 ++
 net/ipv4/ipconfig.c            |  2 ++
 10 files changed, 74 insertions(+), 39 deletions(-)

-- 
2.36.1.124.g0e6072fb45-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
