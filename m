Return-Path: <SRS0=JfOd=4H=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBC3C5ACC5
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 23:19:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0CD0208C4
	for <iommu@archiver.kernel.org>; Wed, 19 Feb 2020 23:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="MgyJDERi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CD0208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BEB7387807;
	Wed, 19 Feb 2020 23:19:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nGEWWxPe1z3j; Wed, 19 Feb 2020 23:19:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9706F8776C;
	Wed, 19 Feb 2020 23:19:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80EF9C1D81;
	Wed, 19 Feb 2020 23:19:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2CBCC013E
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 23:19:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id BCD2584177
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 23:19:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VDw8u1AXNeRw for <iommu@lists.linux-foundation.org>;
 Wed, 19 Feb 2020 23:19:28 +0000 (UTC)
X-Greylist: delayed 00:18:03 by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 807D683524
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 23:19:28 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id 4so864063pfz.9
 for <iommu@lists.linux-foundation.org>; Wed, 19 Feb 2020 15:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lixom-net.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=EpAMqTgPV4b+hRig2cUuoFOjWPXPfch7/PyvuUrynfo=;
 b=MgyJDERiivp1dcjo74oCW8yuyz6aC8CNoXb0F6HsaegPUinGGik9ix6+iP5CnOalk1
 4UjzVEepkpU3z8MTk5mU1ADbPZVRkWYWlS2H4Ct3iRstTrtyq6jQV1GZeFhXFsOfAFJB
 MRF928ZnYXO7aHo00rSYB5EX8sAHKDNNxZMo8Ul4ECu0STSLii2l6X4odKnwts1wmiLc
 pTNby6eBi80K/79yJDmac47n7L1nrvDOPTuR0YKYmrKsNjQkf57nQ77NjximRQjy0WPu
 oxVprbv/W3YU12Npr8w3cr1ssDrya9ovY16d0PyCYB6FmQYHDBnlcloXk0iHLs2HOI/B
 oQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=EpAMqTgPV4b+hRig2cUuoFOjWPXPfch7/PyvuUrynfo=;
 b=i+l/s7afJS30TQEda7MQa+vOSF1Pl0+c5T/quBtdba5ts4YBo1NgjLWzoWPQESXSIv
 szqqOZ6Qh7XFaA6In+GaNC7ZDdSVSOFSHOLkylTrPuHw1KJJhCxTknHaJj0h6UVT9Vpq
 8DvL73qqsl19yKtNI+goNTwU95ecgaK5mCypTvnvONsmX6h5KGe/JfOJBWRy0Q4vkG7p
 eVz+7d4DjV+GlcmCzN4yaQpQ6YjI6fwIfHD/KZLPF5FTqIkbVrxcJ8MB5pppNUPegDEn
 ycJwpf9MXSDAKHrsu+15WOVRPdR+dY2S70JXNvWJNGNCUM8V2FAgiRrC8KJVIekS2wKh
 lPxg==
X-Gm-Message-State: APjAAAV+TMQeyLCqz8AWSu1ziRwSwnev1u6tga2BUJXl+0WaEPX3ZTIw
 ByDtXXiEhX0aAuliI/FUPbzeC+3FFWj/uvNTBkakDeFl
X-Google-Smtp-Source: APXvYqyb15r2mBFqMeHZTZlCfhyqX8qvJmHY5h2wuxudCzKO9l5t9qgNWFv72waBtxlihRgSTFhu7tMKS/98+D5l1K0=
X-Received: by 2002:a92:db49:: with SMTP id w9mr24744338ilq.277.1582152904310; 
 Wed, 19 Feb 2020 14:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20200218171321.30990-1-robh@kernel.org>
 <20200218181356.09ae0779@donnerap.cambridge.arm.com>
In-Reply-To: <20200218181356.09ae0779@donnerap.cambridge.arm.com>
From: Olof Johansson <olof@lixom.net>
Date: Wed, 19 Feb 2020 14:54:53 -0800
Message-ID: <CAOesGMg=-w6+gpAmBDV6yfAg-HUk5AZfsKxQ+kYOn56NcB59vA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Removing Calxeda platform support
To: Andre Przywara <andre.przywara@arm.com>
Cc: Mark Langsdorf <mlangsdo@redhat.com>, kvm@vger.kernel.org,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-ide@vger.kernel.org,
 Will Deacon <will@kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
 Rob Herring <robh@kernel.org>, SoC Team <soc@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, DTML <devicetree@vger.kernel.org>,
 Jon Loeliger <jdl@jdl.com>, linux-pm@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Alexander Graf <graf@amazon.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
 linux-edac@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Matthias Brugger <mbrugger@suse.com>, Stephen Boyd <sboyd@kernel.org>,
 Network Development <netdev@vger.kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, Robert Richter <rrichter@marvell.com>,
 James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>,
 Robin Murphy <robin.murphy@arm.com>, "David S. Miller" <davem@davemloft.net>
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

Hi,

On Tue, Feb 18, 2020 at 10:14 AM Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Tue, 18 Feb 2020 11:13:10 -0600
> Rob Herring <robh@kernel.org> wrote:
>
> Hi,
>
> > Calxeda has been defunct for 6 years now. Use of Calxeda servers carried
> > on for some time afterwards primarily as distro builders for 32-bit ARM.
> > AFAIK, those systems have been retired in favor of 32-bit VMs on 64-bit
> > hosts.
> >
> > The other use of Calxeda Midway I'm aware of was testing 32-bit ARM KVM
> > support as there are few or no other systems with enough RAM and LPAE. Now
> > 32-bit KVM host support is getting removed[1].
> >
> > While it's not much maintenance to support, I don't care to convert the
> > Calxeda DT bindings to schema nor fix any resulting errors in the dts files
> > (which already don't exactly match what's shipping in firmware).
>
> While every kernel maintainer seems always happy to take patches with a negative diffstat, I wonder if this is really justification enough to remove a perfectly working platform. I don't really know about any active users, but experience tells that some platforms really are used for quite a long time, even if they are somewhat obscure. N900 or Netwinder, anyone?

One of the only ways we know to confirm whether there are active users
or not, is to propose removing a platform.

The good news is that if/when you do, and someone cares enough about
it to want to keep it alive, they should also have access to hardware
and can help out in maintaining it and keeping it in a working state.

For some hardware platforms, at some point in time it no longer makes
sense to keep the latest kernel available on them, especially if
maintainers and others no longer have easy access to hardware and
resources/time to keep it functional.

It's really more about "If you care about this enough to keep it
going, please speak up and help out".

> So to not give the impression that actually *everyone* (from that small subset of people actively reading the kernel list) is happy with that, I think that having support for at least Midway would be useful. On the one hand it's a decent LPAE platform (with memory actually exceeding 4GB), and on the other hand it's something with capable I/O (SATA) and networking, so one can actually stress test the system. Which is the reason I was using that for KVM testing, but even with that probably going away now there remain still some use cases, and be it for general ARM(32) testing.

How many bugs have you found on this platform that you would not have
on a more popular one? And, how many of those bugs only affected this
platform, i.e. just adding onto the support burden without positive
impact to the broader community?

> I don't particularly care about the more optional parts like EDAC, cpuidle, or cpufreq, but I wonder if keeping in at least the rather small SATA and XGMAC drivers and basic platform support is feasible.

At what point are you better off just running under QEMU/virtualization?

> If YAML DT bindings are used as an excuse, I am more than happy to convert those over.
>
> And if anyone has any particular gripes with some code, maybe there is a way to fix that instead of removing it? I was always wondering if we could get rid of the mach-highbank directory, for instance. I think most of it is Highbank (Cortex-A9) related.

Again, how do you fix it if nobody has signed up for maintaining and
keeping it working? Doing blind changes that might or might not work
is not a way to keep a platform supported.

Just because code is removed, it doesn't mean it can't be reintroduced
when someone comes along and wants to do that. Look at some of the
recent additions of old OLPC hardware support, for example. But
there's a difference between this and keeping the code around hoping
that someone will care about it. It's not lost, and it's easy to bring
back.



-Olof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
