Return-Path: <SRS0=n9pq=UC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDD9C282CE
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 14:40:24 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A8F278AB
	for <iommu@archiver.kernel.org>; Mon,  3 Jun 2019 14:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icPrNJtA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A8F278AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9CFB7AAE;
	Mon,  3 Jun 2019 14:40:23 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 31510DA7
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 14:40:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
	[209.85.128.65])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E7BBEA3
	for <iommu@lists.linux-foundation.org>;
	Mon,  3 Jun 2019 14:40:20 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id f204so7482555wme.0
	for <iommu@lists.linux-foundation.org>;
	Mon, 03 Jun 2019 07:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=O/AELnaQ4k42QfaP+WsrrV00zITqRvCQBl4QyL9fI5w=;
	b=icPrNJtAyYl4hhi5BzDc+enymlkJUBrI6qm2UwQ4GDhCBg4CJ3Qa6ps1cmjMzP8A0I
	lMnXZ0cdaL/bUbLi4cxtpxEC+Ih3MDsxlWVhSMQwlqDea0RpUrxaSDx/QTMDy0Dw2SGz
	IiFLW97HBZT4W9hTO+/E8gFF7ye5O+Lk4P44XS430461i14HgluZsyU4Zm0CQuhEZawJ
	K3gYW77iYmi4OVg1aGPd75IdpFW3JV+i/5msnU2YB1xMbaCAT+To3FiMc1nLGudhHdi7
	K0B5iVo7VkZ3SGqItv/SQy37SYALG0hl+KunhZdfbcMK5mvvfBj9iYM2mRusse7hxMNP
	a6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=O/AELnaQ4k42QfaP+WsrrV00zITqRvCQBl4QyL9fI5w=;
	b=srpV/c0OUh9rQAeuRX7+cSuPtypV2rw8hczthSPIA7PYJisfQTqkptxceuDpgr32P8
	G+UXadfSUF5QaJvZh5mu4OU8OjnWEx96p3LVJ4gDuxQvGulADj1dztgwhsbuEjscv1pL
	gvFibATswdC5IEmUpfrj/a3EXJSNkxbvPan4Km+5LHqp4MZcCgkGlpbxHeVIIdKNqn0H
	AwFbmjR8Rv+opvc3vpRrCllDOKTKX7SdueLAC9g6lbqni813tgcEk6NbHnLiyK1mJaHp
	vNg128nQGaJPtjMqszkFYjNk1RtinHGsr5fPRxPXJX3QIV2+gHLM7gbhRMU+qW+XHjXO
	ziWg==
X-Gm-Message-State: APjAAAWIr8cyutWsV5dfEPikwpaG2JNWA0VTW9GvyC9jTFv1njBIC7R+
	svrDxyXsdo+mUz7sfYYkPKg=
X-Google-Smtp-Source: APXvYqz30RK8w3jZL918ldJAdOuAflvnk6nuRblL0IDupJwAiKtJxfWTpbuwEE08CciG5WyHlbNpTA==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr14935541wma.78.1559572819391; 
	Mon, 03 Jun 2019 07:40:19 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
	by smtp.gmail.com with ESMTPSA id
	s63sm6277446wme.17.2019.06.03.07.40.18
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 03 Jun 2019 07:40:18 -0700 (PDT)
Date: Mon, 3 Jun 2019 16:40:16 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] of/device: add blacklist for iommu dma_ops
Message-ID: <20190603144016.GG30132@ulmo>
References: <20181201165348.24140-1-robdclark@gmail.com>
	<CAL_JsqJmPqis46Un91QyhXgdrVtfATMP_hTp6wSeSAfc8MLFfw@mail.gmail.com>
	<CAF6AEGs9Nsft8ofZkGz_yWBPBC+prh8dBSkJ4PJr8yk2c5FMdQ@mail.gmail.com>
	<CAF6AEGt-dhbQS5zZCNVTLT57OiUwO0RiP5bawTSu2RKZ-7W-aw@mail.gmail.com>
	<CAAFQd5BdrJFL5LKK8O5NPDKWfFgkTX_JU-jU3giEz33tj-jwCA@mail.gmail.com>
	<CAF6AEGtj+kyXqKeJK2-0e1jw_A4wz-yBEyv5zhf5Vfoi2_p2CA@mail.gmail.com>
	<401f9948-14bd-27a2-34c1-fb429cae966d@arm.com>
	<CAF6AEGuGGAThqs9ztTNyGnMyhFc9wbtn=N8A4qqQxcN_PAxsEw@mail.gmail.com>
	<20190603135408.GE30132@ulmo>
	<CAF6AEGtrfqYBNyjpHsUy1Tj-FJZ0MybvAJdHQsqb5kqih2BY3A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAF6AEGtrfqYBNyjpHsUy1Tj-FJZ0MybvAJdHQsqb5kqih2BY3A@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Content-Type: multipart/mixed; boundary="===============7062382260999842272=="
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org


--===============7062382260999842272==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VbfcI4OLZ4XW0yH2"
Content-Disposition: inline


--VbfcI4OLZ4XW0yH2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2019 at 07:20:14AM -0700, Rob Clark wrote:
> On Mon, Jun 3, 2019 at 6:54 AM Thierry Reding <thierry.reding@gmail.com> =
wrote:
> >
> > On Mon, Jun 03, 2019 at 06:20:57AM -0700, Rob Clark wrote:
> > > On Mon, Jun 3, 2019 at 4:14 AM Robin Murphy <robin.murphy@arm.com> wr=
ote:
> > > >
> > > > On 03/06/2019 11:47, Rob Clark wrote:
> > > > > On Sun, Jun 2, 2019 at 11:25 PM Tomasz Figa <tfiga@chromium.org> =
wrote:
> > > > >>
> > > > >> On Mon, Jun 3, 2019 at 4:40 AM Rob Clark <robdclark@gmail.com> w=
rote:
> > > > >>>
> > > > >>> So, another case I've come across, on the display side.. I'm wo=
rking
> > > > >>> on handling the case where bootloader enables display (and take=
s iommu
> > > > >>> out of reset).. as soon as DMA domain gets attached we get iommu
> > > > >>> faults, because bootloader has already configured display for s=
canout.
> > > > >>> Unfortunately this all happens before actual driver is probed a=
nd has
> > > > >>> a chance to intervene.
> > > > >>>
> > > > >>> It's rather unfortunate that we tried to be clever rather than =
just
> > > > >>> making drivers call some function to opt-in to the hookup of dm=
a iommu
> > > > >>> ops :-(
> > > > >>
> > > > >> I think it still works for the 90% of cases and if 10% needs some
> > > > >> explicit work in the drivers, that's better than requiring 100% =
of the
> > > > >> drivers to do things manually.
> > > >
> > > > Right, it's not about "being clever", it's about not adding opt-in =
code
> > > > to the hundreds and hundreds and hundreds of drivers which *might* =
ever
> > > > find themselves used on a system where they would need the IOMMU's =
help
> > > > for DMA.
> > >
> > > Well, I mean, at one point we didn't do the automatic iommu hookup, we
> > > could have just stuck with that and added a helper so drivers could
> > > request the hookup.  Things wouldn't have been any more broken than
> > > before, and when people bring up systems where iommu is required, they
> > > could have added the necessary dma_iommu_configure() call.  But that
> > > is water under the bridge now.
> > >
> > > > >> Adding Marek who had the same problem on Exynos.
> > > > >
> > > > > I do wonder how many drivers need to iommu_map in their ->probe()?
> > > > > I'm thinking moving the auto-hookup to after a successful probe(),
> > > > > with some function a driver could call if they need mapping in pr=
obe,
> > > > > might be a way to eventually get rid of the blacklist.  But I've =
no
> > > > > idea how to find the subset of drivers that would be broken witho=
ut a
> > > > > dma_setup_iommu_stuff() call in their probe.
> > > >
> > > > Wouldn't help much. That particular issue is nothing to do with DMA=
 ops
> > > > really, it's about IOMMU initialisation. On something like SMMUv3 t=
here
> > > > is literally no way to turn the thing on without blocking unknown
> > > > traffic - it *has* to have stream table entries programmed before i=
t can
> > > > even allow stuff to bypass.
> > >
> > > fwiw, on these sdm850 laptops (and I think sdm845 boards like mtp and
> > > db845c) the SMMU (v2) is taken out of bypass by the bootloader.  Bjorn
> > > has some patches for arm-smmu to read-back the state at boot.
> > >
> > > (Although older devices were booting with display enabled but SMMU in=
 bypass.)
> > >
> > > > The answer is either to either pay attention to the "Quiesce all DMA
> > > > capable devices" part of the boot protocol (which has been there si=
nce
> > > > pretty much forever), or to come up with some robust way of
> > > > communicating "live" boot-time mappings to IOMMU drivers so that th=
ey
> > > > can program themselves appropriately during probe.
> > >
> > > Unfortunately display lit up by bootloader is basically ubiquitous.
> > > Every single android phone does it.  All of the windows-arm laptops do
> > > it.  Basically 99.9% of things that have a display do it.  It's a
> > > tough problem to solve involving clks, gdsc, regulators, etc, in
> > > addition to the display driver.. and sadly now smmu.  And devices
> > > where we can make changes to and update the firmware are rather rare.
> > > So there is really no option to ignore this problem.
> >
> > I think this is going to require at least some degree of cooperation
> > from the bootloader. See my other thread on that. Unfortunately I think
> > this is an area where everyone has kind of been doing their own thing
> > even if standard bindings for this have been around for quite a while
> > (actually 5 years by now). I suspect that most bootloaders that run
> > today are not that old, but as always downstream doesn't follow closely
> > where upstream is guiding.
> >
> > > I guess if we had some early-quirks mechanism like x86 does, we could
> > > mash the display off early in boot.  That would be an easy solution.
> > > Although I'd prefer a proper solution so that android phones aren't
> > > carrying around enormous stacks of hack patches to achieve a smooth
> > > flicker-free boot.
> >
> > The proper solution, I think, is for bootloader and kernel to work
> > together. Unfortunately that means we'll just have to bite the bullet
> > and get things fixed across the stack. I think this is just the latest
> > manifestation of the catch-up that upstream has been playing. Only now
> > that we're starting to enable all of these features upstream are we
> > running into interoperability issues.
> >
> > If upstream had been further along we would've caught these issues way
> > ahead of time and could've influenced the designs of bootloader much
> > earlier. Now, unless we get all the vendors to go back and modify 5 year
> > old code that's going to be difficult.
> >
> > However, I think Robin has a point here: it's clearly documented in the
> > boot protocol, so technically bootloaders are buggy and we can't always
> > go and fix things so that buggy bootloaders continue to work. There's
> > not a whole lot of incentive for anyone to fix the bootloaders if we
> > keep doing that, ey?
> >
>=20
> A couple notes:
>=20
> 1) The odds of getting new bootloaders for 5yr old phones is basically
>    none.. and they are typically signed so we couldn't just write our
>    own even if we wanted to.
>=20
> 2) The windows arm laptops shipping actually have "real" UEFI+ACPI..
>    for now we've been using device-tree to get linux booting on them.
>    But I think we are going to need to shift to ACPI eventually.. so
>    a dt specific solution isn't super helpful.
>=20
>    But we do have EFI GOP to get the address of the boot framebuffer,
>    and I believe there is a reserved memory region setup for it.
>    Not sure how to connect that to the iommu subsys.

It shouldn't be a problem to hook something else up to the IOMMU
subsystem. Hopefully it's something that people are going to standardize
on.

> 3) The automatic attach of DMA domain is also causing a different
>    problem for us on the GPU side, preventing us from supporting per-
>    context pagetables (since we end up with a disagreement about
>    which context bank is used between arm-smmu and the firmware).

I'm not sure I understand this issue. Is the context bank hard-coded in
the firmware somehow? Or is it possible to rewrite which one is going to
be used at runtime? Do you switch out the actual page tables rather than
the IOMMU domains for context switching?

> I'm kinda glad that x86 folks were more pragmatic about getting linux
> to work on actual hardware, not just restricting things to hw that
> looked the way they wanted it too.. at some point in arch/arm64 we are
> going to have to decide that reality is a thing.  Ignoring that is
> only going to force users and distros to downstream kernels.

You're comparing apples to oranges here. On x86 at least there was some
standardization when Linux started, whereas we still don't really have
that on ARM after so many years of efforts to standardize. I think we
are slowly getting there, but this particular instance shows that we're
not there yet.

Don't get me wrong, I'm not trying to say that we should just ignore
everything that's out there just because it may not be the way we want
it to be. On the other hand if we just take everything as-is and try to
implement workarounds and quirks every step of the way that's going to
also take away a lot of the resources that are already pretty scarce as
it is. I think it needs to be a reasonable compromise.

Also, there doesn't really seem to be a standardizing force in the Linux
on ARM world, so who's going to do that if not the Linux community?

Thierry

--VbfcI4OLZ4XW0yH2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz1MU0ACgkQ3SOs138+
s6E5qA/8CM4e1jf334G23zxkUibf2KzW/Wqwjvp3suj9VUih3kozt1yJQMbYGN0G
Udag6koIGccJFHL1nxHxuMqBDCaMNO9QYquS15TSver5P/7pfZv1nJV10NBGtGEY
kYBKOYR1u3lqSRexN/aoCHpYK16Lgh/O/RykEmcwyr5g+rW3PaKL16GHBb6k6XA8
PRjl1kZbuxDqs1CPWImCMU3a2TEeBm5UhZ4+ptQVIbhDnEvLlKX3zQe0f+TtUi71
Q5+Yfz/35WITVbWUmPQaIZB7MxeUjAbnyFwEDrHJoSNdUUyTW1jGsedc8t5nCHsV
BOLBMxr47UW3Xi3CppbsVgi4s1v7uq9Ez5/8laJ0tqTeNxWoyEi3z2WWkAjU4kuw
OiZM9WPx+VXvVTaogXyl8IVb3pym208YYprjBHaDWNGdzchbz8RWsWDkly/01eQz
/Z4GEZ/bpQaz+2ZOHPgin4q43O/Uprc+MWHuIYBfwZCZq3AJeGyRDz3NQqNrayAA
kj0iu6Es06BRvgrP/wXAAvQC5xFG9OuYuh5BCBTnURT41iuEdZMrEHViXyb3T6Nk
WDnnSgeqzksN6QdQveAxa5h/gq0myJXQLSctUPoHJBnaLZYlN+GvKuhzEQtZFQRK
GK+3Htl9EIU7vTBTX8M/MTl6xgfd+H26HU8+DHYKi2KFtWiJM9o=
=pXsS
-----END PGP SIGNATURE-----

--VbfcI4OLZ4XW0yH2--

--===============7062382260999842272==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============7062382260999842272==--
