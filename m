Return-Path: <SRS0=royy=7P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04698C433DF
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 11:02:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCBC4206A4
	for <iommu@archiver.kernel.org>; Tue,  2 Jun 2020 11:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFzbey8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBC4206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1D22B20770;
	Tue,  2 Jun 2020 11:02:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O-jeFY0cQo5R; Tue,  2 Jun 2020 11:02:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B2ACD203C8;
	Tue,  2 Jun 2020 11:02:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 847CBC0865;
	Tue,  2 Jun 2020 11:02:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E161C016E
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 11:02:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D9333203C8
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 11:02:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4DrdBlmmlHMj for <iommu@lists.linux-foundation.org>;
 Tue,  2 Jun 2020 11:02:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by silver.osuosl.org (Postfix) with ESMTPS id A97D52044C
 for <iommu@lists.linux-foundation.org>; Tue,  2 Jun 2020 11:02:27 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id s19so9699928edt.12
 for <iommu@lists.linux-foundation.org>; Tue, 02 Jun 2020 04:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xgkzO+n+OaR1PsIu6Y5TBKCmjAXGMbznUyr7FevGw1Y=;
 b=UFzbey8vdoQPyo1fDkaxCPS4iGMpGAadkgSJ+erXoeY62mKWRUFz3hcNGgMViPlMt6
 AzBaW5OjYZjGi9C15/5z7rAJ1uJpuhFJUOF3YRIJIMtgrc0EiiAqy8rajx3d9DRgrW+6
 c+yAk50O9FTR3FzuAQoCZ9Zhij24F/OcZobrs2PYlhE4fGHPU0U0M8W9VaWrYheS0l/V
 YgCvWCcnm+Sff3ypUP2XaKhTcHribLwzfqUkmZEL9Ana/ZJJxd5YNCeKjYjUdamxQ6OI
 o7DduFgW4ufoeD0iWjV5a5+56uj6VBETLcgrjMolq04qsRiDBz9Cd64ZRq8ukwWJEzqU
 L1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xgkzO+n+OaR1PsIu6Y5TBKCmjAXGMbznUyr7FevGw1Y=;
 b=ZIyYmYAw9rVg1SLoo0ZtFsdZwi3rqeIzWn9wgRdZyqS40bWTqijAJ/iLtGHeID4rHg
 M8qBqbBmhF+QFTyKKW3fE2vfbwuXxYDDVHr5OZNwN3MDrfs5Ga75bvTctn0ff3Ng/G3B
 WVR02xvM0UPFvmANbMZ06I5LouowhGrSspxws1XZWvqXrNOFhqvZ9ZtEblqtm7d2yA4n
 XEpaDZsxQeLCmDJDCWryos8BQb3QrDv6B8HaaJY67YvdEFpYD61Ps5E9vuIUf5hPgVC7
 YiwQcfDP5khBQT0LdkmxDbvPpGoZmrKVlav/12V0SUVp9nOrpfDdHMPZeGRo9uwJ1bw5
 PnVg==
X-Gm-Message-State: AOAM530hYd4JJyy41WCFZTlol8xMAv5s51o1bmO6+Ak/RKwWjADMjpHc
 4DN+RRE8kkpFFvrYxMBIKng=
X-Google-Smtp-Source: ABdhPJw82udMbDApJ+beV5fEl+EF6IRgM2MG0DNUBeiIVsIjkESu71dUiOyq5Ln1AnZkuwapXb8bgQ==
X-Received: by 2002:a05:6402:1d30:: with SMTP id
 dh16mr25188393edb.302.1591095745784; 
 Tue, 02 Jun 2020 04:02:25 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
 by smtp.gmail.com with ESMTPSA id s15sm1375913edw.54.2020.06.02.04.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 04:02:21 -0700 (PDT)
Date: Tue, 2 Jun 2020 13:02:16 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Will Deacon <will@kernel.org>
Subject: Re: [RFC 0/2] iommu: arm-smmu: Add support for early direct mappings
Message-ID: <20200602110216.GA3354422@ulmo>
References: <20191209150748.2471814-1-thierry.reding@gmail.com>
 <20200228025700.GA856087@builder>
 <20200514193249.GE279327@builder.lan>
 <CALAqxLVmomdKJCwh=e-PX+8-seDX0RXA81FzmG4sEyJmbXBh9A@mail.gmail.com>
 <20200527110343.GD11111@willie-the-truck>
MIME-Version: 1.0
In-Reply-To: <20200527110343.GD11111@willie-the-truck>
User-Agent: Mutt/1.13.1 (2019-12-14)
Cc: linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, iommu@lists.linux-foundation.org,
 John Stultz <john.stultz@linaro.org>, linux-tegra@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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
Content-Type: multipart/mixed; boundary="===============2419862101818722996=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2419862101818722996==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2020 at 12:03:44PM +0100, Will Deacon wrote:
> Hi John, Bjorn,
>=20
> On Tue, May 26, 2020 at 01:34:45PM -0700, John Stultz wrote:
> > On Thu, May 14, 2020 at 12:34 PM <bjorn.andersson@linaro.org> wrote:
> > >
> > > On Thu 27 Feb 18:57 PST 2020, Bjorn Andersson wrote:
> > >
> > > Rob, Will, we're reaching the point where upstream has enough
> > > functionality that this is becoming a critical issue for us.
> > >
> > > E.g. Lenovo Yoga C630 is lacking this and a single dts patch to boot
> > > mainline with display, GPU, WiFi and audio working and the story is
> > > similar on several devboards.
> > >
> > > As previously described, the only thing I want is the stream mapping
> > > related to the display controller in place, either with the CB with
> > > translation disabled or possibly with a way to specify the framebuffer
> > > region (although this turns out to mess things up in the display
> > > driver...)
> > >
> > > I did pick this up again recently and concluded that by omitting the
> > > streams for the USB controllers causes an instability issue seen on o=
ne
> > > of the controller to disappear. So I would prefer if we somehow could
> > > have a mechanism to only pick the display streams and the context
> > > allocation for this.
> > >
> > >
> > > Can you please share some pointers/insights/wishes for how we can
> > > conclude on this subject?
> >=20
> > Ping? I just wanted to follow up on this discussion as this small
> > series is crucial for booting mainline on the Dragonboard 845c
> > devboard. It would be really valuable to be able to get some solution
> > upstream so we can test mainline w/o adding additional patches.
>=20
> Sorry, it's been insanely busy recently and I haven't had a chance to thi=
nk
> about this on top of everything else. We're also carrying a hack in Andro=
id
> for you :)
>=20
> > The rest of the db845c series has been moving forward smoothly, but
> > this set seems to be very stuck with no visible progress since Dec.
> >=20
> > Are there any pointers for what folks would prefer to see?
>=20
> I've had a chat with Robin about this. Originally, I was hoping that
> people would all work together towards an idyllic future where firmware
> would be able to describe arbitrary pre-existing mappings for devices,
> irrespective of the IOMMU through which they master and Linux could
> inherit this configuration. However, that hasn't materialised (there was
> supposed to be an IORT update, but I don't know what happened to that)
> and, in actual fact, the problem that you have on db845 is /far/ more
> restricted than the general problem.

It doesn't sound to me like implementing platform-specific workarounds
is a good long-term solution (especially since, according to Bjorn, they
aren't as trivial to implement as it sounds). And we already have all
the infrastructure in place to implement what you describe, so I don't
see why we shouldn't do that. This patchset uses standard device tree
bindings that were designed for exactly this kind of use-case.

So at least for device-tree based boot firmware can already describe
these pre-existing mappings. If something standard materializes for ACPI
eventually I'm sure we can find ways to integrate that into whatever we
come up with now for DT.

I think between Bjorn, John, Laurentiu and myself there's pretty broad
consensus (correct me if I'm wrong, guys) that solving this via reserved
memory regions is a good solution that works. So I think what's really
missing is feedback on whether the changes proposed here or Laurentiu's
updated proposal[0] are acceptable, and if not, what the preference is
for getting something equivalent upstream.

Just to highlight: the IOMMU framework already provides infrastructure
to create direct mappings (via iommu_get_resv_regions(), called from
iommu_create_device_direct_mappings()). I have patches that make use of
this on Tegra210 and earlier where a non-ARM SMMU is used and where the
IOMMU driver enables translations (and doesn't fault by default) only at
device attachment time. That works perfectly using reserved-memory
regions. Perhaps that infrastructure could be extended to cover the
kinds of early mappings that we're discussing here. On the other hand it
might be a bit premature at this point because the ARM SMMU is the only
device that currently needs this, as far as I can tell.

Thierry

[0]: https://patchwork.ozlabs.org/project/linux-tegra/list/?series=3D164853

> Could you please try hacking something along the following lines and see
> how you get on? You may need my for-joerg/arm-smmu/updates branch for
> all the pieces:
>=20
>   1. Use the ->cfg_probe() callback to reserve the SMR/S2CRs you need
>      "pinning" and configure for bypass.
>=20
>   2. Use the ->def_domain_type() callback to return IOMMU_DOMAIN_IDENTITY
>      for the display controller
>=20
> I /think/ that's sufficient, but note that it differs from the current
> approach because we don't end up reserving a CB -- bypass is configured
> in the S2CR instead. Some invalidation might therefore be needed in
> ->cfg_probe() after unhooking the CB.
>=20
> Thanks, and please yell if you run into problems with this approach.
>=20
> Will

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7WMbMACgkQ3SOs138+
s6FS7hAAjnzmOGg8TMxb0NhiGM6QcXO3Js8Tej1WhHH/3E6vxv+RV6kunncGhxwH
Iw3wyGnqbwRjjzCdM+tgojDnyi+eEeb5961WbNoEmWZFJtk2ARhOxbjizxbH8ZNo
GZnKiYKHRk4VamcBxHZGgzRyhxAi1GPYGgoCmDbf0lzkvX3fydaurT3UBtlcxUC0
rBRIZppeNMFqzyyX1derKVtrLrsSIlZtdIl08tPvD+pDdpIoglxx3+JRI0oO6ESU
4uDUHipo8Ww1uRzEnEwWi1RAOAtl+M17QGlAl6OF33N2+m7bvHcyAlTYJDzksNHB
jNd8q7obRseZkGsUdbmYkW7ZJDYFa6ygQr2iEUQuGoqcQKY4eQcxRCdM2GsgzLzv
YpIFRsSfuRK1f/+YmanGqPLP+K0LQ1fP/QxllEuk+taQyFmEYn27VwWnGZBNT/cm
j5RZWrReSHcRDCDolUGlBAoWsqIOrk2qYH+z3gWBcaK+YZ+8uEZldXmX+RXNq/IX
XKKkYBioF5UnYhx0u0AB964vGKLYnalp5ajSyEWybbWFLaj/SYdLTShmz3bffy0L
rEldzwfiSS3uhmtAjSFOAhjHtnr1ExCXxrMiyGP6XEeOOfmQCe6fOOuM1GSytIaP
AlC/E7XjsbPeVjUvYffk0a0lK7x1WMuPYOq6RBVVACkVvH6G8Uo=
=0kMT
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--

--===============2419862101818722996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2419862101818722996==--
