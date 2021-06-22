Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36791C2B9F4
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 16:47:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFFAC6128C
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 16:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFAC6128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 90D1E40370;
	Tue, 22 Jun 2021 16:47:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o9us9O9xYost; Tue, 22 Jun 2021 16:47:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 447BA402F6;
	Tue, 22 Jun 2021 16:47:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 191EDC001A;
	Tue, 22 Jun 2021 16:47:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CEE3C000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 16:47:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D2D960850
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 16:47:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zN2kBoGaXQOl for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 16:47:28 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6E21E60848
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 16:47:28 +0000 (UTC)
Received: by mail-ot1-x32c.google.com with SMTP id
 w23-20020a9d5a970000b02903d0ef989477so21767508oth.9
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cnIT4Uu6v7OErIw/h3MHSRjA8siJIWWdRBRj8QBPlgw=;
 b=TdfJPlJ2SdcEgU78Q5teRSDl0nj+gX7ShrwD+p+EUe1jbMCKiZz6IWSde2kIMCuGbk
 s2ZibuUr/AvviD8Z9vJcmWBR3ZXPAyIsLRVvtJLIx5CIwfCEuvftXqZBKCxyIQ3JUjW4
 zY94UAAq7PdYvRB09/WPx5cR4lSyh9TgZLz2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cnIT4Uu6v7OErIw/h3MHSRjA8siJIWWdRBRj8QBPlgw=;
 b=km4OE59Y2JE09FCdqLh66CKpQFG2nLVGhM/BQvI3CbyXeDE6PmadinEmfcuFq3hnYm
 PgMhdFb4+ALj4VdO+lHQkHTHTTYgNHXBjlFvwe+zRVfxWL1i+OWRWNriZmn5RFxTVnij
 tx+CdzRQDr7zvELb9e0zGduAkwLkPwhJBOUMTQLEmZDAo4h4El3OrExW/aSG/+eZSGm0
 LbCxQU8xorEWbRlvtnQg65WpXvgsb2CqDSqbx5JIf7ynmfZQFHZgfE5r5C3x7ZQdZDo4
 c4qLmeqm/tKJwrrsIsOPU8GKTgbxFGYlugCxPa+j17M683f/uk8vxggUUcWcCCrsHRHq
 iJcQ==
X-Gm-Message-State: AOAM530iSCq1IFEOYFn5i1mIrAxHrCKXNJNxShdzJRf7eWfJgCU/q5jQ
 VJpfdLpKqqAwHJHl6lvc6NuXlOUflyfnWA==
X-Google-Smtp-Source: ABdhPJx3Kl2qxip5z/7ttwyyOFjSBb6UNeeDciPX3R9l7YwZUb6GC7k9lgTdVxqzctPugQIoWOoPQQ==
X-Received: by 2002:a9d:206:: with SMTP id 6mr4040673otb.31.1624380447205;
 Tue, 22 Jun 2021 09:47:27 -0700 (PDT)
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com.
 [209.85.161.51])
 by smtp.gmail.com with ESMTPSA id a78sm4350446oii.42.2021.06.22.09.47.27
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jun 2021 09:47:27 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id
 v17-20020a4aa5110000b0290249d63900faso26899ook.0
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 09:47:27 -0700 (PDT)
X-Received: by 2002:a25:80d4:: with SMTP id c20mr6016912ybm.345.1624380041368; 
 Tue, 22 Jun 2021 09:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
 <CAGETcx-dZ_Wwjafk+5akWJwbrFx2rYNKZAU8tWhFUunEyn8sqQ@mail.gmail.com>
In-Reply-To: <CAGETcx-dZ_Wwjafk+5akWJwbrFx2rYNKZAU8tWhFUunEyn8sqQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 22 Jun 2021 09:40:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VCgugY6veyqs09Owc72FSeuCJkNZEb93Or1Ud2jmfExw@mail.gmail.com>
Message-ID: <CAD=FV=VCgugY6veyqs09Owc72FSeuCJkNZEb93Or1Ud2jmfExw@mail.gmail.com>
Subject: Re: [PATCH 4/6] iommu: Combine device strictness requests with the
 global default
To: Saravana Kannan <saravanak@google.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, Rajat Jain <rajatja@google.com>,
 Will Deacon <will@kernel.org>, Rob Clark <robdclark@chromium.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, quic_c_gdjako@quicinc.com,
 Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Sonny Rao <sonnyrao@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux MMC List <linux-mmc@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, Jun 21, 2021 at 7:56 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Jun 21, 2021 at 4:53 PM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > In the patch ("drivers: base: Add bits to struct device to control
> > iommu strictness") we add the ability for devices to tell us about
> > their IOMMU strictness requirements. Let's now take that into account
> > in the IOMMU layer.
> >
> > A few notes here:
> > * Presumably this is always how iommu_get_dma_strict() was intended to
> >   behave. Had this not been the intention then it never would have
> >   taken a domain as a parameter.
> > * The iommu_set_dma_strict() feels awfully non-symmetric now. That
> >   function sets the _default_ strictness globally in the system
> >   whereas iommu_get_dma_strict() returns the value for a given domain
> >   (falling back to the default). Presumably, at least, the fact that
> >   iommu_set_dma_strict() doesn't take a domain makes this obvious.
> >
> > The function iommu_get_dma_strict() should now make it super obvious
> > where strictness comes from and who overides who. Though the function
> > changed a bunch to make the logic clearer, the only two new rules
> > should be:
> > * Devices can force strictness for themselves, overriding the cmdline
> >   "iommu.strict=0" or a call to iommu_set_dma_strict(false)).
> > * Devices can request non-strictness for themselves, assuming there
> >   was no cmdline "iommu.strict=1" or a call to
> >   iommu_set_dma_strict(true).
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/iommu/iommu.c | 56 +++++++++++++++++++++++++++++++++----------
> >  include/linux/iommu.h |  2 ++
> >  2 files changed, 45 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 808ab70d5df5..0c84a4c06110 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -28,8 +28,19 @@
> >  static struct kset *iommu_group_kset;
> >  static DEFINE_IDA(iommu_group_ida);
> >
> > +enum iommu_strictness {
> > +       IOMMU_DEFAULT_STRICTNESS = -1,
> > +       IOMMU_NOT_STRICT = 0,
> > +       IOMMU_STRICT = 1,
> > +};
> > +static inline enum iommu_strictness bool_to_strictness(bool strictness)
> > +{
> > +       return (enum iommu_strictness)strictness;
> > +}
> > +
> >  static unsigned int iommu_def_domain_type __read_mostly;
> > -static bool iommu_dma_strict __read_mostly = true;
> > +static enum iommu_strictness cmdline_dma_strict __read_mostly = IOMMU_DEFAULT_STRICTNESS;
> > +static enum iommu_strictness driver_dma_strict __read_mostly = IOMMU_DEFAULT_STRICTNESS;
> >  static u32 iommu_cmd_line __read_mostly;
> >
> >  struct iommu_group {
> > @@ -69,7 +80,6 @@ static const char * const iommu_group_resv_type_string[] = {
> >  };
> >
> >  #define IOMMU_CMD_LINE_DMA_API         BIT(0)
> > -#define IOMMU_CMD_LINE_STRICT          BIT(1)
> >
> >  static int iommu_alloc_default_domain(struct iommu_group *group,
> >                                       struct device *dev);
> > @@ -336,25 +346,38 @@ early_param("iommu.passthrough", iommu_set_def_domain_type);
> >
> >  static int __init iommu_dma_setup(char *str)
> >  {
> > -       int ret = kstrtobool(str, &iommu_dma_strict);
> > +       bool strict;
> > +       int ret = kstrtobool(str, &strict);
> >
> >         if (!ret)
> > -               iommu_cmd_line |= IOMMU_CMD_LINE_STRICT;
> > +               cmdline_dma_strict = bool_to_strictness(strict);
> >         return ret;
> >  }
> >  early_param("iommu.strict", iommu_dma_setup);
> >
> >  void iommu_set_dma_strict(bool strict)
> >  {
> > -       if (strict || !(iommu_cmd_line & IOMMU_CMD_LINE_STRICT))
> > -               iommu_dma_strict = strict;
> > +       /* A driver can request strictness but not the other way around */
> > +       if (driver_dma_strict != IOMMU_STRICT)
> > +               driver_dma_strict = bool_to_strictness(strict);
> >  }
> >
> >  bool iommu_get_dma_strict(struct iommu_domain *domain)
> >  {
> > -       /* only allow lazy flushing for DMA domains */
> > -       if (domain->type == IOMMU_DOMAIN_DMA)
> > -               return iommu_dma_strict;
> > +       /* Non-DMA domains or anyone forcing it to strict makes it strict */
> > +       if (domain->type != IOMMU_DOMAIN_DMA ||
> > +           cmdline_dma_strict == IOMMU_STRICT ||
> > +           driver_dma_strict == IOMMU_STRICT ||
> > +           domain->force_strict)
> > +               return true;
> > +
> > +       /* Anyone requesting non-strict (if no forces) makes it non-strict */
> > +       if (cmdline_dma_strict == IOMMU_NOT_STRICT ||
> > +           driver_dma_strict == IOMMU_NOT_STRICT ||
> > +           domain->request_non_strict)
> > +               return false;
> > +
> > +       /* Nobody said anything, so it's strict by default */
>
> If iommu.strict is not set in the command line, upstream treats it as
> iommu.strict=1. Meaning, no drivers can override it.
>
> If I understand it correctly, with your series, if iommu.strict=1 is
> not set, drivers can override the "default strict mode" and ask for
> non-strict mode for their domain. So if this series gets in and future
> driver changes start asking for non-strict mode, systems that are
> expected to operate in fully strict mode will now have devices
> operating in non-strict mode.
>
> That's breaking backward compatibility for the kernel command line
> param. It looks like what you really need is to change iommu.strict
> from 0/1 to lazy (previously 0), strict preferred, strict enforced
> (previously 1) and you need to default it to "enforced".

I'm not quite sure I'd agree, but certainly it could be up for debate.
I think I'm keeping full compatibility with the kernel command line
parameter, specifically:

* iommu.strict=0: default to non-strict mode unless a driver overrides

* iommu.strict=1: force everything to strict no matter what

...both of those two things are the same before and after my patchset.

You're arguing that I'm changing the behavior of the system when no
command line parameter is present. To me this seems a little bit of a
stretch. If no command line parameter is present I'd assert that the
kernel should do some sort of sane behavior and that we don't have to
force 100% strictness if the command line parameter isn't present at
all.

I would also note that your assertion that the system is 100% strict
under the "no command line parameter" case isn't actually true as far
as I can tell. The code in mainline is a little hard to follow (for me
the code after my patch is easier to follow), but you can see that
even before my patch a call to iommu_set_dma_strict() could be used to
make the system non-strict if no command-line parameter was passed.


> Alternately (and potentially a better option?), you really should be
> changing/extending dev_is_untrusted() so that it applies for any
> struct device (not just PCI device) and then have this overridden in
> DT (or ACPI or any firmware) to indicate a specific device is safe to
> use non-strict mode on.

I was really trying _not_ to do that. I believe this has been talked
about several times, including at last year's Linux Plumbers
conference. As far as I can tell it always ends in a shouting match w/
no forward progress. There are a bunch of problems here, namely:

* Trust isn't necessarily binary. There might be peripherals that you
sort-of trust, others that you really trust, and others that you don't
trust at all. For the ones you sort-of trust there may be some things
you trust about them and other things you don't trust about them.

* The firmware isn't necessarily the best arbitrar of trust. For
instance, if the company that employs me (Google) compiled their own
firmware for a given peripheral device and they were convinced that
the peripheral firmware couldn't be compromised any more easily than
code running in the kernel itself, they might assert that the
peripheral device should be "trusted". An individual Linux hacker,
however, might not really trust the firmware blob that Google provides
and might want the device to be "untrusted".

* In the PCI subsystem I believe that "trusted" vs "untrusted" is
generally associated with whether a device is soldered down onto the
board or in some type of slot (the "external" concept). That's been
working OK for them, I think, but I'm not convinced it'd be easy to
apply everywhere. One example problem: what do you do about SD cards?
The thing doing the DMA (the SDHCI controller) is certainly "internal"
but the cards are "external". I'm making the argument in my series
that SDHCI should be considered at least trusted enough to use
non-strict DMA, but it's still technically "external" and you wouldn't
necessarily, for instance, trust the filesystem structure not to be
crafted in a malicious way so as to exploit the kernel.

> What you are trying to capture (if the device
> safe enough) really isn't a function of the DMA device's driver, but a
> function of the DMA device.

It's a function of the DMA device, but the entity in the kernel with
the most knowledge about this is the device's driver. The driver also
has the best ability to make informed decisions, perhaps looking at
the device's properties (like the "non-removable" one for SD/MMC) to
help make decisions without us having to create a new property to
describe trust and then argue about who sets it and when.

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
