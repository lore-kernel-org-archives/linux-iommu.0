Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B156C4727E
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:38:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5DDA20888
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rRfHylci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DDA20888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3E1EA8721C;
	Wed, 30 Sep 2020 16:38:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i1YR8rvvMlua; Wed, 30 Sep 2020 16:38:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6137487214;
	Wed, 30 Sep 2020 16:38:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F3A8C0889;
	Wed, 30 Sep 2020 16:38:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0291C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:38:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A847C84070
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:38:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xeWJoepqUazo for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 16:38:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9659C83F22
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:38:46 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id i1so2586643edv.2
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lK/kHzAgP4lolcSnmUV2y0FUAwU87rxBn1hTaVebsi0=;
 b=rRfHylciErSD/kdKAs0tNs686ORfPKWBVSRfxb9WoptD35zrcER7xtRiowQrXRE6Rb
 v/0AVfrRUy26xaGjAVMyEqVv+ATUHZ/IiAGL/C8WybBQBm5Ymk/FyYknU/tTIO9T3OGi
 eJKP1htjq3XBY/fBLnE9AyqCZkZNrcKKAviusBMkLKJWdiNSEwoX7ZBJVSk4o14iINPf
 CY2eOavaqUX6XLYE9bo9G4lsvtKS7f0uaIXcOXIK9APLqIBnREarQDEjm38YI9hCoulU
 HJ0ch1qCUMf6IlpJaoKVfY1tAnRL7dZTPgv9FVzKTWo3IASIBTL4+uhZJkaQ73lrmtJc
 k6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lK/kHzAgP4lolcSnmUV2y0FUAwU87rxBn1hTaVebsi0=;
 b=LpXh6z4N9rCCPVsXug+JOw5zxUo0gZrgqdQW+MCZh/3HCAW3eZDV2Vgbz/bsDffcc3
 C2w6Sln9601LW42/yrWAzgFLnn5QiW5qA/oRJLHLVyfDMVmFgZNIzLam5ABIU23xX/TJ
 okKbdELERuNHK6d6e+I9YwxesAOOOxRP32sW+RCiTNQelWyJKW2gkSuKXsedO+euBoNk
 r10Chk0sqPWaDP5Ph/jht3IL9rncGJ67Q1jC5hgSRRDPIZ+/8fx3Ac2MCsvnSpxOZbqL
 lHVR+SC0d8HPpi6VhFBFaSRP4Tq+NTVLLoIfTbcDb1Cz7k8Rqhhi/ToiYAPHv/6sB5t8
 4fSw==
X-Gm-Message-State: AOAM530wu8MvVRH9TIAORdYRE+YxbjUnuYt6Vhx66cUsPVlWgN8jlA7T
 +r7XkBTajJQpqn8sY21F1zs=
X-Google-Smtp-Source: ABdhPJwGsiRpgc59xDLvzK22/4jMNI+uTslhTdq+f9N0m8Bqg5lwYAja8fK1QKXjcoYlQY9LsS5YaQ==
X-Received: by 2002:aa7:c154:: with SMTP id r20mr3687532edp.337.1601483925053; 
 Wed, 30 Sep 2020 09:38:45 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id m6sm1057236ejl.94.2020.09.30.09.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 09:38:43 -0700 (PDT)
Date: Wed, 30 Sep 2020 18:38:42 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 1/3] memory: tegra: Add
 devm_tegra_get_memory_controller()
Message-ID: <20200930163842.GA3852280@ulmo>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-2-nicoleotsuka@gmail.com>
 <20200930152320.GA3833404@ulmo>
 <ed7b4375-d06e-2750-e6fa-603ef2b60d36@gmail.com>
 <20200930160355.GC3833404@ulmo>
 <839df5d6-513f-3d77-ba5f-a1afe5d0883a@gmail.com>
 <20200930161503.GF3833404@ulmo>
 <29a989b3-a8cc-5c1f-ba12-47ed0d667e8e@gmail.com>
MIME-Version: 1.0
In-Reply-To: <29a989b3-a8cc-5c1f-ba12-47ed0d667e8e@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============2821963192391146838=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2821963192391146838==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 07:26:00PM +0300, Dmitry Osipenko wrote:
> 30.09.2020 19:15, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Wed, Sep 30, 2020 at 07:06:27PM +0300, Dmitry Osipenko wrote:
> >> 30.09.2020 19:03, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Wed, Sep 30, 2020 at 06:53:06PM +0300, Dmitry Osipenko wrote:
> >>>> 30.09.2020 18:23, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>> On Wed, Sep 30, 2020 at 01:42:56AM -0700, Nicolin Chen wrote:
> >>>>>> From: Dmitry Osipenko <digetx@gmail.com>
> >>>>>>
> >>>>>> Multiple Tegra drivers need to retrieve Memory Controller and henc=
e there
> >>>>>> is quite some duplication of the retrieval code among the drivers.=
 Let's
> >>>>>> add a new common helper for the retrieval of the MC.
> >>>>>>
> >>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>>>>> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> >>>>>> ---
> >>>>>>
> >>>>>> Changelog
> >>>>>> v2->v3:
> >>>>>>  * Replaced with Dimtry's devm_tegra_get_memory_controller()
> >>>>>> v1->v2:
> >>>>>>  * N/A
> >>>>>>
> >>>>>>  drivers/memory/tegra/mc.c | 39 ++++++++++++++++++++++++++++++++++=
+++++
> >>>>>>  include/soc/tegra/mc.h    | 17 +++++++++++++++++
> >>>>>>  2 files changed, 56 insertions(+)
> >>>>>
> >>>>> Let's not add this helper, please. If a device needs a reference to=
 the
> >>>>> memory controller, it should have a phandle to the memory controlle=
r in
> >>>>> device tree so that it can be looked up explicitly.
> >>>>>
> >>>>> Adding this helper is officially sanctioning that it's okay not to =
have
> >>>>> that reference and that's a bad idea.
> >>>>
> >>>> And please explain why it's a bad idea, I don't see anything bad her=
e at
> >>>> all.
> >>>
> >>> Well, you said yourself in a recent comment that we should avoid glob=
al
> >>> variables. devm_tegra_get_memory_controller() is nothing but a glorif=
ied
> >>> global variable.
> >>
> >> This is not a variable, but a common helper function which will remove
> >> the duplicated code and will help to avoid common mistakes like a miss=
ed
> >> put_device().
> >=20
> > Yeah, you're right: this is actually much worse than a global variable.
> > It's a helper function that needs 50+ lines in order to effectively
> > access a global variable.
> >=20
> > You could write this much simpler by doing something like this:
> >=20
> > 	static struct tegra_mc *global_mc;
> >=20
> > 	int tegra_mc_probe(...)
> > 	{
> > 		...
> >=20
> > 		global_mc =3D mc;
> >=20
> > 		...
> > 	}
> >=20
> > 	struct tegra_mc *tegra_get_memory_controller(void)
> > 	{
> > 		return global_mc;
> > 	}
> >=20
> > The result is *exactly* the same, except that this is actually more
> > honest. Nicolin's patch *pretends* that it isn't using a global variable
> > by wrapping a lot of complicated code around it.
> >=20
> > But that doesn't change the fact that this accesses a singleton object
> > without actually being able to tie it to the device in the first place.
>=20
> I don't think that the MC driver will stay built-in forever, although
> its modularization is complicated right now. Hence something shall keep
> the reference to the MC device resources while they are in use and this
> patch takes care of doing that.

It looks to me like all the other places where we get a reference to the
MC also keep a reference to the device. That's obviously not going to be
enough once the code is turned into a module. At that point we need to
make sure to also grab a reference to the module. But that's orthogonal
to this discussion.

> Secondly, the Nicolin's patch doesn't pretend on anything, but rather

Yes, the patch does pretend to "look up" the memory controller device,
but in reality it will always return a singleton object, which can just
as easily be achieved by using a global variable.

> brings the already existing duplicated code to a single common place.

Where exactly is that duplicated code? The only places I see where we
get a reference to the memory controller are from the EMC drivers and
they properly look up the MC via the nvidia,memory-controller device
tree property.

But that's not what this new helper does. This code will use the OF
lookup table to find any match and then returns that, completely
ignoring any links established by the device tree.

Thierry

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl90tI8ACgkQ3SOs138+
s6EKNw/+J/VfzEF447KR0hgUG9h0PaTreKUUBO/pGai7NlCCXpgKtzFsW8tXWKJu
nf/lvvcawYFmFF/JI1aAfe9urmkcxa1/mKOPzzOVtpnwL1b7e2gKaDxCDP2I7vU7
DqhCKbmAFYV5gA3pKrUmpukn+1CcIUNIgHZIi046Clr4Ipr7gtSh0HmQpdNs6T22
K+Y35u7evOOk1r+UPaXFNQVm4W+C7sKiCpYTbVnyZwV0Skp6GKBwypBp1Fi3g7TN
abeo2M+ydxVBDRD53459CDVVje4TLUnn67cW3Aoudk2kvfPJBdM3FQjHD4aVYOxR
DmL9XnulUrUM066T4HZ9mfz8b5dOuZMbOFEe/WbFoSOmpDTq5BeW687jcdMgMd79
Ne8Qkd4BTG8KJoDTdxYM3BX4Zl1PqkXh1hrrHDq3VBTFRayJrpi528lcu0crqxda
tFvuuoHbHSDKuDLxz7LH88RTxjCHFT6T/5cK08FxiUOjFIE2YvohV7ji7uga89Tv
KyjFddYmtTHM7gkZofuAFxXZhJ31KCO5PpD2ScIFNjZJs8tqF11a6vodxMEVMCH5
ThjT7sFbOcckn1fQxW/zfi6JV3tFP/OvOcXDtn+JAR//aEGheAxw/78dGAe6SGyZ
FTA2JxYo3BGby4YBAl/SQVh0nuAJ1pe6Jxzx5W6QZ5vTK6Im5Zw=
=ngRF
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--

--===============2821963192391146838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2821963192391146838==--
