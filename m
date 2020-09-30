Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13426C4727E
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:06:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81AED20789
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pq1CulC8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AED20789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id ED36E8628B;
	Wed, 30 Sep 2020 16:06:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DqFtcckeK8dg; Wed, 30 Sep 2020 16:06:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B921685E0D;
	Wed, 30 Sep 2020 16:06:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 987C8C0889;
	Wed, 30 Sep 2020 16:06:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1E1BC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9895B85DF6
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:06:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v39TFTEX4cFU for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 16:06:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com
 [209.85.218.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CEC9785C67
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:06:29 +0000 (UTC)
Received: by mail-ej1-f66.google.com with SMTP id a3so2829811ejy.11
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=NDiay5Y7h+SHyza+gL5HDWZkjBPPCDcnbUKJ/AtUF+4=;
 b=pq1CulC8RWyAVCTp6GZippCf/6lEsda7nW2SZs4EhNYKXZYXmiGsLFQiTnFehZiBXa
 m7ZHC6pJrb7Q+EgDSythiLTfolFwqZKpsvLJdJYpWdojQVLE3sfj/pz8mJfC5VAIzX/K
 PYyBjR3r7kzN4MbCD9ADytGl16ElKsbTSWR1yMx1fG/nnhN5ds77vCQESOffIYVjEGlS
 smSGuvCxrJDWl1nf3lOOQRHJWFMXA46xe7y6Zi8JYiQK9Z42rE+e1OFUpRqYPYGYQ8bS
 GOPO76shdPu2S7WRTMjwOhvdBUbmY0bNanqOtfbn2plGYrhY0jit2jTtHuDx+t0y1YkO
 rxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=NDiay5Y7h+SHyza+gL5HDWZkjBPPCDcnbUKJ/AtUF+4=;
 b=MUtKBj40ZHG5Rm5p48KbTZdwe7jAvAJjSR48M6YQ4wNh4WtxsPIoTolpxsq0VAEOzS
 ghh5VxbkFGyd91HXTG6EE3Q56fQoBm5LF6aC1x7xs6vbVK5jnnsMVVdCd/jp5UQbTwQG
 MyIhAjQF+u0O5h+VQlMjHlpixFActcTAiityx+dn6Zao/36/wcrzWEpxNxQc/Ir2SuE2
 Uwg1Nb8Q0kv+lkeuvS12y3jnX2dcICyyAM5M7sNEyMUK4BV38zBjfFGL3G5N2KBp67ge
 t0FCKaAO63CIBk3GrmoU2QQsJkqacoTchtwWcqYsym3WkRF/S8afbiTvR4WbzjfvY5kX
 RDEg==
X-Gm-Message-State: AOAM5331p0YDqHKfQ2erWpQXRAyBuWTD/zCo/CGN5YmnyPk5+F9ETlX2
 n5t+w213bAMAXxcAXderkcM=
X-Google-Smtp-Source: ABdhPJyrvVrcQq2hFotX3BTY6j708efNUE4w28URGOKT7Lye6zyw4DN2Tcxgpskpi3WILDqBO2f5Ww==
X-Received: by 2002:a17:906:1fd5:: with SMTP id
 e21mr3698133ejt.349.1601481988391; 
 Wed, 30 Sep 2020 09:06:28 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id k6sm1910354ejr.104.2020.09.30.09.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 09:06:27 -0700 (PDT)
Date: Wed, 30 Sep 2020 18:06:26 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20200930160626.GD3833404@ulmo>
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-3-nicoleotsuka@gmail.com>
 <20200930153131.GB3833404@ulmo>
 <ece615ad-8d6b-96ae-d8b4-9667aef17281@gmail.com>
MIME-Version: 1.0
In-Reply-To: <ece615ad-8d6b-96ae-d8b4-9667aef17281@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============4374840309789745335=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4374840309789745335==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2020 at 06:36:52PM +0300, Dmitry Osipenko wrote:
>  I'...
> >> +	struct tegra_mc *mc =3D devm_tegra_get_memory_controller(dev);
> >> +	struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> >=20
> > It looks to me like the only reason why you need this new global API is
> > because PCI devices may not have a device tree node with a phandle to
> > the IOMMU. However, SMMU support for PCI will only be enabled if the
> > root complex has an iommus property, right? In that case, can't we
> > simply do something like this:
> >=20
> > 	if (dev_is_pci(dev))
> > 		np =3D find_host_bridge(dev)->of_node;
> > 	else
> > 		np =3D dev->of_node;
> >=20
> > ? I'm not sure exactly what find_host_bridge() is called, but I'm pretty
> > sure that exists.
> >=20
> > Once we have that we can still iterate over the iommus property and do
> > not need to rely on this global variable.
>=20
> This sounds more complicated than the current variant.
>=20
> Secondly, I'm already about to use the new tegra_get_memory_controller()
> API for all the T20/30/124/210 EMC and devfreq drivers.

Why do we need it there? They seem to work fine without it right now. If
it is required for new functionality, we can always make the dependent
on a DT reference via phandle without breaking any existing code.

Thierry

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl90rQEACgkQ3SOs138+
s6FhgQ//a+/NTVtKzfGbpKqEQ0N9/dM3xFZWr3Yuv1vue8BU4+eVrXxhSASrsa9x
c4740hqylshqqqPxmxYYhwBg1j5RK4UhGWPjZ8E0R59sKb+TJHhk4ij/jfu9PM9d
XD3LV5CBqkZsDQ6mQFbOWc8DK0CX9+XyH/tWevtlZtee0JUSSLcGj3Qc7BoZK2F0
pyL3bA+F6CyJ1tocb+EfaTxDvL9XlL5rg8ubZRKumlOdqEG8P5w4w8g1uxUzGBqF
g8uz7qmHlE5XRvIMHsulkB3SG6gXn7TbexAcWD0CG/yRk6UnKA4rRdhYWoFJeVkT
hUVV28gJk3nPvLKoqX5zkzIAhofy2s5YkhanPe8j5batn1ok0ixIfQbHyXBbrmLV
ZCWbHXRiPb0FZmpbiX/EBjmT697mI45gOvrmhcMpEMhFMZV8KaBll6tGQtOOGM6/
17DyfIe5vrYMvdv1TgUA3csAkd7DYPM4SpOOOiXYe8Uz7a+fxJXcfAga3gG/H+t2
4ZSnfxzHYNNJIq7QHyhoDHgO0EjlnF6PJ6oPRy5tN9NKG+igAux0eTgS5gMDrZgC
/DjFOh6B67RbhlVt3JQeqHqUFM0j8MD/BzTqW5A0vBXs0X+5eHK+G4BEBXE0M2hs
Gwq1NExwiMlZwueBUmGH6hHeiH+MySwoWu60U//ez1dUZkkdPeo=
=SlyZ
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--

--===============4374840309789745335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4374840309789745335==--
