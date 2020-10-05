Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D6BC4363A
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 09:51:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38BB620578
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 09:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulY7zWOi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38BB620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A547D8639E;
	Mon,  5 Oct 2020 09:51:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HD-Wrn14+pPc; Mon,  5 Oct 2020 09:51:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BF6548610F;
	Mon,  5 Oct 2020 09:51:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 882ECC07FF;
	Mon,  5 Oct 2020 09:51:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FB44C0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 09:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3BC2F85593
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 09:51:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kbb3utNM26yR for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 09:51:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7874A8532B
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 09:51:36 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id dn5so8581172edb.10
 for <iommu@lists.linux-foundation.org>; Mon, 05 Oct 2020 02:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xVMDpuwSWx9cJIlM4tDMXRAB/KMvl7kDIIAKzdiSpb0=;
 b=ulY7zWOimlyfZyK6YnQOs4cmOYoADYddLaILjK5pufzyA382zlw9rdNAX+N/Pd7H1X
 sfKQuvCMKDvRdReB3myjSx/7m9OcGYZKTJM8qbB5kWKcKsvbV3Q/OIdaUgUBVf6GPgrH
 QZewG+v46kGHkOvRzctMTv1Qq0i3KqOo1dgLJql//ClV7OI06UJSBYqYaVbLzdumeRAo
 luod2TT0oee/DTHpVwf6bKcUZpR7UtCKceoXtkZXSaB4fmtTsP8VpJSpqeC4kVSltyja
 ANR9ooc77082cj4prqPq6KKkZWMYmWCiukGuaPOnevPY3oaAj/z547w6uBiobxnMq52c
 Km+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xVMDpuwSWx9cJIlM4tDMXRAB/KMvl7kDIIAKzdiSpb0=;
 b=hMVnyRE+E1XM6Ypyz2wCLY6BBYobVlSn3r8fYTxRHCP7Y/TKBsHGdTfk0bDWy2pKax
 BHK9jQjZbCWQhuvTFUEClj7ySioUPrhJOdhDFLL8tcFHbO2YAyFG8EuK7Vd5CAVVl9YO
 OReNGtXiH8EUAyKiQqMJbLuleq52b8mq6ouYus/JjKBwLIPayY79LJ1Q++pu+YKLLo/h
 g0KGS/8em5pOvZy0NoXPQKlu2vIBnBWzu25RJ0wHEV1RlLtSd3I7/qbnECv7SoSsfxZ7
 BWhVuKOu/KPYmx3BbnDLUbFGFfGAhO6X5VhMlB5O4rnlM1mSBmNe/XlkOwWAlLHPoU80
 xPEA==
X-Gm-Message-State: AOAM531Q40MT3w5BoxjcWyW0UoiBilbVRhi2EeJpGNb5MQC57ocyFhHY
 Y7/W08k3OK9Z2E1WmiRM1SU=
X-Google-Smtp-Source: ABdhPJzBrcM6KDwh5g5wHr/FHftugh84YRErwAwekwNfMW9hAWTj3dDVrLQQ44bVLCxmS+IBaZaP3Q==
X-Received: by 2002:a05:6402:b68:: with SMTP id
 cb8mr16580359edb.350.1601891494997; 
 Mon, 05 Oct 2020 02:51:34 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id k18sm7758003ejk.42.2020.10.05.02.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 02:51:33 -0700 (PDT)
Date: Mon, 5 Oct 2020 11:51:32 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
Message-ID: <20201005095132.GH425362@ulmo>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <b1a195cf-0127-0531-f6d1-835367511f57@gmail.com>
MIME-Version: 1.0
In-Reply-To: <b1a195cf-0127-0531-f6d1-835367511f57@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org
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
Content-Type: multipart/mixed; boundary="===============1808847404701857817=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============1808847404701857817==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a8sldprk+5E/pDEv"
Content-Disposition: inline


--a8sldprk+5E/pDEv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2020 at 05:22:41PM +0300, Dmitry Osipenko wrote:
> 02.10.2020 09:08, Nicolin Chen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >  static int tegra_smmu_of_xlate(struct device *dev,
> >  			       struct of_phandle_args *args)
> >  {
> > +	struct platform_device *iommu_pdev =3D of_find_device_by_node(args->n=
p);
> > +	struct tegra_mc *mc =3D platform_get_drvdata(iommu_pdev);
> >  	u32 id =3D args->args[0];
> > =20
> > +	of_node_put(args->np);
> > +
> > +	if (!mc || !mc->smmu)
> > +		return -EPROBE_DEFER;
>=20
> platform_get_drvdata(NULL) will crash.
>=20
> > +	dev_iommu_priv_set(dev, mc->smmu);
>=20
> I think put_device(mc->dev) is missed here, doesn't it?

Yeah, I think we'd need that here, otherwise we'd be leaking a
reference. Worse, even, mc->dev is the same device that owns the SMMU,
so we're basically incrementing our own reference here and never
releasing it. We also need that put_device(mc->dev) in the error case
above because we already hold the reference there.

Thierry

--a8sldprk+5E/pDEv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl967KQACgkQ3SOs138+
s6EZ4w//XClEGoJOj1S9ALPjYnZ7yQN7pBPfwPv2qNVwYwkSXvNIRhLa4AfazRm5
DCJCelfgkYONrrtuxyUSzatdpBNFuRFVKDUy3cBuZd/yXaDg83AXc3LWR99jKcNZ
LWuszo33+o7JSwz2rlGBfOWG/pEIZ3ffkENDhsIFbuff0dyIpHcB6t4Bk9Oucaag
cbQhJkfVYZXBbuz0qolfVkoxzbsYJ+HkWyYR6C2iFa46W4ed/uPAWj8y12nAJhMk
rEazHONfPq5T2kup+r5rLMJgt+jCZ7ofsuR+PK7g5S6FIxyF4S3QTFmRvh7uFBSs
JsmPElXPTcPFhM70fLvN/HkZjsGyJiLGfRHfcvuibqozGdTGY58ImpNFBrINRUGR
AwralPobbGBG+ER7MctmIENYcAODTJLAldodbOcrx7wGWESwsdBg2Vp2Uzn9iI8X
IGqtswrhSCZR2dJv6cykZwj6zFrpFWAuKAXZTGSO8qIxIV7QX1Y+CYm0nDg3iwek
KEJJAtwuhgNQ/g15SBn9Sq8JqUPZ+0e5TCoO/YyyOalvisC2nWb3IJYsXy+24sz2
lBpXygBpxuv+wQNRmU3cEWlwOgekaSuWXMoHGV0/i70llsuX5UWrO+rXVAReM9k6
4NUFGUgNQGBNygabucLpAatMEcFal1rF72zXio8eFig0ooLWimA=
=ny5U
-----END PGP SIGNATURE-----

--a8sldprk+5E/pDEv--

--===============1808847404701857817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============1808847404701857817==--
