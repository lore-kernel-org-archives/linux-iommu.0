Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4EBC433EF
	for <iommu@archiver.kernel.org>; Wed, 16 Feb 2022 13:25:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2C6940302;
	Wed, 16 Feb 2022 13:25:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hUZFSMs9QcVV; Wed, 16 Feb 2022 13:25:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7CAE641586;
	Wed, 16 Feb 2022 13:25:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54D86C001A;
	Wed, 16 Feb 2022 13:25:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77C58C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 13:25:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6FED5409D5
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 13:25:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a6jEv7GUIwOW for <iommu@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 13:25:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 69125402D0
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 13:25:26 +0000 (UTC)
Received: by mail-lj1-x232.google.com with SMTP id b38so3257181ljr.12
 for <iommu@lists.linux-foundation.org>; Wed, 16 Feb 2022 05:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=lOkRfnAK67kKjK4/79VZhvtQ4sw0j39PjhZ9eFLB3so=;
 b=R1NtB7ax8LBmgh31v/0Bsp5y/iYNzYwAmukAeYwmpNINF+SAd/2h0+E6Yz1eoFemmc
 kXoOo0xmTdBD9EpYtddwXaBKsIEwuvZXigDanvghwQkEtO4meL/rKDpPPnVK42NiDYDI
 8QMoxVBgd3rBUTOBpPkx17oNYb1T49QyG9oZzGaRkvEVu6eJN7jV58SJeWWHL34ROpjz
 BtcXGKEFnqyLtJzvHfPdKw+2BGbjq4bUq/doapWFv1Jrq5SxA5StXLn6zD9bD45fHVnr
 232jO9gbsGFocxUZ7EvcyaUw+edG/OZEyv7DUm6dIgswLcQCrKPvB1yD//s1gKxvP/ck
 cKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lOkRfnAK67kKjK4/79VZhvtQ4sw0j39PjhZ9eFLB3so=;
 b=Q5XjZtygfGqmi6BCSU9UhaE7JnDVrNjvUf+ouTTbauIVwa2XTOSL8KJjrHjyyBad/4
 +iUlfQecptLWiVl5hTRHSm03Ulhj4VPGYGCdPBazRHwphwnaWCLsaslONzTABjNagAu8
 L8HHNmttRZr9PMYwCfuELtqwT1vwzDYFaJdwEO4QxTnr2F9HqSYbgFCHICca9xGo1lIV
 Titl0UMyoSxGB0+NL4F6A7OS2tj22V5dWHc0Fh88n4RuqY2qzHwFJgRgRDcuYmGl3BdX
 yW6qop4m88RbUgVid1+M8hBSgApyhiof4X0P+r4x7GOBwgTZq+fZRFCYmocoxB6p+bp0
 YDfw==
X-Gm-Message-State: AOAM532KpmH2N9iL8RkXSD+t53BZqsiEyNK5eLrwJWluq0ywZ+drzl4t
 t8gHfLplQd21pM0hZzrg7kk=
X-Google-Smtp-Source: ABdhPJzG+KWM7JX7Pbf0JWplz9UI+LWoWlcmpKTGSzwKMkz4wWdoLkxZY6G7vMEYaafdItFdy2/dXQ==
X-Received: by 2002:a05:651c:179d:b0:244:c216:5598 with SMTP id
 bn29-20020a05651c179d00b00244c2165598mr2156415ljb.484.1645017924083; 
 Wed, 16 Feb 2022 05:25:24 -0800 (PST)
Received: from orome ([193.209.96.43])
 by smtp.gmail.com with ESMTPSA id y39sm2987078lfa.27.2022.02.16.05.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Feb 2022 05:25:22 -0800 (PST)
Date: Wed, 16 Feb 2022 14:25:20 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: arm-smmu: Document
 nvidia,memory-controller property
Message-ID: <Ygz7QD4EJX3vZJtD@orome>
References: <20211209163600.609613-1-thierry.reding@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20211209163600.609613-1-thierry.reding@gmail.com>
User-Agent: Mutt/2.2 (7160e05a) (2022-02-12)
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 Jon Hunter <jonathanh@nvidia.com>
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
Content-Type: multipart/mixed; boundary="===============8779407373079047089=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============8779407373079047089==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QdP3IMTJOvZvvtKr"
Content-Disposition: inline


--QdP3IMTJOvZvvtKr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 09, 2021 at 05:35:57PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> On NVIDIA SoC's the ARM SMMU needs to interact with the memory
> controller in order to map memory clients to the corresponding stream
> IDs. Document how the nvidia,memory-controller property can be used to
> achieve this.
>=20
> Note that this is a backwards-incompatible change that is, however,
> necessary to ensure correctness. Without the new property, most of the
> devices would still work but it is not guaranteed that all will.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - clarify why the new nvidia,memory-controller property is required
>=20
>  .../devicetree/bindings/iommu/arm,smmu.yaml     | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Hi Joerg,

can you pick up patches 1-3 of this series? DT bindings have been
reviewed by Rob and Will acked the ARM SMMU change. I can take the
device tree changes (patch 4) through the Tegra tree.

Thanks,
Thierry

--QdP3IMTJOvZvvtKr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmIM+z0ACgkQ3SOs138+
s6F+NhAAn5xDNKRoblN/jQS2iO8okgeQy7nLasXqGnUTnZOVo3uJjJTjlJTT3kLH
WsOl1n6HoOfXuBigBlp6YAgCSaAnL22ALHz7rdseOKiZcVC5+sMzgv5y/yYS57r4
ay2xlSV0COLxnBwKkNapqijSL9iOxQP+UFxh75r2aAc+qA6qN8E35p8TfBj5NLUX
P4Y4rqdFic4ZULsngj9hlAmlI9uTHs4ltF+/TigKA6cOwTB2cw3jQd9jstib63gY
z07CvPs7GiaOlKl9gXXX6/0iOYtlE3C0GgO42YCgzMXM97F56nh+OOrZY4LOlIPS
g8KAE27wGk4jjkjUgKYjiBNqsIKkvLSqqFg1ZqRaFDkiv6Z6oA7vQ4L78kOrrS1B
g9O2lDNietS/scJXdteN8bqCRhEpqQYtiUEEMlEvRQV91QGb1iRoH78JlagzoKkR
WnzFBe84yw/CJQ9DO3QIfg/Zaqn2aJOzOlsfxwlieKWCyBSmMC9yDMl4Hpb7imC1
f9MbklJ4ORiVyltemtOuFMCvSjgXDmVsOArrAJk+w/6WV+JsvYfLWU5Bm0+TVdtl
I6eSy98XGI8ZQE8dzlGqiF1QZ2rytUE3zCwBz8zG/SiFKFfdWUaxUkB2jr46Izcb
6QSU5X4jaeKL2B69FROt6IoWoX+rPmvhRVrZqMmtfu9Aqc6JI3o=
=7wVH
-----END PGP SIGNATURE-----

--QdP3IMTJOvZvvtKr--

--===============8779407373079047089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============8779407373079047089==--
