Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C12C433EF
	for <iommu@archiver.kernel.org>; Sun,  5 Jun 2022 03:48:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8679641993;
	Sun,  5 Jun 2022 03:48:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VbGnRRC68COV; Sun,  5 Jun 2022 03:48:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 478D3417D1;
	Sun,  5 Jun 2022 03:48:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 182E5C0032;
	Sun,  5 Jun 2022 03:48:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DA86C002D
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 03:48:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 867E5845E4
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 03:48:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nfz9k_ja6ZEz for <iommu@lists.linux-foundation.org>;
 Sun,  5 Jun 2022 03:48:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9DA17845E3
 for <iommu@lists.linux-foundation.org>; Sun,  5 Jun 2022 03:48:05 +0000 (UTC)
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-30c2f288f13so115560807b3.7
 for <iommu@lists.linux-foundation.org>; Sat, 04 Jun 2022 20:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ui3IhTvHG08TEOp9AndOEANRcK2QqiFOkb8b6B7ZUYA=;
 b=AddFdKx/oipuNEWUN4TnsoDh8nTD0u8HK2RqT51wdoG72syLlKDo/zEd+agic/30/e
 WYwjcFvzl4oj/XNn32X2/ylGcuwnyf42X2JMcTlsu4msdOH1kNmwbgm+VHgtTGInga2u
 6DJ1gMG/QM0Ak6DMaGBVtrkOzjVwCw8FnMs90R09fO4rE1yynJFOYVQdfXtEPH5OgrQZ
 Us0JNbDV/U+tD8Pxr2CorRPyvzghTnvPjhAjLF4Ig47UDWxYO4wVa36ySy0c0R4mhP15
 pfJp4rBVPuYHyH3f1GIkogzfn19KI8lMguaiWf9WMI8YXYJKW3RRmrJWUHuYm5hnlGsM
 J3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ui3IhTvHG08TEOp9AndOEANRcK2QqiFOkb8b6B7ZUYA=;
 b=Len6dR9gpntmXMHJ1Hq4fTywArcdRg8BeURvU2ePav3xtYXe34sHkih/J0yd7u1ufr
 cVcSvWe+iRACfJLl5tVLbSPv05LcdjwzwGYODoFjJ8oUF7lLEtwFDnc+Wp+LaJo+mfzz
 Ien31DrKTAXNdgvyQRW/25FpkpDOOI8PBBX90d3t35GNs+O9gLzWgeCOhLm281pUuZez
 oHBC+55FEjm9Mg2F7+ORPmibh9m96/cZFEyCiYA6kUNc4EUG1FiebWQ5XfrNCLNdOSKy
 wN8cOxBkHeZnsd6pfrWOnREZxLmQJ+Y5ELDLezgkBCi70GpEIaE0YamuEGsIEsgybyEc
 FqKw==
X-Gm-Message-State: AOAM531s2U7OLj+L4qpNqeK02TRyvfg26nKBsTvuknG4bvqTACxXIeQj
 fZp9o6ax5b00YsmTRnT2WEH7orP4wmw91TwfGI/98Q==
X-Google-Smtp-Source: ABdhPJwfIUzHGUOY3GZySier5uLjJethOaftbfXihz53N9j35hn71WjRuf110V4OoTkXUC32BWfTpBzZA8XoLj95YRY=
X-Received: by 2002:a0d:c984:0:b0:30c:c95c:21d0 with SMTP id
 l126-20020a0dc984000000b0030cc95c21d0mr20276334ywd.218.1654400884335; Sat, 04
 Jun 2022 20:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220526081550.1089805-1-saravanak@google.com>
 <CAMuHMdW+Dmi9g=Cw9g5vOa9iYRA+L_ujU9C1-j0eKE7u3EmcFQ@mail.gmail.com>
In-Reply-To: <CAMuHMdW+Dmi9g=Cw9g5vOa9iYRA+L_ujU9C1-j0eKE7u3EmcFQ@mail.gmail.com>
Date: Sat, 4 Jun 2022 20:47:28 -0700
Message-ID: <CAGETcx_TGdeZWZOMyP8m+KvCWcPgH9ov1iryq4XGNjJ3kF+BNg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/9] deferred_probe_timeout logic clean up
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Eric Dumazet <edumazet@google.com>,
 John Stultz <jstultz@google.com>, Pavel Machek <pavel@ucw.cz>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Kevin Hilman <khilman@kernel.org>, Russell King <linux@armlinux.org.uk>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Android Kernel Team <kernel-team@android.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Ahern <dsahern@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Scally <djrscally@gmail.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, netdev <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
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

On Mon, May 30, 2022 at 2:38 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Thu, May 26, 2022 at 10:15 AM Saravana Kannan <saravanak@google.com> wrote:
> > This series is based on linux-next + these 2 small patches applies on top:
> > https://lore.kernel.org/lkml/20220526034609.480766-1-saravanak@google.com/
> >
> > A lot of the deferred_probe_timeout logic is redundant with
> > fw_devlink=on.  Also, enabling deferred_probe_timeout by default breaks
> > a few cases.
> >
> > This series tries to delete the redundant logic, simplify the frameworks
> > that use driver_deferred_probe_check_state(), enable
> > deferred_probe_timeout=10 by default, and fixes the nfsroot failure
> > case.
> >
> > Patches 1 to 3 are fairly straightforward and can probably be applied
> > right away.
> >
> > Patches 4 to 9 are related and are the complicated bits of this series.
> >
> > Patch 8 is where someone with more knowledge of the IP auto config code
> > can help rewrite the patch to limit the scope of the workaround by
> > running the work around only if IP auto config fails the first time
> > around. But it's also something that can be optimized in the future
> > because it's already limited to the case where IP auto config is enabled
> > using the kernel commandline.
>
> Thanks for your series!
>
> > Yoshihiro/Geert,
> >
> > If you can test this patch series and confirm that the NFS root case
> > works, I'd really appreciate that.
>
> On Salvator-XS, Micrel KSZ9031 Gigabit PHY probe is no longer delayed
> by 9s after applying the two earlier patches, and the same is true
> after applying this series on top.
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I will do testing on more boards, but that may take a while, as we're
> in the middle of the merge window.

Thanks for testing. I missed your email until now. I sent out a v2
series a few days back and that's a much better solution than v1. If
you can test that series instead, that'd be nice.

-Saravana
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
