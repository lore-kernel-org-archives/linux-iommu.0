Return-Path: <SRS0=iPMr=L7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92582C07E95
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 20:07:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ECB761CC3
	for <iommu@archiver.kernel.org>; Wed,  7 Jul 2021 20:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ECB761CC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD868406A4;
	Wed,  7 Jul 2021 20:07:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id utbwR5eakyKj; Wed,  7 Jul 2021 20:07:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 225314069C;
	Wed,  7 Jul 2021 20:07:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC041C0010;
	Wed,  7 Jul 2021 20:07:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C6E6C000E
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 20:07:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3AF3040151
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 20:07:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a3OY8t2LkNew for <iommu@lists.linux-foundation.org>;
 Wed,  7 Jul 2021 20:07:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 13368400F6
 for <iommu@lists.linux-foundation.org>; Wed,  7 Jul 2021 20:07:48 +0000 (UTC)
Received: by mail-ua1-x934.google.com with SMTP id v22so1270241uaj.13
 for <iommu@lists.linux-foundation.org>; Wed, 07 Jul 2021 13:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=96jWry9WOsdwKu+G0dTVRx+JdimFiJ2QAYFEbiH3H34=;
 b=RGANX0PGc0mFZu9cqrNOVbTfGn0v+kokDFQAPwfrxJwtPODfB/7BgVckPJVrWeW3aX
 Zq/e9LoJ0785EJh+wDzA6h31JQ0sQKhf5OC8+6825AOXSTrCQRvNmjr00Qv4QYBChNR1
 yEToxoe8pidstwnQJpDD7tRYOzkEa8SGd8UWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=96jWry9WOsdwKu+G0dTVRx+JdimFiJ2QAYFEbiH3H34=;
 b=GK6CbPzHtkGfj/rgNxldt39686cz+bKOZvHsSXY3ThFmCag3TMf7aLgx+dWJd37i6i
 k2h3iJhkIs8y/2NJOcTGYHnD8FR+2TAkIxzymVk83R3vDI1GxU56nh6fE6OTnNmENxVk
 EPx/QErw12FAMafez9IZ7gmHouA1k9nQyVDfIh/RDrBaZ/nKQRVjoiSud7N4Amj2jKHF
 k/zhBtQpYQI4CW7IzhOEZ3J0EyHuTUwHyArKtAaHkFA1lzcJOIjByfxii5+r7bN1fTK6
 YMnwhTtcKNJ44S1TukFIJ/hdVbw5MhGjwsayBPiK58aZ02CrY9iRMC8bCrwIuZdsTRNj
 Ofgg==
X-Gm-Message-State: AOAM533xrRDW3g60rSqQQdbqg/PXxFQCcVNkDFH584bYKK0b/O3asyW3
 1FoXh70hzJtlpIyyXxCc7XnUNQFsPQsdeQ==
X-Google-Smtp-Source: ABdhPJwRVQGEXVwYz15m/f01qEH9qjDfhradlhcBLdnXC4WQiuGoDgO6OIkxhbXxlJddo/R5L2bFMw==
X-Received: by 2002:ab0:2690:: with SMTP id t16mr24627057uao.9.1625688467824; 
 Wed, 07 Jul 2021 13:07:47 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com.
 [209.85.222.53])
 by smtp.gmail.com with ESMTPSA id t188sm2319801vkt.30.2021.07.07.13.07.47
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jul 2021 13:07:47 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id r9so1280161ual.7
 for <iommu@lists.linux-foundation.org>; Wed, 07 Jul 2021 13:07:47 -0700 (PDT)
X-Received: by 2002:a25:d97:: with SMTP id 145mr35869561ybn.276.1625688024885; 
 Wed, 07 Jul 2021 13:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210624171759.4125094-1-dianders@chromium.org>
 <YNXXwvuErVnlHt+s@8bytes.org>
 <CAD=FV=UFxZH7g8gH5+M=Fv4Y-e1bsLkNkPGJhNwhvVychcGQcQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UFxZH7g8gH5+M=Fv4Y-e1bsLkNkPGJhNwhvVychcGQcQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 7 Jul 2021 13:00:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W=HmgH3O3z+nThWL6U+X4Oh37COe-uTzVB9SanP2n86w@mail.gmail.com>
Message-ID: <CAD=FV=W=HmgH3O3z+nThWL6U+X4Oh37COe-uTzVB9SanP2n86w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] iommu: Enable non-strict DMA on QCom SD/MMC
To: Joerg Roedel <joro@8bytes.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-pci@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@somainline.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Joel Fernandes <joel@joelfernandes.org>, Rajat Jain <rajatja@google.com>,
 Will Deacon <will@kernel.org>, Rob Clark <robdclark@chromium.org>,
 Saravana Kannan <saravanak@google.com>, Jonathan Corbet <corbet@lwn.net>,
 quic_c_gdjako@quicinc.com, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Sonny Rao <sonnyrao@chromium.org>,
 Vlastimil Babka <vbabka@suse.cz>, Randy Dunlap <rdunlap@infradead.org>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
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

On Fri, Jun 25, 2021 at 7:42 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Jun 25, 2021 at 6:19 AM Joerg Roedel <joro@8bytes.org> wrote:
> >
> > Hi Douglas,
> >
> > On Thu, Jun 24, 2021 at 10:17:56AM -0700, Douglas Anderson wrote:
> > > The goal of this patch series is to get better SD/MMC performance on
> > > Qualcomm eMMC controllers and in generally nudge us forward on the
> > > path of allowing some devices to be in strict mode and others to be in
> > > non-strict mode.
> >
> > So if I understand it right, this patch-set wants a per-device decision
> > about setting dma-mode to strict vs. non-strict.
> >
> > I think we should get to the reason why strict mode is used by default
> > first. Is the default on ARM platforms to use iommu-strict mode by
> > default and if so, why?
> >
> > The x86 IOMMUs use non-strict mode by default (yes, it is a security
> > trade-off).
>
> It is certainly a good question. I will say that, as per usual, I'm
> fumbling around trying to solve problems in subsystems I'm not an
> expert at, so if something I'm saying sounds like nonsense it probably
> is. Please correct me.
>
> I guess I'd start out by thinking about what devices I think need to
> be in "strict" mode. Most of my thoughts on this are in the 3rd patch
> in the series. I think devices where it's important to be in strict
> mode fall into "Case 1" from that patch description, copied here:
>
> Case 1: IOMMUs prevent malicious code running on the peripheral (maybe
> a malicious peripheral or maybe someone exploited a benign peripheral)
> from turning into an exploit of the Linux kernel. This is particularly
> important if the peripheral has loadable / updatable firmware or if
> the peripheral has some type of general purpose processor and is
> processing untrusted inputs. It's also important if the device is
> something that can be easily plugged into the host and the device has
> direct DMA access itself, like a PCIe device.
>
>
> Using sc7180 as an example (searching for iommus in sc7180.dtsi), I'd
> expect these peripherals to be in strict mode:
>
> * WiFi / LTE - I'm almost certain we want this in "strict" mode. Both
> have loadable / updatable firmware and both do complex processing on
> untrusted inputs. Both have a history of being compromised over the
> air just by being near an attacker. Note that on sc7180 these are
> _not_ connected over PCI so we can't leverage any PCI mechanism for
> deciding strict / non-strict.
>
> * Video decode / encode - pretty sure we want this in strict. It's got
> loadable / updatable firmware and processing complex / untrusted
> inputs.
>
> * LPASS (low power audio subsystem) - I don't know a ton and I think
> we don't use this much on our designs, but I believe it meets the
> definitions for needing "strict".
>
> * The QUPs (handles UART, SPI, and i2c) - I'm not as sure here. These
> are much "smarter" than you'd expect. They have loadable / updatable
> firmware and certainly have a sort of general purpose processor in
> them. They also might be processing untrusted inputs, but presumably
> in a pretty simple way. At the moment we don't use a ton of DMA here
> anyway and these are pretty low speed, so I would tend to leave them
> as strict just to be on the safe side.
>
>
> I'd expect these to be non-strict:
>
> * SD/MMC - as described in this patch series.
>
> * USB - As far as I know firmware isn't updatable and has no history
> of being compromised.
>
>
> Special:
>
> * GPU - This already has a bunch of special cases, so we probably
> don't need to discuss here.
>
>
> As far as I can tell everything in sc7180.dtsi that has an "iommus"
> property is classified above. So, unless I'm wrong and it's totally
> fine to run LTE / WiFi / Video / LPASS in non-strict mode then:
>
> * We still need some way to pick strict vs. non-strict.
>
> * Since I've only identified two peripherals that I think should be
> non-strict, having "strict" the default seems like fewer special
> cases. It's also safer.
>
>
> In terms of thinking about x86 / AMD where the default is non-strict,
> I don't have any historical knowledge there. I guess the use of PCI
> for connecting WiFi is more common (so you can use the PCI special
> cases) and I'd sorta hope that WiFi is running in strict mode. For
> video encode / decode, perhaps x86 / AMD are just accepting the risk
> here because there was no kernel infrastructure for doing better? I'd
> also expect that x86/AMD don't have something quite as crazy as the
> QUPs for UART/I2C/SPI, but even if they do I wouldn't be terribly
> upset if they were in non-strict mode.
>
> ...so I guess maybe the super short answer to everything above is that
> I believe that at least WiFi ought to be in "strict" mode and it's not
> on PCI so we need to come up with some type of per-device solution.

I guess this thread has been silent for a bit of time now. Given that
my previous version generated a whole bunch of traffic, I guess I'm
assuming this:

a) Nothing is inherently broken with my current approach.

b) My current approach doesn't make anybody terribly upset even if
nobody is totally in love with it.

c) Nobody has any other bright ideas for ways to solve this that would
make my patch series obsolete.

I guess I'll take that as a good sign and hope that it means that this
approach has a path forward. I suppose it could just be that everyone
is busy and/or on vacation, but I've always been an optimist!

My plan continues to be to send a v3 of my patch series atop Sai's
patch [1] and John's series [2]. I'll plan to wait a bit longer before
posting my v3 to allow for more feedback/thoughts and also to see if
either Sai's patches or John's patches land and/or have newer versions
posted. :-)

-Doug

[1] https://lore.kernel.org/r/20210623134201.16140-1-saiprakash.ranjan@codeaurora.org
[2] https://lore.kernel.org/linux-doc/1624016058-189713-1-git-send-email-john.garry@huawei.com
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
