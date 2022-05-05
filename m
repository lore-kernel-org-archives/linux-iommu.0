Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E91C433F5
	for <iommu@archiver.kernel.org>; Thu,  5 May 2022 14:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 990EB6110C;
	Thu,  5 May 2022 14:15:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PUaRbMvdNJGI; Thu,  5 May 2022 14:15:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8C57960D7B;
	Thu,  5 May 2022 14:15:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 643A5C0039;
	Thu,  5 May 2022 14:15:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC10CC002D
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 14:15:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB84484090
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 14:15:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id acn_EmEgrAoJ for <iommu@lists.linux-foundation.org>;
 Thu,  5 May 2022 14:15:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2CFF48408C
 for <iommu@lists.linux-foundation.org>; Thu,  5 May 2022 14:15:35 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id z2so7430870ejj.3
 for <iommu@lists.linux-foundation.org>; Thu, 05 May 2022 07:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=G0r63EWJGrRILahj/sz+EJV3EOcaqYNjGWpoFKqbQ90=;
 b=jgomm+QM9e2YtsSnghfam7Jo2Vy9nk+MzyosB8qkB7Q4XTv6CFUSq5Qchwh5bqndFo
 kcWYcsCLhG9W/XOKLjWtrhw0wvPv83ih8E4EX7PQ/kBVG+i8Zk8eRRV6DBEcvGV2GU7a
 GjasK1Z7nDvuyQeZFErKNACv+iSX/xV5rgl6RllK0WI9RYt4D8/xl2BXYpDjrhbpgLHh
 tnmCzixQEvlJbxc9xeqYJV8kNDh2OAN2RsOYxPxIVIAiDsuTaXsoIPI9MNUZwaM21fyS
 xWVcTdt7I1s+Z/RVl61LdFZDpgic3tDrbd1GCdPItXLD7p4kpy+lPW4z3ZQ3xv0iAvXu
 TDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=G0r63EWJGrRILahj/sz+EJV3EOcaqYNjGWpoFKqbQ90=;
 b=ZaHeJswbx55UBDaVCK+VkEsR3NFvQ9mBXcKESNdi3VAftV3fT84L9FeIdmuIEc5KR/
 rq4mxtSLFnjLdeKfEXOnKwD/p2uRlpqVozTA200Fd4Dfpjjt2VtsjPq/ZCbhd9/Y78o1
 sGljlVh2gNhE6hQ7HtEDFn1tW03gz5lWKO8ZTj1PrlRIH6Ag6Vdi8AVr918KdrgrF0uC
 VeifZmO96Ku7egEDTHk7eb15vkEUtn7N69y0vTaoucOlPGLNPI7D4clh/fG7NTxr3VkV
 urm7HmpvbsMuAnT2OhQm8m3Uxji4zqG1013sfUxmYh5q+qLAom8KNEgKPWeD6VDWv2Xu
 IbEQ==
X-Gm-Message-State: AOAM530uncFPXAPUi2WEkoPwPRShgAZdHtlDOVmGJmUExfW6cPjJOlmM
 rL1N72p2vmJhzfjUmyXKftQ=
X-Google-Smtp-Source: ABdhPJxeMIlUXQL1s7qEc469SokpB+SnGYy3DObLLLvhCHkHuF4PeB6ZEUpydG7tZafDSLBy0Nqfyw==
X-Received: by 2002:a17:906:5d11:b0:6f4:a04:6b44 with SMTP id
 g17-20020a1709065d1100b006f40a046b44mr26261272ejt.167.1651760133375; 
 Thu, 05 May 2022 07:15:33 -0700 (PDT)
Received: from orome ([62.96.65.119]) by smtp.gmail.com with ESMTPSA id
 p4-20020a50cd84000000b0042617ba6398sm911046edi.34.2022.05.05.07.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 May 2022 07:15:31 -0700 (PDT)
Date: Thu, 5 May 2022 16:15:29 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v3 0/3] iommu/arm-smmu: Support Tegra234 SMMU
Message-ID: <YnPcAaQTMRsNEQYJ@orome>
References: <20220429082243.496000-1-thierry.reding@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20220429082243.496000-1-thierry.reding@gmail.com>
User-Agent: Mutt/2.2.1 (c8109e14) (2022-02-19)
Cc: linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
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
Content-Type: multipart/mixed; boundary="===============0316273136307922772=="
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>


--===============0316273136307922772==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YYtfX2oWqzAJVJlB"
Content-Disposition: inline


--YYtfX2oWqzAJVJlB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 29, 2022 at 10:22:40AM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> Hi Joerg,
>=20
> this is essentially a resend of v2 with a Acked-by:s from Robin and Will
> added. These have been on the list for quite a while now, but apparently
> there was a misunderstanding, so neither you nor Will picked this up.
>=20
> Since Will acked these, I think it's probably best for you to pick these
> up directly. If not, let me know and I'll work with Will to merge via
> the ARM SMMU tree.
>=20
> Thanks,
> Thierry
>=20
> Thierry Reding (3):
>   dt-bindings: arm-smmu: Document nvidia,memory-controller property
>   dt-bindings: arm-smmu: Add compatible for Tegra234 SOC
>   iommu/arm-smmu: Support Tegra234 SMMU
>=20
>  .../devicetree/bindings/iommu/arm,smmu.yaml   | 23 +++++++++++++++++--
>  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c    |  3 ++-
>  2 files changed, 23 insertions(+), 3 deletions(-)

Joerg,

anything left to do on this from your perspective, or can this go into
v5.19?

Thanks,
Thierry

--YYtfX2oWqzAJVJlB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmJz2/4ACgkQ3SOs138+
s6HP/g//eeY9Yqwe2/A5JdXXX9QKOjJ6MRJ1VKXus3HLEWVYfWJWEbOb1SFLtfof
9gJam7J1Wf8zPGHCJs4J+v4X2vasY4JQcfGaJRkmXocoVbzScYX9T8YwNzH5vaWQ
DGQRmTOdRyZys/fVmr/8CYHPMS00uSxQrcp83drjSdh7Lpb7Cl3wfUQ9KXwsSW70
FIXZ0OCNi/NotlkKnkHKV71kX8B5GYTWv5RvJYVUPK8NielahkV4ZxjpZaYVHUQU
mDfTTlzJ1yLfUSPOibffiKdO2pIsPGwYvpzsQ8nq10I2H9W/34NpYhBzRNy/GLfW
tgDbqhUO9x3Ap96fD5AyZvQjJloVM+xPiQWh7qb5n1kgkBcnF3YGK5MM97FrhuDo
2NbTUnZM9y1e66Y/+VDrnhYzTvma4NDtsi5hWjzwmnaUP6Vr8vnYUYyQg3UvEbXi
Go+BJIUl4wfobVqNYHnV+7I0ngXVW/upnrmcoC4gaMwxtV4WdAiiYR0YfJXVwWTw
VTRFSmErt/hZ+QW6WZzyDoe5kv45sMHQHx2SlcmOzrx387pBZasqGL8YLzmFF4ZZ
auvNOH1FekCoR+MfP/U30eBWb0sgXrBVA6CWC2jOtS5VuCPm8TP3B7kn4Kidvaj6
Va8Hwp2T0Fh45nG4+eeibkwCnoSc/8XeW7+hQ5rz6v2koorR56k=
=DXYz
-----END PGP SIGNATURE-----

--YYtfX2oWqzAJVJlB--

--===============0316273136307922772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
--===============0316273136307922772==--
