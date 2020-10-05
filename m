Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFB6C4363A
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 09:48:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D583820795
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 09:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFFP2Tx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D583820795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8C50787014;
	Mon,  5 Oct 2020 09:48:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AbmSiYAtdRQH; Mon,  5 Oct 2020 09:47:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EA8B886F84;
	Mon,  5 Oct 2020 09:47:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7287C07FF;
	Mon,  5 Oct 2020 09:47:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCF11C0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 09:47:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D98F4855CB
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 09:47:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BVGCFBk0aw9U for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 09:47:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1FF08851C2
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 09:47:57 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id k14so8585349edo.1
 for <iommu@lists.linux-foundation.org>; Mon, 05 Oct 2020 02:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8FVfgUbPigKX8q6acs/usUL41ngU1LBGrHZ+WyTTHpU=;
 b=jFFP2Tx+qnv8xeJv5u+m8BMlaEvC9R8HisLPC2n45BC78Gaj+EG538YmJx3bfIl9AG
 FQbQCH56fruWaCLp0aoQBXR8s32E9BaTtJ7rMPUEJ07Y7kt2qDHFz4AlTBuUFk8SD6vK
 gHPVFv041qFnDatTOgx8Q4luMBuDBdolJoIuJupQCt2EUmqc21uEpaWzMnMh3PLI/AnW
 KGgqD442EcPSJzE4gJ9NmTwsxMgh7CKyuuFTkaE1p7oPrTaUwzLDEhhGs9vTWci2ushb
 yQQz73y/GCHV6QzYV7/i1T5jg8a3SZHQ3aNC7L39z/PtC1f09iJn++mvtEeQjeC42WHP
 /2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8FVfgUbPigKX8q6acs/usUL41ngU1LBGrHZ+WyTTHpU=;
 b=QWdwK/ICaPmNiUDBpV/EGQAcDvM8/7JtzWZfKZkLBkXPjxNOIqhs90OUIgYqgPnJHQ
 1r/kotHLsZQB+Z3nvBIJNf3B0C4s18gu6kUXvgMFF6GAaHbypA4WuKnFJJXSLhUVdswu
 bM2ZGy6hZojii0ZihrmIeYr+3NXOH3J/wx9V1LRbR3dirlSs3vi1vEFhjDN1d6kWBA+H
 ZRvAFCfHzI+QYQreEFw4S2Ys8LVQ+RTeB4Cg+mEnMzU3TI2Msw121H+iH8RVmoiIRExU
 5VJLf27qcyCWr6AusDQxCqhRJLeLKKrqIZQnHlcnDulUyu+w1juO0TroWLyfjTgLlDTb
 u+mA==
X-Gm-Message-State: AOAM533W0j5HpfK691krh4PgLYL2qD3yMkl8xLKleHouAMNGY9el4qhz
 raGBQLeDf9LJ55hiYKimAaE=
X-Google-Smtp-Source: ABdhPJzj1lshRyTwroPH5unbnCt2C6kPU7UiCL8EBBHIsEdetc+VATQp5cQQopto3L7ArF3KqR3LXQ==
X-Received: by 2002:aa7:c54f:: with SMTP id s15mr3575372edr.107.1601891275435; 
 Mon, 05 Oct 2020 02:47:55 -0700 (PDT)
Received: from localhost ([217.111.27.204])
 by smtp.gmail.com with ESMTPSA id s1sm1950125edi.44.2020.10.05.02.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 02:47:53 -0700 (PDT)
Date: Mon, 5 Oct 2020 11:47:52 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v4 2/3] iommu/tegra-smmu: Rework tegra_smmu_probe_device()
Message-ID: <20201005094752.GG425362@ulmo>
References: <20201002060807.32138-1-nicoleotsuka@gmail.com>
 <20201002060807.32138-3-nicoleotsuka@gmail.com>
 <c42f1f51-9fa5-6503-91aa-3809f1f27d0c@gmail.com>
 <0f186339-1e49-4878-834e-11ae8bf140f2@gmail.com>
 <20201002195328.GE29706@Asurada-Nvidia>
MIME-Version: 1.0
In-Reply-To: <20201002195328.GE29706@Asurada-Nvidia>
User-Agent: Mutt/1.14.7 (2020-08-29)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
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
Content-Type: multipart/mixed; boundary="===============6620063708743702642=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============6620063708743702642==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y+xroYBkGM9OatJL"
Content-Disposition: inline


--Y+xroYBkGM9OatJL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2020 at 12:53:28PM -0700, Nicolin Chen wrote:
> On Fri, Oct 02, 2020 at 05:58:29PM +0300, Dmitry Osipenko wrote:
> > 02.10.2020 17:22, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > 02.10.2020 09:08, Nicolin Chen =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > >> -static void tegra_smmu_release_device(struct device *dev)
> > >> -{
> > >> -	dev_iommu_priv_set(dev, NULL);
> > >> -}
> > >> +static void tegra_smmu_release_device(struct device *dev) {}
> > >=20
> > > Please keep the braces as-is.
> > >=20
> >=20
> > I noticed that you borrowed this style from the sun50i-iommu driver, but
> > this is a bit unusual coding style for the c files. At least to me it's
> > unusual to see header-style function stub in a middle of c file. But
> > maybe it's just me.
>=20
> I don't see a rule in ./Documentation/process/coding-style.rst
> against this, and there're plenty of drivers doing so. If you
> feel uncomfortable with this style, you may add a rule to that
> doc so everyone will follow :)

I also prefer braces on separate lines. Even better would be to just
drop this entirely and make ->release_device() optional. At least the
following drivers could be cleaned up that way:

    * fsl-pamu
    * msm-iommu
    * sun50i-iommu
    * tegra-gart
    * tegra-smmu

And it looks like mtk-iommu and mtk-iommu-v1 do only iommu_fwspec_free()
in their ->release_device() implementations, but that's already done via
iommu_release_device().

Thierry

--Y+xroYBkGM9OatJL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9668UACgkQ3SOs138+
s6E2dg//V+pp9h+NZZeSpxS6ef49t6f3JNwWjeDDqOJXRqCkou8l/ocyhlvDyypT
rk9YAef+4foynhex5mIEEeQ7KOSgG0wCv1FuH5AlIN5uo/H4NO1pyB4c/P0pSEb+
aj6MfC5oV+ZTNpTTYWGsVv9naSRu6l47V99kv9B8pguq7aU9286Ef/oDTtqgp3bz
xJoEmgiUOtzxkQQZX+//+VFoWzcxbEsNe16zPKxYU+EWH6aqYCK6d5teTROfujjO
JfbsWm8/3/i3gRvhSNDc7bdM2NAx8f66RA15z3PAKiKSSoKAaKedJZOxINYCO2rx
s0u9wQqo36mTujtIIsoq8L3mjcysi+FsInikeX1+FDusQKGOAFQMUHS+odMpi8/4
uUXeGsWNdDBP4e61fLfG53dc2rvqHSvkycwqtXMTpSQc3ToXXoY8y/b6yyCEh+Rm
2mUSe/9KyKaGTm1mvMyL+zAvfYsMbFPD8W6q12e9lpPBzdOSuSufBtvgJZTw9UUi
tqO38VLE6TxhC2Z0x4Eoi/yVPmfgDl4F+XkeA2c4IN872hPrhjSDI4uCL32Rj37d
th/YMvGIIGQ3btUqonM3/ghgFXJGhvR31IudFTLoa4qIhhtqF8bSqD8ZUGJMW9zR
QUfY8opIepx9pdQ3ZDzDNnTNZjRXS1LdKqjM8cKZsctUB83ENyw=
=vOdp
-----END PGP SIGNATURE-----

--Y+xroYBkGM9OatJL--

--===============6620063708743702642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============6620063708743702642==--
