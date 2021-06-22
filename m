Return-Path: <SRS0=IFPa=LQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4A4C2B9F4
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 19:41:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F06A61353
	for <iommu@archiver.kernel.org>; Tue, 22 Jun 2021 19:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F06A61353
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8F6E83AD9;
	Tue, 22 Jun 2021 19:41:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CXsS5ZzHMu7b; Tue, 22 Jun 2021 19:41:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BDA2282E14;
	Tue, 22 Jun 2021 19:41:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F422C0010;
	Tue, 22 Jun 2021 19:41:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54336C000E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 19:41:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3786D40507
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 19:41:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fSk29Y88Yiqm for <iommu@lists.linux-foundation.org>;
 Tue, 22 Jun 2021 19:40:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E88404045A
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 19:40:58 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 x22-20020a4a62160000b0290245cf6b7feeso129658ooc.13
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 12:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KbphWW+YCq0HiY8JKMK80s61y/VI/u5uRCvjvuYgRvo=;
 b=B0KKMBDv6mmc1lnaI4uPkAm6cPTmdb7TIXjhicSbGznIFUVv9JjjbjCqNCaOd7EpYM
 pnnEU8sbe0AVpMJXATFzGWXRlVkOSlojtJ9YUkl0HamHxDkd3CMgYIcUaibp/wBrGa39
 arNtBQL0FAKJSiCk0bIOZEIS47O+vz6l2FCAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KbphWW+YCq0HiY8JKMK80s61y/VI/u5uRCvjvuYgRvo=;
 b=GJGervMNhXeYV7XjD24fQGxaIzbXT/w+S6oGVHiRBoHLUF8N+psRLkmBYUp+JAsHjR
 OzjrW8I+gVAAmjwK3PVeyFaEHHDU3gdZj1XasmrApTvfPrfWWcurAFxZjKsmm7rx9vZz
 Bxd22A+VIgXsdTwI2Ng7M8RutDzZNqxTG1Wra2y2zCy1eJhFMq+95LJWt8AAgVLGjxoM
 8p75qIYzGoK9Gv9aHYX6Mr0Uw72FHYjzERp/lbzYoMSYx7hUgdSbtdJCuPJtewMuLd0x
 hGmCFkyve3N+Xa1t+o9bfxzEL+vpilN3Mn4f2AhuHfdFciK4w5GOxmZqlNaqJO7A/qIF
 4Ymw==
X-Gm-Message-State: AOAM530zuBt2QoYp1isWLFO83pF8pdD3fb54g+oFrfMYW2AqOdcPXjeG
 Z6r/NMHNH7hIODr5iWqdzrUUDuh4enTe5g==
X-Google-Smtp-Source: ABdhPJy5HrnjnyxYG8ZFMksDGmRqgaME5+M/fzkK+Hq9YxVZ8ij1UKDvnpdVEvlgmzrOPolgw7Q7pw==
X-Received: by 2002:a4a:ab07:: with SMTP id i7mr4666605oon.89.1624390857697;
 Tue, 22 Jun 2021 12:40:57 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com.
 [209.85.210.43])
 by smtp.gmail.com with ESMTPSA id r4sm688732ooq.18.2021.06.22.12.40.57
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jun 2021 12:40:57 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id
 f3-20020a0568301c23b029044ce5da4794so15750032ote.11
 for <iommu@lists.linux-foundation.org>; Tue, 22 Jun 2021 12:40:57 -0700 (PDT)
X-Received: by 2002:a25:2405:: with SMTP id k5mr6758869ybk.405.1624390512166; 
 Tue, 22 Jun 2021 12:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.4.Id84a954e705fcad3fdb35beb2bc372e4bf2108c7@changeid>
 <CACK8Z6EVmnMx4X8ZF7QSm58KCMMAkgSa+S9YkH+mC5RfmeyYoA@mail.gmail.com>
In-Reply-To: <CACK8Z6EVmnMx4X8ZF7QSm58KCMMAkgSa+S9YkH+mC5RfmeyYoA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 22 Jun 2021 12:35:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U9WqEKVgX6p1Eaf5hvpXet0e_rqKKS4YRNsDrLW5R5zg@mail.gmail.com>
Message-ID: <CAD=FV=U9WqEKVgX6p1Eaf5hvpXet0e_rqKKS4YRNsDrLW5R5zg@mail.gmail.com>
Subject: Re: [PATCH 4/6] iommu: Combine device strictness requests with the
 global default
To: Rajat Jain <rajatja@google.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, Will Deacon <will@kernel.org>,
 Rob Clark <robdclark@chromium.org>, Saravana Kannan <saravanak@google.com>,
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

On Tue, Jun 22, 2021 at 11:45 AM Rajat Jain <rajatja@google.com> wrote:
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
>
> Along the same lines, I believe a platform (device tree / ACPI) should
> also be able to have a say in this. I assume in your proposal, a
> platform would expose a property in device tree which the device
> driver would need to parse and then use it to set these bits in the
> "struct device"?

Nothing would prevent creating a device tree or ACPI property that
caused either "force-strict" or "request-non-strict" from being set if
everyone agrees that it's a good idea. I wouldn't reject the idea
myself, but I do worry that we'd devolve into the usual bikeshed for
exactly how this should look. I talked about this a bit in my response
to Saravana, but basically:

* If there was some generic property, would we call it "untrusted",
"external", or something else?

* How do you describe "trust" in a generic "objective" way? It's not
really boolean and trying to describe exactly how trustworthy
something should be considered is hard.

* At least for the device tree there's a general requirement that it
describes the hardware and not so much how the software should
configure the hardware. As I understand it there is _some_ leeway here
where it's OK to describe how the hardware was designed for the OS to
configure it, but it's a pretty high bar and a hard sell. In general
the device tree isn't supposed to be used to describe "policy". In
other words: if one OS might decide on one setting and another OS on
another then it doesn't really belong in the device tree.

* In general the kernel is also not really supposed to have policy
hardcoded in either, though it feels like we can get away with having
a good default/sane policy and allowing overriding the policy with
command line parameters (like iommu.strict). In the case where
something has to be configured at bootup there's not many ways to do
better.


tl;dr: I have no plans to try to make an overarching property, but my
patch series does allow subsystems to come up with and easily
implement their own rules as it makes sense. While this might seem
hodgepodge I prefer to see it as "flexible" since I'm not convinced
that we're going to be able to come up with an overarching trust
framework.

-Doug
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
