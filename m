Return-Path: <SRS0=MyXX=DI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D426EC4727F
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 10:23:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645C320848
	for <iommu@archiver.kernel.org>; Thu,  1 Oct 2020 10:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dbp8rEtw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645C320848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C4ECC87332;
	Thu,  1 Oct 2020 10:23:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Wv4K-Uygbt0; Thu,  1 Oct 2020 10:23:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 87ACE87304;
	Thu,  1 Oct 2020 10:23:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B756C0889;
	Thu,  1 Oct 2020 10:23:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3C95C0051
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 10:23:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AB09387328
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 10:23:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z0+LfqWeqvie for <iommu@lists.linux-foundation.org>;
 Thu,  1 Oct 2020 10:23:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DD26587304
 for <iommu@lists.linux-foundation.org>; Thu,  1 Oct 2020 10:23:20 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id i1so5060173edv.2
 for <iommu@lists.linux-foundation.org>; Thu, 01 Oct 2020 03:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=W44N+jftb23F8yET1l0mgDLP8TLfoJw/pGspRNe/hHc=;
 b=Dbp8rEtwOtZh2Hqd91NKvBhxiYekNB+N8V4dhgG67qoDMr6U4mf3KVpSTA5KaQmZVz
 3V6id+m7r8/IED7pCRfNJkGWr/Ui7VRbB3dJiiN+4y6EHFqY89gMZclKcVC9jAfwLyCy
 h8oJBmtiVFOW7d9acrQH/NVJp6DSV6I5KaxDFqA1a4Epd2VspTJKp+X+NgwpYMWRzVVt
 4bcm67robzL5s2IJPESod3LZaxYjuK2ntObbWlulwG+5YDwKnz7g15KYMyfFdq09EjEd
 IlGrZqlhEg1zu10WASZ54gMzpmCFe0nFdnTlJmF7RTRK2e8Oij+2ZadXzsMGVzhf9uQk
 Oc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=W44N+jftb23F8yET1l0mgDLP8TLfoJw/pGspRNe/hHc=;
 b=uGwx1AqhYhqZy2Claq9mBqicCwrix4YZRB4bY452JgNv/1WIRZyCt5UgI3kmAO37r5
 NLEcAxyHjgXXIJ69vWzr6ALZRoIZPjZ8FwwwkaAWL+7VVpSPLekRcjjlyPFW+Vy+kHQQ
 nrKCrB4ZCij0zMxp8KdJSEfzUJbWGKaxS9hrCG18OAOAsOzTxyEf1vobBJ2jHoBymdj8
 XMaJa8ZRhB+kHyjUdeCYWMn2QDHo8G/ndQQfetiMj6Urvu2UxbQoAtz+Dc9uz+EowfN5
 54yC/rBie+EkuefnJ2I5Q/zsuIw+2ryjag7ZHM9D8AKZ+tTe9tu0MmyW7MT45hY62c8C
 Ffww==
X-Gm-Message-State: AOAM533WLFxHzE4dPOGzQHbV7R60FOcnP74zbWMMU/fuC+eQsEC+f36F
 CtpQX6UZFPC+oe+3we0eiYA=
X-Google-Smtp-Source: ABdhPJwiywR/H0Uuaero5sNwwrf1u3GhSmIp+OXclJ9rJGsR6f8CkFn4PJoF0n+C048JpmD4Tsq0Vg==
X-Received: by 2002:a05:6402:515:: with SMTP id
 m21mr7539182edv.348.1601547799181; 
 Thu, 01 Oct 2020 03:23:19 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id h18sm3764960edt.75.2020.10.01.03.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 03:23:18 -0700 (PDT)
Date: Thu, 1 Oct 2020 12:23:16 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20201001102316.GF3919720@ulmo>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <20200930153131.GB3833404@ulmo>
 <20200930203618.GC2110@Asurada-Nvidia>
 <13746922-0253-cda7-e9ac-2bd20bf1a17f@gmail.com>
 <20200930213244.GA10573@Asurada-Nvidia>
 <5945a63e-79d8-e3ae-ab53-cee8c220ac7d@gmail.com>
 <20201001012630.GA28240@Asurada-Nvidia>
 <72b11925-5857-8ce5-d084-cab01ca1b396@gmail.com>
 <20201001024850.GA28456@Asurada-Nvidia>
MIME-Version: 1.0
In-Reply-To: <20201001024850.GA28456@Asurada-Nvidia>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
 Dmitry Osipenko <digetx@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============2048549962799649618=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============2048549962799649618==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iBwuxWUsK/REspAd"
Content-Disposition: inline


--iBwuxWUsK/REspAd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 07:48:50PM -0700, Nicolin Chen wrote:
> On Thu, Oct 01, 2020 at 05:06:19AM +0300, Dmitry Osipenko wrote:
> > 01.10.2020 04:26, Nicolin Chen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > On Thu, Oct 01, 2020 at 12:56:46AM +0300, Dmitry Osipenko wrote:
> > >> 01.10.2020 00:32, Nicolin Chen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > >>> On Thu, Oct 01, 2020 at 12:24:25AM +0300, Dmitry Osipenko wrote:
> > >>>> ...
> > >>>>>> It looks to me like the only reason why you need this new global=
 API is
> > >>>>>> because PCI devices may not have a device tree node with a phand=
le to
> > >>>>>> the IOMMU. However, SMMU support for PCI will only be enabled if=
 the
> > >>>>>> root complex has an iommus property, right? In that case, can't =
we
> > >>>>>> simply do something like this:
> > >>>>>>
> > >>>>>> 	if (dev_is_pci(dev))
> > >>>>>> 		np =3D find_host_bridge(dev)->of_node;
> > >>>>>> 	else
> > >>>>>> 		np =3D dev->of_node;
> > >>>>>>
> > >>>>>> ? I'm not sure exactly what find_host_bridge() is called, but I'=
m pretty
> > >>>>>> sure that exists.
> > >>>>>>
> > >>>>>> Once we have that we can still iterate over the iommus property =
and do
> > >>>>>> not need to rely on this global variable.
> > >>>>>
> > >>>>> I agree that it'd work. But I was hoping to simplify the code
> > >>>>> here if it's possible. Looks like we have an argument on this
> > >>>>> so I will choose to go with your suggestion above for now.
> > >>>>
> > >>>> This patch removed more lines than were added. If this will be opp=
osite
> > >>>> for the Thierry's suggestion, then it's probably not a great sugge=
stion.
> > >>>
> > >>> Sorry, I don't quite understand this comments. Would you please
> > >>> elaborate what's this "it" being "not a great suggestion"?
> > >>>
> > >>
> > >> I meant that you should try to implement Thierry's solution, but if =
the
> > >> end result will be worse than the current patch, then you shouldn't =
make
> > >> a v4, but get back to this discussion in order to choose the best op=
tion
> > >> and make everyone agree on it.
> > >=20
> > > I see. Thanks for the reply. And here is a sample implementation:
> >=20
> > That's what I supposed to happen :) The new variant adds code and
> > complexity, while old did the opposite. Hence the old variant is clearly
> > more attractive, IMO.
>=20
> I personally am not a fan of adding a path for PCI device either,
> since PCI/IOMMU cores could have taken care of it while the same
> path can't be used for other buses.

There's already plenty of other drivers that do something similar to
this. Take a look at the arm-smmu driver, for example, which seems to be
doing exactly the same thing to finding the right device tree node to
look at (see dev_get_dev_node() in drivers/iommu/arm-smmu/arm-smmu.c).

> If we can't come to an agreement on globalizing mc pointer, would
> it be possible to pass tegra_mc_driver through tegra_smmu_probe()
> so we can continue to use driver_find_device_by_fwnode() as v1?
>=20
> v1: https://lkml.org/lkml/2020/9/26/68

tegra_smmu_probe() already takes a struct tegra_mc *. Did you mean
tegra_smmu_probe_device()? I don't think we can do that because it isn't
known at that point whether MC really is the SMMU. That's in fact the
whole reason why we have to go through this whole dance of iterating
over the iommus entries to find the SMMU.

Thierry

--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl91rhIACgkQ3SOs138+
s6E6uxAAqKaStX4y9vZE9JRQTPDn15vugDAmwje59SOKK7suH/5dTim+6O2iNNeF
Ywm8u9fn28Z6ImSJmqrFOykq+bRcASQNlZUfuX0vBuL1YZCDeqa2KnvyynMPAIz8
fV15348TJ+BFzSioeEerTo1G25axLZZWMsQgkXAnhrwxrZ3gjiHCZob6h5ZR827w
W6iDeVD8e9zwuxbMsnQChNMUJgRfPvwyOvaPSHz7kcJCojExlaFY/7Tr0xLUDIqF
mKiY2xCv0gocBqZqCZcExNXMCfrFCxWpI8OX+P0MAJRysR+NkSs0HZ0dHA6ZcLOZ
iOOgkybOI/a0bZ0GDF/tmcMLBHB96lcfVGKuWaGgoOBa18fWQQUKQ6ZbItNAH6v0
WPSdwnIOH1qdzZnY3Q72VFwvCBLfU6d4zgiVFg7FjbsfeKjtr8etz2hULgAXBjVr
BkaxoojPJsugsz2/z2RSu2nUyLjHT8zpemvu3vnhEIztvRmcmuPHqdcE3Gmo77oO
SHrxTZLDQu2p72+KK9IpV7KI9ujDum/+39Jbvv/TTVwY1IByyuSkw/WZ0Pt0STaY
W8SJfjphO3Bir7gPLMxm0q9K3pkePMAN9lo4y7N+bsiVHETjvFwM7zdcEd8zCyLd
EFo8jrw6U/ncHUGrX1FSb/9o3r13eP2VNe1mg5twuLruVJ2ns6s=
=Y2Wd
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--

--===============2048549962799649618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============2048549962799649618==--
