Return-Path: <SRS0=n9pq=UC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0457C28CC6
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 14:20:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E9527854
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 14:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxTCtyP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E9527854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9F259CC2;
	Mon,  3 Jun 2019 14:20:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id BE461BDC
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 14:20:32 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
	[209.85.208.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B265D854
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 14:20:31 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id y17so9108177edr.0
	for <iommu@lists.linux-foundation.org>;
	Mon, 03 Jun 2019 07:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=H1l3e5E872lH6qkNiWrauP+wdCi/3UG5lpCKfkIljyk=;
	b=TxTCtyP/7Or/ZSeG32tNbbfu4uLpndP3q0fYvs2+YzvFx2+E9xiFdIX0NemxiZ99jL
	fEZFZrGA86LVdAlJY1yhs6EgdG7cf1CzDNTY5/EVGk7CFlVbGaqVruhTGTSP4eBN9cdI
	+ZudoPr3oSuI+sqI5hqu3KZ+vLWTu3Yi5GYZhk3qsWbd4xmhG95hbyhvnfzAhM8zqYYe
	u1VPm6zoGdDOhY9e1YaaZxh6SYFEQMouYr+qrprl5/daT4AUUs37VmIe37FOpU2UYNpu
	zFP6KPSOJ/JeZQT4X62/YLISY7/hbKF5cqHQzTuHbFHG1kmgS8Z0sCTfrKqRt8bxDEN+
	LhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=H1l3e5E872lH6qkNiWrauP+wdCi/3UG5lpCKfkIljyk=;
	b=V/Z6JXLriHUAdOHO4gUjlI7+Ho3t6m/8fgbkAyB4Kt01Ry2ZTUnUIMy2X5oBXaQh+/
	dRKBKDjncIzo+9XOuAXB0LVoYqLJF+n4K0UoBow9EOiqO+bHn7q/RRuXgHQrGwpi7UMp
	LtHtDGIQowikk3/rKqnyiejbQUOmVmiG3GKCs8KZ0nCAASPKLuCwJX+vBLJJpZiB0ejF
	mCt8y2FmLLUaDEOvQ6FGToHknF1Y1x/h2QfvGPhByucSghdFS/mNbAG8OQiieQT6k2WC
	HxV4LLNeQDXtgF9nfkQ30IsthEVC3Lb1NIgN8TVKC3oFRoWb/r7U4xtApWB1QS+UyiDZ
	Dw2w==
X-Gm-Message-State: APjAAAVisrd8P8616Y3AdI2i2uRSLF6vATxjZfoUMTg6LfcK68EFeXMs
	9EcA0r5mARNl/kE7HuA4Rnp4kr5miAdscnCOJqg=
X-Google-Smtp-Source: APXvYqyitDqunKKxwCVtkAbVz72g165T8RDbubisvbCXCoq9mtwKbyUTiXDW8aa636BnXDN5Tg1eN2yjWtiEEFn1Hws=
X-Received: by 2002:a50:bc15:: with SMTP id j21mr28542309edh.163.1559571630113;
	Mon, 03 Jun 2019 07:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20181201165348.24140-1-robdclark@gmail.com>
	<CAL_JsqJmPqis46Un91QyhXgdrVtfATMP_hTp6wSeSAfc8MLFfw@mail.gmail.com>
	<CAF6AEGs9Nsft8ofZkGz_yWBPBC+prh8dBSkJ4PJr8yk2c5FMdQ@mail.gmail.com>
	<CAF6AEGt-dhbQS5zZCNVTLT57OiUwO0RiP5bawTSu2RKZ-7W-aw@mail.gmail.com>
	<CAAFQd5BdrJFL5LKK8O5NPDKWfFgkTX_JU-jU3giEz33tj-jwCA@mail.gmail.com>
	<CAF6AEGtj+kyXqKeJK2-0e1jw_A4wz-yBEyv5zhf5Vfoi2_p2CA@mail.gmail.com>
	<401f9948-14bd-27a2-34c1-fb429cae966d@arm.com>
	<CAF6AEGuGGAThqs9ztTNyGnMyhFc9wbtn=N8A4qqQxcN_PAxsEw@mail.gmail.com>
	<20190603135408.GE30132@ulmo>
In-Reply-To: <20190603135408.GE30132@ulmo>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 3 Jun 2019 07:20:14 -0700
Message-ID: <CAF6AEGtrfqYBNyjpHsUy1Tj-FJZ0MybvAJdHQsqb5kqih2BY3A@mail.gmail.com>
Subject: Re: [PATCH] of/device: add blacklist for iommu dma_ops
To: Thierry Reding <thierry.reding@gmail.com>
Cc: devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
	Frank Rowand <frowand.list@gmail.com>, Will Deacon <will.deacon@arm.com>,
	Doug Anderson <dianders@chromium.org>,
	dri-devel <dri-devel@lists.freedesktop.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	Rob Herring <robh+dt@kernel.org>, Sean Paul <seanpaul@chromium.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	freedreno <freedreno@lists.freedesktop.org>,
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, Jun 3, 2019 at 6:54 AM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> On Mon, Jun 03, 2019 at 06:20:57AM -0700, Rob Clark wrote:
> > On Mon, Jun 3, 2019 at 4:14 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > On 03/06/2019 11:47, Rob Clark wrote:
> > > > On Sun, Jun 2, 2019 at 11:25 PM Tomasz Figa <tfiga@chromium.org> wrote:
> > > >>
> > > >> On Mon, Jun 3, 2019 at 4:40 AM Rob Clark <robdclark@gmail.com> wrote:
> > > >>>
> > > >>> So, another case I've come across, on the display side.. I'm working
> > > >>> on handling the case where bootloader enables display (and takes iommu
> > > >>> out of reset).. as soon as DMA domain gets attached we get iommu
> > > >>> faults, because bootloader has already configured display for scanout.
> > > >>> Unfortunately this all happens before actual driver is probed and has
> > > >>> a chance to intervene.
> > > >>>
> > > >>> It's rather unfortunate that we tried to be clever rather than just
> > > >>> making drivers call some function to opt-in to the hookup of dma iommu
> > > >>> ops :-(
> > > >>
> > > >> I think it still works for the 90% of cases and if 10% needs some
> > > >> explicit work in the drivers, that's better than requiring 100% of the
> > > >> drivers to do things manually.
> > >
> > > Right, it's not about "being clever", it's about not adding opt-in code
> > > to the hundreds and hundreds and hundreds of drivers which *might* ever
> > > find themselves used on a system where they would need the IOMMU's help
> > > for DMA.
> >
> > Well, I mean, at one point we didn't do the automatic iommu hookup, we
> > could have just stuck with that and added a helper so drivers could
> > request the hookup.  Things wouldn't have been any more broken than
> > before, and when people bring up systems where iommu is required, they
> > could have added the necessary dma_iommu_configure() call.  But that
> > is water under the bridge now.
> >
> > > >> Adding Marek who had the same problem on Exynos.
> > > >
> > > > I do wonder how many drivers need to iommu_map in their ->probe()?
> > > > I'm thinking moving the auto-hookup to after a successful probe(),
> > > > with some function a driver could call if they need mapping in probe,
> > > > might be a way to eventually get rid of the blacklist.  But I've no
> > > > idea how to find the subset of drivers that would be broken without a
> > > > dma_setup_iommu_stuff() call in their probe.
> > >
> > > Wouldn't help much. That particular issue is nothing to do with DMA ops
> > > really, it's about IOMMU initialisation. On something like SMMUv3 there
> > > is literally no way to turn the thing on without blocking unknown
> > > traffic - it *has* to have stream table entries programmed before it can
> > > even allow stuff to bypass.
> >
> > fwiw, on these sdm850 laptops (and I think sdm845 boards like mtp and
> > db845c) the SMMU (v2) is taken out of bypass by the bootloader.  Bjorn
> > has some patches for arm-smmu to read-back the state at boot.
> >
> > (Although older devices were booting with display enabled but SMMU in bypass.)
> >
> > > The answer is either to either pay attention to the "Quiesce all DMA
> > > capable devices" part of the boot protocol (which has been there since
> > > pretty much forever), or to come up with some robust way of
> > > communicating "live" boot-time mappings to IOMMU drivers so that they
> > > can program themselves appropriately during probe.
> >
> > Unfortunately display lit up by bootloader is basically ubiquitous.
> > Every single android phone does it.  All of the windows-arm laptops do
> > it.  Basically 99.9% of things that have a display do it.  It's a
> > tough problem to solve involving clks, gdsc, regulators, etc, in
> > addition to the display driver.. and sadly now smmu.  And devices
> > where we can make changes to and update the firmware are rather rare.
> > So there is really no option to ignore this problem.
>
> I think this is going to require at least some degree of cooperation
> from the bootloader. See my other thread on that. Unfortunately I think
> this is an area where everyone has kind of been doing their own thing
> even if standard bindings for this have been around for quite a while
> (actually 5 years by now). I suspect that most bootloaders that run
> today are not that old, but as always downstream doesn't follow closely
> where upstream is guiding.
>
> > I guess if we had some early-quirks mechanism like x86 does, we could
> > mash the display off early in boot.  That would be an easy solution.
> > Although I'd prefer a proper solution so that android phones aren't
> > carrying around enormous stacks of hack patches to achieve a smooth
> > flicker-free boot.
>
> The proper solution, I think, is for bootloader and kernel to work
> together. Unfortunately that means we'll just have to bite the bullet
> and get things fixed across the stack. I think this is just the latest
> manifestation of the catch-up that upstream has been playing. Only now
> that we're starting to enable all of these features upstream are we
> running into interoperability issues.
>
> If upstream had been further along we would've caught these issues way
> ahead of time and could've influenced the designs of bootloader much
> earlier. Now, unless we get all the vendors to go back and modify 5 year
> old code that's going to be difficult.
>
> However, I think Robin has a point here: it's clearly documented in the
> boot protocol, so technically bootloaders are buggy and we can't always
> go and fix things so that buggy bootloaders continue to work. There's
> not a whole lot of incentive for anyone to fix the bootloaders if we
> keep doing that, ey?
>

A couple notes:

1) The odds of getting new bootloaders for 5yr old phones is basically
   none.. and they are typically signed so we couldn't just write our
   own even if we wanted to.

2) The windows arm laptops shipping actually have "real" UEFI+ACPI..
   for now we've been using device-tree to get linux booting on them.
   But I think we are going to need to shift to ACPI eventually.. so
   a dt specific solution isn't super helpful.

   But we do have EFI GOP to get the address of the boot framebuffer,
   and I believe there is a reserved memory region setup for it.
   Not sure how to connect that to the iommu subsys.

3) The automatic attach of DMA domain is also causing a different
   problem for us on the GPU side, preventing us from supporting per-
   context pagetables (since we end up with a disagreement about
   which context bank is used between arm-smmu and the firmware).

I'm kinda glad that x86 folks were more pragmatic about getting linux
to work on actual hardware, not just restricting things to hw that
looked the way they wanted it too.. at some point in arch/arm64 we are
going to have to decide that reality is a thing.  Ignoring that is
only going to force users and distros to downstream kernels.

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
