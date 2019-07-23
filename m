Return-Path: <SRS0=bViT=VU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFFBC76186
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 17:41:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E6F2083B
	for <iommu@archiver.kernel.org>; Tue, 23 Jul 2019 17:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEgbUlOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E6F2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CCB1EB8F;
	Tue, 23 Jul 2019 17:41:11 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A426C949
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 17:41:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
	[209.85.208.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DA57B7C3
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 17:41:08 +0000 (UTC)
Received: by mail-ed1-f68.google.com with SMTP id s49so9917248edb.1
	for <iommu@lists.linux-foundation.org>;
	Tue, 23 Jul 2019 10:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=nogcB6tU7ggTUc1+z4/fMorc4784ohsjEsA0VkxE4cQ=;
	b=WEgbUlOwKq7FDIuwTpjXkL4hd+FxqB9iuHFupSLPSi3UKeNHLWZaKkOW15zx5J2/ZZ
	iq8eueW8GsDMgV/SbuUXl849uTeoFKSwBk97/PL1K/GdP6IyScS7KKhmTtjPG885+diA
	cRUhcWbQIOTDvi+ETBdb+Wqw2Qr4IRYtifiZNbdb+omqbkcvelRLhYOPCx/6rm/PP0pV
	P+9LzpxJAoz7157KwdoGgBOShLoYyKMiSjWxLv9D/XFnc9iFg6nX+umbM8UXpX5no5ET
	JVjO2MbiOlIMGOzoTAoU0AVnUrhsIVWYyNovjrnEKyh1nIO5ieSGxSZldsbMVW1fftUE
	9PQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=nogcB6tU7ggTUc1+z4/fMorc4784ohsjEsA0VkxE4cQ=;
	b=NTlPKiJnQG062628x++y6+Lbcha/v4nThRGW0YyEabz+o6j+I+KXRDDKW2gWT1igCl
	TLqFH6AsR4Z0j5KXEXXrVqiFA0LeHUxGBIW3dsDNsiUQqAO+eVyQXvxj2BOHreWe1ddZ
	1UB4l5MpR2aFWi1GRknEmsqF7XL95rk9wT0Jk7eG0MQBJvhAX0GCfKZVIXLWSHjS+l6U
	jtDfvfSeTMGiHiXJ+Pip6XRwQP2vRnSF1+ywl5lCrY+tQxOVGTDgyVmkudxwwcevDkJP
	rHX0SaYv7m8Z87JTbsHac53laQbvnM9i4a8V7fEuZ3qGKyl6zIFgo/BXxpEBD3qhMfzQ
	o2lw==
X-Gm-Message-State: APjAAAUWrudfB7GjM5u8qmZyHF5A0a9FVXQt0w49PTGo6wz4rfsvqP/X
	jHDvo3zrpZ3nitT4xLW6KKKRgLPPQAdsB75+Y54=
X-Google-Smtp-Source: APXvYqzemPNRUI4Dv8rCDS7Y3Atwe1foT+6Dyv7m4pV5WgS2/fMuH1KImSCRDazCl+5WCpEBG93Sr1jOHq4wKAJmBc8=
X-Received: by 2002:a17:906:f85:: with SMTP id
	q5mr60032126ejj.192.1563903667438; 
	Tue, 23 Jul 2019 10:41:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190702202631.32148-2-robdclark@gmail.com>
	<20190710182844.25032-1-robdclark@gmail.com>
	<20190722142833.GB12009@8bytes.org>
	<CAF6AEGvJc2RK3GkpcXiVKsuTX81D3oahnu=qWJ9LFst1eT3tMg@mail.gmail.com>
	<20190722154803.GG12009@8bytes.org>
	<CAF6AEGvWf3ZOrbyyWjORuOVEPOcPr+JSEO78aYjhL-GVhDZnTg@mail.gmail.com>
	<20190723153822.gm4ossn43nvqbyak@willie-the-truck>
In-Reply-To: <20190723153822.gm4ossn43nvqbyak@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 23 Jul 2019 10:40:55 -0700
Message-ID: <CAF6AEGtL6gqtbmtksf7zCSGrFOEj0ynq-2nwvizLLiS0FTwHpg@mail.gmail.com>
Subject: Re: [PATCH v2] iommu: add support for drivers that manage iommu
	explicitly
To: Will Deacon <will@kernel.org>
Cc: Rob Clark <robdclark@chromium.org>, aarch64-laptops@lists.linaro.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
	Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, Jul 23, 2019 at 8:38 AM Will Deacon <will@kernel.org> wrote:
>
> On Mon, Jul 22, 2019 at 09:23:48AM -0700, Rob Clark wrote:
> > On Mon, Jul 22, 2019 at 8:48 AM Joerg Roedel <joro@8bytes.org> wrote:
> > >
> > > On Mon, Jul 22, 2019 at 08:41:34AM -0700, Rob Clark wrote:
> > > > It is set by the driver:
> > > >
> > > > https://patchwork.freedesktop.org/patch/315291/
> > > >
> > > > (This doesn't really belong in devicetree, since it isn't a
> > > > description of the hardware, so the driver is really the only place to
> > > > set this.. which is fine because it is about a detail of how the
> > > > driver works.)
> > >
> > > It is more a detail about how the firmware works. IIUC the problem is
> > > that the firmware initializes the context mappings for the GPU and the
> > > OS doesn't know anything about that and just overwrites them, causing
> > > the firmware GPU driver to fail badly.
> > >
> > > So I think it is the task of the firmware to tell the OS not to touch
> > > the devices mappings until the OS device driver takes over. On x86 there
> > > is something similar with the RMRR/unity-map tables from the firmware.
> > >
> >
> > Bjorn had a patchset[1] to inherit the config from firmware/bootloader
> > when arm-smmu is probed which handles that part of the problem.  My
> > patch is intended to be used on top of his patchset.  This seems to me
> > like the best solution, if we don't have control over the firmware.
>
> Hmm, but the feedback from Robin on the thread you cite was that this should
> be generalised to look more like RMRR, so there seems to be a clear message
> here.
>

Perhaps it is a lack of creativity, or lack of familiarity w/ iommu vs
virtualization, but I'm not quite seeing how RMRR would help.. in
particular when dealing with both DT and ACPI cases.  So I kinda
prefer, when possible, if arm-smmu can figure out what is going on by
looking at the hw state at boot (since that approach would work
equally well for DT and ACPI).

I *think* (but need to confirm if Bjorn hasn't already) that the
memory for the pagetables that firmware/bootloader sets up is already
removed from the memory map efi passes to kernel, so we don't need to
worry about kernel stomping in-use pagetables.

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
