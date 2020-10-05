Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F8FC4363A
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 11:15:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32E520774
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 11:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1OflwmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32E520774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 704EB86123;
	Mon,  5 Oct 2020 11:15:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ylGE45xqXpuJ; Mon,  5 Oct 2020 11:15:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8E78886055;
	Mon,  5 Oct 2020 11:15:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 805DFC07FF;
	Mon,  5 Oct 2020 11:15:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDCF4C0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 11:15:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BC91F85948
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 11:15:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ft4V50mlxXjn for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 11:15:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8D1A78591B
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 11:15:51 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id e22so4473397ejr.4
 for <iommu@lists.linux-foundation.org>; Mon, 05 Oct 2020 04:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=G52tFSPPaeht3TFoNGYf73lcJsIZuvlxHBvQMW/kYTU=;
 b=O1OflwmKg/lBEsgt/JHLEvrfnvNzpwEXpE8fFMtuWYxf+A+RoxndDbsn5LoJWd76rZ
 0+vn8POURTdeC328btpQRpm4nXLSo4u/idERBuAzHc7XKlnnmRXNmNTGhULHWOoCsmho
 7i4XbzZ6uDnEcI5uWCZ6S/iacGeL25pv66yo/HYTCsclb9ngKq83jIVhDpB6n60M71l9
 /BdQKt1toZpEgDvfMOItPNPlOYKDmmnt3bNQIzcg0Yvrog26m+a93iIkOx6KQHUjz8DJ
 A87qg5V4LoOr4ik/fa/lswadxMLyswrdG4FUHt+aP9ZIuExI5Leek0XL+/AXNwjMYyWO
 WRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=G52tFSPPaeht3TFoNGYf73lcJsIZuvlxHBvQMW/kYTU=;
 b=rIN/OgsQjY3lOaw/CbtHAAtwnJM8jVy67g7uYfScdPBU52feVGByNQ9NBvSfNBr9zY
 f0WKjftf2IGPib8oUgJPo3umeRL6VFgPjBVJiE2Y6ecsWkDnuIHLqYZerHZzu5TuaxaM
 /lWQxxLY61g9VWPwn/exm0jfEaF8Od2gNFzmFnJl96qFFZG1ofTO5jIoYDKaq9hRgpj0
 xtd4qO/QgzDyemJXcZqs5dagFSwPgq7kOL3sfTl/VWed53MirfF4v/plb8pYFBaWsBTa
 wdZChA9dXuhbnDNQirl1D86LPzX4WMWJq/04dGXm3b6ApGMLnqeDacSaF7JSR/5/olBb
 YX4w==
X-Gm-Message-State: AOAM533EZ++aL34HiMWsU+onYYE7W3gSfKedXFSauRD6kJad/tHjAU+8
 jz1SMZz6zqLwBXrBReOwpGo=
X-Google-Smtp-Source: ABdhPJwnrPmzKEGgsIBpUDZrJBddWhelV8OEvD0c3B5sPykEx4pFJr9tbKxbiHK8nWO5lRmxpDgHDw==
X-Received: by 2002:a17:906:940c:: with SMTP id
 q12mr15491682ejx.195.1601896550021; 
 Mon, 05 Oct 2020 04:15:50 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id y3sm1426201ejk.92.2020.10.05.04.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 04:15:48 -0700 (PDT)
Date: Mon, 5 Oct 2020 13:15:47 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
Message-ID: <20201005111547.GQ425362@ulmo>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <b1a195cf-0127-0531-f6d1-835367511f57@gmail.com>
 <0c66bab9-0132-d3fb-ea4e-de1278cf2b04@gmail.com>
 <20201005095351.GI425362@ulmo>
 <ae48aaaf-fe10-6de4-06bb-2afbde799168@gmail.com>
MIME-Version: 1.0
In-Reply-To: <ae48aaaf-fe10-6de4-06bb-2afbde799168@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============6498599739026602324=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6498599739026602324==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kZU6r8y0YpRwyDfh"
Content-Disposition: inline


--kZU6r8y0YpRwyDfh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2020 at 01:36:55PM +0300, Dmitry Osipenko wrote:
> 05.10.2020 12:53, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, Oct 02, 2020 at 05:50:08PM +0300, Dmitry Osipenko wrote:
> >> 02.10.2020 17:22, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>>  static int tegra_smmu_of_xlate(struct device *dev,
> >>>>  			       struct of_phandle_args *args)
> >>>>  {
> >>>> +	struct platform_device *iommu_pdev =3D of_find_device_by_node(args=
->np);
> >>>> +	struct tegra_mc *mc =3D platform_get_drvdata(iommu_pdev);
> >>>>  	u32 id =3D args->args[0];
> >>>> =20
> >>>> +	of_node_put(args->np);
> >>>> +
> >>>> +	if (!mc || !mc->smmu)
> >>>> +		return -EPROBE_DEFER;
> >>> platform_get_drvdata(NULL) will crash.
> >>>
> >>
> >> Actually, platform_get_drvdata(NULL) can't happen. I overlooked this.
> >=20
> > How so? It's technically possible for the iommus property to reference a
> > device tree node for which no platform device will ever be created, in
> > which case of_find_device_by_node() will return NULL. That's very
> > unlikely and perhaps worth just crashing on to make sure it gets fixed
> > immediately.
>=20
> The tegra_smmu_ops are registered from the SMMU driver itself and MC
> driver sets platform data before SMMU is initialized, hence device is
> guaranteed to exist and mc can't be NULL.

Yes, but that assumes that args->np points to the memory controller's
device tree node. It's obviously a mistake to do this, but I don't think
anyone will prevent you from doing this:

	iommus =3D <&{/chosen} 0>;

In that case, since no platform device is created for the /chosen node,
iommu_pdev will end up being NULL and platform_get_drvdata() will crash.

That said, I'm fine with not adding a check for that. If anyone really
does end up messing this up they deserve the crash.

I'm still a bit undecided about the mc->smmu check because I haven't
convinced myself yet that it can't happen.

Thierry

--kZU6r8y0YpRwyDfh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl97AGMACgkQ3SOs138+
s6EFMhAArB0+w3SsuWOHgLNkY+cFC6nn9FHzozivUKxgv7oSV8svQmcqrUMlfk1C
ZFlyT3HtM1POgbubhOVdybFepULnAvsKut9TD5J8EFvzHZJwYqjyVwwD0VqVry2c
a/zGLATS4nqtMIfgCHQ9hzlNMQa+/S59RO68oLpZdHwRSst+D1fwi6gY+dFn3HoJ
G2x94K10487l1O+wQjN5kQWu9gxzv4tuauLz1OHE+WvP75la9tDjcXMFwH/Jutsa
F7W1H97dD6+YGeNbEKtQ6WkI04D1WIh/9WaryJLDUzvuuw2JyEHEGLdyd9wtfABE
WWvctvwP9lDkLaRz1yOBQBHVWFE+dr6/mHmf3goKN0r4UilDRbpWFsOEEj4BF5Dd
MsiWEayh7MMRzmH66nmfR/ZeJYE05pE7hth/JSmfYVVMTiuOb2ZS2CFk9llO8png
9x6Hy+XrCDqfAoldTfGHiytYIcWEB1nMMRa1SqDqRtVgPxsDmtWXda5eAYqJVjRq
jwgdOPF07B1Y1q+Q9Xn/MQdSlbVK5S4nc3kz3ltmUB9ktVsUetBJs4Xqsr5jwhO5
7+BGIyn/e/y6k5SHQj6rMc87ByIBNrtGooZiPxVgYbKlI/ASye/ZQgY1kO93d+zK
XJ31HMNds7kT5gIaqmtZqUsAdkWHSeQKJqdLsGal3zY8Y62cahE=
=l8C/
-----END PGP SIGNATURE-----

--kZU6r8y0YpRwyDfh--

--===============6498599739026602324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6498599739026602324==--
