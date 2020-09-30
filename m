Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C508C4727C
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:10:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE595206D9
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 16:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GauHFVbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE595206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9CC522107D;
	Wed, 30 Sep 2020 16:10:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KERZW9SN6fRN; Wed, 30 Sep 2020 16:10:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4AA52204BA;
	Wed, 30 Sep 2020 16:10:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C54AC0889;
	Wed, 30 Sep 2020 16:10:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B365C0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:10:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 45407204BA
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:10:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YPs6ERuYQV27 for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 16:10:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 4FBD1204D8
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 16:10:37 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id q13so3620020ejo.9
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Gz8YbIcBLxDIo/9xfQsLMToZ+yZY22BQ/9LJJe3pu9A=;
 b=GauHFVbinz4XzRFmxPc5VJod/LYJfLbRDipc4McYlUB3hVnqVjURSXx6M6nlzYN/tk
 P4R3ExcmAE5zADSbavU6moHxKHs5Zs5nNEAlMCUSgsuueYepEwZjDnb0qfKezrv2xyLX
 fv7zVccFO3rZy3IcASGz3zg6dvDtPYJuUKzUMsO0H1d+Zmh6HP2vkPZqWWJezskG6EJu
 s0GdeeePVwdTChyw807eP2FqHWBwQQcdjsh1GRe2h6TMeMhC4JFyhfWXzbanGZtmPB12
 kQIWfBSCtqLGBVmwluh/Ac0MwR++/ousPynRcxoADcSBf0VXi0gXufw9QRh/FbxmoHXg
 8kDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Gz8YbIcBLxDIo/9xfQsLMToZ+yZY22BQ/9LJJe3pu9A=;
 b=VCePygnA681SLXGTVrkCLIqgz/rb/zy+C2yXoNxYieKqhWvbIsW3hNUHjXr7Bs+B+q
 KTJctf+uiSTvW4hpBGXWxkhR6zqiS+orvldfnQ9/0vHt3Q42u6Rp9GWxAiZkNuWCMgGq
 SK+Lvd6IdluVj4ki4iA3RlaI9VwZJRGfa9NyfOqwSU+OlMVpP7ByLbOUpgacbt9vTIr5
 MGNft1gSRRP4cCUSSeTyssoTjjaiaxTevVJ4DFTWyqZ7YQAeIdZcvnitiIMSofSfuVAq
 PFLIhZkXRXJmIkDN5tZbO7vdZkC8qsUiOhDiMyeNDZtbTQkzff7AlpCGHcaUANqsjIFf
 J00A==
X-Gm-Message-State: AOAM531d2tqcpgtm1+9GnKAIqjfbyaVzwtNU0VSfB7hTPpi6BViW0S0v
 dS/WKgn5YPFT8MVqKIuDFF4=
X-Google-Smtp-Source: ABdhPJxRJM6WzC9xtFLvQGjemfFPSb2It62oOg3Yc7abBDEludDbD97OPrqcFjC8ZWcZWxYiAPDzRA==
X-Received: by 2002:a17:906:f11:: with SMTP id
 z17mr3697701eji.88.1601482235786; 
 Wed, 30 Sep 2020 09:10:35 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id l26sm1913672ejr.78.2020.09.30.09.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 09:10:34 -0700 (PDT)
Date: Wed, 30 Sep 2020 18:10:33 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20200930161033.GE3833404@ulmo>
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
Content-Type: multipart/mixed; boundary="===============4418266151499684867=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============4418266151499684867==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Content-Disposition: inline


--brEuL7wsLY8+TuWz
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

I don't think so. It's actually very clear and explicit. And yes, this
might be a little more work (and honestly, this is what? a handful of
lines?) than accessing a global variable, but that's a fair price to pay
for proper encapsulation.

> Secondly, I'm already about to use the new tegra_get_memory_controller()
> API for all the T20/30/124/210 EMC and devfreq drivers.

Also, this really proves the point I was trying to make about how this
is going to proliferate...

Thierry

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl90rfkACgkQ3SOs138+
s6HL9A/+Ol+FddqakzBkR5ybYmsPeEUyPF5dwncQF++WGcerrvQx2DTXQYpIoGHl
LnUCBYK+np/rcAvNEScWYVUfMD3BslmIHjpAzhza004NLLtz0/m8EUBxfaRxA76i
GRZbr0SEXrIPWdEFwx6gSQMnZvG7+tGsQSybMi+vWWUCItxVYLar9XBg3PLhcZoP
5WURiPyas+HF4wuNzT2e100vACoLos2DexhIRnxGCF0tkDRsBFCEN++0XfWTrBGh
NxdIsX9O6/HYJEZ5ncbP5hUYJ+vnw0xs9EYKXyQsB1P0zxm5dmBsZEnsYm5FvB7o
qC6NK2Aje5ovdIDjJCwNb84c4B1/jW1Q6e7wFZuoO9i3cacbchucH96j5qPM+1Wy
J7gabVPsv/qZ3MDHA+9s1Bs899QWp5gs1NvLu509DcHCtEFfMexG0tnZUDeIB4Fb
wqDhGpfcil6pRL5Q5wvswnKJ+Zji9x/CwbgIu3V1R1ehHOPnOPyy9EjhqvJm7RKE
tvzHLAi4/LXgMBhe1dvO8RE7Ya9c9qGQm0QOi+r+jNWHIsEGI9By2u7kzHKOqBx0
PZctFqhKFVUmSftXv2xp5Gx2hsd+7YIKesZf74lswWCh3c2Sphrb274O3uPHR1qa
ean/rNOn65fNW95vSsOpT9NQ1aJWk0Du8xx7Jv7BZVRZp2KJxtw=
=n10A
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--

--===============4418266151499684867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============4418266151499684867==--
